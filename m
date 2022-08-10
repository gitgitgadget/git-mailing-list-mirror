Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D609FC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 15:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbiHJPD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 11:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbiHJPD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 11:03:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134EF760C8
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:03:56 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l22so18081044wrz.7
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=bhKcSLf6N9IXz1VsaqDwcfxPWsQVedlsBBpJI2yqbt8=;
        b=EtydBj2vXdVgsluys9yb/1P8PP6MGJI0s78MWdKIcDY1TmZynqyKrw+6il3474L8Qh
         EQ7yNCinQSEH6cvD0xiLbT6mkHd0VgqSs3+lQBxC4sbeqJL7gblgGVDfxTQf2cj8hIWN
         eI+Nce9IGbhjNaWj8Ql2f3OuX0gG5rFUYAGJudEWmM7ulLOggRraUP8wSqtEJatasejL
         HBwMItLRzaEwy83auNPiT9h6zArF5A9xu/8vA7Gqy0dVqsfJjoQUCuDyf0JrfPZE5mKP
         5D/DljzFuqHIW0H+tPqCOwQImIJEr3y3pB1+mLb+7JObd0aVj4/VtTnQWnT+rDkRqouc
         uGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=bhKcSLf6N9IXz1VsaqDwcfxPWsQVedlsBBpJI2yqbt8=;
        b=V1imKdmtxCzwEQ3xXp7cLgcoFsBH07TsEs+pM00rKou6MQCTikJYIHjKxkn5Cv6Jhb
         h+7UQokGrEHS6+qMJe19MrHc5Tkl2DTX2AtzKnpjkAcNsmQVdzIIqvc+9HyiRMzDjMM9
         ni3MlX9ACLyzjcHu2dGn6T4p+r/FrlZJLgxhRPd+YofNr6qGKXAFcqG7LnGcSNyWdDGk
         f2hKsRTbHmi2jDkdxwZXCivDhfDQKEsWjIVdrsP3t4Eb7WcgRL73ncamEE5w5gwt7+ZU
         k96kRSld+YzChm490RCTyQ8Coja1GtzL4WOQdAnql62VXkN2tkvX2ZgSYhvwzBE0lq75
         OIWQ==
X-Gm-Message-State: ACgBeo3qk8EtjlGTaV6Dfn2v5KvBtn2Gdy0I8fDkY10f1ZXZYUunHjWv
        f19HN3q6SNSJhFvpNZNAa9zrvTEO+bo=
X-Google-Smtp-Source: AA6agR4qTVteYon8WJPOamUGQCYF9JbsDpJeQvxCB464tbCIyEiX6JASYMqcvYmvK3SOHkJlGyOCHQ==
X-Received: by 2002:a5d:6acb:0:b0:21e:efd7:c7be with SMTP id u11-20020a5d6acb000000b0021eefd7c7bemr17842351wrw.293.1660143834513;
        Wed, 10 Aug 2022 08:03:54 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id f3-20020a5d50c3000000b0021d76a1b0e3sm16276288wrt.6.2022.08.10.08.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 08:03:53 -0700 (PDT)
Message-ID: <08ea1eec-58fb-cbfa-d405-0d4159c99515@gmail.com>
Date:   Wed, 10 Aug 2022 16:03:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 08/14] merge-resolve: rewrite in C
Content-Language: en-GB-large
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20210317204939.17890-1-alban.gruin@gmail.com>
 <20220809185429.20098-1-alban.gruin@gmail.com>
 <20220809185429.20098-9-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220809185429.20098-9-alban.gruin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 09/08/2022 19:54, Alban Gruin wrote:
