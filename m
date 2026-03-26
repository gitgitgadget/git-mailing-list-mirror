Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEBB260592
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774530443; cv=none; b=CRBwFsqIgPgXcxTdnsgkomSWUxeHYVau81GKmySUKiiTVcEvwCXfPB+rWamNKoTadqQekZU9C1SxaKI2JFDUIU5KtaLQUjhEnDHvx7x3NL2nXaQg+ipfel2ESouBf3EHDndav27tREYqFk4T8j7xr2IMiiyveY5I9EKMKYAh6ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774530443; c=relaxed/simple;
	bh=YJaL45bHJ8mT+eBdA0Ok+q/8ElRZZvl9kF9SbvsD1gA=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Cqp3hWkibM9lMNn915bNF/hKCvhwBH8CVKyCABOuOa8c3INUr+Xe1BI4sAU9S30voXytG9joImwvCBQZOoKqlHNbLk/7ICMz2U5yUcQoh3jfuTf/DOsJvbOwRh8vd6Ng7oCDrz2OB2JBG1EiESU+oyTPSsrY8l1rdXzXnyHgZPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bExfymOU; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bExfymOU"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-46805c4ae5dso359150b6e.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 06:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774530440; x=1775135240; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AgZ7JJ+VMNgSfD7tjXo/GzsTNB/JTPXdaf4lprNDEU8=;
        b=bExfymOU1nAz04ODe8tez3O1w5PCH4QGbtW1qyQBnG8K3RrBIxna2FJOCKmhJPl0Qn
         5gn3Qrnuk8nj50OuhYJrwFy/FYFjr6Lj5DWg1cFauqOaAL1ThrtFoTCyzUXAqqTADNK1
         guHBYgtlBqFsmV6vN7OH/gHLFtdycliYMZp0HKspJGJVh+5oDOgAyZpQ+e4FapLc2fJ2
         aBjyj/mRtnL/1KH6mYUTCW3pQ1kGYPA4c9pELiC44CBA1Y+9YmWT3azgsOCe5kzy8NDg
         NtlXpFJeZZv3Awx1ZqHKfBF/uzI/sAA5Da6H4F3ceuaJzAPJXhQKh7tTKO8JEhob2LvC
         ImpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774530440; x=1775135240;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgZ7JJ+VMNgSfD7tjXo/GzsTNB/JTPXdaf4lprNDEU8=;
        b=AquSSCQr0KUNhMD0Rn+YY7Fcq1QsKq/BgM6sO0d9QLOh7ZuyZUnGEp6dGgtSIjc8t1
         jw+Yiq2aC35mKU1gc7CNnaQ/Fz+mUA/OixxLiwLcqbEQDdpZZjzia8/si9e9+Pwweaoj
         K5L9bi61cPhhpY3jMjMhLgmz96rZgfGtjevFaIZOCN/41tDWXgCSpC52RwdmRBoZHw/H
         R7YRLrUagPI7oO8RU0WsN7QxtKfxqh1r/2zeA0woMy+88JP6rcbqjiD8XJ0iKgGO+GMh
         wDrXcTFhM74qeIclnEAJyu5OTPTcYXNHf1qMTu24fVaI2n1gRG8wgl516XZ5ehb9pxrL
         3SDw==
X-Gm-Message-State: AOJu0Yzgme1QELEJEClr0R4ry0AnkQ1MsDAxIf2iSsEea7B4gOY5oAtk
	tLIDx3TkP0DmQa8jzqBntMwMhK5BaOmgp3yOpn5OGPOUr2gGqvepr4L5rT4qww==
