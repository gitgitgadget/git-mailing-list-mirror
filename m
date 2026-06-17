Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399153B71DE
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 06:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678440; cv=none; b=u0oFNv9kTlwVoWwtwZkjfNHV+xXmTaDGkp3t9djN04qH2PxvzgvfyjfYR+ZG38qATdE0SSMawmOzrSf9H2t0nbFF3C62IftcdB4o7qim3TTHtxFJ3IFcELcrX/TXxwvkY34Ci93Amifw0NP7UUMpC8Yma4fXgCdMgdJzJvJmX58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678440; c=relaxed/simple;
	bh=AnXrp1RyEKj710nxT+g8hnLLhbfO5hRqdqLPgtDmN1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GFRrK6g6i4hw16+97mOL/5P4fzwvCKwk9o5TGHGAAJs2E6Pno3VWeTQhyLi+CTapHA40Qo144bejiUIUXcWJrpAyCLk0DwRAQ4lroGYf02FtJ/V+JpFYL/rI2teNqLxCEv0odJMQR06awIMZ9qxawmsj7YxM5+LGXaxsD3/IjXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I/sBmKvE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OHyb0pJ2; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I/sBmKvE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OHyb0pJ2"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8DB9A7A00D0;
	Wed, 17 Jun 2026 02:40:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 17 Jun 2026 02:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781678437;
	 x=1781764837; bh=2JeS88AabDe1ZZtE59PoAzwPJVBhftZPEeEu+R5VDe4=; b=
	I/sBmKvEmgNX31Rs6NXr4VPYf8O6m/bqhyT6d54IJ0nokWJz9tpFoPauAon/KaA4
	6uLcC/F8vWvN3lQG/a3tl3Jjw+doS/9XhPPRZh7EQNOX6hKRuKqArGANRaIdMe0C
	87Cj1Aa4kpaokzOHCr+e3MFqExQUvx4o5wk8LmE0UPWbr42ggjsTIDq1IpQv8A2N
	oMyr6b3oJbFK2rQZSJq7ilDWG25DOhNeCULEYJOGyeKFgcmDFehKOHGLszjdFIoP
	6dBE5e9WcgGWQM1NsjiStxJSUTkSvLxhXgsB7sb+GywKIV2Wiqti1Uqg0kDhMSL9
	SVY9VrXJW3RYquQTA9tTKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781678437; x=
	1781764837; bh=2JeS88AabDe1ZZtE59PoAzwPJVBhftZPEeEu+R5VDe4=; b=O
	Hyb0pJ2m9Qsi5Oso+xZm8sq9NZ+jIcYeHSpNS8/dr6NABqWns+hp8RiW2unzDQlL
	2K3OmgXtBNvowPuv1WrJJBBjjpn3ohbfTXATKih86qLyuQDFMaHYWbgm+G7Xcc7j
	fEIw+a6/pzx77Xg+IUzaa2rxUl3lRSiS+vnMbFFay6Qi9Iw4B7MwVbBz0eWZ+LTZ
	kL4Y31E91zx7PoaOycSyESYSS1lqItAuWDsnr0EBGYvgrnIItWh+yu10fGYvQL0a
	YYgMjoMwYdaog9uyPdaDfrOwhft9CLnlUbqceVc1Evl1ZcRR0BonFz/EVrrGMk/w
	izdh79oupxtLVl91+vivw==
X-ME-Sender: <xms:ZUEyasuxHEQGiP_sjkgDSCXtsVTb6cFnUfZ2mVKeqxUSUq49X3SPBA>
    <xme:ZUEyag4N6mq6ZwXfhgSWT_PyprAp9oOQTzS7CDFQsPgONRVxsZ2HvKDL5WPIDHwev
    NzavWa_z_mhRpimNkmHiQ1WnI5b_0n1zOiCI_iDig2rDDhb0tiw>
X-ME-Received: <xmr:ZUEyalIryC6ElFv6JrtsHhFSN9LpsBSgEWFLfA97Gu_7lZ6JPzQemDVvfZh8Q_BG4odbOebWaKwqHEFoYKyg73ihiauj3EV6iDc1dYE>
X-ME-Proxy-Cause: dmFkZTGO0C78ZwW/frQbOi0yCZr+3GuzTeYQYFlkQNPcjd5Ibxn88F8mcCuwiw5R0LaC49
    KJhHoT6pt2ouQ0TmaZBZoQ9x2gUJJMC5mgMVUTSZTuscfNdkDIdfcUFMHqPDDQBiSMwl3m
    SMGQxVBuHTRS6Hbv2nQ3ME3ZxXdCTBTMth8OKmyedtasQzciKMeXHwxr5RW1FUkUbI8hyQ
    GzyRa8IG+8urqY6o+u+qtni9Xi2SATUTXBXbFWF9zWnEZyUNdPww5/ZB+rK41HoG9mJKAJ
    QmZjJFQ1sfIWQY7Q3Go3Tc+nVcDPT7mlhtlA8E5SqwHw+ZmexVHwsBWw88RiR25rM/gUNh
    lw5Yn/WghwRpB+/UTZydPRhdGrH4ft1UWZoEpui6v572AP9xlQ1IKyPdMJ8wUc+HkjxTku
    3rx0b2xx/y8To6RnFG9gJG+2NV+z4daIfNjtesmRInOG5ps6ISFDiGuGdMeDNInoq5hdjv
    wiIb/VsKlSpTF6m8dbhg9fS7RR7nfUGX08smnmUJV70M1wRFyjra5qblieVaJVn3IQlCDW
    aW67iuC846CazDrkziPSMIhoqTZsT1VVsvXBbuOhFFOBaO0jEKrW0wZLJMBYcnTbCFIvX0
    ojtDkxTacjxQaE9fAIJZK0xVNsXn5LBsPVj1PmcliSe70PqSiIPU1J84asBA
