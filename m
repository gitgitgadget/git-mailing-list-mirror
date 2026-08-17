Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A716391832
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 05:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786945208; cv=none; b=R6289YbE9KQcdx3So0xCpaTlFDhjmOmw3Bzr5f+bKSg6Zx1b8MmQqNOv7C0pTfJW1tsIQlRD6vcf7GKUue0MNqxT9YuCZln5iEw4ObvWLjxna2zKiZDg/E97SbR4W1vxUaMOH71qrB57H4prxB/PxqchWOI+2M2siuSLpCkyN+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786945208; c=relaxed/simple;
	bh=O78lumlBNzj+4Cl+QLdZ0euPVSwjqFZ1hvWGXWcsdBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ngTTtwy5VldyHUhGu+313+tlT0oOklaasHc4nbvcVyrofCf/U5P0ySZiRD2aGaL1hF/qkEKpDjHTKwNB8ZeTfNdfu4esl3wsFQzsBeJCYckO+rQGEyvcKa8HOlrSSAxux4E+aps5ePZZZF9ukc44Ehij4KOTiRLqPnWUc1Z6Bik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eTvvptwU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KtJq9seo; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eTvvptwU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KtJq9seo"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A433D1D00120;
	Mon, 17 Aug 2026 01:40:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 17 Aug 2026 01:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786945205;
	 x=1787031605; bh=Ad8qyVcL3/b3/mCNx/QQFGC+gmNp9rBx2fw9pF/vKI4=; b=
	eTvvptwU2LpwBpuN+6OR16BoG9/F1ZHOu+3ZQK1nymjxQo7+WeN1LwmbD/XuMRaX
	oCZ7mmi3ODwSuqhLFKXfAfkda12lcCHZbDE9mk/yR8WFf4nnUUW4YPlcofL/g/Ys
	MsvJk+e+wjyh4YucCeVfCR8GPUM5JegpNV81Je3AlRQ5AJslFrkvICbJyMqAl/mt
	9YuhhM+qDY+qF1QNK9BJo0RNgiIHSOMuL2vQffdTgG9+cKJxR6ejIEgyTGrkR2Us
	yHZ8BUQBQb3bfLegHPlLDQw0FxxTv1FpW4FRl+LtvLU6JoOk/MIB2Y59gCpSQV50
	znXvvEXt0Zm/b8SvLyS7Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786945205; x=
	1787031605; bh=Ad8qyVcL3/b3/mCNx/QQFGC+gmNp9rBx2fw9pF/vKI4=; b=K
	tJq9seoM//6L6ugdDK3dw3Cc5I7BtPIp7F14LThOlsjOsVDR9y+3JX8vmcoPmHa6
	Tz0vDSJc84ekyg3Vi9/gWqhr8/fyP/5HU2VmHsIYo5/T0GM1enLeZQSyz8DKfpCO
	Ke60mLiLKMkixgxxKlq6jcX4w/mGApRDsN1A5e+oWBObltYljw/7N0WE3nOOv0Ry
	KvTmyd/zKo2GG5eJZVZf8Rbdw6AG4CbNx6fvnweeJQBDgyzj6qI9I32LnDL/D3gq
	qxrB0LPa9t3DlfB0g+iBvtCLiuNAnzgQT94CXO0qKwqUMtyEYgKXuPC7WaxPnsBr
	1J+zydocNZIxG8CnGnfEA==
X-ME-Sender: <xms:tZ6CamcbWFOCgIKps4bSiYXvq8SSlAErD7tsyyzgUQF5WNOcxcPIFQ>
    <xme:tZ6CamPUqRI_EFW0oYudFtQXoDIxZQrmWF9gQBkQqeHCwdhhoEparn4bb3ck2TPmd
    q7rOlvT_chnvJxUsToXyV7MpariSkNlU4jbTMkT9aiMqK4Fvv6aaQ>
