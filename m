Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E9B46F48E
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099557; cv=none; b=WzHK9LcaqwWbxZS2MHUrQHAK+XrKdt5oltrJbJiJyS/jlQ4LBPbg7hWhCQoI0t3xrREM05OysFhLVeMVZBvsZAFXUJ63dymZC2b2IrL5ObVKHlFfjhpUsuyLvyUa43KF41pqRduR2F1J0W7hBa8/TkUAhqrgTtA4rz4Y7c6AFTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099557; c=relaxed/simple;
	bh=BWgPoOTP+b6/gZKTvOI7OxP90Yol/vsbDhqrVU2D3pM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K2B3W2A0I+bmKKMdAtrwtoDYndWMlD5OLY6hOOvEFsYcyTnH6/WAhIBIhHSt9NmeX4j98GCfajmnue1mH5WVGlhPfUnzqQEX9zFetufYzIPytXksUU5jpae6HYGIPNlSqogVztGFmURiFVKlVfUJ1wBoVeMtmWdrfHAdewN7+d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HkIJCGO+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oc/Wfcat; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HkIJCGO+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oc/Wfcat"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 56BD614000F9
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 06:45:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 07 Aug 2026 06:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786099554;
	 x=1786185954; bh=1CJSArDaxXMa4yLld3Uq43ZcfZPUkyZXPOiBDt/6tHw=; b=
	HkIJCGO+8pAr/XXSjmHi5XauK/efbLkYQK2FqzXCqYvW61FiBBmGaNXg3Z9rBnzP
	xO0ruU1dNCqWMMpOAyivd6180vh/9o16AmQ8LRDi/5o8dkMaHgeBNjowakhfP1Q8
	WVagkfcMS7Wi8dlucY63SmP6fpFGWF7SBYX7PvUGkTwxIOiWgBB778yZ6gRp59cw
	HsJNBkKByWJeGPAkj9k4En29XHtehour/1LRUsfXBlh0MGQsKFQBUKmjLJQCuokq
	YIf/Txj8Ne0gtQ+ZVLTmH0YSf7GMoESKeHXvxHxx7C826HxpFYdlXXCecbaW2Myg
	sdkbf9PLQ4EvOqod+TsxEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786099554; x=
	1786185954; bh=1CJSArDaxXMa4yLld3Uq43ZcfZPUkyZXPOiBDt/6tHw=; b=O
	c/Wfcat6U3DZwuRkj5Uz3r5FsMXeWo4MdKWLPa6xqDQSGnFInZgdcEHwiVcETor5
	f9EH0SnC/mGIvLrAcnr+9q2GA/C78Bi84kgXrIifR+FQPgMNwpsPoAyoD4BsI6DH
	Tn6vGSQVO4HwtSQyLjUbfyYcvyRXc4KCsfurtPSCDknmEiLYPpUtNgQwU1Wp6Fva
	MQ6t12tQBbbDWyqmWRjUUP7vppD/qiYpVVcr+1iEhHbcX8rLjLjtuJZWj1u8hinF
	IzZ+khWEBkBBxVGAb0aYaba5P5Wk9DengkecsYlUEYhEMSzIeUKQvlYDEJ7VVwzm
	oi4b4XawxODziO+JgVyxA==
X-ME-Sender: <xms:Yrd1avifU0jOuGKBUvqBzwXqfOVRSkQzhG-kqRg2TusnHp8_FSBq-Q>
    <xme:Yrd1ai8BlBw4kBZAwGvfoi4R9pigYjOMm_9aa-8G_AdwORtmk3e0QXDznTawWY8MI
    g7J4cDDgDN_YVdvwPt2VyaIb15I9PwII-CMSlqZEgq2ELxycxFhmRg>