X-ME-Proxy: <xmx:ZUEyao6hiLYGUd5txBPy4hiwTSGSS1QmSL81geU3Ejyga2xkUE6hWA>
    <xmx:ZUEyagzZm_YMoCq7T1Sj-ByGhUiyG9WnVDZNKINawIRnaMmI2PLCNw>
    <xmx:ZUEyakaz_Y7ECurw91KL5YEwdmu2oKFl8e39YOJ_uiobVbUANQsZlg>
    <xmx:ZUEyaqRCcTd6oRKfO6VyirPavE6-2rlqMH6_4Ofh-8LeuhoytFsbMw>
    <xmx:ZUEyajWGh2RIvgvVMrgz2bh5YjptHlUGFOUYwRHnlyBZu2TztLhXrk0t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 02:40:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 78e0e40f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 06:40:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 17 Jun 2026 08:39:59 +0200
Subject: [PATCH v3 16/17] midx: refactor interfaces to work on "packed"
 source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-pks-odb-source-packed-v3-16-b5c7583cd795@pks.im>
References: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
In-Reply-To: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Our interfaces used to interact with MIDXs all work on top of the
generic `struct odb_source`. This doesn't make much sense though: a MIDX
is strictly tied to the "packed" source, so passing in a generic source
gives the false sense that it may also work with a different type of
source.

Fix this conceptual weirdness and instead require the caller to pass in
a "packed" source explicitly. This also makes the next commit easier to
implement, where we drop the pointer to the "files" source in the
"packed" source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/multi-pack-index.c |  29 +++++------
 builtin/pack-objects.c     |   3 +-
 builtin/repack.c           |   8 ++-
 midx-write.c               |  34 ++++++-------
 midx.c                     | 118 ++++++++++++++++++++++-----------------------
 midx.h                     |  30 ++++++------
 odb/source-packed.c        |  12 ++---
 pack-bitmap.c              |   8 +--
 pack-revindex.c            |   6 +--
 repack-geometry.c          |   3 +-
 repack-midx.c              |   9 ++--
 repack.c                   |   6 +--
 t/helper/test-read-midx.c  |   7 ++-
 13 files changed, 144 insertions(+), 129 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 00ffb36394..6e73c85cde 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -10,6 +10,7 @@
 #include "trace2.h"
 #include "odb.h"
 #include "odb/source.h"
+#include "odb/source-files.h"
 #include "replace-object.h"
 #include "repository.h"
 
@@ -85,12 +86,12 @@ static int parse_object_dir(const struct option *opt, const char *arg,
 	return 0;
 }
 
-static struct odb_source *handle_object_dir_option(struct repository *repo)
+static struct odb_source_files *handle_object_dir_option(struct repository *repo)
 {
 	struct odb_source *source = odb_find_source(repo->objects, opts.object_dir);
 	if (!source)
 		source = odb_add_to_alternates_memory(repo->objects, opts.object_dir);
-	return source;
+	return odb_source_files_downcast(source);
 }
 
 static struct option common_opts[] = {
@@ -167,7 +168,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 			     N_("refs snapshot for selecting bitmap commits")),
 		OPT_END(),
 	};
-	struct odb_source *source;
+	struct odb_source_files *source;
 	int ret;
 
 	opts.flags |= MIDX_WRITE_BITMAP_HASH_CACHE;
@@ -211,7 +212,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 
 		read_packs_from_stdin(&packs);
 
-		ret = write_midx_file_only(source, &packs,
+		ret = write_midx_file_only(source->packed, &packs,
 					   opts.preferred_pack,
 					   opts.refs_snapshot,
 					   opts.incremental_base, opts.flags);
@@ -223,7 +224,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 
 	}
 
