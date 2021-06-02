Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8789C47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 12:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94BF2613B8
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 12:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhFBMVq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 08:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhFBMVq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 08:21:46 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2846EC061574
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 05:20:02 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id m3so2281412lji.12
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 05:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vigEUw83yytQ4LLreBsfwKZpjSLxE5zITnG5b9pvmfo=;
        b=oTP97QQRsEz9nkjsUv2Qm0Wf9XP6+BvBOmsp0nIdqxJvog/sTdS3rZG+L+2Vixqo+u
         8hSV7yHEJvnazgKPikqt4FMhFHE6R+NFQPTzYMzq4W92mfecwdEMASh7ZFTqFi1O1VEB
         RA46UWIKpjYLR2cQm3ABjCeVeg/7DObWszz85WCKyTxE8Wr4taSqvJJ6T3KLnbYsWw99
         IZp9xurmasQXD4Lyfg5OrhAoGUkEDttu8+ZgWxpiPYe9fEzoKku5B8pxv6TWyHLPTGeb
         jYpU9f6uyHoG9uQeaBxfE8O6O0DZ1MfezlOEFog3bcmeMZUiQUpxNCELXjMTDzxP2Pbs
         8D6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=vigEUw83yytQ4LLreBsfwKZpjSLxE5zITnG5b9pvmfo=;
        b=RgzV5vXCOMaTGyc2pPOMZoIyfbdKICz6OBN9Isr6XMPz0bfxB2vxLgcuBMmZdi+Tjb
         ZXJWN5mn4f3QVspgqGhIHgH7Mg490TvgrsyqryTpboJK/vLBRxxfYsynfw+RNqjGSEVK
         Hbhvdlibei7g6v/v2PVA7eyk0H9uTgQAylxCmhm71UqOX/cWQrZu90YiY3OIYIaEiz8V
         7A3Apa6YuKqsYyo4zTD1Beu8hOaRvIi7qUvVEfK1i4fJWlu8C47+4tM0oarjJSCviCOf
         BmQtGGUdz3diRyQEVVUDubOjiZYSEDCVYUCtbPayEnttLaD8mpDec0rlsPn49h0zMs3T
         4xHg==
X-Gm-Message-State: AOAM531Zu2eMYUSbmTtkF4KEX6S5dBsvkX+KqAlXusHyYsXbkpX4arob
        VW/9EUdOTEh+hdsbHj9CGnXk3xJKPz4=
X-Google-Smtp-Source: ABdhPJyV6eBGQNY14t01DA21HtINma3g2IE4eTXyyvBsTGFCdots4wkJ5Hf2Aghlh/gwoHX2vom2Xg==
X-Received: by 2002:a2e:7207:: with SMTP id n7mr25141635ljc.352.1622636400249;
        Wed, 02 Jun 2021 05:20:00 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c20sm796498lfm.8.2021.06.02.05.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 05:19:59 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: The git spring cleanup challenge
References: <60b5d281552d6_e359f20828@natae.notmuch>
        <87wnrd6wqj.fsf@osv.gnss.ru> <60b6c08f75c1c_40442086d@natae.notmuch>
Date:   Wed, 02 Jun 2021 15:19:58 +0300
In-Reply-To: <60b6c08f75c1c_40442086d@natae.notmuch> (Felipe Contreras's
        message of "Tue, 01 Jun 2021 18:19:43 -0500")
Message-ID: <87eedktq4x.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Sergey Organov wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> > These are the configurations I've chosen:
>> >
>> >   [merge]
>> >     conflictstyle = diff3
>> >   [sendemail]
>> >     smtpserver = /usr/bin/msmtp
>> >
>> 
>> [pull]
>> 	rebase = merges
>
> Can you do `git pull --rebase=merges` for a while?

I never use 'git pull' for merging, and all the time with rebasing, so
what's the point? I mean, whenever I do 'git pull' I mean 'git pull
--rebase', and whenever I need to merge, I exclusively use'git merge'.

>
>> [push]
>> 	default = simple
>
> This is the default, you don't need it.

Yep, a remnant from the past.

>
>> [rerere]
>> 	enabled = true
>> 	autoupdate = true
>
> We are seeing a pattern here.
>
>> [diff]
>> 	algorithm = patience
>
> Does this make a lot of difference?

As far as I recall, I had some mismerges long time ago that this setting
affected positively, so I've tweaked it.

Thanks,
-- Sergey Organov
