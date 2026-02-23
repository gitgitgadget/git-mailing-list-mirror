Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D7533439A
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868491; cv=none; b=tYGpWC00qT4T4rRsVyJMWOIAvuoiKWOLma3jKpNeU1IPHaAeWZKpOZVhnAmMi9DvWcKKRTJR1I2Zd0owgYlQGOZ8Ty4OCOfW4sBrkuz1bSvRUcbnhE5PNm5JtIz2okTXpz2DKzlLvDlZ/PG1EgcbFXyNyZxTr392jAvrewE8c6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868491; c=relaxed/simple;
	bh=AwiSKbGf+NuV10AJ9YSkmdh299qvBZYaWkfB75xHyVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSEGL0/Uv7L8L0vdVAxScNDrLZz5AouQyy0CaLfxUh2MheKnbKQCsieJXNbU6y6L/KRoK4RiKUjARBFzNbhpvSJiKvB/Ysu5yCftfOhjsonLCRVxsF/kHgQAi6td2ZwJREuuuWwkOeCPSom8IMoE/iZn9J1muDwI6PqFd2VokGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViFr06Cb; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViFr06Cb"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d18f80b5c2so3909347a34.3
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 09:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771868488; x=1772473288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUqBNHQQjpUjx0H5Lw2b7LYa8BeJzUdRUULEYPlwkhQ=;
        b=ViFr06CbcqqtdNlsuKgV6/9UNIUon6Hzgwhh8gPqCWoPcTGcSvai6+r9rmZbf/sjXz
         ycX1PZ8XlbduGaIs6x2PhZ6aH0aJYJ9YYc6F8yGnIyS32arCvP9LCiAeGBFHPh3dvMCx
         uH3JofSL3V6A/bRxAr7PVaOfHYLGHCz0EJZ78Svs1krQy10Un5fszlLaRnpt88lpfgV+
         /32q5gVMCprHZ6XPU0fKj0xS4a1eMARQXeH03R3smhlHPO8MyUESM+0hqLliNMdktE+D
         x9lmBhfvFmst7Gl0SPKrMansHlKq4L7sKVsZKwLlZNotHjffR0AWD5C21ntBJPunWnin
         dKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771868488; x=1772473288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mUqBNHQQjpUjx0H5Lw2b7LYa8BeJzUdRUULEYPlwkhQ=;
        b=QAJqiGZ1QXXqYxzRvG61HMeqCUYHyA5xdhR+h4/hFFKqsJtbdFODbglGnLy9bLJ9FR
         f/g0k0ABrvHjKFb66Dd/nb4hvN4liNEtvqBCH1npMhs4+aSWTN3z99V3cg7/fSICoynO
         XbBNWoe4h1qrfKCAZ+pCyQ8NaZYnrXj42NLpd3LwRvdKvnC/JqMiBQw8HbGhPptvTP42
         cUn+bElhyxqS4gFvFF12/r4j9EKIRE4EqBcNqsdJZpsvK1DvjaO0s/SS2XH9qlpU9Ld5
         wcp9ykDJos++62+ZblUOoETsPcOw10LRDoCII2kgGSy6W2z8VeVwaiaCEwH2HU1rJxVt
         3W5A==
X-Gm-Message-State: AOJu0YxKuad07BIgdpXKXSLQFNgP7pl5W5uY2IqZVVBqpFyvuPm9X852
	YtSeHnDAqIKLEqivvlckzPUye87D6KLqzDXf9ycgEKBFH2XPqqZakBMHPDLVRg==
