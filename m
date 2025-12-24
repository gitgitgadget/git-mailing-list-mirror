Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662AC25F98B
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 10:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766572723; cv=none; b=GQsL8C5muDDj1TmAqPYge0pyBDt0bmTO+d6Vj/B8kKWCLWjAKJyeX4L8ScpS2CYRBo9vNzDsDViypLn1JSC++sZS9CvbXuPgHzHs9xBWrWbfuDINuFCzrulcIBTpBMw0Lx9AL/Ag9Uf1H7q6XTZ+uF1W0O99czjBOE6RPz28uBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766572723; c=relaxed/simple;
	bh=olXSpMFt9hAOLB3xsCFG60EeHYKe6/5tDFJKC4AYkK4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XJ9mlMzQod1AttIDeUABQaPL9r6+AvyVXgs3lo71UqBVHy4JVji2Dyp56DlY6YY9c1dlji9ylWcAPfw2Q8sOjybu2VOovGVgW9bxJgYzjsTtu2qTT8tuYu3jQMJrp+BQOG2otpTpRyvGm89hv8ddQGFSJxZh782rRMvLkp+Uga0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqsPDA2q; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqsPDA2q"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8888a444300so62582886d6.1
        for <git@vger.kernel.org>; Wed, 24 Dec 2025 02:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766572720; x=1767177520; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87FO33ycJoRW4/p4RjOFV29Otf8eIYFHCwHjBiNEPBo=;
        b=kqsPDA2qRZG9PtsqnLxZj0P6T36PuknyfH5KB9ytAU6H1HxWXsLdlU3P+c6n4uQKiB
         M7z+n52uCpR4to52u6lk/bAC+HC4C2XkS6c6RNiNOBlka76ML9CZZw3m0rUCJgWcsG8N
         k+aB5g9NIQ6x9KddvWNsdHbHmvAkr6EKlp43HFW/DaeP5LJKfWNKYpTmoglkDzKqb0mW
         RfDyGUQ1N8aOSlVb0kBpP1goP8XJZO7Bq8Nm8N5TaS+niTpETO6SjHDKdfpdJYfIKLd6
         u8AzoS3thOJCmKm3QmbxMOFikHkfuwTWReQqF0+z9z7Y0vnTPPmpUZX/kT325czEAR/S
         hsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766572720; x=1767177520;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=87FO33ycJoRW4/p4RjOFV29Otf8eIYFHCwHjBiNEPBo=;
        b=m1C8xxYPhrHR4XCvRoZ8ossZMkWTG0HsizhZ9bD9otf0RT/ClG3Fzp2N/J/YOM0AYJ
         q5dDGFNm1VJxFt/YgQw73pcG2FxOZjom8ubWheHm1L0GXBmiz+y4L2pfNICgO4d0ZG/p
         PSx3rhnDvlZeOB23i7ltfFN+7bjebOKVpAZvMzJ0Y6QHxmxlIOBng36Sq3PEkyDeJzBl
         VPmxv2vDZisktZZxqTHKrmIQvbVhSmTkqFaRs5TGzrj/NYIWRwmVoGeCxAEQbknaSEAb
         DLeLthQrkM5kdqNwkugutYSdbAoiPstgGYcEKj0PWrLpXY51Gciuka71ryhvbyUIdslA
         KMvQ==
X-Gm-Message-State: AOJu0YyZRKzq9ZZgD3k1HYujAwSjtTRzaLtL0MHqRg8AB51krJNpJMFG
	J4w401yXoDXfFDfOp9C2P7F7jM/5GbxaL88PVPWzOstg9oelmKAnQNc5pRzDlbz7
X-Gm-Gg: AY/fxX6hh2dGLBLLTonStrX94Zo3HPHcNS4YIfJjV+EVLrw5wuL3vLI3/Nroq7HnA4h
	STROv3pvHXx7UWKbw/qpPH7B0U7OamjnocRdx8HvmlTtdwiJE27OomQskJbKMwhizkRpW79n3+V
	Nj7+IwvHz7JG6bbtUznur8+L6RN9tW9S73aRbA2rVAex4iEf32fU3VrxN+mTMsLG31kxFv4dgkO
	p27eVyyOOrjb+uCCgp2ixK6YB+dXiRqDU4K9dEBMNiWOjtdwPspIWtI3tPOAXV5XHY/Tl4+YtEy
	cUtdOjv81rWXaCV9otvNcK0/792TBDD1upL27GUCC3GVdTSznbTyJEjW+niw/a3ng8ZoZLHPsya
	Uk443+4FyeFQLRnXBeqEOGROvgx5wRC1XmRdL/opWcrFOWxnInnCw7O7i2gFfdIywvAYfc6JAfF
	QqUJ1ps1irTyNy
X-Google-Smtp-Source: AGHT+IE3iUgNlwOX6gSWsIwHXlltyTKZJ2+A8V3dmxVp4hCenUS+OsB9EWa3fOCI69YvixzeuGYQKg==
X-Received: by 2002:a05:6214:212f:b0:880:471f:2ecc with SMTP id 6a1803df08f44-88d82de8026mr299381116d6.29.1766572719677;
        Wed, 24 Dec 2025 02:38:39 -0800 (PST)
Received: from [127.0.0.1] ([64.236.153.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9aa363e3sm126125966d6.57.2025.12.24.02.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 02:38:39 -0800 (PST)
Message-Id: <417f2075fb876cbf5a00cd9877fb867ceddf7f6d.1766572715.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v5.git.git.1766572715.gitgitgadget@gmail.com>
References: <pull.2138.v4.git.git.1766571587.gitgitgadget@gmail.com>
	<pull.2138.v5.git.git.1766572715.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Dec 2025 10:38:32 +0000
Subject: [PATCH v5 2/5] Simplify default branch comparison logic
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

