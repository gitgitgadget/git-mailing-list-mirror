Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1C1288518
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 21:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838663; cv=none; b=Zqapr1357eTWzRze5dyvOX3uZjblt0ulnX1W7gfoIGHvffptUCVf4zMNHDQs20NS7JboI1IPJVoYaiXpG1Tf4pTPRWZdvI8ONulFnbD/Bu3MojGYz4vkUPmwM7C9vZRQo2R+wf1v+4/vu3PhllEoKNMip9eQZpJirOFMWABXco8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838663; c=relaxed/simple;
	bh=FTlOqTxFaAH/rnAXtLfM78PRiP1tbwPoqkCbnYXOcQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDLO/cWrjXNL6WbuzSZC/R03w8pFyb0N84blbk14Rm1KVHqFdZcB+qbJ0xua/xqb87gX1EH1QZmKzdP2zEEvPJbMw5VClkvgmsoqGoKdt1op+pOM+5WeTiJFDAR/Fw4UCK4g40PnEkhF5kwOfuGr1UZowxBDSWEanU1P54n0l0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwGhk9kN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwGhk9kN"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235ea292956so21221505ad.1
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 14:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751838661; x=1752443461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqSPsuofsApec5kHULRBpHlXR9K5Y9o22PySstS3aXQ=;
        b=bwGhk9kNtT1UmY0wyWcTJQSVshRoY9l2XJzHICLckdsHegwrFdET27NyFXuZQOUaeP
         nWOjz+Kr6QZISzBHb/DpsYH+luE12LdaJ1LC7Rd/AbKLHjT3AQ3hyUXF7cMGdC1D0fwu
         39mrgF+zUc8HZkxclzU/u7jLMDdjCpycWkQTD+k8BKZApUqXehraQ7CXDRcXAHx2vSiH
         u9ezAP+Eo84CQWDlOnA3bU3YVqee6HlltYP67Zu8oN0a8SkO8Q9m1EyaaSdoqiX1FvZr
         KQNtg96Z3zLqNdqWH5gZnj2ftZDJp6+L3QrXLHt4KFgh25K1wt0xhGw2T8jTSzKYrl9m
         W/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751838661; x=1752443461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqSPsuofsApec5kHULRBpHlXR9K5Y9o22PySstS3aXQ=;
        b=FJMQeM8bcaw1goDUS9+4TGGpjG+oJyWUGnvs+5l5I67M6cIgW5BcAjNnLZBKYcUx61
         K9ijxPS6qWbSewXE/U8YRYo6/SAd/c0BSyBgGV+9Y4Li5QA5eFV9smIawY2bxArnUP5I
         I89A5F2nWHIwCWFmwg+VFVytPwOmUJdG6Ci3eza+gmqFgPe5a+2xCyBAEHCJRA1Gkll6
         VFfvupYCX836hBBmEy5to9PiDyXByzTe20KkgY/HJbWmw5ihURjYELqG/R1ioaceh52O
         RzfrErHMJ9Guiizo98sIqql9T7eIqDJuEVJbRfzfKUg8ZEDQrPVnYi9YYOiFLbbagVCi
         IDaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeJJ/A1ymuwoAaql7p5aOMLHJRZbckaSZ5dYHR0nZRWnwOUUKXaK7tBr0voIYOAjas4ro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqed/34Ulz2jLnOIBYa/sze4dEzYZqqwoYVEN+oGRXG6h5R3T+
	WEXrE2Tk/DMXVWKmjhwRafx3k68OzHRFchUZr6uIXIOmFh5q66Tq4+WU
X-Gm-Gg: ASbGncujNnQnhKBG9gglj0Vly737I6TLSaZ+9RbbDF6qBBpxSi6C3+LahveMUlTJaUd
	OF+Y724xcz0kWIkGV5bPEz2crKRB+DqqEd4hpMqDt+2VaxQ3kVDcuZQ8n33+t+vHNMhQpNWQc9I
	j75XmaKFR6RGa8/7OotO0rw/MqlnC8/nUacn4YB+Vfoa2C2Gu9L7cPR6jnxLPpwPCwMml0VC5Ga
	xKklr5nm/lvaA6fMzTeEI4LMGlSSncQgAe9tS3PrVzy145J1+MotDR+I1Cc9jNDXXl600zfHXTz
	j5JbZoxBYCMWdneKVtKxFA1gqnD/wg0bxew7nmptMTn50UU0vHsWNDAGPvSzMrPm++FVja4cHBR
	5gtge9ZIeNN0=
X-Google-Smtp-Source: AGHT+IGnXncBUQWFbpj/MetL5NnpHLHjnCSKeSWLuEEo8b75PR4Yg35JMR4DPbW6LRCFjiSNJVkTTg==
X-Received: by 2002:a17:902:ecc5:b0:234:8eeb:d834 with SMTP id d9443c01a7336-23c874761d6mr166907635ad.16.1751838660973;
        Sun, 06 Jul 2025 14:51:00 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8457f308sm72912335ad.149.2025.07.06.14.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:51:00 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: usmanakinyemi202@gmail.com,
	git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	ps@pks.im
Subject: [PATCH v3 5/7] t/t1517: move send-pack -h test to t1517
Date: Mon,  7 Jul 2025 03:20:37 +0530
Message-ID: <20250706215039.715732-6-usmanakinyemi202@gmail.com>
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

The test 'send-pack does not crash with -h' checks that
the command exits cleanly with usage information, both inside and
outside of a repository.

Move this test from "t/t5400-send-pack.sh" to
"t1517-outside-repo.sh" since it better fits with tests that check
command behavior outside a repository.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t1517-outside-repo.sh | 7 +++++++
 t/t5400-send-pack.sh    | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 39e7842c9e..2568f8ae0d 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -142,4 +142,11 @@ test_expect_success 'pack-refs does not crash with -h' '
 	test_grep "[Uu]sage: git pack-refs " usage
 '
 
+test_expect_success 'send-pack does not crash with -h' '
+	test_expect_code 129 git send-pack -h >usage &&
+	test_grep "[Uu]sage: git send-pack " usage &&
+	test_expect_code 129 nongit git send-pack -h >usage &&
+	test_grep "[Uu]sage: git send-pack " usage
+'
+
 test_done
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 83b42ff073..571e8f1bc5 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -55,13 +55,6 @@ test_expect_success setup '
 	echo Rebase &&
 	git log'
 
-test_expect_success 'send-pack does not crash with -h' '
-	test_expect_code 129 git send-pack -h >usage &&
-	test_grep "[Uu]sage: git send-pack " usage &&
-	test_expect_code 129 nongit git send-pack -h >usage &&
-	test_grep "[Uu]sage: git send-pack " usage
-'
-
 test_expect_success 'pack the source repository' '
 	git repack -a -d &&
 	git prune
-- 
2.50.0

