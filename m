Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5373C4178
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631627; cv=none; b=nkvnPqrGbKw6xm9IIoGMNBd4HaGLds+NVFTKqk6fpEwO7DkSm3u4Dw8riU1CW2XMCNtE1Q5AbIBW7JPaKnsNRovOcxQe7/5I2/b7/QbdBCYYG109m6vtUhSWbmkJsh5g0Fb+qOMiIbAzTOE9CBFcCyEu9wqSEhksVGKfq7Cs2js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631627; c=relaxed/simple;
	bh=6r6vI32s9pHofjBzVindNckNFhLuh/F1Trg9dPMV3uY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qy88Zqa2182GqmLQLcuDCVTOOK+ziOGDx9/7nk+d1/8+brYpiVi3CipURgpvzpXbFoFbItUod4RpnnRqamSiZWZshEXArFuw3sIjrNEsROLyEXzms8XfUuR3SGeQ8L4HFMLVOusEUaX791IPcex5WinIAVpKupE+fJyvHgjAPio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=oDBoQLNy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="oDBoQLNy"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45ef41adbc1so3598886f8f.0
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 10:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781631622; x=1782236422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YKJLIhA5D4Yw3a48UpdJfqI3NtKvssaskHUZB0MDXI4=;
        b=oDBoQLNyoGG4H4VVtv2Mjt2Y0iX6qwNYV7UWo8ZlFL/6W78ZlzLn5njVLHRmmuUjBZ
         NOjxFk8WM8970lcfQVfPJF/70MMeLMd3cMdsS6zpWsETao3F2/ATYNSCNZdwii07ITB1
         UOmEPtOjczMv6DE7fbttyTJjFzoHreAlE6C6WB1x/392lGgHNi8rugNDAEcGZ1cGpU/z
         Xh5svUoFPL2HGPToO8vOtfJ7qfO3I5CVmuGRQjP+3IO0OpeIyJVcx8Ogkva4TA99nFJ5
         LYRZMMEZp7e12ghnDRYX/0uOTboR6/lOqWf4tS1+eIKp0nJ7inyI1TzXTOLVkbboTELR
         kqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781631622; x=1782236422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKJLIhA5D4Yw3a48UpdJfqI3NtKvssaskHUZB0MDXI4=;
        b=NhZHJzxKvx5UVuIs6DZK1Hx2VKloE+p+OF3D0b5VPpyvvRrvnCJnQEdot3iUgmDUBK
         o7bchQcl7lQ3FYbHe8D7RjK8eE1V240cPAUHZqPVO2EtJ+SaCH4QrHgT/ZxMsAeywBsI
         fUdVJXu+9SuJi1dG4MaGcXtM0ygNJuEg0fyGikwHOnJ9D7+NG5vbX01Z+nfGPwwVSewP
         S0dZuEgkSZng9etY2ZI3IbmCJFu4L2HUD51w/j96PzSC15rgplNTL8S8fskaYV/CPGYv
         Csvg3DHmKMrigaHkI5m3XIDbfMbi+WNbhczdgtiN3zIdnx8XUMUxRcWHEZunRPyVK0IT
         VCIA==
X-Gm-Message-State: AOJu0YyWGvq+cyLwyVIsiXjzvzs84tk/Gfa0ODvhfqstgDB1e2wyOFIH
	eaB2fHopZmaMnMbvfRxU5E8QiejifFkQM9Q33RzVXNrI72AfxUxxe6ZPrGCeQGHLvTbrgBn3/ZB
	D/aC+
X-Gm-Gg: Acq92OHYhCQ0RFsUVxDXqbqcE/ReoAcxXVq6VJ3OfNcNVXvhbOjJpRCLjPXGHnYeiiF
	4dISYmuepsxRZcha0BahK7jmVdVEVHbUhFufZ7CLB6S8fYWAqtcMwVvufGDDwYva+4Fcd5S8CI9
	k8tbcWad46r4hAqlIBFix4TVmbm+UtER7BSWyenWO3wuJRxfiI0uD5h/coNouND91XPSIT2l05Y
	JpdPIJk1yjmcUpxh/NBjsmzM/xciY+rfrqQwvnt2GG9v/YZuFMW9RfMyHI/0MevMZZ0NJBhyxej
	gQr3EFNuXTUV0DWVxKYXPV4Qi3nkNMGCrDpydfaPbG+BaMgIj8qgaFsX89AJOjVuO46FP0Sm664
	FYz0AJyMPsipZxWyLPNdjTgJy4gnyjympqZTqMOKuO2BioG+ARheJGoiUoji1BfYXrilJKIhwn+
	imnFQa9q4QLr++v64288KpCQ9SXgAmJTLMHju3OXXNY4szdvhO9XfemTnbcirAaZNZsoGgZxAxS
	92Q3pmWa03yA3YYdvWTrrJ8
