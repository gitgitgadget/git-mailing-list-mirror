Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447BB298CB7
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 23:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766619684; cv=none; b=kVHwjQJdMSlziQfdciyHtCEVYwZr+irfiNLSRJY4m70PMGxmWtJ49N7bBzaF4/HibDzDRgip++CUR7e/guYPnv89/zp+izVxtcWBTcBbSD0FmKih10vB/EUa9AmrxryrdVGeqlRHNr6oYmYP/y1Lb6wFnPoKN/6qkp81dIfvFcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766619684; c=relaxed/simple;
	bh=olXSpMFt9hAOLB3xsCFG60EeHYKe6/5tDFJKC4AYkK4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HV5VjCrEm0STOM0funC4skQ08g8P8MOnkkcua/jBjR7xTeMewNG8T8hOkTT7YVRFKWX9oMpVvriRbvfwJ8ZQaq8GR6AFs4nG0vCx+adeHl8O2gWxNjpy//MTF20fWt+6ziO/3VpgNQlYTUeeh+wM/1K6l9aP5l7sSCapMH/w6hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JR6oH/Ph; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JR6oH/Ph"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b22b1d3e7fso614304785a.3
        for <git@vger.kernel.org>; Wed, 24 Dec 2025 15:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766619681; x=1767224481; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87FO33ycJoRW4/p4RjOFV29Otf8eIYFHCwHjBiNEPBo=;
        b=JR6oH/PhsUhUme1GpSI9ICy39UOIUNsML4xQudRdZ3DnBQ7BUhGoXZduAJeCNgLH88
         wonTK07KQXoLf2xVpFdsLgkrEL4/MK4rrtPlCKM/e93bLsB+3eYM1KiKwp1JAR1VOmko
         3zJBqqn4es9+0ZIP/hnRwW7fdbjpgQlXn56odN3z6lS3gT6os0cWOzYwRZmIU1j698Iy
         GWaiD304Bh5oQLpZildQmgvomFxeGKUBoOCgT9NJ4nx6XGLEz3R4TXUz9B4zjoyEaZAd
         QhtYAV7cxQeMyZurAiJXHG7kaAwFddANPGTH2yFnmd6bpCyTwPyVLHRSa2h146uStq+E
         tUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766619681; x=1767224481;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=87FO33ycJoRW4/p4RjOFV29Otf8eIYFHCwHjBiNEPBo=;
        b=Wh/0d+gyt2wwG1Ygvw2sZ98FFnnSAXnh9CEsZi0DFUsEEndNMTfOAii0xscujlduAc
         MTXpwiImtfXjODrDc3rbLkS86quHjMcKrY7IjTH4NxBLrKo7ghhEqyy9OeO1ceavxK2/
         psvjiiVlZBGGx70AWQrboFETEQ+YamNe1rzj7lqmKMtEZZbGT+4ehCznwIOX0ijDWhgq
         iKzq5k+xSUD4Qq/2b3DORScHxqrjuKLEn2kcHXE1vTCmXRgOBcQr8GEt4kGeDssmFnFm
         p44BrkqlSDBvzH/3Y9iqUyayC07YE44yuBGpyKuojFyptq41y3HNt10GtEbIYY8nMu+0
         0pTw==
X-Gm-Message-State: AOJu0Yy91fOxBBjxGnYHjn3MfFR5s5kStpcUr1hTSs7u/zGxeOPDIrWK
	FcUvvfOVghl/su4SHgQS6+4OyEjF14oLwhLBAzhFfAU7Xp8Axi5qO+fk/sQbCA==
X-Gm-Gg: AY/fxX6UXI5rcCeccSSTsFFVqR49d4LZ6K6YNksl5jdkWG4cMHl+fVE0IE8oCFINSQD
	2w4/4RJ2NgLGoKepjO0lJi0uO08MrrUu+zkmHz1QUlwEdkOkTp26OIBNiuH9IDTqiJm5XHIvAvn
	smIVpJt0Ae/H0QErKin4UX/L8P9FKeV5eqLfv7VZYbLVAm+/xPRAwuNSSERbW8kvJpuYiIOQoDf
	ly/slRxEWFl3CAWbOh2m6l5hHoFRtapKv2DitXHkRuEDDvNAfdYHaFzap22leHoqs57HH7C/b93
	1yGdN/DvP7LI4MEUEBbHH8vMS7QA9TmZOJt6XcuYHH0IL1I56+RLdS4EaUhUd7DPAXDPAbs+rHP
	JchgHormb9jQVvqOk1xlxLHb4FADSu3vUxTcWndcimSr/FBWUTlMqhdsg6XKAVLq3BEU4ysf2di
	ZqcVzqXtcPZ82oCQ==
X-Google-Smtp-Source: AGHT+IHmFbymPfXFLAUhKHsRFNdwLrS+QAZUsBWUgOWJ9RiAvF8uZYixl43WKMMwb7IcYkY6N5nNhw==
X-Received: by 2002:a05:620a:444d:b0:8b2:33f5:fa49 with SMTP id af79cd13be357-8c08f6586camr2818109585a.14.1766619680785;
        Wed, 24 Dec 2025 15:41:20 -0800 (PST)
Received: from [127.0.0.1] ([64.236.135.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0968935b5sm1397139985a.19.2025.12.24.15.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 15:41:19 -0800 (PST)
Message-Id: <417f2075fb876cbf5a00cd9877fb867ceddf7f6d.1766619672.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v6.git.git.1766619672.gitgitgadget@gmail.com>
References: <pull.2138.v5.git.git.1766572715.gitgitgadget@gmail.com>
	<pull.2138.v6.git.git.1766619672.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Dec 2025 23:41:08 +0000
Subject: [PATCH v6 2/6] Simplify default branch comparison logic
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

