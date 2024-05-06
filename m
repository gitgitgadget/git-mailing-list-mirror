Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9248015ADB9
	for <git@vger.kernel.org>; Mon,  6 May 2024 19:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025465; cv=none; b=IqsW3sE54mFFgYDEJ3dEq+dphbnlWee+adWr1/QHvfWZ5GkFbOb3elwVWx+1x1TeE0xfXIoP9NXcNYUcQKS8Lv30gMjR1BcvoZiMb5hhIE0aj2cSDOZPuAN+scp+gK7YwOIdHL7WOXenHSr3rNWiiCjGZHoIw8ysS30wiB1iIbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025465; c=relaxed/simple;
	bh=6hfv9dJ3mVPGavbF2drQpmNg/FsQobE4oNEmIyL6aEw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uPaFRxJERMIuAufIvob3BCBFkf+VGsxNPAMV269DW/7ai3oeQ2S23Lo1SXYnKzp4nPyBmCiaOFwGg61INO5C6RO9eXfwNT11BMfNeMoZEcHuZQtoe/G84CQi45aYga4WJD3V2gN55LlTgeytbbcSoVuT+anoEHOtiutpPw3arnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a2BaarAu; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a2BaarAu"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de51daf900cso4309297276.1
        for <git@vger.kernel.org>; Mon, 06 May 2024 12:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715025462; x=1715630262; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d3Lfr1Wdvxj4xlm3iGGkW/blqhNIFqjiFyFUhXWUFOY=;
        b=a2BaarAuYF5TEi3WR9a7EWg/S9y5m/83kqBvF5F4AndXMVSEqW3IsLJyrruWzE/whf
         kWhnYZJNO26xw3SWNQCgmliEmgX5HIxE1uFuCauzp6NB1ta6cMNykfcvnA1oDedi7/Jh
         4MkAsflQrLOdxx27+TVQlxYMNTRQozDbHlM0PGsBVaCiX7suRqWID/IJtEM8C5T0bd/p
         1rsh4ahjUJLXep7+nNeDZ/H4cBj6y0a04btqhCSGwodZ0Dh6qZihRpVk4FQCDc0v6xf7
         xgDkaejqJ09nRq65o3QkhVw4YXNsNleyhAPddM6cX6PMss32fYCKujwcnTyY3FbO10vj
         pDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715025462; x=1715630262;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d3Lfr1Wdvxj4xlm3iGGkW/blqhNIFqjiFyFUhXWUFOY=;
        b=kzhV/L/cENN0EyOz4NnMG7oJW0yoIRs4+MJ1PI+wsR57AHEsjCKOBT7U8tscCXBjM7
         QOA8sgYx2lUj7rJvY2oXzTt3/tCoA8k8kawRCn3epND2B9oGXp5K0dniWzcVvd9Z8TYY
         FxFcnyyNUXT0L/D6VX7NRPzd6jgYGKGY6xpVfdESDw5XPJgL+tDXUdel19CS9Rh9L/KG
         vWyPmWQewkAsll7UOkVDH78GFv0NkBiZ2KFDm5Z3f6eBxWRq4MatLvzbBOflhZammhxD
         0okSJNEaKFIMsZJ5NdVXgpz44Mh6nZKJL4qUzu4A/lwPmwf5QRHR5eMkUYgZqMZQl73h
         R6FQ==
X-Gm-Message-State: AOJu0YzztqPKaBPBv7w3so0JnmmU+u2F/G6NwzA5FHyh8vqx8z5cpyW5
	tl349quDv8oh8rwT7doGuJM0zDAuXXl1uvEFqHnZNqTXHE/1dpGplAPpJ+mvK38gXMQYQL2ai61
	/QiQNRNOUfKRo7LZdhXcsK+ehxQXQih25c/OomLBcxYu5HuubMSCXKQgEq2HA5CGX5g7WOpkJ2Z
	afrX0fiQ/hJf2eq66Aq8qD83GVoA8fP1GptoPzsmo=
X-Google-Smtp-Source: AGHT+IEnD/6+3ZdwTmoDLBEX4eFdQabOsZyWxEmxB1vQ/RCTM/a1f1N6jAxBLg4wZA101gwa553hVimZ+mjNag==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:cf3e:6b4e:994:dc81])
 (user=steadmon job=sendgmr) by 2002:a05:6902:1505:b0:dcc:6065:2b3d with SMTP
 id q5-20020a056902150500b00dcc60652b3dmr3602540ybu.8.1715025462598; Mon, 06
 May 2024 12:57:42 -0700 (PDT)
Date: Mon,  6 May 2024 12:57:32 -0700
In-Reply-To: <cover.1715024899.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1715024899.git.steadmon@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <24f47f8fc7e931c2e15fa985635e3036ec1123ba.1715024899.git.steadmon@google.com>
Subject: [PATCH v6 2/7] test-tool run-command testsuite: get shell from env
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
2.45.0.rc1.225.g2a3ae87e7f-goog