X-ME-Received: <xmr:Yrd1aksmi3nVIpON8Lr3KPyYjeofg4mZDq1vO7CELWCvLXSpwiBoDHcp6PqqvWWpSLvTRKEJKcBOiMlvrQy_o2UyJcr2sSldlU_G4aQP4E-0Ww>
X-ME-Proxy-Cause: dmFkZTGNsvSFSUECcu2Nh0FGOfZ19l5LxGfcGph13wKJT4TAzUBJREfYOszHqXAiQ3n7iU
    lqzIMoX63uJA32W3RBYcZ1/RyQqX26JNaPlBXTGD/ls9dTd0VZhbyytEvDxvkaEG0PK67L
    JGkzA9lNwINefEzvYZKwdjhramO6e3IPfqAJZG0u2o9u3xqlHWQV4mjs6csBpBWYeIfq6t
    8Z7hNK95Hh9RzVMFiF3lT8k+1IfFEkOfZOp6vFPBbw6UfNt0jStcDh7rvbhnMOCy09Xr8t
    YSyUhF+HhFTVABaqOv1R5YNe4ByqU5empe4W0yKQu/SyfLZzc4QHCbGw1hYoAGreUqXRP5
    u2Y7g8C8u3NqAvurPLzO5AOqYFNpMymhe9dKbguEGISLKor+yP8rBH5/d2Uu1S5hGlsr1I
    fEDz4gERB5bmN2fx7RbxUuP2PszI2MXAoGB5shx3RDC3kyEA35ugYSqJLUjdjUX+Jv9yff
    cWxDGlOz5CQygpX4ufnWIpnkAoxgQ2jpN4aKIY+Z5CW2Eumr4X3JD0AD0FPD82jA/SWgcV
    GW73fY0/R2+NOXIjKCnukDalv6thB2oamgPlssnoJ2r9a+J/aVjuINy/t5i/xO8ldsxzzM
    g0vhRAgE0uxIuvCm0cHPPMpIab7HAgcL417GalB7LDJF7IW6GYXtEuulC+hg
X-ME-Proxy: <xmx:Yrd1ahYxQIS37_u2XhN_LTn-FDnmnkZqyeQSOQKLRx3dWK9shhaWlw>
    <xmx:Yrd1asqf2_CD7qj16AkrG9KLkSWyymY9LUlJ_t-xyvwHUOPeZA-hsg>
    <xmx:Yrd1au9x9RpDkeyKS8b2XzB1C11pNU5pK610Tv20AvPerw6YXQThbg>
    <xmx:Yrd1aj9GMVjSCVSXnX8WQHOoDI2Rda5_3p0SLbO6cKaLwJXc-1fMOg>
    <xmx:Yrd1agjymvQRHD3br3wfFyDS35ZXlx-vILTmJrc3XRT8Soq3lxDuoxcA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 7 Aug 2026 06:45:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 21e4da60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 7 Aug 2026 10:45:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Aug 2026 12:45:11 +0200
Subject: [PATCH 5/5] bundle: generate packfiles via the object database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-b4-pks-odb-generate-pack-v1-5-7dec431ae7cd@pks.im>
References: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>
In-Reply-To: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

git-bundle(1) spawns git-pack-objects(1) directly to generate the pack
data that gets appended to the bundle header. While bundles are not
part of the wire protocol, they are a transfer mechanism for packs all
the same, so convert them to use the pack generation interface of the
object database as well.

