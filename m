Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB801A0AE0
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 19:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714506970; cv=none; b=hcOwGw4lg6fD0GbKDZIQrn+AZUe2O80cKChE9hTlELiJK7siYree0zKXP9gN24RPv+z47s3Hbo4JbaaPq9clwFhkESafheQePIBmj7HLxF4cYRJgZxQLvHRvwgM9HEMmU3nNYfjGUUVdr6Hd/l8BhOpb9YPFS1Zw7sa8eYRZ4lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714506970; c=relaxed/simple;
	bh=zW1F8Yn3LK7yPQYCg7Z67QZ8ZJwL5y07M6h8BUyP21g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xy/agtx9cWNT/C7gzJBm7PrYoBdcDJAQYShdE5IfAF8Z2V9e7uSzWcWKZco8ZJSX8jUaY6YzN9/jfDd4QeTSnwdQTJ2fdvLjrXNiaTUVKxa23ZAZieQKsxpJSZHVP/V6584DIB7+vih6dzPrBEPgzwHdiHR2Q61X5qfvpgnZIjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i8Cng3Hw; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i8Cng3Hw"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be75e21fdso28624157b3.0
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714506968; x=1715111768; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sVdZFFCh3rUFSbBBF11GDVhRhs+IoapsU8gQaQ02ono=;
        b=i8Cng3Hw582CNRWYMb67D5w/cgNCcy36qgE3dH7zCrRJEGOSFEmQAvcQYS1jgRgsl6
         DjakLibCyzex0XC/vP2oRDXvSrXKY0lz6lp4Va1ZfDOh1V6rzBdahwA7aiSN0xCt3wEi
         YuOWj6pjKrJylnUTEqm9stZ8ABoAdo9zB8Z6pE/GiX2tJBvg/3Ybp+nO6PS7O3Ngj9Ec
         6+7jTAKuqrzE3ZyEywFVQwlkR5F0J0y0nUVObzg05L/5JeUidQ7PgGNeINJevBEf9/hc
         f4TisGexOtSv77UfZxNe7DRff5fTUW09Bxt5ZiHao3PqX0D29Cu5buTiNedJx488ndWc
         1uNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714506968; x=1715111768;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVdZFFCh3rUFSbBBF11GDVhRhs+IoapsU8gQaQ02ono=;
        b=wSH8EL2giwE5B6OLdafh3D6pf62E97Gll/wRtCOXdEsgz+ZVClAs06EVbGNl473oYo
         JbB3eqnsYX42WCMdDXYX8qXQW7QPUFO5U0YnsmBNy2H0rapkViIo2YQh8nf+HFEjFzyH
         JFI/sMLsgS9v9oT6/v9TyEXajeHyXeDr31PXaMc1TBRXwDR68yDtxy7ZuSel+3pP+Mnt
         hZtHCPcTy6VTp4kOMcqet6PJNwIbA6L4MKPqDGqzPDeGihaRvnV+yTvWQ1RStzKF895N
         ogxUH5eEcAaUrCwPEiF5zzvSE4Qi940dSRnKG5MO6ftJufuAABiuv4u7ipmeaidjXk1m
         6UoA==
X-Gm-Message-State: AOJu0YzMBMDAxgSyb4BMc3qlHbt3kx8++zOrRxFFdC9Eopu8ijfqIZAK
	IzxAi03xEdLz9+YqYQqo7WKiXu/wILB+dsR1x62ga4hW7Gu6WqTupcedLyboMBKEJLx2GTP0M8T
	i9XH/px/Zm0fgdSwLpi6P/5DGMagm+JhGMLrvQLizJeTdlkgamKiIv3eoeTpmG5jqX72nhXdfO8
	TuRZivXQW2YDVk1JKltxV6bPYJ+O+OU+NHsy6hFOg=
X-Google-Smtp-Source: AGHT+IESQt8uP4YHFvlA7BZPuv0/iuKHIiHRhpSCnSk79YnbVThyyjOv+9j7yF0Ke3nLjc/w5nHWexzI2R69gQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:3e48:fe18:8aa:8a0e])
 (user=steadmon job=sendgmr) by 2002:a81:6d15:0:b0:617:d650:11e2 with SMTP id
 i21-20020a816d15000000b00617d65011e2mr150454ywc.3.1714506967621; Tue, 30 Apr
 2024 12:56:07 -0700 (PDT)
Date: Tue, 30 Apr 2024 12:55:54 -0700
In-Reply-To: <cover.1714506612.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1714506612.git.steadmon@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <abc9a7afe8c1ab92bfbd2b9eea672bdd9ff3c107.1714506612.git.steadmon@google.com>
Subject: [PATCH v5 4/7] test-tool run-command testsuite: support unit tests
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
2.45.0.rc0.197.gbae5840b3b-goog

