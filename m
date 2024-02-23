Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE8614DFD1
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 23:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708731244; cv=none; b=hVhwS9VYbHCJIZSPM3/ijq+aSKnUI5WMJ9LQ7tLh0RsSb590+9OdYtvsMBM34rB+BzBgG/QE/Ns7CNxqlLvE4ob8kR3iYGHWNoRRQqLXQkOgUKDMa10KoxH5md9e3OQryKWfukiuQPEpHUr9+th0QySokyYZRZcyTQEuet9/xn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708731244; c=relaxed/simple;
	bh=xbyv/p4g5RVs8l8BGqjKzWm3YMd1NpBnFMGMGjCauyU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uEhT4lS0sGuQqnogUtNZOEjh5El7cPC9zzfO8i0ALm9cdQNau9PoiaqCF/7m08LyZbkGqlUlM9I+1TZaSxcQstSOHv1D+J2iE64JPDFnCyhwQcSlhkt9kCBHFIAPVk6QGnqVEvsgi8mEKQotyd2ilBlGncmOlmv5EIh7Oy4wHEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BTVKvgmz; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BTVKvgmz"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608b648044fso24104217b3.3
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 15:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708731242; x=1709336042; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6j1LMcw6vsmLYWz1zCuGgzvqIqQyphfQxgvW3vUB92c=;
        b=BTVKvgmzIoK5Up6wNfavXInX2iYW5EgXoH0urAolmQtDpOL0QLj/8QHeQy3mFegnYJ
         uSQZTCl1HpgDJeu/ZiI8kNM1kc9+v0LAPeekWrzZXarTnVNw9Qgho4ouQg0tkli0pb2Y
         Bdp1oaDh7QideIcTm12s0xxWUrvrqrrTI0ixPvKV1iAUNWKPh5EjPRnUcg5Y70INLaLI
         GTMtgBafkUvuTdEHdMkqz1mNGzunAuFOiLxbV1b3FbPhkdZsvbaQSlH4sInKtYWU/XLv
         pF95A5ympoNcAnJhP4rKPxYI60LBQBoXEPdZMKeTq4cFKp/cPIDArSHTzhg6r1w9CwQs
         C+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708731242; x=1709336042;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6j1LMcw6vsmLYWz1zCuGgzvqIqQyphfQxgvW3vUB92c=;
        b=VQ3ZsFhupisnwF91RzFYlEjwdblnPrtfgRypSOB0HXqPJVDkQQSWtD+LGA1ZCljvO5
         670zfKceXwmbB95cDyYGlLT1mmtOPHaIOXkxqu+dqyqQzNYt3Nt0ZpO05ZSsCUAirXZE
         vGq8YMq/YjOUEdXIx5EwrfUcw5akzIqCNQb304EyU5AIJxDt9NhN4kKUk6+u38CeCVuB
         CtC0UyLwaRgKocGVdIUe0mfNTDTTw7tJOqao8lJgkqhryB2nRDWzTx0ugy+nagOYvqGS
         EzmfqMIFhTy1ou/Uw/zkgk1w99rlOha392YyTomDdTL8GOYXsaIor83hWIBDRpUE88kn
         7Mhw==
X-Gm-Message-State: AOJu0YxgQ300jgD1j0NMjX4NxRNu7GOASxFlKS1BYB2yYsqR4D2KC0tD
	SlbSW3cGT8mOUN/VfRB7HQWGUrql+2gmf+RmrLtRUHqkMg2mR1QdKtYc4HbJZnPGG6uX70iBWX/
	mlE9JW6SrbBf0NsM4tl1XmWVkeKkMvYaMegsFObpXBUaKb5Din4czTFQlOsg4pcRCskDNLf1Wtr
	mHRiRICwyLaE0YVVzXyIQi96BOne/hfy21ZGgIEuk=
X-Google-Smtp-Source: AGHT+IHbVYUb3BOH3QLFwmFEiUyFsHw+52vddjlb+zIQJBEsigSFFNrX1ZGo80NO8YLdatjCbfVYbP83263nWQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:2fd9:97d1:a490:26b8])
 (user=steadmon job=sendgmr) by 2002:a0d:d456:0:b0:608:5367:a508 with SMTP id
 w83-20020a0dd456000000b006085367a508mr300990ywd.2.1708731241971; Fri, 23 Feb
 2024 15:34:01 -0800 (PST)
Date: Fri, 23 Feb 2024 15:33:51 -0800
In-Reply-To: <cover.1708728717.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1708728717.git.steadmon@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <24f47f8fc7e931c2e15fa985635e3036ec1123ba.1708728717.git.steadmon@google.com>
Subject: [PATCH v3 2/7] test-tool run-command testsuite: get shell from env
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: johannes.schindelin@gmx.de, peff@peff.net, phillip.wood@dunelm.org.uk, 
	gitster@pobox.com
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
2.44.0.rc0.258.g7320e95886-goog

