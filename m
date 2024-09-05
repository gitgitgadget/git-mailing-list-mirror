Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3CC1A0722
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555477; cv=none; b=G1BzbEaBcthQUr0u8uGnWq4icrDYnFWxsDJ4vDDdRvKpwl3azX9MmswWFYu54s/NhkmT6/6oo0sleFJFGf/SgY/wyCrav7U0voqKXsSrsDT4bfhOUddEgSbcEDwAm8hToFiKkB+0/5G9XYITk6xpx3wk2y/8uZG84I2dX0lXQOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555477; c=relaxed/simple;
	bh=LocHGDwJGPh1BpRaInBWxaL4x0Y1HjNM92DOhWPGAbQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UiF+tseimd+pXh2ncEEJtXORIAq/FRgKpNqdC5hH2oBePXCzgFAYw4GJ/dNH8EgnfRtnTdSk7hP3dUMQEUaAMTWxXs5WRQX+SjwUMb/wVmVVswmpkC7NONCG3B4l3IjCb7oX25juzaN3gIH8DuSaOBwhLbWiAjFnlkcPE1Lx6M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecamOmaS; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecamOmaS"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so141423566b.1
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 09:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725555473; x=1726160273; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PcpTRGDrtbOh6tW4V/ywyrvg7ERlZ+3zWl5cdIWkn8=;
        b=ecamOmaSfd5c35fxNgCY4TZFZTuUZems8aPDj+93/VqLciKrxW/pK58L3cv29Kz/T8
         /GBI3SgJBG7FeDQfNOAFBRbGR/IWXfMkBz6h5K9SBd2794qCBf26NHAHYxnbQCVUaUJU
         XluDfHyFrJEMbSbrU3LGrwudl51PKcGxwB6nyYEwtLAyf9E0h3gcW0TIGnnsNI2eT5K9
         eELApJz0TDGM24lw0eY9VhVXS6n22LpFY5FtJCDRNHdxIborL2utsg/ihnBtv5jafzZN
         B+d+fsJwFP27LkopNb5kOYW1rvHxhmrINbPX/5Iyw3ZPbf0fUYnOTX7pK4zi1B+gt7v7
         PR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725555473; x=1726160273;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PcpTRGDrtbOh6tW4V/ywyrvg7ERlZ+3zWl5cdIWkn8=;
        b=IwKZfDKMCNzodVGK84oaBCQlQ1H2VF+iR+6P4UtwDGeYiAB/zLQWx7q1XerGC/RMSz
         VLCS45S0D1aYjQQ+TwLW4sKmKeD3MBNN163pYr6vTM/aL9KzlfETl3BDSpvIMaPZLGSl
         /WAxcr8c0Sfxe4uxGhI0wTRRfhqMft6WBdT9yXfnvtcoyxg7yMNiXMUbifYzlMQRzqzc
         L59AXg8fHPidGxsJVUBjMRrY3eUoYH/7z8lSgtu+TEMLXht0/TXJKIQkRbj/Lsvmc7ML
         CnVzqJOvbHB/h3YOWgNqf+h6Cm3bARn9y59jh1DE1jngQ/xZV4/Psyfd08fUvE0juNQ8
         QigA==
X-Gm-Message-State: AOJu0YwCpjYNXAyYInALAhUx3u5NaAg76dlwcGJ5NMR6ezm8WYQbPxrw
	e9X3VcnWoE4Ffa7HyMU4924dmrPCYx9mJ22B9amIt3e1cUAcznG2CjFmXw==
X-Google-Smtp-Source: AGHT+IFl5a5KL9mvsglEhbacm/uodulmkrFMdrRhIJ7VtU4ZCpRLq5x/uFOps/PrV8r6nsHekYmvqA==
X-Received: by 2002:a17:907:f7a7:b0:a7a:9a78:4b5a with SMTP id a640c23a62f3a-a8a3f49d7e4mr529920466b.52.1725555472025;
        Thu, 05 Sep 2024 09:57:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623a6e85sm159132066b.167.2024.09.05.09.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 09:57:51 -0700 (PDT)
