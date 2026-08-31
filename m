Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE2D3C2787
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 06:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158807; cv=none; b=li3xCge8s1SMM7LObGxtaNbsPB6vuxMdvj7mmstx1BtvweXfUwSzXi/i6Cerd7jKnNK8HU3dVzWd2K/Ze6KfQ07fjm9pFA7opcBUtZh9V8CE5YY1nZ6my+kp7YfTXQf49FHefjMM1l4IuMVzj4m2HLDA3/gKVKcdp2VidsNfAQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158807; c=relaxed/simple;
	bh=lcNWTyhXEwJzbJznESni540UItTOrCYWYlLJecUwgXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UP734Ace5rGZCh+K3haThDymJunwAHx+LCZ/OTkk2jUAUwP27VPQKl7jMahJmbSkdcOZ7iI0cuCSSrfv8kj8/HsfiWfU1sfOTU3dSv1+SgWyT+DI61xbO/VKD3dFAC7nskl5IsWdmmst+wwbbsg9Ye3l5CTlAXnWYqnZMT9rrmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OiB9hi7S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mfzu2FYr; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OiB9hi7S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mfzu2FYr"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A7B8F7A0115;
	Mon, 31 Aug 2026 02:46:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 31 Aug 2026 02:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788158805;
	 x=1788245205; bh=rwygE9PaMY1aw4blRrhPINLIgG4e9GbzXcy+ec8zxYk=; b=
	OiB9hi7SXwy3mIrFgWzgPj1Pvp/3OCRisSlpy9t2QypMILoLqDYdvUvvYNkrV9rK
	7hW2Y4CkhHBy0Mr8rdGuqcpLVlyNyhDsrZfziMhsHZhMMBv61QYrFUfQK+zh7kYM
	30ygGs7ORUxekBsMJaRoMwX9sQ3K/YQlBGCjZ5DiCcs/93jrFzP3x/ViH0vbJTjK
	xRVhzIpb/0UVyxnNLeSELgFouZ7fFIexXxFuz7AcpersPreZ2rp0+hS76cDVBSEW
	iThWa1N9USPL43j3cTsOEOzk3wBJIRLV1+1TM3bISIe2CE05KFRnUGFf//zT4DC1
	ywNA8rCRu0u9LEHLYJODKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788158805; x=
	1788245205; bh=rwygE9PaMY1aw4blRrhPINLIgG4e9GbzXcy+ec8zxYk=; b=M
	fzu2FYr3PhGisrPO9Hz2GV/3qXcV8dTZp0ovYL7Q+wZuNH7GkAhEG21OAYX9ciBZ
	8B6uapuyGfGWtQQ1m8BZG+31NmZLLd5kWvoLIFQO6h6ghCQuy2Yijj/jRfYh9+gE
	wuTxmyFallmIn+k1ch20Am7W2LQX9z0nxx0qEThqI0ctvUnWtFcgk5jtUinONFq9
	WIrhND3rnD7eO1jxMGDOTgvZCmo2U+3IMaZKFjbhFmGZs7yNbhTUCjGzGL04nZS6
	A0ZOMcgXljVYXBFo+kzp0u+FcLAUEwvizwXVMJa2i0xvZsXxwyBXwYciUcgIrNkD
	RdwIx3zeidbtPMrDIK50Q==
X-ME-Sender: <xms:VSOVahvz3du0vUtg50V9c62Qhcw_azu9SDzB61EBANEmvB7IfTFfgg>
    <xme:VSOVagdkYmXCXyH4YQAHOXxb1I-7up0f1yVSpmHWHddX4_3dnliw2A12hAOiC8DfB
    DMQQvwpsJ9Pt4cegrRO7Njs5vE0SFwWQEzQ3cYaLYMkvBlqS0RdbA>
