Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03441537DA
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 21:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726262190; cv=none; b=PV2TML4LHjGOeJynDh/8xlt8+FFireu44bF7ZZ//sT96w89KjXSDVB5szpvk/XTrIN99bJ35AtesZql1mCkeweHs4ZgRYwuVUOubL1fHXwlWSnvENc1yfIiuUFsZ15zYWKTisUPKd3ZO3wKiDGJlbkzLFCuo22r0u84iEP6/Ifs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726262190; c=relaxed/simple;
	bh=S9cjk5aGx/sFP10rBI/SxmxEkOV6B5ySVtHSqz5itIQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TcdFSdUZWr2vAjgPBId1ylJ5mz2BHDJ2J0PMmgkOXIphRNwJUAKTdWK8J9VPYH0jzJ6qZn9ZI43HxMpcUJU2oEtTPIuX+2swzvW4OLKCVRVHET1O8As1faX2VhE3uBpillPI6a9LXTLIXnO79fjMGCPu+boj9SehrX2i/Mk8fV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKucxFjp; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKucxFjp"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c3ed267a7bso2963135a12.3
        for <git@vger.kernel.org>; Fri, 13 Sep 2024 14:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726262185; x=1726866985; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22XtFKSdgGinaYA/xxAVCQSQGDGsOg85nJtH4hiKQbI=;
        b=XKucxFjpN3eJWwMzs6sNGzK/5Xr1rWU9W5JKAetg/6TTpxOfvHpnzKL5AUXFxVGz2r
         s6ufaWzExo24iJHIVr2sJG2/eUiqUAMuZtmYVTw3AmgJgIt4VDSg3G5R1nqiyl4pwzWm
         zZcIEVkVkK81uSU2t+ze717VaxlORdO2ZZWgXgk59tcFHdGXe+ieqO06AwrqT/Qkn3nq
         UFxYmdmQv7GTJ6/tNnUmEepSl3Cv6kDEQQIDx22HrYh9TVsqNkkvzmuPU74AMpQK2CJ+
         hZd4zg2I7XC4JNnz9PJr8iXVl6rI8wUgCXGdTVUlfp5j8ytQ3DlsyswBF5VdFyVaHiHV
         Qh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726262185; x=1726866985;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22XtFKSdgGinaYA/xxAVCQSQGDGsOg85nJtH4hiKQbI=;
        b=LQK82U+B8dS/RkhhYaDAWexIHjL/kXz1usnfR7EQZiWBZMMYDEuwu6k4JOx3jcUPRn
         mGvZB3mkPNVGB4N7DQ5SkUECAlFlLMEN+7Erl23sZnYW6McJJoqd0c/M3deANpI2/Sff
         UKBV5eASyaysdkSNWOEZqsV+eJpz0jI0J1a9yITS8zXjnr8Pc9180L2ylfFFTIEkWLRh
         YxpKKViFMXGOekD6Ec0fi1TovJEtENT2LbljuPVhkykL7y1baZUTrtPMDazU0vIZZvv4
         hcqwLzs6b81FZ6whzNzSIOcWiwwXMhMHOlW7fAElfiz/tdQue7bkLfsFRNPYNWPwg0dJ
         iIhg==
X-Gm-Message-State: AOJu0YxZcx6RV6zpGRyvKFYGoincqtlTuOha1KYJY8TiYohDGlsuuOxm
	v1zyn4DKYtt3YwbcXINSVGJUXTIRtE4GEyA9KxFiUIsqyvCaK0Z7euXiUA==
X-Google-Smtp-Source: AGHT+IHBdRgF3if9EY2kPAcXOekBC7wcMhs/fe5h25A1eaHtv9m8LROd66S39I/L6z7egr+LdP4u8w==
X-Received: by 2002:a17:907:7fa8:b0:a86:7cac:f871 with SMTP id a640c23a62f3a-a9029671603mr610180966b.54.1726262184085;
        Fri, 13 Sep 2024 14:16:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612df5cfsm853866b.146.2024.09.13.14.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 14:16:23 -0700 (PDT)
Message-Id: <7becd3751fc73a51a1791427b2232fc94f1c9ae9.1726262178.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1778.v3.git.git.1726262177.gitgitgadget@gmail.com>
References: <pull.1778.v2.git.git.1726001960.gitgitgadget@gmail.com>
	<pull.1778.v3.git.git.1726262177.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Sep 2024 21:16:15 +0000
Subject: [PATCH v3 2/4] builtin: remove USE_THE_REPOSITORY_VARIABLE from
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Instead of including USE_THE_REPOSITORY_VARIABLE by default on every
builtin, remove it from builtin.h and add it to all the builtins that
reference the_repository.

