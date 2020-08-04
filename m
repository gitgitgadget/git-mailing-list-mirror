Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F64C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 14:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E91D208A9
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 14:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nx/A7bfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgHDOrn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729303AbgHDOre (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 10:47:34 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AAFC061756
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 07:47:33 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a21so42726381ejj.10
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 07:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FvBfltD5PKqCFsuc3BHaSWeg0YLfde9jOjmgpH/cPY0=;
        b=Nx/A7bfVYyf2RW9RuC1ZC6Wi5wVwDFZqcsoBE/8SwKhjTnEcpj/Il3NhzfBQiP4GxV
         Hr5+R8n/4Ix6WhT1d6q+zt1LClRkd/5Vwml3K28U82GfABKiyN7qGGV8rKc0CF+7VYgF
         ct/m6v6KutVYZJO4Mo0glIRMX2cCO5XfqrLHZfkXPiGZksJv1tfeWh5K4Qm9CHxGrRy6
         HAh/C/TsfaV2O9TeIRV0ZJZsbRSSkfkkOI54nuxuiMo0s66+KxvQq3HISyEnlpdOJSnv
         7o6+ac9A4zSPgfV2FbzYbPpGUP1e3P45O9d3GhHwxUS3r+Wy3SIaERo4J22uTjDRp3me
         cSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FvBfltD5PKqCFsuc3BHaSWeg0YLfde9jOjmgpH/cPY0=;
        b=SHoxn743NC3wbQu4QikB78ykhlrZ/Pr6Rbf0CrsGkeKf5U4b9jl/Gkz7TtTz8QtZPE
         1Or+Vl6tW3Rxp1hRHZhhZHGzDDMpF5YxEfWAQ6mgFnMwdXdQXN1Lh4PCl+2zZo0w/5gb
         4L8SNduXAAnQXcxP1ipneOdbV0XNQY6/BcRBRtXdTLXleGu76xMdOnsG9Y8gjgTBVRXh
         oTZGM5Ypq1Ui/N3dUZtRyLqchbnhr0JoKMCBV6zRGPKTy73JkzozhY1JePhjcR5S9/NQ
         mY3DXdo6U72XajwlnSCxX0ZG9P5c1YdWn3mf0F6XKirCz31dhdVFZnFDsHPHmNFLNA5u
         R49g==
X-Gm-Message-State: AOAM531fFu9h+BsXQ3fzip2Y2urQtpo5QmrJdn4stpJcmweFHanf3fcb
        m4KX5AmzI59tzU8iSxboSSs=
X-Google-Smtp-Source: ABdhPJzPIheUmMxrxKk3G5ScoYgjxDUYOAMtSLJLLMWhn5J/1h2MeN5H06gJb2QBer1ef5jLLRMK2A==
X-Received: by 2002:a17:906:d159:: with SMTP id br25mr21307847ejb.16.1596552452700;
        Tue, 04 Aug 2020 07:47:32 -0700 (PDT)
Received: from szeder.dev (94-21-29-171.pool.digikabel.hu. [94.21.29.171])
        by smtp.gmail.com with ESMTPSA id b18sm18770094ejc.41.2020.08.04.07.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 07:47:31 -0700 (PDT)
Date:   Tue, 4 Aug 2020 16:47:24 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 05/15] diff: halt tree-diff early after max_changes
Message-ID: <20200804144724.GA25052@szeder.dev>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
 <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
 <2d4c0b2da38632424c8bd31ccb2037e0676c3c74.1586192395.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d4c0b2da38632424c8bd31ccb2037e0676c3c74.1586192395.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 06, 2020 at 04:59:45PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> When computing the changed-paths bloom filters for the commit-graph,
