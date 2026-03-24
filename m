Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9608A346E6D
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 18:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774378190; cv=none; b=T2K+AqZsKJRSu0jrPSGkbrsXCwjOJlSATQ+6TPWHKP5TIzF+LBxpsRCM20lK8OANiIREcULQbg2gMV16+mJbcKS/0J0PCyi49iPoDUgd+gn/FiLGgqp5R+eD+VWUi7tgLcwPaB8Ss0Re5r8dowOYHjvKBx+UvVCrc5WSx4BhL5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774378190; c=relaxed/simple;
	bh=dGm73GFrvw6fEmfGIQBxgDiuINcgwF61W+/9WJHLz5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZZT3q40gxDQLLGbLOkb9NVLJ2mp7k73Zy5Ol3kzz+IJpc//Y7jKvJ0W4zA1zgFWLWCwBcCUlNgIkk7vMOFwhkxSHgf4WnTz3fQiNu+4FMDdf1geur7PYhzGLyrCVHb2NXOz7nU0I6uKmb3VD+bfqPWYvUx32lM2NW4V299WdbFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpnGwtkB; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpnGwtkB"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-486fe2024a9so33356955e9.0
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 11:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774378187; x=1774982987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpeAaW8wgk4GzkTRF7uEzLdgeC44JaN8LD5ru6T3zTY=;
        b=FpnGwtkBjJCpxiViXcd4S9pydC4i01a7mZZ6VvUrSIYyAON3bUwdNlsq9bib5WWpUR
         LRiOxhOz1zFXCakSHUcPXlJCZ9JP25iPorLryjKYjB3MzbO6ua9Jv6hjh8FJz9fB4JBF
         uZIepdPJuP+KWX+FSZ0Zk6HXiK56l6RNGDJGlajM5KVIpajMkiyyQHtk5/VGFJ4XjvoG
         b17wSOJOrqqIt6fJwKfGAzdlAPHzvqDi6moudKZ4segtJeOz8L/PSVW/KnFPIORsuFiG
         rM47dF4maVDqgkewvIcs+k0B29r1AoRyCH1F7pTf47gBNDNqPF6AE6zn9qLxNbkPIQk1
         u/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774378187; x=1774982987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OpeAaW8wgk4GzkTRF7uEzLdgeC44JaN8LD5ru6T3zTY=;
        b=ierx5UnDS5TMA+KsE/twkDoArlzmEyI0hXAYbDnFIccDzk09Bt+j9mZis5v6BkteYJ
         RFUATMIwPJNc2eYnXBc3paSFb21rRXtMSuoqyGjfAtiTden1w/JsMu5l9i8VSPAklA/7
         Z+GQboWiIr/E4UaAwL8ogQqWwLG7L0CKyluChsCcq4vj7tOeP/Vyed/D1wuDGHx4AHna
         VqclT9eDAulCxpOMa5z0hStndlMjHtTyKLv8Cpd+glstFAOVf6k7JsO6bShfYJdgV6wv
         Rc7wTvbdGD5+Xspz6U1klwZrBlSOyFM8PqJ/Ri2Vp22BrdzBrk7t0MNR7MIqFcSlqnDW
         ibhg==
X-Gm-Message-State: AOJu0YyZwxUTouMRIELLJGioKIilA2Vo+Qwj1XJl7TduY21D+uNkCeSV
	ooU512a4WkrWuPBzsQERDcdFLOn3AxtfjnS3ZOOhoJy6Tpyzbe6R3toi4g6m2m+ftds=
X-Gm-Gg: ATEYQzwSz198dwEXWVfzq7HVXxVjRVSAnLXE2r6IX7O6/MsTVpxLs8C+R1lqxRGvCd3
	mpMC/4QZaqfm01/QLgvNBtT0J0+KM2eJWusJFd7dJuXLytRH8ckH+bvdew0FHk1tOCgeQdwRPRF
	ble3r5YfGfZuqIjCC4knEnZuhboaC0RA/pfYst/2tU21pUSd+xQzXcR4uM63wz+ozUNcqTFlqAy
	rjNSlribyOWx2qCJyyd2wZSq1P9aviN6OmkQyjndVfqrAQ3iqxinuw5pV7P2HEJzyu8vtQNFzJC
	JKGaH0ysypQhc1uYJFcBowpll58VnzQM60zV+oRvcIeSEjF0cpkT8pAPq/3jZaKBLOvR/JpatMx
	PeCX05QkeVHThCgQo5dcZffSEkx9n5xq4S4Qn37FRS2D/zqzQ5doNDPxAdEwsqDDuz45u6/tE5z
	sxj5riVPYIoI5IYGeFhl1as5Szh9zZK69iroueEb0Gz/H8sj7ZaFr4Nn3MdinKsbIXgUhmEQvy2
	R35jJmfC7GPhFNcPDFNWKNBUqJElYozsZ60SCo=