X-ME-Received: <xmr:VSOVaibXfw0kqLY97xpVivz5fqPUGko3f3VIysqg89_bzADisIgdaulvY1qvC4s8M7tMdw>
X-ME-Proxy-Cause: dmFkZTF8uJVk8lultrpZLZY6KctS9HgxGKMdbkrLq5VWkDlt8iOMXWmFSq7W24q4LNVoIC
    NQgeuGP4D1i9C4kuY8em/kvEITSdgjIUluBgCUf7PCb67wuW3weXmbCP+Fh2ElzJ9cONkH
    EJMxUYNa0jPEaKghsMfDJk4CHW3UAB7tpATIFdMJhegVOG9kPk9/0RAThe/VOHvzip80Rk
    xtztq770kAzTxm6piezbwEPSxm1tajLJ/9uUpzDjTwv2WWi2MPS+pWD+1Ao3skxSSuwC2T
    QjioQ3f4gWhpIVctNVlc09b579dXsRhipZB2e5viJVF+lNFjzHJKI4aokIc55eDDAaRlLb
    0r0kDkHeaXuuKkJ56477rPqdfA6B9lMt9fZoSAoo8akQoXc2WaR/wvHhMyNRBldKAth44m
    IAM+mlbNpUneyMOXN9WlS/axXg5TIhv8Q/9abTqZ12qtP4mGzMR4P3Hb26tM4cZadPC9/4
    o0ynHg9rCf9nRyhMJ9kIJ8LWnPQrZyIAFsVb/rcmYpi8C6vvwOlbuHUNPkDrvHOv8MXtZ4
    07dIB4iQaGwD+UuETdwkuN2V0ddxHb4d4rJIYsGHhVk+x4wDpHhaBgnkDRbnPP3RMfeKMx
    sxw99+0iLamyDr+/kWtpLxZpAPI1lNMZo/JDltkUKHsqmTHIE74iUZtQj1yQ
X-ME-Proxy: <xmx:VSOVajUInQ0USlNPgpGBkjya1u9vwq_Ss3D-mheNygIru2AWgKQTLQ>
    <xmx:VSOVakia3lFchh6j-oK9_ZJvubw3Ft-fIkj_HErsgZ_YygnblUiEjg>
    <xmx:VSOVahVMXCKefcEn_c3F6zKheqCdYn0FaeGHbBKrwoayKFovwx9QfQ>
    <xmx:VSOVarP1l8Igd9woBRuann2g18ppMoLfS62r7TvTaGTPEadD-nXhDg>
    <xmx:VSOVasdnvVZMptBrI2_OoLGhUFCmcUMY3XrTxaXI7Hu_1_vA26O8ookT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 02:46:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a5c54167 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 06:46:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Aug 2026 08:46:24 +0200
Subject: [PATCH v2 10/10] builtin/fsck: move loose object verification into
 the loose source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-pks-odb-source-fsck-v2-10-f9b16ef4957b@pks.im>
References: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
In-Reply-To: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

The consistency checks for loose objects are hosted by "builtin/fsck.c".
These checks are obviously specific to the "loose" backend.

Move the logic into `odb_source_loose_fsck()`. Introduce a new "verbose"
flag so that we can properly retain semantics around whether or not we
want to print some status messages.

Note that this fixes a bug as a side effect: the progress meter was
captured in the callback data before `start_progress()` was even called,
so the per-subdirectory progress updates always operated on a NULL
pointer and the meter jumped straight from 0 to 256 upon completion. The
new code only sets up the callback data's progress meter after it has
been created, so the progress display now advances incrementally again.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c     | 91 ++----------------------------------------------------
 odb.h              |  3 ++
 odb/source-loose.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 93 insertions(+), 90 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 7eaea340b0..4af1d874cc 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -12,7 +12,6 @@
 #include "parse-options.h"
 #include "progress.h"
 #include "packfile.h"
-#include "object-file.h"
 #include "object-name.h"
 #include "odb.h"
 #include "odb/streaming.h"
@@ -695,88 +694,6 @@ static void process_refs(struct repository *repo, struct snapshot *snap)
 	}
 }
 
