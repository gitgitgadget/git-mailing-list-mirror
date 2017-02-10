Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 567191FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 19:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932265AbdBJTtE (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 14:49:04 -0500
Received: from mout.web.de ([212.227.15.4]:58929 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932230AbdBJTtD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 14:49:03 -0500
Received: from [192.168.178.36] ([79.197.218.233]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MRUC0-1d0aKG0vAO-00SdgS; Fri, 10
 Feb 2017 20:42:24 +0100
Subject: Re: [PATCH] dir: avoid allocation in fill_directory()
To:     Duy Nguyen <pclouds@gmail.com>
References: <73ec9cc7-8a86-8ba9-90fd-a954fa031820@web.de>
 <CACsJy8CE-cyTZHZZhvhdsNau7iSqBci1BdUqDYvxoE5odV2SBA@mail.gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <213ef44b-9161-1e64-772c-76d93619b6f6@web.de>
Date:   Fri, 10 Feb 2017 20:42:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8CE-cyTZHZZhvhdsNau7iSqBci1BdUqDYvxoE5odV2SBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:l6jtHpQJgIwq+FEvp2pM5C8a85TvnB/qKIZNszCLUNr4LMzeaSB
 i0lHbT/eErOaE+IFZKQYJ73M825HIK1N+k1EDSYOT635UAUwDhwZfPBYY0CYjoqP+ljhuvS
 yNyZpeP75KyLClVO8t5fi8CQNluDGyCKF1h3hCLAcWWEiecjyW3fJ7zo4uAMLWn7MRquk7Q
 g3lrNgU+pFLn9VLQK3mVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:A19ghD+FjPs=:SxKCgp8wILTjEp8v/9xs6N
 KLdxfRmE24/5LVD8pqFJuMCZ3x/oCV2qKzV+Z3DvmbCNEXh1A1iBCFYc3GtRsqIQa1s84zgiB
 9/JgstqEEL0C2CKF7NJgq1m8AlJ4W05+vyLWGtzf4N9YAItwzmh0/K40T9cfaf4hl4PHpNsD0
 BPtMizEE64EtZ7nU45O2NLYWOqn1NB6JlGwtx35G1cwttj1nktkMc/nJnp3Iyq9h9cS5wnsiK
 nosu7e+VqjCymtg4U4kfQD0fR/E5O2Pu3H0MLZkY3rnFXPZkBK5loU2SEszvikohAUFJF/q7M
 iRpRr+/1Nl5UjBNcvsTQTw/GKLTRfYzOSmIi82VTLhuJ/xXDie0E9Ir/nk+nQTmQZ9AyDFTGs
 6DJ0Nyuw18piZOzZtGhGQ6zyz1eFsRUnBe4xnP06UHxkRyWHzecXjaAKLWv6sjgFtl81M06JH
 /CZVFd3e8g5CC8v7AyHLOkuaSse3xYJdxvgOqj42k7s8RUXt2wZqVDuxLZY9NIgEtcdSeKO78
 VwmRthMyIkwiftoa2zvGb7gqoEJ8P6e+YmGy71jj2tsZ3zTVAyUj6Qudki/wKqo+YR30U2KqT
 CDwn0NOxvSh3OYbAj6moAunCb8A14YTGCCHAOSeW9D0nnLVaoEU76QUmWy+hnNnTHqQQaHI/p
 78bi52+jWhyavS5q499IPdBjmOLhburBZDEB/Jcp1U2pFB4IztI7gnXUmVpwb0+FbM7M75Pyp
 XbE3d80538ctEdu9NIUMt8MddXwzWH2F+HkCvCfylJ+ygRpWuFyk0H1sVJLHBW8wiQcqljJPf
 AyFHMKx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.02.2017 um 07:22 schrieb Duy Nguyen:
> On Wed, Feb 8, 2017 at 5:04 AM, René Scharfe <l.s.r@web.de> wrote:
>> Pass the match member of the first pathspec item directly to
>> read_directory() instead of using common_prefix() to duplicate it first,
>> thus avoiding memory duplication, strlen(3) and free(3).
>
> How about killing common_prefix()? There are two other callers in
> ls-files.c and commit.c and it looks safe to do (but I didn't look
> very hard).

I would like that, but it doesn't look like it's worth it.  I have a 
patch series for making overlay_tree_on_cache() take pointer+length, but 
it's surprisingly long and bloats the code.  Duplicating a small piece 
of memory once per command doesn't look so bad in comparison.

(The payoff for avoiding an allocation is higher for library functions 
like fill_directory().)

But while working on that I found two opportunities for improvement in 
prune_cache().  I'll send patches shortly.

> There's a subtle difference. Before the patch, prefix[prefix_len] is
> NUL. After the patch, it's not always true. If some code (incorrectly)
> depends on that, this patch exposes it. I had a look inside
> read_directory() though and it looks like no such code exists. So, all
> good.

Thanks for checking.

NB: The code before 966de302 (dir: convert fill_directory to use the 
pathspec struct interface, committed 2017-01-04) made the same 
assumption, i.e. that NUL is not needed.

René
