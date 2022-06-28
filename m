Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058DFC433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 13:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346294AbiF1N2P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 09:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346477AbiF1N1b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 09:27:31 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380E33337D
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 06:26:09 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i1so13206271wrb.11
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 06:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8891rG2o3EeJT1FCwNOk35ol7Lxt+T/i2N9e2qV53X0=;
        b=Qn9CecKQV/VA1IuOH1oexy52ClD1FK8LMzxcFR00mm7ZqnbmWXc+p1qdMzMKhI/7t3
         eM9rhxS+s/FwQ5k/PFNPK2IMWd7RPd2wn5kU9+EqbJpxfKurn6pW3Jk0cvNXFJhj8Fko
         mJ+eY+TUIixNysg/4VWyEY4VulU/sTPsodTHHBaVyzxdsiU5MVvuD+jAScJ7E8dQzfKa
         cAV5WZW8Tk/Y2XvYistSq/d471iO/9JdwSUXKg7hS9cHJk7Wu9b+AAjpomnmEtCuFZvJ
         Y0owvY6GzSj1PWouVHaqm55VfwKm5st0LRi+nePSQ1HPDrRUA2fgyzP0JywAAC4Cy956
         QsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8891rG2o3EeJT1FCwNOk35ol7Lxt+T/i2N9e2qV53X0=;
        b=HQFIhputE55uARw23YPn5G3Cmsmur88pafoiQaMV7MBa4TLzM8tF7sjkAEPS/iY294
         x8cdBP+2sJ0B14HBeZWWNCUJMSPeaedd6NV7HuQXloZ05EnAcCS0uZA0DNNoEy7/86vX
         PbFs27dvmKngJSNbC5b8ooI+AtUje6L7rzmmQcodOj5zgcFGAkM4J8FqVll+9W2DVxHL
         OqLJMLbyVXLrnt+Ya4s7sNrTr7C7vmvKrz03xGn3+/ltPUf5YqIpP24S3Bh/CE4wDSK2
         3W5ltiZKUQrmv0b1ONmhBMjb7IPwNuTDiVe+9W4MD7x/IvRg7/Mp/ei5pnS5mD1sB36v
         MAdA==
X-Gm-Message-State: AJIora/2sMxcuvH/FouM3iaA2a+a8wBesjowEx6hzZLrX7gwTsVNSeZ8
        okpFF3LuS2/HQgB3VZP6iKLuyNqZi8fbpg==
X-Google-Smtp-Source: AGRyM1uzukyBKxljtbPz9GHgrz9EsuW8wOUOGH+7vQvr6uf4OegOnZBHKb3mO0HT1seZNC+m7z/a+Q==
X-Received: by 2002:a5d:53d0:0:b0:21b:ccc1:ab27 with SMTP id a16-20020a5d53d0000000b0021bccc1ab27mr11939213wrw.327.1656422767399;
        Tue, 28 Jun 2022 06:26:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j14-20020adfa54e000000b0021b93b29cacsm16837386wrb.99.2022.06.28.06.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 06:26:06 -0700 (PDT)
Message-Id: <918b398d6a2264a99acadd319f780c796bbafc18.1656422759.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
        <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jun 2022 13:25:57 +0000
Subject: [PATCH v3 6/8] rebase: add --update-refs option
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

When working on a large feature, it can be helpful to break that feature
into multiple smaller parts that become reviewed in sequence. During
development or during review, a change to one part of the feature could
affect multiple of these parts. An interactive rebase can help adjust
the multi-part "story" of the branch.

However, if there are branches tracking the different parts of the
feature, then rebasing the entire list of commits can create commits not
reachable from those "sub branches". It can take a manual step to update
those branches.

Add a new --update-refs option to 'git rebase -i' that adds 'update-ref
<ref>' steps to the todo file whenever a commit that is being rebased is
decorated with that <ref>. At the very end, the rebase process updates
all of the listed refs to the values stored during the rebase operation.

