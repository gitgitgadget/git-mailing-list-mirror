Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BEA1B4F09
	for <git@vger.kernel.org>; Fri, 16 May 2025 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747407339; cv=none; b=oss1RjyuMePwXtSGzubI20TJUQCr+H9ZHhk2oEMwco6HBR+dL8U+bHyzc58AaLniTd40JEQ8TcpWeWSoT/ZGGRM1VIMLVm4fIXqGNLfReDiPlgMrEdwUPtoFa13SRaquzPHutDSXknaD9VTDouCE0B4lnJr//Y0W42Vzd5rBVf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747407339; c=relaxed/simple;
	bh=eB+zKF8VElFL/CDGm3lj/6LofSUQWhja5Q/73c1Y6q0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FajK+vzsAuoCAQ/EcZMOjuQxDg3/iiTLUg8DV5SlFWIaLm+NuMUdRWQVFKpj/tKSIHAmqYocKzb+CKG3fwiTPymVbkjDf0GfH1wSW58ydFOB168eDXlueyV0uFFACQyvDdJR8NxFhkdMuG5Z4F2qlY1/00aNB7HkSHW7G5jIVC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njtv9kLP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njtv9kLP"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso15133545e9.3
        for <git@vger.kernel.org>; Fri, 16 May 2025 07:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747407335; x=1748012135; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNfyhW61TnHpc8x7l5N8ZRVISMrpZhjlJ91m+aU+pDY=;
        b=njtv9kLPb2yFdVmzR0/Ot6bxQlvsLvBW87tZp/uidVQmArOkS4HKLq9CyChN3iTy/5
         Vd2wk6bEoiL+OenejKWAVsIgrEiG+Amknq3gKnN/DLU46W09lKbUz7NIXhK4EwuQ4PJf
         XnyVN+HE/LWGaz+iqXxhyfMTNmUX2tP225l6fJ9kFZqjebZBCRktD4oUe/5EU5VQKk9T
         lgeMuo+bxYiNOZWgHnzoYRJIGrgdE3xpt7ztKacp5OpTIZ2Bqi6ziZAlV2JkX7CO0iNb
         0ZmKTMtAV6XWaeqILbxt8/xy/gHuVM2UiaxTtqIBFDQuHzpItwGobXKAOZQN7Jvzzu2o
         jB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747407335; x=1748012135;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNfyhW61TnHpc8x7l5N8ZRVISMrpZhjlJ91m+aU+pDY=;
        b=iAM/RZYJ/nDfDIMiVqU9jGlIS5UZaaqiGEAJL8+2EN2eTLq0vYLfNyZZqstiQ8JbKg
         xPmCdl2zAcvB7/t5QJjjpqtwKT9Bngj3+q5RUqOR9bn4AHDzU2zhjyAp3kCaodueftnw
         fcrzsw+EfEN8GPEiHgAhp+UiJxa5ACCjipy020ZQ366CUmNB78L4QRRO/aX1czq3A60/
         VqYtpbcYhmUUg3uROYU4B7hmIiA++YHXe49zWBwOGE9mvYIA3U/MF9Pf6QIl6MSzSkvK
         SJyDIv0xowRifXillWXeJZ6zZ1UVnOMvHrrXqLDbp7ZAoOlYfj5YymrTrGwfjptNiG0Q
         Ti+g==
X-Gm-Message-State: AOJu0Yz6W9tQnecfOB3esLxqR40UvE/kcIW7cPTJt1/B1CetKBp7Fyyb
	K+OxrEydhWLBZXeAuS2mG2OCqOnr5erqvJ+TVAUh3BxFdEDLMku3tNlKob+6mQ==
X-Gm-Gg: ASbGncsJgNz3OSAd3S/HE18ZV8xki2hWMRngQVdoL1gtrxyoEs5PvnoQi1qC742ZMHI
	tRRnx6bkOS7gNYsUCY2zmu2ha52IKOUhf9Ni3c2w+CZC9mpZ3iqvROk2mJjJVl7ECLZXmtJQHMK
	eFQUG5yLVFsIhumZ2DvZ1q8x6j091s06OZC7HwEyCM4Bo6QJ3n9/vpkUCYNfpXbSHg4ogRXLlcR
	CQN7lSsGmiPHIHjj4VAq+4cqSic3Egl7qgjkWvWiAaGhghTTrl56DQf0GF6C4axjdBN9vFPMsrt
	WmAu6WScOJWfEzXmWdF4AHMR2mhIoMpb5aJOihT/QxCgAr7UGunK
X-Google-Smtp-Source: AGHT+IFcgzeM6J/Gvq1SsbHg0UcSu8diwFhVhjYDuEumxkdxT0Hwra0Am1oTlLAb+EhExoelzohycQ==
X-Received: by 2002:a05:600c:a014:b0:43d:ac5:11ed with SMTP id 5b1f17b1804b1-442fd66f08emr39701545e9.24.1747407335031;
        Fri, 16 May 2025 07:55:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39ef87asm106604145e9.36.2025.05.16.07.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 07:55:34 -0700 (PDT)
