Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3856822EE5
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 22:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705443789; cv=none; b=sKHh+uWaLielSnvmBY1ZLojmLfMIFBRz2CAiaih9Cu1y07FmE1mc5kFrUj+U9WelehiPX5TL4yRsDRgVGYY45TU3UMWsyFxySRyacSHXx8Ibh+WqImzOe0Ie26M4BsIMgod+VlYfc1SAqX0ygZ7p7e/OVBB0bw9ldhhxw2sA4aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705443789; c=relaxed/simple;
	bh=7oeVZJc8qew6+ah6xGGuIXjJr4SDWrl2BFYh/6kjx9Y=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:
	 From:To:Cc:Content-Type; b=Ci2/ZfIJ+1HnwNfFMRLCThIfc3EXrtVZiySmUnOKyjymRqLSdhzpP5MxiUsDFGXb3tz54uUDEbV5hVw9yIWE0ZJ4Dl6cPVrlRC09QjkkW+JpigCEvDYwUerC6BTKu2CKZ9RMeGXE51bX+3L/TUV7eXpPE+KVYPq13PqZji3dM/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PpFUFpl5; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PpFUFpl5"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d9a541b720aso14749354276.0
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 14:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705443787; x=1706048587; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h4fDScwI/7M7veleiZScsf1GnA+jVVDAXJVD2ybzUQI=;
        b=PpFUFpl5mtedQuv9aYZ+YsIX7eBjYbaKobbXVO5ktAahFRDbRn1ZEgQ62ebU1FAOwq
         EHdiM2XCsXCX+j76+l1lvokSNp7NcNvkWyWG56jukcB7v2rytTYhMa2LfufIcP725/mI
         vfV3OcO5ClS3gST5tIo3+OE8wTzUTjipPjj1UnUCqbfc9Fpbam6CToYsNQl07mVOIAZ2
         KHoEe3fk+sMIXAWDSHXKf2aiwL0TUW1uk4Q/D0D7cTAtpQDr4xNn50Yqo9TF0ztClmCt
         HgyXhd+xM6rvXFmUtOIvH7hlRJdZXsUP0HsRO7jL/ZCVbSrwmyYyxjSZoacsMZ64RcLa
         BIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705443787; x=1706048587;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h4fDScwI/7M7veleiZScsf1GnA+jVVDAXJVD2ybzUQI=;
        b=UeJUeMOzpEMq5CJnpocZwQj8WbJKDn+f7KyGIi0YW4c0LXhaMYK316fzS7B8gf+8lH
         J+4IlM3uWfi9Pi5GCdttr7aWEytQ3HMM9GGtEsMxvymR9eD7fLyTmJNeCya2N+VS3cLp
         RrVzOETru1Io7bz5jxzY27zm64rU95xshHEsIVP4B5rx8E+DFkN774uz/rstIS18VSG+
         foqieH6v5k8Y41Fp62ycRcOTpFPK2WsFbsybIAvhUf4uZsKEWFkYZ/rD3dRkyALlLpyw
         8CJ9CoUOy0IY7EiWiDLoghG5LPO8h0hVRmZb9smO6a4rFJvc509KDbFhQyrGOQeu6Uln
         jTJA==
X-Gm-Message-State: AOJu0Yz1GlYKooQlOsc4tPZ1OJRkQLzp/frxUVePEG+BX36iTtaxIw0M
	l6aZkzc+aPRbb0achQPGIaej3a4gSXgrvmGqR0zqc25kLBZJbU9nE8IYv72xQoitIWVPc43QhhG
	HjAJkgBsDpL6vzgW3P7EElZIRjD2aWdVNAOMFuKf9aSriSnWaqBch2BnCQKXzDhNhpUtF/w==
X-Google-Smtp-Source: AGHT+IHsuy/KHL+Q20hcBKsKLXPlnqxi2655z9i77q7L+ZEwVwfvLWz/aEN0XBalOhPVJB0j/fpjMiaxUGOLxA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:a6f6:5624:1895:86a4])
 (user=steadmon job=sendgmr) by 2002:a25:abcc:0:b0:dc2:2596:52ef with SMTP id
 v70-20020a25abcc000000b00dc2259652efmr682963ybi.12.1705443787094; Tue, 16 Jan
 2024 14:23:07 -0800 (PST)
Date: Tue, 16 Jan 2024 14:22:59 -0800
In-Reply-To: <cover.1705443632.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Message-ID: <5ecbc976e6216b941e760e096e166ab432ee7784.1705443632.git.steadmon@google.com>
Subject: [RFC PATCH 2/4] test-tool run-command testsuite: support unit tests
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: johannes.schindelin@gmx.de, peff@peff.net, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

Teach the testsuite runner in `test-tool run-command testsuite` how to
run unit tests, by adding two new flags:

First, "--(no-)run-in-shell" allows the test-tool to exec the unit-test
binaries directly, rather than trying to interpret them as shell
scripts.

