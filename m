Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B90C43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 22:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238330AbiFUW4C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiFUW4B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 18:56:01 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E5B2E6BD
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:55:58 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id y13-20020a17090a154d00b001eaaa3b9b8dso14955759pja.2
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Eg4+7gJhAPboIE2Yzr9GBc6+Bud+7mzQPGyXkEg0tbE=;
        b=EUqCscGIVamgqjTAy5Q78UW+8dU/Fmav8VJbrMkaopfXiNYa1Gign8+1CRf4GkkV0o
         VZEgqRt6Bz4txOKrHZ8XVIVnMh8C/AQqhwVPAxdZP18REL0i8iCy7US2iZ5ij+zih0Wj
         mkDa1ZmNXlNUL+qqTAqj+yVDr9rWS2xIeoWmVz3DMu6dn98PMLPb40AT69fYOgRz+O0k
         pnTv/aFJhDn7CQYPKUmJp+YWM142RNOocMHKpSt3wd3j0v68k6rlbX7isjyneM0sF0Mk
         suvCJERdfSyNFRqvcpDZAEYEUh9fuqt86WkRuo5XU5p1r9H3MPkWm3DQyu6OAo4e/4nb
         aMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Eg4+7gJhAPboIE2Yzr9GBc6+Bud+7mzQPGyXkEg0tbE=;
        b=XtUAKHKte+Ru5pO5mZcCx6q9DI2OJyPDc7OXU8ZQZFjSObyr6jddAJOZER4nkvzI2V
         lPC1F4MDTOIl/AA3ofehdmYdJOBXuxQjCPCflEgBQa8Fl5gJUxUVTYa3GbZaLwBHfO5L
         6KKpv8SXZivHRIT8v5AygXVdqrpH5Sq9csmRrQFY1AFHxdvXCOU77g7rKEJQjK/GU27U
         BwbsNXh6CyC/FAMWNib5tAK5hwQhTADU3Eo2Byyo0Wnzy/ge+H1G77rkfj8NojKYcDXd
         DYb7RzBa5+3DQ4qyOfXr4u2QdIYVeHCbBB8Fw2p1Kx2r71P3DZwBw/Mo1xmzVugNSCB9
         6VMQ==
X-Gm-Message-State: AJIora/LMYQNtoUz+xiQOvd4IINRxEgQldHJq1WKiDX/J0h7flXLZH+V
        ionfSwM/HLzDYSf4pjHK44uvw9mab6/Z
X-Google-Smtp-Source: AGRyM1tRiUQokcfDNoZ7l5ltbyy+UPd45u5WkMXdTzBXqosFNqX7XRdJEqxTS1BAv6a/Q0wEWZELqw==
X-Received: by 2002:a17:90b:4b4d:b0:1ec:df7f:a141 with SMTP id mi13-20020a17090b4b4d00b001ecdf7fa141mr265857pjb.191.1655852158413;
        Tue, 21 Jun 2022 15:55:58 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id cq5-20020a056a00330500b0052535e7c489sm2285368pfb.114.2022.06.21.15.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 15:55:58 -0700 (PDT)
Message-ID: <11c81f19-a234-7d63-4d77-f1f15bdf70fb@github.com>
Date:   Tue, 21 Jun 2022 15:55:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [WIP v3 6/7] mv: add check_dir_in_index() and solve general dir
 check issue
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220619032549.156335-1-shaoxuan.yuan02@gmail.com>
 <20220619032549.156335-7-shaoxuan.yuan02@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220619032549.156335-7-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> Originally, moving a <source> directory which is not on-disk due
> to its existence outside of sparse-checkout cone, "giv mv" command
> errors out with "bad source".
> 
> Add a helper check_dir_in_index() function to see if a directory
> name exists in the index. Also add a SKIP_WORKTREE_DIR bit to mark
> such directories.
> 
> Change the checking logic, so that such <source> directory makes
> "giv mv" command warns with "advise_on_updating_sparse_paths()"
> instead of "bad source"; also user now can supply a "--sparse" flag so
> this operation can be carried out successfully.
> 
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
>  builtin/mv.c                  | 49 +++++++++++++++++++++++++++++++----
>  t/t7002-mv-sparse-checkout.sh |  4 +--
>  2 files changed, 46 insertions(+), 7 deletions(-)
> 
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 7ce7992d6c..cb3441c7cb 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -123,6 +123,37 @@ static int index_range_of_same_dir(const char *src, int length,
>  	return last - first;
>  }
>  
> +/*
> + * Check if an out-of-cone directory should be in the index. Imagine this case
> + * that all the files under a directory are marked with 'CE_SKIP_WORKTREE' bit
> + * and thus the directory is sparsified.> + *
> + * Return 0 if such directory exist (i.e. with any of its contained files not
> + * marked with CE_SKIP_WORKTREE, the directory would be present in working tree).
> + * Return 1 otherwise.
> + */
This explanation is helpful in clarifying that you don't mean *sparse
directories* (that is, directory entries in a sparse index), you mean
directories whose contents are all sparse. It's a tricky distinction, but
you handled it nicely here.

