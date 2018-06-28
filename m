Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35AD51F516
	for <e@80x24.org>; Thu, 28 Jun 2018 18:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967828AbeF1SnK (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 14:43:10 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45720 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966933AbeF1SnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 14:43:09 -0400
Received: by mail-wr0-f194.google.com with SMTP id u7-v6so6488642wrn.12
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 11:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7CHJ0i1+hnS+gb6NMsm2556r26E14XecQVVt4Lz5r4M=;
        b=Rnr4tM8Uc1KMv9QoxDDEX/QgNLS1BSrqwssppdwR8m37rVES9l9cg84tAkNkzWZ/4M
         3jYdRuTiLJrWm1ILhRO5IIjSl+SLSqYUWMPhB/tgGyKdNTkFy4iU/YL1jr+eanTyyRb0
         GIq6noggOnMmZFerbPFjryoj6TmwaG3xL6e933DknqQR/sZLFv+R6ZVxYsSRJo5D0xN1
         gD45OK7dZtxPngzC6EZhMYG7dDbb21ISW6C1bAXjfHQNfKWdhPYH66O2X7Sso8l5q4h8
         uGkMApC2ZwXsz3hloQ6k1BPCIipqcYvVGvrXYNIYPFdtsABhejsQtydnjK2l3l0EpBYL
         d9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7CHJ0i1+hnS+gb6NMsm2556r26E14XecQVVt4Lz5r4M=;
        b=tIex5MynsK2ZeJYBP3FMv5DWbSBgxfxJCNVZzl8P+AU3dTvYAqWK8DD6hP97U3RqZu
         n0YLunuZv5SriiZH5olMwieav4a2tcKlyzhbLN2KZJocNktgphm2ykkUMQp1lZoIC8cf
         PrKbeNmmv215hNn4jyQ0zzaR0J59QOzewpVtrSuAftNW2SQUhqMNNzKiuL+cQIqmQlOq
         ow7C4MKDxBwFhR+BxncfCTpVmv1mblwredgA0aEVM1NN3YmMIkuNsRMsfmDI11sc87x5
         HgdWC6hxi9ryKFMEJDjX/GJdac0G+AW1NwX6iNb5XpNDYJEfEuV8Jc1cZQdhKE5Q2Zei
         e8cQ==
X-Gm-Message-State: APt69E1f5OK+9wXsHBOSpxq9JkMOBeAcjauyKMdBG23gsybhb3oNR/Df
        v8yy0GAvx1kN64T4YaOZEmA=
X-Google-Smtp-Source: AAOMgpfxGeZVFlPdKKJ3Nb0oE8T1NOtdFqErDsiD04Wy2hyx06M8Ao6Eum0QHLInEfrOIkiHoggU6A==
X-Received: by 2002:adf:8e89:: with SMTP id q9-v6mr7822795wrb.261.1530211387688;
        Thu, 28 Jun 2018 11:43:07 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 132-v6sm13508717wmr.33.2018.06.28.11.43.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 11:43:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jameson Miller <jamill@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "jonathantanmy\@google.com" <jonathantanmy@google.com>,
        "pclouds\@gmail.com" <pclouds@gmail.com>,
        "peartben\@gmail.com" <peartben@gmail.com>,
        "peff\@peff.net" <peff@peff.net>,
        "sbeller\@google.com" <sbeller@google.com>
Subject: Re: [PATCH v5 3/8] block alloc: add lifecycle APIs for cache_entry structs
References: <20180620201557.77155-1-jamill@microsoft.com>
        <20180628135932.225288-1-jamill@microsoft.com>
        <20180628135932.225288-4-jamill@microsoft.com>
Date:   Thu, 28 Jun 2018 11:43:06 -0700
In-Reply-To: <20180628135932.225288-4-jamill@microsoft.com> (Jameson Miller's
        message of "Thu, 28 Jun 2018 14:00:09 +0000")
Message-ID: <xmqqsh56wy4l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jameson Miller <jamill@microsoft.com> writes:

> Add an API around managing the lifetime of cache_entry
> structs. Abstracting memory management details behind this API will
> allow for alternative memory management strategies without affecting
> all the call sites.  This commit does not change how memory is
> allocated or freed. A later commit in this series will allocate cache
> entries from memory pools as appropriate.
>
> Motivation:
> It has been observed that the time spent loading an index with a large
> number of entries is partly dominated by malloc() calls. This change
> is in preparation for using memory pools to reduce the number of
> malloc() calls made when loading an index.

Not worth a reroll, but having these four lines at the very
beginning, dropping the line "Motivation:", and then following that
with "Add an API around ..." as the second paragraph, would make the
above easier to read, without stutter-causing "Motivation:" in the
middle.

> diff --git a/apply.c b/apply.c
> index 8ef975a32d..8a4a4439bc 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -4092,12 +4092,12 @@ static int build_fake_ancestor(struct apply_state *state, struct patch *list)
>  			return error(_("sha1 information is lacking or useless "
>  				       "(%s)."), name);
>  
> -		ce = make_cache_entry(patch->old_mode, &oid, name, 0, 0);
> +		ce = make_cache_entry(&result, patch->old_mode, &oid, name, 0, 0);
>  		if (!ce)
>  			return error(_("make_cache_entry failed for path '%s'"),
>  				     name);
>  		if (add_index_entry(&result, ce, ADD_CACHE_OK_TO_ADD)) {
> -			free(ce);
> +			discard_cache_entry(ce);
>  			return error(_("could not add %s to temporary index"),
>  				     name);
>  		}

So..., even though it wasn't clear in the proposed log message, two
large part of the lifecycle management API is (1) make_cache_entry()
knows for which istate it is creating the entry and (2) discarding
the entry may not be just a simple matter of free()ing.  Both of
which makes perfect sense, but if the changes are that easily
enumeratable, it would have been nicer for readers if the commit did
so in the proposed log message.

> @@ -4424,27 +4423,26 @@ static int add_conflicted_stages_file(struct apply_state *state,
>  				       struct patch *patch)
>  {
>  	int stage, namelen;
> -	unsigned ce_size, mode;
> +	unsigned mode;
>  	struct cache_entry *ce;
>  
>  	if (!state->update_index)
>  		return 0;
>  	namelen = strlen(patch->new_name);
> -	ce_size = cache_entry_size(namelen);
>  	mode = patch->new_mode ? patch->new_mode : (S_IFREG | 0644);
>  
>  	remove_file_from_cache(patch->new_name);
>  	for (stage = 1; stage < 4; stage++) {
>  		if (is_null_oid(&patch->threeway_stage[stage - 1]))
>  			continue;
> -		ce = xcalloc(1, ce_size);
> +		ce = make_empty_cache_entry(&the_index, namelen);

... and another one in the enumeration is make_empty_cache_entry()
which is somehow different.  And the readers are forced to read its
implementation to find out how it is different, but the use of the
same discard_cache_entry() suggests that the liftime rule of an
entry allcoated by it may be similar to those created by
make_cache_entry().

> ...
>  		if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0) {
> -			free(ce);
> +			discard_cache_entry(ce);
>  			return error(_("unable to add cache entry for %s"),
>  				     patch->new_name);
>  		}

> @@ -230,11 +230,11 @@ static int checkout_merged(int pos, const struct checkout *state)
>  	if (write_object_file(result_buf.ptr, result_buf.size, blob_type, &oid))
>  		die(_("Unable to add merge result for '%s'"), path);
>  	free(result_buf.ptr);
> -	ce = make_cache_entry(mode, &oid, path, 2, 0);
> +	ce = make_transient_cache_entry(mode, &oid, path, 2);

... and then yet another, which is "transient".  An intelligent
reader can guess from the lack of istate parameter (and from the
word "transient") that the resulting one would not belong to any
in-core index.

>  	if (!ce)
>  		die(_("make_cache_entry failed for path '%s'"), path);
>  	status = checkout_entry(ce, state, NULL);
> -	free(ce);
> +	discard_cache_entry(ce);

... but discovers that it is discarded the same way, realizes that
ce knows how it was allocated to allow discard() different way to
discard it, and his/her earlier conjecture about make_empty() does
not hold at all and gets somewhat disappointed.

> diff --git a/cache.h b/cache.h
> index 3fbf24771a..035a627bea 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -339,6 +339,40 @@ extern void remove_name_hash(struct index_state *istate, struct cache_entry *ce)
>  extern void free_name_hash(struct index_state *istate);
>  
>  
> +/* Cache entry creation and cleanup */
> +
> +/*
> + * Create cache_entry intended for use in the specified index. Caller
> + * is responsible for discarding the cache_entry with
> + * `discard_cache_entry`.
> + */
> +struct cache_entry *make_cache_entry(struct index_state *istate,
> +				     unsigned int mode,
> +				     const struct object_id *oid,
> +				     const char *path,
> +				     int stage,
> +				     unsigned int refresh_options);
> +
> +struct cache_entry *make_empty_cache_entry(struct index_state *istate,
> +					   size_t name_len);
> +
> +/*
> + * Create a cache_entry that is not intended to be added to an index.
> + * Caller is responsible for discarding the cache_entry
> + * with `discard_cache_entry`.
> + */
> +struct cache_entry *make_transient_cache_entry(unsigned int mode,
> +					       const struct object_id *oid,
> +					       const char *path,
> +					       int stage);
> +
> +struct cache_entry *make_empty_transient_cache_entry(size_t name_len);

OK, finally it becomes clear that we have per-istate and transient
sets of two (i.e. one that takes the path, stage and mode pfront,
and the other that only takes the length of the name), and ...

> +/*
> + * Discard cache entry.
> + */
> +void discard_cache_entry(struct cache_entry *ce);

... a single function that knows how to discard each kind.  It would
have really helped the reader to talk about them in the proposed log
message, as they are only 5 functions.  Another way to make it easier
for readers would have been to show the diff for cache.h first before
diffs for all the others.
