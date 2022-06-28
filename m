Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D63C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 13:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345728AbiF1N21 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 09:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346456AbiF1N13 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 09:27:29 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B668F9B
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 06:26:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q9so17698590wrd.8
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 06:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+P/IdGGcNRo3SFAFLQ+TOgSB8n0GO2oH0rFfkBNzKtk=;
        b=oMz/tlWg35H4AXrg3sdt3hrYisVcDVwNd2n0tdLRPCK/E9gVAUZv6oO/jHx53z46Ce
         7zwmn4YaYjQImc0qMV1ZAGXSxGGJQEe4MWX04FpRmLhRwIdftEcU/fUCktUaCAuFRRUH
         T+nHeDaxI+NiWnddUueOlC0YYDMXhTb2gGUUKEQUwVe6wdlCWK4gSfhqS6pOFmoEjp3H
         rm6WBLsCEi5te5lSyAinNA9o0x8GLB8ilNscW4exoQjWh0Pvsa0MrgLq3wTqm9qKtHOb
         cofuLb02y+MVWow2acplYMC01kO3dq8kqeluAyZD7Bb8a7o9CV4f+hQXaypqYdJuagUl
         /qLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+P/IdGGcNRo3SFAFLQ+TOgSB8n0GO2oH0rFfkBNzKtk=;
        b=d3NS1xP7LmJ7dNRl2aP86u0bS8b5Jx44XVBJLsY9CHRIr536WsWmJw/p48I5pAoTM7
         CS8o6v3wJOXuljNKdjVcvj/8+5CbAcAiQ8Xok2I+IVZEESC/ocBue799EeFP9Mu865n8
         Xb23Gf67LSYnLm51uzLWp/1Qm3a1hZnEA0sN76Xfk+/R6ft24uYwD7GGeFf8buMeDRtX
         rfwz3JbIQj3pDBClVjKN8ig+Ef9uLW2UYz00bmgXLQMWmp/vvfvP2YQUhsQMlpSbjSPD
         tbY7obhC25sAkddIgvI3x6xQ6RWNLo5kYGeApHF7u/lhOwk0hNkH9iUr2HLyJXM1AaqU
         DkAw==
X-Gm-Message-State: AJIora9roBti0mG0f5WdOYu9wuaU98z+jLTLk7bp/y+z6eAbXQISKxqY
        i8TwWj0QORTWL53ZaHGj2vqLmnBFv3tk2Q==
X-Google-Smtp-Source: AGRyM1vhBDDWVFb+eu3meDfvvy+PkKApJUWEXXUcUTrw6hIxIiSKRrHTpETF6RUCuDOaIoSh9hmu5w==
X-Received: by 2002:a5d:5047:0:b0:21b:92b2:f34f with SMTP id h7-20020a5d5047000000b0021b92b2f34fmr17118372wrt.677.1656422762967;
        Tue, 28 Jun 2022 06:26:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c350800b003a0502c620dsm3867317wmq.44.2022.06.28.06.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 06:26:02 -0700 (PDT)
Message-Id: <2bc647b6fcd6032a1e97e67739ced31117bfbfce.1656422759.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
        <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jun 2022 13:25:53 +0000
Subject: [PATCH v3 2/8] branch: consider refs under 'update-refs'
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

The branch_checked_out() helper helps commands like 'git branch' and
'git fetch' from overwriting refs that are currently checked out in
other worktrees.

A future update to 'git rebase' will introduce a new '--update-refs'
option which will update the local refs that point to commits that are
being rebased. To avoid collisions as the rebase completes, we want to
make the future data store for these refs to be considered by
branch_checked_out().

The data store is a plaintext file inside the 'rebase-merge' directory
for that worktree. The file alternates refnames and OIDs. The OIDs will
be used to store the to-be-written values as the rebase progresses, but
can be ignored at the moment.

Create a new sequencer_get_update_refs_state() method that parses this
file and populates a struct string_list with the ref-OID pairs. We can
then use this list to add to the current_checked_out_branches strmap
used by branch_checked_out().

To properly navigate to the rebase directory for a given worktree,
extract the static strbuf_worktree_gitdir() method to a public API
method.

We can test that this works without having Git write this file by
artificially creating one in our test script.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 branch.c                  | 13 ++++++++++++
 sequencer.c               | 42 +++++++++++++++++++++++++++++++++++++++
 sequencer.h               |  9 +++++++++
 t/t2407-worktree-heads.sh | 22 ++++++++++++++++----
 4 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/branch.c b/branch.c
