Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39602C4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 13:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F669600D3
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 13:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhFWNEG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 09:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhFWNEG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 09:04:06 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0FEC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 06:01:47 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bu12so4011007ejb.0
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 06:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=rJ0GZOz8uvTwD/JijP6NW2jO7tUrn4p1Irpn8xqxdzM=;
        b=PdI6PP8HEuLTLWzhrdy1P0AC0nvmziwBR6XtMmyhYEhKw4P6LsJEKdwbBFWv+lt7Db
         DXuZOFdk/2tmNxbB88iR6ijg9Nh91ZvOsnf5Xyn/m2CMseCJNxtJaT/OVujWxJeVO4GZ
         TGN+C1p3xryfpSnOnrjOCzJ2vHQXd5IBtZe8OQ1bNlbpApfn9PEmP7LWvNK9p9weH4sz
         NvxfoqCs9TqM4ab/Mfcx9i9FzocmusJw18g9Cy+ZTu0sCyOXamGX2xN++QiVo1ovtxRh
         qtgzbPYUwd/PuoauvdPuFljU3zPN371GXejzYTKAMY5PmjYSCuXDrylzurQ08O95jQ/b
         VTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=rJ0GZOz8uvTwD/JijP6NW2jO7tUrn4p1Irpn8xqxdzM=;
        b=UIlPTbgIgIjoNHuiWrNGHED34MGZWLk+RKYD5wFslUFKvPwgesuKNGlidCcicQ7Osi
         O52GqH+gVceXV8459jlOuBZp/lKmr1dTJu6o/AgiJqL/wUIC1sexjtWc0tpNkJacq6Ik
         S3VE4u2Oe3k74GsZbsbzHwMBDN6JjrFMxGoqDVXN5DKzQyBnwNm5I3ESem7M5ws9+XlL
         FYzwWTkAZz+zvNq+EjOSZYo7UjwbBfjq2bpR2J4CaItiNAuDmcNgRuamNDWttz615p/Z
         R5EBiYjlSrhbyWgfYY9rUvg8nwbz+LaL3fcmdXmOGui65574pCTKNk+7Lg9nEHXsHjrr
         Bvrg==
X-Gm-Message-State: AOAM530Wxx5sFXy1IZIcxYQHLvhK/88IzJ9mG5TKEfrGJYl1nJNEF+Jn
        rLvFZukYhpd4+LnM/Fq9BHA=
X-Google-Smtp-Source: ABdhPJybiORpJABuPvNurmQMustl/5s+ymm/9UeGZk++/ZvUobGR/5NQKab8Wp38TVc72OtYWKH75Q==
X-Received: by 2002:a17:907:3fa7:: with SMTP id hr39mr9680716ejc.23.1624453305923;
        Wed, 23 Jun 2021 06:01:45 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id t8sm7296704eju.14.2021.06.23.06.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 06:01:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Tim Hutt <tdhutt@gmail.com>, git@vger.kernel.org
Subject: Re: Bug: branch checkout is detached if the case doesn't match
Date:   Wed, 23 Jun 2021 15:00:24 +0200
References: <CAKuVd4DfvEhXDUvxaU_jjNk8JSZANM8jpSEOxi1cbSAp23ohjg@mail.gmail.com>
 <87czsg429h.fsf@evledraar.gmail.com>
 <CAKuVd4Bfykm0xe0P5FMy3W8HuECJHqP-RGo+T_VK4hn43sgEpg@mail.gmail.com>
 <YNKeq5mSu3f0A/5I@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <YNKeq5mSu3f0A/5I@camp.crustytoothpaste.net>
Message-ID: <87wnqk20qv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 23 2021, brian m. carlson wrote:

> [...] In the mean time, you may prefer to adopt a naming convention
> for your project branches; for example, even though I use Linux and
> don't have this problem, I always use lowercase, which makes things
> easier for colleagues on other systems (and is also easier to type).

The reported issue is one that doesn't have to do with the naming of the
branch itself, but git accepting it due to how the ref backend interacts
with the FS.

As noted I've run into e.g. people writing unportable "head.." code,
which we happily resolve to "HEAD"., ditto "master", "Master", "MASTER"
etc. on OSX.
