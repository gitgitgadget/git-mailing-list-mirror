Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88211F3D3A
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 20:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515644; cv=none; b=oggTgZHH58r5yKBBSNka4LHr+Z3uVitfCvEORLXtBxUjuo2NGHYPjPbcOy7GpO41S5GMJERfLQf1+4kQsOcpmiFW0zpmQ7zo1YTsqNPcdNhYhedsIDn/0ngnvKhW9x+1RTrXFSBkf8B9HhyhzKcyBHsUf6FEqfchFj0OQxVeM7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515644; c=relaxed/simple;
	bh=I9Pb9pjR0dbL4sTNqDEDrW7TKbj21teRmZNgbpZDFZs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RR9Vk6En8on/euGgPKRQdEcv4ds3An3jl1glQ9VdNkGYy9npSxXMVYN5iZ60vJJSlVjjx35fBYDHdrMtHr/mT7zxg4BzqkhXQuFjfTqig97eutFHEvqhiotyPW3G60DH9JkHelPNCU3yjreCFVuaey5PLHUGITJ7WmWQDmySjU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVqV+sB4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVqV+sB4"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434ab938e37so16522105e9.0
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 12:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733515641; x=1734120441; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1MZfcW3h2bVPFqgSOH07jJe+Cl7FkMBlEB42zBTChU=;
        b=VVqV+sB40R/6Du8RVpQw/+Z7Be6Ep/CliLQVJVEwg8GezDyCDbHSxs+khzLC7krcbv
         yH/nhg36x9Zvadhh540VOvmtiTemW7GqOfk/p5NI/Cjo8vrP4TIb0QyVMDD0UVyKCcyR
         SaUNboA0UC9VOTkWVofQPpBK6xSJAw1nYBi9mswMzOVgeomcZpF8mvkL5/Qg8aRK9gd+
         MCXeOqNBoQu7JxPmX94LzbepQe1JFOHYl7l9o25Re7OMRsRyNjCEs41HRW5vLyRD+zVf
         04hOA6sHDbKm6oEh/vokguboPtkmScJMuplEP+ooKBfiSBbHG3nmFZ51CA5c7lEWCeaA
         eI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733515641; x=1734120441;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1MZfcW3h2bVPFqgSOH07jJe+Cl7FkMBlEB42zBTChU=;
        b=sv/ZeEBI88Xtif6qXW+Tbf6+UE6pcXPsAkI3nSw7qozjO1zdJtQsOPMmqyPYpEN9Hf
         f6i1tUIc3KKoXSeefLX7V1SVW87BkMKmzpow/lLZvolVGeLkBoaRuaLIj/vmtivRbQ7y
         ROJ2uzSq1rtjGAxA1Jah12YA/GmtYt80dsJVG7apcLEjhtg0BNatcKCuGYdxFpBXygY4
         YsMGKufQERWQmrZqln8l9FZFzZUER+S+myUK+WSiNhCEVTqjMEsfinGQlwgAGsJ/ABbU
         nYRhIUhzVVyEcNJ1BiolzMKx+ef0F8Dpj/johzw/XHwcja7kfCWg8OEDo0NEP9p7dxqA
         gkpw==
X-Gm-Message-State: AOJu0YyvqK1BNAPNZh75QybnJW9wtkkG0HdbOfEMeAtiULVeOE3CpBYh
	+5JhZE7EaFLkwP+65MI33uStDkon3AJ8QBcpDHexnNYZAxIoro1aDaPewQ==
X-Gm-Gg: ASbGncszAlSDE2JsMPHS9W1uu0othTHb6AHcK80sWaEozAHx4GZq3uDcdhBUcxWWML9
	JiQNE7LpHxKxwBaEgAKeR6urvfgg4mO0iwWb26mpa4EVYSDOzi5HPBY7s0SbOTc2smrypgNMfhA
	z3ZUMXcAIObDqCyEXUcbLWF66S+eDhNwr6jpiIRJwJ08SWcS4MSUWmeYLlBou54SiQYa25MXxXj
	XSd43NsIvRHkAfJIXZQghx/uVuRgGKkD3tioji8IZ0YJ2gq4+c=
X-Google-Smtp-Source: AGHT+IHnFVptriIuACO1vJtH27nKLlC2YTE2wXqxssFE1VLuFgQD/FTJkmozaMg1H9+65az5N8a+Fw==
X-Received: by 2002:a05:600c:3ca3:b0:434:a367:2bd9 with SMTP id 5b1f17b1804b1-434ddeb6731mr38711605e9.14.1733515640522;
        Fri, 06 Dec 2024 12:07:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da1133c3sm65278905e9.31.2024.12.06.12.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 12:07:19 -0800 (PST)
