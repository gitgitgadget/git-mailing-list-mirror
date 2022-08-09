Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00844C00140
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 00:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244760AbiHIAxa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 20:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbiHIAx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 20:53:28 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA8B186D2
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 17:53:27 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ha11so10316163pjb.2
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 17:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Umv9Kw7mnZP6yzmF9q/evmMAEdIEPs6Oh244fu7DJX4=;
        b=WHfgQeY5oDnadZh8BlKFkiOIZcd83uwnSufnSm72aS5Tdpq5mQN3dhPGjbWJk3tNxb
         9I5mszUC1zQ1ugaOzhvqE15zCh2Xqh9IYQjO+yprMWNIcarGIpADmJcfkaeoeeT4zguf
         P4xEygbvqb/5M3J+9yxax9zhX0GoZ1SI1c3swvioovUPq+U7zA919ESyGC4xT6kif+Kf
         t6sO42QE+TkU4F0M+RPuJ+tcFlFvU5rwVESclDDR3KWQPV85rHtK8dRRlJJMCo6qZUe6
         euXG+gW7RCw3EhqBgdsOfeI7sEzgmZ12MW/tgm5EblYPHDDh7SI6p13sApBlK/xt9KMm
         hYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Umv9Kw7mnZP6yzmF9q/evmMAEdIEPs6Oh244fu7DJX4=;
        b=55S8qAS0ABE93SHbDEw0PD45qVzp7yg9zNEQEMN+Zlib1dXgXVoYayah/hfk3KsUpH
         skfbdtjvTxFk8Ybdcc497zQrSjEJOQugsPpnr2LHirJVyXRmEuMldwZzi2TBxZw3hhMz
         YS7GC8MkwA0h+MubVtzwpfYcgjtOiUwa1bAmr7i3IuvoU/jzgTvn4+IBfVm4udomh2AV
         98OPMXHKGdZe7N3Rv3qP9sQhqo5jsSB+O6Mu6tcvaP7pG0UQo1fQ2XPRtbjXKFubYGLe
         Allt52IQATPVeLUfOjyqrPE8ogHL6dNTssBPBE1DN/8pRZGMmziW+1HUOktBgO8YOsWw
         NgRQ==
X-Gm-Message-State: ACgBeo0AapJGlvagyUISssaKPoUDo6vIBbq8afayfeqicSMMf23dUfWn
        bnV0kJwtun1GLPH8/JJmane30hPJHCaw
X-Google-Smtp-Source: AA6agR5Q8Zlx/yYt2FV7s9okioQnCZ5G1GbNP9+Arco9x8AD4mhSty1SgITlNEmeMxG/fTwd6XJUeA==
X-Received: by 2002:a17:90a:fb4b:b0:1f3:1cbb:8912 with SMTP id iq11-20020a17090afb4b00b001f31cbb8912mr31843295pjb.239.1660006406827;
        Mon, 08 Aug 2022 17:53:26 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id y3-20020aa793c3000000b005289fad1bbesm9556434pff.94.2022.08.08.17.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 17:53:26 -0700 (PDT)
Message-ID: <9718ab8a-5a1a-d93c-ae8f-aa06f6822577@github.com>
Date:   Mon, 8 Aug 2022 17:53:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v2 6/9] mv: from in-cone to out-of-cone
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-7-shaoxuan.yuan02@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220805030528.1535376-7-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> Originally, moving an in-cone <source> to an out-of-cone <destination>
> was not possible, mainly because such <destination> is a directory that
> is not present in the working tree.
> 
> Change the behavior so that we can move an in-cone <source> to
> out-of-cone <destination> when --sparse is supplied.
> 
> Such <source> can be either clean or dirty, and moving it results in
> different behaviors:
> 
> A clean move should move the <source> to the <destination>, both in the
> working tree and the index, then remove the resulted path from the
> working tree, and turn on its CE_SKIP_WORKTREE bit.

It looks like this description is the same as what you wrote in patch 1 [1].
That's fine with me but, as noted in [2], I wanted to double-check whether
the "move <src> to <dst> in worktree, then remove <dst> from worktree" is an
accurate description of what's happening.

