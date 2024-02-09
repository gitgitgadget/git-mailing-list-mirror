Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AA571B2F
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707495585; cv=none; b=S+syd1OVzjxwWqg3kDNHRSNo9Yo0ZFBIqc3sBeGdM3hpEm/uxQSDkJrR6csTmBwonlBSXpxHXcqJuyigAqNjdAA86LW6GsKVO/B27C8b+BNYwWyKlvmcqQkCy7hvUxy8M0GLGxsRs7j65vgTega8ejT7wJ3CtyAPKqR4QkiE1eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707495585; c=relaxed/simple;
	bh=8WycQs7HyG1K0PCgaMUMU44ceUUH3qQ4Qq1ls9XKiNY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ly5lrgUzSxqGHPsgPOtNQXbt3GKy46IK37w28shzUP1OQd4wnrnvBwrMVYv6x1UZ+C6X8awM7UIIz6PfafBKmNq6p8zna5BTf8QPokN9wWSvbcRFzQXhI2usd34R8/HjuRdMGUYGgQCFqSPqp/Zl2YMbS5WeKT+TjpixbmAzLe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X25/6cuS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X25/6cuS"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41061f0a243so7806075e9.0
        for <git@vger.kernel.org>; Fri, 09 Feb 2024 08:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707495581; x=1708100381; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvDdiNp35j4UEwYUOLsTg/+h03Jm+APu1HolJX3Cwqs=;
        b=X25/6cuS4aAWlLfWF0HiLZK98dDmOS1boUGuLXTCjJpDkLI9SgYMpsdg7wm9iXIogd
         9buP7pNgLlAoJPNUSSqNPEo0ssEAb+/a/IKwakoQMN3R+w30Q0S8L1KShO2qZ4ymj+Jv
         Zkz/TxBKRTXaLBwmvC7jyJnuZyeAc/MDv5ACrTWcpeuPtOpC7GzrdAPduvRqKB1qwv1b
         cu0NYySzdFaDUa1zSnKolMWyF7m37a1MiW5yJz1aXwgorftS0IrBjX4BCO+MNOq82ha5
         yul0FfemoX+Cu3jk1FH677bzUE7bxihj5GPtgRYjFr+8oZtfMq9ZVObFaqW9LTedyvUQ
         /Q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707495581; x=1708100381;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvDdiNp35j4UEwYUOLsTg/+h03Jm+APu1HolJX3Cwqs=;
        b=i4RbMUw/hYJQgyMbaDMS8pwwqTpoWqd13klJfy4NWNE5oMMW7kVbWUTB7R4WTrZ+KI
         NHIwCkE3vmZFzBO1iG/zEuFU9bh9H+2/bn3csSO11ByaAY62YnGCK6igIXUA3mtnZvtQ
         //CH4A/3mqZE6UTA+dHF9epOu7k3Weq2Mf4slQYnTgepa3t2Gswdf3/sU2ektquuBYc1
         BWPgMQ7RV1tZ4qPka91DEGRdW2Ja5nvUTx15V6qJXCB2qUt+qUNmAru0wmtFKzj2RWy4
         gxITOXso4MUO2rkLtRuuCRo6KKvs59YEDVlYN7C0lHBPIHrpOPnB4F9ZpaIVU3nIjEW8
         gsCw==
X-Gm-Message-State: AOJu0YyXi57OszADDPa5swD13RegnbfCV0ZXsN2erzWUAGXaHMYyAiuu
	+ZlsGP6V30NFOD0VYaUPgCLz6/ba98XjUhYftdNc4EgsVe+C5fADCJQDfbWN
