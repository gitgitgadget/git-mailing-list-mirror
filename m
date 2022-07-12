Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C497CCA47C
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 13:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiGLNHu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 09:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbiGLNH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 09:07:29 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1F8B5D08
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:07:22 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v14so11097405wra.5
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bIHkZC8xLAGUYytjtE5i+/Fu795PmAoTffHp0ygxWC0=;
        b=Tujf3FO3yLHPritKsr1hoHw1OCD0dtba3Xz4UPYsCPDm3YMB2yQSUqDqLA3UfKt0+7
         mL4N3EGsS72HDrczJaMHhRCqIpDM5rTJEgQXJ42tdAs7WIzXkJUejmrLYZQ8aNoqb7RB
         4KbIOmq+6R7JljsPr/KfMHwaOrvI6Hjmk4Ae9LuqSlaeuFhMDagD/FW3+km61nqNLl1m
         3ZNw4EDVvfeHqCdqxn3ma3Q+IRc1R3AB+cq85I5FGvY5jsBFRq2JCRnrrj6xTJn8o3Fq
         eA2FPhq3ytVjdt1mqCN/SaQiQ5HloXlthEd/efY+qF+xhUrO49ARDVUDwzNBJV5+UFLZ
         x7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bIHkZC8xLAGUYytjtE5i+/Fu795PmAoTffHp0ygxWC0=;
        b=kPR4r6euTvIjKolPKXY2hzu4LYwzrxyvBY113AO+oc78/NBNuaQJD4c+u1GUltpp0B
         V4xceM7slqtgpkT+FQMDyHcqTJ1GCnSg6KtaHwPUGiKLi7zDvHFdkjPsCf3v5v39Zmhu
         4cLDFHeTKEnEXTRFe40Uox0QbnvFU3P3Y7OFu1a5DFto0BMc8k9xlXI/VQtOqzQ0k/nw
         bWBDRfBLedK3iY9lAoru4sH3wnpO+EJepeOdkyFyfaTwGM1qWi8ZOsyx7Rgd7CC232tt
         siSNLR4VZCYY1VK7MlwKDm7pkgYK7KbAFYvfq1JrHi3+xNDOzElndU5k3TjFcnKGmpkw
         2KHg==
X-Gm-Message-State: AJIora9/J50CHLIrOZ5xsLwN3e+bJN3gE1vMW9qr9ujZtDZ4iXg2pAnT
        XZuG8XT+PLlZHB2kisQBmNI7vAQ+NUc=
X-Google-Smtp-Source: AGRyM1vwsx8ntwhed7I+ISF0zCtIeeBuphgq12NXrvEFaKb0MB1/5Xfl4bqVtk5nsUrqWoISOjFvvQ==
X-Received: by 2002:a05:6000:1567:b0:21d:abdb:29e1 with SMTP id 7-20020a056000156700b0021dabdb29e1mr7495208wrz.36.1657631241410;
        Tue, 12 Jul 2022 06:07:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c1d1300b003976fbfbf00sm9245999wms.30.2022.07.12.06.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:07:20 -0700 (PDT)
Message-Id: <fb5f64c52010e01ce0b5a886e9611fa2a6ea7833.1657631226.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
        <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jul 2022 13:07:01 +0000
Subject: [PATCH v4 08/12] rebase: update refs from 'update-ref' commands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous change introduced the 'git rebase --update-refs' option
which added 'update-ref <ref>' commands to the todo list of an
interactive rebase.

Teach Git to record the HEAD position when reaching these 'update-ref'
commands. The ref/before/after triple is stored in the
$GIT_DIR/rebase-merge/update-refs file. A previous change parsed this
file to avoid having other processes updating the refs in that file
while the rebase is in progress.

Not only do we update the file when the sequencer reaches these
'update-ref' commands, we then update the refs themselves at the end of
the rebase sequence. If the rebase is aborted before this final step,
then the refs are not updated. The 'before' value is used to ensure that
we do not accidentally obliterate a ref that was updated concurrently
(say, by an older version of Git or a third-party tool).