-struct for_each_loose_cb {
-	struct repository *repo;
-	struct progress *progress;
-};
-
-static int fsck_loose(const struct object_id *oid, const char *path,
-		      void *cb_data)
-{
-	struct for_each_loose_cb *data = cb_data;
-	enum object_type type = OBJ_NONE;
-	size_t size;
-	void *contents = NULL;
-	int eaten;
-	struct object_info oi = OBJECT_INFO_INIT;
-	struct object_id real_oid = *null_oid(data->repo->hash_algo);
-	int err = 0;
-
-	oi.sizep = &size;
-	oi.typep = &type;
-
-	if (read_loose_object(data->repo, path, oid, &real_oid, &contents, &oi) < 0) {
-		if (contents && !oideq(&real_oid, oid))
-			err = error(_("%s: hash-path mismatch, found at: %s"),
-				    oid_to_hex(&real_oid), path);
-		else
-			err = error(_("%s: object corrupt or missing: %s"),
-				    oid_to_hex(oid), path);
-	}
-	if (err < 0) {
-		errors_found |= ERROR_OBJECT;
-		free(contents);
-		return 0; /* keep checking other objects */
-	}
-
-	if (!contents && type != OBJ_BLOB)
-		BUG("read_loose_object streamed a non-blob");
-
-	if (fsck_obj_buffer(oid, type, size, contents, &eaten, data->repo))
-		errors_found |= ERROR_OBJECT;
-
-	if (!eaten)
-		free(contents);
-	return 0; /* keep checking other objects, even if we saw an error */
-}
-
-static int fsck_cruft(const char *basename, const char *path,
-		      void *data UNUSED)
-{
-	if (!starts_with(basename, "tmp_obj_"))
-		fprintf_ln(stderr, _("bad sha1 file: %s"), path);
-	return 0;
-}
-
-static int fsck_subdir(unsigned int nr, const char *path UNUSED, void *data)
-{
-	struct for_each_loose_cb *cb_data = data;
-	struct progress *progress = cb_data->progress;
-	display_progress(progress, nr + 1);
-	return 0;
-}
-
-static void fsck_source(struct repository *repo, struct odb_source *source)
-{
-	struct progress *progress = NULL;
-	struct for_each_loose_cb cb_data = {
-		.repo = source->odb->repo,
-		.progress = progress,
-	};
-
-	if (verbose)
-		fprintf_ln(stderr, _("Checking object directory"));
-
-	if (show_progress)
-		progress = start_progress(repo,
-					  _("Checking object directories"), 256);
-
-	for_each_loose_file_in_source(source, fsck_loose,
-				      fsck_cruft, fsck_subdir, &cb_data);
-	display_progress(progress, 256);
-	stop_progress(&progress);
-}
-
 static int fsck_cache_tree(struct repository *repo, struct cache_tree *it, const char *index_path)
 {
 	int i;
@@ -978,8 +895,10 @@ int cmd_fsck(int argc,
 
 	if (show_progress == -1)
 		show_progress = isatty(2);
-	if (verbose)
+	if (verbose) {
 		show_progress = 0;
+		odb_fsck_opts.flags |= ODB_FSCK_VERBOSE;
+	}
 	if (show_progress)
 		odb_fsck_opts.flags |= ODB_FSCK_PROGRESS;
 
@@ -1012,10 +931,6 @@ int cmd_fsck(int argc,
 		odb_for_each_object(repo->objects, NULL,
 				    mark_object_for_connectivity, repo, 0);
 	} else {
-		for (source = repo->objects->sources; source; source = source->next)
-			if ((odb_fsck_opts.flags & ODB_FSCK_FULL) || source->local)
-				fsck_source(repo, source);
-
 		if (odb_fsck(repo->objects, &odb_fsck_opts) < 0)
 			errors_found |= ERROR_OBJECT;
 
diff --git a/odb.h b/odb.h
index 0bf6c8d7d2..b87f281cbd 100644
--- a/odb.h
+++ b/odb.h
@@ -218,6 +218,9 @@ enum odb_fsck_flags {
 
 	/* Display a progress meter, if sensible. */
 	ODB_FSCK_PROGRESS = (1 << 1),
+
+	/* Be extra verbose when checking the database. */
+	ODB_FSCK_VERBOSE = (1 << 2),
 };
 
 /* Options that shall be passed to `odb_fsck()`. */
diff --git a/odb/source-loose.c b/odb/source-loose.c
index f68d3c4d6c..efef9ca61f 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -12,6 +12,7 @@
 #include "odb/streaming.h"
 #include "oidtree.h"
 #include "path.h"
+#include "progress.h"
 #include "repository.h"
 #include "strbuf.h"
 #include "tempfile.h"
@@ -1031,12 +1032,96 @@ static void odb_source_loose_free(struct odb_source *source)
 	free(loose);
 }
 
-static int odb_source_loose_fsck(struct odb_source *source UNUSED,
-				 struct odb_fsck_options *opts UNUSED)
+struct fsck_loose_data {
+	struct odb_source_loose *source;
+	struct odb_fsck_options *opts;
+	struct progress *progress;
+	bool error_found;
+};
+
+static int fsck_loose(const struct object_id *oid, const char *path,
+		      void *cb_data)
 {
+	struct fsck_loose_data *data = cb_data;
+	enum object_type type = OBJ_NONE;
+	size_t size;
+	void *contents = NULL;
+	int eaten = 0;
+	struct object_info oi = OBJECT_INFO_INIT;
+	struct object_id real_oid = *null_oid(data->source->base.odb->repo->hash_algo);
+	int err = 0;
+
+	oi.sizep = &size;
+	oi.typep = &type;
+
+	if (read_loose_object(data->source->base.odb->repo,
+			      path, oid, &real_oid, &contents, &oi) < 0) {
+		if (contents && !oideq(&real_oid, oid))
+			err = error(_("%s: hash-path mismatch, found at: %s"),
+				    oid_to_hex(&real_oid), path);
+		else
+			err = error(_("%s: object corrupt or missing: %s"),
+				    oid_to_hex(oid), path);
+	}
+	if (err < 0)
+		goto out;
+
+	if (!contents && type != OBJ_BLOB)
+		BUG("read_loose_object streamed a non-blob");
+
+	if (data->opts->object_cb(oid, type, size, contents, &eaten,
+				  data->opts->object_payload)) {
+		err = -1;
+		goto out;
+	}
+
+out:
+	if (err)
+		data->error_found = true;
+	if (!eaten)
+		free(contents);
+	return 0; /* keep checking other objects, even if we saw an error */
+}
+
+static int fsck_cruft(const char *basename, const char *path,
+		      void *data UNUSED)
+{
+	if (!starts_with(basename, "tmp_obj_"))
+		fprintf_ln(stderr, _("bad sha1 file: %s"), path);
+	return 0;
+}
+
+static int fsck_subdir(unsigned int nr, const char *path UNUSED, void *cb_data)
+{
+	struct fsck_loose_data *data = cb_data;
+	display_progress(data->progress, nr + 1);
 	return 0;
 }
 
+static int odb_source_loose_fsck(struct odb_source *source,
+				 struct odb_fsck_options *opts)
+{
+	struct odb_source_loose *loose = odb_source_loose_downcast(source);
+	struct fsck_loose_data data = {
+		.source = loose,
+		.opts = opts,
+	};
+
+	if (opts->flags & ODB_FSCK_VERBOSE)
+		fprintf_ln(stderr, _("Checking object directory"));
+
+	if (opts->flags & ODB_FSCK_PROGRESS)
+		data.progress = start_progress(source->odb->repo,
+					       _("Checking object directories"), 256);
+
+	for_each_loose_file_in_source(source, fsck_loose,
+				      fsck_cruft, fsck_subdir, &data);
+	display_progress(data.progress, 256);
+	stop_progress(&data.progress);
+
+	return data.error_found ? -1 : 0;
+}
+
 struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
 					      const char *path,
 					      bool local)

-- 
2.55.0.979.g7e5102b832.dirty

