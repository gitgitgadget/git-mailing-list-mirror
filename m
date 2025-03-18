Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8033420B80C
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299170; cv=none; b=DkHRkBKYi1r9AafESPp8u3ZR9Y0mwOCMoftYRHrZ2FQnE2+y1neFGVcBrgRMfQjEM2RIMRKyjGubgNLM2ISiw+6jKO40cwZLnoNw0MvnoGDlmtfoV4G19qvMfJ91mpRgbpFwwvCFz2cqcP/a4E0A+ui+PrVnvzVS2yScTgQ85UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299170; c=relaxed/simple;
	bh=JAJbSWuFJgB3UDNULyyBg5saO01KET8wLRD6PmDumWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyyr8sEdGAnjTdWKJR6Y5dtmRKQlONE7sKnqTe3LKfKlQwZbody8svuvQYir6Y9Gr22SyIJ8Huj4PBPV4BuT6Ts/yptPK55ocqEl1Y3r3W9o6PZYDVbpDu5H6L2KukjXBfhl3TD5qNvi4o1ykczC9gMg57vUPutvsbAqRcqvu8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTwaGBvf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTwaGBvf"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22359001f1aso58254605ad.3
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 04:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742299164; x=1742903964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YS369oUw4eRuRr2YFC8W8hxX9W24rD8Bi7rbrICFRVs=;
        b=lTwaGBvfy3ECcVeABDv5wQz2gdLhXRvEPRmqMvrBh6xEM1N0MOYSLsbJDi6uF3BZHS
         nO2RaCzlzWxq8ixjoIS6ywJEGwLczkkYxLNldIDTKGYKokQTBUo8eFsEfPyALHVse/On
         Yepv7K7VOa9HyoatvyTBZ/bbBaIAlpo74uIK8a0l1adTTZQa/KE22JhZVXLw0sNm64sJ
         GzdH30rblXORJq7czJJDEyVBEnY8h9HnviHpcK7xzlJh2Hoifx1Fzd8ZWn2kdKjWqqbT
         a9AfaFf2FYj0MsDO/e/hWxZreAiq1rfdwGVGNDDkRb2uzR8jybVYSGc7rhSVothCUYE0
         RRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742299164; x=1742903964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YS369oUw4eRuRr2YFC8W8hxX9W24rD8Bi7rbrICFRVs=;
        b=f+G3ww9XEn+mscTz6jT4M/eXx3z+9tFnfVwS1k7tfm0ZmadK2VoXmpVv1p3tscunJg
         GV216niza99iiXq+g+4RGae0tSRsQDGAIT9IRNzXeKHztxjubMsnbMIPtYZWuaziTJWZ
         vnogGsSvAcMnkc3C+uiSJHgT1qYTvmoLuU+ipIbVMhVLSnQOa0Ot6NNKRdYQGdvk4OtW
         ktiPZ1+OjsTQpQZc6rxSzqcjGehWFTwmr9nN2Qe5t1f9dOkAYSCkQydpljuBv+ItRrrZ
         d4xRg8wvE2dScdsfX1ZYHbUeSVZg0OgetHh8GDyW+vLHWxO451/vbdQbnJzg/sys+Wyb
         H0Ew==
X-Gm-Message-State: AOJu0YwdfT6fWHwER877iNSjrcyoclVuvkXHBU/84pHPwGUmbhRB3JPy
	AvPk/PNUrKzKnd1YMJ+KkvaEG4zlnM5GoO+NS2BiAWDmFztVOU2OTG+ptiq/
X-Gm-Gg: ASbGncsWTkdhS8+AIRGzB9Lvg+VN6D//9ZvnLzaOiUA4qGOYPOsEpiIbzxz1JHLBS9V
	rwDzlRR9/cUzedXlEQcgvNh9DKiNo0JZl4mce/yG+lTB9KTTcsAB9NSzn/IU5DIX8tc0nO8ZFtV
	QsxqwxGWB8YPEee1s/OhmErc0POt+sb9gLGNZUzdXezCCbB6riXwquvCQGnLZKaW14pN1EnCaVP
	inATm6xfn5mT9qQK2kayQhl1VgwKUVgHruq56t0PJc3blOczp6Rbi/J5WuhyQ33XO3KFA0ECShT
	9J0rtPhTGSieVrcDBoKXCLh9i6jH6cYUmGOALjM1Vl9bjOPO14g73apsiemPZunhwg749g==
X-Google-Smtp-Source: AGHT+IFDuPpHH0lHw+SWnRsU4wDKppcZOcLNiJzmKspQ87FuBC2mu/PLqh6aX/mmT/ehSUO/AvgsMQ==
X-Received: by 2002:a17:902:d481:b0:21f:dbb:20a6 with SMTP id d9443c01a7336-2262c5ecad9mr33681695ad.33.1742299164548;
        Tue, 18 Mar 2025 04:59:24 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bc012bsm92101605ad.205.2025.03.18.04.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:59:24 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/9] builtin/verify-tag: stop using `the_repository`
Date: Tue, 18 Mar 2025 17:28:54 +0530
Message-ID: <20250318115912.2978992-3-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318115912.2978992-1-usmanakinyemi202@gmail.com>
References: <20250318115912.2978992-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the_repository global variable in favor of the repository
argument that gets passed in "builtin/verify-tag.c".

When `-h` is passed to the command outside a Git repository, the
`run_builtin()` will call the `cmd_verify_tag()` function with `repo` set
to NULL and then early in the function, `parse_options()` call will give
the options help and exit.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/verify-tag.c  | 7 +++----
 t/t7030-verify-tag.sh | 7 +++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index f6b97048a5..ed1c40338f 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -5,7 +5,6 @@
  *
  * Based on git-verify-tag.sh
  */
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
@@ -23,7 +22,7 @@ static const char * const verify_tag_usage[] = {
 int cmd_verify_tag(int argc,
 		   const char **argv,
 		   const char *prefix,
-		   struct repository *repo UNUSED)
+		   struct repository *repo)
 {
 	int i = 1, verbose = 0, had_error = 0;
 	unsigned flags = 0;
@@ -35,7 +34,7 @@ int cmd_verify_tag(int argc,
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, verify_tag_options,
 			     verify_tag_usage, PARSE_OPT_KEEP_ARGV0);
@@ -56,7 +55,7 @@ int cmd_verify_tag(int argc,
 		struct object_id oid;
 		const char *name = argv[i++];
 
-		if (repo_get_oid(the_repository, name, &oid)) {
+		if (repo_get_oid(repo, name, &oid)) {
 			had_error = !!error("tag '%s' not found.", name);
 			continue;
 		}
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 6f526c37c2..2c147072c1 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -7,6 +7,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
+test_expect_success GPG 'verify-tag does not crash with -h' '
+	test_expect_code 129 git verify-tag -h >usage &&
+	test_grep "[Uu]sage: git verify-tag " usage &&
+	test_expect_code 129 nongit git verify-tag -h >usage &&
+	test_grep "[Uu]sage: git verify-tag " usage
+'
+
 test_expect_success GPG 'create signed tags' '
 	echo 1 >file && git add file &&
 	test_tick && git commit -m initial &&
-- 
2.48.1

