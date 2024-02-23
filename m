Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D973114E2E3
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 23:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708731252; cv=none; b=j0jKohC2OBLj7BBHxDrSOi+KB9ndrMw8L91tAGAdlEVPKTXStBgVPgr3swFOGCd3uC61flNC4qALKuGS1/JfN2gyX4p2oNWlULwosmj6WeVimbqJMaOoJzOPRi5BCoGmqsHLLIljmPmiTzcZ3vTCPyu2fLwVrYw6jH+imFzUfto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708731252; c=relaxed/simple;
	bh=tiJVQbgbTgTXpBcwOAw7AokirBNUNgOM0EsaC6DQ9So=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TdiY+kDvq8R75fp2l65UenvbpZcEyLLs1zBQWsyrPS4uFbSLS7j5JhbItI1CwSNfXkex1XAp7paDEk7xjh/SS9tHLuMv+P0HF5iCbaT+fYy36SuVYH3pEcPFuqPniJejlDlFRLQe3cyAGq7tilLo3DNji7sx0uLbawJDYwjKjy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OOX504jB; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OOX504jB"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc0bcf9256so2020352276.3
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 15:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708731250; x=1709336050; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V7nNYjRr2WPTi1Fwl0q7+3DWsrU9EN5PibjP4kQhviU=;
        b=OOX504jBkn7SVEW9wSe7jmlULk5YoHl2V9X0zzwePl5tRNi1dASRLBvsl1atmkF6MZ
         9duxW4EOqWot+KKkzn8914QE2WgX31ylVTYgzRiCBOsH7xRgbBwhqZquOZT6hbW/1RMN
         hGBNGcqhiQnxErDWCi9cBsUeCmyxfu2Nhh+Pnezic4K9DO/XlORldiGwKLzKjtJg+X5L
         3nRdYpPE2C1en0TdwfrHm361eA0pvMsgH+51MDu5qK7BQ/MOuuqFddv12z5uui5ko9U4
         SywelN4sXZr3P6lbamWddpnTtLm+z8/XSrP/LpLMD77R7t/clRzA4Qu2M7emBUcBzxYr
         CdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708731250; x=1709336050;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7nNYjRr2WPTi1Fwl0q7+3DWsrU9EN5PibjP4kQhviU=;
        b=foXXV01kqp8Hft3ZLHdF5qgN9lXXOHrWia0Eghsl2sEG1w7nWz9H32CPC8ORrVYHbu
         eGgtkPIKFMcI8Z20MvoobcN6IIClL5tO7jDePMWBWvIa7KPFiKzuI9utLnzpQU4xpMXB
         VHGCr/4iSCVGHyScXl9WHTRx/N8A+59IwH05gpPRZskGXLjVV93GbHbG8HvxWZrz+B1s
         Ss28M0RuW5hCQjlvH3s/kWKzJ4EjNxM5WzNQrSUfBCmUIe5kAIDOeNx1ypiVSasBHYFL
         aQFU5tSEYvTxUgoriCy0sicWfgNiM8oZWPuDB9se8456Vm6Z20sQj2Wr1+Av+hapvZrZ
         jjVg==
X-Gm-Message-State: AOJu0YztayxUsdGkks4vnVDbs+gz41ZLdSf3Omu4uObhtOKfg3LOu8uy
	kPd5jPQYF/heKfyqenNR9ImlaUxjz19pfd714n43ROXywDtMRbjqaKUOBgyrBvHbDL5G270FDfC
	bkaZx9RU/AjWh3YtkQtf+CGkqOkFPuFs1qhuRe0Ejp7ZDDocAuhllCYqB3Ndf3D8hxpUQI3BLeM
	SnpzE6wwwb9pJX8/zebO+nqFjnGpHjXmp+9AFMMN8=
X-Google-Smtp-Source: AGHT+IEVfGUt8FdVbB3/t5NAP4sedc61MWnlVzpwOMfXDfnOAgdwXvmI6cpBEbxrI0OG4xRaqaDfd2fieRtXEg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:2fd9:97d1:a490:26b8])
 (user=steadmon job=sendgmr) by 2002:a25:ac67:0:b0:dcc:53c6:1133 with SMTP id
 r39-20020a25ac67000000b00dcc53c61133mr39590ybd.13.1708731249814; Fri, 23 Feb
 2024 15:34:09 -0800 (PST)
Date: Fri, 23 Feb 2024 15:33:55 -0800
In-Reply-To: <cover.1708728717.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1708728717.git.steadmon@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <cfcc4bd427318fed1cacc8457381d5a0c408460a.1708728717.git.steadmon@google.com>
Subject: [PATCH v3 6/7] t/Makefile: run unit tests alongside shell tests
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: johannes.schindelin@gmx.de, peff@peff.net, phillip.wood@dunelm.org.uk, 
	gitster@pobox.com
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
 t/run-test.sh             | 13 +++++++++++++
 3 files changed, 14 insertions(+), 3 deletions(-)
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
index 0ae04f1e42..0c739754d8 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -68,7 +68,7 @@ failed:
 	test -z "$$failed" || $(MAKE) $$failed
 
 prove: pre-clean check-chainlint $(TEST_LINT)
-	@echo "*** prove ***"; $(CHAINLINTSUPPRESS) $(PROVE) --exec '$(TEST_SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
+	@echo "*** prove (shell & unit tests) ***"; $(CHAINLINTSUPPRESS) $(PROVE) --exec ./run-test.sh $(GIT_PROVE_OPTS) $(T) $(UNIT_TESTS) :: $(GIT_TEST_OPTS)
 	$(MAKE) clean-except-prove-cache
 
 $(T):
diff --git a/t/run-test.sh b/t/run-test.sh
new file mode 100755
index 0000000000..c29fef48dc
--- /dev/null
+++ b/t/run-test.sh
@@ -0,0 +1,13 @@
+#!/bin/sh
+
+# A simple wrapper to run shell tests via TEST_SHELL_PATH,
+# or exec unit tests directly.
+
+case "$1" in
+*.sh)
+	exec ${TEST_SHELL_PATH:-/bin/sh} "$@"
+	;;
+*)
+	exec "$@"
+	;;
+esac
-- 
2.44.0.rc0.258.g7320e95886-goog

