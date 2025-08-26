Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334FC3054E8
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 23:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756251330; cv=none; b=NTkDqM3XMBiD1iHl2lSbcGteCUf3B2xc30ihV9uf+vPNVdBT7b82VLlRAnftJYQhFLAyq7YaXcJZfvxIzvlmWZDAF1hRcHlkQpN1ky4aEoz6AWxK80Npu7q2whLs+Mh6o6uajXWXiAolRzfjQ1PRAFy+8mlxNuxQm2mPZ3jeYzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756251330; c=relaxed/simple;
	bh=gIz02vCI75nyEXfNKEASMB947iQaVv523Y3fNkSmkeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESmQT5sx+699UCIdrIktOTRlYZwOLFmcfZ6qUayQaiRFXO+r1HYSGSE+S6lPKKEpERYENYkG4sH55GIsaw5x1kd/FPJxwbUjeVS3HQWn8vhIKeL1DKZEkygAzglzan7ZLCGUGqecYkcwqohVKQ/k/2c7EhAqvgtFBR0GLSAQPAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvUhEUtn; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvUhEUtn"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4c1fc383eeso1750071a12.1
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 16:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756251328; x=1756856128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HVMGQiafHWDcwX4Ar2UobO3C3YJPAKCzvLE2/gQa48=;
        b=LvUhEUtnm648d/E7EXEXyIQbNLUD5hGHAIyWIr+IdVen3xBWRrTLK2dNFqIfhc4j6P
         OIrVyYE4hQgDq2G9EnmqbrR5KjP4FeE03COn7LKymajdQoDrxFcfLeFgzqJIWTDiymtv
         +MFZRFXmp6VARrJ8qj2qxl4cXPFVCW7qCybeNw3Q/YVkxVXpQ+mQIeuXPj7UAhSRMwdy
         BOuJ11WvwzGoXfXF8Vg1g/6iapxMq4+mE/DXwNPdf8rzLxbeoe2l2fQsNiLAUM3HBTt/
         +Sqqi9dGc/j4/RxZDJFbVYCWAQCXzMNTXL2ZUlt9OWv/GYFlac+DfuWQVECeuAGonUxW
         qlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756251328; x=1756856128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HVMGQiafHWDcwX4Ar2UobO3C3YJPAKCzvLE2/gQa48=;
        b=jed+wIC+4hE34KXHbmQldWmtUN20WWHNpyP1QxPTH9JKg8SQXOuirtzWT1beGXX2XP
         acMH/nbkHmYQTfenKSvCYduc9ca0fg1dkh/3VCTFA5UfMLeoX4wuUih1KwB9CZ4Vjibh
         mLiUyD8Y9dpgE1XDdte5tN9mFB/E4eyUsgtsHSNr2SEkCNBvro2/yHtXMM2UmT79+tYl
         4B7hNdN4r+IOpNy/WgT5Ij0Cc62HybPS8R25303+wrUi9FUbhUC15NMQJE2k3cKO9mzs
         TN++2/uOEaYdAC0E5oipU3dfAJb5yr+2KZ78qz3QJ+nZahv/OkHeqt149F7223baAJGO
         m3bw==
X-Gm-Message-State: AOJu0YzGSyfD5d8arH4cUFgTqURV8sMIY3TL6aSIE4qMxgZTvKNI/5IM
	GHnLXHLDfCHy7p0y7Ubpg27ewZjLD6kVX9dkiYd/ARJd9MHdHDGKkKF9KCvVFQ==
X-Gm-Gg: ASbGncuxtwZ0P2aoz3XIyld4Cccxel82htLEliuCVGfBBUJsZwwhE5N63tmV+lfsetf
	J6ClEFVm+/I8fJiweIf4r3/M3UGPKC8OxfuXTmbpoF7jOjh7UaZEFtne7LwZwO/cDMaQJxGQDjj
	hbaB9rPf7WqeVrCrin4OgBMuZ9ebqae0ulUexJ4NkuHeecc4wYmv6cyKTeAqr5SLYDP/l8D+vsz
	NvsIemwbKCtUG3mynufRanqyj1JrTcyeC3W5W3zgJyApeXtSE2ylYHLXsrKcNcbhupSpdooN5CT
	yi5NsM2xETnOMN3sdKfGxrcRa32RyjEu/QJIHgPuY99vghCTJyhWK2z5W9BpBeMrA6uZeFqNTiH
	/OVfew4xiO7xYClWi