Message-Id: <0300aa1b8c37dcd0d529cc24588ae77960fdfbff.1733515638.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Dec 2024 20:07:14 +0000
Subject: [PATCH 1/5] backfill: add builtin boilerplate
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
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <derrickstolee@github.com>

From: Derrick Stolee <derrickstolee@github.com>

In anticipation of implementing 'git backfill', populate the necessary files
with the boilerplate of a new builtin.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 .gitignore                     |  1 +
 Documentation/git-backfill.txt | 23 +++++++++++++++++++++++
 Makefile                       |  1 +
 builtin.h                      |  1 +
 builtin/backfill.c             | 29 +++++++++++++++++++++++++++++
 command-list.txt               |  1 +
 git.c                          |  1 +
 7 files changed, 57 insertions(+)
 create mode 100644 Documentation/git-backfill.txt
 create mode 100644 builtin/backfill.c

diff --git a/.gitignore b/.gitignore
index 6687bd6db4c..0f9e7de2ec3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -20,6 +20,7 @@
 /git-apply
 /git-archimport
 /git-archive
+/git-backfill
 /git-bisect
 /git-blame
 /git-branch
diff --git a/Documentation/git-backfill.txt b/Documentation/git-backfill.txt
new file mode 100644
index 00000000000..640144187d3
--- /dev/null
+++ b/Documentation/git-backfill.txt
@@ -0,0 +1,23 @@
+git-backfill(1)
+===============
+
+NAME
+----
+git-backfill - Download missing objects in a partial clone
+
+
+SYNOPSIS
+--------
+[verse]
+'git backfill' [<options>]
+
+DESCRIPTION
+-----------
+
+SEE ALSO
+--------
+linkgit:git-clone[1].
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 50413d96492..e18e0f4e447 100644
--- a/Makefile
+++ b/Makefile
@@ -1203,6 +1203,7 @@ BUILTIN_OBJS += builtin/am.o
 BUILTIN_OBJS += builtin/annotate.o
 BUILTIN_OBJS += builtin/apply.o
 BUILTIN_OBJS += builtin/archive.o
+BUILTIN_OBJS += builtin/backfill.o
 BUILTIN_OBJS += builtin/bisect.o
 BUILTIN_OBJS += builtin/blame.o
 BUILTIN_OBJS += builtin/branch.o
diff --git a/builtin.h b/builtin.h
index f7b166b3348..89928ccf92f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -120,6 +120,7 @@ int cmd_am(int argc, const char **argv, const char *prefix, struct repository *r
 int cmd_annotate(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_apply(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_archive(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_backfill(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_bisect(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_blame(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_branch(int argc, const char **argv, const char *prefix, struct repository *repo);
diff --git a/builtin/backfill.c b/builtin/backfill.c
new file mode 100644
index 00000000000..38e6aaeaa03
--- /dev/null
+++ b/builtin/backfill.c
@@ -0,0 +1,29 @@
+#include "builtin.h"
+#include "config.h"
+#include "parse-options.h"
+#include "repository.h"
+#include "object.h"
+
+static const char * const builtin_backfill_usage[] = {
+	N_("git backfill [<options>]"),
+	NULL
+};
+
+int cmd_backfill(int argc, const char **argv, const char *prefix, struct repository *repo)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(builtin_backfill_usage, options);
+
+	argc = parse_options(argc, argv, prefix, options, builtin_backfill_usage,
+			     0);
+
+	repo_config(repo, git_default_config, NULL);
+
+	die(_("not implemented"));
+
+	return 0;
+}
diff --git a/command-list.txt b/command-list.txt
index e0bb87b3b5c..c537114b468 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -60,6 +60,7 @@ git-annotate                            ancillaryinterrogators
 git-apply                               plumbingmanipulators            complete
 git-archimport                          foreignscminterface
 git-archive                             mainporcelain
+git-backfill                            mainporcelain           history
 git-bisect                              mainporcelain           info
 git-blame                               ancillaryinterrogators          complete
 git-branch                              mainporcelain           history
diff --git a/git.c b/git.c
index 2fbea24ec92..00d9b3ec8a9 100644
--- a/git.c
+++ b/git.c
@@ -509,6 +509,7 @@ static struct cmd_struct commands[] = {
 	{ "annotate", cmd_annotate, RUN_SETUP },
 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
+	{ "backfill", cmd_backfill, RUN_SETUP },
 	{ "bisect", cmd_bisect, RUN_SETUP },
 	{ "blame", cmd_blame, RUN_SETUP },
 	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
-- 
gitgitgadget

