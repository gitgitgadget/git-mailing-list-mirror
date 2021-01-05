Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5E7C433E0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 15:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A64422C9D
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 15:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbhAEP7u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 10:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbhAEP7u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 10:59:50 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BC7C061574
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 07:59:09 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id l14so14859103qvh.2
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 07:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nDasrqqB80YdZaxTZAPdTOE+xEJY7j+gX6pk4ILV7YE=;
        b=tEjbg6q8leRgZIEBPryDLh2GagCyYqWxfFfsA8iFAmu22/xTYo7e6dWOZR0JXXbZ4O
         q2qJSRL6G+kl1W7YxOTOyOU4xXz0zBFSiXqPTWcViXFl8borcNvsyX7HfeBHoNfRMfmb
         wnczK8LptqMe9IqgXnuzU7s9wV7YaUG/mO55ZrXUzlWy5PIuaHmES5p7nevKB1aYwesX
         prK0666dtbG2yomOaTdeS6PgYDmM+fOsd5OnacgkCPqrdmcMyCvsHzXtfipz5sRLTQUX
         nDEitSPWSEkNVNjp/yiMMcK261CkYLYhDhppGnTn67JaP6OdeWvx+OL6DyHZ2Koroi3k
         hG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nDasrqqB80YdZaxTZAPdTOE+xEJY7j+gX6pk4ILV7YE=;
        b=YQuZPatQI0zaqrhZWnaE0OwLacOOzy3/JLE2axq3B7KuT6Lun1FiZla+usse5mqkUi
         X62VNw0lf59jLqX0bcIlpmOUu/CBRn5nIfV4WvElg4lNUg5NIjnF2jnpGhzWTyMcyssg
         +p3zv2quT69ihv24ITP7OQUWvKJs/rhUet/JPey1TJsrhbfDDajLVkDcJ+Sho88WXDv2
         XVX7O6iH3TZfShjChUq6LoiY/cdhhW5CutZvwl4EohlkCtVTU4RMnQv0iuyno06Pge0o
         KB7SjW6NN9tuez1/cxyM9ona8IwexB057uZSlXpOCGakN7V/rdWOXp4ZXjGbHJraiJp+
         QNSg==
X-Gm-Message-State: AOAM531A8uG7DioW568GLyp6g7tiMRdKpOrujKkDVeGKDFP7F3TSPSJk
        Wq1s7gtP4eQ2RqC2yhuHDlE=
X-Google-Smtp-Source: ABdhPJyC4B2yzDlBXVn+BwM224mu819/Y2b3tiA4u5SndwKcndXqPV9G/3VEK+YlZZPDuJC9qAO3Bg==
X-Received: by 2002:a05:6214:c4a:: with SMTP id r10mr41756qvj.60.1609862348860;
        Tue, 05 Jan 2021 07:59:08 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id g18sm73429qtv.79.2021.01.05.07.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:59:08 -0800 (PST)
Subject: Re: [PATCH v6 05/13] merge-index: libify merge_one_path() and
 merge_all()
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <20201116102158.8365-1-alban.gruin@gmail.com>
 <20201124115315.13311-1-alban.gruin@gmail.com>
 <20201124115315.13311-6-alban.gruin@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2ff7cebf-0084-aef8-bf82-d76a82be23e7@gmail.com>
Date:   Tue, 5 Jan 2021 10:59:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20201124115315.13311-6-alban.gruin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/24/2020 6:53 AM, Alban Gruin wrote:
> The "resolve" and "octopus" merge strategies do not call directly `git
> merge-one-file', they delegate the work to another git command, `git
> merge-index', that will loop over files in the index and call the
> specified command.  Unfortunately, these functions are not part of
> libgit.a, which means that once rewritten, the strategies would still
> have to invoke `merge-one-file' by spawning a new process first.

This is a good thing to do.
 
> To avoid this, this moves and renames merge_one_path(), merge_all(), and
> their helpers to merge-strategies.c.  They also take a callback to
> dictate what they should do for each file.  For now, to preserve the
> behaviour of `merge-index', only one callback, launching a new process,
> is defined.

I don't think the callback should be in libgit.a, though. The callback
itself should be a static method inside builtin/merge-index.c.

> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  builtin/merge-index.c |  77 +++----------------------------
>  merge-strategies.c    | 104 ++++++++++++++++++++++++++++++++++++++++++
>  merge-strategies.h    |  19 ++++++++
>  3 files changed, 130 insertions(+), 70 deletions(-)
> 
> diff --git a/builtin/merge-index.c b/builtin/merge-index.c
> index 38ea6ad6ca..d5e5713b25 100644
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
> +				err |= merge_all_index(the_repository, one_shot, quiet,
> +						       merge_one_file_spawn, (void *)pgm);

This hunk makes it look like pgm is uninitialized, but it is set earlier
in cmd_merge_index() (previously referring to the global instance). Good.

> +int merge_one_file_spawn(struct repository *r,
> +			 const struct object_id *orig_blob,
> +			 const struct object_id *our_blob,
> +			 const struct object_id *their_blob, const char *path,
> +			 unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
> +			 void *data)
> +{
> +	char oids[3][GIT_MAX_HEXSZ + 1] = {{0}};
> +	char modes[3][10] = {{0}};
> +	const char *arguments[] = { (char *)data, oids[0], oids[1], oids[2],
> +				    path, modes[0], modes[1], modes[2], NULL };
> +
> +	if (orig_blob) {
> +		oid_to_hex_r(oids[0], orig_blob);
> +		xsnprintf(modes[0], sizeof(modes[0]), "%06o", orig_mode);
> +	}
> +
> +	if (our_blob) {
> +		oid_to_hex_r(oids[1], our_blob);
> +		xsnprintf(modes[1], sizeof(modes[1]), "%06o", our_mode);
> +	}
> +
> +	if (their_blob) {
> +		oid_to_hex_r(oids[2], their_blob);
> +		xsnprintf(modes[2], sizeof(modes[2]), "%06o", their_mode);
> +	}
> +
> +	return run_command_v_opt(arguments, 0);
> +}

Yes, this would be better in the builtin code. Better to keep the meaning
of 'data' clear in the context of that file.

> +static int merge_entry(struct repository *r, int quiet, unsigned int pos,
> +		       const char *path, int *err, merge_fn fn, void *data)
> +{
> +	int found = 0;
> +	const struct object_id *oids[3] = {NULL};
> +	unsigned int modes[3] = {0};
> +
> +	do {
> +		const struct cache_entry *ce = r->index->cache[pos];
> +		int stage = ce_stage(ce);
> +
> +		if (strcmp(ce->name, path))
> +			break;
> +		found++;
> +		oids[stage - 1] = &ce->oid;
> +		modes[stage - 1] = ce->ce_mode;
> +	} while (++pos < r->index->cache_nr);
> +	if (!found)
> +		return error(_("%s is not in the cache"), path);
> +
> +	if (fn(r, oids[0], oids[1], oids[2], path,
> +	       modes[0], modes[1], modes[2], data)) {
> +		if (!quiet)
> +			error(_("Merge program failed"));
> +		(*err)++;
> +	}
> +
> +	return found;
> +}
> +
> +int merge_index_path(struct repository *r, int oneshot, int quiet,
> +		     const char *path, merge_fn fn, void *data)
> +{
> +	int pos = index_name_pos(r->index, path, strlen(path)), ret, err = 0;
> +
> +	/*
> +	 * If it already exists in the cache as stage0, it's
> +	 * already merged and there is nothing to do.
> +	 */
> +	if (pos < 0) {
> +		ret = merge_entry(r, quiet || oneshot, -pos - 1, path, &err, fn, data);
> +		if (ret == -1)
> +			return -1;
> +		else if (err)
> +			return 1;
> +	}
> +	return 0;
> +}
> +
> +int merge_all_index(struct repository *r, int oneshot, int quiet,
> +		    merge_fn fn, void *data)
> +{
> +	int err = 0, ret;
> +	unsigned int i;
> +
> +	for (i = 0; i < r->index->cache_nr; i++) {
> +		const struct cache_entry *ce = r->index->cache[i];
> +		if (!ce_stage(ce))
> +			continue;
> +
> +		ret = merge_entry(r, quiet || oneshot, i, ce->name, &err, fn, data);
> +		if (ret > 0)
> +			i += ret - 1;
> +		else if (ret == -1)
> +			return -1;
> +
> +		if (err && !oneshot)
> +			return 1;
> +	}
> +
> +	return err;
> +}

I notice that these methods don't actually use the repository pointer
more than they just use 'r->index'. Should they instead take a
'struct index_state *istate' directly? (I see that the repository is
used later by merge_strategies_resolve(), but not in these.)

If you think it likely that we will need a repository for these methods,
then feel free to ignore me and keep your 'r' pointer.

Thanks,
-Stolee
