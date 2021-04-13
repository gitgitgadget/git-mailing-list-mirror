Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B766C433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AD3161249
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbhDMH2g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 03:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbhDMH2f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 03:28:35 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CDAC061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 00:28:16 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id m3so18177404edv.5
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 00:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=mHAVMMIB7R3HCUaAs5G2C6U8PTcUzSNX4gl3y+kjvjc=;
        b=Us8TbA7csqyU9ZDfvEPGSlj3yvTjq98QNja5bX03aU+Q3uIiZx6xJocjKORqpYE7Ls
         cG1GEIKyLeJ/ZWK1lczHZpnau5S1ai1omeRS2IZsyHasZ6fBLVoqpJ+ULovPNspXiHn2
         uPHRdsWuR5BNNxa5Z0DsmstbWP1jSwt/7iVMx6vQJXxDgF+l27C6O++V9EzMHlOGkao2
         j2RHS0i0MJtH5m4w3+UUc0O5Vq+2YxbCSwoIuMJ9OkBseblb9FLlOXJeqssGhbBnvfD0
         HnNbaYbuvu94oxr0rkR4yH5O5Vxcrkqgg0PIaPemBbuMw2pDS0/g40u+XLlkAUH1Pc4J
         /NUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=mHAVMMIB7R3HCUaAs5G2C6U8PTcUzSNX4gl3y+kjvjc=;
        b=fs8smHC68bUiNYBe+oRHCqOwMlka9f1sV3XZdubaPABGgUjgBe8lBj9EUVtAFnFXEN
         1/OGRjXKJjNW3RR9pAaO25GSD8az5XoQEp1/e/O1DMbwK8vWKzCa0ySX322BxYC/bezX
         DkqkkYLfgMvaT4dAZXzgOn0ZW0RpnkF5bLyRlLhD0i/KxDZniSbeiOMFbGBtUm2iWJaM
         XwtPzmBlvJA+RU9iZG9KnuZz9KGFK90RZXvPP8qDRlfkA2X9ZhEWZgXZMvRvXn/m3DxJ
         DUcqnGlND9E/FYoBtKo2Q81FnWXshugBgvcwLxJEI9qQMHMSAqWitlHKsiBaVBMjVUZO
         eJiQ==
X-Gm-Message-State: AOAM532oH4/vPum/PQs9a1UOgdrJJKoKGfvYBUdfbi3OYjM/usY3gmCS
        u+bpIxZJ1GhHq/SkJgCD/X4HIuDDZSQF6g==
X-Google-Smtp-Source: ABdhPJyp4Xh4N/BG6XFQ/dt+DLYuqEpZY+5FK0dZsWLnNq4mZPlobBLJQRYoUiH5k2QhVAQ+WT3IJw==
X-Received: by 2002:a05:6402:350f:: with SMTP id b15mr33013466edd.6.1618298894756;
        Tue, 13 Apr 2021 00:28:14 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id b22sm8412949edv.96.2021.04.13.00.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 00:28:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v6 02/20] reftable: add LICENSE
References: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
 <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
 <02bd1f40fa4e281f878d0b9ba4a8b5f8eb21c8ff.1618255552.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <02bd1f40fa4e281f878d0b9ba4a8b5f8eb21c8ff.1618255552.git.gitgitgadget@gmail.com>
Date:   Tue, 13 Apr 2021 09:28:13 +0200
Message-ID: <87fszuej8y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 12 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> TODO: relicense?

So to your[1]:

    > However, it is fundamentally blocked on someone willing to spend
    > some time reviewing the series; this seems to be out of my
    > control.

I for one find it hard to follow re-rolls of this when past discussion
isn't clarified/updated in commit messages/CLs.

So in particular in v3[2] there was a whole discussion about what what
this licence & external hosting of this codebase meant in practical
terms.

I vaguely recall that that was clarified in some way by you, but didn't
find the relevant E-Mail. Something like Google's lawyers said something
to the effect that this could just be added to git.git, no? Maybe that's
incorrect, I don't remember.

Anyway, we're now in v6, and we still have nothing but a "TODO:
relicense?" blurb here.

As noted in the past discussion I'm not interested in the
academic/theoretical side that license discussion, but the very
practical question of how this library is expected to be
integrated/maintained.

I.e. if it's meant to be 100% externally maintained and "code-dumped"
into git.git like we do with sha1collisiondetection/ that raises one set
of concerns, but if it's meant to be "eaten" by git.git that poses
another set of questions for the code review here. I.e. much of what
you're doing in later patches in this series is introducing things that
are redundant/odd if viewed if we're supposing that this code is meant
to live in git.git.

1. https://lore.kernel.org/git/CAFQ2z_P=MqT81gLjov6A471Z9sd69qQTep8KG8M8=LO9pJtkpQ@mail.gmail.com/
2. https://lore.kernel.org/git/CAFQ2z_OJQf3+b0TT6BmAV9q9G9c2icbLK0EqrEjpYmpi8g9Fsg@mail.gmail.com/