> +static int check_dir_in_index(const char *name, int namelen)
> +{
> +	int ret = 1;
> +	const char *with_slash = add_slash(name);
> +	int length = namelen + 1;
> +
> +	int pos = cache_name_pos(with_slash, length);
> +	const struct cache_entry *ce;
> +
> +	if (pos < 0) {
> +		pos = -pos - 1;
> +		if (pos >= the_index.cache_nr)
> +			return ret;
> +		ce = active_cache[pos];
> +		if (strncmp(with_slash, ce->name, length))
> +			return ret;
> +		if (ce_skip_worktree(ce))
> +			return ret = 0;
> +	}
> +	return ret;

The way 'ret' is handled here is a bit difficult to follow. Would you be
opposed to returning hardcoded '0' or '1', rather than changing the value of
'ret' throughout? Something like:

static int check_dir_in_index(const char *name, int namelen)
{
	int pos, length = namelen + 1;
	const struct cache_entry *ce;
	const char *with_slash = add_slash(name);

	pos = cache_name_pos(with_slash, length);
	if (pos < 0) {
		pos = -pos - 1;
		if (pos >= the_index.cache_nr)
			return 1;
		ce = active_cache[pos];
		if (strncmp(with_slash, ce->name, length))
			return 1;
		if (ce_skip_worktree(ce))
			return 0;
	}
	return 1;
}

> +}
> +
>  int cmd_mv(int argc, const char **argv, const char *prefix)
>  {
>  	int i, flags, gitmodules_modified = 0;
> @@ -184,7 +215,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  	/* Checking */
>  	for (i = 0; i < argc; i++) {
>  		const char *src = source[i], *dst = destination[i];
> -		int length, src_is_dir;
> +		int length;
>  		const char *bad = NULL;
>  		int skip_sparse = 0;
>  
> @@ -198,12 +229,17 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  
>  			pos = cache_name_pos(src, length);
>  			if (pos < 0) {
> +				const char *src_w_slash = add_slash(src);
> +				if (!check_dir_in_index(src, length) &&
> +					!path_in_sparse_checkout(src_w_slash, &the_index)) {

In checks like these, the less "expensive" one should come first (so that if
it returns 'false', we completely skip the more expensive one). Since
'check_dir_in_index()' requires binary searching the index, it's likely to
be more expensive than 'path_in_sparse_checkout()', so the condition order
should be flipped:

				if (!path_in_sparse_checkout(src_w_slash, &the_index) &&
				    !check_dir_in_index(src, length)) {

Also nit: alignment (more details on why/how in my last message [1]).

[1] https://lore.kernel.org/git/01b39c63-5652-4293-0424-ff99b6f9f7d2@github.com/

> +					modes[i] |= SKIP_WORKTREE_DIR;
> +					goto dir_check;
> +				}
>  				/* only error if existence is expected. */
>  				if (!(modes[i] & SPARSE))
>  					bad = _("bad source");
>  				goto act_on_entry;
>  			}
> -
>  			ce = active_cache[pos];
>  			if (!ce_skip_worktree(ce)) {
>  				bad = _("bad source");
> @@ -230,14 +266,17 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  			bad = _("can not move directory into itself");
>  			goto act_on_entry;
>  		}
> -		if ((src_is_dir = S_ISDIR(st.st_mode))
> +		if (S_ISDIR(st.st_mode)
>  		    && lstat(dst, &st) == 0) {
>  			bad = _("cannot move directory over file");
>  			goto act_on_entry;
>  		}
> -		if (src_is_dir) {
> +
> +dir_check:
> +		if (S_ISDIR(st.st_mode)) {
>  			int j, dst_len, n;
> -			int first = cache_name_pos(src, length), last;
> +			int first, last;
> +			first = cache_name_pos(src, length);

Super-nit: why did this line change? It looks like it just rearranges the
lines for no functional purpose.

>  
>  			if (first >= 0) {
>  				prepare_move_submodule(src, first,
> diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
> index 5b61fbad5f..30e13b9979 100755
> --- a/t/t7002-mv-sparse-checkout.sh
> +++ b/t/t7002-mv-sparse-checkout.sh
> @@ -219,7 +219,7 @@ test_expect_success 'refuse to move file to non-skip-worktree sparse path' '
>  	test_cmp expect stderr
>  '
>  
> -test_expect_failure 'refuse to move out-of-cone directory without --sparse' '
> +test_expect_success 'refuse to move out-of-cone directory without --sparse' '
>  	test_when_finished "cleanup_sparse_checkout" &&
>  	setup_sparse_checkout &&
>  
> @@ -230,7 +230,7 @@ test_expect_failure 'refuse to move out-of-cone directory without --sparse' '
>  	test_cmp expect stderr
>  '
>  
> -test_expect_failure 'can move out-of-cone directory with --sparse' '
> +test_expect_success 'can move out-of-cone directory with --sparse' '
>  	test_when_finished "cleanup_sparse_checkout" &&
>  	setup_sparse_checkout &&
>  

