Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075C822EE0
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705443791; cv=none; b=hQdOEGLP9z2bWeX+sP56o7TVq37wU2tfyTDPYk3txaSseda9VEA7jIe8/0T3Wxmo3QBEP7IRi0j4WEUQBgCGY9nNFaZ0NKK33GxE0VBG4a6ATDqeOgZUuIwMQZNhg+Q4EIfit1I1zSbE+l/A8gC2KFPUPBdAfihhz459a7RVYv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705443791; c=relaxed/simple;
	bh=GQTRefyPjES8n371fwE1Gxb6aGaDP7Gc3VM1ltqi2oc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:
	 From:To:Cc:Content-Type; b=gIQTku8nZ1aYZsV8penrxElj0Z09uJMPZgNqXppXMB9stYzIO14NMahf6tNOZYIeudhJN5s3ulEgJQl17+BGfumhrD94FnwopUtHs8UDDDuZt2c352KjuMpzJWOJ2pU3o79Y4qRfOfuC/ohgGlKchi53zcwvgQ+2FcLw4CNB0hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K/ucDt9P; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K/ucDt9P"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf618042daso3769810276.0
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 14:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705443789; x=1706048589; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UYW1NbBD3CBw5tYdWW7N+SPMKc2vXBTmZ8E1zRgTAuE=;
        b=K/ucDt9PLbEZfxILwCok/jLemMVE2F1voz4iBrld2Pcb4XJO4ahmexyRkyWjaYKZjG
         wvbSuBtxvoPXgsLOJDsBBSRfWXbnELf9KOroARJ4uCscmYjrtkGdr3XmohRHfk8iTpoM
         ZW346xU9ceHWEz/c1ibMpcparIQWVJQqqCvw8zqLsZQWGsWWvBIEFUCM5+U9i4eHXEth
         cZd/TF3O6bIkpGKiVEGmGgOXMEXA8lMg2ldMyZpfkaJ35jz2HW/b1ibzDH21ef0E/Vro
         0kX/+AlhmBM+JJv+cPBEdxE10sLOAgqF8iPh2vqnHkQfF9saL53G3/zTv4CAon33pLFX
         LG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705443789; x=1706048589;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYW1NbBD3CBw5tYdWW7N+SPMKc2vXBTmZ8E1zRgTAuE=;
        b=CjMGMtecirwb+rzRToW2jGUGWjzClcB4UKf7LU5naQRWzx6febtiJkqsm9C1SHY829
         vML9n1fmF1icw6w0YypYp6Ck0GuapL+eD8AmPi8lqbLsmm7tDIZTN4C7VhDWME60qrDO
         6ZNwQpxcGOLHPyEBCCTc1IHfFVynHtijEisnL53HGnFyHS204e50ZRjdCfrWzMIoL/ao
         hEvDgg0NoPGgHH6DkQOWgHMJ9WM+4jIqGLN3Bovh5/V0I2S6PhG9ysWbshXtmlEedzD9
         b6QHQPm7llr3ZDdnHNy56culQu0QUUHmojOYgWjf3ctiQTglj9xjxDDeKFhvsORuz83U
         edMg==
X-Gm-Message-State: AOJu0YwSoL4rCmEbrwuwvm7qWtGPIbMmcLHFGCVqiweptIWVu+tRmQjk
	UnzTHeVrmOnCYBeNUuthci+9czJGKR8KlvYsGCQlpzzBIcQ8FK59IuV7GnLtO0k9JkztoP7NCDD
	3fDed/bdrU+oSOQpQGJ0eXQuOWJMsVMCnr2Z5p233bV0HCbxUSCuQJAaHqNkGb/FT/1fGaQ==
X-Google-Smtp-Source: AGHT+IFAPQqoQOsTQ1jzzVbHABBBUyPmX/XPnRq0q+E9BDoJiV1EGKu2kRlwUF/L7PSufMJSp8661UQhbN5f3A==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:a6f6:5624:1895:86a4])
 (user=steadmon job=sendgmr) by 2002:a5b:c51:0:b0:dc2:191c:5410 with SMTP id
 d17-20020a5b0c51000000b00dc2191c5410mr171850ybr.8.1705443788952; Tue, 16 Jan
 2024 14:23:08 -0800 (PST)
Date: Tue, 16 Jan 2024 14:23:00 -0800
In-Reply-To: <cover.1705443632.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Message-ID: <5b34c851cdcf97e52a4df0e4bf4724d388c350ce.1705443632.git.steadmon@google.com>
Subject: [RFC PATCH 3/4] unit tests: add rule for running with test-tool
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: johannes.schindelin@gmx.de, peff@peff.net, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

In the previous commit, we added support in test-tool for running
collections of unit tests. Now, add rules in t/Makefile for running in
this way.

This new rule can be executed from the top-level Makefile via
`make DEFAULT_UNIT_TEST_TARGET=unit-tests-test-tool unit-tests`, or by
setting DEFAULT_UNIT_TEST_TARGET in config.mak.

NEEDS WORK: we need to exclude .pdb files generated by cmake [see
0df903d402 (unit-tests: do not mistake `.pdb` files for being
executable, 2023-09-25)]

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Makefile   | 2 +-
 t/Makefile | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index ab32ec1101..ce43ad2ae8 100644
--- a/Makefile
+++ b/Makefile
@@ -3880,5 +3880,5 @@ $(UNIT_TEST_HELPER_PROGS): %$X: %.o $(UNIT_TEST_DIR)/test-lib.o $(GITLIBS) GIT-L
 
 .PHONY: build-unit-tests unit-tests
 build-unit-tests: $(UNIT_TEST_PROGS)
-unit-tests: $(UNIT_TEST_PROGS)
+unit-tests: $(UNIT_TEST_PROGS) t/helper/test-tool$X
 	$(MAKE) -C t/ unit-tests
diff --git a/t/Makefile b/t/Makefile
index 0bee7bc6ea..ad57ec0a41 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -70,7 +70,7 @@ $(T):
 $(UNIT_TESTS):
 	@echo "*** $@ ***"; $@
 
-.PHONY: unit-tests unit-tests-raw unit-tests-prove
+.PHONY: unit-tests unit-tests-raw unit-tests-prove unit-tests-test-tool
 unit-tests: $(DEFAULT_UNIT_TEST_TARGET)
 
 unit-tests-raw: $(UNIT_TESTS)
@@ -78,6 +78,13 @@ unit-tests-raw: $(UNIT_TESTS)
 unit-tests-prove:
 	@echo "*** prove - unit tests ***"; $(PROVE) $(GIT_PROVE_OPTS) $(UNIT_TESTS)
 
+unit-tests-test-tool:
+	@echo "*** test-tool - unit tests **"
+	( \
+		cd unit-tests/bin && \
+		../../helper/test-tool run-command testsuite --no-run-in-shell --no-require-shell-test-pattern \
+	)
+
 pre-clean:
 	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
 
-- 
2.43.0.381.gb435a96ce8-goog

