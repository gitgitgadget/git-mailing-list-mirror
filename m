Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F737C352A3
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 22:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C010020730
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 22:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmtFEYL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgBFW4C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 17:56:02 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:53983 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgBFW4C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 17:56:02 -0500
Received: by mail-wm1-f51.google.com with SMTP id s10so616625wmh.3
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 14:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=D3VwPrdD8cJjAZ4A47TA4XSzSJQkrMvQnsfoEQI4104=;
        b=dmtFEYL+R42vW3bIxT/Kbfl64afIdJln82xBCJlrwVF2g3hWpcIidz8eJBG2VsqjMi
         ljUWr/4fG3w8JDOCevqSuv5tBrSYr3vCAn6RL4/RnAoL0P57aP+TyHgYiik8bqzeKc0t
         DXJHI03kPVm6FdYOttsJ6GibFyx5WSSTTAkeqMfAn2uRBhfKIgvRT60SBPcYz7H8Iyv1
         GXH5s4vcQ+c96VcLOx9kCyX4hboBEA66GEW2l30XYVnpZb+IWbEjCzxh4cGDhWakw67J
         sy4T6U5m/KID9L30Po3oYne3C9J+sAPy3lqFLjY4gXGuu7umXj5qUfySy54S2lYzbV7a
         kxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=D3VwPrdD8cJjAZ4A47TA4XSzSJQkrMvQnsfoEQI4104=;
        b=pS3vQcT49Y5DAd0cSmwbKOJ2E+1BY6Ly9Y6lY3HFrvfv9v+4LgD8M+olHJ4UKmmfeD
         Pavvc0o/GKhV9THLUn+IQHmVsffFqne8DFjljjHcHY6gnpnnSMSpZtIky/Z+ueJpog2S
         j8rni+Dz90tTWOiGzFnxkvpuDk5L3y04DQ0zlljFRztDz531h2DVESv+/4u88o66e15I
         VzFqQreyl2COs3TPfEneKqhnL7UssNb3YRgYvE5ljKShebCmdCf+n6J0DIncBJoklonP
         iG/Ai1vBWB66Bb3mEDv5SLuK3Fpz7XBQ9y5a5WKg0wLqNaXTOOOlZDIjnNIiayohzBGg
         gcUw==
X-Gm-Message-State: APjAAAWJVWe3EDz50Yy8or/HGlMjPBictgHsIoLumDO8reZSlcPFnAkI
        fT+G/dd2DEoH9Xs0wXSppxwyo8iY
X-Google-Smtp-Source: APXvYqxLTeE/tIeAoHUH5gqqWDsAYXot8mcR26BIJKoaJ52/QC4022ottIwlU/fgugHJ2x9yM9PZaQ==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr106354wmb.150.1581029758247;
        Thu, 06 Feb 2020 14:55:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m21sm1066600wmi.27.2020.02.06.14.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 14:55:57 -0800 (PST)
Message-Id: <pull.539.v4.git.1581029756.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
References: <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Feb 2020 22:55:51 +0000
Subject: [PATCH v4 0/5] Reftable support git-core
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

 Makefile                |   24 +-
 builtin/init-db.c       |   49 +-
 cache.h                 |    2 +
 refs.c                  |   20 +-
 refs.h                  |    5 +-
 refs/files-backend.c    |    6 +
 refs/refs-internal.h    |    6 +
 refs/reftable-backend.c |  880 +++++++++++++++++++++++++++++++
 reftable/LICENSE        |   31 ++
 reftable/README.md      |   19 +
 reftable/VERSION        |    5 +
 reftable/basics.c       |  196 +++++++
 reftable/basics.h       |   37 ++
 reftable/block.c        |  401 ++++++++++++++
 reftable/block.h        |   71 +++
 reftable/blocksource.h  |   20 +
 reftable/bytes.c        |    0
 reftable/config.h       |    1 +
 reftable/constants.h    |   27 +
 reftable/dump.c         |   97 ++++
 reftable/file.c         |   97 ++++
 reftable/iter.c         |  229 ++++++++
 reftable/iter.h         |   56 ++
 reftable/merged.c       |  286 ++++++++++
 reftable/merged.h       |   34 ++
 reftable/pq.c           |  114 ++++
 reftable/pq.h           |   34 ++
 reftable/reader.c       |  708 +++++++++++++++++++++++++
 reftable/reader.h       |   52 ++
 reftable/record.c       | 1107 +++++++++++++++++++++++++++++++++++++++
 reftable/record.h       |   79 +++
 reftable/reftable.h     |  399 ++++++++++++++
 reftable/slice.c        |  199 +++++++
 reftable/slice.h        |   39 ++
 reftable/stack.c        |  983 ++++++++++++++++++++++++++++++++++
 reftable/stack.h        |   40 ++
 reftable/system.h       |   55 ++
 reftable/tree.c         |   66 +++
 reftable/tree.h         |   24 +
 reftable/writer.c       |  623 ++++++++++++++++++++++
 reftable/writer.h       |   46 ++
 reftable/zlib-compat.c  |   92 ++++
 repository.c            |    2 +
 repository.h            |    3 +
 setup.c                 |   12 +-
 45 files changed, 7248 insertions(+), 28 deletions(-)
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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-539%2Fhanwen%2Freftable-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-539/hanwen/reftable-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/539