X-Received: by 2002:a05:600d:8449:b0:485:39d1:b500 with SMTP id 5b1f17b1804b1-4871603157bmr10030165e9.16.1774378186516;
        Tue, 24 Mar 2026 11:49:46 -0700 (PDT)
Received: from macbook.fritz.box ([2001:9e8:16e2:d600:4d27:7cf0:2953:93d0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487173833a3sm115415e9.28.2026.03.24.11.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 11:49:46 -0700 (PDT)
From: Mahi Kassa <mahlet.takassa@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	lucasseikioshiro@gmail.com,
	jltobler@gmail.com,
	Mahi Kassa <mahlet.takassa@gmail.com>
Subject: [PATCH v3] repo: show subcommand-specific help text
Date: Tue, 24 Mar 2026 19:48:43 +0100
Message-Id: <20260324184843.299223-1-mahlet.takassa@gmail.com>
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

The previous reroll mistakenly omitted the requested code
changes; this version includes them.

---
v3:
- include the requested code changes that were missing from v2
- factor shared usage strings into macros to avoid duplication
- restore blank lines between tests and before test_done

 builtin/repo.c            | 28 ++++++++++++++++++++++------
 t/t1900-repo-info.sh      |  6 ++++++
 t/t1901-repo-structure.sh |  6 ++++++
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 55f9b9095c..71a5c1c29c 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -20,11 +20,27 @@
 #include "tree-walk.h"
 #include "utf8.h"
 
+#define REPO_INFO_USAGE \
+	"git repo info [--format=(lines|nul) | -z] [--all | <key>...]", \
+	"git repo info --keys [--format=(lines|nul) | -z]"
+
+#define REPO_STRUCTURE_USAGE \
+	"git repo structure [--format=(table|lines|nul) | -z]"
+
 static const char *const repo_usage[] = {
-	"git repo info [--format=(lines|nul) | -z] [--all | <key>...]",
-	"git repo info --keys [--format=(lines|nul) | -z]",
-	"git repo structure [--format=(table|lines|nul) | -z]",
-	NULL
+	REPO_INFO_USAGE,
+	REPO_STRUCTURE_USAGE,
+	NULL,
+};
+
+static const char *const repo_info_usage[] = {
+	REPO_INFO_USAGE,
+	NULL,
+};
+
+static const char *const repo_structure_usage[] = {
+	REPO_STRUCTURE_USAGE,
+	NULL,
 };
 
 typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
@@ -214,7 +230,7 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, repo_info_usage, 0);
 
 	if (show_keys && (all_keys || argc))
 		die(_("--keys cannot be used with a <key> or --all"));
@@ -879,7 +895,7 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, repo_structure_usage, 0);
 	if (argc)
 		usage(_("too many arguments"));
 
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index a9eb07abe8..39bb77dda0 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -149,4 +149,10 @@ test_expect_success 'git repo info --keys uses lines as its default output forma
 	test_cmp expect actual
 '
 
+test_expect_success 'git repo info -h shows only repo info usage' '
+	test_must_fail git repo info -h >actual &&
+	test_grep "git repo info" actual &&
+	test_grep ! "git repo structure" actual
+'
+
 test_done
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 98921ce1cb..10050abd70 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -224,4 +224,10 @@ test_expect_success 'progress meter option' '
 	)
 '
 
+test_expect_success 'git repo structure -h shows only repo structure usage' '
+	test_must_fail git repo structure -h >actual &&
+	test_grep "git repo structure" actual &&
+	test_grep ! "git repo info" actual
+'
+
 test_done
-- 
2.34.1

