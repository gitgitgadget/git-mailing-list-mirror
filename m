Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5919115B118
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 22:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725661294; cv=none; b=KuCF+FKy81pB0dVh7BNAvvr+av7Dg9VNbUtZicMwjklIH/nlJwkjQKI4gwZiSQU5xr/GGiIK1CNT1qJ4cwSJNPEgZNr1q+sYSj2pPojWv7bQ2h2GIP99JpddvQeyjxI1fP+AqSQmiY9T7bd1JBJLGuXN8dXXj/I+llrlKICtwso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725661294; c=relaxed/simple;
	bh=n1Z4toqLKTe9idXtzwLkCt6XkUgWKAX2rWLA3WZ+WrE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hXTEeCcciTaorOktacWIlZL5JzXGhFrGiwOVw3ormNhJV/E3labnqNdSbI7aIPM6tkPlWcFLLim0RV52bdxGclZM6l1XXofagV9i3dDVe//zWWBOweefVR1mLzcXR82unyd8i/j8jRhA48Pqc5TtEj1qru1oNnEm74GGJprjou8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DW3kLAhJ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DW3kLAhJ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2d889fc26e7so3072149a91.3
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 15:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725661293; x=1726266093; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XXqBYKy29wLXRTFntiRP0axnFMI9DerB60/VYYTaxhs=;
        b=DW3kLAhJfo+THlrosHyMHLvi4MBDhc2c1iK9mbAol2gmNl8U3VEeq7hebo307xaVY9
         I+/cBVn3XNFlfITfpUxkZ6SaCbBD36WeBdvVzQIgOZ6BotTy177QDXgtoDXJew3qekXk
         Wrjlpxg/IAG/RKGw8mrC9XMBW62p5g0KDJDkQ6HAwFV3+rWmZ7EaRBU1RMmtHvipV68m
         2qYNWaVjY0huxPrrb2kBR+VgEoJBmOxjh4XS2FCmCn46R9043tZGXQ7cfsziPGmwmlQm
         mhv+rZVQYjoG93Kph8mKbN1HRhVYNTKAsbOpcTkSpMSWS1Nvcd/RAXzSzV/0TzaJsa7D
         2c/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725661293; x=1726266093;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXqBYKy29wLXRTFntiRP0axnFMI9DerB60/VYYTaxhs=;
        b=d6pfzPbM4EvmD3AKMfXRc1ag3plDuhY0Oyr7sr22raR1rDgPRWFK0qYO+Ytuchbdou
         0JKm43zq3KHIDRMilvtl1Uxoj+08pZP+81RWyuYNZt6srqdfcFG8WzT1wG2N2rsdYQk/
         MOOEjLsxDcIBo7WDkZTQRDKcMgrK0OQmXtULSVhw7rCj3dmD68zwCxMOOujAmKRqWnXO
         zRswvEhllkbZxD9PAMp80s/JAlrT6xXCwu1D3Xyu09QJqGlSLf27n0Q6h0KDVTRzhwz7
         odcmMJR9+TzwudEbfr88iXq4XZb7/Xi9pj+1Lijy6755uMsLKwZMpjR0XfXnG2GwlRqC
         2yLw==
X-Gm-Message-State: AOJu0Yyp73BSsv78cEIEaxOGgm+YU6t6jPfwceik4djrIRobIOoNEVDk
	46rd7qB0U0uz2U/zGEC4jv1Ilt5VLOhcSfwqDKMWSTb3RgWbgFqrQ5LENDBMpdc1Sx1NgMWuL9a
	ZL8EI4owumblTVA3j6Hr2zKm7PET6q027wOae/pEHXPfpGuxkCSj7Trme+8/ivay2WMpYsoyQsr
	DdXaspquUOZSOn71725Wdpwic2+ifKeXisTjKK3agZXzhy
X-Google-Smtp-Source: AGHT+IFGIC0Dnd3QsG2AZ/PdOvE8JVacxyYii7r8tTTgHxNAzTbo4Mla/QcVuTsx5On2ALNBuwOjaLH1v5fnSaE=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90a:5e0e:b0:2d8:dd3b:a6de with SMTP
 id 98e67ed59e1d1-2dad5114956mr8156a91.7.1725661291025; Fri, 06 Sep 2024
 15:21:31 -0700 (PDT)
Date: Fri,  6 Sep 2024 22:21:16 +0000
In-Reply-To: <20240906221853.257984-1-calvinwan@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240906221853.257984-1-calvinwan@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240906222116.270196-6-calvinwan@google.com>
Subject: [PATCH v3 6/6] Makefile: add option to build and test libgit-rs and libgit-rs-sys
From: Calvin Wan <calvinwan@google.com>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, steadmon@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com, 
	gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	Jason@zx2c4.com, dsimic@manjaro.org
Content-Type: text/plain; charset="UTF-8"

Add libgitrs, libgitrs-sys, libgitrs-test, and libgitrs-sys-test targets
to their respective Makefiles so they can be built and tested without
having to run cargo build/test.

Add environment variable, INCLUDE_LIBGIT_RS, that when set,
automatically builds and tests libgit-rs and libgit-rs-sys when `make
all` is ran.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 Makefile   | 16 ++++++++++++++++
 t/Makefile | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/Makefile b/Makefile
index abeee01d9e..41ad458aef 100644
--- a/Makefile
+++ b/Makefile
@@ -3870,6 +3870,22 @@ build-unit-tests: $(UNIT_TEST_PROGS)
 unit-tests: $(UNIT_TEST_PROGS) t/helper/test-tool$X
 	$(MAKE) -C t/ unit-tests
 
+.PHONY: libgitrs-sys
+libgitrs-sys:
+	$(QUIET)(\
+		cd contrib/libgit-rs/libgit-sys && \
+		cargo build \
+	)
+.PHONY: libgitrs
+libgitrs:
+	$(QUIET)(\
+		cd contrib/libgit-rs && \
+		cargo build \
+	)
+ifdef INCLUDE_LIBGIT_RS
+all:: libgitrs
+endif
+
 contrib/libgit-rs/libgit-sys/partial_symbol_export.o: contrib/libgit-rs/libgit-sys/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
 	$(LD) -r $^ -o $@
 
diff --git a/t/Makefile b/t/Makefile
index b2eb9f770b..066cb5c2b4 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -169,3 +169,19 @@ perf:
 
 .PHONY: pre-clean $(T) aggregate-results clean valgrind perf \
 	check-chainlint clean-chainlint test-chainlint $(UNIT_TESTS)
+
+.PHONY: libgitrs-sys-test
+libgitrs-sys-test:
+	$(QUIET)(\
+		cd ../contrib/libgit-rs/libgit-sys && \
+		cargo test \
+	)
+.PHONY: libgitrs-test
+libgitrs-test:
+	$(QUIET)(\
+		cd ../contrib/libgit-rs && \
+		cargo test \
+	)
+ifdef INCLUDE_LIBGIT_RS
+all:: libgitrs-sys-test libgitrs-test
+endif
-- 
2.46.0.469.g59c65b2a67-goog

