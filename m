Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7C0219A89
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734712200; cv=none; b=OAw46SavGxxDWeUcHveBEUE+FgHAFfSajnVWnSfaDdhw3Jih8oNFT03REK+4VFI42RA537Ydx2NmABD0seEdtPpHEvsCFm0hOWK65cOZPEXO+2vd/CkD0S4iABxHrZBMAP6xUCas47LZ/OLZmdf4U30BuYNNyv2mzmSqxxrRH5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734712200; c=relaxed/simple;
	bh=I9Pb9pjR0dbL4sTNqDEDrW7TKbj21teRmZNgbpZDFZs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fc+lQR09b3WYnffbtPRa4xxSROBsAuOb6Yw1sTZmhPNu/k/03fSHOOOXAXbw1LmCN42879ZAri0kj3jJl+gvoNc9w2tG3QhQQlZFZTWHLYDdX1jo7pOpvo/QJvGDVPQ2o1KQpbpb5wqzgKKHP5/nb3gZPxHTpV9Zf+gC+Ge0P/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWP8a/el; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWP8a/el"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3862df95f92so1118575f8f.2
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 08:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734712196; x=1735316996; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1MZfcW3h2bVPFqgSOH07jJe+Cl7FkMBlEB42zBTChU=;
        b=nWP8a/elZpeulcjuJlD+1wqHZYys1olNLmGFJZovJobjcNL+rw0OJChAbCvCfA9y/9
         ZZ90rLiiwQi1P4DVI548ix7zjrYirHWsgIhHOtGRE4lhIK3qik23Gr7g9Af26nRp1cZV
         dIt6b84QaBvc1NZF2lkz2ZZ6Vmd3d2IPX6CGPV85e+Qb9y75brBlSf8T+lM7lyLUppst
         lUWOkjZMWRnw5lp86+wSmQCKRfgpDa/bTEdX/MqSJFOLI5DGJ4iTQT5wflPt/If+sh7a
         MOl/DPB/XvMJwcRiBErLrkdseeNxueyPRnjxh5xMrmm8Gp0wF7iT2N1lLSQ/5ThM4g/N
         joAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734712196; x=1735316996;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1MZfcW3h2bVPFqgSOH07jJe+Cl7FkMBlEB42zBTChU=;
        b=VXU3qaSiA21RofcMTO8ku6lsAnfnzEFH18rVOwiwSUTKXyV1pxsbEjuYOhqhqWZqk9
         sWVeB/tmWBCoJaWTKxVoRbJeMSGqj/PAxQw1MCxynVnFtWuGrzqTc7wk3Py6qgSzenso
         U81AwT2LymYb/OaKFipWjXJIkpTdZ/rb4bpzFNqn6G41frVdFdCJ2QynpwUx53Geadt4
         OKfQvwfyIdrqWsyzfWcU9i+yrd70VGQjl9glzym7eMXjxzvkKNE2Bxhi+CVLpEbuM/Hi
         LIWH/ehSD6UXQKU8Nh16Ic3hZVLfMLfrJGtCN+omut6PrduV+W/EK7djUQ+plAos7yC9
         jQMQ==
X-Gm-Message-State: AOJu0YzZN0bdgY4lokwMdpMRPOkOGBGRl6MdtzQhFfqsdC68vNVZXy6N
	sey3TcqjL1BHWejd/+qrnojBNsZJeaWeR0VxraauBMccxjThCB0txN0cEA==
X-Gm-Gg: ASbGnct39ckffvae79ojEAcLe7ufvnM+akA6PRb6Z6uKKBrFHd7YK1VbMOAEY6nAiwz
	yBFuDK00D7KhevpvfkmdwBjkWMs2oKIlhRVjWPIfrSdvHwUWKN+WmS9HBNfeiGj7bJkL+dsOXqo
	e8COr222Luljli1ZiJ2Q5X/rgDoGb/toTRpRVfLMQ+NQOFvtlE7xzMBraroEbbwOwcv+Sz72XpE
	9050wdViWa6TT3V0EQoPiacyk/19FZh3cI2ymIrLxhqNEyX99CXPZN1yA==
X-Google-Smtp-Source: AGHT+IHEMoUIoiTtmklh3CIXpONHyGHtrhZbMkWKT0gmUm6ZDFWeEKgch2zxdBEZSsJJ7tgfeVsCvg==
X-Received: by 2002:a5d:5f8b:0:b0:385:fc70:826 with SMTP id ffacd0b85a97d-38a223fd808mr3411384f8f.52.1734712196286;
        Fri, 20 Dec 2024 08:29:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8ace0esm4331957f8f.106.2024.12.20.08.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 08:29:55 -0800 (PST)
Message-Id: <ac86510417a0b1713f5fa34acab547f01b716fd2.1734712193.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
	<pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Dec 2024 16:29:49 +0000
Subject: [PATCH v2 1/5] backfill: add builtin boilerplate
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

