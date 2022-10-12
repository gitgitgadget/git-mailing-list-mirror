Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7EAC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 17:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJLRJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 13:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJLRJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 13:09:09 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B64B5FFE
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 10:09:07 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id q12-20020a170902dacc00b00184ba4faf1cso935020plx.23
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 10:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IdNvDFy2QrtK/RNcci96SOqY3rDb3UFCHWBZfhp+GB4=;
        b=O32aphZdpbmkGrIrHDrxU9XxXgZnFC5JpoRPMiRdG3su36zjsTvdyn0jjiTFgElXE9
         80sxYizgBqweL7Nk86ha89T8al2kEQuWrKsxcivElTXYv6nvGCVyZNwO3P7yYwQyP+1z
         n9TxrUxqG10VgwLYaWQIYPWbf+9odIueraSXPO2a6Opc1cftiVI3ElzDhRgzDJnf48F0
         XX6g2U+pCcYp/emYBA2rsoTGxPBCJCoDBdEATgVN4O14fDl90KUPVRBgTzDX8iZvdRhh
         76rgVtBlM6EJ15iy/xKU6hlywxu5YQWk3/agiw0E2pnbUcm/CeaPsaZhqLc5IHV23KJZ
         13Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IdNvDFy2QrtK/RNcci96SOqY3rDb3UFCHWBZfhp+GB4=;
        b=JAwbdxrB2mpHCKkoH7fCbIfx3mpV7yfwpolEeku865pVjZyZj5P5rtWMlxHsuyMeHA
         h4EKBQWdKFRuvCR/CMLm8QP6S4m8XpSTAR2uBKUOVJK0QcM58/+0aXO0NV1RBFuwVWcv
         s4hDtH6URme0JmyFS6auqn2oodNV9uWyfLsY6G/Bngq0/IjEpe0Szbdh2EJURRebCzf/
         pQ07fNRly/gZP8lYa9oEAzYRxdTE7IRkVzl/XcATavK94pMohf8Tm8e9F7Ql5kTw/KjM
         GdRfOs2T8W6m0hlwcD2BFkvFMA2uKCgB5HIOTrqJgXAbVO3piP/WWovSxGUm5fctEg30
         u+2A==
X-Gm-Message-State: ACrzQf0NkeMEvU6wajWiKNmUBnUNx4xtUj5arTUhuAFmgCGpMFgfGb3P
        s1A6Uz0eKk+844dcA/fcD6qYUNtcyZzn8w==
X-Google-Smtp-Source: AMsMyM7kmAz5SojKqsX1LHqlAiwrsg9QaCIzINyWypneoY/kqudcJcJDpUYdFTfJyud2wMBUP/IG3F4fdWbjug==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:cfc2:0:b0:565:cbcd:b0a3 with SMTP id
 b185-20020a62cfc2000000b00565cbcdb0a3mr1621238pfg.73.1665594547415; Wed, 12
 Oct 2022 10:09:07 -0700 (PDT)
Date:   Wed, 12 Oct 2022 10:09:05 -0700
In-Reply-To: <CAPWNY8W_Tr-WoD-GXBddD5Y8w5Y4w+gDNYQdOAJ1uBwVHuRrsQ@mail.gmail.com>
Mime-Version: 1.0
References: <CAPWNY8W_Tr-WoD-GXBddD5Y8w5Y4w+gDNYQdOAJ1uBwVHuRrsQ@mail.gmail.com>
Message-ID: <kl6lbkqh0y1a.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: 2.38 "protected configuration" ignores includes
From:   Glen Choo <chooglen@google.com>
To:     "Mantas =?utf-8?Q?Mikul=C4=97nas?=" <grawity@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mantas Mikul=C4=97nas <grawity@gmail.com> writes:

> After Git 2.38 (specifically after commit 6061601d9), git no longer
> honors safe.directory settings in files that are [include]'d from the
> main global configuration file, even though they are shown as being in
> global scope by `git config --show-scope --show-origin`.
>
> The docs added by
> https://github.com/git/git/commit/779ea9303a7de3d618f3b0e329ebb89529ab328=
5
> only talk about scopes and do not mention anything about [include]
> being specifically ignored.
>
> $ git config --get-all --show-scope --show-origin safe.directory
> global    file:/home/grawity/.config/git/config    /srv/this.works
> global    file:/home/grawity/.config/git/config.local    /srv/this.does.n=
ot.work
>
> # ~/.config/git/config (owned by grawity:users)
> [safe]
>     directory =3D /srv/this.works
> [include]
>     path =3D ~/.config/git/config.local
>
> # ~/.config/git/config.local (also owned by grawity:users)
> [safe]
>     directory =3D /srv/this.does.not.work
>
> --=20
> Mantas Mikul=C4=97nas

CC-ed some folks who have interest in safe.directory and/or have looked
at the safe.bareRepository series.

Thanks for the report. As the author of the series in question, this
wasn't an intended change.

Protect config, as implemented in 5b3c650777 (config: learn
`git_protected_config()`, 2022-07-14), reads from a hardcoded set of
file paths without considering "include"s, so this bug is not surprising
in retrospect.

I believe this can be fixed by replacing this implementation with an
invocation to config_with_options() (which knows about "include"s)
should be adequate to fix this.

I'll prioritize a test and a fix for this.
