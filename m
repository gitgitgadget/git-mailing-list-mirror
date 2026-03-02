Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794A739098E
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 21:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772487934; cv=none; b=fxIbbXRayQd8zm1LVbpwl8TvHtkCUHfg9S8FCt3bLOfEeEPTj32taWDjFpmLDvbOO8eMvr1g69gCFC1ZQ5g2uOU7JDkWZ8qUs3vXJg0f3SxH9LkZT6nlFbG04VaFZrC+7pfJ02oBrqpLWLSO+jEBJEBEM7T2gbDc8T0QV4VHGzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772487934; c=relaxed/simple;
	bh=AwiSKbGf+NuV10AJ9YSkmdh299qvBZYaWkfB75xHyVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqcfgSpG/8Kbyuu2eooeTl2LMWNoFo442VkQmN0h1wFxJIFSS6rnOPcB1qe13aGt96PIwCj6pq392URLs9+OeTILBOBd5pPUC+OD2Mibh/O2Kog3RNQue5l1g23tMcL4hKxLe/3SisQepARZxpQnVDUfimLDdnrydal6vozuzp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjBozn9Y; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjBozn9Y"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d596a5be31so4118361a34.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 13:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772487932; x=1773092732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUqBNHQQjpUjx0H5Lw2b7LYa8BeJzUdRUULEYPlwkhQ=;
        b=LjBozn9YS0wyUj9elzRKYfrdciNOKFOqy88PmI//8b8K7iYLfjSnEgCb3e9YTADjFi
         l2P4GtZASh1tLkNJy5H3QDDoQAqST4BkW6sbn3m8dtBHcgW2FhwWdAeLGS6G3CzwCSpV
         tb78/IRB2o0h+q6W6yKOxGvd8ThlwhcfE6Aq63GTDVWJ/pgEdQz7Q0Lbl0LmLCnnwHuQ
         GWmoQy1I1dF4XhIetJdzTwdXsO5sAbJuADOhlVON9PbOaE7chMSlo+7i/snDBHSJBVKM
         /gOLCsLEGe4vM53DSryPSb6ROmm2o68yTFxsU+rYcHtzwwiLDB92qo0XysQjpF3qF85k
         0nCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772487932; x=1773092732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mUqBNHQQjpUjx0H5Lw2b7LYa8BeJzUdRUULEYPlwkhQ=;
        b=bw5UDxYwUpVpNU9E3NZxBiFGWkl/SIolDAOqg9TIimNm+oewIcHLM0Z/YCtCEHpvWI
         1NgleO9MpAhr34MMH5sTdXiBi3dfYJIH76UURdJ97JwCinNmTwahATofpVmRXpaMO6lC
         m1C+7IphcUzQf+3R0wXiuubvu6D9t992MUNpX/F/FCHTQoP/FurMthCP1HehUPgeAJiB
         o9OBZ4hRbEzaH3fIOFO4SVBHelNrCL+uGz40aHopmCg4sDHfPOK5rXZVayGt3pVrGRqx
         pulhfAKxopO2vv4ZKVYFyG/4yp2OCs5xvJKGtZTswRxnrtc6yO3KZxDOcrxIA/5ssHBt
         T2EQ==
X-Gm-Message-State: AOJu0Yx4v0RwcIdVyteiP/wuHKEF9vDQKMjY9dSEyC/XkJtHW5HmFJcR
	/6O8P6TBy7KXQHKpagUmNq2+8I3oajX6pVwDkBCijs21JYXYmK7li0wSu5Z76w==
X-Gm-Gg: ATEYQzwSS/qQakVh0vcyqU0ruMZjdYF85mnzvcvNz2yuuQojxOmlvzSW6VzUeZy50AV
	ZAgVaXeOcGFU1n2vU8fh7vASF4SYjVTlzJ06+tmezjcvRteYZAe1EUAEqQVPDVpOAqDISyV9IK4
	jfa8KN6GK7f0OgM0Aar29qLgOA2MqQNGWn2x7oez15IQj9ee/nPkpSmpTnDJ8FR4uzRAKuQ19MI
	6L56527czgWKXW+RAm5YP1WJlrR6wf7yWrmJi+Xpzbu6Sr4alZCo5q1LQqUwb3TU2pK79ZToUBW
	c0zYoEwDFsFjNOjDwKXTK2xMuL2hNpxm7fd2cOgNEj4k4IXwYmd8WeChwks+Q8kFrcmFxPE1YWK
	P7/nf2PFuoXrffUPDKZaJqtbT/iHqYHReX1eJJ/6wQ8qaDR1W4TAWYJ3JAspYslXxAiJb1tj1hL
	OulWhimj1HTwWnmiBAatqiBrLC1bKsjL8=
X-Received: by 2002:a05:6820:620:b0:659:9a49:8fb2 with SMTP id 006d021491bc7-679faf3b77bmr8041426eaf.43.1772487932015;
        Mon, 02 Mar 2026 13:45:32 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2d84dacsm9775877eaf.9.2026.03.02.13.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 13:45:31 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	kristofferhaugsbakk@fastmail.com,
	lucasseikioshiro@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 1/6] builtin/repo: update stats for each object
Date: Mon,  2 Mar 2026 15:45:21 -0600
Message-ID: <20260302214526.2034279-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302214526.2034279-1-jltobler@gmail.com>
References: <20260223174120.2356504-1-jltobler@gmail.com>
 <20260302214526.2034279-1-jltobler@gmail.com>
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

