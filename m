Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7141D59B4F
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 02:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707185381; cv=none; b=F+QvAO3dbMXSqB3hqnrlzOiIedzwZ43FgMW7g+lWTRrVB6SGv738wLGleBIhOga9M3P5+Si3JSLH4oyRMi1t1UljSJWT9qWUKAUMCmDG2vuVX1+L0Gg+hC6BHP9SaZph1aep7kJ1mTznZhgXJofe+mEbhtaxMIX0xRaR+9iiXUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707185381; c=relaxed/simple;
	bh=G4jFFry/sMdArCitMtx+StoyXZV+P7Ssfadj+vZiNwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+rwddYXuCDiQAJZYvYxQGgHOVi1n5Du8wc7cZxFSZpWsa4YTMpabXaO9iZuB6STckvYpN5BnZh2MmghdBWUbxFpVXsDNih6GosqP29FjIqrdOnSfbwjojNgNU9MoBdGhPfz62CC3YAXvBouO8tVuchtQRghxUtVk//mg4lWfFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwkshHFz; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwkshHFz"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e02597a0afso2007232b3a.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 18:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707185380; x=1707790180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oHnza+QGWzvqfOr+ub1rgbb9vJWfTCjbT/c1rVKw9o=;
        b=NwkshHFzlFPAB3z8+oG7cQGuh6n5BkSpb1U8GHG7/ej4ul17TSeugMdMfBunr3geGE
         rgsv+Ph5MUunANEiY00Q7fHuZp4MmK7I4YKUgrqTOtXYcnHMuYj3ZM6XZd//nP1BcrKr
         M3YrmpN7Z4WlbMVsmnmgWDSg9fRVm5nPtriJKDUX1MzavPjWQLgESVZigQUtUV8R/vMX
         O2KF8v6oCbibxoFHe+B77uXmSgZLPIPspFBpUkWW88gTxp0h8DSHaSqPB0hR2y5sirwH
         kLhXF9B0ka8ZBc+zC8b2gAoN9XOPRUMrV8SB4vEJclrU7crnChMRv0wkCN3Cl1H3wbtM
         f6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707185380; x=1707790180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oHnza+QGWzvqfOr+ub1rgbb9vJWfTCjbT/c1rVKw9o=;
        b=aSrTzJmgbRKTbYW7nppCTBEDR2Ipxl/BF7v9MHuTyfOx8neDYFzn5YqMKKUh9s9lJL
         RDN4jkB6d9XYhZpwOVS6cNLC0Wy9o8qBRHgnc/ZHQ2DyfgiBZ6/BW8Qx9egMq9E9ZlnO
         Eh8O95AmRal6N9M3srkFpfj2AHYkX3nkTzds4ujEzSUdK6mYzrOvYe7gHmXc0uOjDNZY
         CXpP1mEtgRBxZysmvb51eQcQJb+Hy16nE77cCmQ4zJIBso6qAYcHdhQ+7u34vOWvWhu/
         dGYUeKpZU+rxNMNTpS7du/MoamTUadcypFPa5T9jOw7RLEVwp5Rj8Y1utfRCdiCBquRk
         aIyQ==
X-Gm-Message-State: AOJu0Ywke6Z1lf39faNL7sxR0aKThCvSJabRTJCugCnC64JNP57BWNA2
	cQdNIyHvTla5VYDbix//IeGzjnKFCK7cnHFoMfY3pWFbd9PNiX8m
X-Google-Smtp-Source: AGHT+IGbAm9OctBDduORy8PrwadMg4iZx9Rw+WfgY2pfXXAxjANGXhzz2FIwHcFzWdE6/qdcWBxeXA==
X-Received: by 2002:a05:6a20:4329:b0:19c:acfe:5fe6 with SMTP id h41-20020a056a20432900b0019cacfe5fe6mr380337pzk.21.1707185379784;
        Mon, 05 Feb 2024 18:09:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWpoCyvdncIiTw4xGMwyyuUmKS2yvZ00rP9+nRRE2OM6XtCnLMcPMIKsDWE60SKyCw64SBK5XaRFT13lBI/vBCT7dObOuJZBpJSzddoiZ2AOETN
Received: from brittons-large-Vivobook ([2600:380:4635:872e:d8c9:9f5d:4e33:1b6a])
        by smtp.gmail.com with ESMTPSA id s9-20020a056a00194900b006e044e376adsm581182pfk.166.2024.02.05.18.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 18:09:37 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 80C75520298; Mon,  5 Feb 2024 17:09:31 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v5 5/7] completion: new function __git_complete_log_opts
Date: Mon,  5 Feb 2024 17:09:28 -0900
Message-ID: <20240206020930.312164-6-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206020930.312164-1-britton.kerin@gmail.com>
References: <20240128223447.342493-1-britton.kerin@gmail.com>
 <20240206020930.312164-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The options accepted by git-log are also accepted by at least one other
command (git-bisect).  Factor the common option completion code into
a new function and use it from _git_log.

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 57c6e09968..8c3b1b8e96 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2089,10 +2089,12 @@ __git_diff_merges_opts="off none on first-parent 1 separate m combined c dense-c
 __git_log_pretty_formats="oneline short medium full fuller reference email raw format: tformat: mboxrd"
 __git_log_date_formats="relative iso8601 iso8601-strict rfc2822 short local default human raw unix auto: format:"
 
-_git_log ()
+# Complete porcelain (i.e. not git-rev-list) options and at least some
+# option arguments accepted by git-log.  Note that this same set of options
+# are also accepted by some other git commands besides git-log.
+__git_complete_log_opts ()
 {
-	__git_has_doubledash && return
-	__git_find_repo_path
+        COMPREPLY=""
 
 	local merge=""
 	if [ -f "$__git_repo_path/MERGE_HEAD" ]; then
@@ -2186,6 +2188,16 @@ _git_log ()
 		return
 		;;
 	esac
+}
+
+_git_log ()
+{
+	__git_has_doubledash && return
+	__git_find_repo_path
+
+	__git_complete_log_opts
+	[ -z "$COMPREPLY" ] || return
+
 	__git_complete_revlist
 }
 
-- 
2.43.0

