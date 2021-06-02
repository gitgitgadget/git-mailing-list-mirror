Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DBEC4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 02:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5281610C8
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 02:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFBCCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 22:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhFBCCg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 22:02:36 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF540C06174A
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 19:00:53 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id x41-20020a05683040a9b02903b37841177eso1111398ott.9
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 19:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=vNFEYCBDPeJ2TStNmuaM5hjRWWR0iw1Cqu9xzSI0tuE=;
        b=ulbGKMdeP04yZilXBTNg4/6hcGIG0ZPmjZFnVpJO0mmyjz9JThrGuIsjRAtm8eLH6J
         fZQ1W4olSNYhtoAubLaMG8m1biwMqqmyyw9NpJkNaS1zzGYRDFtkovoKiJlc8Kxdrepl
         SaqCOTVGocg3h/GQLruiUJtf66j6aXQYcHM5n4cew328ccLuVSkoa3OGkjZUgaQlrr3v
         hd1hQVbQL2X/T4Bk7PDOoMzS/1dUQTOpe5/bFbj4HbLNT3aZPm7oGKSfb9XaOyuTwAai
         ENxHigPP5X9iDIQtjLEZ9W+0HL7uvX2e+hWAY7WbNpoxZc2kXQIzpXI/MzpLCTQvZjtz
         phQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vNFEYCBDPeJ2TStNmuaM5hjRWWR0iw1Cqu9xzSI0tuE=;
        b=UHf1EdxNBOcQzmPvk+6Ki13dQ4EatGFSL07YGvtAIukKeX9nslsKBgE7Awi2eLdzSo
         1JDCQtS/Um/XCliPgpd5i94X1i4AygElShK6jjERi7gvyNqHkAjveRQQyodbAH4zlNKc
         6mt/KoCJbHJ7y6sMuLgt/Qw6uz0PQguCD8IFkLzzVciqBG0miWtKb073NJbqxjweXYpf
         OFetJljyL1T3e7etG7TH0TiERupzHGD/6rOMg6snn51lVbPaKWvE+cKxdrdvAdG6tbUn
         xMVzwNoEr+t5Pharh6lgyq/R2q7mDSmlIEnN81ZgKs7YY4c3tFMldcGkjhwLhozz2zNP
         jBag==
X-Gm-Message-State: AOAM531HHwzv9MtfPxQX0uVbjweJqU9VQGscUVl4AVSt8Ryyd6YR7Rcj
        1qIdGijR6aKZVyafRe7jmZ/P8a6DAwYhUw==
X-Google-Smtp-Source: ABdhPJyr5ZSum9zIH6ECr3lEtmYWOsWraQFoaFKVZ7+NTn8t5lpXgSe2K5AgVhD1Xrlbxn9RSLbucA==
X-Received: by 2002:a9d:4b8a:: with SMTP id k10mr24604101otf.131.1622599252625;
        Tue, 01 Jun 2021 19:00:52 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:35fd:75aa:3890:f004? ([2600:1700:e72:80a0:35fd:75aa:3890:f004])
        by smtp.gmail.com with ESMTPSA id w6sm4114170otj.5.2021.06.01.19.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 19:00:52 -0700 (PDT)
Subject: Re: [PATCH] unpack-trees: add core.sparseCheckoutRmFiles config
To:     Tim Renouf <tpr.ll@botech.co.uk>, newren@gmail.com,
        dstolee@microsoft.com, git@vger.kernel.org
References: <20210601183106.3084008-1-tpr.ll@botech.co.uk>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f6d39636-308c-c846-55b5-3f16a155e69d@gmail.com>
Date:   Tue, 1 Jun 2021 22:00:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601183106.3084008-1-tpr.ll@botech.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/1/2021 2:31 PM, Tim Renouf wrote:
> When doing a checkout (or other index merge from a tree) causes the
> removal of a path that is outside sparse-checkout, the file is removed
> from the working tree, even if it is dirty.
> 
> That is probably what you want if the file got there by being
> materialized in a merge conflict. But it is not what you want if you
> deliberately put the file there.
> 
> This commit adds the above config item, defaulting to "true" to get the
> old behavior. Set it to "false" to avoid removing such a file from the
> worktree.

I don't think config is necessary here. This behavior is niche
enough to create a behavior-breaking change. However, we do want
to ensure that the full flow of eventually clearing the file when
clean is handled.

> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index a0eeaeb02e..31adb38b1d 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -111,6 +111,17 @@ the sparse-checkout file.
>  To repopulate the working directory with all files, use the
>  `git sparse-checkout disable` command.
>  
> +The `core.sparseCheckoutRmFiles` config setting

If we _are_ going to go with a config option, then I'm not a big
fan of this name. I've also been thinking that the sparse-checkout
config has been squatting in the "core.*" space too long. Perhaps
it is time to create its own section?

What about something like sparseCheckout.keepDirtyFiles, which
defaults to false?

Alternatively, we could add things to the index.* space. We
already have "index.sparse" for the sparse index feature. For this
topic, a config option "index.keepDirtySparseFiles" would have a
similar meaning to my other suggestion.

