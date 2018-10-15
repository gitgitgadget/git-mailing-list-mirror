Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF8141F453
	for <e@80x24.org>; Mon, 15 Oct 2018 02:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbeJOKOo (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 06:14:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33608 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeJOKOo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 06:14:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id e4-v6so19410242wrs.0
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 19:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bQYO6C7OnPDmnRY6cvHy+W/nIa6iUm5sWmwHbVF265U=;
        b=RcpZDxgNchAjhjksuGJdPO++OgC6HWVjH+99UVKl8BB4EfS9UbA9gLbEHmVYA0KxIx
         vN1Zo7s7zAx841YPfLDQNM8ImcntRu8cYW+BhwM/mJP9shxOQ5DMH5zBEylIsbzwwRJS
         YvrT81s1kZPL3gjUYH4Y6VmIzBhssMS6UmVDHYZFop/b1LS/p6BTUy3FItGouzoFbWt8
         cgchw+8/6BnRQXusve3dYRD8Jgab9SusJM9W9FGsLMpw1gIXmKhxD79A7DPvEujSqt7o
         NzCPkbULuk3k45umENC551S1DyUKp6oRtKbMEFA54sZUvwNMs36mzbEB0i26KxU1Hw2a
         TwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bQYO6C7OnPDmnRY6cvHy+W/nIa6iUm5sWmwHbVF265U=;
        b=R8rdmAJdTFHwwUKiI4p+CxIPHK6bMZyjqYLya/XNaBy78wcFA+USoLwmqCjbU45rJB
         azRde6mobXK//cs2VyF/S/mJn221giFn2XiYRYdOsgAmyVO/qiQ0pLzC6PXs4zj4ZJma
         Ej2gxOIKtH5I4GibKo4Uuj+8sEFoxz3LTag/QeYOpMdQLanB1j0h18TIHc8wjIQQh5KO
         rBWXMynQLHIJTlnBmUa21k1/syEhyaQIJ+2mkoUASm7Bw+ywzoClFLRw7NysweWuiChH
         hEiamqlihuignb9p3xtOKXutQJDrOtnpHoiO35Q75GWhZVzv8JlKYarKlImm1BZpa1yr
         3SkQ==
X-Gm-Message-State: ABuFfogVDi80yLHjtRrw9GsuV28VehqpMruLiseD7xoQbzEuVpEpWMbE
        lvwxR6UhUJK4YCAx+h57das=
X-Google-Smtp-Source: ACcGV60o4CHAhMmZ/DUlSLlczXT12ihnhZYfn5VosYmnHsHkR8eA2vJeKtidts7QXVUIhWVy7f6K/g==
X-Received: by 2002:a5d:6707:: with SMTP id o7-v6mr13137884wru.326.1539570692389;
        Sun, 14 Oct 2018 19:31:32 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b2-v6sm6081199wru.51.2018.10.14.19.31.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Oct 2018 19:31:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: Re: [RFC PATCH 3/3] list-objects-filter: teach tree:# how to handle >0
References: <cover.1539298957.git.matvore@google.com>
        <e340f743e6749e65525e1342dc47faaa6540f04b.1539298957.git.matvore@google.com>
Date:   Mon, 15 Oct 2018 11:31:30 +0900
In-Reply-To: <e340f743e6749e65525e1342dc47faaa6540f04b.1539298957.git.matvore@google.com>
        (Matthew DeVore's message of "Thu, 11 Oct 2018 16:09:02 -0700")
Message-ID: <xmqqlg706iv1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> The long-term goal at the end of this is to allow a partial clone to
> eagerly fetch an entire directory of files by fetching a tree and
> specifying <depth>=1. This, for instance, would make a build operation
> fast and convenient

This would reduce round-trip, as you do not have to fetch the tree
to see what its contents are before issuing another set of fetches
for them.  Those who are building virtual filesystem that let you
mount a specific tree object, perhaps via fuse, may find it useful,
too, even though I suspect that may not be your primary focus.

> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index c2c1c40e6..c78985c41 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -734,8 +734,12 @@ specification contained in <path>.
>  +
>  The form '--filter=tree:<depth>' omits all blobs and trees whose depth
>  from the root tree is >= <depth> (minimum depth if an object is located
> -at multiple depths in the commits traversed). Currently, only <depth>=0
> -is supported, which omits all blobs and trees.
> +at multiple depths in the commits traversed). <depth>=0 will not include
> +any trees or blobs unless included explicitly in <object>. <depth>=1

Here, <object> refers to the objects directly requested on the
command line (or --stdin)?  Triggering this question from me is a
sign that this description may want to say a bit more to avoid the
same question from the real readers.  Perhaps replace "included
explicitly in <object>" with "explicitly requested by listing them
on the command line or feeding them with `--stdin`", or something
like that?

> diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> index e8da2e858..9dc61d6e6 100644
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@ -50,12 +50,12 @@ static int gently_parse_list_objects_filter(
>  		}
>  
>  	} else if (skip_prefix(arg, "tree:", &v0)) {
> -		unsigned long depth;
> -		if (!git_parse_ulong(v0, &depth) || depth != 0) {
> +		if (!git_parse_ulong(v0,
> +				     &filter_options->tree_depth_limit_value)) {
>  			if (errbuf) {
>  				strbuf_addstr(
>  					errbuf,
> -					_("only 'tree:0' is supported"));
> +					_("expected 'tree:<int>'"));

We do not accept "tree:-1", even though "-1" is an int.  Is it too
obvious to worry about?  I do not think we want to say tree:<uint>
even if we do want to make it clear we reject "tree:-1"

I am wondering if "expected 'tree:<depth>'" would work better.

> diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
> index af64e5c66..c1ae70cd8 100644
> --- a/list-objects-filter-options.h
> +++ b/list-objects-filter-options.h
> @@ -44,6 +44,7 @@ struct list_objects_filter_options {
>  	struct object_id *sparse_oid_value;
>  	char *sparse_path_value;
>  	unsigned long blob_limit_value;
> +	unsigned long tree_depth_limit_value;
>  };

This change gets it right by adding "depth" in the field name and it
is not a comment on this patch, but someday not in too distant
future we should rename the "blob_limit_value" to make it clear that
it is filtering by number of bytes, as other filtering criteria on
blobs that can be expressed in ulong are quite possible.

> -static enum list_objects_filter_result filter_trees_none(
> +static enum list_objects_filter_result filter_trees_depth(
>  	enum list_objects_filter_situation filter_situation,
>  	struct object *obj,
>  	const char *pathname,
>  	const char *filename,
>  	void *filter_data_)
>  {
> -	struct filter_trees_none_data *filter_data = filter_data_;
> +	struct filter_trees_depth_data *filter_data = filter_data_;
> +
> +	int too_deep = filter_data->current_depth >= filter_data->max_depth;

Does max mean "maximum allowed", or "this and anything larger are
rejected".  The latter sound wrong, but I offhand do not know if
your current_depth counts from 0 or 1, so there may not be
off-by-one.

 - dir.c::within_depth() that is used by pathspec matching that in turn
   is used by "grep --max-depth=1" does "if (depth > max_depth)", which
   sounds more in line with the usual convention, I would think.

 - pack-objects has max_delta_cache_size, which also is used as
   "maximum allowed", not "this is already too big".  So is its
   max_depth.

There may be other examples.  One existing violator I noticed was
the "reject blobs that is this size or larger" in this file; it is
called "max_bytes", but it is apparently not "maximum allowed",
which we probably would want to fix.

> +	/*
> +	 * Note that we do not use _MARK_SEEN in order to allow re-traversal in
> +	 * case we encounter a tree or blob again at a shallower depth.
> +	 */

Hmph.  Earlier tree:0 support never even read the actual tree, so
this was not a problem.  We wouldn't have found a tree in deeper
places first and then at a shallower depth, as we wouldn't have seen
any tree in any depth deeper than the surface anyway.

Now we need to worry about a tree that originally gets seen in a
deeper depth (that is still below the allowed maximum) to reappear
at a shallower place, so a subtree within it that used to be too
deep may now be within the allowed maximum depth.

Step 1 of these three patches made sure trees are not even opened
under "tree:0", so it was not just optimizing/shrinking the output
of rev-list but also optimizing the traversal.  When we are
collecting omits, however, this one now returns _ZERO which means we
still traverse into the tree, even under "tree:0"?  I must be
reading the code incorrectly (in general, when we are seeing a tree
object that itself is at the maximum allowed depth, trees found by
reading its contents will never become eligible for output, even if
they are found at a shallower depth than their other copies were
previously found, I would think).

>  	switch (filter_situation) {
>  	default:
>  		BUG("unknown filter_situation: %d", filter_situation);
>  
> -	case LOFS_BEGIN_TREE:
>  	case LOFS_BLOB:
> +		if (!too_deep) goto include_it;

Style: on two lines, like you did below for the next if() statement.

> +
> +		if (filter_data->omits)
> +			oidset_insert(filter_data->omits, &obj->oid);
> +
> +		return LOFR_ZERO;
> +
> +	case LOFS_BEGIN_TREE:
> +		filter_data->current_depth++;
> +
> +		if (!too_deep) goto include_it;
> +
>  		if (filter_data->omits) {
>  			oidset_insert(filter_data->omits, &obj->oid);
> -			/* _MARK_SEEN but not _DO_SHOW (hard omit) */
> -			return LOFR_MARK_SEEN;
> +			return LOFR_ZERO;
>  		}
>  		else
>  			/*
>  			 * Not collecting omits so no need to to traverse tree.
>  			 */
> -			return LOFR_SKIP_TREE | LOFR_MARK_SEEN;
> +			return LOFR_SKIP_TREE;
>  
>  	case LOFS_END_TREE:
>  		assert(obj->type == OBJ_TREE);
> +		filter_data->current_depth--;
>  		return LOFR_ZERO;
>  
>  	}
> +
> +include_it:
> +	if (filter_data->omits)
> +		oidset_remove(filter_data->omits, &obj->oid);
> +	return LOFR_MARK_SEEN | LOFR_DO_SHOW;
>  }
