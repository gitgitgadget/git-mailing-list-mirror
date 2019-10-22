Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BCE91F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 10:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731764AbfJVKT6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 06:19:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42659 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfJVKT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 06:19:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id c16so4393942plz.9
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 03:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s9gtzXbkxU2AwA1Az3M4p+6fdX0e/8tFrxZmzvsFb7U=;
        b=N3oR+sdsClptlFh9fjTnulJRN8s5IHRU3LcUjIB+4ZzFE/siyZU8eLZK9pEp7Bsa0w
         2SrUgUY0CL9m16xnTJAnqc1MGHPUJ85eDwtjZGxnU+pzFJNxHIGDQoZEG45mHd1VeT9u
         TTGc3i0575lVbkHXUSAfuAF7yK7Www1VANzXesABZF1uGTLGr8XlhabFmgNvDrZ+869l
         amwMsG76FjMgCIdikyXGI316/REiiH2gKG6LXvcKbNCFhB3ZDQE3FKvkvhkVZDcXWxLV
         D4DU8n2qxUMLUHcb4VmeEVm5mMwxaszXXEnquvsUYJr76Vj9NNk01F84FfkMHH7QlstO
         z1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s9gtzXbkxU2AwA1Az3M4p+6fdX0e/8tFrxZmzvsFb7U=;
        b=rvIFqV7ZTOcVqoZgmOWSCysI0nVeEZ/E+1QX/4AKQiCkmyrg56OkmrEaXuRx0ZAtvj
         9FrMTXZBWJqD0FSleqExoNJdhFLI2FkhnYMrVGXsDV2B87kecZ29Maa8B6VPh2UBIcko
         Sc9zCsqSqsFvVrb4YN0ynbHB5d7CzOkUMgMzpjZhEFAhtY4EfAH/uXAU6uO20oQytr6k
         o45XU1MCjqDT3pmv3O6LR138Gaz0Y1O6Ebtbr4ZNZP95pz4iqvs2/57t5KGQ6Z/W7r6q
         J3LQdyiHm1Q4RtnEFloppDlVH1smq4Mu3uiFOZgKGA4ZwRWjAHv5bi39IGgqLXvB1s2D
         blZw==
X-Gm-Message-State: APjAAAUV3WNS41Ieg/eHhJtPXTfoQc3Y04PUpYByvKIUxV7Sv+zC4a31
        GWcJ5PXKevMMM+uFmUyX9pH93ng0
X-Google-Smtp-Source: APXvYqyWtwlMaukd7I1rXjt2KlWDJgLXRWP8ZRTop+VAu22+4WyNXIecTzj+yHbUHVV9fJQRHaF7zg==
X-Received: by 2002:a17:902:ff10:: with SMTP id f16mr2947638plj.102.1571739596975;
        Tue, 22 Oct 2019 03:19:56 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id y129sm16485520pgb.28.2019.10.22.03.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 03:19:56 -0700 (PDT)
Date:   Tue, 22 Oct 2019 03:19:54 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 01/14] t: teach test_cmp_rev to accept ! for not-equals
Message-ID: <9a96f113e74601dda8f7f300b13dcca19ba3285e.1571739459.git.liu.denton@gmail.com>
References: <cover.1571435195.git.liu.denton@gmail.com>
 <cover.1571739459.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571739459.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, in the case where we are using test_cmp_rev() to report
not-equals, we write `! test_cmp_rev`. However, since test_cmp_rev()
contains

	r1=$(git rev-parse --verify "$1") &&
	r2=$(git rev-parse --verify "$2") &&

In the case where `git rev-parse` segfaults and dies unexpectedly, the
failure will be ignored.

Rewrite test_cmp_rev() to optionally accept "!" as the first argument to
do a not-equals comparison. Rewrite `! test_cmp_rev` to `test_cmp_rev !`
in all tests to take advantage of this new functionality.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t2400-worktree-add.sh             |  4 ++--
 t/t3400-rebase.sh                   |  2 +-
 t/t3421-rebase-topology-linear.sh   |  6 +++---
 t/t3430-rebase-merges.sh            |  2 +-
 t/t3432-rebase-fast-forward.sh      |  2 +-
 t/t3501-revert-cherry-pick.sh       |  2 +-
 t/t3508-cherry-pick-many-commits.sh |  2 +-
 t/test-lib-functions.sh             | 22 +++++++++++++++++++---
 8 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index e819ba741e..52d476979b 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -438,7 +438,7 @@ test_expect_success 'git worktree add does not match remote' '
 		cd foo &&
 		test_must_fail git config "branch.foo.remote" &&
 		test_must_fail git config "branch.foo.merge" &&
-		! test_cmp_rev refs/remotes/repo_a/foo refs/heads/foo
+		test_cmp_rev ! refs/remotes/repo_a/foo refs/heads/foo
 	)
 '
 
@@ -483,7 +483,7 @@ test_expect_success 'git worktree --no-guess-remote option overrides config' '
 		cd foo &&
 		test_must_fail git config "branch.foo.remote" &&
 		test_must_fail git config "branch.foo.merge" &&