Second "--(no-)require-shell-test-pattern" bypasses the check that the
test filenames match the expected t####-*.sh pattern.

With these changes, you can now use test-tool to run the unit tests:
$ make
$ cd t/unit-tests/bin
$ ../../helper/test-tool run-command testsuite --no-run-in-shell \
    --no-require-shell-test-pattern

This should be helpful on Windows to allow running tests without
requiring Perl (for `prove`), as discussed in [1] and [2].

[1] https://lore.kernel.org/git/nycvar.QRO.7.76.6.2109091323150.59@tvgsbejvaqbjf.bet/
[2] https://lore.kernel.org/git/850ea42c-f103-68d5-896b-9120e2628686@gmx.de/

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 t/helper/test-run-command.c | 40 +++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index c0ed8722c8..2db7e1ef03 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -64,11 +64,12 @@ static int task_finished(int result UNUSED,
 struct testsuite {
 	struct string_list tests, failed;
 	int next;
-	int quiet, immediate, verbose, verbose_log, trace, write_junit_xml;
+	int quiet, immediate, verbose, verbose_log, trace, write_junit_xml, run_in_shell;
 };
 #define TESTSUITE_INIT { \
 	.tests = STRING_LIST_INIT_DUP, \
 	.failed = STRING_LIST_INIT_DUP, \
+	.run_in_shell = 1, \
 }
 
 static int next_test(struct child_process *cp, struct strbuf *err, void *cb,
@@ -80,7 +81,9 @@ static int next_test(struct child_process *cp, struct strbuf *err, void *cb,
 		return 0;
 
 	test = suite->tests.items[suite->next++].string;
-	strvec_pushl(&cp->args, "sh", test, NULL);
+	if (suite->run_in_shell)
+		strvec_push(&cp->args, "sh");
+	strvec_push(&cp->args, test);
 	if (suite->quiet)
 		strvec_push(&cp->args, "--quiet");
 	if (suite->immediate)
@@ -133,7 +136,7 @@ static const char * const testsuite_usage[] = {
 static int testsuite(int argc, const char **argv)
 {
 	struct testsuite suite = TESTSUITE_INIT;
-	int max_jobs = 1, i, ret = 0;
+	int max_jobs = 1, i, ret = 0, require_shell_test_pattern = 1;
 	DIR *dir;
 	struct dirent *d;
 	struct option options[] = {
@@ -147,6 +150,10 @@ static int testsuite(int argc, const char **argv)
 		OPT_BOOL('x', "trace", &suite.trace, "trace shell commands"),
 		OPT_BOOL(0, "write-junit-xml", &suite.write_junit_xml,
 			 "write JUnit-style XML files"),
+		OPT_BOOL(0, "run-in-shell", &suite.run_in_shell,
+			 "run programs in the suite via `sh`"),
+		OPT_BOOL(0, "require-shell-test-pattern", &require_shell_test_pattern,
+			 "require programs to match 't####-*.sh'"),
 		OPT_END()
 	};
 	struct run_process_parallel_opts opts = {
@@ -155,12 +162,21 @@ static int testsuite(int argc, const char **argv)
 		.task_finished = test_finished,
 		.data = &suite,
 	};
+	struct strbuf progpath = STRBUF_INIT;
+	size_t path_prefix_len;
 
 	argc = parse_options(argc, argv, NULL, options,
 			testsuite_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (max_jobs <= 0)
 		max_jobs = online_cpus();
+	/*
+	 * If we run without a shell, we have to provide the relative path to
+	 * the executables.
+	 */
+	if (!suite.run_in_shell)
+		strbuf_addstr(&progpath, "./");
+	path_prefix_len = progpath.len;
 
 	dir = opendir(".");
 	if (!dir)
@@ -168,20 +184,27 @@ static int testsuite(int argc, const char **argv)
 	while ((d = readdir(dir))) {
 		const char *p = d->d_name;
 
-		if (*p != 't' || !isdigit(p[1]) || !isdigit(p[2]) ||
-		    !isdigit(p[3]) || !isdigit(p[4]) || p[5] != '-' ||
-		    !ends_with(p, ".sh"))
+		if (!strcmp(p, ".") || !strcmp(p, ".."))
 			continue;
+		if (require_shell_test_pattern)
+			if (*p != 't' || !isdigit(p[1]) || !isdigit(p[2]) ||
+			    !isdigit(p[3]) || !isdigit(p[4]) || p[5] != '-' ||
+			    !ends_with(p, ".sh"))
+				continue;
 
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
@@ -208,6 +231,7 @@ static int testsuite(int argc, const char **argv)
 
 	string_list_clear(&suite.tests, 0);
 	string_list_clear(&suite.failed, 0);
+	strbuf_release(&progpath);
 
 	return ret;
 }
-- 
2.43.0.381.gb435a96ce8-goog

