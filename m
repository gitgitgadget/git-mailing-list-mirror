Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861451A0AE0
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714506974; cv=none; b=iL04IL/Y/NsqKSiqilkGv7Crt3eb0FZWl6HhQtlo8Jp5CDpo0ZIDFzrGCfbu+cDvT2hXQPTVJP5XXAK5O8ZuoL3bczmxfbdvvnXUO/pzWvZjRiVlOW8M204il9leO5hO16T3ny2lAJXik7n/lxzY93EOBSEbB5Q+bTtwY7J455s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714506974; c=relaxed/simple;
	bh=P7rqg+j7YmGKYDVvzRftuaqgay3cr3G/uSkeijPYLl0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HXXdtOTGymXlUwPk2WpUehUqVjVtRFR19PUbWpVZ6YWEsoAh2p6c9ePbVI9zzqu+D+UAVHIQ1znFyaA3dL+jLK/waCzlzZqzc7ZSJ0LXpBWxxZ/4V8h1Pc6lbsxmjvWSRREJh8i21FidwUjwso5IasKeK901nDg6ANdP9d+imNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UqTRmXBo; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UqTRmXBo"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de604ccb373so3385186276.2
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714506971; x=1715111771; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rceCE5CEDtiQThJgtF1K8/2u3J5Q/t1b5qFYCDmoU3s=;
        b=UqTRmXBo77MFU6/GLuXPnHs7VC87eBG/wbzEuxENvaHZTvp/BLw8DZ7rqiw4R9vWbv
         mrMRMjVSmLkPXvPAgF5fOW3eiGVIjmx3SHNZKfL4iAJZCVb8wrNOEo1FIl9ep9ULr7MO
         xYkc+/M+8a2AdOXvnkalynYzna4j4g34b305cdghiw3yWKGTsVuY+ScC/gpipfHJ/noE
         OIOADhSWZK7fNWVeFvxWWEqQN8IpCcVpRw43D8hW6psHOBlC2bszCkpzRzG6IKrDrROt
         jEDMXDbMphNrwGyZJtkkFP5i3EYwR0oLeXQ1KCbsSHaeU2BRfOWVeoZEV//yVfRIoM1o
         nQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714506971; x=1715111771;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rceCE5CEDtiQThJgtF1K8/2u3J5Q/t1b5qFYCDmoU3s=;
        b=hS/fYeSVFAg9XpLfvCZxAE6yr3WvA7pP9RWLQIE46kdMEs8EJP4Eluim9i4NiY39K6
         olVjwKp58jzQE/vEO+US9x9eVbqewGxdhGjYrSftQzILbANy3rIU4iqkvEMdsjpnHVCJ
         KK8oINUeHWGCtrlVYYZxitoafvTXsCxyEI9YASsUH6WQ6Vt2mFcylGwUkCV2BVmrlH1g
         qq1SscVlwYvrfx/08B0d+nOGVEeZ9v/Fkbt8IER0iI7M0KCpPPlrDV2VsDcC0i2Ru7A7
         bTHC68EWR7uGlCdzjkFkbFmh6NfJpuNhVxZmNncMTTrl4vUWsLxYZhGN1vJzSD7Jl5dy
         jWQQ==
X-Gm-Message-State: AOJu0YyUc0U3M31oGGw1N4ETAPi4L0SyTU2bFF2MA5A1WjPqFkmNOicX
	NlA5gUGPxjbJcQetHjDAMXGoNgKkJ0WyvoCoL1cg6UX4ZxT1YDCLe8fTS4BHy1rFDLHkFTXmhwA
	Qn6l0buKB5MO/70Ii2dJq8ORYl8S/fd0qZsvONxGdwHw224DcLwwkvWDqLJ8GuvEA43YrG1yfEZ
	OJQJWcOf2nZf07M8/HR5wATQLtpjt+E42x724BzZ0=
X-Google-Smtp-Source: AGHT+IGFjE/rqv+tM1gAZgWuH4hSWya5fyB6JpaYtMGeTLVvEZgLh4jYuXKD9AcUyuwHnGOpM0o+xdgPlO3Pjg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:3e48:fe18:8aa:8a0e])
 (user=steadmon job=sendgmr) by 2002:a25:aa90:0:b0:de4:654f:9ad0 with SMTP id
 t16-20020a25aa90000000b00de4654f9ad0mr90110ybi.6.1714506971419; Tue, 30 Apr
 2024 12:56:11 -0700 (PDT)
Date: Tue, 30 Apr 2024 12:55:56 -0700
In-Reply-To: <cover.1714506612.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1714506612.git.steadmon@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <c6606446c47a7f49007e058e9ba84025919d86c4.1714506612.git.steadmon@google.com>
Subject: [PATCH v5 6/7] t/Makefile: run unit tests alongside shell tests
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
 t/run-test.sh             | 18 ++++++++++++++++++
 3 files changed, 19 insertions(+), 3 deletions(-)
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
index 0000000000..0eabf42d69
--- /dev/null
+++ b/t/run-test.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+
+# A simple wrapper to run shell tests via TEST_SHELL_PATH,
+# or exec unit tests directly.
+
+case "$1" in
+*.sh)
+	if test -z "${TEST_SHELL_PATH+set}"
+	then
+		echo >&2 "ERROR: TEST_SHELL_PATH is empty or not set"
+		exit 1
+	fi
+	exec ${TEST_SHELL_PATH} "$@"
+	;;
+*)
+	exec "$@"
+	;;
+esac
-- 
2.45.0.rc0.197.gbae5840b3b-goog

