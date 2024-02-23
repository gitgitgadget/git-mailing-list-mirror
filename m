Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B53C14E2E3
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 23:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708731248; cv=none; b=cwMp9cK+kVudnFDSCPVRWJtdNvjqFa4tRdKjz0dI9F4pDmBX548ZreCvCuMkt9Vn+pkgUlXJB3PiAZPKdXuGY/k/cmfXJBui/bT/Ycp0+8VbDn2DEJt8ucHMFXAvSfKmH6PIhDhJbul4fH0v6JJ/r3Zbk+q+iZhl5J3zaHQco/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708731248; c=relaxed/simple;
	bh=8+Ur2wDE3s5LH4SggzLj3O7YuVC/e+cLYOdrRxMnCS0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FH6ij7vi6FCP7UDanbJEegQ4+6pJB6P5r4fMtQBkiANgIkFUsIcbLwlhUJH47qNz24yt3opSG3GUzp+H+SQPl5eo3lLbQN2DP6NkrjVMnE8Ci2aya2mWCg6Pb5XKIHdJeyms7jG48b9DOU9oJIk/dDY3gfsn8f6RneoUrNn7BoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yY18nXQJ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yY18nXQJ"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608ad239f8fso25246467b3.0
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 15:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708731246; x=1709336046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YS5IgGzKz2ph9H6jWzxteSZ9Z//flJwLlak8BMLty8M=;
        b=yY18nXQJGOdU6IQdy0xEq8nQ30t5vC+fH8XZ1W2LYvOYY/A+xDnCoGGcRQEeUoN06a
         kylDR//vPk2FJg6YopxOWVq27CXcmUZF3Wnn7fWXyXW7aQKz8VYaWU16zYzPA9qpMqIE
         P7mC54DcrcyDq9FEs9axpVqnZpIHleI/fKqYcBPgv1dvMPydQxeTdTaBkm279RxxQbZd
         8xRuKeL4fyGkIOyIzadDH6tn4SQCcL+j3Q/0Ic8Cli026D2yB26j1S3FpitvkpQ6XNin
         6p6Lbs49sp3CYW4CS3yKEYGPvCZLl1FdB1g50tP3+1BGjFZuPJgES1QMou/GmNRCHScs
         l/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708731246; x=1709336046;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YS5IgGzKz2ph9H6jWzxteSZ9Z//flJwLlak8BMLty8M=;
        b=f21GmDxe4xpcWFPeibauQ+j5V2IyPppfDmiEm4y76Pt3viogD6oK4I1wXLXEWstjRa
         aoX4K16a4NagoHJ1ZOQgSjkYQsZJWdRk6t/QP/4DkvQX5QKf1FaLrXPg5P/sLD2gbuLi
         wrieMpqJPdVa7vyoNPSVVtjTHNwqGzazCoB7hQQ+dH/Ot1RU8jbNszd8L1fHHbzHIEyv
         yy0zEhXJUYlcjAPrHNAsPhWrXJb8LK/E+RoGhGd3/9MxD1HsTuP7n/UeiUmuQyPO5dm3
         FuKx4rvRFSUaM3B0LB07b+BLP2H4fski62CGsvD9ow4A7qqK5oIUsKjXDeCkURQTI45R
         F4sw==
X-Gm-Message-State: AOJu0YyedgyLkk3vrcjkzuUH3zElCas7cVP/50BS5Nccg6l4IIBf4vWd
	eizAGSNNoKpiIg/Tioq5IgF4b17DdweTBun5DUm2Cp6dEWhPZriyPn5J3KP/f1d7xY4HSCVi9qN
	uQiYTOQ8WtjmiePoBYvBcEOI9yI/R6/JS7L5P0VuQh8+uuosmWH2F5IeeNWk2ir6pg+77nC1wns
	zR1xmKLZrYRF+F6GNEyYZ63F5mdptGZkWpMr9kEPw=
