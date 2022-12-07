Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC49C4708D
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 22:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiLGW1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 17:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiLGW1m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 17:27:42 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4BD3880
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 14:27:40 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ud5so17365150ejc.4
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 14:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z8tv+Bf1Z2FMzT3YErFOFlrdfetvyoJM7C0knhAP8hg=;
        b=qIqD7ea9AInFQRV3bof/co9MIgFSchdBue35zodODdqk2mPCMEwTf6o9Qpyw700Som
         RQmoTQ5vn7FWVuvflBtIJjpnch1rybusanz+Sb9vCUs3apAg8ojpFJanx4jyjo/aWUr/
         vqf6hkRK758qk4RgQdjEYHPwbrCS8stFGP9KCWKo/io8UVmGCvpl8TCyLMMj/bvFNAz1
         kijW62Obtd1S+W0b85LbxFj7Vr5IMTU0zzN77fP1ulRKRPWQqWcXZ5JPCO8EVP3xF7P3
         Y5V9+yyo+oLbEgbvO2RAy9aIftDg6xK3lbLMY370XVlghzCUVUGTowPujOQ0AaocL77b
         qfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8tv+Bf1Z2FMzT3YErFOFlrdfetvyoJM7C0knhAP8hg=;
        b=P8mpWF5qGPO+U/45QzDGvtoP8s9GgjugxGD0A+bYO507XJ9gORJ/HirS5L+NCes7T6
         xjjXo3HI453ntpjHEKoqzz0C9fpZ9lZ7LxM6utSeQv45Dwohtj7YGfbHolXKEWGebcFl
         ovfJHB+Xb4y0bWFHpmkqEeu+nIj2b0ZqCGVPSlVvkknKV+U3zCcR946BTKP9R/S9U+2Y
         pkKi90Hk0Ae9+7Z6uiQXJdRFHxrnhy+wg4IKdzInOxlfQecWYW+LER4GP2SjFWwjjqxD
         Pzvp4AENyklzNk5/olctDtPFUSKh8L8VnAHx2vrG4ti6wFYQJdKrpJ8R1o8Rbza8QjRO
         kCOw==
X-Gm-Message-State: ANoB5pmSSPRNlwkOHURqf0ppo97Wt+IPe2FLLEi6Z0jSsoR4orca/Gsh
        3dsOdF5k1KgHaQ0NE89nbX4BujxqB0i0pw==
X-Google-Smtp-Source: AA0mqf7AkX9RRhK9yZWP9TlzIiIPYgPS2b2iQ+mw6fJOAI7uO6CIu6gr4Dj6vcw3/qWDZxI9y/yCtA==
X-Received: by 2002:a17:906:1594:b0:7b2:757a:1411 with SMTP id k20-20020a170906159400b007b2757a1411mr725114ejd.9.1670452058649;
        Wed, 07 Dec 2022 14:27:38 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090623e900b007bf24b8f80csm8996480ejg.63.2022.12.07.14.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:27:38 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p32t5-004cX8-2j;
        Wed, 07 Dec 2022 23:27:35 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/4] read-cache: add index.skipHash config option
Date:   Wed, 07 Dec 2022 23:25:06 +0100
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
 <5fb4b5a36ac806f3ee07a614bcb93df2c430507c.1670433958.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <5fb4b5a36ac806f3ee07a614bcb93df2c430507c.1670433958.git.gitgitgadget@gmail.com>
Message-ID: <221207.864ju6alyg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 07 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
> [...]
> diff --git a/read-cache.c b/read-cache.c
> index 46f5e497b14..fb4d6fb6387 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1817,6 +1817,8 @@ static int verify_hdr(const struct cache_header *hdr, unsigned long size)
>  	git_hash_ctx c;
>  	unsigned char hash[GIT_MAX_RAWSZ];
>  	int hdr_version;
> +	unsigned char *start, *end;
> +	struct object_id oid;
>  
>  	if (hdr->hdr_signature != htonl(CACHE_SIGNATURE))
>  		return error(_("bad signature 0x%08x"), hdr->hdr_signature);
> @@ -1827,10 +1829,16 @@ static int verify_hdr(const struct cache_header *hdr, unsigned long size)
>  	if (!verify_index_checksum)
>  		return 0;
>  
> +	end = (unsigned char *)hdr + size;
> +	start = end - the_hash_algo->rawsz;
> +	oidread(&oid, start);
> +	if (oideq(&oid, null_oid()))
> +		return 0;

It's good to see this use the existing hashing support, as I suggested
in the RFC comments. Glad it helped.

>  	int ieot_entries = 1;
>  	struct index_entry_offset_table *ieot = NULL;
>  	int nr, nr_threads;
> +	int skip_hash;

You don't need this variable.
>  
>  	f = hashfd(tempfile->fd, tempfile->filename.buf);
>  
> +	if (!git_config_get_maybe_bool("index.skiphash", &skip_hash))
> +		f->skip_hash = skip_hash;

Because this can just be:

	git_config_get_maybe_bool("index.skiphash", &f->skip_hash);

I.e. the config API guarantees that it won't touch the variable if the
key doesn't exist, so no need for the intermediate variable.

In a later commit you convert this to that very API use when moving this
to the repo-settings.

Can we maybe skip straight to that step?

> +test_expect_success 'index.skipHash config option' '
> +	(
> +		rm -f .git/index &&
> +		git -c index.skipHash=true add a &&
> +		git fsck
> +	)

Why the subshell?
