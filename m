Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D90DC433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbiGSSeO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239007AbiGSSeD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:34:03 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDB35D0C1
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:33:59 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id j29-20020a05600c1c1d00b003a2fdafdefbso9695885wms.2
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZzirPXEIG/9zSZTSCNq1F5K8eCdqtL6TGpZfO6CMUkI=;
        b=IbzNpXTLmt6acDRTsepZV32j+F0oHTnCb5a2TvkVlYNuZ2tqxDgaWePh7zSDZsHJIA
         LcFyf8XiKNTSYnTtGNKQq6Z2ACxDuuPXggZ0ws6zholEaefZA25s4yFUMs4axnt2EE7U
         oD0cDn9Fc0YW4LP9o/g17cbCvYN1ATCwMhK36QWC3WY2HKzLetbc5JvJ5C1PluVQ8l0T
         Oc0+PbwkWJh8S8BSC7Y0siokqMj7TTLngEBB9DWGW+rPsbn2SYFDCbWExP13kp8YrN7W
         LH5kEdNhjAfq2UfbeEUG9JMj8rlbFZfwUeFe5A2UKFdCn5DsY/DoeuVPSNj0WW+EDMkQ
         NKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZzirPXEIG/9zSZTSCNq1F5K8eCdqtL6TGpZfO6CMUkI=;
        b=2b1GeF5q4feKD9yK+po1GQAhNvufM7rT5kSx+foDCVJIZrj/RrbOCa8iYDeIXq7xYh
         IRgSjLaKdbcw2PSiIejtwe3oXW9QD7m0zL/gCPWp0c1nthHtvl/g96J/deub0t6tvRn7
         hSnBexg5pC1ZgpKezGMm+0VeMmxfSjqPRlAb0zDdxtS6tz97p4IkjmdZaIWQ1Q8lp2j1
         f98YhmPqGCvx+aS7z4RXtAv8JfxVTnZ6QuVxaYMAS/CAx7Y6SdiynzhXCgnIrz50QDGl
         Xm8bVzTQIynJkKFHzeogp6Mj4A+c2KhkCwidsZVmf7AV7m7Engy/IOYpY1JnhtYvUk50
         5c7w==
X-Gm-Message-State: AJIora9NRUcyEnF+CSPvVCOvenvIU7bHhtvwB/1kV97CsLzCR+TA+PRK
        c9pcKlydXODjzWvIF7sK1cHwfGEksI4=
X-Google-Smtp-Source: AGRyM1tXmC39+/wrhLQq+qyjNY6quiFZOZ2cuYnGbnVKihvSw3CR+VwDTD0gQ7Gl1HmVhumBcN+F5A==
X-Received: by 2002:a1c:241:0:b0:3a3:142d:b65 with SMTP id 62-20020a1c0241000000b003a3142d0b65mr522679wmc.171.1658255637438;
        Tue, 19 Jul 2022 11:33:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l24-20020a05600c089800b003a327b98c0asm465038wmp.22.2022.07.19.11.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:33:56 -0700 (PDT)
Message-Id: <e7a91bdffbd9a1fe0eda9a5a264f7734aadbf688.1658255624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
References: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
        <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 18:33:40 +0000
Subject: [PATCH v5 08/12] rebase: update refs from 'update-ref' commands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
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
 sequencer.c                   | 120 +++++++++++++++++++++++++++++++++-
 t/t2407-worktree-heads.sh     |  21 ++----
 t/t3404-rebase-interactive.sh |  17 +++++
 3 files changed, 140 insertions(+), 18 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a4ee2799d6f..ce8c7d8cd3a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -36,6 +36,7 @@
 #include "rebase-interactive.h"
 #include "reset.h"
 #include "branch.h"
+#include "log-tree.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -193,6 +194,21 @@ struct update_ref_record {
 	struct object_id after;
 };
 
+static struct update_ref_record *init_update_ref_record(const char *ref)
+{
+	struct update_ref_record *rec;
+
+	CALLOC_ARRAY(rec, 1);
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
@@ -4081,11 +4097,97 @@ leave_merge:
 	return ret;
 }
 
-static int do_update_ref(struct repository *r, const char *ref_name)
+static int write_update_refs_state(struct string_list *refs_to_oids)
+{
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
 {
+	struct string_list_item *item;
+	struct string_list list = STRING_LIST_INIT_DUP;
+
+	if (sequencer_get_update_refs_state(r->gitdir, &list))
+		return -1;
+
+	for_each_string_list_item(item, &list) {
+		if (!strcmp(item->string, refname)) {
+			struct update_ref_record *rec = item->util;
+			if (read_ref("HEAD", &rec->after))
+				return -1;
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
+	if ((res = sequencer_get_update_refs_state(r->gitdir, &refs_to_oids)))
+		return res;
+
+	for_each_string_list_item(item, &refs_to_oids) {
+		struct update_ref_record *rec = item->util;
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
@@ -4601,6 +4703,9 @@ cleanup_head_ref:
 
 		strbuf_release(&buf);
 		strbuf_release(&head_ref);
+
+		if (do_update_refs(r))
+			return -1;
 	}
 
 	/*
@@ -5676,7 +5781,7 @@ static int add_decorations_to_list(const struct commit *commit,
 
 			sti = string_list_insert(&ctx->refs_to_oids,
 						 decoration->name);
-			sti->util = oiddup(the_hash_algo->null_oid);
+			sti->util = init_update_ref_record(decoration->name);
 		}
 
 		item->offset_in_buf = base_offset;
@@ -5696,7 +5801,7 @@ static int add_decorations_to_list(const struct commit *commit,
  */
 static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
 {
-	int i;
+	int i, res;
 	static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
 	static struct string_list decorate_refs_exclude_config = STRING_LIST_INIT_NODUP;
 	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
@@ -5732,7 +5837,16 @@ static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
 		}
 	}
 
+	res = write_update_refs_state(&ctx.refs_to_oids);
+
 	string_list_clear(&ctx.refs_to_oids, 1);
+
+	if (res) {
+		/* we failed, so clean up the new list. */
+		free(ctx.items);
+		return res;
+	}
+
 	free(todo_list->items);
 	todo_list->items = ctx.items;
 	todo_list->nr = ctx.items_nr;
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
index 75c0b90fae1..2fffcf5d5fb 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1817,6 +1817,23 @@ test_expect_success '--update-refs adds commands with --rebase-merges' '
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

