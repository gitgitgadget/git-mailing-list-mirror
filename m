Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EB701F731
	for <e@80x24.org>; Thu,  1 Aug 2019 22:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389439AbfHAWU6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 18:20:58 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:49361 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729750AbfHAWU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 18:20:58 -0400
Received: by mail-qt1-f201.google.com with SMTP id l16so59343743qtq.16
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 15:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HZBcqrPynoQhiVNi5IwOba8mqaeypL2a5fyqZP55ZLQ=;
        b=gUO1cQ/Rj11GyJqjm+0Ajn1gy5GHqT9LI0C3PzjBVZS3HADPoZMjHkpUFRCuIEDgGG
         zE7HBCi1me2WKWHaHXXgXbOB/QBxVp8wZfTRfn8ibM8YRZlGLTC2ahOZ7BJfUIGsRQ34
         D9jeDWbAD4dHSCUQvrPE3MF8pwX1wMFbC57wJR5hRbh1tlsKNRCv92eiKaiTRkjJ2Wyv
         1wcjIih+phlGXuVX6bmOjQTf2uvLq1S0IDkzr8MEN8wmGvjSVxFP6pt4hNXOXjZNkHad
         /xNSAVrAtzKoJP2BTgW08wyKGm6Mj0VzefPl/eUNFCZIEPBQ9fymCMVwmYNjqRNKs6wc
         9Crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HZBcqrPynoQhiVNi5IwOba8mqaeypL2a5fyqZP55ZLQ=;
        b=ko8QP8XYlc2+kzFEIK2txMNHe0B0OmzAlB+90UiUILjxSrn91Qavt3vZ1MsTTi8pb/
         yW3nYw69OTJycJz2sCQZu7b0BsU4ARDbuHHd5rdO+sf9/VONv8kvvMSSm9Qcminua2xt
         TxDCe6wQ6hM6s3o2ffCBBZwrun9GiRZCK6DnAEWjS7hPbyLpadcexd3itl7kzRIed5Lb
         MbP+HWykPoSkl00d8Wh0uWJjbTr6KfdyIAMqbxQrMlgdICrOblVXTbX8LB8GOYYEGQY3
         eTR5Y86Pa03nV8zH4B8XqR2Cxi8v1alv4IF4Jq3Ofj7O3w0vocx2Qx5SY6UE8CuUwHaz
         b58A==
X-Gm-Message-State: APjAAAUIQcELtNUIIy7FWSWZtk0GhCGRIj4+nafUImZZkDyMqw71y2zJ
        suJwW1St2tPsiAWiwWsOMg2dCD3xhL5RuLCkIN41J+W8aI1CcDLmUt6Z/Vjuk/vLmY9tvn7Fzt9
        it/WKh8I9ps4wlWRxXCabejv0xo0OqPohDjjIC4Fsras7bRy2iuA25mtNdDQw9uw=
X-Google-Smtp-Source: APXvYqzlpeoOY8oI0spBXG3XF8CaFGn+EmpKfgtlHCUJq8m4NrFH41gbWClv4azMzZxRDRH+0u+B2wQgYI5X3Q==
X-Received: by 2002:a0c:b036:: with SMTP id k51mr96622360qvc.103.1564698056999;
 Thu, 01 Aug 2019 15:20:56 -0700 (PDT)
Date:   Thu,  1 Aug 2019 15:20:45 -0700
In-Reply-To: <cover.1564695892.git.steadmon@google.com>
Message-Id: <61b989ff16eadfd0508e10f71c9b318eb15ce2a7.1564695893.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1563490164.git.steadmon@google.com> <cover.1564695892.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH v3 3/4] git-merge: honor pre-merge-commit hook
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@grubix.eu, martin.agren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-merge does not honor the pre-commit hook when doing automatic merge
commits, and for compatibility reasons this is going to stay.

Introduce a pre-merge-commit hook which is called for an automatic merge
commit just like pre-commit is called for a non-automatic merge commit
(or any other commit).

[js: * renamed hook from "pre-merge" to "pre-merge-commit"
     * only discard the index if the hook is actually present
     * clarified that hook should write messages to stderr
     * squashed test changes from the original series' patch 4/4
     * modified tests to follow new pattern from this series' patch 1/4
     * reworded commit message
]

Signed-off-by: Michael J Gruber <git@grubix.eu>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/githooks.txt                    |  7 +++
 builtin/merge.c                               | 12 +++++
 ...-pre-commit-and-pre-merge-commit-hooks.sh} | 45 ++++++++++++++++++-
 templates/hooks--pre-merge-commit.sample      | 13 ++++++
 4 files changed, 76 insertions(+), 1 deletion(-)
 rename t/{t7503-pre-commit-hook.sh => t7503-pre-commit-and-pre-merge-commit-hooks.sh} (78%)
 create mode 100755 templates/hooks--pre-merge-commit.sample

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 82cd573776..7c4c994858 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -103,6 +103,13 @@ The default 'pre-commit' hook, when enabled--and with the
 `hooks.allownonascii` config option unset or set to false--prevents
 the use of non-ASCII filenames.
 
