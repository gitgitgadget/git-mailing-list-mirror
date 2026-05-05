Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4F42EC0A6
	for <git@vger.kernel.org>; Tue,  5 May 2026 19:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778009051; cv=none; b=Vw4SjJfeab+thK7hIIqupsDSge9ba5MeZ1IKhUoMCHFC8edYCcJ1Ugldlv8OC8A+KTVXpLDUHltVd56NiqRODYiaji0GOAD2DCxNbjF/oOxhtHwgDejg0FQHhsP8OJ7GoZUfYbZugy2ToK18TQB3WVdaf6s6KrjdbUQiFqQvbqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778009051; c=relaxed/simple;
	bh=+ijuAnXpL0uD6XVvx4gebsk0JUCaRIVmT7gyD5iAYzA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Lp3quDW/u8R3DnvOjBDDMeZ6GumGWllrhm83FguUCOWRHo4G1j4UMSPsn59MI1JT3C6sEQx9HoaR8OLJzTYDiJoelH/swV/OHp49Ar8M3hmfBvyEt9a0kNUC25pzGMdSIE9cIwh6QjoV7pf/SKOq3frlfp6ej8+90VSkVNyiLZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJAKhpft; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJAKhpft"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-479dc6d26e3so3174381b6e.0
        for <git@vger.kernel.org>; Tue, 05 May 2026 12:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778009048; x=1778613848; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voLD+WYhQefwnj26p99HAWOufcq7B2+rDde40BV2cck=;
        b=gJAKhpft8VreVTzCFI5+pDfJneK/UQDl6rhDngy8iuEfQiHAMprb8sI7KGmx0/OM1d
         fVsHN6ShQoByk96hF2ZY/s6Y5qCm1Hm/z1MpEdxyFYnBHbOxUyWUMm+JPHAWDNCcaC6K
         CMFKEWUSYzax1fZ74AKyMQlqSui8l1EDPfe2bJlEjkpKkq53Nmhd759lDQTgSQPr/NjN
         LHyzZB10G7wlrKUkvQ5XdmObdydDsm76qwQbAG++r8u9vMKvKpl0kF16xZ2e49TgZ56A
         ejOSVi6FuKxZArynQ4MXo6TroSrgQm+OTaASkn2pvX+HsuXWBwtbw7r+yriFHWj1BVzZ
         Z6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778009048; x=1778613848;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=voLD+WYhQefwnj26p99HAWOufcq7B2+rDde40BV2cck=;
        b=Zq87PwkQ0L1DQJQfs4xiqvHsVlwxOrc8TmU3XgUGYFE/3/6DXiF90Mk2ikQQ4CsCsp
         ckect97QhwYx9RDxPK0QSY6bzf3KN/LX42y5OUYrcjihhr+m6KGQsdIHntEkeXw3adZk
         wjkWEvU9Tss16QvIdHs3T3q8ovlKHn3yKj0ZkAVtFSxAYXZ9QEvEE5fFU+6EN1FUee4/
         gDu3lOQm3yTDh6lt3RIIk6Iu19S5hALA+4wSZ3qTELUrRCxNEOozX5+iPy/jSNz2dI39
         leWdaQQnSDaYVZxmaJsrj8iq8JzMRz1h8uwCXgQjnxS+9f2YQ3S64vao0xNmUN/1GrDx
         KKlA==
X-Gm-Message-State: AOJu0Yytd3uSrJ38yN5jL8z9Sf9doCBxHu2hpe7XSKmXRx+jZWkqwaYN
	u1kV6gO1vT4184P3QTJsJqfeYAIyheBrpv/uxWMHMZ+ugX53AQsoI2hBxSgVxQ==
X-Gm-Gg: AeBDieukhgrEs+ALJeKaLVtQxunoVds7b6jklro4iX3TCP3TwXAfA20WhweRgfQZE6L
	YNIWKHkuTmBie66P/qgQbgyz0iSt9lJe//c9cguvfm1M/S92aKs8etr04WL6B/eKvnphAIep05A
	3o9J59Zztw9SauCK0v/koQscMbMSiZqWySs5v0pyDlmsMNkg5tEQshOE/glO3v5gwd7kLmDFhww
	+cfI73UBFteTYpjRceR3H75mf3wlfWVXpPQ7MN8jYekqbnuicplxckquZsnirAsJE8OLbZqsFv1
	3k4/RHYi4ZWVBWNhyzEfbZuDkYMP1+20CdXqr5D50NPo0OEYNL84PF4baSI7Q6ZRAvnGoBjMPaz
	AmOtc+Xsi41NSCEUOmPUhuWu4whJIlguQftjgP/yuJesMNOzP9uLr9+Ye666p84ODOqXwTN03Hh
	crW1a0sTMJncgSyWUqcCdkbLJqV2/g+q/+W6jk