This makes the pack generator the single spawn point for all pack
streams that leave the repository, leaving only local maintenance tasks
like git-repack(1) with direct knowledge of git-pack-objects(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/bundle.c | 10 +--------
 bundle.c         | 68 +++++++++++++++++++++++++++++---------------------------
 bundle.h         |  3 +--
 3 files changed, 37 insertions(+), 44 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index bfafadc984..de86e092a6 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -69,7 +69,6 @@ static int parse_options_cmd_bundle(int argc,
 
 static int cmd_bundle_create(int argc, const char **argv, const char *prefix,
 			     struct repository *repo UNUSED) {
-	struct strvec pack_opts = STRVEC_INIT;
 	int progress = isatty(STDERR_FILENO);
 	int version = -1;
 	struct option options[] = {
@@ -92,16 +91,9 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix,
 			builtin_bundle_create_usage, options, &bundle_file);
 	/* bundle internals use argv[1] as further parameters */
 
-	if (progress)
-		strvec_push(&pack_opts, "--progress");
-	else
-		strvec_push(&pack_opts, "--quiet");
-	strvec_push(&pack_opts, "--all-progress-implied");
-
 	if (!startup_info->have_repository)
 		die(_("Need a repository to create a bundle."));
-	ret = !!create_bundle(the_repository, bundle_file, argc, argv, &pack_opts, version);
-	strvec_clear(&pack_opts);
+	ret = !!create_bundle(the_repository, bundle_file, argc, argv, version, progress);
 	free(bundle_file);
 	return ret;
 }
diff --git a/bundle.c b/bundle.c
index b64716f252..09afc465c0 100644
--- a/bundle.c
+++ b/bundle.c
@@ -325,50 +325,52 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
 
 
 /* Write the pack data to bundle_fd */
-static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *pack_options)
+static int write_pack_data(int bundle_fd, struct rev_info *revs, int progress)
 {
-	struct child_process pack_objects = CHILD_PROCESS_INIT;
+	struct odb_generate_pack_options opts = ODB_GENERATE_PACK_OPTIONS_INIT;
+	struct odb_pack_generator *generator;
+	int ret = 0;
 	int i;
 
-	strvec_pushl(&pack_objects.args,
-		     "pack-objects",
-		     "--stdout", "--thin", "--delta-base-offset",
-		     NULL);
-	strvec_pushv(&pack_objects.args, pack_options->v);
+	opts.thin = 1;
+	opts.ofs_delta = 1;
+	if (progress)
+		opts.progress = ODB_GENERATE_PACK_PROGRESS_VERBOSE;
 	if (revs->filter.choice)
-		strvec_pushf(&pack_objects.args, "--filter=%s",
-			     list_objects_filter_spec(&revs->filter));
-	pack_objects.in = -1;
-	pack_objects.out = bundle_fd;
-	pack_objects.git_cmd = 1;
+		opts.filter_spec = list_objects_filter_spec(&revs->filter);
 
 	/*
-	 * start_command() will close our descriptor if it's >1. Duplicate it
-	 * to avoid surprising the caller.
+	 * The pack generator will consume our descriptor if it's >1.
+	 * Duplicate it to avoid surprising the caller.
 	 */
-	if (pack_objects.out > 1) {
-		pack_objects.out = dup(pack_objects.out);
-		if (pack_objects.out < 0) {
-			error_errno(_("unable to dup bundle descriptor"));
-			child_process_clear(&pack_objects);
-			return -1;
-		}
+	opts.pack_fd = bundle_fd;
+	if (opts.pack_fd > 1) {
+		opts.pack_fd = dup(bundle_fd);
+		if (opts.pack_fd < 0)
+			return error_errno(_("unable to dup bundle descriptor"));
 	}
 
-	if (start_command(&pack_objects))
-		return error(_("Could not spawn pack-objects"));
-
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object *object = revs->pending.objects[i].item;
 		if (object->flags & UNINTERESTING)
-			write_or_die(pack_objects.in, "^", 1);
-		write_or_die(pack_objects.in, oid_to_hex(&object->oid), the_hash_algo->hexsz);
-		write_or_die(pack_objects.in, "\n", 1);
+			oid_array_append(&opts.haves, &object->oid);
+		else
+			oid_array_append(&opts.wants, &object->oid);
 	}
-	close(pack_objects.in);
-	if (finish_command(&pack_objects))
-		return error(_("pack-objects died"));
-	return 0;
+
+	if (odb_generate_pack(the_repository->objects, &generator, &opts)) {
+		ret = error(_("Could not spawn pack-objects"));
+		goto out;
+	}
+
+	if (odb_pack_generator_finish(generator)) {
+		ret = error(_("pack-objects died"));
+		goto out;
+	}
+
+out:
+	odb_generate_pack_options_release(&opts);
+	return ret;
 }
 
 /*
@@ -476,7 +478,7 @@ static void write_bundle_prerequisites(struct commit *commit, void *data)
 }
 
 int create_bundle(struct repository *r, const char *path,
-		  int argc, const char **argv, struct strvec *pack_options, int version)
+		  int argc, const char **argv, int version, int progress)
 {
 	struct lock_file lock = LOCK_INIT;
 	int bundle_fd = -1;
@@ -584,7 +586,7 @@ int create_bundle(struct repository *r, const char *path,
 	}
 
 	/* write pack */
-	if (write_pack_data(bundle_fd, &revs_copy, pack_options)) {
+	if (write_pack_data(bundle_fd, &revs_copy, progress)) {
 		ret = -1;
 		goto out;
 	}
diff --git a/bundle.h b/bundle.h
index d664b2f2d6..471da23d1b 100644
--- a/bundle.h
+++ b/bundle.h
@@ -27,8 +27,7 @@ int read_bundle_header(const char *path, struct bundle_header *header);
 int read_bundle_header_fd(int fd, struct bundle_header *header,
 			  const char *report_path);
 int create_bundle(struct repository *r, const char *path,
-		  int argc, const char **argv, struct strvec *pack_options,
-		  int version);
+		  int argc, const char **argv, int version, int progress);
 
 enum verify_bundle_flags {
 	VERIFY_BUNDLE_VERBOSE = (1 << 0),

-- 
2.55.0.679.g6767b8d81c.dirty

