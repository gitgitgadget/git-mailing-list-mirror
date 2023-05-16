Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508A2C77B75
	for <git@archiver.kernel.org>; Tue, 16 May 2023 21:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjEPVTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 17:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjEPVTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 17:19:09 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146035FD6
        for <git@vger.kernel.org>; Tue, 16 May 2023 14:19:08 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1aaff9c93a5so1072245ad.2
        for <git@vger.kernel.org>; Tue, 16 May 2023 14:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1684271947; x=1686863947;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FFhU1MjvueAz4J3WV3nK6SHf9SnjGOCxrEioVycuNfU=;
        b=ATHC5moifXzfgEqrTATchAdzH9obi3TyhTRBL477K6mix3/j1hwYgyPh8NOxnegJhf
         AxncSvSDx+T6/n0kCjGCKy3zSN4h2rdvWyea2SygYR+/q3joivWBe9MVFSlJ6KZwMqCN
         gcdXt0HAfimfyVRl4mZu2ZAGz2DzuFXP6yL3EinY750ZX9rWWWeQHW5TFEx3tC3dkGQK
         tImc64DuvOmoRUANuQcAhzDj9p+i2NfRPWDQockbpmK6DHIhHvqSeKdPxkIMXVjN3V70
         Nju3mT/H9WxRu0U48x5hxAll80GE7hVdEFma9tQvwsYvAfE9ZtQBsWC75Oo4KDllQ3UO
         xNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684271947; x=1686863947;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFhU1MjvueAz4J3WV3nK6SHf9SnjGOCxrEioVycuNfU=;
        b=XuHcJocimWqyB48HCznZ+RdB/y0pMqJo5rZP1tYWzrWRHTF84ISVMqwyoWOgt3NO7Q
         9WoBU1me1vLy/Bvu8NDYUSsGCvNm+6yrX+Wo+2jzzI/5iWrIqCygMtG9b0YaZtN8v6Es
         2Nw5NuAsNmPMODY9DBZa3Rz3pJ6kghOucfSKQXsvZVIroNtVnw2hK5rdo+XRphcOV5d8
         WRRUybhRfjyFSXzHBf9Ds1NQLCHWPDu8VAm79N/8THs3ksCPfEpM7ZiOueE5nhdyh4qL
         nXQPd20rexcw3+DdCKrpAoobW2h4v5oRVloHrm14CKpQwlLwZN9+0WiSOT94ygGU3znj
         8F5Q==
X-Gm-Message-State: AC+VfDzWTSC3u/2c0xMrmUO0BINCdC9uwF4IPPz8zW5/yW9ldln6gotX
        kcIYQVpBd9NtaC5zOuJ/9b7k
X-Google-Smtp-Source: ACHHUZ73Or0fQoNJRCIPMIHHsVBSUSP2m637DwZXWUDkJRSp+dYoAew/13I8h8uOEldjH+ZinhudQw==
X-Received: by 2002:a17:902:e5cf:b0:1ac:807b:deb1 with SMTP id u15-20020a170902e5cf00b001ac807bdeb1mr35958085plf.38.1684271947362;
        Tue, 16 May 2023 14:19:07 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id n18-20020a170902d2d200b001aaeba5ce0fsm15973692plc.68.2023.05.16.14.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 14:19:07 -0700 (PDT)
Message-ID: <fa24482c-7c48-9b7f-5d97-3dbf9822728c@github.com>
Date:   Tue, 16 May 2023 14:19:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [RFC][PATCH V1] diff-tree: integrate with sparse index
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com
References: <20230515191836.674234-1-cheskaqiqi@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230515191836.674234-1-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> Remove full index requirement for `git diff-tree`. Add tests that verify
> that 'git diff-tree' behaves correctly when the sparse index is enabled
> and test to ensure the index is not expanded.
> 
> The `p2000` tests demonstrate a ~98% execution time reduction for
> 'git diff-tree' using a sparse index:
> 
> Test                                                before  after
> ------------------------------------------------------------------------
> 2000.94: git diff-tree HEAD (full-v3)                0.05   0.04 -20.0%
> 2000.95: git diff-tree HEAD (full-v4)                0.06   0.05 -16.7%
> 2000.96: git diff-tree HEAD (sparse-v3)              0.59   0.01 -98.3%
> 2000.97: git diff-tree HEAD (sparse-v4)              0.61   0.01 -98.4%
> 2000.98: git diff-tree HEAD -- f2/f4/a (full-v3)     0.05   0.05 +0.0%
> 2000.99: git diff-tree HEAD -- f2/f4/a (full-v4)     0.05   0.04 -20.0%
> 2000.100: git diff-tree HEAD -- f2/f4/a (sparse-v3)  0.58   0.01 -98.3%
> 2000.101: git diff-tree HEAD -- f2/f4/a (sparse-v4)  0.55   0.01 -98.2%

