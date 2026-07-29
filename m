Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A9738889B
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354095; cv=none; b=R17N+tkEJaJfrgRhyicSrK4/KjHhFzDIVmX55adWUGHz//eBE16IK5ktBmsl75z8h726lZq4pYNovQgyM/soNfd1LDOEPDFxxwmgS9HAQrg6t9Ut9PHvrDjmw1WDxS7OaplK8hBr79OVhb0rNnu6/IqSZcIrATq9Ws/SoJZf86w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354095; c=relaxed/simple;
	bh=51c46KV3qQCD0ut9tmvrVZ+ERAjuEeCFmQ4Bd2DlvWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sg/rDiHTH426G1ViqelogP5HQTOITCyJaFuiVwiEep80FSg8teENebkEttGSJt9fdJ5Auh1B0/OofTYkQKSRNV3xAnoqMkqAoDoDez7mwHrDUQTrMPZTAxJQtLHAGTApJ2XuBcbreG7su2ew4jUoUpagcO9suOoQz7JUK8x5zl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClpqD7gC; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClpqD7gC"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81f36179d72so21186007b3.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 12:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785354093; x=1785958893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gVt/CLnMskFK9UtmDjr8hkSMaDdX2cX0q30UEQnBvgU=;
        b=ClpqD7gCoFNUr7Ni1l7vAqHqrftWNHnxYXS+w60KIWJw8kqDjoEzFXJOWfOtMDq9H7
         kr+GwM3ZfZ7ZNJaEicn0AtQkJYWIG6N/8FJ6JJvPSTkB+HjYbb6QG3eu+KLCZCn3A5qE
         kp65q6MHO05VQYnEDCDWN/tI9oPnL8rmIk7j4bstMVrZZZeKk2hSMWmhqGwVZ9KrBG+/
         NBxEVI1H/VsLk77VMVGHhAJiTaGtdocZPfv+UsDFSWqv+X4gqsK076BmQoYJTdy59eQk
         yfcwUP2wtQWwIm9sPezIN93lwAMbeY4gbcNb48SABJfnXEUXLXSwo5Ots8z//7PB1tWQ
         BkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785354093; x=1785958893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gVt/CLnMskFK9UtmDjr8hkSMaDdX2cX0q30UEQnBvgU=;
        b=FbCqJx1/I1n3QivM16q1UmSvP4dBtAn/m5Odq+L0XnFQRWA32KIN91qm16Xf1Q2A4U
         0rktcOy/mXI3r0+WmEm6WO1dstggq65RA9FjfYxfTOLqZVO3kvxtmKzmUh4tDgzL1F1G
         TMhSPkSoOcxNhr/eFnJ0qnkjADTRhVUkIemGoLk+gbWsyYSq9XJb3NOEKuzkDrBfSsi3
         Mxvtd+ZqJ1aasgNfPhj9ShV7bZqOIvVJ7u1XAtgxD3AbzNWN9q23IokE2Gn+29Ml9vyJ
         P7bqkSyDkIddPOxAY0o34FvHvGpvTu2F/g8LcfoGhGcIpveuphGsYyfzv2yk2e5GdMb1
         vHRQ==
X-Gm-Message-State: AOJu0YzIOSw4LBhXpvomxY1ce0Y+9wK8B9uVmwxpj13dSFELdQ1hgLzf
	t+9bhkIDGS6s939Rp2M5+6vhx+9Z9bV3ADcuLuGE+yb9W1lPSY+p5QLBv3RedTLk1+Q=
X-Gm-Gg: AR+sD13PA+hN6cNHeje4l3Nh1hoiUxhK5+Lpay23ApK7N3REOE5cbDYe84IHLl/X4zc
	CzBADXs1BSLN4lSPLnl8HAaWs4C9YcJ5ANYoE0sh1/kFFpWg0bCTpCASSUgptKH2LsgWHKKetZz
	czU/do1Qk0YE1vvFaRS/aQGJIkuzcet4bW4+sbQk3ziASFtcdBT2GLuRRD4D20s6zx7vfSLBqS/
	Gww8RzSHbvsBgsFESeq4gQcjQ9HMwPLA8rXOKXnrnJ3iZN4tU3deozv1MQoaFPxOB2TItQrPaLC
	qMzE12Vu1GgPwgg5YkqwPum/+cuQKodX50f5XXzWWMz14rarqsQrS+NHWFXtafBrIsL1f/SdDiD
	D8T1cCWM6oQ3Lv0Pepji5g59Ehl7uCUVTavVhxwDAkhihB5pJEzWXilejR9JE31M+/V7ghYlQBu
	2QEODPQqcxHWQ9tgMf05sz6oTPX2ZeqNZnKkV6pj66j3xlGKRGwuFsIcx4h+YVZjrLYXWe2ruxP
	ytH66qdFcDmcvUG5JGcrqtraBhfrinYqjY=
X-Received: by 2002:a05:690c:6993:b0:80b:9f4e:a73 with SMTP id 00721157ae682-81fb5cef359mr1833797b3.13.1785354092918;
        Wed, 29 Jul 2026 12:41:32 -0700 (PDT)
Received: from st-davidlin1 ([139.45.175.10])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fa2981260sm23447667b3.42.2026.07.29.12.41.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jul 2026 12:41:32 -0700 (PDT)
From: David Lin <davidzylin@gmail.com>
X-Google-Original-From: David Lin <davidlin@stripe.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	David Lin <davidlin@stripe.com>
Subject: [PATCH] builtin/maintenance: accept "none" as a maintenance strategy
Date: Wed, 29 Jul 2026 15:40:06 -0400
Message-ID: <20260729194006.75317-1-davidlin@stripe.com>
X-Mailer: git-send-email 2.54.0.1783223981.geb76c99f7f.stripe
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d465be2327 (builtin/maintenance: don't silently ignore invalid
strategy, 2025-10-24) changed scheduled maintenance to error on an
unknown maintenance strategy instead of silently defaulting to the
`none` strategy.

However, `parse_maintenance_strategy()` does not recognize `none`, so
Git rejects a valid and documented strategy that can be used to override
an existing strategy and disable maintenance tasks.

Accept `none` as a valid maintenance strategy and add tests to ensure
it's accepted.

Signed-off-by: David Lin <davidlin@stripe.com>
---
 builtin/gc.c           | 2 ++
 t/t7900-maintenance.sh | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index 46999a99ab..3d1e39d46a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1922,6 +1922,8 @@ static const struct maintenance_strategy geometric_strategy = {
 
 static struct maintenance_strategy parse_maintenance_strategy(const char *name)
 {
+	if (!strcasecmp(name, "none"))
+		return none_strategy;
 	if (!strcasecmp(name, "incremental"))
 		return incremental_strategy;
 	if (!strcasecmp(name, "gc"))
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index a8d691719d..130c971b15 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -1022,6 +1022,9 @@ test_expect_success 'maintenance.strategy is respected' '
 		test_must_fail git -c maintenance.strategy=unknown maintenance run 2>err &&
 		test_grep "unknown maintenance strategy: .unknown." err &&
 
+		test_strategy none </dev/null &&
+		test_strategy none --schedule=weekly </dev/null &&
+
 		test_strategy incremental <<-\EOF &&
 		git pack-refs --all --prune
 		git reflog expire --all

base-commit: 13c7afec212fc97ce257d15601659314c6673d6c
-- 
2.54.0
