Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E0D220305
	for <e@80x24.org>; Wed, 17 Apr 2019 07:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbfDQH6m (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 03:58:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34215 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731207AbfDQH6m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 03:58:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so11645767pgq.1
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 00:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=20Njc1nfM56beVClhSKp3HQxMYRgdVfe4Ehg53xPShg=;
        b=sealrl4RrxCkljpzoNcg2SZSqH/pK8uOHGXL8qk+8mDk5S+4unPpZRNZowGWTs4lXo
         cmkG4+euGuw36X+K9fk1GeNjEvcCx3pPvSd8jtZuYyKPxjAbCAa7v8i4zReqXzZKUq7w
         JXvA97bV/bgZMKr1JOcA1SJao8F7yOm2/CKIEiS/wrQ/ttDd3kiemdv80HRscLbCxfJT
         5n312qgfJ2NWPnM20Nv3ctvPEjhx1vwWzsXA6mOFxOFrFqwIVdULIYQSGD9mMCmhb5P7
         MvoinPDmS1hhehYxS7B5GkaJ0dp9dpMhTLdUqrJ01DfUGDoq4XjM292UHbsEjVuyYK8W
         46Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=20Njc1nfM56beVClhSKp3HQxMYRgdVfe4Ehg53xPShg=;
        b=QomNeLxhhGUI460t0UfrtPMcmKjDWlZpkAvcXhcG/h9s2TC4LBrv1KeibaO681Sczk
         DNW2e4pxRlQRx0dwOhMiGDy+wkH8vKp1pVcG2ZMOd52w7lOVcfcH+CqjI46t45TKq4EX
         bPfW82G+RAWAtzLNPgrWwVSyCx5/ne09n7GTQBNm1Ylcex92BOthRi+NflEDI4/QQ+Zs
         B5XLY6okE1j4fTqwk8lbb89i5GHVlSmUDEb21gJCuynYAhxhFyxpvYRXBOtg8WhEuyg+
         Z0Jpoj65PKIz/RhFpKkbaV4v/0JCzhe4n5QgYI+OJvNs5+Xefc981KvbazA7Cx3gPibC
         +vng==
X-Gm-Message-State: APjAAAVUh4wIBUYrburuvRfh6wDmbtLtzMz+IWg1A2Kdw2UjHsvjRDwY
        uwYT0eE6w9LnZD/nY52fQDpgu82+
X-Google-Smtp-Source: APXvYqxvi9cKSXqh5gd/Kq+o3367Mu1L6NmZb7JzgQ3l9dxbU/hPmH25DGSTcWwqaj5letJy9OMLrw==
X-Received: by 2002:a65:5cc8:: with SMTP id b8mr79270411pgt.36.1555487920678;
        Wed, 17 Apr 2019 00:58:40 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id n21sm107331932pfb.42.2019.04.17.00.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 00:58:39 -0700 (PDT)
Date:   Wed, 17 Apr 2019 00:58:38 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 2/4] *.[ch]: remove extern from function declarations
 using sed
Message-ID: <7d35a052a609dd54374a1caede3e0dbded531296.1555487381.git.liu.denton@gmail.com>
References: <cover.1555352526.git.liu.denton@gmail.com>
 <cover.1555487380.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555487380.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There has been a push to remove extern from function declarations.
Finish the job by removing all instances of "extern" for function
declarations in headers using sed.

This was done by running the following on my system with sed 4.2.2:

    $ git ls-files \*.{c,h} | xargs sed -i'' -e 's/^\(\s*\)extern \([^(]*([^*]\)/\1\2/'

Then, leftover instances of extern were found by running

    $ git grep -w -C3 extern \*.{c,h}

and manually checking the output. No other instances were found.

Note that the regex used specifically excludes function variables which
_should_ be left as extern.

Not the most elegant way to do it but it gets the job done.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 cache.h           |  4 ++--
 commit.h          |  2 +-
 config.h          |  2 +-
 exec-cmd.h        |  2 +-
 git-compat-util.h | 20 ++++++++++----------
 khash.h           | 14 +++++++-------
 path.h            | 30 +++++++++++++++---------------
 quote.h           |  2 +-
 run-command.h     |  2 +-
 trace.h           | 18 +++++++++---------
 worktree.h        |  2 +-
 11 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/cache.h b/cache.h
index e21a10b380..1f42d5ecb1 100644
--- a/cache.h
+++ b/cache.h
@@ -1690,7 +1690,7 @@ extern const char *git_mailmap_blob;
 /* IO helper functions */
 void maybe_flush_or_die(FILE *, const char *);
 __attribute__((format (printf, 2, 3)))
-extern void fprintf_or_die(FILE *, const char *fmt, ...);
+void fprintf_or_die(FILE *, const char *fmt, ...);
 
 #define COPY_READ_ERROR (-2)
 #define COPY_WRITE_ERROR (-3)
