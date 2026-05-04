Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D583E8684
	for <git@vger.kernel.org>; Mon,  4 May 2026 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919261; cv=none; b=alrdlFT623aoMw9LTe0VZrRlxp0xqS7seIeJ8mb4WzSlYIXs3a25HEvYyDlUdvfekfkX7mVePP08DdOnb21BmmYQvWeB0hxvoC4pYzgrR1dKDJ9E1XHt/3ULTLOhsaQ6w2NJs7BUVKnyFrppbGD6l9CNCG1u8UsWg1P4AYRsdts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919261; c=relaxed/simple;
	bh=IFlwNBimThsBfTd2dx+dzw5aoenobn6UhKgbSVwGLV8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IHPNyPP/3idHRsIwWXGWtpC59rtJPid/89vaBC/zbUg7QFRS/WRkQpUs4+eHME/wtgR5fg0r6DF1IAHEqoq5QCyhEge6Fm1zfxRvj6Uc+lcCyRe9nzOUV0t5zZoF2iN7MImLNOeexz47FwnbEh7QcT3hVKK38+HUHYsB5FpfqTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDXr8tls; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDXr8tls"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8b4aeddfacaso47003716d6.0
        for <git@vger.kernel.org>; Mon, 04 May 2026 11:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777919259; x=1778524059; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2a341OuY1fxH+jmt7aVP1tMUu6/CebN7GltibBgOHj4=;
        b=MDXr8tlsHP+NQitnWglqqwc+fs8Qd2ycFzByNF8AQlrtNVtN6dARD9LrIwZh/OYVlu
         RQbsA7Jpz9yOfq0/4T8PE0iu9Cis3SkMUU2ZlU/fjGmhLSTV72szDrdegl/XpXtJyHtY
         tB+MZu6argfW7fLyjGZcJeiQvQTdj3IVanGb4McHmqvBoqx+jjYFogpzzGuqv6KAtUnQ
         ll4Gg3offMqe3QLHzKutDf42qoPcB1m4PMoQ5cPo7BZNzRWVw45XJTxzfO/TCIwAuG5U
         34LcrK8QxUwxMUQcibKZnqAcoqJedp5EGqNhYXUK0E2LcqA/gdwuvEQOoqzZnyTyxCFP
         qVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777919259; x=1778524059;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2a341OuY1fxH+jmt7aVP1tMUu6/CebN7GltibBgOHj4=;
        b=TMZX5WlMmbAnskBxkLpCBXdurNLZaSGzvP/0TVDLkW/EuO23QjvsLGsUofA+rGdTYP
         wyYEmOEr5Sd+rmFpYoA25qaJM3qEs2k54/1cSOyV77k2gqoazb0QuCJWNKG0LqjGXf6v
         H1Ma1q5Zz/DSrv0Kj403KBaDn3oIHfkIw+Z5J7R20lgb2FLlDVdjCcFGRNjhypzjB5PO
         GVIvpRBtk8M+xeQGLSXBwgHauA8FVksS6unzcekyu0DFzVm08rVWj2IHqfRPPxhP2b/p
         nIs6WLesMX+EgvuKDkaevyFbCxZomGewf0EUu5Hqj76sA1DSq31Cde27aAkPXmUCrwo5
         vk9A==
X-Gm-Message-State: AOJu0Yyk+GIqv48gLN/Ty3vgurKTZ78bRJiM0c2KAEASKk8FmIZP2jmZ
	z5aZnYKL6El0ypmmsNm/L8Fov2mXUhhlf+t2jbh0nsI33z3nH9oJH0XcfwgUJQ==
X-Gm-Gg: AeBDievqPTsF2NRYBjB50wt/LWRt1WKs3WhgeeYjLgtpo0+qrmzW9FOvaEjy3ctPgHO
	4c9Bf2AAbqLyWC5db4nzl6mvsiOWmU+vPM5AvPgxf05XDdZaaYx1kX2ErmUue93sPdUnbeovXTK
	0YEQZH8cYUHqk5fCw128T+FYXkp+Tm7KqZMkA+ktXMoWbWdX6IuKLgmdE2kXQprLjwMOJ48YI/C
	pN4T+BpLsiEQAgug5gmNhro7Oq/SvWIphpNEOqmPNQ3NFHMWyIOKjeXRDXyB8qdwG0onvw0fvlj
	3EqnL+vmhOaNewFT07da0oXItyI+TFa8bDaCDRZKmf0HBf7bwQAjbwZ9vAErjhQ9bBpbsbWKXxG
	QELFE27DaSz0n/Yd61ph87zFAJtNoedz1BFoHwqyjEyCY0oMhcx7Ed+RzH6JJG1C/fD5p9g50SS
	yTECx2ZM8OYmn6iK/lrSY4j5O0vnBUjHMlgmw71QcwhQPWCg==
X-Received: by 2002:a05:6214:4986:b0:8b7:abb5:66d5 with SMTP id 6a1803df08f44-8b7abb56a9cmr135618826d6.18.1777919258799;
        Mon, 04 May 2026 11:27:38 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.30.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5391e344fsm139803266d6.12.2026.05.04.11.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:27:37 -0700 (PDT)
Message-Id: <0bc5ebbe68c29b408f7f5b3656f23704a2645a12.1777919250.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v2.git.git.1777919250.gitgitgadget@gmail.com>
References: <pull.2285.git.git.1777671337839.gitgitgadget@gmail.com>
	<pull.2285.v2.git.git.1777919250.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 18:27:29 +0000
Subject: [PATCH v2 5/6] branch: add branch.<name>.pruneMerged opt-out
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Setting branch.<name>.pruneMerged=false exempts that branch from
--prune-merged (and from fetch --prune-merged), even with --force.
Useful for keeping a topic branch around between rounds.

