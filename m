Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D32EC433E0
	for <git@archiver.kernel.org>; Sat, 16 May 2020 11:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8E0620727
	for <git@archiver.kernel.org>; Sat, 16 May 2020 11:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8bbKjM8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgEPLFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 07:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726170AbgEPLFI (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 07:05:08 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844DEC061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 04:05:07 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id a11so1736283uah.12
        for <git@vger.kernel.org>; Sat, 16 May 2020 04:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wj9yGLbZgPYIwGFapeoGz40phVd3XwCnc7RTFd/CvaQ=;
        b=Y8bbKjM8Ey8C0nx7OoZ2JwEzydBj1HGNuWjgJ2KVXhnOXsE40BWPwTKEZ0mYwlG8qn
         KqQjs/5ABp+PW77HJA9Y2MkDBtVLgmT3TUa+6FeH99vZvCYr98yVe/DecAgEy7HyR+Du
         /d+V4pC9rJ7UoN0b9bQXSWE9OyMwSkAxL11/JgjTtldr0uKIo2Wb5+A+pxwnjw04Xu3S
         KAXKFms+wIb6qmrwpRBDN7pU1M59xPhC/ajD/2REvEyYrHDRFJ0ag5nTy4c48Xt/O390
         Gz2VBsrPejSyEuv+CABR8fK/vcK2NgVxz1Wqcz1RtGQ6EoaL0rff2ZBZ8UYilSgs3dBp
         tkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wj9yGLbZgPYIwGFapeoGz40phVd3XwCnc7RTFd/CvaQ=;
        b=Xsd9giX8cAGIvLAkSUwmE4GcHA84u4snV4moCnLogJ+1x8j+mG3Wgnvb7k67W7NyNZ
         ow9NuTcfVBlDR8Va7zhQ+9BwaT3l6yzYwLFLix17ySh3oKluuPgoJ/lw678urQpKih29
         cccD3PYoXVPE33H/wpegXjlVs6kwuKiJcG5VJ7yper3l3Av4PYVtTteS8N1OmF7EepJD
         AcXt3Og2nEXND19k+f8vJCFgkLJWRuTGMPx5kkm8uMV1OPKoKdqKmLRoilhNAxBQcPoL
         UYXWSg6f9m5lraE4cn9Q2bldXaQ1zc9pj0RMhb0sorqcV9MSNJOywucOd78UhF77FiQB
         kN3A==
X-Gm-Message-State: AOAM5302k/svFMVh6SoMe48nYgnU4jQWwuYSKv0YL/C6h0NqEOvyj/DJ
        iqh9b+Gpzrgld+nkASu/PIYnAu24RQLGG61yTF0=
X-Google-Smtp-Source: ABdhPJzOjwadjCh0GSFq/v7+RPOQbikrnRpXSg2eZW37wlPgyvF+0Do5FW/im4P61JFC0SiRVrtN2R//6z8kbUF35mg=
X-Received: by 2002:ab0:6ed0:: with SMTP id c16mr2432289uav.62.1589627106841;
 Sat, 16 May 2020 04:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200513005424.81369-1-sandals@crustytoothpaste.net> <20200513005424.81369-25-sandals@crustytoothpaste.net>
In-Reply-To: <20200513005424.81369-25-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 16 May 2020 13:04:56 +0200
Message-ID: <CAN0heSpKG_2F_WFP6c7WoppEwoQ7Pjbik152+8_hcz70C3i2MQ@mail.gmail.com>
Subject: Re: [PATCH 24/44] t3200: mark assertion with SHA1 prerequisite
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 May 2020 at 02:56, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> One of the test assertions in this test checks that git branch -m works
> even without a .git/config file.  However, if the repository requires
> configuration extensions, such as because it uses a non-SHA-1 algorithm,
> this assertion will fail.  Mark the assertion as requiring SHA-1.

Makes sense.

> -test_expect_success 'git branch -m q q2 without config should succeed' '
> +test_expect_success SHA1 'git branch -m q q2 without config should succeed' '
>         git branch -m q q2 &&
>         git branch -m q2 q
>  '

Going forward, we might need config files for other reasons (reftable?),
meaning this would become "SHA1,!REFTABLE". So maybe this should be
"!CONFIG_EXTENSIONS" or "CONFIG_LESS". I think this is ok for now,
though. When/if someone needs to make another fix like this here -- or
at the very least the *third* time around -- that's when we should think
a bit bigger.


Martin
