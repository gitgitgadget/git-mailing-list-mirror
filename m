Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B281D198E89
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727718039; cv=none; b=aa1Wa1fMbeKkITSp1ZIbCVudQzkb041E6AEwjh+P4geUCmUfSh/lDxFFeozFAjPvDylsqJDfGr74y1hpea4iMU4bA4s8XtidbuM0ko5SHPukH8vFmb1Qyt6wTBJymyPVs+/6qyiowMuR+vQ1mzDvR2wrB5vj4CQAE39vDauTrpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727718039; c=relaxed/simple;
	bh=TkH0Jy/C2wq7XC9ZiU8UMdsetPfOA8Hy8vKnd6emoX0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Yi+9zx1aa0Vahg38toeuQvoUUHxQcwKJIcGHi8LAffsgGWtREea/jxnp4l2bUMJ/AcKgy9kPvPXz1W1jmQ0LrULsaEv4sv40jINN78F3eWf5K9w6QXCg8WQh1eJz3S4uw895QcUmw0iaNDIZyXbk+vSe8uSgQZulhdKeu3+OJ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkL2cGk4; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkL2cGk4"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f75aaaade6so46547031fa.1
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 10:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727718034; x=1728322834; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1lMFnQXIkx6Fd9qYyPeN7DpuZ/qTyN07CquJF0snKg=;
        b=FkL2cGk4QXdHPsxm+pHg0RcimaT5vYA0I21A8M3UpT8JH3dDDEnpKORkQx3DBG7FcP
         /WIIdV2CstXp9OLKTMjgjBhJnjexIQTtfE9UpoOs8znHvP2+Hm4t9n5ZXPSRVPFNVRlz
         GPZDQq6Qa3BOSaYzhMsv/dusx2k6Mc5bsmDJQ3alk6M7hNBoRL6W4kExdt9l+AJyy1gV
         jmdtAirbfykrqlRVLKyTp/HZjIBsxjRcfFJ4ZFv8QG6jw2h+2dLY1XzR8GFSfynzIkN1
         aT5iUbRtOC9OaNoSOJmxDNCyYCQNNuQ85avO09dWQHMLLVCLIIE1vm11DyF1BeIui8SJ
         ENyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727718034; x=1728322834;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1lMFnQXIkx6Fd9qYyPeN7DpuZ/qTyN07CquJF0snKg=;
        b=Z9jQoP315791Wxi5P4QyL9NTOdjkJxI/oleTb83u7be8gzc7Mvvj1DDMknTxTMPcfV
         kynkkbEWmpkwelJVcSz9IHiSsQDUr93c/zXv+t9WD/8DfiwaInWbD6QT1ikZ8aH+Xvh5
         OFZDXCRb2lb1BbkrlMid0i5QAZwJlqVgxJY6+kqc3gmVE+SLRflRDNATxqugp2zHsHRc
         HN8N2ZDy0qi72QgP3R8oXzWARo6YfD8HdjPR+ei16811VlafI2M6o9zwwjk0jpcMV295
         ANd6tQMHCucG4UxWxNn1XKffeNr5w6gmN+brD4CqG7e8PryOtMCWstHGSVTABgBFSoBu
         LobQ==
X-Gm-Message-State: AOJu0YxQsf/lOso0D+0H9TjETzYTaqa+fqfOOlZIBD7OCI6DpdQ/QXtE
	wIFP6Xhgy/sxxt4rgGZcPZodBsUHYP+bgV7KFgT86KG+6t3Mvga1MZU9kg==
X-Google-Smtp-Source: AGHT+IE0fL54aLaHzrhyIGvzI1/h71ygtOXl/b4TVXWjiWwAUMvGwrL6TDTs4fwPICwUSbFZEoz+lA==
X-Received: by 2002:a2e:b895:0:b0:2f7:c76f:3c62 with SMTP id 38308e7fff4ca-2f9d3e56020mr69982891fa.24.1727718034000;
        Mon, 30 Sep 2024 10:40:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c882405ce6sm4800782a12.13.2024.09.30.10.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:40:33 -0700 (PDT)
Message-Id: <d64955a2e277da138146020f6a0cf96f4636a162.1727718031.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
	<pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 30 Sep 2024 17:40:29 +0000
Subject: [PATCH v2 3/4] apply: remove the_repository global variable
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
Cc: shejialuo <shejialuo@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Remove the_repository global variable in favor of the repository
argument that gets passed in through the builtin function.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/apply.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 84f1863d3ac..d0bafbec7e4 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "hash.h"
@@ -12,14 +11,14 @@ static const char * const apply_usage[] = {
 int cmd_apply(int argc,
 	      const char **argv,
 	      const char *prefix,
-	      struct repository *repo UNUSED)
+	      struct repository *repo)
 {
 	int force_apply = 0;
 	int options = 0;
 	int ret;
 	struct apply_state state;
 
-	if (init_apply_state(&state, the_repository, prefix))
+	if (init_apply_state(&state, repo, prefix))
 		exit(128);
 
 	/*
@@ -28,8 +27,8 @@ int cmd_apply(int argc,
 	 * is worth the effort.
 	 * cf. https://lore.kernel.org/git/xmqqcypfcmn4.fsf@gitster.g/
 	 */
-	if (!the_hash_algo)
-		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+	if (!repo->hash_algo)
+		repo_set_hash_algo(repo, GIT_HASH_SHA1);
 
 	argc = apply_parse_options(argc, argv,
 				   &state, &force_apply, &options,
-- 
gitgitgadget

