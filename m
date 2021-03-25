Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07154C433DB
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 20:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6D7061A3E
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 20:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhCYUbw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 16:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhCYUb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 16:31:26 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7052C06174A
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 13:31:25 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so3213124otb.7
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 13:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/xWOspvlLpIkmLBUKD9j2nlC4jqDwyIC/blYzcMzPUY=;
        b=WhArPj22Emfo4fW4DDw+EGYKo4jqNJ6SXwbhTLh/FNeXOWiaXn/imXNvXLN1zyjO52
         CJIUsmKXXl+5sNvm5rVroFhkqe/tZMXr6NYPSTDyJoVWrNJ0979sxxaULrVVL2dZr8cj
         tJWnM28wLCmycuU+NMq+5/CWTixXLT8TFGaLT2FW21Ei9v+wT5+PJ3XQooUPClf29jQy
         ZdbcqETJyL91zGmyd40LPAsS31lgcqrgSabD8cEXSL+zWD9o9+j6HXtA4P8WHLqeFKIK
         toMCrCKtUQ0zdDuKAGutAgoITIH1UfVRNyuC5HEt4RN+z1/jsen5e568KG3KBkUdU/l4
         nWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/xWOspvlLpIkmLBUKD9j2nlC4jqDwyIC/blYzcMzPUY=;
        b=S6iJ+Qhj4wG19QBser4OeRLhAjc7OHGG/CLWnR/S3lWyK44wJ+14wCWxNLvyMSfTE0
         meS+DRP/rPon9UOwhvcxqhHAFPdE45gnzT2n+ePcWb1W6ZYL4LWzTzBSQ54uwYvWXl3e
         rZRKenUYp3IcNK3MDicdMai9r6gNJEXDVdTHOFtzV5HSvhpfMuXCglUSSjX77bDeSA7x
         vaPW1JigLmGfXuHljHj0oXQGiFtkl6wuQ0kHkCoQauaPyzqs4PXrYFw6G363Kb3tuLr/
         hZdyxbune/+KvhHQWvpQmEGbMir3ONn9/UQCphg4jMcdoarH856P5kQ6yfipgFalUjCn
         zOPw==
X-Gm-Message-State: AOAM530cLvaMHx1oldJ3So3PIJf9JU2775aeprXuESGq89QPGcmlmHcw
        blNNPbAVYtNWOBo9A7fHF3w=
X-Google-Smtp-Source: ABdhPJz0FX8MIDRmDf2llJb2MXzuU1XXo+eE33wQ+CSZsJzZI3LSUPO6GfQdvY/6FXGfm8elViiWZw==
X-Received: by 2002:a05:6830:1b69:: with SMTP id d9mr9365007ote.165.1616704285065;
        Thu, 25 Mar 2021 13:31:25 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:4fa:ce48:2457:c3ab? ([2600:1700:e72:80a0:4fa:ce48:2457:c3ab])
        by smtp.gmail.com with ESMTPSA id h12sm1684063ote.75.2021.03.25.13.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 13:31:24 -0700 (PDT)
Subject: Re: [PATCH] cache-tree.c: remove implicit dependency on
 the_repository
To:     Chinmoy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Chinmoy <chinmoy12c@gmail.com>
References: <pull.915.git.1616701733901.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f187df01-8e59-ac74-01e1-586a7a63fd4e@gmail.com>
Date:   Thu, 25 Mar 2021 16:31:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <pull.915.git.1616701733901.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

n 3/25/2021 3:48 PM, Chinmoy via GitGitGadget wrote:
> From: Chinmoy Chakraborty <chinmoy12c@gmail.com>
> 
> This kills the_repository dependency in cache_tree_update(),
> but for unpack_trees(), they still assume the_repository
> (which also means the_index).

This is a worthwhile goal.
 
> Unfortunately the widespread use of unpack_trees() will make
> it hard to make the conversion now.

And this is true.

> The `update_main_cache_tree()` method uses `cache_tree_update(r, r->index, flags)`.
> `r->index` is easily deduced from `r` but the signature of `cache_tree_update()`
> is not changed to take `struct repository *` instead of `struct index_state *`
> because there can be temporary indexes. Therefore, one might want to update
> the cache tree for an index other than `r->index`.

Unfortunately, you're also hitting against a use of
cache_tree_update() that I'm introducing in my sparse-index
work [1], so that will cause a semantic, non-textual conflict.

[1] https://lore.kernel.org/git/pull.883.v4.git.1616507069.gitgitgadget@gmail.com/

There are a couple options here:

1. Wait a little while for that to settle and merge to master.
2. Rebase your work onto ds/sparse-index, so you also fix the
   new use in sparse-index.c.
3. Continue without it, and maybe Junio will update the merge
   with this diff:

diff --git a/sparse-index.c b/sparse-index.c
index e5712d98d8..585f269214 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -169,7 +169,7 @@ int convert_to_sparse(struct index_state *istate)
 		return -1;
 	}
 
-	if (cache_tree_update(istate, 0)) {
+	if (cache_tree_update(istate->repo, istate, 0)) {
 		warning(_("unable to update cache-tree, staying full"));
 		return -1;
 	}
@@ -183,7 +183,7 @@ int convert_to_sparse(struct index_state *istate)
 
 	/* Clear and recompute the cache-tree */
 	cache_tree_free(&istate->cache_tree);
-	cache_tree_update(istate, 0);
+	cache_tree_update(istate->repo, istate, 0);
 
 	istate->sparse_index = 1;
 	trace2_region_leave("index", "convert_to_sparse", istate->repo);

Finally, there is yet a fourth option: use istate->repo instead. In
1fd9ae51 (repository: add repo reference to index_state), I added a
'repo' member to struct index_state. This is intended for methods to
access a repository directly from the index.

However, this is slightly dangerous because there are some cases where
and index is loaded without even the_repository being populated (and
hence istate->repo can be NULL). They are rare, so perhaps
unpack_trees() is always used on an index_state with a populated repo.
If not, then a temporary fix can be done to set istate->repo to
the_repository at the start of the method.

This could help you avoid changing method prototypes, reducing the
conflicts in your patch.

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 2d6550bc3c86..3bc630ef64e7 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -684,6 +684,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
>  	int ret;
>  	struct lock_file lock_file = LOCK_INIT;
>  	struct tree *new_tree;
> +	struct repository *r = the_repository;

I do appreciate you using this pattern so we could
possibly add 'r' as a method parameter later.

The rest of the patch looks pretty standard. I hope my comments
above are helpful in your direction here.

Thanks,
-Stolee
