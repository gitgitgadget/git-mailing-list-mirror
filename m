Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE69C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 18:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 350236101C
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 18:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhG1SSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 14:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhG1SST (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 14:18:19 -0400
Received: from mail.aixigo.de (mail.aixigo.de [IPv6:2001:67c:13b0:ffff::60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84F17C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 11:18:16 -0700 (PDT)
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
        by mail.aixigo.de (OpenSMTPD) with ESMTPS id 19e18fa0 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 28 Jul 2021 20:18:12 +0200 (CEST)
Received: from vmdpcl078.ac.aixigo.de (vmdpcl078.ac.aixigo.de [172.19.97.224])
        by mailhost.ac.aixigo.de (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTPS id 16SIICEF149139
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Wed, 28 Jul 2021 20:18:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aixigo.com;
        s=default; t=1627496292;
        bh=2fWZUvWGfoqt9SxlkIj+WMAgUuZo90ZC2MR2ZTzFpVE=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=j2P7wuPxZOJ3usabIciTpEFGEGX+zOdArIZVqR8kcOZkrnD/RUChwr6xcxWgkdREq
         NvMDVtiPF2lH+OqvBYlszZyU94AJxPGNrEf7apCMq32+fVT7lHhGTkk+zZkf58H5F6
         pRwbeBuq3VVPJA23uL0fOqGrO1E2sx16fWFutO1g=
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>
References: <20210721134650.1866387-1-felipe.contreras@gmail.com>
 <CAHk-=whf-9kNV3y5G-VVA2K5EZCnvv94paAEj6p=i2R4RM2emQ@mail.gmail.com>
 <xmqqeebregns.fsf@gitster.g>
 <CAMMLpeTL92cDmMHsE3iuhHQrVjwLFWHxE0CwD+uDBoPGAQCrkg@mail.gmail.com>
 <xmqqwnpcdu1w.fsf@gitster.g>
 <CAMMLpeQ-Qpct4TX__KVuCyjbgxtB49qTMRHYc9R9-o0cRu4MuA@mail.gmail.com>
 <610038c0e1056_8fd52084a@natae.notmuch>
 <9e8f1c87-cd08-e1a2-fd5d-713cb0590049@aixigo.com>
 <xmqqv94u9x2l.fsf@gitster.g>
From:   Matthias Baumgarten <matthias.baumgarten@aixigo.com>
Subject: Re: [PATCH v2] pull: introduce --merge option
Message-ID: <e5952eea-61f2-1beb-64a2-1a077c57f0e6@aixigo.com>
Date:   Wed, 28 Jul 2021 20:18:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqv94u9x2l.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/28/21 7:18 PM, Junio C Hamano wrote:
> I am afraid that you are misinterpreting what I said, comparing
> apples and oranges, and drawing a wrong conclusion >
> When I said "-m" would not fly well as a short-hand for "--merge" in
> the context of "pull", I didn't mean "nobody would think 'm' stands
> for 'merge'", and I didn't mean "more people would think 'm' stands
> for 'message' more than 'merge'".  The reason why I find it
> problematic is because it can be ambiguous >
> When we step back and think about your "switch -m" and its synonym
> "checkout -m", we realize that these commands fundamentally never
> take "--message", as there is no place to record such a message
> (they do not create a commit after all), after they switch to a
> different branch while carrying the local modification forward by
> performing a (possibly conflicting) content-level merge.  That is
> why we can give their "merge" operation a short-and-sweet "m"
> without confusing our users.  So contrasting "switch" having "-m"
> that means "merge" with "pull" that can conceivably take both
> "merge" and "message" is not a comparison you can draw useful
> conclusion from.
I must confess that this comparison is indeed not a valid one. Maybe -m 
isn't as great as I thought it was.

-- 
aixigo AG
Karl-Friedrich-Str. 68, 52072 Aachen, Germany
phone: +49 (0)241 559709-390, fax: +49 (0)241 559709-99
email: matthias.baumgarten@aixigo.com
web: https://www.aixigo.com
District Court Aachen – HRB 8057
Board: Christian Friedrich, Tobias Haustein
Chairman of the Supervisory Board: Dr. Roland Schlager
