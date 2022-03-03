Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F9BC433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 21:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbiCCVT4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 16:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiCCVTy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 16:19:54 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E17A41BF
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 13:19:08 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id t14so5791626pgr.3
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 13:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Q5YlBYMMwIvjWv+OSvr8vG0bgfy4UoBFtbWMgAkqlhk=;
        b=fNzRpCLq157umUwhtdyApgpkKsPTuakYoJ0eiPhXUZsiWl92ytze3pqfNh4mz0OVlq
         kSyw7teeBjNo+yDGnR5lH5yRPA2M9ut9DGIxRFltDER49dFqxDFKfzihJQpyHDaqVjR1
         xoJjjC3v/eWKZCqfMLI1ec3UVfWHSQ0WAhaq6cvGDM0fIlZejsGxeLvYcReUTnEef0me
         acKASHbqcGT1ESFfYb/J60/JfDYYtWGJ5GgBt3T9XoEonnZ8iGU6WH/sDEMsJRONvGJX
         jjXidfAUuhxgnWLoI095eB++KIVvbxmlQNlNiCbaWlNHjzEDtoRGP1rMleHBlghXH0H7
         Xj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Q5YlBYMMwIvjWv+OSvr8vG0bgfy4UoBFtbWMgAkqlhk=;
        b=o44I1c3IY1aPbpcgyVmyjzz4XmZ8VqV9w9stcRriwFk8I3NkBux+1f3vtKKYpfYKmd
         CoxCnjEjdvoi1EHLzGu4TZaOKpjFjlnl5tu9Nk+QF6KW816dhmjs9sA5X+VkkcUMncfo
         Qh17SMdlrsE629jH0NNCmrbhcuqLxiNr8dAW8Uine9hfQJUFIORITyIBIPcqqlSgdRNp
         sRfceUr1v//QB3Vk5xzqAQFzx1r1dQry7OICee6yK/7jkUZIDEtueyTL5ZdATbFmSY5Q
         sIQdG2S9d9cPeyqJ1zEguNc5T/o1Ew2FRuyED3N3av2LOW6kBaUwoc3ptUPcNxiKOwhK
         wYZw==
X-Gm-Message-State: AOAM533/mvM5za72BDvqOdoFioR7CLnJdBmhk5tDQ7mv10yahF3LBQJ9
        0ESOrmL6nohtr7kQXBOcUUVD
X-Google-Smtp-Source: ABdhPJzH0Ym5NuAoS3MfRhyDQroUTQHgSvirWemTlrVHHcfNUvHJ0ctlXU/LxpA6Hm7G7zn8LVkzZg==
X-Received: by 2002:a63:8843:0:b0:37c:926d:3fc7 with SMTP id l64-20020a638843000000b0037c926d3fc7mr791330pgd.112.1646342348114;
        Thu, 03 Mar 2022 13:19:08 -0800 (PST)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id d4-20020a17090a8d8400b001bc386dc44bsm9027308pjo.23.2022.03.03.13.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 13:19:07 -0800 (PST)
Message-ID: <5353fb06-09e4-77bf-554c-1cd750158730@github.com>
Date:   Thu, 3 Mar 2022 13:19:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v3 6/8] read-tree: narrow scope of index expansion for
 '--prefix'
Content-Language: en-US
To:     Glen Choo <chooglen@google.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
 <pull.1157.v3.git.1646166271.gitgitgadget@gmail.com>
 <1a9365c3bc5b810a60593612bfba97a8b0c1d657.1646166271.git.gitgitgadget@gmail.com>
 <kl6lczj2exbn.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <kl6lczj2exbn.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Victoria Dye <vdye@github.com>
>> +static void update_sparsity_for_prefix(const char *prefix,
>> +				       struct index_state *istate)
>> +{
>> +	int prefix_len = strlen(prefix);
>> +	struct strbuf ce_prefix = STRBUF_INIT;
>> +
>> +	if (!istate->sparse_index)
>> +		return;
>> +
>> +	while (prefix_len > 0 && prefix[prefix_len - 1] == '/')
>> +		prefix_len--;
>> +
>> +	if (prefix_len <= 0)
>> +		BUG("Invalid prefix passed to update_sparsity_for_prefix");
>> +
>> +	strbuf_grow(&ce_prefix, prefix_len + 1);
>> +	strbuf_add(&ce_prefix, prefix, prefix_len);
>> +	strbuf_addch(&ce_prefix, '/');
>> +
>> +	/*
>> +	 * If the prefix points to a sparse directory or a path inside a sparse
>> +	 * directory, the index should be expanded. This is accomplished in one
>> +	 * of two ways:
>> +	 * - if the prefix is inside a sparse directory, it will be expanded by
>> +	 *   the 'ensure_full_index(...)' call in 'index_name_pos(...)'.
>> +	 * - if the prefix matches an existing sparse directory entry,
>> +	 *   'index_name_pos(...)' will return its index position, triggering
>> +	 *   the 'ensure_full_index(...)' below.
>> +	 */
>> +	if (!path_in_cone_mode_sparse_checkout(ce_prefix.buf, istate) &&
>> +	    index_name_pos(istate, ce_prefix.buf, ce_prefix.len) >= 0)
>> +		ensure_full_index(istate);
>> +
>> +	strbuf_release(&ce_prefix);
>> +}
> 
> Hm, I don't think I follow the rationale for having two different ways
> of expanding the index:
> 
> - If the prefix is inside a sparse directory, we should expand the
>   index.
> - If the prefix matches a sparse directory entry, we should expand the
>   index.
> 

