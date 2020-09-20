Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34CCC4346A
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 11:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D78B20EDD
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 11:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXcd/xW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgITLWt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 07:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgITLWq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 07:22:46 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463CEC0613D3
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 04:22:45 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mm21so5697332pjb.4
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 04:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I2qSGXT9rPfIcl/5fhUk+xVgkaraVpv7E8dIYLbpOqk=;
        b=OXcd/xW8gFQVNdpLbNBYj+YiUWAjxw/w7kxJsxJawW8YAbeELKIFDJd1nnKtzsbjkU
         7KeHsRVjxrMNjjOZU9Lanx3XUW+x96hYhmhydBzC5HIsOGzW/IQFLXQLy3l2/k7GqRsm
         uSWeHHwtly+nZ2PehfjgrzeXBBAJ2t6ytd1FYerssbjuc0a9K6/Gkraa+NwWUw1GVqQ8
         qUCk4x83kdiTEuElJF/bn/UCTalWP1MXJLKb9uDnXNr5PyZPXFRqrj/FPqaGKdnbrx9P
         N3hakJA8duIM26G4FRJOZ1OLPPfWGG+PUvL4S11Xg3vV7AzTpMqzHuTzTbLvMY6Z4qWS
         iJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I2qSGXT9rPfIcl/5fhUk+xVgkaraVpv7E8dIYLbpOqk=;
        b=nWEJYYsz/1P91e+G721+5AoCjK6ni1Ect4kb4CEpWUyldkXle/uZt3MgQOKo1pOVbf
         eJ9pZx+JKMzW99/pYNmHfi23xthRWNQaSqwMurmogpQ4BiSeebcDruV2xT7LNAKGPHZ1
         eJJzJq0rSbEJ/uCoJMjrWHJGbZXe7NSkl57CqxhOendBN5yKWZp+r/zZFrdAGhwAMO/p
         2uWVWYAmJ59gdfVWkyRQgIyqZJORKKt4FlAWuiwUncr8oW2MIaOKN3PX9lgcSvEs/c+A
         75IgeRJ+o/XmGSTgiKSuyNGKsobgxsQQqgPc1goixQ1AQl9mCEDyAquykV15XBOEElLg
         I62w==
X-Gm-Message-State: AOAM530GhjeJX5Bvd+YaxNVgeJBo8i2wbo3X09/UZfdFwjgHmcJDoBC8
        TNfUOw/AthphT43pX9HDtSyXrI55xAs=
X-Google-Smtp-Source: ABdhPJztIgB11hQW3O/1NAkown6GyFIP0ifO9hrn+cZJX7hUVwwGkIU3WAbNoAUsqUCd80G5kk5IfA==
X-Received: by 2002:a17:90a:65c5:: with SMTP id i5mr18388219pjs.112.1600600964423;
        Sun, 20 Sep 2020 04:22:44 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id y79sm9550737pfb.45.2020.09.20.04.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 04:22:43 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 08/10] builtin/diff-index: learn --merge-base
Date:   Sun, 20 Sep 2020 04:22:25 -0700
Message-Id: <f54baa4ecd495026c2fce1772b560b7bbbeecc04.1600600823.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.760.g8d73e04208
In-Reply-To: <cover.1600600823.git.liu.denton@gmail.com>
References: <cover.1600328335.git.liu.denton@gmail.com> <cover.1600600823.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is currently no easy way to take the diff between the working tree
or index and the merge base between an arbitrary commit and HEAD. Even
diff's `...` notation doesn't allow this because it only works between
commits. However, the ability to do this would be desirable to a user
who would like to see all the changes they've made on a branch plus
uncommitted changes without taking into account changes made in the
upstream branch.