-		! test_cmp_rev refs/remotes/repo_a/foo refs/heads/foo
+		test_cmp_rev ! refs/remotes/repo_a/foo refs/heads/foo
 	)
 '
 
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index ab18ac5f28..f267f6cd54 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -64,7 +64,7 @@ test_expect_success 'rebase sets ORIG_HEAD to pre-rebase state' '
 	pre="$(git rev-parse --verify HEAD)" &&
 	git rebase master &&
 	test_cmp_rev "$pre" ORIG_HEAD &&
-	! test_cmp_rev "$pre" HEAD
+	test_cmp_rev ! "$pre" HEAD
 '
 
 test_expect_success 'rebase, with <onto> and <upstream> specified as :/quuxery' '
diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index b847064f91..325072b0a3 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -61,7 +61,7 @@ test_run_rebase () {
 	test_expect_$result "rebase $* -f rewrites even if upstream is an ancestor" "
 		reset_rebase &&
 		git rebase $* -f b e &&
-		! test_cmp_rev e HEAD &&
+		test_cmp_rev ! e HEAD &&
 		test_cmp_rev b HEAD~2 &&
 		test_linear_range 'd e' b..
 	"
@@ -78,7 +78,7 @@ test_run_rebase () {
 	test_expect_$result "rebase $* -f rewrites even if remote upstream is an ancestor" "
 		reset_rebase &&
 		git rebase $* -f branch-b branch-e &&
-		! test_cmp_rev branch-e origin/branch-e &&
+		test_cmp_rev ! branch-e origin/branch-e &&
 		test_cmp_rev branch-b HEAD~2 &&
 		test_linear_range 'd e' branch-b..
 	"
@@ -368,7 +368,7 @@ test_run_rebase () {
 	test_expect_$result "rebase $* -f --root on linear history causes re-write" "
 		reset_rebase &&
 		git rebase $* -f --root c &&
-		! test_cmp_rev a HEAD~2 &&
+		test_cmp_rev ! a HEAD~2 &&
 		test_linear_range 'a b c' HEAD
 	"
 }
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 9efcf4808a..abbdc26b1b 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -346,7 +346,7 @@ test_expect_success 'A root commit can be a cousin, treat it that way' '
 	git merge --allow-unrelated-histories khnum &&
 	test_tick &&
 	git rebase -f -r HEAD^ &&
-	! test_cmp_rev HEAD^2 khnum &&
+	test_cmp_rev ! HEAD^2 khnum &&
 	test_cmp_graph HEAD^.. <<-\EOF &&
 	*   Merge branch '\''khnum'\'' into asherah
 	|\
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 034ffc7e76..92f95b57da 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -64,7 +64,7 @@ test_rebase_same_head_ () {
 			test_cmp_rev \$oldhead \$newhead
 		elif test $cmp = diff
 		then
-			! test_cmp_rev \$oldhead \$newhead
+			test_cmp_rev ! \$oldhead \$newhead
 		fi
 	"
 }
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index d1c68af8c5..1c51a9131d 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -106,7 +106,7 @@ test_expect_success 'cherry-pick on unborn branch' '
 	rm -rf * &&
 	git cherry-pick initial &&
 	git diff --quiet initial &&
-	! test_cmp_rev initial HEAD
+	test_cmp_rev ! initial HEAD
 '
 
 test_expect_success 'cherry-pick "-" to pick from previous branch' '
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index b457333e18..23070a7b73 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -5,7 +5,7 @@ test_description='test cherry-picking many commits'
 . ./test-lib.sh
 
 check_head_differs_from() {
-	! test_cmp_rev HEAD "$1"
+	test_cmp_rev ! HEAD "$1"
 }
 
 check_head_equals() {
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index b299ecc326..064131ac39 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1012,8 +1012,17 @@ test_must_be_empty () {
 	fi
 }
 
-# Tests that its two parameters refer to the same revision
+# Tests that its two parameters refer to the same revision, or if '!' is
+# provided first, that its other two parameters refer to different
+# revisions.
 test_cmp_rev () {
+	local inverted_op
+	inverted_op='!='
+	if test $# -ge 1 && test "x$1" = 'x!'
+	then
+	    inverted_op='='
+	    shift
+	fi
 	if test $# != 2
 	then
 		error "bug in the test script: test_cmp_rev requires two revisions, but got $#"
@@ -1021,10 +1030,17 @@ test_cmp_rev () {
 		local r1 r2
 		r1=$(git rev-parse --verify "$1") &&
 		r2=$(git rev-parse --verify "$2") &&
-		if test "$r1" != "$r2"
+		if test "$r1" "$inverted_op" "$r2"
 		then
+			local comp_out
+			if "x$inverted_op" = 'x='
+			then
+				comp_out='the same'
+			else
+				comp_out='different'
+			fi
 			cat >&4 <<-EOF
-			error: two revisions point to different objects:
+			error: two revisions point to $comp_out objects:
 			  '$1': $r1
 			  '$2': $r2
 			EOF
-- 
2.24.0.rc0.197.g0926ab8072

