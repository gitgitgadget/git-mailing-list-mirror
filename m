Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86891C433DF
	for <git@archiver.kernel.org>; Tue, 26 May 2020 11:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 569B520663
	for <git@archiver.kernel.org>; Tue, 26 May 2020 11:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="I4CyZsai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389019AbgEZL5e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 07:57:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:59075 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389011AbgEZL5e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 07:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590494249;
        bh=GVCs6LGGdGStU06p8uVZkzpDd3a3xxqcI8rcBiyhIQk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=I4CyZsaiOfhVpyATjc9UL6DS//1FH+JS7S5mAiH4bjQWgm3E7cgtDhTtj/IcQu4GF
         QIgGsslzxdjwJEoiWE23Z6WVDz/FpejNuuQ1Ss2ZYrWnvSYqQx+MvbW9RdpiBCsltG
         P2tNvx6J/Vv14kNzMewwcovb6ehsAmSsLaWByYQo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([89.1.215.88]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvY8-1jZGtl291U-00Uost; Tue, 26
 May 2020 13:57:29 +0200
Date:   Mon, 25 May 2020 23:40:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 11/11] ci: modification of main.yml to use cmake for
 vs-build job
In-Reply-To: <CAKiG+9UXa_1tfJ49gXGQCKTK5hqmVSAV2SqEc4iZCT54i18h6Q@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005252338090.56@tvgsbejvaqbjf.bet>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com> <pull.614.v2.git.1589302254.gitgitgadget@gmail.com> <fa1b8032906c6042a0e5851f803ec0427922a1a5.1589302255.git.gitgitgadget@gmail.com> <xmqq3684c096.fsf@gitster.c.googlers.com>
 <CAKiG+9VXk1vdMM1amQK6pnHcn9H_93-3fkqgK4nwKf=GtrDGyg@mail.gmail.com> <CAKiG+9Uz4YG=Hq9PRN8EhFF_agXNUPRnYjetY=ZNVRE6_VDAew@mail.gmail.com> <xmqqzh9vok90.fsf@gitster.c.googlers.com> <CAKiG+9UXa_1tfJ49gXGQCKTK5hqmVSAV2SqEc4iZCT54i18h6Q@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Hb/hHCzateuZRJDWrE2b5f50QwiSpTWogeOoNsKQ0g2bH1H/XBE
 JkB39hYYhFQPvC7vajof1Ztbt0Ff1MtjWYYQHqjuWgoMObFvH4zWmK+7hLN3KmHLlLSv/W9
 GgMVBDgyv1FeNaKr1rMPtGh0cxdHF3rYIlBSrY+V+spoW/K61d1v+FewOtlG1zkGeRoYEQk
 9wvm4WjGVTq+y10xDfDmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X4qfkYndCmE=:J5n6oC8ansoLpjSWrwYYn7
 VB04++Xhh1MSm4iuQZT4ytZgG506+kOyoz+j43OE32px2MCpkpI1chwJioGgYDLVRHa7e54q4
 +L4ZOxtge+vsI2GjaPNjxiQ0xssIPpqvX0MU7BteGmntkKat8x8muZa6BK8rZFjPD48erjJwM
 bU4fklu56t9SUd1ShpDn07CH2goFzPYYQxHfQ8dlIvWrU8/GRnSdxhzMLLlipdc2fJIlY/yUU
 /2hxU0iG1A44+uh7ws+eYC47RfyE57uCl5VUQLGGzChwoWG9VvsClMOhV+C1PSptXXD9XZ9jW
 pFABUcU2F6I2/j9MVaosAchia6ftfKav8YOT/zdkckdby/nX2u8Z+acUeK1n+wiJrKozpK2Ak
 ppoc4x5BqPsrJtqOzEabA+FNs96hTIAa0dvP4JsccWI2dKSBEOKCrlazkwzo9taZdzu+4euDC
 P7GuHOjJy0Ng/McnC5TZuzcHnrnXxPfmdB+o/73hof/fA4Sy9tDXCQOrHv57dHzrZ37K/Ztci
 yDPjjQkAbQId0qDdp5iOm1asjk0rR6Lx2R4/5kd+1NqgfyRUsPD/dNIh6SzJbiWGCdsx92M09
 +l5oozscXYWntBE0T+M79CVJMmekyarNDHy5Dna4lUiaNNrn/XATq8bKNPhqRE7aqJw5WoJ5m
 mhRGfC7StirgBNkMULKctofS5tewzNSVZkYLj3fhUhIV+J93oAOa/Zf//qA3LjIrc34kOmlwc
 jALLXRmNeYBfk8jRi2AFsrwaFPAdvgmUTTi683UKjvq6VUVAQUJMlqJ3cgO6/v6iMD5NG1D1U
 oTKmTgDimssjsEum5jUI3jYHwJpuXYGYI89TEQidhvK/khfqUdRI/+PlEO9bWWUPgouuk2na2
 FwFXibPhBWII5lh27hpKxnahpl8nMa6/nJpRYG9gaU3vpiLeXXnZzDj388GacVNMOyDll8pKT
 cXigUqoPz0BnGG52s+C41MckixfEi5Bvgt2XXN9MrTekLhL+TZxaAcHDHv8hIxWmfJ8c4o1lf
 XdFcWIryQ1uG44F27awsle93hrrtSLd9InbMVVyfibC72TOdYuPXRlAac7Kx0kwJA5uIy+f76
 eYFVK1SCfD5DRh5H9EyDPo81d3e5xAEqPT/vHmIuV8z5tyG4fTeChMw6VZTJrdqwZvbgsnnnk
 fOpR84mv2B+H7m4BVpYu9L4LL44Y4XphcgxMP6tkKvqCMEt5hd/Sguo8mqhlDDZLY2PHfjpmu
 Hj3Um1ean7zTW+krD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sibi,

On Tue, 26 May 2020, Sibi Siddharthan wrote:

> The difference in build between Linux platforms and Windows would be
> 8-15 lines of code atmost . I see no point in the extra Linux stuff to
> be a burden for the reviewers.

I agree that this does not constitute a big burden.

Linux support in the CMake system _might_ come in real handy in certain
circumstances. For example, if I understand correctly cppcheck uses the
CMake configuration to figure out which source files to analyze, and with
which #define's.

So there might be some previously-underappreciated benefit to having a
CMake configuration that works on Linux, even if it is not the recommended
way to build Git on Linux.

Thank you for your incredible work on the CMake front,
Dscho
