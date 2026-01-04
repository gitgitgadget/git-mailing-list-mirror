Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2AA2882A7
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767527641; cv=none; b=iSJEalDe548GJbdYS2lJ67u75RnI66moHscla8lz8iuMLNswegRsgycxEDJ9ITWwBRdiUbcXfQSak7oQxuo19HjvI6Q1x6qVDGfkhM5zsCHfMXhTwU/DD1hI8IO1YETNsqpb6Oydn684+i5Wje+vEPZumot9Yrh8m3CxwrvmmiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767527641; c=relaxed/simple;
	bh=0xb6GbH2ZnhWYInRD63Rq9pi16UzNFixFIy1Hfpd5cI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oa6fDFWse2koS0+mWONlt3rj/IaXGx0zk/3iPpc3WRVLaRuiaHiBqlk1Un/zAydtMqdUBnGcnEgzmjy5PMA/IU4sUtMWzHEmBoG1QykCeWs7q+hTVN3PBq5cGQJ+PeAPyVKM160c37ey31Wy6GxEEI1IpW9/su6Llf5xBIAvwcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORHj5LLd; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORHj5LLd"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88a2f2e5445so172542676d6.1
        for <git@vger.kernel.org>; Sun, 04 Jan 2026 03:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767527637; x=1768132437; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wxf4RNYBgkjP3iqG3fr+vZGJl96LsKv7Bf4WMkmBCA=;
        b=ORHj5LLd/iy7FsW+Z6ZSDLYMKJw1SKerFRJ24XCRa61DrcnnrK+4hgZ+Y1Jko+o/YO
         qFDGV5pnKKdkf+wgiTK9sB7ifIcdrAr2s4F292WW30B/kVFqh8i2j25RJAvHof9I2N6W
         grP/coPTHdlvPTeThWhsStb7ZNw8gVcIgLUKxbghYs3nWuy4fPymCG/Sr8mu3w8317le
         xipGrznITqE7kOKgATA7qWN43xATcK8McPtBefHq7KOvXZlMuDHFQq2IlzTuxXlipOdI
         a2NbIE1Fs1mvzYo4+4ed5xXvJ0AraPK1QDV/alsl8pCXX4gjKbHm+DiKrY62o/2WmmAk
         6ACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767527637; x=1768132437;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4wxf4RNYBgkjP3iqG3fr+vZGJl96LsKv7Bf4WMkmBCA=;
        b=hVJgCZjqOjwdSvLLT1kErTH/nkRZUo8YLjBS8J/f9wrO1GPWTNppPETR3MTaT9Wfeu
         UFpGLC5qhg2NFQTIULMCj2QTN3OMWMv/B31kRc7ymLc2ygNmqzNYh9cCEAtDIXYnk2V3
         hJO6SrjtYOPboduxlAXoImOTIwsMELKOFzzjGG6l7bcYLUU/GdyVsx6ZX+yzmH0gfG1X
         io9qtMffnzuGAXFT1jqFN4v8VCLGMknxfT8TImOBTQc3fE8kRD5t9cmXJS7exLD8oxFr
         8o5sQNT2uOKAOGfDHQtf0zCYo7TkKWHNpHVwjTcbuEKxpRZfcFSNC/Dg57NbvYUpExyG
         prdg==
X-Gm-Message-State: AOJu0Yxsgwg8+RLBbqJA8Hit+QdtsajlwPCvlrP+dE6GkkbKMPshhQHk
	LAsJGF+VwFGDtywbGgWnyMIRs2k8p/wT/defg6n3i/lShHlsVwi5wM7+/V5BZw==
