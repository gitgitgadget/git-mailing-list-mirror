Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A815147987E
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668240; cv=none; b=uRC1UpyZLjz5gnDrmcC++ns10Wn/pf/Lv2KNYg2p8ftKceSPMubmfBa/Wvr9Kex+g47D5MvqSakb8g/E+JfyqkUAlGMMHeLqaqp4FWlB4m3P8jjQeGkXOT9BjpG4e+/+lECyDQQOn/CS5buxRXpOTTcXRYzdymijGZNI3y9pRuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668240; c=relaxed/simple;
	bh=hkL7eJMR/cWogvD8TEw8UGK0SwHSJqAR0q5/vhJOY8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u1DhFUjM4yf9R23tMVVFbNI96L3SLZOSTs4/glmsb+Y1m/FXSl18W0/7RnU7jBdF3A0l8uAMrlxGHM4VL47gzMJESD1t2xaRE6o3N1R0X7A1iQDemoKKOLVaZ2YYm6f+Gbe/dGsYaVGB2fd8mqWreQ+QnIjHualOn10fCPvHjwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i6eNqGgi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E6hTM0TP; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i6eNqGgi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E6hTM0TP"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0A9287A00E0
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:30:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 25 Aug 2026 10:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787668237;
	 x=1787754637; bh=UznJOykA6llhrNshUkDmin7LISRZM4iTJ+PFOfFpF9c=; b=
	i6eNqGgi4MbT8DUWZPaXd2Hai8amxKJO91XF5rHmJmA57HpTiPOwgvSseB1Ij2v2
	kTLFHPb9+4K/B+5xrpY8JUm+Bscn5rLRnRaSaZUVbkXQ1LbcZp5/0mrMns0IiKcS
	2AkyVCpOgBkT5BZo820+5pzRqIKTNuIN9KRWeb/BWS5+roRLSoYpnWCsqiHzJnf8
	0WZQG6x/WXO3zE6J3/++7ObfltusL0gQPw0wEbX066C0gmoi6HhtW99fnKuE0xzX
	nmJvErVM8ugJPR+L+rYYSdX6d+FCjSmzroRFkBNMUX25jKzGmIpAFycwA1RL3PbJ
	Flrb30mXtn9ROyzYnbPF0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787668237; x=
	1787754637; bh=UznJOykA6llhrNshUkDmin7LISRZM4iTJ+PFOfFpF9c=; b=E
	6hTM0TPcP7JyVYtISlQw3Q3FCI5QIpMp353fyvGYh/ZyD/GoAzBaJEWp/zEkaMV4
	8ODFoq4WJK5BsKoJ+b2wmUV+b5icypZxT4z2XgOHm9Dpo2MmN1YZiohwEMikNHuH
	fBcoELRftGFOPY6ojIHcdaE7y+FZbHB3OUr09NHRQ4Y4jzmam/tTm7Y3qAs/K+MF
	BF0NPayKU/BOFplevJvxVBz/7MrBUvqHOtEOLlWkHmH1shqI79P175wcd/EL1Gkn
	tccXi+jnox4miQBme7HZqy0nSLLFy66UAayH7Rv5z3MrfPdVDCG/ok7QRxsdn6ZK
	M67eye1XZUMLmGETaEUIA==
X-ME-Sender: <xms:DaeNarMF3PwEQu1YMYSyGht0ONMwlVWPEVBCqAGf7e_e7YNr8FO9og>
    <xme:DaeNas5TcXitzw1o50K6cjhZToUGbUYwd6smZ31Krq8EMUmlRqlliIQLyCVme9fzt
    oOyWnS6YFKcQNDc6gaSvd9xILGSrYeahxktii19dShxc3xISb02004>
X-ME-Received: <xmr:DaeNav4tlnuPEZm1SVV0cUwXx2xTWquHk7hOD4PaYRwBAE2HVf3khwl8LxCyjioNiOd-CSwraCKFCu1AoEl_3dF9xq83zsTCBNMHTLOxnA>
X-ME-Proxy-Cause: dmFkZTGOmSEoA9+neI+y6KiFqVXJj0lCm5MyPrg5bG3mwmIfeptIuZK7pOspHB6dr6A3jw
    0b/nHilbJLti9juHqkQtupslXwSfMeDhLeTytcgAkgbV5IYLLNRDfbNZwb8KKAtTqC7BGu
    RkE7+oesP2tvNj31/eakZnAWVEErj3M2qF0Lr2Tnt7Be2UkyMqYngT1/WrI2kQn2isyTAn
    XQBfDsHBrb4V+jW4kTy1dcwAq5rnGQeLikoGIjyTQHK8hFdW6U12c6P5gTTsozsE8NAAfa
    Z34rMM9NxT8cpJVaHMuMXC8bYMvWvlH7A/119w9iGKyCoQJIG7KBeAj1ZQLj0M5keapHo6
    jyiicb69hLOw1x7mMMlLU0N326qMVFt9/9iCefEh8qheFKO1PPL8MhWhHNea+z64+jNOqI
    hV3SB670rci6yOm3tioETsDIf8oY7R5MnPmoNYpzpAilAs+hnz/fju+OOx8BWPcTKJGS3V
    3q1oAX8THSr6Vc1HqDM/UuE7bHGM6TLNxs1QMssersYrgE4YvcrqpP9sJuPb+g7Gy9I6S6
    yHViYkG/BtGB0/XfTEeXC7UqGc9W3c7vPi0W2aBDKRnQNaAV0dqPJ5tiOt5mO1RdxNQa5j
    0sDo6SKrVRnPvVhHvwpsRLMYp+V3s0WI2at75gjee9tjOzby1nwPWMGIrbmw
X-ME-Proxy: <xmx:DaeNak1K4Z6bMxHebdos_J8sxKziaIu3_GHKdkt-xy_G6Tfo-aamhg>
    <xmx:DaeNajXGzvT_adj7IwIIRZMB7RhemLrOzH0myyhnvfAitz1ZCaGmuA>
    <xmx:DaeNan7vpHJ-8ggOTIXdBZQlUI_M7r1Wx_GfR6XD6yKop5pdcscG1w>
    <xmx:DaeNaiI2jBpbQmxaHgrNgZiYnLpxE17IOAL6p1m6jFEnnUQW71Q_1Q>
    <xmx:DaeNav_GoAYh4fORzHrMQrTCIkt80x9rCdR88OL0uJp4T7u-ocjE5YTL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 25 Aug 2026 10:30:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2c989bc6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 25 Aug 2026 14:30:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Aug 2026 16:30:12 +0200
Subject: [PATCH 10/10] builtin/fsck: move loose object verification into
 the loose source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-pks-odb-source-fsck-v1-10-b756de0bf24f@pks.im>
References: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
In-Reply-To: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.55.0.822.g20453c30eb.dirty

