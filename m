Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8250242D7F
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 23:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751844012; cv=none; b=tpoY42+jQZywWJyVAVC1t8M/awi+UrP1dCxJPzRKhNDGOcPrEIly7GlkrsQXo+D80eXDlsyKVwdsb0TNPgUt/KrUTPE+tkNL2P+G/1Pkjt9Kt52qwIry/iTDndj/LFvq/J1595KYArvDYjCWkhMR+Kfk06jT4WxdOR97/AFA1BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751844012; c=relaxed/simple;
	bh=uoP6gykkIjpfFaWanSsHl9JSasAH0aDOvcBXT+UTw5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PnYpIzeYG2mKOxIaeZtBvC3+CgEiFzzYv8aIvSk5otCwyBBXQngytfROW66/iiCFq8zFnC3arXHXKlpOoMSBJrbaS7+ywfxpC89FJbOVobOuokzQCpD6kR/BT5TnkZLOCHenczz/96OtI/nwFJ33JDtYn2Nyo8bljoy7YFA1NHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MP4JKhFd; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MP4JKhFd"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6fafb6899c2so29647776d6.0
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 16:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751844009; x=1752448809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2ImCxuvbSNNVDM3UZsHgmC0AIDDgFRWSOjnBo1cZTQ=;
        b=MP4JKhFdL/N0cjzTsF8v0ypBTLc+Rq0InKOLIenv++gvwRxj0mCJfMoOra/GfF03Ei
         yRXIUGWB5tvhTw24uA7jqWeZ3vMaAx1flbfQ174I7uPRgRAs6+Wpz4IAlyoIgQWy+2Ua
         F/etIFg9azbkFwbeynRzNxdY/KpCqtIz2qqZWDSo+lLZ1ihQvJ5qkgl5XN6hoHsdExZ6
         I6hulHQuHStkicv9kOHG7eF75Ejyc7rBNPTfimEcvL0kUiC4aHoNW4VwCn/R3TH38xe/
         8vsZOYd3r1vCovOajWG/8+ebdZdFgdvui8Ndl3g+s3JY9agcIwUocfTg8TkQUrdi2a0A
         VtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751844010; x=1752448810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2ImCxuvbSNNVDM3UZsHgmC0AIDDgFRWSOjnBo1cZTQ=;
        b=GaT20Nt9xUKdqlakjU1tqfVhNxyucawM6DmCBqxlq8J7rbJ/WyhHzmsqDYQ3G0cDZx
         GWrjkIsXeAovPPO05EgOztA3uOqyYBtumb/I8hKotEkHvudj/xceCrGfsRVQIUcO8Myy
         JYB7coqbXcmY/afIdihVy9aTDIkF5fjh1Ty5iNbp1JW8Xhxa6s6EQz7OpKO59zMav5El
         olaAag12mlfFZR2HcZjo8pyF7Ft+yUWwMuZD3CMPH1xSuxQ0NcMbsaXlpnUHJWh7sFC+
         AncUphV0OQR9JhhosifPA+a8mH2xvERCxXcgXia2ya5HiktXs84xrHnnW3l805602eIU
         HJiQ==
X-Gm-Message-State: AOJu0YxAot/U1DzYgjLHExwfRuxuNzDl+/nPS1GPye7uo+6QGNH5yj5P
	tIMEAl8KZH17BnWEL/vD2rLzoQ5DFJABhrMeW1YhS8ld0qpZbvl3rJiFbUKG3g==
X-Gm-Gg: ASbGncu3rYpY33sNmnpAbYUIsXCFzmhN1+x4EwWVpoOB7JC5ixekyl0CH+PaXVLi2af
	+TzeyaCLAZB4HpXnNwBHN5SsCEF8fZfq5e2vNZdsKS6BNkK88/iQc9W5GmT/n2I7Smd4uBwa1C2
	DZpFphY0j70A+FM2QfEfYbu/tTiQgdmuba4/Ka3D00rFBNw5uQq+QXj93Q5ITG35vwd3m/7Zlw/
	2O5iSpall/OlNl9BANjIVd/DGRpxJqgRiN6wHW89QRzGvIphrrPxrCbbH+tPBouxJhymywCIROm
	YQfVkspIxV6AXWt6UWyHg08LGyWwOa3N0XFfttfRWi9sJYwUe9uH/M5iaGYNzxT4L+rkn1cVG7T
	9H+3SGa+EKcnPKOsZSGkZfDOJPg==
