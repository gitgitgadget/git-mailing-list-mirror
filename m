Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B738C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 16:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A9036109F
	for <git@archiver.kernel.org>; Tue, 18 May 2021 16:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343956AbhERQYq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 12:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237986AbhERQYp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 12:24:45 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57ACC061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 09:23:26 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w12so4188237edx.1
        for <git@vger.kernel.org>; Tue, 18 May 2021 09:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=72/0TygspPj7R9U+kWL8bHGR3UyAkVQiv8p7fVnBaxs=;
        b=puiVh3AVPbjQfHQhNTCwL0Ph4NpkliD8XwUwzEGlmy0vhuhXivWU91CTdHJtMVV1C8
         X1ItgNVxTXSMBJIU7Mk4m3oxpbLc/eUCTlJlGHjeMmnbz9qSJe8oWmAesmss3PoTp5pn
         wLggEHpjfC5v1D87lJ87UNRZWSSkeAgSE6KNKCTc29rYojGBMMRDRFtgtwv1/bY5yTSG
         jBci8NfJZtFueVkCh2DliNRsEwo2bw49nQryRG0KKgZEHAGQ+g+dnfukjj9qkUBSFgmF
         TEMqgNqpgpb1KIW6Dsg4WgavtrHiSOt0qQ37CiVaDH5efNRAKD2NQE2qnk89MAEvkHPY
         7FdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=72/0TygspPj7R9U+kWL8bHGR3UyAkVQiv8p7fVnBaxs=;
        b=ZmKg1PfXiVkFg5eFXzrPlzxZjRo2P5HMEVJkwo7F+ZM3NNblBrj4EX5IYVxkQ56h+H
         VJENQLqJLyX9k5Zk7IaxesaCvxyWKw1k23NU2U18Ktfgy9R1JsJ0wTOXehHs4EE1tVzz
         9c07TNUryNXq2n9UrYs92Z+75GaqMHFP4l67Mx5JrOBTmIXntDCxGFpYV1abMyP9Jdnc
         AS0vZUltmxD8QxoaBIPxPDfiM/qkJV783uD3tuTjZrzUJ3uVc0amwSV1T0kOAVJSLap1
         FPpZOI/8qYfsPVwysTBWlOwmY8/VH5/HzW/WhtL2gq5MOx7Kz3ei6WNHB2eP+QsxALqw
         KFZQ==
X-Gm-Message-State: AOAM532jfBphZMIXBIJaRQiKpdFpMOKtTGZkxhx5dl0v3eiI7dItl6lo
        0ra2nfk0QYFKRrOkKJL9ThH4wesjkvUsWkoopYg=
X-Google-Smtp-Source: ABdhPJyZXUMgPR0wcn235gZETYLXZilfYCEVOfpnEDM7gqAHBGnqZD/yQeiCkNINkuiJ4bqsPTIzCF26S24cgPnOm10=
X-Received: by 2002:a05:6402:752:: with SMTP id p18mr8104375edy.127.1621355005505;
 Tue, 18 May 2021 09:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <740165DC-19B3-49A0-8D70-B78B2BDF4C1D@gmail.com>
In-Reply-To: <740165DC-19B3-49A0-8D70-B78B2BDF4C1D@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 18 May 2021 18:23:14 +0200
Message-ID: <CAP8UFD2b4Gd-g55MzgJkcKobhw6NCueuV=f+HFGPgSMvPeQ0OQ@mail.gmail.com>
Subject: Re: [GSoC] An Introduction
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva,

On Tue, May 18, 2021 at 9:15 AM Atharva Raykar <raykar.ath@gmail.com> wrote=
:
>
> Hello Git Developers!
>
> I am Atharva Raykar, a student from Bangalore, who is going to be
> involved more deeply with the Git community in the coming months.
>
> I am going to be focusing on converting Git's Submodule functionality
> from shell to C, and I greatly look forward to make improve Git :)

Thanks for your work so far! We are happy to mentor you and also look
forward to the improvements you will make!

> Congratulations to ZheNing Hu for getting selected as well. I am
> not surprised at all -- his volume of contributions even before his
> selection has been great, and quite inspiring for me.
>
> I look forward to helping out in any way I can and get to know the
> community better. I'd also like to thank Christian, Kaartic, =C3=86var,
> Junio, Johannes and Phillip who have all helped me learn and guide
> me through my first few Git contributions.
>
> Thanks again for trusting me with this work. I look forward to
> contribute and help others contribute!

Thanks,
Christian.