Now that the 'git rebase --update-refs' command is implemented to write
to the update-refs file, we can remove the fake construction of the
update-refs file from a test in t2407-worktree-heads.sh.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 sequencer.c                   | 113 +++++++++++++++++++++++++++++++++-
 t/t2407-worktree-heads.sh     |  21 ++-----
 t/t3404-rebase-interactive.sh |  17 +++++
 3 files changed, 134 insertions(+), 17 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e657862cda2..2d89b3b727a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -36,6 +36,7 @@
 #include "rebase-interactive.h"
 #include "reset.h"
 #include "branch.h"
+#include "log-tree.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -193,6 +194,19 @@ struct update_ref_record {
 	struct object_id after;
 };
 
+static struct update_ref_record *init_update_ref_record(const char *ref)
+{
+	struct update_ref_record *rec = xmalloc(sizeof(*rec));
+
+	oidcpy(&rec->before, null_oid());
+	oidcpy(&rec->after, null_oid());
+
+	/* This may fail, but that's fine, we will keep the null OID. */
+	read_ref(ref, &rec->before);
+
+	return rec;
+}
+
 static int git_sequencer_config(const char *k, const char *v, void *cb)
 {
 	struct replay_opts *opts = cb;
@@ -4081,11 +4095,102 @@ leave_merge:
 	return ret;
 }
 
-static int do_update_ref(struct repository *r, const char *ref_name)
+static int write_update_refs_state(struct string_list *refs_to_oids)
 {
+	int result = 0;
+	struct lock_file lock = LOCK_INIT;
+	FILE *fp = NULL;
+	struct string_list_item *item;
+	char *path;
+
+	if (!refs_to_oids->nr)
+		return 0;
+
+	path = rebase_path_update_refs(the_repository->gitdir);
+
+	if (safe_create_leading_directories(path)) {
+		result = error(_("unable to create leading directories of %s"),
+			       path);
+		goto cleanup;
+	}
+
+	if (hold_lock_file_for_update(&lock, path, 0) < 0) {
+		result = error(_("another 'rebase' process appears to be running; "
+				 "'%s.lock' already exists"),
+			       path);
+		goto cleanup;
+	}
+
+	fp = fdopen_lock_file(&lock, "w");
+	if (!fp) {
+		result = error_errno(_("could not open '%s' for writing"), path);
+		rollback_lock_file(&lock);
+		goto cleanup;
+	}
+
+	for_each_string_list_item(item, refs_to_oids) {
+		struct update_ref_record *rec = item->util;
+		fprintf(fp, "%s\n%s\n%s\n", item->string,
+			oid_to_hex(&rec->before), oid_to_hex(&rec->after));
+	}
+
+	result = commit_lock_file(&lock);
+
+cleanup:
+	free(path);
+	return result;
+}
+
+static int do_update_ref(struct repository *r, const char *refname)
+{
+	struct string_list_item *item;
+	struct string_list list = STRING_LIST_INIT_DUP;
+
+	sequencer_get_update_refs_state(r->gitdir, &list);
+
+	for_each_string_list_item(item, &list) {
+		if (!strcmp(item->string, refname)) {
+			struct update_ref_record *rec = item->util;
+			read_ref("HEAD", &rec->after);
+			break;
+		}
+	}
+
+	write_update_refs_state(&list);
+	string_list_clear(&list, 1);
 	return 0;
 }
 
