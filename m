Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43711A0AF0
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 19:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714506972; cv=none; b=u9KEG3vUukhk001wZf1dqANbO1cF1lc+DjVrdl3/2dueyGe7GvO6XqggPf2iYquUKPSnnNHDYaGm2ZNMv4eyklhTIJgLsYVH40REra8teOmYJR7SuQjnmkImJU/Glfepi33cpDf/ATyx6hYwcgH3OFHNdD5Hx2dxT73Kh8H9Keg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714506972; c=relaxed/simple;
	bh=Ly5MCCx0ouMmnG8mdHlwZ0G/gMHgbS0moyNwG8CmISc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FcdIJ9kkSyzsSGfjiq3hX21zzoPEP9ZJEUpnqZPTRJ9Xrr6hZ1OUg20tQONWfYVHCXF2sw3kg1aT5nOduWvzIAURSonPF4TzxDM3c/6bsd6QimuCM8vDzvTCANTg7Mm5N1+3qZXxqU9ghmr0xBdMs7aXMCjEGLnV8ROIipIlVys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M3eNlOmb; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M3eNlOmb"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be452c62bso30410447b3.2
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714506969; x=1715111769; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6kHhk9VTDawcXJXAQI7oPMaxgm0kzd4qGSjA+hqQk1s=;
        b=M3eNlOmbsuyITPTxKlbfUSJepIx19AoGBeOquPvz8QLUHDSw7eTFCY+JtSIuox4r+i
         4KFu/3yPzHQEwb5OJrQjm7OkdHVLfb7t8wiRi/nGn25qUjVW2wFltF/ixBW1yKYE8oa9
         37IX3gqpz7pScsxGxHmhgmKUFbvYk4hNbmd3q96Zu9Vtf3Ks5P24ucugEr6LpjHrOx9E
         pXvEKFDuju6wtPVfCp4UgXdxyLaPbNbOhm1xpPHCMNPZJe2sZAFWxGo4zDZRbqsYp6PN
         e+zjm8F1UcJVkPJXl9f8M+uWPNaCPI+FH6po0LX2D1IwXxb28eRq/wY589C25v10BnwO
         uk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714506969; x=1715111769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6kHhk9VTDawcXJXAQI7oPMaxgm0kzd4qGSjA+hqQk1s=;
        b=rBXR7hwel+6yAMg/jPW7+4Uzj5TPRupIf4oZ5CIZEHO31rq13erXtoVffiiI7eicMa
         byrUlDID4D5Hou25dk7+58V62p0aa8NG0TbVMY4JbRcek48NvfMnxfZy3JBKqMGxIif+
         mOuw9QhUzcFZZS3S6gmgCQFMpRnBTrqgTrx3QxZpWKmlplJGGsPriekuxOLsc5IGblHZ
         oeYnEa46RJDRSF3cVRpx3eRspT2wAnLSBWvsm4ua914ZobWQGTNbyPmoldKjL+q+M+dB
         QMFEaMWmPFz/5FVfxu7so/bEoMwjp0xJ/I3H9lhEZgtuDgH/N3TPBl02ApALhdblUlr8
         RalA==
X-Gm-Message-State: AOJu0Yx24mFostSD8jOrRGBiUlKcvtKk47FhEtUQ9Uwmak6IN4qRD9Oy
	s8mQaeH6PlReR9a3CgK/W1lLMIj5Jz7cGZaA0IF1deurggr+cUaebs/e10ZRzej0fvG7IznC5FR
	aPisydD5pQX+0zJmXSE/Jw64/GltkFHS0X7MLxI6bWDi7yrE8EFUG/0VSmGEEIL+RI2Tspy2zDL
	Q3jbXBNLVfEvGw/QzLJt/Gn778aHP/dvZG8LPgsa0=
X-Google-Smtp-Source: AGHT+IGHRjrgCe7A0ev49zbiJ4NHfj5mUe+Hb4X0Vj70H2MzCgsriyQknh82/8AfKWA+dH2fU/Io8NTMiQDlvQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:3e48:fe18:8aa:8a0e])
 (user=steadmon job=sendgmr) by 2002:a05:6902:1109:b0:dda:c566:dadd with SMTP
 id o9-20020a056902110900b00ddac566daddmr58652ybu.4.1714506969451; Tue, 30 Apr
 2024 12:56:09 -0700 (PDT)
Date: Tue, 30 Apr 2024 12:55:55 -0700
In-Reply-To: <cover.1714506612.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1714506612.git.steadmon@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <a8bbff2c6bcea6a8874d2a145cffe370d6cbddfb.1714506612.git.steadmon@google.com>
Subject: [PATCH v5 5/7] unit tests: add rule for running with test-tool
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"

In the previous commit, we added support in test-tool for running
collections of unit tests. Now, add rules in t/Makefile for running in
this way.

This new rule can be executed from the top-level Makefile via
`make DEFAULT_UNIT_TEST_TARGET=unit-tests-test-tool unit-tests`, or by
setting DEFAULT_UNIT_TEST_TARGET in config.mak.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Makefile   |  2 +-
 t/Makefile | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index ba55d817ee..b0d1f04b4d 100644
--- a/Makefile
+++ b/Makefile
@@ -3870,5 +3870,5 @@ $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TEST_DIR)/
 
 .PHONY: build-unit-tests unit-tests
 build-unit-tests: $(UNIT_TEST_PROGS)
-unit-tests: $(UNIT_TEST_PROGS)
+unit-tests: $(UNIT_TEST_PROGS) t/helper/test-tool$X
 	$(MAKE) -C t/ unit-tests
diff --git a/t/Makefile b/t/Makefile
index 4861edafe6..0ae04f1e42 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -49,6 +49,7 @@ CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
 UNIT_TEST_SOURCES = $(wildcard unit-tests/t-*.c)
 UNIT_TEST_PROGRAMS = $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UNIT_TEST_SOURCES))
 UNIT_TESTS = $(sort $(UNIT_TEST_PROGRAMS))
+UNIT_TESTS_NO_DIR = $(notdir $(UNIT_TESTS))
 
 # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
 # checks all tests in all scripts via a single invocation, so tell individual
@@ -76,7 +77,7 @@ $(T):
 $(UNIT_TESTS):
 	@echo "*** $@ ***"; $@
 
-.PHONY: unit-tests unit-tests-raw unit-tests-prove
+.PHONY: unit-tests unit-tests-raw unit-tests-prove unit-tests-test-tool
 unit-tests: $(DEFAULT_UNIT_TEST_TARGET)
 
 unit-tests-raw: $(UNIT_TESTS)
@@ -84,6 +85,13 @@ unit-tests-raw: $(UNIT_TESTS)
 unit-tests-prove:
 	@echo "*** prove - unit tests ***"; $(PROVE) $(GIT_PROVE_OPTS) $(UNIT_TESTS)
 
+unit-tests-test-tool:
+	@echo "*** test-tool - unit tests **"
+	( \
+		cd unit-tests/bin && \
+		../../helper/test-tool$X run-command testsuite $(UNIT_TESTS_NO_DIR)\
+	)
+
 pre-clean:
 	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
 
-- 
2.45.0.rc0.197.gbae5840b3b-goog

