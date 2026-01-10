Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94A222A817
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768058659; cv=none; b=Y7Z8ZkT5Qdfd0NADFR6r09UGIfz/A5mbCY3zh5ToOap1EhWEp3QEViyIszXYZUoDLJu2QBdPjFC9ybv8zvajqUnNKqWGqnhT8HwD4qyn7ZrjWuP3grurMe5U0pAGAzpuXBbGWbp4FplFo3Uu/EXoIZ+yKtoO1IxX3xiHdjjnpjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768058659; c=relaxed/simple;
	bh=mIbJONrwz8YHjyZ2bWHYW26398s9EBta0desorcZgWY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VIBPvpb0acgMuWyTG/RNqK4jzl5qdTEE3w5C/P+BjMrg9TnZuTZisbSxe6f8eb9yjS8xWMJP+IodsTVBDyM60Bf/QQ3zJyg9WhUQPziylrOHCjcyh/RorxQsKdxL6eVrFSlM2jbIMZSDxJhHNwIJqb82AvIyCYsNpAl8dhf4jHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEVoDsZu; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEVoDsZu"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12056277571so5912660c88.1
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 07:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768058656; x=1768663456; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8llGxGYlgyq3nZf6dIAEuBc5d86UA01o+Y2K8NFelKg=;
        b=FEVoDsZuSI1iAtIniZKmZhx1cFZuO0HJUt51Mwcg5Pzo7NBbrwce7+1yY3MiGBqBUG
         ynDvcOeKOIPCjYd6ir3LU9QZ8nB/QUpmu8eM3vD/YGcelrvc7HZkvBRGxCsdPJa5UsgI
         ESB2n3SP7PzL8TNIa5TnizU4xhOBP2rCkzXYZSupm2MH/j6TLaAwL9dmUDa5fchPr+8e
         8/ydTmu7kTylKn6bBrtc/H0Jk2jhqyFaIkKs480lKzEVwA+9Hdgc+ZEggMOLMYukil7N
         xXUARRGDUn8mzbGTEbtDQFjXlBFGSZrNDNPRzWYWTdr0u1FssWyO5WzpMqDSGsKB3qka
         9Slg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768058656; x=1768663456;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8llGxGYlgyq3nZf6dIAEuBc5d86UA01o+Y2K8NFelKg=;
        b=gkR+pHLLoo8j8Z8uTNMCw8O20+s6gDOOJLRSZLB48LxBL0Ey3dSFo/61G10x+9Wnrp
         5EQMv4KYlzNhbySt29XXa+lM9w1Cuc2y3NKYKVPdkl+ktWYVxzEASTbngZ4pTIC9Rkjs
         fsc1GCzele2uX+824o+JzHTNUL4rah2WoabEEjBfaQqUJHVTv7K59mabQdZz2PtneSR7
         FonjfgXxW9YvcNVwQI7vKffZLHZrOYlKZY5LquIiVZdHiuEM5Atjzzxdz9SDn7oO9D9S
         q5SJal4TI6MzeQm/BXDGkNVreb3+RgopDbYq02XoayjjfXceuDSdKg8KAGZg+fIRumr7
         q/DQ==
X-Gm-Message-State: AOJu0YwoktH7XTUuc4QGNZxTU4uxewRgLDdXfo5uC1IDzsFQE2qovEcc
	aujQobEx/2YYTbl/xT4BqFO4tMwd0E46+z8hk7qv4mVB1iYyLHQqYQnBbzvTVQ==
X-Gm-Gg: AY/fxX484haVTIikQ06JbAa+9e6csJgkMTfLgIeQVHk8Sz6Oorck8PFyPeyEL9jWY99
	2eWNF6uz+G4wMwMejAQPmA1l/eegDbuE1mT19kvvbRifjKA/YwWEAo1ULcXHhMlWnW2LEmZDTYL
	azfYdkOUv9+BB/vgnmIVsMLF6kfXNuashyrSmS7CoPPLpYxQ44J9ikhxUZHZhHZI81meQ5el6VB
	anLWQnBwBVeiR5vRTqwSr41F1EfugjvDhaCetb9kHEzNCjXf5VyfMhIMhNmONEzWZHglVucUIBg
	SUX5lhckYP/4wLVPjp2GZg22a+Gj+BOSR4aq2rlmH0EyzUyLkU8Bc2XV5J8ndpQaQmyNbLC9Uc3
	UC0Aa7BQnyalZXi+H9LRXmR2ybEHH5R9mrxIYpFFO2aKTVqsHnPdtYjGA+F7hFo1uHunXEz0/5f
	ZWCO/qa1JpyVCw
X-Google-Smtp-Source: AGHT+IHsUtnofLfHrnfqFDmEZR5vVL1/cyXwM672u+0FfUGGf1pXx7d+I33sW6I08f3TxY98MftBjg==
X-Received: by 2002:a05:7022:e12:b0:119:e56b:98b1 with SMTP id a92af1059eb24-121f8b7936emr13315910c88.24.1768058656300;
        Sat, 10 Jan 2026 07:24:16 -0800 (PST)
Received: from [127.0.0.1] ([68.220.58.243])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b170672ee3sm12827800eec.4.2026.01.10.07.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 07:24:15 -0800 (PST)
Message-Id: <ce1f1eebb5a9371baccbdbe5f1f2c3324d5f8d11.1768058653.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v21.git.git.1768058653.gitgitgadget@gmail.com>
References: <pull.2138.v20.git.git.1768051831.gitgitgadget@gmail.com>
	<pull.2138.v21.git.git.1768058653.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Jan 2026 15:24:12 +0000
Subject: [PATCH v21 1/2] refactor format_branch_comparison in preparation
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
 remote.c | 91 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 50 insertions(+), 41 deletions(-)

diff --git a/remote.c b/remote.c
index 59b3715120..af078817a4 100644
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
@@ -2292,25 +2271,55 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			   "Your branch is behind '%s' by %d commits, "
 			       "and can be fast-forwarded.\n",
 			   theirs),
-			base, theirs);
+			branch_name, theirs);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
 	} else {
 		strbuf_addf(sb,
-			Q_("Your branch and '%s' have diverged,\n"
-			       "and have %d and %d different commit each, "
-			       "respectively.\n",
-			   "Your branch and '%s' have diverged,\n"
-			       "and have %d and %d different commits each, "
-			       "respectively.\n",
-			   ours + theirs),
-			base, ours, theirs);
+			"Your branch and '%s' have diverged,\n"
+			       "and have %d and %d different commits each, respectively.\n",
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

