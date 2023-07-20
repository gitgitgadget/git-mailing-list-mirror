Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0619EEB64DA
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 20:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjGTUS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 16:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGTUS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 16:18:57 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3AF271D
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 13:18:50 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-66f5faba829so855354b3a.3
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 13:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1689884329; x=1690489129;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=che2ueIW7sq+9Td4bdyTyCnCIoVhvoURxrKQnaFI0xQ=;
        b=eSZPSc62SN3cGoL0p3NnJGtcpv3qPO5Im/nD3tQGQ7iTgp5kDGRPGLdtlJtDO+uBnC
         fH/9tUfhnVqDqkaEuFPdC2hKF+3WDSeFGqGSFDxTqxD0AIuyOofErkYZpN88/UjiInbe
         p1oNxD9X5Z3RoSfoKdXFjVWhhX1B3vNe0GdiGpMRbvsnmXZuqy48u3yay1ISPt1Y+p2b
         G0K/CgQczO9fndrdIqtpbQJMjW5D8fJ8C+B4t0DUYpgXG71FTR+uYW8EFdyLmdtTMXiZ
         MeRnlqx4AcGUNVCpG7JooAjB4COSFr4XZM64Icv1X/lddEYoI3e5kcHX0jXhhnPdw9Zm
         /izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689884329; x=1690489129;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=che2ueIW7sq+9Td4bdyTyCnCIoVhvoURxrKQnaFI0xQ=;
        b=bWcLDbes3vih7nysfaXBUdx2zABIjWCyNucp7I6RqR+5CbYjyFxAXQu2ZJJayZ1qgJ
         CMagtcbX4T8/A8QoQOZxN60rnmaxCPzSFsfdNRcgp8VjcfFWo+t0h6UdNWpxaI1TPlqS
         Hb4sQ8jXfzAFmZ8PDAdomMwE6tS8C5px3c8xiUTYYdci6n6LwOeSzX0pt9337dfQayUC
         oIXr0jum6H0hQtOgqD9yt2j1LU24GV5+pSOxIbxCQJZ+RunJVa74kbkxQGy4CWLzwDwj
         yr1kxt6wfYOuVVCXayOaM7099a5neyiHp6UkSDaaFbkha+kvno3H62Ps4wnobtC6NO32
         eq1w==
X-Gm-Message-State: ABy/qLYGb3Zs54ZWN2lkjgAkr3A9S4ooTFGIo3FBsYqoluG+S//HUoM3
        pmolitGItfhQZALCoM2Am7kmmmKiSX0lf+EdJA==
X-Google-Smtp-Source: APBJJlHMCyjYYhVqFcDXP1U56p7lOjhlrA4+LJVpfBBpNoEDhbHjA3Db0W502+ic0Wv1nhOBjDcZyg==
X-Received: by 2002:a05:6a00:228d:b0:672:264c:e8cf with SMTP id f13-20020a056a00228d00b00672264ce8cfmr1224699pfe.7.1689884329360;
        Thu, 20 Jul 2023 13:18:49 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id g8-20020aa78748000000b00668738796b6sm1599830pfo.52.2023.07.20.13.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 13:18:49 -0700 (PDT)
Message-ID: <5e478d8b-9ef4-864b-41e4-e0a79877d278@github.com>
Date:   Thu, 20 Jul 2023 13:18:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/3] attr.c: read attributes in a sparse directory
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <20230711133035.16916-1-cheskaqiqi@gmail.com>
 <20230718232916.31660-1-cheskaqiqi@gmail.com>
 <20230718232916.31660-3-cheskaqiqi@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230718232916.31660-3-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> Before this patch, git check-attr was unable to read the attributes from
> a .gitattributes file within a sparse directory. The original comment
> was operating under the assumption that users are only interested in
> files or directories inside the cones. Therefore, in the original code,
> in the case of a cone-mode sparse-checkout, we didn't load the
> .gitattributes file.
> 
> However, this behavior can lead to missing attributes for files inside
> sparse directories, causing inconsistencies in file handling.
> 
> To resolve this, revise 'git check-attr' to allow attribute reading for
> files in sparse directories from the corresponding .gitattributes files:
> 
> 1.Utilize path_in_cone_mode_sparse_checkout() and index_name_pos_sparse
> to check if a path falls within a sparse directory.
> 
> 2.If path is inside a sparse directory, employ the value of
> index_name_pos_sparse() to find the sparse directory containing path and
> path relative to sparse directory. Proceed to read attributes from the
> tree OID of the sparse directory using read_attr_from_blob().
> 
> 3.If path is not inside a sparse directory，ensure that attributes are
> fetched from the index blob with read_blob_data_from_index().
> 
> Modify previous tests so such difference is not considered as an error.

