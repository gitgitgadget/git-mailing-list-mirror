Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE48EC433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 23:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhLPXsv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 18:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhLPXsu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 18:48:50 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B30EC061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 15:48:50 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z9so1406355edb.5
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 15:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=zCTp7eKI9Ek8+rGZb5blhHhMGZMFlmlsjPvCQLAy6xg=;
        b=Xvp6+j90LcDj/GGtarijMKIeQ9pmD1JexVeuowz0KodFNFw0FfbW0H+CectDH6yf8f
         kqaqJT2htUmatlwc8DxAg40rAAx7DSCNPhYSNqAImzcCxHoZdBzhbJuzo1SBgrhiH0rc
         y748udYHOcMIGU7S61e/KpMQkxikLqajBQ4ABqZeaEfwWcFyVtQLbbWmPNcJFHEpnctx
         te6pl4FijmkLtr/IqQWzWxlS1Q585cOamsDszIA39HmbNBKg8TkTK13xaZaMSmFAbv3Q
         oPbJI6ILDSoJwhSo574GO2p0+TaOJx3DY3cqnA2x8t/oK4vLuA4inYvlVlsQNFLvmBsT
         OhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=zCTp7eKI9Ek8+rGZb5blhHhMGZMFlmlsjPvCQLAy6xg=;
        b=Dt7Bt/2D/6xEG9C1ShHdhrHRaOA19G4vHhYmmx7ASq3rDcZ3n3f549O6UrjhA0Ce34
         42se4S+RWdEHaN+dDY2ms7qmdIcwRoWpTgAMX2Os1136IgOac3/Va8PzAc8UbRLllqqp
         /Wtvn5AoJXzpJe5MVR69B0J978xsvjcTCuYbaBVPsfRTXIhviGoIpkT2+rFRIU4hhPDT
         5WnMTymLJcb2oztl0F8Cma1wfhWrUQV5oqYGstfEsIfFpcWc1BO1dOoNIS28jiNi+TFX
         lRlCN6ddjfHPVqTFouNP+2WZa+ehTMmHSGYC0xD4tXxAdPM+ZvNrK8RTe9IGkzKVLq9e
         zOZA==
X-Gm-Message-State: AOAM532tYff61o15Ng4/1Dn7gECHAwoZljArBpjVkVIhK6/WBa6Ga8xC
        DGud4HGuwIjVK3u4CrMAho5l4Xh/ExurEA==
X-Google-Smtp-Source: ABdhPJyXUd+NVNWmEWB0fbFgPekntajRIKnOajsZecsNOkivk6tfjygpqNgelBZro67pGiM441FOLw==
X-Received: by 2002:a17:906:4781:: with SMTP id cw1mr395322ejc.116.1639698528865;
        Thu, 16 Dec 2021 15:48:48 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qf22sm833153ejc.85.2021.12.16.15.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 15:48:48 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1my0UQ-000d13-LG;
        Fri, 17 Dec 2021 00:48:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/make-dependency (was: What's cooking in git.git (Dec 2021, #04;
 Wed, 15))
Date:   Fri, 17 Dec 2021 00:46:46 +0100
References: <xmqq8rwlz3cq.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq8rwlz3cq.fsf@gitster.g>
Message-ID: <211217.86a6h09km9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 15 2021, Junio C Hamano wrote:

> * ab/make-dependency (2021-11-18) 24 commits
>  - Makefile: move ".SUFFIXES" rule to shared.mak
>  - Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
>  - Makefile: disable GNU make built-in wildcard rules
>  - Makefile: use $(file) I/O instead of "FORCE" when possible
>  - Makefile: correct the dependency graph of hook-list.h
>  - Makefiles: add and use wildcard "mkdir -p" template
>  - Makefile: use $(wspfx) for $(QUIET...) in shared.mak
>  - Makefile: add "$(QUIET)" boilerplate to shared.mak
>  - Makefile: add a "TRACK_template" for GIT-*{FLAGS,DEFINES,...}
>  - Makefile: re-add and use the "shellquote" macros
>  - Makefile: move $(comma), $(empty) and $(space) to shared.mak
>  - Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
>  - Makefile: stop needing @@GIT_VERSION@@ in *.perl scripts
>  - Makefile: create a GIT-PYTHON-DEFINES, like "PERL"
>  - Makefile: correct "GIT-PERL-{DEFINES,HEADER}" dependency graph
>  - Makefile: adjust Perl-related comments & whitespace
>  - Makefile: change "ifndef NO_PERL" to "ifdef NO_PERL"
>  - Makefile: guard Perl-only variable assignments
>  - Makefile: remove "mv $@ $@+" dance redundant to .DELETE_ON_ERROR
>  - Makefile: clean perl/build/ even with NO_PERL=Y
>  - Makefile: use "=" not ":=" for po/* and perl/*
>  - Makefile: don't set up "perl/build" rules under NO_PERL=Y
>  - Makefile: don't invoke msgfmt with --statistics
>  - Merge branch 'ab/sh-retire-helper-functions' into ab/make-dependency
>
>  Dependency clean-up.
>
>  Needs review.
>  There are some comments on earlier rounds; the latest one needs a
>  serious review or at least Acks from past commentors.
>  source: <patch-v4-23.23-48a3927d972-20211117T101807Z-avarab@gmail.com>

I think it's best to drop this rather large topic for now.

I started re-rolling it with improvements to address your shell escaping
comments, and ended up with a much better end-state, but it's now at
north of 30 commits locally.

So I've split it up and have some incoming patches. Not for all of it,
just starting with some of the more urgent than not fixes & more trivial
& easy to review changes, or around 1/2 of what's quoted above.

I'll then submit the rest sometime after that lands.

