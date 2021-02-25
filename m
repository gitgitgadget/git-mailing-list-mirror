Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CE5C433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 02:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE986146B
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 02:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbhBYCRG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 21:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236839AbhBYCQp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 21:16:45 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE20BC06174A
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 18:16:24 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s8so4979057edd.5
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 18:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=CNCQsZC9+1u12398F6vOJJNtFyR9XLkc2fQ6zE5Cw+U=;
        b=ktQ1iaM1Hl7w809UTZqrU2VzqIkGv2UyBeoTWciqMCRKwhaDwpm+tLG5Lo6GZ4JKMc
         AagNCATNlmU7J1C0oeFs1fe7mx/aHqiO95H/+1vK5o2OrACwjMX62HGlBh8aiCs3fWDM
         L6J7R4XYb8+axqGa29MzI7RDL/0uKMv1s9DerDdwJFjswlkvu2cigc8vDWo3LZb0JVdd
         dJMqNKPKAkVUncUSU3plhbGVCM3u+epAvltruUNqBvAu3D1B5DAHTZDycsiLzlsYWdIX
         QV5HW/nYhnd+2eUCWV4x5Yt/pyac3SH+Hh7EJjoPrj062LpEE+s2hIOHP3B2xIOTKT6h
         +W9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=CNCQsZC9+1u12398F6vOJJNtFyR9XLkc2fQ6zE5Cw+U=;
        b=kG2HnWDuWkLlP+x7WbmjlKt+TXQaBIqNoiaBqhRLRAQJRt4iTcKjVsIE7TYgDBlX16
         PQ1tt9h4Bmbx4awcOZ7f32yAtDQJmtFg9O4HHy7Q+/5WPuiVbyhg1gRyFxH7zPQVC6+2
         uFLyVsBbxQ91HwLtExpPhN29z6YLEFD7DUfTHMn7kjdMAT/xCj22czcBhkpaeg0vlbkV
         DgzqHZi1/FFy/OTr3QibCCS8LDWaZopm8C2peSjz9cQ5cGM01ulVhjXhNrwNVYerJ1b2
         MRz5yCSjg/uvkUWvnMU4YIArNhMyuSpkuPjdbjNkaA0ktzbuDo9dDgIZk9HJ8U90bqIF
         plXA==
X-Gm-Message-State: AOAM532FAdhdOGN5C8eCkeFni0N2fmmUDgP61DxKpPuas/yrHcL0/ZP0
        PVjn6UaC5qzLeRQzxyrTNwi7nYS10YWx5g==
X-Google-Smtp-Source: ABdhPJyGNfpev8SC54ukYLCIrUnGRvc22+VGH18fb6eCcBmEe2RwNq5pytdpR9gONgN/3xpU/xV2Og==
X-Received: by 2002:aa7:c7c3:: with SMTP id o3mr769966eds.8.1614219383234;
        Wed, 24 Feb 2021 18:16:23 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p19sm1791068edr.57.2021.02.24.18.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 18:16:22 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 04/10] diffcore-rename: extend cleanup_dir_rename_info()
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
        <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
        <f7bdad78219de6819d0403f8957e9a0c8b4218bc.1614123848.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <f7bdad78219de6819d0403f8957e9a0c8b4218bc.1614123848.git.gitgitgadget@gmail.com>