These performance results look great! This is generally what we'd expect,
too, since 'diff-tree' should be fast enough that index expansion is the
majority of its runtime.

> 
> Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
> ---
>  builtin/diff-tree.c                      |  4 ++
>  t/perf/p2000-sparse-operations.sh        |  2 +
>  t/t1092-sparse-checkout-compatibility.sh | 62 ++++++++++++++++++++++++
>  3 files changed, 68 insertions(+)
> 
> diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
> index 385c2d0230..c5d5730ebf 100644
> --- a/builtin/diff-tree.c
> +++ b/builtin/diff-tree.c
> @@ -121,6 +121,10 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
>  		usage(diff_tree_usage);
>  
>  	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
> +
> +	prepare_repo_settings(the_repository);
> +	the_repository->settings.command_requires_full_index = 0;

tl;dr: this does appear to be all you need to integrate the sparse index
with 'diff-tree', although there's an opportunity to clean up some
(seemingly) unused code to make that clearer.
 
Longer version: 

Looking at the documentation for 'diff-tree', it's not immediately obvious
why we'd need the index at all - it "[c]ompares the content and mode of
blobs found via two tree objects," per the command documentation. However,
the index is read in 'cmd_diff_tree' at two points, so to be reasonably
certain that this sparse index integration is correct we should verify that
the intended usage associated with those two reads will still work with a
sparse index.

Reading the index for attributes
================================
The first index read was added in fd66bcc31ff (diff-tree: read the index so
attribute checks work in bare repositories, 2017-12-06) to deal with reading
'.gitattributes' content. Per the 'gitattributes.txt' documentation:

"Git consults `$GIT_DIR/info/attributes` file (which has the highest
precedence), `.gitattributes` file in the same directory as the path in
question, and its parent directories up to the toplevel of the work
tree...When the `.gitattributes` file is missing from the work tree, the
path in the index is used as a fall-back."

However, 77efbb366ab (attr: be careful about sparse directories, 2021-09-08)
established that, in a sparse index, we do _not_ try to load a
'.gitattributes' file from within a sparse directory. Therefore, we don't
need to expand the index or change anything about reading attributes in
'diff-tree'. Good!

Reading the index for rename detection(?)
=========================================
The second one is read only on the condition that we're reading from stdin:

if (opt->diffopt.detect_rename) {
	if (!the_index.cache)
		repo_read_index(the_repository);
	opt->diffopt.setup |= DIFF_SETUP_USE_SIZE_CACHE;
}

This was initially added in f0c6b2a2fd9 ([PATCH] Optimize diff-tree -[CM]
--stdin, 2005-05-27), where 'setup' was set to 'DIFF_SETUP_USE_SIZE_CACHE |
DIFF_SETUP_USE_CACHE'. That assignment was later modified to drop the
'DIFF_SETUP_USE_CACHE' in ff7fe37b053 (diff.c: move read_index() code back
to the caller, 2018-08-13). 

However, 'DIFF_SETUP_USE_SIZE_CACHE' seems to be unused as of 6e0b8ed6d35
(diff.c: do not use a separate "size cache"., 2007-05-07) and nothing about
'detect_rename' otherwise indicates index usage, so AFAICT that whole
condition can be dropped (along with DIFF_SETUP_USE_SIZE_CACHE,
DIFF_SETUP_REVERSE, and diff_options.setup). Note that, if you want to make
that change in this series, it should be done in a separate patch _before_
this one (since dropping the deprecated setup infrastructure isn't really
part of the sparse index integration).

> +
>  	repo_init_revisions(the_repository, opt, prefix);
>  	if (repo_read_index(the_repository) < 0)
>  		die(_("index file corrupt"));
> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
> index 60d1de0662..14caf01718 100755
> --- a/t/perf/p2000-sparse-operations.sh
> +++ b/t/perf/p2000-sparse-operations.sh
> @@ -129,5 +129,7 @@ test_perf_on_all git grep --cached bogus -- "f2/f1/f1/*"
>  test_perf_on_all git write-tree
>  test_perf_on_all git describe --dirty
>  test_perf_on_all 'echo >>new && git describe --dirty'
> +test_perf_on_all git diff-tree HEAD
> +test_perf_on_all git diff-tree HEAD -- $SPARSE_CONE/a

These tests cover both the whole tree & a specific pathspec, looks good.

