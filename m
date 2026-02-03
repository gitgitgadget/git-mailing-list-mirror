Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB84431281C
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 22:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770157117; cv=none; b=YunSsGEfzuVPYTReDNr9tOv2b4EBs83c2RY1IR58nQGZJgAhU7hOdMKX5JZMmn5PjYcrncrhNsFzzPyiYmefhaFes8aXPRwy4RqjQhNmLvxTp/RsyjVSpwZ8+ITNPtoANkVbH1EQGWRMWm0IVmaUTb900mi9D2ysysY75mGho8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770157117; c=relaxed/simple;
	bh=AwiSKbGf+NuV10AJ9YSkmdh299qvBZYaWkfB75xHyVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtiwKbGpkmUFLuJ9XLFdToygD4a/sPGy2W469+wW0nt0LU8X07opywczb+Bv2v++4mV3QPQrABazPZmr0MrQE0ysnxNdhLHG8C2uR8/9sookIsj1e349HkKdZKRD3Bfj0pgIsiw6M9LjG++Br2DfyI/g3M1E4mnqJGZSNofxeS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrDClr4A; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrDClr4A"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-408778a8ec4so4078061fac.0
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 14:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770157114; x=1770761914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUqBNHQQjpUjx0H5Lw2b7LYa8BeJzUdRUULEYPlwkhQ=;
        b=jrDClr4AVgYfN3+GkX+EmUYyAXk9buueSwcGDnI33h8DSb9ft9f85fuZjSPM0MZ1px
         H0u4CNDwpZJRsz4Gfegx3ClPijfJ7l2RYGulxlK0A3I58QrYcp1SnKIuTaNhXf9N1Un9
         cEvsTHNSfqaZFF15Gc1jh04HoQEmYf+pzrtdl5pOzgnpT3vgShu4VfPaiq/9Yw+kBEsj
         TYXesB2Y2sqcBBosfDYY282e7N6BFEBhjG5P4OaLzw54FfamJoYOdAi2HxxYLIZYXGZ5
         /iuelEJLjDC0ufyBe7TGdgJbfCXzNaebXV1rwU4AwLEnDWTh7sry/6u0d+wWlMxeRYvz
         +YGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770157114; x=1770761914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mUqBNHQQjpUjx0H5Lw2b7LYa8BeJzUdRUULEYPlwkhQ=;
        b=tyhHTR1awRq+U74jLuzsMDH6pvKoa+olbZRqy0dLLuQyrtacX2F9z57+tUa9X6O2za
         hbQS+cssaKtmh8n67TYJzVrGFsYaP/Hgv2b2PSbKjAMMuUc7hHwwrIKkwuGBSF7R10vj
         9BEDtyh9zu8jpSVPP3mCv2TKo4XAewt8aF6rrlmVr9wIc8pqPG7DlsxJVzGo6LcYbyLk
         l+ttxfnu5tDHSdwetIvJSKbGj/6ziRJG7NoqN7d4336YZMvBwJdFdtHGeaRnHhTv/hB1
         yTjXETu+a+/1vmYAEuv9T3oEUpDbR2vZgLkJNlBz4TorazE1j9/3Hi/+StivhO2ika+Z
         0Zbg==
X-Gm-Message-State: AOJu0YxltJnbdGk7HHpRH1lGrykKXc6ZyT65V8gE7W98/c3xsNpGoaoP
	4roKRDakGYGUC+wYICbAks9JolggdWn1Q9V5ajIlx+ay7Zn9jkGQRvqYAGKFcg==
X-Gm-Gg: AZuq6aJG88g3Jm1jP8zo3k3fNe7YA+3BM0mloVmfUQXSikTdj6+Ha09F9CQr2kWo2W5
	TKhgc/OaQDgZwXIgTgzFrgdHSEKKo2f9Rm8WBVp2L2a4grCdC5t/7penjVSfQqXGFyOBnpckVZ3
	p1fugOSJMX+8DdAyE8zzl9ZOzMJCoSe4fHjEql/HvIcyEKdXEw3eKItBEh6rjzTciWxV7VGMLMK
	rKaToxLqJ16XOPx1Z4hZdosOe4T/c05a5O3L9g81gxtFUzytuYyuFQDI7V8Wydd4HhCERGh/JhE
	EsYbpP+rthovw1j2SAOHBMWWUysDgF1ujLVVBjInZWj+pfV+Uvm8DyBBErDNeL9fKrRMXUiuB0b
	LiZUz+swBEvx6cd5lILub+EVUt90bbuSjtopTKWt1sCnwlKHl5/SlxCSC2XjVSs5M3Tdj+kxo/g
	X3FPgwqSgVi+EwcWi1kWA=
X-Received: by 2002:a05:6870:7091:b0:409:6da8:c8f4 with SMTP id 586e51a60fabf-40a53ac8ecamr487292fac.6.1770157114402;
        Tue, 03 Feb 2026 14:18:34 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a53c3c4dasm479042fac.0.2026.02.03.14.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 14:18:34 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 1/5] builtin/repo: update stats for each object
Date: Tue,  3 Feb 2026 16:17:54 -0600
Message-ID: <20260203221758.1164434-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260203221758.1164434-1-jltobler@gmail.com>
References: <20260203221758.1164434-1-jltobler@gmail.com>
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

