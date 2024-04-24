Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7211375818
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713986065; cv=none; b=tCGyXsS7bg0cLWBZ2Y29Vh1087STlLdonlKcUmoR1eFJFjmV6uLpssUSYhNBTqOunaQ6uEG9LKqF1Lcz093SQHwMUFHVu5hoia1oiaKQUoYpUk8Vt0SxZngjcOSP6XRIi/xp7HOIJCs/coe5moamHo21yETge7PsANnXRr//7fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713986065; c=relaxed/simple;
	bh=yg46iEGvZBwXbfOKCDQhMMocQwlcjDeR+guuv1f81SQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SrdikabHgOegG7BQBpLrC6Z4THV6EZQbSGB1jrrrHVcm+cknYuYS5yxAB2Bsc5IgRlQYhxo7efFMQsQYDMZNmeCPAhrQYNCm22dL/WPBJe7/tohL/AwgtPt02fvu+cvXM+BzLkxhwfhLiZT4xbYV81d3BcRlY4vzFIVo7fhXEkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MMSmTw6m; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MMSmTw6m"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de465caa098so429988276.2
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 12:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713986063; x=1714590863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G64qEtS+3zmjGrrTEZef+ZAZnHDZCT8RCENC8Hj3u40=;
        b=MMSmTw6mQW6kQZatwopYcQGQ/EQPyEP+N5u1T3B+IUVrWqcWWQDYTDYI7qRXdK4mss
         bIwJWKd8UKF6XKnDAg9L/39uws0NYYGa2EqZiza/r4+9p/6Fg9d5xG5TAQrduUo9BU5E
         eJvlrT3RmrDxbYAc6FoaOyDPGh/wWOjbC++jUMRMGnQgNbqJWvQdXBMV/pEMPINGUEgv
         8fAMrPwcqr+V0XUhSHre93hRi1ZLwOtfYLBAZY+wmrkTkXHHyrTS2/KHQVQsMXA8cDqP
         /c0IEAxdxlf41iUmcAM+pMJohWsHCJV1DxnxlOBavHDbFicuzJSHhPloBaApzBkuarQw
         BuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713986063; x=1714590863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G64qEtS+3zmjGrrTEZef+ZAZnHDZCT8RCENC8Hj3u40=;
        b=ILo9exWyA611OCOrV9dKeO2KTEiY0SN62x0ZiA4oSS6cRljOUDml9ec8CsBSZgWGFi
         PmgEI7pPg58vNBBQw643rh4Dy0J1hCEmhdZG1ph8Q/j8bv6Ja+GSeqUkIO8TE9USAicU
         sXvj4w4qkSUVCTBE3DA+PJDyEXvCzsk0NecjmnKYjMY1/nQJouon36hZhC2ldyvMJ1TK
         q92byOUC+5kzjEAHBKzM7O8od+hiDuNh7cdipV2UI3ET/ozKgxcDJ4A7pOfL2khPjRkM
         HoDhaNvBpWFXj1pypsNOCJlPlUxZdJ2+Cbz2Jq7cso3APrOmBJ6MqmNQA/GNdZcnRfCh
         JRyA==
X-Gm-Message-State: AOJu0YwtFkJBSqjFad7gTA7edmsx/R/bZbLT7/3iH88invuNxcaOgj15
	sMwI3sroMkgFT+JpXfHqFSWg8eBFz8cj6tEQLf/GXd6GkVdKltEEL6xZ2evGBjMqxEkDa77H6Tm
	w+w9QEIgEDbNIIqWADPCNIUtMfT/K2KTK7uxuaL1TcZ1bpvKas5nQaUphI90qESdOKJrcn0oudu
	hWzPHVbbIJPUGxTCMINs97C7EUj31EAcGbgCGyYGU=
X-Google-Smtp-Source: AGHT+IFh6kiPyBJwp4D0GppjYGEXjtLXwl0phEUdaysht4dlwkfR1Zyp5ZmGAU5hPur7XwFfMhLsj6o0ot0p0g==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:5580:46bd:98b:ecbb])
 (user=steadmon job=sendgmr) by 2002:a05:6902:114d:b0:dda:c566:dadd with SMTP
 id p13-20020a056902114d00b00ddac566daddmr340769ybu.4.1713986063323; Wed, 24
 Apr 2024 12:14:23 -0700 (PDT)
Date: Wed, 24 Apr 2024 12:14:10 -0700
In-Reply-To: <cover.1713985716.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1713985716.git.steadmon@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <abc9a7afe8c1ab92bfbd2b9eea672bdd9ff3c107.1713985716.git.steadmon@google.com>
Subject: [PATCH v4 4/7] test-tool run-command testsuite: support unit tests
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, peff@peff.net
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
2.44.0.769.g3c40516874-goog

