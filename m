Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35841F4168
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 21:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838666; cv=none; b=Hr3b93E3cZyg21qzGWJTvJmrwI2+ZrPE0eWAHZdtsdkq6scTzRAayMjjPlfxyNU7DWbVptqA3c0Th8eLu20341TdyCcprvsyXKJnuzRx8ymqvl7FYm9phGTQHddaKB89EmlAW+Ulhg+xoFPGaTArDDx/qzmxyHurQxA+A3Pfo0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838666; c=relaxed/simple;
	bh=mo10VbJAdpSzGMuTE1bp2aBAS5AWsiEdSYoeoTjNddc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwddYgID8qOXUXZBZnKNoVeiyEB7v1T3XbzU9Tb05b7U2nkB35npNkEusWgBhxEF0x6b2lPZCIsq1vF/HsXt/J3k9sX/9musN9lV0bk65rKt5A8e/4xIWLq6K+X3p9og2cwT2F8F4B/4hvs/gjA86P5Cv6f2e5depagzQpFiBhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAQssubs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAQssubs"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234b9dfb842so20876435ad.1
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 14:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751838664; x=1752443464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2tJb25DIueXTwiI6a2j0IYObpDxqxw5f1lkzKE5Rqk=;
        b=SAQssubsEq0bi6GRJ59uewJL/0GMZOGKKjl0XnYZli0x1M0q//LD2rhIfEEGnf9lDi
         Yjon5IISvWeyUQ13SzCU08JobWvwgvQstBNgXpJ8v81gzG++DKP7OFsF7I+f1cxB0zG2
         qyKj7C0MrzigGwZGBwO1uJDp6yfZddS63modg+5Of19JvZtE6SI9hu8715SIN88+TVcU
         t2lM0eYP6JsXzzFuGx7nnuCnnIechQA0PiEEVhbnas9x6z5ys6GLYMWGgr+l104ld/Gf
         ZtLvreH/ElFl2NKBM1+ZDQumxX6IbpjpfqGpZJz+Yjzy1kzXSjTxVECh9KdK7QTGqHCK
         KkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751838664; x=1752443464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2tJb25DIueXTwiI6a2j0IYObpDxqxw5f1lkzKE5Rqk=;
        b=WIxYWMly/wnH9eE3ufgCK/95Soiq443RQbIqzuP3bQPJrpvBADXFTXRAyjogk/BiWA
         gP0SDeNnfsC2+MfTtiHC1qFvFb1qgcciNDHnlZr6KLAebVxyfhvDrgAVPaMzgQFB+dYq
         KaumV7Ug5rJTKnJljB8b1jjJ5ibmJo4oFKvg6I7s7oT1/7WJjPLtQM2KJfsQIPf10vBx
         IL8h8v1rzP4IycJyxKzAm+HSSNmyXn0zlDbp8zhHYnuNiZ7971IlIUPZNZWp7z4py+ax
         E7v9klT/zWIaxhYyUlfMtxAyEz7NYWwK/gsycy43jskVSdJcWrRns9ougxkr3yDT1gy5
         42Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWbY0UsDC/gUU8namh2tBdtKPI3KauSHMc/2MiD3/F3iX2//co/ydw+dxigEbn1EsVjHMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmClwWSjwXVAIl0pkg01GlMr7S9EOTiCD1S7OiufyLbQCbaRHU
	50tom3KNhvT+SpVB5P7w8DugC97ZMjY1cM4KwPJxVVrH9AXBuGlg/EG2
X-Gm-Gg: ASbGncvf+4prc1ewf9aYpeTBEDCkHvbqTl/5vND6JXHxXSZIUk9tdUuv/v8s391WeY/
	gwvECSnmKmSYV3fWxi+KIkLfcnqA0Ua0xLE5g/a3hJ9SEIGj/Q3ms7HARpwTPiy3LLRmvkKVJKT
	Qz9+xwYyN4aOEUfBQnBNtukwudE4jjpnayhj1ADba7dJIfMwGuQYn8v/k3fP7X3VH0+A5Fdt0h4
	I3vyeEl5KktzicpqrtR6GjmFmm3/w0F7zYOkVk1FUn+BUIn+wF1fcorPpOkh4hX5ZEg6EYExY7+
	YEynAVFFyLjfxBOCfVhyPztKd30kVRF+5e605Vb2TN5yDryA+SddBechl1rIEmxcdl0B1aZCdeW
	RPEDhsEWOYK8=
X-Google-Smtp-Source: AGHT+IEEMhac9q7XAYVah6Foatqoza+Xr5BIY6HbZ87aYD5CSWYSt9Kxu3wqooBVQjRnXsNeAqRtHQ==
X-Received: by 2002:a17:902:f609:b0:234:98eb:8eda with SMTP id d9443c01a7336-23c8755bdeemr165530715ad.28.1751838664151;
        Sun, 06 Jul 2025 14:51:04 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8457f308sm72912335ad.149.2025.07.06.14.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:51:03 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: usmanakinyemi202@gmail.com,
	git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	ps@pks.im
Subject: [PATCH v3 6/7] t/t1517: move verify-commit -h test to t1517
Date: Mon,  7 Jul 2025 03:20:38 +0530
Message-ID: <20250706215039.715732-7-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250706215039.715732-1-usmanakinyemi202@gmail.com>
References: <20250706214108.714499-1-usmanakinyemi202@gmail.com>
 <20250706215039.715732-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test 'verify-commit does not crash with -h' checks that
the command exits cleanly with usage information, both inside and
outside of a repository.

Move this test from "t/t7510-signed-commit.sh" to
"t1517-outside-repo.sh" since it better fits with tests that check
command behavior outside a repository.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t1517-outside-repo.sh  | 7 +++++++
 t/t7510-signed-commit.sh | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 2568f8ae0d..8a46fdfdd1 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -149,4 +149,11 @@ test_expect_success 'send-pack does not crash with -h' '
 	test_grep "[Uu]sage: git send-pack " usage
 '
 
+test_expect_success 'verify-commit does not crash with -h' '
+	test_expect_code 129 git verify-commit -h >usage &&
+	test_grep "[Uu]sage: git verify-commit " usage &&
+	test_expect_code 129 nongit git verify-commit -h >usage &&
+	test_grep "[Uu]sage: git verify-commit " usage
+'
+
 test_done
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 39677e859a..0d2dd29fe6 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -8,13 +8,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
-test_expect_success GPG 'verify-commit does not crash with -h' '
-	test_expect_code 129 git verify-commit -h >usage &&
-	test_grep "[Uu]sage: git verify-commit " usage &&
-	test_expect_code 129 nongit git verify-commit -h >usage &&
-	test_grep "[Uu]sage: git verify-commit " usage
-'
-
 test_expect_success GPG 'create signed commits' '
 	test_oid_cache <<-\EOF &&
 	header sha1:gpgsig
-- 
2.50.0