> This rewrites `git merge-resolve' from shell to C.  As for `git
> merge-one-file', this port is not completely straightforward and removes
> calls to external processes to avoid reading and writing the index over
> and over again.
> 
>   - The call to `update-index -q --refresh' is replaced by a call to
>     refresh_index().
> 
>   - The call to `read-tree' is replaced by a call to unpack_trees() (and
>     all the setup needed).
> 
>   - The call to `write-tree' is replaced by a call to
>     cache_tree_update().  This call is wrapped in a new function,
>     write_tree().  It is made to mimick write_index_as_tree() with
>     WRITE_TREE_SILENT flag, but without locking the index; this is taken
>     care directly in merge_strategies_resolve().
> 
>   - The call to `diff-index ...' is replaced by a call to
>     repo_index_has_changes().
> 
>   - The call to `merge-index', needed to invoke `git merge-one-file', is
>     replaced by a call to the new merge_all_index() function.
> 
> The index is read in cmd_merge_resolve(), and is wrote back by
> merge_strategies_resolve().  This is to accomodate future applications:
> in `git-merge', the index has already been read when the merge strategy
> is called, so it would be redundant to read it again when the builtin
> will be able to use merge_strategies_resolve() directly.
> 
> The parameters of merge_strategies_resolve() will be surprising at first
> glance: why using a commit list for `bases' and `remote', where we could
> use an oid array, and a pointer to an oid?  Because, in a later commit,
> try_merge_strategy() will be able to call merge_strategies_resolve()
> directly, and it already uses a commit list for `bases' (`common') and
> `remote' (`remoteheads'), and a string for `head_arg'.  To reduce
> frictions later, merge_strategies_resolve() takes the same types of
> parameters.

git-merge-resolve will happily merge three trees, unfortunately using 
lists of commits will break that.

