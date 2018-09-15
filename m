Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F6211F404
	for <e@80x24.org>; Sat, 15 Sep 2018 17:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeIOXQH (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 19:16:07 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:45833 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeIOXQH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 19:16:07 -0400
Received: by mail-lj1-f179.google.com with SMTP id u83-v6so9936151lje.12
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 10:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zDD7yWoGcRga8yERGZE6K71zYkhGmWE3f4EymhvBqh0=;
        b=XFg9voFyEj6TimWTxrq2uNWUYHp1mSo2/WnwyUtscj+GAU+voUWl7VyLvG2E4Rh+Yx
         0MqGqujAZg+z2b1G1FM4+8Nq51GZwNheuo78jLO9SIgq3/tQR17CE7JnndMjNFivjVVP
         IzPZdnRlyHkket5jd914Uz4qePUncvki+93PA1xH3z668TTtwvnlxGxSKJzpwrJnpG9/
         nZPghNQYJHy5o9IgBmA8bt66oKrThlKKV6MP847fyhWerHhvqAmgAskuWXlgQ8nfYihg
         1FtmEpGCcqJkISI6hIDFIjzWjC0AsJxWid9iVei8E6stHFnaGHNtct3etx+lj7Z9I5Dp
         XmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zDD7yWoGcRga8yERGZE6K71zYkhGmWE3f4EymhvBqh0=;
        b=qs0OV0OAqPTxuZi0l9xbN9miErkRF63eJylmQiXzZGmPgNpdD2vHdmtVvAahGyUKra
         pmHsN0cNWuBZMSTTQPdyQnTkB/3NAGqY2vDGo6l4FoikG+t+KISZfqwcq99jM1xBJJoZ
         0ir6eMK+xZa5HXQqo4C3AHBif71FB7CzctLEGM8m1K48SvBTMQhb99ZGGfFx+Nt7DEsi
         idpLAC4/J67Eudsh0BotMEL6jujCz8qzaYwlTwqemV289vejKvKRT2SFdDx6k1td1OBb
         3r6s7mTy5+LtYrnRlLo1p2tYJKsr/S1RVIktNmars/6NqARRhOSBOlhRVU4+EgYwdgho
         isfg==
X-Gm-Message-State: APzg51Ct0srQYFrVWn6lMUjp2MC3wTSjug3mLm9VOLwbkHK0hKdGf3bz
        7YAlVyRcyWHWyaZEzqmADgfNdeDo
X-Google-Smtp-Source: ANB0VdaUOqShKBVKJ8q9j1tV1cLjOLDRQWXAyVa27kiaCQHTIq7HMeierBfJwBy+6USjsCdQWrJo7g==
X-Received: by 2002:a2e:9e55:: with SMTP id g21-v6mr11615223ljk.116.1537034176562;
        Sat, 15 Sep 2018 10:56:16 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id b68-v6sm1894277ljb.62.2018.09.15.10.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 10:56:15 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2] status: show progress bar if refreshing the index takes too long
Date:   Sat, 15 Sep 2018 19:56:04 +0200
Message-Id: <20180915175604.27801-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180907155133.27737-1-pclouds@gmail.com>
References: <20180907155133.27737-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refreshing the index is usually very fast, but it can still take a
long time sometimes. Cold cache is one. Or copying a repo to a new
place (*). It's good to show something to let the user know "git
status" is not hanging, it's just busy doing something.

(*) In this case, all stat info in the index becomes invalid and git
    falls back to rehashing all file content to see if there's any
    difference between updating stat info in the index. This is quite
    expensive. Even with a repo as small as git.git, it takes 3
    seconds.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v2 changes

  - call stop_progress() without checking if the progress_data object
    is NULL.

  - disable progress bar when outputting porcelain formats

 builtin/am.c     |  2 +-
 builtin/commit.c | 10 ++++++++--
 cache.h          |  7 +++++--
 preload-index.c  | 50 +++++++++++++++++++++++++++++++++++++++++++-----
 read-cache.c     | 12 ++++++++++++
 sequencer.c      |  2 +-
 6 files changed, 72 insertions(+), 11 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 5e866d17c7..22a93cfef3 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2324,7 +2324,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	/* Ensure a valid committer ident can be constructed */
 	git_committer_info(IDENT_STRICT);
 