X-Google-Smtp-Source: AGHT+IF0whuQI3z7j0atW7ZmOyVZYe5AipZ9oSneNiQD+jbMdtu/PJl0lJNsuGuRKNS8H5FomAyb2Q==
X-Received: by 2002:ad4:54c5:0:b0:702:d756:8a05 with SMTP id 6a1803df08f44-702d7569129mr51993966d6.16.1751844009561;
        Sun, 06 Jul 2025 16:20:09 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:934a:8cb5:107d:e42b:6887])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d50947sm49891716d6.78.2025.07.06.16.20.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 06 Jul 2025 16:20:09 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC RFC PATCH v3 1/5] repo-info: declare the repo-info command
Date: Sun,  6 Jul 2025 20:19:34 -0300
Message-Id: <20250706231938.16113-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250706231938.16113-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250706231938.16113-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, `git rev-parse` covers a wide range of functionality not
directly related to parsing revisions, as its name says. Over time,
many features like parsing datestrings, options, paths, and others
were added to it because there wasn't a more appropriated command
to place them.

Create a new Git subcommand called `repo-info`. `git repo-info` will
bring the functionality of retrieving repository-related information
currently returned by `rev-parse`, displaying them in
machine-readable formats (JSON or a null-terminated format).

Also add entries for this new command in:

- the build files (Makefile, meson.build, Documentation/meson.build)
- builtin.h
- git.c
- .gitignore
- command-list.txt
- Documentation

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 .gitignore                       |  1 +
 Documentation/git-repo-info.adoc | 45 ++++++++++++++++++++++++++++++++
 Documentation/meson.build        |  1 +
 Makefile                         |  1 +
 builtin.h                        |  1 +
 builtin/repo-info.c              | 21 +++++++++++++++
 command-list.txt                 |  1 +
 git.c                            |  1 +
 meson.build                      |  1 +
 9 files changed, 73 insertions(+)
 create mode 100644 Documentation/git-repo-info.adoc
 create mode 100644 builtin/repo-info.c

diff --git a/.gitignore b/.gitignore
index 04c444404e..b2f3fb0047 100644
--- a/.gitignore
+++ b/.gitignore
@@ -139,6 +139,7 @@
 /git-repack
 /git-replace
 /git-replay
+/git-repo-info
 /git-request-pull
 /git-rerere
 /git-reset