X-Received: by 2002:a5d:4a91:0:b0:45e:f381:cd8c with SMTP id ffacd0b85a97d-4623788f9fdmr592720f8f.30.1781631620849;
        Tue, 16 Jun 2026 10:40:20 -0700 (PDT)
Received: from localhost (p200300f65f47db049ad350a70b85c1e7.dip0.t-ipconnect.de. [2003:f6:5f47:db04:9ad3:50a7:b85:c1e7])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4606f2ce361sm44314905f8f.31.2026.06.16.10.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 10:40:20 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH] sequencer: Skip copying notes for commits that disappear during rebase
Date: Tue, 16 Jun 2026 19:40:12 +0200
Message-ID: <20260616174012.601651-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5948; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=6r6vI32s9pHofjBzVindNckNFhLuh/F1Trg9dPMV3uY=; b=owGbwMvMwMXY3/A7olbonx/jabUkhizDrprm6cuMwmcz6rAteyVw4Hg913/HO/l7W6O8DN742 dVoHFHvZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAi6qwcDFM2vXIoq4ybcuVb thGrOnv3UbatvP/tG14YmJ33Ekn+UzCJ2z1xhVHSAu74G3Hhsb/3xnwTZeW/Giw36aTMucnlGhf ObzcR5YzQ5X/rICj++f2kdl8O/uwD62JnzGMwYzSKmLfZcvOvoA2fm/Yt5jvQLZA6V73Eepv6kg B3rprSIOPjK976xwjN4FsTmD6LRSLPemmfSadi1Izzq5tWOqy81ZbudJRl8aO50nbOkwu12V/fe 1N8fr7mPNeXLxdsK5WVP8U2+VEC3+bTpRe2zXZJe2ulMMk1pq+lNU52l1K4/KJZ7KKXJjY+cOG/ FRrwr7L+zdWOncxTWMwNpzc6LW01+b1t7hYduaqzJjNcAQ==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

When a commit disappears during rebase because the patch content is
already there (but not by the same patch in which case the commit would
be skipped) the notes of that disappearing commit should not be copied
to the unrelated commit that happens to be HEAD.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

after also my 2nd bug report[1] didn't motivate anyone to come up with a
fix, I invested the time to work out one according to Phillip Wood's
suggestion.

IMHO it's not pretty, but it works for me.

Note that Phillip also suggested to integrete the test into
t3400-rebase.sh . IMHO it doesn't matter much if this is considered a
rebase test or a notes test. I kept it where I have it because I'm lazy
and failed to understand the git history created in that test.

Best regards
Uwe

[1] https://lore.kernel.org/git/20260612143952.3281115-2-u.kleine-koenig@baylibre.com


 sequencer.c             | 20 ++++++++++----------
 t/meson.build           |  1 +
 t/t3322-notes-rebase.sh | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 10 deletions(-)
 create mode 100755 t/t3322-notes-rebase.sh