X-Google-Smtp-Source: AGHT+IEhLeezydd4wQo3ysNMjf0Xo5VE38w4i/ySQKEAx1UUoY3oPZbrIePI7ZO1ESusp6jJHCxm7g==
X-Received: by 2002:a17:903:b4f:b0:246:aef5:5884 with SMTP id d9443c01a7336-246aef55a91mr149956325ad.49.1756251328244;
        Tue, 26 Aug 2025 16:35:28 -0700 (PDT)
Received: from tinycat ([172.56.186.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466886122dsm106430285ad.101.2025.08.26.16.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 16:35:27 -0700 (PDT)
From: David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Calvin Wan <calvinwan@google.com>,
	Kyle Lippincott <spectral@google.com>,
	rsbecker@nexbridge.com
Subject: [PATCH v2] Makefile: build libgit-rs and libgit-sys serially
Date: Tue, 26 Aug 2025 16:35:25 -0700
Message-ID: <20250826233525.2635432-1-davvid@gmail.com>
X-Mailer: git-send-email 2.50.0.7.ge90cf88798
In-Reply-To: <xmqq7byqkp3p.fsf@gitster.g>
References: <xmqq7byqkp3p.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"make -JN" with INCLUDE_LIBGIT_RS enabled causes cargo lock warnings
and can trigger ld errors during the build.

The build errors are caused by two inner "make" invocations getting
triggered concurrently: once inside of libgit-sys and another inside of
libgit-rs.

Make libgit-rs depend on libgit-sys so that "make" prevents them
from running concurrently. Apply the same logic to the test invocations.
Use cargo's "--manifest-path" option instead of "cd" in the recipes.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

Differences since v0:

* The targets have been split apart into
separate targets so that the libgit-rs targets can be made to
depend on the libgit-sys targets.

* cargo build/test --manifest-path is being used to simplify
the build recipe by eliminating the "cd" step, which would
have been duplicated in the split-out target.

* t/Makefile has been updated to apply the same logic.

 Makefile   | 11 +++++------
 t/Makefile | 14 ++++----------
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/Makefile b/Makefile
index 29a53520fd..539e6907b4 100644
--- a/Makefile
+++ b/Makefile
@@ -3983,13 +3983,12 @@ unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG) t/helper/test-tool$X
 	$(MAKE) -C t/ unit-tests
 
 .PHONY: libgit-sys libgit-rs
-libgit-sys libgit-rs:
-	$(QUIET)(\
-		cd contrib/$@ && \
-		cargo build \
-	)
+libgit-sys:
+	$(QUIET)cargo build --manifest-path contrib/libgit-sys/Cargo.toml
+libgit-rs: libgit-sys
+	$(QUIET)cargo build --manifest-path contrib/libgit-rs/Cargo.toml
 ifdef INCLUDE_LIBGIT_RS
-all:: libgit-sys libgit-rs
+all:: libgit-rs
 endif
 
 LIBGIT_PUB_OBJS += contrib/libgit-sys/public_symbol_export.o
diff --git a/t/Makefile b/t/Makefile
index 791e0a0978..29dd226c7d 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -190,15 +190,9 @@ perf:
 
 .PHONY: libgit-sys-test libgit-rs-test
 libgit-sys-test:
-	$(QUIET)(\
-		cd ../contrib/libgit-sys && \
-		cargo test \
-	)
-libgit-rs-test:
-	$(QUIET)(\
-		cd ../contrib/libgit-rs && \
-		cargo test \
-	)
+	$(QUIET)cargo test --manifest-path ../contrib/libgit-sys/Cargo.toml
+libgit-rs-test: libgit-sys-test
+	$(QUIET)cargo test --manifest-path ../contrib/libgit-rs/Cargo.toml
 ifdef INCLUDE_LIBGIT_RS
-all:: libgit-sys-test libgit-rs-test
+all:: libgit-rs-test
 endif
-- 
2.50.0.7.ge90cf88798