Date:   Thu, 25 Feb 2021 03:16:22 +0100
Message-ID: <87v9ag7uyx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 24 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> [...]
>  MAYBE_UNUSED
> -static void cleanup_dir_rename_info(struct dir_rename_info *info)
> +static void cleanup_dir_rename_info(struct dir_rename_info *info,
> +				    struct strset *dirs_removed,
> +				    int keep_dir_rename_count)
>  {
> +	struct hashmap_iter iter;
> +	struct strmap_entry *entry;
> +
>  	if (!info->setup)
>  		return;
>  
> -	partial_clear_dir_rename_count(info->dir_rename_count);
> -	strmap_clear(info->dir_rename_count, 1);
> +	if (!keep_dir_rename_count) {
> +		partial_clear_dir_rename_count(info->dir_rename_count);
> +		strmap_clear(info->dir_rename_count, 1);
> +		FREE_AND_NULL(info->dir_rename_count);
> +	} else {
> +		/*
> +		 * Although dir_rename_count was passed in
> +		 * diffcore_rename_extended() and we want to keep it around and
> +		 * return it to that caller, we first want to remove any data
> +		 * associated with directories that weren't renamed.
> +		 */
> +		struct string_list to_remove = STRING_LIST_INIT_NODUP;
> +		int i;
> +
> [...]

I find the pattern in patch 02 and 03 and leading up to this 04/05
confusing to review.

First we add a clear_dir_rename_count() in 02 but nothing uses it, then
in 03 it's renamed to cleanup_dir_rename_info() and its code changed,
but still nothing uses it. Here we're changing the function nothing
uses, and then finally in 05 we make use of it, and the MAYBE_UNUSED
attribute is removed.

I appreciate trying to split these large and complex patches into more
digestible pieces. I think that sometimes it's more readable to have a
patch that adds a function and a subsequent one that uses it.

But in this case where we've gone through stages of changing code that's
never been used I think we're making it harder to read than not. I'd
prefer just to see this cleanup_dir_rename_info() function pop into
existence in 05.

Just my 0.02.

Style nit/preference: I think code like this is easier to read as:

    if (simple-case) {
        blah
        blah;
        return;
    }
    complex_case;

Than not having the "return" and having most of the interesting logic in
an indented "else" block. Or maybe just this on top of the whole thing
(a -w diff, hopefully more readable, but still understandable):
    
    diff --git a/diffcore-rename.c b/diffcore-rename.c
    index 70a484b9b6..5a5c62ec79 100644
    --- a/diffcore-rename.c
    +++ b/diffcore-rename.c
    @@ -609,11 +609,12 @@ void partial_clear_dir_rename_count(struct strmap *dir_rename_count)
     }
     
     static void cleanup_dir_rename_info(struct dir_rename_info *info,
    -				    struct strset *dirs_removed,
    -				    int keep_dir_rename_count)
    +				    struct strset *dirs_removed)
     {
     	struct hashmap_iter iter;
     	struct strmap_entry *entry;
    +	struct string_list to_remove = STRING_LIST_INIT_NODUP;
    +	int i;
     
     	if (!info->setup)
     		return;
    @@ -624,20 +625,12 @@ static void cleanup_dir_rename_info(struct dir_rename_info *info,
     	/* dir_rename_guess */
     	strmap_clear(&info->dir_rename_guess, 1);
     
    -	if (!keep_dir_rename_count) {
    -		partial_clear_dir_rename_count(info->dir_rename_count);
    -		strmap_clear(info->dir_rename_count, 1);
    -		FREE_AND_NULL(info->dir_rename_count);
    -	} else {
     	/*
     	 * Although dir_rename_count was passed in
     	 * diffcore_rename_extended() and we want to keep it around and
     	 * return it to that caller, we first want to remove any data
     	 * associated with directories that weren't renamed.
     	 */
    -		struct string_list to_remove = STRING_LIST_INIT_NODUP;
    -		int i;
    -
     	strmap_for_each_entry(info->dir_rename_count, &iter, entry) {
     		const char *source_dir = entry->key;
     		struct strintmap *counts = entry->value;
    @@ -653,7 +646,6 @@ static void cleanup_dir_rename_info(struct dir_rename_info *info,
     			      to_remove.items[i].string, 1);
     	string_list_clear(&to_remove, 0);
     }
    -}
     
     static const char *get_basename(const char *filename)
     {
    @@ -1317,7 +1309,13 @@ void diffcore_rename_extended(struct diff_options *options,
     		if (rename_dst[i].filespec_to_free)
     			free_filespec(rename_dst[i].filespec_to_free);
     
    -	cleanup_dir_rename_info(&info, dirs_removed, dir_rename_count != NULL);
    +	if (!dir_rename_count) {
    +		cleanup_dir_rename_info(&info, dirs_removed);
    +	} else {
    +		partial_clear_dir_rename_count(info.dir_rename_count);
    +		strmap_clear(info.dir_rename_count, 1);
    +		FREE_AND_NULL(info.dir_rename_count);
    +	}
     	FREE_AND_NULL(rename_dst);
     	rename_dst_nr = rename_dst_alloc = 0;
     	FREE_AND_NULL(rename_src);

I also wonder if that strmap_clear() wouldn't be better moved into
partial_clear_dir_rename_count():
    
    diff --git a/diffcore-rename.c b/diffcore-rename.c
    index 5a5c62ec790..5f6c5745d64 100644
    --- a/diffcore-rename.c
    +++ b/diffcore-rename.c
    @@ -596,7 +596,8 @@ static void initialize_dir_rename_info(struct dir_rename_info *info,
     	}
     }
     
    -void partial_clear_dir_rename_count(struct strmap *dir_rename_count)
    +void partial_clear_dir_rename_count(struct strmap *dir_rename_count,
    +				    int clear_strmap)
     {
     	struct hashmap_iter iter;
     	struct strmap_entry *entry;
    @@ -606,6 +607,9 @@ void partial_clear_dir_rename_count(struct strmap *dir_rename_count)
     		strintmap_clear(counts);
     	}
     	strmap_partial_clear(dir_rename_count, 1);
    +	if (clear_strmap)
    +		strmap_clear(dir_rename_count, 1);
    +
     }
     
     static void cleanup_dir_rename_info(struct dir_rename_info *info,
    @@ -1312,8 +1316,7 @@ void diffcore_rename_extended(struct diff_options *options,
     	if (!dir_rename_count) {
     		cleanup_dir_rename_info(&info, dirs_removed);
     	} else {
    -		partial_clear_dir_rename_count(info.dir_rename_count);
    -		strmap_clear(info.dir_rename_count, 1);
    +		partial_clear_dir_rename_count(info.dir_rename_count, 1);
     		FREE_AND_NULL(info.dir_rename_count);
     	}
     	FREE_AND_NULL(rename_dst);
    diff --git a/diffcore.h b/diffcore.h
    index c6ba64abd19..de8667bfa04 100644
    --- a/diffcore.h
    +++ b/diffcore.h
    @@ -161,7 +161,8 @@ struct diff_filepair *diff_queue(struct diff_queue_struct *,
     				 struct diff_filespec *);
     void diff_q(struct diff_queue_struct *, struct diff_filepair *);
     
    -void partial_clear_dir_rename_count(struct strmap *dir_rename_count);
    +void partial_clear_dir_rename_count(struct strmap *dir_rename_count,
    +				    int clear_strmap);
     
     void diffcore_break(struct repository *, int);
     void diffcore_rename(struct diff_options *);
    diff --git a/merge-ort.c b/merge-ort.c
    index 467404cc0a3..0bbd49f0d78 100644
    --- a/merge-ort.c
    +++ b/merge-ort.c
    @@ -353,9 +353,9 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
     	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; ++i) {
     		strset_func(&renames->dirs_removed[i]);
     
    -		partial_clear_dir_rename_count(&renames->dir_rename_count[i]);
    -		if (!reinitialize)
    -			strmap_clear(&renames->dir_rename_count[i], 1);
    +		partial_clear_dir_rename_count(&renames->dir_rename_count[i],
    +					       !reinitialize);
    +		free(&renames->dir_rename_count[i]);
     
     		strmap_func(&renames->dir_renames[i], 0);
     	}
    
