Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE871C433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 10:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbhL1K6A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 05:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbhL1K6A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 05:58:00 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F2FC061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 02:57:59 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q16so37616655wrg.7
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 02:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cAQDgonTikS2L9d+hfRzbNh+Ce+SU62FX0PtZX37nHo=;
        b=iMMxPrdkB5vzWuRQqveX4QMSZ5q+N/3hbTb6u4dsxnUgGLtVU6WHhyUUDS9JGHc7ha
         viP510HtQ3thfrV1opy5rauJdMf+r1LYhL9gnrB0e7zwATxgtAt3ViGWgR+qvYUu1vjA
         5wbPa82HsZzNPeN2Cs7Ywsgtkb8rkgjRVk6CtwQyVmZUDGf0JZN6EjDMY67/1pT3MQ6H
         1ZqYIkEnfVAa3jXRAGDCCvpVhQUcAhoWeqXDeFDuZ2+m7nCCv5o0o5KRQvxRmQz4iYjW
         f4HpO+KLokOOpyzk3M1i+Mu2fNjBaC2I1uyDiQrPQn8fE175Ai+W+jpfQ3PAfUD0SH44
         KvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cAQDgonTikS2L9d+hfRzbNh+Ce+SU62FX0PtZX37nHo=;
        b=MsU0XIRcdEnaq/LJSyiapYSxGio0pvrcIA6pHJSvzQuJpY0aX53OOppu1tPqDMujX8
         PMeDbbSA21gNm+UPETl96S9bJybAMyLx8j3H0o6cUgKy97YkSSFqTjC91bgwMyf7cFMT
         Jcf8m8FAgYAyR5TAqhIXI9265lZc0xAFJjxrDnfLy2yKoUZXZgheyTKMO/qsUejDWh7b
         F5ftZpm+85cPMJa/5zNbMw39O8PWnF9YZFoMbBmW1CmgOkiA3t4dGcOo+CkZiHrJNsLR
         dlcsVO83FiYhFDXE/Fmo7yfTFH568LHuOgzdCZf3repdHBMOfnaaoeGK3QR14tO3dqK9
         SYcg==
X-Gm-Message-State: AOAM533urii1k+/eCCgiMdpPrWxQEk0O5a4sk1ckmSGgn5Hhodz0k8bi
        r9M+ofQYewnJqWCtSTjKn+k=
X-Google-Smtp-Source: ABdhPJzXNE2UXXfXzjKTdGzzjHQwFCF16HTE1HtqkbQacrFFGRsH2buUQoOlq7N1m7mSRqoTC+E6jw==
X-Received: by 2002:adf:d0c1:: with SMTP id z1mr16071362wrh.215.1640689078046;
        Tue, 28 Dec 2021 02:57:58 -0800 (PST)
Received: from gmail.com (62-47-14-33.adsl.highway.telekom.at. [62.47.14.33])
        by smtp.gmail.com with ESMTPSA id e12sm19026616wrg.110.2021.12.28.02.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 02:57:57 -0800 (PST)
Date:   Tue, 28 Dec 2021 11:57:55 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Subject: Re: [PATCH v2 8/8] show, log: include conflict/warning messages in
 --remerge-diff headers
Message-ID: <20211228105755.zgahkoxn6ewjpdol@gmail.com>
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
 <4cc53c55a6ea1531342b23bc9343890a576d9f1c.1640419160.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cc53c55a6ea1531342b23bc9343890a576d9f1c.1640419160.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 25, 2021 at 07:59:19AM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Conflicts such as modify/delete, rename/rename, or file/directory are
