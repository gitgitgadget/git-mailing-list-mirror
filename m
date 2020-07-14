Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974C0C433E6
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 18:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75B362242E
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 18:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfSa5e3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgGNSSJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgGNSSI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 14:18:08 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F413FC061794
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 11:18:07 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z2so23816932wrp.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 11:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VySy7PrHGK+5Q3UYrraYTqRH6qe97Tn1Vfak5or30kI=;
        b=kfSa5e3+NSr4vua63lxk1p1B3O3vrBQv3F7jkizXyXaGpWlvnSTGY8EaCyDpPynkCF
         sasrxAmj1steSBKODKlOWORXsKeE5A2eOY937ElLeFieUDKsG6LV43YGpjqTpjvsyw9e
         hKK6vXTY7jP2Lu55fkH+IF057WMVGxuppRsBHKwAJr+R9NGvslWo3hbRy4ezvYAPyv8j
         j48udXNEddHrCYXKFjkRDHRTDs5Yjc2KZisnK3AqI1iRgyiJG6cYf9EKF52etVRf5n3u
         fVGYncVHYFPoDreNKstngwqjPe82587x95qLY7TqfrvO+1DLOGnY/nczONrjx2/o5SaC
         kBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VySy7PrHGK+5Q3UYrraYTqRH6qe97Tn1Vfak5or30kI=;
        b=hiHdrMBOUcmZtHWZBb/JupaIzDuorlwFzvWL6+lyZxZtXyDpY6NDf7qArCMXQZEjiY
         U2xb4scKH4a6O64y+EOQx2kULhNaMzZy6tDi4JXd0pj2s3mNBVWv55LmE5TKGUVkk9qU
         cag6DAp0jRog+kQYRSqtz1zpyrRcdE0S+1aLVlP611zz7x1uGPGl3JVSdO0drJQvNPBl
         1cMm7MEjrpYJuv9YPq7WM7BIxatFC16FTXUKN8dr7kIJNsYhj07PrKXFYFtBG7UH+yu4
         sjyJBX9j2MOt+QQcyBJVAr78C5sgsmZhCTrQamEe5hj9oYMGkMJdfLPhTfKI+KI84PWj
         tNgQ==
X-Gm-Message-State: AOAM530B9z4fainv6jMxffmliix87IyfnAuaV5vR0rK1f93B+7Ym/2Fu
        8o6LrSUiu9i7evzv0AxmY3pOBjnFhd8TpzQ9Np/7rFvhHwc=
X-Google-Smtp-Source: ABdhPJyZad2iHDViZFxBnyD2x1Yx7hw/yBDfEP3QKE96a02J//Db6a00YDz7yN6LR61QqOjtLYA9HtLWZuAJg7Qccoo=
X-Received: by 2002:adf:e48f:: with SMTP id i15mr6856712wrm.327.1594750686628;
 Tue, 14 Jul 2020 11:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <CACwCsY7YSn_mbtFv3QjL5dY80G6e_r-gGC3SGo5rO5b8LGXxVA@mail.gmail.com>
 <CACwCsY7P5NiQL5ajHMOWo2EPiQZKUj_m_AVbtGy=z=twChimjw@mail.gmail.com>
In-Reply-To: <CACwCsY7P5NiQL5ajHMOWo2EPiQZKUj_m_AVbtGy=z=twChimjw@mail.gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Tue, 14 Jul 2020 11:17:56 -0700
Message-ID: <CAPx1GvcOpmpuPseAQDYk9pg+hfdF9KJSSSiB0fEHQrnUuPS4CA@mail.gmail.com>
Subject: Re: Can't checkout branch
To:     Larry Martell <larry.martell@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 14, 2020 at 10:04 AM Larry Martell <larry.martell@gmail.com> wrote:
[snippage]
> $ git fetch --all
> Fetching origin
>  * [new branch]      deploy     -> origin/deploy
>
> $ git checkout deploy
> $ git branch
> * master
>
> $ git checkout origin/deploy
> Note: checking out 'origin/deploy'.
>
> You are in 'detached HEAD' state.
>
> I tried deleting the local repo and recloning, but I got the same
> results. I see the branch on github. I can checkout other branches,
> just not this one.
>
> What could be going on?

This happens in Git versions prior to 2.23 (what Git version are
you using?) when there is a *file or directory* named `deploy`.

What is happening is that since there is no *branch* named
deploy (yet), you can't check it out (yet).  So `git checkout
deploy` initially fails.  The checkout command then goes on
to try two alternatives:

 1. Treat this as `git checkout -- deploy`, i.e.,
    extract the file or subtree named `deploy` from
    the index (discarding changes to that file or
    subtree).

 2. Treat this as `git checkout -b deploy origin/deploy`
    or `git checkout -t origin/deploy`, i.e., create the
    branch `deploy` from `origin/deploy`.

If *both* of these alternatives work, pre-2.23 Git *assumes* you
meant alternative number 1.  In 2.23 or later, `git checkout`
tells you that this is ambiguous and makes you pick which one you
want.

To work around this in all versions of Git, you can just be
more explicit.  For instance:

    git checkout deploy --

forces Git to treat it as a branch name.

Chris