-	if (read_index_preload(&the_index, NULL) < 0)
+	if (read_index_preload(&the_index, NULL, 0) < 0)
 		die(_("failed to read the index"));
 
 	if (in_progress) {
diff --git a/builtin/commit.c b/builtin/commit.c
index 0d9828e29e..7523463066 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1295,6 +1295,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	static int no_renames = -1;
 	static const char *rename_score_arg = (const char *)-1;
 	static struct wt_status s;
+	unsigned int progress_flag = 0;
 	int fd;
 	struct object_id oid;
 	static struct option builtin_status_options[] = {
@@ -1355,8 +1356,13 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		       PATHSPEC_PREFER_FULL,
 		       prefix, argv);
 
-	read_cache_preload(&s.pathspec);
-	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, &s.pathspec, NULL, NULL);
+	if (status_format != STATUS_FORMAT_PORCELAIN &&
+	    status_format != STATUS_FORMAT_PORCELAIN_V2)
+		progress_flag = REFRESH_PROGRESS;
+	read_index_preload(&the_index, &s.pathspec, progress_flag);
+	refresh_index(&the_index,
+		      REFRESH_QUIET|REFRESH_UNMERGED|progress_flag,
+		      &s.pathspec, NULL, NULL);
 
 	if (use_optional_locks())
 		fd = hold_locked_index(&index_lock, 0);
diff --git a/cache.h b/cache.h
index 4d014541ab..35da02be90 100644
--- a/cache.h
+++ b/cache.h
@@ -410,7 +410,7 @@ void validate_cache_entries(const struct index_state *istate);
 
 #define read_cache() read_index(&the_index)
 #define read_cache_from(path) read_index_from(&the_index, (path), (get_git_dir()))
-#define read_cache_preload(pathspec) read_index_preload(&the_index, (pathspec))
+#define read_cache_preload(pathspec) read_index_preload(&the_index, (pathspec), 0)
 #define is_cache_unborn() is_index_unborn(&the_index)
 #define read_cache_unmerged() read_index_unmerged(&the_index)
 #define discard_cache() discard_index(&the_index)
@@ -659,7 +659,9 @@ extern int daemonize(void);
 /* Initialize and use the cache information */
 struct lock_file;
 extern int read_index(struct index_state *);
-extern int read_index_preload(struct index_state *, const struct pathspec *pathspec);
+extern int read_index_preload(struct index_state *,
+			      const struct pathspec *pathspec,
+			      unsigned int refresh_flags);
 extern int do_read_index(struct index_state *istate, const char *path,
 			 int must_exist); /* for testting only! */
 extern int read_index_from(struct index_state *, const char *path,
@@ -814,6 +816,7 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 #define REFRESH_IGNORE_MISSING	0x0008	/* ignore non-existent */
 #define REFRESH_IGNORE_SUBMODULES	0x0010	/* ignore submodules */
 #define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not "needs update" */
+#define REFRESH_PROGRESS	0x0040  /* show progress bar if stderr is tty */
 extern int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
 extern struct cache_entry *refresh_cache_entry(struct index_state *, struct cache_entry *, unsigned int);
 
diff --git a/preload-index.c b/preload-index.c
index 71cd2437a3..2541b307e8 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -5,10 +5,12 @@
 #include "pathspec.h"
 #include "dir.h"
 #include "fsmonitor.h"
+#include "progress.h"
 
 #ifdef NO_PTHREADS
 static void preload_index(struct index_state *index,
-			  const struct pathspec *pathspec)
+			  const struct pathspec *pathspec,
+			  unsigned int refresh_flags)
 {
 	; /* nothing */
 }
