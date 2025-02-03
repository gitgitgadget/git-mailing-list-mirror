Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E7A20B7ED
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738602675; cv=none; b=IDFwuJTiaUDuo0Uo0C9tzNcS/r5Cf4UDppKnw8mgi6YlUYvHjz062jy1hisWGDlNZEmTbC1lVSM5U2bqRH30muBN0qEqINxoXMaSKdsW0gwhBei8yFdFpWp6azku0L6OJtSRRuDLCDHEw8vllwBSEkHG/IAfS8yk2QZrAN9YAvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738602675; c=relaxed/simple;
	bh=o2CIeyO1LecBdsa/v+T9PszOgzJd9XKGL9q5ebU5aeM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ohwq1/fG4snrX9XkuRZRgwrDjOQV0F15wL9jp3Lmd26Hc2WxV+qCp9bldKu4GkI96pLTqMwn1nob0uYSHFvQFdukyU+q+B6vYSzDNNC2eDxfi9Nb6h78kJrsFnMjVXYQh839+cNirRdqPeQR9j/wORG+y617EE4mub5saNhVqKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpkaAm+Q; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpkaAm+Q"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3f28a4fccso6935501a12.2
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 09:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738602671; x=1739207471; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ew5OHsOQw9NetfEXm1XCGvae0ZhzF+qsLTiD9c4WbQ=;
        b=UpkaAm+Qjb9L0USih6GtRkikagbC3PCI0iOjfzxUbczmCqbRPBWDe6IxhqfdNbIs9e
         gOsyJetJnq9rZYvM1fY/hRiCxQfIifrdxeEWCqagIgXVAbdUqwvSwYuqqoKIDZdxgxbS
         Kidbz/3sGyAyrixjTMwmQrcDoEz/L1suFPYDj6uPgSM8g42oi/0tOe1PHCpZy9BN6cvy
         LEajn5s48isZ2qzv9ShDjEuU/oVghPHRPeUhfay/wRzUxZg72agjH30OOrr5+3aX3ZrJ
         Qg2u1Zs/1tPjbc3U6Ec3pRHvLbpH6TI7Lv6mOsfoYQ7SZzFrVqye2e29NvT7leQDcbLF
         Ag8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738602671; x=1739207471;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ew5OHsOQw9NetfEXm1XCGvae0ZhzF+qsLTiD9c4WbQ=;
        b=XSRaG+R2Ci/4F6ZWPVpUgaWk0HTzOgECDuQwycKoQfz/M5BzazpkH9CbDW4/Ru2g2u
         j6EmTpg9WhiRBaXitzzF1M4cZAJ6nNc7Euar9xW8XWbReZPCblkoc5KtMuYb4Law4rxE
         i99LIfXvdbxUIc5y/IR9tPRlyWg5IRxCoK/5ZmrUcF5r/ZMU4ZM9v5kHoj/AU9iim/WR
         ZwwltFEGxsA8DhvDNnNc3EVQB5YIQUezFHt4wMg/UHBKNvCIQzVnxFxeudpc7dwF8hU7
         rmixtgeh0JIR/HnwHHE575Das96jip+9MTXewOFXrfWNoVFCc58hYVZDLgko/8wQTvDx
         7Dbg==
X-Gm-Message-State: AOJu0YzbBatb/oK+3wX4iu8losE7EUHCCxsJqhk7pgijP9lVzQdy6O02
	jUZEJBSsmpJw4OmB/cB5grmMoMlaqds2IB1GjUeNeKg9bi+ga+waX/p4Sg==
X-Gm-Gg: ASbGncsGIaeFKOVskS+C1y8Xz5pWqwdYmGWL36cWDHllBxfVp71zIRywrJjAh01lUTc
	MFJFMW76tp+y3AUDZpUCTprmgFO4GoNywPF0JU7KwqB11KXTSjsenq8+ri3GMbUjJb55b2D5h4M
	2QzC8/vrdNWxH+7p+sW9I7kwwlBH81Sjn9gl3GCF6qvQQp+aY6IG6Ng1omdNbsO0znA/ncgQ6jm
	z5hCUZfwRhPYJaZ5GoLLadyupi1BfoAOisgcLTdObEDNVAu3TpTtjN/hSeZiima2Q7uVSpeyZZC
	yJHkRjIoCKnZc493