Message-Id: <17acc1e054c26b67659df17db828b106c005ffea.1725555468.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>
References: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Sep 2024 16:57:46 +0000
Subject: [PATCH 2/3] builtin: remove USE_THE_REPOSITORY_VARIABLE from
 builtin.h
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
Cc: John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Instead of including USE_THE_REPOSITORY_VARIABLE by default on every
builtin, remove it from builtin.h and add it where necessary to
individual builtins/*. The next step will be to migrate each builtin
from having to use the_repository.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin.h                          | 8 --------
 builtin/add.c                      | 2 +-
 builtin/am.c                       | 1 +
 builtin/apply.c                    | 1 +
 builtin/archive.c                  | 1 +
 builtin/bisect.c                   | 1 +
 builtin/blame.c                    | 2 +-
 builtin/branch.c                   | 3 ++-
 builtin/bugreport.c                | 1 +
 builtin/bundle.c                   | 1 +
 builtin/cat-file.c                 | 3 ++-
 builtin/check-attr.c               | 1 +
 builtin/check-ignore.c             | 1 +
 builtin/check-mailmap.c            | 1 +
 builtin/checkout--worker.c         | 1 +
 builtin/checkout-index.c           | 1 +
 builtin/checkout.c                 | 1 +
 builtin/clean.c                    | 2 +-
 builtin/clone.c                    | 3 ++-
 builtin/column.c                   | 2 ++
 builtin/commit-graph.c             | 1 +
 builtin/commit-tree.c              | 1 +
 builtin/commit.c                   | 3 ++-
 builtin/config.c                   | 1 +
 builtin/count-objects.c            | 2 +-
 builtin/credential-cache--daemon.c | 1 +
 builtin/credential-store.c         | 1 +
 builtin/credential.c               | 2 ++
 builtin/describe.c                 | 1 +
 builtin/diff-files.c               | 1 +
 builtin/diff-index.c               | 1 +
 builtin/diff-tree.c                | 1 +
 builtin/diff.c                     | 3 ++-
 builtin/difftool.c                 | 3 ++-
 builtin/fast-export.c              | 2 ++
 builtin/fast-import.c              | 1 +
 builtin/fetch-pack.c               | 1 +
 builtin/fetch.c                    | 1 +
 builtin/fmt-merge-msg.c            | 1 +
 builtin/for-each-ref.c             | 1 +
 builtin/for-each-repo.c            | 1 +
 builtin/fsck.c                     | 1 +
 builtin/fsmonitor--daemon.c        | 1 +
 builtin/gc.c                       | 2 +-
 builtin/grep.c                     | 1 +
 builtin/hash-object.c              | 2 ++
 builtin/help.c                     | 2 ++
 builtin/hook.c                     | 1 +
 builtin/index-pack.c               | 1 +
 builtin/interpret-trailers.c       | 2 +-
 builtin/log.c                      | 1 +
 builtin/ls-files.c                 | 1 +
 builtin/ls-remote.c                | 1 +
 builtin/ls-tree.c                  | 2 ++
 builtin/merge-base.c               | 1 +
 builtin/merge-file.c               | 1 +
 builtin/merge-index.c              | 1 +
 builtin/merge-ours.c               | 1 +
 builtin/merge-recursive.c          | 1 +
 builtin/merge-tree.c               | 1 +
 builtin/merge.c                    | 3 ++-
 builtin/mktag.c                    | 1 +
 builtin/mktree.c                   | 2 ++
 builtin/multi-pack-index.c         | 1 +
 builtin/mv.c                       | 1 +
 builtin/name-rev.c                 | 1 +
 builtin/notes.c                    | 2 +-
 builtin/pack-objects.c             | 1 +
 builtin/pack-redundant.c           | 1 +
 builtin/pack-refs.c                | 1 +
 builtin/patch-id.c                 | 1 +
 builtin/prune.c                    | 1 +
 builtin/pull.c                     | 1 +
 builtin/push.c                     | 1 +
 builtin/range-diff.c               | 1 +
 builtin/read-tree.c                | 2 +-
 builtin/rebase.c                   | 3 ++-
 builtin/receive-pack.c             | 1 +
 builtin/reflog.c                   | 1 +
 builtin/refs.c                     | 1 +
 builtin/remote.c                   | 1 +
 builtin/repack.c                   | 1 +
 builtin/replace.c                  | 1 +
 builtin/replay.c                   | 1 +
 builtin/rerere.c                   | 1 +
 builtin/reset.c                    | 3 ++-
 builtin/rev-list.c                 | 1 +
 builtin/rev-parse.c                | 3 ++-
 builtin/revert.c                   | 1 +
 builtin/rm.c                       | 2 +-
 builtin/send-pack.c                | 1 +
 builtin/shortlog.c                 | 1 +
 builtin/show-branch.c              | 1 +
 builtin/show-index.c               | 1 +
 builtin/show-ref.c                 | 1 +
 builtin/sparse-checkout.c          | 1 +
 builtin/stash.c                    | 1 +
 builtin/stripspace.c               | 1 +
 builtin/submodule--helper.c        | 1 +
 builtin/symbolic-ref.c             | 1 +
 builtin/tag.c                      | 3 ++-
 builtin/unpack-file.c              | 1 +
 builtin/unpack-objects.c           | 1 +
 builtin/update-index.c             | 1 +
 builtin/update-ref.c               | 1 +
 builtin/update-server-info.c       | 1 +
 builtin/upload-archive.c           | 1 +
 builtin/var.c                      | 2 ++
 builtin/verify-commit.c            | 1 +
 builtin/verify-pack.c              | 1 +
 builtin/verify-tag.c               | 2 ++
 builtin/worktree.c                 | 1 +
 builtin/write-tree.c               | 2 +-
 113 files changed, 132 insertions(+), 29 deletions(-)

diff --git a/builtin.h b/builtin.h
index fc6fc8ffed8..f7b166b3348 100644
--- a/builtin.h
+++ b/builtin.h
@@ -1,14 +1,6 @@
 #ifndef BUILTIN_H
 #define BUILTIN_H
 
-/*
- * TODO: Almost all of our builtins access `the_repository` by necessity
- * because they do not get passed a pointer to it. We should adapt the function
- * signature of those main functions to accept a `struct repository *` and then
- * remove the macro here.
- */
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "repository.h"
 
