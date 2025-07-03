Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5CA28D831
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751529684; cv=none; b=osTtmmqPd8HiNGsdxIh1uiJ5fv2wmj5GBdtezA5zv5zXtEICxO93ZBELWflZFOlLSjn54QDdcOQM096aJQGr9vZoS4gKxOqM0DjcF7pk2Es3gCMm03YgfI931f0+Di/TdHFk023sjqa6bbprtRoXSuT14XwbqgdRZTxIyRy7qoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751529684; c=relaxed/simple;
	bh=fwdrLuKGQMyKINj22VKIzQ6U66cmcFoogkT86TGqJV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o8fy95RLL5e/GZ3jauK3Z0hqzuPxYKra+wjdyJkixXv2Z/2kG18TzVpjfk0IxU0UH1vX56KnyjKhc8Hm5zS3ZewZR8rFZ0KE3DSqzRK1pV7XY8ck2Rkk8C5O+eIXDCQ9jxhXhNIw5/mwtT4PejVlTsORLL6ceZdFIlghS2vddA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpqQN9Xt; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpqQN9Xt"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b34ab678931so6386363a12.0
        for <git@vger.kernel.org>; Thu, 03 Jul 2025 01:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751529681; x=1752134481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0A46YedsE/tk4WcnWtBN+9Ck2nHCSrTUskFsN+VEGw=;
        b=lpqQN9XtPxQa9bkFLt4suYweiVbIOEpGOZb3/I4J/uMYsP1ijcagEClFE2awLTsVRv
         XtjasdELrHtot4nEFB5ZsAWnPVtmxo6v/tUMrfhOX/O+RNbZUKGIJ5AEoy3I0rzx0U3D
         DIqYYMP66BtAnW3F6ZMsf4Mo9PSeebzWLSa1JCY2OKQC7owuyCAqFmACDe8VtFhUqoLo
         AAjyRvhu4IMwaAznHgN+akrT93FMFZYK3X+EtH2N8F6ZQVABvaN/KmQ3lTeIiEZvYXIe
         jgPdruHaq/lOA8rSWu/LC2gfghpZU31yPfCXo7zy+aifW9FdeUAljdgg/bjlku9K3Ue6
         d/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751529681; x=1752134481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0A46YedsE/tk4WcnWtBN+9Ck2nHCSrTUskFsN+VEGw=;
        b=RXdbZ6voJXaZCE0SBKtTS64kcFIxrtwfIBxIdPC3QV/4iBiItIK+xiP5eMDgvLULr8
         PBAfaw8mEbPVP0ImAlV4gPw4E4DDAgJVKgKk3mZkjh+SWfsQtxm6zWTCj4jE+xfZD0MG
         SwSYU7g5H5U48ejflHMPxy+06CggshKCptPZeNBTx5ZsY4P1Typ6KzqLxBLVu+wU9Qtn
         QP+xgiDCFgsQxN21xRC+f/l5RNfk7dtd2200vknlBB1U/6cUIWBd2jrsyBWBe0faN6fx
         iUon4As3rzhrim2HOAADnjmrIBEkXwdZlsvJiWPWyUG9I17byIJ05W/3PXU9eeHqmuwR
         dCkQ==
X-Gm-Message-State: AOJu0YyryKprBDvhFsRmxd3exHacAeBgI7a9uDJLrPDIw/BB44wZ28wy
	QC6LUvUutEBeebhS8Gf94hDG1OJK022SCNoDv6XaOhdqt8AvsIcl6ddbITlFHg==
X-Gm-Gg: ASbGnctLH1NHHfEeQ9CjS12+1zhtKSg5EZjbMVRVpW7vpQapTqN+qyNFaMCzWfT5cCD
	V+Hgpbjg2yy+OTsm/BrDJ2Vfm5INiMi7NYeX0ubEsFq4dbhumasxanLflndjiBS55tm9m0OkaQE
	BkU3y14GgI+JLpCkRQyNqYDPDGE8g/4TW3ph2PiD18RMklnWnK7RY+tGgqhW2sU/66TW2sQ+nUd
	L2nmdV7dLu3T2Pebpab7rtqozOHIhV5tp7QgSyo9sxruzCZ8iyORl4g8bP6Zjzf1zQ52gxx09RD
	qqY1FpGLNMed3ca48qmRG+CcheBy3sIXxngDZOdOzitAM9WbXxPT2Qp0j4hbkgRkHKZ8mkIlJga
	VIlLSOWaAcxUGdZx5
X-Google-Smtp-Source: AGHT+IGuqbZM5brYd7T6AOzs5O9j4BZqp6BrB1tuI8CD3/zNOe8oJFkjIheAW3FgXryKECoPeii9iA==
X-Received: by 2002:a17:90b:2b4c:b0:312:e8ed:758 with SMTP id 98e67ed59e1d1-31a9d58f1bfmr3027553a91.13.1751529681449;
        Thu, 03 Jul 2025 01:01:21 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8e80:3680:1125:4ae7:7ddb:b0ff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cd1acfcsm1703006a91.43.2025.07.03.01.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 01:01:19 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: brad@comstyle.com,
	collin.funk1@gmail.com,
	pclouds@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH v4] builtin/gc: correct total_ram calculation with HAVE_BSD_SYSCTL
Date: Thu,  3 Jul 2025 01:01:11 -0700
Message-ID: <20250703080111.64276-1-carenas@gmail.com>
X-Mailer: git-send-email 2.50.0.rc0.48.gd8154328d9
In-Reply-To: <20250702202118.48742-1-carenas@gmail.com>
References: <20250702202118.48742-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The calls to sysctl() assume a 64-bit memory size for the variable
holding the value, but the actual size depends on the key name and
platform, at least for HW_PHYSMEM.

Detect any mismatched reads, and retry with a shorter variable as
needed.  Make the second tentatively optional in little endian
systems, as the variable was preinitialized and would work AS-IS.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 builtin/gc.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 7dc94f243d..b680a1f739 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -517,7 +517,7 @@ static uint64_t total_ram(void)
 		return total;
 	}
 #elif defined(HAVE_BSD_SYSCTL) && (defined(HW_MEMSIZE) || defined(HW_PHYSMEM) || defined(HW_PHYSMEM64))
-	int64_t physical_memory;
+	uint64_t physical_memory = 0;
 	int mib[2];
 	size_t length;
 
@@ -529,9 +529,18 @@ static uint64_t total_ram(void)
 # else
 	mib[1] = HW_PHYSMEM;
 # endif
-	length = sizeof(int64_t);
-	if (!sysctl(mib, 2, &physical_memory, &length, NULL, 0))
+	length = sizeof(physical_memory);
+	if (!sysctl(mib, 2, &physical_memory, &length, NULL, 0)) {
+# ifndef __LITTLE_ENDIAN__
+		if (length == 4) {
+			unsigned mem;
+
+			if (!sysctl(mib, 2, &mem, &length, NULL, 0))
+				physical_memory = mem;
+		}
+# endif
 		return physical_memory;
+	}
 #elif defined(GIT_WINDOWS_NATIVE)
 	MEMORYSTATUSEX memInfo;
 
-- 
2.50.0.rc0.48.gd8154328d9