@@ -1724,7 +1724,7 @@ void write_file_buf(const char *path, const char *buf, size_t len);
  *   write_file(path, "counter: %d", ctr);
  */
 __attribute__((format (printf, 2, 3)))
-extern void write_file(const char *path, const char *fmt, ...);
+void write_file(const char *path, const char *fmt, ...);
 
 /* pager.c */
 void setup_pager(void);
diff --git a/commit.h b/commit.h
index 26d0b51758..40744e1bed 100644
--- a/commit.h
+++ b/commit.h
@@ -379,6 +379,6 @@ int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused)
 int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused);
 
 LAST_ARG_MUST_BE_NULL
-extern int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
+int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
 
 #endif /* COMMIT_H */
diff --git a/config.h b/config.h
index f9d5593c8b..1482b9b7fa 100644
--- a/config.h
+++ b/config.h
@@ -265,7 +265,7 @@ struct key_value_info {
 	enum config_scope scope;
 };
 
-extern NORETURN void git_die_config(const char *key, const char *err, ...) __attribute__((format(printf, 2, 3)));
+NORETURN void git_die_config(const char *key, const char *err, ...) __attribute__((format(printf, 2, 3)));
 NORETURN void git_die_config_linenr(const char *key, const char *filename, int linenr);
 
 #define LOOKUP_CONFIG(mapping, var) \
diff --git a/exec-cmd.h b/exec-cmd.h
index bddf5cb934..8cd1df28d3 100644
--- a/exec-cmd.h
+++ b/exec-cmd.h
@@ -10,7 +10,7 @@ void setup_path(void);
 const char **prepare_git_cmd(struct argv_array *out, const char **argv);
 int execv_git_cmd(const char **argv); /* NULL terminated */
 LAST_ARG_MUST_BE_NULL
-extern int execl_git_cmd(const char *cmd, ...);
+int execl_git_cmd(const char *cmd, ...);
 char *system_path(const char *path);
 
 #endif /* GIT_EXEC_CMD_H */
diff --git a/git-compat-util.h b/git-compat-util.h
index 337bc9a7c3..cc2cd27f30 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -448,13 +448,13 @@ struct strbuf;
 /* General helper functions */
 void vreportf(const char *prefix, const char *err, va_list params);
 NORETURN void usage(const char *err);
-extern NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
-extern NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
-extern NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
-extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
-extern int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
-extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
-extern void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
+NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
+NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
+int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
+void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
 #ifndef NO_OPENSSL
 #ifdef APPLE_COMMON_CRYPTO
@@ -769,7 +769,7 @@ FILE *git_fopen(const char*, const char*);
 #undef snprintf
 #endif
 #define snprintf git_snprintf
-extern int git_snprintf(char *str, size_t maxsize,
+int git_snprintf(char *str, size_t maxsize,
 			const char *format, ...);
 #ifdef vsnprintf
 #undef vsnprintf
@@ -855,7 +855,7 @@ void *xrealloc(void *ptr, size_t size);
 void *xcalloc(size_t nmemb, size_t size);
 void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
 void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_t offset);
-extern int xopen(const char *path, int flags, ...);
+int xopen(const char *path, int flags, ...);
 ssize_t xread(int fd, void *buf, size_t len);
 ssize_t xwrite(int fd, const void *buf, size_t len);
 ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
@@ -966,7 +966,7 @@ static inline size_t xsize_t(off_t len)
 }
 
 __attribute__((format (printf, 3, 4)))
-extern int xsnprintf(char *dst, size_t max, const char *fmt, ...);
+int xsnprintf(char *dst, size_t max, const char *fmt, ...);
 
 #ifndef HOST_NAME_MAX
 #define HOST_NAME_MAX 256
diff --git a/khash.h b/khash.h
index 532109c87f..3d25667a82 100644
--- a/khash.h
+++ b/khash.h
@@ -70,13 +70,13 @@ static const double __ac_HASH_UPPER = 0.77;
 	} kh_##name##_t;
 
 #define __KHASH_PROTOTYPES(name, khkey_t, khval_t)	 					\