X-Gm-Gg: ATEYQzwpqhykcx5ufScrmAxcUC0bYM/NrzLNiAYeh/Q1ylXW8Sgl0AwDHSfkUJzZxiv
	+GpZwvnmVCRXi6YJ0y1xest/4NR5nLHpzSbc1HOIZuGgKeZkjz3CVVJ03WDAwaXNeLSmIeKCLwZ
	Z51mYSkCL5G13XXvtTzi0kQ1VJZAKcWZ9TK0z7KKUJJCQVueiCp0KZ35+gX63K5Tt6HO3afutB9
	rBmnuqlYp6q1K58m1R5vRYsG5/XeMoaTLbZ7VMeF8l+4qiothc7fPGNfTN25luRwPrA/bQk78NL
	oqLz/behH39GaJEXKNQxIicWCqW9i6iRBqFdOSIERuEPxrQ5tBuYOjLpUptG7AQfo8fKlG6B8xu
	MoQclZYE/uCDKeiJzsdpR8ADVe3m4edD9e+nh5v8qXS46Pmb233DKp9zA0tbsM1E2B8eWDJFcJg
	fuRHCymWRxqweYHRR5JHZE2FLo
X-Received: by 2002:a05:6808:1582:b0:467:14c7:a8ba with SMTP id 5614622812f47-46a5c6e70d1mr3721306b6e.32.1774530439612;
        Thu, 26 Mar 2026 06:07:19 -0700 (PDT)
Received: from [127.0.0.1] ([135.119.38.43])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46a73ae98bbsm1288048b6e.18.2026.03.26.06.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 06:07:18 -0700 (PDT)
Message-Id: <pull.2074.git.1774530437562.gitgitgadget@gmail.com>
From: "Aaron Paterson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Mar 2026 13:07:17 +0000
Subject: [PATCH] odb: add write_packfile, for_each_unique_abbrev,
 convert_object_id
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
Cc: Aaron Paterson <apaterson@pm.me>,
    Aaron Paterson <apaterson@pm.me>

From: Aaron Paterson <apaterson@pm.me>

Add three vtable methods to odb_source that were not part of the
recent ps/odb-sources and ps/object-counting series:

 - write_packfile: ingest a pack from a file descriptor. The files
   backend chooses between index-pack (large packs) and
   unpack-objects (small packs below fetch.unpackLimit). Options
   cover thin-pack fixing, promisor marking, fsck, lockfile
   capture, and shallow file passing.

 - for_each_unique_abbrev: iterate objects matching a hex prefix
   for disambiguation. Searches loose objects via oidtree, then
   multi-pack indices, then non-MIDX packs.

 - convert_object_id: translate between hash algorithms using the
   loose object map. Used during SHA-1 to SHA-256 migration.

Also add ODB_SOURCE_HELPER to the source type enum, preparing for
the helper backend in the next commit.

The write_packfile vtable method replaces the pattern where callers
spawn index-pack/unpack-objects directly. fast-import already uses
odb_write_packfile() and this allows non-files backends to handle
pack ingestion through their own mechanism.

