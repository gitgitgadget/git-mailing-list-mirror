Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4E637107E
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780477495; cv=none; b=HPzsSsyngukFZmNwCr9HO1B9C900rrKKJ7iNYjaatApzIPdc/whbVK5fgS5nYcihZJPCvo3BMEAd/WnfmqS+0w9a7rojVe4qYzINhPwp7TmAI6sqZ4eiWFJQCFy4SejRiEMY4MGgpwtoKendwsZUaks+vu7v87TRD2/lqoic3UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780477495; c=relaxed/simple;
	bh=EIeLIAv0mG/h7nrEM7VgCfFatA/PEKMg3hT36T/kJY4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mZ1P7mfqdAkQkdD7wGkrg9ILxXiENZYzMGxPq5CtlBuk4Nf/IDWogY9GYJYwhx+bUQETSKCHBpprQzHZDUEr4qroJWsFXw+/OYskrJ0rAeZ1GTSzJFI2i8jYK+toXDKUkk0UdjzocNU1RegDVAzQkzAj+LMGtjWjFCD4413RRDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LS6SJz2m; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LS6SJz2m"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30759632453so292793eec.1
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 02:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780477493; x=1781082293; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8M+GSzWxUqsw9r7HDW48dUYuyZdVCtzsSkaDRzGYhRI=;
        b=LS6SJz2mWgZN9YvHHZ4nVAp1m8J+vi4IkKvMG+vVne4kaETUXuSHQYe7WkNNFlWwHG
         0eePabVYQbtHTSvbgY03kKKhekwEug+tEXeLzoogYf00lZm2DRbDs5mlgAELhzKidGk1
         zsq8Z3XOJOt7bI9pbPvYolAFTCzkw/+rzs38q93YRnLNhT6uevaxA7M2Y7u3v7oQVHCP
         /hOSEfclxrlmTUhPx2Hona+84wFwJMrV5X6poNwGLwpETIExF8IYhqIclU40awLiPZ5V
         DWXFa9HPK/7JUguqqVgSuWQz4lMIsbc5l35SkBaE3Yyr7bGybdg0BKQ9d5qI5Y+xOtEu
         W5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780477493; x=1781082293;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8M+GSzWxUqsw9r7HDW48dUYuyZdVCtzsSkaDRzGYhRI=;
        b=NXMkLDmTeBqaMY7uxoC92Uxn1zsIN7Z2mnZaDWhwCNzfrj5iojzpKQncfi8bIKMsxf
         dQ3zXya41+LkPzW8haopsSm2mGX77wqbmvRieFa9BbnGJXXcIs02bmwFMqAfz4i430qP
         qdJebgoJO3yEnfFDiE1dEmPJAFLwdCr/CbUsIWRviVQOtCEPk3uDAdylRtmuoJ1dOQSf
         /p+8Q/KV7ecgl1oAqqjtyKxGlhD4ywMLAWczh8L0fGfeuIhY7li5MVVmmvWLgEPoZ5hz
         Aqy/tViVnAS3TBsTcfYgu5Hb6o7PUrtJ74KwmQHzeLuMmYRUiOEee6yMUDbBPknRrMvs
         LPKw==
X-Gm-Message-State: AOJu0Yxj/rK9sw0zpyGYYyKaKdf77mWcWDrhUTQQPuHYpuOwu6+o1lV0
	3POKmgbNpA/HF/LYtra7caJKkYIT3/cYohaUTVtRWvnMf5aR//XpcSBcFja40C1r
X-Gm-Gg: Acq92OFPKRJ1gfauNnRoIiqcMWRtCNAASO5cqiWfW1mWpcrqKIsFx0bj1SeI2KMiRjM
	rsrx183sh+8yfoDBanPYN7i8SrmU5qvODb7mRpyh3tF2Rv/tWt2KPi2eqZ72LGZJnvh73/W5TvZ
	yK3pLftSWl4XDRyhkYkeB9/ouwNdlKju/6GrClTRH7nxr+2mIt1SjyciJK3zwjs41DdWmlS0DIb
	dT/HtRd3Dd5WMegji//k18hRG1jUfDr1AfYD+o92092b8xD/V0TUCSqGQhcgFNfaf5Yo5NjSs4O
	/UlbU2FIhxa6fBNDIepkBv5haNVZFTrHgC9KgnG2bQceHw4Ur6Rkqx3nhyr2tIxzvmLNE3KUsbj
	XWqIs4pw/SGo2J5T20jBsPt/i4MEca3Axk4icLgmHYKvZwy6QWpW11mxQqrUSDvV88M1IdwwaoT
	cxbH4O3N25cJdlU1g0hgejvZ0d+6mqv5I+fbxYuQL1DVMCtxWJ
X-Received: by 2002:a05:7301:19ad:b0:307:3a6c:ecf4 with SMTP id 5a478bee46e88-3074fa7f724mr1464794eec.9.1780477492491;
        Wed, 03 Jun 2026 02:04:52 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.228.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db56697sm1970895eec.2.2026.06.03.02.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 02:04:51 -0700 (PDT)
