Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A83B299949
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 18:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767984044; cv=none; b=p6r86wxGHUjaiFO0JnlstbaDeBq+VAOdSLQNjWGIR0iqveLzqNgtqCBuCgkDcVsSq2cN5oYMWPWCHJ3m7oRPYz0KkRp502d/s9lB7HXpkmXixxZr2Q0veHrMgraJxm0hp7UUHPxmGTgoxg512lR0w0SHuWzApFrgGLZPu28BH6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767984044; c=relaxed/simple;
	bh=8ryG2hFTyaLbyxcrgm9DfGeWDedWFEIl+F1HlPsbvF4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PSc7oR2DyyIoaibJcoUTGYneZXxdwK6dc3HgqMR2NnpogdRubQJxUnSklX5nkTJJYFokjZyvbFWe+DOVcGpTj4ow6UQ1nC8PPXKcheNf2ORv1RL127trzs8+Rex4fRGzEmp3EESUZBEaVt+Az9n7rIss0RKnoedEfDWTGHI0vEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvOzdRPr; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvOzdRPr"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-88a34450f19so45060986d6.1
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 10:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767984039; x=1768588839; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZzSB9ePBcRXQOQ8QyW9ss1jeWshIwso8pIGq51d0mg=;
        b=GvOzdRPrH5QTalrZg8hqJ4EuguahJVE4pba7bGBv2boQArNdi2GBUdEnKpKEDHFIb3
         g/zZ4o9x6VLZGMfZ8SeHGtQPCL/uy2toXrGiburNWkt+vDIAdKyKOV9ET2XUsbwLyzWW
         pa6Bov9k+J3CNF1I8Q+SjSJmp5qauu4mynAvmfyDAIkni9AYslJieBJdCu9LRFXw5PSo
         0Bya+waVE3+CUoWDO0wF14BMBv0Slw8z3aZYQ24PI0OH4gPQZ1zdpoga4yqFL9o4Npr/
         qBfi0BQ26VZeUROKowye9bvtpCThiYC+T5+mV3jex9YqQPwcIXqnSEuO81RVcO4Up3Yo
         qFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767984039; x=1768588839;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qZzSB9ePBcRXQOQ8QyW9ss1jeWshIwso8pIGq51d0mg=;
        b=Qz0kBnnzEyqfxLhqKnmFoH3SbRhE3w8tcyegEmDuaWbqs9YOUhARLW1+Dqz1P22nFR
         AGUvOcRNUtufUT/+UeR/2DfMJJUFIg2/3xGIGCk7HyI3os50RWmqT+VVFGHOo/gfxF5k
         EN5zmgwfLufiXxRLx7ayEyJsMv8TY9SIT7b6wYO9tIxCqBqRYMwM3rMYVMHIm+xrWtMY
         JdjvD97ayv3EE7o8WrqRWwx7hHJ2bYpsmBv+QlkkZVVbw/+iA+aHtY8SBixrWlSqhWFA
         Yxoai1roBaE4UB5WMtfTzDUUIDCikvZQmVwEi9IVXm9jeHjOViV1adhDnl0ypVeY3PVY
         fryw==
X-Gm-Message-State: AOJu0YwLzaEdxpsU33zQuwlGv7rg8kLEgsAE8Kybhru6X1FLzQoJBZxs
	0DrPJmQuel12HMSrEsZZ5wtBIvIjaTR8Ou24nhHMf1uhO+vnKj/D5dylA6B+Gw==
X-Gm-Gg: AY/fxX5wo7+JEZ1S+c42BhxWmKDwCk/lqWAjzpw8EU6RVb/MFhfNEgRWfYwFJa/2YPV
	ADI/tMC26PAZwR6s5xOV80ZEl7jfDH7GUSYEAlZ8+DcKHiqtSYT7NUdKSk5GyQBWL7H3CZPZbMO
	2s4Bct3cKXXS8jvOZZmGK07N0B44hWiEeOKhI3mENe5Qfx46jMUu9hrutAX3LEEEoxKA/mbCfC6
	eFny2HIoFIKZIevNjiSdqjlptbT18B/9h5FGnlyCX7Y7T0gujfC18DF1KS+pzCO3rZInkitOUwr
	0NNxfW2cuV6veU0IYJpeYlxWp0bp3t88YJDOuslE+UKhMZsenBpwhlZKulqwNdhWrziCa150Hpg
	f4npEO4aV1gCO4k4xPbn+zBid2RRRIilPefmdY8aroccyQz/P5LQd1PzpS23nPhW/aEwSc/uyL2
	tiIKsVRCLDVsxEhpXcZ6n3AGHp
X-Google-Smtp-Source: AGHT+IHim/U3bW5D96ScAwhRiNTxCTGeHsDyAQiOZ6CzrgB7crGjqiHaSMsS9mykVI6T6WO0zvfVsQ==
X-Received: by 2002:a05:6214:3bc8:b0:888:498e:5a3a with SMTP id 6a1803df08f44-890842b4819mr164629936d6.68.1767984039271;
        Fri, 09 Jan 2026 10:40:39 -0800 (PST)
Received: from [127.0.0.1] ([145.132.100.68])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077253305sm85280296d6.41.2026.01.09.10.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 10:40:38 -0800 (PST)
Message-Id: <451d7a498617fbcbeb08ee644cb621cbf6af0bd5.1767984037.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v19.git.git.1767984037.gitgitgadget@gmail.com>
References: <pull.2138.v18.git.git.1767976906.gitgitgadget@gmail.com>
	<pull.2138.v19.git.git.1767984037.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 18:40:36 +0000
Subject: [PATCH v19 1/2] refactor format_branch_comparison in preparation
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
index 59b3715120..eba013b6b4 100644
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
+		format_branch_comparison(sb, !sti, ours, theirs, base, abf, show_divergence_advice);
+	}
+
 	free(base);
 	return 1;
 }
-- 
gitgitgadget

