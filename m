Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A352D170A0C
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935350; cv=none; b=A0a8oqHw5xmyEfk73dzfzlv/jH1c2qGaCa0C4VGxWvSuep8dYnVVoxM9IGHiJXCb556JdRTZhp9t1LmPdfP6+03DKpczQJo/p82kxg9Fp+A1oZ4Wm7hIjfsUes44A/Z5fuj+u0J234uGqeOJsRQHYF+NEBwe+pF1bGObWaQtL28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935350; c=relaxed/simple;
	bh=Go1XUKLY7c0eb5W9KHBv7FO3C997HZdEcDN77UNK3Mk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DHz3lxbZPQ8BZICVaDy3FhrknSknomOta4OvoUo6mrwKABCDEFZQqxB7rrJFjObSIBmiXwo2S49hqKjZ9Q31zdQe6fUps8A8SvAI+1WWDbgvZNtENt0HUVJS6cjK7PapiUPj4Q+BeuWIHitnWJetaMm2Gej5M4K4nzHnWALquEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/XlDF8R; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/XlDF8R"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c3cdba33b0so5322758a12.1
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935346; x=1726540146; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TIY02C2h2gxt3+JNHhmVHI27oCIFDdgGPNie6FNZlY=;
        b=J/XlDF8Rh1ZyWG+qLR0Q1i31tt+SejTpU3nTzi2Mp0miqmSHF6IE6ZfkDSRBhwLEEq
         O3vHrHnHwviE48J/cTlI77W+MBpm1KMiqqovPoUksXaAzt5dj7vBGja5ySSBeMZl277Z
         zQHtqCPonXapdM2C1sKkmJrgjvewyTeO3jBIYrvSPj4QJapv7x8+RcFCKukjf/Q/yG4f
         QoOvtm28irPCwnGb5j2nWv32yVvJta2u2I5cwf1kFttYHpo0otrd2/oudVNHJ71DMhBX
         km7soh2fvIoTjnH/+vbLvvJYxBggf+FMmW/VHtPQIv1BNiqcseQP81/u0dA76MTendCE
         6beA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935346; x=1726540146;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TIY02C2h2gxt3+JNHhmVHI27oCIFDdgGPNie6FNZlY=;
        b=ecVIbhosBY4BoGQvh2cseEbl1l+v7gft9ry+ZqrDYM21FOZ1tgLqM9lxx5Xvg6S/54
         pcPpz60u22A2kp2Kx62xuhKRMG3wcfVMYci9C+zJGTwfRN5U+TVZ2lDq8yu+s5KrTYdh
         qE62SVoz6tlVTVryIa+sxIEjfE2KFhRWPK9BaJ/2yszH7tu9y3PUe5ocSjk0P5I05m5f
         TgkopEOmuobmV4jNBtVZzUR2oT0uIS/1lRhWRYto45dEFFoFN9hLbaLT1KDsHRajv+Rp
         rp+6LAX/P+ntbD9j+W56WyMN8hGId41L2K6TRPLnPcKM6wWqWYV3MkYBHucvjQRuiME/
         OfOQ==
X-Gm-Message-State: AOJu0YwA2lKuTl+BamlIl7CeahcdknmGxt0wjPRsnoNxHrKF9CNUhgob
	dmkmwDY86/i4LW7E8NMv8SpciRR8uH9Cl8LalZ16CqLr4Qpyr9LORV1J0w==
X-Google-Smtp-Source: AGHT+IFMVYE7IqRGpHP6rSA5w0SZzhVo7gGtKuHDpGV31hpDgmwQi7XCGxC9cIuRlA/ZDnPlIiJ06Q==
X-Received: by 2002:a17:906:fd8b:b0:a8a:809b:14e0 with SMTP id a640c23a62f3a-a8a88871d22mr1362627066b.48.1725935346401;
        Mon, 09 Sep 2024 19:29:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a2539bsm415256266b.85.2024.09.09.19.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:06 -0700 (PDT)
Message-Id: <7d43a1634bbe2d2efa96a806e3de1f1fd480041b.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:34 +0000
Subject: [PATCH 09/30] survey: stub in new experimental `git-survey` command
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Start work on a new `git survey` command to scan the repository
for monorepo performance and scaling problems.  The goal is to
measure the various known "dimensions of scale" and serve as a
foundation for adding additional measurements as we learn more
about Git monorepo scaling problems.