Range-diff vs v3:

 1:  c00403c94d = 1:  c00403c94d refs.h: clarify reflog iteration order
 2:  57c7342319 < -:  ---------- setup.c: enable repo detection for reftable
 3:  5b7060cb2f ! 2:  4d6da9bc47 create .git/refs in files-backend.c
     @@ -29,9 +29,13 @@
       
      +	files_ref_path(refs, &sb, "refs");
      +	safe_create_dir(sb.buf, 1);
     -+        /* adjust permissions even if directory already exists. */
     ++	/* adjust permissions even if directory already exists. */
      +	adjust_shared_perm(sb.buf);
      +
       	/*
       	 * Create .git/refs/{heads,tags}
       	 */
     ++	strbuf_reset(&sb);
     + 	files_ref_path(refs, &sb, "refs/heads");
     + 	safe_create_dir(sb.buf, 1);
     + 
 4:  1b01c735a9 = 3:  fbdcdccc88 refs: document how ref_iterator_advance_fn should handle symrefs
 5:  eb0df10068 ! 4:  02d2ca8b87 Add reftable library
     @@ -98,11 +98,11 @@
       --- /dev/null
       +++ b/reftable/VERSION
      @@
     -+commit e54326f73d95bfe8b17f264c400f4c365dbd5e5e
     ++commit e7c3fc3099d9999bc8d895f84027b0e36348d5e6
      +Author: Han-Wen Nienhuys <hanwen@google.com>
     -+Date:   Tue Feb 4 19:48:17 2020 +0100
     ++Date:   Thu Feb 6 20:17:40 2020 +0100
      +
     -+    C: PRI?MAX use; clang-format.
     ++    C: use inttypes.h header definitions
      
       diff --git a/reftable/basics.c b/reftable/basics.c
       new file mode 100644
     @@ -2882,7 +2882,7 @@
      +{
      +	char hex[SHA256_SIZE + 1] = {};
      +
     -+	printf("ref{%s(%" PRIdMAX ") ", ref->ref_name, ref->update_index);
     ++	printf("ref{%s(%" PRIu64 ") ", ref->ref_name, ref->update_index);
      +	if (ref->value != NULL) {
      +		hex_format(hex, ref->value, hash_size);
      +		printf("%s", hex);
     @@ -3274,9 +3274,9 @@
      +{
      +	char hex[SHA256_SIZE + 1] = {};
      +
     -+	printf("log{%s(%" PRIdMAX ") %s <%s> %" PRIuMAX " %04d\n",
     -+	       log->ref_name, log->update_index, log->name, log->email,
     -+	       log->time, log->tz_offset);
     ++	printf("log{%s(%" PRIu64 ") %s <%s> %" PRIu64 " %04d\n", log->ref_name,
     ++	       log->update_index, log->name, log->email, log->time,
     ++	       log->tz_offset);
      +	hex_format(hex, log->old_hash, hash_size);
      +	printf("%s => ", hex);
      +	hex_format(hex, log->new_hash, hash_size);
     @@ -4860,7 +4860,7 @@
      +static void format_name(struct slice *dest, uint64_t min, uint64_t max)
      +{
      +	char buf[100];
     -+	snprintf(buf, sizeof(buf), "%012" PRIxMAX "-%012" PRIxMAX, min, max);
     ++	snprintf(buf, sizeof(buf), "%012" PRIx64 "-%012" PRIx64, min, max);
      +	slice_set_string(dest, buf);
      +}
      +
     @@ -5585,6 +5585,7 @@
      +#include <assert.h>
      +#include <errno.h>
      +#include <fcntl.h>
     ++#include <inttypes.h>
      +#include <stdint.h>
      +#include <stdio.h>
      +#include <stdlib.h>
     @@ -5595,9 +5596,6 @@
      +#include <unistd.h>
      +#include <zlib.h>
      +
     -+#define PRIuMAX "lu"
     -+#define PRIdMAX "ld"
     -+#define PRIxMAX "lx"
      +#define ARRAY_SIZE(a) sizeof((a)) / sizeof((a)[0])
      +#define FREE_AND_NULL(x)    \
      +	do {                \
     @@ -5605,14 +5603,14 @@
      +		(x) = NULL; \
      +	} while (0)
      +#define QSORT(arr, n, cmp) qsort(arr, n, sizeof(arr[0]), cmp)
     -+#define SWAP(a, b) \
     -+  { \
     -+     char tmp[sizeof(a)]; \
     -+     assert(sizeof(a)==sizeof(b)); \
     -+     memcpy(&tmp[0], &a, sizeof(a)); \
     -+     memcpy(&a, &b, sizeof(a)); \
     -+     memcpy(&b, &tmp[0], sizeof(a)); \
     -+  }
     ++#define SWAP(a, b)                              \
     ++	{                                       \
     ++		char tmp[sizeof(a)];            \
     ++		assert(sizeof(a) == sizeof(b)); \
     ++		memcpy(&tmp[0], &a, sizeof(a)); \
     ++		memcpy(&a, &b, sizeof(a));      \
     ++		memcpy(&b, &tmp[0], sizeof(a)); \
     ++	}
      +#endif
      +
      +int uncompress_return_consumed(Bytef *dest, uLongf *destLen,
     @@ -5758,6 +5756,7 @@
      +		return &w->stats.log_stats;
      +	}
      +	assert(false);
     ++	return NULL;
      +}
      +
      +/* write data, queuing the padding for the next write. Returns negative for
     @@ -6299,7 +6298,7 @@
      +	w->stats.blocks++;
      +
      +	if (debug) {
     -+		fprintf(stderr, "block %c off %" PRIuMAX " sz %d (%d)\n", typ,
     ++		fprintf(stderr, "block %c off %" PRIu64 " sz %d (%d)\n", typ,
      +			w->next, raw_bytes,
      +			get_u24(w->block + w->block_writer->header_off + 1));
      +	}
 6:  0b2a1a81d6 ! 5:  2786a6bf61 Reftable support for git-core
     @@ -39,6 +39,7 @@
            reftable.LogRecord{RefName:"HEAD", UpdateIndex:0x2, New:[]uint8{0x37, 0x3d, 0x96, 0x97, 0x2f, 0xca, 0x9b, 0x63, 0x59, 0x57, 0x40, 0xbb, 0xa3, 0x89, 0x8a, 0x76, 0x27, 0x78, 0xba, 0x20}, Old:[]uint8{0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, Name:"Han-Wen Nienhuys", Email:"hanwen@google.com", Time:0x5e29ef27, TZOffset:100, Message:"commit (initial): x\n"}
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Co-authored-by: Jeff King <peff@peff.net>
      
       diff --git a/Makefile b/Makefile
       --- a/Makefile
     @@ -120,6 +121,31 @@ $^
       {
       	struct stat st1;
       	struct strbuf buf = STRBUF_INIT;
     +@@
     + 	is_bare_repository_cfg = init_is_bare_repository;
     + 	if (init_shared_repository != -1)
     + 		set_shared_repository(init_shared_repository);
     ++	if (flags & INIT_DB_REFTABLE)
     ++		the_repository->ref_storage_format = xstrdup("reftable");
     + 
     + 	/*
     + 	 * We would have created the above under user's umask -- under
     +@@
     + 		adjust_shared_perm(get_git_dir());
     + 	}
     + 
     ++	/*
     ++	 * Check to see if .git/HEAD exists; this must happen before
     ++	 * initializing the ref db, because we want to see if there is an
     ++	 * existing HEAD.
     ++	 */
     ++	path = git_path_buf(&buf, "HEAD");
     ++	reinit = (!access(path, R_OK) ||
     ++		  readlink(path, junk, sizeof(junk) - 1) != -1);
     ++
     + 	/*
     + 	 * We need to create a "refs" dir in any case so that older
     + 	 * versions of git can tell that this is a repository.
      @@
       	 * Create the default symlink from ".git/HEAD" to the "master"
       	 * branch, if it does not exist yet.
     @@ -127,18 +153,14 @@ $^
      -	path = git_path_buf(&buf, "HEAD");
      -	reinit = (!access(path, R_OK)
      -		  || readlink(path, junk, sizeof(junk)-1) != -1);
     -+	if (flags & INIT_DB_REFTABLE) {
     -+		reinit = 0; /* XXX - how do we recognize a reinit,
     -+			     * and what should we do? */
     -+	} else {
     -+		path = git_path_buf(&buf, "HEAD");
     -+		reinit = (!access(path, R_OK) ||
     -+			  readlink(path, junk, sizeof(junk) - 1) != -1);
     -+	}
     -+
       	if (!reinit) {
       		if (create_symref("HEAD", "refs/heads/master", NULL) < 0)
       			exit(1);
     ++	} else {
     ++		/*
     ++		 * XXX should check whether our ref backend matches the
     ++		 * original one; if not, either die() or convert
     ++		 */
       	}
       
       	/* This forces creation of new config file */
     @@ -251,10 +273,8 @@ $^
       
      -	r->refs = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
      +	r->refs = ref_store_init(r->gitdir,
     -+				 /* XXX r->ref_storage_format == NULL. Where
     -+				  * should the config file be parsed out? */
      +				 r->ref_storage_format ? r->ref_storage_format :
     -+							 "reftable",
     ++							 "files",
      +				 REF_STORE_ALL_CAPS);
       	return r->refs;
       }
     @@ -410,13 +430,14 @@ $^
      +{
      +	struct reftable_ref_store *refs =
      +		(struct reftable_ref_store *)ref_store;
     -+
     ++	FILE *file;
      +	safe_create_dir(refs->reftable_dir, 1);
     -+	FILE *f = fopen(refs->table_list_file, "a");
     -+	if (f == NULL) {
     ++
     ++	file = fopen(refs->table_list_file, "a");
     ++	if (file == NULL) {
      +		return -1;
      +	}
     -+	fclose(f);
     ++	fclose(file);
      +	return 0;
      +}
      +
     @@ -777,7 +798,6 @@ $^
      +			log.old_hash = old_oid.hash;
      +		}
      +
     -+		/* XXX should the resolution be done relative or absolute? */
      +		if (refs_resolve_ref_unsafe((struct ref_store *)create->refs,
      +					    create->target, RESOLVE_REF_READING,
      +					    &new_oid, NULL) != NULL) {
     @@ -1194,9 +1214,7 @@ $^
       	if (worktree)
       		repo_set_worktree(repo, worktree);
       
     -+	repo->ref_storage_format = format.ref_storage != NULL ?
     -+					   xstrdup(format.ref_storage) :
     -+					   "files"; /* XXX */
     ++	repo->ref_storage_format = xstrdup_or_null(format.ref_storage);
      +
       	clear_repository_format(&format);
       	return 0;
     @@ -1227,7 +1245,7 @@ $^
      +		} else if (!strcmp(ext, "worktreeconfig")) {
       			data->worktree_config = git_config_bool(var, value);
      -		else
     -+		} else if (!strcmp(ext, "refStorage")) {
     ++		} else if (!strcmp(ext, "refstorage")) {
      +			data->ref_storage = xstrdup(value);
      +		} else
       			string_list_append(&data->unknown_extensions, ext);
     @@ -1241,3 +1259,16 @@ $^
       	init_repository_format(format);
       }
       
     +@@
     + 				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
     + 			setup_git_env(gitdir);
     + 		}
     +-		if (startup_info->have_repository)
     ++		if (startup_info->have_repository) {
     + 			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
     ++			the_repository->ref_storage_format =
     ++				xstrdup_or_null(repo_fmt.ref_storage);
     ++		}
     + 	}
     + 
     + 	strbuf_release(&dir);

-- 
gitgitgadget
