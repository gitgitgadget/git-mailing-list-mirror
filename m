Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47434C433E0
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 10:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16D8A208C7
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 10:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/RtyfJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgFZKNZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 06:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgFZKNY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 06:13:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888E1C08C5C1
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 03:13:24 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k6so8947070wrn.3
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 03:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gtGHXyLnCgdNyvwrXrx3M6EVMihtnAw0r85hSWYvpr4=;
        b=O/RtyfJZh76Cll7xmfvcF7GXZPFPTMrE+MQ8AL4d4Ab0TMOIKoYFZytRLQOeiXKrTf
         g1wAicGMOzv7XPJN1EzyCqoxE0Mu9Z8ZKlTjvZ1k7KwYUaFLutiMpcJ/jCtN8obfGMcX
         4lcBgsW3ng4LC/pc7mB6f1I29SwAUJwHkrkyrpKdviKnvpIze43dO0uztk8KUqB2meAT
         BuUhh1zI7BRcYlqsTB5NDIm0mxmgUzWJIw8tYBFiwe0Ab2EeZz9vT5i8/2n0//QZhPCI
         HuidK0ySoUUTAmyp75DPcghBthJLQmgA019nzB+voi1+NX78adm1iN0W5jic5F+lW9YV
         kDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gtGHXyLnCgdNyvwrXrx3M6EVMihtnAw0r85hSWYvpr4=;
        b=N8aglPGJL4zQ+ZeRMIPYzgAbijLkRLnyVn3QtRYbpjdU9wlOA+c0AzJs0HiOlZ/UqH
         fy2/t9ptla8YcLskvbfbhHd1WXM00rmDYBg6hp0jV5xeiQFvV2PxjlB4YuKRPlpD+5/H
         Eu9Zh4GSKEeCQPrh3Bo4M3aK+g67KmM+5pYK2UxSz/tUjNy86pE4zVoNVEpjg/V5Mrf5
         vN3/UPnu6Hts14YdXhqEYesTs/rQM1wT+LlfvdfqImwwyfbawtoGssPJfTY28IBpxU1V
         Tnl5rV8ep5WiEli/7tnm26OnpEGmNE0h9Fs7iYT/HoaUiNkAAyHU6dDfpl3BLxMzoVUX
         fFNw==
X-Gm-Message-State: AOAM530ekpda6jL28yP/MeqdpjGY4vMHg/lU9KOtKiaWULaMoZ6ofeto
        XbDxxQ+T4hbxRI3hK8DiA9aMymEz
X-Google-Smtp-Source: ABdhPJzZiMtt/eIAmgchMaeRWGZR9nk4dd9F2yGUxxLvc4czGiHTGANpU93gmWYBOQ8vnMjrtNirAg==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr2902275wrm.82.1593166403002;
        Fri, 26 Jun 2020 03:13:23 -0700 (PDT)
Received: from [192.168.1.201] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.googlemail.com with ESMTPSA id s18sm39350617wra.85.2020.06.26.03.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 03:13:22 -0700 (PDT)
Subject: Re: [RFC PATCH v1 06/17] merge-index: libify merge_one_path() and
 merge_all()
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
 <20200625121953.16991-7-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0e20fa12-4628-d1fe-fc6e-df83d26edda3@gmail.com>
