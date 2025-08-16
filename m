Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA33317713
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755384398; cv=none; b=ZuI/U9OsTgC/4mgA0atbi4Cb6tqPORQVUq1PGeA0f+loVGgtE2BlYGTzKEe00mI2r/WF4dzWRTGGLeRS688rBdnacCx9734IjJA3qFX8D+VFZlWXDYTIIaDah8HLQObOlY2ZOEG/VAvwnC7mbK38uf9fU4hcLFtVNMTmYd+pJcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755384398; c=relaxed/simple;
	bh=wvClg+WRCLLxUp55dWLwWW7AJGyFP+BGnw/Uuqa3KVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gOgjucmFs5anIN6n9KQlSyTNG3JvvIkYmmyeLVvhDeMvCN12+3AvMM4Fu28x3nrWjGXRC/JoWLPi29GS2cMKVCVg09vLqMDBNiWdW570eUUwZ1c05xy9yagg7bntc1XQK8OaxKyzXhavMkYE8lnlHZryrZzZq+PnzwLJ31GjESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlH+zEF2; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlH+zEF2"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-323267bc0a8so4019925a91.1
        for <git@vger.kernel.org>; Sat, 16 Aug 2025 15:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755384394; x=1755989194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmdKslSkemJZT1zT2CS2vDgkEnYmH9VeGghTnXuqmRk=;
        b=AlH+zEF2q7+3T0uiRAM90KaX6hfqyH5OBWzBXfnaU7QK/3BC4Nik1lXYkGrY+8hpdE
         c3yOzOToz5f7ppsBcLKadKY+ZbxW5fle1R6rbJL3z3ipcsX7U57bTfPn5+2t69X1a6fO
         7zz40GGaos+BmaqISXdsqbVxDjr2mwI1zwf1IaOdJ9rFySMJsdY0EzR3rJP9mEM2xzHr
         JIumHj1/6cggfh+JCc8qRg1h8Y1MAndWNPL/QP9jQ6fdmRYzaOdF6pbW9kDzmETIbjWW
         s7lB+WtzgEuH9m0+YMWsBReoyLpZtwdAcmAqlV3IhttCwt3yHn6y1XB2ZOYS0gxpfHs2
         8bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755384394; x=1755989194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmdKslSkemJZT1zT2CS2vDgkEnYmH9VeGghTnXuqmRk=;
        b=lY2lbwTKDWVGJ6UPZxR5Lx3YScB8ozAW0z44mVE3YoIhCiTSVbdWygFxvUSdx8DbKr
         oRzJ0KvnL0lN4VwO/BpqrG1CHWccdZ42VuPeynfo+oKqG8j+Fr5Eim7qRGDFV5BsOnqu
         YOdr3q1Z1A9M7JQirLVLjTiVCipntad50a2eu8LqAl8GV1aJX++3H87Fol45LhRFL8uW
         l1qvJrip/KJjBhE7fTBSinw8Sb/AkMVKydCAWeWeAka9L5jaoffx4JChkW6Z7uuMPH/Q
         idXJjF/i+uIeAoQSlzwefi3xXbjDiEaCYHePI5hebaq3i90aAHE/4LMsPGbsWcuBqYRD
         iM/A==
X-Gm-Message-State: AOJu0YymGtIE3Mml8KLaJSV77aePkER8Tg5tVXVHz0U8bb5ZPny+pApe
	kUJOlorkJ1HaZ2DlTWy7FKs3bDUXLgBA+9VKpiXo6nyN/VZuQHGgh2MRBpxJ+Q==
X-Gm-Gg: ASbGnct/hOIzj/+LAawYMZJWOlBe/mE385wxVLzzjr2QzIdvC4F48JiZFoAE8L6rptD
	bCqucgiwbO9wbWKiMMhnEaB3ertixtSSHwRaclBCmmHkfte+nW/zh9Yv+3sFhHNx+djSY8SsIFC
	IOi3qzCfsFF8I2VbbV6z//TbVol0PI9T86qxWlODrDEIKJjZuHsMcOWpNt1+DICvF/3jCp8tZrg
	Gm5Yjw7RQ1J6YrS0cGNDr8IvPj+hmdYKjUjcn5EivC5vurzMneP3HE8fRaNe62AntPgV2z1Z8Hx
	tPzu3/svE37VVqvHmwPzIW+UFsgoRlwkDao8gfIQDMRMj0XCeyNLNRHHyKu9a080de+LG30mrdc
	XzadQfVTME/b0mmTRLrV2JRk6uMxBMtBowZqzcd32dW3wYmUtx70Qlmr2Uz3Q6Q==
X-Google-Smtp-Source: AGHT+IGBDW7H3ShuUbVcdYyyHr2kvTAxyL4gY0Im5WyQO/Zk+dMXlrZwkJFb3MCGYlVjyewqXA3/eQ==
X-Received: by 2002:a17:90b:3d92:b0:321:9549:66cf with SMTP id 98e67ed59e1d1-32341e0e960mr10054604a91.12.1755384393897;
        Sat, 16 Aug 2025 15:46:33 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:8e83:e855:1cad:1392:e988])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d5ad0f7sm4617280a12.2.2025.08.16.15.46.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 16 Aug 2025 15:46:33 -0700 (PDT)
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
Subject: [GSoC PATCH v11 1/5] repo: declare the repo command
Date: Sat, 16 Aug 2025 19:45:59 -0300
Message-Id: <20250816224603.3307-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250816224603.3307-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250816224603.3307-1-lucasseikioshiro@gmail.com>
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
index e11340c1ae..ec7ac58980 100644
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
index 83eac0aeab..d4ff4d5517 100644
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
index 5dd299b496..e8ec0eca16 100644
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