> not representable via content conflict markers, and the normal output
> messages notifying users about these were dropped with --remerge-diff.
> While we don't want these messages randomly shown before the commit
> and diff headers, we do want them to still be shown; include them as
> part of the diff headers instead.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  log-tree.c              |  3 ++
>  merge-ort.c             |  1 +
>  merge-ort.h             | 10 +++++
>  t/t4069-remerge-diff.sh | 86 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 100 insertions(+)
> 
> diff --git a/log-tree.c b/log-tree.c
> index 33c28f537a6..97fbb756d21 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -922,6 +922,7 @@ static int do_remerge_diff(struct rev_info *opt,
>  	/* Setup merge options */
>  	init_merge_options(&o, the_repository);
>  	o.show_rename_progress = 0;
> +	o.record_conflict_msgs_as_headers = 1;
>  
>  	ctx.abbrev = DEFAULT_ABBREV;
>  	format_commit_message(parent1, "%h (%s)", &parent1_desc, &ctx);
> @@ -938,10 +939,12 @@ static int do_remerge_diff(struct rev_info *opt,
>  	merge_incore_recursive(&o, bases, parent1, parent2, &res);
>  
>  	/* Show the diff */
> +	opt->diffopt.additional_path_headers = res.path_messages;
>  	diff_tree_oid(&res.tree->object.oid, oid, "", &opt->diffopt);
>  	log_tree_diff_flush(opt);
>  
>  	/* Cleanup */
> +	opt->diffopt.additional_path_headers = NULL;
>  	strbuf_release(&parent1_desc);
>  	strbuf_release(&parent2_desc);
>  	merge_finalize(&o, &res);
> diff --git a/merge-ort.c b/merge-ort.c
> index 9142d56e0ad..07e53083cbd 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -4579,6 +4579,7 @@ redo:
>  	trace2_region_leave("merge", "process_entries", opt->repo);
>  
>  	/* Set return values */
> +	result->path_messages = &opt->priv->output;
>  	result->tree = parse_tree_indirect(&working_tree_oid);
>  	/* existence of conflicted entries implies unclean */
>  	result->clean &= strmap_empty(&opt->priv->conflicted);
> diff --git a/merge-ort.h b/merge-ort.h
> index c011864ffeb..fe599b87868 100644
> --- a/merge-ort.h
> +++ b/merge-ort.h
> @@ -5,6 +5,7 @@
>  
>  struct commit;
>  struct tree;
> +struct strmap;
>  
>  struct merge_result {
>  	/*
> @@ -23,6 +24,15 @@ struct merge_result {
>  	 */
>  	struct tree *tree;
>  
> +	/*
> +	 * Special messages and conflict notices for various paths
> +	 *
> +	 * This is a map of pathnames to strbufs.  It contains various
> +	 * warning/conflict/notice messages (possibly multiple per path)
> +	 * that callers may want to use.
> +	 */
> +	struct strmap *path_messages;
> +
>  	/*
>  	 * Additional metadata used by merge_switch_to_result() or future calls
>  	 * to merge_incore_*().  Includes data needed to update the index (if
> diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
> index 192dbce2bfe..a040d3bcd91 100755
> --- a/t/t4069-remerge-diff.sh
> +++ b/t/t4069-remerge-diff.sh
> @@ -4,6 +4,15 @@ test_description='remerge-diff handling'
>  
>  . ./test-lib.sh
>  
> +# --remerge-diff uses ort under the hood regardless of setting.  However,
> +# we set up a file/directory conflict beforehand, and the different backends
> +# handle the conflict differently, which would require separate code paths
> +# to resolve.  There's not much point in making the code uglier to do that,
> +# though, when the real thing we are testing (--remerge-diff) will hardcode
> +# calls directly into the merge-ort API anyway.  So just force the use of
> +# ort on the setup too.
> +GIT_TEST_MERGE_ALGORITHM=ort
> +
>  test_expect_success 'setup basic merges' '
>  	test_write_lines 1 2 3 4 5 6 7 8 9 >numbers &&
>  	git add numbers &&
> @@ -55,6 +64,7 @@ test_expect_success 'remerge-diff with both a resolved conflict and an unrelated
>  	git log -1 --oneline ab_resolution >tmp &&
>  	cat <<-EOF >>tmp &&
>  	diff --git a/numbers b/numbers
> +	CONFLICT (content): Merge conflict in numbers
>  	index a1fb731..6875544 100644
>  	--- a/numbers
>  	+++ b/numbers
> @@ -83,4 +93,80 @@ test_expect_success 'remerge-diff with both a resolved conflict and an unrelated
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'setup non-content conflicts' '
> +	git switch --orphan base &&
> +
> +	test_write_lines 1 2 3 4 5 6 7 8 9 >numbers &&
> +	test_write_lines a b c d e f g h i >letters &&
> +	test_write_lines in the way >content &&
> +	git add numbers letters content &&
> +	git commit -m base &&
> +
> +	git branch side1 &&
> +	git branch side2 &&
> +
> +	git checkout side1 &&
> +	test_write_lines 1 2 three 4 5 6 7 8 9 >numbers &&
> +	git mv letters letters_side1 &&
> +	git mv content file_or_directory &&
> +	git add numbers &&
> +	git commit -m side1 &&
> +
> +	git checkout side2 &&
> +	git rm numbers &&
> +	git mv letters letters_side2 &&
> +	mkdir file_or_directory &&
> +	echo hello >file_or_directory/world &&
> +	git add file_or_directory/world &&
> +	git commit -m side2 &&
> +
> +	git checkout -b resolution side1 &&
> +	test_must_fail git merge side2 &&
> +	test_write_lines 1 2 three 4 5 6 7 8 9 >numbers &&
> +	git add numbers &&
> +	git add letters_side1 &&
> +	git rm letters &&
> +	git rm letters_side2 &&
> +	git add file_or_directory~HEAD &&
> +	git mv file_or_directory~HEAD wanted_content &&
> +	git commit -m resolved
> +'
> +
> +test_expect_success 'remerge-diff with non-content conflicts' '
> +	git log -1 --oneline resolution >tmp &&
> +	cat <<-EOF >>tmp &&
> +	diff --git a/file_or_directory~HASH (side1) b/wanted_content

the "~HASH (side1)" suffix will probably mess with some programs that extract
the filename from the diff.
I don't know what programs are supposed to expect.  I can see arguments for
either dropping the suffix or including only "~HASH" since that's part of
the actual filename that's left in the worktree.
Maybe it's not so important.

The file/link typechange conflict test I'll add below exposes what looks
like an accidental interaction with the trailing tab characters that we emit
on --- and +++ lines if the "filename" contains a space (since 1a9eb3b9d5
(git-diff/git-apply: make diff output a bit friendlier to GNU patch (part
2), 2006-09-22)).

	index 70885e4..0000000
	--- a/typechange~738109f (side1)	<-- git diff adds a trailing tab!
	+++ /dev/null

I haven't formed an opinion yet, but since Tig uses the --- and +++ lines
to extract file names, I'd drop the " (side1)" suffix from at least the ---
and +++ lines. Maybe also the ^diff lines, I'm not sure

> +	similarity index 100%
> +	rename from file_or_directory~HASH (side1)
> +	rename to wanted_content
> +	CONFLICT (file/directory): directory in the way of file_or_directory from HASH (side1); moving it to file_or_directory~HASH (side1) instead.

I wonder if it's better to have this line further up, before the "rename"
resolution, to correct the temporal order.

> +	diff --git a/letters b/letters
> +	CONFLICT (rename/rename): letters renamed to letters_side1 in HASH (side1) and to letters_side2 in HASH (side2).
> +	diff --git a/letters_side2 b/letters_side2
> +	deleted file mode 100644
> +	index b236ae5..0000000
> +	--- a/letters_side2
> +	+++ /dev/null
> +	@@ -1,9 +0,0 @@
> +	-a
> +	-b
> +	-c
> +	-d
> +	-e
> +	-f
> +	-g
> +	-h
> +	-i
> +	diff --git a/numbers b/numbers
> +	CONFLICT (modify/delete): numbers deleted in HASH (side2) and modified in HASH (side1).  Version HASH (side1) of numbers left in tree.
> +	EOF

Took me some time to grok these but the output makes sense (it's loud and
ugly but that's okay since these are serious conflicts).

> +	# We still have some sha1 hashes above; rip them out so test works
> +	# with sha256
> +	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&
> +
> +	git show --oneline --remerge-diff resolution >tmp &&
> +	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> -- 
> gitgitgadget

We're missing a test case for typechange.  Here's is a quick draft I've been
playing around with. Seems ugly that the "diff --git a/typechange b/typechange"
is doubled but okay.

Maybe a rename/delete conflict is interesting as well, I'm not sure.  (Also I
wonder if switching the order of parents will give any interesting difference,
I guess not)

test_expect_success 'remerge-diff with file/link conflict' '
	git branch -d base side1 side2 &&
	git switch --orphan base &&

	echo base >typechange &&
	git add typechange &&
	git commit -m base &&

	git branch side1 &&
	git branch side2 &&

	git checkout side1 &&
	echo orig-file-contents >typechange &&
	git commit -a -m side1 &&

	git checkout side2 &&
	ln -sf . typechange &&
	git add typechange &&
	git commit -m side2 &&

	git checkout -b resolution2 side1 &&
	test_must_fail git merge side2 &&
	rm typechange &&
	mv typechange~HEAD typechange &&
	echo resolved >>typechange &&
	git add typechange~HEAD typechange &&
	git merge --continue &&

	git show --oneline --remerge-diff resolution2 >tmp &&
	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&

	cat <<-EOF >tmp &&
	7759b27 Merge branch ${SQ}side2${SQ} into resolution2
	diff --git a/typechange b/typechange
	deleted file mode 120000
	CONFLICT (distinct types): typechange had different types on each side; renamed one of them so each can be recorded somewhere.
	index 945c9b4..0000000
	--- a/typechange
	+++ /dev/null
	@@ -1 +0,0 @@
	-.
	\ No newline at end of file
	diff --git a/typechange b/typechange
	new file mode 100644
	CONFLICT (distinct types): typechange had different types on each side; renamed one of them so each can be recorded somewhere.
	index 0000000..70885e4
	--- /dev/null
	+++ b/typechange
	@@ -0,0 +1,2 @@
	+orig-file-contents
	+resolved
	diff --git a/typechange~738109f (side1) b/typechange~738109f (side1)
	deleted file mode 100644
	index 70885e4..0000000
	--- a/typechange~738109f (side1)	
	+++ /dev/null
	@@ -1 +0,0 @@
	-orig-file-contents
	EOF
	# We still have some sha1 hashes above; rip them out so test works
	# with sha256
	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&

	test_cmp expect actual
'
