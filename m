Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADA03F6601
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 12:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355027; cv=none; b=LcD5JHKwISLtnxr/m9LgWy6FfIzZC9yCeLtFMkwtkxSIU2kmG58EAgHO1j7M2EXkaJ8EIwdWIUtTjRarYhtl7TtuW3XO0cEANMUMaNwQAM38drnqzEzErfN/0Pdf5qj0dY+fOHZfHW/QF6m/EpfsetKpPjyWlRTgnVmYEslVo/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355027; c=relaxed/simple;
	bh=xO95HN1ImHzNBvvQ3xGyNr6ymYz11hHhGykQh3NWH4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MDYO67czmrnf4kei1/uOJJvN91t3M/+1Nr/397uJIJ7mOfFrQPlIPjQX5JmMoReYPBBXXfONZAc5NMURJ567nHVP9XsDjJa9jolHSSIoZZrD/XpfgS868xAXd3+IyM7nDMACM5zBKo0mxllDJFj/z9OHFo8177Yi18QelOkZHJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+ex8XAU; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+ex8XAU"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so41263375e9.3
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 05:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774355021; x=1774959821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOTpgHshjQbIF+2OzUMMqO93oxFb99D/mBeIB7KNHaA=;
        b=N+ex8XAUL/MuqE5FPbGtNUpC6xVu773RyHOnH/RPlZQ505Lcl0ijBbLldnfBHHuPLk
         BKKaBi4LLZWIoBwHhruhdAxPQD1YO2/VYS4BsgqZXmPWjHjAQU1lDd26mtvxqlQoGS7h
         ER1lgEl6Q92g3BPAWC5h7HYkZEZTkfzI9J9rcQygZN+ZS6uVR74a+uESqqP4JoRpuRF6
         jaDRs0H0baNAiztnFnWZo5nefu+4DI2OgAQ+Zxq0uznQpCsVBgkjMCLuz5xj19Y4ZRPG
         xuaTEEEvIGYZDMOEZZ3s09QBx35GzSs474L4E3eXTbnE4sWT+m/D6d//V+EhyvKZc87j
         7Z+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774355021; x=1774959821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XOTpgHshjQbIF+2OzUMMqO93oxFb99D/mBeIB7KNHaA=;
        b=PUvBsHZi+JP6RBUc/Hrcaun7o3xEtXljYQ/vlHHR2BqClXD+1xbcQm564d32ZAV6Gt
         FyMb3pyUnMklpPpt3k9Mzx+vHTEctG/vcN1BpwUYmrGQ9pMF+UsyozODEdP/Fbfjf7mG
         GEDKjDEXp0EQp4p/BnRYvRZOuwBLlVXA/qIiN2U8hyI5KVZeDOtOVNvNZEgwLC/2raFA
         MmF0ZRezFajkBC0sevmCqgeYHZOyeh5KIgrtG+d8NkXI+1SUMxi+nDNiQb5m7bGMuU1e
         aQxi8Pm0tsfOlWHR17lBvPL7PdVaYP+7gKmyc5d04v0T0037hHINoxW9Z4gMp52mbpEc
         JmPw==
X-Gm-Message-State: AOJu0YzrQ6s96+xAZrt3ACesIu+NgTe9bM2r22K+aF66VgSnHKbtYGKC
	gA0I/Ty/URe/gQkKBFF/HIAIfBA3MI/7SQSjTIVLuiaPmkBnbGVfaOIEExIkL4plSwg=
