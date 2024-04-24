Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5649D768EF
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713986067; cv=none; b=hqdLTk/HdL8wP/v/iXQbrlANRDvfXgQAoQCDL4H0sIkY3omvmV83IEtO3oQ0TgPq4je/apsYUi+DcRjPas68CRWbXacXsbDXDMP/jsL5IajzWzw6LH3t3FYKpUiEwn6bV7PI20LHOCMSelXKPxm666R9lGO8kH+8JNOSMfM8JDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713986067; c=relaxed/simple;
	bh=0o0CxDfjGz2bjkuxxOsWJ4cKzUqvmEaqYobt7WRc7iw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FQ7cjykOEwexDwmYA3NIE7+SfYHD1diSd9MGyUinx8z/LQPhWg6RukzO9iDJokc/deGHdgqTtGmKdEAxmsYTh4Diq/gVmpXTFJo6mbB3VctqMSXbM9MCZb9zpLIy8WY02k6Wrv9fQCSp1ZaTpwiq0HQwb4cDvhLI8YXTQxP3wWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pqUFNlUI; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pqUFNlUI"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61ab00d8a2eso2553487b3.3
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 12:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713986065; x=1714590865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KbD6bguqs6FaA9q79veX+5zGuNpubqTIT4TYQlUpYMU=;
        b=pqUFNlUIN5cEoVDdIwxMKckXb4Qhg4YR/U0YM154xn57BxstEpKUgeGs3F18FxbtzQ
         IrZHI83Rw0y4U1cNOtS9e10+10Yz41OEH7EHydb9R3QSnPa18fYaowE/aKLQYt9JBjED
         23z3Ahb9SMbGhqwfGs5rJdOY6yBzRi+6c7+daQH69wANDxxG3em5yjRYs3YFGIe6sipU
         8q1OXbx2WEdN+1NkgDbcnNs3nJY3T/avyT1GAuw9/FYCCYsIirv+0uxZdsJYLHiGnLma
         +zm4B0V7sXOgnLoURGfOWOsFp88be6yzI9pqKKnaxzKtV7ow+kmaD1Cd2KxVlN2GUsdb
         qMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713986065; x=1714590865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbD6bguqs6FaA9q79veX+5zGuNpubqTIT4TYQlUpYMU=;
        b=UbEomKBVVLgc036hYSJbuAfz8eeGAxpSR+x649eygJpxLyPqXOIoEdEbqAR45dpBKK
         +yRYwaJDXiO7nYSoG+3pVEw8eH6dIYUeZ6K6ZPPUtshJQGASEy8B+ThsftoXl+klWk58
         Y1AxFJVvKr6S8GYsCKz2gcRCfqZ4K3xpuU6pDz0yhJqJ1yU66xwYRQTdRmqJ4mXXLpAQ
         Bacx32k3heTIYgNTRNBcYIEXYMxZI34zraSwGCeywctfHbAJb/AlWRclBWq32oPV+TsY
         L7LU+US2+tfCH5n0x8wXwkiFWiFBuiGTlybA3i+mr+AQZ0eWexT67YoBmo0PdP1wPF6G
         xanA==
X-Gm-Message-State: AOJu0YyJXeFJZQVSVAAIdqmXv4p2XMTzkgXvdRQZv6hN1O5MvvAymVFM
	qlOyngVIagAXsZFueGgGWwHU8FroARnZcqSNrSZXuRdUyvTvmWghoDiIytDgTCi8qiYTJsOWnTW
	dAa8JADMgFgkwJolBxbdGD2WUaf+lTuDMs6b1oHcVufhUBc2nNW6lwxauPx+qH5lbtEMXZaw5G3
	ZdZYfABCjekVLoAdBSlTje4vc7C1Tr2lAEw5VMhlM=
X-Google-Smtp-Source: AGHT+IHDHPbJNs+0IRnI7I3rb1l+RbMYjSzrfxPpLZiiQ+itCNCJOoSdOgmej+YEl3gX/1xuExSGpWy5zOtYRg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:5580:46bd:98b:ecbb])
 (user=steadmon job=sendgmr) by 2002:a05:6902:706:b0:dbe:30cd:8fcb with SMTP
 id k6-20020a056902070600b00dbe30cd8fcbmr336936ybt.0.1713986065321; Wed, 24
 Apr 2024 12:14:25 -0700 (PDT)
Date: Wed, 24 Apr 2024 12:14:11 -0700
In-Reply-To: <cover.1713985716.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1713985716.git.steadmon@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <a8bbff2c6bcea6a8874d2a145cffe370d6cbddfb.1713985716.git.steadmon@google.com>
Subject: [PATCH v4 5/7] unit tests: add rule for running with test-tool
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
2.44.0.769.g3c40516874-goog

