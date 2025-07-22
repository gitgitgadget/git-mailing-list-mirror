Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76B92E7160
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169918; cv=none; b=JBJ+kzeeMEJYleuZZ13PPAxeS7l7eOxDAmsZsZaAAMwaawzlAYOYAhOXDgsvM2ohjCNUI7ABAwFmv8yovg0RmGYyCpE0iGTlZC5xjeaLrLs6Qfd5Quh8kKcQzhK3OcNHrg//unk/WmL0fm2owT3clDhrks7JRo7LTmmfSrLznOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169918; c=relaxed/simple;
	bh=WqCyFCIw/02pbRVTODiGPf0U5Nx9kE/qwlaVIHBDK1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n74iyjKTH2bBI9ct2L+AWVCINMKD9Azrr8WuOsasVU5msQWg2Bbli/K8vkRC/+Y28bOe4qxXJVU79Zqz9ZVCG5ldgCyt0s4aiVsoWjTdjWFRZrGYBFEXxthF1wleC14nNaQqAxqZjsoKWwSY+ajGGDEBCZoibiwt7xuI6ItVq70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSkGkKQa; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSkGkKQa"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-75001b1bd76so3215935b3a.2
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 00:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753169916; x=1753774716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6L4KsR7d0W15h3p8cmh/YxGV/06BHuB8AKng83QN3w=;
        b=ZSkGkKQaf6QRW4IhEFvw19Ub9WwgfSqPhovAZoch3NzSoaw99k8dGO7Z4HUhXaEYrs
         kvZVsW5u34wdFJBguIm2h27x0tK658tU72gkrkFt9993zCU+QRk3c413wmn5pqns2OHU
         xNI20RWQtlBa6JXEmkCvrpX5ZgZVFB2YkvYiNpfuXWZoEPkYVvcyoEJE7NYhwOeSoKZt
         GhigkesfTY7EBShWphIb5A1/xVgTcIF1ERUawLYkPkfAraJZhM+fD8KIAPl7SYZ9gsQk
         oSyK+lEIOr8LNJezf0VrUCmIGi9N4OHF0lMLayEpU+UuCph4KnUOMimPOEEodcdQP4KO
         pqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169916; x=1753774716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6L4KsR7d0W15h3p8cmh/YxGV/06BHuB8AKng83QN3w=;
        b=A004eKpH2g8svOrg0MG8XXMLnBcMkpgErmZuO1yvhfp9f2BplxKrG7pIlFHatBr9WV
         uCUBWN4caKNoBXMoJGa8YfkV33nLTHyByrukwxUFKvWkgm+eF+FmMy+fUhcOZcwXzIxC
         QJgAFS9uJ6fCxWCPqqdYxNaOYOJO3PPuXv1hVtaIutbgi65XMNj3tuSHMVDO7MDyHUNt
         A/PUdFavFnuJ8eGaBXPbwnv0MtWFFhsfMSqTp+mnhV2gxjeBMTQ2ADNuWStSZRDcvN5h
         N/fjkFnL+Yp/NrMSxr3sb80mRyXjj/Q93uBHVkBlCyocaovXm4Rv7aVincwYU/LhQtmn
         A78g==
X-Gm-Message-State: AOJu0YxHdB2RUy3azy5VHgbOyfn5IByJSjcNwDNeAYngV77L6cypFLAy
	BCA6Jz08CxLPT8M1Y791yrnfCxVOSK/uLYR+wIL0NLabATjGsA4gAG5pvHFviG8E
X-Gm-Gg: ASbGncu5Nn1ONPEjHexKwSNfTtNLuUbxa5s0ogKHT613CuyaKp0gl9kFDUDjd+V0Oaw
	weOWTscduNBfnTrkyE0BJsOx+zyIcpzw+u8o4/Ahj7lEOVGVfzDb9yoWlw5wgDXfnVv532xUQb6
	JmY/N2AODXuKNCYGdslTesCuMXyOCnjMUlWCLeUwvQTxjK9ykEKtzXgYVXXRHOZC0AQ+8J4UQzU
	oes2+bmGMowIzyEHHhspT+h+5BD3tZIsXDWplyFl0+KhlKc6eIzIS0jCoL+MIzzaK2diIB07Hgq
	+eSwAM9FQTQIJzpInVndZxPsIEdqvYwvoLZ16kVDYFC66PXTG376ILRR+sVj1KHW76wtg/bCAJd
	AE8YJXIS7rJfq7/JrPIsGaEprOFFRyVmGqg==
X-Google-Smtp-Source: AGHT+IE8SjF67C+Wxk4MW2JdxhnaND98Xth/FZqxWk2DGsNqI+SbQQxohL5liju8zQ1nFPsMk+AMmA==
X-Received: by 2002:a05:6a21:6004:b0:232:1d30:cd6e with SMTP id adf61e73a8af0-2381395d325mr37563617637.41.1753169915947;
        Tue, 22 Jul 2025 00:38:35 -0700 (PDT)
Received: from localhost.localdomain ([211.37.148.227])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2feabe7bsm6393713a12.32.2025.07.22.00.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:38:35 -0700 (PDT)
From: Hoyoung Lee <lhywkd22@gmail.com>
To: git@vger.kernel.org
Cc: Hoyoung Lee <lhywkd22@gmail.com>
Subject: [PATCH 4/4] t/helper/test-delta: close fd if fstat() fails after second open()
Date: Tue, 22 Jul 2025 07:36:34 +0000
Message-Id: <20250722073634.1080217-5-lhywkd22@gmail.com>
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

When opening argv[3], if open() succeeds but fstat() fails,
the file descriptor is not closed, resulting in a resource leak.
This patch ensures that the descriptor is closed on failure.

Signed-off-by: Hoyoung Lee <lhywkd22@gmail.com>
---
 t/helper/test-delta.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index 103bf7f3e9..ba2d897aa3 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -46,6 +46,8 @@ int cmd__delta(int argc, const char **argv)
 	fd = open(argv[3], O_RDONLY);
 	if (fd < 0 || fstat(fd, &st)) {
 		perror(argv[3]);
+		if (fd >= 0)
+			close(fd);
 		goto cleanup;
 	}
 	data_size = st.st_size;
-- 
2.34.1