diff --git a/Documentation/git-repo-info.adoc b/Documentation/git-repo-info.adoc
new file mode 100644
index 0000000000..d5f34fc46e
--- /dev/null
+++ b/Documentation/git-repo-info.adoc
@@ -0,0 +1,45 @@
+git-repo-info(1)
+================
+
+NAME
+----
+git-repo-info - Retrieve information about a repository
+
+SYNOPSIS
+--------
+[synopsis]
+git repo-info
+
+DESCRIPTION
+-----------
+Retrieve information about the current repository in a machine-readable format.
+
+`git repo-info` will be the primary tool to query repository-specific
+information, which currently can also be done by calling `git rev-parse` (see
+linkgit:git-rev-parse[1]). `git repo-info` doesn't query information unrelated
+to the current repository or that is already retrieved by a specialized command,
+for example, `git config` (see linkgit:git-config[1]) or `git var` (see
+linkgit:git-var[1]).
+
+THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
+
+OPTIONS
+-------
+
+`<key>`::
+Key of the value that will be retrieved. It should be in the format
+`<category>.<field>`. See the "CATEGORIES AND FIELDS" section below.
+
+CATEGORIES AND FIELDS
+---------------------
+
+The set of data that `git repo-info` can return is divided into
+categories. Each category is composed by one or more fields.
+
+SEE ALSO
+--------
+linkgit:git-rev-parse[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index 2fe1a1369d..1369523741 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -116,6 +116,7 @@ manpages = {
   'git-repack.adoc' : 1,
   'git-replace.adoc' : 1,
   'git-replay.adoc' : 1,
+  'git-repo-info.adoc' : 1,
   'git-request-pull.adoc' : 1,
   'git-rerere.adoc' : 1,
   'git-reset.adoc' : 1,
diff --git a/Makefile b/Makefile
index 70d1543b6b..50e3a3cbcc 100644
--- a/Makefile
+++ b/Makefile
@@ -1308,6 +1308,7 @@ BUILTIN_OBJS += builtin/remote.o
 BUILTIN_OBJS += builtin/repack.o
 BUILTIN_OBJS += builtin/replace.o
 BUILTIN_OBJS += builtin/replay.o
+BUILTIN_OBJS += builtin/repo-info.o
 BUILTIN_OBJS += builtin/rerere.o
 BUILTIN_OBJS += builtin/reset.o
 BUILTIN_OBJS += builtin/rev-list.o
diff --git a/builtin.h b/builtin.h
index bff13e3069..cc6bc95962 100644
--- a/builtin.h
+++ b/builtin.h
@@ -216,6 +216,7 @@ int cmd_remote_ext(int argc, const char **argv, const char *prefix, struct repos
 int cmd_remote_fd(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_repack(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_replay(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_repo_info(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_rerere(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_reset(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_restore(int argc, const char **argv, const char *prefix, struct repository *repo);
diff --git a/builtin/repo-info.c b/builtin/repo-info.c
new file mode 100644
index 0000000000..0180c89908
--- /dev/null
+++ b/builtin/repo-info.c
@@ -0,0 +1,21 @@
+#include "builtin.h"
+#include "parse-options.h"
+
+int cmd_repo_info(int argc,
+		  const char **argv,
+		  const char *prefix,
+		  struct repository *repo UNUSED)
+{
+	const char *const repo_info_usage[] = {
+		"git repo-info",
+		NULL
+	};
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, repo_info_usage,
+			     0);
+
+	return 0;
+}
diff --git a/command-list.txt b/command-list.txt
index b7ade3ab9f..197ac21706 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -164,6 +164,7 @@ git-remote                              ancillarymanipulators           complete
 git-repack                              ancillarymanipulators           complete
 git-replace                             ancillarymanipulators           complete
 git-replay                              plumbingmanipulators
+git-repo-info                           plumbinginterrogators
 git-request-pull                        foreignscminterface             complete
 git-rerere                              ancillaryinterrogators
 git-reset                               mainporcelain           history
diff --git a/git.c b/git.c
index 07a5fe39fb..27a2b3569b 100644
--- a/git.c
+++ b/git.c
@@ -611,6 +611,7 @@ static struct cmd_struct commands[] = {
 	{ "repack", cmd_repack, RUN_SETUP },
 	{ "replace", cmd_replace, RUN_SETUP },
 	{ "replay", cmd_replay, RUN_SETUP },
+	{ "repo-info", cmd_repo_info, RUN_SETUP },
 	{ "rerere", cmd_rerere, RUN_SETUP },
 	{ "reset", cmd_reset, RUN_SETUP },
 	{ "restore", cmd_restore, RUN_SETUP | NEED_WORK_TREE },
diff --git a/meson.build b/meson.build
index 7fea4a34d6..06f2f647ba 100644
--- a/meson.build
+++ b/meson.build
@@ -645,6 +645,7 @@ builtin_sources = [
   'builtin/repack.c',
   'builtin/replace.c',
   'builtin/replay.c',
+  'builtin/repo-info.c',
   'builtin/rerere.c',
   'builtin/reset.c',
   'builtin/rev-list.c',
-- 
2.39.5 (Apple Git-154)