diff --git a/builtin/add.c b/builtin/add.c
index 3b9bc93ed9a..dac832df3e7 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2006 Linus Torvalds
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
diff --git a/builtin/am.c b/builtin/am.c
index 830c295314b..0546aee12ad 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -4,6 +4,7 @@
  * Based on git-am.sh by Junio C Hamano.
  */
 
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "advice.h"
diff --git a/builtin/apply.c b/builtin/apply.c
index 923ce992bdd..456b1498067 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "repository.h"
diff --git a/builtin/archive.c b/builtin/archive.c
index 21e5e3b877b..e1743b93ac0 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -2,6 +2,7 @@
  * Copyright (c) 2006 Franck Bui-Huu
  * Copyright (c) 2006 Rene Scharfe
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "archive.h"
 #include "gettext.h"
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 8cf6167df61..23af9a3ae4d 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "copy.h"
 #include "environment.h"
diff --git a/builtin/blame.c b/builtin/blame.c
index 522f564d6b0..2d263074e90 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2006, 2014 by its authors
  * See COPYING for licensing conditions
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "color.h"
diff --git a/builtin/branch.c b/builtin/branch.c
index e20420059a2..8a5424c836f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -4,8 +4,9 @@
  * Copyright (c) 2006 Kristian Høgsberg <krh@redhat.com>
  * Based on git-branch.sh by Junio C Hamano.
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
+#include "repository.h"
 #include "config.h"
 #include "color.h"
 #include "editor.h"
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 5269f073d59..428d3a26f80 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "editor.h"
diff --git a/builtin/bundle.c b/builtin/bundle.c
index e26c1f7d4a7..f54559a54ea 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "gettext.h"
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 6e6f134eab1..34888633e4f 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -3,8 +3,9 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
+#include "repository.h"
 #include "config.h"
 #include "convert.h"
 #include "diff.h"
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 0f180350bec..704da2743bf 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "attr.h"
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 4067127c8b4..319676e2b8e 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "dir.h"
diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
index 07ab8fa9b3c..18733e78fb6 100644
--- a/builtin/check-mailmap.c
+++ b/builtin/check-mailmap.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
index 61758a11d5d..369097aa43e 100644
--- a/builtin/checkout--worker.c
+++ b/builtin/checkout--worker.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "entry.h"
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index dcf58a4fe13..118845bcc25 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2005 Linus Torvalds
  *
  */
