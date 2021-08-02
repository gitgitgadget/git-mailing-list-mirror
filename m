Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DB4C432BE
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 15:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D26C9610FC
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 15:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbhHBP41 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 11:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbhHBP41 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 11:56:27 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670BFC06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 08:56:17 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b7so25170722edu.3
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 08:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=J7MZ36y1lZ+sXKaKBEY+UWXgBteB8HDoJO4tnnwp0Fo=;
        b=sNJnwfrrgZZunhw3UKs3mP4v8Z9TVfUEdhaRFcP8PBzbymnaa2DzIR1sugUffW+w3R
         NVWPASyye8T2DeETO0XMV8O5ryLEt41KI0xJMoN1wDagTZsC9Dri7ntZF5Cfj+k94g9s
         hSG9+ZEgVxEvFhXd3Gx5svo+3KS83LwAUC+/Rbex8HjY+KPhVgIlDkaFPqt4gA8mGhAO
         nC9vXA7ucPcCNLQ2nEpL1LV0EIN6OUwNtdsyqPFHitzIIj8GqATOdvdFgzHGzmltsWKX
         GgZndMWzNEMBrGb2oIiHcAaWsQZb46jcV/qXjJBIy2fX64OoA7FeYtjQcXhMtuFFL3kk
         2x/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=J7MZ36y1lZ+sXKaKBEY+UWXgBteB8HDoJO4tnnwp0Fo=;
        b=hlUXDWZAW/3lgMnwWsoYNbRO/FykgvLw/8LA9ho4Jv/yfK3LJsM2Q+AypiglbEVLOv
         O0cSWwLoqu0FA+Cmxd8qOoid9+D447WGwoPp+8PaBiAPepdbm8QMcocWeRdqGYYfuBi/
         Vpbrgyv+TY/2qzPhqH6MRO5FOvHOHsndqADeCJIizYc/efOgdJTc7hylV71C86xbR8EH
         KnDC6F3PS5lIMcICyMXqopiIQu79R6bPvpyjw1SUWH//AotWOrmNub5EVuEzPLovUhYb
         dNYr7oXqkcF02xcfoxihQuXCiimjLAcEo94xrbwPNh4ASwFfWY79ek2wkL0DGx5fwFUF
         DK0g==
X-Gm-Message-State: AOAM533yR1BlKTivu1ywQUsOKKEVgm/7TswZ5ehAETwUtVn8juybjl67
        4qdzXsPfYFWp5lkC0qLMWwWr32+OxTVUmQ==
X-Google-Smtp-Source: ABdhPJycTywz116okhJJza36I8R0jRlP5hBqkgV3y9X2wimrAtth8W2hPagy+gwyAOFTG56fxSe1Qw==
X-Received: by 2002:a05:6402:7c9:: with SMTP id u9mr20269262edy.387.1627919775801;
        Mon, 02 Aug 2021 08:56:15 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d23sm4783573ejc.4.2021.08.02.08.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 08:56:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] Change default merge backend from recursive to ort
Date:   Mon, 02 Aug 2021 17:55:18 +0200
References: <pull.1055.git.git.1627776461.gitgitgadget@gmail.com>
 <8f6af8d494e0924aef4ae6963b8dca2228dad9b1.1627776462.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <8f6af8d494e0924aef4ae6963b8dca2228dad9b1.1627776462.git.gitgitgadget@gmail.com>
Message-ID: <87h7g7on6q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Aug 01 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> [...]
> @@ -3968,7 +3968,7 @@ static int do_merge(struct repository *r,
>  	o.branch2 = ref_name.buf;
>  	o.buffer_output = 2;
>  
> -	if (opts->strategy && !strcmp(opts->strategy, "ort")) {
> +	if (!opts->strategy || strcmp(opts->strategy, "recursive")) {
>  		/*
>  		 * TODO: Should use merge_incore_recursive() and
>  		 * merge_switch_to_result(), skipping the call to

I might spot more tiny issues, but it looks like our error messaging
needs updating for 14c4586c2df (merge,rebase,revert: select ort or
recursive by config or environment, 2020-11-02).

I.e. we die on "Unknown option for merge-recursive", presumably that
should be updated to indicate that we might call one of
merge_recursive() or merge_ort_recursive() now.

And perhaps this in sequencer.c:

    that represents the "current" state for merge-recursive[...]
