Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F1B35973
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 00:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753144157; cv=none; b=OLg8b4xwx3b8FpcjaCFeuZ9dKQfhDMtgtX+FEPWO24+d7tkbAVRUQ0Ie55VRWCiV0P02p+3Thhp0ElM1m9ldvQbhoKQBhMvdasNTmwv2PI8AAqVUwZxsr7Y+YEhTJod5XS2qq/YL7HGpyZv8ByStPM/q78R0inzdvbpBjH35eMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753144157; c=relaxed/simple;
	bh=Mp3PndYc9eG6i4O+Vi5zOTrAER7XWMDgnzSmWFknTOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gbLDd6z0RUWTfxhpDVsnR/HtDTv/MtVg0TKcBp4ULY9e/U2CNGR3/t9JYYt9L20DFk4b4tYGfbRwTkGxNp/4qciiPIXiAUO1EH2b4v3z5bRlRtlq/F8PfYN+TT7ZN3f2CEpz2xDSUQIh8jRyN90nOxOGabF9mtwW17pdX5VEza4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFoJnXdQ; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFoJnXdQ"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4e9b26a5e45so444224137.1
        for <git@vger.kernel.org>; Mon, 21 Jul 2025 17:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753144154; x=1753748954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luV5SYmDn1r8amsUlOb58L0/+4zuNFu5xcHNdwH8aBI=;
        b=KFoJnXdQ623oLXyg42ynz/egaXPnA3Mk7z51lh/hJlFhuaTVR2OVzyCOiZyWEiEDgt
         LDdWi05ssZAT6DrwEErQftHBX53nmC0f+Fc7KIprNLfOxeKWMxSXMi46CX87esQYClR3
         odeOXE34bhAyUCy6B+HsLl4ho8zsnoSsj/USZOR4Kyzhg6bpGXzEmby4aZ5XEhZc+w15
         wYoOo4RIVkjtJzmI4QE29Dtqwc+zBTJ9C3Ml5r707pMLWIa90tHsUHaTtSY6SfR7gZRU
         dhAlcoEHtI3ISKwPRla+SKNp+DBpas7Zi3LkBw0qxmFnuV2T0qeIJbuTgLE9DRmII6Gp
         4XTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753144154; x=1753748954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=luV5SYmDn1r8amsUlOb58L0/+4zuNFu5xcHNdwH8aBI=;
        b=RkYVP9ARgu9NthEN8FpRY5XfQ4KrNuD+2tp/UNbH3ZaDUEghOklP+1YTMKCDn/Xl6d
         zDuyaya3J7mRcWIIozCBcuBunbUm1LDhd+tyCdFKjuHLQViSThJ5VVoFswmPE73VAgqI
         Gm8Ppz4v1bTTu6BNhOoR3mtnPaB02gqaMxeKWTGBlXhkaAbEXiDcGxNgnLHvvUhORqjh
         IUFcBJ0jKBZ8fP4IRntJArYHVT/u+XphOlJ60fDDdejxR82pOo5vYmlt6ATVLbwqRuD9
         CMZpamFypxKOH3tfy8XQTe/JO3sy2vc5Z0TWgf+s+5sFrlEyP+rUybS6IYAm6aEVkG4O
         LwSA==
X-Gm-Message-State: AOJu0YzcYDW0oO99l0vw1mIGFJ7wQUUMXmWXgLU68oT2rfduVrcH+ygi
	QC3jNFHHO6s5huq0uviEK1tD6IVNUvDm7MwuLYMtpxrd9cHIdNRrrbWWcbpE0A==
X-Gm-Gg: ASbGnctcdqqYU5Dc+FnSHoakBGjdsr0e56Xsj8o573Tt3/9n1c2UG9FxW/1e1gO1BhY
	P2NTgAKas8ytOxtcOsQu2VfhAtQG0AREHfx/TakNhCoOdiQXnl7/lWVfC1a+fGFvCtoU3hTVV/P
	xWQjZZE1kBNUUtItscecYP1lIt8T9s+IrtN/p5bOQ9YfW8K7hhMnlE2npt4pVVjmZJmonufZ6o0
	KuhuHTigcHR0668ZAHRwASErLYuPawxEL5jucZrH4RykSUCSr1P4sXlcU8y22CCYaHy6I/9ZJ3i
	5JVVRL6eG8gmWYc5E/MxYL3yYrFJvoRnBUZfrFchY8yR5nCxYIcI3AAnDxTxbA44/AjxoV3vGlS
	ChpimMbnNO7gqiCCgLyR8lHP4c7T3spef7kNUzfF3GdDo+TgMCgtgQWY=
X-Google-Smtp-Source: AGHT+IHDL0RIuRStAcAWWTyqFiuh715d5c/18vEdQX1FyI3gAH1GA8HGsxsxDWxRod9MXtwA389pfw==
X-Received: by 2002:a05:6102:6894:b0:4eb:2eac:aaa0 with SMTP id ada2fe7eead31-4f9ab385f20mr6603844137.19.1753144154010;
        Mon, 21 Jul 2025 17:29:14 -0700 (PDT)
Received: from localhost.localdomain ([179.113.63.169])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88b0ad603easm3344169241.16.2025.07.21.17.29.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Jul 2025 17:29:13 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: oswald.buddenhagen@gmx.de,
	ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	jltobler@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v5 1/5] repo: declare the repo command
Date: Mon, 21 Jul 2025 21:28:31 -0300
Message-Id: <20250722002835.33428-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250722002835.33428-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-1-lucasseikioshiro@gmail.com>
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
metadata and metrics), returning them in a machine readable format
following the syntax "field<LF>value<NUL>".

Also declare a subcommand for `repo` called `info`. `git repo info`
will bring the functionality of retrieving repository-related
information currently returned by `rev-parse`.

Add the required tests, documentation and build changes to enable
usage of this subcommand.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 .gitignore                  |  1 +
 Documentation/git-repo.adoc | 38 +++++++++++++++++++++++++++++++++++++
 Documentation/meson.build   |  1 +
 Makefile                    |  1 +
 builtin.h                   |  1 +
 builtin/repo.c              | 26 +++++++++++++++++++++++++
 command-list.txt            |  1 +
 git.c                       |  1 +
 meson.build                 |  1 +
 9 files changed, 71 insertions(+)
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
index 0000000000..caee7d8aef
--- /dev/null
+++ b/Documentation/git-repo.adoc
@@ -0,0 +1,38 @@
+git-repo(1)
+===========
+
+NAME
+----
+git-repo - Retrieve information about a repository
+
+SYNOPSIS
+--------
+[synopsis]
+git repo info [<key>...]
+
+DESCRIPTION
+-----------
+This command retrieve repository level information.
+
+THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
+
+COMMANDS
+--------
+info [<key>...]::
+	Retrieve metadata-related information about the current repository. Only
+	the requested data will be returned based on their keys (see "INFO KEYS"
+	section below).
+
+INFO KEYS
+---------
+
+The set of data that `git repo` can return is grouped into the following
+categories:
+
+SEE ALSO
+--------
+linkgit:git-rev-parse[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index 2fe1a1369d..1ebdd57789 100644
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
index 0000000000..d4f01e35e2
--- /dev/null
+++ b/builtin/repo.c
@@ -0,0 +1,26 @@
+#include "builtin.h"
+#include "parse-options.h"
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
+	const char *const repo_usage[] = {
+		"git repo info [<key>...]",
+		NULL
+	};
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
index 9579377f3d..15d3e3701f 100644
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

