Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52743FE22
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709907277; cv=none; b=NDkpLnO6s6meftm0vwHUNNJRDbyzfj/tkdO/sZP7TAXCUShu2XMSHj4moVhl3s91DSUwZYSLNfYgnL85MibOkVeyR+BhPshrEPPJHA9c8mWFLPpRoJGk3ieMitJTa+ydLbtZep18t2Xln5rHzApB0dKjIndUluOia18/3UaklGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709907277; c=relaxed/simple;
	bh=lc1c2r7Q/Bkn7lW9a+G1YNYIlzgAmtV/zp22qGVEG/M=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=g3P+ZMaAZj/719IQVYsgYtxaN7qZFWJ6WdXseWZ87oCc2zhuCR/Vg//H98UJjXTyMQaXEJPGaZIr0b8gAr1GEcDqtAEPXrqSlY3HI+Aa6xIWbgKuAbGuq/FKDTegG9CZY1ZDs6ln3untuo9LALqlvdrNMtEyLHPZ/NAJsvwoQyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBGCEu+u; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBGCEu+u"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4130ff11782so6369435e9.2
        for <git@vger.kernel.org>; Fri, 08 Mar 2024 06:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709907272; x=1710512072; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5aJUaGJH5A51169aETUrWdf0IHIrzsjkj4k8uK3oWc=;
        b=gBGCEu+uQjJvUwdyiOUtF984m4GSKNNlH5LWzAXcbUr55xG59f4ZsyNWkTDodWuIAS
         Ct4YhAjM9TG9x3xsfY7YI1VoVUEX2jngpEyjKnNHCloC1dZSjtlUAQR8by7Qn70R8pYn
         Uhk5be/Iv4TivMrWOJzwir1hIcx5akub7bm34FXJMuwM4gnbe6PSnG79gUOu6UJjmkfY
         Oh8ncbi6Q5126VL9BI+ye8uIwzxWKWjsNOLZ0Ay/uepla57f1tyG7jPvkbY//rcdecOS
         qh2TIf1K3a0mHG2qAbH7H09QOJb7gdEQ86bOXa+h5CMNC3GZGpWWlLLfM6Wfy2LzHVzC
         BEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709907272; x=1710512072;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5aJUaGJH5A51169aETUrWdf0IHIrzsjkj4k8uK3oWc=;
        b=HlTf0f5eS0NqiU6Pck4Y9A8/XAfinJPdCY4Qp9EjGeJzuJQxqjo2wPLtxh6Bvu7T/c
         /MY9Am5BrTuY/CkQsQXT7tOAcfoX31azt/h+4+7n6w1Dog6tTpJ6MucJjP4y1sXr678f
         d7/trJALMlIX4bJtsUZ27Ur53IEWsOLa9lM561mh9F73D0NWw3nzINKyoU1CiO2eAti5
         rlIiksvyWqoWDXYoK0TsLW60f0Och5bnraVLP6cPG9f9ELwVBPdKHVPALVoZITDv8ELd
         n4aLvsXjcnig/oLCmPXA9WUU+nVON6sb7wCQVjXG8nOiHbE1N7U8FILlx9eS+RJaNv/b
         517w==
X-Gm-Message-State: AOJu0YwLifh7h7JKEplvJ+fjoSrjQpMzO/ariVA2E5dQAfyi8mPZXjeK
	rlkUdQiJnv9iiZYyfEF6uPHyZeOYhDEqkC+vM6x0mcW1tsaaB9tGWMOhcWN9
X-Google-Smtp-Source: AGHT+IGuD0x740SAFX+af2dynPSjRlvUvKD1OHQew3TfkzpWigdgPjH15Bd6zuTL9RtkhdEzby+4Kg==
X-Received: by 2002:a05:600c:310e:b0:413:1375:871b with SMTP id g14-20020a05600c310e00b004131375871bmr3000357wmo.26.1709907272580;
        Fri, 08 Mar 2024 06:14:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bv28-20020a0560001f1c00b0033d70dd0e04sm23377282wrb.8.2024.03.08.06.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 06:14:32 -0800 (PST)
Message-ID: <0263d001634bd29970390be96a1df9b2251ef10c.1709907270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Mar 2024 14:14:27 +0000
Subject: [PATCH 1/4] xdiff-interface: refactor parsing of merge.conflictstyle
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Factor out the code that parses of conflict style name so it can be
reused in a later commit that wants to parse the name given on the
command line.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff-interface.c | 29 ++++++++++++++++++-----------
 xdiff-interface.h |  1 +
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index 3162f517434..daee3c584e1 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -305,6 +305,22 @@ int xdiff_compare_lines(const char *l1, long s1,
 	return xdl_recmatch(l1, s1, l2, s2, flags);
 }
 
+int parse_conflict_style(const char *value)
+{
+	if (!strcmp(value, "diff3"))
+		return XDL_MERGE_DIFF3;
+	else if (!strcmp(value, "zdiff3"))
+		return XDL_MERGE_ZEALOUS_DIFF3;
+	else if (!strcmp(value, "merge"))
+		return 0;
+	/*
+	 * Please update _git_checkout() in git-completion.bash when
+	 * you add new merge config
+	 */
+	else
+		return -1;
+}
+
 int git_xmerge_style = -1;
 
 int git_xmerge_config(const char *var, const char *value,
@@ -313,17 +329,8 @@ int git_xmerge_config(const char *var, const char *value,
 	if (!strcmp(var, "merge.conflictstyle")) {
 		if (!value)
 			return config_error_nonbool(var);
-		if (!strcmp(value, "diff3"))
-			git_xmerge_style = XDL_MERGE_DIFF3;
-		else if (!strcmp(value, "zdiff3"))
-			git_xmerge_style = XDL_MERGE_ZEALOUS_DIFF3;
-		else if (!strcmp(value, "merge"))
-			git_xmerge_style = 0;
-		/*
-		 * Please update _git_checkout() in
-		 * git-completion.bash when you add new merge config
-		 */
-		else
+		git_xmerge_style = parse_conflict_style(value);
+		if (git_xmerge_style == -1)
 			return error(_("unknown style '%s' given for '%s'"),
 				     value, var);
 		return 0;
diff --git a/xdiff-interface.h b/xdiff-interface.h
index e6f80df0462..c569b7c5203 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -51,6 +51,7 @@ int buffer_is_binary(const char *ptr, unsigned long size);
 void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line, int cflags);
 void xdiff_clear_find_func(xdemitconf_t *xecfg);
 struct config_context;
+int parse_conflict_style(const char *value);
 int git_xmerge_config(const char *var, const char *value,
 		      const struct config_context *ctx, void *cb);
 extern int git_xmerge_style;
-- 
gitgitgadget

