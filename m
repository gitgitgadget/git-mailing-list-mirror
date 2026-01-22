Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFA92F90C4
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096248; cv=none; b=oNtjDRHYn7cneqgN/H7VRH7k3RpXEcTbwNUeKVAwA7qLos38TVUk/McE0nzrMxWQdaITQN8UNby5SWyK5ml+3UdJDjG0GwjzuWBei7Uwznz7TwCJTz2YG8D3aOkDNMsIIR0lr+Zj3X/EyHGw+iF0FZpZjj8qM0K9Nx862VkCf9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096248; c=relaxed/simple;
	bh=hvaFgUfinjZIgeJ3QHsxahSWfHO8GXT5K0VY9CQ/M+A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HJUx8q9c9vGErhoe4P/4fxk84CW1WzzJ5PzF7Pe7nS+c7FVZGC2RJAqvnN456l3tjKt4oKbjqHOjBybQFdYNMVKh22LT6iSCBwc+D6CF3gCRBNetGWvCcuOC1KUTF5zAAcDnJyn+IWatiCI0WCoMgXeR1o9OVTNK9DFQxQtd1HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qt+LAR3a; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qt+LAR3a"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1233702afd3so1708185c88.0
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 07:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769096244; x=1769701044; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4r8h+bI4iflLCMRaiiguOyi2Omzn95RD919H6vq9AA=;
        b=Qt+LAR3a+02Fzv71v4ZhJYZk80Qqf/qgnp3IIsIP25Mi93srNbTz/wr3rLgC08vyOL
         HtooIqqhBvSYdwApXMAbQhreWhaJm3a3ajZIUwYyIG1BWZsPSiBT+DJualQnkMcXjcpP
         66rvm5AW4GwmOiUoIPPavrWeyn3rVAGAR0NO2MBaeilzSCPQm8QDuAknKuRhnxnIpABD
         UGw60uxBACY+0TmUa8HciTQI2aWyOO8+WMviuaY5F6e3PsiFtgkU0vueYi6boCQY94Ij
         RC7/m6IvgNc56QMxu+tRQpsmuOGsZ2SLFZ1biw87Hmv0ewGxaNjFgbAgmEvvJDnxtOGn
         P2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769096244; x=1769701044;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p4r8h+bI4iflLCMRaiiguOyi2Omzn95RD919H6vq9AA=;
        b=wNWJYishNvAYh7k4b4fgCm7QtJmJ43dPiooSyHYDwED5ws+huZNrlTV8IDw/ghX4MZ
         /TtKYkEHs/fsTIsHyZpjF+EBjjTb3y5YjWEnNpjrYKCDOPwvyYI3Bp70nzsVoFHJn1FA
         dwNCXzhfYpnaCsIMCx0oVc0mjnHEqZvQZwylqkCmsIuu1z9LKCLiOMeaWGerY5hXFobx
         bYFgGR4habF8dgtvRlqwMqBGJbcc22n5kPky3d+1reLK3YGeIISIEaXgRxq9bQxtbkI9
         6K+otFsF+Hg3T6/jcKjE5hXVmEOeNIa9UtGFlvHgJ1sP8jHbJT2L2L9eajgaYZdpo/F4
         oY3Q==
X-Gm-Message-State: AOJu0YwghWn9j3GWe/FACaymyHiOOaSQc3E/mXIeAzyK3gR7JRnshn6S
	4GbpTAn73LAwUn+QK22vxWqktZzKSXlqZ/40RIQggKxQhY5gltOJekpo8zdANA==
X-Gm-Gg: AZuq6aITLhiFonMPkV59ZUQVmThWfkU88OkKBoX12vsEAMCcMuj0Y8OCLH5fNritGff
	hSQItrFs9EmDudMSqkx/PJJvRPgbUODH2EKjVbK2ygn1ABNv5oRFHwoMVENLD8y5RKorg64pGQ5
	YewxkcoaO+SqKRPuene5HoK9PDg5Na6ixx79D9kmoAgOKPXR0kL5ZStzE8YxRyz5oISKbwP5PuJ
	1AWdsoXUhdX+q0s6q1LhRG43lHqcD1MTtAu7BxgwYdDxhMTrCurpSGLwg1Zhc6x5ICQWr2NtH6h
	JGmc5lRk182KPVlLd21cXzioPF+bPIi7D0Yk+aSqGAodIi8qi6Z0kNzcAfGEZJfwSlZhvqev9gz
	CbQszC53sOdMYcdASNTzWbl7iEwZTKnDUyZrfKf/8a/JWNHrH/a7NGh1P4j64+gyBLj9VDzY4lu
	ZkH3pZ3gomY1olhv8=
X-Received: by 2002:a05:7022:406:b0:119:e55a:9be4 with SMTP id a92af1059eb24-1246a8e0b37mr7143450c88.0.1769096244033;
        Thu, 22 Jan 2026 07:37:24 -0800 (PST)
Received: from [127.0.0.1] ([172.215.217.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm28858872eec.32.2026.01.22.07.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 07:37:23 -0800 (PST)
Message-Id: <27a46f8d9cf41674ff2eb5b60ce772a39d43ca3b.1769096240.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v27.git.git.1769096240.gitgitgadget@gmail.com>
References: <pull.2138.v26.git.git.1768766353.gitgitgadget@gmail.com>
	<pull.2138.v27.git.git.1769096240.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Jan 2026 15:37:19 +0000
Subject: [PATCH v27 1/2] refactor format_branch_comparison in preparation
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
index b756ff6f15..fd592ec659 100644
--- a/remote.c
+++ b/remote.c
@@ -2230,42 +2230,21 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
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
@@ -2274,7 +2253,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			Q_("Your branch is ahead of '%s' by %d commit.\n",
 			   "Your branch is ahead of '%s' by %d commits.\n",
 			   ours),
-			base, ours);
+			branch_name, ours);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
@@ -2285,7 +2264,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			   "Your branch is behind '%s' by %d commits, "
 			       "and can be fast-forwarded.\n",
 			   theirs),
-			base, theirs);
+			branch_name, theirs);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
@@ -2298,12 +2277,47 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
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