Date:   Fri, 26 Jun 2020 11:13:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625121953.16991-7-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 25/06/2020 13:19, Alban Gruin wrote:
> The "resolve" and "octopus" merge strategies do not call directly `git
> merge-one-file', they delegate the work to another git command, `git
> merge-index', that will loop over files in the index and call the
> specified command.  Unfortunately, these functions are not part of
> libgit.a, which means that once rewritten, the strategies would still
> have to invoke `merge-one-file' by spawning a new process first.
> 
> To avoid this, this moves merge_one_path(), merge_all(), and their
> helpers to merge-strategies.c.  They also take a callback to dictate
> what they should do for each file.  For now, only one launching a new
> process is defined to preserve the behaviour of the builtin version.
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
> 
> Notes:
>     This patch is best viewed with `--color-moved'.
> 
>  builtin/merge-index.c | 77 +++------------------------------
>  merge-strategies.c    | 99 +++++++++++++++++++++++++++++++++++++++++++
>  merge-strategies.h    | 17 ++++++++
>  3 files changed, 123 insertions(+), 70 deletions(-)
> 
> diff --git a/builtin/merge-index.c b/builtin/merge-index.c
> index 38ea6ad6ca..6cb666cc78 100644
> --- a/builtin/merge-index.c
> +++ b/builtin/merge-index.c
> @@ -1,74 +1,11 @@
>  #define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "builtin.h"
> -#include "run-command.h"
> -
> -static const char *pgm;
> -static int one_shot, quiet;
> -static int err;
> -
> -static int merge_entry(int pos, const char *path)
> -{
> -	int found;
> -	const char *arguments[] = { pgm, "", "", "", path, "", "", "", NULL };
> -	char hexbuf[4][GIT_MAX_HEXSZ + 1];
> -	char ownbuf[4][60];
> -
> -	if (pos >= active_nr)
> -		die("git merge-index: %s not in the cache", path);
> -	found = 0;
> -	do {
> -		const struct cache_entry *ce = active_cache[pos];
> -		int stage = ce_stage(ce);
> -
> -		if (strcmp(ce->name, path))
> -			break;
> -		found++;
> -		oid_to_hex_r(hexbuf[stage], &ce->oid);
> -		xsnprintf(ownbuf[stage], sizeof(ownbuf[stage]), "%o", ce->ce_mode);
> -		arguments[stage] = hexbuf[stage];
> -		arguments[stage + 4] = ownbuf[stage];
> -	} while (++pos < active_nr);
> -	if (!found)
> -		die("git merge-index: %s not in the cache", path);
> -
> -	if (run_command_v_opt(arguments, 0)) {
> -		if (one_shot)
> -			err++;
> -		else {
> -			if (!quiet)
> -				die("merge program failed");
> -			exit(1);
> -		}
> -	}
> -	return found;
> -}
> -
> -static void merge_one_path(const char *path)
> -{
> -	int pos = cache_name_pos(path, strlen(path));
> -
> -	/*
> -	 * If it already exists in the cache as stage0, it's
> -	 * already merged and there is nothing to do.
> -	 */
> -	if (pos < 0)
> -		merge_entry(-pos-1, path);
> -}
> -
> -static void merge_all(void)
> -{
> -	int i;
> -	for (i = 0; i < active_nr; i++) {
> -		const struct cache_entry *ce = active_cache[i];
> -		if (!ce_stage(ce))
> -			continue;
> -		i += merge_entry(i, ce->name)-1;
> -	}
> -}
> +#include "merge-strategies.h"
>  
>  int cmd_merge_index(int argc, const char **argv, const char *prefix)
>  {
> -	int i, force_file = 0;
> +	int i, force_file = 0, err = 0, one_shot = 0, quiet = 0;
> +	const char *pgm;
>  
>  	/* Without this we cannot rely on waitpid() to tell
>  	 * what happened to our children.
> @@ -98,14 +35,14 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
>  				continue;
>  			}
>  			if (!strcmp(arg, "-a")) {
> -				merge_all();
> +				err |= merge_all(&the_index, one_shot, quiet,
> +						 merge_program_cb, (void *)pgm);
>  				continue;
>  			}
>  			die("git merge-index: unknown option %s", arg);
>  		}
> -		merge_one_path(arg);
> +		err |= merge_one_path(&the_index, one_shot, quiet, arg,
> +				      merge_program_cb, (void *)pgm);
>  	}
> -	if (err && !quiet)
> -		die("merge program failed");
>  	return err;
>  }
> diff --git a/merge-strategies.c b/merge-strategies.c
> index 3a9fce9f22..f4c0b4acd6 100644
> --- a/merge-strategies.c
> +++ b/merge-strategies.c
> @@ -1,6 +1,7 @@
>  #include "cache.h"
>  #include "dir.h"
>  #include "merge-strategies.h"
> +#include "run-command.h"
>  #include "xdiff-interface.h"
>  
>  static int add_to_index_cacheinfo(struct index_state *istate,
> @@ -189,3 +190,101 @@ int merge_strategies_one_file(struct repository *r,
>  
>  	return 0;
>  }
> +
> +int merge_program_cb(const struct object_id *orig_blob,
> +		     const struct object_id *our_blob,
> +		     const struct object_id *their_blob, const char *path,
> +		     unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
> +		     void *data)

Using void* is slightly unfortunate but it's needed later.

It would be nice to check if the program to run is git-merge-one-file
and call the appropriate function instead in that case so all users of
merge-index get the benefit of it being builtin. That probably wants to
be done in cmd_merge_index() rather than here though.

> +{
> +	char ownbuf[3][60] = {{0}};

I know this is copied from above but it would be better to use
GIT_MAX_HEXSZ rather than 60

> +	const char *arguments[] = { (char *)data, "", "", "", path,
> +				    ownbuf[0], ownbuf[1], ownbuf[2],
> +				    NULL };
> +
> +	if (orig_blob)
> +		arguments[1] = oid_to_hex(orig_blob);
> +	if (our_blob)
> +		arguments[2] = oid_to_hex(our_blob);
> +	if (their_blob)
> +		arguments[3] = oid_to_hex(their_blob);
> +
> +	xsnprintf(ownbuf[0], sizeof(ownbuf[0]), "%o", orig_mode);
> +	xsnprintf(ownbuf[1], sizeof(ownbuf[1]), "%o", our_mode);
> +	xsnprintf(ownbuf[2], sizeof(ownbuf[2]), "%o", their_mode);

These are leaked. Also are you sure we want to fill out the mode if the
corresponding blob is missing - I guess it doesn't matter but it would
be good to check that - i think the original passed "". It also passed
"" rather than "0000..." for the blobs that were missing I think.

Best Wishes

Phillip

> +
> +	return run_command_v_opt(arguments, 0);
> +}
> +
> +static int merge_entry(struct index_state *istate, int quiet, int pos,
> +		       const char *path, merge_cb cb, void *data)
> +{
> +	int found = 0;
> +	const struct object_id *oids[3] = {NULL};
> +	unsigned int modes[3] = {0};
> +
> +	do {
> +		const struct cache_entry *ce = istate->cache[pos];
> +		int stage = ce_stage(ce);
> +
> +		if (strcmp(ce->name, path))
> +			break;
> +		found++;
> +		oids[stage - 1] = &ce->oid;
> +		modes[stage - 1] = ce->ce_mode;
> +	} while (++pos < istate->cache_nr);
> +	if (!found)
> +		return error(_("%s is not in the cache"), path);
> +
> +	if (cb(oids[0], oids[1], oids[2], path, modes[0], modes[1], modes[2], data)) {
> +		if (!quiet)
> +			error(_("Merge program failed"));
> +		return -2;
> +	}
> +
> +	return found;
> +}
> +
> +int merge_one_path(struct index_state *istate, int oneshot, int quiet,
> +		   const char *path, merge_cb cb, void *data)
> +{
> +	int pos = index_name_pos(istate, path, strlen(path)), ret;
> +
> +	/*
> +	 * If it already exists in the cache as stage0, it's
> +	 * already merged and there is nothing to do.
> +	 */
> +	if (pos < 0) {
> +		ret = merge_entry(istate, quiet, -pos - 1, path, cb, data);
> +		if (ret == -1)
> +			return -1;
> +		else if (ret == -2)
> +			return 1;
> +	}
> +	return 0;
> +}
> +
> +int merge_all(struct index_state *istate, int oneshot, int quiet,
> +	      merge_cb cb, void *data)
> +{
> +	int err = 0, i, ret;
> +	for (i = 0; i < istate->cache_nr; i++) {
> +		const struct cache_entry *ce = istate->cache[i];
> +		if (!ce_stage(ce))
> +			continue;
> +
> +		ret = merge_entry(istate, quiet, i, ce->name, cb, data);
> +		if (ret > 0)
> +			i += ret - 1;
> +		else if (ret == -1)
> +			return -1;
> +		else if (ret == -2) {
> +			if (oneshot)
> +				err++;
> +			else
> +				return 1;
> +		}
> +	}
> +
> +	return err;
> +}
> diff --git a/merge-strategies.h b/merge-strategies.h
> index b527d145c7..cf78d7eaf4 100644
> --- a/merge-strategies.h
> +++ b/merge-strategies.h
> @@ -10,4 +10,21 @@ int merge_strategies_one_file(struct repository *r,
>  			      unsigned int orig_mode, unsigned int our_mode,
>  			      unsigned int their_mode);
>  
> +typedef int (*merge_cb)(const struct object_id *orig_blob,
> +			const struct object_id *our_blob,
> +			const struct object_id *their_blob, const char *path,
> +			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
> +			void *data);
> +
> +int merge_program_cb(const struct object_id *orig_blob,
> +		     const struct object_id *our_blob,
> +		     const struct object_id *their_blob, const char *path,
> +		     unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
> +		     void *data);
> +
> +int merge_one_path(struct index_state *istate, int oneshot, int quiet,
> +		   const char *path, merge_cb cb, void *data);
> +int merge_all(struct index_state *istate, int oneshot, int quiet,
> +	      merge_cb cb, void *data);
> +
>  #endif /* MERGE_STRATEGIES_H */
> 