X-Received: by 2002:a05:6808:30a5:b0:46a:cd63:96ca with SMTP id 5614622812f47-48042309bf6mr235140b6e.27.1778009048421;
        Tue, 05 May 2026 12:24:08 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.108.21])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7deca826dbesm10630132a34.12.2026.05.05.12.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:24:07 -0700 (PDT)
Message-Id: <c645526bb5c699df5238d148e8fd8d2b891cd337.1778009038.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v4.git.git.1778009038.gitgitgadget@gmail.com>
References: <pull.2285.v3.git.git.1777965747.gitgitgadget@gmail.com>
	<pull.2285.v4.git.git.1778009038.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 May 2026 19:23:57 +0000
Subject: [PATCH v4 5/6] branch: add branch.<name>.pruneMerged opt-out
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Harald Nordgren <haraldnordgren@gmail.com>,
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
 builtin/branch.c                 | 31 +++++++++++++++++++++----
 t/t3200-branch.sh                | 40 ++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+), 13 deletions(-)

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
index 80b20a55eb..9d4944d17e 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -216,16 +216,15 @@ Each _<remote>_ may be either the name of a configured remote
 	Delete the local branches that `--forked` would list for
 	the same _<remote>_ arguments, but only when the branch's
 	push destination remote-tracking branch (the branch `git push`
-	would update; see `branch_get_push` semantics) no longer
-	resolves locally. In other words: the branch was pushed
-	under some name on _<remote>_, and that name has since
-	been pruned upstream.
+	would update) no longer resolves locally. In other words:
+	the branch was pushed under some name on _<remote>_, and
+	that name has since been pruned upstream.
 +
-By default, the local tip must also be reachable from the
-upstream remote-tracking branch (see `--no-merged`); branches with
-unpushed commits are refused. With `--force` (or `-f`), delete
-them regardless. The currently checked-out branch in any worktree
-is always preserved.
+The local tip must also be reachable from the upstream
+remote-tracking branch; branches with unpushed commits are refused.
+With `--force` (or `-f`), delete them regardless. The currently
+checked-out branch in any worktree is always preserved, as is
+any branch with `branch.<name>.pruneMerged` set to `false`.
 
 `-v`::
 `-vv`::
diff --git a/builtin/branch.c b/builtin/branch.c
index f2ca7b64d3..07d867373f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -834,13 +834,16 @@ static int prune_merged_branches(int argc, const char **argv, int force,
 	for_each_string_list_item(item, &candidates) {
 		const char *short_name = item->string;
 		struct strbuf full = STRBUF_INIT;
+		struct strbuf key = STRBUF_INIT;
 		struct branch *branch;
 		const char *push_ref;
 		const char *upstream;
+		int opt_out = 0;
 
 		strbuf_addf(&full, "refs/heads/%s", short_name);
 		if (branch_checked_out(full.buf)) {
 			strbuf_release(&full);
+			strbuf_release(&key);
 			continue;
 		}
 		strbuf_release(&full);
@@ -850,18 +853,38 @@ static int prune_merged_branches(int argc, const char **argv, int force,
 		if (upstream &&
 		    string_list_has_string(&protected_default_refs, upstream)) {
 			const char *leaf = strrchr(upstream, '/');
-			if (leaf && !strcmp(leaf + 1, short_name))
+			if (leaf && !strcmp(leaf + 1, short_name)) {
+				strbuf_release(&key);
 				continue;
+			}
 		}
 
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
+		if (string_list_has_string(&protected_default_refs, push_ref)) {
+			strbuf_release(&key);
 			continue;
-		if (string_list_has_string(&protected_default_refs, push_ref))
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
index b41f8343b3..f9aca90f4d 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1884,4 +1884,44 @@ test_expect_success '--prune-merged spares branches whose push ref is the defaul
 	git -C pm-pushdefault rev-parse --verify refs/heads/topic
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

