Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB66DC43217
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 23:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiKXXoH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 18:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKXXoG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 18:44:06 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223DF898C5
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 15:44:04 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id y14-20020a17090a2b4e00b002189a1b84d4so2697049pjc.2
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 15:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+fGy2TvnyXtMB5JM89LJlML+0RYRg4M5JeV+1ipbh60=;
        b=V2vGcjwHLlWCEyUmZW3Mf/jPR39ol4AmwNgbd6TmFuss3NrJSNEjaW+1MNtfgJM1sm
         TtwJOjiX7f3Q92kYd81dI1Mh4i8m3nuHIlNjL4NXV0H6lTlB1oLgtUK6B8LxfuDvkqhE
         B9apIJenAUC9FoxrAuLzzQ7DNddvJ5E3ZqlECZUC1iOY8kRc8ePhIvZvLm6vjmPOgneP
         Kziueh8Pt1vgIFfxye4VhFXQPee5bHLNR3Rw8rR1bMn3tZ+awOfxlh7g/anPEIkqCqX9
         uqBA7w9BV/hsM422WXHTKsyZi1xJXyDOevssZ33y25XTC4UUqItSZHcZLRWlVZKjzDfS
         COgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+fGy2TvnyXtMB5JM89LJlML+0RYRg4M5JeV+1ipbh60=;
        b=Z7gtOeS+6S0wnyxG6tj8espUd5qPs4C83MJE262x0YN8b13zL09TlAxDOCWIBpYqFO
         pXUJC3z241l+KXdcm0hu+1Ig2TEl2IuQLXEXZ3ao/6GvisNj2JuTvcijyOrpzhtHjgVy
         iGt5Msmta/4RFLnaqozXg5YoVtxKnG1gPPPQYIaDB3Y2fnuBJQgR/7AnE7/fwJnJda2Q
         9HbFHP0ZqFaHArzHZPgoSIISXgq0ZyrmATaZatErh0f+rkd/XMlrR5BheaSpI61UThgg
         ukqmF+zdDgf2Uuh1NDWHn+GJYydDRMxxPYQeKvo8qwuBVYcAsXvshDmPyezTkLYnYEas
         JgTg==
X-Gm-Message-State: ANoB5pk6gvHoOV053X2j07FAg3yESPO1SbYrfO0hFdP6zfeMHhhj4YNq
        8A0YmD0cCxnLafZhZ5MbxkME9Cy2JejDuA==
X-Google-Smtp-Source: AA0mqf7gaqHsfoUnhrqRUXmo2Z0jbtzmXkxafxtk0yQTqXTV3a2619WA1DylBIrowowZCZZ4NQkZnA==
X-Received: by 2002:a17:90b:1282:b0:214:1804:d96b with SMTP id fw2-20020a17090b128200b002141804d96bmr36766242pjb.90.1669333443407;
        Thu, 24 Nov 2022 15:44:03 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id m13-20020a17090ade0d00b00209a12b3879sm1685339pjv.37.2022.11.24.15.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 15:44:02 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git for Windows 2.39.0-rc0
References: <20221123122753.3132-1-johannes.schindelin@gmx.de>
Date:   Fri, 25 Nov 2022 08:44:02 +0900
In-Reply-To: <20221123122753.3132-1-johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Wed, 23 Nov 2022 12:27:53 +0000")
Message-ID: <xmqqpmdbkjel.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Dear Git users,
>
> I hereby announce that Git for Windows 2.39.0-rc0 is available from:
>
>     https://github.com/git-for-windows/git/releases/tag/v2.39.0-rc0.windows.1
>
> Changes since Git for Windows v2.38.1 (October 18th 2022)
>
>   * Comes with OpenSSL v1.1.1q.
>
> New Features
>
>   * Comes with Git v2.39.0-rc0.
>   * Comes with OpenSSL v1.1.1s.
>   * Comes with cURL v7.86.0.
>   * The Portable Git edition (which comes as a self-extracting 7-Zip
>     archive) now uses the latest 7-Zip version to self-extract.
>   * Comes with OpenSSH v9.1p1.
>   * It is now possible to generate and use SSH keys protected by
>     security keys (AKA FIDO devices) via Windows Hello, e.g. via
>     ssh-keygen.exe -t ecdsa-sk.
>   * Comes with Bash v5.2 patchlevel 009 .
>   * Portable Git no longer configures color.diff, color.status and
>     color.branch individually, but configures color.ui instead, which
>     makes it easier to override the default.
>   * Comes with GNU TLS v3.7.8.
>   * Comes with Git Credential Manager Core v2.0.877.
>
> Bug Fixes
>
>   * The Git executables (e.g. git.exe itself) used to have incomplete
>     version information recorded in their resources, which has been
>     fixed.
>   * A regression introduced in Git for Windows v2.38.0 that prevented
>     git.exe from running in Windows Nano Server containers was fixed.

Thanks!
