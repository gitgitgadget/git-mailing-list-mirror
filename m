Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474B75E07E
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713986061; cv=none; b=EkbfHJvigkVloGkooFhZxqoIuXdzCDRSeVi5pkKVOVM3GVGp4k7QEnC3EbssYEdBHP3/tJdwYgDE9Hf9LkasHsQJGJmAqxqcccZcJr4BAA8K1aacMdK/jrCJt/2GVfJ3M75piZvbqbmPcKgZiZW3oEkI/MxYCF3JvWGPmQH1+oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713986061; c=relaxed/simple;
	bh=lbt9TJAPElNie2SlD/5S4WTeE/79cDloHMdXhhDb7jk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jem3EiFk0HTMyJmv2ajMTfjRHSrg6wmytKJASa8TqAoMOql2d8sprRe0p2WrIk3l8C57sL0JDqYMW6z9Zgw2FprkjEZ5ax/ZgkcbJNs/D/9iAEK6EcfxlS8XT6HGTdrwI0QhL41/kOb97qWcpwbxlfVb5YGb7d3AtzisAjukJck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X6XdiMMI; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X6XdiMMI"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61ac32822bcso3182537b3.1
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 12:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713986059; x=1714590859; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GhLNRLpJH1PUCRG33l0/jTFly3a2tm8jftvh3mdfOBk=;
        b=X6XdiMMIQ3HysEVDo/rE+9DOrEDC0Sh8nuXSWgItkzlCLnL0NOQwjJQfedQ4eNeLCq
         uc1Bk5cjAQOp1UnN3uiNHfUJrldxQBGaNLT/qClMM/DrxWLWrELxEPx/kazzmEafVWYp
         vgNQ1KbBACWL/ck7Qld9UnlOM6QRDNbDLBdRHDmkgoblE+5Z6pOxR+jZWD8a4wkyubdz
         1HB3JrEBLuSv4avuluE/lkL2QzG8rfcMgPH7OAsy/Y54kJLcW3vIft61eSJwcXF775FP
         eQJyTJ9vMCuEpgZnxYmxyaEbrqzL9CQEGGvjYH9bY+avz8mscI5c82j0X7jlefvDl1KC
         v7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713986059; x=1714590859;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GhLNRLpJH1PUCRG33l0/jTFly3a2tm8jftvh3mdfOBk=;
        b=TpQNRXto9E8dAEYIYn7B+CYd7h1QKGSiX/FCyxh1MiMHz3tu59CbvIp0FVl79/uBp3
         z8fIUivIQebFH6hJTDHaVMB0KPSyxLLvhSf7U58lPLN0z3/QP81g+srdopWGT9FX/Tip
         PBrF9qv2U8Wdqjz00T24oPm47mMgZo6FZa+/tG1gCGTK0tNY18iGyIWWGCBsKrRq8hV8
         sdHSVHj1DATCPHkAb2Mmz0IGGbTn/z5PQX/kLr/jWGx+FFy3Et7/xIBmY14zmIISJqU8
         iBgeZ1j1/fj2p3+ym53gxazy6Fug1sRuQbU96WhqyHsyCKoceg4y4ipJhW0KhGlqbUk2
         gidg==
X-Gm-Message-State: AOJu0Yy7WkZqUnRu7unxywPEmSsmcKQPponi087nOT44C0nzqkA8VQUK
	3fCSe0P/mBIozzIxN9CFcFi3qLlRNNZq+IW31ctvgJZGGxTKMIEsPBFqCI06GjKhsublKER2lYS
	rkGADVQP0mihRB289LVQ2n8u29HZI1rZJZfdVtw2FBvA2WmT6jbvZGKp/QZE6zMtuZ/muLgXoAf
	ViLxxw694HnPJTfWG/GTXDHOO0SH6PiLG9RxxDnc8=
X-Google-Smtp-Source: AGHT+IEG5Sbp/f5oNu8yYbHBuPcxr4mXR8noXIQdDiKjOXHmRXDBX4TfVg1n9ASY8VvQq+xnf0Mn7d5DjPduZQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:5580:46bd:98b:ecbb])
 (user=steadmon job=sendgmr) by 2002:a81:69c4:0:b0:618:9588:e9db with SMTP id
 e187-20020a8169c4000000b006189588e9dbmr846668ywc.2.1713986059348; Wed, 24 Apr
 2024 12:14:19 -0700 (PDT)
Date: Wed, 24 Apr 2024 12:14:08 -0700
In-Reply-To: <cover.1713985716.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1713985716.git.steadmon@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <24f47f8fc7e931c2e15fa985635e3036ec1123ba.1713985716.git.steadmon@google.com>
Subject: [PATCH v4 2/7] test-tool run-command testsuite: get shell from env
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
2.44.0.769.g3c40516874-goog

