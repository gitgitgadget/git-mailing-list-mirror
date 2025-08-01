Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ACE248F7A
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754053888; cv=none; b=nQxUvEStMxfggjz6MEHfy+/qQZy8iCAGIRf8R/RehvIo7ycyrt1FCnIwujgLzZQJv00i8omHwh7vOHS0aRpyIaMJGR5cRBt+ZPELXjZA+WD5TapoeMdE0eghluPQHqMb67pvilVeqjqhHZG2/A0by071QmcvDLRCQvHeJd5vUEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754053888; c=relaxed/simple;
	bh=uFmvYduQqZC/ySomJ4ccuBPfAxmrVYCuhdnQz4O0bsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PzzqucjhYnmZ6n2M5MhP7gKbqQmrXi/1shu3e3wWtC3fsdyQsn6bmdaNqXpZGD/V9vyurizT3ENM58mgiD197hIA2eCE9KATT8/sTb1Awb5OguUBFcxspd75GgisiyIK6xTO51iYvOeAWKpsnvYSXYVXiqfYBGIK//fik0V0lnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OH50E8XS; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OH50E8XS"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76bd202ef81so1996961b3a.3
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 06:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754053885; x=1754658685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GW16YC6borsBHZm4PHzxLwl1mRwYAe+M7/8sljk2eM=;
        b=OH50E8XSBreIXk/tSGtgx4xyTk0YPnvKmtBzxojnHpSAe8A3hFUaZZo+1EEu+zmCYb
         9j8HWweAKFhkEk/FcvWzWBRnwbN5yhzQGU3Pjh/WBXpirO/S9YGC7JdObZtQMmlk+Q9l
         d+6wNt8gKDkL79kvFR+r2SwS+SibTiG/BX2m1mDBTuevJlnrZfrt8MYSp5kuhx1G+rHM
         00SOUcbQYVn/RpHulvq8Fkq2GaVXNNtmLox/EOd7QAVPQwTqivVNbBfIdo3GpO6RO3Zi
         V/UYSEAOHndphWIqNEeeaa6M83+ZCvNyGR2Z4jyWU/Tdmo+XvCXFf18OsRa0Ol8u6Qqk
         So3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754053885; x=1754658685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GW16YC6borsBHZm4PHzxLwl1mRwYAe+M7/8sljk2eM=;
        b=RJe/Rkp/T+KRlT1SeJtE1Z9LMsvIFuU2UiEqW4gmK6VNqIGzZhiAHLw0sJWD8Onvm+
         jZsYuZbM5WuB4p5bn2iByCNoMKzd9knrJ697Sta5FW5L9Woo4ihAMcvIP59760uUz3tT
         AdHjVV/AXZCQ8V+zgwkm70w/4Zc0GOd6MGj1+wgkPAZwrukFebRWfYMnsv3fpyG1uxgq
         e4pRaTv8nh9ZVV1Kc/ttrmNn9r5mbATzrlC4KJSObtBPKEhbOXkk4I2mHDXttSb01zoy
         4EE003KrunMN6ylCSVNYkTtUtKqGXVqMVU41U6jhCUZwscvdTaSY8fFkmxArdZd8e/vT
         wXEA==
X-Gm-Message-State: AOJu0Yz5ogz/HYghQrtFVInj5W8DVo7Qdth1ZwHi8oJXLtvZTIxUCEgt
	1Scfpb+pBypxC9Nve1cdDV6oyAFqRyIadd/eFONHhhPgvILW5CO5UleWtuAMxGQB