Be sure to iterate after any squashing or fixups are placed. Update the
branch only after those squashes and fixups are complete. This allows a
--fixup commit at the tip of the feature to apply correctly to the sub
branch, even if it is fixing up the most-recent commit in that part.

One potential problem here is that refs decorating commits that are
already marked as "fixup!" or "squash!" will not be included in this
list. Generally, the reordering of the "fixup!" and "squash!" is likely
to change the relative order of these refs, so it is not recommended.
The workflow here is intended to allow these kinds of commits at the tip
of the rebased branch while the other sub branches come along for the
ride without intervention.

This change update the documentation and builtin to accept the
--update-refs option as well as updating the todo file with the
'update-ref' commands. Tests are added to ensure that these todo
commands are added in the correct locations.

A future change will update the behavior to actually update the refs
at the end of the rebase sequence.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-rebase.txt  |   8 +++
 builtin/rebase.c              |   5 ++
 sequencer.c                   | 107 ++++++++++++++++++++++++++++++++++
 sequencer.h                   |   1 +
 t/t2407-worktree-heads.sh     |  17 ++++++
 t/t3404-rebase-interactive.sh |  70 ++++++++++++++++++++++
 6 files changed, 208 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 262fb01aec0..e7611b4089c 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -609,6 +609,13 @@ provided. Otherwise an explicit `--no-reschedule-failed-exec` at the
 start would be overridden by the presence of
 `rebase.rescheduleFailedExec=true` configuration.
 
+--update-refs::
+--no-update-refs::
+	Automatically force-update any branches that point to commits that
+	are being rebased. Any branches that are checked out in a worktree
+	or point to a `squash! ...` or `fixup! ...` commit are not updated
+	in this way.
+
 INCOMPATIBLE OPTIONS
 --------------------
 
@@ -632,6 +639,7 @@ are incompatible with the following options:
  * --empty=
  * --reapply-cherry-picks
  * --edit-todo
+ * --update-refs
  * --root when used in combination with --onto
 
 In addition, the following pairs of options are incompatible:
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7ab50cda2ad..56d82a52106 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -102,6 +102,7 @@ struct rebase_options {
 	int reschedule_failed_exec;
 	int reapply_cherry_picks;
 	int fork_point;
+	int update_refs;
 };
 
 #define REBASE_OPTIONS_INIT {			  	\
@@ -298,6 +299,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 		ret = complete_action(the_repository, &replay, flags,
 			shortrevisions, opts->onto_name, opts->onto,
 			&opts->orig_head, &commands, opts->autosquash,
+			opts->update_refs,
 			&todo_list);
 	}
 
@@ -1124,6 +1126,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "autosquash", &options.autosquash,
 			 N_("move commits that begin with "
 			    "squash!/fixup! under -i")),