X-ME-Received: <xmr:tZ6CalJWrWC28FS2wPqIKC70U0Y4lVejTzVCrmPFR7lshVHV0ZBw6E-_RZqb_ssUzBs7EdnhWzdcpe86KKLXs54R0Z-9rDNeLauyw7Q6CQ>
X-ME-Proxy-Cause: dmFkZTEAlT7DZKz578srq5GcS9IxSABbEf8k0j0dk9XmK8v56n+hOtlXesDJvWb0JfgPCm
    5Ys3LDf3/N3ZnprDBpKeWyeCdYyPseuY+CfmRxWo/w2Hp4LPdV8ccaEeWazvOQVxJnLxo0
    wB8t2nD08V/njJ14JBU55+CK+uw875MLfa7fa2RUMXZ2+grfzZ6MS+ODf7hPvvNAW3R2BU
    GSghIYBjO6e+en3+a0Z753nJbB78yTwx49j6t3qeWlPXniNRwJ5fxcF2GBMOcTaIGLiB4r
    6F0W770E4qRP15oVEbDVasIpst4ZzyOvW8/2vXqBrFxx6MhPz8W4tqXr1hF8Gk/G4/ymHV
    fPYhhP3lmDoXdbmdyz9vrzJ86J10Q5rwtPJjvEKyeDLjpOi1X8mXoV5zeFRb0yktoQpo2+
    cRd7ztx9yinoyj6T24War6tZWTnA4YWWzsEea8H3/83B3hxITmrQ9FSpe/Ww1l4xDuWFF+
    h4DX9thTkADRh6aPilCT11vPruVUabbuJE7IXQZUqhUI+lESpudGD3jNUHA1jJprWnzn4T
    3j9diIqTQ+npbJIMwWggcQXqQGqsD213A9Uto+A+oLLvJmhe5fKcSeHH4yYTr8/XfemAkw
    CW724P1bU3HVifDUsCcrh9PW/5LnasHe9HW+rwJZTQoY+rxzS5d8qu7Rgq9w
X-ME-Proxy: <xmx:tZ6CavG1zbx5eBgF1fdGnc__wv45X3VUTLAOON6M5W6UHeT9Vr8rtg>
    <xmx:tZ6CalR7_9ZIV--cgYZb1po4O9Vvg8hlzN7rfBIOh7H1NRTBbyDjSA>
    <xmx:tZ6CajHmnDr9-gUTSbWQx-zRRKiuwaawSvz666uUU22XX48b4QfLeQ>
    <xmx:tZ6Cap-7XnoXYByS-_MJY1B7Zr9wHJt1VMfTf2xBpoC9ZJbyIWvZoQ>
    <xmx:tZ6Cah3pOSzP5_mOwDmFLNbaIv8L6PfRPiZyQL_Whkard7npgkurwKqw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 01:40:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0647ba92 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Aug 2026 05:40:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 17 Aug 2026 07:39:47 +0200
Subject: [PATCH v2 6/6] bundle: generate packfiles via the object database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-b4-pks-odb-generate-pack-v2-6-4c8a96ccfdb3@pks.im>
References: <20260817-b4-pks-odb-generate-pack-v2-0-4c8a96ccfdb3@pks.im>
In-Reply-To: <20260817-b4-pks-odb-generate-pack-v2-0-4c8a96ccfdb3@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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
 builtin/bundle.c | 10 +-------
 bundle.c         | 69 ++++++++++++++++++++++++++++----------------------------
 bundle.h         |  3 +--
 3 files changed, 37 insertions(+), 45 deletions(-)

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
index a9330bf0d3..f55a521b2a 100644
--- a/bundle.c
+++ b/bundle.c
@@ -332,51 +332,52 @@ static int is_tag_in_date_range(struct repository *repo,
 
 
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
-		write_or_die(pack_objects.in, oid_to_hex(&object->oid),
-			     revs->repo->hash_algo->hexsz);
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
+	if (odb_generate_pack(revs->repo->objects, &generator, &opts)) {
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
@@ -485,7 +486,7 @@ static void write_bundle_prerequisites(struct commit *commit, void *data)
 }
 
 int create_bundle(struct repository *r, const char *path,
-		  int argc, const char **argv, struct strvec *pack_options, int version)
+		  int argc, const char **argv, int version, int progress)
 {
 	struct lock_file lock = LOCK_INIT;
 	int bundle_fd = -1;
@@ -594,7 +595,7 @@ int create_bundle(struct repository *r, const char *path,
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
2.55.0.739.g4f2b995119.dirty

