Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DD8C55179
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BD8E206F4
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvsnrqZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732851AbgJ1WYD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732815AbgJ1WYA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 18:24:00 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE861C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:23:59 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l20so19842wme.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bxWeKk2NVYpVnK3oOD6g2jdmDnVT+RnaIccFgepYtCE=;
        b=DvsnrqZszVR+eiC9tV/zQTfDRQX+7n5zvvOTg0bt6Ys7wBwuro105zDODayp5mPiJx
         3hb89vCO1g2GCWSS4XMzKl3o7bXNBjklTIe4Snd57p2fyq7QNQd0pTIiRwoJRNWluNPJ
         2kyvwlh99RlWbspd9jMkSycUEqlHgq42LvWDlwLAB3Wnd++6nm+JvPIQ240XsLFd44dj
         /mq8lro4GwzIaH3GoLLvQlpM7hJiLES1SGrkNSLDN6N4uP4zk77HT4Pd8atX586/5i1o
         /CtBQY8tV2tVVAi3DEOGt5RxIJEMXGu8WqVlDZ8wD+FQtOtKB1L0Li1624kCj7FecmEC
         2Hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bxWeKk2NVYpVnK3oOD6g2jdmDnVT+RnaIccFgepYtCE=;
        b=U+/qMvBlaxSNutQGovSDVM3+b13ss2C72LSlzqtjYi1Na/fSjAMYxglfcrQzOKX9Zg
         hJmR9uSaVWaHAbExr76X/cHcRn+xcrJVSQ+VQOsA3argYApbpy3K8m6YaCldqoes2sug
         mHLMmDR5u+YAifftQN6gTOwsz0Zpesi9x3DITNSYclIEkmAUHfU7/nt0PezZqhS3D3hc
         Ay9syHk8f9TGMhBqeW+KDiZgzf2jw/5rTeCciGUoenaVTCFV9H0idJmDLTSjeQHJzRia
         HO7ppYW4xctKGycHARBlOB/oM0sPJF61yIlFwb+L2xWl86fe7E5Tp/GODo4wWfkQONxQ
         wQxg==
X-Gm-Message-State: AOAM530E5+jBXX1Xeyk50XPVt1CnYNfJk1D57soUFajIZBdcQdUmOVJs
        CZ+wjYtOBdHhWO/WVnsokCGjpjQNDQSLyEha4Qv95D/z4mk=
X-Google-Smtp-Source: ABdhPJzgbXi0k7r5MTP2LWYAqAyUuP/8xgrCsKvrALzRogUMOUaAlnU2s8C+K/w4R4lAbSEK1281F5LJJnHtylL37zw=
X-Received: by 2002:a7b:c2fa:: with SMTP id e26mr5164947wmk.37.1603848717313;
 Tue, 27 Oct 2020 18:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.814.git.git.1593687080695.gitgitgadget@gmail.com>
 <xmqqr1to8dv9.fsf@gitster.c.googlers.com> <abc4ab95-ed65-1d6b-e964-73734c08cda9@haller-berlin.de>
 <CAMP44s3=CUmx_7DCExK7L4trZvQTxO67Qk20eexsP3su-3RyKQ@mail.gmail.com>
 <abc34ced-0c0f-4024-a50c-30e4ca31b325@haller-berlin.de> <CAKU+SVKad4q-2tTrYXa+DJBz5UJOtndEe3-4Uvnd5GZ92543ng@mail.gmail.com>
In-Reply-To: <CAKU+SVKad4q-2tTrYXa+DJBz5UJOtndEe3-4Uvnd5GZ92543ng@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 27 Oct 2020 19:31:46 -0600
Message-ID: <CAMP44s32wNhZsAgrLoz9-HFDV=aPjCp6bcJB1JsBeE+p8Qc7vA@mail.gmail.com>
Subject: Re: [PATCH] Fix zsh installation instructions
To:     =?UTF-8?B?0JvRkdGI0LAg0J7Qs9C+0L3RjNC60L7Qsg==?= 
        <lesha.ogonkov@gmail.com>
Cc:     Stefan Haller <lists@haller-berlin.de>,
        Junio C Hamano <gitster@pobox.com>,
        Alexey via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 27, 2020 at 2:59 AM =D0=9B=D1=91=D1=88=D0=B0 =D0=9E=D0=B3=D0=BE=
=D0=BD=D1=8C=D0=BA=D0=BE=D0=B2 <lesha.ogonkov@gmail.com> wrote:
>
> As an inexperienced zsh user it took me ages to understand why the
> whole thing is not working.

What was the reason? The filename wasn't correct?

--=20
Felipe Contreras
