Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDC863CB
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 00:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706921446; cv=none; b=ev7RziiuKhisEitZgkdUs1slvMlEL3w/rZLlIixbD84zVBFam/nDTjhblIBi8fog9s3HXqOGtsIfLGaCfcs32tn3VLLYiuEuxgwZiH3kcCM22zOJbA6i3glruG+OPBAyRTOodxN+hZZ3KpFDUfPdwunKa9u14hqGaSwj6QHegzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706921446; c=relaxed/simple;
	bh=EWOirqDuXBrPcUm4D2QXoU1aTxTanl5L9E1qLu9aaGc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZTDxTQQ1LRwdy0Q/UBPAnMFRgZhpTI+rEFoXfHrw8es++3QMTOsQ8Py885tH1QfDKycI3jGMzO7ibw/h5dQdQYVz9xmLTomz6Ygbw+d0z39LPedES4Fl8umq/fQQERwZNKoTkAVgyL7xj3YwQW/qTbtiJ5P9Keco2SQPTo7kRlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wqghtr/F; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wqghtr/F"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60404b12af2so43158767b3.2
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 16:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706921444; x=1707526244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KmSIMf2vwCAOfQzAupBVRVGEAt+IBP4x+xK6jYJMRds=;
        b=wqghtr/FKxuFYZlEYEdbBYSSZay4z/Po15aiqB+YngdKn7OdjOs3J7p8jXgBDlt8L1
         SJtJtAdamW128XBk00P/+frw9FjTOaVHRMGK9l97JcteyqBfOle4nOQZujLXeMbb4x5a
         jAmK7LpDTSLXvFmVYz1x8LFwGcwd3xLc8CmcMmxZKyrhyghOXY970KjSj0SV9l6/U+Es
         ZgU6AOYeT+cQn1NtB5ZUVWgwuDRiEZaPloRRBQ2hxXj+mwzcFy4VmhWRUxltpT1p4VK1
         y+j6q68icqcwenchNQBWoWynfk9p9FGa8uIHBAeIfRAQisMx87FLgUvCNm+dHE8TvgkQ
         J2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706921444; x=1707526244;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KmSIMf2vwCAOfQzAupBVRVGEAt+IBP4x+xK6jYJMRds=;
        b=S1m9qRRlIftiUUvqPQxR7HG9asT64NyQXEndfEbSYafGlevNyWjb7AfFtCA+n8XQwR
         ghypb1yGHTcMNjKV72aAY3OL5fYB1khYKmUBppuyOBFyRP7M/6VdpwubYKe41vAAc724
         lrj/teddq0M5mNufqPUp6lQYCSAr0wUbcgKNUd6Dzgm0a3i9HZ6cGv5c0KLCC9RbOaZp
         7qOmC01POPz7YiIHGUyfhGbiwv0GS9RNDL0++xjhaVICZVnrtaeWlExnMXVhQJVa2kiE
         hZl/+EGRL3XeT6ICdfa3JjZyAvo7bHGJnIqLwDHygI2KaXxlfLrBj7QaOsLucn0l8iBg
         v78w==
X-Gm-Message-State: AOJu0Yz21Me2rCt2Vh+VUXHLgFpYpSLiyDVqivOD10ETuHOy5v/gi9sK
	nKsOITzBhcDWhm3BiRiwpXvD9FNT2uSTbHIHQFVAsAP0t37Fp8Una4H/zo3YUaMeFD0jvYarzuO
	nVkmoqTfTk6KixXWZ9otgDjtMGA7dPeO47yFDa3ecVUjtI98tUPdZ1PRnYR8Tklf1J43PZOCulf
	I9iMFTFmlSvJxdcdPy2qscV6G+xXZvUrosaGhp29w=
X-Google-Smtp-Source: AGHT+IF89TCuUZll+8u9YSiIRVUOwr/yYqBHeVDxtSMu9srr8OW4ioYTkqmjqtxVN/GCUs8kOw6mbTlMywe3fA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:705c:77af:6ef2:8f42])
 (user=steadmon job=sendgmr) by 2002:a05:6902:138f:b0:dc6:dd74:de68 with SMTP
 id x15-20020a056902138f00b00dc6dd74de68mr210023ybu.12.1706921443881; Fri, 02
 Feb 2024 16:50:43 -0800 (PST)
Date: Fri,  2 Feb 2024 16:50:30 -0800
In-Reply-To: <cover.1706921262.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1706921262.git.steadmon@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <f2746703d554d65d41afe0e41b1c9757427cda26.1706921262.git.steadmon@google.com>
Subject: [RFC PATCH v2 5/6] unit tests: add rule for running with test-tool
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: johannes.schindelin@gmx.de, peff@peff.net, phillip.wood@dunelm.org.uk, 
	gitster@pobox.com
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
index 1283c90c10..6e6316c29b 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -45,6 +45,7 @@ CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.tes
 CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
 UNIT_TEST_SOURCES = $(wildcard unit-tests/t-*.c)
 UNIT_TESTS = $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UNIT_TEST_SOURCES))
+UNIT_TESTS_NO_DIR = $(notdir $(UNIT_TESTS))
 
 # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
 # checks all tests in all scripts via a single invocation, so tell individual
@@ -72,7 +73,7 @@ $(T):
 $(UNIT_TESTS):
 	@echo "*** $@ ***"; $@
 
-.PHONY: unit-tests unit-tests-raw unit-tests-prove
+.PHONY: unit-tests unit-tests-raw unit-tests-prove unit-tests-test-tool
 unit-tests: $(DEFAULT_UNIT_TEST_TARGET)
 
 unit-tests-raw: $(UNIT_TESTS)
@@ -80,6 +81,13 @@ unit-tests-raw: $(UNIT_TESTS)
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
2.43.0.594.gd9cf4e227d-goog