X-Gm-Gg: ATEYQzz8d42ftxNPtlx/dLIwVCFi3ntkPgJ7z5XHE70FXVEUOfyw4PZYTCa5JTcEOpX
	MB801q6+Sy8i2P8wT96E/KtYGMr/9IMEjdoxY3a1/JvTPFpaLOM49VY7kE5O5CyEZrEVvdOlVAD
	Xfd3aVdQfioYMw1c7L/g8JIei42osgVXtnoRbMfGx3m/nvghGkv+9WqCQynkIbKNcxwABFxTHcX
	bjdN7gAc70OvH78B4u/hzJpccZcxLOemUbHTPNxJTzb4yiMg5A5Dv3XXWXBvkz8O5tbZXVlo1xl
	hwcfqK++AtyyeXmzZ64FZJjkIEiDA4/1AeRgyyIf1C0znIXM1FZ9I4iCLKoy6rlFMMAK8bU4XBp
	TeRhG5u+nPli8/0ttxr89DFtO5ODGePefT49TDOK+HWq9sD7POfVYIFLyYpIHJYhacO6jYn0Nzt
	CqBdNIaOaOYETi23QTmWMEPxWZry6+vGfzRcxco8sxqOjnKclz6k7xQP42iOomB4fm3vAPxImpM
	Ng3o9eZUMuugQHr
X-Received: by 2002:a05:600c:3483:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-486ff02923emr235121305e9.21.1774355021085;
        Tue, 24 Mar 2026 05:23:41 -0700 (PDT)
Received: from macbook.. ([88.130.184.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4870f6e9519sm18659225e9.5.2026.03.24.05.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 05:23:40 -0700 (PDT)
From: Mahi Kassa <mahlet.takassa@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	lucasseikioshiro@gmail.com,
	jltobler@gmail.com,
	Mahi Kassa <mahlet.takassa@gmail.com>
Subject: [PATCH v2] repo: show subcommand-specific help text
Date: Tue, 24 Mar 2026 13:21:11 +0100
Message-Id: <20260324122111.84122-1-mahlet.takassa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323152937.257406-1-mahlet.takassa@gmail.com>
References: <20260323152937.257406-1-mahlet.takassa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use subcommand-specific usage arrays for "git repo info" and
"git repo structure" so that each command shows only its own
synopsis in help output.

Factor the shared usage strings into macros to avoid
duplicating the same synopsis text in multiple arrays.

Add tests to cover the subcommand help behavior.

---
v2:
- wrap commit message lines
- factor shared usage strings into macros to avoid duplication
- restore blank lines between tests and before test_done

 builtin/repo.c            | 15 +++++++++++++--
 t/t1900-repo-info.sh      |  6 +++++-
 t/t1901-repo-structure.sh |  5 +++++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 55f9b9095c..5ccc5c401a 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -27,6 +27,17 @@ static const char *const repo_usage[] = {
 	NULL
 };
 
+static const char *const repo_info_usage[] = {
+	"git repo info [--format=(lines|nul) | -z] [--all | <key>...]",
+	"git repo info --keys [--format=(lines|nul) | -z]",
+	NULL
+};
+
+static const char *const repo_structure_usage[] = {
+	"git repo structure [--format=(table|lines|nul) | -z]",
+	NULL
+};
+
 typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
 
 enum output_format {
@@ -214,7 +225,7 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, repo_info_usage, 0);
 
 	if (show_keys && (all_keys || argc))
 		die(_("--keys cannot be used with a <key> or --all"));
@@ -879,7 +890,7 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, repo_structure_usage, 0);
 	if (argc)
 		usage(_("too many arguments"));
 
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index a9eb07abe8..e0e79ff167 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -148,5 +148,9 @@ test_expect_success 'git repo info --keys uses lines as its default output forma
 	git repo info --keys >actual &&
 	test_cmp expect actual
 '
-
+test_expect_success 'git repo info -h shows only repo info usage' '
+	test_must_fail git repo info -h >actual &&
+	test_grep "git repo info" actual &&
+	test_grep ! "git repo structure" actual
+'
 test_done
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 98921ce1cb..0f7ec4da10 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -224,4 +224,9 @@ test_expect_success 'progress meter option' '
 	)
 '
 
+test_expect_success 'git repo structure -h shows only repo structure usage' '
+	test_must_fail git repo structure -h >actual &&
+	test_grep "git repo structure" actual &&
+	test_grep ! "git repo info" actual
+'
 test_done
-- 
2.34.1

