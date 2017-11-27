Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 078BA20C11
	for <e@80x24.org>; Mon, 27 Nov 2017 23:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752858AbdK0X3d (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 18:29:33 -0500
Received: from mout.gmx.net ([212.227.17.22]:53244 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752423AbdK0X3d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 18:29:33 -0500
Received: from localhost ([82.251.162.233]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0Mb8HX-1eZkEl1J4F-00KdWg; Tue, 28
 Nov 2017 00:29:28 +0100
Date:   Tue, 28 Nov 2017 00:29:27 +0100
From:   mwnx <mwnx@gmx.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pretty: fix buffer over-read with %> and %<
Message-ID: <20171127232927.x5iamt5rlxrafkhe@debian>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20171126025222.7831-1-mwnx@gmx.com>
 <xmqqh8tgfq8g.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh8tgfq8g.fsf@gitster.mtv.corp.google.com>
Name:   "mwnx"
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K0:npOhf/Qjb3oAH83Ds153Lu2fUrwxP3J4mtvOfIRLh+rvlWjt9Dj
 vl0GTqIZps2b2C4YVSetgh10V+xJxFgFGikzxUjuWGXKz2tmQI6zuOEFMMV6m3PbH4P8HYi
 g0xYk6aU6i6GE738DKVBfB4TnIyG1GLyZ4ZfRaR/ZrmdKkD0IknKLwdVbHeRPu+tMQYVtgb
 6oBG0hbqTs4mTZJIk5Izw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:A1Opod6MVi0=:d7mEl1SrM0dJbj3ehLqtXS
 40Iu47lUYkvYEaG4h7NQ1l3iMwMgd8xml4Gmuf3EpnY4wT0m03aaOqyufM5eo6pC8lO3a/1ZQ
 2bw0THPtxdHegAnXkbrN+z8iFsEzRFRFHHcUR7aRu2Rr6LQu46uCAynHxhk5t4+hldhxee282
 sCjHvELRko0NlVuvg2ntdsSPYnnpfSJqEnJoyiak0aw+jdSzfa6OG0lPm5n7ExBCpS3U6nWAS
 EjiJ/UFuHFNuGJ+Fs3yJv7SYCg2u5A+cN1A58Np5yZ6J1kb+RjWY+K91d9AWEWtUThc/7Rrm6
 rRFhIZknrEZ3OT/ok5fR3BeNkcNjwgKE/1vjeyp/3rFI1dMNntvOc64k07D6xw6hMI3kC8W08
 x2kTt6NKYoi9W65P9DIZm0L1fEgYhsUvmYGMZwipxOkeZIER/5B3i7BI3SJT0OzksWzNcQZrm
 iFpFt9xv4KZktFL1oss24GLV7zQiSTL8QFivalFgBVDTxGPPCt9UN4kUhThrSGax0lJ3MyzgH
 hVObfSviiACNlJZofpicelQH01EKonBoJxsGXjoATZaj6MdpiuUgzEgFr9BcfmgMN6Tt0s8/l
 wkgrJXOzxHWgm9TAhAWi/e+QABANW5K4GFq/9HMth9HhD24p1NZR/DGQ15wjCwp+BWE7VDT3C
 3CWLQqKEY6nHUIK7K9HGkWphKJLqDe0ePmg/up7iRo0XI0y14XHPbRASTtSRHPa9kzLKBIcIJ
 DLBCgBO7wD6tbD1bA8sJ5c6X2ST4sfJV0KFAquV5hLKHFLHY4CTYXdJExXI9YQi52F427PfrB
 EXhFKn4w2dbxrvUyYRhwEmTx7EqIg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 27, 2017 at 10:46:23AM +0900, Junio C Hamano wrote:
> By the way, Documentation/SubmittingPatches has this in "(5) Certify
> your work" section:
> 
>     Also notice that a real name is used in the Signed-off-by: line. Please
>     don't hide your real name.

I did read that document, but I saw a few commits which were signed
off with an alias so I figured the rule might be flexible
(especially since I'm not quite sure what the rationale behind it
is). I'd rather not give my full name if I can avoid it, however if
I really can't convince you to accept this patch any other way, I
guess I'll comply. What are your thoughts on this issue?

-- 
mwnx
GPG: AEC9 554B 07BD F60D 75A3  AF6A 44E8 E4D4 0312 C726