+pre-merge-commit
+~~~~~~~~~~~~~~~~
+
+This hook is invoked by 'git merge' when doing an automatic merge
+commit; it is equivalent to 'pre-commit' for a non-automatic commit
+for a merge.
+
 prepare-commit-msg
 ~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 4425a7a12e..bf0ae68c40 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -816,6 +816,18 @@ static void write_merge_heads(struct commit_list *);
 static void prepare_to_commit(struct commit_list *remoteheads)
 {
 	struct strbuf msg = STRBUF_INIT;
+	const char *index_file = get_index_file();
+
+	if (run_commit_hook(0 < option_edit, index_file, "pre-merge-commit", NULL))
+		abort_commit(remoteheads, NULL);
+	/*
+	 * Re-read the index as pre-merge-commit hook could have updated it,
+	 * and write it out as a tree.  We must do this before we invoke
+	 * the editor and after we invoke run_status above.
+	 */
+	if (find_hook("pre-merge-commit"))
+		discard_cache();
+	read_cache_from(index_file);
 	strbuf_addbuf(&msg, &merge_msg);
 	if (squash)
 		BUG("the control must not reach here under --squash");
diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
similarity index 78%
rename from t/t7503-pre-commit-hook.sh
rename to t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
index 500bdd97c2..040dfa0175 100755
--- a/t/t7503-pre-commit-hook.sh
+++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
@@ -1,11 +1,12 @@
 #!/bin/sh
 
-test_description='pre-commit hook'
+test_description='pre-commit and pre-merge-commit hooks'
 
 . ./test-lib.sh
 
 HOOKDIR="$(git rev-parse --git-dir)/hooks"
 PRECOMMIT="$HOOKDIR/pre-commit"
+PREMERGE="$HOOKDIR/pre-merge-commit"
 
 # Prepare sample scripts that write their $0 to actual_hooks
 test_expect_success 'sample script setup' '
@@ -29,6 +30,17 @@ test_expect_success 'sample script setup' '
 	EOF
 '
 
+test_expect_success 'root commit' '
+	echo "root" > file &&
+	git add file &&
+	git commit -m "zeroth" &&
+	git checkout -b side &&
+	echo "foo" > foo &&
+	git add foo &&
+	git commit -m "make it non-ff" &&
+	git checkout master
+'
+
 test_expect_success 'with no hook' '
 	test_when_finished "rm -f expected_hooks actual_hooks" &&
 	touch expected_hooks actual_hooks &&
@@ -38,6 +50,15 @@ test_expect_success 'with no hook' '
 	test_cmp expected_hooks actual_hooks
 '
 
+test_expect_success 'with no hook (merge)' '
+	test_when_finished "rm -f expected_hooks actual_hooks" &&
+	touch expected_hooks actual_hooks &&
+	git checkout side &&
+	git merge -m "merge master" master &&
+	git checkout master &&
+	test_cmp expected_hooks actual_hooks
+'
+
 test_expect_success '--no-verify with no hook' '
 	test_when_finished "rm -f expected_hooks actual_hooks" &&
 	touch expected_hooks actual_hooks &&
@@ -58,6 +79,17 @@ test_expect_success 'with succeeding hook' '
 	test_cmp expected_hooks actual_hooks
 '
 
+test_expect_success 'with succeeding hook (merge)' '
+	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks" &&
+	ln -s "success.sample" "$PREMERGE" &&
+	touch actual_hooks &&
+	echo "$PREMERGE" >expected_hooks &&
+	git checkout side &&
+	git merge -m "merge master" master &&
+	git checkout master &&
+	test_cmp expected_hooks actual_hooks
+'
+
 test_expect_success '--no-verify with succeeding hook' '
 	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
 	ln -s "success.sample" "$PRECOMMIT" &&
@@ -89,6 +121,17 @@ test_expect_success '--no-verify with failing hook' '
 	test_cmp expected_hooks actual_hooks
 '
 
+test_expect_success 'with failing hook (merge)' '
+	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks" &&
+	ln -s "fail.sample" "$PREMERGE" &&
+	touch actual_hooks &&
+	echo "$PREMERGE" >expected_hooks &&
+	git checkout side &&
+	test_must_fail git merge -m "merge master" master &&
+	git checkout master &&
+	test_cmp expected_hooks actual_hooks
+'
+
 test_expect_success POSIXPERM 'with non-executable hook' '
 	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks; chmod +x \"$HOOKDIR/fail.sample\"" &&
 	ln -s "fail.sample" "$PRECOMMIT" &&
diff --git a/templates/hooks--pre-merge-commit.sample b/templates/hooks--pre-merge-commit.sample
new file mode 100755
index 0000000000..399eab1924
--- /dev/null
+++ b/templates/hooks--pre-merge-commit.sample
@@ -0,0 +1,13 @@
+#!/bin/sh
+#
+# An example hook script to verify what is about to be committed.
+# Called by "git merge" with no arguments.  The hook should
+# exit with non-zero status after issuing an appropriate message to
+# stderr if it wants to stop the merge commit.
+#
+# To enable this hook, rename this file to "pre-merge-commit".
+
+. git-sh-setup
+test -x "$GIT_DIR/hooks/pre-commit" &&
+        exec "$GIT_DIR/hooks/pre-commit"
+:
-- 
2.22.0.770.g0f2c4a37fd-goog

