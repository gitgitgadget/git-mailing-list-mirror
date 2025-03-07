Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCC233DF
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 23:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390568; cv=none; b=KdVm6so+76IUcvBiBhRKb0SJaXSdsVl46pCd93my9dvYhv79EOERY6UD+cQ2aXExYQGN3rdwzxgScm0lLfE3cYfIOmSp/sa+oTGcBiJ7YawnGNgTd+Vd0jeJQvrLYKRRn1B9yDtAkoQOYFLZchSCZkZ3r8VuCbMhErYFgVu3+8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390568; c=relaxed/simple;
	bh=XTJrwl6lGzYH/UD6p2YmKN1G1LrAG9X5uWXZIigQmz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUz1qxiTP9kzBDuP2oXtRb7vFLC3anvPgOXaZFs0VRz9YElwqTULmB1MfToz3ftAe5vCCIS4wNPsczBeo9hiM224Al0p7GDBcRMHRKuQDbTiV8q6+YU5PfsQOCpZv0Il2Fm6BLZxXG3pFeELADTiX7UR5Fo6OxrrU016e//iuxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0RTTRBl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0RTTRBl"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22548a28d0cso1251725ad.3
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 15:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741390566; x=1741995366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odxIt6J5cAejMWvEFPdbwTynWI7WHeWNfI/TInK4QPk=;
        b=e0RTTRBllDORQRodq+SAhi8G5RBcMgZzEscoKUbpuEiJtNxOhnHkjdAU9wfuPLAlMd
         yFuDhFOvu5BV+X1hNz5r4CkUerZBJLHBeIIw2ZzED+r4e3NcVC/6YYo5DZa0Ib2UOu0r
         WxSnuluoowA1s2/4bHmYalDnbk4Jx/zVpDwithTvtIHZQWjDe7OmMDhxDfFCzhFq9h3F
         +qygxz4iz2i2AHNDsJ7Axp0tgNT6z9RVarLVXPwZtWU8yJMWmtGzhmLDnBvG0qPlHimj
         iPLnyMPvd5e7cqUJG7SVZV6gCF8PpGpl5HjslRGQHQjW3S78jJn8DPR5SaoWfbxZwE2s
         i+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390566; x=1741995366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odxIt6J5cAejMWvEFPdbwTynWI7WHeWNfI/TInK4QPk=;
        b=g4Kg428LJYUXkgWL6TO2G1b4Ifbm2H/clsYQubeHXTGj6flTOxVYBe/QYReMlmdgt+
         gQoBxhyW5r1GM0Fil0sqQJNeX6kE24d5JDsSIBYZLS4Kye8sn0F7GeYgHBZMCIjRuEZU
         GaTChjuIhOizIpnNVTujIZZUmKpBgvGkA1RTKF6NCP5LhyhwtpWHYufaoQxw8PjzFsTw
         PHNDqd19OjzY/GAY72N7JqIrU3DvEjDfZbzOxujCt2jjxqthkxLXJ+gE6MLfFiBmU+DE
         A7E7N1rS3KZ6x5hvAq9M1Q/3gTPfnTACfDzHs0eHRT60udqKDfSHH/2AXhaLpEBYm2XA
         KKCw==
X-Gm-Message-State: AOJu0YzbK93DfQ60yjgxJRbfhNt6dHdiCLbSEXmFYE2g+/S5rmHSDGIm
	VvO2hzz17Dnw9BAGs3/CLxWl8LcVdyKkJUMgYIyMJZKMnEWTxqGGKCfjrAGyr18=
X-Gm-Gg: ASbGnctDR1W0092EuLOULNRcC65pcL0SPXERYOOVfSX2ANHBYBeQcVYWAgqW16Mla7Q
	0L3SbbA+5a5VVbVKoous29eQa0877NDvnR2o9V7lSErIAH2pCTI1AVArQwFRvSA/iyWfOncEQT5
	IRB60NjVzTZDfTBafj/XTvp7qmT2687RMGTgrbMHrgncFCYJeoRIrq1kuDL2Zlcs2/kiUjfbunc
	PG4fC+QLVGf9hF+/qU3qDYLHxF/mYqJLW3suxATH2Jfn+lJ8pLSvFTND6liOQrZrENGsymBnmBc
	BQ4QTstE+w6SldOWjY5I8rzB3MhZznLXgmtvWJm2deAjpMcJNedoXsqXSH1KjECTqB7yeg==
X-Google-Smtp-Source: AGHT+IG8sqpqxK6s442ZRfhZC4mD+NW9vfmqY5Sk5h1DpbqfaYHLDfm7oAPaou5RbfQ3s0m4vupT8g==
X-Received: by 2002:a17:902:ea07:b0:21d:dfae:300c with SMTP id d9443c01a7336-22428880270mr79316145ad.3.1741390565989;
        Fri, 07 Mar 2025 15:36:05 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736bcb8de04sm423880b3a.154.2025.03.07.15.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:36:05 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com,
	phillip.wood123@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 5/8] builtin/pack-refs: stop using `the_repository`
Date: Sat,  8 Mar 2025 05:05:04 +0530
Message-ID: <20250307233543.1721552-6-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307233543.1721552-1-usmanakinyemi202@gmail.com>
References: <20250306143629.1267358-1-usmanakinyemi202@gmail.com>
 <20250307233543.1721552-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the_repository global variable in favor of the repository
argument that gets passed in "builtin/pack-refs.c".

When `-h` is passed to the command outside a Git repository, the
`run_builtin()` will call the `cmd_pack_refs()` function with `repo` set
to NULL and then early in the function, `parse_options()` call will give
the options help and exit.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/pack-refs.c        | 8 +++-----
 t/t0610-reftable-basics.sh | 7 +++++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 4fdd68880e..e47bae1c80 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
@@ -15,7 +13,7 @@ static char const * const pack_refs_usage[] = {
 int cmd_pack_refs(int argc,
 		  const char **argv,
 		  const char *prefix,
-		  struct repository *repo UNUSED)
+		  struct repository *repo)
 {
 	struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
 	struct string_list included_refs = STRING_LIST_INIT_NODUP;
@@ -39,7 +37,7 @@ int cmd_pack_refs(int argc,
 			N_("references to exclude")),
 		OPT_END(),
 	};
-	git_config(git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
 	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
 		usage_with_options(pack_refs_usage, opts);
 
@@ -52,7 +50,7 @@ int cmd_pack_refs(int argc,
 	if (!pack_refs_opts.includes->nr)
 		string_list_append(pack_refs_opts.includes, "refs/tags/*");
 
-	ret = refs_pack_refs(get_main_ref_store(the_repository), &pack_refs_opts);
+	ret = refs_pack_refs(get_main_ref_store(repo), &pack_refs_opts);
 
 	clear_ref_exclusions(&excludes);
 	string_list_clear(&included_refs, 0);
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 4618ffc108..002a75dee8 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -14,6 +14,13 @@ export GIT_TEST_DEFAULT_REF_FORMAT
 
 INVALID_OID=$(test_oid 001)
 
+test_expect_success 'pack-refs does not crash with -h' '
+	test_expect_code 129 git pack-refs -h >usage &&
+	test_grep "[Uu]sage: git pack-refs " usage &&
+	test_expect_code 129 nongit git pack-refs -h >usage &&
+	test_grep "[Uu]sage: git pack-refs " usage
+'
+
 test_expect_success 'init: creates basic reftable structures' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.48.1