X-Google-Smtp-Source: AGHT+IEUiyVpL+OhBTINpiAon7M6NqiJNoLbypTBRHcswxDw8Cs3nSBWfU35mjymZIDmDXnor/01U4U3gGqDlg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:2fd9:97d1:a490:26b8])
 (user=steadmon job=sendgmr) by 2002:a0d:d44d:0:b0:607:d016:d85c with SMTP id
 w74-20020a0dd44d000000b00607d016d85cmr317901ywd.9.1708731245886; Fri, 23 Feb
 2024 15:34:05 -0800 (PST)
Date: Fri, 23 Feb 2024 15:33:53 -0800
In-Reply-To: <cover.1708728717.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1708728717.git.steadmon@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <abc9a7afe8c1ab92bfbd2b9eea672bdd9ff3c107.1708728717.git.steadmon@google.com>
Subject: [PATCH v3 4/7] test-tool run-command testsuite: support unit tests
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: johannes.schindelin@gmx.de, peff@peff.net, phillip.wood@dunelm.org.uk, 
	gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

Teach the testsuite runner in `test-tool run-command testsuite` how to
run unit tests: if TEST_SHELL_PATH is not set, run the programs directly
from CWD, rather than defaulting to "sh" as an interpreter.

With this change, you can now use test-tool to run the unit tests:
$ make
$ cd t/unit-tests/bin
$ ../../helper/test-tool run-command testsuite

This should be helpful on Windows to allow running tests without
requiring Perl (for `prove`), as discussed in [1] and [2].

This again breaks backwards compatibility, as it is now required to set
TEST_SHELL_PATH properly for executing shell scripts, but again, as
noted in [2], there are no longer any such invocations in our codebase.

[1] https://lore.kernel.org/git/nycvar.QRO.7.76.6.2109091323150.59@tvgsbejvaqbjf.bet/
[2] https://lore.kernel.org/git/850ea42c-f103-68d5-896b-9120e2628686@gmx.de/

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 t/helper/test-run-command.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index e6bd792274..61eb1175fe 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -158,6 +158,8 @@ static int testsuite(int argc, const char **argv)
 		.task_finished = test_finished,
 		.data = &suite,
 	};
+	struct strbuf progpath = STRBUF_INIT;
+	size_t path_prefix_len;
 
 	argc = parse_options(argc, argv, NULL, options,
 			testsuite_usage, PARSE_OPT_STOP_AT_NON_OPTION);
@@ -165,9 +167,13 @@ static int testsuite(int argc, const char **argv)
 	if (max_jobs <= 0)
 		max_jobs = online_cpus();
 
+	/*
+	 * If we run without a shell, execute the programs directly from CWD.
+	 */
 	suite.shell_path = getenv("TEST_SHELL_PATH");
 	if (!suite.shell_path)
-		suite.shell_path = "sh";
+		strbuf_addstr(&progpath, "./");
+	path_prefix_len = progpath.len;
 
 	dir = opendir(".");
 	if (!dir)
@@ -180,13 +186,17 @@ static int testsuite(int argc, const char **argv)
 
 		/* No pattern: match all */
 		if (!argc) {
-			string_list_append(&suite.tests, p);
+			strbuf_setlen(&progpath, path_prefix_len);
+			strbuf_addstr(&progpath, p);
+			string_list_append(&suite.tests, progpath.buf);
 			continue;
 		}
 
 		for (i = 0; i < argc; i++)
 			if (!wildmatch(argv[i], p, 0)) {
-				string_list_append(&suite.tests, p);
+				strbuf_setlen(&progpath, path_prefix_len);
+				strbuf_addstr(&progpath, p);
+				string_list_append(&suite.tests, progpath.buf);
 				break;
 			}
 	}
@@ -213,6 +223,7 @@ static int testsuite(int argc, const char **argv)
 
 	string_list_clear(&suite.tests, 0);
 	string_list_clear(&suite.failed, 0);
+	strbuf_release(&progpath);
 
 	return ret;
 }
-- 
2.44.0.rc0.258.g7320e95886-goog