-	extern kh_##name##_t *kh_init_##name(void);							\
-	extern void kh_destroy_##name(kh_##name##_t *h);					\
-	extern void kh_clear_##name(kh_##name##_t *h);						\
-	extern khint_t kh_get_##name(const kh_##name##_t *h, khkey_t key); 	\
-	extern int kh_resize_##name(kh_##name##_t *h, khint_t new_n_buckets); \
-	extern khint_t kh_put_##name(kh_##name##_t *h, khkey_t key, int *ret); \
-	extern void kh_del_##name(kh_##name##_t *h, khint_t x);
+	kh_##name##_t *kh_init_##name(void);							\
+	void kh_destroy_##name(kh_##name##_t *h);					\
+	void kh_clear_##name(kh_##name##_t *h);						\
+	khint_t kh_get_##name(const kh_##name##_t *h, khkey_t key); 	\
+	int kh_resize_##name(kh_##name##_t *h, khint_t new_n_buckets); \
+	khint_t kh_put_##name(kh_##name##_t *h, khkey_t key, int *ret); \
+	void kh_del_##name(kh_##name##_t *h, khint_t x);
 
 #define __KHASH_IMPL(name, SCOPE, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal) \
 	SCOPE kh_##name##_t *kh_init_##name(void) {							\
diff --git a/path.h b/path.h
index ab9d8d86f2..0efbd4fb0d 100644
--- a/path.h
+++ b/path.h
@@ -13,19 +13,19 @@ struct strbuf;
 /*
  * Return a statically allocated path.
  */
