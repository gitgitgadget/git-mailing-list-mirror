Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9269417580
	for <git@vger.kernel.org>; Fri, 10 May 2024 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715361771; cv=none; b=hvg+ZYwZW8Hy9ttlHlVBMk0DK1w76BeEG/T0TKYhlX1cetG+cFTis512PgHOo78BRew+u4csTmMgZuZfXs9MR95dcK9h3wrPgUUHf6gApT4Ko5bh6wDc5u4EZ/SOxe/frfNduyW7ui/DeKgqGuCzIQFrjw9gJKaDWRoCwTkI+4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715361771; c=relaxed/simple;
	bh=k0ZNbEHUuKJ26aonNXl2ZstsUrvnYuDdejT18d+nIbw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ghHo6D+OJHcX11XFmLqoCKEnry4gEXoVn/oSTWouySmrKHXPAjwGZo5qOWx4ZNW0PG3hMGKE3vu6k47eK+UU0Hxt8IBtTqW440y9V9CTiU5uwqV+OqhKGF+V90qBy7NCCQF6c7Xeq8K6eCOBj8yf7ftZ0tHo9wZECwIZJ9SOsrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--emilyshaffer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=082MuFlM; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--emilyshaffer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="082MuFlM"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de603db5d6aso3905428276.2
        for <git@vger.kernel.org>; Fri, 10 May 2024 10:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715361768; x=1715966568; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cTWPODBdjVrVo5b0XeKmSG+8hGkp1friA8qC88XfnEE=;
        b=082MuFlMlWQ9YUNIAvU+KjvN6ItCnFvQKfNiihVoRFDClwqMzNdRvGmzkpXD6C23t9
         0HgTp3GOrPEybXEYEPz564IENXZou1hfz+8RF4U+t7Nz6PntmoZDUZ2KjuJgy4xtvbqw
         oj/qdHMYGXI5IDlHvtF/seniXmrXTDIaqV6PAyUom5O+ecNRWKaO4RWB0BOwbvt8cco5
         ZM5ujBDJl1Cfddd++OJRL6UBmORdR/xMaNrB8HtqxhUJMoQg/u+zUZ8hfym+adrZEw45
         Q8pDU5auhm4RbfCSpHibTQgp0u+XjoVNsQx0HB9enLCQXaw4QJWTh8wSlQZ0Mu//PXRr
         i89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715361768; x=1715966568;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cTWPODBdjVrVo5b0XeKmSG+8hGkp1friA8qC88XfnEE=;
        b=Ukg8Q89Pdhe7BNyLrDqRdF9ndcoC032u++Gx9ILGDFgcisUHluW4d3vdp5Zg1Nv5eK
         Z1FMzVaQMIIA0OgR6FsyQaxMAlC/A+b5n9UpZKqNcDk6wM+Bju2ZiBUB7UdTIbkm6b4y
         fv1lgxoHqSu8KC4g5pfmdhrxSNgdLTHQ7FgDeKhudEzXyZrBXot1N+9B6ueFvPB6cQaO
         zOPRktPQlvAL1Vq7VApYoL6Ef2xUgnJVD6cJU5C4H36umT7UAeOJUYMDVeuVXfPZHz80
         1LRf0wOlldl1kvIUW7Xf32Ut8f4jHBudhWEt8MzB+/1y2E8cawOn/0YKl5wkQ7Q2kXaa
         LwXA==
X-Gm-Message-State: AOJu0YwTc4+XWGK/oyKNgZBPO1BT5ToxuztF/LSyMDQIODz3Mxi+a7l1
	X7UemEMnVtKemPVQ/HKb2UTORpPe+fOEUn0Uq/QBJXov8IrGbz+fwPx8rQsLXVAR+lrmGftoamZ
	6wVeuCogk5IGNINoH9ToPW7gYH3lvFjxLwIbNKKyPiF+QAGlKqfzzxYvAf3+jZtY9hBulZuqqOd
	SPLo1ojXGMK1n7o1diAgzOWREL/lr5MAEwU8yxRiIREVVl89bMMqTmuijQkagT
X-Google-Smtp-Source: AGHT+IGo79MMs1iQ9EbIHXORMzgL813wa3Ugn+1ExfVyVMfnab4/sv6ql+LtvMrhxyaFeaqL52D2fqBuRwo+Y0Fc5MM=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2d3:204:27c7:d8b8:da85:fcdd])
 (user=emilyshaffer job=sendgmr) by 2002:a25:d8d4:0:b0:de4:e042:eee9 with SMTP
 id 3f1490d57ef6-dee4f2e9594mr723382276.6.1715361768556; Fri, 10 May 2024
 10:22:48 -0700 (PDT)