Also, remove the include statement for repository.h since it gets
brought in through builtin.h.

The next step will be to migrate each builtin
from having to use the_repository.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin.h                          | 8 --------
 builtin/add.c                      | 3 +--
 builtin/am.c                       | 2 +-
 builtin/annotate.c                 | 2 ++
 builtin/apply.c                    | 2 +-
 builtin/archive.c                  | 2 +-
 builtin/bisect.c                   | 1 +
 builtin/blame.c                    | 3 +--
 builtin/branch.c                   | 2 +-
 builtin/bugreport.c                | 1 +
 builtin/bundle.c                   | 2 +-
 builtin/cat-file.c                 | 2 +-
 builtin/check-attr.c               | 2 +-
 builtin/check-ignore.c             | 2 +-
 builtin/check-mailmap.c            | 1 +
 builtin/check-ref-format.c         | 2 +-
 builtin/checkout--worker.c         | 1 +
 builtin/checkout-index.c           | 3 +--
 builtin/checkout.c                 | 1 +
 builtin/clean.c                    | 3 +--
 builtin/clone.c                    | 3 ++-
 builtin/column.c                   | 1 +
 builtin/commit-graph.c             | 2 +-
 builtin/commit-tree.c              | 3 ++-
 builtin/commit.c                   | 2 +-
 builtin/config.c                   | 2 +-
 builtin/count-objects.c            | 3 +--
 builtin/credential-cache--daemon.c | 1 +
 builtin/credential-cache.c         | 1 +
 builtin/credential-store.c         | 1 +
 builtin/credential.c               | 2 ++
 builtin/describe.c                 | 1 +
 builtin/diagnose.c                 | 1 +
 builtin/diff-files.c               | 2 +-
 builtin/diff-index.c               | 2 +-
 builtin/diff-tree.c                | 2 +-
 builtin/diff.c                     | 2 +-
 builtin/difftool.c                 | 3 ++-
 builtin/fast-export.c              | 1 +
 builtin/fast-import.c              | 2 +-
 builtin/fetch-pack.c               | 1 +
 builtin/fetch.c                    | 2 +-
 builtin/fmt-merge-msg.c            | 1 +
 builtin/for-each-ref.c             | 1 +
 builtin/for-each-repo.c            | 2 +-
 builtin/fsck.c                     | 2 +-
 builtin/fsmonitor--daemon.c        | 3 ++-
 builtin/gc.c                       | 3 +--
 builtin/get-tar-commit-id.c        | 1 +
 builtin/grep.c                     | 2 +-
 builtin/hash-object.c              | 1 +
 builtin/help.c                     | 2 ++
 builtin/hook.c                     | 1 +
 builtin/index-pack.c               | 1 +
 builtin/init-db.c                  | 2 +-
 builtin/interpret-trailers.c       | 2 +-
 builtin/log.c                      | 3 ++-
 builtin/ls-files.c                 | 2 +-
 builtin/ls-remote.c                | 1 +
 builtin/ls-tree.c                  | 2 ++
 builtin/mailinfo.c                 | 1 +
 builtin/mailsplit.c                | 1 +
 builtin/merge-base.c               | 2 +-
 builtin/merge-file.c               | 1 +
 builtin/merge-index.c              | 2 +-
 builtin/merge-ours.c               | 3 ++-
 builtin/merge-recursive.c          | 2 +-
 builtin/merge-tree.c               | 2 +-
 builtin/merge.c                    | 3 ++-
 builtin/mktag.c                    | 1 +
 builtin/mktree.c                   | 1 +
 builtin/multi-pack-index.c         | 1 +
 builtin/mv.c                       | 3 ++-
 builtin/name-rev.c                 | 2 +-
 builtin/notes.c                    | 4 ++--
 builtin/pack-objects.c             | 2 +-
 builtin/pack-redundant.c           | 3 ++-
 builtin/pack-refs.c                | 2 +-
 builtin/patch-id.c                 | 1 +
 builtin/prune-packed.c             | 1 +
 builtin/prune.c                    | 1 +
 builtin/pull.c                     | 1 +
 builtin/push.c                     | 2 +-
 builtin/range-diff.c               | 3 ++-
 builtin/read-tree.c                | 3 +--
 builtin/rebase.c                   | 3 ++-
 builtin/receive-pack.c             | 3 ++-
 builtin/reflog.c                   | 2 +-
 builtin/refs.c                     | 2 +-
 builtin/remote-ext.c               | 1 +
 builtin/remote-fd.c                | 1 +
 builtin/remote.c                   | 1 +
 builtin/repack.c                   | 1 +
 builtin/replace.c                  | 3 +--
 builtin/replay.c                   | 1 +
 builtin/rerere.c                   | 3 ++-
 builtin/reset.c                    | 2 +-
 builtin/rev-list.c                 | 1 +
 builtin/rev-parse.c                | 3 ++-
 builtin/revert.c                   | 2 +-
 builtin/rm.c                       | 4 ++--
 builtin/send-pack.c                | 1 +
 builtin/shortlog.c                 | 2 +-
 builtin/show-branch.c              | 3 ++-
 builtin/show-index.c               | 2 +-
 builtin/show-ref.c                 | 1 +
 builtin/sparse-checkout.c          | 2 +-
 builtin/stash.c                    | 1 +
 builtin/stripspace.c               | 1 +
 builtin/submodule--helper.c        | 3 ++-
 builtin/symbolic-ref.c             | 1 +
 builtin/tag.c                      | 2 +-
 builtin/unpack-file.c              | 1 +
 builtin/unpack-objects.c           | 1 +
 builtin/update-index.c             | 3 +--
 builtin/update-ref.c               | 2 +-
 builtin/update-server-info.c       | 1 +
 builtin/upload-archive.c           | 2 +-
 builtin/upload-pack.c              | 1 +
 builtin/var.c                      | 2 ++
 builtin/verify-commit.c            | 2 +-
 builtin/verify-pack.c              | 1 +
 builtin/verify-tag.c               | 1 +
 builtin/worktree.c                 | 2 +-
 builtin/write-tree.c               | 3 +--
 125 files changed, 147 insertions(+), 92 deletions(-)

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
index ba331519cac..c893ff48d26 100644
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
@@ -18,7 +18,6 @@
 #include "preload-index.h"
 #include "diff.h"
 #include "read-cache.h"