Signed-off-by: Aaron Paterson <apaterson@pm.me>
---
    odb: add write_packfile, for_each_unique_abbrev, convert_object_id
    
    This adds three ODB source vtable methods that were not part of the
    recent ps/odb-sources and ps/object-counting series, plus caller routing
    for object-name.c.
    
    New vtable methods:
    
     * write_packfile: Ingest a pack from a file descriptor. The files
       backend chooses between index-pack (large packs) and unpack-objects
       (small packs below fetch.unpackLimit). Options cover thin-pack
       fixing, promisor marking, fsck, lockfile capture, and shallow file
       passing. Non-files backends can handle pack ingestion through their
       own mechanism.
    
     * for_each_unique_abbrev: Iterate objects matching a hex prefix for
       disambiguation. The files backend searches loose objects via oidtree,
       multi-pack indices, then non-MIDX packs.
    
     * convert_object_id: Translate between hash algorithms using the loose
       object map. Used during SHA-1 to SHA-256 migration.
    
    Caller routing in object-name.c:
    
    The abbreviation and disambiguation paths in object-name.c
    (find_short_object_filename, find_abbrev_len_packed, and
    find_short_packed_object) directly access files-backend internals (loose
    cache, pack store, MIDX). These are converted to dispatch through the
    for_each_unique_abbrev vtable method, so that non-files backends
    participate in abbreviation and disambiguation through proper
    abstraction rather than being skipped.
    
    This addresses Patrick's feedback on the previous submission [1]: the
    correct fix for downcast sites is proper vtable abstraction, not
    skipping non-files backends.
    
    Additional:
    
     * ODB_SOURCE_HELPER added to the source type enum
     * odb/source-type.h extracted to avoid circular includes with
       repository.h
     * OBJECT_INFO_KEPT_ONLY flag for backends that track kept status
     * self_contained_out output field on odb_write_packfile_options
    
    Motivation: These methods are needed by the local helper backend series
    [2], which delegates object and reference storage to external git-local-
    helper processes. sqlite-git [3] is a working proof of concept that
    stores objects, refs, and reflogs in a single SQLite database with full
    worktree support.
    
    CC: Junio C Hamano gitster@pobox.com, Patrick Steinhardt ps@pks.im
    
    [1] https://github.com/gitgitgadget/git/pull/2068.patch [2]
    https://github.com/gitgitgadget/git/compare/master...MayCXC:git:ps/series-2-helpers-v3.patch
    [3] https://github.com/MayCXC/sqlite-git

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2074%2FMayCXC%2Fps%2Fseries-1-vtable-v3-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2074/MayCXC/ps/series-1-vtable-v3-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2074

 object-name.c      |  79 ++++++++++----
 odb.c              |  26 +++++
 odb.h              |  26 +++++
 odb/source-files.c | 259 +++++++++++++++++++++++++++++++++++++++++++++
 odb/source.h       | 108 +++++++++++++++++++
 5 files changed, 480 insertions(+), 18 deletions(-)

diff --git a/object-name.c b/object-name.c
index e5adec4c9d..8f503b985f 100644
--- a/object-name.c
+++ b/object-name.c
@@ -20,6 +20,7 @@
 #include "packfile.h"
 #include "pretty.h"
 #include "object-file.h"
+#include "odb/source.h"
 #include "read-cache-ll.h"
 #include "repo-settings.h"
 #include "repository.h"
@@ -111,13 +112,28 @@ static enum cb_next match_prefix(const struct object_id *oid, void *arg)
 	return ds->ambiguous ? CB_BREAK : CB_CONTINUE;
 }
 
+static int disambiguate_cb(const struct object_id *oid,
+			   struct object_info *oi UNUSED, void *data)
+{
+	struct disambiguate_state *ds = data;
+	update_candidates(ds, oid);
+	return ds->ambiguous ? 1 : 0;
+}
+
 static void find_short_object_filename(struct disambiguate_state *ds)
 {
 	struct odb_source *source;
 
-	for (source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next)
-		oidtree_each(odb_source_loose_cache(source, &ds->bin_pfx),
-				&ds->bin_pfx, ds->len, match_prefix, ds);
+	for (source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next) {
+		if (source->for_each_unique_abbrev) {
+			odb_source_for_each_unique_abbrev(
+				source, &ds->bin_pfx, ds->len,
+				disambiguate_cb, ds);
+		} else {
+			oidtree_each(odb_source_loose_cache(source, &ds->bin_pfx),
+					&ds->bin_pfx, ds->len, match_prefix, ds);
+		}
+	}
 }
 
 static int match_hash(unsigned len, const unsigned char *a, const unsigned char *b)
@@ -208,15 +224,23 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 
 	odb_prepare_alternates(ds->repo->objects);
 	for (source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next) {
-		struct multi_pack_index *m = get_multi_pack_index(source);
-		if (m)
-			unique_in_midx(m, ds);
+		if (source->for_each_unique_abbrev) {
+			odb_source_for_each_unique_abbrev(
+				source, &ds->bin_pfx, ds->len,
+				disambiguate_cb, ds);
+		} else {
+			struct multi_pack_index *m = get_multi_pack_index(source);
+			if (m)
+				unique_in_midx(m, ds);
+		}
 	}
 