+#define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
 #include "config.h"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index c43bba082f5..74052571026 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "advice.h"
 #include "branch.h"
diff --git a/builtin/clean.c b/builtin/clean.c
index d4e00f4f3af..f3eb6a0886e 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -5,7 +5,7 @@
  *
  * Based on git-clean.sh by Pavel Roskin
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index fb820861cd9..9772a9723e7 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -7,8 +7,9 @@
  *
  * Clone a repository into a different directory that does not yet exist.
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
+#include "repository.h"
 #include "abspath.h"
 #include "advice.h"
 #include "config.h"
diff --git a/builtin/column.c b/builtin/column.c
index ca2b522284e..e3e95a9ee20 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 67e27ef0cd7..83e566de652 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "commit.h"
 #include "config.h"
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 42f88d007ff..2e7e2ecb203 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/commit.c b/builtin/commit.c
index 27c807cde08..141c8d85620 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -4,8 +4,9 @@
  * Copyright (c) 2007 Kristian Høgsberg <krh@redhat.com>
  * Based on git-commit.sh by Junio C Hamano and Linus Torvalds
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
+#include "repository.h"
 #include "advice.h"
 #include "config.h"
 #include "lockfile.h"
diff --git a/builtin/config.c b/builtin/config.c
index 8604986fa98..69b2e857888 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 74225ff2488..7d9d7cd94ab 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2006 Junio C Hamano
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "dir.h"
diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 0c4d29a0745..9cda9f30739 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "gettext.h"
diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index e79d72d9695..6dfa66b300e 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/credential.c b/builtin/credential.c
index 9235fbf1977..73510946cac 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "credential.h"
 #include "builtin.h"
diff --git a/builtin/describe.c b/builtin/describe.c
index 32ab17de651..d8ea2e8fdf8 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "environment.h"
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 93a3df766ad..b2e3628d9ef 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 645d2fba359..15e0dcf60f8 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 0d17708d2a3..e01caea94d7 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
diff --git a/builtin/diff.c b/builtin/diff.c
index ebf71aa5592..bf3b7ab3350 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -3,8 +3,9 @@
  *
  * Copyright (c) 2006 Junio C Hamano
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
+#include "repository.h"
 #include "config.h"
 #include "ewah/ewok.h"
 #include "lockfile.h"
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 94f3bf72a7c..f1a2c7e7e1e 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -11,8 +11,9 @@
  *
  * Copyright (C) 2016 Johannes Schindelin
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
+#include "repository.h"
 #include "abspath.h"
 #include "config.h"
 #include "copy.h"
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 37482785b81..d2e1a5028d3 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -3,7 +3,9 @@
  *
  * Copyright (C) 2007 Johannes E. Schindelin
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
+#include "repository.h"
 #include "config.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 36b76490e1e..e0df21bf5fe 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "environment.h"
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index fcabd1906d4..83b131d5c5d 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index ccdb409da43..b4bd8d89851 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1,6 +1,7 @@
 /*
  * "git fetch"
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 0a9c2008429..af4264159af 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "fmt-merge-msg.h"
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 70391638a3d..aeba8e69408 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "commit.h"
 #include "config.h"
diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 6b2935ae140..47a97653474 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 2b69c963b2e..bc6046c3c73 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 93f4a60ca22..1bd7cf41ffd 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
diff --git a/builtin/gc.c b/builtin/gc.c
index 462dacb0bdb..2cca94afce4 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -9,7 +9,7 @@
  *
  * Copyright (c) 2006 Shawn O. Pearce
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "date.h"
diff --git a/builtin/grep.c b/builtin/grep.c
index 98eea1f4dc5..b0b149d81bf 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -3,6 +3,7 @@
  *
  * Copyright (c) 2006 Junio C Hamano
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "gettext.h"
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 59a48345394..293fc2ab879 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -4,7 +4,9 @@
  * Copyright (C) Linus Torvalds, 2005
  * Copyright (C) Junio C Hamano, 2005
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
+#include "repository.h"
 #include "abspath.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/help.c b/builtin/help.c
index 4efdccfb7fb..557d2b645e6 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -1,6 +1,8 @@
+
 /*
  * Builtin help command
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "exec-cmd.h"
diff --git a/builtin/hook.c b/builtin/hook.c
index 2aa6476f8fc..1b71eb021c2 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 64754da036d..a0acfad823d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "delta.h"
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 79da472e8eb..2e05551b4dd 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
  *
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "parse-options.h"
diff --git a/builtin/log.c b/builtin/log.c
index c9018e89e55..5353ec02df7 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -4,6 +4,7 @@
  * (C) Copyright 2006 Linus Torvalds
  *		 2006 Junio Hamano
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 5185f264e8d..5496536b0ff 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -5,6 +5,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "repository.h"
 #include "config.h"
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index ce826d32686..de282999059 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index f91361ca788..57a9a00c348 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -3,7 +3,9 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
+#include "repository.h"
 #include "config.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index d5aef8b32c0..b6b28d60df2 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "commit.h"
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index a538edf2a46..a5a6d821f20 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "diff.h"
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 39870e14bfa..7ca6af69539 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "hex.h"
 #include "read-cache-ll.h"
diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index 391c767e122..258d5560a17 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -7,6 +7,7 @@
  *
  * Pretend we resolved the heads, but declare our tree trumps everybody else.
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "git-compat-util.h"
 #include "builtin.h"
 #include "diff.h"
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index cd2b4d9a721..c7ec78b0d66 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "advice.h"
 #include "gettext.h"
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index e69ed337f46..f247480b434 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "tree-walk.h"
 #include "xdiff-interface.h"
diff --git a/builtin/merge.c b/builtin/merge.c
index 4e817f6e91f..6427b7c4a8b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -5,8 +5,9 @@
  *
  * Based on git-merge.sh by Junio C Hamano.
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
+#include "repository.h"
 #include "abspath.h"
 #include "advice.h"
 #include "config.h"
diff --git a/builtin/mktag.c b/builtin/mktag.c
index cc3f1b7c5bb..d4bcebb0abf 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 1c43360b50c..f52015a5e81 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -3,7 +3,9 @@
  *
  * Copyright (c) Junio C Hamano, 2006, 2009
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
+#include "repository.h"
 #include "gettext.h"
 #include "hex.h"
 #include "quote.h"
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 91324a5581d..86f974bc6ae 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
diff --git a/builtin/mv.c b/builtin/mv.c
index 3069d1d9ce8..1123c3d5f1a 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2006 Johannes Schindelin
  */