> we limit the size of the filter by restricting the number of paths
> in the diff. Instead of computing a large diff and then ignoring the
> result, it is better to halt the diff computation early.
> 
> Create a new "max_changes" option in struct diff_options. If non-zero,
> then halt the diff computation after discovering strictly more changed
> paths. This includes paths corresponding to trees that change.
> 
> Use this max_changes option in the bloom filter calculations. This
> reduces the time taken to compute the filters for the Linux kernel
> repo from 2m50s to 2m35s. On a large internal repository with ~500
> commits that perform tree-wide changes, the time reduced from
> 6m15s to 3m48s.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  bloom.c     | 4 +++-
>  diff.h      | 5 +++++
>  tree-diff.c | 6 ++++++
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/bloom.c b/bloom.c
> index 881a9841ede..a16eee92331 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -133,6 +133,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
>  	struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
>  	int i;
>  	struct diff_options diffopt;
> +	int max_changes = 512;
>  
>  	if (bloom_filters.slab_size == 0)
>  		return NULL;
> @@ -141,6 +142,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
>  
>  	repo_diff_setup(r, &diffopt);
>  	diffopt.flags.recursive = 1;
> +	diffopt.max_changes = max_changes;
>  	diff_setup_done(&diffopt);
>  
>  	if (c->parents)
> @@ -149,7 +151,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
>  		diff_tree_oid(NULL, &c->object.oid, "", &diffopt);
>  	diffcore_std(&diffopt);
>  
> -	if (diff_queued_diff.nr <= 512) {
> +	if (diff_queued_diff.nr <= max_changes) {
>  		struct hashmap pathmap;
>  		struct pathmap_hash_entry *e;
>  		struct hashmap_iter iter;
> diff --git a/diff.h b/diff.h
> index 6febe7e3656..9443dc1b003 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -285,6 +285,11 @@ struct diff_options {
>  	/* Number of hexdigits to abbreviate raw format output to. */
>  	int abbrev;
>  
> +	/* If non-zero, then stop computing after this many changes. */
> +	int max_changes;
> +	/* For internal use only. */
> +	int num_changes;

"For internal use only", understood.

> +
>  	int ita_invisible_in_index;
>  /* white-space error highlighting */
>  #define WSEH_NEW (1<<12)
> diff --git a/tree-diff.c b/tree-diff.c
> index 33ded7f8b3e..f3d303c6e54 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -434,6 +434,9 @@ static struct combine_diff_path *ll_diff_tree_paths(
>  		if (diff_can_quit_early(opt))
>  			break;
>  
> +		if (opt->max_changes && opt->num_changes > opt->max_changes)
> +			break;
> +
>  		if (opt->pathspec.nr) {
>  			skip_uninteresting(&t, base, opt);
>  			for (i = 0; i < nparent; i++)
> @@ -518,6 +521,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
>  
>  			/* t↓ */
>  			update_tree_entry(&t);
> +			opt->num_changes++;
>  		}
>  
>  		/* t > p[imin] */
> @@ -535,6 +539,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
>  		skip_emit_tp:
>  			/* ∀ pi=p[imin]  pi↓ */
>  			update_tp_entries(tp, nparent);
> +			opt->num_changes++;
>  		}
>  	}

This counter is basically broken, its value is wrong for over 98% of
commits, and, worse, its value remains 0 for over 85% of commits in
the repositories I usually use to test modified path Bloom filters.
Consequently, a relatively large number of commits modifying more than
512 paths get Bloom filters.

The makeshift tests in the patch below demonstrate these issues as
most of them fail, most notably those two tests that demonstrate that
modifying existing paths are not counted at all.


  ---  >8  ---

diff --git a/bloom.c b/bloom.c
index 9b86aa3f59..3db0fde734 100644
--- a/bloom.c
+++ b/bloom.c
@@ -203,7 +203,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 	repo_diff_setup(r, &diffopt);
 	diffopt.flags.recursive = 1;
 	diffopt.detect_rename = 0;
-	diffopt.max_changes = max_changes;
+	diffopt.max_changes = 0;
 	diff_setup_done(&diffopt);
 
 	/* ensure commit is parsed so we have parent information */
@@ -214,6 +214,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 	else
 		diff_tree_oid(NULL, &c->object.oid, "", &diffopt);
 	diffcore_std(&diffopt);
+	printf("%s  %d\n", oid_to_hex(&c->object.oid), diffopt.num_changes);
 
 	if (diffopt.num_changes <= max_changes) {
 		struct hashmap pathmap;
diff --git a/t/t9999-test.sh b/t/t9999-test.sh
new file mode 100755
index 0000000000..8d2bd9f03f
--- /dev/null
+++ b/t/t9999-test.sh
@@ -0,0 +1,142 @@
+#!/bin/sh
+
+test_description='test'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_tick &&
+
+	echo 1 >file &&
+	mkdir -p dir/subdir &&
+	echo 1 >dir/subdir/file1 &&
+	echo 1 >dir/subdir/file2 &&
+	git add file dir &&
+	git commit -m setup &&
+
+	echo 2 >file &&
+	git commit -a -m "modify one path in root" &&
+	mod_one_path=$(git rev-parse HEAD) &&
+
+	echo 2 >dir/subdir/file1 &&
+	echo 2 >dir/subdir/file2 &&
+	git commit -a -m "modify two file two dirs deep" &&
+	mod_four_paths=$(git rev-parse HEAD) &&
+
+	>new-file &&
+	git add new-file &&
+	git commit -m "add new file in root" &&
+	new_file_in_root=$(git rev-parse HEAD) &&
+
+	git rm new-file &&
+	git commit -m "delete file in root" &&
+	delete_file_in_root=$(git rev-parse HEAD) &&
+
+	>dir/new-file &&
+	git add dir/new-file &&
+	git commit -m "add new file in dir" &&
+	new_file_in_dir=$(git rev-parse HEAD) &&
+
+	git rm dir/new-file &&
+	git commit -m "delete file in dir" &&
+	delete_file_in_dir=$(git rev-parse HEAD) &&
+
+	echo 1 >d-f &&
+	git add d-f &&
+	git commit -m foo &&
+	git rm d-f &&
+	mkdir d-f &&
+	echo 2 >d-f/file &&
+	git add d-f &&
+	git commit -m "replace file with dir" &&
+	file_to_dir=$(git rev-parse HEAD) &&
+
+	>d-f.c &&
+	git add d-f.c &&
+	git commit -m "add a file that sorts between d-f and d-f/" &&
+	git rm -r d-f &&
+	echo 3 >d-f &&
+	git add d-f &&
+	git commit -m "replace dir with file" &&
+	dir_to_file=$(git rev-parse HEAD) &&
+
+	bin_sha1=$(git rev-parse HEAD:dir/subdir | hex2oct) &&
+	# leading zero in mode: the content of the tree remains the same,
+	# but its oid does change!
+	printf "040000 subdir\0$bin_sha1" >rawtree &&
+	tree1=$(git hash-object -t tree -w rawtree) &&
+	git cat-file -p HEAD^{tree} >out &&
+	tree2=$(sed -e "s/$(git rev-parse HEAD:dir/)/$tree1/" out |git mktree) &&
+	different_but_same_tree=$(git commit-tree \
+		-m "leading zeros in mode" \
+		-p $(git rev-parse HEAD) $tree2) &&
+	git update-ref HEAD $different_but_same_tree &&
+
+	git commit-graph write --reachable --changed-paths >out &&
+	cat out  # debug
+'
+
+test_expect_success 'modify one path in root' '
+	git diff --name-status $mod_one_path^ $mod_one_path &&
+	echo "$mod_one_path  1" >expect &&
+	grep "$mod_one_path" out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'modify two file two dirs deep' '
+	git diff --name-status $mod_four_paths^ $mod_four_paths &&
+	echo "$mod_four_paths  4" >expect &&
+	grep "$mod_four_paths" out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'add new file in root' '
+	git diff --name-status $new_file_in_root^ $new_file_in_root &&
+	echo "$new_file_in_root  1" >expect &&
+	grep "$new_file_in_root" out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'delete file in root' '
+	git diff --name-status $delete_file_in_root^ $delete_file_in_root &&
+	echo "$delete_file_in_root  1" >expect &&
+	grep "$delete_file_in_root" out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'add new file in dir' '
+	git diff --name-status $new_file_in_dir^ $new_file_in_dir &&
+	echo "$new_file_in_dir  2" >expect &&
+	grep "$new_file_in_dir" out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'delete file in dir' '
+	git diff --name-status $delete_file_in_dir^ $delete_file_in_dir &&
+	echo "$delete_file_in_dir  2" >expect &&
+	grep "$delete_file_in_dir" out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'replace file with dir' '
+	git diff --name-status $file_to_dir^ $file_to_dir &&
+	echo "$file_to_dir  2" >expect &&
+	grep "$file_to_dir" out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'replace dir with file' '
+	git diff --name-status $dir_to_file^ $dir_to_file &&
+	echo "$dir_to_file  2" >expect &&
+	grep "$dir_to_file" out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'leading zeros in mode' '
+	git diff --name-status $different_but_same_tree^ $different_but_same_tree &&
+	echo "$different_but_same_tree  0" >expect &&
+	grep "$different_but_same_tree" out >actual &&
+	test_cmp expect actual
+'
+
+test_done

  ---  >8  ---


> @@ -552,6 +557,7 @@ struct combine_diff_path *diff_tree_paths(
>  	const struct object_id **parents_oid, int nparent,
>  	struct strbuf *base, struct diff_options *opt)
>  {
> +	opt->num_changes = 0;
>  	p = ll_diff_tree_paths(p, oid, parents_oid, nparent, base, opt);
>  
>  	/*
> -- 
> gitgitgadget
> 