-	repo_for_each_pack(ds->repo, p) {
-		if (ds->ambiguous)
-			break;
-		unique_in_pack(p, ds);
+	if (!ds->repo->objects->sources->for_each_unique_abbrev) {
+		repo_for_each_pack(ds->repo, p) {
+			if (ds->ambiguous)
+				break;
+			unique_in_pack(p, ds);
+		}
 	}
 }
 
@@ -796,19 +820,38 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
 	mad->init_len = mad->cur_len;
 }
 
-static void find_abbrev_len_packed(struct min_abbrev_data *mad)
+static int abbrev_len_cb(const struct object_id *oid,
+			 struct object_info *oi UNUSED, void *data)
 {
-	struct packed_git *p;
+	struct min_abbrev_data *mad = data;
+	extend_abbrev_len(oid, mad);
+	return 0;
+}
 
+static void find_abbrev_len_packed(struct min_abbrev_data *mad)
+{
 	odb_prepare_alternates(mad->repo->objects);
-	for (struct odb_source *source = mad->repo->objects->sources; source; source = source->next) {
-		struct multi_pack_index *m = get_multi_pack_index(source);
-		if (m)
-			find_abbrev_len_for_midx(m, mad);
+
+	for (struct odb_source *source = mad->repo->objects->sources;
+	     source; source = source->next) {
+		if (source->for_each_unique_abbrev) {
+			mad->init_len = 0;
+			odb_source_for_each_unique_abbrev(
+				source, mad->oid, mad->cur_len,
+				abbrev_len_cb, mad);
+			mad->init_len = mad->cur_len;
+		} else {
+			struct multi_pack_index *m = get_multi_pack_index(source);
+			if (m)
+				find_abbrev_len_for_midx(m, mad);
+		}
 	}
 
-	repo_for_each_pack(mad->repo, p)
-		find_abbrev_len_for_pack(p, mad);
+	if (!mad->repo->objects->sources->for_each_unique_abbrev) {
+		struct packed_git *p;
+		repo_for_each_pack(mad->repo, p)
+			find_abbrev_len_for_pack(p, mad);
+	}
 }
 
 void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
diff --git a/odb.c b/odb.c
index 350e23f3c0..3032d5492c 100644
--- a/odb.c
+++ b/odb.c
@@ -981,6 +981,32 @@ int odb_write_object_stream(struct object_database *odb,
 	return odb_source_write_object_stream(odb->sources, stream, len, oid);
 }
 
+int odb_write_packfile(struct object_database *odb,
+		       int pack_fd,
+		       struct odb_write_packfile_options *opts)
+{
+	return odb_source_write_packfile(odb->sources, pack_fd, opts);
+}
+
+int odb_for_each_unique_abbrev(struct object_database *odb,
+			       const struct object_id *oid_prefix,
+			       unsigned int prefix_len,
+			       odb_for_each_object_cb cb,
+			       void *cb_data)
+{
+	int ret;
+
+	odb_prepare_alternates(odb);
+	for (struct odb_source *source = odb->sources; source; source = source->next) {
+		ret = odb_source_for_each_unique_abbrev(source, oid_prefix,
+							prefix_len, cb, cb_data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 struct object_database *odb_new(struct repository *repo,
 				const char *primary_source,
 				const char *secondary_sources)
diff --git a/odb.h b/odb.h
index 9aee260105..99d6674706 100644
--- a/odb.h
+++ b/odb.h
@@ -374,6 +374,13 @@ enum object_info_flags {
 	 * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK.
 	 */
 	OBJECT_INFO_FOR_PREFETCH = (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK),
+
+	/*
+	 * Only consider objects marked as "kept" (surviving GC). Used by
+	 * helper backends that track kept status per object. Backends that
+	 * do not support kept tracking should return -1 (not found).
+	 */
+	OBJECT_INFO_KEPT_ONLY = (1 << 5),
 };
 
 /*
@@ -570,6 +577,25 @@ int odb_write_object_stream(struct object_database *odb,
 			    struct odb_write_stream *stream, size_t len,
 			    struct object_id *oid);
 
+/*
+ * Ingest a pack from a file descriptor into the primary source.
+ * Returns 0 on success, a negative error code otherwise.
+ */
+struct odb_write_packfile_options;
+int odb_write_packfile(struct object_database *odb,
+		       int pack_fd,
+		       struct odb_write_packfile_options *opts);
+
+/*
+ * Iterate over all objects across all sources whose ID starts with
+ * the given prefix. Used for object name disambiguation.
+ */
+int odb_for_each_unique_abbrev(struct object_database *odb,
+			       const struct object_id *oid_prefix,
+			       unsigned int prefix_len,
+			       odb_for_each_object_cb cb,
+			       void *cb_data);
+
 void parse_alternates(const char *string,
 		      int sep,
 		      const char *relative_base,
diff --git a/odb/source-files.c b/odb/source-files.c
index c08d8993e3..e450c87f91 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -1,14 +1,21 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "chdir-notify.h"
+#include "config.h"
 #include "gettext.h"
 #include "lockfile.h"
+#include "loose.h"
+#include "midx.h"
 #include "object-file.h"
 #include "odb.h"
 #include "odb/source.h"
 #include "odb/source-files.h"
+#include "pack-objects.h"
 #include "packfile.h"
+#include "run-command.h"
 #include "strbuf.h"
+#include "strvec.h"
+#include "oidtree.h"
 #include "write-or-die.h"
 
 static void odb_source_files_reparent(const char *name UNUSED,
@@ -232,6 +239,255 @@ out:
 	return ret;
 }
 
+static int odb_source_files_write_packfile(struct odb_source *source,
+					   int pack_fd,
+					   struct odb_write_packfile_options *opts)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	int fsck_objects = 0;
+	int use_index_pack = 1;
+	int ret;
+
+	if (opts && opts->nr_objects) {
+		int transfer_unpack_limit = -1;
+		int fetch_unpack_limit = -1;
+		int unpack_limit = 100;
+
+		repo_config_get_int(source->odb->repo, "fetch.unpacklimit",
+				    &fetch_unpack_limit);
+		repo_config_get_int(source->odb->repo, "transfer.unpacklimit",
+				    &transfer_unpack_limit);
+		if (0 <= fetch_unpack_limit)
+			unpack_limit = fetch_unpack_limit;
+		else if (0 <= transfer_unpack_limit)
+			unpack_limit = transfer_unpack_limit;
+
+		if (opts->nr_objects < (unsigned int)unpack_limit &&
+		    !opts->from_promisor && !opts->lockfile_out)
+			use_index_pack = 0;
+	}
+
+	cmd.in = pack_fd;
+	cmd.git_cmd = 1;
+
+	if (!use_index_pack) {
+		strvec_push(&cmd.args, "unpack-objects");
+		if (opts && opts->quiet)
+			strvec_push(&cmd.args, "-q");
+		if (opts && opts->pack_header_version)
+			strvec_pushf(&cmd.args, "--pack_header=%"PRIu32",%"PRIu32,
+				     opts->pack_header_version,
+				     opts->pack_header_entries);
+		repo_config_get_bool(source->odb->repo, "transfer.fsckobjects",
+				     &fsck_objects);
+		repo_config_get_bool(source->odb->repo, "receive.fsckobjects",
+				     &fsck_objects);
+		if (fsck_objects)
+			strvec_push(&cmd.args, "--strict");
+		if (opts && opts->max_input_size)
+			strvec_pushf(&cmd.args, "--max-input-size=%lu",
+				     opts->max_input_size);
+		ret = run_command(&cmd);
+		if (ret)
+			return error(_("unpack-objects failed"));
+		return 0;
+	}
+
+	strvec_push(&cmd.args, "index-pack");
+	strvec_push(&cmd.args, "--stdin");
+	strvec_push(&cmd.args, "--keep=write_packfile");
+
+	if (opts && opts->pack_header_version)
+		strvec_pushf(&cmd.args, "--pack_header=%"PRIu32",%"PRIu32,
+			     opts->pack_header_version,
+			     opts->pack_header_entries);
+
+	if (opts) {
+		if (opts->use_thin_pack)
+			strvec_push(&cmd.args, "--fix-thin");
+		if (opts->from_promisor)
+			strvec_push(&cmd.args, "--promisor");
+		if (opts->check_self_contained)
+			strvec_push(&cmd.args, "--check-self-contained-and-connected");
+		if (opts->max_input_size)
+			strvec_pushf(&cmd.args, "--max-input-size=%lu",
+				     opts->max_input_size);
+		if (opts->shallow_file)
+			strvec_pushf(&cmd.env, "GIT_SHALLOW_FILE=%s",
+				     opts->shallow_file);
+		if (opts->report_end_of_input)
+			strvec_push(&cmd.args, "--report-end-of-input");
+		if (opts->fsck_objects)
+			fsck_objects = 1;
+	}
+
+	if (!fsck_objects) {
+		repo_config_get_bool(source->odb->repo, "transfer.fsckobjects",
+				     &fsck_objects);
+		repo_config_get_bool(source->odb->repo, "fetch.fsckobjects",
+				     &fsck_objects);
+	}
+	if (fsck_objects)
+		strvec_push(&cmd.args, "--strict");
+
+	if (opts && opts->lockfile_out) {
+		cmd.out = -1;
+		ret = start_command(&cmd);
+		if (ret)
+			return error(_("index-pack failed to start"));
+		*opts->lockfile_out = index_pack_lockfile(source->odb->repo,
+							  cmd.out, NULL);
+		close(cmd.out);
+		ret = finish_command(&cmd);
+	} else {
+		ret = run_command(&cmd);
+	}
+
+	if (ret)
+		return error(_("index-pack failed"));
+
+	if (opts && opts->check_self_contained)
+		opts->self_contained_out = 1;
+
+	packfile_store_reprepare(files->packed);
+	return 0;
+}
+
+static int match_hash_prefix(unsigned len, const unsigned char *a,
+			     const unsigned char *b)
+{
+	while (len > 1) {
+		if (*a != *b)
+			return 0;
+		a++; b++; len -= 2;
+	}
+	if (len)
+		if ((*a ^ *b) & 0xf0)
+			return 0;
+	return 1;
+}
+
+struct abbrev_cb_data {
+	odb_for_each_object_cb cb;
+	void *cb_data;
+	int ret;
+};
+
+static enum cb_next abbrev_loose_cb(const struct object_id *oid, void *data)
+{
+	struct abbrev_cb_data *d = data;
+	d->ret = d->cb(oid, NULL, d->cb_data);
+	return d->ret ? CB_BREAK : CB_CONTINUE;
+}
+
+static int odb_source_files_for_each_unique_abbrev(struct odb_source *source,
+						   const struct object_id *oid_prefix,
+						   unsigned int prefix_len,
+						   odb_for_each_object_cb cb,
+						   void *cb_data)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	struct multi_pack_index *m;
+	struct packfile_list_entry *entry;
+	unsigned int hexsz = source->odb->repo->hash_algo->hexsz;
+	unsigned int len = prefix_len > hexsz ? hexsz : prefix_len;
+
+	/* Search loose objects */
+	{
+		struct oidtree *tree = odb_source_loose_cache(source, oid_prefix);
+		if (tree) {
+			struct abbrev_cb_data d = { cb, cb_data, 0 };
+			oidtree_each(tree, oid_prefix, prefix_len, abbrev_loose_cb, &d);
+			if (d.ret)
+				return d.ret;
+		}
+	}
+
+	/* Search multi-pack indices */
+	m = get_multi_pack_index(source);
+	for (; m; m = m->base_midx) {
+		uint32_t num, i, first = 0;
+
+		if (!m->num_objects)
+			continue;
+
+		num = m->num_objects + m->num_objects_in_base;
+		bsearch_one_midx(oid_prefix, m, &first);
+
+		for (i = first; i < num; i++) {
+			struct object_id oid;
+			const struct object_id *current;
+			int ret;
+
+			current = nth_midxed_object_oid(&oid, m, i);
+			if (!match_hash_prefix(len, oid_prefix->hash, current->hash))
+				break;
+			ret = cb(current, NULL, cb_data);
+			if (ret)
+				return ret;
+		}
+	}
+
+	/* Search packs not covered by MIDX */
+	for (entry = packfile_store_get_packs(files->packed); entry; entry = entry->next) {
+		struct packed_git *p = entry->pack;
+		uint32_t num, i, first = 0;
+
+		if (p->multi_pack_index)
+			continue;
+		if (open_pack_index(p) || !p->num_objects)
+			continue;
+
+		num = p->num_objects;
+		bsearch_pack(oid_prefix, p, &first);
+
+		for (i = first; i < num; i++) {
+			struct object_id oid;
+			int ret;
+
+			nth_packed_object_id(&oid, p, i);
+			if (!match_hash_prefix(len, oid_prefix->hash, oid.hash))
+				break;
+			ret = cb(&oid, NULL, cb_data);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int odb_source_files_convert_object_id(struct odb_source *source,
+					      const struct object_id *src,
+					      const struct git_hash_algo *to,
+					      struct object_id *dest)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	struct loose_object_map *map;
+	kh_oid_map_t *hash_map;
+	khiter_t pos;
+
+	if (!files->loose || !files->loose->map)
+		return -1;
+
+	map = files->loose->map;
+
+	if (to == source->odb->repo->compat_hash_algo)
+		hash_map = map->to_compat;
+	else if (to == source->odb->repo->hash_algo)
+		hash_map = map->to_storage;
+	else
+		return -1;
+
+	pos = kh_get_oid_map(hash_map, *src);
+	if (pos == kh_end(hash_map))
+		return -1;
+
+	oidcpy(dest, kh_value(hash_map, pos));
+	return 0;
+}
+
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
 					      const char *path,
 					      bool local)
@@ -256,6 +512,9 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.begin_transaction = odb_source_files_begin_transaction;
 	files->base.read_alternates = odb_source_files_read_alternates;
 	files->base.write_alternate = odb_source_files_write_alternate;
+	files->base.write_packfile = odb_source_files_write_packfile;
+	files->base.for_each_unique_abbrev = odb_source_files_for_each_unique_abbrev;
+	files->base.convert_object_id = odb_source_files_convert_object_id;
 
 	/*
 	 * Ideally, we would only ever store absolute paths in the source. This
diff --git a/odb/source.h b/odb/source.h
index 96c906e7a1..8b898f80ed 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -13,12 +13,42 @@ enum odb_source_type {
 
 	/* The "files" backend that uses loose objects and packfiles. */
 	ODB_SOURCE_FILES,
+
+	/* An external helper process (git-local-<name>). */
+	ODB_SOURCE_HELPER,
 };
 
 struct object_id;
 struct odb_read_stream;
 struct strvec;
 
+/*
+ * Options for write_packfile. When NULL is passed, the backend
+ * uses sensible defaults.
+ */
+struct odb_write_packfile_options {
+	unsigned int nr_objects;
+	uint32_t pack_header_version;
+	uint32_t pack_header_entries;
+	int use_thin_pack;
+	int from_promisor;
+	int fsck_objects;
+	int check_self_contained;
+	unsigned long max_input_size;
+	int quiet;
+	int show_progress;
+	int report_end_of_input;
+	const char *shallow_file;
+	char **lockfile_out;
+
+	/*
+	 * Output: set to 1 by the backend if the ingested pack was
+	 * verified as self-contained (all referenced objects present).
+	 * Used by the transport layer to skip connectivity checks.
+	 */
+	int self_contained_out;
+};
+
 /*
  * The source is the part of the object database that stores the actual
  * objects. It thus encapsulates the logic to read and write the specific
@@ -237,6 +267,45 @@ struct odb_source {
 	 */
 	int (*write_alternate)(struct odb_source *source,
 			       const char *alternate);
+
+	/*
+	 * Ingest a pack from a file descriptor. Each backend chooses
+	 * its own ingestion strategy:
+	 *
+	 *   - The files backend spawns index-pack (large packs) or
+	 *     unpack-objects (small packs), then registers the result.
+	 *
+	 *   - Non-files backends may parse the pack and write each
+	 *     object individually through write_object.
+	 *
+	 * Returns 0 on success, a negative error code otherwise.
+	 */
+	int (*write_packfile)(struct odb_source *source,
+			      int pack_fd,
+			      struct odb_write_packfile_options *opts);
+
+	/*
+	 * Iterate over all objects whose object ID starts with the
+	 * given prefix. Used for object name disambiguation.
+	 *
+	 * Returns 0 on success, a negative error code in case
+	 * iteration has failed, or a non-zero value from the callback.
+	 */
+	int (*for_each_unique_abbrev)(struct odb_source *source,
+				      const struct object_id *oid_prefix,
+				      unsigned int prefix_len,
+				      odb_for_each_object_cb cb,
+				      void *cb_data);
+
+	/*
+	 * Translate an object ID from one hash algorithm to another
+	 * using the source's internal mapping (for SHA-1/SHA-256
+	 * migration). Returns 0 on success, -1 if no mapping exists.
+	 */
+	int (*convert_object_id)(struct odb_source *source,
+				 const struct object_id *src,
+				 const struct git_hash_algo *to,
+				 struct object_id *dest);
 };
 
 /*
@@ -442,4 +511,43 @@ static inline int odb_source_begin_transaction(struct odb_source *source,
 	return source->begin_transaction(source, out);
 }
 
+/*
+ * Ingest a pack from a file descriptor into the given source. Returns 0 on
+ * success, a negative error code otherwise.
+ */
+static inline int odb_source_write_packfile(struct odb_source *source,
+					    int pack_fd,
+					    struct odb_write_packfile_options *opts)
+{
+	return source->write_packfile(source, pack_fd, opts);
+}
+
+/*
+ * Iterate over all objects in the source whose ID starts with the given
+ * prefix. Used for object name disambiguation.
+ */
+static inline int odb_source_for_each_unique_abbrev(struct odb_source *source,
+						    const struct object_id *oid_prefix,
+						    unsigned int prefix_len,
+						    odb_for_each_object_cb cb,
+						    void *cb_data)
+{
+	return source->for_each_unique_abbrev(source, oid_prefix, prefix_len,
+					      cb, cb_data);
+}
+
+/*
+ * Translate an object ID between hash algorithms using the source's mapping.
+ * Returns 0 on success, -1 if no mapping exists.
+ */
+static inline int odb_source_convert_object_id(struct odb_source *source,
+					       const struct object_id *src,
+					       const struct git_hash_algo *to,
+					       struct object_id *dest)
+{
+	if (!source->convert_object_id)
+		return -1;
+	return source->convert_object_id(source, src, to, dest);
+}
+
 #endif

base-commit: 41688c1a2312f62f44435e1a6d03b4b904b5b0ec
-- 
gitgitgadget