+#define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
 #include "abspath.h"
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index f46f5546629..8bccc3ebf59 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/builtin/notes.c b/builtin/notes.c
index 2f8e896283a..9b894ab85f3 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -6,7 +6,7 @@
  * Based on git-notes.sh by Johannes Schindelin,
  * and builtin/tag.c by Kristian Høgsberg and Carlos Rica.
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "editor.h"
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 702d10ea86b..cf255e537d0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 42d367c95d1..690dbe233f9 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -5,6 +5,7 @@
 * This file is licensed under the GPL v2.
 *
 */
+#define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
 #include "gettext.h"
diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index c61e876216a..ea155d4f076 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 4449c44580a..7853f052ce1 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
diff --git a/builtin/prune.c b/builtin/prune.c
index ed532fab0a5..289344efdb8 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "commit.h"
 #include "diff.h"
diff --git a/builtin/pull.c b/builtin/pull.c
index 906c02e5a97..60ac523e4f4 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -6,6 +6,7 @@
  * Fetch one or more remote refs and merge it/them into the current HEAD.
  */
 
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
diff --git a/builtin/push.c b/builtin/push.c
index a6b7fcd9538..5d5e4899bb8 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -1,6 +1,7 @@
 /*
  * "git push"
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "advice.h"
 #include "branch.h"
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 30a5b003bab..82a44684805 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "object-name.h"
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 89fa0b728d7..b08627980da 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 20a0a324aff..232b1fecffd 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -3,8 +3,9 @@
  *
  * Copyright (c) 2018 Pratik Karki
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
+#include "repository.h"
 #include "abspath.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 74677ff1a24..db23fff7dac 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "repository.h"
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 1eab96aca98..d946d1b2245 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/refs.c b/builtin/refs.c
index 355e0abce76..aa020eef7f8 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "fsck.h"
diff --git a/builtin/remote.c b/builtin/remote.c
index d24d4966ccb..cfd5b891181 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/repack.c b/builtin/repack.c
index ea06f0b4a0f..8a7e8e80af1 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "dir.h"
diff --git a/builtin/replace.c b/builtin/replace.c
index 9c6d846c497..d157c237d57 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -7,6 +7,7 @@
  * and Carlos Rica <jasampler@gmail.com> that was itself based on
  * git-tag.sh and mktag.c by Linus Torvalds.
  */
