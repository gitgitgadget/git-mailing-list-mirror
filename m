Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBE6C38145
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 21:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiIHVOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 17:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiIHVOC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 17:14:02 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9498FE485
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 14:14:01 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id h19-20020a63e153000000b00434dfee8dbaso3659910pgk.18
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 14:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=d33CeGTfrs4HvGs+11P5gBBQEOEQSMLnqBfWeStHWkM=;
        b=UtvcZPsplpD99lqDIw9/sQ6e2zGiq+90cZ7vQaykdobXzQgP/LtsrHFLLSJIp8jap7
         kGesrVZLmG3ebncTnmvPti4iHSmn5dBbI+TKan17r3KLa3G4Us17X2cHC6hxI/FamOI9
         p/5hXwHP0p2uZbmUEHWwYHSvWa32VG8nVOVaSglktQy8Wob3p0PnvtZGHKI5ZlpEl7Eg
         LiZmqN5mPd//XoUMGEWOgD6bVr/HDNVEtnf+0uyPv4cz25obQsoHvjgAZ7IO5ZepJY2w
         1CVKI0hNuAugyURkc5i8I1ttO3f55YBJT02Hn6qVeJNHotosoGRjvPmAvplNiq6G4Hoc
         CucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=d33CeGTfrs4HvGs+11P5gBBQEOEQSMLnqBfWeStHWkM=;
        b=r4T6/MYu6+ITneR2kLmNAc9+mHRe9+QfL8WcrR+gR39qfL74dak/FKlBZWXtk81cB4
         Nd1KtXLno8JifN/ennWjMBEGYTiRkjsoLf+Ocp78moHfFJQSV1Iq1u00dNnpkfq89khR
         GmaPhD2gQI0k/EVcPKEzKl9TnsYlBRQrkYM2gmMBYzRJizBOPXjh7pPdkg5D8NwV7Olx
         a/XagAJXwgARNopdMe5UdTUzVvbRvUjfrvxGPh3KbkCTLR8lrSyTwYXAnaYLslyHg6GR
         8YkYilvP/B48CqCiBKzcmqU40nyIEI/NlGLfWyrhdkhaqyfMAWbJa57RnmBK1v7Je3/j
         atFg==
X-Gm-Message-State: ACgBeo37QSfqnGsUoLAtH8PttpGcK79gWLsrnpOMqblQoGhYN8HWExMf
        CNkVcxIE5TXEhAOR1BwHPCMqxvGpopAveQ==
X-Google-Smtp-Source: AA6agR6ZtDx/zop3jP5pe11xWDGg0Y/g10gH39+T5r8tRUK7/1x71PLgheHSKZZAelDqaliQo9HA5VbttIq12Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:41c6:b0:174:3acf:8294 with SMTP
 id u6-20020a17090341c600b001743acf8294mr10531197ple.118.1662671641302; Thu,
 08 Sep 2022 14:14:01 -0700 (PDT)
Date:   Thu, 08 Sep 2022 14:13:53 -0700
In-Reply-To: <c249bface2a6dcd0355620f92579b42a6fa4ea58.1659722324.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
 <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com> <c249bface2a6dcd0355620f92579b42a6fa4ea58.1659722324.git.gitgitgadget@gmail.com>
Message-ID: <kl6lr10l8t7y.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 07/11] log: add default decoration filter
From:   Glen Choo <chooglen@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> When a user runs 'git log', they expect a certain set of helpful
> decorations. This includes:
>
> * The HEAD ref
> * Branches (refs/heads/)
> * Stashes (refs/stash)
> * Tags (refs/tags/)
> * Remote branches (refs/remotes/)
> * Replace refs (refs/replace/ or $GIT_REPLACE_REF_BASE)
>
> Each of these namespaces was selected due to existing test cases that
> verify these namespaces appear in the decorations. In particular,
> stashes and replace refs can have custom colors from the
> color.decorate.<slot> config option.

I _just_ noticed that refs/bisect/* isn't part of this list, but I'd
presume that users want to see those decorations (or I do, at least).
Was that an intentional omission?