X-Gm-Gg: AZuq6aJAWKLXGgzLQPNhc4Bhd5AxePu1DP+F5iKdfjjOq8dfzP0U8tL9jJ5ciR/zqld
	rkCiLe7bmVZ85Hii5MStieT1CYJHwrnBzoWYAH+GX/JGgZmbIAqS/lYx7NPHx/zJ9nzfMwFYUzF
	kTR1Sb7bF/PMsg4tib2sz3ypxT/0S1eeBNHpyY5tO87P5Xn9N3GLdbr31mG4X/+vWJsy6aV+4bL
	Lwm6VD09wId+6xf4CZUcgGLT0ezPs2vnHOTUDiYezvFhZ2aYyh7m5LyKiBYJ/vK/x1pNbzbVSTC
	OX0oHRSX5cScqeFfOnABjbanwhtYYmtrflR3vmcJSPosaxU+Z/QOs6xpjWd4wXIhVeOsCAJRz5r
	Oupwhd19IZwGrC5bJNIOpDltfQxS5b7kRnTggfLkGMKFK+xYuTid40QbHGW2IDIe19PXBL33fOt
	PSbPrfUgZs8snJrBsCsw8go7bpzB9eyxw=
X-Received: by 2002:a05:6830:dca:b0:7d5:1532:228c with SMTP id 46e09a7af769-7d52bf16283mr5846688a34.23.1771868488558;
        Mon, 23 Feb 2026 09:41:28 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52d0386c6sm8305476a34.13.2026.02.23.09.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:41:27 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	kristofferhaugsbakk@fastmail.com,
	eslam.reda.div@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 1/5] builtin/repo: update stats for each object
Date: Mon, 23 Feb 2026 11:41:16 -0600
Message-ID: <20260223174120.2356504-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223174120.2356504-1-jltobler@gmail.com>
References: <20260203221758.1164434-1-jltobler@gmail.com>
 <20260223174120.2356504-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When walking reachable objects in the repository, `count_objects()`
processes a set of objects and updates the `struct object_stats`. In
preparation for more granular statistics being collected, update the
`struct object_stats` for each individual object instead.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/repo.c | 53 +++++++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 0ea045abc1..c7c9f0f497 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -558,8 +558,6 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 {
 	struct count_objects_data *data = cb_data;
 	struct object_stats *stats = data->stats;
-	size_t inflated_total = 0;
-	size_t disk_total = 0;
 	size_t object_count;
 
 	for (size_t i = 0; i < oids->nr; i++) {
@@ -575,33 +573,30 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 						  OBJECT_INFO_QUICK) < 0)
 			continue;
 
-		inflated_total += inflated;
-		disk_total += disk;
-	}
-
-	switch (type) {
-	case OBJ_TAG:
-		stats->type_counts.tags += oids->nr;
-		stats->inflated_sizes.tags += inflated_total;
-		stats->disk_sizes.tags += disk_total;
-		break;
-	case OBJ_COMMIT:
-		stats->type_counts.commits += oids->nr;
-		stats->inflated_sizes.commits += inflated_total;
-		stats->disk_sizes.commits += disk_total;
-		break;
-	case OBJ_TREE:
-		stats->type_counts.trees += oids->nr;
-		stats->inflated_sizes.trees += inflated_total;
-		stats->disk_sizes.trees += disk_total;
-		break;
-	case OBJ_BLOB:
-		stats->type_counts.blobs += oids->nr;
-		stats->inflated_sizes.blobs += inflated_total;
-		stats->disk_sizes.blobs += disk_total;
-		break;
-	default:
-		BUG("invalid object type");
+		switch (type) {
+		case OBJ_TAG:
+			stats->type_counts.tags++;
+			stats->inflated_sizes.tags += inflated;
+			stats->disk_sizes.tags += disk;
+			break;
+		case OBJ_COMMIT:
+			stats->type_counts.commits++;
+			stats->inflated_sizes.commits += inflated;
+			stats->disk_sizes.commits += disk;
+			break;
+		case OBJ_TREE:
+			stats->type_counts.trees++;
+			stats->inflated_sizes.trees += inflated;
+			stats->disk_sizes.trees += disk;
+			break;
+		case OBJ_BLOB:
+			stats->type_counts.blobs++;
+			stats->inflated_sizes.blobs += inflated;
+			stats->disk_sizes.blobs += disk;
+			break;
+		default:
+			BUG("invalid object type");
+		}
 	}
 
 	object_count = get_total_object_values(&stats->type_counts);
-- 
2.53.0

