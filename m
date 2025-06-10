Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C07296167
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 13:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560586; cv=none; b=gvvjqn37EB0u2iY5fcICr1JT27cjfpT+ugj6CoyFIN89oygFm4MKPwq3WkKEg9fbilk9nCWRpvX8pgrscBpzA/Aims6p7jwrRjTIGXHZfvh1WJcZ8IJWn4kPrmM3NvdpY0riadQYDSzvlZ3lxZRKsQqQbPILXN+CnH5UbpgnDos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560586; c=relaxed/simple;
	bh=MPS5bZRL9n2C9ho+yW3ClWLba/ILAd3Cpmr09L8grtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzI6a+wJK3DpQwf2FDV7wDIGAzci3SYY3kE9D7t3jb1VmnbAD4/CWosddThSlork+Z68AvE27xgEhbb5+akWXOb+Vd4FmBAYEmXz0rAKVB6JtVwMguDVLcRr2nYdLOiCjs45GL0kTxiYX1gvPWGM8a7ehg/FqnFf9knu5DC8bFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luhF2/HE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luhF2/HE"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234b9dfb842so47972095ad.1
        for <git@vger.kernel.org>; Tue, 10 Jun 2025 06:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749560584; x=1750165384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rl3u4G+KrZG5DW7XRt6Id69tz1gNkBSu2Xp3FCwx1I=;
        b=luhF2/HEZom2UPDJXPeV5bZG8xG7s902r01EMJHv+cyvd+TkhJWVUo5jAcYiE9tl9F
         GH4s1xHFHmQP6AdP9GB/A/av9lDbalTGIxJcCsfEoSNDJXOiKOETCZaOHcy36r3TjDJM
         7dki2oYPcYX9P7/+8ezbao0CX8+kap/c2QJ/v1LxEJfGs6/J+aXSZ2gkgUqtnvb+bhBD
         quJ7aVLS1KPpdk01iKodVS5XfVU5FuMB24CYlr1hrCBCOdJ2J5P3xoJfxAUwwOIpR0Ug
         8zZNvS+n3LQVdeqR6DM5ruh+avuY6F3Ee8LLnc3Lr6ZLc7DaCVqP67NkpOh23ZrBxUe+
         434w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749560584; x=1750165384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rl3u4G+KrZG5DW7XRt6Id69tz1gNkBSu2Xp3FCwx1I=;
        b=f63vIYJ4jvpUT3o6nCvWNaIgaircA7di//8F/841G/aUJcnZ4mDgCCalLwVp8O+KFd
         ep/41QKeGSIsxVR761uLu/0BIBR2dBRwaGQ2EaBDlLSwQPfbTJVujAHZXw2n1QbS4yjz
         QpNZTGiPWLqw1LVnKB0FFVvx6/xVdrklbTU/suvD0/SjTkOqgJVywX9gJ/7bHh5tNFVW
         et1KUgzeVFkxBvaZz6mhPRnTZtMpv20+Bm3ziLOtcgjfvv/wLaIRnSciCjSJ5F3/s/XR
         smphZymnbq6WLmBmvPtOzv3uddAUjS4fWBBGcZ/zHBpK6+wNHrpdn+GMVv773TwVt9lc
         EKHA==
X-Gm-Message-State: AOJu0YyJDfy1mlWg3En48IQEvfHc7NHiisNI3u97MbUDVBJAprDv9BLM
	RrDzL364nDserU5gZNRw3NXuys7+3lVQPs9+gJ/2JT02WE9tNFyo27KXbEki9g==
X-Gm-Gg: ASbGncsi5w2SyvhFAxe5qlkJ39B5VHCfZ/3cykJBAMfpvsgPL4gzM6I0uBz5yH+n0dJ
	MT8zqvAmiTnit5GngwUOdm0bnwooT93eSsD9CvUiTuWkc/xJ6QZhJXxCzU91t04X2uVQkyWF5iI
	rslZUdgH/PeLSXDWg7lXriMwheafh9bs5SJfPjpTcuLr09BQmYUcqObamatcrLxyjdHxjfMn2Ar
	DeD5KVjCrcU11Vp9wscBcjbQKT9l81Yt/U+k5VN1dldRUMGFjyzZ/tyYBtF9WbbRkKrqVSedrRJ
	nRjoBs8AaK/SEW81rIAYArzKuv0lyxbRbEdNiWqmOFZ7Wq4D+AlT9y/5L6iZD1rvDXOWlftaUuo
	90Uxtb5R2kWxQsg==
X-Google-Smtp-Source: AGHT+IEIqgjvFTPKzFSJLNcLxGKyOWXk4D9bYAw4jH0dbraE3oW54xRHgEA7FpJwg2KpApmQURucYA==
X-Received: by 2002:a17:902:db0b:b0:234:c5c1:9b63 with SMTP id d9443c01a7336-23601cfec14mr201331995ad.18.1749560584115;
        Tue, 10 Jun 2025 06:03:04 -0700 (PDT)
Received: from thinku.domain.name ([2401:4900:1c17:909b:153b:8cf8:294b:5a5a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603506d58sm70338175ad.227.2025.06.10.06.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 06:03:03 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	Ayush Chandekar <ayu.chandekar@gmail.com>
Subject: [GSOC PATCH 2/2] preload-index: stop depending on 'the_repository'
Date: Tue, 10 Jun 2025 18:32:21 +0530
Message-ID: <505a6ee8a55397fc5cdfc6f003861f6fefab29d1.1749557133.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749557133.git.ayu.chandekar@gmail.com>
References: <cover.1749557133.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor "preload-index.c" to remove the dependency on the global
'the_repository'. Replace the occurrences of 'the_repository' with
'index->repo' and thus remove the definition '#define
USE_THE_REPOSITORY_VARIABLE'.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 preload-index.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/preload-index.c b/preload-index.c
index 9fee4cc3aa..b222821b44 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -2,7 +2,6 @@
  * Copyright (C) 2008 Linus Torvalds
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -114,7 +113,7 @@ void preload_index(struct index_state *index,
 	int t2_sum_lstat = 0;
 	int core_preload_index = 1;
 
-	repo_config_get_bool(the_repository, "core.preloadindex", &core_preload_index);
+	repo_config_get_bool(index->repo, "core.preloadindex", &core_preload_index);
 
 	if (!HAVE_THREADS || !core_preload_index)
 		return;
@@ -136,7 +135,7 @@ void preload_index(struct index_state *index,
 
 	memset(&pd, 0, sizeof(pd));
 	if (refresh_flags & REFRESH_PROGRESS && isatty(2)) {
-		pd.progress = start_delayed_progress(the_repository,
+		pd.progress = start_delayed_progress(index->repo,
 						     _("Refreshing index"),
 						     index->cache_nr);
 		pthread_mutex_init(&pd.mutex, NULL);
-- 
2.49.0