-	ret = write_midx_file(source, opts.preferred_pack,
+	ret = write_midx_file(source->packed, opts.preferred_pack,
 			      opts.refs_snapshot, opts.flags);
 
 	free(opts.refs_snapshot);
@@ -237,7 +238,7 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
 	struct multi_pack_index *m, *cur;
 	struct multi_pack_index *from_midx = NULL;
 	struct multi_pack_index *to_midx = NULL;
-	struct odb_source *source;
+	struct odb_source_files *source;
 	int ret;
 
 	struct option *options;
@@ -282,7 +283,7 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
 
 	FREE_AND_NULL(options);
 
-	m = get_multi_pack_index(source);
+	m = get_multi_pack_index(source->packed);
 
 	for (cur = m; cur && !(from_midx && to_midx); cur = cur->base_midx) {
 		const char *midx_csum = midx_get_checksum_hex(cur);
@@ -305,7 +306,7 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
 			die(_("MIDX %s must be an ancestor of %s"), argv[0], argv[1]);
 	}
 
-	ret = write_midx_file_compact(source, from_midx, to_midx,
+	ret = write_midx_file_compact(source->packed, from_midx, to_midx,
 				      opts.incremental_base, opts.flags);
 
 	return ret;
@@ -319,7 +320,7 @@ static int cmd_multi_pack_index_verify(int argc, const char **argv,
 	static struct option builtin_multi_pack_index_verify_options[] = {
 		OPT_END(),
 	};
-	struct odb_source *source;
+	struct odb_source_files *source;
 
 	options = add_common_options(builtin_multi_pack_index_verify_options);
 
@@ -337,7 +338,7 @@ static int cmd_multi_pack_index_verify(int argc, const char **argv,
 
 	FREE_AND_NULL(options);
 
-	return verify_midx_file(source, opts.flags);
+	return verify_midx_file(source->packed, opts.flags);
 }
 
 static int cmd_multi_pack_index_expire(int argc, const char **argv,
@@ -348,7 +349,7 @@ static int cmd_multi_pack_index_expire(int argc, const char **argv,
 	static struct option builtin_multi_pack_index_expire_options[] = {
 		OPT_END(),
 	};
-	struct odb_source *source;
+	struct odb_source_files *source;
 
 	options = add_common_options(builtin_multi_pack_index_expire_options);
 
@@ -366,7 +367,7 @@ static int cmd_multi_pack_index_expire(int argc, const char **argv,
 
 	FREE_AND_NULL(options);
 
-	return expire_midx_packs(source, opts.flags);
+	return expire_midx_packs(source->packed, opts.flags);
 }
 
 static int cmd_multi_pack_index_repack(int argc, const char **argv,
@@ -379,7 +380,7 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv,
 		  N_("during repack, collect pack-files of smaller size into a batch that is larger than this size")),
 		OPT_END(),
 	};
-	struct odb_source *source;
+	struct odb_source_files *source;
 
 	options = add_common_options(builtin_multi_pack_index_repack_options);
 
@@ -398,7 +399,7 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv,
 
 	FREE_AND_NULL(options);
 
-	return midx_repack(source, (size_t)opts.batch_size, opts.flags);
+	return midx_repack(source->packed, (size_t)opts.batch_size, opts.flags);
 }
 
 int cmd_multi_pack_index(int argc,
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5e94805478..424c92cc29 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1775,7 +1775,8 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 	odb_prepare_alternates(the_repository->objects);
 
 	for (source = the_repository->objects->sources; source; source = source->next) {
-		struct multi_pack_index *m = get_multi_pack_index(source);
+		struct odb_source_files *files = odb_source_files_downcast(source);
+		struct multi_pack_index *m = get_multi_pack_index(files->packed);
 		struct pack_entry e;
 
 		if (m && fill_midx_entry(m, oid, &e)) {
diff --git a/builtin/repack.c b/builtin/repack.c
index 1524a9c13a..47966a686b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -458,6 +458,8 @@ int cmd_repack(int argc,
 	}
 
 	if (!names.nr) {
+		struct odb_source_files *files = odb_source_files_downcast(existing.source);
+
 		if (!po_args.quiet)
 			printf_ln(_("Nothing new to pack."));
 		/*
@@ -473,7 +475,7 @@ int cmd_repack(int argc,
 		 * midx_has_unknown_packs() will make the decision for
 		 * us.
 		 */
-		if (!get_multi_pack_index(existing.source))
+		if (!get_multi_pack_index(files->packed))
 			midx_must_contain_cruft = 1;
 	}
 
@@ -626,10 +628,12 @@ int cmd_repack(int argc,
 		update_server_info(repo, 0);
 
 	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0)) {
+		struct odb_source_files *files = odb_source_files_downcast(existing.source);
 		unsigned flags = 0;
+
 		if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL, 0))
 			flags |= MIDX_WRITE_INCREMENTAL;
-		write_midx_file(existing.source, NULL, NULL, flags);
+		write_midx_file(files->packed, NULL, NULL, flags);
 	}
 
 cleanup:
diff --git a/midx-write.c b/midx-write.c
index 561e9eedc0..7cafc49fb8 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -25,9 +25,9 @@
 #define NO_PREFERRED_PACK (~((uint32_t)0))
 
 extern int midx_checksum_valid(struct multi_pack_index *m);
-extern void clear_midx_files_ext(struct odb_source *source, const char *ext,
+extern void clear_midx_files_ext(struct odb_source_packed *source, const char *ext,
 				 const char *keep_hash);
-extern void clear_incremental_midx_files_ext(struct odb_source *source,
+extern void clear_incremental_midx_files_ext(struct odb_source_packed *source,
 					     const char *ext,
 					     const struct strvec *keep_hashes);
 extern int cmp_idx_or_pack_name(const char *idx_or_pack_name,
@@ -119,7 +119,7 @@ struct write_midx_context {
 	struct string_list *to_include;
 
 	struct repository *repo;
-	struct odb_source *source;
+	struct odb_source_packed *source;
 };
 
 static uint32_t midx_pack_perm(struct write_midx_context *ctx,
@@ -1107,7 +1107,7 @@ static int link_midx_to_chain(struct multi_pack_index *m)
 	return ret;
 }
 
-static void clear_midx_files(struct odb_source *source,
+static void clear_midx_files(struct odb_source_packed *source,
 			     const struct strvec *hashes, unsigned incremental)
 {
 	/*
@@ -1237,7 +1237,7 @@ static int midx_hashcmp(const struct multi_pack_index *a,
 }
 
 struct write_midx_opts {
-	struct odb_source *source; /* non-optional */
+	struct odb_source_packed *source; /* non-optional */
 
 	struct string_list *packs_to_include;
 	struct string_list *packs_to_drop;
@@ -1253,7 +1253,7 @@ struct write_midx_opts {
 
 static int write_midx_internal(struct write_midx_opts *opts)
 {
-	struct repository *r = opts->source->odb->repo;
+	struct repository *r = opts->source->base.odb->repo;
 	struct strbuf midx_name = STRBUF_INIT;
 	unsigned char midx_hash[GIT_MAX_RAWSZ];
 	uint32_t start_pack;
@@ -1301,7 +1301,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	if (ctx.incremental)
 		strbuf_addf(&midx_name,
 			    "%s/pack/multi-pack-index.d/tmp_midx_XXXXXX",
-			    opts->source->path);
+			    opts->source->base.path);
 	else
 		get_midx_filename(opts->source, &midx_name);
 	if (safe_create_leading_directories(r, midx_name.buf))
@@ -1396,7 +1396,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 		fill_packs_from_midx_range(&ctx, bitmap_order);
 	} else {
 		ctx.to_include = opts->packs_to_include;
-		for_each_file_in_pack_dir(opts->source->path, add_pack_to_midx, &ctx);
+		for_each_file_in_pack_dir(opts->source->base.path, add_pack_to_midx, &ctx);
 	}
 	stop_progress(&ctx.progress);
 
@@ -1847,7 +1847,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	return result;
 }
 
-int write_midx_file(struct odb_source *source,
+int write_midx_file(struct odb_source_packed *source,
 		    const char *preferred_pack_name,
 		    const char *refs_snapshot,
 		    unsigned flags)
@@ -1862,7 +1862,7 @@ int write_midx_file(struct odb_source *source,
 	return write_midx_internal(&opts);
 }
 
-int write_midx_file_only(struct odb_source *source,
+int write_midx_file_only(struct odb_source_packed *source,
 			 struct string_list *packs_to_include,
 			 const char *preferred_pack_name,
 			 const char *refs_snapshot,
@@ -1881,7 +1881,7 @@ int write_midx_file_only(struct odb_source *source,
 	return write_midx_internal(&opts);
 }
 
-int write_midx_file_compact(struct odb_source *source,
+int write_midx_file_compact(struct odb_source_packed *source,
 			    struct multi_pack_index *from,
 			    struct multi_pack_index *to,
 			    const char *incremental_base,
@@ -1898,7 +1898,7 @@ int write_midx_file_compact(struct odb_source *source,
 	return write_midx_internal(&opts);
 }
 
-int expire_midx_packs(struct odb_source *source, unsigned flags)
+int expire_midx_packs(struct odb_source_packed *source, unsigned flags)
 {
 	uint32_t i, *count, result = 0;
 	struct string_list packs_to_drop = STRING_LIST_INIT_DUP;
@@ -1915,7 +1915,7 @@ int expire_midx_packs(struct odb_source *source, unsigned flags)
 
 	if (flags & MIDX_PROGRESS)
 		progress = start_delayed_progress(
-					  source->odb->repo,
+					  source->base.odb->repo,
 					  _("Counting referenced objects"),
 					  m->num_objects);
 	for (i = 0; i < m->num_objects; i++) {
@@ -1927,7 +1927,7 @@ int expire_midx_packs(struct odb_source *source, unsigned flags)
 
 	if (flags & MIDX_PROGRESS)
 		progress = start_delayed_progress(
-					  source->odb->repo,
+					  source->base.odb->repo,
 					  _("Finding and deleting unreferenced packfiles"),
 					  m->num_packs);
 	for (i = 0; i < m->num_packs; i++) {
@@ -2085,9 +2085,9 @@ static void fill_included_packs_batch(struct repository *r,
 	free(pack_info);
 }
 
-int midx_repack(struct odb_source *source, size_t batch_size, unsigned flags)
+int midx_repack(struct odb_source_packed *source, size_t batch_size, unsigned flags)
 {
-	struct repository *r = source->odb->repo;
+	struct repository *r = source->base.odb->repo;
 	int result = 0;
 	uint32_t i, packs_to_repack = 0;
 	unsigned char *include_pack;
@@ -2131,7 +2131,7 @@ int midx_repack(struct odb_source *source, size_t batch_size, unsigned flags)
 
 	strvec_push(&cmd.args, "pack-objects");
 
-	strvec_pushf(&cmd.args, "%s/pack/pack", source->path);
+	strvec_pushf(&cmd.args, "%s/pack/pack", source->base.path);
 
 	if (delta_base_offset)
 		strvec_push(&cmd.args, "--delta-base-offset");
diff --git a/midx.c b/midx.c
index 00bbd137b2..cc6b94f9dd 100644
--- a/midx.c
+++ b/midx.c
@@ -17,9 +17,9 @@
 #define MIDX_PACK_ERROR ((void *)(intptr_t)-1)
 
 int midx_checksum_valid(struct multi_pack_index *m);
-void clear_midx_files_ext(struct odb_source *source, const char *ext,
+void clear_midx_files_ext(struct odb_source_packed *source, const char *ext,
 			  const char *keep_hash);
-void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext,
+void clear_incremental_midx_files_ext(struct odb_source_packed *source, const char *ext,
 				      const struct strvec *keep_hashes);
 int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 			 const char *idx_name);
@@ -27,25 +27,25 @@ int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 const char *midx_get_checksum_hex(const struct multi_pack_index *m)
 {
 	return hash_to_hex_algop(midx_get_checksum_hash(m),
-				 m->source->odb->repo->hash_algo);
+				 m->source->base.odb->repo->hash_algo);
 }
 
 const unsigned char *midx_get_checksum_hash(const struct multi_pack_index *m)
 {
-	return m->data + m->data_len - m->source->odb->repo->hash_algo->rawsz;
+	return m->data + m->data_len - m->source->base.odb->repo->hash_algo->rawsz;
 }
 
-void get_midx_filename(struct odb_source *source, struct strbuf *out)
+void get_midx_filename(struct odb_source_packed *source, struct strbuf *out)
 {
 	get_midx_filename_ext(source, out, NULL, NULL);
 }
 
-void get_midx_filename_ext(struct odb_source *source, struct strbuf *out,
+void get_midx_filename_ext(struct odb_source_packed *source, struct strbuf *out,
 			   const unsigned char *hash, const char *ext)
 {
-	strbuf_addf(out, "%s/pack/multi-pack-index", source->path);
+	strbuf_addf(out, "%s/pack/multi-pack-index", source->base.path);
 	if (ext)
-		strbuf_addf(out, "-%s.%s", hash_to_hex_algop(hash, source->odb->repo->hash_algo), ext);
+		strbuf_addf(out, "-%s.%s", hash_to_hex_algop(hash, source->base.odb->repo->hash_algo), ext);
 }
 
 static int midx_read_oid_fanout(const unsigned char *chunk_start,
@@ -99,17 +99,16 @@ static int midx_read_object_offsets(const unsigned char *chunk_start,
 	return 0;
 }
 
-struct multi_pack_index *get_multi_pack_index(struct odb_source *source)
+struct multi_pack_index *get_multi_pack_index(struct odb_source_packed *source)
 {
-	struct odb_source_files *files = odb_source_files_downcast(source);
-	odb_source_packed_prepare(files->packed);
-	return files->packed->midx;
+	odb_source_packed_prepare(source);
+	return source->midx;
 }
 
-static struct multi_pack_index *load_multi_pack_index_one(struct odb_source *source,
+static struct multi_pack_index *load_multi_pack_index_one(struct odb_source_packed *source,
 							  const char *midx_name)
 {
-	struct repository *r = source->odb->repo;
+	struct repository *r = source->base.odb->repo;
 	struct multi_pack_index *m = NULL;
 	int fd;
 	struct stat st;
@@ -234,23 +233,23 @@ static struct multi_pack_index *load_multi_pack_index_one(struct odb_source *sou
 	return NULL;
 }
 
-void get_midx_chain_dirname(struct odb_source *source, struct strbuf *buf)
+void get_midx_chain_dirname(struct odb_source_packed *source, struct strbuf *buf)
 {
-	strbuf_addf(buf, "%s/pack/multi-pack-index.d", source->path);
+	strbuf_addf(buf, "%s/pack/multi-pack-index.d", source->base.path);
 }
 
-void get_midx_chain_filename(struct odb_source *source, struct strbuf *buf)
+void get_midx_chain_filename(struct odb_source_packed *source, struct strbuf *buf)
 {
 	get_midx_chain_dirname(source, buf);
 	strbuf_addstr(buf, "/multi-pack-index-chain");
 }
 
-void get_split_midx_filename_ext(struct odb_source *source, struct strbuf *buf,
+void get_split_midx_filename_ext(struct odb_source_packed *source, struct strbuf *buf,
 				 const unsigned char *hash, const char *ext)
 {
 	get_midx_chain_dirname(source, buf);
 	strbuf_addf(buf, "/multi-pack-index-%s.%s",
-		    hash_to_hex_algop(hash, source->odb->repo->hash_algo), ext);
+		    hash_to_hex_algop(hash, source->base.odb->repo->hash_algo), ext);
 }
 
 static int open_multi_pack_index_chain(const struct git_hash_algo *hash_algo,
@@ -306,11 +305,11 @@ static int add_midx_to_chain(struct multi_pack_index *midx,
 	return 1;
 }
 
-static struct multi_pack_index *load_midx_chain_fd_st(struct odb_source *source,
+static struct multi_pack_index *load_midx_chain_fd_st(struct odb_source_packed *source,
 						      int fd, struct stat *st,
 						      int *incomplete_chain)
 {
-	const struct git_hash_algo *hash_algo = source->odb->repo->hash_algo;
+	const struct git_hash_algo *hash_algo = source->base.odb->repo->hash_algo;
 	struct multi_pack_index *midx_chain = NULL;
 	struct strbuf buf = STRBUF_INIT;
 	int valid = 1;
@@ -362,7 +361,7 @@ static struct multi_pack_index *load_midx_chain_fd_st(struct odb_source *source,
 	return midx_chain;
 }
 
-static struct multi_pack_index *load_multi_pack_index_chain(struct odb_source *source)
+static struct multi_pack_index *load_multi_pack_index_chain(struct odb_source_packed *source)
 {
 	struct strbuf chain_file = STRBUF_INIT;
 	struct stat st;
@@ -370,7 +369,8 @@ static struct multi_pack_index *load_multi_pack_index_chain(struct odb_source *s
 	struct multi_pack_index *m = NULL;
 
 	get_midx_chain_filename(source, &chain_file);
-	if (open_multi_pack_index_chain(source->odb->repo->hash_algo, chain_file.buf, &fd, &st)) {
+	if (open_multi_pack_index_chain(source->base.odb->repo->hash_algo,
+					chain_file.buf, &fd, &st)) {
 		int incomplete;
 		/* ownership of fd is taken over by load function */
 		m = load_midx_chain_fd_st(source, fd, &st, &incomplete);
@@ -380,7 +380,7 @@ static struct multi_pack_index *load_multi_pack_index_chain(struct odb_source *s
 	return m;
 }
 
-struct multi_pack_index *load_multi_pack_index(struct odb_source *source)
+struct multi_pack_index *load_multi_pack_index(struct odb_source_packed *source)
 {
 	struct strbuf midx_name = STRBUF_INIT;
 	struct multi_pack_index *m;
@@ -456,7 +456,7 @@ static uint32_t midx_for_pack(struct multi_pack_index **_m,
 int prepare_midx_pack(struct multi_pack_index *m,
 		      uint32_t pack_int_id)
 {
-	struct odb_source_files *files = odb_source_files_downcast(m->source);
+	struct odb_source_packed *packed = m->source;
 	struct strbuf pack_name = STRBUF_INIT;
 	struct packed_git *p;
 
@@ -467,10 +467,10 @@ int prepare_midx_pack(struct multi_pack_index *m,
 	if (m->packs[pack_int_id])
 		return 0;
 
-	strbuf_addf(&pack_name, "%s/pack/%s", files->base.path,
+	strbuf_addf(&pack_name, "%s/pack/%s", packed->base.path,
 		    m->pack_names[pack_int_id]);
-	p = packfile_store_load_pack(files->packed,
-				     pack_name.buf, files->base.local);
+	p = packfile_store_load_pack(packed,
+				     pack_name.buf, packed->base.local);
 	strbuf_release(&pack_name);
 
 	if (!p) {
@@ -523,7 +523,7 @@ int bsearch_one_midx(const struct object_id *oid, struct multi_pack_index *m,
 {
 	int ret = bsearch_hash(oid->hash, m->chunk_oid_fanout,
 			       m->chunk_oid_lookup,
-			       m->source->odb->repo->hash_algo->rawsz,
+			       m->source->base.odb->repo->hash_algo->rawsz,
 			       result);
 	if (result)
 		*result += m->num_objects_in_base;
@@ -554,7 +554,7 @@ struct object_id *nth_midxed_object_oid(struct object_id *oid,
 	n = midx_for_object(&m, n);
 
 	oidread(oid, m->chunk_oid_lookup + st_mult(m->hash_len, n),
-		m->source->odb->repo->hash_algo);
+		m->source->base.odb->repo->hash_algo);
 	return oid;
 }
 
@@ -734,26 +734,25 @@ int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
 	return 0;
 }
 
-int prepare_multi_pack_index_one(struct odb_source *source)
+int prepare_multi_pack_index_one(struct odb_source_packed *source)
 {
-	struct odb_source_files *files = odb_source_files_downcast(source);
-	struct repository *r = source->odb->repo;
+	struct repository *r = source->base.odb->repo;
 
 	prepare_repo_settings(r);
 	if (!r->settings.core_multi_pack_index)
 		return 0;
 
-	if (files->packed->midx)
+	if (source->midx)
 		return 1;
 
-	files->packed->midx = load_multi_pack_index(source);
+	source->midx = load_multi_pack_index(source);
 
-	return !!files->packed->midx;
+	return !!source->midx;
 }
 
 int midx_checksum_valid(struct multi_pack_index *m)
 {
-	return hashfile_checksum_valid(m->source->odb->repo->hash_algo,
+	return hashfile_checksum_valid(m->source->base.odb->repo->hash_algo,
 				       m->data, m->data_len);
 }
 
@@ -776,7 +775,7 @@ static void clear_midx_file_ext(const char *full_path, size_t full_path_len UNUS
 		die_errno(_("failed to remove %s"), full_path);
 }
 
-void clear_midx_files_ext(struct odb_source *source, const char *ext,
+void clear_midx_files_ext(struct odb_source_packed *source, const char *ext,
 			  const char *keep_hash)
 {
 	struct clear_midx_data data = {
@@ -793,12 +792,12 @@ void clear_midx_files_ext(struct odb_source *source, const char *ext,
 		strbuf_release(&buf);
 	}
 
-	for_each_file_in_pack_dir(source->path, clear_midx_file_ext, &data);
+	for_each_file_in_pack_dir(source->base.path, clear_midx_file_ext, &data);
 
 	strset_clear(&data.keep);
 }
 
-void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext,
+void clear_incremental_midx_files_ext(struct odb_source_packed *source, const char *ext,
 				      const struct strvec *keep_hashes)
 {
 	struct clear_midx_data data = {
@@ -817,7 +816,7 @@ void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext
 		}
 	}
 
-	for_each_file_in_pack_subdir(source->path, "multi-pack-index.d",
+	for_each_file_in_pack_subdir(source->base.path, "multi-pack-index.d",
 				     clear_midx_file_ext, &data);
 
 	strbuf_release(&buf);
@@ -826,26 +825,28 @@ void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext
 
 void clear_midx_file(struct repository *r)
 {
+	struct odb_source_files *files;
 	struct strbuf midx = STRBUF_INIT;
 
-	get_midx_filename(r->objects->sources, &midx);
-
 	if (r->objects) {
 		struct odb_source *source;
 
 		for (source = r->objects->sources; source; source = source->next) {
-			struct odb_source_files *files = odb_source_files_downcast(source);
+			files = odb_source_files_downcast(source);
 			if (files->packed->midx)
 				close_midx(files->packed->midx);
 			files->packed->midx = NULL;
 		}
 	}
 
+	files = odb_source_files_downcast(r->objects->sources);
+	get_midx_filename(files->packed, &midx);
+
 	if (remove_path(midx.buf))
 		die(_("failed to clear multi-pack-index at %s"), midx.buf);
 
-	clear_midx_files_ext(r->objects->sources, MIDX_EXT_BITMAP, NULL);
-	clear_midx_files_ext(r->objects->sources, MIDX_EXT_REV, NULL);
+	clear_midx_files_ext(files->packed, MIDX_EXT_BITMAP, NULL);
+	clear_midx_files_ext(files->packed, MIDX_EXT_REV, NULL);
 
 	strbuf_release(&midx);
 }
@@ -853,28 +854,27 @@ void clear_midx_file(struct repository *r)
 void clear_incremental_midx_files(struct repository *r,
 				  const struct strvec *keep_hashes)
 {
-	struct odb_source *source = r->objects->sources;
+	struct odb_source_files *files;
+	struct odb_source *source;
 	struct strbuf chain = STRBUF_INIT;
 
-	get_midx_chain_filename(source, &chain);
-
-	for (; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
+	for (source = r->objects->sources; source; source = source->next) {
+		files = odb_source_files_downcast(source);
 		if (files->packed->midx)
 			close_midx(files->packed->midx);
 		files->packed->midx = NULL;
 	}
 
+	files = odb_source_files_downcast(r->objects->sources);
+	get_midx_chain_filename(files->packed, &chain);
+
 	if (!keep_hashes && remove_path(chain.buf))
 		die(_("failed to clear multi-pack-index chain at %s"),
 		    chain.buf);
 
-	clear_incremental_midx_files_ext(r->objects->sources, MIDX_EXT_BITMAP,
-					 keep_hashes);
-	clear_incremental_midx_files_ext(r->objects->sources, MIDX_EXT_REV,
-					 keep_hashes);
-	clear_incremental_midx_files_ext(r->objects->sources, MIDX_EXT_MIDX,
-					 keep_hashes);
+	clear_incremental_midx_files_ext(files->packed, MIDX_EXT_BITMAP, keep_hashes);
+	clear_incremental_midx_files_ext(files->packed, MIDX_EXT_REV, keep_hashes);
+	clear_incremental_midx_files_ext(files->packed, MIDX_EXT_MIDX, keep_hashes);
 
 	strbuf_release(&chain);
 }
@@ -918,9 +918,9 @@ static int compare_pair_pos_vs_id(const void *_a, const void *_b)
 			display_progress(progress, _n); \
 	} while (0)
 
-int verify_midx_file(struct odb_source *source, unsigned flags)
+int verify_midx_file(struct odb_source_packed *source, unsigned flags)
 {
-	struct repository *r = source->odb->repo;
+	struct repository *r = source->base.odb->repo;
 	struct pair_pos_vs_id *pairs = NULL;
 	uint32_t i;
 	struct progress *progress = NULL;
diff --git a/midx.h b/midx.h
index 63853a03a4..939c18e588 100644
--- a/midx.h
+++ b/midx.h
@@ -37,7 +37,7 @@ struct strvec;
 	"GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL"
 
 struct multi_pack_index {
-	struct odb_source *source;
+	struct odb_source_packed *source;
 
 	const unsigned char *data;
 	size_t data_len;
@@ -92,16 +92,16 @@ struct multi_pack_index {
 
 const char *midx_get_checksum_hex(const struct multi_pack_index *m) /* static buffer */;
 const unsigned char *midx_get_checksum_hash(const struct multi_pack_index *m);
-void get_midx_filename(struct odb_source *source, struct strbuf *out);
-void get_midx_filename_ext(struct odb_source *source, struct strbuf *out,
+void get_midx_filename(struct odb_source_packed *source, struct strbuf *out);
+void get_midx_filename_ext(struct odb_source_packed *source, struct strbuf *out,
 			   const unsigned char *hash, const char *ext);
-void get_midx_chain_dirname(struct odb_source *source, struct strbuf *out);
-void get_midx_chain_filename(struct odb_source *source, struct strbuf *out);
-void get_split_midx_filename_ext(struct odb_source *source, struct strbuf *buf,
+void get_midx_chain_dirname(struct odb_source_packed *source, struct strbuf *out);
+void get_midx_chain_filename(struct odb_source_packed *source, struct strbuf *out);
+void get_split_midx_filename_ext(struct odb_source_packed *source, struct strbuf *buf,
 				 const unsigned char *hash, const char *ext);
 
-struct multi_pack_index *get_multi_pack_index(struct odb_source *source);
-struct multi_pack_index *load_multi_pack_index(struct odb_source *source);
+struct multi_pack_index *get_multi_pack_index(struct odb_source_packed *source);
+struct multi_pack_index *load_multi_pack_index(struct odb_source_packed *source);
 int prepare_midx_pack(struct multi_pack_index *m, uint32_t pack_int_id);
 struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
 				   uint32_t pack_int_id);
@@ -123,22 +123,22 @@ int midx_contains_pack(struct multi_pack_index *m,
 int midx_layer_contains_pack(struct multi_pack_index *m,
 			     const char *idx_or_pack_name);
 int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id);
-int prepare_multi_pack_index_one(struct odb_source *source);
+int prepare_multi_pack_index_one(struct odb_source_packed *source);
 
 /*
  * Variant of write_midx_file which writes a MIDX containing only the packs
  * specified in packs_to_include.
  */
-int write_midx_file(struct odb_source *source,
+int write_midx_file(struct odb_source_packed *source,
 		    const char *preferred_pack_name, const char *refs_snapshot,
 		    unsigned flags);
-int write_midx_file_only(struct odb_source *source,
+int write_midx_file_only(struct odb_source_packed *source,
 			 struct string_list *packs_to_include,
 			 const char *preferred_pack_name,
 			 const char *refs_snapshot,
 			 const char *incremental_base,
 			 unsigned flags);
-int write_midx_file_compact(struct odb_source *source,
+int write_midx_file_compact(struct odb_source_packed *source,
 			    struct multi_pack_index *from,
 			    struct multi_pack_index *to,
 			    const char *incremental_base,
@@ -146,9 +146,9 @@ int write_midx_file_compact(struct odb_source *source,
 void clear_midx_file(struct repository *r);
 void clear_incremental_midx_files(struct repository *r,
 				  const struct strvec *keep_hashes);
-int verify_midx_file(struct odb_source *source, unsigned flags);
-int expire_midx_packs(struct odb_source *source, unsigned flags);
-int midx_repack(struct odb_source *source, size_t batch_size, unsigned flags);
+int verify_midx_file(struct odb_source_packed *source, unsigned flags);
+int expire_midx_packs(struct odb_source_packed *source, unsigned flags);
+int midx_repack(struct odb_source_packed *source, size_t batch_size, unsigned flags);
 
 void close_midx(struct multi_pack_index *m);
 
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 08a2de9bc5..d513b3efc3 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -136,8 +136,8 @@ static int for_each_prefixed_object_in_midx(
 
 	for (; m; m = m->base_midx) {
 		uint32_t num, i, first = 0;
-		int len = opts->prefix_hex_len > m->source->odb->repo->hash_algo->hexsz ?
-			m->source->odb->repo->hash_algo->hexsz : opts->prefix_hex_len;
+		int len = opts->prefix_hex_len > m->source->base.odb->repo->hash_algo->hexsz ?
+			m->source->base.odb->repo->hash_algo->hexsz : opts->prefix_hex_len;
 
 		if (!m->num_objects)
 			continue;
@@ -249,7 +249,7 @@ static int odb_source_packed_for_each_prefixed_object(
 
 	store->skip_mru_updates = true;
 
-	m = get_multi_pack_index(&store->files->base);
+	m = get_multi_pack_index(store);
 	if (m) {
 		ret = for_each_prefixed_object_in_midx(store, m, opts, data);
 		if (ret)
@@ -348,7 +348,7 @@ static int odb_source_packed_count_objects(struct odb_source *source,
 	unsigned long count = 0;
 	int ret;
 
-	m = get_multi_pack_index(&packed->files->base);
+	m = get_multi_pack_index(packed);
 	if (m)
 		count += m->num_objects + m->num_objects_in_base;
 
@@ -465,7 +465,7 @@ static int odb_source_packed_find_abbrev_len(struct odb_source *source,
 	struct packfile_list_entry *e;
 	struct multi_pack_index *m;
 
-	m = get_multi_pack_index(&packed->files->base);
+	m = get_multi_pack_index(packed);
 	if (m)
 		find_abbrev_len_for_midx(m, oid, min_len, &min_len);
 
@@ -674,7 +674,7 @@ void odb_source_packed_prepare(struct odb_source_packed *source)
 	if (source->initialized)
 		return;
 
-	prepare_multi_pack_index_one(&source->files->base);
+	prepare_multi_pack_index_one(source);
 	prepare_packed_git_one(&source->files->base);
 
 	sort_packs(&source->packs.head, sort_pack);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index f9af8a96bd..6bfcbc8ce6 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -238,7 +238,7 @@ static uint32_t bitmap_name_hash(struct bitmap_index *index, uint32_t pos)
 static struct repository *bitmap_repo(struct bitmap_index *bitmap_git)
 {
 	if (bitmap_is_midx(bitmap_git))
-		return bitmap_git->midx->source->odb->repo;
+		return bitmap_git->midx->source->base.odb->repo;
 	return bitmap_git->pack->repo;
 }
 
@@ -711,7 +711,8 @@ static int open_midx_bitmap(struct repository *r,
 
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
-		struct multi_pack_index *midx = get_multi_pack_index(source);
+		struct odb_source_files *files = odb_source_files_downcast(source);
+		struct multi_pack_index *midx = get_multi_pack_index(files->packed);
 		if (midx && !open_midx_bitmap_1(bitmap_git, midx))
 			ret = 0;
 	}
@@ -3399,7 +3400,8 @@ int verify_bitmap_files(struct repository *r)
 
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
-		struct multi_pack_index *m = get_multi_pack_index(source);
+		struct odb_source_files *files = odb_source_files_downcast(source);
+		struct multi_pack_index *m = get_multi_pack_index(files->packed);
 		char *midx_bitmap_name;
 
 		if (!m)
diff --git a/pack-revindex.c b/pack-revindex.c
index 1b67863606..62387ae632 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -383,13 +383,13 @@ int load_midx_revindex(struct multi_pack_index *m)
 		 * not want to accidentally call munmap() in the middle of the
 		 * MIDX.
 		 */
-		trace2_data_string("load_midx_revindex", m->source->odb->repo,
+		trace2_data_string("load_midx_revindex", m->source->base.odb->repo,
 				   "source", "midx");
 		m->revindex_data = (const uint32_t *)m->chunk_revindex;
 		return 0;
 	}
 
-	trace2_data_string("load_midx_revindex", m->source->odb->repo,
+	trace2_data_string("load_midx_revindex", m->source->base.odb->repo,
 			   "source", "rev");
 
 	if (m->has_chain)
@@ -401,7 +401,7 @@ int load_midx_revindex(struct multi_pack_index *m)
 				      midx_get_checksum_hash(m),
 				      MIDX_EXT_REV);
 
-	ret = load_revindex_from_disk(m->source->odb->repo->hash_algo,
+	ret = load_revindex_from_disk(m->source->base.odb->repo->hash_algo,
 				      revindex_name.buf,
 				      m->num_objects,
 				      &m->revindex_map,
diff --git a/repack-geometry.c b/repack-geometry.c
index 2064683dcf..15b3412950 100644
--- a/repack-geometry.c
+++ b/repack-geometry.c
@@ -32,7 +32,8 @@ void pack_geometry_init(struct pack_geometry *geometry,
 {
 	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
-	struct multi_pack_index *m = get_multi_pack_index(existing->source);
+	struct odb_source_files *files = odb_source_files_downcast(existing->source);
+	struct multi_pack_index *m = get_multi_pack_index(files->packed);
 
 	repo_for_each_pack(existing->repo, p) {
 		if (geometry->midx_layer_threshold_set && m &&
diff --git a/repack-midx.c b/repack-midx.c
index b6b1de7180..7c7c3620e5 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -557,13 +557,14 @@ static void repack_make_midx_append_plan(struct repack_write_midx_opts *opts,
 					 struct midx_compaction_step **steps_p,
 					 size_t *steps_nr_p)
 {
+	struct odb_source_files *files = odb_source_files_downcast(opts->existing->source);
 	struct multi_pack_index *m;
 	struct midx_compaction_step *steps = NULL;
 	struct midx_compaction_step *step;
 	size_t steps_nr = 0, steps_alloc = 0;
 
 	odb_reprepare(opts->existing->repo->objects);
-	m = get_multi_pack_index(opts->existing->source);
+	m = get_multi_pack_index(files->packed);
 
 	if (opts->names->nr) {
 		struct strbuf buf = STRBUF_INIT;
@@ -606,6 +607,7 @@ static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
 					    struct midx_compaction_step **steps_p,
 					    size_t *steps_nr_p)
 {
+	struct odb_source_files *files = odb_source_files_downcast(opts->existing->source);
 	struct multi_pack_index *m;
 	struct midx_compaction_step *steps = NULL;
 	struct midx_compaction_step step = { 0 };
@@ -618,7 +620,7 @@ static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
 			    opts->existing->repo);
 
 	odb_reprepare(opts->existing->repo->objects);
-	m = get_multi_pack_index(opts->existing->source);
+	m = get_multi_pack_index(files->packed);
 
 	for (i = 0; m && i < m->num_packs + m->num_packs_in_base; i++) {
 		if (prepare_midx_pack(m, i)) {
@@ -938,6 +940,7 @@ static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
 
 static int write_midx_incremental(struct repack_write_midx_opts *opts)
 {
+	struct odb_source_files *files = odb_source_files_downcast(opts->existing->source);
 	struct midx_compaction_step *steps = NULL;
 	struct strbuf lock_name = STRBUF_INIT;
 	struct lock_file lf;
@@ -946,7 +949,7 @@ static int write_midx_incremental(struct repack_write_midx_opts *opts)
 	size_t i;
 	int ret = 0;
 
-	get_midx_chain_filename(opts->existing->source, &lock_name);
+	get_midx_chain_filename(files->packed, &lock_name);
 	if (safe_create_leading_directories(opts->existing->repo,
 					    lock_name.buf))
 		die_errno(_("unable to create leading directories of %s"),
diff --git a/repack.c b/repack.c
index 571dabb665..d2aa58e134 100644
--- a/repack.c
+++ b/repack.c
@@ -59,10 +59,10 @@ void repack_remove_redundant_pack(struct repository *repo, const char *dir_name,
 				  bool wrote_incremental_midx)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct odb_source *source = repo->objects->sources;
-	struct multi_pack_index *m = get_multi_pack_index(source);
+	struct odb_source_files *files = odb_source_files_downcast(repo->objects->sources);
+	struct multi_pack_index *m = get_multi_pack_index(files->packed);
 	strbuf_addf(&buf, "%s.pack", base_name);
-	if (m && source->local && midx_contains_pack(m, buf.buf)) {
+	if (m && files->base.local && midx_contains_pack(m, buf.buf)) {
 		clear_midx_file(repo);
 		if (!wrote_incremental_midx)
 			clear_incremental_midx_files(repo, NULL);
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 790000fb26..fb16ec0176 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -13,13 +13,16 @@
 
 static struct multi_pack_index *setup_midx(const char *object_dir)
 {
+	struct odb_source_files *files;
 	struct odb_source *source;
 	setup_git_directory(the_repository);
 	source = odb_find_source(the_repository->objects, object_dir);
 	if (!source)
 		source = odb_add_to_alternates_memory(the_repository->objects,
 						      object_dir);
-	return load_multi_pack_index(source);
+	files = odb_source_files_downcast(source);
+
+	return load_multi_pack_index(files->packed);
 }
 
 static int read_midx_file(const char *object_dir, const char *checksum,
@@ -70,7 +73,7 @@ static int read_midx_file(const char *object_dir, const char *checksum,
 	for (i = 0; i < m->num_packs; i++)
 		printf("%s\n", m->pack_names[i]);
 
-	printf("object-dir: %s\n", m->source->path);
+	printf("object-dir: %s\n", m->source->base.path);
 
 	if (show_objects) {
 		struct object_id oid;

-- 
2.55.0.rc0.786.g65d90a0328.dirty

