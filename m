Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0121413B2B8
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935342; cv=none; b=Sh6sKX7guOlzKWYFziEp+2za/fBtilhwVo6hsMxBx7A8XD33zcbpbHl9IAl2qwIM4Fl8m/AsI0TW5R+w7u4wYLtEZHZFeSGiVPrBtnCTn5l2XCS0rDsm1B0iXlcjISrrFvSQXCr41nNFuDyyoUR8oJuNfbdvDCf192S4liT7xXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935342; c=relaxed/simple;
	bh=8WpLaP8S48Qhtbv7IPfx6RoVF5NWIcMenRRJiD3/HEg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=shzRL33Ld+x4OqPHWcZF6X6I/Qj/uD2vRpwxpBawBc0V3Snzeg/fsi7VeYwEUs0TYSWSed4oIkQ0wVleygYeom2vFJ4CxJZfBQfwDnPmptLv1Wcm+gldzqBeSlLd8Pfwg4dESELnnPgmKS90ZUiTbIoQ/L+WDQzjPzKosEnYNps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Unn7b7TC; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Unn7b7TC"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c3ca32971cso357467a12.0
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935338; x=1726540138; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGMH37EycR8jxMJo3/rBXnAayoJ7MMo1d9WtbnU5SrE=;
        b=Unn7b7TCFPJgQS6o1O67q4dvxlL3hxajN2JIqQxHx3spbZtFSaTjqhp1aFeojfEXv1
         tZRjyzLDVcIceTx+GKzsdTnmi7U+z1SwHC2uh4lqfuwjCdN5vxHLwjh22CDFRLjogYfK
         3oFamUT3wv5Jn2kSMREYbBht5CUaDv992uHgVwpPnlk/1IV0EC+7b+IwCltbe5DIDwdW
         tWIgoxUhwSmWZ1UHWakyGxhLGMB3YVZ7nPeSylmnif8f6nlcMeGweNMXR1emYKhmgAM8
         m+cz1kxwaH1O/QQekoHcz54SHhPuHeAsR/7mLpjZbVu+AYmz/OJ+ruda9ScsKpabrJR9
         Q0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935338; x=1726540138;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGMH37EycR8jxMJo3/rBXnAayoJ7MMo1d9WtbnU5SrE=;
        b=YckPGoqUayn1sp3nUsFI3NwmJLLt94IkMLROitvPNmgx3ZbUDppfPNL1zXS/qAuEC0
         BOS6JMyysWLk/6k/S4TqYT9z4ANJ8v1phUjNn9SJRcyKibUQGIcilVCbTjpcMgQ2gro5
         EZQdDIdxYyI37tuM1qeaajMuilTr8RQHiv9CkgGjfEF6mm58YBxLRwxxRpXVzwcZ4i2U
         UOOsg1PaH6hO3jumsbG9Wd3IhJDu5QhN/jW3Qs12wOf1HpFlTci2bHGt510YUGe7gkcJ
         Byg0DhNcIzTXzArZ8XxYe02FDRbpH72De7ChiuK84iLt4GKLL80cBCpPFCq3DKaRwZxy
         dE8A==
X-Gm-Message-State: AOJu0YytZYal5bZsVJnnyzPNk4gwGyPx6uAxSZn3gG2A+qLpbmj2pUh9
	BtWROOyAd8GQD9zItYT/VJ+dggT2hWna7lUwbpOwuse77bgVTasPwRjoZw==
X-Google-Smtp-Source: AGHT+IHr4c5/R4ZFE1bp2dUNwI2l6A9nv6kDdtXjSf8xhAqLqa9kE0xu/XXRZw51dPbeWoqDIpJRDw==
X-Received: by 2002:a17:907:6d24:b0:a8d:11c2:2b4 with SMTP id a640c23a62f3a-a8d11c206b0mr934964666b.56.1725935338398;
        Mon, 09 Sep 2024 19:28:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25835cc9sm411772866b.26.2024.09.09.19.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:28:58 -0700 (PDT)
Message-Id: <41c49bba131ed014cc4f7ab579313527dd4c9d29.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:27 +0000
Subject: [PATCH 02/30] backfill: add builtin boilerplate
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
    Derrick Stolee <derrickstolee@github.com>

From: Derrick Stolee <derrickstolee@github.com>

In anticipation of implementing 'git backfill', populate the necessary files
with the boilerplate of a new builtin.

RFC TODO: When preparing this for a full implementation, make sure it is
based on the newest standards introduced by [1].

[1] https://lore.kernel.org/git/xmqqjzfq2f0f.fsf@gitster.g/T/#m606036ea2e75a6d6819d6b5c90e729643b0ff7f7
    [PATCH 1/3] builtin: add a repository parameter for builtin functions

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
index 8caf3700c23..8f5cb938ecb 100644
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
index e83f6de9a2c..4305474d96e 100644
--- a/Makefile
+++ b/Makefile
@@ -1198,6 +1198,7 @@ BUILTIN_OBJS += builtin/am.o
 BUILTIN_OBJS += builtin/annotate.o
 BUILTIN_OBJS += builtin/apply.o
 BUILTIN_OBJS += builtin/archive.o
+BUILTIN_OBJS += builtin/backfill.o
 BUILTIN_OBJS += builtin/bisect.o
 BUILTIN_OBJS += builtin/blame.o
 BUILTIN_OBJS += builtin/branch.o
diff --git a/builtin.h b/builtin.h
index 14fa0171607..73dd0ccbe8c 100644
--- a/builtin.h
+++ b/builtin.h
@@ -127,6 +127,7 @@ int cmd_am(int argc, const char **argv, const char *prefix);
 int cmd_annotate(int argc, const char **argv, const char *prefix);
 int cmd_apply(int argc, const char **argv, const char *prefix);
 int cmd_archive(int argc, const char **argv, const char *prefix);
+int cmd_backfill(int argc, const char **argv, const char *prefix);
 int cmd_bisect(int argc, const char **argv, const char *prefix);
 int cmd_blame(int argc, const char **argv, const char *prefix);
 int cmd_branch(int argc, const char **argv, const char *prefix);
diff --git a/builtin/backfill.c b/builtin/backfill.c
new file mode 100644
index 00000000000..77b05a2f838
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
+int cmd_backfill(int argc, const char **argv, const char *prefix)
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
+	git_config(git_default_config, NULL);
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
index 9a618a2740f..4f2215e9c8b 100644
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

