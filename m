Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707753FB072
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774457348; cv=none; b=SZb4cbc1dv8PsbyzIFUYTMQ55wz6xrMNulBFna8wfm/6YINQjd74EWLmFOdoWfH/CMdiQS0avdy7gjgnHjW/fyX5WSsdnTgjV6tMtUnsknSSkJJ2m4Nh363CiKMyYWGCbXiEoeRcjG+dqXvwBkCzlGH9lVc8HeDPLERd59RFTwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774457348; c=relaxed/simple;
	bh=oiHn+xh9pIhd2i78ZlGT07EhBnYARhgUcp0FA7EM0uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8k4wWbkOTdeTB4nYrzJZqBpfXvnWRRIwfTD9ZNGP0KCwrXKMFU2/vDU3AmXO+6noIfnT1NxHKsGF9sbXBfBPzzwBYxdlKId9G3X89ilBm78CjfQjM2tSFMoOh3PC3CLSUMQFU3R0/FNQsomiBRH65MeCu5iaGAYv0aMhooGHKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+f0e0QO; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+f0e0QO"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35c16db1b53so44586a91.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 09:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774457344; x=1775062144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMWyzz2p3i469ydikqT1J3g8iglgnOf/wC2IbYVs7ns=;
        b=H+f0e0QOJ3Xf0KISdS5HGhrqB9SGL34e4Q9eKM5ORjg2GULyARYCQ3C5o8KngfEHHL
         JNZBdl5s5wrizToXJPdmtg5jIrgaZd5cRHvaIZ6Yv7xbpg8VCbWXSgiuCzkF3gtMYxvU
         21usHgBoe46E+seGBzUq6cBiMdWirDGb+kj5hVkMzH98gM9sP6S7qs++2M1vzc5kllyi
         XogK3FdXy1toVXgleo+kJDMTt/JhrlK8jaHMeMwvkugZzOtx/f/iQNVX1bDA4A+KvAq2
         +T1TvdSdlEp9POfFGy1+Z5WuX6LlMsgm1/H53xB03pzAC11WKZglOTIHybzvxZzalwc6
         cfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774457344; x=1775062144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IMWyzz2p3i469ydikqT1J3g8iglgnOf/wC2IbYVs7ns=;
        b=hyTiT7Fee4Ug7FiXqUSG82KT2s1OTO6XCa0iJwGaMkfYoc5ifDIdJ12c2+Of97nMbC
         Og6Q1ST5IKPgwBeu/2iRSZ2o3XCK/5XV6MDUusVLG05LLOyYJC+jfXrEWbUaV4QxWngc
         b7LFjw1XMzCRl/TLFL8o1S0xAd0MXUuOGy/pi7Oy8hzqkax2RVTWaC7P4jZfvZakZRcu
         z8uKCPGAa2RxMIrKn9htdS42Ruj+LelGH12YKy6U2RzAn2PByGVo2GzzUviitHKbYA7L
         KbBLhjntCTKPOapiBlGp7YDPSC8ZVp/dUSRR6y88AQnk9SfGF33FZRwDqQQiIkgylTYM
         t68A==
X-Gm-Message-State: AOJu0YyQKrZ5OMyApS4sHc++wc/8XZ2sTmr2TG3iyOGxygSgdFwiTWfO
	pGl2WGrGrLB6pT8UDNLLjyhWaM0AZ5csCRbcSjnC+DYIdmkw4LbopDuKw79pcA==
X-Gm-Gg: ATEYQzy/i9xFh9I1YTTVg60RMjGmpDFSZOPDVYFVL8StbbLZMSFeX8t7Ut9DHwWNCdx
	CKCS7xValoHdhdQgGusYS+UmtZ3/CtEOc3kxLeUfTZKg5eZN9hOgCRztn2FiNOs1GbRxXLMLeL0
	Ah1FPjhB6O8mKjICUezE2udTw+0ZULxXO3s1MKgjkKNnZAgGPF3tt+ea3R7pMKKNt5yCszAhtaM
	90YJFAoIRn/j1Eyp+eFAn6pYiyhjvwbolH6/PXbCUNUDqUvF6LxW32cNH0+A1Z6K6Ii0ETDRU3L
	EjEQx5k1mWKe0vAdoaQCmI7PP87pA2BjNL/ZVJBWq7UoBAaKuFH3K1ShCI+ynQct/WdSGS/Cvel
	jAQQYlSjgc7AYKypuSRHHRY5VihChBsrIEG36OTi2fHhEHEXzKJz/04xb5slxTHxG1OrI2YZOm0
	ZvQLjkwgFqf83qgLd/WjYK/KcU5/seBb1tZSru/fAWymk=
X-Received: by 2002:a17:902:da88:b0:2b0:9101:1b77 with SMTP id d9443c01a7336-2b0b09bfca3mr48124125ad.17.1774457344188;
        Wed, 25 Mar 2026 09:49:04 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:88eb:4aec:6f26:76cd:bafb:15d6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76ba80sm3901275ad.2.2026.03.25.09.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 09:49:03 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH 5/5] refs/packed-backend: use ref_store->repo instead of the_repository
Date: Wed, 25 Mar 2026 22:14:22 +0530
Message-ID: <20260325164833.1216577-6-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In refs/packed-backend.c, repo_config_get_int() is called using the global
the_repository, even though a repository instance is available via struct
ref_store.

Replace the use of the_repository with ref_store->repo to make the code
explicitly repository-aware. With no remaining users of the_repository in
this file, drop the USE_THE_REPOSITORY_VARIABLE macro.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 refs/packed-backend.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 23ed62984b..ebc10dab4d 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "../git-compat-util.h"
@@ -1223,7 +1222,7 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 	static int timeout_value = 1000;
 
 	if (!timeout_configured) {
-		repo_config_get_int(the_repository, "core.packedrefstimeout", &timeout_value);
+		repo_config_get_int(ref_store->repo, "core.packedrefstimeout", &timeout_value);
 		timeout_configured = 1;
 	}
 
-- 
2.53.0