>  
>  test_done
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 0c784813f1..f08edcbf8e 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -2108,4 +2108,66 @@ test_expect_success 'sparse-index is not expanded: write-tree' '
>  	ensure_not_expanded write-tree
>  '
>  
> +test_expect_success 'diff-tree' '
> +	init_repos &&
> +
> +	write_script edit-contents <<-\EOF &&
> +	echo text >>"$1"
> +	EOF
> +
> +	# Get the tree SHA for the current HEAD
> +	tree1=$(git -C sparse-index rev-parse HEAD^{tree}) &&
> +
> +	# make a change inside the sparse cone
> +	run_on_all ../edit-contents deep/a &&
> +	test_all_match git add deep/a &&
> +	test_all_match git commit -m "Change deep/a" &&
> +
> +	# Get the tree SHA for the new HEAD
> +	tree2=$(git -C sparse-index rev-parse HEAD^{tree}) &&

Commits with changes similar to what you create here here already exist in
the test repo; you can simplify the test by using them:

test_expect_success 'diff-tree' '
        init_repos &&

        # Test change inside sparse cone
        test_all_match git diff-tree HEAD update-deep &&
        test_all_match git diff-tree HEAD update-deep -- deep/a &&

        # Test change outside sparse cone
        test_all_match git diff-tree HEAD update-folder1 &&
        test_all_match git diff-tree HEAD update-folder1 -- folder1/a &&

	# Check that SKIP_WORKTREE files are not materialized
	test_path_is_missing sparse-checkout/folder1/a &&
	test_path_is_missing sparse-index/folder1/a
'

This also has the benefit of avoiding the creation of 'folder1/a' on disk in
the sparse-checkout test repos.

> +
> +

nit: extra newline should be removed

> +	test_all_match git diff-tree $tree1 $tree2 &&
> +	test_all_match git diff-tree HEAD &&
> +	test_all_match git diff-tree HEAD -- deep/a &&

You don't have a wildcard pathspec tested here, but I think that's okay in
this case; unlike e.g. 'git grep', there's no sparse index-related behavior
here that depends on the pathspec's contents.

> +
> +	# make a change outside the sparse cone
> +	run_on_all mkdir -p folder1 &&
> +	run_on_all cp a folder1/a &&
> +	run_on_all ../edit-contents folder1/a &&
> +	test_all_match git update-index folder1/a &&

'update-index' will work here, but I think using the more porcelain command
'add --sparse' might be better for demonstrating typical user behavior.

> +	test_all_match git commit -m "Change folder1/a" &&
> +
> +	# Get the tree SHA for the new HEAD
> +	tree3=$(git -C sparse-index rev-parse HEAD^{tree}) &&
> +
> +	test_all_match git diff-tree $tree1 $tree3 &&
> +	test_all_match git diff-tree $tree1 $tree3 -- folder1/a &&
> +	test_all_match git diff-tree HEAD &&
> +	test_all_match git diff-tree HEAD -- folder1/a &&
> +
> +	# check that SKIP_WORKTREE files are not materialized
> +	test_path_is_missing sparse-checkout/folder2/a &&
> +	test_path_is_missing sparse-index/folder2/a

At first I wasn't sure about whether these checks were necessary (we don't
'diff-tree' on any 'folder2/' pathspec), but this check verifies that we
don't materialize the files in the case with no pathspec. While that's
unlikely to happen, it doesn't hurt to have this test to be sure.

> +'
> +
> +test_expect_success 'sparse-index is not expanded: diff-tree' '
> +	init_repos &&
> +
> +	# Get the tree SHA for the current HEAD
> +	tree1=$(git -C sparse-index rev-parse HEAD^{tree}) &&

As with the previous test, you can use the 'update-deep' and
'update-folder1' branches to simplify here.

> +
> +	echo "test1" >>sparse-index/deep/a &&
> +	git -C sparse-index add deep/a &&
> +	git -C sparse-index commit -m "Change deep/a" &&
> +
> +	# Get the tree SHA for the new HEAD
> +	tree2=$(git -C sparse-index rev-parse HEAD^{tree}) &&
> +
> +	ensure_not_expanded diff-tree $tree1 $tree2 &&
> +	ensure_not_expanded diff-tree $tree1 $tree2 -- deep/a &&
> +	ensure_not_expanded diff-tree HEAD &&
> +	ensure_not_expanded diff-tree HEAD -- deep/a

Since the index won't expand regardless of whether you 'diff-tree'
a file inside or outside the cone, it'd be nice to have a test like:

ensure_not_expanded diff-tree update-folder1 &&
ensure_not_expanded diff-tree update-folder1 -- folder1/a

> +'
> +
>  test_done