+		OPT_BOOL(0, "update-refs", &options.update_refs,
+			 N_("update local refs that point to commits "
+			    "that are being rebased")),
 		{ OPTION_STRING, 'S', "gpg-sign", &gpg_sign, N_("key-id"),
 			N_("GPG-sign commits"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
diff --git a/sequencer.c b/sequencer.c
index 0b61835d441..915d87a0336 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -35,6 +35,7 @@
 #include "commit-reach.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "branch.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -5615,10 +5616,113 @@ static int skip_unnecessary_picks(struct repository *r,
 	return 0;
 }
 
+struct todo_add_branch_context {
+	struct todo_item *items;
+	size_t items_nr;
+	size_t items_alloc;
+	struct strbuf *buf;
+	struct commit *commit;
+	struct string_list refs_to_oids;
+};
+
+static int add_decorations_to_list(const struct commit *commit,
+				   struct todo_add_branch_context *ctx)
+{
+	const struct name_decoration *decoration = get_name_decoration(&commit->object);
+
+	while (decoration) {
+		struct todo_item *item;
+		const char *path;
+		size_t base_offset = ctx->buf->len;
+
+		ALLOC_GROW(ctx->items,
+			ctx->items_nr + 1,
+			ctx->items_alloc);
+		item = &ctx->items[ctx->items_nr];
+		memset(item, 0, sizeof(*item));
+
+		/* If the branch is checked out, then leave a comment instead. */
+		if ((path = branch_checked_out(decoration->name))) {
+			item->command = TODO_COMMENT;
+			strbuf_addf(ctx->buf, "# Ref %s checked out at '%s'\n",
+				    decoration->name, path);
+		} else {
+			struct string_list_item *sti;
+			item->command = TODO_UPDATE_REF;
+			strbuf_addf(ctx->buf, "%s\n", decoration->name);
+
+			sti = string_list_append(&ctx->refs_to_oids,
+						 decoration->name);
+			sti->util = oiddup(the_hash_algo->null_oid);
+		}
+
+		item->offset_in_buf = base_offset;
+		item->arg_offset = base_offset;
+		item->arg_len = ctx->buf->len - base_offset;
+		ctx->items_nr++;
+
+		decoration = decoration->next;
+	}
+
+	return 0;
+}
+
+/*
+ * For each 'pick' command, find out if the commit has a decoration in
+ * refs/heads/. If so, then add a 'label for-update-refs/' command.
+ */
+static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
+{
+	int i;
+	static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
+	static struct string_list decorate_refs_exclude_config = STRING_LIST_INIT_NODUP;
+	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
+	struct decoration_filter decoration_filter = {
+		.include_ref_pattern = &decorate_refs_include,
+		.exclude_ref_pattern = &decorate_refs_exclude,
+		.exclude_ref_config_pattern = &decorate_refs_exclude_config,
+	};
+	struct todo_add_branch_context ctx = {
+		.buf = &todo_list->buf,
+		.refs_to_oids = STRING_LIST_INIT_DUP,
+	};
+
+	ctx.items_alloc = 2 * todo_list->nr + 1;
+	ALLOC_ARRAY(ctx.items, ctx.items_alloc);
+
+	string_list_append(&decorate_refs_include, "refs/heads/");
+	load_ref_decorations(&decoration_filter, 0);
+
+	for (i = 0; i < todo_list->nr; ) {
+		struct todo_item *item = &todo_list->items[i];
+
+		/* insert ith item into new list */
+		ALLOC_GROW(ctx.items,
+			   ctx.items_nr + 1,
+			   ctx.items_alloc);
+
+		ctx.items[ctx.items_nr++] = todo_list->items[i++];
+
+		if (item->commit) {
+			ctx.commit = item->commit;
+			add_decorations_to_list(item->commit, &ctx);
+		}
+	}
+
+	string_list_clear(&ctx.refs_to_oids, 1);
+	free(todo_list->items);
+	todo_list->items = ctx.items;
+	todo_list->nr = ctx.items_nr;
+	todo_list->alloc = ctx.items_alloc;
+
+	return 0;
+}
+
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
 		    struct commit *onto, const struct object_id *orig_head,
 		    struct string_list *commands, unsigned autosquash,
+		    unsigned update_refs,
 		    struct todo_list *todo_list)
 {
 	char shortonto[GIT_MAX_HEXSZ + 1];
@@ -5637,6 +5741,9 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		item->arg_len = item->arg_offset = item->flags = item->offset_in_buf = 0;
 	}
 
+	if (update_refs && todo_list_add_update_ref_commands(todo_list))
+		return -1;
+
 	if (autosquash && todo_list_rearrange_squash(todo_list))
 		return -1;
 
diff --git a/sequencer.h b/sequencer.h
index 2cf5c1b9a38..e671d7e0743 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -167,6 +167,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		    const char *shortrevisions, const char *onto_name,
 		    struct commit *onto, const struct object_id *orig_head,
 		    struct string_list *commands, unsigned autosquash,
