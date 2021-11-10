Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD02FC433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 03:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6320611AD
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 03:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhKJD7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 22:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhKJD7x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 22:59:53 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1ECC061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 19:57:06 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m14so5265001edd.0
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 19:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=gGP16ABYh8JHJA8jxyojAw9CYOx8ZnyAgI3nbjzH/vY=;
        b=SRtgx4X1xRjEU8dKT61jzKwzgdBtNLBpPzMJazBRHW6PnZxA5+cehpPkgxF+bykoS/
         g1T9t7pRp3JnIG6/PH3FoGiBGdcs4CpQFDOa2Bc0QbSO/sAp41TG003CvxzlWF+o1BXF
         JgZ+3QlTH4WrmyHaxUpP1cvxPFMKh5z0QHzdgbVT/sAbBtFhIQVvXAF+ajRkJkU1IcEh
         KmeSHC/feGmn2OfiaDRbNIw/I8hWlyDwCnOLvfGU9r05I+xstbY3o+mEjSmnEHDix78E
         lp21UQyDvAtCrVZ19eh+R5L1/X5YsYWriVQ5SPPcG9JMaqb+uZuqnE+9Mvt6j4x3p0lg
         6wGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=gGP16ABYh8JHJA8jxyojAw9CYOx8ZnyAgI3nbjzH/vY=;
        b=sOzERTd9szS68vpqwfEO2iA0YkIwjuMJraxh+MuuDEdzST2c9gIhWJtd71YeeY79CG
         a/8z057DqF4Pc5iJRApTQUzGQ5gfs51lP1uBiuax8KfRUHTPSPw2S32m7/LveXDHr/pE
         ZAZc72/MZ1jnmwXtOgYkRVFwUTY2sovTnblepAz7Gts9HCkwnOyZfxWH3tTZlhkAhPff
         ve+uRZhB7SwFgMoXWfthGSOUvOsKfAzRg/ZqKkXTsRslz3NnfhkJjsHgrvoY0KL9jpPk
         RfIma1Hb0o0MEcOTAxzQtvKUyiRLdBw1H7sksYwrMeiZX4sXXIjUaN7CV+gINXEQn8IP
         NFEQ==
X-Gm-Message-State: AOAM531aliYK+sZ3v0V7rypls25gFRyVaQFF2HLirCLTqS8L2UBsa4Le
        1/GGuacoqP12HvRnAp7MjD3KnEml/ITmsQ==
X-Google-Smtp-Source: ABdhPJy6TLxmBQPk0aeNUwTfixlt30pX8mlcwlRsefVXAahcEP4Tq7HzI8cRS68POwRkwvLF0BQKfg==
X-Received: by 2002:a17:907:3d9e:: with SMTP id he30mr16383299ejc.177.1636516625223;
        Tue, 09 Nov 2021 19:57:05 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m9sm10365258eje.102.2021.11.09.19.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 19:57:04 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkejQ-000nAK-7s;
        Wed, 10 Nov 2021 04:57:04 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: Re: [PATCH v5 1/4] fetch: Protect branches checked out in all
 worktrees
Date:   Wed, 10 Nov 2021 04:56:03 +0100
References: <2f983e36-532f-ac87-9ade-fba4c6b9d276@mit.edu>
 <20211109230941.2518143-1-andersk@mit.edu>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211109230941.2518143-1-andersk@mit.edu>
Message-ID: <211110.8635o4k6i7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 09 2021, Anders Kaseorg wrote:

> Refuse to fetch into the currently checked out branch of any working
> tree, not just the current one.
>
> Fixes this previously reported bug:
>
> https://public-inbox.org/git/cb957174-5e9a-5603-ea9e-ac9b58a2eaad@mathema=
.de
>
> As a side effect of using find_shared_symref, we=E2=80=99ll also refuse t=
he
> fetch when we=E2=80=99re on a detached HEAD because we=E2=80=99re rebasin=
g or bisecting
> on the branch in question. This seems like a sensible change.

Missing tests though, would be nice to have a test that saw what
happened when the branch is in that "git bisect start" or rebasing
state.

Also what those commands to if the branch is updated, e.g. with
git-update-ref.