At the least, you would need to update the appropriate file in
Documentation/config/*.txt.

>  extern int core_apply_sparse_checkout;
>  extern int core_sparse_checkout_cone;
> +extern int core_sparse_checkout_rm_files;

These previous variables being global is unfortunate and it
might be time to fix that. At minimum, I think this new
option might be able to inject somewhere else without
running a lot of git_config_get_value() calls in a loop.

Since your changes are within unpack-trees.c, maybe adding
a flag to 'struct unpack_trees_options' would suffice. It
could be initialized in unpack_trees() so only happen once
per index update.

> +test_expect_success 'core.sparseCheckoutRmFiles checkout that would remove file outside sparse-checkout removes file from disk' '

This test name is too long. Perhaps

	'sparse-checkout removes dirty non-matching file'

> +	git config core.sparseCheckout false &&
> +	git checkout -f top &&
> +	echo added3 >added3 &&
> +	git add added3 &&
> +	git commit -madded3 &&
> +	git checkout top &&
> +	test_path_is_missing added3 &&
> +	git config core.sparseCheckout true &&
> +	git config core.sparseCheckoutRmFiles true &&
> +	echo init.t >.git/info/sparse-checkout &&

Perhaps we could use a more modern approach, such as

	git sparse-checkout init &&
	git sparse-checkout set init.t &&

(and use 'git sparse-checkout disable' at the start of the
test.)

> +	git checkout HEAD@{1} &&

I'd typically expect 'git checkout HEAD~1' instead of
using the reflog, since it is more robust to changing
the test in the future. Better even to create a new
branch earlier and then switch between named branches.

> +	test_path_is_missing added3 &&
> +	echo dirty >added3 &&

I appreciate that you confirm the file is missing before
you create it.

> +	git checkout top &&
> +	test_path_is_missing added3

Thought: does this happen also with 'git sparse-checkout
reapply'?

> +'
> +
> +test_expect_success '!core.sparseCheckoutRmFiles checkout that would remove file outside sparse-checkout does not remove file from disk' '

and here:

	'sparse-checkout keeps dirty non-matching file'

These tests are very similar. Perhaps they could be
grouped and just have a check at the end that makes
'added3' dirty and checks the behavior of 'git checkout'
with the two config settings?

> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1528,7 +1528,9 @@ static void mark_new_skip_worktree(struct pattern_list *pl,
>  
>  	/*
>  	 * 1. Pretend the narrowest worktree: only unmerged entries
> -	 * are checked out
> +	 * are checked out. If core.sparseCheckoutRmFiles is off, then
> +	 * treat a file being removed as merged, so it does not get
> +	 * removed from the worktree.
>  	 */
>  	for (i = 0; i < istate->cache_nr; i++) {
>  		struct cache_entry *ce = istate->cache[i];
> @@ -1536,7 +1538,8 @@ static void mark_new_skip_worktree(struct pattern_list *pl,
>  		if (select_flag && !(ce->ce_flags & select_flag))
>  			continue;
>  
> -		if (!ce_stage(ce) && !(ce->ce_flags & CE_CONFLICTED))
> +		if ((!ce_stage(ce) && !(ce->ce_flags & CE_CONFLICTED)) ||
> +		    ((ce->ce_flags & CE_REMOVE) && !core_sparse_checkout_rm_files))
>  			ce->ce_flags |= skip_wt_flag;
>  		else
>  			ce->ce_flags &= ~skip_wt_flag;
> @@ -1681,12 +1684,15 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  
>  	if (!o->skip_sparse_checkout) {
>  		/*
> -		 * Sparse checkout loop #2: set NEW_SKIP_WORKTREE on entries not in loop #1
> +		 * Sparse checkout loop #2: set NEW_SKIP_WORKTREE on entries not in loop #1.
> +		 * If !core.sparseCheckoutRmFiles, include files being removed so ones
> +		 * outside sparse-checkout patterns do not get removed from the worktree.
>  		 * If they will have NEW_SKIP_WORKTREE, also set CE_SKIP_WORKTREE
>  		 * so apply_sparse_checkout() won't attempt to remove it from worktree
>  		 */
> +		int mask = core_sparse_checkout_rm_files ? CE_ADDED : CE_ADDED | CE_REMOVE;
>  		mark_new_skip_worktree(o->pl, &o->result,
> -				       CE_ADDED, CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE,
> +				       mask, CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE,
>  				       o->verbose_update);

I'm a bit worried about this use of CE_REMOVE. I see its use listed in
cache-tree.c with this comment:

		/*
		 * CE_REMOVE entries are removed before the index is
		 * written to disk. Skip them to remain consistent
		 * with the future on-disk index.
		 */

This makes me think that the entries are actually not present in the
written index, which is incorrect. It will make it look like we have
staged a deletion of that file. Can you check that the output of
'git status' shows the file with no staged changes, but an unstaged
_modification_? Alternatively: the modification might be ignored since
it is a sparse entry, but we would probably want to fix that before
taking this change. If my understanding is correct*, then 'git status'
will show it as a staged deletion and an unstaged addition.

(*) This is a BIG IF.

Thank you for your interest here. Elijah is right that the area is
fraught with complexity, and I'm learning something new about it
every day as I work on my sparse-index feature. I'm still trying
to grasp the subtleties like this and their ramifications before
changing the existing behavior because I want to be _sure_ we are
moving in a more stable direction and not just another unstable
point that frustrates users.

This change seems like a focused attempt, but I think we need to
track down those other details before committing to such a change:

1. How does a user with a dirty, tracked, sparse file get back
   into a state where that file is deleted? What commands do
   they need to run? Can that be tested and added to the sparse-
   checkout documentation?

2. What does 'git status' look like when a user is in this state?
   Is that helpful?

Thanks,
-Stolee
