Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AC3C63705
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 22:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiLGWeT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 17:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGWeS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 17:34:18 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C00CFD
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 14:34:17 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id s5so26870712edc.12
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 14:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8fngCtuMxJnGW05iXuRF5fK6SJuSpEbCuc+/JP4objs=;
        b=f/L3b/p/yNStMituhOBWMMY2B1BNnCZaTxNQd2xYuF9nv021h53cW9yWSw8tqOSEgk
         bbwryUlAGjg1mbBDmSNyZBWoquLbocwmPB1zK6eA1uLHah2e3MyZ367o0hbDIEHfPwGu
         wGC3gFU4ZcqPqGuvRnvE3X6BmLclKu/W6F7LRCOIisO4L55HhcfzXIRsRWpXMVCQ267g
         aUtj7pZlx5suL9cY8m0ueRZTAEpqDV5Z8ENNZbnge26pH6SzFOSP0FqS/IfrGczEML5I
         QRMLLtOEWd25DCEv05shuO2ZypIHf/Q0wSFilfp6YxmjWIyLsV062Njx8eBWXQ89m68P
         co1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fngCtuMxJnGW05iXuRF5fK6SJuSpEbCuc+/JP4objs=;
        b=D6qsGEu7or7bvRW20TWOIAruMNhGxD7NmpKDDqZe5jXlWhY3CjVH+Q8+kBdmUsH7MB
         hm0E+kR1xbyQ4rgR9T7oHxcdYecNOCv+icypPptAy1s2aIJCbqf3rSlFQZcQ0gySxFyy
         X/s7S2I9YPgMVixXWQo3DoeVPbe05Wniw1PREnKfwd6x5PzrgViaKYS6wWeqoitZPhOR
         twi11nA2vrNqeajLqm2Ky0p/plv29UT6lHYHdvzGehBwq20PmwYmLA2NJLp2j9HjnuWP
         8RGkNK1MRKpyByoPQsvZLQpxjJLY3m0ZpOO3MDBPebT9hI4UAjHU0C9wnim/vDZ7OH9x
         qkbg==
X-Gm-Message-State: ANoB5pne52/jZS+FQIvcqxB3SNtrr5ov2vcX7pZ/RJX7Y0owfbsHewq/
        iBHIpsGGkZRSMbYUlFgn5a1j2DMVcpmr4A==
X-Google-Smtp-Source: AA0mqf7TYyojsVEMTjYhxV9R4pR4Pq8kQNFe/GG3Id358/2O43spgKwjdxUatNa9zUYCnKKaeiBkvQ==
X-Received: by 2002:a05:6402:e06:b0:461:9764:15f0 with SMTP id h6-20020a0564020e0600b00461976415f0mr1082629edh.38.1670452455682;
        Wed, 07 Dec 2022 14:34:15 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id y7-20020aa7ce87000000b0045c3f6ad4c7sm2713071edv.62.2022.12.07.14.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:34:15 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p32zU-004cmL-2D;
        Wed, 07 Dec 2022 23:34:12 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 4/4] features: feature.manyFiles implies fast index writes
Date:   Wed, 07 Dec 2022 23:30:04 +0100
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
 <77bf5d5ff27729a39ac00d52af3c09610d733b14.1670433958.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <77bf5d5ff27729a39ac00d52af3c09610d733b14.1670433958.git.gitgitgadget@gmail.com>
Message-ID: <221207.86v8mm972z.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 07 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
> [...]
> diff --git a/read-cache.c b/read-cache.c
> index fb4d6fb6387..1844953fba7 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2923,12 +2923,13 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>  	int ieot_entries = 1;
>  	struct index_entry_offset_table *ieot = NULL;
>  	int nr, nr_threads;
> -	int skip_hash;
>  
>  	f = hashfd(tempfile->fd, tempfile->filename.buf);
>  
> -	if (!git_config_get_maybe_bool("index.skiphash", &skip_hash))
> -		f->skip_hash = skip_hash;
> +	if (istate->repo) {
> +		prepare_repo_settings(istate->repo);
> +		f->skip_hash = istate->repo->settings.index_skip_hash;
> +	}

Urm, are we ever going to find ourselves in a situation where:

 * We have read the settings for the_repository
 * We have an index we're about to write out as our "main index", but
   the istate->repo *isn't* the_repository.
 * Even then, wouldn't the two copies of the repos have read the same
   repo settings?

But maybe there's a really obvious submodule / worktree / whatever edge
case I'm missing.

But if not, shouldn't we just always read/write this from
the_repository?

> +		rm -f .git/index &&
> +		git -c feature.manyFiles=true \
> +		    -c index.skipHash=false add a &&
> +		test_trailing_hash .git/index >hash &&
> +		! test_cmp expect hash

We had a parallel thread where we discussed "! test_cmp" being an
anti-pattern, i.e. you want them not to be the same, but you want it to
still show a diff, Maybe just "! cmp" ?

I.e. either the diff will be meaningless, or we really should be
asserting the actual value we want, not what it shouldn't be.

so in this case, shouldn't we assert that it's the 0000... value, or the
actual hash (depending on which way around we're testing this)?
