Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D376A1F453
	for <e@80x24.org>; Sat,  3 Nov 2018 08:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbeKCR7k (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 13:59:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44204 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbeKCR7j (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 13:59:39 -0400
Received: by mail-lf1-f65.google.com with SMTP id m18-v6so2841381lfl.11
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 01:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b23l1Od1UoAgQbGbitmUi3qfEmvDGX+lB2/o0OsqBis=;
        b=bfTCi+S667pBo+ZHaJmdcIK3RERgIrzNnX41GueMUP9w2NIZ00YQbTTxZga8nG7b9C
         yaEgpDre6skIpz2sdKJ3IIt3c24GyjJOvWcqPJQhGAR0wEmn3zAD6hWtZ6YqrSrzX/Gt
         GP7sQxYI4+hmJTX3YunG01C4Vm+KYJOZhp4gHXgNgca9hdLHdkhNx3iIBJNlvifKpZJ+
         jtumM3jg1cwwrwp8y1hc8dpVF9zpkuDlvyWEoPJ79aPeiYMcceVi7aTLATzuw1KCIjah
         rFaYxHHWnk5XK3Mtn8b+nazjwjnRLPiKKDBF7Q73gc3F2sFYPeLe6HKPBZaxE/1UWjB7
         1m3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b23l1Od1UoAgQbGbitmUi3qfEmvDGX+lB2/o0OsqBis=;
        b=jbOrTpObSmYYThyoPiCC1CgG4H8AZ6u9zSH4N9Qu6oJMUVg0Rmee/AfGbJTFmjgqg+
         BdBqDCHNbNY2/0x88yJjsr+W+MJEMjYXL+EvK1prU4GQuPR637BaqBlARuaRktWmm5tP
         jLNhhNBdh59TudQpa7pfA0sunR9z0LotFKfFDanV3Q7zxs9wUdh/cNmeqOYSgcYGCsT8
         9ECkKrCtXmljIHXdGLjo73iVXS0tVQgzxtIC8YkjpyC1qccs3cX8FO1hNmWet0DRvJTI
         w2yi3UbbaDfjg7WLPog5k3XKYFCSEazkYxSNOb2rWHxCEzhWfAPyCo8ho2O5cW/POmfv
         K86Q==
X-Gm-Message-State: AGRZ1gIhBXb/3mHNDRQCtqFlW39sQ8GrURSh77fJObcwFKwLiuoTuNLW
        OUchOW2zXWeHFhYDttQ8BGU=
X-Google-Smtp-Source: AJdET5eXWv0Z6EUytBLCEvYNj16RzfLd4iYLwnld+3mCfJehnwxk/1JRzhdRcu3Lll6CYtCFFRSEQA==
X-Received: by 2002:a19:2a4b:: with SMTP id f72mr8071819lfl.139.1541234941126;
        Sat, 03 Nov 2018 01:49:01 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s191-v6sm657373lfe.17.2018.11.03.01.48.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 01:49:00 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com,
        peff@peff.net
Subject: [PATCH v3 00/14] Reduce #ifdef NO_PTHREADS
Date:   Sat,  3 Nov 2018 09:48:36 +0100
Message-Id: <20181103084850.9584-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181027173008.18852-1-pclouds@gmail.com>
References: <20181027173008.18852-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2

- more cleanups in grep.c, read-cache.c and index-pack.c
- the send-pack.c changes are back, but this time I just add
  async_with_fork() to move NO_PTHREADS back in run-command.c

For grep.c and read-cache.c, changes are split in two patches. The
first one is a dumb, mechanical conversion from #ifdef to if and is
straightforward. The second one makes "no thread" use "one thread"
code path and needs more careful review.

Diff against nd/pthreads

diff --git a/builtin/grep.c b/builtin/grep.c
index 6dd15dbaa2..de3f568cee 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -69,13 +69,11 @@ static pthread_mutex_t grep_mutex;
 
 static inline void grep_lock(void)
 {
-	assert(num_threads);
 	pthread_mutex_lock(&grep_mutex);
 }
 
 static inline void grep_unlock(void)
 {
-	assert(num_threads);
 	pthread_mutex_unlock(&grep_mutex);
 }
 
@@ -234,7 +232,7 @@ static int wait_all(void)
 	int i;
 
 	if (!HAVE_THREADS)
-		return 0;
+		BUG("Never call this function unless you have started threads");
 
 	grep_lock();
 	all_work_added = 1;
@@ -279,14 +277,14 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
 		if (num_threads < 0)
 			die(_("invalid number of threads specified (%d) for %s"),
 			    num_threads, var);
-		else if (!HAVE_THREADS && num_threads && num_threads != 1) {
+		else if (!HAVE_THREADS && num_threads > 1) {
 			/*
 			 * TRANSLATORS: %s is the configuration
 			 * variable for tweaking threads, currently
 			 * grep.threads
 			 */
 			warning(_("no threads support, ignoring %s"), var);
-			num_threads = 0;
+			num_threads = 1;
 		}
 	}
 
@@ -323,7 +321,7 @@ static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 	grep_source_init(&gs, GREP_SOURCE_OID, pathbuf.buf, path, oid);
 	strbuf_release(&pathbuf);
 
-	if (HAVE_THREADS && num_threads) {
+	if (num_threads > 1) {
 		/*
 		 * add_work() copies gs and thus assumes ownership of
 		 * its fields, so do not call grep_source_clear()
@@ -353,7 +351,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 	grep_source_init(&gs, GREP_SOURCE_FILE, buf.buf, filename, filename);
 	strbuf_release(&buf);
 
-	if (HAVE_THREADS && num_threads) {
+	if (num_threads > 1) {
 		/*
 		 * add_work() copies gs and thus assumes ownership of
 		 * its fields, so do not call grep_source_clear()
@@ -1025,36 +1023,34 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	pathspec.recursive = 1;
 	pathspec.recurse_submodules = !!recurse_submodules;
 
-	if (HAVE_THREADS) {
-		if (list.nr || cached || show_in_pager)
-			num_threads = 0;
-		else if (num_threads == 0)
-			num_threads = GREP_NUM_THREADS_DEFAULT;
-		else if (num_threads < 0)
-			die(_("invalid number of threads specified (%d)"), num_threads);
-		if (num_threads == 1)
-			num_threads = 0;
+	if (list.nr || cached || show_in_pager) {
+		if (num_threads > 1)
+			warning(_("invalid option combination, ignoring --threads"));
+		num_threads = 1;
+	} else if (!HAVE_THREADS && num_threads > 1) {
+		warning(_("no threads support, ignoring --threads"));
+		num_threads = 1;
+	} else if (num_threads < 0)
+		die(_("invalid number of threads specified (%d)"), num_threads);
+	else if (num_threads == 0)
+		num_threads = HAVE_THREADS ? GREP_NUM_THREADS_DEFAULT : 1;
+
+	if (num_threads > 1) {
+		if (!HAVE_THREADS)
+			BUG("Somebody got num_threads calculation wrong!");
+		if (!(opt.name_only || opt.unmatch_name_only || opt.count)
+		    && (opt.pre_context || opt.post_context ||
+			opt.file_break || opt.funcbody))
+			skip_first_line = 1;
+		start_threads(&opt);
 	} else {
-		if (num_threads)
-			warning(_("no threads support, ignoring --threads"));
-		num_threads = 0;
-	}
-
-	if (!num_threads)
 		/*
 		 * The compiled patterns on the main path are only
 		 * used when not using threading. Otherwise
-		 * start_threads() below calls compile_grep_patterns()
+		 * start_threads() above calls compile_grep_patterns()
 		 * for each thread.
 		 */
 		compile_grep_patterns(&opt);
-
-	if (HAVE_THREADS && num_threads) {
-		if (!(opt.name_only || opt.unmatch_name_only || opt.count)
-		    && (opt.pre_context || opt.post_context ||
-			opt.file_break || opt.funcbody))
-			skip_first_line = 1;
-		start_threads(&opt);
 	}
 
 	if (show_in_pager && (cached || list.nr))
@@ -1106,7 +1102,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		hit = grep_objects(&opt, &pathspec, &list);
 	}
 
-	if (num_threads)
+	if (num_threads > 1)
 		hit |= wait_all();
 	if (hit && show_in_pager)
 		run_pager(&opt, prefix);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index bbd66ca025..682042579b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1501,9 +1501,8 @@ static int git_index_pack_config(const char *k, const char *v, void *cb)
 		if (nr_threads < 0)
 			die(_("invalid number of threads specified (%d)"),
 			    nr_threads);
-		if (!HAVE_THREADS) {
-			if (nr_threads != 1)
-				warning(_("no threads support, ignoring %s"), k);
+		if (!HAVE_THREADS && nr_threads != 1) {
+			warning(_("no threads support, ignoring %s"), k);
 			nr_threads = 1;
 		}
 		return 0;
@@ -1693,10 +1692,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				nr_threads = strtoul(arg+10, &end, 0);
 				if (!arg[10] || *end || nr_threads < 0)
 					usage(index_pack_usage);
-				if (!HAVE_THREADS) {
-					if (nr_threads != 1)
-						warning(_("no threads support, "
-							  "ignoring %s"), arg);
+				if (!HAVE_THREADS && nr_threads != 1) {
+					warning(_("no threads support, ignoring %s"), arg);
 					nr_threads = 1;
 				}
 			} else if (starts_with(arg, "--pack_header=")) {
diff --git a/read-cache.c b/read-cache.c
index 4307b9a7bf..c510f598b1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2170,20 +2170,19 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 
 	src_offset = sizeof(*hdr);
 
-	if (HAVE_THREADS) {
-		nr_threads = git_config_get_index_threads();
+	nr_threads = git_config_get_index_threads();
 
-		/* TODO: does creating more threads than cores help? */
-		if (!nr_threads) {
-			nr_threads = istate->cache_nr / THREAD_COST;
-			cpus = online_cpus();
-			if (nr_threads > cpus)
-				nr_threads = cpus;
-		}
-	} else {
-		nr_threads = 1;
+	/* TODO: does creating more threads than cores help? */
+	if (!nr_threads) {
+		nr_threads = istate->cache_nr / THREAD_COST;
+		cpus = online_cpus();
+		if (nr_threads > cpus)
+			nr_threads = cpus;
 	}
 
+	if (!HAVE_THREADS)
+		nr_threads = 1;
+
 	if (nr_threads > 1) {
 		extension_offset = read_eoie_extension(mmap, mmap_size);
 		if (extension_offset) {
@@ -2216,12 +2215,11 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 
 	/* if we created a thread, join it otherwise load the extensions on the primary thread */
-	if (HAVE_THREADS && extension_offset) {
+	if (extension_offset) {
 		int ret = pthread_join(p.pthread, NULL);
 		if (ret)
 			die(_("unable to join load_index_extensions thread: %s"), strerror(ret));
-	}
-	if (!extension_offset) {
+	} else {
 		p.src_offset = src_offset;
 		load_index_extensions(&p);
 	}
@@ -2860,7 +2858,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	 * strip_extensions parameter as we need it when loading the shared
 	 * index.
 	 */
-	if (HAVE_THREADS && ieot) {
+	if (ieot) {
 		struct strbuf sb = STRBUF_INIT;
 
 		write_ieot_extension(&sb, ieot);
diff --git a/run-command.c b/run-command.c
index 26154ba257..decf3239bd 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1246,6 +1246,15 @@ int finish_async(struct async *async)
 #endif
 }
 
+int async_with_fork(void)
+{
+#ifdef NO_PTHREADS
+	return 1;
+#else
+	return 0;
+#endif
+}
+
 const char *find_hook(const char *name)
 {
 	static struct strbuf path = STRBUF_INIT;
diff --git a/run-command.h b/run-command.h
index 3932420ec8..68f5369fc2 100644
--- a/run-command.h
+++ b/run-command.h
@@ -1,9 +1,7 @@
 #ifndef RUN_COMMAND_H
 #define RUN_COMMAND_H
 
-#ifndef NO_PTHREADS
-#include <pthread.h>
-#endif
+#include "thread-utils.h"
 
 #include "argv-array.h"
 
@@ -143,6 +141,7 @@ struct async {
 int start_async(struct async *async);
 int finish_async(struct async *async);
 int in_async(void);
+int async_with_fork(void);
 void check_pipe(int err);
 
 /**
diff --git a/send-pack.c b/send-pack.c
index e920ca57df..f692686770 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -203,9 +203,8 @@ static int receive_status(int in, struct ref *refs)
 static int sideband_demux(int in, int out, void *data)
 {
 	int *fd = data, ret;
-#ifdef NO_PTHREADS
-	close(fd[1]);
-#endif
+	if (async_with_fork())
+		close(fd[1]);
 	ret = recv_sideband("send-pack", fd[0], out);
 	close(out);
 	return ret;

Nguyễn Thái Ngọc Duy (14):
  thread-utils: macros to unconditionally compile pthreads API
  run-command.h: include thread-utils.h instead of pthread.h
  send-pack.c: move async's #ifdef NO_PTHREADS back to run-command.c
  index-pack: remove #ifdef NO_PTHREADS
  name-hash.c: remove #ifdef NO_PTHREADS
  attr.c: remove #ifdef NO_PTHREADS
  grep: remove #ifdef NO_PTHREADS
  grep: clean up num_threads handling
  preload-index.c: remove #ifdef NO_PTHREADS
  pack-objects: remove #ifdef NO_PTHREADS
  read-cache.c: remove #ifdef NO_PTHREADS
  read-cache.c: reduce branching based on HAVE_THREADS
  read-cache.c: initialize copy_len to shut up gcc 8
  Clean up pthread_create() error handling

 Makefile               |  2 +-
 attr.c                 | 14 --------
 builtin/grep.c         | 79 ++++++++++++++++--------------------------
 builtin/index-pack.c   | 63 ++++++++-------------------------
 builtin/pack-objects.c | 26 ++------------
 grep.c                 |  6 ----
 grep.h                 |  6 ----
 name-hash.c            | 38 ++++++++------------
 pack-objects.h         |  6 ----
 preload-index.c        | 23 +++++-------
 read-cache.c           | 37 ++++++--------------
 run-command.c          | 11 +++++-
 run-command.h          |  5 ++-
 send-pack.c            |  5 ++-
 thread-utils.c         | 48 +++++++++++++++++++++++++
 thread-utils.h         | 48 +++++++++++++++++++++++--
 16 files changed, 186 insertions(+), 231 deletions(-)

-- 
2.19.1.1005.gac84295441

