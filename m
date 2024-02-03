Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7DF6FC8
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 00:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706921448; cv=none; b=JPcUOuFUD/amd+Wa8bxQ4bxLQEDYecl813Ta6b1wRrHlpmc/wFGdnQR6rMo3JbPKnZUk1eGBDyWOuAO93aJF0J8H9cOcVtyT7S0wWQ9kezIVNJpmMXihxgwT9TsA/yupvGW286cKM1D6TXFTaBDYBbS7QY1qmyy6Aem8s9/At7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706921448; c=relaxed/simple;
	bh=ta7jSsFsUvbqYfsj5MRTByPYVNQZY3T4CU1P1Gmxmi0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IGtkJaSy6Jwml+wna2wq9PMoFBfP6qurM/96mA1zFKDS31E9MedGNUjJXAoMEeM5AZLbDuSpiIF6AgMLCX3rKJcDzGOvt8VKW/tBIE0SwAu8LGddKeJ/8cbxCvrqIoVEDxxeQrb7h0Rl0DqFdNP2G1jFdUS6Te6KKKBkgZPPaE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dcP3Myj0; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcP3Myj0"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ee22efe5eeso45717487b3.3
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 16:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706921445; x=1707526245; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m1c+35MaGAYPyhmHMrHlmAOh6RNGkcWUZiwUw6lLKE8=;
        b=dcP3Myj0mF193QpuOsO6fmmAtJ1VlDvNi2AIg8bAP4uC8jqGLn9GvQJvDGMCrmZ6DY
         2kGqDhCSnz8sGtgt368ZdB4Qk+LtzOiU96uVO7uKrIMUvrSbR4kZvki8YZKJyvbxRGeK
         NS2TLCuNon7Kni+0FV1Gbsg1QyW0A4M9mO5LkwnhWapW885CBF4nWd1J7IfrSbj0Tfwa
         ZBUWeOlgRt/nv0xYIjf4R0tkNyJYhTQbN59hSVCYmxyFxArJtWLv5iVi+hyi7rZx7f0X
         jpkRs/Jd76S0Ots3xP4k0mWjWl8c60eW5m8b0Z69qXJtFdaCkjQPtHZRlliDQU/1ES3E
         +cTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706921445; x=1707526245;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1c+35MaGAYPyhmHMrHlmAOh6RNGkcWUZiwUw6lLKE8=;
        b=sBeinp6L3I7Knmk3CeSobtPSnRRmwLTbncYx7MBBCgEHdJngfqoA8LHuWX1S7f0NmC
         RxGqMeWo4MPXyQCtKiWXpz8Akr2YPEvzqLPFszgN6wn7Ax/wjBt2Yx6I9NVkd65arUix
         8J6tzeZwLI2SQeZ0ykx5/VXjEoskQWKk2uDFahXQEIRTwqEGsvgf2/VFxySdhKVYR/ZF
         bjQbZnyG2DGWZE96kjNbRJ0N32Lnv08Du314/uXSlbdgEBHueySDrvqtDwX+DCLRbZIy
         GEexJ2xwpC6rph1PKeK/3YuxabBjvkp2pS7PttCBO8amgI9iIBStWONZm9pwOYkrk43V
         qbcw==
X-Gm-Message-State: AOJu0YxqNK4Nj0xEfi5pXebvkzLHmQWXUp6Vk2J+xwmaMGXilcgmyR2k
	uwYcYWe0REyrKM7jiVrHFmXBGLLPLM5EYAtxw1klUWsGs2rz9gG3AVwji7fcOprHc2c5rR40AeN
	t9nMaOpk5Xn5E+O8a+/wOI81ddAE9+n3EKp19Go3cgnm3ATAJveCHChO2eVEEpmJQnBuZexPe4+
	tQL/i8uP32DuctluuzExg5a7QXIWldVW7WnLAeiIc=
X-Google-Smtp-Source: AGHT+IHnYbh1I6u9Sd5z8tfSeFgQaalt7+D+gtu97c1zyt7OHq++KfEQX5aAchM0MpQAHb+c9e6pCHwg59lJbQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:705c:77af:6ef2:8f42])
 (user=steadmon job=sendgmr) by 2002:a81:4c14:0:b0:5ff:a885:65b with SMTP id
 z20-20020a814c14000000b005ffa885065bmr1173375ywa.10.1706921445608; Fri, 02
 Feb 2024 16:50:45 -0800 (PST)
Date: Fri,  2 Feb 2024 16:50:31 -0800
In-Reply-To: <cover.1706921262.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1706921262.git.steadmon@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <cd7467a7bd51fbc01c999ee1bd7688770b1d11e5.1706921262.git.steadmon@google.com>
Subject: [RFC PATCH v2 6/6] t/Makefile: run unit tests alongside shell tests
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
that errors can be spotted more quickly.

NEEDS WORK: as discussed in previous commits in this series, there's a
desire to avoid `prove` specifically and (IIUC) unnecessary
fork()/exec()ing in general on Windows. This change adds an extra exec()
for each shell and unit test execution, will that be a problem for
Windows?

[1] https://lore.kernel.org/git/pull.1613.git.1699894837844.gitgitgadget@gmail.com/

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 t/Makefile    |  2 +-
 t/run-test.sh | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100755 t/run-test.sh

diff --git a/t/Makefile b/t/Makefile
index 6e6316c29b..6a67fc22d7 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -64,7 +64,7 @@ failed:
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
2.43.0.594.gd9cf4e227d-goog

