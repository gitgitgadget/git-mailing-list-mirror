Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD972DBF5D
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 07:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169916; cv=none; b=mPu9Vdi6O10HJNf8BKYlLsv8wDT4P9monPURge129CWlyeeg6soWl+aeOpK1ARYMfKvrMhFHQeeO8qADDvViG/3DuiuffyKFkL2zPH3096UoRBwH6wLxa3P7Je+WtggS2TLULvnygDORq5c7Zp62EoAqa+c3jKgQZTczaYlrK2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169916; c=relaxed/simple;
	bh=ZkG1GeGebvxK1Nlj4Bm+8tiOPzWVWBq96m7RRmAnPaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZZGwsZIQrtYxEBZZNa3TUG+8xYoATLOL4Wujgarx9tlc8w9FYDgLNd/6hmecTVTVWrohvse5xbCwIhvPvzGoqRQsBidjWRmn7xk8Zu8Q+x0dp4OrYTa85vBKysktMfOzYrvRVZaaP7TER7yzkxZii10FrR/nGYGb5ZW3A8Y9qxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCwtQka/; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCwtQka/"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-749068b9b63so3431042b3a.0
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 00:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753169914; x=1753774714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5GhttFXQyNWMkH4PFO/MJh2fhRMjpxrlt5sBExZFCk=;
        b=DCwtQka/oGt71JyaVO3DpKJLwgsD8JWrhpQ9++HUWTlDkWKmjFfAQzkAwRbAM6f2gF
         qmKkNArTaXKIlWAzfXxZgPLiu2w4e1kRBwiW3zgGS7lenGtSvhas0JuzxJo1txb5mPSP
         Kyv2CuphieEcw8ER59Hrfi9GDNF+dcECNBVjqWym8H7PQAUG6+b8MqktIOeCXekIUlLv
         iWC0EsmHjj6rUrm1POCsqJr+mokcQKjZ9Bghk1siuF8dnLYPPgOnDzg1moY+qtLQNo40
         Zlrh8fbT+J6vYsvmV/1XSR6BhL27sxaBLBRhaVMFBNDz+1VWnPWfg4GBLaLlbRjg2LhT
         6MLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169914; x=1753774714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5GhttFXQyNWMkH4PFO/MJh2fhRMjpxrlt5sBExZFCk=;
        b=w+zQ7T6/L3ffvjCeDQJlCrBxKyYShE9AoGq67ZiTj6G8PZjdCww4noGkGM3icQQbnH
         QOGJRbnwi61UVWDgY5p64/DNtPqleOIaEjE6h+BDG5Gx28rTLyz0dFghD2g2WzhnQnUp
         oEJome1CjoHyDhXdleYrB1B3h5hMaqB/W92PeGkhz9PDLT3lAzJWDWX6+NXDoCLnpmE2
         WwhmQFWuPda1QJG1pI74spgFHMe6KXxk2qht22mF3cou3GNVfbA0BFvusz24k+e0BP1z
         EstLEcaKu8s503COK4UdcxjOnUhvh/m7nELx0VCXn7kURpRstWc7UckwY5MnLO3POen1
         SuFg==
X-Gm-Message-State: AOJu0YxKx/897PiX/m67lCmdW3qSIWyM6n2ZnaLMRxdSfyBZqXqvSqHu
	XKChamZw7HEHkJltfL54AjveGg6FC2z/RtAVUIt360uGG7T+g8kmtVoYNzwM4cah
X-Gm-Gg: ASbGncvs5DNWr5+X+WDNk7tmoYTaC8ul9CehtWWm+MSQ6X4JxOmSvqgLbPd3j/1dH3V
	4mmxttmNYiaNNMr1E8DNJhbQt9ENFOt6xVrrY0m54XuKVwhWJwoFdm4DS267B9gL38DMsz17BP8
	9RaXq0ACTsxX7dzIMnV1Ht5WNSQ0KaGm8S7kWubgSmbCkDH941DN7EL2gdwrc4pNqnD5nmNFVp6
	atbbexFLxqiVdmCUJZf57ninh8lfud3pnJpw6F+1Xf9AHcmpG5mhBJEjamAJejJmQrbbXZlTsr7
	zz3AvNbZ0MdPCr/NZqkrHsanFZS0g1RBwX9VI+yjTn59/8NofouOBaBZLJ/wmMrZ5uaFO8f/Nwg
	oLrmAie23wliFkv1KxZ87jQRKSOEDpT8nXA==
X-Google-Smtp-Source: AGHT+IEKHNb5b+juUisNdkGz146Km7siZgKXKimpoE2lAkQxWRGWHr8+TLgTSGsQIOlGPdyJOb+vTQ==
X-Received: by 2002:a05:6a21:a49:b0:21f:543f:f11c with SMTP id adf61e73a8af0-237d54012bdmr34614503637.2.1753169914477;
        Tue, 22 Jul 2025 00:38:34 -0700 (PDT)
Received: from localhost.localdomain ([211.37.148.227])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2feabe7bsm6393713a12.32.2025.07.22.00.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:38:34 -0700 (PDT)
From: Hoyoung Lee <lhywkd22@gmail.com>
To: git@vger.kernel.org
Cc: Hoyoung Lee <lhywkd22@gmail.com>
Subject: [PATCH 3/4] t/helper/test-delta: close fd if fstat() fails after open()
Date: Tue, 22 Jul 2025 07:36:33 +0000
Message-Id: <20250722073634.1080217-4-lhywkd22@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722073634.1080217-1-lhywkd22@gmail.com>
References: <20250722073634.1080217-1-lhywkd22@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If open() succeeds but fstat() fails, the file descriptor is not
closed, causing a resource leak. This patch adds a close(fd) call
in the failure path after fstat() to ensure proper resource cleanup.

Signed-off-by: Hoyoung Lee <lhywkd22@gmail.com>
---
 t/helper/test-delta.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index 6bc787a474..103bf7f3e9 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -31,6 +31,7 @@ int cmd__delta(int argc, const char **argv)
 	fd = open(argv[2], O_RDONLY);
 	if (fd < 0 || fstat(fd, &st)) {
 		perror(argv[2]);
+		close(fd);
 		return 1;
 	}
 	from_size = st.st_size;
-- 
2.34.1

