Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9C114EFC5
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 23:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708731250; cv=none; b=FbxvsbRiM1FM++056GlJHDkl5LjvTt4BmMR10Lzgs2hjd9AQPq01lpoFVJmLwKnWFdurg8pixRDUXSPWOpx8zl5L5NnkO3R29RSBy3qAyc5zOp5sKdQx7JVaoeY5UkLjtJkt1/zp46IyGgbetFbvzyIX/2iF5l6EIouidzs+W8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708731250; c=relaxed/simple;
	bh=SiQqByYeEQzhpPBR3mV88GDAMy83ayejYJCW2Jy+nWk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oi8VbcrDOKgkNMT37LkOxIS8/G75mTGUUN3J9Yb3tJBOQ/NF5rOsWeJex6IqbyDNJk/jUQtAzLYnduRLIM+JlKlsehg6wfDMKAg/mkkt9NlxgcGP/KgFnxp1QV7nYsdJJ4k0EaguYshnMMDNAsZq2gqUo9rz1DxZy0sxFMPqxr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FI3ZcS5Q; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FI3ZcS5Q"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608575317f8so22543247b3.3
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 15:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708731248; x=1709336048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tsP8u0s+63+2WSgJOtZp/ggjt+17TUlD4Z0p+56oLUc=;
        b=FI3ZcS5QtQw25HgHnCwGJHZdRnEvJv7PDZ0vG9hGTCNk7ILXnDTlTAFtnPvUC2sGQn
         kgP1jyQV5hwSSsvQ6UFl2gOlj5xxXMgF8iQcZngqeaQnxqp6EMqBK+7JTEoyenDA+HQy
         3gSuP+Yg/JSS89Pt/pr2mlPcv6Gwf651sbsngQDqe62KwymdULmpQhBr/VJFVaxrlr1Y
         EDh5jCTnR469/+nQRKU5O4ocA1m9y5VJ0I0pUIUzombKZFLcXb4huczhHSy9FaleFnZb
         cnNet9KS0Op70Gu2pOWb7ezLnMLB7vcPzT/WJE6p6XyATavGhUnCMQHvb5pqFCaTVpmn
         pdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708731248; x=1709336048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tsP8u0s+63+2WSgJOtZp/ggjt+17TUlD4Z0p+56oLUc=;
        b=cVNTJnTfW7aj08h3ecENUqI3mSz/D0zQWjVN1gnivRStG8aqKq+kh5SKxWuVV3CeF8
         fLxmWPJAv83L3QFPu0QlFTwoFuOHVCJ7//WmSHFpUwQRK/xWNrrTIlVdJ+CYLSo6ZPLy
         B/7OK6Oc4wmMkuIACzj5httDU7YBgQE8QCo3AERrda/C8kqWrjTyCdbCVyD9Mkatn16A
         thPMYCQIdpN9TgyzpVJR+7vJGPoQhxuOnMOGKbIb9ooe7ciLO6K6/+990nlVgE4wMETe
         c3AzD4MuEKuPR3NGDBHdFldM/FWEizlzggLUHJYDtXX8ylhMGPIZxoJzMg+8ORY8xGfw
         m9bQ==
X-Gm-Message-State: AOJu0YzmRJ+1OuDtaBf/Y9mBMmkJxpNvAfpRHbqXp4337s75gyNAqx/O
	3JW7bXV1RnD7XokswjB7WBRwGshnP4oqy1v2l/2Imh55Yk0Tn6LCLGq+6oIVEUGQHR9BIxFS4US
	ftQHtf/NeaXuM8Ql+UUhPryPzVfceiasxd7GB2v0TB1XocUQ3PI2T01IOFMZcyMZwYc8bYvG8Nt
	lM39R7KAW5K1y4QEuFAdrNkRyP26H488el3+r3XO8=
X-Google-Smtp-Source: AGHT+IH6iJ5iAGRdXE2nXSG7GKky0UUGrZLkrn8wSmSQmTJMnIFyJDnTDrx0RJImB54ijtcOHlwwAyjV/s/CDg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:2fd9:97d1:a490:26b8])
 (user=steadmon job=sendgmr) by 2002:a0d:cb53:0:b0:608:7d49:85de with SMTP id
 n80-20020a0dcb53000000b006087d4985demr254796ywd.9.1708731248076; Fri, 23 Feb
 2024 15:34:08 -0800 (PST)
Date: Fri, 23 Feb 2024 15:33:54 -0800
In-Reply-To: <cover.1708728717.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1708728717.git.steadmon@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <a8bbff2c6bcea6a8874d2a145cffe370d6cbddfb.1708728717.git.steadmon@google.com>
Subject: [PATCH v3 5/7] unit tests: add rule for running with test-tool
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
2.44.0.rc0.258.g7320e95886-goog