X-Gm-Gg: AY/fxX5e1wSHSLFOk3zJ04+Pf97Mhq0zjsuU4Nbb7ChxFdqSDGszpkwj6PmNtp0Xk9A
	tpa0DK9nA6fMv59dgGcAu2G3vyj3rUIdehxl608VXUSuhpfFOhCFWvFwt/1B6lJ5yS8VyxpZbVF
	3utLPk6PsmYAB+v+8f/vEv8jTJUjFMIQzRul8fd9gnxlxvzpp//ehgTpEazUJcnMiLJGe0gh5x/
	qMZ+hM2TWqTI7S/S5Sd36gH63yUb88F5ETIfufG3p3yNkCwhu3zbNYyRzt1P8eFx2fKcqwjD8xV
	WUZdbdxzK5W7TS8IbWtMiqKYMzPUPHzU5INAPjhUgQyOxOkcwaqNGQKQzE/GZkQSqC+pfH9ifI3
	0M+vY+fMQbNY90Y4Rt5QWqDpAODC9BJl+GcngKyAjeUMw8h8saB9wxjCAEMA14B/TGhzJfLyNy0
	dXn2C5LyIgtsQ=
X-Google-Smtp-Source: AGHT+IHfN0Ay+vkcNU66U+fDBWbvj+VjK2h70MVPWTurt+Xji1ZdzCPxDFdtIFNJf/CW7VO9oLrWCQ==
X-Received: by 2002:a05:6214:485:b0:88a:41d9:23b0 with SMTP id 6a1803df08f44-88d8203c03dmr875926896d6.22.1767527636674;
        Sun, 04 Jan 2026 03:53:56 -0800 (PST)
Received: from [127.0.0.1] ([74.249.78.33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9a44c880sm331040236d6.46.2026.01.04.03.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 03:53:56 -0800 (PST)
Message-Id: <cf4e9779c5d47b22bd4a04fd9b2b138d5602145a.1767527634.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v15.git.git.1767527634.gitgitgadget@gmail.com>
References: <pull.2138.v14.git.git.1767445236.gitgitgadget@gmail.com>
	<pull.2138.v15.git.git.1767527634.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 04 Jan 2026 11:53:53 +0000
Subject: [PATCH v15 1/2] refactor format_branch_comparison in preparation
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
 remote.c | 85 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 36 deletions(-)

diff --git a/remote.c b/remote.c
index 59b3715120..b6a9e14376 100644
--- a/remote.c
+++ b/remote.c
@@ -2237,51 +2237,29 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
 }
 
-/*
- * Return true when there is anything to report, otherwise false.
- */
-int format_tracking_info(struct branch *branch, struct strbuf *sb,
-			 enum ahead_behind_flags abf,
-			 int show_divergence_advice)
+static void format_branch_comparison(struct strbuf *sb,
+				     int ours, int theirs,
+				     const char *branch_name,
+				     enum ahead_behind_flags abf,
+				     int show_divergence_advice)
 {
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
-		strbuf_addf(sb,
-			_("Your branch is up to date with '%s'.\n"),
-			base);
-	} else if (abf == AHEAD_BEHIND_QUICK) {
+	if (abf == AHEAD_BEHIND_QUICK) {
 		strbuf_addf(sb,
 			    _("Your branch and '%s' refer to different commits.\n"),
-			    base);
+			    branch_name);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
 				    "git status --ahead-behind");
+	} else if (!ours && !theirs) {
+		strbuf_addf(sb,
+			_("Your branch is up to date with '%s'.\n"),
+			branch_name);
 	} else if (!theirs) {
 		strbuf_addf(sb,
 			Q_("Your branch is ahead of '%s' by %d commit.\n",
 			   "Your branch is ahead of '%s' by %d commits.\n",
 			   ours),
-			base, ours);
+			branch_name, ours);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
@@ -2292,7 +2270,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			   "Your branch is behind '%s' by %d commits, "
 			       "and can be fast-forwarded.\n",
 			   theirs),
-			base, theirs);
+			branch_name, theirs);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
@@ -2305,12 +2283,47 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
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
+	int ours, theirs, sti;
+	const char *full_base;
+	char *base;
+	int upstream_is_gone = 0;
+
+	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
+	if (sti < 0) {
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
+		format_branch_comparison(sb, ours, theirs, base, abf, show_divergence_advice);
+	}
+
 	free(base);
 	return 1;
 }
-- 
gitgitgadget

