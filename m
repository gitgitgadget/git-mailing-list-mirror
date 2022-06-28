Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBE4CCA479
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 13:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346345AbiF1N2V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 09:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346483AbiF1N1b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 09:27:31 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BEEB7E
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 06:26:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id s1so17677468wra.9
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 06:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ihArIUXkX6fSLH0rGer7G+GLh9s0tCZFbX4BPIcYzjY=;
        b=TK6z5AR++X0SKMc74tddQTfjX2CNPQTH7AUVINY/uDWVJma/pd3HxADB4MpR7A974z
         2zoeBFgeUXeuH5Fbw5neMli1j7Qyy8iPhvfwXHMFnoi5Qwx6p25swrmEEKFww/9EFvLF
         vIfJjsMBgV2X5PMH9J2wZo7KxksToPpnUjKyXTjk+YsJfmofqZrcdKE1uXFOBMXw58VU
         pZYkxsOOoResVN4zUkObuSIir/i85Go7DMhjmie4jH6V93qXa28xKirC+e/5ZrUle+6m
         q/vukYWDiPCaAYvYjQphBhcjoo9FR8Ng2oM8EmcgThxrmsTo5YEsk/RfUG3nZ7TpWoaK
         k2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ihArIUXkX6fSLH0rGer7G+GLh9s0tCZFbX4BPIcYzjY=;
        b=W+fj0Iudet1008TCzgkzp9HxleQpHIL5pLGWYzBgd4MpbTK5LuaydIMDE6vCg/E5A4
         Heq9KuBgxr10UfxaEBFSnXYiFZ+5k06hGm+b/qkGjUQfM/k6+zwRui5RcxlSnhE87Bdw
         rBeg1GoLuiqHd7Y6tJFyqe5rm7i9XgiS8mIRpLWCuEVJGgbna8QewC1DPkXGERQIk2TH
         NHUBcPQluFscxPAwESQ6SUxRNznVD0PUZCJbCWXw8yc7EcBQB0HxMXRU6I/Sf0iVRup9
         y+NU5kGGG0umVVPHhzX1k3Eb/ZqX7KBW63Kg4J1+HEnP8c+iVA0ri5XMRMGL4Q30EHu2
         yvkQ==
X-Gm-Message-State: AJIora/heUQZCqvgzlJtJfMcnA3qSXF949uR7BTM4N2TOFKJ5odVCLTD
        QyiNT/IqK6UahIyDeZf8XbmOokbsfXLY6g==
X-Google-Smtp-Source: AGRyM1slYtGLOlLepU9rJPx0a8eBJolRNJSngDPnDsQCNBePnanTo4xH+P5EdN2TgZJ9zeUFPDBTLA==
X-Received: by 2002:a05:6000:1287:b0:21b:8f56:43cb with SMTP id f7-20020a056000128700b0021b8f5643cbmr17269333wrx.625.1656422768624;
        Tue, 28 Jun 2022 06:26:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x12-20020a05600c2d0c00b003a04a9504b0sm7158208wmf.40.2022.06.28.06.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 06:26:08 -0700 (PDT)
Message-Id: <72e0481b643e98c5670eee0bf5c199c4fb693b16.1656422759.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
        <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jun 2022 13:25:58 +0000
Subject: [PATCH v3 7/8] rebase: update refs from 'update-ref' commands
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
commands. The ref/OID pair is stored in the
$GIT_DIR/rebase-merge/update-refs file. A previous change parsed this
file to avoid having other processes updating the refs in that file
while the rebase is in progress.

Not only do we update the file when the sequencer reaches these
'update-ref' commands, we then update the refs themselves at the end of
the rebase sequence. If the rebase is aborted before this final step,
then the refs are not updated.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 sequencer.c                   | 114 +++++++++++++++++++++++++++++++++-
 t/t3404-rebase-interactive.sh |  23 +++++++
 2 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 915d87a0336..4fd1c0b5bce 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -36,6 +36,7 @@
 #include "rebase-interactive.h"
 #include "reset.h"
 #include "branch.h"
+#include "log-tree.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -148,6 +149,14 @@ static GIT_PATH_FUNC(rebase_path_squash_onto, "rebase-merge/squash-onto")
  */
 static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
 
