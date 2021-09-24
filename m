Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF0DC433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 11:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3362C61164
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 11:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245504AbhIXMAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 08:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245466AbhIXMAu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 08:00:50 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C565C061574
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 04:59:17 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ee50so35164179edb.13
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 04:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Te5e9LNmiqfz3ts+DRlNTgsPnGemGZ3+Rv22IOCETBk=;
        b=NYC6iQEiL3R1wq+Rm0q7OeJ/I12hwQxcUMS1xrZhTigihgsiFKEava9UVS0zJnwi3W
         p3BDM548Rt3Mw8Na3Lrx1GLLwME12sVJnfzKnpR1RvJRBghFjQkfrF0gCyxb2VSHXip7
         6yL4GtFFKqD/nJZ3lqrlUA02UdIX2m8s2W5KotG+yxMATKHeYjatiFYTi0FERE8OSUg1
         NEZlEoCu3dJpJ7nZBozgm7J/Wftu5ge5FN7rClorP+DVThEj5pYu5seKltHF8nJ6h4hB
         eiwXwbaMEnro1gKxmIzvGMoHKVNlw2z8nZxVUs04fTqYXF4C8TtEX8X7tvZnHcRcmv94
         uyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Te5e9LNmiqfz3ts+DRlNTgsPnGemGZ3+Rv22IOCETBk=;
        b=Xw1VF83ufNRJzPv+ZLM9usL0l0aMw+PAZbO+IOrz7nijQl+3LokQhPlxZdRxGzgtbJ
         bGvv9qhAgF7mmmSKeKJPuwo49bNhJs//Bl8GUaGDUdRiKh1+q8cf3vp0MAt5Y1RPWUeS
         uzhscMDB2/xkDzq5W0is8ZIM7A4S6c8msG5/FUMrlZWdj+MTGFQZDJdB9UXXCdgXA5gN
         T9QaUkckPl+sPex5ZEjJHQaIyQ1gYGBr/uff2ie475janoaBWkVkL+QSaUb48U1bwXDT
         +dBOzNMPkD58PwQC15icHK2dW/RSMxDakWcyrRBN7poDKkAp2CGCZr6EZwgCGhPzTG4f
         uRhA==
X-Gm-Message-State: AOAM531cVJUc55Iyit/SdyOnt6iwBBfEKe/J9Usu36w2JiGQM9ZX79Lu
        AQsGAPOJ4Iga0dArv6vpdtB5SFBbLtQNgw==
X-Google-Smtp-Source: ABdhPJzyptxLaVrT0nt8KVZevLcHvIqMwhsT1K9+ADLu5cP+35D7VtKYklyPdNP9klbVkngItAlxqg==
X-Received: by 2002:a50:e187:: with SMTP id k7mr2172676edl.190.1632484755441;
        Fri, 24 Sep 2021 04:59:15 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id dh16sm5764424edb.63.2021.09.24.04.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 04:59:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 08/19] reftable: reading/writing blocks
Date:   Fri, 24 Sep 2021 13:52:28 +0200
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
 <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
 <97f7ee04886d573f6b0f2e0d54a853cf016e7d74.1631213265.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <97f7ee04886d573f6b0f2e0d54a853cf016e7d74.1631213265.git.gitgitgadget@gmail.com>
Message-ID: <87wnn62nhp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 09 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> The reftable format is structured as a sequence of block. Within a block,
> records are prefix compressed, with an index of offsets for fully expand keys to
> enable binary search within blocks.
> [...]
> +	if (typ == BLOCK_TYPE_LOG) {
> +		int block_header_skip = 4 + header_off;
> +		uLongf dst_len = sz - block_header_skip; /* total size of dest
> +							    buffer. */
> +		uLongf src_len = block->len - block_header_skip;
> +		/* Log blocks specify the *uncompressed* size in their header.
> +		 */
> +		uint8_t *uncompressed = reftable_malloc(sz);
> +
> +		/* Copy over the block header verbatim. It's not compressed. */
> +		memcpy(uncompressed, block->data, block_header_skip);
> +
> +		/* Uncompress */
> +		if (Z_OK !=
> +		    uncompress2(uncompressed + block_header_skip, &dst_len,
> +				block->data + block_header_skip, &src_len)) {
> +			reftable_free(uncompressed);
> +			return REFTABLE_ZLIB_ERROR;
> +		}
> +
> +		if (dst_len + block_header_skip != sz)
> +			return REFTABLE_FORMAT_ERROR;
> +
> +		/* We're done with the input data. */
> +		reftable_block_done(block);
> +		block->data = uncompressed;
> +		block->len = sz;
> +		block->source = malloc_block_source();
> +		full_block_size = src_len + block_header_skip;

I haven't tried to re-implement this, but in 07/19 we're adding an
uncompress2() fallaback function, and here's the only place where it'll
get used.

Looking at the uncompress2() implementation isn't this a rather trivial
wrapper for something we'd get from git.git's zlib.c, i.e. you seem to
just need the "avail_in" here, which we're checking in various other
parts of the codebase.

I suspect that the reason for this is that this code is trying to keep
at arms length from the rest of git.git, but if so some ifdef here if
it's compiling in git.git seems better than having a compat interface in
git.git just for doing something its zlib.c API provides.

Anyway, re Junio's ask if this is ready for "next" in the latest What's
Cooking I don't think this should be a blocker, just wondering if
anyone's interested in some post-cleanup at some point, and whether I'm
missing something about uncompress2() v.s. zlib.c.
