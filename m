Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F7640A92E
	for <git@vger.kernel.org>; Sat, 15 Aug 2026 07:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786777295; cv=none; b=MXvLNbWAw5QLxEsz8GPFhg1deaBFdfJdGN2OPkup4TnaE73SqaZy4Pbhaom/aJVepwUAncH/BN2jrtD6UyAn5YTzdeD6eeXfrw1D3GYPlJdczLMIUW20ZTPgmc7pFiSZjvVXBOgE70RxOPNRYCnxjtKZlqFjKUPsNEuNFantsko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786777295; c=relaxed/simple;
	bh=wfhzD755enGK5guv6MKmFag5AsNbVX4m1I1wrA92BnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEjNUyc1q1CR35xIwXB2fMrZDATUqaCaR3wKVOwHUws9WZcf8bkeGZqWLKwooRsmPjMbmdKYk9oP34CGrPd6li6KaoZIntdnBao3MSmmeACZG4cpkyfCuT+pFf2L7PsC66+P40DuStJuLpaNxcQeK1PPx9LYjFWQTgXFVporoRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ack//QRN; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ack//QRN"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so1546121a91.0
        for <git@vger.kernel.org>; Sat, 15 Aug 2026 00:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786777292; x=1787382092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Up0rE7Q4qQy1EOQRcbu5kGdbHcDEfJgVGFXPUeKEPM=;
        b=ack//QRNAvU2K6bD1L5wP+Kp6AtTFTDu7XkI5fpusJkp36hNj7sgmczGJAKqgOIixO
         CQZb7+q21yohdN+Xy777gskFnLplHfJuUNKD4PXqoLwvGglDy3JiXPMYb2BQFKV5P8Ii
         YhTrOny2CXPbjO7AJmGDkd3CiYy0WvVqnxEKtm7/TrsVQc7oqzYkSdXM3btynAehI6Os
         q/p5Z3+7lHj6jZnnTrBseC1jSrvw1fv3v4bmN+P0Os23dGYU5LiSHDQAT3rOB+RIx7Bc
         SCnleNQbPqo6g1HAhXyKQjboW5jq6QBXup9Uz46oAiECbH2MNr9nNUrwmbav9sw1l5hL
         5xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786777292; x=1787382092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Up0rE7Q4qQy1EOQRcbu5kGdbHcDEfJgVGFXPUeKEPM=;
        b=M0ifKdyRULYLsRURwXigxZI8LvGvx9Entyq44AzoYcz3s08CTvlHVdU0ih0Hy/7a7X
         OdqVUqgmnjdt/r6nEdtJ5qNqBW66nLW8DhCWsquapCmMWu/vOrgV8QJKGPxRTEcv7LCL
         KX5pMYpUOjHyaXsduoMjXfr8PUOnXt/LCXyjFiIBSUwDtEj6c5b6tbgmDZmH+/JrthwC
         KwIgfmJ3jTCT//DSk2Bfrr0t6NoHEf0okvZvbL7VPVigHE2nJ6pT/s4vWzSyXzMb95Yr
         9jV2J/hSLWH9n8WO2AP7oiyAtv21l+KakM/a5YP/usAfxDaTzU+Tu9idibfnTlmSBgk+
         qhvg==
X-Gm-Message-State: AOJu0YxxttIbvkKJsvJTR1c5rPdcC5UJWefiyMLGEEgOUVpuKBgYc0ft
	N4TVl7mr2LmAkecvfjaFsjfgTZgvuoB2yQdTdke453JV/KTPZF0cqMS8G4w6Bg==
X-Gm-Gg: AR+sD10+TBrFxWK+7LEVc8kA6nMbtgyNj2HNZofZAO3OndqAkWBUYfX+rxUs2BvdNAC
	yg0mqEbGIs5M0eW3h1Rs1mwLuzbmURZv98+4gWQTSKAefJcYt4leEx11NKQLlVNG/VeM8n8ST6l
	UulMdW/FoebiXwQEvt4QOry7oU51ODr4kcCcvF2N4r0zSkYXpf4kA2P7tdF0x898q6DPTqcatiY
	UXhnxt/UZD+ssUNb96N07N05daqtW9HI62Rgf9JrY0axvpL+dxuND87Wg2ytn2wY+l8jNo3L4in
	egOQVSQeKULvPoFRA0wJtQLT2iGzrSDu+oeVNxfNQak6gD0hi+1EvWwtQdG+VUWIDgHEetyulE6
	MLuL7o7QqzMF+zheGZ8dfSC7KBsf2zjNtwe+6K76wheKbgH8AvwS4HCkvrkbsDQRMgCWcJ2PSuf
	BCozZS9KF4X0OggwmcNPm8aCHnHsaNBWTAi2yK7N7M+G8kI3oTyKtEFwtbFKnY6qAstUntTXdBY
	oq65SSUQD7lMn8tpnD0uiSshyNQTw==