I don't quite follow what you mean here "such difference". I see that you
changed the 'test_expect_failure' to 'test_expect_success', but that's
because the attributes inside a sparse directory are now being read rather
than ignored.

The rest of the commit message looks good to me, though.

> 
> Helped-by: Victoria Dye <vdye@github.com>
> Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
> ---
>  attr.c                                   | 60 +++++++++++++++++-------
>  t/t1092-sparse-checkout-compatibility.sh |  4 +-
>  2 files changed, 44 insertions(+), 20 deletions(-)
> 
> diff --git a/attr.c b/attr.c
> index 7d39ac4a29..7650f5481a 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -808,35 +808,59 @@ static struct attr_stack *read_attr_from_blob(struct index_state *istate,
>  static struct attr_stack *read_attr_from_index(struct index_state *istate,
>  					       const char *path, unsigned flags)
>  {
> +	struct attr_stack *stack = NULL;
>  	char *buf;
>  	unsigned long size;
> +	int pos = -1;
> +	char normalize_path[PATH_MAX];
> +	const char *relative_path;
>  
>  	if (!istate)
>  		return NULL;
>  
>  	/*
> -	 * The .gitattributes file only applies to files within its
> -	 * parent directory. In the case of cone-mode sparse-checkout,
> -	 * the .gitattributes file is sparse if and only if all paths
> -	 * within that directory are also sparse. Thus, don't load the
> -	 * .gitattributes file since it will not matter.
> -	 *
> -	 * In the case of a sparse index, it is critical that we don't go
> -	 * looking for a .gitattributes file, as doing so would cause the
> -	 * index to expand.
> +	 * When handling sparse-checkouts, .gitattributes files
> +	 * may reside within a sparse directory. We distinguish
> +	 * whether a path exists directly in the index or not by
> +	 * evaluating if 'pos' is negative.
> +	 * If 'pos' is negative, the path is not directly present
> +	 * in the index and is likely within a sparse directory.
> +	 * For paths not in the index, The absolute value of 'pos'
> +	 * minus 1 gives us the position where the path would be
> +	 * inserted in lexicographic order within the index.
> +	 * We then subtract another 1 from this value
> +	 * (pos = -pos - 2) to find the position of the last
> +	 * index entry which is lexicographically smaller than
> +	 * the path. This would be the sparse directory containing
> +	 * the path. By identifying the sparse directory containing
> +	 * the path, we can correctly read the attributes specified
> +	 * in the .gitattributes file from the tree object of the
> +	 * sparse directory.
>  	 */
> -	if (!path_in_cone_mode_sparse_checkout(path, istate))
> -		return NULL;
> +	if (!path_in_cone_mode_sparse_checkout(path, istate)) {
> +		pos = index_name_pos_sparse(istate, path, strlen(path));
>  
> -	buf = read_blob_data_from_index(istate, path, &size);
> -	if (!buf)
> -		return NULL;
> -	if (size >= ATTR_MAX_FILE_SIZE) {
> -		warning(_("ignoring overly large gitattributes blob '%s'"), path);
> -		return NULL;
> +		if (pos < 0)
> +			pos = -pos - 2;
>  	}

What 'pos' represents after this block is somewhat confusing/possibly
misleading. Consider the possible cases for 'path':

1. 'path' is inside the sparse-checkout cone.
2. 'path' is not inside the sparse-checkout cone, but it is in the index
   (i.e., the sparse directory has been expanded for some reason).
3. 'path' is inside a sparse directory.

In case #1, 'pos' will be '-1'. We never enter the
'!path_in_cone_mode_sparse_checkout()' if-statement, so the value is never
updated.

In case #2, 'pos' will be positive, since it exists in the index.

In case #3, the return value of 'index_name_pos_sparse()' will be negative,
then assigned the value of '-pos - 2' to (in many cases) create a positive
value pointing to the entry before the insertion point of 'path'.

Based on your explanation in the code comment above, I would assume that, if
'pos' was >= 0 coming out of this block, it represented the index position
of the potential sparse directory containing 'path'. But that's not true in
case #2.

To make the purpose of these variables clearer, instead of changing 'pos'
in-place, you could create a variable like 'sparse_dir_pos'. Like 'pos' is
now, it'd be initialized to '-1', but instead of unconditionally assigning
it the output of 'index_name_pos_sparse()', you'd only assign it if the
output of that function is negative:

	if (!path_in_cone_mode_sparse_checkout(path, istate)) {
		int pos = index_name_pos_sparse(istate, path, strlen(path));
		if (pos < 0)
			sparse_dir_pos = -pos - 2;
	}

Then, you'd use 'sparse_dir_pos' in the condition below, and it'd always be
-1 when 'path' is definitely not contained in a sparse directory.

>  
> -	return read_attr_from_buf(buf, path, flags);
> +	if (pos >= 0 && !path_in_cone_mode_sparse_checkout(path, istate) &&

nit: the check of '!path_in_cone_mode_sparse_checkout()' is redundant, since
'pos' will always be '-1' if 'path_in_cone_mode_sparse_checkout()' is true.

> +	    S_ISSPARSEDIR(istate->cache[pos]->ce_mode) &&
> +	    !strncmp(istate->cache[pos]->name, path, ce_namelen(istate->cache[pos])) &&
> +	    !normalize_path_copy(normalize_path, path)) {

The normalization should come before the 'strncmp' so that you're comparing
'normalize_path' to the index entry.  

That said, I know I asked about path normalization earlier [1], but did you
confirm that 'path' _isn't_ normalized? Because if it's normalized by all of
the potential callers of this function, the check here would be unnecessary.

[1] https://lore.kernel.org/git/e4a77d0f-cf1d-ef76-fe26-ad5e58372a02@github.com/

> +		relative_path = normalize_path + ce_namelen(istate->cache[pos]);

'relative_path' should be declared here, since it's not used outside this
block. 

> +		stack = read_attr_from_blob(istate, &istate->cache[pos]->oid, relative_path, flags);
> +	} else {
> +		buf = read_blob_data_from_index(istate, path, &size);
> +		if (!buf)
> +			return NULL;
> +		if (size >= ATTR_MAX_FILE_SIZE) {
> +			warning(_("ignoring overly large gitattributes blob '%s'"), path);
> +			return NULL;
> +		}
> +		stack = read_attr_from_buf(buf, path, flags);
> +	}
> +	return stack;
>  }
>  
>  static struct attr_stack *read_attr(struct index_state *istate,
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 90633f383a..3f32c1f972 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -2271,7 +2271,7 @@ test_expect_success 'check-attr with pathspec inside sparse definition' '
>  	test_all_match git check-attr -a --cached -- deep/a
>  '
>  
> -test_expect_failure 'check-attr with pathspec outside sparse definition' '
> +test_expect_success 'check-attr with pathspec outside sparse definition' '

Re: my suggested change to the test in patch 1 [2], when I applied _this_
patch, the test still failed for the 'sparse-index' case. It doesn't seem to
be a problem with your patch, but rather a bug in 'diff' that can be
reproduced with this test (using the infrastructure in t1092):

test_expect_failure 'diff --cached shows differences in sparse directory' '
	init_repos &&

	test_all_match git reset --soft update-folder1 &&
	test_all_match git diff --cached -- folder1/a
'

It's not immediately obvious to me what the problem is, but my guess is it's
some mis-handling of sparse directories in the internal diff machinery.
Given the likely complexity of the issue, I'd be content with you leaving
the 'diff --check' test as 'test_expect_failure' with a note about the bug
in 'diff' to fix later. Or, if you do want to investigate & fix it now, I
wouldn't be opposed to that either. :) 

[2] https://lore.kernel.org/git/c3ebe3b4-88b9-8ca2-2ee3-39a3e0d82201@github.com/

>  	init_repos &&
>  
>  	echo "a -crlf myAttr" >>.gitattributes &&
> @@ -2288,7 +2288,7 @@ test_expect_failure 'check-attr with pathspec outside sparse definition' '
>  	test_all_match git check-attr  -a --cached -- folder1/a
>  '
>  
> -test_expect_failure 'diff --check with pathspec outside sparse definition' '
> +test_expect_success 'diff --check with pathspec outside sparse definition' '
>  	init_repos &&
>  
>  	write_script edit-contents <<-\EOF &&

