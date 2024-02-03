Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BBA1854
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 00:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706921440; cv=none; b=eSyRDm4p+dJ/dFlqJwhxmuPgU1DfHBPIm8AQDyf6YGi3zJwtA1zVRqD3oXk5Luzjh8GOrrxRj256t9Efyrf6YleHu4BHBYrmgFGJJIY/NbkIc7SYrePeTl5VgJtW9Vtz+lIl+bHQq5h0ZG2x8EU10i+0d6U+BB9KWpyhsIDJPcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706921440; c=relaxed/simple;
	bh=rbf3Q3sNdOZczot6g4kqk9VpWyzg06ZPSbRL9xj5N04=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TOV2xEZMdsvQfHI9Snn3kr830all0HXgJZ0+dCJwTyDQ1dvYAZfyc9X0fxrR9Q1HhlcOJdAi+T8SP/a1fXAw/bsOZD5GmqZAaD2JvVlostE6hVRhB/vFY+6cpfcypb96NRFUbdj6CpACxPOPPVGPw1D1PWVKxjI0jH28ROGe9QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BIHVkfHs; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BIHVkfHs"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d9a541b720aso4499829276.0
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 16:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706921438; x=1707526238; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nX+KD/gXJwakeZOwzCXpgz5ZUUqqwLVPBHC9dSmqy6s=;
        b=BIHVkfHsBl6JKY8J2iOJlECLFj3slbHQWYNS+EGAR7sIBg5A+vKoKzp477FI67NkQ/
         7ISkIE1f8o6JfMqI84LPLPpqJpiB4ZswF32HhrdnsN9B4gObS+J3OYZ66z4DJVTOqKFd
         XsYwdGgtmE4yfWCZX1CDzPEAdi9tgYQ0KeOyaZ41Js15Ke3UtLPsqh0RW8f02DBGAA94
         JK7NxpQSNtcA9G2gkAIY43hRBPtBxBe1zlVLD367MwpsRYDz+nMFbRjQZ6jADMkjtcKV
         hgOBCIWswRU2G3u0wxhop1GSU1T0KWljHDLO7v+uJpo7uW5zzjuZxJ3bU5KnJPttZnT6
         2FYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706921438; x=1707526238;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nX+KD/gXJwakeZOwzCXpgz5ZUUqqwLVPBHC9dSmqy6s=;
        b=JyqsyJ3eJNG9HMhcXdYVOPBpN6sZQXsiI1F46U7cXwgKLS7T8KM/5XgC2Pwk3JBOB3
         AgaidMVeWK4nrquW9fC5614PmBLu12DRUDOQsSIbPSLcqzZyBPcl0lMF4iT63458eK9s
         ZSJUW47XR98saGJ1eDb4OnUCBoneaXcEqzWPRr1Hc7TwKJN4xOia/KbT5shrt5wTC6EU
         ToXc78zfwUTSgrN+D5f1ugrfVeij7YQpjJBdN/8/7BZgiijjXLZLTYnPdBitCRY7kUDJ
         BP6Nhw6J3T53oFz8i/gtVXvtk1C4nvZkMLO6sal5mMoq4jyFbrcuW8KaRmq9WAJ1hWoK
         ajug==
X-Gm-Message-State: AOJu0YyRhTY/CDHarFu40BY/1tH9nFjarbY3RNfTfylZzUUn8L0BIlUG
	XbWK9mj6UL+nsTH6Bsn4plh2wqdgdrxrvyIgW9K3Nw1ZSbTZSFMmKjAM8YeYt7P027+qNzGlDPM
	ApT6OTKkE/aZPn/WY+sc3JAbnmmA2gEMRYTtgYjpJVDhxVhBHtvjWFYrFnt30G2C2C4QsNZPWy1
	EgI5GWKf54y6M5raA6y9diEYNR0ShUqI5cJJ4Y+LM=
X-Google-Smtp-Source: AGHT+IGpcUl+FlLzBmXJXRIwsKv9Knbj6Q5AkfLwTI0HmZ+HAzHniv6fovZ/WAptuaR81i7JI/+3U4vDowDVpw==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:705c:77af:6ef2:8f42])
 (user=steadmon job=sendgmr) by 2002:a05:6902:1748:b0:dc6:f21f:64ac with SMTP
 id bz8-20020a056902174800b00dc6f21f64acmr656937ybb.12.1706921438119; Fri, 02
 Feb 2024 16:50:38 -0800 (PST)
Date: Fri,  2 Feb 2024 16:50:27 -0800
In-Reply-To: <cover.1706921262.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1706921262.git.steadmon@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <c8448406d71151714e89893208c46b8a4c369cb5.1706921262.git.steadmon@google.com>
Subject: [RFC PATCH v2 2/6] test-tool run-command testsuite: get shell from env
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
program directly.

When setting up the struct testsuite in testsuite(), use the value
of TEST_SHELL_PATH if it's set, otherwise default to `sh`.

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
2.43.0.594.gd9cf4e227d-goog