X-Received: by 2002:a17:90b:2d92:b0:36b:77b9:5c8c with SMTP id 98e67ed59e1d1-3933babae61mr13390334a91.17.1786777292009;
        Sat, 15 Aug 2026 00:01:32 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:313a:bee1:6c01:e931:89fc:1f80])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea2fe8f1sm12455193eec.23.2026.08.15.00.01.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 15 Aug 2026 00:01:31 -0700 (PDT)
From: tilak-raaz <raaztilak07@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ben.knoble@gmail.com,
	tilak-raaz <raaztilak07@gmail.com>
Subject: [PATCH v3] submodule: warn on valueless active config
Date: Sat, 15 Aug 2026 12:30:04 +0530
Message-ID: <20260815070004.17538-1-raaztilak07@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <MESSAGE_ID_FROM_JUNIOS_LAST_EMAIL>
References: <MESSAGE_ID_FROM_JUNIOS_LAST_EMAIL>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The config parser previously threw a hard error if 'submodule.active'
was provided without a value, causing commands to abort.

Swap repo_config_get_string_multi() to repo_config_get_value_multi()
to parse valueless keys safely. Use the standard config_error_nonbool()
helper to emit a warning to the user rather than crashing.

This resolves a NEEDSWORK comment in submodule.c.

Signed-off-by: tilak-raaz <raaztilak07@gmail.com>
---
Junio, thank you for the review and guidance on the terminology and tense.
Regarding causing the command to fail on a malformed config: I investigated returning an error code here, but is_tree_submodule_active() is evaluated as a boolean predicate by its callers (for example, if (!is_tree_submodule_active(...))). Since -1 is truthy in C, returning -1 would cause callers to treat the broken submodule as active.
To avoid changing the existing caller semantics or introducing process termination from this helper, I kept the continue behavior so the malformed entry is skipped after being reported with config_error_nonbool(), while valid entries continue to be processed.
Please let me know if you would prefer a different error-propagation approach.
Changes in v3:
-Updated the commit message to use present tense.
-Updated the commit message to use "valueless true".
-Fixed the whitespace and indentation in the t7400 test script.

 submodule.c                | 12 ++++++------
 t/t7400-submodule-basic.sh | 11 +++++++++++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/submodule.c b/submodule.c
index 5c92575888..07d1fc63e9 100644
--- a/submodule.c
+++ b/submodule.c
@@ -231,11 +231,7 @@ int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
 /*
  * Determine if a submodule has been initialized at a given 'path'
  */
-/*
- * NEEDSWORK: Emit a warning if submodule.active exists, but is valueless,
- * ie, the config looks like: "[submodule] active\n".
- * Since that is an invalid pathspec, we should inform the user.
- */
+
 int is_tree_submodule_active(struct repository *repo,
 			     const struct object_id *treeish_name,
 			     const char *path)
@@ -261,12 +257,16 @@ int is_tree_submodule_active(struct repository *repo,
 	free(key);
 
 	/* submodule.active is set */
-	if (!repo_config_get_string_multi(repo, "submodule.active", &sl)) {
+	if (!repo_config_get_value_multi(repo, "submodule.active", &sl)) {
 		struct pathspec ps;
 		struct strvec args = STRVEC_INIT;
 		const struct string_list_item *item;
 
 		for_each_string_list_item(item, sl) {
+			 if (!item->string) {
+				config_error_nonbool("submodule.active");
+				continue;
+			}
 			strvec_push(&args, item->string);
 		}
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index eefdecb0bd..62b2537174 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1549,4 +1549,15 @@ test_expect_success 'submodule add fails when name is reused' '
 	)
 '
 
+
+test_expect_success 'warn on valueless submodule.active' '
+	test_when_finished "rm -rf empty-active" &&
+	git init empty-active &&
+	test_commit -C empty-active initial &&
+	git -c protocol.file.allow=always -C empty-active submodule add ../empty-active sub &&
+	git -C empty-active config --unset submodule.sub.active &&
+	printf "[submodule]\n\tactive\n" >>empty-active/.git/config &&
+	git -C empty-active submodule status 2>err &&
+	grep "missing value for .submodule.active." err
+'
 test_done
-- 
2.50.1 (Apple Git-155)