X-Google-Smtp-Source: AGHT+IH5iw2XS7pWommTJkeQwGCmeeh1mSiIWerdUDg4qTfkBwq5YaQMW5u5NWXFwZtAFrAEMxPgzA==
X-Received: by 2002:a05:6402:26c9:b0:5d4:1ac2:277f with SMTP id 4fb4d7f45d1cf-5dc5efc1b98mr25134809a12.9.1738602670575;
        Mon, 03 Feb 2025 09:11:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724c9d0asm8042269a12.77.2025.02.03.09.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 09:11:10 -0800 (PST)
Message-Id: <1612ad924556974e41587b441ccf886d74963048.1738602667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1820.v3.git.1738602667.gitgitgadget@gmail.com>
References: <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
	<pull.1820.v3.git.1738602667.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 03 Feb 2025 17:11:03 +0000
Subject: [PATCH v3 1/5] backfill: add builtin boilerplate
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
    =?UTF-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <derrickstolee@github.com>

From: Derrick Stolee <derrickstolee@github.com>

In anticipation of implementing 'git backfill', populate the necessary files
with the boilerplate of a new builtin. Mark the builtin as experimental at
this time, allowing breaking changes in the near future, if necessary.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 .gitignore                     |  1 +
 Documentation/git-backfill.txt | 25 +++++++++++++++++++++++++
 Documentation/meson.build      |  1 +
 Makefile                       |  1 +
 builtin.h                      |  1 +
 builtin/backfill.c             | 28 ++++++++++++++++++++++++++++
 command-list.txt               |  1 +
 git.c                          |  1 +
 meson.build                    |  1 +
 9 files changed, 60 insertions(+)
 create mode 100644 Documentation/git-backfill.txt
 create mode 100644 builtin/backfill.c

diff --git a/.gitignore b/.gitignore
index e82aa19df03..95cd94c5044 100644
--- a/.gitignore
+++ b/.gitignore
@@ -19,6 +19,7 @@
 /git-apply
 /git-archimport
 /git-archive
+/git-backfill
 /git-bisect
 /git-blame
 /git-branch
diff --git a/Documentation/git-backfill.txt b/Documentation/git-backfill.txt
new file mode 100644
index 00000000000..ab384dad6e4
--- /dev/null
+++ b/Documentation/git-backfill.txt
@@ -0,0 +1,25 @@
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
+[synopsis]
+git backfill [<options>]
+
+DESCRIPTION
+-----------
+
+THIS COMMAND IS EXPERIMENTAL. ITS BEHAVIOR MAY CHANGE IN THE FUTURE.
+
+SEE ALSO
+--------
+linkgit:git-clone[1].
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index 2a26fa8a5fe..5e9e3e19c5c 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -6,6 +6,7 @@ manpages = {
   'git-apply.txt' : 1,
   'git-archimport.txt' : 1,
   'git-archive.txt' : 1,
+  'git-backfill.txt' : 1,
   'git-bisect.txt' : 1,
   'git-blame.txt' : 1,
   'git-branch.txt' : 1,
diff --git a/Makefile b/Makefile
index 2f6e2d52955..efa199d390c 100644
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
index 00000000000..58d0866c0fc
--- /dev/null
+++ b/builtin/backfill.c
@@ -0,0 +1,28 @@
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
+	show_usage_if_asked(argc, argv, builtin_backfill_usage[0]);
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
index a94dab37702..a9b45fcef79 100644
--- a/git.c
+++ b/git.c
@@ -506,6 +506,7 @@ static struct cmd_struct commands[] = {
 	{ "annotate", cmd_annotate, RUN_SETUP },
 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
+	{ "backfill", cmd_backfill, RUN_SETUP },
 	{ "bisect", cmd_bisect, RUN_SETUP },
 	{ "blame", cmd_blame, RUN_SETUP },
 	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
diff --git a/meson.build b/meson.build
index 548eac62b28..527c015acfa 100644
--- a/meson.build
+++ b/meson.build
@@ -487,6 +487,7 @@ builtin_sources = [
   'builtin/annotate.c',
   'builtin/apply.c',
   'builtin/archive.c',
+  'builtin/backfill.c',
   'builtin/bisect.c',
   'builtin/blame.c',
   'builtin/branch.c',
-- 
gitgitgadget