X-Gm-Gg: ASbGncuo6OaSwGu8qVZSBOdZsSSXdmEntBkFOrfCx88GyTdd0oBha29H01Ro8A+rF6F
	rNa1DyX1P6DRWzs9Rk9KUOkZ0ojs7QkKDq2cwLojLgfVcDenxi0znoEXnstmtvVI10DJIQZSFDv
	5SV4x19J73nWvHIKEdsZc8uaVFSUuyjUVHqxVD95zWkN2SMg+SW32R8F6OcvM/tfMPjyG9mfXB7
	Dyi8VkwoLm1Dl5/5XVrJf6QqDANt5v3ad6SnyumgIJdhnjVaTBiMR6QPH6vdHSB3pxJsi1yaslE
	5WnQQkSXFV1Vz7qWvvd180NKlEGb8n1+6MWQSJ3Qj5hzpWVdnK4gaG7w5GZxgNezsN3pHjLtAvC
	t0hcRkvyEHAqXQDGIfhtz9HpI6BNCfxxKbeNQVogdF5N8Ypol3ZytMVfqfI1L7GnwIQ==
X-Google-Smtp-Source: AGHT+IHKLpCkWttdExXcz7NoffMmDeJHIdy/BDiHB8Ap2gvlSp+gqL2cKYE8LNVIi3g/qnJjDnxW1A==
X-Received: by 2002:a05:6a20:7484:b0:23d:61eb:51c2 with SMTP id adf61e73a8af0-23dc0d910camr16146919637.12.1754053885541;
        Fri, 01 Aug 2025 06:11:25 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:8c1d:878:ec5d:4583:4785])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7e4fc1sm3542272a12.28.2025.08.01.06.11.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 01 Aug 2025 06:11:25 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: oswald.buddenhagen@gmx.de,
	ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	jltobler@gmail.com,
	jn.avila@free.fr,
	sunshine@sunshineco.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v7 1/5] repo: declare the repo command
Date: Fri,  1 Aug 2025 10:11:06 -0300
Message-Id: <20250801131111.8115-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250801131111.8115-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250801131111.8115-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, `git rev-parse` covers a wide range of functionality not
directly related to parsing revisions, as its name suggests. Over time,
many features like parsing datestrings, options, paths, and others
were added to it because there wasn't a more appropriate command
to place them.

Create a new Git command called `repo`. `git repo` will be the main
command for obtaining the information about a repository (such as
metadata and metrics).

Also declare a subcommand for `repo` called `info`. `git repo info`
will bring the functionality of retrieving repository-related
information currently returned by `rev-parse`.

Add the required documentation and build changes to enable usage of
this subcommand.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Justin Tobler <jltobler@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 .gitignore                  |  1 +
 Documentation/git-repo.adoc | 32 ++++++++++++++++++++++++++++++++
 Documentation/meson.build   |  1 +
 Makefile                    |  1 +
 builtin.h                   |  1 +
 builtin/repo.c              | 27 +++++++++++++++++++++++++++
 command-list.txt            |  1 +
 git.c                       |  1 +
 meson.build                 |  1 +
 9 files changed, 66 insertions(+)
 create mode 100644 Documentation/git-repo.adoc
 create mode 100644 builtin/repo.c

diff --git a/.gitignore b/.gitignore
index 04c444404e..1803023427 100644
--- a/.gitignore
+++ b/.gitignore
@@ -139,6 +139,7 @@
 /git-repack
 /git-replace
 /git-replay
+/git-repo
 /git-request-pull
 /git-rerere
 /git-reset
diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
new file mode 100644
index 0000000000..68c706f5a0
--- /dev/null
+++ b/Documentation/git-repo.adoc
@@ -0,0 +1,32 @@
+git-repo(1)
+===========
+
+NAME
+----
+git-repo - Retrieve information about the repository
+
+SYNOPSIS
+--------
+[synopsis]
+git repo info [<key>...]
+
+DESCRIPTION
+-----------
+Retrieve information about the repository.
+
+THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
+
+COMMANDS
+--------
+`info [<key>...]`::
+	Retrieve metadata-related information about the current repository. Only
+	the requested data will be returned based on their keys (see "INFO KEYS"
+	section below).
+
+SEE ALSO
+--------
+linkgit:git-rev-parse[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index 4404c623f0..41f43e0336 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -116,6 +116,7 @@ manpages = {
   'git-repack.adoc' : 1,
   'git-replace.adoc' : 1,
   'git-replay.adoc' : 1,
+  'git-repo.adoc' : 1,
   'git-request-pull.adoc' : 1,
   'git-rerere.adoc' : 1,
   'git-reset.adoc' : 1,
diff --git a/Makefile b/Makefile
index 5f7dd79dfa..9dce446309 100644
--- a/Makefile
+++ b/Makefile
@@ -1306,6 +1306,7 @@ BUILTIN_OBJS += builtin/remote.o
 BUILTIN_OBJS += builtin/repack.o
 BUILTIN_OBJS += builtin/replace.o
 BUILTIN_OBJS += builtin/replay.o
+BUILTIN_OBJS += builtin/repo.o
 BUILTIN_OBJS += builtin/rerere.o
 BUILTIN_OBJS += builtin/reset.o
 BUILTIN_OBJS += builtin/rev-list.o
diff --git a/builtin.h b/builtin.h
index bff13e3069..e6458e6fb9 100644
--- a/builtin.h
+++ b/builtin.h
@@ -216,6 +216,7 @@ int cmd_remote_ext(int argc, const char **argv, const char *prefix, struct repos
 int cmd_remote_fd(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_repack(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_replay(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_repo(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_rerere(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_reset(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_restore(int argc, const char **argv, const char *prefix, struct repository *repo);
diff --git a/builtin/repo.c b/builtin/repo.c
new file mode 100644
index 0000000000..fd2a9b4216
--- /dev/null
+++ b/builtin/repo.c
@@ -0,0 +1,27 @@
+#include "builtin.h"
+#include "parse-options.h"
+
+static const char *const repo_usage[] = {
+	"git repo info [<key>...]",
+	NULL
+};
+
+static int repo_info(int argc UNUSED, const char **argv UNUSED,
+		     const char *prefix UNUSED, struct repository *repo UNUSED)
+{
+	return 0;
+}
+
+int cmd_repo(int argc, const char **argv, const char *prefix,
+	     struct repository *repo)
+{
+	parse_opt_subcommand_fn *fn = NULL;
+	struct option options[] = {
+		OPT_SUBCOMMAND("info", &fn, repo_info),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
+
+	return fn(argc, argv, prefix, repo);
+}
diff --git a/command-list.txt b/command-list.txt
index b7ade3ab9f..1b0bdee00d 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -164,6 +164,7 @@ git-remote                              ancillarymanipulators           complete
 git-repack                              ancillarymanipulators           complete
 git-replace                             ancillarymanipulators           complete
 git-replay                              plumbingmanipulators
+git-repo                                plumbinginterrogators
 git-request-pull                        foreignscminterface             complete
 git-rerere                              ancillaryinterrogators
 git-reset                               mainporcelain           history
diff --git a/git.c b/git.c
index 07a5fe39fb..8290d8b8c8 100644
--- a/git.c
+++ b/git.c
@@ -611,6 +611,7 @@ static struct cmd_struct commands[] = {
 	{ "repack", cmd_repack, RUN_SETUP },
 	{ "replace", cmd_replace, RUN_SETUP },
 	{ "replay", cmd_replay, RUN_SETUP },
+	{ "repo", cmd_repo, RUN_SETUP },
 	{ "rerere", cmd_rerere, RUN_SETUP },
 	{ "reset", cmd_reset, RUN_SETUP },
 	{ "restore", cmd_restore, RUN_SETUP | NEED_WORK_TREE },
diff --git a/meson.build b/meson.build
index 9bc1826cb6..8819b64f93 100644
--- a/meson.build
+++ b/meson.build
@@ -645,6 +645,7 @@ builtin_sources = [
   'builtin/repack.c',
   'builtin/replace.c',
   'builtin/replay.c',
+  'builtin/repo.c',
   'builtin/rerere.c',
   'builtin/reset.c',
   'builtin/rev-list.c',
-- 
2.39.5 (Apple Git-154)

