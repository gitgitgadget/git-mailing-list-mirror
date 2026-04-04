Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589AA14884C
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 11:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775301366; cv=none; b=hHyQbrEA1KzviBJqkDfZeiBUsRr6zwxyHAK52ZXnyBzigkJAEmo+IQZDbV7Cs6bRD+Y4zYftVvO/6a0yfVhlLqVOzWWVCmgexPD7AInloqkJWeRF1M7x7LW5gjss5TlE8JsJ57BcpGMBWNSlypJWWD5+213nv01b8HMrqZCE8FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775301366; c=relaxed/simple;
	bh=p8mutkVe9gvSw+uTYUvv7PKPpaUDzB8DHsa8XNYxr7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eHu/pz/EGYSHkWEoXOpkJzZwErBWxxb/ALFmrvEr0OaE9/IHugfjs5dCqCzEEfLxuPQWlXNMMpJ/zxxELf4TQL/VwjmRlNbzZgbZZN0+NGnvDSj4Q+h1wR6/DoP5ZPg+kUkNV7jz01uzTkq3KbmSSbSBI8ocqfhKgIU8k2C2o4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kn7xsqeR; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kn7xsqeR"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82ce0a9b41aso958640b3a.0
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 04:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775301364; x=1775906164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sQAqjZLeIqpxtg0F8wLP6SB+OtXBLgXS5LvDtp/kCGk=;
        b=kn7xsqeR4ejVq2ziL7nspCuB2GGtphV+JUr1EOQX4qAbpNE4hgZ6zEZYSQm4Blbrwh
         2k5i2j3b0wGLsF7W78UnN1ZrPs+jPcm5vl+pg7KLRH9Gkw8G/KNdmWN1Qa3dxaUGH/6H
         Pvaooc+WvZCAFME1v+0D/UfbAk3CQsTtpCLxbmE0+CimXq1QQbPt76JvEtF38RMrK+Pw
         yBUuOTwbZc3SVRt7zahe32nkzQKoVuQ/fKRNqlXrowrd7HjpItijdZAfrwiJvskzy/Rq
         zufafwu81RhXeBGbjv0ygoUMFCyx9It30ZBSaghBSQSBByBWwNA0fw3vOZbSiLA0rq9F
         y01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775301364; x=1775906164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQAqjZLeIqpxtg0F8wLP6SB+OtXBLgXS5LvDtp/kCGk=;
        b=hK++fa77aJ/iTrGM/0rftlPg4qOVZQMF7JlLdKcwCKmUkVYjX4uppkQ3jDZRmcEXlk
         b/FynaqsEGHuPhS+A46Jm5zxJiUXCif8j8m4oqVIzU3Sp38TGZlOHbqqQRQB7zwsN/hk
         2105Fs3ta3b+At5Ii6O0G+Ol7aBqPI08vGWJqEBp4BvJp+PPGKPAJCE+hBkHJ2/7VI45
         o88ua+Dade9Y0Uic73DYlk5af4ndLIMCXVnxwlSuHly12ZkEcZVBtzZzwQ/zhfCoe+2y
         60wOqGJSvshqloA+ktNplw7Z01peSXqrU5oiXgHe2Ke3lEH+NiueTH6M44d/b/XRD8cW
         MlYw==
X-Gm-Message-State: AOJu0YyyinaP/kiOtTSnfXdU/6zzU/GkKEvDOFeNZj3Wk8KRg+TZ4Xe8
	Khvwd/mfz3fRttQPXbWPToxgDYRufrlhfWYwy4Ruq0uNpReS8qWbe8HUYfEiPjgr9MY=
