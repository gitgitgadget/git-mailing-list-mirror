Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF8AC433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbiDMUkC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiDMUkA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:40:00 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446AF4CD68
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:37:38 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id m12-20020a170902d18c00b001589ea4e0d6so1703452plb.12
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rAyKlnJsRxHRGJIPUam8pvZnKxPfnQlLmh8irT6Ki50=;
        b=PBmOllbixjBiYvC3WvQteZSPU7HpZpLF7vIAbscEOiF9p4HFcNt8LDOv+XEQldvXr2
         olWGHiRsmbAiBZgGneuCuIHf6aauBV1DFrjCPnjUTXl7jLRAPZGMSWI+eitjCiDqRJhS
         9HgV7EcM/b0VGRIjaTsBhqIkLGeuMlrWvR3pF8/5tgN0pZmGCc0DAUn2GNeXg++zzmWK
         gzcUp7OodD0OmQOoo/iFJNKHMabShtmhm1ZQkNhv8SVN4QuIleXVsSkwGARX+b7GQ5ka
         XA8fd4BYl6cwFTZZV0AyUPDq3yRzd0SWJvz+nedZmMyyWEYJhlTIoJsY4Zo2hFv9LxdD
         NOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rAyKlnJsRxHRGJIPUam8pvZnKxPfnQlLmh8irT6Ki50=;
        b=SRv/z0+7FbjVZjWPC0KC/ocGz6/PpPjmMLcHnLAVYnGNnB/pGjFpRorypgfwtqL8d8
         ZS9oOLuIxD9kiTl4/dm9T2Q3HqhL3BikCoY083wI8Endc4ITaz900vTcxwYNQuZm4BBx
         LkAcDsS/wESI4Pmn+aixfEcqr2+KzQgm7uSb14ebxiINTiAvkG41ZMtBDRCbAbD47BdN
         gLeVvM7pAl6PbmRdKPpS8DTYrlGRrSDwxqn5QXS+zSaXNRi3N2KThSPq5GcFzwnnKorX
         2cJ/HLvbdu8d4/orPTvoo37mE5obNTZbooegsBPEFBUCF6murUUExoi/XCCKO0hGQfex
         Xldw==
X-Gm-Message-State: AOAM532IL+vOUBQlMEa28q6shF1CdOrOJhUMZ03V2mAIcQH3c1ow6FZw
        D2aUbqzaXjr42R0eQUUbkOAhLg/mpaZLKAS3nsaeX/ROGjqdMomjcV8RJ48DqxK4U/WNvxytOXo
        QEzPrRFEtt48hUfr6BuWuNen0bn+tbZNLILBp47S6vZtWAJTjiJ9euV2KZTRen1c=
X-Google-Smtp-Source: ABdhPJz54bdF4VJ0iAVMkYnbMi4EyazgWQZ6oktHIEw/U1Uwqg3TzGX5BBUpab/02b8/7TVCQGdTkWlthI5SfQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:8d47:0:b0:4f6:a7f9:1ead with SMTP id
 s7-20020aa78d47000000b004f6a7f91eadmr573067pfe.42.1649882257582; Wed, 13 Apr
 2022 13:37:37 -0700 (PDT)
Date:   Wed, 13 Apr 2022 13:37:35 -0700
In-Reply-To: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <kl6lv8vc90ts.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: Bare repositories in the working tree are a security risk
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>, justin@justinsteven.com,
        Taylor Blau <me@ttaylorr.com>, martinvonz@google.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the thoughtful replies, everyone. I'm still catching up with
the discussion but I thought I'd share a suggestion/observation from
a colleague (cc-ed, thanks!) who was following the discussion
separately.

Glen Choo <chooglen@google.com> writes:

> = What can we do about it?
>
> Each subsection is an alternative and an analysis (+/- are pros/cons).
>
> == 1. Prevent users from checking out bare repos
> ...
> == 2. Detect and reject bare repos using `git fsck` and `transfer.fsckObjects`.
> ...
> == 3. Detect that we are in an embedded bare repo and ignore the embedded bare
>  repository in favor of the containing repo.
> ...     
> == 4. Educate users about this risk without making code changes.

Martin observed that, viability aside, there's another approach that I
haven't discussed:

  == 5 Disable bare repo discovery

  We could introduce a config value that disables bare repo discovery
  altogether. This would only disable _discovery_; a user can still use
  the bare repo by specifying the gitdir (e.g. via `--git-dir=.` or
  GIT_DIR).

  + Extremely robust (for the majority of users who don't need bare
    repos at least).
  + Easy to understand.
  - We need to read config _before_ discovering the gitdir; although Git
    _can_ do this (e.g. via read_early_config()), I don't think there is
    precedent for doing this during repository setup.
  - Making this behavior opt-out would break every bare repo user
    (they'd need to either start passing --git-dir or change their
    config).
  - Making this behavior opt-in won't help the users who need it the
    most.

I'm not sure if specifically "disable bare repo discovery for all users
by default" is viable, but the line of thinking seems like it might
yield some good ideas.

Thoughts?
