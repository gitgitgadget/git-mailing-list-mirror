Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D12F2BE04B
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 21:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838083; cv=none; b=CnxPUi5EEIIU00lBexI6XmyM2jkCv5YppLOjWVD+3KUn3WzTTxGrPO/B0vuQVZn0CmjrvNgIzro3436OqlRv0SAb69GRhE7N+TSomC8iiQLrLOk7K4KuqZvh4DoT5WgPFyWw5UtfAHPjn7ZkT1WOyvzJ3CfVRzF35wd2eXJCMrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838083; c=relaxed/simple;
	bh=dy2+NJGSchTWSrEfUVkYakgaTxZXNpF3vmFysG+xB9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mk80l7t1y4m/2Ey8fzYYjJVGVtnn8Azbv/jDR5pOEkVfzHBZ7+RIsG16lJm2KNQVg3epBDCQTh1IwjmaN9ySCn4ecERxOQ0QDDR4L3wrL0I2LJT12PzMdqNpuqU5tvnxnXqL1dSkrx+HeupmKkOePyv6HrNDmeQmqSK10yqbqxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4ILmcbf; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4ILmcbf"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-73972a54919so2100987b3a.3
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 14:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751838081; x=1752442881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhSw9iK/XJJzbmXSFpcqY1YVf6vcxjoslpXI9bdxXmA=;
        b=T4ILmcbfBqUsgDr5IryczChBTE3nDNS9A03U3hw4GRDIfGgBjJRgJUyB4CG1VMDtyT
         1/9oDT3q1+dWrvgN9qjPWRzORxOJuJXGd6Tc1s4M9kzr1tL5xU2PdOoqsCtEbaVd9jVn
         WeG0iSyIqpAbWx07NmHJuoCDZ0Bxo3H3y0e70Dpnh6LqMguW9v5ODHfYm3S55Qt520/k
         KC7cw7UsDXKdcuxtGE6FdkhnRN/bDdudOkP7CZQjjOVPHaOeCKdyxBNhSiUmF27eotL0
         ayc1d9pnQikWMrq9PbRVov+JMMxPcaXHm4HkYgp1dzjTnY2GFPFNwcTUL94fn7wLu5lt
         erEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751838081; x=1752442881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhSw9iK/XJJzbmXSFpcqY1YVf6vcxjoslpXI9bdxXmA=;
        b=b8oa3OHDHR5AoRZmkuTK69N8/QUGZcT8ay+w/HpEcnXXorqNWPxbRYQSesoJ4bOY2A
         dLGvSoTLqwwsRO5t9M4R9WOBit7dBdS6TfcfdMD0w0cPXfSOIErL6a2FYUaIFTEKZRAh
         Fgh1Lmb0dvl8Y0yfWL8IGQKBAaQvn6yCfR3KE1IcXc6HsWmRcJzUEPBBAGu5CnYvSJdT
         x+AyKimcxY4XkGgLL4bPw8KdYOEHVwgKuHphk+o6zfW1+wjz1qOWMJZzn9rlbi65CNAR
         fuVGSsRWcgVlai6t/tWnQTAx5bi3uAZlkWC3Ye7T03FexY2ps7HM1NqKB7lKUJkRQAX/
         FsRg==
X-Gm-Message-State: AOJu0YwcrUTFTjpSMzIBMhPipRbgMnM2uzcHzH5sHvmVyve/jUcOv2OP
	iDrBJQXLP3nPYBEFxXhkjUsLBInNSzIl8bLNTNqXOOD4YB78fKOOlBuNafdyN1ifhMY=
X-Gm-Gg: ASbGncsicbc4VvcQAiFMTokX3rMUR6pS5rtVxSwJYosq+ZbU77ZhLhFIIoDwfrQ2Lds
	MU+9XN/+c++iphb2tnBubCPSYtC4yp5uDErPmfqFfpggiDdjyfbgmhntHCtqTdjZRNb/dZSMqw3
	aw/g8cjuvSZF2fvTtWtQlKDSt5Gv/5IxFDulPm29ilRfOG+rRfC/nno5oTbchqjvRn6VBfcYcNU
	jrTx5kpENhZZhVkO7gv4HmITa2pr/gUqKBG4UjQfLij8dTOAgJU/11fU10QaM+zrUb4J97oIxgl
	HpePc9Tl62NtVU31jwZcvWW3FpMXlxbj/D/7SYGRxC19BX1nSr0/R6aIanw+Ptpw39ZsdBSdDGh
	PRJxdjLIzeqQ=
X-Google-Smtp-Source: AGHT+IGHbSRKUHwpu21ZCdfgkJ/PgeZp6jYS2Ebt2qMKqfOYo9h+6ABIRBoRi9JX1j0S6w7RWoGRzw==
X-Received: by 2002:a05:6a00:21ca:b0:739:50c0:b3fe with SMTP id d2e1a72fcca58-74ce8842197mr15961958b3a.8.1751838080766;
        Sun, 06 Jul 2025 14:41:20 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee60c55csm7363968a12.43.2025.07.06.14.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:41:20 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	usmanakinyemi202@gmail.com
Subject: [PATCH v2 2/7] t/t1517: move for-each-ref -h test to t1517
Date: Mon,  7 Jul 2025 03:11:03 +0530
Message-ID: <20250706214108.714499-3-usmanakinyemi202@gmail.com>
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

The test 'for-each-ref does not crash with -h' checks that
the command exits cleanly with usage information, both inside and
outside of a repository.

Move this test from "t6300-for-each-ref.sh" to
"t1517-outside-repo.sh" since it better fits with tests that check
command behavior outside a repository.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t1517-outside-repo.sh | 7 +++++++
 t/t6300-for-each-ref.sh | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 98a453db58..92ad159b58 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -121,4 +121,11 @@ test_expect_success 'checkout-index does not crash with -h' '
 	test_grep "[Uu]sage: git checkout-index " usage
 '
 
+test_expect_success 'for-each-ref does not crash with -h' '
+	test_expect_code 129 git for-each-ref -h >usage &&
+	test_grep "[Uu]sage: git for-each-ref " usage &&
+	test_expect_code 129 nongit git for-each-ref -h >usage &&
+	test_grep "[Uu]sage: git for-each-ref " usage
+'
+
 test_done
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index ce9af79ab1..5db7038c41 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -292,13 +292,6 @@ test_expect_success 'Check invalid atoms names are errors' '
 	test_must_fail git for-each-ref --format="%(INVALID)" refs/heads
 '
 
-test_expect_success 'for-each-ref does not crash with -h' '
-	test_expect_code 129 git for-each-ref -h >usage &&
-	test_grep "[Uu]sage: git for-each-ref " usage &&
-	test_expect_code 129 nongit git for-each-ref -h >usage &&
-	test_grep "[Uu]sage: git for-each-ref " usage
-'
-
 test_expect_success 'Check format specifiers are ignored in naming date atoms' '
 	git for-each-ref --format="%(authordate)" refs/heads &&
 	git for-each-ref --format="%(authordate:default) %(authordate)" refs/heads &&
-- 
2.50.0

