Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027B51C698
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 21:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707256258; cv=none; b=UiLqtXLRkM8e1jFwKRnApWggLsIdBi+ppR53Yaml9BDhYwLt376oUARQr4jeOHJc5JBWbRfGRpWDm1NqOHYe53RmNRzuW94FzDcbSjSIBWfBtDfR8cT5cAe/Cyx0tIBWmElVdwxAg3v8yXyZZZUwMkQGqBNeJ6ujixXVmopraDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707256258; c=relaxed/simple;
	bh=C6Di1lxD0cNG4i/FG+kzPB+50qUKs5oQLy340iS58Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6kCUbl53q2peA8fdR+bEz7QjvWwZSqqtkP/MGqd6t8zpgHlHQtMJmG6dmS/WRRyD5WRp/K4NHRsMvS9MJUmsulsIeGiUNI3GNtO0YJM7HnsuIKmV1ODLdak9cn1AQSVpyYmoeMWKvjnHtXyVP5ahBxbU7Eu/fhYbRxEHm3iU04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qs/hboRN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qs/hboRN"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d74045c463so49074755ad.3
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 13:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707256256; x=1707861056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLMn5ENvg++13o1FnzYaS7/8vOgeTyzlkzJy6LHATSA=;
        b=Qs/hboRNzlo/svXpF5Mtl2CUaefBrOEgcTKFsf/Ivi2vfIabKPGxpUpn3IH+EM1m1M
         KF2oq2VQRs/K9Erbcx35A9U6lcjOzcmrIjbEKOUYnACTBPw4dfgkxW/zgWlmuYgifEZ6
         RYR9GxLQrj3whZkQGDrEqLHpLqfmOmjWRAUtzVlzx/cmvdMEqFep1jUBLO3yIHeuSnkH
         UcOx+c8iG1Oh1RIwoAAwsrAlNMOaS1Ofu4i0wYAHBU3o8pbyzbKcVwOljzCNCnGbxF1w
         Y3sSyq86VWqvBBHPBglrTKPodMGXVtEN6nl13/8LR2VeWfciwAgO/Tv8I0TpXkE2mOPH
         d2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707256256; x=1707861056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLMn5ENvg++13o1FnzYaS7/8vOgeTyzlkzJy6LHATSA=;
        b=pfneed8yp0ts3ZCT22jfDZ6m97Ns6fO6Wj2YtVISJZJngkI86Egkzmp9CMJ2vbP0Ri
         hqbeKdDGkBqjYTJUcmehN/fQNKD2ko0IIA/qIhqZYIuZgB7bsh09bHJm33ECFLGgcPut
         ehZSVIv5TT1CoaNZ9yct5T8YVNQSyZcronw166OQFpLM9GqDuuR6cgYav8oIvIIG+Q3u
         UcYrkUSzO48tglR1sMDoK4lNzhVXTUeeBWNkwnaSg3/8f0whYKug1EoBR6oqrQYO18Sx
         KjbkwGM3BDp1ON5CHBsLcD9mcIrSS0OUU6T3nYYx89DnM+XfUdTQyZCMpXzDYUDkB6DN
         rNjw==
X-Gm-Message-State: AOJu0YzY6IIY8HI0uOL6xZF7SxN8+29HX1+kejIwuSeEHHvxCN3GL9kn
	t7Zzu73GfQqAopdc2wxEcLVanhf1qvnq6mZMtFA28KcH7nQKBRYs
X-Google-Smtp-Source: AGHT+IEAoJpFjNadPNiqVW20UH1J3+ZlI9G+U4D5bqt6Yuzsx/+gYgCNTYaeK7SMmoiCK6glI6S33g==
X-Received: by 2002:a17:902:ce81:b0:1d9:6c08:39bd with SMTP id f1-20020a170902ce8100b001d96c0839bdmr3520580plg.28.1707256256394;
        Tue, 06 Feb 2024 13:50:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWhhrF14aOdNN2AHG7yJgZx2F/4KpLaLFtJ4PZpdsHdiP5153nvG+NFM0CMGSbF5TNaQRlcduYXV0i2gQfDyBSbLeqwBL5qqCHSRpKeQoNBfFPE
Received: from brittons-large-Vivobook ([209.112.166.194])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902ce9100b001d7915fc630sm2366664plg.307.2024.02.06.13.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 13:50:54 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 4E84A5202A4; Tue,  6 Feb 2024 12:50:50 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v6 5/7] completion: new function __git_complete_log_opts
Date: Tue,  6 Feb 2024 12:50:46 -0900
Message-ID: <20240206215048.488344-6-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206215048.488344-1-britton.kerin@gmail.com>
References: <20240206020930.312164-1-britton.kerin@gmail.com>
 <20240206215048.488344-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The options accepted by git-log are also accepted by at least one other
command (git-bisect).  Factor the common option completion code into a
new function and use it from _git_log.  The new function leaves
COMPREPLY empty if no option candidates are found, so that callers can
safely check it to determine if completion for other arguments should be
attempted.

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 57c6e09968..b9ebd5e409 100644
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
+	COMPREPLY=()
 
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
+        [ ${#COMPREPLY[@]} -eq 0 ] || return
+
 	__git_complete_revlist
 }
 
-- 
2.43.0