[1] https://lore.kernel.org/git/20220805030528.1535376-2-shaoxuan.yuan02@gmail.com/
[2] https://lore.kernel.org/git/bd80881d-b2a3-c220-8f2d-a07a46e14207@github.com/

> 
> A dirty move should move the <source> to the <destination>, both in the
> working tree and the index, but should *not* remove the resulted path
> from the working tree and should *not* turn on its CE_SKIP_WORKTREE bit.> 
> Helped-by: Derrick Stolee <derrickstolee@github.com>
> Helped-by: Victoria Dye <vdye@github.com>
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
>  builtin/mv.c                  | 55 +++++++++++++++++++++++++++++------
>  t/t7002-mv-sparse-checkout.sh |  8 ++---
>  2 files changed, 50 insertions(+), 13 deletions(-)
> 
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 1dc55153ed..e4a14aea2d 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -171,12 +171,13 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  	};
>  	const char **source, **destination, **dest_path, **submodule_gitfile;
>  	const char *dst_w_slash;
> -	enum update_mode *modes;
> +	enum update_mode *modes, dst_mode = 0;
>  	struct stat st;
>  	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
>  	struct lock_file lock_file = LOCK_INIT;
>  	struct cache_entry *ce;
>  	struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
> +	struct string_list dirty_paths = STRING_LIST_INIT_NODUP;
>  
>  	git_config(git_default_config, NULL);
>  
> @@ -214,6 +215,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  		if (!path_in_sparse_checkout(dst_w_slash, &the_index) &&
>  		    empty_dir_has_sparse_contents(dst_w_slash)) {
>  			destination = internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_BASENAME);
> +			dst_mode = SKIP_WORKTREE_DIR;
>  		} else if (argc != 1) {
>  			die(_("destination '%s' is not a directory"), dest_path[0]);
>  		} else {
> @@ -408,6 +410,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  		const char *src = source[i], *dst = destination[i];
>  		enum update_mode mode = modes[i];
>  		int pos;
> +		int sparse_and_dirty = 0;
>  		struct checkout state = CHECKOUT_INIT;
>  		state.istate = &the_index;
>  
> @@ -418,6 +421,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  		if (show_only)
>  			continue;
>  		if (!(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
> +		    !(dst_mode & SKIP_WORKTREE_DIR) &&
>  		    rename(src, dst) < 0) {
>  			if (ignore_errors)
>  				continue;
> @@ -437,17 +441,49 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  
>  		pos = cache_name_pos(src, strlen(src));
>  		assert(pos >= 0);
> +		if (!(mode & SPARSE) && !lstat(src, &st))
> +			sparse_and_dirty = ce_modified(active_cache[pos], &st, 0);
>  		rename_cache_entry_at(pos, dst);
>  
> -		if ((mode & SPARSE) &&
> -		    (path_in_sparse_checkout(dst, &the_index))) {
> -			int dst_pos;
> +		if (ignore_sparse &&
> +		    core_apply_sparse_checkout &&
> +		    core_sparse_checkout_cone) {
> +			if ((mode & SPARSE) &&
> +			    path_in_sparse_checkout(dst, &the_index)) {
> +				/* from out-of-cone to in-cone */
> +				int dst_pos = cache_name_pos(dst, strlen(dst));
> +				struct cache_entry *dst_ce = active_cache[dst_pos];
> +
> +				dst_ce->ce_flags &= ~CE_SKIP_WORKTREE;
> +
> +				if (checkout_entry(dst_ce, &state, NULL, NULL))
> +					die(_("cannot checkout %s"), dst_ce->name);
> +			} else if ((dst_mode & SKIP_WORKTREE_DIR) &&
> +				   !(mode & SPARSE) &&
> +				   !path_in_sparse_checkout(dst, &the_index)) {
> +				/* from in-cone to out-of-cone */
> +				int dst_pos = cache_name_pos(dst, strlen(dst));
> +				struct cache_entry *dst_ce = active_cache[dst_pos];

It looks like the above conditions assume "out-of-cone <src>" and
"out-of-cone <dst>" are mutually exclusive. Have you checked what happens
when you try a move like that? 

If the behavior is sensible, it would be nice to add a test (in 't7002'?)
establishing that. Otherwise, changing that behavior is reasonably outside
the scope of this series, so it's fine with me if you add a either
"test_expect_failure" test, an "unsupported" warning message earlier in
'mv', or even just a "NEEDSWORK" comment somewhere around this code.

>  
> -			dst_pos = cache_name_pos(dst, strlen(dst));
> -			active_cache[dst_pos]->ce_flags &= ~CE_SKIP_WORKTREE;
> -
> -			if (checkout_entry(active_cache[dst_pos], &state, NULL, NULL))
> -				die(_("cannot checkout %s"), active_cache[dst_pos]->name);
> +				/*
> +				 * if src is clean, it will suffice to remove it
> +				 */
> +				if (!sparse_and_dirty) {
> +					dst_ce->ce_flags |= CE_SKIP_WORKTREE;
> +					unlink_or_warn(src);
> +				} else {
> +					/*
> +					 * if src is dirty, move it to the
> +					 * destination and create leading
> +					 * dirs if necessary
> +					 */
> +					char *dst_dup = xstrdup(dst);
> +					string_list_append(&dirty_paths, dst);
> +					safe_create_leading_directories(dst_dup);
> +					FREE_AND_NULL(dst_dup);
> +					rename(src, dst);
> +				}
> +			}

The rest of this is clearly organized and (as far as I can tell) matches the
behavior you established with the tests in patch 1. Nice work!

>  		}
>  	}
>  
> @@ -459,6 +495,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  		die(_("Unable to write new index file"));
>  
>  	string_list_clear(&src_for_dst, 0);
> +	string_list_clear(&dirty_paths, 0);
>  	UNLEAK(source);
>  	UNLEAK(dest_path);
>  	free(submodule_gitfile);
> diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
> index 9b3a9ab4c3..fc9577b2a6 100755
> --- a/t/t7002-mv-sparse-checkout.sh
> +++ b/t/t7002-mv-sparse-checkout.sh
> @@ -290,7 +290,7 @@ test_expect_success 'move sparse file to existing destination with --force and -
>  	test_cmp expect sub/file1
>  '
>  
> -test_expect_failure 'move clean path from in-cone to out-of-cone' '
> +test_expect_success 'move clean path from in-cone to out-of-cone' '
>  	test_when_finished "cleanup_sparse_checkout" &&
>  	setup_sparse_checkout &&
>  
> @@ -343,7 +343,7 @@ test_expect_failure 'move clean path from in-cone to out-of-cone overwrite' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_failure 'move dirty path from in-cone to out-of-cone' '
> +test_expect_success 'move dirty path from in-cone to out-of-cone' '
>  	test_when_finished "cleanup_sparse_checkout" &&
>  	setup_sparse_checkout &&
>  	echo "modified" >>sub/d &&
> @@ -363,7 +363,7 @@ test_expect_failure 'move dirty path from in-cone to out-of-cone' '
>  	grep "H folder1/d" actual
>  '
>  
> -test_expect_failure 'move dir from in-cone to out-of-cone' '
> +test_expect_success 'move dir from in-cone to out-of-cone' '
>  	test_when_finished "cleanup_sparse_checkout" &&
>  	setup_sparse_checkout &&
>  
> @@ -382,7 +382,7 @@ test_expect_failure 'move dir from in-cone to out-of-cone' '
>  	grep "S folder1/dir/e" actual
>  '
>  
> -test_expect_failure 'move partially-dirty dir from in-cone to out-of-cone' '
> +test_expect_success 'move partially-dirty dir from in-cone to out-of-cone' '
>  	test_when_finished "cleanup_sparse_checkout" &&
>  	setup_sparse_checkout &&
>  	touch sub/dir/e2 sub/dir/e3 &&