X-Google-Smtp-Source: AGHT+IGTKFdXUIPAmFHwNys258hBJAkQyRq0ymuVEsYaXIt+rgwsfJcNs6jh8o5M9EvH67ZaJJ1+4w==
X-Received: by 2002:a05:600c:19cb:b0:40d:8bc2:6059 with SMTP id u11-20020a05600c19cb00b0040d8bc26059mr1720705wmq.36.1707495581060;
        Fri, 09 Feb 2024 08:19:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWnsjRJ7wqkkFQtZopM5VpPocF3KRguaPXOwiJV93HSHHzaxzDNBjKbrIhQmPBc+W8vSRVC+OVDMjjBdHSEqEFKxP4CsiOP3N9+Wjd3zUNKfVwZmEoZl3S/5OL8wn3VZwTjX58=
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c470500b0040fdf5e6d40sm1131221wmo.20.2024.02.09.08.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:19:40 -0800 (PST)
Message-ID: <pull.1656.v2.git.1707495579886.gitgitgadget@gmail.com>
In-Reply-To: <pull.1656.git.1707411636382.gitgitgadget@gmail.com>
References: <pull.1656.git.1707411636382.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Feb 2024 16:19:39 +0000
Subject: [PATCH v2] prune: mark rebase autostash and orig-head as reachable
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Orgad Shaneh <orgads@gmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Rebase records the oid of HEAD before rebasing and the commit created by
"--autostash" in files in the rebase state directory. This means that
the autostash commit is never reachable from any ref or reflog and when
rebasing a detached HEAD the original HEAD can become unreachable if the
user expires HEAD's the reflog while the rebase is running. Fix this by
reading the relevant files when marking reachable commits.

Note that it is possible for the commit recorded in
.git/rebase-merge/amend to be unreachable but pruning that object does
not affect the operation of "git rebase --continue" as we're only
interested in the object id, not in the object itself.

Reported-by: Orgad Shaneh <orgads@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    prune: mark rebase autostash and orig-head as reachable
    
    Thanks for the comments on v1. I've fixed the memory leak and changed
    the return types as suggested by Eric.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1656%2Fphillipwood%2Fprune-protect-rebase-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1656/phillipwood/prune-protect-rebase-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1656

