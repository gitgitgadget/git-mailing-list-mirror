Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F1F22B8B6
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074982; cv=none; b=Ez1mENvaYv0Rnk5lUygjFopl/Y5mBZHT6ECkmhIj0IHLOzSPWNlh3Bu1hIueisr3YnjVjb12gLxj1pUPMLJuVKRwQfzpCXKn1Q9pZ1Ns9EgORhQH4tsUB3x9kuaD2x6oMZT81a1k+kPvkwAoEwAP2NRuH0aK9IWjBuL/gWH4HiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074982; c=relaxed/simple;
	bh=dB1lOZXu7PI2sX18ZLUIXznr7i6XLr4XBpWzbURaioQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HVlEZ/wtM/f4luh5x7nhgYRg+TkUirG4oegRGjeXOtPjgx6rvPGIJDetc7bujimO3pcGVOkxW3cgcaT1j5G/eKH1h/wiwqeLNR//C7wYnCC/lmH2ECkIPQoTciqlsgwvy2BQm8uWuUeNeMjyE0nGkPBb6EOt4pFiowaLy3DKwJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzcgFLG+; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzcgFLG+"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ae53df0be7so8235231eec.1
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 11:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768074979; x=1768679779; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kA//qt5uFuRbfEIAEmNDsZh1aDkmFUKNGtIPxNydPcw=;
        b=HzcgFLG+u/35d+HI8kvtx6xZMuvyz27ZnKM3txf3ycOZj2Ikk0kstjJ01y+N+ewcwM
         lg11d4BXs8Mqk8ID1Te6ijRYuLX1YUBfeX3O98bJR8P451xDEcVzD1+vG1UwTpOOeRi2
         e1wwpDJgZoqoDI2ED14ouNBpvbV89kc2c9ecatF6tm9uA556mDWl04jDkJiakYjeONN2
         W8MNIPGW4druF7qvAFNmC/7b/fkRGIM+ctIuQsTXOk0UTvBd4lo2KeBaqdPZXOWBmp9K
         Ftn3ThUmEtLAIGJwD08ZEjEwtAM7PdQCJzMTi7CRTwBalNfcG47Si5X1ZMqwG/OKSREU
         Ivmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768074979; x=1768679779;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kA//qt5uFuRbfEIAEmNDsZh1aDkmFUKNGtIPxNydPcw=;
        b=rESiveCU50xWp/Y9tr813btOnQ5ZNX6uEoMtE7tDDPb39aYMf7sXIsXWJS4aNYDtyW
         f2BeJrgi9jM3xbP0zEGawGMdI0SvGOywhpH7Z0iGkUss8mkAxPWfIW7I4YDDVxn15vyA
         z8Dt0bJdK8+9RAveAYunj5CNCmsDUCAopb2NbfFGTP41XU1RSN0kcnYend2LONe9ZVPa
         WzstMgJhUswVlJfJLoX1+7wJIXv3VbF6wsyvkmw4thXj3hWE8sz6WZkqVKRL1iNjPuYW
         cZmgBJPXxJ17IFoBjkG3AlGsB6qtY1Gx6FFurw6zL1gCcf1tETUTa1TYCpr6fw6XvyiC
         lOGg==
X-Gm-Message-State: AOJu0Yx/FGlfBpB6TZx+ntSCrphScHS7DoNgnKcByL/iN1f4bgJRp1ej
	O/w5ZqC2IkJv0lJpiaL1A95eJn5YYUj5sGUYcn/ICUvj/l5W0Qrn8l+rHr6L4w==
X-Gm-Gg: AY/fxX5FMOEeADsn7fyfa4m1K3YTwCbDe75mCnwI6oXl3OZnlE1XXSIzl6h78fNvnWT
	R468HzNQjSGtM/s+CYACHvSVRtERG/lPzffYUzjshv6GQMcjCCkyN6VvUgbGeFQ7KHqButJe/Az
	b8A5crnGjEyo1eIz+TWubnsqA00vs/TNtfmPxum+tE5/NGxrFfy0y4zDBlhxDTmnx8EnI34EI1S
	BUTMHOUsSFzhe6BDfKdAMBmwOjDnBzkzGcX7nnsBYu2OsMloxsDHk5KS5qbospTD1LcIzBOCZ86
	IZ21gmvV2OoKfNepnLOSSMLJnV6W/9Cn0KJ1cmWAOw5ItVle+OgkoKLPmMKwaIA+dk57iqOoOoq
	Bc/q5BeDYph+iH95P38J+vokwmsAdg3mGk3+ipm8WtW1c+V4Bq1VXce4Lxej2AzvWWc28hbtVd0
	DHX5Xnjg66V+ZJuSDE4FiA75cjSA==