+/*
+ * The update-refs file stores a list of refs that will be updated at the end
+ * of the rebase sequence. The 'update-ref <ref>' commands in the todo file
+ * update the OIDs for the refs in this file, but the refs are not updated
+ * until the end of the rebase sequence.
+ */
+static GIT_PATH_FUNC(rebase_path_update_refs, "rebase-merge/update-refs")
+
 /*
  * The following files are written by git-rebase just after parsing the
  * command-line.
@@ -4058,11 +4067,110 @@ leave_merge:
 	return ret;
 }
 
-static int do_update_ref(struct repository *r, const char *ref_name)
+static int write_update_refs_state(struct string_list *refs_to_oids)
+{
+	int result = 0;
+	FILE *fp = NULL;
+	struct string_list_item *item;
+	char *path = xstrdup(rebase_path_update_refs());
+
+	if (safe_create_leading_directories(path)) {
+		result = error(_("unable to create leading directories of %s"),
+			       path);
+		goto cleanup;
+	}
+
+	fp = fopen(path, "w");
+	if (!fp) {
+		result = error_errno(_("could not open '%s' for writing"), path);
+		goto cleanup;
+	}
+
+	for_each_string_list_item(item, refs_to_oids)
+		fprintf(fp, "%s\n%s\n", item->string, oid_to_hex(item->util));
+
+cleanup:
+	if (fp)
+		fclose(fp);
+	return result;
+}
+
+static int do_update_ref(struct repository *r, const char *refname)
 {
+	struct string_list_item *item;
+	struct string_list list = STRING_LIST_INIT_DUP;
+	int found = 0;
+
+	sequencer_get_update_refs_state(r->gitdir, &list);
+
+	for_each_string_list_item(item, &list) {
+		if (!strcmp(item->string, refname)) {
+			struct object_id oid;
+			free(item->util);
+			found = 1;
+
+			if (!read_ref("HEAD", &oid)) {
+				item->util = oiddup(&oid);
+				break;
+			}
+		}
+	}
+
+	if (!found) {
+		struct object_id oid;
+		item = string_list_append(&list, refname);
+
+		if (!read_ref("HEAD", &oid))
+			item->util = oiddup(&oid);
+		else
+			item->util = oiddup(the_hash_algo->null_oid);
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
+		struct object_id *oid_to = item->util;
+		struct object_id oid_from;
+
+		if (oideq(oid_to, the_hash_algo->null_oid)) {
+			/*
+			 * Ref was not updated. User may have deleted the
+			 * 'update-ref' step.
+			 */
+			continue;
+		}
+
+		if (read_ref(item->string, &oid_from)) {
+			/*
+			 * The ref does not exist. The user probably
+			 * inserted a new 'update-ref' step with a new
+			 * branch name.
+			 */
+			oidcpy(&oid_from, the_hash_algo->null_oid);
+		}
+
+		res |= refs_update_ref(refs, "rewritten during rebase",
+				item->string,
+				oid_to, &oid_from,
+				0, UPDATE_REFS_MSG_ON_ERR);
+	}
+
+	string_list_clear(&refs_to_oids, 1);
+	return res;
+}
+
 static int is_final_fixup(struct todo_list *todo_list)
 {
 	int i = todo_list->current;
@@ -4580,6 +4688,8 @@ cleanup_head_ref:
 		strbuf_release(&head_ref);
 	}
 
+	do_update_refs(r);
+
 	/*
 	 * Sequence of picks finished successfully; cleanup by
 	 * removing the .git/sequencer directory
@@ -5709,6 +5819,8 @@ static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
 		}
 	}
 
+	write_update_refs_state(&ctx.refs_to_oids);
+
 	string_list_clear(&ctx.refs_to_oids, 1);
 	free(todo_list->items);
 	todo_list->items = ctx.items;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 3cd20733bc8..63a69bc073e 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1813,6 +1813,29 @@ test_expect_success '--update-refs adds commands with --rebase-merges' '
 	)
 '
 
+compare_two_refs () {
+	git rev-parse $1 >expect &&
+	git rev-parse $2 >actual &&
+	test_cmp expect actual
+}
+
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
+	compare_two_refs HEAD~3 refs/heads/first &&
+	compare_two_refs HEAD~3 refs/heads/second &&
+	compare_two_refs HEAD~1 refs/heads/third &&
+	compare_two_refs HEAD refs/heads/no-conflict-branch
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
gitgitgadget

