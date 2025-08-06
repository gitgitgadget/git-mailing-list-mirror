Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4FE1DF74F
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 19:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510163; cv=none; b=DVaCAzIrtj96k8sp0B5sNFHROrSYbXj5BTaCt1YeJ+TSMAP0RhPEX57AmWcCowQ87XvMyABlpotKnOV/BLG1vqV1pOnUSGQ66cQMxwMZcCs73rReWi3jLkUUJ7PYxbbLpmq5ENGVTRFDOUciqVpqQT5EWcM2ePB1d8iZpw3N51c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510163; c=relaxed/simple;
	bh=wvClg+WRCLLxUp55dWLwWW7AJGyFP+BGnw/Uuqa3KVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SPXSW4rzHkFSKsFMDFHZCoPlmMBH1lCyaAzy5UJLvD0N2ufBBaQF1kWndj1w1xDRCaWGwX1usPn608uQounUlFMR8aUyhwu1292IjdYAeVe1xuHk+8Vv0rK9ykYr0Fl3WSXVbkyNQcfnnHAw1n6Iu0wD5RHdvfmT5ZEy67oCL5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4Di6gQE; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4Di6gQE"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76858e9e48aso328004b3a.2
        for <git@vger.kernel.org>; Wed, 06 Aug 2025 12:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754510161; x=1755114961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmdKslSkemJZT1zT2CS2vDgkEnYmH9VeGghTnXuqmRk=;
        b=a4Di6gQEgQp2dw4fRZxP6ge4CMBZWAaaU7cZYuR9umHONoKxZLbP1jF7LHMrgaUVIO
         MF29EQlqxIk8a//jrymbqTvQ95JbvhEdD3xS0WRypJFdLIDsNMRit13kEFFiOZ2x36SC
         QHoWOuBI8s+7n6ya6u6HftC9liZ0OUqWKmbyFBKNgyNzKYXXnMgtIy+ibiVPSQLlfkh7
         pDQy1nPhnC0oxBLfv8ynXQ2iI07MT2ZjnZRg4BpJScAvQOlCdAMtSpPzOgsC4nKSps2B
         ft+y/m7zkvq+1e8gUV/WncOWZWmlGNSHBJHGMYwvXN0sDKMORbAI61JFQ00x+U39dhTD
         jhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510161; x=1755114961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmdKslSkemJZT1zT2CS2vDgkEnYmH9VeGghTnXuqmRk=;
        b=nOrgqa7ZLZ/m+egTvjXH8D6hjDHsuU7Xf9GnFZJmkrmxM++H0OV/ivG7S0jNiRerxv
         5gsJ7FZsP+0cyvZjgGbL1XbVbqkYVdBdkfQaGIJpjXomqlXa8dEEw4RCj6HwmVR2uZFk
         5wSNHzake1d0vOcbWqowEXJUGkeh/v6hJ9FAcU0T7PGxonYz6N34xDwHLtk5XqcHoefx
         AjzjMG7a+gGtFLhIoPil68mdJsBhfxuM6lyUau3cKWeue9QXjvzU1PZlaJPU6je1NE/d
         MhbWs0aLhMx8ieaLx7w3/rAc4mSDZa68XPyig5SGmE2TroOF669Rkf0JZsrB2bdnpXmz
         YYHg==
X-Gm-Message-State: AOJu0YyxhLVDRoohYQ3ERQShWl7Ar/KzeoBShIO8faT5SmCoOxDifD2r
	+GrhO0GndPuLwsAlDL2hgcRBl8JiIgxvj71ytrtbnQA1dG6R2RfVEb0mI0XPpIYx
X-Gm-Gg: ASbGncvrtwPu4N1ND7OUSctn6a2cVpBNEVtvvFOfRSs/BdXD9LOYXUQD0tDt1rLYJ82
	281+h2NraGJUb9GmL7ooOX68oPrT6Gs8s3V+/HNtTADRmXPGgXHFq5TcTYdeYdHlbcBlsTv5AQW
	+DxPjr0SFaIh5bO4Hm2RK5g7qNZyp21TPlbwGXlVCX/wLWB7xylFz/n7y+xExLwpbQdE9jlUMfo
	/SMr568JGnOceIiwFe8inlComrPyLCSZ/hrTEWBzGHWvD8WvXumcgidt4JiZQ8NCO+ctLWG7rkz
	N+Kt7v0koboU1EHoJ6bIKgmMtdvMZOFRusqIuWcahEWgy1UjV3RAs5BgsKwX/RDN04dYvIpnXli
	QJpWeAKhUuycWJwVnfZ3C5T4Mi1IK1MhB1+0OzRrWGPhp9G6P7ooHcJEne0PJgkQ=
X-Google-Smtp-Source: AGHT+IH52PAqP0yDALCkzFlags28VMFKXZJoTH358Yu/gfPrwnbk8BFKehElNgZj/zqC+QD0bMMeHg==
X-Received: by 2002:a05:6a00:124e:b0:76b:ffd1:7722 with SMTP id d2e1a72fcca58-76c2a93df78mr5365205b3a.24.1754510161071;
        Wed, 06 Aug 2025 12:56:01 -0700 (PDT)
Received: from localhost.localdomain (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd026dsm16212400b3a.95.2025.08.06.12.55.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Aug 2025 12:56:00 -0700 (PDT)
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
Subject: [GSoC PATCH v8 1/5] repo: declare the repo command
Date: Wed,  6 Aug 2025 16:55:33 -0300
Message-Id: <20250806195537.93302-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250806195537.93302-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250806195537.93302-1-lucasseikioshiro@gmail.com>
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