There's an (admittedly subtle if you aren't familiar with sparse index)
distinction between a "sparse directory" index entry and "a directory
outside the sparse-checkout cone with SKIP_WORKTREE enabled on its entries".
Ultimately, that's what necessitates the two checks but, as in [1], I want
to use this as an opportunity to shed some light on what 'unpack_trees(...)'
does.

Taking a step back, why would index expansion matter when you pass a prefix
to 'read-tree'? The answer lies in the tree traversal at the core of
'unpack_trees(...)'; when a prefix is provided, 'unpack_trees' does the
following:

1. Set the "traversal prefix" to the user-provided prefix.
2. Call 'traverse_trees(...)', iterating through the child files/directories
   of the prefix directory (NOTE: this does *not* use the index - it finds
   the child entries by extracting them from the tree).
3. For each child, call 'unpack_callback' which, among other things, looks
   for the child entry as it exists in the index to merge the input trees
   into it.

The problem with sparse directories arises in step 3. Suppose you have the
following repo:

.
├── bar
│   └── f1
├── baz
│   ├── deep
│   │   └── a
│   └── f2
├── foo
└── foo1


where directory 'baz/' is sparse, leading to an index that looks like this
(per 'git ls-files -t --sparse'):

H bar/f1
S baz/
H foo
H foo1

If you provide 'baz/' as a prefix, 'unpack_callback(...)' tries to find
'baz/deep/a' and 'baz/f2' in the index, but they won't be found because
they're "wrapped" in sparse directory 'baz/'. Ultimately, this leads to a
corrupted index with duplicate 'baz/' contents merged in:

H bar/f1
S baz/
S baz/deep/a
S baz/f2
H foo
H foo1

This explains why you need to expand the index at all, but not why you need
to check that the prefix is not in the sparse cone *and* that it (or its
parent directory) doesn't exist in the index. For that, an important bit of
context is that you can have a sparse index with non-sparse directories
outside the cone. This can happen in a number of ways (for example, running
'git update-index --no-skip-worktree' on a file in a sparse directory), but
the important thing is that it is a completely valid state and not entirely
uncommon. 

Using our example above, suppose 'baz/' is partially expanded in the index,
with the following index contents:

H bar/f1
S baz/deep/
S baz/f2
H foo
H foo1

If we use the prefix 'baz/' here, we actually traverse the trees properly:
'baz/deep/' and 'baz/f2' will be found and merged - no index expansion
needed! But if we only checked '!path_in_cone_mode_sparse_checkout(...)', we
would have expanded the index because 'baz/' is outside the sparse cone. 

This presents a problem because index expansion is *extremely* expensive -
we should avoid it whenever possible. That's where checking
'index_name_pos(...)' comes in: if the directory is in the index as a sparse
directory, the position is '>= 0' and 'ensure_full_index(...)' is called; if
the directory is inside an existing sparse directory, the position will be
'< 0' but the index will be expanded implicitly. In every other case, we
avoid expanding the index and proceed with the merge as normal.

Hope this helps!

[1] https://lore.kernel.org/git/dc47f12b-8724-22ef-ed2c-096badfafd76@github.com/

> So it seems like distinguishing between the two cases with
> index_name_pos(...) isn't necessary. I've attached a diff that does
> exactly this, and it passes t1092-sparse-checkout-compatibility.sh as
> far as I can tell. I've also amended the comment in a way that makes
> more sense to me, but I'm not 100% sure if it's accurate.
> 
> I'm also a little averse to using a side effect of index_name_pos() to
> achieve what we really want, so I'd prefer to get rid of the call if we
> can :)
> 
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
> 
> diff --git a/unpack-trees.c b/unpack-trees.c
> index b876caca0d..5b07055605 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1749,17 +1749,11 @@ static void update_sparsity_for_prefix(const char *prefix,
>  	strbuf_addch(&ce_prefix, '/');
>  
>  	/*
> -	 * If the prefix points to a sparse directory or a path inside a sparse
> -	 * directory, the index should be expanded. This is accomplished in one
> -	 * of two ways:
> -	 * - if the prefix is inside a sparse directory, it will be expanded by
> -	 *   the 'ensure_full_index(...)' call in 'index_name_pos(...)'.
> -	 * - if the prefix matches an existing sparse directory entry,
> -	 *   'index_name_pos(...)' will return its index position, triggering
> -	 *   the 'ensure_full_index(...)' below.
> +	 * If the prefix points to a sparse directory or a path inside a
> +	 * sparse directory (not within the sparse patterns), the index
> +	 * should be expanded.
>  	 */
> -	if (!path_in_cone_mode_sparse_checkout(ce_prefix.buf, istate) &&
> -	    index_name_pos(istate, ce_prefix.buf, ce_prefix.len) >= 0)
> +	if (!path_in_cone_mode_sparse_checkout(ce_prefix.buf, istate))
>  		ensure_full_index(istate);
>  
>  	strbuf_release(&ce_prefix);

