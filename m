Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 208621F406
	for <e@80x24.org>; Tue, 12 Dec 2017 19:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbdLLTAc (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 14:00:32 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:38481 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752432AbdLLTAb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 14:00:31 -0500
Received: by mail-it0-f50.google.com with SMTP id r6so697429itr.3
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 11:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DgD4FXDVzLpwCvbwdCAQxH1t5XrXRYguIL/V2m/o5tw=;
        b=HEBfz0a1W7djhfXoRzjXdwEDeTElDbPK57YiKv42+COVFXNIFNKk1fVImzvfuQT0KF
         EgHTwTUsdLFVE2N7rCJ4+eEGoN+OovOKFJEpkM4vcK1l0z4UAs79fxreCSvyjR6ADb3K
         eGzr7UE7pI6gb5+Ev8szaHUyzvcPUHpC68KQQwVP865yR+ThXsKKjk1L9+Dv+uMRgd4F
         JRNl8fGaSmv7U3foU8yVCKcsztI9AeHbMOUaGNLQ+Rzq0Th3A6f0Ys3jqWujG59GKcs0
         ZAvwzY2aqe1yax6Bn8UY6pNQE33vPQ3r/R3Q8GZIMOkWOlY8CPJlnIXUNAlMcNG0UVix
         cLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DgD4FXDVzLpwCvbwdCAQxH1t5XrXRYguIL/V2m/o5tw=;
        b=OBH/idLyEb9Yq9+5DO2IziZhyuhpF7i+1s2D1ufn7qi1cAlxESvveFDstQZUpM6BO4
         QaIXOzM9038/UUji0I3gtiOigmhD06VNyBOT0KYpXZVuSJ9Uc58gb6RqUt+qHTbPGij6
         EY1IPKdTs/EhaScPlORPSMGfdbVb65nTY/r0zbS10ppj/KUvc2aloodQeaKAYBl+sPxs
         FCLftRkK6I6ILQ5apYPZh+quHfdur98sxbWtoE473C4LnlPJ4bGXzkwW/3M+y0dpQ+uz
         /jSafVNeAUhUgpYtSm+LeCI4jYZPHjPCtoh7ugQLaUH8dnJQUdree9Fmbq2vBtInieUB
         RH6A==
X-Gm-Message-State: AKGB3mKJPxtv6uLvN9t9vvxvxfacG/BZIhId9Zja9wwq/JiS+i9IjV8w
        oMEthSYcpujAo8Pz9ocXadI/gw==
X-Google-Smtp-Source: ACJfBou+D93xGtjjHSrLM+GSuAK2KT0Dl3vKqDlnLFZSppuCKuOPOfC472cuq+peGg6RFPA0A2WoPw==
X-Received: by 10.36.69.234 with SMTP id c103mr853408itd.150.1513105230397;
        Tue, 12 Dec 2017 11:00:30 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 124sm97374itw.30.2017.12.12.11.00.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Dec 2017 11:00:29 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     dnj@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, judge.packham@gmail.com,
        kostix+git@007spb.ru, manschwetus@cs-software-gmbh.de,
        max@max630.net, peff@peff.net, sunshine@sunshineco.com,
        Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH] t/helper: Move sources to t/helper-src; gitignore any files in t/helper
Date:   Tue, 12 Dec 2017 11:00:26 -0800
Message-Id: <20171212190026.17671-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.504.g5279b80103-goog
In-Reply-To: <20171212161701.4272-1-dnj@google.com>
References: <20171212161701.4272-1-dnj@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compiled test helpers in t/helper are out of sync with the .gitignore
files quite frequently. This can happen when new test helpers are added,
but the explicit .gitignore file is not updated in the same commit, or
when you forget to 'make clean' before checking out a different version
of git, as the different version may have a different explicit list of
test helpers to ignore.

This can be fixed by using overly broad ignore patterns, such as ignoring
the whole directory via '//t/helper/*' in .gitignore.

