Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F5630EF76
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 22:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766530457; cv=none; b=Or3b09ZBL0HFfksgLgswBcfKf28jMdAYys3A16nawdiUsvYQ1CL20lXuKNuaZwqYFxsKYziSgaw1BnSTAGO3b9Q82su8KyNlbNP1R7ffF/N6TGYqh0fkthu3n6s6N80Rovm+/bpnCOurLH2aZssdz7inoRfCfJ1I1Fa77z+yz28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766530457; c=relaxed/simple;
	bh=olXSpMFt9hAOLB3xsCFG60EeHYKe6/5tDFJKC4AYkK4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GPkD0sQIMImc6AAMJ21recIMRLq8C0Za4kI3IVektwtfFSTU4bbp+dKmJ3Y9/70uzPzkIXYl9Cim8boOuvl2nAzkyp4TVdRG25mnykjFgUucmvZfobpUA61uxf7dF+8fe0XcUoXiziGq1NoYZ0VLSK2RsR6aNrLoQsymOwhTgYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOUpBkeD; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOUpBkeD"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso4450379b3a.0
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 14:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766530455; x=1767135255; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87FO33ycJoRW4/p4RjOFV29Otf8eIYFHCwHjBiNEPBo=;
        b=GOUpBkeD+7g07oyeJz15XBpJH38M50PjjkjUmD3CKkck++PQpT+XErbO5gN/7gQrZv
         Ah53Qj9bluvH5TokvI1emZM/pOtcdEMNRytWKvlCfckK63IKgOyHIpK1lJ9uWv2jTsrg
         j4VNrwaTvjOsk5EtAv+dcENREDgxKAJFCwMI6t2h7F5Ys777nQ8MUkKZhe7o2bqaehEL
         /6+ZS6sVBuykCXC4CXzC+1gwZkn/HNnqivnI27kWTv86VnevNHI7WMSveXaaG8tPtY9m
         HUt707tu0cuG8jj0zosEU2reOnIE7zqSHtvg6svrCttosBqE2+FdBBpMKUckecKtJVwa
         mAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766530455; x=1767135255;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=87FO33ycJoRW4/p4RjOFV29Otf8eIYFHCwHjBiNEPBo=;
        b=ioC7Ivde4teW1B6CljX+p052Czhi02/G0az2gUiB4tnSB7YWPAE5wWUgFCieoCJ1wc
         /yg86+uylF7ay0pQBAb1tmxppWpjNnx8AhGJ9oyT6IW3t9s51CDhDCkFAQoinDuHehqf
         by5QLDeS/qTjA9bt9XcK8DjEJ7vaJDlHXZGOQBhkTWklUObEWQvmQHm7TNYNgYwrKLtM
         T/bT+lqCwAN8RanJyuZpNgWYSa2kJ0EG+JtrEQ77TJIn4yW9g/vSVHxzTKe81gws/gMK
         t//3wHVN+RqTaZgaTfiRzB9AN60QQnbS+GnrdFygW6O7tQmk9qeJkB6letdBHAeKzIWZ
         KAOw==
X-Gm-Message-State: AOJu0Yx6D3qy33FkyZj+J/g1TJJDrYUrvTIQ6vBEsEanxAsonuopONU8
	7l1oaoWeuU9in8dB6BzxnAnhaquD8DyhChE7ASc4vG6a9MY/Hmb4XP84vNrPHT2F
X-Gm-Gg: AY/fxX7wm677QTOhfjfSxXlIHYXmBBZQtFJhRyCTFHlhzuTaSvODkVVgaeKfYult9vy
	TFm39Fpo1fQ6Ki98nzQGLWcCxQlQeGF//sS1WfUfcve+yY0WjSVOweYUox1GHE1SVUE/hHaIUAS
	QUU1Jd33JFzerSGWBFlLjOEDyDE+tq90Uq/7stQqj2OTME8TZGlLdx4XLOF/nwjWzuY5UdhWYfB
	EfIE9TQzsENWOUBSxX2Pr84f5eIiHBaJcYDvdaF3vj4cNrMTrjANHyAaWSJuO0mBA2u9cXuDtI7
	PQgdbHsZaGyG1bheXbAq87mgbHI0Ss78WH56RP83bh+g3/YZMx4YSl7gtHl2o22niT8bRfVaURX
	sqKheVImGZanx36ldx8bFcvRlFxsyoWpoQzdJ5hNrJqX4arPbG8x3rFRAagTarvOeAx+ReG8dSD
	RSKi0Qlf8Sz6gw
X-Google-Smtp-Source: AGHT+IG3JRbYo+/JiDgjgDOV70b0JM2+AAURywY2T9mDnK01X5ok6XAOLIkY/s/+4lGAMV+cLCLa/g==
X-Received: by 2002:a05:6a00:bb84:b0:7e8:4587:e8d0 with SMTP id d2e1a72fcca58-7ff66a6f5b3mr14732723b3a.67.1766530454513;
        Tue, 23 Dec 2025 14:54:14 -0800 (PST)
