Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962CB3E5A3A
	for <git@vger.kernel.org>; Fri, 22 May 2026 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779449519; cv=none; b=WgibMs+C0xCuA8eN0R58dAJvdaaYqG5Ol4u5wlu6jtPgc4v8Bhy00rKGaAzni7mSHdGdIABuGpNpOHoupIOIh5cDT7pJ7UUAicoTdiIlNSTf2G7697yPxYKr6TY4qfVNuDf9STjHR6BYCvGpAjDPyl+u9SFDLNNe33p0gkif/xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779449519; c=relaxed/simple;
	bh=/H+QChWjoBbGKEUAX9+HVr+/Vnimv3RiFNJOMzo3Q+s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=V8xUB5RCwjZK3fUCA4+ueYIBl5hQiGt9GwfUmvPEGIlFw/hqW1LNATkiLPDKZzuOB5gVoeHXHUItmAfFcxbSK4Xz32Rnxm+mLXwjSS3dj8QyYHQ9sTkdouDw1RBhgyEBNGY8Y6IO+uvAw87LNGhpjoKnKewYLXI8+DdP3RDifKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXoj9O/l; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXoj9O/l"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9125d2a4d36so508911585a.3
        for <git@vger.kernel.org>; Fri, 22 May 2026 04:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779449507; x=1780054307; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvQrclGYxPLNDmiH4UEAW5A+ZkFP28GHjr1ri+7G7ro=;
        b=nXoj9O/lqO0bSLjRoxoa0KyQl5xoRqVLTEu+1FJvHWBL7172YKMy6miAeGtjq8I5Va
         H+HoaP13raWH+EGjEAIjjNXc+F5lbHeuCMWl2GwY3njPlT2mUhnx9S7yzY3bl/KlkO7v
         vDnU9jkD94vBDFCYBBgQ/1VAbAhr4BnENz/1Y+Pj2fFsJVtGPJjGzdOL24l9KHCIzZhb
         LgQM2S9Sp7kjKai3iDjkNnMS1DRhHY+L4Q2b/AmOTMdQomWZZO7D41YHRCcTW+r7+gZB
         cN/HufISysz6CmpAo2Jogt82+oruCBA09G1aQyfSqXcuJlmZm/9ywVNW2JIxgOyynTGD
         1UPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779449507; x=1780054307;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cvQrclGYxPLNDmiH4UEAW5A+ZkFP28GHjr1ri+7G7ro=;
        b=V5fD9OlruayEtiNBqI9sXjGiGJrMafvYHxxUm6/9Q7yxk3mxupBywmRPU9ferVtede
         5cqoO1FfIVI+aKtzFBSeHCBl5sbPSgLjuau7O45DxW5kQtKQ1seF5vRsvCit9ZS4UmBh
         t0OqjDtD/4Gq3HT88+K2Kegb80JeUPAHgBKSDXOG55vXj1EmKxmqjkyYc222Lv1eJU2S
         Bbns6HOJUNBaRWnRf31Jc3+Jwq0nQPGF1EIV/7yT8B5oN8bp+/FLhsnqS6VMz8pcnYoP
         eMUz1Jd5jgj1un1UtYs2kRjNTAxNWpy/C/gSkkdJROBUvMI9BQIFA9X7HLAel1zLc7y+
         nydw==
X-Gm-Message-State: AOJu0YwbrxAlb3S0fvG/HXBZYPCuoLnWP/GX7bxh2DzxI8VRhR1HMmpN
	pIdaa2VLkBvJb6tgtPJCZVH+D+7P9bhLUUj8g72/YNs/aAzgb8UELPBV0+b3z6CN
X-Gm-Gg: Acq92OHSX8qdfzBtkjMIjo5cwnKZFLZLAnR+WIMLNLxfaJcUuZA369FUCJUbyuBNt1u
	6IzrOdSB1t0l4Irhp4f4HMl1TvDGq/UqcjyZ/vC5QZXoNyRT3/LILbTOHnshJ8rdYlrmB2QAwq5
	xUVJzcTj3ofg94gxHyFgPDwB/rx2N7eLnFDZFpvCFMJvY+H4G/JrEj3pDyjT7BxkGefnUBTcOp7
	dBFkPnz31DOqAptV+1bIH6hui0ei7tmoyp+tuQpRO5je5KO+MTJ5fs/lW6BsFufQ6BW9KYNO26i
	NaZ+S5+Jei4XM51z9bDdXcJQC0FUl6ulheJDan4lM977i4VKeK9ALh1+Rl8FJ4o6T7Ubjzix52L
	afDZ/uiMNCwC19KsDJqOUcSbwormpmFRH2tPO5jZgs0tLpoD5RoTvyal02QLDEmSGs2VKqrUjIw
	AcWl0D1eEEa2Zu05URU04dkpHjXZ8gamtVhtA7
X-Received: by 2002:a05:620a:1a26:b0:90d:76fb:ca29 with SMTP id af79cd13be357-914b49dda10mr439986785a.52.1779449507178;
        Fri, 22 May 2026 04:31:47 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.47.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb9f199dsm91696785a.36.2026.05.22.04.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 04:31:46 -0700 (PDT)
Message-Id: <75b6d2366a3aa6e8eaa3d7e657265fa3afc6ad5b.1779449498.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com>
References: <pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com>
	<pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 11:31:37 +0000
Subject: [PATCH v11 5/6] branch: add branch.<name>.pruneMerged opt-out
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
index c521b5f4ca..1bd28c4e37 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -226,9 +226,10 @@ the upstream refs refreshed.
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
index 1569f29573..187d5d1563 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -875,7 +875,9 @@ static int prune_merged_branches(int argc, const char **argv, int quiet)
 		struct branch *branch = branch_get(short_name);
 		const char *upstream, *push;
 		struct strbuf full = STRBUF_INIT;
+		struct strbuf key = STRBUF_INIT;
 		int skip;
+		int opt_out;
 
 		strbuf_addf(&full, "refs/heads/%s", short_name);
 		skip = !!branch_checked_out(full.buf);
@@ -890,6 +892,18 @@ static int prune_merged_branches(int argc, const char **argv, int quiet)
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
index ad87946081..da7e174e09 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1990,4 +1990,34 @@ test_expect_success '--prune-merged requires at least one <branch>' '
 	test_grep "at least one <branch>" err
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