X-Google-Smtp-Source: AGHT+IEVh6K/Q2NzIqAzPbxS0CRNZT9FNELj0VlabINU+ydgVkk15MZYJJrVL7/8l2Qa/1BfsJJjNQ==
X-Received: by 2002:a05:7300:f806:b0:2a4:3593:6474 with SMTP id 5a478bee46e88-2b17d30fe63mr10963773eec.36.1768074979252;
        Sat, 10 Jan 2026 11:56:19 -0800 (PST)
Received: from [127.0.0.1] ([172.215.216.211])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b170673271sm12989491eec.3.2026.01.10.11.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 11:56:18 -0800 (PST)
Message-Id: <4aa4f1abc85540773b27b52ee273bd9359500e2f.1768074976.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v22.git.git.1768074976.gitgitgadget@gmail.com>
References: <pull.2138.v21.git.git.1768058653.gitgitgadget@gmail.com>
	<pull.2138.v22.git.git.1768074976.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Jan 2026 19:56:15 +0000
Subject: [PATCH v22 1/2] refactor format_branch_comparison in preparation
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

Refactor format_branch_comparison function in preparation for showing
comparison with push remote tracking branch.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c | 82 +++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 34 deletions(-)

diff --git a/remote.c b/remote.c
index 59b3715120..d5a6486026 100644
--- a/remote.c
+++ b/remote.c
@@ -2237,42 +2237,21 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
 }
 
-/*
- * Return true when there is anything to report, otherwise false.
- */
-int format_tracking_info(struct branch *branch, struct strbuf *sb,
-			 enum ahead_behind_flags abf,
-			 int show_divergence_advice)
-{
-	int ours, theirs, sti;
-	const char *full_base;
-	char *base;
-	int upstream_is_gone = 0;
-
-	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
-	if (sti < 0) {
-		if (!full_base)
-			return 0;
-		upstream_is_gone = 1;
-	}
-
-	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
-					    full_base, 0);
-	if (upstream_is_gone) {
-		strbuf_addf(sb,
-			_("Your branch is based on '%s', but the upstream is gone.\n"),
-			base);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
-			strbuf_addstr(sb,
-				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
-	} else if (!sti) {
+static void format_branch_comparison(struct strbuf *sb,
+				     bool up_to_date,
+				     int ours, int theirs,
+				     const char *branch_name,
+				     enum ahead_behind_flags abf,
+				     bool show_divergence_advice)
+{
+	if (up_to_date) {
 		strbuf_addf(sb,
 			_("Your branch is up to date with '%s'.\n"),
-			base);
+			branch_name);
 	} else if (abf == AHEAD_BEHIND_QUICK) {
 		strbuf_addf(sb,
 			    _("Your branch and '%s' refer to different commits.\n"),
-			    base);
+			    branch_name);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
 				    "git status --ahead-behind");
@@ -2281,7 +2260,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			Q_("Your branch is ahead of '%s' by %d commit.\n",
 			   "Your branch is ahead of '%s' by %d commits.\n",
 			   ours),
-			base, ours);
+			branch_name, ours);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
@@ -2292,7 +2271,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			   "Your branch is behind '%s' by %d commits, "
 			       "and can be fast-forwarded.\n",
 			   theirs),
-			base, theirs);
+			branch_name, theirs);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
@@ -2305,12 +2284,47 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			       "and have %d and %d different commits each, "
 			       "respectively.\n",
 			   ours + theirs),
-			base, ours, theirs);
+			branch_name, ours, theirs);
 		if (show_divergence_advice &&
 		    advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
 	}
+}
+
+/*
+ * Return true when there is anything to report, otherwise false.
+ */
+int format_tracking_info(struct branch *branch, struct strbuf *sb,
+			 enum ahead_behind_flags abf,
+			 int show_divergence_advice)
+{
+	int ours, theirs, cmp_fetch;
+	const char *full_base;
+	char *base;
+	int upstream_is_gone = 0;
+
+	cmp_fetch = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
+	if (cmp_fetch < 0) {
+		if (!full_base)
+			return 0;
+		upstream_is_gone = 1;
+	}
+
+	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
+					    full_base, 0);
+
+	if (upstream_is_gone) {
+		strbuf_addf(sb,
+			_("Your branch is based on '%s', but the upstream is gone.\n"),
+			base);
+		if (advice_enabled(ADVICE_STATUS_HINTS))
+			strbuf_addstr(sb,
+				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
+	} else {
+		format_branch_comparison(sb, !cmp_fetch, ours, theirs, base, abf, show_divergence_advice);
+	}
+
 	free(base);
 	return 1;
 }
-- 
gitgitgadget

