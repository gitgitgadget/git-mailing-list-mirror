Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB292C0F8A
	for <git@vger.kernel.org>; Sat,  6 Sep 2025 07:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757145138; cv=none; b=fe9N05tblC7oVRPXFp4/jBocAN8Z3Ffn6oWrl8B1rkp4cR45Au6PVQHCqND0YODPsmMrkO13Eto96Z5Uw2rC84huqaBOXqT35eqUDbckp66tE6yVWIxyTZZ94BquUEbRh4lYzutLFTnksi71a+Og9Gv+0JT1GVZD8mzRAoYzysI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757145138; c=relaxed/simple;
	bh=H9JvrtrWLPMxXbNDV+3zmZUNzxsxpLaumrynUF+tpSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i3wkeH5rpGbPrMByapiHkS8CMToLP/+73/d2+xX2VyWLYjJhMCAVDVJRZkEZ4lqFv62WjeowYLVwh4QFXFJKXzok/SCLUdJnBFZdl9byInbadfOljgz6hPbiNI938dgJqtrxEqPgN4sbnQ13Sr9I5zeAr83bpDKNdKZRRE3KmoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgcPeMAA; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgcPeMAA"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32b590d819aso2345909a91.3
        for <git@vger.kernel.org>; Sat, 06 Sep 2025 00:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757145134; x=1757749934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PELAp4sikEbY2gTmMLfwfsGo/ARzKbpsS/L7V6sY4mQ=;
        b=BgcPeMAAkx/bVDq1T/tUKLHPEqJSVH9f1eHaIp3FIHHB1hLookFAnjXZHASU9qBICd
         fZ3GgIhaI2EV6m88SAxByzYPnaUap5M1wKTMQHG1Jg6Q77BdkV5Z0/DR6jw4sRYcJE5P
         BGSnNSO+fjK6rgnmrWhZdEiXtFRQu/zYVQL3w6PUMvIAGYAi82uRe5bE1TEgE9RF3a7l
         Zb2RjWp3xorvwQftCiD1P9fX92A9OMAAwNR4F1+jhR2xmcrJQbIjj6UAJN5KQJSa7aAh
         tDO1Z5ROOBSW31y3XKj+jg48qiTRLh5Uq48s5+4sMXwc/sE7L6eHtrZuKmA8KT23GkX5
         DlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757145134; x=1757749934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PELAp4sikEbY2gTmMLfwfsGo/ARzKbpsS/L7V6sY4mQ=;
        b=VbP4DiG4HWwUKBU/ytEp8EdH2RwIAwJQxWjhyuFNeDF+BgxSZWhqot1/d/cxBbT9Hs
         Ptv0nILWdUgf5orqDxxcS9xFBsbu03bYUBBQtJxIfOq0Sq1YWSLftBwVOQOwonHcuL8V
         XH91jl3Z7vdajh2u4vnVZU9+BCIfW4G+y7Un9fQTO91l0kukvI3lYv8KMCeWN2nlNWuT
         2QmpFIz0sj4OApdf26t7D5Dm7AWtuo8A+Z/kppK/PEfgAvcMELIqCrc4Y10vKTnupi2N
         Tq8b7qCp2lSQidnfl3vbUIPnr4db/1+HVtzx+aSEVrlogUoM7da5SKq2PhWGjKA1Lhvn
         zFYg==
X-Gm-Message-State: AOJu0YxxmSLNj+bQgbuDXFiJHDjflLSK7UPPvyfxuB7uQVr669tf/nJ+
	LWLp49DP25T5abGePyrhzpbjf3nMC1h5JXlSo4qh0W3QOLIkMmP2GNg+rRPhwg==
X-Gm-Gg: ASbGncsbgu4EjO251CYbC0ALXdwhEsnzdTclGNm3YkmlNKGg++8WhQOclVVMh4TwrrA
	oBwqrQ4vUhueTsSjNKO8a+rBWCwkFMc8TDKnnUj9iOGaHhQY+igrcel5Nhx+DuvQD48YmJtdpv+
	1GJa1VsdBxzNU4r8eeyUNVASt+0Hvvc+lLB4GBn2ukzll/AsKdJ9lI6V9lcjMnJfSY1dVinR8I5
	b9wTpT5oKLaaeJt44m3nCc0dCzon4ZoCEsqVdDhogfBF4oWF1VukB7xKjh9iomUfW+c6GVxIE0T
	XxiSf53URZ0lZi2NjycEZqvGA0sGZjRFdumFaA/6bWBUZbBkZiQVMgbpekgL6ae4Jf648tJdiPX
	nZSP5CNnVTrJCHSgV+gCykpSYp9FtMw==
X-Google-Smtp-Source: AGHT+IHyLGhmPvGpN0uTC+CxvbbjnbLxr/R1IhiM2u/cwLkHUJ4taWxyYfc5zCpRgpT/j8aCG+X2lQ==
X-Received: by 2002:a17:90b:1343:b0:329:d8d2:3602 with SMTP id 98e67ed59e1d1-32d43fb6f0amr2197413a91.17.1757145134191;
        Sat, 06 Sep 2025 00:52:14 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32bd182256bsm3540929a91.23.2025.09.06.00.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 00:52:13 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v2 5/5] t: add test for git refs optimize subcommand
Date: Sat,  6 Sep 2025 13:21:47 +0530
Message-Id: <20250906075147.1076656-6-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250906075147.1076656-1-meetsoni3017@gmail.com>
References: <20250906075147.1076656-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test script, `t/t1463-refs-optimize.sh`, for the new `git refs
optimize` command.

This script acts as a simple driver, leveraging the shared test library
created in the preceding commit. It works by overriding the
`$pack_refs` variable to "refs optimize" and then sourcing the
shared library (`t/pack-refs-tests.sh`).

This approach ensures that `git refs optimize` is tested against the
entire comprehensive test suite of `git pack-refs`, verifying
that it acts as a compatible drop-in replacement.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 t/meson.build            |  3 ++-
 t/t1463-refs-optimize.sh | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100755 t/t1463-refs-optimize.sh

diff --git a/t/meson.build b/t/meson.build
index daf01fb5d0..48f83e12a7 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -210,6 +210,7 @@ integration_tests = [
   't1451-fsck-buffer.sh',
   't1460-refs-migrate.sh',
   't1461-refs-list.sh',
+  't1463-refs-optimize.sh',
   't1500-rev-parse.sh',
   't1501-work-tree.sh',
   't1502-rev-parse-parseopt.sh',
@@ -1216,4 +1217,4 @@ if perl.found() and time.found()
       timeout: 0,
     )
   endforeach
-endif
\ No newline at end of file
+endif
diff --git a/t/t1463-refs-optimize.sh b/t/t1463-refs-optimize.sh
new file mode 100755
index 0000000000..c11c905d79
--- /dev/null
+++ b/t/t1463-refs-optimize.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description='git refs optimize should not change the branch semantic
+
+This test runs git refs optimize and git show-ref and checks that the branch
+semantic is still the same.
+'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+GIT_TEST_DEFAULT_REF_FORMAT=files
+export GIT_TEST_DEFAULT_REF_FORMAT
+
+. ./test-lib.sh
+
+pack_refs='refs optimize'
+. "$TEST_DIRECTORY"/pack-refs-tests.sh
-- 
2.34.1