However we do not want to have an overlap of checked source files and
ignored files, hence we'll move the the source files currently residing
in t/helper to t/helper-src. To accommodate that we'll need to update
the Makefile as well to look at a different place for the source files.
(This patch takes the hacky approach in symlinking the sources back into
the t/helper, which we'd want to avoid long term)

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Makefile                                           |  4 +++
 t/{helper => helper-src}/.gitignore                |  0
 t/{helper => helper-src}/test-chmtime.c            |  0
 t/{helper => helper-src}/test-config.c             |  0
 t/{helper => helper-src}/test-ctype.c              |  0
 t/{helper => helper-src}/test-date.c               |  0
 t/{helper => helper-src}/test-delta.c              |  0
 t/{helper => helper-src}/test-dump-cache-tree.c    |  0
 t/{helper => helper-src}/test-dump-split-index.c   |  0
 .../test-dump-untracked-cache.c                    |  0
 t/{helper => helper-src}/test-fake-ssh.c           |  0
 t/{helper => helper-src}/test-genrandom.c          |  0
 t/{helper => helper-src}/test-hashmap.c            |  0
 t/{helper => helper-src}/test-index-version.c      |  0
 .../test-lazy-init-name-hash.c                     |  0
 t/{helper => helper-src}/test-line-buffer.c        |  0
 t/{helper => helper-src}/test-match-trees.c        |  0
 t/{helper => helper-src}/test-mergesort.c          |  0
 t/{helper => helper-src}/test-mktemp.c             |  0
 t/{helper => helper-src}/test-online-cpus.c        |  0
 t/{helper => helper-src}/test-parse-options.c      |  0
 t/{helper => helper-src}/test-path-utils.c         |  0
 t/{helper => helper-src}/test-prio-queue.c         |  0
 t/{helper => helper-src}/test-read-cache.c         |  0
 t/{helper => helper-src}/test-ref-store.c          |  0
 t/{helper => helper-src}/test-regex.c              |  0
 t/{helper => helper-src}/test-revision-walking.c   |  0
 t/{helper => helper-src}/test-run-command.c        |  0
 t/{helper => helper-src}/test-scrap-cache-tree.c   |  0
 t/{helper => helper-src}/test-sha1-array.c         |  0
 t/{helper => helper-src}/test-sha1.c               |  0
 t/{helper => helper-src}/test-sha1.sh              |  0
 t/{helper => helper-src}/test-sigchain.c           |  0
 t/{helper => helper-src}/test-strcmp-offset.c      |  0
 t/{helper => helper-src}/test-string-list.c        |  0
 t/{helper => helper-src}/test-submodule-config.c   |  0
 t/{helper => helper-src}/test-subprocess.c         |  0
 t/{helper => helper-src}/test-svn-fe.c             |  0
 .../test-urlmatch-normalization.c                  |  0
 t/{helper => helper-src}/test-wildmatch.c          |  0
 t/{helper => helper-src}/test-write-cache.c        |  0
 t/helper/.gitignore                                | 39 +---------------------
 42 files changed, 5 insertions(+), 38 deletions(-)
 copy t/{helper => helper-src}/.gitignore (100%)
 rename t/{helper => helper-src}/test-chmtime.c (100%)
 rename t/{helper => helper-src}/test-config.c (100%)
 rename t/{helper => helper-src}/test-ctype.c (100%)
 rename t/{helper => helper-src}/test-date.c (100%)
 rename t/{helper => helper-src}/test-delta.c (100%)
 rename t/{helper => helper-src}/test-dump-cache-tree.c (100%)
 rename t/{helper => helper-src}/test-dump-split-index.c (100%)
 rename t/{helper => helper-src}/test-dump-untracked-cache.c (100%)
 rename t/{helper => helper-src}/test-fake-ssh.c (100%)
 rename t/{helper => helper-src}/test-genrandom.c (100%)
 rename t/{helper => helper-src}/test-hashmap.c (100%)
 rename t/{helper => helper-src}/test-index-version.c (100%)
 rename t/{helper => helper-src}/test-lazy-init-name-hash.c (100%)
 rename t/{helper => helper-src}/test-line-buffer.c (100%)
 rename t/{helper => helper-src}/test-match-trees.c (100%)
 rename t/{helper => helper-src}/test-mergesort.c (100%)
 rename t/{helper => helper-src}/test-mktemp.c (100%)
 rename t/{helper => helper-src}/test-online-cpus.c (100%)
 rename t/{helper => helper-src}/test-parse-options.c (100%)
 rename t/{helper => helper-src}/test-path-utils.c (100%)
 rename t/{helper => helper-src}/test-prio-queue.c (100%)
 rename t/{helper => helper-src}/test-read-cache.c (100%)
 rename t/{helper => helper-src}/test-ref-store.c (100%)
 rename t/{helper => helper-src}/test-regex.c (100%)
 rename t/{helper => helper-src}/test-revision-walking.c (100%)
 rename t/{helper => helper-src}/test-run-command.c (100%)
 rename t/{helper => helper-src}/test-scrap-cache-tree.c (100%)
 rename t/{helper => helper-src}/test-sha1-array.c (100%)
 rename t/{helper => helper-src}/test-sha1.c (100%)
 rename t/{helper => helper-src}/test-sha1.sh (100%)
 rename t/{helper => helper-src}/test-sigchain.c (100%)
 rename t/{helper => helper-src}/test-strcmp-offset.c (100%)
 rename t/{helper => helper-src}/test-string-list.c (100%)
 rename t/{helper => helper-src}/test-submodule-config.c (100%)
 rename t/{helper => helper-src}/test-subprocess.c (100%)
 rename t/{helper => helper-src}/test-svn-fe.c (100%)
 rename t/{helper => helper-src}/test-urlmatch-normalization.c (100%)
 rename t/{helper => helper-src}/test-wildmatch.c (100%)
 rename t/{helper => helper-src}/test-write-cache.c (100%)
 rewrite t/helper/.gitignore (100%)

diff --git a/Makefile b/Makefile
index c26596c30a..477ddef820 100644
--- a/Makefile
+++ b/Makefile
@@ -2454,6 +2454,10 @@ t/helper/test-svn-fe$X: $(VCSSVN_LIB)
 t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
+t/helper/test-%.c: t/helper-src/test-%.c
+	@echo $@ $<
+	ln -s ../../$< $@
+
 check-sha1:: t/helper/test-sha1$X
 	t/helper/test-sha1.sh
 
diff --git a/t/helper/.gitignore b/t/helper-src/.gitignore
similarity index 100%
copy from t/helper/.gitignore
copy to t/helper-src/.gitignore
diff --git a/t/helper/test-chmtime.c b/t/helper-src/test-chmtime.c
similarity index 100%
rename from t/helper/test-chmtime.c
rename to t/helper-src/test-chmtime.c
diff --git a/t/helper/test-config.c b/t/helper-src/test-config.c
similarity index 100%
rename from t/helper/test-config.c
rename to t/helper-src/test-config.c
diff --git a/t/helper/test-ctype.c b/t/helper-src/test-ctype.c
similarity index 100%
rename from t/helper/test-ctype.c
rename to t/helper-src/test-ctype.c
diff --git a/t/helper/test-date.c b/t/helper-src/test-date.c
similarity index 100%
rename from t/helper/test-date.c
rename to t/helper-src/test-date.c
diff --git a/t/helper/test-delta.c b/t/helper-src/test-delta.c
similarity index 100%
rename from t/helper/test-delta.c
rename to t/helper-src/test-delta.c
diff --git a/t/helper/test-dump-cache-tree.c b/t/helper-src/test-dump-cache-tree.c
similarity index 100%
rename from t/helper/test-dump-cache-tree.c
rename to t/helper-src/test-dump-cache-tree.c
diff --git a/t/helper/test-dump-split-index.c b/t/helper-src/test-dump-split-index.c
similarity index 100%
rename from t/helper/test-dump-split-index.c
rename to t/helper-src/test-dump-split-index.c
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper-src/test-dump-untracked-cache.c
similarity index 100%
rename from t/helper/test-dump-untracked-cache.c
rename to t/helper-src/test-dump-untracked-cache.c
diff --git a/t/helper/test-fake-ssh.c b/t/helper-src/test-fake-ssh.c
similarity index 100%
rename from t/helper/test-fake-ssh.c
rename to t/helper-src/test-fake-ssh.c
diff --git a/t/helper/test-genrandom.c b/t/helper-src/test-genrandom.c
similarity index 100%
rename from t/helper/test-genrandom.c
rename to t/helper-src/test-genrandom.c
diff --git a/t/helper/test-hashmap.c b/t/helper-src/test-hashmap.c
similarity index 100%
rename from t/helper/test-hashmap.c
rename to t/helper-src/test-hashmap.c
diff --git a/t/helper/test-index-version.c b/t/helper-src/test-index-version.c
similarity index 100%
rename from t/helper/test-index-version.c
rename to t/helper-src/test-index-version.c
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper-src/test-lazy-init-name-hash.c
similarity index 100%
rename from t/helper/test-lazy-init-name-hash.c
rename to t/helper-src/test-lazy-init-name-hash.c
diff --git a/t/helper/test-line-buffer.c b/t/helper-src/test-line-buffer.c
similarity index 100%
rename from t/helper/test-line-buffer.c
rename to t/helper-src/test-line-buffer.c
diff --git a/t/helper/test-match-trees.c b/t/helper-src/test-match-trees.c
similarity index 100%
rename from t/helper/test-match-trees.c
rename to t/helper-src/test-match-trees.c
diff --git a/t/helper/test-mergesort.c b/t/helper-src/test-mergesort.c
similarity index 100%
rename from t/helper/test-mergesort.c
rename to t/helper-src/test-mergesort.c
diff --git a/t/helper/test-mktemp.c b/t/helper-src/test-mktemp.c
similarity index 100%
rename from t/helper/test-mktemp.c
rename to t/helper-src/test-mktemp.c
diff --git a/t/helper/test-online-cpus.c b/t/helper-src/test-online-cpus.c
similarity index 100%
rename from t/helper/test-online-cpus.c
rename to t/helper-src/test-online-cpus.c
diff --git a/t/helper/test-parse-options.c b/t/helper-src/test-parse-options.c
similarity index 100%
rename from t/helper/test-parse-options.c
rename to t/helper-src/test-parse-options.c
diff --git a/t/helper/test-path-utils.c b/t/helper-src/test-path-utils.c
similarity index 100%
rename from t/helper/test-path-utils.c
rename to t/helper-src/test-path-utils.c
diff --git a/t/helper/test-prio-queue.c b/t/helper-src/test-prio-queue.c
similarity index 100%
rename from t/helper/test-prio-queue.c
rename to t/helper-src/test-prio-queue.c
diff --git a/t/helper/test-read-cache.c b/t/helper-src/test-read-cache.c
similarity index 100%
rename from t/helper/test-read-cache.c
rename to t/helper-src/test-read-cache.c
diff --git a/t/helper/test-ref-store.c b/t/helper-src/test-ref-store.c
similarity index 100%
rename from t/helper/test-ref-store.c
rename to t/helper-src/test-ref-store.c
diff --git a/t/helper/test-regex.c b/t/helper-src/test-regex.c
similarity index 100%
rename from t/helper/test-regex.c
rename to t/helper-src/test-regex.c
diff --git a/t/helper/test-revision-walking.c b/t/helper-src/test-revision-walking.c
similarity index 100%
rename from t/helper/test-revision-walking.c
rename to t/helper-src/test-revision-walking.c
diff --git a/t/helper/test-run-command.c b/t/helper-src/test-run-command.c
similarity index 100%
rename from t/helper/test-run-command.c
rename to t/helper-src/test-run-command.c
diff --git a/t/helper/test-scrap-cache-tree.c b/t/helper-src/test-scrap-cache-tree.c
similarity index 100%
rename from t/helper/test-scrap-cache-tree.c
rename to t/helper-src/test-scrap-cache-tree.c
diff --git a/t/helper/test-sha1-array.c b/t/helper-src/test-sha1-array.c
similarity index 100%
rename from t/helper/test-sha1-array.c
rename to t/helper-src/test-sha1-array.c
diff --git a/t/helper/test-sha1.c b/t/helper-src/test-sha1.c
similarity index 100%
rename from t/helper/test-sha1.c
rename to t/helper-src/test-sha1.c
diff --git a/t/helper/test-sha1.sh b/t/helper-src/test-sha1.sh
similarity index 100%
rename from t/helper/test-sha1.sh
rename to t/helper-src/test-sha1.sh
diff --git a/t/helper/test-sigchain.c b/t/helper-src/test-sigchain.c
similarity index 100%
rename from t/helper/test-sigchain.c
rename to t/helper-src/test-sigchain.c
diff --git a/t/helper/test-strcmp-offset.c b/t/helper-src/test-strcmp-offset.c
similarity index 100%
rename from t/helper/test-strcmp-offset.c
rename to t/helper-src/test-strcmp-offset.c
diff --git a/t/helper/test-string-list.c b/t/helper-src/test-string-list.c
similarity index 100%
rename from t/helper/test-string-list.c
rename to t/helper-src/test-string-list.c
diff --git a/t/helper/test-submodule-config.c b/t/helper-src/test-submodule-config.c
similarity index 100%
rename from t/helper/test-submodule-config.c
rename to t/helper-src/test-submodule-config.c
diff --git a/t/helper/test-subprocess.c b/t/helper-src/test-subprocess.c
similarity index 100%
rename from t/helper/test-subprocess.c
rename to t/helper-src/test-subprocess.c
diff --git a/t/helper/test-svn-fe.c b/t/helper-src/test-svn-fe.c
similarity index 100%
rename from t/helper/test-svn-fe.c
rename to t/helper-src/test-svn-fe.c
diff --git a/t/helper/test-urlmatch-normalization.c b/t/helper-src/test-urlmatch-normalization.c
similarity index 100%
rename from t/helper/test-urlmatch-normalization.c
rename to t/helper-src/test-urlmatch-normalization.c
diff --git a/t/helper/test-wildmatch.c b/t/helper-src/test-wildmatch.c
similarity index 100%
rename from t/helper/test-wildmatch.c
rename to t/helper-src/test-wildmatch.c
diff --git a/t/helper/test-write-cache.c b/t/helper-src/test-write-cache.c
similarity index 100%
rename from t/helper/test-write-cache.c
rename to t/helper-src/test-write-cache.c
diff --git a/t/helper/.gitignore b/t/helper/.gitignore
dissimilarity index 100%
index 7c9d28a834..72e8ffc0db 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -1,38 +1 @@
-/test-chmtime
-/test-ctype
-/test-config
-/test-date
-/test-delta
-/test-dump-cache-tree
-/test-dump-split-index
-/test-dump-untracked-cache
-/test-fake-ssh
-/test-scrap-cache-tree
-/test-genrandom
-/test-hashmap
-/test-index-version
-/test-lazy-init-name-hash
-/test-line-buffer
-/test-match-trees
-/test-mergesort
-/test-mktemp
-/test-online-cpus
-/test-parse-options
-/test-path-utils
-/test-prio-queue
-/test-read-cache
-/test-ref-store
-/test-regex
-/test-revision-walking
-/test-run-command
-/test-sha1
-/test-sha1-array
-/test-sigchain
-/test-strcmp-offset
-/test-string-list
-/test-submodule-config
-/test-subprocess
-/test-svn-fe
-/test-urlmatch-normalization
-/test-wildmatch
-/test-write-cache
+*
-- 
2.15.1.504.g5279b80103-goog

