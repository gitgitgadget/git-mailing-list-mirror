Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9B93195FD
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 21:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772056271; cv=none; b=Ybhvo6aRUlSztEz5TAU55bDy1I1Hz4YkQf61oo4CdKAIgmV9dDUTR1+QtYqX1EMtaplpFiVGx9zdCLEQDDd11bW88ZgWTrNZG82K5w0LdozXLFRcIv+D9SoJlC4XU2gY7L2OuyrktuxpsSMAdiHCb10W7I03AkcCOagzjNlnmz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772056271; c=relaxed/simple;
	bh=HGCIbfbRQfA16pZXuS9KJhKZ6nQvAjZqK3Hmbk4RxZU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Sof7IVYkRSYFHX/889cJ78n11DaVLbcG8IBCWgBDhN6lqrOC5XQtGwi0lTm0diUire0qbW06aALTYX8Aecw4m1ZTZ3SA9U5LihZbosjrvGWiKotCvgG+VVZzxmxKL7GSAb7teQfFbLW5HCY5D+720o1qsYiiuUGXFgz7/Fhnk0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJJnc717; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJJnc717"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899b2b6ab42so2252806d6.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 13:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772056266; x=1772661066; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJzyRLXLPvCJ2nqoPKedMe78GJdKzW2icxs2oH53vEo=;
        b=XJJnc717LJDe6sVqVJpoEQ/vzwLDxtG9+DDH6CNC5T9IFbEhZnwCdGxRdHQgsF4GU9
         RcgejpO87rrjGK/q+iO9hkoG9WG2sOE7ReI6viyFrHiLRi/X7LxSZnqhBq0d7dnibMXf
         9PF61Z3TATV3uA02FXLMycrnrf+UVwJVsWPf8IFumFYWXAtFK6NGkajZ/Ac6NI0XpRuX
         XucF+lw6LGS/rphfujeblyI80aU62cPvn7Bmth+/minkE6s/TXb/JCQPp38uRQKEFvtl
         ERWfjVgwXOjflLZdGNnhFGyjPokTY0IsQA5TpWujQ/f/2ivz3yu74ECkZC/uh489ikBB
         wjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772056266; x=1772661066;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UJzyRLXLPvCJ2nqoPKedMe78GJdKzW2icxs2oH53vEo=;
        b=kbW6vAVSOMMooiApzbYdLnSqwu7Dsfy+s+OIFNVc+klLbOZfReuCBYQYW94cHNwNmU
         VsAudhl6dXJL63vU41eLAoZXAD1dE+Kle4ktXK+sxgV7EVm+5T/+2tIKogt1DzXW7poE
         3OZVFIBrUiZlsyemgioeExdiBK34SxTJcUhXFMjXBUHxtAAG5G+kdmViU68cIgQ3Sr7Y
         0bGuCWi6yVAcnsDlSnKs/RvV73VMWe/HkuIh+WumN3qDgbCtljVz1K1Nst02edy5M/eM
         FEf6+yvyTaYL/96NvY4If78tmgvuED4pkzZtLQO8sa2Cvd8C2GZRunn5HSi05IiWarJr
         m55g==
X-Gm-Message-State: AOJu0Yy1w9UgyuqWuUktWSoGVJc2t+SL44kc+EkqIQA8t/BJ+QZIt+E+
	raFAfzBKqrGLhbKhHXQMqldg0KaOa/hCCQUyGBXssft0DNcsSGf8F03G/F3pSg==
X-Gm-Gg: ATEYQzxBjmWE8GQNxxZxYZvqAvgNbhM7dSwAYhKNCZVu8GMywrfTXGyEQhV29L3LHxw
	JyBr2Sa1RdGtclUYd7OBSgQYoPeo/OZQzhnyPEsK3KZlUSfvXvahKWcQvk/DUDHs8+eyoisS6zN
	i0Yu7Sojd6hz+jnN5jJhgUd9/8OSOD0etLVEPsVgBNU8e1KbghqoOuBnNOLG1vMY0ppRXviQcdx
	kHf+HdELeerveTt+eC7CAUHgz/GVjAhYxhPWyKU+0PLoXwOBUZM/1LmFxLjNwQsW7JyDhy7QSJK
	kIemefS6qKOMJqk/WjKxApyCANxqS3OmMu/424Sc+mDv/PCsWzEM8gXhkbGaVvbALgoJ/HvkhfQ
	FyyNNHho9NExyqZLfNVPBpqOf7gi4lf40fp4RpAGBiWeDioRtMmKvIYpAikf55AGwsPlw9ZvtjT
	ulx9QUu0XE7887lXU107sC+hX25g==
X-Received: by 2002:ad4:5e8e:0:b0:88a:57db:8e04 with SMTP id 6a1803df08f44-89979c39ae0mr248045516d6.8.1772056266345;
        Wed, 25 Feb 2026 13:51:06 -0800 (PST)
Received: from [127.0.0.1] ([135.232.201.80])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c716c53dsm1554886d6.13.2026.02.25.13.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 13:51:05 -0800 (PST)
Message-Id: <48db1f4847dde9e6ac387fc5b7f24c9465ef5528.1772056263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v29.git.git.1772056263.gitgitgadget@gmail.com>
References: <pull.2138.v28.git.git.1769112471.gitgitgadget@gmail.com>
	<pull.2138.v29.git.git.1772056263.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Feb 2026 21:51:02 +0000
Subject: [PATCH v29 1/2] refactor format_branch_comparison in preparation
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
index f6980dc656..e9e2f56ed6 100644
--- a/remote.c
+++ b/remote.c
@@ -2234,42 +2234,21 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
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
@@ -2278,7 +2257,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			Q_("Your branch is ahead of '%s' by %d commit.\n",
 			   "Your branch is ahead of '%s' by %d commits.\n",
 			   ours),
-			base, ours);
+			branch_name, ours);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
@@ -2289,7 +2268,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			   "Your branch is behind '%s' by %d commits, "
 			       "and can be fast-forwarded.\n",
 			   theirs),
-			base, theirs);
+			branch_name, theirs);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
@@ -2302,12 +2281,47 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
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

