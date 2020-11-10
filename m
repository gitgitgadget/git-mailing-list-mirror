Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280B3C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 11:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6E1120659
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 11:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="puSXENju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgKJLhb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 06:37:31 -0500
Received: from mout.web.de ([212.227.17.11]:40149 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726737AbgKJLha (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 06:37:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1605008245;
        bh=r3HXQjQM2zNuejJLSZWF4ZzSOfOlGBCfoqzrIvpz8q8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=puSXENjuPH44W+XO5mgTw87XoD8GWvD7Cgai4hWjoYPZ4THXuHwCQPv8O6w8B6QQU
         ZPuZXP3OyRWOEdG08n9OQdTsEtwJiLYlyjVpJ+LEbDPy0FAjA7JC6KGn6G1uEiMN9E
         YaEUun/ESJHQUPH7bDm3abWVmIEcYQnX/ci1yhqI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ls95v-1kAhhK3BBn-013uhU; Tue, 10
 Nov 2020 12:37:25 +0100
Subject: Re: [PATCH] archive: support compression levels beyond 9
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <96e6e2ce-fc7b-1e73-0112-93589b28506d@web.de>
 <xmqq7dqucr9t.fsf@gitster.c.googlers.com>
 <9c35f3e7-e0ac-b68a-2807-ef1ef9ade54f@web.de>
Message-ID: <1104ab8a-2353-c074-3d81-b31ff75287bb@web.de>
Date:   Tue, 10 Nov 2020 12:37:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <9c35f3e7-e0ac-b68a-2807-ef1ef9ade54f@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j/+B98WEAHUl0+9vEpW8k4FvFAZzU8ID5Qu8skUtRlcPa6V/5bq
 V+rf78IHKymOazKmInKqQ/ktKRqiUaerHcp2CRC07BP/iJGM1Emus3ZM7LSH3606hUKC6B9
 z7TmfsEYEQ/LFB37k3nwIk2bOsW0gWWKrlIuDeD2q5e4bvez0MPpZmWqIiHTS5SBgnfCW+B
 Nv/uPBU/44beaevJ88IXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H0mDIf8OkNI=:Tfk983frgBGq4TZz+DqWd1
 l87KpEr/DI/EFgjdYVrRGkDeVaH43NIG6ynfkm6qft9PyNKE/llm4vprSAVhFxAj68jwZ6z9D
 Rn9U1m5+VluzjSaRRdTqFMl+r50i58iA5UyP2BScbAcSR2hsHMmTlG/mT0yspvLX03eTsud3l
 QoMSieWlVRlP7ZHis6M3SI1enqZYork21mmhTnNXSznhhlS3JXmq+NquxpErl7v3Hbvg3KLIg
 qiUD2ANgtF1C4y/erE1Yhbh/mqSEKFibxIUZiW6T5ji3W2WqtccZ9vROq0CA1GcHUQprnElyK
 qNMazLIoWKDCBQdNM/rWcg4emvJKa42fb1/aDysYVISJKkoc4+XZ845exUw3rllseOCujYWy0
 njbCJkgjrhISLdBLXJuT7pmOFP896m1n68/34bYvTQdyBhi/evotd7JyNw5E4VCtBs/f5z4Bg
 FwkuQ2XNbaG8fWbLbikCinUvnG10NK2l2mYcDuWBaRHjWSvWCAVrqijQzYOewGimgRyKFalY/
 jeQMgNYCwyFRNhvcK5EmQi7z+3hjTBaKl/y1Q34ECdFw1CYIDFcVfOQ0a6VAUO3DnGENBwVFu
 Lxbep5tPrrohyYNLLzEQ+rDk4rzywIrbL0B2e5MGJlCRdLD1Drb+H3ND7sZoVArnEBtEszuJy
 WTkoxAHPYZNa5js1tEfTnIXvoL3Vw630yeaGmJExoeYdZjdZ3E/qbtkwY3upD4nz6v7w39pxt
 eyUv9tOVkSjX0p/M+UbLZKULg6gOUw1ND9HN6WFizrSkJzjoOdxenERRs97nz7g2NC/gh9mAc
 LTtsF8VBFVWXSqdPdI03lp5a+IcQH+LJk4vZd4SyYiLjNizAkWXbyKW5+Nz5WJ7ryzVvel4an
 mrfw1qLL5BnzI5N0ZU2w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.11.20 um 00:48 schrieb Ren=C3=A9 Scharfe:
> Hmm, adding an option for passing arbitrary options to the filter and
> removing the feature flag ARCHIVER_WANT_COMPRESSION_LEVELS from
> archive-tar.c would be cleaner overall.  The latter would be a
> regression, though.

And the former can allow remote code execution with --remote if we're
not careful, since filters are called via the shell.

Ren=C3=A9
