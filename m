Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E276C433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9464B2065C
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMEzcYfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388012AbgEMUHY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 16:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387445AbgEMUHX (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 16:07:23 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47671C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 13:07:23 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x8so964901qtr.2
        for <git@vger.kernel.org>; Wed, 13 May 2020 13:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vBDN4K+73NKVxe8TqRFQaahiJUfOyqrNSall2bp6Il4=;
        b=aMEzcYfC30DeHIhBcMix5UWd4aVyzTCU7ydLdCNdk84qJMFhMGYJD9oE/Pa/HIwHcD
         YSm3NJfSwjsa4ohGGy3nUqa91AAv/LV1dO5tCoLqYaf9r6FtfRXogE314knjTdMtPM7H
         n+/wCI1N8lm+wAkiv3xpoN+76nAymYsCu4vfiXPD6l3bUbdv/q8f56DrPNMP+xoCD+r9
         uyLOCSznvmNr8F29QgN2CThNxrL3XI9/n1Q2HlFHzOavtagJ86DSFaG7GbBjvmTw6G/b
         I7lRAlN/SPM7E/8cO2F4BER20k1hX8DvfHv5G6sKLQVUeQte8b9bioaDtJwOLBnw+enf
         xMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vBDN4K+73NKVxe8TqRFQaahiJUfOyqrNSall2bp6Il4=;
        b=DC/+UZ2NzPgCXslVH8wEyRa7M8XLP8Ul2ggvxs6SMolroWW8x23z/vl1SLC2wVJ7hW
         zlhMeAsN96uxNQgh+2Yo0HpPNr+XfX5t2CJLv1o4KtIPq3dyoVx3i4VFn4u/fK+rgYj0
         zRAbBmrKSzkqqsd1OneprR6g9FI9ClMqN80nyh6k9yE5Tp5tW5BDwAUvwAORnkdVOb7n
         V+w/r4wlujWbKNZP44Qf3Vc0q6IdnX8ZAQyzRfKjJ/KJ9VLnjiqanjO7dr8rtLGrfI9J
         2Lr0J4lV6vXtd5VmpLRTQkNkMCR+Mtq3itb6UQ2jOKVPc1kGF1HUMo8wqV+6CFLJLGOR
         xJ5Q==
X-Gm-Message-State: AOAM533ZI501lMdr10D/hsIQL5u5pD5RepwbrjV+XjyA9K/KpWHTzr2M
        QqxCJXFfFSRh//dw7nh6UXJnfGtITksRg241WDs=
X-Google-Smtp-Source: ABdhPJxxXiXPNKWr7wg0/K+7WyskzFVbbezGsU065MPqCVeTaRKYTC64FEI2xOb2Ob34DHcNU2aQ/QJwqYEZ3p3Ter4=
X-Received: by 2002:ac8:67da:: with SMTP id r26mr883243qtp.51.1589400442550;
 Wed, 13 May 2020 13:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <pull.614.v2.git.1589302254.gitgitgadget@gmail.com> <ca242cf5bda74aafca6c169ad53ce33a62761027.1589302254.git.gitgitgadget@gmail.com>
 <xmqq7dxgc0mc.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7dxgc0mc.fsf@gitster.c.googlers.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Thu, 14 May 2020 01:37:13 +0530
Message-ID: <CAKiG+9W+ba1ZFqKb=ADGQy146gNB7zQVOADGUqBZ4ULQM7XX9w@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] cmake: generate the shell/perl/python scripts
 and templates, translations
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 13, 2020 at 2:49 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> >
> > This patch implements the placeholder substitution to generate, say,
> > `git-request-pull` from `git-request-pull.sh`.
> >
> > The shell/perl/python scripts and template are generated using CMake
> > (very similar to what sed does).
>
> We do not say "This patch does X" or "I do Y in this patch".
> perhaps.
>
>         Implement the placeholder substitution to generate scripted
>         Porcelain commands, e.g. git-request-pull out of
>         git-request-pull.sh
>
>         Generate scripts and templates using CMake, instead of using
>         sed like the build procedure in the Makefile does.
>

Will reword.

Thank You,
Sibi Siddharthan