Received: from [127.0.0.1] ([52.160.166.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a93b441sm14523523b3a.9.2025.12.23.14.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 14:54:13 -0800 (PST)
Message-Id: <417f2075fb876cbf5a00cd9877fb867ceddf7f6d.1766530448.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v2.git.git.1766530448.gitgitgadget@gmail.com>
References: <pull.2138.git.git.1766451217075.gitgitgadget@gmail.com>
	<pull.2138.v2.git.git.1766530448.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Dec 2025 22:54:08 +0000
Subject: [PATCH v2 2/2] Simplify default branch comparison logic
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

This maintains the same functionality while reducing ref resolution calls
from multiple to one, and eliminating unnecessary memory allocations.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c | 59 ++++++++++++++++++--------------------------------------
 1 file changed, 19 insertions(+), 40 deletions(-)

diff --git a/remote.c b/remote.c
index b2a1e980b1..f3831ef3be 100644
--- a/remote.c
+++ b/remote.c
@@ -2267,41 +2267,17 @@ static char *get_default_remote_ref(char **full_ref_out)
 	return NULL;
 }
 
-static int is_default_remote_branch(const char *name)
-{
-	char *default_full = NULL;
-	char *default_short;
-	int result = 0;
-
-	default_short = get_default_remote_ref(&default_full);
-	if (!default_short)
-		return 0;
-
-	result = !strcmp(name, default_short);
-
-	free(default_short);
-	free(default_full);
-	return result;
-}
-
 static void format_default_branch_comparison(struct strbuf *sb,
 					     const char *branch_refname,
+					     const char *default_full,
+					     const char *default_short,
 					     enum ahead_behind_flags abf)
 {
 	int default_ours = 0, default_theirs = 0;
-	char *default_full = NULL;
-	char *default_short;
-
-	default_short = get_default_remote_ref(&default_full);
-	if (!default_short)
-		return;
 
 	if (stat_branch_pair(branch_refname, default_full,
-			     &default_ours, &default_theirs, abf) <= 0) {
-		free(default_short);
-		free(default_full);
+			     &default_ours, &default_theirs, abf) <= 0)
 		return;
-	}
 
 	strbuf_addstr(sb, "\n");
 
@@ -2324,9 +2300,6 @@ static void format_default_branch_comparison(struct strbuf *sb,
 			   default_ours + default_theirs),
 			default_short, default_ours + default_theirs);
 	}
-
-	free(default_short);
-	free(default_full);
 }
 
 /*
@@ -2340,7 +2313,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	const char *full_base;
 	char *base;
 	int upstream_is_gone = 0;
-	int show_default_branch_comparison;
+	char *default_full = NULL;
+	char *default_short = NULL;
 
 	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
 	if (sti < 0) {
@@ -2352,7 +2326,13 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
 					    full_base, 0);
 
-	show_default_branch_comparison = !is_default_remote_branch(base);
+	default_short = get_default_remote_ref(&default_full);
+	if (default_short && !strcmp(base, default_short)) {
+		free(default_short);
+		free(default_full);
+		default_short = NULL;
+		default_full = NULL;
+	}
 
 	if (upstream_is_gone) {
 		strbuf_addf(sb,
@@ -2365,8 +2345,6 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		strbuf_addf(sb,
 			_("Your branch is up to date with '%s'.\n"),
 			base);
-		if (show_default_branch_comparison)
-			format_default_branch_comparison(sb, branch->refname, abf);
 	} else if (abf == AHEAD_BEHIND_QUICK) {
 		strbuf_addf(sb,
 			    _("Your branch and '%s' refer to different commits.\n"),
@@ -2383,8 +2361,6 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
-		if (show_default_branch_comparison)
-			format_default_branch_comparison(sb, branch->refname, abf);
 	} else if (!ours) {
 		strbuf_addf(sb,
 			Q_("Your branch is behind '%s' by %d commit, "
@@ -2396,8 +2372,6 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
-		if (show_default_branch_comparison)
-			format_default_branch_comparison(sb, branch->refname, abf);
 	} else {
 		strbuf_addf(sb,
 			Q_("Your branch and '%s' have diverged,\n"
@@ -2412,10 +2386,15 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		    advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
-		if (show_default_branch_comparison)
-			format_default_branch_comparison(sb, branch->refname, abf);
 	}
+
+	if (default_short && !upstream_is_gone && sti >= 0 && abf != AHEAD_BEHIND_QUICK)
+		format_default_branch_comparison(sb, branch->refname, default_full,
+						 default_short, abf);
+
 	free(base);
+	free(default_short);
+	free(default_full);
 	return 1;
 }
 
-- 
gitgitgadget