Message-Id: <5f793f8d0d5e4fd5b2eea73905092c45039a1d3c.1780477479.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com>
References: <pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com>
	<pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Jun 2026 09:04:38 +0000
Subject: [PATCH v12 5/6] branch: add branch.<name>.pruneMerged opt-out
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
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Setting branch.<name>.pruneMerged=false exempts that branch from
"git branch --prune-merged". Useful for a topic branch you want
to develop further after an initial round has been merged
upstream.

Unless --quiet is given, the skip is reported per branch so the
user knows why their topic was preserved.

Explicit deletion via "git branch -d" continues to consult the
normal merge check and is not affected by this setting.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/branch.adoc |  7 +++++++
 Documentation/git-branch.adoc    |  5 +++--
 builtin/branch.c                 | 14 ++++++++++++++
 t/t3200-branch.sh                | 30 ++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
index a4db9fa5c8..6c1b5bb9cd 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -102,3 +102,10 @@ for details).
 	`git branch --edit-description`. Branch description is
 	automatically added to the `format-patch` cover letter or
 	`request-pull` summary.
+
+`branch.<name>.pruneMerged`::
+	If set to `false`, branch _<name>_ is exempt from
+	`git branch --prune-merged`.  Useful for a topic branch you
+	intend to develop further after an initial round has been
+	merged upstream.  Defaults to true.  Explicit deletion via
+	`git branch -d` is unaffected.
diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index f7942fcd7d..69878549fc 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -221,9 +221,10 @@ the upstream refs refreshed.
 +
 A branch is left alone if any of the following holds:
 its upstream no longer resolves locally; it is checked out in any
-worktree; or its push destination (`<branch>@{push}`) equals its
+worktree; its push destination (`<branch>@{push}`) equals its
 upstream (`<branch>@{upstream}`), so it cannot be distinguished
-from a freshly pulled trunk that just looks "fully merged".
+from a freshly pulled trunk that just looks "fully merged"; or
+`branch.<name>.pruneMerged` is set to `false`.
 +
 Branches refused by the "fully merged" safety check are listed as
 warnings and skipped; pass them to `git branch -D` explicitly if
diff --git a/builtin/branch.c b/builtin/branch.c
index 736480b002..e03805a8a7 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -878,7 +878,9 @@ static int prune_merged_branches(const struct string_list *upstreams,
 		struct branch *branch = branch_get(short_name);
 		const char *upstream, *push;
 		struct strbuf full = STRBUF_INIT;
+		struct strbuf key = STRBUF_INIT;
 		int skip;
+		int opt_out;
 
 		strbuf_addf(&full, "refs/heads/%s", short_name);
 		skip = !!branch_checked_out(full.buf);
@@ -893,6 +895,18 @@ static int prune_merged_branches(const struct string_list *upstreams,
 		if (!push || !strcmp(push, upstream))
 			continue;
 
+		strbuf_addf(&key, "branch.%s.prunemerged", short_name);
+		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
+		    !opt_out) {
+			if (!quiet)
+				fprintf(stderr,
+					_("Skipping '%s' (branch.%s.pruneMerged is false)\n"),
+					short_name, short_name);
+			strbuf_release(&key);
+			continue;
+		}
+		strbuf_release(&key);
+
 		strvec_push(&deletable, short_name);
 	}
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index beb86987ad..9e33179590 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1997,4 +1997,34 @@ test_expect_success '--prune-merged rejects positional arguments' '
 	test_grep "does not take positional arguments" err
 '
 
+test_expect_success '--prune-merged honours branch.<name>.pruneMerged=false' '
+	test_when_finished "rm -rf pm-optout" &&
+	git clone pm-upstream pm-optout &&
+	git -C pm-optout remote add fork ../pm-fork &&
+	test_config -C pm-optout remote.pushDefault fork &&
+	test_config -C pm-optout push.default current &&
+	git -C pm-optout branch one one-commit &&
+	git -C pm-optout branch --set-upstream-to=origin/next one &&
+	git -C pm-optout branch two two-commit &&
+	git -C pm-optout branch --set-upstream-to=origin/next two &&
+	test_config -C pm-optout branch.one.pruneMerged false &&
+
+	git -C pm-optout branch --prune-merged "origin/*" 2>err &&
+
+	git -C pm-optout rev-parse --verify refs/heads/one &&
+	test_must_fail git -C pm-optout rev-parse --verify refs/heads/two &&
+	test_grep "Skipping .one." err
+'
+
+test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
+	test_when_finished "rm -rf pm-optout-d" &&
+	git clone pm-upstream pm-optout-d &&
+	git -C pm-optout-d branch one one-commit &&
+	git -C pm-optout-d branch --set-upstream-to=origin/next one &&
+	test_config -C pm-optout-d branch.one.pruneMerged false &&
+
+	git -C pm-optout-d branch -d one &&
+	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
+'
+
 test_done
-- 
gitgitgadget