+#define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
 #include "config.h"
diff --git a/builtin/replay.c b/builtin/replay.c
index 66f417aab78..feb2e0192c6 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -4,6 +4,7 @@
 
 #include "git-compat-util.h"
 
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "environment.h"
 #include "hex.h"
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 7bccf393c8d..2a33c57c481 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/reset.c b/builtin/reset.c
index a8e293b0c57..956d716c787 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -7,8 +7,9 @@
  *
  * Copyright (c) 2005, 2006 Linus Torvalds and Junio C Hamano
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
+#include "repository.h"
 #include "advice.h"
 #include "config.h"
 #include "environment.h"
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 71bc12ee6b2..c90c7e77a11 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "commit.h"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index ba5bc0facd7..b84b2ef642a 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -3,8 +3,9 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
+#include "repository.h"
 #include "abspath.h"
 #include "config.h"
 #include "commit.h"
diff --git a/builtin/revert.c b/builtin/revert.c
index e6be55a2bd9..e4f71b5fbf0 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "git-compat-util.h"
 #include "builtin.h"
 #include "parse-options.h"
diff --git a/builtin/rm.c b/builtin/rm.c
index 4fd94f7e7e8..6f9638ca079 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Linus Torvalds 2006
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 5479cd5731c..02654613ed5 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "hex.h"
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index c911383026d..f12f7ad0a53 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "commit.h"
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 800a64fd4c7..27207e515be 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "environment.h"
diff --git a/builtin/show-index.c b/builtin/show-index.c
index 952ea798fc1..b96a28531cd 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "hash.h"
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 8d908a03949..47831bf793b 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index da9d582b12d..138cece3ac9 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "dir.h"
diff --git a/builtin/stash.c b/builtin/stash.c
index da90d18f16d..557bbcc6740 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index a83ad2b5f30..336194a93f4 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "environment.h"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1a1fc40e467..970d0b93022 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "environment.h"
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 682f3cf3ae4..a13dc8b35a2 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/tag.c b/builtin/tag.c
index 925e269f0f4..757fd390b29 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -5,8 +5,9 @@
  *                    Carlos Rica <jasampler@gmail.com>
  * Based on git-tag.sh and mktag.c by Linus Torvalds.
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
+#include "repository.h"
 #include "advice.h"
 #include "config.h"
 #include "editor.h"
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 366d4743d4c..f4ba988711c 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "hex.h"
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index c6f9456a0ec..51075fc0e54 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "bulk-checkin.h"
 #include "config.h"
diff --git a/builtin/update-index.c b/builtin/update-index.c
index c2974b57661..df1ee60dd2d 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+#define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
 #include "bulk-checkin.h"
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 97f116ed391..ede553a34c8 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/update-server-info.c b/builtin/update-server-info.c
index b09527b2865..ce0784f390b 100644
--- a/builtin/update-server-info.c
+++ b/builtin/update-server-info.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 447fbbb90b5..f7f89771827 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (c) 2006 Franck Bui-Huu
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "archive.h"
 #include "path.h"
diff --git a/builtin/var.c b/builtin/var.c
index 8b07a7a6a09..07785b3dd1b 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -3,7 +3,9 @@
  *
  * Copyright (C) Eric Biederman, 2005
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
+#include "repository.h"
 #include "attr.h"
 #include "config.h"
 #include "editor.h"
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index dbf5b315569..57fa5657add 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -5,6 +5,7 @@
  *
  * Based on git-verify-tag
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index 1d0a789d19a..323466af865 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 8e81a9a9e05..818c373cc63 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -5,7 +5,9 @@
  *
  * Based on git-verify-tag.sh
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
+#include "repository.h"
 #include "config.h"
 #include "gettext.h"
 #include "tag.h"
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 4c2b9e19217..e4f024cf2db 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "advice.h"
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index 91b80e05d3a..47a2837cb8e 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "environment.h"
-- 
gitgitgadget

