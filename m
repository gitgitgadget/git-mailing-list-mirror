Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D54F332EC0
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766568673; cv=none; b=OKvrIHpKo4NSIwTbZ196O6dMxatGo/hPKOXhVMnC7ogme/1ru4lhhyXfOx6wgCLMFe0XKMBiP3Co1lCfsrlGDQCj80DWqaHY/U3dxmvuJzOzQH55eEondOrcA+91+5zY3CHTycHf9PFear4W9hcxA9ebFE5SPlYMBK5Wb40DbNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766568673; c=relaxed/simple;
	bh=olXSpMFt9hAOLB3xsCFG60EeHYKe6/5tDFJKC4AYkK4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BS62QjdfKSnjMr1D1axMTQ2KKSfvfSdFEsLtoElFWbgWozcOqReRvnuhF+p4bqKFP1g4NcMvkZClanpXuKqLGz3Fw0XweXd0CaDZu/Ihnh+S/bftOuzSULsBaFGOU9GpHBPNWEUHZxwXaCgfx7M/jfaI/tagfieUPfGUe1IYRrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ewlcyrzb; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ewlcyrzb"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so4640415a12.0
        for <git@vger.kernel.org>; Wed, 24 Dec 2025 01:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766568670; x=1767173470; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87FO33ycJoRW4/p4RjOFV29Otf8eIYFHCwHjBiNEPBo=;
        b=EwlcyrzbB3J8RtnSUYqRRaAvqf9TxAE4+b7OEu1od0i+xcOUmyGsmQ395SSVYUR3+I
         qhDYW1e1DWcQ6Q2GPJ+e+ug1jU1IYg1NmRYF83BBeHOE1Txg0g4YQ/IBwW669zuzK3Wq
         rpzmHEbWm4YVQIpE9PXveIrNMOSUB7KSOUekcObpVE8LpJMcGtahKSWebL2oeo/Txi2/
         CaUNefFCv8jQUcgZPRAmI4DSl+JRz6nguqmYUVZ+1xI0Udig7AEXXhRRC9Fy9Ft0nFxd
         iS+/Ekl+TtBRUqLYyrNv6IS9PNfTuLze1rymwbknm9FHR7tLZsbhCDHgxq7WZPpBDxJy
         HpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766568670; x=1767173470;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=87FO33ycJoRW4/p4RjOFV29Otf8eIYFHCwHjBiNEPBo=;
        b=gG5atgzCPvKmvrxCG1lwVysVIFV4EdOn4VW10wz2aOetBnsTnYsyTqjcrTMFjvKEk2
         WEYV/ppEXfXx/7mEIKLgiWdB1GXFQu7D8dXjI45Wwgb55jT4PQO3N/k3mGfCy1a9fleD
         kb+6STV7nvUtMSZZ4xCCNbe+jZtRnJ7b09KHv1n/eAfzZj5rCDxU+TjoGcloz5m3gheY
         61ADHLlf+uvOlXFlq9AIhHJ0qHyRIvhk04xW+aU748XjGmyPBRLURO5PQGVSTc5EAzL6
         tLEjYHGiIu1IvJ8mYsAwu3O82C4Jxt8VYzFlpHsysQYKaoBlmxeh8BXBnj4ptjVupQs/
         6DBg==
X-Gm-Message-State: AOJu0YxrY52I/4uBo9kfcXIYbf/nt4lK4doqxCu4cizjbrKrFvq/516q
	XIzrMjTbZjAIgBZv85Q1Y3uqLAeQhnot2y3g6MHrEhue/pFdzqhxDgMy8NxWwyO4
X-Gm-Gg: AY/fxX413UuNQLHRQI9Zv1C/7W4EMYJHHS59zRuk50Qxjjuq3k172fZgdsxtjspQcC5
	HsMyq6jwfDYgHxHE71l6/6qDM0X/hhpGlRIokE79IZ2LoARQgW1h7zYn2SQmVG0J7n3Do1g+9zf
	PCcYatYXAkLP9QCIaJUbpcQQOQcHCf9umef2YeH7Pkgdl9/7zA9isPtbLinN4q8S7WiWYt+WZ5Z
	U8Pf/qaTLOTsvgPxjgn8pngDLC0DxFeYUu48WP6r7ZYTaysfPKD9Ml9p5f/f8j1dX8cvv8pkiEz
	deuu73R3SnnsU6FNjgIs6FH6YLS6P4/f19ZIAdFO6w7q4n0SLc/fbbGGciljo4EaLADX+9buzOK
	WF7m2hM88VDjysscp6JYuKiVYJKW+d4XLV2ynxxRCn7RuMQJk86kjPCVC+XJFPf36+Vr+rGe3ev
	wafgC3S+MrqCJV
X-Google-Smtp-Source: AGHT+IFHitpmU6uOPswDdZ9V3L8O2w/RnuLK6BjMOzslp2hW7r0pYwj7out4nFG94z/mmzWIdcwLkA==
X-Received: by 2002:a05:7022:2093:b0:11b:b064:f606 with SMTP id a92af1059eb24-121722f5f71mr14166479c88.26.1766568669985;
        Wed, 24 Dec 2025 01:31:09 -0800 (PST)
Received: from [127.0.0.1] ([68.220.57.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfd95sm64269265c88.1.2025.12.24.01.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 01:31:09 -0800 (PST)
Message-Id: <417f2075fb876cbf5a00cd9877fb867ceddf7f6d.1766568665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v3.git.git.1766568665.gitgitgadget@gmail.com>
References: <pull.2138.v2.git.git.1766530448.gitgitgadget@gmail.com>
	<pull.2138.v3.git.git.1766568665.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Dec 2025 09:31:04 +0000
Subject: [PATCH v3 2/3] Simplify default branch comparison logic
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