index 526e8237673..f252c4eef6c 100644
--- a/branch.c
+++ b/branch.c
@@ -365,6 +365,7 @@ static void prepare_checked_out_branches(void)
 		char *old;
 		struct wt_status_state state = { 0 };
 		struct worktree *wt = worktrees[i++];
+		struct string_list update_refs = STRING_LIST_INIT_DUP;
 
 		if (wt->is_bare)
 			continue;
@@ -400,6 +401,18 @@ static void prepare_checked_out_branches(void)
 			strbuf_release(&ref);
 		}
 		wt_status_state_free_buffers(&state);
+
+		if (!sequencer_get_update_refs_state(get_worktree_git_dir(wt),
+						     &update_refs)) {
+			struct string_list_item *item;
+			for_each_string_list_item(item, &update_refs) {
+				old = strmap_put(&current_checked_out_branches,
+						 item->string,
+						 xstrdup(wt->path));
+				free(old);
+			}
+			string_list_clear(&update_refs, 1);
+		}
 	}
 
 	free_worktrees(worktrees);
diff --git a/sequencer.c b/sequencer.c
index 8c3ed3532ac..1094e146b99 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5901,3 +5901,45 @@ int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
 
 	return 0;
 }
+
+int sequencer_get_update_refs_state(const char *wt_dir,
+				    struct string_list *refs)
+{
+	int result = 0;
+	struct stat st;
+	FILE *fp = NULL;
+	struct strbuf ref = STRBUF_INIT;
+	struct strbuf hash = STRBUF_INIT;
+	char *path = xstrfmt("%s/rebase-merge/update-refs", wt_dir);
+
+	if (stat(path, &st))
+		goto cleanup;
+
+	fp = fopen(path, "r");
+	if (!fp)
+		goto cleanup;
+
+	while (strbuf_getline(&ref, fp) != EOF) {
+		struct object_id oid;
+		struct string_list_item *item;
+
+		if (strbuf_getline(&hash, fp) == EOF ||
+		    get_oid_hex(hash.buf, &oid)) {
+			warning(_("update-refs file at '%s' is invalid"),
+				  path);
+			result = -1;
+			goto cleanup;
+		}
+
+		item = string_list_append(refs, ref.buf);
+		item->util = oiddup(&oid);
+	}
+
+cleanup:
+	if (fp)
+		fclose(fp);
+	free(path);
+	strbuf_release(&ref);
+	strbuf_release(&hash);
+	return result;
+}
diff --git a/sequencer.h b/sequencer.h
index da64473636b..3ae541bb145 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -232,4 +232,13 @@ void sequencer_post_commit_cleanup(struct repository *r, int verbose);
 int sequencer_get_last_command(struct repository* r,
 			       enum replay_action *action);
 int sequencer_determine_whence(struct repository *r, enum commit_whence *whence);
+
+/**
+ * Append the set of ref-OID pairs that are currently stored for the 'git
+ * rebase --update-refs' feature if such a rebase is currently happening.
+ *
+ * Localized to a worktree's git dir.
+ */
+int sequencer_get_update_refs_state(const char *wt_dir, struct string_list *refs);
+
 #endif /* SEQUENCER_H */
diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index 4f59bc21303..f1e9e172a0c 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -7,8 +7,11 @@ TEST_PASSES_SANITIZE_LEAK=true
 
 test_expect_success 'setup' '
 	test_commit init &&
-	git branch -f fake-1 &&
-	git branch -f fake-2 &&
+
+	for i in 1 2 3 4
+	do
+		git branch -f fake-$i || return 1
+	done &&
 
 	for i in 1 2 3 4
 	do
@@ -73,8 +76,19 @@ test_expect_success 'refuse to overwrite: worktree in rebase (merge)' '
 	echo refs/heads/fake-1 >.git/worktrees/wt-3/rebase-merge/head-name &&
 	echo refs/heads/fake-2 >.git/worktrees/wt-3/rebase-merge/onto &&
 
-	test_must_fail git branch -f fake-1 HEAD 2>err &&
-	grep "cannot force update the branch '\''fake-1'\'' checked out at.*wt-3" err
+	cat >.git/worktrees/wt-3/rebase-merge/update-refs <<-EOF &&
+	refs/heads/fake-3
+	$(git rev-parse HEAD~1)
+	refs/heads/fake-4
+	$(git rev-parse HEAD)
+	EOF
+
+	for i in 1 3 4
+	do
+		test_must_fail git branch -f fake-$i HEAD 2>err &&
+		grep "cannot force update the branch '\''fake-$i'\'' checked out at.*wt-3" err ||
+			return 1
+	done
 '
 
 test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: checked out' '
-- 
gitgitgadget