> merge_strategies_resolve() locks the index only once, at the beginning
> of the merge, and releases it when the merge has been completed.
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
> diff --git a/builtin/merge-resolve.c b/builtin/merge-resolve.c
> new file mode 100644
> index 0000000000..a51158ebf8
> --- /dev/null
> +++ b/builtin/merge-resolve.c
> @@ -0,0 +1,63 @@
> +/*
> + * Builtin "git merge-resolve"
> + *
> + * Copyright (c) 2020 Alban Gruin
> + *
> + * Based on git-merge-resolve.sh, written by Linus Torvalds and Junio C
> + * Hamano.
> + *
> + * Resolve two trees, using enhanced multi-base read-tree.
> + */
> +
> +#include "cache.h"
> +#include "builtin.h"
> +#include "merge-strategies.h"
> +
> +static const char builtin_merge_resolve_usage[] =
> +	"git merge-resolve <bases>... -- <head> <remote>";
> +
> +int cmd_merge_resolve(int argc, const char **argv, const char *prefix)
> +{
> +	int i, sep_seen = 0;
> +	const char *head = NULL;
> +	struct commit_list *bases = NULL, *remote = NULL;
> +	struct commit_list **next_base = &bases;
> +	struct repository *r = the_repository;
> +
> +	if (argc < 5)
> +		usage(builtin_merge_resolve_usage);

I think it would be better to call parse_options() and then check argc. 
That would give better error messages for unknown options and supports 
'-h' for free.

I think we also need to call git_config(). I see that read-tree respects 
submodule.recurse so I think we need the same here. I suspect we should 
also be reading the merge config to respect merge.conflictStyle.

> +	setup_work_tree();
> +	if (repo_read_index(r) < 0)
> +		die("invalid index");

This should probably be marked for translation.

> +
> +	/*
> +	 * The first parameters up to -- are merge bases; the rest are
> +	 * heads.
> +	 */
> +	for (i = 1; i < argc; i++) {
> +		if (!strcmp(argv[i], "--"))
> +			sep_seen = 1;
> +		else if (!strcmp(argv[i], "-h"))
> +			usage(builtin_merge_resolve_usage);
> +		else if (sep_seen && !head)
> +			head = argv[i];
> +		else {
> +			struct object_id oid;
> +			struct commit *commit;
> +
> +			if (get_oid(argv[i], &oid))
> +				die("object %s not found.", argv[i]);

translation here as well.

> +			commit = oideq(&oid, r->hash_algo->empty_tree) ?
> +				NULL : lookup_commit_or_die(&oid, argv[i]);

As I said above, git-merge-resolve should be callable with trees I think.

> +
> +			if (sep_seen)
> +				commit_list_insert(commit, &remote);
> +			else
> +				next_base = commit_list_append(commit, next_base);
> +		}
> +	}
> +
> +	return merge_strategies_resolve(r, bases, head, remote);
> +}
> diff --git a/merge-strategies.c b/merge-strategies.c
> index 373b69c10b..30f225ae5f 100644
> --- a/merge-strategies.c
> +++ b/merge-strategies.c
> @@ -1,9 +1,34 @@
>   #include "cache.h"
> +#include "cache-tree.h"
>   #include "dir.h"
>   #include "entry.h"
> +#include "lockfile.h"
>   #include "merge-strategies.h"
> +#include "unpack-trees.h"
>   #include "xdiff-interface.h"
>   
> +static int check_index_is_head(struct repository *r, const char *head_arg)
> +{
> +	struct commit *head_commit;
> +	struct tree *head_tree;
> +	struct object_id head;
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	get_oid(head_arg, &head);
> +	head_commit = lookup_commit_reference(r, &head);
> +	head_tree = repo_get_commit_tree(r, head_commit);

Can this all be replaced by a call to parse_tree_indirect(), we should 
also handle an invalid HEAD.

> +
> +	if (repo_index_has_changes(r, head_tree, &sb)) {
> +		error(_("Your local changes to the following files "
> +			"would be overwritten by merge:\n  %s"),
> +		      sb.buf);

This matches the script but I wonder why that did not check for unstaged 
changes.


> +int merge_strategies_resolve(struct repository *r,
> +			     struct commit_list *bases, const char *head_arg,

As well as the commit vs tree comments above I think that we should be 
getting the callers to parse head rather than passing a string. Both 
builtin/merge.c and sequencer.c have a struct commit we can use.

> +			     struct commit_list *remote)
> +{
> +	struct tree_desc t[MAX_UNPACK_TREES];
> +	struct commit_list *i;
> +	struct lock_file lock = LOCK_INIT;
> +	int nr = 0, ret = 0;
> +
> +	/* Abort if index does not match head */
> +	if (check_index_is_head(r, head_arg))
> +		return 2;
> +
> +	/*
> +	 * Give up if we are given two or more remotes.  Not handling
> +	 * octopus.
> +	 */
> +	if (remote && remote->next)
> +		return 2;
> +
> +	/* Give up if this is a baseless merge. */
> +	if (!bases)
> +		return 2;
> +
> +	puts(_("Trying simple merge."));
> +
> +	for (i = bases; i && i->item; i = i->next) {
> +		if (add_tree(repo_get_commit_tree(r, i->item), t + (nr++)))

This needs to check that we're not overrunning the end of t as 
builtin/read-tree.c:list_trees() does.


Except for the tree issue the conversion of the script looks correct to 
me and you have been careful to preserve the exit values.

Best Wishes

Phillip

> +			return 2;
> +	}
> +
> +	if (head_arg) {
> +		struct object_id head;
> +		struct tree *tree;
> +
> +		get_oid(head_arg, &head);
> +		tree = parse_tree_indirect(&head);
> +
> +		if (add_tree(tree, t + (nr++)))
> +			return 2;
> +	}
> +
> +	if (remote && add_tree(repo_get_commit_tree(r, remote->item), t + (nr++)))
> +		return 2;
> +
> +	repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
> +
> +	if (merge_trees(r, t, nr, 1)) {
> +		rollback_lock_file(&lock);
> +		return 2;
> +	}
> +
> +	if (write_tree(r)) {
> +		puts(_("Simple merge failed, trying Automatic merge."));
> +		ret = merge_all_index(r->index, 1, 0, merge_one_file_func, NULL);
> +	}
> +
> +	if (write_locked_index(r->index, &lock, COMMIT_LOCK))
> +		return !!error(_("unable to write new index file"));
> +	return !!ret;
> +}
> diff --git a/merge-strategies.h b/merge-strategies.h
> index 8705a550ca..bba4bf999c 100644
> --- a/merge-strategies.h
> +++ b/merge-strategies.h
> @@ -1,6 +1,7 @@
>   #ifndef MERGE_STRATEGIES_H
>   #define MERGE_STRATEGIES_H
>   
> +#include "commit.h"
>   #include "object.h"
>   
>   int merge_three_way(struct index_state *istate,
> @@ -28,4 +29,8 @@ int merge_index_path(struct index_state *istate, int oneshot, int quiet,
>   int merge_all_index(struct index_state *istate, int oneshot, int quiet,
>   		    merge_fn fn, void *data);
>   
> +int merge_strategies_resolve(struct repository *r,
> +			     struct commit_list *bases, const char *head_arg,
> +			     struct commit_list *remote);
> +
>   #endif /* MERGE_STRATEGIES_H */