+static int do_update_refs(struct repository *r)
+{
+	int res = 0;
+	struct string_list_item *item;
+	struct string_list refs_to_oids = STRING_LIST_INIT_DUP;
+	struct ref_store *refs = get_main_ref_store(r);
+
+	sequencer_get_update_refs_state(r->gitdir, &refs_to_oids);
+
+	for_each_string_list_item(item, &refs_to_oids) {
+		struct update_ref_record *rec = item->util;
+
+		if (oideq(&rec->after, the_hash_algo->null_oid)) {
+			/*
+			 * Ref was not updated. User may have deleted the
+			 * 'update-ref' step.
+			 */
+			continue;
+		}
+
+		res |= refs_update_ref(refs, "rewritten during rebase",
+				       item->string,
+				       &rec->after, &rec->before,
+				       0, UPDATE_REFS_MSG_ON_ERR);
+	}
+
+	string_list_clear(&refs_to_oids, 1);
+	return res;
+}
+
 static int is_final_fixup(struct todo_list *todo_list)
 {
 	int i = todo_list->current;
@@ -4603,6 +4708,8 @@ cleanup_head_ref:
 		strbuf_release(&head_ref);
 	}
 
+	do_update_refs(r);
+
 	/*
 	 * Sequence of picks finished successfully; cleanup by
 	 * removing the .git/sequencer directory
@@ -5676,7 +5783,7 @@ static int add_decorations_to_list(const struct commit *commit,
 
 			sti = string_list_insert(&ctx->refs_to_oids,
 						 decoration->name);
-			sti->util = oiddup(the_hash_algo->null_oid);
+			sti->util = init_update_ref_record(decoration->name);
 		}
 
 		item->offset_in_buf = base_offset;
@@ -5732,6 +5839,8 @@ static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
 		}
 	}
 
+	write_update_refs_state(&ctx.refs_to_oids);
+
 	string_list_clear(&ctx.refs_to_oids, 1);
 	free(todo_list->items);
 	todo_list->items = ctx.items;
diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index 8a03f14df8d..50815acd3e8 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -81,25 +81,16 @@ test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase (mer
 	grep "cannot force update the branch '\''wt-2'\'' checked out at.*wt-2" err
 '
 
-test_expect_success 'refuse to overwrite: worktree in rebase with --update-refs' '
-	test_when_finished rm -rf .git/worktrees/wt-3/rebase-merge &&
-
-	mkdir -p .git/worktrees/wt-3/rebase-merge &&
-	touch .git/worktrees/wt-3/rebase-merge/interactive &&
+test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase with --update-refs' '
+	test_when_finished git -C wt-3 rebase --abort &&
 
-	cat >.git/worktrees/wt-3/rebase-merge/update-refs <<-EOF &&
-	refs/heads/fake-3
-	$(git rev-parse HEAD~1)
-	$(git rev-parse HEAD)
-	refs/heads/fake-4
-	$(git rev-parse HEAD)
-	$(git rev-parse HEAD)
-	EOF
+	git branch -f can-be-updated wt-3 &&
+	test_must_fail git -C wt-3 rebase --update-refs conflict-3 &&
 
 	for i in 3 4
 	do
-		test_must_fail git branch -f fake-$i HEAD 2>err &&
-		grep "cannot force update the branch '\''fake-$i'\'' checked out at.*wt-3" err ||
+		test_must_fail git branch -f can-be-updated HEAD 2>err &&
+		grep "cannot force update the branch '\''can-be-updated'\'' checked out at.*wt-3" err ||
 			return 1
 	done
 '
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 3cd20733bc8..a37820fa728 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1813,6 +1813,23 @@ test_expect_success '--update-refs adds commands with --rebase-merges' '
 	)
 '
 
+test_expect_success '--update-refs updates refs correctly' '
+	git checkout -B update-refs no-conflict-branch &&
+	git branch -f base HEAD~4 &&
+	git branch -f first HEAD~3 &&
+	git branch -f second HEAD~3 &&
+	git branch -f third HEAD~1 &&
+	test_commit extra2 fileX &&
+	git commit --amend --fixup=L &&
+
+	git rebase -i --autosquash --update-refs primary &&
+
+	test_cmp_rev HEAD~3 refs/heads/first &&
+	test_cmp_rev HEAD~3 refs/heads/second &&
+	test_cmp_rev HEAD~1 refs/heads/third &&
+	test_cmp_rev HEAD refs/heads/no-conflict-branch
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
gitgitgadget

