Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D97011F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 21:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbeJFEzC (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 00:55:02 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:53391 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeJFEzC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 00:55:02 -0400
Received: by mail-qt1-f201.google.com with SMTP id d18-v6so13866844qtj.20
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 14:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5K0JWtUmnN/H6bk9NsTG26B56jm/UkNOCi/D43JEBF0=;
        b=dtxRI4E9gWLardndchjjSeEZB0akMH2bpArzgqO1mR9kEeH7+5bmMnVL6Cnej2xMqZ
         8bznBO3YhCuV+3Ah8JwpRcwpDsv6Qzet/L7AE3ecmo2fTIgS/QaLVjuSGsCmdYqyphTO
         06MpxSp8Z9Y9wCiT4aTtyhJk0VvjlqQaJ1DqsTcAKZp8//7HEQzQ3HsTaCsTEMEMUeoj
         QQJ3MTn/aGdusExOMKSuwgo0BBvBQ3KXuHCFK5wWRLAu6tX0ylmswKMYiBR1t4Aoe9RS
         GTbdojJBH52TXdXvD2lNtRv17WYXzctJgkFYj73grUPS5BkKlClBS2gVXiNvfpOR8ZsG
         ws8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5K0JWtUmnN/H6bk9NsTG26B56jm/UkNOCi/D43JEBF0=;
        b=eC/OjII0gwqU0Lg5s2cvx4LNfbI7Z8nmO4y2e7Jk1hpbxTVpFdQ6muBiqIb4Ad+2O3
         XwY+BrZXSeoI8XOuSAlWz55PPcFNWpeeAPsIfmtHuDgwMyzD8sO4Lm7kdJ2W1Hg+I6rx
         pjjsqMBNxv/HPnolP0SFZexjgdWfGnsv53qQtt8Jc5s3T7Bi8l0KC1enG+zG9FIgZM5+
         EuEYGmHT5WC90xiTpmwsvVNLuVg/6ZEN4ozcMW/YfspBRvDC13BxCOyE9YErDn6rGMYw
         d7ym7skC8fQBvR7MgbUFnN0zkKWfiRGUjuftOmG1yL3KgKbAlPs+987I5DpsbzMZCnTn
         nUyQ==
X-Gm-Message-State: ABuFfojMyxuOSG7NG+4tTmfl/qFnuyaKjwoLnWDhB0BeZ3ym/B/ubqA1
        A8nR8OaubadwL/rzVeaLToW1BT6WF7s3wZ0QK4WYVdMNTFNs/UysACOImMdRUWu6BeI2PqFWkJL
        7sF41rMQNxQS7M9YSGICC6ic5BVla0P/dbwtSSlQ3+tp4GmW3G0vFqqkl950=
X-Google-Smtp-Source: ACcGV60hpzHHSwPgXUbV8uhngMW9Cc4oLNMBg7HZwt4QFqbpIyjDrwmmaDhL4TK9LxXSNG5jBLEtCkRnuZtK
X-Received: by 2002:a0c:d8ca:: with SMTP id w10-v6mr9957903qvj.29.1538776462485;
 Fri, 05 Oct 2018 14:54:22 -0700 (PDT)
Date:   Fri,  5 Oct 2018 14:54:04 -0700
In-Reply-To: <cover.1538775186.git.matvore@google.com>
Message-Id: <b22221ee652eaa52d9ed5e54a286d777bbf689ec.1538775186.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1538775186.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v5 4/7] t/*: fix ordering of expected/observed arguments
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, peff@peff.net,
        jonathantanmy@google.com, gitster@pobox.com, jrn@google.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix various places where the ordering was obviously wrong, meaning it
was easy to find with grep.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 t/t0000-basic.sh                       |  2 +-
 t/t0021-conversion.sh                  |  4 +--
 t/t1300-config.sh                      |  4 +--
 t/t1303-wacky-config.sh                |  4 +--
 t/t2101-update-index-reupdate.sh       |  2 +-
 t/t3200-branch.sh                      |  2 +-
 t/t3320-notes-merge-worktrees.sh       |  4 +--
 t/t3400-rebase.sh                      |  8 +++---
 t/t3417-rebase-whitespace-fix.sh       |  6 ++---
 t/t3702-add-edit.sh                    |  4 +--
 t/t3903-stash.sh                       |  8 +++---
 t/t3905-stash-include-untracked.sh     |  2 +-
 t/t4025-hunk-header.sh                 |  2 +-
 t/t4117-apply-reject.sh                |  6 ++---
 t/t4124-apply-ws-rule.sh               | 30 +++++++++++------------
 t/t4138-apply-ws-expansion.sh          |  2 +-
 t/t5317-pack-objects-filter-objects.sh | 34 +++++++++++++-------------
 t/t5318-commit-graph.sh                |  2 +-
 t/t5701-git-serve.sh                   | 14 +++++------
 t/t5702-protocol-v2.sh                 | 10 ++++----
 t/t6023-merge-file.sh                  | 12 ++++-----
 t/t6027-merge-binary.sh                |  4 +--
 t/t6031-merge-filemode.sh              |  2 +-
 t/t6112-rev-list-filters-objects.sh    | 24 +++++++++---------
 t/t7201-co.sh                          |  4 +--
 t/t7406-submodule-update.sh            |  8 +++---
 t/t7800-difftool.sh                    |  2 +-
 t/t9100-git-svn-basic.sh               |  2 +-
 t/t9133-git-svn-nested-git-repo.sh     |  6 ++---
 t/t9600-cvsimport.sh                   |  2 +-
 t/t9603-cvsimport-patchsets.sh         |  4 +--
 t/t9604-cvsimport-timestamps.sh        |  4 +--
 32 files changed, 112 insertions(+), 112 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 850f651e4..224c098a8 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1018,7 +1018,7 @@ test_expect_success SHA1 'validate git diff-files output for a know cache/work t
 :120000 120000 6649a1ebe9e9f1c553b66f5a6e74136a07ccc57c 0000000000000000000000000000000000000000 M	path3/subp3/file3sym
 EOF
 	git diff-files >current &&
-	test_cmp current expected
+	test_cmp expected current
 '
 
 test_expect_success 'git update-index --refresh should succeed' '
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 308cd28f3..fd5f1ac64 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -166,10 +166,10 @@ test_expect_success expanded_in_repo '
 	rm -f expanded-keywords expanded-keywords-crlf &&
 
 	git checkout -- expanded-keywords &&
-	test_cmp expanded-keywords expected-output &&
+	test_cmp expected-output expanded-keywords &&
 
 	git checkout -- expanded-keywords-crlf &&
-	test_cmp expanded-keywords-crlf expected-output-crlf
+	test_cmp expected-output-crlf expanded-keywords-crlf
 '
 
 # The use of %f in a filter definition is expanded to the path to
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 5869d6cb6..e2cd50ecf 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1001,7 +1001,7 @@ EOF
 
 test_expect_success 'value continued on next line' '
 	git config --list > result &&
-	test_cmp result expect
+	test_cmp expect result
 '
 
 cat > .git/config <<\EOF
@@ -1882,7 +1882,7 @@ test_expect_success '--replace-all does not invent newlines' '
 	Qkey = b
 	EOF
 	git config --replace-all abc.key b &&
-	test_cmp .git/config expect
+	test_cmp expect .git/config
 '
 
 test_done
diff --git a/t/t1303-wacky-config.sh b/t/t1303-wacky-config.sh
index 3b92083e1..0000e664e 100755
--- a/t/t1303-wacky-config.sh
+++ b/t/t1303-wacky-config.sh
@@ -14,7 +14,7 @@ setup() {
 check() {
 	echo "$2" >expected
 	git config --get "$1" >actual 2>&1
-	test_cmp actual expected
+	test_cmp expected actual
 }
 
 # 'check section.key regex value' verifies that the entry for
@@ -22,7 +22,7 @@ check() {
 check_regex() {
 	echo "$3" >expected
 	git config --get "$1" "$2" >actual 2>&1
-	test_cmp actual expected
+	test_cmp expected actual
 }
 
 test_expect_success 'modify same key' '
diff --git a/t/t2101-update-index-reupdate.sh b/t/t2101-update-index-reupdate.sh
index 685ec4563..6c32d42c8 100755
--- a/t/t2101-update-index-reupdate.sh
+++ b/t/t2101-update-index-reupdate.sh
@@ -73,7 +73,7 @@ test_expect_success 'update-index --update from subdir' '
 	100644 $(git hash-object dir1/file3) 0	dir1/file3
 	100644 $file2 0	file2
 	EOF
-	test_cmp current expected
+	test_cmp expected current
 '
 
 test_expect_success 'update-index --update with pathspec' '
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 93f21ab07..478b82cf9 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1221,7 +1221,7 @@ test_expect_success 'use --edit-description' '
 	EOF
 	EDITOR=./editor git branch --edit-description &&
 	echo "New contents" >expect &&
-	test_cmp EDITOR_OUTPUT expect
+	test_cmp expect EDITOR_OUTPUT
 '
 
 test_expect_success 'detect typo in branch name when using --edit-description' '
diff --git a/t/t3320-notes-merge-worktrees.sh b/t/t3320-notes-merge-worktrees.sh
index 10bfc8b94..823fdbda1 100755
--- a/t/t3320-notes-merge-worktrees.sh
+++ b/t/t3320-notes-merge-worktrees.sh
@@ -44,7 +44,7 @@ test_expect_success 'merge z into y fails and sets NOTES_MERGE_REF' '
 	git config core.notesRef refs/notes/y &&
 	test_must_fail git notes merge z &&
 	echo "ref: refs/notes/y" >expect &&
-	test_cmp .git/NOTES_MERGE_REF expect
+	test_cmp expect .git/NOTES_MERGE_REF
 '
 
 test_expect_success 'merge z into y while mid-merge in another workdir fails' '
@@ -66,7 +66,7 @@ test_expect_success 'merge z into x while mid-merge on y succeeds' '
 		grep -v "A notes merge into refs/notes/x is already in-progress in" out
 	) &&
 	echo "ref: refs/notes/x" >expect &&
-	test_cmp .git/worktrees/worktree2/NOTES_MERGE_REF expect
+	test_cmp expect .git/worktrees/worktree2/NOTES_MERGE_REF
 '
 
 test_done
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 3996ee013..3e73f7584 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -183,13 +183,13 @@ test_expect_success 'cherry-picked commits and fork-point work together' '
 	test_commit final_B B "Final B" &&
 	git rebase &&
 	echo Amended >expect &&
-	test_cmp A expect &&
+	test_cmp expect A &&
 	echo "Final B" >expect &&
-	test_cmp B expect &&
+	test_cmp expect B &&
 	echo C >expect &&
-	test_cmp C expect &&
+	test_cmp expect C &&
 	echo D >expect &&
-	test_cmp D expect
+	test_cmp expect D
 '
 
 test_expect_success 'rebase -q is quiet' '
diff --git a/t/t3417-rebase-whitespace-fix.sh b/t/t3417-rebase-whitespace-fix.sh
index 1fb3e499b..e85cdc703 100755
--- a/t/t3417-rebase-whitespace-fix.sh
+++ b/t/t3417-rebase-whitespace-fix.sh
@@ -55,7 +55,7 @@ test_expect_success 'blank line at end of file; extend at end of file' '
 	git add file &&	git commit -m second &&
 	git rebase --whitespace=fix HEAD^^ &&
 	git diff --exit-code HEAD^:file expect-first &&
-	test_cmp file expect-second
+	test_cmp expect-second file
 '
 
 # prepare third revision of "file"
@@ -82,7 +82,7 @@ test_expect_success 'two blanks line at end of file; extend at end of file' '
 	cp third file && git add file && git commit -m third &&
 	git rebase --whitespace=fix HEAD^^ &&
 	git diff --exit-code HEAD^:file expect-second &&
-	test_cmp file expect-third
+	test_cmp expect-third file
 '
 
 test_expect_success 'same, but do not remove trailing spaces' '
@@ -120,7 +120,7 @@ test_expect_success 'at beginning of file' '
 	done >> file &&
 	git commit -m more file	&&
 	git rebase --whitespace=fix HEAD^^ &&
-	test_cmp file expect-beginning
+	test_cmp expect-beginning file
 '
 
 test_done
diff --git a/t/t3702-add-edit.sh b/t/t3702-add-edit.sh
index c6af7f82b..6c676645d 100755
--- a/t/t3702-add-edit.sh
+++ b/t/t3702-add-edit.sh
@@ -110,10 +110,10 @@ test_expect_success 'add -e' '
 	cp second-part file &&
 	git add -e &&
 	test_cmp second-part file &&
-	test_cmp orig-patch expected-patch &&
+	test_cmp expected-patch orig-patch &&
 	git diff --cached >actual &&
 	grep -v index actual >out &&
-	test_cmp out expected
+	test_cmp expected out
 
 '
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 6450bc669..cd216655b 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -36,7 +36,7 @@ EOF
 test_expect_success 'parents of stash' '
 	test $(git rev-parse stash^) = $(git rev-parse HEAD) &&
 	git diff stash^2..stash > output &&
-	test_cmp output expect
+	test_cmp expect output
 '
 
 test_expect_success 'applying bogus stash does nothing' '
@@ -210,9 +210,9 @@ test_expect_success 'stash branch' '
 	test refs/heads/stashbranch = $(git symbolic-ref HEAD) &&
 	test $(git rev-parse HEAD) = $(git rev-parse master^) &&
 	git diff --cached > output &&
-	test_cmp output expect &&
+	test_cmp expect output &&
 	git diff > output &&
-	test_cmp output expect1 &&
+	test_cmp expect1 output &&
 	git add file &&
 	git commit -m alternate\ second &&
 	git diff master..stashbranch > output &&
@@ -710,7 +710,7 @@ test_expect_success 'stash where working directory contains "HEAD" file' '
 	git diff-index --cached --quiet HEAD &&
 	test "$(git rev-parse stash^)" = "$(git rev-parse HEAD)" &&
 	git diff stash^..stash > output &&
-	test_cmp output expect
+	test_cmp expect output
 '
 
 test_expect_success 'store called with invalid commit' '
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index 597b0637d..cc1c8a7bb 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -142,7 +142,7 @@ test_expect_success 'stash save --include-untracked removed files' '
 	rm -f file &&
 	git stash save --include-untracked &&
 	echo 1 > expect &&
-	test_cmp file expect
+	test_cmp expect file
 '
 
 rm -f expect
diff --git a/t/t4025-hunk-header.sh b/t/t4025-hunk-header.sh
index fa44e7886..35578f2bb 100755
--- a/t/t4025-hunk-header.sh
+++ b/t/t4025-hunk-header.sh
@@ -37,7 +37,7 @@ test_expect_success 'hunk header truncation with an overly long line' '
 		echo " A $N$N$N$N$N$N$N$N$N2" &&
 		echo " L  $N$N$N$N$N$N$N$N$N1"
 	) >expected &&
-	test_cmp actual expected
+	test_cmp expected actual
 
 '
 
diff --git a/t/t4117-apply-reject.sh b/t/t4117-apply-reject.sh
index d80187de9..f7de6f077 100755
--- a/t/t4117-apply-reject.sh
+++ b/t/t4117-apply-reject.sh
@@ -72,7 +72,7 @@ test_expect_success 'apply with --reject should fail but update the file' '
 	rm -f file1.rej file2.rej &&
 
 	test_must_fail git apply --reject patch.1 &&
-	test_cmp file1 expected &&
+	test_cmp expected file1 &&
 
 	cat file1.rej &&
 	test_path_is_missing file2.rej
@@ -85,7 +85,7 @@ test_expect_success 'apply with --reject should fail but update the file' '
 
 	test_must_fail git apply --reject patch.2 >rejects &&
 	test_path_is_missing file1 &&
-	test_cmp file2 expected &&
+	test_cmp expected file2 &&
 
 	cat file2.rej &&
 	test_path_is_missing file1.rej
@@ -99,7 +99,7 @@ test_expect_success 'the same test with --verbose' '
 
 	test_must_fail git apply --reject --verbose patch.2 >rejects &&
 	test_path_is_missing file1 &&
-	test_cmp file2 expected &&
+	test_cmp expected file2 &&
 
 	cat file2.rej &&
 	test_path_is_missing file1.rej
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 7e32237a2..ff51e9e78 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -313,9 +313,9 @@ test_expect_success 'applying beyond EOF requires one non-blank context line' '
 	{ echo a; echo; } >one &&
 	cp one expect &&
 	test_must_fail git apply --whitespace=fix patch &&
-	test_cmp one expect &&
+	test_cmp expect one &&
 	test_must_fail git apply --ignore-space-change --whitespace=fix patch &&
-	test_cmp one expect
+	test_cmp expect one
 '
 
 test_expect_success 'tons of blanks at EOF should not apply' '
@@ -342,10 +342,10 @@ test_expect_success 'missing blank line at end with --whitespace=fix' '
 	cp one saved-one &&
 	test_must_fail git apply patch &&
 	git apply --whitespace=fix patch &&
-	test_cmp one expect &&
+	test_cmp expect one &&
 	mv saved-one one &&
 	git apply --ignore-space-change --whitespace=fix patch &&
-	test_cmp one expect
+	test_cmp expect one
 '
 
 test_expect_success 'two missing blank lines at end with --whitespace=fix' '
@@ -360,11 +360,11 @@ test_expect_success 'two missing blank lines at end with --whitespace=fix' '
 	cp no-blank-lines one &&
 	test_must_fail git apply patch &&
 	git apply --whitespace=fix patch &&
-	test_cmp one expect &&
+	test_cmp expect one &&
 	mv no-blank-lines one &&
 	test_must_fail git apply patch &&
 	git apply --ignore-space-change --whitespace=fix patch &&
-	test_cmp one expect
+	test_cmp expect one
 '
 
 test_expect_success 'missing blank line at end, insert before end, --whitespace=fix' '
@@ -376,7 +376,7 @@ test_expect_success 'missing blank line at end, insert before end, --whitespace=
 	echo a >one &&
 	test_must_fail git apply patch &&
 	git apply --whitespace=fix patch &&
-	test_cmp one expect
+	test_cmp expect one
 '
 
 test_expect_success 'shrink file with tons of missing blanks at end of file' '
@@ -392,10 +392,10 @@ test_expect_success 'shrink file with tons of missing blanks at end of file' '
 	cp no-blank-lines one &&
 	test_must_fail git apply patch &&
 	git apply --whitespace=fix patch &&
-	test_cmp one expect &&
+	test_cmp expect one &&
 	mv no-blank-lines one &&
 	git apply --ignore-space-change --whitespace=fix patch &&
-	test_cmp one expect
+	test_cmp expect one
 '
 
 test_expect_success 'missing blanks at EOF must only match blank lines' '
@@ -427,7 +427,7 @@ test_expect_success 'missing blank line should match context line with spaces' '
 	git add one &&
 
 	git apply --whitespace=fix patch &&
-	test_cmp one expect
+	test_cmp expect one
 '
 
 sed -e's/Z//' >one <<EOF
@@ -447,7 +447,7 @@ test_expect_success 'same, but with the --ignore-space-option' '
 
 	git checkout-index -f one &&
 	git apply --ignore-space-change --whitespace=fix patch &&
-	test_cmp one expect
+	test_cmp expect one
 '
 
 test_expect_success 'same, but with CR-LF line endings && cr-at-eol set' '
@@ -464,7 +464,7 @@ test_expect_success 'same, but with CR-LF line endings && cr-at-eol set' '
 	mv save-one one &&
 
 	git apply --ignore-space-change --whitespace=fix patch &&
-	test_cmp one expect
+	test_cmp expect one
 '
 
 test_expect_success 'CR-LF line endings && add line && text=auto' '
@@ -478,7 +478,7 @@ test_expect_success 'CR-LF line endings && add line && text=auto' '
 	mv save-one one &&
 	echo "one text=auto" >.gitattributes &&
 	git apply patch &&
-	test_cmp one expect
+	test_cmp expect one
 '
 
 test_expect_success 'CR-LF line endings && change line && text=auto' '
@@ -491,7 +491,7 @@ test_expect_success 'CR-LF line endings && change line && text=auto' '
 	mv save-one one &&
 	echo "one text=auto" >.gitattributes &&
 	git apply patch &&
-	test_cmp one expect
+	test_cmp expect one
 '
 
 test_expect_success 'LF in repo, CRLF in worktree && change line && text=auto' '
@@ -503,7 +503,7 @@ test_expect_success 'LF in repo, CRLF in worktree && change line && text=auto' '
 	echo "one text=auto" >.gitattributes &&
 	git -c core.eol=CRLF apply patch &&
 	printf "b\r\n" >expect &&
-	test_cmp one expect
+	test_cmp expect one
 '
 
 test_expect_success 'whitespace=fix to expand' '
diff --git a/t/t4138-apply-ws-expansion.sh b/t/t4138-apply-ws-expansion.sh
index 0ffe33fbe..3b636a63a 100755
--- a/t/t4138-apply-ws-expansion.sh
+++ b/t/t4138-apply-ws-expansion.sh
@@ -114,7 +114,7 @@ for t in 1 2 3 4
 do
 	test_expect_success 'apply with ws expansion (t=$t)' '
 		git apply patch$t.patch &&
-		test_cmp test-$t expect-$t
+		test_cmp expect-$t test-$t
 	'
 done
 
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index ce69148ec..c093eb891 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -34,7 +34,7 @@ test_expect_success 'verify blob count in normal packfile' '
 	awk -f print_1.awk |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 test_expect_success 'verify blob:none packfile has no blobs' '
@@ -63,7 +63,7 @@ test_expect_success 'verify normal and blob:none packfiles have same commits/tre
 	awk -f print_1.awk |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 # Test blob:limit=<n>[kmg] filter.
@@ -96,7 +96,7 @@ test_expect_success 'verify blob count in normal packfile' '
 	awk -f print_1.awk |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 test_expect_success 'verify blob:limit=500 omits all blobs' '
@@ -144,7 +144,7 @@ test_expect_success 'verify blob:limit=1001' '
 	awk -f print_1.awk |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 test_expect_success 'verify blob:limit=10001' '
@@ -162,7 +162,7 @@ test_expect_success 'verify blob:limit=10001' '
 	awk -f print_1.awk |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 test_expect_success 'verify blob:limit=1k' '
@@ -180,7 +180,7 @@ test_expect_success 'verify blob:limit=1k' '
 	awk -f print_1.awk |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 test_expect_success 'verify explicitly specifying oversized blob in input' '
@@ -199,7 +199,7 @@ test_expect_success 'verify explicitly specifying oversized blob in input' '
 	awk -f print_1.awk |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 test_expect_success 'verify blob:limit=1m' '
@@ -217,7 +217,7 @@ test_expect_success 'verify blob:limit=1m' '
 	awk -f print_1.awk |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 test_expect_success 'verify normal and blob:limit packfiles have same commits/trees' '
@@ -231,7 +231,7 @@ test_expect_success 'verify normal and blob:limit packfiles have same commits/tr
 	awk -f print_1.awk |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 # Test sparse:path=<path> filter.
@@ -269,7 +269,7 @@ test_expect_success 'verify blob count in normal packfile' '
 	awk -f print_1.awk |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 test_expect_success 'verify sparse:path=pattern1' '
@@ -287,7 +287,7 @@ test_expect_success 'verify sparse:path=pattern1' '
 	awk -f print_1.awk |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 test_expect_success 'verify normal and sparse:path=pattern1 packfiles have same commits/trees' '
@@ -301,7 +301,7 @@ test_expect_success 'verify normal and sparse:path=pattern1 packfiles have same
 	awk -f print_1.awk |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 test_expect_success 'verify sparse:path=pattern2' '
@@ -319,7 +319,7 @@ test_expect_success 'verify sparse:path=pattern2' '
 	awk -f print_1.awk |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 test_expect_success 'verify normal and sparse:path=pattern2 packfiles have same commits/trees' '
@@ -333,7 +333,7 @@ test_expect_success 'verify normal and sparse:path=pattern2 packfiles have same
 	awk -f print_1.awk |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 # Test sparse:oid=<oid-ish> filter.
@@ -370,7 +370,7 @@ test_expect_success 'verify blob count in normal packfile' '
 	awk -f print_1.awk |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 test_expect_success 'verify sparse:oid=OID' '
@@ -389,7 +389,7 @@ test_expect_success 'verify sparse:oid=OID' '
 	awk -f print_1.awk |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 test_expect_success 'verify sparse:oid=oid-ish' '
@@ -407,7 +407,7 @@ test_expect_success 'verify sparse:oid=oid-ish' '
 	awk -f print_1.awk |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 # Delete some loose objects and use pack-objects, but WITHOUT any filtering.
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 0c500f7ca..d6da3ce4e 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -35,7 +35,7 @@ test_expect_success 'create commits and repack' '
 graph_git_two_modes() {
 	git -c core.commitGraph=true $1 >output
 	git -c core.commitGraph=false $1 >expect
-	test_cmp output expect
+	test_cmp expect output
 }
 
 graph_git_behavior() {
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 75ec79e6c..bf139e245 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -16,7 +16,7 @@ test_expect_success 'test capability advertisement' '
 
 	git serve --advertise-capabilities >out &&
 	test-pkt-line unpack <out >actual &&
-	test_cmp actual expect
+	test_cmp expect actual
 '
 
 test_expect_success 'stateless-rpc flag does not list capabilities' '
@@ -89,7 +89,7 @@ test_expect_success 'basics of ls-refs' '
 
 	git serve --stateless-rpc <in >out &&
 	test-pkt-line unpack <out >actual &&
-	test_cmp actual expect
+	test_cmp expect actual
 '
 
 test_expect_success 'basic ref-prefixes' '
@@ -109,7 +109,7 @@ test_expect_success 'basic ref-prefixes' '
 
 	git serve --stateless-rpc <in >out &&
 	test-pkt-line unpack <out >actual &&
-	test_cmp actual expect
+	test_cmp expect actual
 '
 
 test_expect_success 'refs/heads prefix' '
@@ -129,7 +129,7 @@ test_expect_success 'refs/heads prefix' '
 
 	git serve --stateless-rpc <in >out &&
 	test-pkt-line unpack <out >actual &&
-	test_cmp actual expect
+	test_cmp expect actual
 '
 
 test_expect_success 'peel parameter' '
@@ -150,7 +150,7 @@ test_expect_success 'peel parameter' '
 
 	git serve --stateless-rpc <in >out &&
 	test-pkt-line unpack <out >actual &&
-	test_cmp actual expect
+	test_cmp expect actual
 '
 
 test_expect_success 'symrefs parameter' '
@@ -171,7 +171,7 @@ test_expect_success 'symrefs parameter' '
 
 	git serve --stateless-rpc <in >out &&
 	test-pkt-line unpack <out >actual &&
-	test_cmp actual expect
+	test_cmp expect actual
 '
 
 test_expect_success 'sending server-options' '
@@ -191,7 +191,7 @@ test_expect_success 'sending server-options' '
 
 	git serve --stateless-rpc <in >out &&
 	test-pkt-line unpack <out >actual &&
-	test_cmp actual expect
+	test_cmp expect actual
 '
 
 test_expect_success 'unexpected lines are not allowed in fetch request' '
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 3beeed454..54727450b 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -29,7 +29,7 @@ test_expect_success 'list refs with git:// using protocol v2' '
 	grep "git< version 2" log &&
 
 	git ls-remote --symref "$GIT_DAEMON_URL/parent" >expect &&
-	test_cmp actual expect
+	test_cmp expect actual
 '
 
 test_expect_success 'ref advertisment is filtered with ls-remote using protocol v2' '
@@ -42,7 +42,7 @@ test_expect_success 'ref advertisment is filtered with ls-remote using protocol
 	$(git -C "$daemon_parent" rev-parse refs/heads/master)$(printf "\t")refs/heads/master
 	EOF
 
-	test_cmp actual expect
+	test_cmp expect actual
 '
 
 test_expect_success 'clone with git:// using protocol v2' '
@@ -138,7 +138,7 @@ test_expect_success 'list refs with file:// using protocol v2' '
 	grep "git< version 2" log &&
 
 	git ls-remote --symref "file://$(pwd)/file_parent" >expect &&
-	test_cmp actual expect
+	test_cmp expect actual
 '
 
 test_expect_success 'ref advertisment is filtered with ls-remote using protocol v2' '
@@ -151,7 +151,7 @@ test_expect_success 'ref advertisment is filtered with ls-remote using protocol
 	$(git -C file_parent rev-parse refs/heads/master)$(printf "\t")refs/heads/master
 	EOF
 
-	test_cmp actual expect
+	test_cmp expect actual
 '
 
 test_expect_success 'server-options are sent when using ls-remote' '
@@ -164,7 +164,7 @@ test_expect_success 'server-options are sent when using ls-remote' '
 	$(git -C file_parent rev-parse refs/heads/master)$(printf "\t")refs/heads/master
 	EOF
 
-	test_cmp actual expect &&
+	test_cmp expect actual &&
 	grep "server-option=hello" log &&
 	grep "server-option=world" log
 '
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index 20aee43f9..51ee887a7 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -99,7 +99,7 @@ EOF
 printf "propter nomen suum." >> expect.txt
 
 test_expect_success "merge does not add LF away of change" \
-	"test_cmp test3.txt expect.txt"
+	"test_cmp expect.txt test3.txt"
 
 cp test.txt backup.txt
 test_expect_success "merge with conflicts" \
@@ -122,7 +122,7 @@ non timebo mala, quoniam tu mecum es:
 virga tua et baculus tuus ipsa me consolata sunt.
 EOF
 
-test_expect_success "expected conflict markers" "test_cmp test.txt expect.txt"
+test_expect_success "expected conflict markers" "test_cmp expect.txt test.txt"
 
 cp backup.txt test.txt
 
@@ -138,7 +138,7 @@ non timebo mala, quoniam tu mecum es:
 virga tua et baculus tuus ipsa me consolata sunt.
 EOF
 test_expect_success "merge conflicting with --ours" \
-	"git merge-file --ours test.txt orig.txt new3.txt && test_cmp test.txt expect.txt"
+	"git merge-file --ours test.txt orig.txt new3.txt && test_cmp expect.txt test.txt"
 cp backup.txt test.txt
 
 cat > expect.txt << EOF
@@ -154,7 +154,7 @@ non timebo mala, quoniam tu mecum es:
 virga tua et baculus tuus ipsa me consolata sunt.
 EOF
 test_expect_success "merge conflicting with --theirs" \
-	"git merge-file --theirs test.txt orig.txt new3.txt && test_cmp test.txt expect.txt"
+	"git merge-file --theirs test.txt orig.txt new3.txt && test_cmp expect.txt test.txt"
 cp backup.txt test.txt
 
 cat > expect.txt << EOF
@@ -171,7 +171,7 @@ non timebo mala, quoniam tu mecum es:
 virga tua et baculus tuus ipsa me consolata sunt.
 EOF
 test_expect_success "merge conflicting with --union" \
-	"git merge-file --union test.txt orig.txt new3.txt && test_cmp test.txt expect.txt"
+	"git merge-file --union test.txt orig.txt new3.txt && test_cmp expect.txt test.txt"
 cp backup.txt test.txt
 
 test_expect_success "merge with conflicts, using -L" \
@@ -195,7 +195,7 @@ virga tua et baculus tuus ipsa me consolata sunt.
 EOF
 
 test_expect_success "expected conflict markers, with -L" \
-	"test_cmp test.txt expect.txt"
+	"test_cmp expect.txt test.txt"
 
 sed "s/ tu / TU /" < new1.txt > new5.txt
 test_expect_success "conflict in removed tail" \
diff --git a/t/t6027-merge-binary.sh b/t/t6027-merge-binary.sh
index 07735410b..4e6c7cb77 100755
--- a/t/t6027-merge-binary.sh
+++ b/t/t6027-merge-binary.sh
@@ -45,7 +45,7 @@ test_expect_success resolve '
 		false
 	else
 		git ls-files -s >current
-		test_cmp current expect
+		test_cmp expect current
 	fi
 '
 
@@ -60,7 +60,7 @@ test_expect_success recursive '
 		false
 	else
 		git ls-files -s >current
-		test_cmp current expect
+		test_cmp expect current
 	fi
 '
 
diff --git a/t/t6031-merge-filemode.sh b/t/t6031-merge-filemode.sh
index 7d06461f1..87741efad 100755
--- a/t/t6031-merge-filemode.sh
+++ b/t/t6031-merge-filemode.sh
@@ -61,7 +61,7 @@ do_both_modes () {
 		git checkout -f a2 &&
 		test_must_fail git merge -s $strategy b2 &&
 		git ls-files -u >actual &&
-		test_cmp actual expect &&
+		test_cmp expect actual &&
 		git ls-files -s file2 | grep ^100755
 	'
 
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 0f6b569e1..ae4402226 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -29,7 +29,7 @@ test_expect_success 'verify blob:none omits all 5 blobs' '
 	sed "s/~//" |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 test_expect_success 'verify emitted+omitted == all' '
@@ -42,7 +42,7 @@ test_expect_success 'verify emitted+omitted == all' '
 	sed "s/~//" |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 
@@ -71,7 +71,7 @@ test_expect_success 'verify blob:limit=500 omits all blobs' '
 	sed "s/~//" |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 test_expect_success 'verify emitted+omitted == all' '
@@ -84,7 +84,7 @@ test_expect_success 'verify emitted+omitted == all' '
 	sed "s/~//" |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 test_expect_success 'verify blob:limit=1000' '
@@ -97,7 +97,7 @@ test_expect_success 'verify blob:limit=1000' '
 	sed "s/~//" |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 test_expect_success 'verify blob:limit=1001' '
@@ -110,7 +110,7 @@ test_expect_success 'verify blob:limit=1001' '
 	sed "s/~//" |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 test_expect_success 'verify blob:limit=1k' '
@@ -123,7 +123,7 @@ test_expect_success 'verify blob:limit=1k' '
 	sed "s/~//" |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 test_expect_success 'verify blob:limit=1m' '
@@ -165,7 +165,7 @@ test_expect_success 'verify sparse:path=pattern1 omits top-level files' '
 	sed "s/~//" |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 test_expect_success 'verify sparse:path=pattern2 omits both sparse2 files' '
@@ -178,7 +178,7 @@ test_expect_success 'verify sparse:path=pattern2 omits both sparse2 files' '
 	sed "s/~//" |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 # Test sparse:oid=<oid-ish> filter.
@@ -203,7 +203,7 @@ test_expect_success 'verify sparse:oid=OID omits top-level files' '
 	sed "s/~//" |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 test_expect_success 'verify sparse:oid=oid-ish omits top-level files' '
@@ -216,7 +216,7 @@ test_expect_success 'verify sparse:oid=oid-ish omits top-level files' '
 	sed "s/~//" |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 # Delete some loose objects and use rev-list, but WITHOUT any filtering.
@@ -237,7 +237,7 @@ test_expect_success 'rev-list W/ --missing=print' '
 	sed "s/?//" |
 	sort >observed &&
 
-	test_cmp observed expected
+	test_cmp expected observed
 '
 
 test_expect_success 'rev-list W/O --missing fails' '
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 324933acf..826987ca8 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -160,7 +160,7 @@ test_expect_success 'checkout -m with merge conflict' '
 	git diff master:one :3:uno |
 	sed -e "1,/^@@/d" -e "/^ /d" -e "s/^-/d/" -e "s/^+/a/" >current &&
 	fill d2 aT d7 aS >expect &&
-	test_cmp current expect &&
+	test_cmp expect current &&
 	git diff --cached two >current &&
 	test_must_be_empty current
 '
@@ -174,7 +174,7 @@ test_expect_success 'format of merge conflict from checkout -m' '
 
 	git ls-files >current &&
 	fill same two two two >expect &&
-	test_cmp current expect &&
+	test_cmp expect current &&
 
 	cat <<-EOF >expect &&
 	<<<<<<< simple
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 10dc91620..e87164aa8 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -789,7 +789,7 @@ test_expect_success 'submodule add places git-dir in superprojects git-dir' '
 	 (cd .git/modules/deeper/submodule &&
 	  git log > ../../../../actual
 	 ) &&
-	 test_cmp actual expected
+	 test_cmp expected actual
 	)
 '
 
@@ -807,7 +807,7 @@ test_expect_success 'submodule update places git-dir in superprojects git-dir' '
 	 (cd .git/modules/deeper/submodule &&
 	  git log > ../../../../actual
 	 ) &&
-	 test_cmp actual expected
+	 test_cmp expected actual
 	)
 '
 
@@ -827,7 +827,7 @@ test_expect_success 'submodule add places git-dir in superprojects git-dir recur
 	 git add deeper/submodule &&
 	 git commit -m "update submodule" &&
 	 git push origin : &&
-	 test_cmp actual expected
+	 test_cmp expected actual
 	)
 '
 
@@ -874,7 +874,7 @@ test_expect_success 'submodule update places git-dir in superprojects git-dir re
 	 (cd .git/modules/submodule/modules/subsubmodule &&
 	  git log > ../../../../../actual
 	 ) &&
-	 test_cmp actual expected
+	 test_cmp expected actual
 	)
 '
 
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 668bbee73..562bd215a 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -557,7 +557,7 @@ test_expect_success SYMLINKS 'difftool --dir-diff --symlink without unstaged cha
 	EOF
 	git difftool --dir-diff --symlink \
 		--extcmd "./.git/CHECK_SYMLINKS" branch HEAD &&
-	test_cmp actual expect
+	test_cmp expect actual
 '
 
 write_script modify-right-file <<\EOF
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 9af607884..2c309a57d 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -221,7 +221,7 @@ tree d667270a1f7b109f5eb3aaea21ede14b56bfdd6e
 tree 8f51f74cf0163afc9ad68a4b1537288c4558b5a4
 EOF
 
-test_expect_success POSIXPERM,SYMLINKS "$name" "test_cmp a expected"
+test_expect_success POSIXPERM,SYMLINKS "$name" "test_cmp expected a"
 
 test_expect_success 'exit if remote refs are ambigious' '
         git config --add svn-remote.svn.fetch \
diff --git a/t/t9133-git-svn-nested-git-repo.sh b/t/t9133-git-svn-nested-git-repo.sh
index f3c30e63b..f89486086 100755
--- a/t/t9133-git-svn-nested-git-repo.sh
+++ b/t/t9133-git-svn-nested-git-repo.sh
@@ -45,7 +45,7 @@ test_expect_success 'update git svn-cloned repo' '
 		git svn rebase &&
 		echo a > expect &&
 		echo b >> expect &&
-		test_cmp a expect &&
+		test_cmp expect a &&
 		rm expect
 	)
 '
@@ -69,7 +69,7 @@ test_expect_success 'update git svn-cloned repo' '
 		git svn rebase &&
 		echo a > expect &&
 		echo b >> expect &&
-		test_cmp a expect &&
+		test_cmp expect a &&
 		rm expect
 	)
 '
@@ -93,7 +93,7 @@ test_expect_success 'update git svn-cloned repo again' '
 		echo a > expect &&
 		echo b >> expect &&
 		echo c >> expect &&
-		test_cmp a expect &&
+		test_cmp expect a &&
 		rm expect
 	)
 '
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 5dfee07d9..251fdd66c 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -148,7 +148,7 @@ test_expect_success PERL 'import from a CVS working tree' '
 		git cvsimport -a -z0 &&
 		echo 1 >expect &&
 		git log -1 --pretty=format:%s%n >actual &&
-		test_cmp actual expect
+		test_cmp expect actual
 	)
 
 '
diff --git a/t/t9603-cvsimport-patchsets.sh b/t/t9603-cvsimport-patchsets.sh
index c4c3c4954..3e64b11ea 100755
--- a/t/t9603-cvsimport-patchsets.sh
+++ b/t/t9603-cvsimport-patchsets.sh
@@ -29,11 +29,11 @@ test_expect_failure PERL 'import with criss cross times on revisions' '
 Rev 3
 Rev 2
 Rev 1" > expect-master &&
-    test_cmp actual-master expect-master &&
+    test_cmp expect-master actual-master &&
 
     echo "Rev 5 Branch A Wed Mar 11 19:09:10 2009 +0000
 Rev 4 Branch A Wed Mar 11 19:03:52 2009 +0000" > expect-A &&
-    test_cmp actual-A expect-A
+    test_cmp expect-A actual-A
 '
 
 test_done
diff --git a/t/t9604-cvsimport-timestamps.sh b/t/t9604-cvsimport-timestamps.sh
index a4b3db24b..2ff4aa932 100755
--- a/t/t9604-cvsimport-timestamps.sh
+++ b/t/t9604-cvsimport-timestamps.sh
@@ -31,7 +31,7 @@ test_expect_success PERL 'check timestamps are UTC (TZ=CST6CDT)' '
 	Rev  2 2005-02-01 00:00:00 +0000
 	Rev  1 2005-01-01 00:00:00 +0000
 	EOF
-	test_cmp actual-1 expect-1
+	test_cmp expect-1 actual-1
 '
 
 test_expect_success PERL 'check timestamps with author-specific timezones' '
@@ -65,7 +65,7 @@ test_expect_success PERL 'check timestamps with author-specific timezones' '
 	Rev  2 2005-01-31 18:00:00 -0600 User Two
 	Rev  1 2005-01-01 00:00:00 +0000 User One
 	EOF
-	test_cmp actual-2 expect-2
+	test_cmp expect-2 actual-2
 '
 
 test_done
-- 
2.19.0.605.g01d371f741-goog

