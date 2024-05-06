Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0121F15B10A
	for <git@vger.kernel.org>; Mon,  6 May 2024 19:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025470; cv=none; b=P0nbngdaz9dLh7HCJkYYjIxgfQ0dCwMAAN8lFvVTfd6QGJO4w3ISDXPYEzQjZhGJFR0ISrRZAv/Ox8hSuxJPwKkzMzp4WJxGAb3JrieYI+ECbapLaJZL+ZQNUM/21UMbN4FyJrTQIOOaYDMHc1kC0DfWOwZQzCVoB/l114o7bOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025470; c=relaxed/simple;
	bh=vvkdPxgBTLNm9rYCJNcB2ylQeVVO/xBvfqaKfqvx1c0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DTc9OCUcj1YuTxlBcVZIItj9jYPGUaYTRpFrtq5OqOXCd8KxHPvVN6AVJlXiNzq73inyDMCcbkJKEXuLzG3zbTFxnahWQknvVnWYC0IHpVzZP0EXo+7WgSWiKNCO/Dm5BjobR/Hn1PXhwWxbu3PVgZLPK1tnfVZ332tpZasEB+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hDNQXBMm; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hDNQXBMm"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61e0c296333so58574497b3.1
        for <git@vger.kernel.org>; Mon, 06 May 2024 12:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715025468; x=1715630268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Te4JAQhYWNwMg09FSYQHk0fhr/4qReTBh2xzBw5qAyU=;
        b=hDNQXBMmYGXjL6CVDiCh+HeJSCr7f8qM2+Eis6uhO1M816DYoG6XZEyi/CtL4x3ycP
         MO/51qvlbGxbR5gcAvcEJHmEcKjR98mCm5IzKzD9kPRSarImOBOnuCMd/GqMVUHhU4SU
         9ajU9hx6UkJ0P+K3BlWhfk/7gK0BPUddVoN7vTDGVXUqoSK6tWExhKcpEvkaRAplQ8XE
         RPNFxwyvAHCWuyAdW3vdvimxzT4uJo3noizFpPzv7iBZL1pmIgKAdR5DUbtxiyXylb5t
         vs7WJrY3DEMyE4JyCRU22OOl067cSn6r2of0wJXvvl201YgakmM4KZP0DCKHWD3H1J1T
         tYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715025468; x=1715630268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Te4JAQhYWNwMg09FSYQHk0fhr/4qReTBh2xzBw5qAyU=;
        b=QGE3YVklWuJfWQGnE2bvjfZhMtg12i3K5/sazkUharOw435KFn0oaISZRu1GJpL5w4
         OQFpxoRulWf8vlcGUzj3kloOVsQqaSXr/N0S3UbRtdZhcnkQJW/GaeNiMX+GD5wlvn/6
         08B0yqIjasNskWluQFoc98y9bePQtG3ceE/6C8bHF3zTZkUUkeNxBFWjArSUuD2LuyS9
         uV0cVvZ8iV7l1oTvNcBB2w5WF4Gzod/r/sEPbTeoyy7u7gLTH8Y7ySU45Bt6X1GwSKcm
         vLXFFQvRCIgPGZL9TrPKva4eoON+ROgvh0nuGGs+bM+Z9ouq6ROxN+6n9wx6V2s79nYE
         fflA==
X-Gm-Message-State: AOJu0YydT6pwaQcst6xR+dPij/XkkJoJ9Ntp9POAVfJu/UHgeyNJTEsD
	LS+MCRhbRRp+Djji3hWY03Y1/BW/i/kIMDrvNlaMDFioTrLDJqABbUjx5Wh4WN8/4VJWY/28db2
	fOWMJ8+tLNRj+59rMlsO+/9ECZGbh/swchSrRP0Y541qDYXOFPC/VzWT2V5rhwKYO4XYxLKVEG0
	RI3k+wVtA/VdSR/qKaNKphi61YUtzYKMeJSC5ETX8=
X-Google-Smtp-Source: AGHT+IGeq9GLwbZmTWtGoxVnz/gjplzMlg0dHuLiEalodAOwaQGXpwcJCaUHhRSirA6B3P7K917Gm3HCmrCgfA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:cf3e:6b4e:994:dc81])
 (user=steadmon job=sendgmr) by 2002:a0d:ea04:0:b0:618:5009:cb71 with SMTP id
 t4-20020a0dea04000000b006185009cb71mr156143ywe.5.1715025467997; Mon, 06 May
 2024 12:57:47 -0700 (PDT)
Date: Mon,  6 May 2024 12:57:35 -0700
In-Reply-To: <cover.1715024899.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1715024899.git.steadmon@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <a8bbff2c6bcea6a8874d2a145cffe370d6cbddfb.1715024899.git.steadmon@google.com>
Subject: [PATCH v6 5/7] unit tests: add rule for running with test-tool
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
2.45.0.rc1.225.g2a3ae87e7f-goog

