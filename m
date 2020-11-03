Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0537C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 18:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DCA9206DF
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 18:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sathyasays-com.20150623.gappssmtp.com header.i=@sathyasays-com.20150623.gappssmtp.com header.b="H42fqVM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgKCS4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 13:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgKCS4b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 13:56:31 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85FBC0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 10:56:30 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id s30so1380414lfc.4
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 10:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sathyasays-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LwFKPy+7Vd/fRhxQfBQY0IczNvHEFlL9pq5uFmS11OE=;
        b=H42fqVM/f2ClFvGnI/aEYCUvaETZHGC0mcSKs8F4g/RBqjT954RqRaa18uqvASoHfo
         6Z56uio+/3OSOQGsLFqE6OE7XfeaJHKgJNvf7Fws8NLmvS70tR9gyiRWAWQeWLKO3ZUy
         CJO0MKoWQ7sDX2q2+BUUwthlQqJpNnDD6o0Cbu+EylxALnKtwIzOdHbw7pB0wbm9uD+N
         edvFWJQUDMGVgdn64eSV2Nx1rhgy63LAmjGSgIVsVaUP0YVZ8Yay781Pp7w3Pg00y+LG
         JnG7eAcYhHnK6fcsOKIjK54k1dFtPIMZoYdXFjSMreW31WGLAueiH+wkqc90x3W4HsJc
         tjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LwFKPy+7Vd/fRhxQfBQY0IczNvHEFlL9pq5uFmS11OE=;
        b=eqtFms+bkZQq3jPOZMDjBlHN8vpJ5CY3LfXVH0H1iFGgHRB9pokAFUEnEnF6vYZ1Ya
         SpYc1Jzt9JbGKLYJdNc1QpsyRRsawJYyhxt6BeImDGyC1nGdZ1r0NyEhouhmuqxXCjVe
         mxms1KE5LkUPzov69+22/f5ZbUXsEjzb/r2uwvAwm/6wVRTWWmIHb9aAtZYyc359v8i4
         nQggQ7pfbuYvLVQ9uoAkiZ6jSKg7DATuoB+qpEkJc5QH24exQaXP7AhD9VNLQXox5IAe
         8brXx5ACcQZ/q+JsyT+0bxsy6CG55GiKIVO677N/Sus/Ts1EsWRja2gagvySwKrm/44B
         nL/g==
X-Gm-Message-State: AOAM532CxzcXNssbbyPyLEIrlTV7XG98bgaqipWxGe1cN10PiH1u9VRV
        DJcwG+9P4x/26ENMvzWV0zUJsMR5Pv9p87Q5XW6UEQ==
X-Google-Smtp-Source: ABdhPJwFBZg1wLBFoeIt9MTs+OsCloSsXdnKLz/sB2AkhRbZLSwiFVtN/tcAN6NpI8TyyVbTwULJQFPB4HpkTmi3cDY=
X-Received: by 2002:a19:22d8:: with SMTP id i207mr8411100lfi.85.1604429788281;
 Tue, 03 Nov 2020 10:56:28 -0800 (PST)
MIME-Version: 1.0
References: <CAMsWJsyPVQWV++gc2YJriEOEWBELa_xj2G0NWFMSgNYt47swiQ@mail.gmail.com>
 <0581272e-6ad2-42d9-0196-b804ee304619@gmail.com>
In-Reply-To: <0581272e-6ad2-42d9-0196-b804ee304619@gmail.com>
From:   Sathyajith Bhat <sathya@sathyasays.com>
Date:   Tue, 3 Nov 2020 20:55:52 +0200
Message-ID: <CAMsWJsxyW=JUh=XGCkGG3LhOsZASwFHtx9b6ziNi_uHa918Scw@mail.gmail.com>
Subject: Re: Segfault in git when using git logs
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 3 Nov 2020 at 20:46, Derrick Stolee <stolee@gmail.com> wrote:

> Hi Sathyajith,
> I started filling out an issue on the VS Code GitHub repo
> so they could perhaps fix their usage of "git log" in this case.
> However, I started searching their code for where they might
> be executing the command, and I didn't find anything!
>
> Is it possible that you have an extension that enables Git
> history commands like this?

Hi Derek,

I believe it is GitLens [1] which is causing the incorrect behaviour.
I haven't had any crashes after I disabled GitLens, and that's the
only extension I've had which interacts with scm.

[1] https://github.com/eamodio/vscode-gitlens

thanks,
Sathya
