Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F1BC433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 14:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbiB1OPg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 09:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbiB1OPf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 09:15:35 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302D748E6E
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 06:14:56 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id f8so5651357edf.10
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 06:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=x3aMy0sI6uZtNY+pfWzVWiHJDNP+9H28UKfQ60Q8zOs=;
        b=lChMShMa39f+Mv1xWvEZxYLOJ37jOCDW+Cjfy4bbe3EO0IrnNPayLpHj1c7zpoN5bb
         4hyBO9PvhzoII37xRYemk6f42jB2jibnct8VQMMkGImoxpHuj/HhkvOQpsnQ6HbEgVyv
         60vhG9qiFO+sWgZ154H+H0H7X5S+Hna/xjfAxOgxIRharrsoQoR3/PQsj5zJVXzNc4nm
         Ge10F0KkS+wlHhC9D+NmwrbqpfzYbJRICqxLJt5QFvBFTg5wCvWKN2yhQYVkWiUgoBSf
         /MXZ552Nz8wVgVpGH6rSyimqQAe9+ki3j94FsiY504ODyUsyCiWw/k5aBDc/3Ez5dmRD
         +hJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=x3aMy0sI6uZtNY+pfWzVWiHJDNP+9H28UKfQ60Q8zOs=;
        b=Cm98/o/DltiNG7TIiDjDyf+eeK0SvspxFS2A0mW11fctCkAfJwgIJXXmXOkpTsufAl
         cCFUUdk5dFyDzUETPaVm7Xqb3vt+oLyJuMc2m006tR7KS0QuYiaNDK85zxcKpAWhq5i5
         J3DnTXl2zS6KwW7vE3OsuIwF8oTgjHy8yDyoz6zaObdGOFCy32U+E0PN1LK36X8ADL50
         cx4p++cS6Twl4DGrGYveiNjHWm+mt02azD+aNDwT6b3v0SAuiR4a7zwstCqIFw5tVLRH
         yHWttjuIFg70s25x1iOxuW23zLvZb37stnIyYq/kwQv9/mOMNRQGeWwWrIq77jRSZ3H7
         fd+w==
X-Gm-Message-State: AOAM533PrcRMwGs23P6uNiKioL1zmlw3/qqavDm1LT+zp7YSsDy0IV3n
        7tUs7mvsVerBDkWmIfq9JJg=
X-Google-Smtp-Source: ABdhPJwNlx9PtXvvT467tPVN61wQmSUcTK0nQoHr8E3mOjffzpOO7312KrvfRgF09e7RwVdJob74Xw==
X-Received: by 2002:a05:6402:7cb:b0:410:dde2:5992 with SMTP id u11-20020a05640207cb00b00410dde25992mr20290826edy.323.1646057694673;
        Mon, 28 Feb 2022 06:14:54 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q9-20020a17090609a900b006cd30a3c4f0sm4459168eje.147.2022.02.28.06.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 06:14:54 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOgnd-001OGV-OD;
        Mon, 28 Feb 2022 15:14:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/test-lib-tweaks (was: What's cooking in git.git (Feb 2022, #07;
 Fri, 25))
Date:   Mon, 28 Feb 2022 15:10:54 +0100
References: <xmqqee3q73e1.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqee3q73e1.fsf@gitster.g>
Message-ID: <220228.86tucj3wo2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 25 2022, Junio C Hamano wrote:

> * ab/test-lib-tweaks (2022-02-21) 4 commits
>  - test-lib: add "fast_unwind_on_malloc=0" to LSAN_OPTIONS
>  - test-lib: make $GIT_BUILD_DIR an absolute path
>  - test-lib: correct commentary on TEST_DIRECTORY overriding
>  - test-lib: add GIT_SAN_OPTIONS, inherit [AL]SAN_OPTIONS
>
>  Random test-framework clean-up.
>
>  Will merge to 'next'?
>  source: <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com>

I sent a very minor v4 re-roll of this which should be ready for "next",
i.e. it addresses comments (including yours) on the v3:
https://lore.kernel.org/git/cover-v4-0.4-00000000000-20220227T102256Z-avarab@gmail.com/

If you're considering branch name/log message changes before merging (it
would be fine without) I'd suggest:

    ab/test-lib-leak-diagnostics
    
    Spend more CPU to emit meaningful stack traces when testing under
    SANITIZE=leak, and allow overriding ASAN and LSAN options from the
    environment without breaking our tests in cases where they relied on
    setting their own options.
