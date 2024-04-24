Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCCC2E652
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713986069; cv=none; b=SUmHmv8athif5vQlSd8yiDUaSTVkv+90NcG3yEGU2HcAZlVFTfXYa9RYA5hosh5MXo1V8ajDdBsEbb4ZlpKVi3SfP0e1Qex96HVr14q+Y1jArFCIOOqIpFrCV4ZQbk4MlZ+wirIVPnPtONBkA7394UE6UGzXGJiDQwc0IqHKYhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713986069; c=relaxed/simple;
	bh=OK/AK7OwRaxjhQuX69mk/1GRNWht2P/CGaHRI6gZEic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GmhF1rFoR2REUWBO50muKroSWldtyK1McNn2JNLK8VUyCg4WMlsVHd/i8i+ADe9kpzPgzg6ZDDapCXvR1aOHlcXXcFVqrQOaMcM66aniqSdmQrCJRi6VC9ySCSuUgfixnBDr+J1KTI4ptiMjPyVgiOdQ6/F4h6tPK+LVeO62r8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cdB9+GE3; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cdB9+GE3"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de58ab59821so80444276.1
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 12:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713986067; x=1714590867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xmIf6E6awSbarOX/qVEWRtHpQQF7e9ghor3pb5DLyDU=;
        b=cdB9+GE3UuZfBr8RMKZSlULtbxQFLDjh78Mav4XZoqXOZ1LZZnHLDQsBYB4picrPW0
         wkmwWuzV3XjahGjF3S59p6Op6P11ArhoJvFa/zIuj5HqcABjoEW7CP+tvN2jEdVztMn+
         6nZN3tBfbpzd3ltJ5P5m8h0Nq8NTfFz+URVg9D/AKxQVgnduuPpEwwh58YhFGfR/dEfi
         yvzFfqLLmktwMm8AYHS3+sqVjpa+Ua3iIyICrXLlAAb+LIliCL6PJ/0jrbe0LPrtihdx
         0di/DZboKNBaP7SJhQaeIddTwNCWtnvfZESr9PuZQKvSKS9aKugXwEVzUtK2Dc9T9iCi
         IaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713986067; x=1714590867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xmIf6E6awSbarOX/qVEWRtHpQQF7e9ghor3pb5DLyDU=;
        b=tKFg4ZrdySY7Ll3WVGSnJd/ZNmIbF/xVFx9lWyN5ZfOW7XDSxOh9lQgozHYZ5SQFGd
         d7M/mljlq39WHH4rS3IOkIdZtc1oHCh4wsKclCuWc4pQnvS3vfvKFiUzz3zfDF9KWCx3
         uuH0VUHjMYMNJqA44oSTpvh8oh0MRvgTTfZ9qyxDLRY2s84QY7SKVP0Kagi6uIYE5Pxn
         LItmm8GXEYK4d1HEN/+z0V8DwhfoT11+VYicfXdl830FlR76aqny5PVlxk8q954xMYtH
         RqtMIKaTAdtGKHauZ9OXKtvM4Ny+YTdk1oinWU7ijAomyhpPeAdb8acOWbDEHTe8hkQw
         J6vg==
X-Gm-Message-State: AOJu0YwoqTuI8RDO6k3Btjda4HiNL5glfEu1slHICkPS5zFZI74Fnu1b
	YnPjTJ7g5PpbG54xGydHPibEvwaZU7AA9QIWERl00X99zd6ErDnirsd5riAVE3wSIjo1lOqCnBl
	qkuVQYCRaMy6UkcI12H+hS/opM3Fz0e/h4wMwhnpvzNnD6bpOocibFauSYn3mPWwhdYNH7LCQnk
	rkR7RnzhHxM7UZcxDVsadQMZwqxmCwLGRw9ucXcmk=
X-Google-Smtp-Source: AGHT+IE4DujGjh/6hRg7T2cxFcYJ8H/8eIRj2b+fUAPWP88a8nIWUa9GKDI/wohus2hwIxPrZb0E1zfoKfSVFA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:5580:46bd:98b:ecbb])
 (user=steadmon job=sendgmr) by 2002:a05:6902:1028:b0:dcb:e982:4e40 with SMTP
 id x8-20020a056902102800b00dcbe9824e40mr1093263ybt.12.1713986066839; Wed, 24
 Apr 2024 12:14:26 -0700 (PDT)
Date: Wed, 24 Apr 2024 12:14:12 -0700
In-Reply-To: <cover.1713985716.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1713985716.git.steadmon@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <0e32de1afe9cbab02c5d3476a0fc2a1ba0151dcf.1713985716.git.steadmon@google.com>
Subject: [PATCH v4 6/7] t/Makefile: run unit tests alongside shell tests
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"

From: Jeff King <peff@peff.net>

Add a wrapper script to allow `prove` to run both shell tests and unit
tests from a single invocation. This avoids issues around running prove
twice in CI, as discussed in [1].

Additionally, this moves the unit tests into the main dev workflow, so
that errors can be spotted more quickly. Accordingly, we remove the
separate unit tests step for Linux CI. (We leave the Windows CI
unit-test step as-is, because the sharding scheme there involves
selecting specific test files rather than running `make test`.)

[1] https://lore.kernel.org/git/pull.1613.git.1699894837844.gitgitgadget@gmail.com/

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 ci/run-build-and-tests.sh |  2 --
 t/Makefile                |  2 +-
 t/run-test.sh             | 17 +++++++++++++++++
 3 files changed, 18 insertions(+), 3 deletions(-)
 create mode 100755 t/run-test.sh

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 7a1466b868..2528f25e31 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -50,8 +50,6 @@ if test -n "$run_tests"
 then
 	group "Run tests" make test ||
 	handle_failed_tests
-	group "Run unit tests" \
-		make DEFAULT_UNIT_TEST_TARGET=unit-tests-prove unit-tests
 fi
 check_unignored_build_artifacts
 
diff --git a/t/Makefile b/t/Makefile
index 0ae04f1e42..b2eb9f770b 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -68,7 +68,7 @@ failed:
 	test -z "$$failed" || $(MAKE) $$failed
 
 prove: pre-clean check-chainlint $(TEST_LINT)
-	@echo "*** prove ***"; $(CHAINLINTSUPPRESS) $(PROVE) --exec '$(TEST_SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
+	@echo "*** prove (shell & unit tests) ***"; $(CHAINLINTSUPPRESS) TEST_SHELL_PATH='$(TEST_SHELL_PATH_SQ)' $(PROVE) --exec ./run-test.sh $(GIT_PROVE_OPTS) $(T) $(UNIT_TESTS) :: $(GIT_TEST_OPTS)
 	$(MAKE) clean-except-prove-cache
 
 $(T):
diff --git a/t/run-test.sh b/t/run-test.sh
new file mode 100755
index 0000000000..a0e2dce5e0
--- /dev/null
+++ b/t/run-test.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+# A simple wrapper to run shell tests via TEST_SHELL_PATH,
+# or exec unit tests directly.
+
+case "$1" in
+*.sh)
+	if test -z "${TEST_SHELL_PATH+set}" ; then
+		echo "ERROR: TEST_SHELL_PATH is not set" >&2
+		exit 1
+	fi
+	exec ${TEST_SHELL_PATH} "$@"
+	;;
+*)
+	exec "$@"
+	;;
+esac
-- 
2.44.0.769.g3c40516874-goog