-#include "repository.h"
 #include "revision.h"
 #include "bulk-checkin.h"
 #include "strvec.h"
diff --git a/builtin/am.c b/builtin/am.c
index 8c610eed3e6..7693891fcde 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -4,6 +4,7 @@
  * Based on git-am.sh by Junio C Hamano.
  */
 
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "advice.h"
@@ -38,7 +39,6 @@
 #include "string-list.h"
 #include "pager.h"
 #include "path.h"
-#include "repository.h"
 #include "pretty.h"
 
 /**
diff --git a/builtin/annotate.c b/builtin/annotate.c
index 0abf89ef186..a99179fe4dd 100644
--- a/builtin/annotate.c
+++ b/builtin/annotate.c
@@ -3,6 +3,8 @@
  *
  * Copyright (C) 2006 Ryan Anderson
  */
+
+#define USE_THE_REPOSITORY_VARIABLE
 #include "git-compat-util.h"
 #include "builtin.h"
 #include "strvec.h"
diff --git a/builtin/apply.c b/builtin/apply.c
index ca0bb97df40..84f1863d3ac 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1,6 +1,6 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
-#include "repository.h"
 #include "hash.h"
 #include "apply.h"
 
diff --git a/builtin/archive.c b/builtin/archive.c
index 2b5dc5f43b0..dc926d1a3df 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -2,13 +2,13 @@
  * Copyright (c) 2006 Franck Bui-Huu
  * Copyright (c) 2006 Rene Scharfe
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "archive.h"
 #include "gettext.h"
 #include "transport.h"
 #include "parse-options.h"
 #include "pkt-line.h"