The initial goal is to complement the scanning and analysis performed
by the GO-based `git-sizer` (https://github.com/github/git-sizer) tool.
It is hoped that by creating a builtin command, we may be able to take
advantage of internal Git data structures and code that is not
accessible from GO to gain further insight into potential scaling
problems.

RFC TODO: Adapt this boilerplat to match the upcoming changes to builtin
methods that include a 'struct repository' pointer.

Co-authored-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 .gitignore                   |  1 +
 Documentation/git-survey.txt | 36 ++++++++++++++++++++++
 Makefile                     |  1 +
 builtin.h                    |  1 +
 builtin/survey.c             | 60 ++++++++++++++++++++++++++++++++++++
 command-list.txt             |  1 +
 git.c                        |  1 +
 t/t8100-git-survey.sh        | 18 +++++++++++
 8 files changed, 119 insertions(+)
 create mode 100644 Documentation/git-survey.txt
 create mode 100644 builtin/survey.c
 create mode 100755 t/t8100-git-survey.sh

diff --git a/.gitignore b/.gitignore
index 8f5cb938ecb..3f6fdb31a5e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -165,6 +165,7 @@
 /git-submodule
 /git-submodule--helper
 /git-subtree
+/git-survey
 /git-svn
 /git-switch
 /git-symbolic-ref
diff --git a/Documentation/git-survey.txt b/Documentation/git-survey.txt
new file mode 100644
index 00000000000..cdd1ec4358b
--- /dev/null
+++ b/Documentation/git-survey.txt
@@ -0,0 +1,36 @@
+git-survey(1)
+=============
+
+NAME
+----
+git-survey - EXPERIMENTAL: Measure various repository dimensions of scale
+
+SYNOPSIS
+--------
+[verse]
+(EXPERIMENTAL!) `git survey` <options>
+
+DESCRIPTION
+-----------
+
+Survey the repository and measure various dimensions of scale.
+
+As repositories grow to "monorepo" size, certain data shapes can cause
+performance problems.  `git-survey` attempts to measure and report on
+known problem areas.
+
+OPTIONS
+-------
+
+--progress::
+	Show progress.  This is automatically enabled when interactive.
+
+OUTPUT
+------
+
+By default, `git survey` will print information about the repository in a
+human-readable format that includes overviews and tables.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 4305474d96e..154de6e01d0 100644
--- a/Makefile
+++ b/Makefile
@@ -1303,6 +1303,7 @@ BUILTIN_OBJS += builtin/sparse-checkout.o
 BUILTIN_OBJS += builtin/stash.o
 BUILTIN_OBJS += builtin/stripspace.o
 BUILTIN_OBJS += builtin/submodule--helper.o
+BUILTIN_OBJS += builtin/survey.o
 BUILTIN_OBJS += builtin/symbolic-ref.o
 BUILTIN_OBJS += builtin/tag.o
 BUILTIN_OBJS += builtin/unpack-file.o
diff --git a/builtin.h b/builtin.h
index 73dd0ccbe8c..d4e8cf3b97b 100644
--- a/builtin.h
+++ b/builtin.h
@@ -239,6 +239,7 @@ int cmd_status(int argc, const char **argv, const char *prefix);
 int cmd_stash(int argc, const char **argv, const char *prefix);
 int cmd_stripspace(int argc, const char **argv, const char *prefix);
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
+int cmd_survey(int argc, const char **argv, const char *prefix);
 int cmd_switch(int argc, const char **argv, const char *prefix);
 int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
 int cmd_tag(int argc, const char **argv, const char *prefix);
diff --git a/builtin/survey.c b/builtin/survey.c
new file mode 100644
index 00000000000..4cfd0f0293c
--- /dev/null
+++ b/builtin/survey.c
@@ -0,0 +1,60 @@
+#include "builtin.h"
+#include "config.h"
+#include "parse-options.h"
+
+static const char * const survey_usage[] = {
+	N_("(EXPERIMENTAL!) git survey <options>"),
+	NULL,
+};
+
+struct survey_opts {
+	int verbose;
+	int show_progress;
+};
+
+static struct survey_opts survey_opts = {
+	.verbose = 0,
+	.show_progress = -1, /* defaults to isatty(2) */
+};
+
+static struct option survey_options[] = {
+	OPT__VERBOSE(&survey_opts.verbose, N_("verbose output")),
+	OPT_BOOL(0, "progress", &survey_opts.show_progress, N_("show progress")),
+	OPT_END(),
+};
+
+static int survey_load_config_cb(const char *var, const char *value,
+				 const struct config_context *ctx, void *pvoid)
+{
+	if (!strcmp(var, "survey.verbose")) {
+		survey_opts.verbose = git_config_bool(var, value);
+		return 0;
+	}
+	if (!strcmp(var, "survey.progress")) {
+		survey_opts.show_progress = git_config_bool(var, value);
+		return 0;
+	}
+
+	return git_default_config(var, value, ctx, pvoid);
+}
+
+static void survey_load_config(void)
+{
+	git_config(survey_load_config_cb, NULL);
+}
+
+int cmd_survey(int argc, const char **argv, const char *prefix)
+{
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(survey_usage, survey_options);
+
+	prepare_repo_settings(the_repository);
+	survey_load_config();
+
+	argc = parse_options(argc, argv, prefix, survey_options, survey_usage, 0);
+
+	if (survey_opts.show_progress < 0)
+		survey_opts.show_progress = isatty(2);
+
+	return 0;
+}
diff --git a/command-list.txt b/command-list.txt
index c537114b468..ecc9d2281a0 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -187,6 +187,7 @@ git-stash                               mainporcelain
 git-status                              mainporcelain           info
 git-stripspace                          purehelpers
 git-submodule                           mainporcelain
+git-survey                              mainporcelain
 git-svn                                 foreignscminterface
 git-switch                              mainporcelain           history
 git-symbolic-ref                        plumbingmanipulators
diff --git a/git.c b/git.c
index 4f2215e9c8b..98e90838e42 100644
--- a/git.c
+++ b/git.c
@@ -630,6 +630,7 @@ static struct cmd_struct commands[] = {
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
 	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP },
+	{ "survey", cmd_survey, RUN_SETUP },
 	{ "switch", cmd_switch, RUN_SETUP | NEED_WORK_TREE },
 	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 	{ "tag", cmd_tag, RUN_SETUP | DELAY_PAGER_CONFIG },
diff --git a/t/t8100-git-survey.sh b/t/t8100-git-survey.sh
new file mode 100755
index 00000000000..2df7fa83629
--- /dev/null
+++ b/t/t8100-git-survey.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+
+test_description='git survey'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+TEST_PASSES_SANITIZE_LEAK=0
+export TEST_PASSES_SANITIZE_LEAK
+
+. ./test-lib.sh
+
+test_expect_success 'git survey -h shows experimental warning' '
+	test_expect_code 129 git survey -h 2>usage &&
+	grep "EXPERIMENTAL!" usage
+'
+
+test_done
-- 
gitgitgadget

