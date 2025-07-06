Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED29D264FBD
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 21:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838089; cv=none; b=OZcIhMyabz5MGG2pyg5oNJneJYHzWANyCRC5sb4OBV6Mk5DtvJynhDxQ07fDYj0SNc96xwnT9JH6iLViF8wlf/zO6yEXBLJTyCwdF7ze5aueks3ZxA6rusaCkxVrHroXbtAJltU1qcGLuAGjxGSbMqsq7z4x1lF7Fh0Et3BcDPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838089; c=relaxed/simple;
	bh=O+6KPxYF7l6IQ4SZw8lxBuEDj9jDbmuBLJvZVkQQcvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQtyAi4Wg7R4AvLtb1vs4IBd+YSYa7NVoT7pgn35sS/rk9dPsIoonJQSFWJsgLOok9qdEB8plAOCzhVjIH6z8oBo95TKQtYcAP1XxbdfgQ2bkWLLW6sl+hPfnlQPuZgfqp9YsG2Eea+NG3KO33c1UFZ3C0TuVM6cDbEnU1aJan8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6poHymM; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6poHymM"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-748d982e97cso2295964b3a.1
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 14:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751838087; x=1752442887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRWoG//ff0MWiP5lWHpxBF1qdq3rLh3uhRVq+9gd4jg=;
        b=I6poHymMfhnmbC/Ek0z4ZZNfnAgpHCTLpCMycKd70RkFBoHwuEZQEK7g/mgmY6yGSq
         N3M4oNmKfBrwBoKwMZaQHYVHCXKYoX2LNaxUy/72RbBQfX13wYg9+AdHVw6qLU5gUXYw
         IsUD+YxpTENCzpNOnwH81d/wMb41UC9sytSn4DvU9HnxSlR8iLUqQMxMehQdP4TV/kRZ
         MjR+zePvB7xkGZ4ODIcALekakq2fhLFWwmG5HDawGDHxolugUJSKog7uNmkb6WMETghQ
         UsmvJE55dzl70lakQFDHXDSdnhD5xJblVZLuiN2/tDQdIep0AGsxByElNgwuPOoBAiCx
         ZdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751838087; x=1752442887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRWoG//ff0MWiP5lWHpxBF1qdq3rLh3uhRVq+9gd4jg=;
        b=hjqk/R8BjkGMEhhKRqrOAJJSns0n5YHwjnvjfKfPsWZRmyv9qlSw2f1KTX+uRy3+Ma
         EBB/RUSbZAu/wqLq/UJSNOsmyC6baIymKdK1T0vbdzF8K2H3LOqSNNQYSArLY2aa5Nxq
         1HX5yDyvXowtNWHBwS2FRtSrsVv7Cd3sZqLsakZBEGymneIM2MxQsliyvnd04YolsL+W
         2AJKsDf3I0pK8gipVhM89/l7Kk1keQtKjvRhGJZG+cu+ySRs7SNbdiMAs8WGNlos9Ay3
         ajd3hePokatls2YpWTQheGNQPmDvLc+/kNhJw/S3N7J+3NVrHJdLKIQycRhlAHm0Rti9
         DXDA==
X-Gm-Message-State: AOJu0Yy6I9mB23P+fs7HKOnOE5u7ZAT4r5wOwCgZuCEcYYK8q7aUSnYN
	Qy27IpUrTP2vWso/QK1oPE454jqiwa/hoPlR7ZsARBKNgvC8VhkeDCUyaNcN+2M07a8=
X-Gm-Gg: ASbGncsAMT4rSGjke9gbfVs80DTbpbRSU/2lQDt71FF55dXbexpbrzLpmvN9BJhPBrn
	kLYbiWCsd+s2gIN/8RK1kKfNISyrK/ZYWldY6SFN6/37yqFD1j3jmmj2N7zja+kLTY0S7qiRq5Z
	0I4/II7vYhypJAXe9xV6dcVp0boFhNich+2v4URgjyNBEvJ03+EaqG5FdoCkLncFfh0piYma5qJ
	1uNNtBow2DSwaEi5zEZBVOnZtVxDoPzNwFCMA5o2q94yV4hvmFrb9tKH9P0P2+IGuWK4mzKCyOv
	BM/RWtdCrVVPpBB/Fp486rVEucwVnVl6HVGbTNx/Z5dKNH5hTxIcQgOESJ+opj2BRQJPqAls7cM
	AnMlhHnO4nFg=
X-Google-Smtp-Source: AGHT+IHJVD75M+hAYnP36bgN0EYCcnncmVKmTV+78alAsLbUBFsbip+ivYV+SubZqcDmIyRKiUCGUg==
X-Received: by 2002:a05:6a20:72a4:b0:220:19b7:9d6b with SMTP id adf61e73a8af0-225b800e7e5mr15411804637.9.1751838087113;
        Sun, 06 Jul 2025 14:41:27 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee60c55csm7363968a12.43.2025.07.06.14.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:41:26 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	usmanakinyemi202@gmail.com
Subject: [PATCH v2 4/7] t/t1517: move pack-refs -h test to t1517
Date: Mon,  7 Jul 2025 03:11:05 +0530
Message-ID: <20250706214108.714499-5-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250706214108.714499-1-usmanakinyemi202@gmail.com>
References: <20250706214108.714499-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test 'pack-refs does not crash with -h' checks that
the command exits cleanly with usage information, both inside and
outside of a repository.

Move this test from "t0610-reftable-basics.sh" to
"t1517-outside-repo.sh" since it better fits with tests that check
command behavior outside a repository.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t0610-reftable-basics.sh | 7 -------
 t/t1517-outside-repo.sh    | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 3ea5d51532..ffd8ecc0ce 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -14,13 +14,6 @@ export GIT_TEST_DEFAULT_REF_FORMAT
 
 INVALID_OID=$(test_oid 001)
 
-test_expect_success 'pack-refs does not crash with -h' '
-	test_expect_code 129 git pack-refs -h >usage &&
-	test_grep "[Uu]sage: git pack-refs " usage &&
-	test_expect_code 129 nongit git pack-refs -h >usage &&
-	test_grep "[Uu]sage: git pack-refs " usage
-'
-
 test_expect_success 'init: creates basic reftable structures' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index e04be2d811..5b4373f8cd 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -135,4 +135,11 @@ test_expect_success 'ls-files does not crash with -h' '
 	test_grep "[Uu]sage: git ls-files " usage
 '
 
+test_expect_success 'pack-refs does not crash with -h' '
+	test_expect_code 129 git pack-refs -h >usage &&
+	test_grep "[Uu]sage: git pack-refs " usage &&
+	test_expect_code 129 nongit git pack-refs -h >usage &&
+	test_grep "[Uu]sage: git pack-refs " usage
+'
+
 test_done
-- 
2.50.0