-#include "repository.h"
 
 static void create_output_file(const char *output_file)
 {
diff --git a/builtin/bisect.c b/builtin/bisect.c
index bec5cc749af..21d17a6c1a8 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "copy.h"
 #include "environment.h"
diff --git a/builtin/blame.c b/builtin/blame.c
index 728a62402b5..472dd762f41 100644
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
@@ -12,7 +12,6 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "repository.h"
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
diff --git a/builtin/branch.c b/builtin/branch.c
index 7980d2e83d6..7112459ebd1 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2006 Kristian Høgsberg <krh@redhat.com>
  * Based on git-branch.sh by Junio C Hamano.
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "color.h"
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index aeab40c4902..7c2df035c9c 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "editor.h"
diff --git a/builtin/bundle.c b/builtin/bundle.c
index 3fdd9195fd7..127518c2a8d 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "gettext.h"
@@ -5,7 +6,6 @@
 #include "strvec.h"
 #include "parse-options.h"
 #include "pkt-line.h"
-#include "repository.h"
 #include "bundle.h"
 
 /*
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b0ce49c9640..bfdfb51c7cb 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "convert.h"
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index ffd1067558d..7cf275b8937 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "attr.h"
@@ -5,7 +6,6 @@
 #include "gettext.h"
 #include "object-name.h"
 #include "quote.h"
-#include "repository.h"
 #include "setup.h"
 #include "parse-options.h"
 #include "write-or-die.h"
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 70565b9f892..7b7831d13a8 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "dir.h"
@@ -5,7 +6,6 @@
 #include "quote.h"
 #include "pathspec.h"
 #include "parse-options.h"
-#include "repository.h"
 #include "submodule.h"
 #include "write-or-die.h"
 
diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
index 422b6938788..df00b5ee13a 100644
--- a/builtin/check-mailmap.c
+++ b/builtin/check-mailmap.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index 6874edb4f41..65945171b3f 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -1,7 +1,7 @@
 /*
  * GIT - The information manager from hell
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "refs.h"
 #include "setup.h"
diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
index f53e1082690..ff6cdccc21d 100644
--- a/builtin/checkout--worker.c
+++ b/builtin/checkout--worker.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "entry.h"
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 98247ff8236..6dd38eb05d4 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -4,13 +4,12 @@
  * Copyright (C) 2005 Linus Torvalds
  *
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
 #include "lockfile.h"
 #include "quote.h"
-#include "repository.h"
 #include "cache-tree.h"
 #include "parse-options.h"
 #include "entry.h"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index d3bc48684f9..d6defc36b2b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "advice.h"
 #include "branch.h"
diff --git a/builtin/clean.c b/builtin/clean.c
index b5887f877e0..9c48dd02711 100644
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
@@ -14,7 +14,6 @@
 #include "parse-options.h"
 #include "path.h"
 #include "read-cache-ll.h"
-#include "repository.h"
 #include "setup.h"
 #include "string-list.h"
 #include "quote.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index 1b82310ac5b..e77339c8472 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -7,8 +7,9 @@
  *
  * Clone a repository into a different directory that does not yet exist.
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
+
 #include "abspath.h"
 #include "advice.h"
 #include "config.h"
diff --git a/builtin/column.c b/builtin/column.c
index 93f84beeee7..50314cc2559 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 65ce98d4675..81e577c14ae 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "commit.h"
 #include "config.h"
@@ -5,7 +6,6 @@
 #include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
-#include "repository.h"
 #include "commit-graph.h"
 #include "object-store-ll.h"
 #include "progress.h"
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index bd8bf3296ed..2ca1a57ebbb 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -3,13 +3,14 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
 #include "hex.h"
 #include "object-name.h"
 #include "object-store-ll.h"
-#include "repository.h"
+
 #include "commit.h"
 #include "parse-options.h"
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 768d76ac461..fd1cc42c5a6 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2007 Kristian Høgsberg <krh@redhat.com>
  * Based on git-commit.sh by Junio C Hamano and Linus Torvalds
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
diff --git a/builtin/config.c b/builtin/config.c
index c64baebb1ec..3eafea4936a 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -1,10 +1,10 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
 #include "color.h"
 #include "editor.h"
 #include "environment.h"
-#include "repository.h"
 #include "gettext.h"
 #include "ident.h"
 #include "parse-options.h"
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 6b905da3c3d..3d7b289f597 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -3,14 +3,13 @@
  *
  * Copyright (c) 2006 Junio C Hamano
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "path.h"
-#include "repository.h"
 #include "parse-options.h"
 #include "quote.h"
 #include "packfile.h"
diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 4caaf38b841..bc22f5c6d24 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "gettext.h"
diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index 5de8b9123bf..1918c474f02 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "credential.h"
 #include "gettext.h"
diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index 128704078e9..e669e99dbfb 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/credential.c b/builtin/credential.c
index 796422c6fe7..14c8c6608b2 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "credential.h"
 #include "builtin.h"
diff --git a/builtin/describe.c b/builtin/describe.c
index 1c1c250fe0c..7929223c8b2 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "environment.h"
diff --git a/builtin/diagnose.c b/builtin/diagnose.c
index 66a22d918e6..5ac7872b998 100644
--- a/builtin/diagnose.c
+++ b/builtin/diagnose.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "gettext.h"
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 7f4f9bcb3eb..b8ec420f867 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -3,13 +3,13 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
 #include "diff-merges.h"
 #include "commit.h"
 #include "preload-index.h"
-#include "repository.h"
 #include "revision.h"
 
 static const char diff_files_usage[] =
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 8abec38592f..e87f717d86e 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -1,10 +1,10 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
 #include "diff-merges.h"
 #include "commit.h"
 #include "preload-index.h"
-#include "repository.h"
 #include "revision.h"
 #include "setup.h"
 
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 841448b023f..715995c46fa 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
@@ -6,7 +7,6 @@
 #include "hex.h"
 #include "log-tree.h"
 #include "read-cache-ll.h"
-#include "repository.h"
 #include "revision.h"
 #include "tmp-objdir.h"
 #include "tree.h"
diff --git a/builtin/diff.c b/builtin/diff.c
index 499b7872dd4..63e790b2291 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2006 Junio C Hamano
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "ewah/ewok.h"
diff --git a/builtin/difftool.c b/builtin/difftool.c
index c8700d67f4d..f7dfa1fd0da 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -11,8 +11,9 @@
  *
  * Copyright (C) 2016 Johannes Schindelin
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
+
 #include "abspath.h"
 #include "config.h"
 #include "copy.h"
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 1bd5949dd24..e17f262e8e4 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2007 Johannes E. Schindelin
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 4b9e341aa44..1e7ab67f6e5 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1,9 +1,9 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "repository.h"
 #include "config.h"
 #include "lockfile.h"
 #include "object.h"
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index f12daa93498..49222a36fa6 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 2385ea4952e..c900f577219 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1,13 +1,13 @@
 /*
  * "git fetch"
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
 #include "gettext.h"
 #include "environment.h"
 #include "hex.h"
-#include "repository.h"
 #include "refs.h"
 #include "refspec.h"
 #include "object-name.h"
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 1fba4cf5590..324e904ac93 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "fmt-merge-msg.h"
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index b1187587135..8085ebd8fe9 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "commit.h"
 #include "config.h"
diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 93d82b952e9..fae7f91cf15 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -1,9 +1,9 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "path.h"
-#include "repository.h"
 #include "run-command.h"
 #include "string-list.h"
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 87068cee09d..7f4e2f04143 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1,7 +1,7 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "hex.h"
-#include "repository.h"
 #include "config.h"
 #include "commit.h"
 #include "tree.h"
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 73a4b885661..ba8a6eebe5d 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
@@ -11,7 +12,7 @@
 #include "compat/fsmonitor/fsm-health.h"
 #include "compat/fsmonitor/fsm-listen.h"
 #include "fsmonitor--daemon.h"
-#include "repository.h"
+
 #include "simple-ipc.h"
 #include "khash.h"
 #include "run-command.h"
diff --git a/builtin/gc.c b/builtin/gc.c
index 4469c058a02..a6dd2dea567 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -9,13 +9,12 @@
  *
  * Copyright (c) 2006 Shawn O. Pearce
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "date.h"
 #include "environment.h"
 #include "hex.h"
-#include "repository.h"
 #include "config.h"
 #include "tempfile.h"
 #include "lockfile.h"
diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index 6bec0d1854c..272384a6b15 100644
--- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (c) 2005, 2006 Rene Scharfe
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "commit.h"
 #include "tar.h"
diff --git a/builtin/grep.c b/builtin/grep.c
index da11879c637..bc3439cabd5 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -3,11 +3,11 @@
  *
  * Copyright (c) 2006 Junio C Hamano
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "gettext.h"
 #include "hex.h"
-#include "repository.h"
 #include "config.h"
 #include "tag.h"
 #include "tree-walk.h"
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 090daea5cd8..a25f0403f44 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -4,6 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  * Copyright (C) Junio C Hamano, 2005
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
diff --git a/builtin/help.c b/builtin/help.c
index f7723bdf5c8..9c4cfe11d9e 100644
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
index f02e2421ac0..367ef3e0b89 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index ece4648d047..e228c56ff27 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "delta.h"
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 94bd6075095..687cada4d7e 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "environment.h"
@@ -11,7 +12,6 @@
 #include "parse-options.h"
 #include "path.h"
 #include "refs.h"
-#include "repository.h"
 #include "setup.h"
 #include "strbuf.h"
 
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index fb93e54e5ea..44f83625c11 100644
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
index 67140575f4b..e4533a99fda 100644
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
@@ -37,7 +38,7 @@
 #include "mailmap.h"
 #include "progress.h"
 #include "commit-slab.h"
-#include "repository.h"
+
 #include "commit-reach.h"
 #include "range-diff.h"
 #include "tmp-objdir.h"
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 7f45cb62cf6..6aaba08e305 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -5,8 +5,8 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
-#include "repository.h"
 #include "config.h"
 #include "convert.h"
 #include "quote.h"
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index f2c2854d0c3..f723b3bf3bb 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 363cb948d92..8542b5d53e4 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -3,7 +3,9 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
+
 #include "config.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 00bfcd1afa0..e17dec27b1d 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -2,6 +2,7 @@
  * Another stupid program, this one parsing the headers of an
  * email to figure out authorship and subject
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "environment.h"
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index b8f7150ce9a..24254221417 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -4,6 +4,7 @@
  * It just splits a mbox into a list of files: "0001" "0002" ..
  * so you can process them further from there.
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "string-list.h"
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index afeae8d8346..a20c93b11aa 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "commit.h"
@@ -5,7 +6,6 @@
 #include "hex.h"
 #include "object-name.h"
 #include "parse-options.h"
-#include "repository.h"
 #include "commit-reach.h"
 
 static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index f785813ddae..cb42865eb52 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "diff.h"
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 1309a8ff471..a5b87ee3c5e 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,7 +1,7 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "hex.h"
 #include "read-cache-ll.h"
-#include "repository.h"
 #include "run-command.h"
 #include "sparse-index.h"
 
diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index 62267f12dd8..1fcf53f0054 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -7,10 +7,11 @@
  *
  * Pretend we resolved the heads, but declare our tree trumps everybody else.
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "git-compat-util.h"
 #include "builtin.h"
 #include "diff.h"
-#include "repository.h"
+
 
 static const char builtin_merge_ours_usage[] =
 	"git merge-ours <base>... -- HEAD <remote>...";
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index 2bd3fb0e553..1dd295558b2 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -1,10 +1,10 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "advice.h"
 #include "gettext.h"
 #include "hash.h"
 #include "merge-recursive.h"
 #include "object-name.h"
-#include "repository.h"
 
 static const char builtin_merge_recursive_usage[] =
 	"git %s <base>... -- <head> <remote> ...";
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index aeaec9d99f3..c5ed472967a 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "tree-walk.h"
 #include "xdiff-interface.h"
@@ -10,7 +11,6 @@
 #include "object-name.h"
 #include "object-store-ll.h"
 #include "parse-options.h"
-#include "repository.h"
 #include "blob.h"
 #include "merge-blobs.h"
 #include "quote.h"
diff --git a/builtin/merge.c b/builtin/merge.c
index fd6dc00d6c0..c54ac7b67c6 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -5,8 +5,9 @@
  *
  * Based on git-merge.sh by Junio C Hamano.
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
+
 #include "abspath.h"
 #include "advice.h"
 #include "config.h"
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 5cd8a3e6fa0..6e188dce50a 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 72a1af1bca5..3c16faa40e3 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -3,6 +3,7 @@
  *
  * Copyright (c) Junio C Hamano, 2006, 2009
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 154fc77075f..e397723fe09 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
diff --git a/builtin/mv.c b/builtin/mv.c
index 6e2eb9cf4b8..472a2787376 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2006 Johannes Schindelin
  */
+#define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
 #include "abspath.h"
@@ -18,7 +19,7 @@
 #include "string-list.h"
 #include "parse-options.h"
 #include "read-cache-ll.h"
-#include "repository.h"
+
 #include "setup.h"
 #include "strvec.h"
 #include "submodule.h"
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 19d92fb382d..7f08c38629c 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -1,8 +1,8 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "repository.h"
 #include "config.h"
 #include "commit.h"
 #include "tag.h"
diff --git a/builtin/notes.c b/builtin/notes.c
index 49d8364af60..55ce2eb919a 100644
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
@@ -17,7 +17,7 @@
 #include "object-name.h"
 #include "object-store-ll.h"
 #include "path.h"
-#include "repository.h"
+
 #include "pretty.h"
 #include "refs.h"
 #include "exec-cmd.h"
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0260a9886aa..ff2f906170a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1,8 +1,8 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "repository.h"
 #include "config.h"
 #include "attr.h"
 #include "object.h"
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 84f0d83affb..81f4494d466 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -5,11 +5,12 @@
 * This file is licensed under the GPL v2.
 *
 */
+#define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
 #include "gettext.h"
 #include "hex.h"
-#include "repository.h"
+
 #include "packfile.h"
 #include "object-store-ll.h"
 
diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 67dabb39756..2d83c1ed2ac 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -1,9 +1,9 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "refs.h"
-#include "repository.h"
 #include "revision.h"
 
 static char const * const pack_refs_usage[] = {
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index fa31a1b7a60..704044c2eb9 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index 4d63f26b0a1..0720d825c83 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "parse-options.h"
diff --git a/builtin/prune.c b/builtin/prune.c
index cbd4c38fa0a..f439d1b5bb9 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "commit.h"
 #include "diff.h"
diff --git a/builtin/pull.c b/builtin/pull.c
index 1a926f0b0d7..149f2013205 100644
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
index 9636ad52f4d..238cd5da829 100644
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
@@ -13,7 +14,6 @@
 #include "transport.h"
 #include "parse-options.h"
 #include "pkt-line.h"
-#include "repository.h"
 #include "submodule.h"
 #include "submodule-config.h"
 #include "send-pack.h"
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 3e67259aecc..1b33ab66a7b 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -1,10 +1,11 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "object-name.h"
 #include "parse-options.h"
 #include "range-diff.h"
 #include "config.h"
-#include "repository.h"
+
 
 static const char * const builtin_range_diff_usage[] = {
 N_("git range-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 89410db6a7a..d2a807a828b 100644
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
@@ -16,7 +16,6 @@
 #include "cache-tree.h"
 #include "unpack-trees.h"
 #include "parse-options.h"
-#include "repository.h"
 #include "resolve-undo.h"
 #include "setup.h"
 #include "sparse-index.h"
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 727d9df847f..d2ad7d08631 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -3,8 +3,9 @@
  *
  * Copyright (c) 2018 Pratik Karki
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
+
 #include "abspath.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 36a6229c2a4..c4b766c6137 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1,6 +1,7 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
-#include "repository.h"
+
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 6250f5ad49f..22df6834f71 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -1,7 +1,7 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
-#include "repository.h"
 #include "revision.h"
 #include "reachable.h"
 #include "wildmatch.h"
diff --git a/builtin/refs.c b/builtin/refs.c
index 70bca724d2a..24978a7b7b0 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -1,9 +1,9 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "fsck.h"
 #include "parse-options.h"
 #include "refs.h"
-#include "repository.h"
 #include "strbuf.h"
 
 #define REFS_MIGRATE_USAGE \
diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index 33c8ae0fc7d..119f33895e7 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "transport.h"
 #include "run-command.h"
diff --git a/builtin/remote-fd.c b/builtin/remote-fd.c
index ae896eda57b..b27ea81e4fb 100644
--- a/builtin/remote-fd.c
+++ b/builtin/remote-fd.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "transport.h"
 
diff --git a/builtin/remote.c b/builtin/remote.c
index a73eea9ae4c..76670ddd8b4 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/repack.c b/builtin/repack.c
index b0c7dd14338..f1295ffbb3b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "dir.h"
diff --git a/builtin/replace.c b/builtin/replace.c
index 293ae6d327f..2daed943735 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -7,7 +7,7 @@
  * and Carlos Rica <jasampler@gmail.com> that was itself based on
  * git-tag.sh and mktag.c by Linus Torvalds.
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "editor.h"
@@ -22,7 +22,6 @@
 #include "object-name.h"
 #include "object-store-ll.h"
 #include "replace-object.h"
-#include "repository.h"
 #include "tag.h"
 #include "wildmatch.h"
 
diff --git a/builtin/replay.c b/builtin/replay.c
index c8e9098fc12..2d12a4e403f 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -4,6 +4,7 @@
 
 #include "git-compat-util.h"
 
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "environment.h"
 #include "hex.h"
diff --git a/builtin/rerere.c b/builtin/rerere.c
index ae345155834..f7143c3f5d5 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -1,8 +1,9 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
 #include "parse-options.h"
-#include "repository.h"
+
 #include "string-list.h"
 #include "rerere.h"
 #include "xdiff/xdiff.h"
diff --git a/builtin/reset.c b/builtin/reset.c
index 75529072606..cb054c2cc0e 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -7,7 +7,7 @@
  *
  * Copyright (c) 2005, 2006 Linus Torvalds and Junio C Hamano
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index a4186d47ce3..f62bcbf2b14 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "commit.h"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 26190aaa3ed..f2d90f69952 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -3,8 +3,9 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
+
 #include "abspath.h"
 #include "config.h"
 #include "commit.h"
diff --git a/builtin/revert.c b/builtin/revert.c
index 5f2ec3ade73..55ba1092c52 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -1,9 +1,9 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "git-compat-util.h"
 #include "builtin.h"
 #include "parse-options.h"
 #include "diff.h"
 #include "gettext.h"
-#include "repository.h"
 #include "revision.h"
 #include "rerere.h"
 #include "sequencer.h"
diff --git a/builtin/rm.c b/builtin/rm.c
index 59077efa4b4..eaff027258d 100644
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
@@ -15,7 +15,7 @@
 #include "object-name.h"
 #include "parse-options.h"
 #include "read-cache.h"
-#include "repository.h"
+
 #include "string-list.h"
 #include "setup.h"
 #include "sparse-index.h"
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 522c2f4d133..81fc96d423a 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "hex.h"
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 70eb7890334..3ed5c460786 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "commit.h"
@@ -5,7 +6,6 @@
 #include "environment.h"
 #include "gettext.h"
 #include "string-list.h"
-#include "repository.h"
 #include "revision.h"
 #include "utf8.h"
 #include "mailmap.h"
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 05c10628df9..cd6bdf63bc1 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "environment.h"
@@ -10,7 +11,7 @@
 #include "strvec.h"
 #include "object-name.h"
 #include "parse-options.h"
-#include "repository.h"
+
 #include "dir.h"
 #include "commit-slab.h"
 #include "date.h"
diff --git a/builtin/show-index.c b/builtin/show-index.c
index 9e1f7ac9ca5..f164c01bbea 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -1,10 +1,10 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "hash.h"
 #include "hex.h"
 #include "pack.h"
 #include "parse-options.h"
-#include "repository.h"
 
 static const char *const show_index_usage[] = {
 	"git show-index [--object-format=<hash-algorithm>]",
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 6ee05f09a69..285cd3e4338 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 23f1548fe54..5e930e5d639 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "dir.h"
@@ -7,7 +8,6 @@
 #include "object-name.h"
 #include "parse-options.h"
 #include "pathspec.h"
-#include "repository.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "lockfile.h"
diff --git a/builtin/stash.c b/builtin/stash.c
index b10d41e1f2b..4c268f1ac5a 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 674ef939769..e147f3ff92c 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "environment.h"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index cc07ab46a33..51ff5fa54da 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1,9 +1,10 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "repository.h"
+
 #include "config.h"
 #include "parse-options.h"
 #include "quote.h"
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 9bc70229468..299d23d76a8 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/tag.c b/builtin/tag.c
index a80838eb8e0..ca2166e7e21 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -5,7 +5,7 @@
  *                    Carlos Rica <jasampler@gmail.com>
  * Based on git-tag.sh and mktag.c by Linus Torvalds.
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 97886840f8d..6da28257539 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "hex.h"
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 3bcdaaeb5fa..02b8d02f63f 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "bulk-checkin.h"
 #include "config.h"
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 1d1d87d08e3..a1a98aa7bca 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "bulk-checkin.h"
 #include "config.h"
@@ -22,7 +22,6 @@
 #include "pathspec.h"
 #include "dir.h"
 #include "read-cache.h"
-#include "repository.h"
 #include "setup.h"
 #include "sparse-index.h"
 #include "split-index.h"
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 06826a90515..8a98615dc86 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
@@ -6,7 +7,6 @@
 #include "object-name.h"
 #include "parse-options.h"
 #include "quote.h"
-#include "repository.h"
 
 static const char * const git_update_ref_usage[] = {
 	N_("git update-ref [<options>] -d <refname> [<old-oid>]"),
diff --git a/builtin/update-server-info.c b/builtin/update-server-info.c
index a5b7d86727c..6769611a025 100644
--- a/builtin/update-server-info.c
+++ b/builtin/update-server-info.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index dd84c83f137..9e9343f1213 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -1,12 +1,12 @@
 /*
  * Copyright (c) 2006 Franck Bui-Huu
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "archive.h"
 #include "path.h"
 #include "pkt-line.h"
 #include "sideband.h"
-#include "repository.h"
 #include "run-command.h"
 #include "strvec.h"
 
diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index 3b6c83fbce3..363091c31e8 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "exec-cmd.h"
 #include "gettext.h"
diff --git a/builtin/var.c b/builtin/var.c
index 4a5c2649d6f..2ecaed51b44 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -3,7 +3,9 @@
  *
  * Copyright (C) Eric Biederman, 2005
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
+
 #include "attr.h"
 #include "config.h"
 #include "editor.h"
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index c5859e5b2b4..779b7988ca9 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -5,11 +5,11 @@
  *
  * Based on git-verify-tag
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
 #include "object-name.h"
-#include "repository.h"
 #include "commit.h"
 #include "parse-options.h"
 #include "gpg-interface.h"
diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index 7ad456649d2..34e4ed715f3 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index a7bef524191..f6b97048a57 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -5,6 +5,7 @@
  *
  * Based on git-verify-tag.sh
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 3b47f9832fa..c22b2e95f50 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "advice.h"
@@ -17,7 +18,6 @@
 #include "read-cache-ll.h"
 #include "refs.h"
 #include "remote.h"
-#include "repository.h"
 #include "run-command.h"
 #include "hook.h"
 #include "sigchain.h"
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index 1b467d6ed23..de4ebf767d4 100644
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
@@ -12,7 +12,6 @@
 #include "tree.h"
 #include "cache-tree.h"
 #include "parse-options.h"
-#include "repository.h"
 
 static const char * const write_tree_usage[] = {
 	N_("git write-tree [--missing-ok] [--prefix=<prefix>/]"),
-- 
gitgitgadget

