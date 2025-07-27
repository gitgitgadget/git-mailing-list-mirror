Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6805221286
	for <git@vger.kernel.org>; Sun, 27 Jul 2025 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753638708; cv=none; b=A+3TFKIYAeOH8vOxZzN9sUOuZqlFCxZ0ru7fFHtcIGVciZst9EJ4K4Mfb1hcyZgQhZd8boSgNCxgFkyqElD8bgr1XGEWOO5r6jT1jVH5q1tFcNjF7LcSIuhColygiqnu18KfGPJP7J564j+qi67noNscUEdGxhJnwbDlnx5n5AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753638708; c=relaxed/simple;
	bh=XE/5GEm/PShxK6GTvP1c3HS8i45laHqnQOJMMKbrKPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lTSjRPyhg37WcayvBTB9UQJYYQFIlI06197MgeA4+b4g8IraI4pMDciHMF2FAtZ+Unq3yakIF4EDkfQfQeR5IPmZ3q6SluA4gBj6QhoyHO22pAeRxVJoMqYvk0q57Z8TgaLgiUPL/QCkYXPNvoLeGGqI62VQpP1pqFQ3PrHmid4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQvJ5ABc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQvJ5ABc"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7600271f3e9so3159990b3a.0
        for <git@vger.kernel.org>; Sun, 27 Jul 2025 10:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753638704; x=1754243504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZT3LbfcjZ5RDs+el6KtB+ugXrrZn9//F68rcyj/pyw=;
        b=PQvJ5ABcQbzESLoYSHBYLYjDVjBQphWyKXs8QHbPiSe6cY7uw29ezCe89S716IjFxe
         fOtNXmh6IwazJc+DIkAJcEpKpaCCFYppMZLhdQzIlww8Idm0OvRKOQ1uxHjQ9vsN1YUg
         GcjSpfHB2GMFF0KcHMcxJbGfyPPftZl9G7kFa1IlaKqBgt22b3bJ8i+7JrlSgESQjRVk
         //+K652uFPOJVYTePIuepchl9vPO78UB+HNiDXqPc92FnUh6qAzAIxzI+3Dom+eDJtlZ
         vlNT4xkeu3VtlHKXIXzehANpNGt/gRd3tPl5qQgJ8cEK/BRpluLETdNGZTrmYEdekTtI
         n4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753638704; x=1754243504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZT3LbfcjZ5RDs+el6KtB+ugXrrZn9//F68rcyj/pyw=;
        b=luh1TlXvNjGr20ve8nVSqvn11IQ9Vp1Od4nItyYkbJxveqX18jtv3lwBSGaItexi4a
         8rqiB595cbijGI+hQr6XpCoAQVM7M7ey4JwmU2mmrFSLuCMm9QsR8AtmFYb7JrOvifos
         06HasqUAAsUJiR/f4hL0KQsLBjKT/5RuctCDXhVvhMu3TO1X3rWi/RDfjZw9Ws3sum2e
         GYHO7LEzXthZeRqTKKW4kmiQF76XmsI3W/BoGXPqp/UgD+rgDJL+HxBubnSF61RhqRsf
         dEgrO1OnJTXhjeaY/Ab1pxZb8T8UZeegmhyNcjglATMKG/HbHpnGdXwEpmMGd7tAa5FY
         5irw==
X-Gm-Message-State: AOJu0YzqQqf10db0VWRYV7CggYAwGitIqf1/W+tqMkA0h4vVYz1lWmV3
	Ptld3tCANlUQ3e3MJmtNge2Rluld/hjf5PAqBL7CjMPFi+sf/dPmUX9kDWuRvQ==
X-Gm-Gg: ASbGncuRl8C2FarZ5JV/rjVG9xdM9rXCI+kQqNBgFlckPpg4K2myg0GHKx3rWBqgjws
	hZaYGBauPlk2gkLrFBY/7uCBNWdAcLKwNI/zxTik3dBnQhBsbz4j0emOC7KZja86vvL2XpzlWIS
	qWr1uO0+VZ7ktfK8p72CCWVb+YKNDV8nvU1M1pYPQ7tgBX2Fncy92VMtZ7IF5IItVQXja7xbZx3
	koC+oy/7rhkli/AXKVXRtvGN45Gt14pTMkj6O9+Wii8MY08QxmvF/cPIyeA4Yv0Wq1t8uDRyV4f
	06SuXOITxhbEA5xkaFHYloRwD82eZ3QZqQhox8mzNUrvt0qJZXo5Lqg8kheJXdRnpkjIjbaA1B5
	7zOWXBa6VQF2AedfRqO/3pSCFE5k/LqcmDVCR4vmRVt1XS4PeZKHxpI6wzDjqSPWAyQQzxESj8t
	h+c3iKxb/m8sx3owfIAc9TJg==
X-Google-Smtp-Source: AGHT+IGzvypt2e+7OgVTg8mKsuXZHC7wYrEtsYHtrDo2hbQOR85j1OdlhDxwNun3uu7vCmSjRvYAWw==
X-Received: by 2002:a05:6a20:2585:b0:232:f6bd:7649 with SMTP id adf61e73a8af0-23d5b5ba3acmr24251307637.7.1753638703575;
        Sun, 27 Jul 2025 10:51:43 -0700 (PDT)
Received: from localhost.localdomain (201-1-210-243.dsl.telesp.net.br. [201.1.210.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f58bec0sm3392488a12.17.2025.07.27.10.51.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Jul 2025 10:51:43 -0700 (PDT)
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
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v5 1/5] repo: declare the repo command
Date: Sun, 27 Jul 2025 14:51:06 -0300
Message-Id: <20250727175110.84770-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250727175110.84770-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250727175110.84770-1-lucasseikioshiro@gmail.com>
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
index 0000000000..aca76b131b
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
+`info [<key>...]`::
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

