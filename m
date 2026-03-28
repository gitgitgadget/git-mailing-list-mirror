Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03CE2FFDEA
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774707163; cv=none; b=kxDDcMbBsc0uk5CL0882YqObZpoO5CL3Tl4aJyK8FYj75t3KfePx3P/fzp5QrwVj/Eg39HkX/xe3YyDEIKH79agWa6woX5XKCBw6X7OAnGOTUfttlR3f1ZHLvd+spCj7kzYAcgU9bDD6zoOTCvgAShdvkKFLW8oQGfODiVpftoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774707163; c=relaxed/simple;
	bh=oiHn+xh9pIhd2i78ZlGT07EhBnYARhgUcp0FA7EM0uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKnp4WN9hyV3uSAlFFkuUQTsYhMfVjzh6WHTlMM0M6Ho86123WGVIHn5BXjFrL/icgkmUvoJfwqvUXS5xoOhJVc/Ube+8CrIgOFfxbM+4eDVBGV/8qgqMw/lcCXT/nOs7tLskceesP5laImuYpjpOJl1VXfrvWMB1NAfe0Ic7cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fz+y+//3; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fz+y+//3"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso1332783a12.1
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 07:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774707162; x=1775311962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMWyzz2p3i469ydikqT1J3g8iglgnOf/wC2IbYVs7ns=;
        b=Fz+y+//3MRRD/75JWSzHYe7fQ07yX3qMnidSPuNkLYoK9EjEq6nVdt21pa5GtkZHY/
         jqIY8natjBQ+oJAcfihEVpgHS7jtnKzcvuEox+QEGunOWpzMOUAgvluRj01VSEKgA+JB
         Es8cxxnsoSX/ms6ISJ8Sz0EjHGJkLjwjz9y+Mvz3Ximvt422LYBzIcKYksZ26YRRAAXY
         kOGOoh1p30fTCbxfMkmJJTVi33HXb1U77P5Vb+sYF4ZxaJHXutM8isIp8QZ2//I93Try
         Hjsj3OpH9goIA21/Li6hr1zwop/OKeCoooUpwiZlK8uFjJpZhg152RwDiNJg43pCIeWC
         q/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774707162; x=1775311962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IMWyzz2p3i469ydikqT1J3g8iglgnOf/wC2IbYVs7ns=;
        b=Qx7nTjjA3E2nXunuB7mieFSMwI1i7Yv2B0eLDFvUV+8KvxJQhmjP3E+/Iu75Czh1L7
         hoQGxgl9OSMUT7PlQEwkRNIInkCaKJGagbq7DP3ZQ5XkTDkl3Uuy6RNE7R7UtZshmXoi
         F74wHrG+el5QQs6FnjIUpTtOawxuAtmkFA9xpNLgcrSz251/PQJImOrkwOXZwVsD8okm
         g7SnHmvVfkB2rNWG7rYzlfBx/Fv3cGPV+kCCQxcQLL/qHbBn84WnN/Oor3RcN45VS5Eq
         V5TGRAegOnAmvCgfIBHxkFfhWtEw062bqKOkWKUoQIl6CxOAF8NBm5iGpdwVbfOM0smw
         lhkg==
X-Gm-Message-State: AOJu0Yz0rU+wE0OUOc0uGEkGYJRVlZQb3aq+bpSAZ5BwzkTyw/udM1II
	nYa/zSg+p00u3NmjggqPEb9lgYzKCRqSeOZLp2vxKLgCm3HY3eGZGHzybJyz7A==
X-Gm-Gg: ATEYQzzi4RcCg4wT7zDFTE7fZRs9aM6Hej/tj4yUKDwdEPOL7GF7rEXw+Vr6Iv67wKe
	1QAtkwKarxUeYdRpeNLPF2JiujqDQSxdMCA9C4Jgg5mnicioUtC6zTjDk5IN6tm8D5rVIG+wh4k
	XL+llRiu6MADqoUeOcGfap1bytgAlrcC3sBe+l+uVTBtWgH3aN3WpEKRQHA6sQInLntB2wHjR0D
	eFR0eISIxDQd5//CdNVpgIpj75FncwoDx+zxLJBhXtNKY74URUVd63UJpRQDyTSnstcIIUyzztd
	A5aXkwou+iL81GR+xQBdUTOGdvA95X5kwU3oIEi/FrEO+8trFtV4rb7liJYJ+OPxyjRkrMhp2zB
	ekc1UjpjwuSker//IlNkfZiHHzoJgTIcVnjK9l+smdyaUPKjWY/nIVRXeqXoX5SzgohSMeRmXNO
	WR5IzkCDMvsPVfvaevRTnMsR683pSUs7OAVgoLpJvsXg==
X-Received: by 2002:a17:902:ce8c:b0:2b0:60b2:4f8 with SMTP id d9443c01a7336-2b0cdc21654mr69498705ad.15.1774707161668;
        Sat, 28 Mar 2026 07:12:41 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:88eb:4aec:1b3c:5de4:c8b:1b79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427a27f2sm33173855ad.67.2026.03.28.07.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 07:12:41 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v2 5/5] refs/packed-backend: use ref_store->repo instead of the_repository
Date: Sat, 28 Mar 2026 19:39:36 +0530
Message-ID: <20260328141146.1095115-6-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
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

