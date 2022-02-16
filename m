Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6979BC433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 09:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiBPJ52 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 04:57:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiBPJ51 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 04:57:27 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BDC2A4A22
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 01:57:10 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id m17so2893603edc.13
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 01:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=yT060BSxEcs/6eHRxydwL3zgSQbl/4qpJrOwKiDvBGo=;
        b=iyqU+DEcxEJIbBGAGE7LwvtOMglZqfOIYeeLQFywuQTVirOcJ6Io6bdOp4W2CpnnW3
         n2aJZzj1IIZA0db7C1RkBuGWP/5QyOq5kSFOyXfkIUNPRIa+9xN0KCDFcbbMK/LFZ6UF
         jn57DBA023LhRtP5jY0i4TAeOCOvwEr+yMDShdNIL7GNdmG4PK4ktG1iSW05BLA5Ha97
         wPXb8fLRVGOnUwbJvId8rA0LJ8zj9jxzcnuHjj1dq2vURy4cHGEPYhn5BdXJhy36e/T+
         kkhMkdKkKn1mX8tXL57vTbHpJPRpwOd0kqfNVIYH/tfW3V080ccQhCHohVCUJDJ7Ybvm
         Tljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=yT060BSxEcs/6eHRxydwL3zgSQbl/4qpJrOwKiDvBGo=;
        b=NbQNTby3k/62mWZnTFQxNPU2BgIhGKgBbWh+6eQPGT6XPeFpfJE9m+12HksS9MCtxQ
         kXrfoo1lUnzmoraYM5/lQw1gCa7gd3MmCzNWBWNfUuLzrTPpuARHNIPVDqT60iuR2C3x
         dfQhWjDD4cc1qQSUv2gBXlZr5eNBsjeQonP4j0mSMe2LtbbP+B+cT2dI2rRKWYGIVq9D
         KzC3vLfONP6r9uhj6Bm/OHEgWynzrdRfaNyEDxVCYM6WFjr7F2k9y9ETr28K7J92VMkM
         kvS8VWYIzFTD0dnDIbqZ/WB9p8STQUpAf5UX7sG1PQcImfh13j581ev3/GHAfClI7Fdw
         Fv3w==
X-Gm-Message-State: AOAM5323kFjUhsTpG/nKJW90PmpKn9dLYVZaXni/1bvdgvupss9xAGoy
        r/wI7F3KR8J1tPtcG9wV4P6xtKTPbsYzxA==
X-Google-Smtp-Source: ABdhPJwCB0IZS3shpxsQlDzU/s1UyciEZM6/Sz/SwueloX3q3UBSM78GsHASMBaWBNhO5Py65PzPrQ==
X-Received: by 2002:a05:6402:40c2:b0:404:17cf:78fe with SMTP id z2-20020a05640240c200b0040417cf78femr2093212edb.204.1645005428334;
        Wed, 16 Feb 2022 01:57:08 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h19sm1369217edt.6.2022.02.16.01.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 01:57:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nKH3b-003B7W-9V;
        Wed, 16 Feb 2022 10:57:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 5/5] sparse-checkout: reject arguments in cone-mode
 that look like patterns
Date:   Wed, 16 Feb 2022 10:53:15 +0100
References: <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
 <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com>
 <2008542d0c718bbe43388297307a791f94bc73e1.1644985283.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <2008542d0c718bbe43388297307a791f94bc73e1.1644985283.git.gitgitgadget@gmail.com>
Message-ID: <220216.8635kjuob0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 16 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> In sparse-checkout add/set under cone mode, the arguments passed are
> supposed to be directories rather than gitignore-style patterns.
> However, given the amount of effort spent in the manual discussing
> patterns, it is easy for users to assume they need to pass patterns such
> as
>    /foo/*
> or
>    !/bar/*/
> or perhaps they really do ignore the directory rule and specify a
> random gitignore-style pattern like
>    *.c
>
> To help catch such mistakes, throw an error if any of the positional
> arguments:
>   * starts with any of '/!'
>   * contains any of '*\?[]'

But not "\" itself, we're just escaping the "?" here?...

> +	if (core_sparse_checkout_cone) {
> +		for (i = 0; i < argc; i++) {
> +			if (argv[i][0] == '/')
> +				die(_("specify directories rather than patterns (no leading slash)"));
> +			if (argv[i][0] == '!')
> +				die(_("specify directories rather than patterns.  If your directory starts with a '!', pass --skip-checks"));
> +			if (strchr(argv[i], '*') ||
> +			    strchr(argv[i], '?') ||
> +			    strchr(argv[i], '[') ||
> +			    strchr(argv[i], ']'))
> +				die(_("specify directories rather than patterns.  If your directory really has any of '*?[]' in it, pass --skip-checks"));

Isn't this nested || a reinvention of a simpler strtok() or strtok_r()
call? I.e. (untested):

	const char *p;
	const char *wildcards = "*?[]";
	if (strtok_r(argv[i], wildcards, &p))
		die(_("specify... has ony of '%s' in it...", wildcards));

That would also allow parameterizing the set of characters for
translators.
