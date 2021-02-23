Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C971C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 08:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C8664E05
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 08:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhBWI1N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 03:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbhBWI1I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 03:27:08 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA215C061574
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 00:26:27 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id s3so4931409qvn.7
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 00:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q4su/Q/wmcTYVZmnK9WcUfig01KDT+F+Jdy1kWY2E9A=;
        b=GizLu1iGEacBCqR4JojURV304zO71lgmHxM9TIKnGjf6KmQJAEhswOnnQU9HOVuQf+
         3kF+JSwEG2709z8aNWtVgOe4c2vC1nBLHER+UG5wU0fQuReiiQ0aD1swxaybY1Pg/Nsj
         9CroJH3c+V/o7thzpRbOoy0KaAoMAIHAAvzWlcUZvj4vKYqhBCsBr2/B1Owvi3UCG4D5
         F34nD0ZTP74TCbzequU/aJQrFfqKVB1UXV16TVVILh/1LVfSsWIH+U3gCusb4gaA76ZC
         d3m0hAe4GY/zzhGR9eJXAv4JVLTp/x899SyNUOda1VgAKUNAkXsi6uDhL0vWWy9sgN1U
         QgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q4su/Q/wmcTYVZmnK9WcUfig01KDT+F+Jdy1kWY2E9A=;
        b=eIWW/ypJ674QVCfa6p+ZPRTPe28hbSQfHUEQD/u/SVajnV8MxVOKaMucBb1+NillGz
         nDoyPBMehwrqDyNemldnWEfe1+db8FRiPg8cy57dkc+6nn0/tjRI1Q2j/eZYX5hWO+1Y
         nwzfuxjeoomc6wcRtRV1qjdx+S3/RAAKqf0iy/TnYAraP9yHLiiaC/TgesDHXOIudMVf
         bQZf2RAIATbge3iWq1Fnk3FB5+kxrkZ1VWc/9l29kAefKRMkeDy2s32+T4T1xQP4NNIA
         9u4DqsnKxQ3GgM8FALuCCHOePjgcshpPjVpvezutyBUNHwfOfxq1g5K7qregALMbvZgV
         xv7w==
X-Gm-Message-State: AOAM533hDaFeaGrnNiKzztAKuOoHn2U4al1YXnEUSR9+nDh8YtL+Vxnz
        MrznAcfLQDEdApyMtiJIblTIt9DlhtOEiazmJHs=
X-Google-Smtp-Source: ABdhPJxDqKPSgQTINGsS8SVN6uQ0kyKm+oy8Jyn18Ez1qtmx1Kmo3zg1GGhzh3dxnBmOodyE7CUzuj62+0HD19Ul10o=
X-Received: by 2002:a0c:a404:: with SMTP id w4mr14637824qvw.22.1614068786886;
 Tue, 23 Feb 2021 00:26:26 -0800 (PST)
MIME-Version: 1.0
References: <20210211194704.28913-1-shubhunic@gmail.com> <xmqqk0rewa82.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqk0rewa82.fsf@gitster.c.googlers.com>
From:   Shubham Verma <shubhunic@gmail.com>
Date:   Tue, 23 Feb 2021 13:56:15 +0530
Message-ID: <CAD=kLptZS28NH53qEQ48eD7yT-GZ4Xx4Uc4oGAJD-g_UwQFRUg@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Modernizing the t7001 test script
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Junio,

I already corrected the author-name spelling in this v3 series
but I looking at the last "What's Cooking" message and saw that
Modernizing the t7001 test script series described as
"Expecting the final version with corrected author attribution".
Please once look at my patch series.

Thank You!


On Fri, Feb 12, 2021 at 3:14 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Shubham Verma <shubhunic@gmail.com> writes:
>
> > In this patch series modernize the t7001 test script by changing the
> > style of its tests from an old one to the modern one and by cleaning
> > up the test script.
> >
> > Changes since v2:
> >
> > - Correct the author name spelling
> >
> > Thanks everyone for your feedback and suggestions.
>
> I've compared between v2 and v3 and verified the only change is the
> name spelling, so I'll port over Eric's reviewed-by's from the
> previous round.
>
> Thanks.
>
>
>
