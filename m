Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C1B5396
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 00:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706921444; cv=none; b=Xe4BI5Og+vGre/eFzUyAY1I0+JCXdblbNhnGByQGOQnvQgtWlSzyEweSnKCUt6eX73XBPQ8+A8H+7QcbKZHvMx5SfluKaTBkuYhDtA8Y49kNtm2SNOMkUIKJKC9/pAXGtGGMCERl6+5qhOwHVK/TySxlHh7EzGNkDhdqWRnnDnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706921444; c=relaxed/simple;
	bh=BFkovf9z3h2O/Zj7FehocK22dRLk7/+hP9pwgz2IbGU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KUYj4wFZ94wYSC3c8RW7B6fHLfrguoyymHRMGoo21X2nNltdZhxCNoVePn823SoMklpZ48c1VFkidK1yC0QpJiYgTKyMsETki5591IWMtEgwmITz+bKZrt2yutGm8Vsc8Yquml70ai33lpE/5jA58rX+c9ZQbHMX5Bnk6kLEyTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gywh0mWb; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gywh0mWb"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60420dcb127so17003077b3.1
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 16:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706921442; x=1707526242; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ik1LLyHE1sLsNq5BQyDgfQO92otwf9v4YaUoiA61F6M=;
        b=gywh0mWbGk+PMFuLHoBcnlZ9NTGH6dYX7o+Tq5QEz5Pkofvhb1HuMu3xmbBjgTf/bq
         FM88fpeOiKVmT/CaZONitUu5cvon//C1E1WQ077YYwZH/dTdJYRUkMpWaPkMUeHq3b68
         96d1qXjyI0JtqFrmw2PipPdJryOeDuvwdAJtU0iw+mO+mU7hHkf7hFf8OVudttBMekES
         JQ5Nicp6M20ostVfrTbQxpIcU6xAAZy6qIQLFSW8TNnJf68BNTIjI8+/zqPiHM59zInK
         3QxoIpwVzjwO+XSvF/SVAaHdce3KxGyLces9DsmsSkszmWJVAd+lj+AKSZhWsV8M5uHN
         ZPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706921442; x=1707526242;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ik1LLyHE1sLsNq5BQyDgfQO92otwf9v4YaUoiA61F6M=;
        b=MJ3/Ju9MM+BO1ZQ4cabgvDpX6KnuaxqL+1rzHyWxKeDo6aQwbu0DqYY+RPwFcEVwRI
         jY2kPyOCbllwOoE0xuZHKHESh52d8tcoBttyvemNjo8+pzTGkxwbPVfh7J2ayBv3ixHe
         QbBqF5Iibdbtct7hHn/y0bdpF4Cnu5zI0SN3o1YJe3oP4rOb04JdAm8Dhj8+hty2bAVf
         BmLfVmpMYFavXjBWVwrUOJUIIe5DZ5QVF6900G8PI3WHp3aUM5aZ0j6orN/2c5we1sqI
         jPvD0SYyYsqSt8iWwx8fOYOBzncDUEokZZtM6F3S/q7D+cTFCyBBD42IT1x+ZodmpZr1
         XPeg==
X-Gm-Message-State: AOJu0YwncuUXiKQQOod7NSDyjpdPNojikjSjA5HclPRv0iuzoVJhcyHK
	EaRxSbBe+ZfEPx4g8RaZlE3xqEkRq2gnL569OYr6fVkZ3C5VsMsg3fqA+h97UNZJvYlyI+FElW9
	m82MwDOMNXKseP8sjBBu0kM/vIS0c9QGnxVxTPD9QsfSXWEv2knnm4ncFEL81GM4ie7q9tgWLWk
	ktfxzFpthY2A3mhPLMo+5M62BuUh+8TgcJd7pXavU=
X-Google-Smtp-Source: AGHT+IHpEzFQ+VUfC6AeECewDKcRpFM3xRmGbvtCvTIDLc1TjnKzfYK3cbNr0oXgtOOuYZGfF57CM6kYpj7jqA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:705c:77af:6ef2:8f42])
 (user=steadmon job=sendgmr) by 2002:a05:690c:ece:b0:5ff:6e82:ea31 with SMTP
 id cs14-20020a05690c0ece00b005ff6e82ea31mr44935ywb.3.1706921442018; Fri, 02
 Feb 2024 16:50:42 -0800 (PST)
Date: Fri,  2 Feb 2024 16:50:29 -0800
In-Reply-To: <cover.1706921262.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1706921262.git.steadmon@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <b5665386b56df91fa5d95ee5b11288b5853546f0.1706921262.git.steadmon@google.com>
Subject: [RFC PATCH v2 4/6] test-tool run-command testsuite: support unit tests
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: johannes.schindelin@gmx.de, peff@peff.net, phillip.wood@dunelm.org.uk, 
	gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

Teach the testsuite runner in `test-tool run-command testsuite` how to
run unit tests: if TEST_SHELL_PATH is not set, assume that we're running
the programs directly from CWD, rather than defaulting to "sh" as an
interpreter.

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
 t/helper/test-run-command.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index e6bd792274..a0b8dc6fd7 100644
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
@@ -165,9 +167,14 @@ static int testsuite(int argc, const char **argv)
 	if (max_jobs <= 0)
 		max_jobs = online_cpus();
 
+	/*
+	 * If we run without a shell, we have to provide the relative path to
+	 * the executables.
+	 */
 	suite.shell_path = getenv("TEST_SHELL_PATH");
 	if (!suite.shell_path)
-		suite.shell_path = "sh";
+		strbuf_addstr(&progpath, "./");
+	path_prefix_len = progpath.len;
 
 	dir = opendir(".");
 	if (!dir)
@@ -180,13 +187,17 @@ static int testsuite(int argc, const char **argv)
 
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
@@ -213,6 +224,7 @@ static int testsuite(int argc, const char **argv)
 
 	string_list_clear(&suite.tests, 0);
 	string_list_clear(&suite.failed, 0);
+	strbuf_release(&progpath);
 
 	return ret;
 }
-- 
2.43.0.594.gd9cf4e227d-goog