X-Gm-Gg: AeBDietkrVirQ900EwdHy8yd0KjJvQjBCrStPMwjOq0OcP26j1t06p4kGqhk1YIOIWw
	52h977c1qogPfXKPw1RDpo64+Ju29utZ7VH+BaA+P6/nNM+vB+6BEVK/JE0MxGkMVXBRVSwJAsO
	zu/zKM2kk4cr4qOs2T1NFkUXP9Z+/7QEUhZlNQi/ttca1k2i4TIx7ihwsyxVmV4l7cqwiy90ZhU
	4cI8sj9k1oaKNL7a5DB/4jNSvvPSVWyjIznREJLeD0mKu7P9AfdWYN+6TXkGsvFGIkgJtFqdxYo
	sfxWwbCAIrNGW3ueL/3rBtg5eehqIG1r0y7oldYYNnjK6CQlyppx0wXdFFZR8zWUA5b7wIPUm4N
	NpIYX6XkmIU0GWq/Jv21JYxBfTcRg/f2OKoNCXtiYPekeS8mYRIVpzcKu4kCBwzOAWfpFZXc54I
	JlO3IELKhFBkqcWqLziwzqIaUH0v797r+uDcWNaXHYPng6/84=
X-Received: by 2002:a05:6a00:3e15:b0:81d:dd3a:b8f5 with SMTP id d2e1a72fcca58-82d0db9ca66mr6275084b3a.38.1775301364428;
        Sat, 04 Apr 2026 04:16:04 -0700 (PDT)
Received: from localhost.localdomain ([123.19.199.205])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca4efesm8807497b3a.61.2026.04.04.04.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 04:16:03 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
X-Google-Original-From: Trieu Huynh <viking4@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	stolee@gmail.com,
	Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH v2] backfill: auto-detect sparse-checkout from config
Date: Sat,  4 Apr 2026 18:15:57 +0700
Message-ID: <20260404111557.17220-1-viking4@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trieu Huynh <vikingtc4@gmail.com>

Commit 85127bcdea ("backfill: assume --sparse when sparse-checkout is
enabled") intended for 'git backfill' to consult the repository
configuration when the user does not pass '--sparse' or
'--no-sparse' on the command line. It added the sentinel check:

    if (ctx->sparse < 0)
        ctx->sparse = cfg->apply_sparse_checkout;

However, the ctx->sparse field is initialized to 0 instead of -1,
so this guard never triggers. Consequently, the repository config
(core.sparseCheckout) is never checked, and the command always
performs a full backfill even when sparse-checkout is enabled.

Fix this by initializing ctx->sparse to -1, ensuring the existing
fallback logic correctly reads the repository configuration when
no explicit flags are provided.

Add a test to verify that 'git backfill' automatically respects
sparse-checkout settings when no flags are passed.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
v2:
  - Update commit message to explicitly point to addressing 85127bcdea.
  - The code change itself is unchanged.

 builtin/backfill.c  |  2 +-
 t/t5620-backfill.sh | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index e80fc1b694..54acdfe290 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -120,7 +120,7 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 		.repo = repo,
 		.current_batch = OID_ARRAY_INIT,
 		.min_batch_size = 50000,
-		.sparse = 0,
+		.sparse = -1,
 	};
 	struct option options[] = {
 		OPT_UNSIGNED(0, "min-batch-size", &ctx.min_batch_size,
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index 58c81556e7..bed4987124 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -119,6 +119,21 @@ test_expect_success 'backfill --sparse' '
 	test_line_count = 0 missing
 '
 
+test_expect_success 'backfill auto-detects sparse-checkout from config' '
+	git clone --sparse --filter=blob:none \
+		--single-branch --branch=main \
+		"file://$(pwd)/srv.bare" backfill-auto-sparse &&
+
+	git -C backfill-auto-sparse rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 44 missing &&
+
+	GIT_TRACE2_EVENT="$(pwd)/auto-sparse-trace" git \
+		-C backfill-auto-sparse backfill &&
+
+	test_trace2_data promisor fetch_count 4 <auto-sparse-trace &&
+	test_trace2_data path-walk paths 5 <auto-sparse-trace
+'
+
 test_expect_success 'backfill --sparse without cone mode (positive)' '
 	git clone --no-checkout --filter=blob:none		\
 		--single-branch --branch=main 		\
-- 
2.43.0