@@ -25,16 +27,23 @@ static void preload_index(struct index_state *index,
 #define MAX_PARALLEL (20)
 #define THREAD_COST (500)
 
+struct progress_data {
+	unsigned long n;
+	struct progress *progress;
+	pthread_mutex_t mutex;
+};
+
 struct thread_data {
 	pthread_t pthread;
 	struct index_state *index;
 	struct pathspec pathspec;
+	struct progress_data *progress;
 	int offset, nr;
 };
 
 static void *preload_thread(void *_data)
 {
-	int nr;
+	int nr, last_nr;
 	struct thread_data *p = _data;
 	struct index_state *index = p->index;
 	struct cache_entry **cep = index->cache + p->offset;
@@ -43,6 +52,7 @@ static void *preload_thread(void *_data)
 	nr = p->nr;
 	if (nr + p->offset > index->cache_nr)
 		nr = index->cache_nr - p->offset;
+	last_nr = nr;
 
 	do {
 		struct cache_entry *ce = *cep++;
@@ -58,6 +68,15 @@ static void *preload_thread(void *_data)
 			continue;
 		if (ce->ce_flags & CE_FSMONITOR_VALID)
 			continue;
+		if (p->progress && !(nr & 31)) {
+			struct progress_data *pd = p->progress;
+
+			pthread_mutex_lock(&pd->mutex);
+			pd->n += last_nr - nr;
+			display_progress(pd->progress, pd->n);
+			pthread_mutex_unlock(&pd->mutex);
+			last_nr = nr;
+		}
 		if (!ce_path_match(index, ce, &p->pathspec, NULL))
 			continue;
 		if (threaded_has_symlink_leading_path(&cache, ce->name, ce_namelen(ce)))
@@ -69,16 +88,25 @@ static void *preload_thread(void *_data)
 		ce_mark_uptodate(ce);
 		mark_fsmonitor_valid(ce);
 	} while (--nr > 0);
+	if (p->progress) {
+		struct progress_data *pd = p->progress;
+
+		pthread_mutex_lock(&pd->mutex);
+		display_progress(pd->progress, pd->n + last_nr);
+		pthread_mutex_unlock(&pd->mutex);
+	}
 	cache_def_clear(&cache);
 	return NULL;
 }
 
 static void preload_index(struct index_state *index,
-			  const struct pathspec *pathspec)
+			  const struct pathspec *pathspec,
+			  unsigned int refresh_flags)
 {
 	int threads, i, work, offset;
 	struct thread_data data[MAX_PARALLEL];
 	uint64_t start = getnanotime();
+	struct progress_data pd;
 
 	if (!core_preload_index)
 		return;
@@ -93,6 +121,13 @@ static void preload_index(struct index_state *index,
 	offset = 0;
 	work = DIV_ROUND_UP(index->cache_nr, threads);
 	memset(&data, 0, sizeof(data));
+
+	memset(&pd, 0, sizeof(pd));
+	if (refresh_flags & REFRESH_PROGRESS && isatty(2)) {
+		pd.progress = start_delayed_progress(_("Refreshing index"), index->cache_nr);
+		pthread_mutex_init(&pd.mutex, NULL);
+	}
+
 	for (i = 0; i < threads; i++) {
 		struct thread_data *p = data+i;
 		p->index = index;
@@ -100,6 +135,8 @@ static void preload_index(struct index_state *index,
 			copy_pathspec(&p->pathspec, pathspec);
 		p->offset = offset;
 		p->nr = work;
+		if (pd.progress)
+			p->progress = &pd;
 		offset += work;
 		if (pthread_create(&p->pthread, NULL, preload_thread, p))
 			die("unable to create threaded lstat");
@@ -109,15 +146,18 @@ static void preload_index(struct index_state *index,
 		if (pthread_join(p->pthread, NULL))
 			die("unable to join threaded lstat");
 	}
+	stop_progress(&pd.progress);
+
 	trace_performance_since(start, "preload index");
 }
 #endif
 
 int read_index_preload(struct index_state *index,
-		       const struct pathspec *pathspec)
+		       const struct pathspec *pathspec,
+		       unsigned int refresh_flags)
 {
 	int retval = read_index(index);
 
-	preload_index(index, pathspec);
+	preload_index(index, pathspec, refresh_flags);
 	return retval;
 }
diff --git a/read-cache.c b/read-cache.c
index 7b1354d759..5969ca93c7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -23,6 +23,7 @@
 #include "split-index.h"
 #include "utf8.h"
 #include "fsmonitor.h"
+#include "progress.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -1477,6 +1478,11 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	const char *added_fmt;
 	const char *unmerged_fmt;
 	uint64_t start = getnanotime();
+	struct progress *progress = NULL;
+
+	if (flags & REFRESH_PROGRESS && isatty(2))
+		progress = start_delayed_progress(_("Refresh index"),
+						  istate->cache_nr);
 
 	modified_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
 	deleted_fmt = (in_porcelain ? "D\t%s\n" : "%s: needs update\n");
@@ -1516,6 +1522,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		new_entry = refresh_cache_ent(istate, ce, options, &cache_errno, &changed);
 		if (new_entry == ce)
 			continue;
+		if (progress)
+			display_progress(progress, i);
 		if (!new_entry) {
 			const char *fmt;
 
@@ -1547,6 +1555,10 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 
 		replace_index_entry(istate, i, new_entry);
 	}
+	if (progress) {
+		display_progress(progress, istate->cache_nr);
+		stop_progress(&progress);
+	}
 	trace_performance_since(start, "refresh index");
 	return has_errors;
 }
diff --git a/sequencer.c b/sequencer.c
index dc2c58d464..e0cd17df70 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1909,7 +1909,7 @@ static int read_and_refresh_cache(struct replay_opts *opts)
 {
 	struct lock_file index_lock = LOCK_INIT;
 	int index_fd = hold_locked_index(&index_lock, 0);
-	if (read_index_preload(&the_index, NULL) < 0) {
+	if (read_index_preload(&the_index, NULL, 0) < 0) {
 		rollback_lock_file(&index_lock);
 		return error(_("git %s: failed to read the index"),
 			_(action_name(opts)));
-- 
2.19.0.rc0.337.ge906d732e7

