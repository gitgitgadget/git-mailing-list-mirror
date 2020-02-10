Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE91C352A5
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DF320714
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fk9rzPVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgBJOOZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:14:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35821 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbgBJOOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 09:14:25 -0500
Received: by mail-wr1-f68.google.com with SMTP id w12so7949429wrt.2
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 06:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LWfEpoNU3CGeLFoxQm6aHVX36uFErfpM93cSfcrquTY=;
        b=fk9rzPVFA1fYtTkmebVgh4FAL8nn118e9FgBdrEz2+ktzKdxoNTV2weQgb24ap/Q3l
         T7ci2OEr2KIHOtEm1PNKiBrSVL/v0Dk1Dnohotcb+cxiI2jQc5oRyqIMlfJPzM4dvZe7
         Rp6S+geTiFCbdk+dvrwj17Af/gjLAUb/dVw/gSuWj2C0csHGkR1VBYW1Xb+/Wv3EWmgw
         AelRVVfgRrfg86BshZN6Hjvnt3EzeRVu2sN4PKH5do5FCXmKHnJBRD0eYGaqjQjBasKW
         MFKLAzWCGvV9+lYQ2PXlywkk+MNrybImjgeefxwWK66RNSH9KO01jtOmm0ng/qNN/EPL
         IQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LWfEpoNU3CGeLFoxQm6aHVX36uFErfpM93cSfcrquTY=;
        b=K6U+Oy5zcYDiGTBnVOBSx8aW/wmsuuNTsRi2XXJJIwK9bzShmH6m2i6p/qO6XQZyQt
         69XVW1MG4JAfRsFO/gzfbaUX67EwklfvYSfhPjt3KUp58CKkVMVE7MDeiInF0tGKuHsQ
         Qxyk8Pn4NrE1/bTsqb8BMR+smfmw9ug7W2YxpK3csIcyDsoJdhVEcnnRZCIVkkDT35n4
         P3Sh5UzG6oebW6f/Z+uRavvDPfOYuy/PDZNh2k40tFMFsjeH7F8Lu0TlQIsJ8glgMd9T
         ek6inuwzM9983qTZ9lQabkXyG6Ei25ayWTh/ZT3mTwe7uiv9sF3xi6vr1Lc/u5+ezPdV
         irQg==
X-Gm-Message-State: APjAAAWgnZcY350huZN7K8PjwOABlObricA3dOi1JwgtwqQOYTF7cKou
        XcmBqnBg3iQLXu/hq3grUpY5kAzi
X-Google-Smtp-Source: APXvYqyqdhCepCdlhDWydmzP5A2zfkA/cj76hBOtCPtaW87WFbj6V56xGPvfRkf29jNbEgT0vRehTQ==
X-Received: by 2002:adf:df03:: with SMTP id y3mr2268945wrl.260.1581344061589;
        Mon, 10 Feb 2020 06:14:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h205sm767869wmf.25.2020.02.10.06.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 06:14:21 -0800 (PST)
Message-Id: <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v4.git.1581029756.gitgitgadget@gmail.com>
References: <pull.539.v4.git.1581029756.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 14:14:15 +0000
Subject: [PATCH v5 0/5] Reftable support git-core
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds the reftable library, and hooks it up as a ref backend.

At this point, I am mainly interested in feedback on the spots marked with
XXX in the Git source code.

v3

 * passes gitgitgadget CI.

