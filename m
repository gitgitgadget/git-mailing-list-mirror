Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1658BC07E9B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 00:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECBF161029
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 00:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhGUAEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 20:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGUAEc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 20:04:32 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B51C061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 17:45:10 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z11so584467iow.0
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 17:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=atgPFfpkeHR9DN07IdhWhh4yivZEi/lRW8Y4cc5fBMM=;
        b=cvUuHCkDhHmLsfu9QAVP289+M3/xlSA6u0QkiAonMjcUzew+XZe3OZjqi0FFl4BL6l
         Ebuekm4QZgCykE2JuUmG1xHNKxpZz3/vr48sDlrgP0fQ2czv0MlX+viP8MNrA6tsPntg
         ssUNSm2YavYKBRnkDSccoBVmKpRHxa18WiG4lvymk2xdIm9yfANI7SqaGAH1ETM4gXI0
         E2ZlU+Kl51K9MRNTPSkIs9ntL94wUXxDuDa50LN2IpzbEQ+hxPpRNAXwuuBUKcmKRbBy
         761fNGX+jJFXwOCIeYquoTbIpvy2Igr46FIZwZlISekF0GG3p+cbmjCVP/5LFLEVK3Gj
         TFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=atgPFfpkeHR9DN07IdhWhh4yivZEi/lRW8Y4cc5fBMM=;
        b=dCJgejyHVhxUXIobrdougWXk9BxH2k/2NwMW5Z3Hsxyjmby6wtwo7H+vCDLGRzH9cV
         DdkyoolkkxrSKyQbRso9Wra4nB7S28fiDI9mPLNUIxQNAW7MKH83+xDbcb+KFdUaN7Ql
         q2PnuJ1EAYC3u3seBXy9J42VMRfaRBhMCTZk+c8d5TM1S4UGoeitTS7S9P4erniBbelp
         VGMJgd2BiahVQWDDwM2MpQF5zfFzVr+xrEIlkfDY/uxoOdegARvLxoVqTYYKplXoiQh7
         eOCv+o+UJa+pMPvfV3ynYgGc4f+OgDay/+M2mHaDqF4mXn8oC1oCSPcUxjgrjiF3t9PW
         LkSw==
X-Gm-Message-State: AOAM531qfoPqld1B6PW2/+wpBsFZP22B269/7M1FofIsUNPxDrxP3l1P
        K9VQmncBTlaypl6udcoeQ/Hlnozwzlorhr0D+Ns=
X-Google-Smtp-Source: ABdhPJxzhf7GFj5NFjeDYzCCT5ScgnUmb6dg2+xnvOU2fmH8WN0Ov3CHV1aA2z/N+0G8canE71eWQd2G7UvsCZJYc9Y=
X-Received: by 2002:a02:ccad:: with SMTP id t13mr28513267jap.29.1626828309591;
 Tue, 20 Jul 2021 17:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <49498ed0-cfd5-2305-cee7-5c5939a19bcf@campoint.net>
 <87a6mo29dp.fsf@evledraar.gmail.com> <CAMMLpeQ5Lh8xfqTZoM74f616wE7ZhqWArL1WgGiMtiJSfrYcYg@mail.gmail.com>
 <87h7gsvybx.fsf@evledraar.gmail.com> <60f5c7b867941_141e5c20886@natae.notmuch>
 <60f5d3ac6ce_14538820823@natae.notmuch> <CAMMLpeT3bJcr7mRDpxmk32VqpAbNpN=fgPjmkcY+0zOBYruybQ@mail.gmail.com>
 <60f61b81a3b74_14781320816@natae.notmuch>
In-Reply-To: <60f61b81a3b74_14781320816@natae.notmuch>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 21 Jul 2021 08:45:32 +0800
Message-ID: <CAOLTT8T0oKQ2jCjcmjd6mfYeFFZESgCvV2iOLeUQ1b_byB2UZQ@mail.gmail.com>
Subject: Re: progress test failure on fedora34
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fabian Stelzer <fabian.stelzer@campoint.net>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, I met this bug too on my ArchLinux.

Felipe Contreras <felipe.contreras@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=
=8820=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=889:04=E5=86=99=E9=81=93=
=EF=BC=9A

>
>
> Yeah, this fixes it, but it doesn't seem we are setting any
> bash-specific options right now, and additionally I don't think bash
> should be doing that in the first place. If the shell is
> non-interactive, why is checkwinsize being honored?
>
> Moreover, why does it work with prove? I'm investigating that right now,
> but so far I haven't found any reason.
>

I ask this question on IRC #git, and ikke said that after bisecting,
he thought that
this bug was introduced in c49a177be.

> --
> Felipe Contreras

--
ZheNing Hu