Teach diff-index and diff (with one commit) the --merge-base option
which allows a user to use the merge base of a commit and HEAD as the
"before" side.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-diff-index.txt     |  7 +++-
 Documentation/git-diff.txt           | 12 ++++--
 builtin/diff-index.c                 |  2 +
 builtin/diff.c                       |  2 +
 diff-lib.c                           | 15 ++++++-
 diff.h                               |  1 +
 t/t4068-diff-symmetric-merge-base.sh | 59 ++++++++++++++++++++++++++++
 7 files changed, 92 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
index 25fe165f00..27acb31cbf 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -9,7 +9,7 @@ git-diff-index - Compare a tree to the working tree or index
 SYNOPSIS
 --------
 [verse]
-'git diff-index' [-m] [--cached] [<common diff options>] <tree-ish> [<path>...]
+'git diff-index' [-m] [--cached] [--merge-base] [<common diff options>] <tree-ish> [<path>...]
 
 DESCRIPTION
 -----------
@@ -29,6 +29,11 @@ include::diff-options.txt[]
 --cached::
 	Do not consider the on-disk file at all.
 
+--merge-base::
+	Instead of comparing <tree-ish> directly, use the merge base
+	between <tree-ish> and HEAD instead.  <tree-ish> must be a
+	commit.
+
 -m::
 	By default, files recorded in the index but not checked
 	out are reported as deleted.  This flag makes
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 8f7b4ed3ca..762ee6d074 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git diff' [<options>] [<commit>] [--] [<path>...]
-'git diff' [<options>] --cached [<commit>] [--] [<path>...]
+'git diff' [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]
 'git diff' [<options>] <commit> [<commit>...] <commit> [--] [<path>...]
 'git diff' [<options>] <commit>...<commit> [--] [<path>...]
 'git diff' [<options>] <blob> <blob>
@@ -40,7 +40,7 @@ files on disk.
 	or when running the command outside a working tree
 	controlled by Git. This form implies `--exit-code`.
 
-'git diff' [<options>] --cached [<commit>] [--] [<path>...]::
+'git diff' [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]::
 
 	This form is to view the changes you staged for the next
 	commit relative to the named <commit>.  Typically you
@@ -49,6 +49,10 @@ files on disk.
 	If HEAD does not exist (e.g. unborn branches) and
 	<commit> is not given, it shows all staged changes.
 	--staged is a synonym of --cached.
++
+If --merge-base is given, instead of using <commit>, use the merge base
+of <commit> and HEAD.  `git diff --merge-base A` is equivalent to
+`git diff $(git merge-base A HEAD)`.
 
 'git diff' [<options>] <commit> [--] [<path>...]::
 
@@ -89,8 +93,8 @@ files on disk.
 
 Just in case you are doing something exotic, it should be
 noted that all of the <commit> in the above description, except
-in the last two forms that use `..` notations, can be any
-<tree>.
+in the `--merge-base` case and in the last two forms that use `..`
+notations, can be any <tree>.
 
 For a more complete list of ways to spell <commit>, see
 "SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index c3878f7ad6..7f5281c461 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -33,6 +33,8 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 
 		if (!strcmp(arg, "--cached"))
 			option |= DIFF_INDEX_CACHED;
+		else if (!strcmp(arg, "--merge-base"))
+			option |= DIFF_INDEX_MERGE_BASE;
 		else
 			usage(diff_cache_usage);
 	}
