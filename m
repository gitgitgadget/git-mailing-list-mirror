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
	by dcvr.yhbt.net (Postfix) with ESMTP id 82EAF1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 23:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfKLXHu (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 18:07:50 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44545 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfKLXHu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 18:07:50 -0500
Received: by mail-pl1-f195.google.com with SMTP id az9so159674plb.11
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 15:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+RhjpUw7YtWyRSKhSHpG73LE/lkAeI106BhHT7QxyN8=;
        b=VKOdG7EOmfdkHQpRTtLDbQYsBz//yj0cuNJMi0Cala9o3fOTnD1sLCQqxa5OJGNapN
         /70m2HdneLO6OCFP+MaGERqBOi3DTHdXU7C15yXvHlxbmUCFiHY7vIlDsMP7/PoYDmGH
         YNqVd7JXwgeM+amjI0wN6GKrHMcbep+bp89z7i6TmWCUg200Qs/9Ix8bpJ3D86erUXyZ
         V0Evs+I9HksWlaDYILTj3IUx/u4F2v79ZcIxfgW1AGqUl1bjzAlUcJvzg8ycrarlsnEC
         8mjjlDGeGhXnt9/DFSd2IUxt+DrXlEM1FYC6ASAURGY7W2gYN73OuE9hFGk80YCiKixN
         IW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+RhjpUw7YtWyRSKhSHpG73LE/lkAeI106BhHT7QxyN8=;
        b=ITP6BsmTaubYoQFwjz7XJq5YdzYSYidYDV+SaRBdkm3cmQAsS//gpBlzaQz/NvPW5V
         1GGXe5clTk19HamSUQKnunB+/i/b6zxyMR0tRlfXaHTnpJwnoit2VelYUNMHny7gwR1n
         PRT5mHtBaUEjwEqELEoTtvmXcWqk44A+wJvIbfD5tnzRBdLfvJC2GwI9hfk8yf8bFkoT
         r/neQbaHvt9q5Xg0wfRyubO7zEqNWcz8TljWSxP/uAcaPtwKLE56jHvUDJj9vkiuAFgL
         O8lnpwA0V0MzUMi9Z1kPMGHY+KOutDr+ereUje5kQpiSpfC30t9quxwOiG3OmWc3fMpZ
         uuqg==
X-Gm-Message-State: APjAAAVRrsKZwz3wfl/LRAHlrSIfgulPDirWBkuoCGWPcAlmrwrHO3TL
        d0pfQ+oKwv8duFqi8ztex8sZw0aZ
X-Google-Smtp-Source: APXvYqwNeh4veYXmKgnVKkXjPGBE2PT5ThOkNrLDsvFiEE8Oo3/W0+uySUnSmYtwB8MTwSuQqJpJQQ==
X-Received: by 2002:a17:902:9343:: with SMTP id g3mr340855plp.278.1573600067737;
        Tue, 12 Nov 2019 15:07:47 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id j11sm69377pgk.3.2019.11.12.15.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:07:47 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:07:45 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 01/14] t: teach test_cmp_rev to accept ! for not-equals
Message-ID: <0532847787dfd48fbe4b41a4a7d2783748f3bd7f.1573595985.git.liu.denton@gmail.com>
References: <cover.1573517561.git.liu.denton@gmail.com>
 <cover.1573595985.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573595985.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the case where we are using test_cmp_rev() to report not-equals, we
write `! test_cmp_rev`. However, since test_cmp_rev() contains

	r1=$(git rev-parse --verify "$1") &&
	r2=$(git rev-parse --verify "$2") &&

`! test_cmp_rev` will succeed if any of the rev-parses fail. This
behavior is not desired. We want the rev-parses to _always_ be
successful.

Rewrite test_cmp_rev() to optionally accept "!" as the first argument to
do a not-equals comparison. Rewrite `! test_cmp_rev` to `test_cmp_rev !`
in all tests to take advantage of this new functionality.

Also, rewrite the rev-parse logic to end with a `|| return 1` instead of
&&-chaining into the rev-comparison logic. This makes it obvious to
future readers that we explicitly intend on returning early if either of
the rev-parses fail.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t2400-worktree-add.sh             |  4 ++--
 t/t3400-rebase.sh                   |  2 +-
 t/t3421-rebase-topology-linear.sh   |  6 +++---
 t/t3430-rebase-merges.sh            |  2 +-
 t/t3432-rebase-fast-forward.sh      |  2 +-
 t/t3501-revert-cherry-pick.sh       |  2 +-
 t/t3508-cherry-pick-many-commits.sh |  2 +-
 t/test-lib-functions.sh             | 20 ++++++++++++++++----
 8 files changed, 26 insertions(+), 14 deletions(-)

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
index b299ecc326..15f4c96777 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1012,19 +1012,31 @@ test_must_be_empty () {
 	fi
 }
 
-# Tests that its two parameters refer to the same revision
+# Tests that its two parameters refer to the same revision, or if '!' is
+# provided first, that its other two parameters refer to different
+# revisions.
 test_cmp_rev () {
+	local op wrong_result
+	op='='
+	wrong_result='different'
+	if test $# -ge 1 && test "x$1" = 'x!'
+	then
+	    op='!='
+	    wrong_result='the same'
+	    shift
+	fi
 	if test $# != 2
 	then
 		error "bug in the test script: test_cmp_rev requires two revisions, but got $#"
 	else
 		local r1 r2
 		r1=$(git rev-parse --verify "$1") &&
-		r2=$(git rev-parse --verify "$2") &&
-		if test "$r1" != "$r2"
+		r2=$(git rev-parse --verify "$2") || return 1
+
+		if ! test "$r1" "$op" "$r2"
 		then
 			cat >&4 <<-EOF
-			error: two revisions point to different objects:
+			error: two revisions point to $wrong_result objects:
 			  '$1': $r1
 			  '$2': $r2
 			EOF
-- 
2.24.0.346.gee0de6d492