diff --git a/sequencer.c b/sequencer.c
index 57855b0066ac..da2185a37c5d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2263,7 +2263,7 @@ static const char *reflog_message(struct replay_opts *opts,
 static int do_pick_commit(struct repository *r,
 			  struct todo_item *item,
 			  struct replay_opts *opts,
-			  int final_fixup, int *check_todo)
+			  int final_fixup, int *check_todo, int *dropped_commit)
 {
 	struct replay_ctx *ctx = opts->ctx;
 	unsigned int flags = should_edit(opts) ? EDIT_MSG : 0;
@@ -2273,7 +2273,7 @@ static int do_pick_commit(struct repository *r,
 	const char *base_label, *next_label, *reflog_action;
 	char *author = NULL;
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
-	int res, unborn = 0, reword = 0, allow, drop_commit;
+	int res, unborn = 0, reword = 0, allow;
 	enum todo_command command = item->command;
 	struct commit *commit = item->commit;
 
@@ -2492,7 +2492,7 @@ static int do_pick_commit(struct repository *r,
 		goto leave;
 	}
 
-	drop_commit = 0;
+	*dropped_commit = 0;
 	allow = allow_empty(r, opts, commit);
 	if (allow < 0) {
 		res = allow;
@@ -2500,7 +2500,7 @@ static int do_pick_commit(struct repository *r,
 	} else if (allow == 1) {
 		flags |= ALLOW_EMPTY;
 	} else if (allow == 2) {
-		drop_commit = 1;
+		*dropped_commit = 1;
 		refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
 				NULL, REF_NO_DEREF);
 		unlink(git_path_merge_msg(r));
@@ -2510,7 +2510,7 @@ static int do_pick_commit(struct repository *r,
 			_("dropping %s %s -- patch contents already upstream\n"),
 			oid_to_hex(&commit->object.oid), msg.subject);
 	} /* else allow == 0 and there's nothing special to do */
-	if (!opts->no_commit && !drop_commit) {
+	if (!opts->no_commit && !*dropped_commit) {
 		if (author || command == TODO_REVERT || (flags & AMEND_MSG))
 			res = do_commit(r, msg_file, author, reflog_action,
 					opts, flags,
@@ -4943,12 +4943,12 @@ static int pick_one_commit(struct repository *r,
 			   struct replay_opts *opts,
 			   int *check_todo, int* reschedule)
 {
-	int res;
+	int res, dropped_commit;
 	struct todo_item *item = todo_list->items + todo_list->current;
 	const char *arg = todo_item_get_arg(todo_list, item);
 
 	res = do_pick_commit(r, item, opts, is_final_fixup(todo_list),
-			     check_todo);
+			     check_todo, &dropped_commit);
 	if (is_rebase_i(opts) && res < 0) {
 		/* Reschedule */
 		*reschedule = 1;
@@ -4965,7 +4965,7 @@ static int pick_one_commit(struct repository *r,
 		return error_with_patch(r, commit,
 					arg, item->arg_len, opts, res, !res);
 	}
-	if (is_rebase_i(opts) && !res)
+	if (is_rebase_i(opts) && !res && !dropped_commit)
 		record_in_rewritten(&item->commit->object.oid,
 				    peek_command(todo_list, 1));
 	if (res && is_fixup(item->command)) {
@@ -5523,14 +5523,14 @@ static int single_pick(struct repository *r,
 		       struct commit *cmit,
 		       struct replay_opts *opts)
 {
-	int check_todo;
+	int check_todo, dummy;
 	struct todo_item item;
 
 	item.command = opts->action == REPLAY_PICK ?
 			TODO_PICK : TODO_REVERT;
 	item.commit = cmit;
 
-	return do_pick_commit(r, &item, opts, 0, &check_todo);
+	return do_pick_commit(r, &item, opts, 0, &check_todo, &dummy);
 }
 
 int sequencer_pick_revisions(struct repository *r,
diff --git a/t/meson.build b/t/meson.build
index c5832fee0535..6927bd9c794f 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -358,6 +358,7 @@ integration_tests = [
   't3311-notes-merge-fanout.sh',
   't3320-notes-merge-worktrees.sh',
   't3321-notes-stripspace.sh',
+  't3322-notes-rebase.sh',
   't3400-rebase.sh',
   't3401-rebase-and-am-rename.sh',
   't3402-rebase-merge.sh',
diff --git a/t/t3322-notes-rebase.sh b/t/t3322-notes-rebase.sh
new file mode 100755
index 000000000000..0eddde7f9961
--- /dev/null
+++ b/t/t3322-notes-rebase.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description='Test notes on rebase'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	git init &&
+	git config notes.rewriteRef refs/notes/commits &&
+	git version > version &&
+	echo A > A &&
+	git add A &&
+	git commit -m A &&
+	git branch branch &&
+	echo B > B &&
+	git add B &&
+	git commit -m B &&
+	git notes add -m "This is B" @ &&
+	echo C > C &&
+	git add C &&
+	git commit -m C &&
+	git checkout branch &&
+	echo B > B &&
+	echo D > D &&
+	git add B D &&
+	git commit -m BD
+'
+
+test_expect_success 'rebase B + C on top of BD' '
+	git rebase @ master
+'
+
+test_expect_success 'assert there is no note on BD' '
+	if git notes list branch >/tmp/lalaa; then return 1; fi
+'
+
+test_done

base-commit: 3e65291872de10c3f0bf05ea8c24187e7a71ebf0
-- 
2.47.3

