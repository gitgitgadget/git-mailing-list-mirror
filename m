Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D2D48988A
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133277; cv=none; b=OfrNWqF5BOPPfIKNetRXgcsplxsNkud2sWymRTSOhAFij0UKG6m+SARQPdBgLo+yQkaDkln4CEzJBBxi9GyyL78oCacyL4+o+/jV/IJGeMIWtkEnkh1lMZuHnk6Lrbtk1r3cSGfFtKu2XpzXkreNE7f3c9O5bWsO2nuptnBb+Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133277; c=relaxed/simple;
	bh=Eze/73n6Y/jyit5wu9rYpAF46zE91CCkTCFeCR50Akw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AwZzBGU/kjKNSKxp5aMX19kz78hoCn5igWvmgHo3l7NyAdZOKkHnT3XTyWfd8nscyuE+nnl1+Vc3EBWrH2rvzIkB5RRkOxgL4Vj8XYsG81KBFgwljgbmRzVTPA8tGUacv/18NItTGBGGd01AD9DC3IuBfrVFKLD+uQN0wZrKFco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o18keFtu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fCrUY5b7; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o18keFtu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fCrUY5b7"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EFE531400105;
	Fri, 11 Sep 2026 09:27:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 11 Sep 2026 09:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789133274;
	 x=1789219674; bh=H0YYS/01w2KKQLYxA+Vu6na2t2PYkaqB+TNqgLkwc98=; b=
	o18keFtuj0akiJOCzLbpv8j16RpO2Ks3ERjuTqbiBPLJIFJhidwxMcOq4SaQXuy0
	adUaUc9V6eul5b2VnWoVEtQUvAGWAbhbgVaUxnbpW5hMdsLITgrcH4G7PzhQniLp
	YSOWhMQqJfv8N7H2gdvF60CvERFKLHC0LTQzHq1LnCOCE82L86v2CYPRWE+18+OZ
	aSQAx/12ayP7TUbv1lePgYB16quk2G950VD+TWoFreyg8tTf2oaajtXJfS6lU3hE
	YcK6rtegNw/eVzi7RF/Ary/xL+H6KAw92LfokQpydl0spWe1CmEWOpDBM2vxGoBL
	5zDsW0RHT0ol4fhwg73s3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789133274; x=
	1789219674; bh=H0YYS/01w2KKQLYxA+Vu6na2t2PYkaqB+TNqgLkwc98=; b=f
	CrUY5b7UgWJeMPkTx6u3r85z4zjWMZDMitudXdSURMQ10WVz3oryToLBONqkKTrv
	T4e+CYOBPPdwv7pyVZznKVPFnW1lGblMPZLTdG9wPmZpzi+1wyAqJwnbHvDZIt9S
	x7X60Fvsv9rO6+mzapf72XwlgSJYfydaWMbIfYRSGhcE7Ln7TKSga9MNwk11MzIG
	z1VdRGduK2iOJr8Ht3SMD2PKrolrepxAQQ19+jdwnz0EkoZqxxeAx1nWEak4KyHW
	3kbMZtfv7mR4tiJqyr6tkDuj9CFNFAM7xwNAShs/mxCvqZOj9vnsgmOfnrQpIPTB
	O5c60l4FHDNq7qgW/W8Zw==
X-ME-Sender: <xms:2gGkah6nRuR6AJUQLRObUIgDGk5bTvRviJSdaPM4viHqhF5r6szkXA>
    <xme:2gGkamUTtHHLEo_Gm2lrLPcwadJ0TwxRS_lToxmlp82KeJFbkYWqxTJ-WzwLUHpS6
    vdkdVj92o_NLsHdUet5sL18wpOto2G9IBww9yNjeVn8iUNSOM-SLw>
X-ME-Received: <xmr:2gGkal0Is95vDIBcPHKArO-FXiiy83q359Xhei9gA69lb8GMOlTQrRLpGJiuq7RalQQV7A>
X-ME-Proxy-Cause: dmFkZTECg8xxBicj1DZS8ANPYnoLkr6WmqZgUjMjlEg+sGzWjqLplREE0ffvvHBmWPAecg
    q+c7PBkoqu7i3P61nG0ccczl9tex8wqN0uqAIqkscV+NqvEU3KnvXs7k+hFS/VwVVQQ43c
    A5FpjBpUNGQKkA3B3tIA+qB36AOfSLZGPRcOW25ujcTxgOzqUBQduBQyZOZe5kUxdKiaJp
    l/OBoFl3wHXALaR6wymfPNH4IY2Krzm00t/d2XCLL8Dy/KaES604yZutrFoJEyqnQ1FLf9
    Fn5HVsaR+LB9rj6EHr0E8SreONR8SbYOhAQ3KEI0o4NHBdJmhZ3EPoIyEYihr4bhpRbSN9
    qVWAb2cbDzcPXmGQMOD9YitQzkXYAvF6dgxJeLVVk539uOd/WDz1fYrwzIP17RLc6eLw4v
    VZ/u5YqKrwwB+6GDC6JEILBW1OFJXWXqs3DuLugAgb5teGN2swwSl3+USnvP/wyaZcAUsA
    iYjcew04iGjLsPv2oKTHjqorcwa1ej8rw7qdgd8HtQNNZ2IZHjNydLHVEvlXJCTYMyPTI2
    MW1FrZlP2cwfSeML9PLvAo5LIk6lVeDMbCWcKo+x5gcepPsQDozeSrIf/uhGGVJFSb76yM
    DVkUdCpdaqyNWqOyjxjJVk8aMFprZKMRqDZC71olQV5f8GAtfm7sKiT+iNHA
X-ME-Proxy: <xmx:2gGkaj2hRPBV_e16Z9Wv8oTZluXi0VOuWouKxtgdAuYF1LTKIv7V8Q>
    <xmx:2gGkao_wsuqNdvVZOrL9v0anV2JLKsFP5U-lmEdetzjDkzqxp-tVJA>
    <xmx:2gGkag1otoJxk40eN3Z4XE5g1eTPk0uRRwWAUm_aN5S1HR3j4kRq8Q>
    <xmx:2gGkal8F9Sim_CLAWT2uvvxuPv9MUysvdTiTe8bJv1yXNOjR3ANb-w>
    <xmx:2gGkaiez5U1OUYauGSrYId4R2UCbfXeJobxAYechQbP6Z3yo628wpiei>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 09:27:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e7e418f8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 13:27:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Sep 2026 15:27:34 +0200
Subject: [PATCH v3 10/10] builtin/fsck: move loose object verification into
 the loose source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-pks-odb-source-fsck-v3-10-ef2fdc085e38@pks.im>
References: <20260911-pks-odb-source-fsck-v3-0-ef2fdc085e38@pks.im>
In-Reply-To: <20260911-pks-odb-source-fsck-v3-0-ef2fdc085e38@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
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
2.55.0.1074.ge7621b4bad.dirty