Range-diff vs v1:

 1:  ce75996f1a3 ! 1:  7256197a26f prune: mark rebase autostash and orig-head as reachable
     @@ reachable.c: static void update_progress(struct connectivity_progress *cp)
       		display_progress(cp->progress, cp->count);
       }
       
     -+static int add_one_file(const char *path, struct rev_info *revs)
     ++static void add_one_file(const char *path, struct rev_info *revs)
      +{
      +	struct strbuf buf = STRBUF_INIT;
      +	struct object_id oid;
     @@ reachable.c: static void update_progress(struct connectivity_progress *cp)
      +
      +	if (!read_oneliner(&buf, path, READ_ONELINER_SKIP_IF_EMPTY)) {
      +		strbuf_release(&buf);
     -+		return 0;
     ++		return;
      +	}
      +	strbuf_trim(&buf);
      +	if (!get_oid_hex(buf.buf, &oid)) {
      +		object = parse_object_or_die(&oid, buf.buf);
      +		add_pending_object(revs, object, "");
      +	}
     -+	return 0;
     ++	strbuf_release(&buf);
      +}
      +
     -+/* Mark objects recored in rebase state files as reachable. */
     -+static int add_rebase_files(struct rev_info *revs)
     ++/* Mark objects recorded in rebase state files as reachable. */
     ++static void add_rebase_files(struct rev_info *revs)
      +{
      +	struct strbuf buf = STRBUF_INIT;
      +	size_t len;
     @@ reachable.c: static void update_progress(struct connectivity_progress *cp)
      +	}
      +	strbuf_release(&buf);
      +	free_worktrees(worktrees);
     -+	return 0;
      +}
      +
       static int add_one_ref(const char *path, const struct object_id *oid,


 reachable.c                 | 50 +++++++++++++++++++++++++++++++++++++
 t/t3407-rebase-abort.sh     | 17 ++++++++++++-
 t/t3420-rebase-autostash.sh | 10 ++++++++
 3 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/reachable.c b/reachable.c
index f29b06a5d05..3b85add243b 100644
--- a/reachable.c
+++ b/reachable.c
@@ -17,6 +17,7 @@
 #include "pack-mtimes.h"
 #include "config.h"
 #include "run-command.h"
+#include "sequencer.h"
 
 struct connectivity_progress {
 	struct progress *progress;
@@ -30,6 +31,52 @@ static void update_progress(struct connectivity_progress *cp)
 		display_progress(cp->progress, cp->count);
 }
 
+static void add_one_file(const char *path, struct rev_info *revs)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct object_id oid;
+	struct object *object;
+
+	if (!read_oneliner(&buf, path, READ_ONELINER_SKIP_IF_EMPTY)) {
+		strbuf_release(&buf);
+		return;
+	}
+	strbuf_trim(&buf);
+	if (!get_oid_hex(buf.buf, &oid)) {
+		object = parse_object_or_die(&oid, buf.buf);
+		add_pending_object(revs, object, "");
+	}
+	strbuf_release(&buf);
+}
+
+/* Mark objects recorded in rebase state files as reachable. */
+static void add_rebase_files(struct rev_info *revs)
+{
+	struct strbuf buf = STRBUF_INIT;
+	size_t len;
+	const char *path[] = {
+		"rebase-apply/autostash",
+		"rebase-apply/orig-head",
+		"rebase-merge/autostash",
+		"rebase-merge/orig-head",
+	};
+	struct worktree **worktrees = get_worktrees();
+
+	for (struct worktree **wt = worktrees; *wt; wt++) {
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, get_worktree_git_dir(*wt));
+		strbuf_complete(&buf, '/');
+		len = buf.len;
+		for (size_t i = 0; i < ARRAY_SIZE(path); i++) {
+			strbuf_setlen(&buf, len);
+			strbuf_addstr(&buf, path[i]);
+			add_one_file(buf.buf, revs);
+		}
+	}
+	strbuf_release(&buf);
+	free_worktrees(worktrees);
+}
+
 static int add_one_ref(const char *path, const struct object_id *oid,
 		       int flag, void *cb_data)
 {
@@ -322,6 +369,9 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	head_ref(add_one_ref, revs);
 	other_head_refs(add_one_ref, revs);
 
+	/* rebase autostash and orig-head */
+	add_rebase_files(revs);
+
 	/* Add all reflog info */
 	if (mark_reflog)
 		add_reflogs_to_pending(revs, 0);
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index ebbaed147a6..9f49c4228b6 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -40,9 +40,24 @@ testrebase() {
 		test_path_is_missing "$state_dir"
 	'
 
+	test_expect_success "pre rebase$type head is marked as reachable" '
+		# Clean up the state from the previous one
+		git checkout -f --detach pre-rebase &&
+		test_tick &&
+		git commit --amend --only -m "reworded" &&
+		orig_head=$(git rev-parse HEAD) &&
+		test_must_fail git rebase$type main &&
+		# Stop ORIG_HEAD marking $state_dir/orig-head as reachable
+		git update-ref -d ORIG_HEAD &&
+		git reflog expire --expire="$GIT_COMMITTER_DATE" --all &&
+		git prune --expire=now &&
+		git rebase --abort &&
+		test_cmp_rev $orig_head HEAD
+	'
+
 	test_expect_success "rebase$type --abort after --skip" '
 		# Clean up the state from the previous one
-		git reset --hard pre-rebase &&
+		git checkout -B to-rebase pre-rebase &&
 		test_must_fail git rebase$type main &&
 		test_path_is_dir "$state_dir" &&
 		test_must_fail git rebase --skip &&
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 693934ee8be..1a820f14815 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -333,4 +333,14 @@ test_expect_success 'never change active branch' '
 	test_cmp_rev not-the-feature-branch unrelated-onto-branch
 '
 
+test_expect_success 'autostash commit is marked as reachable' '
+	echo changed >file0 &&
+	git rebase --autostash --exec "git prune --expire=now" \
+		feature-branch^ feature-branch &&
+	# git rebase succeeds if the stash cannot be applied so we need to check
+	# the contents of file0
+	echo changed >expect &&
+	test_cmp expect file0
+'
+
 test_done

base-commit: 2a540e432fe5dff3cfa9d3bf7ca56db2ad12ebb9
-- 
gitgitgadget
