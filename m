Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B69515B135
	for <git@vger.kernel.org>; Mon,  6 May 2024 19:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025472; cv=none; b=U4rIlfWq+11JymAnWO19Re6Ge5mEX6MLXewF06q71fP8l8dPP2teFOkyKdBxe/e0U3+rM1VY8/wJFWl0B7VcXhIsL0p0fkt6BFYkLLGDr8DUO0U0v6P1ueWazFhmPCDAMIspOO1xQiHh2tGOpl39p3l4t/sx/omujdpJM1Ogd/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025472; c=relaxed/simple;
	bh=7Hc2WJPOTOOO+0w9uaXRa8/G/OpOTTxAnZbRwBxQmEA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f/U5CFdLcGbK4W7Ro2kNTgnVM28NNfD/JLSZPmygTsvt/iJzRIZGliRtdPYsjzvR5jXcbsWVYxGpV2J9LnAxY4xXDpPtc/h14odrIvbk06u8rnE69OpauCpuxkbaSx0jVRaAuPFQshwB1Zt02y+dDQTih0b+tQ664yRChk1INtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xY+Pft/k; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xY+Pft/k"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61bef0accddso59658617b3.0
        for <git@vger.kernel.org>; Mon, 06 May 2024 12:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715025470; x=1715630270; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RU+AFoAaCv+5oI4Ce2i9HE/Kl2wGSJ9eLdx5U2U+nR0=;
        b=xY+Pft/kkpNyIPUeRzYFb5siJnE31fStDCtCUbZTw17dd8lnyb3ghUHilb67wmi5+o
         NyFIZ+/6WdFCmKqOMErej0WjwHzK2hQ6HmA734RbNmFY5JoHBEAipaGelUNkphFdo7fH
         u3AzHPVSBu9oYyB2HdROizXVMxfaDiEHy7AduW2hG/hdJ3MHbnoVl6p1W7tjd0HEtuMD
         t54+WOQxZmbKrhHRbu6+wFG2VQ4TkYWTcbqKInLMHQ/apkmW1hXBC82huohb1Ri8oqKn
         dFmZ66U0RqnjZ5SGUWycq2PPjSHLddDTKnvfkCibEzoLyip1tG45MZLkTqhyMrIoAlq2
         7eqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715025470; x=1715630270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RU+AFoAaCv+5oI4Ce2i9HE/Kl2wGSJ9eLdx5U2U+nR0=;
        b=MNnkM5j6Qey5gdJNdqMXLC241EiKQALjTnWF7RkTpLfdjqwajSPdG9KQAdZdmRWbx6
         taB+eEzaeZ/OZOR4oUDtTVX5xnkaxl0D2lVxGDqMsEpt3ajunIXSeixfYz6v2PPCxMGy
         I3EEn3uLmQxWycm1y4fAP6o/12U8wgYXcDf82ZpMPNlY8KrVv04uEw/bjZXfiX7z1IjW
         Mm7Q9vn4BXoID5JloKgIGdCCu4XFq9x7+ou2v+AYERagG1oa6h0rgYJS9JDQTl0ooTPV
         pwMgFrJUtd6VGxrlX9GC2AKfDjGAIHuUiE0LfnjB2DbvXDlK9/cokwrFSqIGIG6YOyAj
         1y6Q==
X-Gm-Message-State: AOJu0YxmxWL/ZpJOtObd/oqLdLPEq5VKFfFFEUnda9noQxD/8VhNrzy/
	Lhtfs/W/r2KSLIQeQBhBzlZwtrQAsP+Pa4P7b5zL/5Tz6mB36dWLoB/BylscoohLLybIS+2Udzh
	cfiTUlmUn0rqE1AoHWUbCvqgVSXIPYwzAk1THdV+nwppILL74zCDj8oZG2SgC6rTITaC66Y8qe2
	flomA3Z0LLKlDW7zDdVxxlwZLDNSrd2l1/brbKrTQ=
X-Google-Smtp-Source: AGHT+IFNgSO1qeSnG3C6OUc3N3rISh6jZ+CREBw58pQDShr4sPVP3DirLEJERGDyBBTgpzS1X6+EZM516y/QLQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:cf3e:6b4e:994:dc81])
 (user=steadmon job=sendgmr) by 2002:a0d:eb04:0:b0:61b:ebab:ce9b with SMTP id
 u4-20020a0deb04000000b0061bebabce9bmr2969493ywe.3.1715025469663; Mon, 06 May
 2024 12:57:49 -0700 (PDT)
Date: Mon,  6 May 2024 12:57:36 -0700
In-Reply-To: <cover.1715024899.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1715024899.git.steadmon@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <dae670fcb115e6ee9a490b1965b09aeaaa5e8a4e.1715024899.git.steadmon@google.com>
Subject: [PATCH v6 6/7] t/Makefile: run unit tests alongside shell tests
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
index 0000000000..13c353b91b
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
+	if test -z "${TEST_SHELL_PATH}"
+	then
+		echo >&2 "ERROR: TEST_SHELL_PATH is empty or not set"
+		exit 1
+	fi
+	exec "${TEST_SHELL_PATH}" "$@"
+	;;
+*)
+	exec "$@"
+	;;
+esac
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