Date: Fri, 10 May 2024 10:22:43 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510172243.3529851-1-emilyshaffer@google.com>
Subject: [PATCH] trace2: intercept all common signals
From: Emily Shaffer <emilyshaffer@google.com>
To: git@vger.kernel.org
Cc: git@jeffhostetler.com, Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Emily Shaffer <nasamuffin@google.com>

We already use trace2 to find out about unexpected pipe breakages, which
is nice for detecting bugs or system problems, by adding a handler for
SIGPIPE which simply writes a trace2 line. However, there are a handful
of other common signals which we might want to snoop on:

 - SIGINT, SIGTERM, or SIGQUIT, when a user manually cancels a command in
   frustration or mistake (via Ctrl-C, Ctrl-D, or `kill`)
 - SIGHUP, when the network closes unexpectedly (indicating there may be
   a problem to solve)

There are lots more signals which we might find useful later, but at
least let's teach trace2 to report these egregious ones. Conveniently,
they're also already covered by the `_common` variants in sigchain.[ch].

Sigchain itself is already tested via helper/test-sigchain.c, and trace2
is tested in a number of places - let's also add tests demonstrating
that sigchain + trace2 works correctly.

Signed-off-by: Emily Shaffer <nasamuffin@google.com>
---
 t/helper/test-trace2.c   | 17 +++++++++++++++++
 t/t0210-trace2-normal.sh | 22 ++++++++++++++++++++++
 trace2.c                 |  2 +-
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index 1adac29a57..8970956ea8 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -231,6 +231,22 @@ static int ut_010bug_BUG(int argc UNUSED, const char **argv UNUSED)
 	BUG("a %s message", "BUG");
 }
 
+static int ut_011signal(int argc, const char **argv)
+{
+	const char *usage_error = "expect <bool common>";
+	int common = 0;
+
+	if (argc != 1 || get_i(&common, argv[0]))
+		die("%s", usage_error);
+
+	/*
+	 * There is no strong reason SIGSEGV is ignored by trace2 - it's just
+	 * not included by sigchain_push_common().
+	 */
+	raise(common ? SIGINT : SIGSEGV);
+	return 0; /*unreachable*/
+}
+
 /*
  * Single-threaded timer test.  Create several intervals using the
  * TEST1 timer.  The test script can verify that an aggregate Trace2
@@ -482,6 +498,7 @@ static struct unit_test ut_table[] = {
 	{ ut_008bug,      "008bug",    "" },
 	{ ut_009bug_BUG,  "009bug_BUG","" },
 	{ ut_010bug_BUG,  "010bug_BUG","" },
+	{ ut_011signal,   "011signal","" },
 
 	{ ut_100timer,    "100timer",  "<count> <ms_delay>" },
 	{ ut_101timer,    "101timer",  "<count> <ms_delay> <threads>" },
diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index c312657a12..c34ccc518c 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -244,6 +244,28 @@ test_expect_success 'bug messages followed by BUG() are written to trace2' '
 	test_cmp expect actual
 '
 
+test_expect_success 'trace2 reports common signals' '
+	test_when_finished "rm trace.normal actual" &&
+
+	# signals are fatal, so expect this to fail
+	! env GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 011signal 1 &&
+
+	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+
+	test_grep "signal elapsed:" actual
+'
+
+test_expect_success 'trace2 ignores uncommon signals' '
+	test_when_finished "rm trace.normal actual" &&
+
+	# signals are fatal, so expect this to fail
+	! env GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 011signal 0 &&
+
+	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+
+	! test_grep "signal elapsed:" actual
+'
+
 sane_unset GIT_TRACE2_BRIEF
 
 # Now test without environment variables and get all Trace2 settings
diff --git a/trace2.c b/trace2.c
index f894532d05..3692010f5d 100644
--- a/trace2.c
+++ b/trace2.c
@@ -231,7 +231,7 @@ void trace2_initialize_fl(const char *file, int line)
 	tr2_sid_get();
 
 	atexit(tr2main_atexit_handler);
-	sigchain_push(SIGPIPE, tr2main_signal_handler);
+	sigchain_push_common(tr2main_signal_handler);
 	tr2tls_init();
 
 	/*
-- 
2.45.0.118.g7fe29c98d7-goog

