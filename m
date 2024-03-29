Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57B813AD1E
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 21:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711746169; cv=none; b=rW+YT+7scazb2SfXD4W2elE1Xns9LW/zbA7cgqFzBThcfGwmdai6/MpY+6i7oY+0HuaZcwZlQ/mxcL8S2Qg/OEDDZrX68NpCBrOJWcIV07Q3y5LllioDGh283wYWSGrUSHwkyh2dafGYsdkhS1itRzssZovgG8+Z+hu7BMDRmEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711746169; c=relaxed/simple;
	bh=UdRd3S6W7YmMrK3zHjrnxGI4yq1stIgV/y01qkGrsQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Td4cEegp+uKWa2Q9QadMfcHYsOPlpYu9WA4aLouvQS4jbAxojLsy0lHFBAsMIsOBrmuEzw051InIB+D4zXmvMWnFC4FYc22OOm8MQR//1zoVDFfnccboCws89M+uK/ROH4wWI+4ZResG0MW1ES0kkiwEaviV/32B4yctE5yJ00g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltEbz0nv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltEbz0nv"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e0d8403257so20189235ad.1
        for <git@vger.kernel.org>; Fri, 29 Mar 2024 14:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711746167; x=1712350967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpbMOhUAaZ+hPOmW8iuJsycHHT64y3dDlvvslRoStp8=;
        b=ltEbz0nvtHgZNnIg1ydgjhNqqge3eva4KFbsMZ6E0xQlfqJxk0sSohSb9b4NayjPWY
         rmTPVCaBC4J4rrJFENaRFE16Mlhm08Esqc/OsbfHtnyoOKdXQPIYgunEr/RkALjBYAr2
         PeFnj/mH1qXW9ioKQmnjN4FAwKS5NyABd5DPsJDvSJqUUrtMpCds++Kndl6NrulKc5f3
         uIEvBWspXa2cM/67Ep7Wg0d6lTQ/KfBqo/klXzhUne36rfWZQl6vSLb6iRGbXcp4/Y3r
         NTagT7BetjYGrIJfZBvz8xxx/p/CL8Sf0BzUVENJGrFO/JEjTjcaQwB6E661j5xBl3Ht
         m5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711746167; x=1712350967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpbMOhUAaZ+hPOmW8iuJsycHHT64y3dDlvvslRoStp8=;
        b=qd9Ovvwqmmu9GVxYZeC6jXEy+CWYkocQIJ25Kpw9hUQ3R3JCfZZs7oFcKq4U3l0dJB
         ZGUT8pptX8tRJuJ2MzgLQwFrTxf0V8CkD8yIfy2Llx17Z5NxCTVv7RcG7MSagbWz0I1X
         ay9uEtdNTvr6dwVVG7Kz39jP5BcPloi/188Sca3y4hu8LSp6tw4Gg1LoWf44thl4qyfe
         TbaUsRbm1LxXRjSD0/TcM7qQdmVtVKmhukzzN9WlyWcjOmJzvwmAJpTPuEeaX5DezNXh
         /vsnNX52aUpt1x8lm/Lv+a6Q9WYETL2xy1ay6xSDQyzqE5q4zhh6yRzxZI+fIDpGudOe
         Ij9g==
X-Gm-Message-State: AOJu0YyiNO8smFftvGgzkG2HIdM4gFSAYZSFAbPklz2P2sHTH1nLVtew
	ky7BW32ryot+d72xhdqVq2XteTkJLrZ9ClHWgS+5pEpqNRHONzV+cotzk7p4UZs=
X-Google-Smtp-Source: AGHT+IFxrxEhNnHc+MTWqzo7hYmgSPqBEgF0gwpf0mA9mzoZ0MSaYeUxHfwD5HyIDRpDfcrgZF+Dmg==
X-Received: by 2002:a17:902:b7c7:b0:1e2:1916:52e6 with SMTP id v7-20020a170902b7c700b001e2191652e6mr3535779plz.25.1711746166678;
        Fri, 29 Mar 2024 14:02:46 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b001e020a47fe9sm3875327plr.261.2024.03.29.14.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 14:02:46 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v2 2/3] builtin/commit: error out when passing untracked path with -i
Date: Sat, 30 Mar 2024 02:26:20 +0530
Message-ID: <20240329205649.1483032-4-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318155219.494206-2-shyamthakkar001@gmail.com>
References: <20240318155219.494206-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we provide a pathspec which does not match any tracked path
alongside --include, we do not error like without --include. If there
is something staged, it will commit the staged changes and ignore the
pathspec which does not match any tracked path. And if nothing is
staged, it will print the status. Exit code is 0 in both cases (unlike
without --include). This is also described in the TODO comment before
the relevant testcase.

Fix this by passing a character array to add_files_to_cache() to
collect the pathspec matching information and error out if the given
path is untracked. Also, amend the testcase to check for the error
message and remove the TODO comment.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 builtin/commit.c                      |  9 ++++++++-
 t/t7501-commit-basic-functionality.sh | 16 +---------------
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 24efeaca98..355f25ec2a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -441,10 +441,17 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	 * (B) on failure, rollback the real index.
 	 */
 	if (all || (also && pathspec.nr)) {
+		char *ps_matched = xcalloc(pathspec.nr, 1);
 		repo_hold_locked_index(the_repository, &index_lock,
 				       LOCK_DIE_ON_ERROR);
 		add_files_to_cache(the_repository, also ? prefix : NULL,
-				   &pathspec, NULL, 0, 0);
+				   &pathspec, ps_matched, 0, 0);
+		if (!all && report_path_error(ps_matched, &pathspec)) {
+			free(ps_matched);
+			exit(1);
+		}
+		free(ps_matched);
+
 		refresh_cache_or_die(refresh_flags);
 		cache_tree_update(&the_index, WRITE_TREE_SILENT);
 		if (write_locked_index(&the_index, &index_lock, 0))
diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index bced44a0fc..cc12f99f11 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -101,22 +101,8 @@ test_expect_success 'fail to commit untracked file (even with --include/--only)'
 	test_must_fail git commit --only -m "baz" baz 2>err &&
 	test_grep -e "$error" err &&
 
-	# TODO: as for --include, the below command will fail because
-	# nothing is staged. If something was staged, it would not fail
-	# even though the provided pathspec does not match any tracked
-	# path. (However, the untracked paths that match the pathspec are
-	# not committed and only the staged changes get committed.)
-	# In either cases, no error is returned to stderr like in (--only
-	# and without --only/--include) cases. In a similar manner,
-	# "git add -u baz" also does not error out.
-	#
-	# Therefore, the below test is just to document the current behavior
-	# and is not an endorsement to the current behavior, and we may
-	# want to fix this. And when that happens, this test should be
-	# updated accordingly.
-
 	test_must_fail git commit --include -m "baz" baz 2>err &&
-	test_must_be_empty err
+	test_grep -e "$error" err
 '
 
 test_expect_success 'setup: non-initial commit' '
-- 
2.44.0