diff --git a/builtin/diff.c b/builtin/diff.c
index e45e19e37e..1baea18ae0 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -139,6 +139,8 @@ static int builtin_diff_index(struct rev_info *revs,
 		const char *arg = argv[1];
 		if (!strcmp(arg, "--cached") || !strcmp(arg, "--staged"))
 			option |= DIFF_INDEX_CACHED;
+		else if (!strcmp(arg, "--merge-base"))
+			option |= DIFF_INDEX_MERGE_BASE;
 		else
 			usage(builtin_diff_usage);
 		argv++; argc--;
diff --git a/diff-lib.c b/diff-lib.c
index fa64e64bbe..79defdc6b8 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -567,13 +567,26 @@ int run_diff_index(struct rev_info *revs, unsigned int option)
 {
 	struct object_array_entry *ent;
 	int cached = !!(option & DIFF_INDEX_CACHED);
+	int merge_base = !!(option & DIFF_INDEX_MERGE_BASE);
+	struct object_id oid;
+	const char *name;
+	char merge_base_hex[GIT_MAX_HEXSZ + 1];
 
 	if (revs->pending.nr != 1)
 		BUG("run_diff_index must be passed exactly one tree");
 
 	trace_performance_enter();
 	ent = revs->pending.objects;
-	if (diff_cache(revs, &ent->item->oid, ent->name, cached))
+
+	if (merge_base) {
+		diff_get_merge_base(revs, &oid);
+		name = oid_to_hex_r(merge_base_hex, &oid);
+	} else {
+		oidcpy(&oid, &ent->item->oid);
+		name = ent->name;
+	}
+
+	if (diff_cache(revs, &oid, name, cached))
 		exit(128);
 
 	diff_set_mnemonic_prefix(&revs->diffopt, "c/", cached ? "i/" : "w/");
diff --git a/diff.h b/diff.h
index fedfeab7a2..6c2efa16fd 100644
--- a/diff.h
+++ b/diff.h
@@ -589,6 +589,7 @@ void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb);
 int run_diff_files(struct rev_info *revs, unsigned int option);
 
 #define DIFF_INDEX_CACHED 01
+#define DIFF_INDEX_MERGE_BASE 02
 int run_diff_index(struct rev_info *revs, unsigned int option);
 
 int do_diff_cache(const struct object_id *, struct diff_options *);
diff --git a/t/t4068-diff-symmetric-merge-base.sh b/t/t4068-diff-symmetric-merge-base.sh
index bd4cf254d9..49432379cb 100755
--- a/t/t4068-diff-symmetric-merge-base.sh
+++ b/t/t4068-diff-symmetric-merge-base.sh
@@ -97,4 +97,63 @@ test_expect_success 'diff --merge-base with three commits' '
 	test_i18ngrep "usage" err
 '
 
+for cmd in diff-index diff
+do
+	test_expect_success "$cmd --merge-base with one commit" '
+		git checkout master &&
+		git $cmd commit-C >expect &&
+		git $cmd --merge-base br2 >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "$cmd --merge-base with one commit and unstaged changes" '
+		git checkout master &&
+		test_when_finished git reset --hard &&
+		echo unstaged >>c &&
+		git $cmd commit-C >expect &&
+		git $cmd --merge-base br2 >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "$cmd --merge-base with one commit and staged and unstaged changes" '
+		git checkout master &&
+		test_when_finished git reset --hard &&
+		echo staged >>c &&
+		git add c &&
+		echo unstaged >>c &&
+		git $cmd commit-C >expect &&
+		git $cmd --merge-base br2 >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "$cmd --merge-base --cached with one commit and staged and unstaged changes" '
+		git checkout master &&
+		test_when_finished git reset --hard &&
+		echo staged >>c &&
+		git add c &&
+		echo unstaged >>c &&
+		git $cmd --cached commit-C >expect &&
+		git $cmd --cached --merge-base br2 >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "$cmd --merge-base with non-commit" '
+		git checkout master &&
+		test_must_fail git $cmd --merge-base master^{tree} 2>err &&
+		test_i18ngrep "fatal: --merge-base only works with commits" err
+	'
+
+	test_expect_success "$cmd --merge-base with no merge bases and one commit" '
+		git checkout master &&
+		test_must_fail git $cmd --merge-base br3 2>err &&
+		test_i18ngrep "fatal: no merge base found" err
+	'
+
+	test_expect_success "$cmd --merge-base with multiple merge bases and one commit" '
+		git checkout master &&
+		test_must_fail git $cmd --merge-base br1 2>err &&
+		test_i18ngrep "fatal: multiple merge bases found" err
+	'
+done
+
 test_done
-- 
2.28.0.760.g8d73e04208