-extern const char *mkpath(const char *fmt, ...)
+const char *mkpath(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
 
 /*
  * Return a path.
  */
-extern char *mkpathdup(const char *fmt, ...)
+char *mkpathdup(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
 
 /*
  * Construct a path and place the result in the provided buffer `buf`.
  */
-extern char *mksnpath(char *buf, size_t n, const char *fmt, ...)
+char *mksnpath(char *buf, size_t n, const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
 
 /*
@@ -37,7 +37,7 @@ extern char *mksnpath(char *buf, size_t n, const char *fmt, ...)
  * Constructs a path into the common git directory of repository `repo` and
  * append it in the provided buffer `sb`.
  */
-extern void strbuf_git_common_path(struct strbuf *sb,
+void strbuf_git_common_path(struct strbuf *sb,
 				   const struct repository *repo,
 				   const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
@@ -46,7 +46,7 @@ extern void strbuf_git_common_path(struct strbuf *sb,
  * Return a statically allocated path into the main repository's
  * (the_repository) common git directory.
  */
-extern const char *git_common_path(const char *fmt, ...)
+const char *git_common_path(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
 
 
@@ -66,7 +66,7 @@ extern const char *git_common_path(const char *fmt, ...)
 /*
  * Return a path into the git directory of repository `repo`.
  */
-extern char *repo_git_path(const struct repository *repo,
+char *repo_git_path(const struct repository *repo,
 			   const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
@@ -74,7 +74,7 @@ extern char *repo_git_path(const struct repository *repo,
  * Construct a path into the git directory of repository `repo` and append it
  * to the provided buffer `sb`.
  */
-extern void strbuf_repo_git_path(struct strbuf *sb,
+void strbuf_repo_git_path(struct strbuf *sb,
 				 const struct repository *repo,
 				 const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
@@ -83,13 +83,13 @@ extern void strbuf_repo_git_path(struct strbuf *sb,
  * Return a statically allocated path into the main repository's
  * (the_repository) git directory.
  */
-extern const char *git_path(const char *fmt, ...)
+const char *git_path(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
 
 /*
  * Return a path into the main repository's (the_repository) git directory.
  */
-extern char *git_pathdup(const char *fmt, ...)
+char *git_pathdup(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
 
 /*
@@ -97,14 +97,14 @@ extern char *git_pathdup(const char *fmt, ...)
  * and place it in the provided buffer `buf`, the contents of the buffer will
  * be overridden.
  */
-extern char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
+char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
 /*
  * Construct a path into the main repository's (the_repository) git directory
  * and append it to the provided buffer `sb`.
  */
-extern void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
+void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
 /*
@@ -112,7 +112,7 @@ extern void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
  *
  * If the repository doesn't have a worktree NULL is returned.
  */
-extern char *repo_worktree_path(const struct repository *repo,
+char *repo_worktree_path(const struct repository *repo,
 				const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
@@ -122,7 +122,7 @@ extern char *repo_worktree_path(const struct repository *repo,
  *
  * If the repository doesn't have a worktree nothing will be appended to `sb`.
  */
-extern void strbuf_repo_worktree_path(struct strbuf *sb,
+void strbuf_repo_worktree_path(struct strbuf *sb,
 				      const struct repository *repo,
 				      const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
@@ -131,7 +131,7 @@ extern void strbuf_repo_worktree_path(struct strbuf *sb,
  * Return a path into a submodule's git directory located at `path`.  `path`
  * must only reference a submodule of the main repository (the_repository).
  */
-extern char *git_pathdup_submodule(const char *path, const char *fmt, ...)
+char *git_pathdup_submodule(const char *path, const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
 /*
@@ -139,7 +139,7 @@ extern char *git_pathdup_submodule(const char *path, const char *fmt, ...)
  * append it to the provided buffer `sb`.  `path` must only reference a
  * submodule of the main repository (the_repository).
  */
-extern int strbuf_git_path_submodule(struct strbuf *sb, const char *path,
+int strbuf_git_path_submodule(struct strbuf *sb, const char *path,
 				     const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
 
diff --git a/quote.h b/quote.h
index 89f99e98fa..86c0d944b5 100644
--- a/quote.h
+++ b/quote.h
@@ -31,7 +31,7 @@ struct strbuf;
 
 void sq_quote_buf(struct strbuf *, const char *src);
 void sq_quote_argv(struct strbuf *, const char **argv);
-extern void sq_quotef(struct strbuf *, const char *fmt, ...);
+void sq_quotef(struct strbuf *, const char *fmt, ...);
 
 /*
  * These match their non-pretty variants, except that they avoid
diff --git a/run-command.h b/run-command.h
index 31f6f2e57f..f769e03f01 100644
--- a/run-command.h
+++ b/run-command.h
@@ -69,7 +69,7 @@ int run_command(struct child_process *);
  */
 const char *find_hook(const char *name);
 LAST_ARG_MUST_BE_NULL
-extern int run_hook_le(const char *const *env, const char *name, ...);
+int run_hook_le(const char *const *env, const char *name, ...);
 int run_hook_ve(const char *const *env, const char *name, va_list args);
 
 #define RUN_COMMAND_NO_STDIN 1
diff --git a/trace.h b/trace.h
index 57faf3530a..4ca2a5a63f 100644
--- a/trace.h
+++ b/trace.h
@@ -28,23 +28,23 @@ uint64_t trace_performance_enter(void);
 #ifndef HAVE_VARIADIC_MACROS
 
 __attribute__((format (printf, 1, 2)))
-extern void trace_printf(const char *format, ...);
+void trace_printf(const char *format, ...);
 
 __attribute__((format (printf, 2, 3)))
-extern void trace_printf_key(struct trace_key *key, const char *format, ...);
+void trace_printf_key(struct trace_key *key, const char *format, ...);
 
 __attribute__((format (printf, 2, 3)))
-extern void trace_argv_printf(const char **argv, const char *format, ...);
+void trace_argv_printf(const char **argv, const char *format, ...);
 
 void trace_strbuf(struct trace_key *key, const struct strbuf *data);
 
 /* Prints elapsed time (in nanoseconds) if GIT_TRACE_PERFORMANCE is enabled. */
 __attribute__((format (printf, 2, 3)))
-extern void trace_performance(uint64_t nanos, const char *format, ...);
+void trace_performance(uint64_t nanos, const char *format, ...);
 
 /* Prints elapsed time since 'start' if GIT_TRACE_PERFORMANCE is enabled. */
 __attribute__((format (printf, 2, 3)))
-extern void trace_performance_since(uint64_t start, const char *format, ...);
+void trace_performance_since(uint64_t start, const char *format, ...);
 
 __attribute__((format (printf, 1, 2)))
 void trace_performance_leave(const char *format, ...);
@@ -132,18 +132,18 @@ void trace_performance_leave(const char *format, ...);
 
 /* backend functions, use non-*fl macros instead */
 __attribute__((format (printf, 4, 5)))
-extern void trace_printf_key_fl(const char *file, int line, struct trace_key *key,
+void trace_printf_key_fl(const char *file, int line, struct trace_key *key,
 				const char *format, ...);
 __attribute__((format (printf, 4, 5)))
-extern void trace_argv_printf_fl(const char *file, int line, const char **argv,
+void trace_argv_printf_fl(const char *file, int line, const char **argv,
 				 const char *format, ...);
 void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
 			    const struct strbuf *data);
 __attribute__((format (printf, 4, 5)))
-extern void trace_performance_fl(const char *file, int line,
+void trace_performance_fl(const char *file, int line,
 				 uint64_t nanos, const char *fmt, ...);
 __attribute__((format (printf, 4, 5)))
-extern void trace_performance_leave_fl(const char *file, int line,
+void trace_performance_leave_fl(const char *file, int line,
 				       uint64_t nanos, const char *fmt, ...);
 static inline int trace_pass_fl(struct trace_key *key)
 {
diff --git a/worktree.h b/worktree.h
index ead36d6f54..2d6a1d207a 100644
--- a/worktree.h
+++ b/worktree.h
@@ -104,7 +104,7 @@ int is_worktree_being_bisected(const struct worktree *wt, const char *target);
  * Similar to git_path() but can produce paths for a specified
  * worktree instead of current one
  */
-extern const char *worktree_git_path(const struct worktree *wt,
+const char *worktree_git_path(const struct worktree *wt,
 				     const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
-- 
2.21.0.832.gd5ec0d3bee