+		    unsigned update_refs,
 		    struct todo_list *todo_list);
 int todo_list_rearrange_squash(struct todo_list *todo_list);
 
diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index f1e9e172a0c..203997d92c6 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -151,4 +151,21 @@ test_expect_success 'refuse to overwrite when in error states' '
 	done
 '
 
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+test_expect_success !SANITIZE_LEAK 'refuse to overwrite during rebase with --update-refs' '
+	git commit --fixup HEAD~2 --allow-empty &&
+	(
+		set_cat_todo_editor &&
+		test_must_fail git rebase -i --update-refs HEAD~3 >todo &&
+		! grep "update-refs" todo
+	) &&
+	git branch -f allow-update HEAD~2 &&
+	(
+		set_cat_todo_editor &&
+		test_must_fail git rebase -i --update-refs HEAD~3 >todo &&
+		grep "update-ref refs/heads/allow-update" todo
+	)
+'
+
 test_done
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f31afd4a547..3cd20733bc8 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1743,6 +1743,76 @@ test_expect_success 'ORIG_HEAD is updated correctly' '
 	test_cmp_rev ORIG_HEAD test-orig-head@{1}
 '
 
+test_expect_success '--update-refs adds label and update-ref commands' '
+	git checkout -b update-refs no-conflict-branch &&
+	git branch -f base HEAD~4 &&
+	git branch -f first HEAD~3 &&
+	git branch -f second HEAD~3 &&
+	git branch -f third HEAD~1 &&
+	git commit --allow-empty --fixup=third &&
+	git branch -f shared-tip &&
+	(
+		set_cat_todo_editor &&
+
+		cat >expect <<-EOF &&
+		pick $(git log -1 --format=%h J) J
+		update-ref refs/heads/second
+		update-ref refs/heads/first
+		pick $(git log -1 --format=%h K) K
+		pick $(git log -1 --format=%h L) L
+		fixup $(git log -1 --format=%h update-refs) fixup! L # empty
+		update-ref refs/heads/third
+		pick $(git log -1 --format=%h M) M
+		update-ref refs/heads/no-conflict-branch
+		update-ref refs/heads/shared-tip
+		EOF
+
+		test_must_fail git rebase -i --autosquash --update-refs primary >todo &&
+		test_cmp expect todo
+	)
+'
+
+test_expect_success '--update-refs adds commands with --rebase-merges' '
+	git checkout -b update-refs-with-merge no-conflict-branch &&
+	git branch -f base HEAD~4 &&
+	git branch -f first HEAD~3 &&
+	git branch -f second HEAD~3 &&
+	git branch -f third HEAD~1 &&
+	git merge -m merge branch2 &&
+	git branch -f merge-branch &&
+	git commit --fixup=third --allow-empty &&
+	(
+		set_cat_todo_editor &&
+
+		cat >expect <<-EOF &&
+		label onto
+		reset onto
+		pick $(git log -1 --format=%h branch2~1) F
+		pick $(git log -1 --format=%h branch2) I
+		update-ref refs/heads/branch2
+		label merge
+		reset onto
+		pick $(git log -1 --format=%h refs/heads/second) J
+		update-ref refs/heads/second
+		update-ref refs/heads/first
+		pick $(git log -1 --format=%h refs/heads/third~1) K
+		pick $(git log -1 --format=%h refs/heads/third) L
+		fixup $(git log -1 --format=%h update-refs-with-merge) fixup! L # empty
+		update-ref refs/heads/third
+		pick $(git log -1 --format=%h HEAD~2) M
+		update-ref refs/heads/no-conflict-branch
+		merge -C $(git log -1 --format=%h HEAD~1) merge # merge
+		update-ref refs/heads/merge-branch
+		EOF
+
+		test_must_fail git rebase -i --autosquash \
+				   --rebase-merges=rebase-cousins \
+				   --update-refs primary >todo &&
+
+		test_cmp expect todo
+	)
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
gitgitgadget

