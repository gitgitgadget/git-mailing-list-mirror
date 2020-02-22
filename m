Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDE7C35669
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 22:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1797C206D7
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 22:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8ux2z/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgBVWfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 17:35:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35793 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgBVWfO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Feb 2020 17:35:14 -0500
Received: by mail-wr1-f67.google.com with SMTP id w12so6041393wrt.2
        for <git@vger.kernel.org>; Sat, 22 Feb 2020 14:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eo1JWsDZ7vtiqb5WOvUN38yoJF2avQq7mp69wBbZDYk=;
        b=P8ux2z/pgZ1CaioKsK0A/WiX1On7ZSQWQlRvvwujf4uu2+qG0Azd5+wQoGmADEurVU
         y6oouv7LGJvyT+wjSQJPczYUFvDLQxNATacm2oxSV1C/zvelcdWAacJZxNsA4osS4ZHB
         C90pxiWa/G1hZJn0IRYLrJPbogkuEgIHWqmWiAF4HchVKjnrc3dYPUdSBGRG/qQKVlyI
         N5rcUrTTLKKpPPNtrAy2pSKcpo1iHTGyvl8+cjvecGMoGuILBHA8POsn9pwK28nMKuCk
         Z0gjZAb8AwS4cl4fUAj0QXIj7FWe0tfCGAg71rRp70RuG3wIKmSJd4yKZbhUmgN1aUKM
         FWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eo1JWsDZ7vtiqb5WOvUN38yoJF2avQq7mp69wBbZDYk=;
        b=MtJpwQIs2wxwgOq4ciHA8y16LP9tDfLj12vbVArwKrev1G+T6P3szdAbzgFMI8dKGH
         rIi8IjZ4rH2T39lu/eHRf8zmWWIWMvSXZmLyjU8tjtgHK2kXHkyp7iwD0T6PnlsxPitk
         7oGIJt+pv9E8V6DV56IAIv3BlE61jTofUyNvw212ecU9Mr/zqOfbaeyE4FnxJszI1JkP
         myExWEZ6aon2Or7J9GGV8DngOh+SgW5KgVuj67iA32DMAq8S+k1tyvbY/d37fJUdR62J
         6RPb2DyA+L6Lb4AyHHMHrxv57g+cQkE2jvY1AmKWe7rKstd/Zp0K4WnEvcV8cbBFCOVy
         d36w==
X-Gm-Message-State: APjAAAXZOE76LG2g8C+LrU27Sdhy4G1Y2OCG26EakL7y9v1HQZLQj6fQ
        TCi9zIF2cnXlENUC8ueBaaKqYKM6
X-Google-Smtp-Source: APXvYqyJ7ISsT2QLVDFenRATfLgw4gcLT9ZtvG9mcvM0xBEjla1FZjKKtYGmH1IPpD7ErjPCk4+THQ==
X-Received: by 2002:adf:f54d:: with SMTP id j13mr56465302wrp.19.1582410912448;
        Sat, 22 Feb 2020 14:35:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b21sm10527388wmd.37.2020.02.22.14.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 14:35:12 -0800 (PST)
Message-Id: <61e5f75a6f9a8579271870f6b8b95021055a96ad.1582410908.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.535.v2.git.1582410908.gitgitgadget@gmail.com>
References: <pull.535.git.1581620351.gitgitgadget@gmail.com>
        <pull.535.v2.git.1582410908.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Feb 2020 22:35:07 +0000
Subject: [PATCH v2 4/4] receive.denyCurrentBranch: respect all worktrees
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

The receive.denyCurrentBranch config option controls what happens if
you push to a branch that is checked out into a non-bare repository.
By default, it rejects it. It can be disabled via `ignore` or `warn`.
Another yet trickier option is `updateInstead`.

However, this setting was forgotten when the git worktree command was
introduced: only the main worktree's current branch is respected.

With this change, all worktrees are respected.

That change also leads to revealing another bug,
i.e. `receive.denyCurrentBranch = true` was ignored when pushing into a
non-bare repository's unborn current branch using ref namespaces. As
`is_ref_checked_out()` returns 0 which means `receive-pack` does not get
into conditional statement to switch `deny_current_branch` accordingly
(ignore, warn, refuse, unconfigured, updateInstead).

receive.denyCurrentBranch uses the function `refs_resolve_ref_unsafe()`
(called via `resolve_refdup()`) to resolve the symbolic ref HEAD, but
that function fails when HEAD does not point at a valid commit.
As we replace the call to `refs_resolve_ref_unsafe()` with
`find_shared_symref()`, which has no problem finding the worktree for a
given branch even if it is unborn yet, this bug is fixed at the same
time: receive.denyCurrentBranch now also handles worktrees with unborn
branches as intended even while using ref namespaces.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 builtin/receive-pack.c           | 37 +++++++++++++++++---------------
 t/t5509-fetch-push-namespaces.sh |  2 +-
 t/t5516-fetch-push.sh            | 11 ++++++++++
 3 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 411e0b4d999..b5ca3123b78 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -27,6 +27,7 @@
 #include "object-store.h"
 #include "protocol.h"
 #include "commit-reach.h"
