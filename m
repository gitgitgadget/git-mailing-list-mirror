Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5845199E9B
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714506966; cv=none; b=OypSvX3bJkJwFLKa40ikImn4PftLedkBJq4RU/+F4dhSzk4Vs6/XY4/mASSWCg+yFpX4M4TMm/GEGNPqhHihL94F9LFSOQnX+W2rpLwtZw9v65Tm/fNX3z+BasyKmNwdq8nyPcFv332DWE/yK7UyKmg8nD7UxnPunOqsOMy9Tv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714506966; c=relaxed/simple;
	bh=kO/wmtigDcTbr38Vw3NacoxQON8NT+9T4h/D/Dlt2p0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PGRo9BCBgznm8yyBvT6VxygIKbVQlLxYArGGeg0EBVaKUk9zfqFgm1c7k/90qmt+VZvVcnECvEaJYhDUG7DetFoslPf9MqtHgQI1zEaIXwwx5OS2UJ541J+JXVV2bjPS3bS0DHVsR03bIHZtbYXYlCDnZYEiB2OT4D5sJ/gQw8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0d6r5Trn; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0d6r5Trn"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61bea0c36bbso24071617b3.2
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714506964; x=1715111764; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aiAxp2tsvVxK6B16seVg/SlNAzZ76SYFu2z5qJAzluM=;
        b=0d6r5Trn3lpy2L+wAB4i4tvsRkhDRKKtOZdm7V9sheaXAKCvBQpf5qd18v5mIQ4Dg2
         BsNdlA6LKYsCiQL/EC2XhAD9w2blxZ88vzu4hA3gkVVitOBQadiEFBGFr+VFCy4dhhxl
         FyABxnz2Qrv/EuvpUUQ3aiGowo6VtXlQdxndOTuK4APUWhaEI6KixvR7FDJ9DGets1ii
         9qfxcIQvEO27oE9iQQjs4LGo21qFkr+kTynjaXtFcmsSYvySn81aQMtsqjA3aJN6uhfU
         vJL9gDDqIoSHNvP6GD7ofziREuvm3wJzJggiZLqV7H+7rexbRSnVnPGWGoY5ex/mkei4
         hzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714506964; x=1715111764;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aiAxp2tsvVxK6B16seVg/SlNAzZ76SYFu2z5qJAzluM=;
        b=kizV5T9yrIqNSsMUEZgfNGiDStsygdMfju05Pixl0VlpKGtguTHQkBF7KLDeOZAkVD
         k38iq8rSXe5yI/2ayFZIBONgfq2IF1L5WS8EtQs+zn5FJXYL4Z2acLLenzEgLUErDJwK
         hRkWgau+9DZ8waEZ0nNT76OI9n2vvkCmLxnflVOyG3fMxZ6dwlTX/yi2mOX0eHz34q31
         KTDdvfICiboSGyk0NQTX9lnvfSCtxsRX6iTvZA8TNAsHZoRglxlbUpcXq9t/Qdg/1Oq2
         ZK4xw9ARYpgc4ExZykc7VTWWUGpWqyOaQQsnlIK1Fz/AomY7Yae2gwzhMoBV4E+8UbUj
         tk6A==
X-Gm-Message-State: AOJu0Yyh/VV8s8hzszCKQ1tseqOSG7E75p38HJS9FEDUucGgZX0arbyx
	uXub4GcWpcpkFc9VRbJLbPELwM6SmzBkm/LOm98iG/uNTVvUm1N1AHGLWVul2ZJN1hPWOY7u3ha
	mYB1whMpE6+d4tjR97OTWxIoAe1nmGcLyJ3KBlVt3uoFX3qW4Uv/AZTHYUHAEg0JfCzts1chGQv
	jzXJdXqDee84RM0igDvg6EsVTFsR6OSmCwYEvXeA4=
X-Google-Smtp-Source: AGHT+IGDQ7Ipldhbq46Isxmiz/TkLyJbt2CfPSgYTygc99lSNd17b9FOBRPylDgHDcKdL29iOPuDUCCB5ModBQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:3e48:fe18:8aa:8a0e])
 (user=steadmon job=sendgmr) by 2002:a0d:d881:0:b0:61b:46e:62da with SMTP id
 a123-20020a0dd881000000b0061b046e62damr155348ywe.4.1714506963758; Tue, 30 Apr
 2024 12:56:03 -0700 (PDT)
Date: Tue, 30 Apr 2024 12:55:52 -0700
In-Reply-To: <cover.1714506612.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1714506612.git.steadmon@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <24f47f8fc7e931c2e15fa985635e3036ec1123ba.1714506612.git.steadmon@google.com>
Subject: [PATCH v5 2/7] test-tool run-command testsuite: get shell from env
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"

When running tests through `test-tool run-command testsuite`, we
currently hardcode `sh` as the command interpreter. As discussed in [1],
this is incorrect, and we should be using the shell set in
TEST_SHELL_PATH instead.

Add a shell_path field in struct testsuite so that we can pass this to
the task runner callback. If this is non-null, we'll use it as the
argv[0] of the subprocess. Otherwise, we'll just execute the test
program directly. We will use this feature in a later commit to enable
running binary executable unit tests.

However, for now when setting up the struct testsuite in testsuite(),
use the value of TEST_SHELL_PATH if it's set, otherwise keep the
original behavior by defaulting to `sh`.

[1] https://lore.kernel.org/git/20240123005913.GB835964@coredump.intra.peff.net/

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 t/helper/test-run-command.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index c0ed8722c8..a41a54d9cb 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -65,6 +65,7 @@ struct testsuite {
 	struct string_list tests, failed;
 	int next;
 	int quiet, immediate, verbose, verbose_log, trace, write_junit_xml;
+	const char *shell_path;
 };
 #define TESTSUITE_INIT { \
 	.tests = STRING_LIST_INIT_DUP, \
@@ -80,7 +81,9 @@ static int next_test(struct child_process *cp, struct strbuf *err, void *cb,
 		return 0;
 
 	test = suite->tests.items[suite->next++].string;
-	strvec_pushl(&cp->args, "sh", test, NULL);
+	if (suite->shell_path)
+		strvec_push(&cp->args, suite->shell_path);
+	strvec_push(&cp->args, test);
 	if (suite->quiet)
 		strvec_push(&cp->args, "--quiet");
 	if (suite->immediate)
@@ -162,6 +165,10 @@ static int testsuite(int argc, const char **argv)
 	if (max_jobs <= 0)
 		max_jobs = online_cpus();
 
+	suite.shell_path = getenv("TEST_SHELL_PATH");
+	if (!suite.shell_path)
+		suite.shell_path = "sh";
+
 	dir = opendir(".");
 	if (!dir)
 		die("Could not open the current directory");
-- 
2.45.0.rc0.197.gbae5840b3b-goog