Han-Wen Nienhuys (5):
  refs.h: clarify reflog iteration order
  create .git/refs in files-backend.c
  refs: document how ref_iterator_advance_fn should handle symrefs
  Add reftable library
  Reftable support for git-core

 .../technical/repository-version.txt          |    7 +
 Makefile                                      |   24 +-
 builtin/clone.c                               |    4 +-
 builtin/init-db.c                             |   57 +-
 cache.h                                       |    4 +-
 refs.c                                        |   20 +-
 refs.h                                        |    8 +-
 refs/files-backend.c                          |    6 +
 refs/refs-internal.h                          |    6 +
 refs/reftable-backend.c                       |  880 +++++++++++++
 reftable/LICENSE                              |   31 +
 reftable/README.md                            |   19 +
 reftable/VERSION                              |    5 +
 reftable/basics.c                             |  196 +++
 reftable/basics.h                             |   37 +
 reftable/block.c                              |  401 ++++++
 reftable/block.h                              |   71 ++
 reftable/blocksource.h                        |   20 +
 reftable/bytes.c                              |    0
 reftable/config.h                             |    1 +
 reftable/constants.h                          |   27 +
 reftable/dump.c                               |   97 ++
 reftable/file.c                               |   97 ++
 reftable/iter.c                               |  229 ++++
 reftable/iter.h                               |   56 +
 reftable/merged.c                             |  286 +++++
 reftable/merged.h                             |   34 +
 reftable/pq.c                                 |  114 ++
 reftable/pq.h                                 |   34 +
 reftable/reader.c                             |  708 +++++++++++
 reftable/reader.h                             |   52 +
 reftable/record.c                             | 1107 +++++++++++++++++
 reftable/record.h                             |   79 ++
 reftable/reftable.h                           |  394 ++++++
 reftable/slice.c                              |  199 +++
 reftable/slice.h                              |   39 +
 reftable/stack.c                              |  983 +++++++++++++++
 reftable/stack.h                              |   40 +
 reftable/system.h                             |   58 +
 reftable/tree.c                               |   66 +
 reftable/tree.h                               |   24 +
 reftable/writer.c                             |  623 ++++++++++
 reftable/writer.h                             |   46 +
 reftable/zlib-compat.c                        |   92 ++
 repository.c                                  |    2 +
 repository.h                                  |    3 +
 setup.c                                       |   12 +-
 47 files changed, 7266 insertions(+), 32 deletions(-)
 create mode 100644 refs/reftable-backend.c
 create mode 100644 reftable/LICENSE
 create mode 100644 reftable/README.md
 create mode 100644 reftable/VERSION
 create mode 100644 reftable/basics.c
 create mode 100644 reftable/basics.h
 create mode 100644 reftable/block.c
 create mode 100644 reftable/block.h
 create mode 100644 reftable/blocksource.h
 create mode 100644 reftable/bytes.c
 create mode 100644 reftable/config.h
 create mode 100644 reftable/constants.h
 create mode 100644 reftable/dump.c
 create mode 100644 reftable/file.c
 create mode 100644 reftable/iter.c
 create mode 100644 reftable/iter.h
 create mode 100644 reftable/merged.c
 create mode 100644 reftable/merged.h
 create mode 100644 reftable/pq.c
 create mode 100644 reftable/pq.h
 create mode 100644 reftable/reader.c
 create mode 100644 reftable/reader.h
 create mode 100644 reftable/record.c
 create mode 100644 reftable/record.h
 create mode 100644 reftable/reftable.h
 create mode 100644 reftable/slice.c
 create mode 100644 reftable/slice.h
 create mode 100644 reftable/stack.c
 create mode 100644 reftable/stack.h
 create mode 100644 reftable/system.h
 create mode 100644 reftable/tree.c
 create mode 100644 reftable/tree.h
 create mode 100644 reftable/writer.c
 create mode 100644 reftable/writer.h
 create mode 100644 reftable/zlib-compat.c


base-commit: 5b0ca878e008e82f91300091e793427205ce3544
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-539%2Fhanwen%2Freftable-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-539/hanwen/reftable-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/539