+#include "worktree.h"
 
 static const char * const receive_pack_usage[] = {
 	N_("git receive-pack <git-dir>"),
@@ -816,16 +817,6 @@ static int run_update_hook(struct command *cmd)
 	return finish_command(&proc);
 }
 
-static int is_ref_checked_out(const char *ref)
-{
-	if (is_bare_repository())
-		return 0;
-
-	if (!head_name)
-		return 0;
-	return !strcmp(head_name, ref);
-}
-
 static char *refuse_unconfigured_deny_msg =
 	N_("By default, updating the current branch in a non-bare repository\n"
 	   "is denied, because it will make the index and work tree inconsistent\n"
@@ -997,16 +988,27 @@ static const char *push_to_checkout(unsigned char *hash,
 		return NULL;
 }
 
-static const char *update_worktree(unsigned char *sha1)
+static const char *update_worktree(unsigned char *sha1, const struct worktree *worktree)
 {
-	const char *retval;
-	const char *work_tree = git_work_tree_cfg ? git_work_tree_cfg : "..";
+	const char *retval, *work_tree, *git_dir = NULL;
 	struct argv_array env = ARGV_ARRAY_INIT;
 
+	if (worktree && worktree->path)
+		work_tree = worktree->path;
+	else if (git_work_tree_cfg)
+		work_tree = git_work_tree_cfg;
+	else
+		work_tree = "..";
+
 	if (is_bare_repository())
 		return "denyCurrentBranch = updateInstead needs a worktree";
+	
+	if (worktree)
+		git_dir = get_worktree_git_dir(worktree);
+	if (!git_dir)
+		git_dir = get_git_dir();
 
-	argv_array_pushf(&env, "GIT_DIR=%s", absolute_path(get_git_dir()));
+	argv_array_pushf(&env, "GIT_DIR=%s", absolute_path(git_dir));
 
 	if (!find_hook(push_to_checkout_hook))
 		retval = push_to_deploy(sha1, &env, work_tree);
@@ -1026,6 +1028,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	struct object_id *old_oid = &cmd->old_oid;
 	struct object_id *new_oid = &cmd->new_oid;
 	int do_update_worktree = 0;
+	const struct worktree *worktree = is_bare_repository() ? NULL : find_shared_symref("HEAD", name);
 
 	/* only refs/... are allowed */
 	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
@@ -1037,7 +1040,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	free(namespaced_name);
 	namespaced_name = strbuf_detach(&namespaced_name_buf, NULL);
 
-	if (is_ref_checked_out(namespaced_name)) {
+	if (worktree) {
 		switch (deny_current_branch) {
 		case DENY_IGNORE:
 			break;
@@ -1069,7 +1072,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 			return "deletion prohibited";
 		}
 
-		if (head_name && !strcmp(namespaced_name, head_name)) {
+		if (worktree || (head_name && !strcmp(namespaced_name, head_name))) {
 			switch (deny_delete_current) {
 			case DENY_IGNORE:
 				break;
@@ -1118,7 +1121,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	}
 
 	if (do_update_worktree) {
-		ret = update_worktree(new_oid->hash);
+		ret = update_worktree(new_oid->hash, find_shared_symref("HEAD", name));
 		if (ret)
 			return ret;
 	}
diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
index c89483fdba2..6270fb7b576 100755
--- a/t/t5509-fetch-push-namespaces.sh
+++ b/t/t5509-fetch-push-namespaces.sh
@@ -152,7 +152,7 @@ test_expect_success 'clone chooses correct HEAD (v2)' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'denyCurrentBranch and unborn branch with ref namespace' '
+test_expect_success 'denyCurrentBranch and unborn branch with ref namespace' '
 	cd original &&
 	git init unborn &&
 	git remote add unborn-namespaced "ext::git --namespace=namespace %s unborn" &&
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index c81ca360ac4..49982b0fd90 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1712,4 +1712,15 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
 	)
 '
 
+test_expect_success 'denyCurrentBranch and worktrees' '
+	git worktree add new-wt &&
+	git clone . cloned &&
+	test_commit -C cloned first &&
+	test_config receive.denyCurrentBranch refuse &&
+	test_must_fail git -C cloned push origin HEAD:new-wt &&
+	test_config receive.denyCurrentBranch updateInstead &&
+	git -C cloned push origin HEAD:new-wt &&
+	test_must_fail git -C cloned push --delete origin new-wt
+'
+
 test_done
-- 
gitgitgadget