Explicit deletion via 'git branch -d' is unaffected.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/branch.adoc |  7 ++++++
 Documentation/git-branch.adoc    | 17 +++++++-------
 builtin/branch.c                 | 23 ++++++++++++++++--
 t/t3200-branch.sh                | 40 ++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
index a4db9fa5c8..60dba38e27 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -102,3 +102,10 @@ for details).
 	`git branch --edit-description`. Branch description is
 	automatically added to the `format-patch` cover letter or
 	`request-pull` summary.
+
+`branch.<name>.pruneMerged`::
+	If set to `false`, branch _<name>_ is exempt from
+	`git branch --prune-merged` (and `git fetch --prune-merged`).
+	Useful for topic branches you intend to develop further after
+	an initial round has been merged upstream. Defaults to true.
+	Explicit deletion via `git branch -d` is unaffected.
diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 4995e03ef6..8d3e13d785 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -216,16 +216,15 @@ Each _<remote>_ may be either the name of a configured remote
 	Delete the local branches that `--forked` would list for
 	the same _<remote>_ arguments, but only when the branch's
 	push destination remote-tracking ref (the ref `git push`
-	would update; see `branch_get_push` semantics) no longer
-	resolves locally. In other words: the branch was pushed
-	under some name on _<remote>_, and that name has since
-	been pruned upstream.
+	would update) no longer resolves locally. In other words:
+	the branch was pushed under some name on _<remote>_, and
+	that name has since been pruned upstream.
 +
-By default, the local tip must also be reachable from the
-upstream remote-tracking ref (see `--no-merged`); branches with
-unpushed commits are refused. With `--force` (or `-f`), delete
-them regardless. The currently checked-out branch in any worktree
-is always preserved.
+The local tip must also be reachable from the upstream
+remote-tracking ref; branches with unpushed commits are refused.
+With `--force` (or `-f`), delete them regardless. The currently
+checked-out branch in any worktree is always preserved, as is
+any branch with `branch.<name>.pruneMerged` set to `false`.
 
 `-v`::
 `-vv`::
diff --git a/builtin/branch.c b/builtin/branch.c
index f50b7e222c..74c8f1aedf 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -809,23 +809,42 @@ static int prune_merged_branches(int argc, const char **argv, int force,
 	for_each_string_list_item(item, &candidates) {
 		const char *short_name = item->string;
 		struct strbuf full = STRBUF_INIT;
+		struct strbuf key = STRBUF_INIT;
 		struct branch *branch;
 		const char *push_ref;
+		int opt_out = 0;
 
 		strbuf_addf(&full, "refs/heads/%s", short_name);
 		if (branch_checked_out(full.buf)) {
 			strbuf_release(&full);
+			strbuf_release(&key);
 			continue;
 		}
 		strbuf_release(&full);
 
 		branch = branch_get(short_name);
 		push_ref = branch ? branch_get_push(branch, NULL) : NULL;
-		if (!push_ref)
+		if (!push_ref) {
+			strbuf_release(&key);
 			continue;
+		}
 		if (refs_ref_exists(get_main_ref_store(the_repository),
-				    push_ref))
+				    push_ref)) {
+			strbuf_release(&key);
+			continue;
+		}
+
+		strbuf_addf(&key, "branch.%s.prunemerged", short_name);
+		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
+		    !opt_out) {
+			if (!quiet)
+				fprintf(stderr, _("Skipping '%s' "
+						  "(branch.%s.pruneMerged is false)\n"),
+					short_name, short_name);
+			strbuf_release(&key);
 			continue;
+		}
+		strbuf_release(&key);
 
 		strvec_push(&deletable, short_name);
 	}
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 9e997b6be6..2127cf1fa5 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1852,4 +1852,44 @@ test_expect_success '--prune-merged deletes when push ref differs from upstream'
 	test_must_fail git -C pm-pushdiff rev-parse --verify refs/heads/topic-a
 '
 
+test_expect_success '--prune-merged honours branch.<name>.pruneMerged=false' '
+	test_when_finished "rm -rf pm-optout" &&
+	git clone pm-upstream pm-optout &&
+	git -C pm-optout branch one --track origin/one &&
+	git -C pm-optout branch two --track origin/two &&
+	git -C pm-optout config branch.one.pruneMerged false &&
+
+	git -C pm-optout update-ref -d refs/remotes/origin/one &&
+	git -C pm-optout update-ref -d refs/remotes/origin/two &&
+	git -C pm-optout branch --prune-merged origin 2>err &&
+
+	git -C pm-optout rev-parse --verify refs/heads/one &&
+	test_must_fail git -C pm-optout rev-parse --verify refs/heads/two &&
+	test_grep "Skipping .one." err
+'
+
+test_expect_success '--prune-merged --force still honours pruneMerged=false' '
+	test_when_finished "rm -rf pm-optout-force" &&
+	git clone pm-upstream pm-optout-force &&
+	git -C pm-optout-force checkout -b one --track origin/one &&
+	test_commit -C pm-optout-force unpushed &&
+	git -C pm-optout-force checkout - &&
+	git -C pm-optout-force config branch.one.pruneMerged false &&
+
+	git -C pm-optout-force update-ref -d refs/remotes/origin/one &&
+	git -C pm-optout-force branch --force --prune-merged origin &&
+
+	git -C pm-optout-force rev-parse --verify refs/heads/one
+'
+
+test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
+	test_when_finished "rm -rf pm-optout-d" &&
+	git clone pm-upstream pm-optout-d &&
+	git -C pm-optout-d branch one --track origin/one &&
+	git -C pm-optout-d config branch.one.pruneMerged false &&
+
+	git -C pm-optout-d branch -d one &&
+	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
+'
+
 test_done
-- 
gitgitgadget

