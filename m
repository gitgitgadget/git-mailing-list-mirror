Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF2CC433EF
	for <git@archiver.kernel.org>; Sun, 19 Jun 2022 06:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbiFSGur (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jun 2022 02:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbiFSGuj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jun 2022 02:50:39 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39924B1C2
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 23:50:38 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id g4so10585617wrh.11
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 23:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Agsq2Wf9D/YaxwlLDiCGryUih1KGDxKwRg1Umh8QQUI=;
        b=he8EVVlIGMdbBWcNiwhRHNHPKYvmCxRPMta0UtfYKAkLG7cMdcgRlFRahghuQ8Sknx
         YKr8Ag2HifoALxWIooeP0Gb9vOgOdM7JqdYQVgigbaWlCW9iy4ZH2jp3UoGrAgVOPuW0
         Ua9Uj6B9atgorAJFkCET352rvc9jdjh4UqtkiiZOmA0K+gQymU9S665dIJIgNV3DDl1R
         aD0ZQhzEEgSsgzeUJkg1otW3XDAkbrKi9w7JcA2oT2GQ2gNMyAD80zXg+FJm7dCtuGfx
         UQaGwk7ZDLDefcKH2EnBXW8J8uNuWoWjDHGtAM2jPKg0B3pDCYkCotCdogiJrEF4v9bn
         DxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Agsq2Wf9D/YaxwlLDiCGryUih1KGDxKwRg1Umh8QQUI=;
        b=fgu2IB+HG3lKlCttFg3y4pzNt8nCdDTscMrPlj61OCDhL1OFfDD5ShJebOJYgZ1a5p
         UmRLvpzxVj7TJeoZTOC3y7ehMj2AbAq/w5bLmzKTzgccwE6mZc3iL6WOzEgTr1FGr/Q4
         tTSVhoIXlbQrmof+switFoZo+vTz32mKmgWHbz22m4CzBCvxhhwD5WwUOxaOStqkdCjV
         t55pb2YBqjI8ohgwt5ghoXxZthecPbPkUjsikoUq1zBkmMknGUnc47gWhBf2SspTJy8O
         dkjpA7ZhH0KRbV5XqlQ0mKMoqQ63oYrF/cck7zWg9SEDFvfzuZFQlBx28sVYbWoOfwSl
         5uCA==
X-Gm-Message-State: AJIora8PN2snTQMaGqwG2N56yB4dRTNtHRiFOP08G0J7qjcTXKVBdPzv
        HOPOGoVPT21o4IqUI7mILAfDCUA2DKndRA==
X-Google-Smtp-Source: AGRyM1uW2RBe1cMRQGbrl7hPvtocNFtB2VDXuvdxmJQTxeS1614k/WtNyhtbLvgwiTZ4+g2un8F0uQ==
X-Received: by 2002:a5d:5c04:0:b0:21a:23e0:6ba3 with SMTP id cc4-20020a5d5c04000000b0021a23e06ba3mr17269686wrb.71.1655621437366;
        Sat, 18 Jun 2022 23:50:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6-20020a5d6206000000b0021350f7b22esm10008722wru.109.2022.06.18.23.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 23:50:36 -0700 (PDT)
Message-Id: <0783b48c121fe74051c13e7d9118d1a5b7cb9aa9.1655621424.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
        <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Jun 2022 06:50:24 +0000
Subject: [PATCH v2 6/6] merge: do not exit restore_state() prematurely
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Previously, if the user:

* Had no local changes before starting the merge
* A merge strategy makes changes to the working tree/index but returns
  with exit status 2

Then we'd call restore_state() to clean up the changes and either let
the next merge strategy run (if there is one), or exit telling the user
that no merge strategy could handle the merge.  Unfortunately,
restore_state() did not clean up the changes as expected; that function
was a no-op if the stash was a null, and the stash would be null if
there were no local changes before starting the merge.  So, instead of
"Rewinding the tree to pristine..." as the code claimed, restore_state()
would leave garbage around in the index and working tree (possibly
including conflicts) for either the next merge strategy or for the user
after aborting the merge.  And in the case of aborting the merge, the
user would be unable to run "git merge --abort" to get rid of the
unintended leftover conflicts, because the merge control files were not
written as it was presumed that we had restored to a clean state
already.

Fix the main problem by making sure that restore_state() only skips the
stash application if the stash is null rather than skipping the whole
function.

However, there is a secondary problem -- since merge.c forks
subprocesses to do the cleanup, the in-memory index is left out-of-sync.
While there was a refresh_cache(REFRESH_QUIET) call that attempted to
correct that, that function would not handle cases where the previous
merge strategy added conflicted entries.  We need to drop the index and
re-read it to handle such cases.

(Alternatively, we could stop forking subprocesses and instead call some
appropriate function to do the work which would update the in-memory
index automatically.  For now, just do the simple fix.)

Reported-by: ZheNing Hu <adlternative@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c        | 10 ++++++----
 t/t7607-merge-state.sh | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 4 deletions(-)
 create mode 100755 t/t7607-merge-state.sh

diff --git a/builtin/merge.c b/builtin/merge.c
index aaee8f6a553..a21dece1b55 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -385,11 +385,11 @@ static void restore_state(const struct object_id *head,
 {
 	const char *args[] = { "stash", "apply", "--index", NULL, NULL };
 
-	if (is_null_oid(stash))
-		return;
-
 	reset_hard(head, 1);
 
+	if (is_null_oid(stash))
+		goto refresh_cache;
+
 	args[3] = oid_to_hex(stash);
 
 	/*
@@ -398,7 +398,9 @@ static void restore_state(const struct object_id *head,
 	 */
 	run_command_v_opt(args, RUN_GIT_CMD);
 
-	refresh_cache(REFRESH_QUIET);
+refresh_cache:
+	if (discard_cache() < 0 || read_cache() < 0)
+		die(_("could not read index"));
 }
 
 /* This is called when no merge was necessary. */
diff --git a/t/t7607-merge-state.sh b/t/t7607-merge-state.sh
new file mode 100755
index 00000000000..655478cd0b3
--- /dev/null
+++ b/t/t7607-merge-state.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+test_description="Test that merge state is as expected after failed merge"
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+. ./test-lib.sh
+
+test_expect_success 'set up custom strategy' '
+	test_commit --no-tag "Initial" base base &&
+git show-ref &&
+
+	for b in branch1 branch2 branch3
+	do
+		git checkout -b $b main &&
+		test_commit --no-tag "Change on $b" base $b
+	done &&
+
+	git checkout branch1 &&
+	test_must_fail git merge branch2 branch3 &&
+	git diff --exit-code --name-status &&
+	test_path_is_missing .git/MERGE_HEAD
+'
+
+test_done
-- 
gitgitgadget
