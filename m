Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9D3377EBA
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960573; cv=none; b=sp4scvjDyCmpsiWLOayjLLOQSJpp1n2KDVfoAYIZLdHXwIiXfvASezsHxjnafr7VaKxvYt2TkzhiNj/j93k3m9kE4+62QLgt4Wyg49FLYpfvxEIV/nkdy9NXmDgbNbf1lHoe5wokVrF68ST/hnmg8G4n65chmytMVJQht+Jg2r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960573; c=relaxed/simple;
	bh=B4/DW42HbhkDu7VHlMB41RSbx30NpYXPEzkRfq0dhWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8pDWWIdSPL48mGsInTVAij5AE4/eNefTeinxzpZAokovv6yVczNr7z+0G8qHi6sq6PgBvlH+I6I8hlU+/OvSMDRM1OXaSMXeXLT2zt9BC0CqLO5RxQtf3iFK0gM8L6RMtWnd+unL0IuoRfP9wia85ZSd3p3XqdlDPSOCwHFKQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEm+Aqz4; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEm+Aqz4"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79ab5fd969aso77972087b3.0
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 09:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776960571; x=1777565371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNeOxsvRqFOMEQhF+u4UuDaXC+cFR9LPA+gUGGD2YA0=;
        b=dEm+Aqz4RkkQttjance03mc8u5kixC58HXCKU45aF4Eg18g/xdKQoSYH5bCN/rsJdA
         HEWyEsDGrzmt/fsvo2lPRouM2Fgr9ltuOuNwPjYU1/AVUMp1AEcMZdOwQcXRHvJGymrM
         TEsSFdS11stOwMq0y2/3fcQdrkDs0msnP7w+D9+fqaIKpKEFjKc209UCg82nDgSwifuj
         Gkt1Vtv1aKmuORAIzD2B0LfjBdcysb33xxzqKGTpBZBbDEX8KXUuFU6rlgFbMQT1CK9m
         X9NqpGO+TWN1hPvTnxSL3P/cG7vi7yBeg4Z44YEBpVgIb2ttoICAhkm8J0wJunEqGHAO
         lLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960571; x=1777565371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WNeOxsvRqFOMEQhF+u4UuDaXC+cFR9LPA+gUGGD2YA0=;
        b=pP8w3s3ROFNT1dP4kVRjZ+Ubr2kNR4vRrhaE3g/CmwRyCTV4VwnObboMWj60aP9QQy
         7MOjxqvRWZg6SC/Em8YIWYTIOKsY3O96cRDgcODsMFi1Vm/dI/g97NI1erAg3zHCKNy/
         lHnfwvznULeJVJxmwGhjSBAkUEl/GqFgTLxP3RQAWMJTpm3u0X714/p1w/wBIGsx1tME
         GzQ8g/u/35zxFAoQH/30adnTb1+9YyuKhb5M7F82Lxwk7N2cMJGSc3eyG5o7dfGoFOIA
         xnI0vPZWrweb8c1pYQ+IidtekFvbxtiDLviO9+8bu7gmH5K8I9Rjc2BTMN36+juIieCb
         0uAQ==
X-Gm-Message-State: AOJu0YwkKryTaPMJH7zBTsoKRUMzCSn1aJEYh6qEg+bkbUcwh9hzHNSO
	eZ8y/HPhh8bKXJ+C/hraXVI4e72wkOVOUh5fK9Un9mIYpKe/0IQt8lLmjYHBFfHP
X-Gm-Gg: AeBDievobKollsvSelNVDwZ01oByi8MRFn44140mbjznta3/K08mQpHqf6Pmzn0UmyN
	mWWvOzyvFGVBZQFGvPiV8xoBhY+Etkcca13Hb4xaug01Ig0d5cM+h9NhTDKOfVFKnPcHmVwIKQi
	b1POUcpB/ai3Bahz5NaIrzsVT+7al1jDTiL9sb0rgfKFgVK+VjU3JA1ITpui57GWTglcZz9apuV
	dfuEAFz9FikhI3feF0/Co+3xvkdVk6bBMCTdR8YGeLgSTlFsIM3+jmkHxxW6LKdNGl1wH+XYSDl
	yJUzKJfjH8AKpqqkkP1ZZ/GDkeQLHK1cuFJU/DbDiM5wBCqb5hsL2zTlKWY5DxUYT/5Id8eQMYo
	dVCUH5FY1LD2f2HbkKT7ATNJueVM+hSgUcUPF3jSunIBosDPZMQRjIHVzh7bwWXKFs99jor98DI
	kO/pBqIHezQQoi0Z6vR2QRqw5sLk0zhL+VVeCP3/460DFVM/V35PjkiUBo9qtGI815nSNAXg==
X-Received: by 2002:a05:690c:348a:b0:7ba:f414:cd1d with SMTP id 00721157ae682-7baf414d19amr177103577b3.18.1776960570423;
        Thu, 23 Apr 2026 09:09:30 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e5f:a910:737e:f405:338f:9bbf])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7baeeaa2cb5sm51083997b3.21.2026.04.23.09.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 09:09:30 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v3 2/8] rust: we are way beyond 2.53
Date: Thu, 23 Apr 2026 17:08:26 +0100
Message-ID: <20260423160832.114816-3-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260423160832.114816-1-belkid98@gmail.com>
References: <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
 <20260423160832.114816-1-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junio C Hamano <gitster@pobox.com>

Earlier we timelined that we'd tune our build procedures to build
with Rust by default in Git 2.53, but we are already in prerelease
freeze for 2.54 now.  Update the BreakingChanges document to delay
it until Git 2.55 (slated for the end of June 2026).

Noticed-by: brian m. carlson <sandals@crustytoothpaste.net>
Helped-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/BreakingChanges.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index f814450d2f..af59c43f42 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -190,7 +190,7 @@ milestones for the introduction of Rust:
 1. Initially, with Git 2.52, support for Rust will be auto-detected by Meson and
    disabled in our Makefile so that the project can sort out the initial
    infrastructure.
-2. In Git 2.53, both build systems will default-enable support for Rust.
+2. In Git 2.55, both build systems will default-enable support for Rust.
    Consequently, builds will break by default if Rust is not available on the
    build host. The use of Rust can still be explicitly disabled via build
    flags.
-- 
2.53.0.155.g9f36b15afa