Range-diff vs v4:

 1:  c00403c94d = 1:  c00403c94d refs.h: clarify reflog iteration order
 2:  4d6da9bc47 = 2:  4d6da9bc47 create .git/refs in files-backend.c
 3:  fbdcdccc88 = 3:  fbdcdccc88 refs: document how ref_iterator_advance_fn should handle symrefs
 4:  02d2ca8b87 ! 4:  546b82fe79 Add reftable library
     @@ -98,11 +98,11 @@
       --- /dev/null
       +++ b/reftable/VERSION
      @@
     -+commit e7c3fc3099d9999bc8d895f84027b0e36348d5e6
     ++commit 6115b50fdb9bc662be39b05f5589bc109282ae7f
      +Author: Han-Wen Nienhuys <hanwen@google.com>
     -+Date:   Thu Feb 6 20:17:40 2020 +0100
     ++Date:   Mon Feb 10 13:59:52 2020 +0100
      +
     -+    C: use inttypes.h header definitions
     ++    README: add a note about the Java implementation
      
       diff --git a/reftable/basics.c b/reftable/basics.c
       new file mode 100644
     @@ -3885,9 +3885,6 @@
      +
      +#include "system.h"
      +
     -+typedef uint8_t byte;
     -+typedef byte bool;
     -+
      +/* block_source is a generic wrapper for a seekable readable file.
      +   It is generally passed around by value.
      + */
     @@ -3900,7 +3897,7 @@
      +   so it can return itself into the pool.
      +*/
      +struct block {
     -+	byte *data;
     ++	uint8_t *data;
      +	int len;
      +	struct block_source source;
      +};
     @@ -3926,14 +3923,14 @@
      +
      +/* write_options sets options for writing a single reftable. */
      +struct write_options {
     -+	/* do not pad out blocks to block size. */
     -+	bool unpadded;
     ++	/* boolean: do not pad out blocks to block size. */
     ++	int unpadded;
      +
      +	/* the blocksize. Should be less than 2^24. */
      +	uint32_t block_size;
      +
     -+	/* do not generate a SHA1 => ref index. */
     -+	bool skip_index_objects;
     ++	/* boolean: do not generate a SHA1 => ref index. */
     ++	int skip_index_objects;
      +
      +	/* how often to write complete keys in each block. */
      +	int restart_interval;
     @@ -3944,13 +3941,13 @@
      +	char *ref_name; /* Name of the ref, malloced. */
      +	uint64_t update_index; /* Logical timestamp at which this value is
      +				  written */
     -+	byte *value; /* SHA1, or NULL. malloced. */
     -+	byte *target_value; /* peeled annotated tag, or NULL. malloced. */
     ++	uint8_t *value; /* SHA1, or NULL. malloced. */
     ++	uint8_t *target_value; /* peeled annotated tag, or NULL. malloced. */
      +	char *target; /* symref, or NULL. malloced. */
      +};
      +
      +/* returns whether 'ref' represents a deletion */
     -+bool ref_record_is_deletion(const struct ref_record *ref);
     ++int ref_record_is_deletion(const struct ref_record *ref);
      +
      +/* prints a ref_record onto stdout */
      +void ref_record_print(struct ref_record *ref, int hash_size);
     @@ -3959,15 +3956,14 @@
      +void ref_record_clear(struct ref_record *ref);
      +
      +/* returns whether two ref_records are the same */
     -+bool ref_record_equal(struct ref_record *a, struct ref_record *b,
     -+		      int hash_size);
     ++int ref_record_equal(struct ref_record *a, struct ref_record *b, int hash_size);
      +
      +/* log_record holds a reflog entry */
      +struct log_record {
      +	char *ref_name;
      +	uint64_t update_index;
     -+	byte *new_hash;
     -+	byte *old_hash;
     ++	uint8_t *new_hash;
     ++	uint8_t *old_hash;
      +	char *name;
      +	char *email;
      +	uint64_t time;
     @@ -3976,14 +3972,13 @@
      +};
      +
      +/* returns whether 'ref' represents the deletion of a log record. */
     -+bool log_record_is_deletion(const struct log_record *log);
     ++int log_record_is_deletion(const struct log_record *log);
      +
      +/* frees and nulls all pointer values. */
      +void log_record_clear(struct log_record *log);
      +
      +/* returns whether two records are equal. */
     -+bool log_record_equal(struct log_record *a, struct log_record *b,
     -+		      int hash_size);
     ++int log_record_equal(struct log_record *a, struct log_record *b, int hash_size);
      +
      +void log_record_print(struct log_record *log, int hash_size);
      +
     @@ -4076,11 +4071,11 @@
      +const char *error_str(int err);
      +
      +/* new_writer creates a new writer */
     -+struct writer *new_writer(int (*writer_func)(void *, byte *, int),
     ++struct writer *new_writer(int (*writer_func)(void *, uint8_t *, int),
      +			  void *writer_arg, struct write_options *opts);
      +
      +/* write to a file descriptor. fdp should be an int* pointing to the fd. */
     -+int fd_writer(void *fdp, byte *data, int size);
     ++int fd_writer(void *fdp, uint8_t *data, int size);
      +
      +/* Set the range of update indices for the records we will add.  When
      +   writing a table into a stack, the min should be at least
     @@ -4163,7 +4158,7 @@
      +void reader_free(struct reader *);
      +
      +/* return an iterator for the refs pointing to oid */
     -+int reader_refs_for(struct reader *r, struct iterator *it, byte *oid,
     ++int reader_refs_for(struct reader *r, struct iterator *it, uint8_t *oid,
      +		    int oid_len);
      +
      +/* return the max_update_index for a table */
     @@ -5613,6 +5608,9 @@
      +	}
      +#endif
      +
     ++typedef uint8_t byte;
     ++typedef int bool;
     ++
      +int uncompress_return_consumed(Bytef *dest, uLongf *destLen,
      +			       const Bytef *source, uLong *sourceLen);
      +
 5:  2786a6bf61 ! 5:  702fb89871 Reftable support for git-core
     @@ -41,6 +41,21 @@
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
          Co-authored-by: Jeff King <peff@peff.net>
      
     + diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.txt
     + --- a/Documentation/technical/repository-version.txt
     + +++ b/Documentation/technical/repository-version.txt
     +@@
     + multiple working directory mode, "config" file is shared while
     + "config.worktree" is per-working directory (i.e., it's in
     + GIT_COMMON_DIR/worktrees/<id>/config.worktree)
     ++
     ++==== `refStorage`
     ++
     ++Specifies the file format for the ref database. Values are `files`
     ++(for the traditional packed + loose ref format) and `reftable` for the
     ++binary reftable format. See https://github.com/google/reftable for
     ++more information.
     +
       diff --git a/Makefile b/Makefile
       --- a/Makefile
       +++ b/Makefile
     @@ -109,6 +124,21 @@ $^
       
       Documentation/GIT-EXCLUDED-PROGRAMS: FORCE
      
     + diff --git a/builtin/clone.c b/builtin/clone.c
     + --- a/builtin/clone.c
     + +++ b/builtin/clone.c
     +@@
     + 		}
     + 	}
     + 
     +-	init_db(git_dir, real_git_dir, option_template, INIT_DB_QUIET);
     ++	init_db(git_dir, real_git_dir, option_template,
     ++		DEFAULT_REF_STORAGE, /* XXX */
     ++		INIT_DB_QUIET);
     + 
     + 	if (real_git_dir)
     + 		git_dir = real_git_dir;
     +
       diff --git a/builtin/init-db.c b/builtin/init-db.c
       --- a/builtin/init-db.c
       +++ b/builtin/init-db.c
     @@ -117,7 +147,8 @@ $^
       
       static int create_default_files(const char *template_path,
      -				const char *original_git_dir)
     -+				const char *original_git_dir, int flags)
     ++				const char *original_git_dir,
     ++				const char *ref_storage_format, int flags)
       {
       	struct stat st1;
       	struct strbuf buf = STRBUF_INIT;
     @@ -125,8 +156,7 @@ $^
       	is_bare_repository_cfg = init_is_bare_repository;
       	if (init_shared_repository != -1)
       		set_shared_repository(init_shared_repository);
     -+	if (flags & INIT_DB_REFTABLE)
     -+		the_repository->ref_storage_format = xstrdup("reftable");
     ++	the_repository->ref_storage_format = xstrdup(ref_storage_format);
       
       	/*
       	 * We would have created the above under user's umask -- under
     @@ -167,17 +197,29 @@ $^
      -	xsnprintf(repo_version_string, sizeof(repo_version_string),
      -		  "%d", GIT_REPO_VERSION);
      +	xsnprintf(repo_version_string, sizeof(repo_version_string), "%d",
     -+		  flags & INIT_DB_REFTABLE ? GIT_REPO_VERSION_READ :
     -+					     GIT_REPO_VERSION);
     ++		  !strcmp(ref_storage_format, "reftable") ?
     ++			  GIT_REPO_VERSION_READ :
     ++			  GIT_REPO_VERSION);
       	git_config_set("core.repositoryformatversion", repo_version_string);
       
       	/* Check filemode trustability */
     +@@
     + }
     + 
     + int init_db(const char *git_dir, const char *real_git_dir,
     +-	    const char *template_dir, unsigned int flags)
     ++	    const char *template_dir, const char *ref_storage_format,
     ++	    unsigned int flags)
     + {
     + 	int reinit;
     + 	int exist_ok = flags & INIT_DB_EXIST_OK;
      @@
       	 */
       	check_repository_format();
       
      -	reinit = create_default_files(template_dir, original_git_dir);
     -+	reinit = create_default_files(template_dir, original_git_dir, flags);
     ++	reinit = create_default_files(template_dir, original_git_dir,
     ++				      ref_storage_format, flags);
       
       	create_object_directory();
       
     @@ -185,14 +227,18 @@ $^
       		git_config_set("receive.denyNonFastforwards", "true");
       	}
       
     -+	if (flags & INIT_DB_REFTABLE) {
     -+		git_config_set("extensions.refStorage", "reftable");
     -+	}
     ++	git_config_set("extensions.refStorage", ref_storage_format);
      +
       	if (!(flags & INIT_DB_QUIET)) {
       		int len = strlen(git_dir);
       
      @@
     + int cmd_init_db(int argc, const char **argv, const char *prefix)
     + {
     + 	const char *git_dir;
     ++	const char *ref_storage_format = DEFAULT_REF_STORAGE;
     + 	const char *real_git_dir = NULL;
     + 	const char *work_tree;
       	const char *template_dir = NULL;
       	unsigned int flags = 0;
       	const struct option init_db_options[] = {
     @@ -212,23 +258,38 @@ $^
      +		  N_("specify that the git repository is to be shared amongst several users"),
      +		  PARSE_OPT_OPTARG | PARSE_OPT_NONEG, shared_callback, 0 },
       		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
     -+		OPT_BIT(0, "reftable", &flags, N_("use reftable"),
     -+			INIT_DB_REFTABLE),
     ++		OPT_STRING(0, "ref-storage", &ref_storage_format, N_("backend"),
     ++			   N_("the ref storage format to use")),
       		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
       			   N_("separate git dir from working tree")),
       		OPT_END()
     +@@
     + 	}
     + 
     + 	UNLEAK(real_git_dir);
     ++	UNLEAK(ref_storage_format);
     + 	UNLEAK(git_dir);
     + 	UNLEAK(work_tree);
     + 
     + 	flags |= INIT_DB_EXIST_OK;
     +-	return init_db(git_dir, real_git_dir, template_dir, flags);
     ++	return init_db(git_dir, real_git_dir, template_dir, ref_storage_format,
     ++		       flags);
     + }
      
       diff --git a/cache.h b/cache.h
       --- a/cache.h
       +++ b/cache.h
      @@
     - 
     - #define INIT_DB_QUIET 0x0001
       #define INIT_DB_EXIST_OK 0x0002
     -+#define INIT_DB_REFTABLE 0x0004
       
       int init_db(const char *git_dir, const char *real_git_dir,
     - 	    const char *template_dir, unsigned int flags);
     +-	    const char *template_dir, unsigned int flags);
     ++	    const char *template_dir, const char *ref_storage_format,
     ++	    unsigned int flags);
     + 
     + void sanitize_stdfds(void);
     + int daemonize(void);
      @@
       	int is_bare;
       	int hash_algo;
     @@ -274,7 +335,7 @@ $^
      -	r->refs = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
      +	r->refs = ref_store_init(r->gitdir,
      +				 r->ref_storage_format ? r->ref_storage_format :
     -+							 "files",
     ++							 DEFAULT_REF_STORAGE,
      +				 REF_STORE_ALL_CAPS);
       	return r->refs;
       }
     @@ -284,7 +345,7 @@ $^
       
       	/* assume that add_submodule_odb() has been called */
      -	refs = ref_store_init(submodule_sb.buf,
     -+	refs = ref_store_init(submodule_sb.buf, "files", /* XXX */
     ++	refs = ref_store_init(submodule_sb.buf, DEFAULT_REF_STORAGE, /* XXX */
       			      REF_STORE_READ | REF_STORE_ODB);
       	register_ref_store_map(&submodule_ref_stores, "submodule",
       			       refs, submodule);
     @@ -292,7 +353,7 @@ $^
       
       struct ref_store *get_worktree_ref_store(const struct worktree *wt)
       {
     -+	const char *format = "files"; /* XXX */
     ++	const char *format = DEFAULT_REF_STORAGE; /* XXX */
       	struct ref_store *refs;
       	const char *id;
       
     @@ -309,6 +370,20 @@ $^
       
       	if (refs)
      
     + diff --git a/refs.h b/refs.h
     + --- a/refs.h
     + +++ b/refs.h
     +@@
     + struct string_list_item;
     + struct worktree;
     + 
     ++/* XXX where should this be? */
     ++#define DEFAULT_REF_STORAGE "files"
     ++
     + /*
     +  * Resolve a reference, recursively following symbolic refererences.
     +  *
     +
       diff --git a/refs/refs-internal.h b/refs/refs-internal.h
       --- a/refs/refs-internal.h
       +++ b/refs/refs-internal.h

-- 
gitgitgadget