Message-Id: <d1482a29d8f23699c713238ba37266fe9efa9aea.1747407330.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1914.v2.git.1747407330.gitgitgadget@gmail.com>
References: <pull.1914.git.1746579320.gitgitgadget@gmail.com>
	<pull.1914.v2.git.1747407330.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 May 2025 14:55:29 +0000
Subject: [PATCH v2 3/4] reset: integrate sparse index with --patch
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
Cc: gitster@pobox.com,
    newren@gmail.com,
    Phillip Wood <phillip.wood123@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Similar to the previous change for 'git add -p', the reset builtin
checked for integration with the sparse index after possibly redirecting
its logic toward the interactive logic. This means that the builtin
would expand the sparse index to a full one upon read.

Move this check earlier within cmd_reset() to improve performance here.

Add tests to guarantee that we are not universally expanding the index.
Add behavior tests to check that we are doing the same operations as a
full index.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/reset.c                          |  6 ++--
 t/t1092-sparse-checkout-compatibility.sh | 42 ++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 73b4537a9a56..dc50ffc1ac59 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -420,6 +420,9 @@ int cmd_reset(int argc,
 		oidcpy(&oid, &tree->object.oid);
 	}
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	if (patch_mode) {
 		if (reset_type != NONE)
 			die(_("options '%s' and '%s' cannot be used together"), "--patch", "--{hard,mixed,soft}");
@@ -457,9 +460,6 @@ int cmd_reset(int argc,
 	if (intent_to_add && reset_type != MIXED)
 		die(_("the option '%s' requires '%s'"), "-N", "--mixed");
 
-	prepare_repo_settings(the_repository);
-	the_repository->settings.command_requires_full_index = 0;
-
 	if (repo_read_index(the_repository) < 0)
 		die(_("index file corrupt"));
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index c419d8b57e84..d8101139b40a 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -384,7 +384,7 @@ test_expect_success 'add, commit, checkout' '
 	test_all_match git checkout -
 '
 
-test_expect_success 'git add -p' '
+test_expect_success 'git add, checkout, and reset with -p' '
 	init_repos &&
 
 	write_script edit-contents <<-\EOF &&
@@ -398,7 +398,7 @@ test_expect_success 'git add -p' '
 	test_write_lines y n >in &&
 	run_on_all git add -p <in &&
 	test_all_match git status --porcelain=v2 &&
-	test_all_match git reset &&
+	test_all_match git reset -p <in &&
 
 	test_write_lines u 1 "" q >in &&
 	run_on_all git add -i <in &&
@@ -413,6 +413,12 @@ test_expect_success 'git add -p' '
 	test_sparse_match git reset &&
 	test_write_lines u 2 3 "" q >in &&
 	run_on_all git add -i <in &&
+	test_sparse_match git status --porcelain=v2 &&
+
+	run_on_all git add --sparse folder1 &&
+	run_on_all git commit -m "take changes" &&
+	test_write_lines y n y >in &&
+	test_sparse_match git checkout HEAD~1 --patch <in &&
 	test_sparse_match git status --porcelain=v2
 '
 
@@ -2458,6 +2464,38 @@ test_expect_success 'sparse-index is not expanded: git add -p' '
 	ensure_expanded add -i <in
 '
 
+test_expect_success 'sparse-index is not expanded: checkout -p, reset -p' '
+	init_repos &&
+
+	# Does not expand when edits are within sparse checkout.
+	echo "new content" >sparse-index/deep/a &&
+	echo "new content" >sparse-index/deep/deeper1/a &&
+	git -C sparse-index commit -a -m "inside-changes" &&
+
+	test_write_lines y y >in &&
+	ensure_not_expanded checkout HEAD~1 --patch <in &&
+
+	echo "new content" >sparse-index/deep/a &&
+	echo "new content" >sparse-index/deep/deeper1/a &&
+	git -C sparse-index add . &&
+	ensure_not_expanded reset --patch <in &&
+
+	# -p does expand when edits are outside sparse checkout.
+	mkdir -p sparse-index/folder1 &&
+	echo "new content" >sparse-index/folder1/a &&
+	git -C sparse-index add --sparse folder1 &&
+	git -C sparse-index sparse-checkout reapply &&
+	ensure_expanded reset --patch <in &&
+
+	# Fully reset the index.
+	mkdir -p sparse-index/folder1 &&
+	echo "new content" >sparse-index/folder1/a &&
+	git -C sparse-index add --sparse folder1 &&
+	git -C sparse-index commit -m "folder1 change" &&
+	git -C sparse-index sparse-checkout reapply &&
+	ensure_expanded checkout HEAD~1 --patch <in
+'
+
 test_expect_success 'advice.sparseIndexExpanded' '
 	init_repos &&
 
-- 
gitgitgadget

