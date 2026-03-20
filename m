Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394D63AA517
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007270; cv=none; b=gZ9plbQOyGNLgyu6GNy/pcgq720/ZlTaUFciiWEeEltgrispbUd0Wd+QwccLAIpJjaY6YDBv5B5hm9EiPEo8vxrfiJw72w9hNW6SJsqse8EAOaNQeRBE0us4buCvQzFPke6BG5qt1ycyE7AYEvRtVGovvAad2y3fO61cGqJVKlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007270; c=relaxed/simple;
	bh=QZWPdfB/i4/PRAb0vxl8b6QQrPRINKWm4pJoSatgcw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OXYGUsD7UWKXByvjxlSp7fac19MG+D1NXkmXgZkYQEtIUj5BvhrByizF25l5tw5Uu7kEI5CFfNovbQfvIW/DhTDMZhQGlVgIJq3qW+w0gjzv8VTmRkO2m8KYqhSn6QAhfrz2XQVTOrb+c6JIoX85AAADlbaDWy0Bg8003HaRA0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JUDH/xib; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sS+HhTgU; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JUDH/xib";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sS+HhTgU"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6A4731400176
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:47:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 20 Mar 2026 07:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774007268;
	 x=1774093668; bh=7fJUBAQ5ZRhh+KOst/2Xv92FA4sjpM0Ow4qa8JaMPLI=; b=
	JUDH/xib+xdgoRAQyDCnQEFr31dqIbtm6PcsD9/m/Ogs/AoIcNtzGGL6NJZF5eIa
	lvWOvbRqM6VuFGlR+v7bJwqHrVgQC+JRZkbmja8viMmyIKWEfdUq64ZfA4Nu61ks
	x9d14bpSzo+5naCAuw8rSIzPooWFChirYaWE+E1oSaMaLdCcgLf9SJjUgbGJO5aH
	MR/3SKZqGMwYUCudEVHvtWCg+OVZzEGPWrjZWs7y3UjweFRt1VHJzsfw1xLjJIPH
	ChTmNEkeoUi/Fcaf67A2u2bojo/lRDhlWAabagduwh5VKyyF8hVNdyEfUBFAuf65
	2q4vW1LBZniJxKIVkVJbqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774007268; x=
	1774093668; bh=7fJUBAQ5ZRhh+KOst/2Xv92FA4sjpM0Ow4qa8JaMPLI=; b=s
	S+HhTgUGS60BJJNZwX246Y0uhLAUbs9R2JPqNABqQ0iYG5v2KizERSKTlSaY8vfR
	X9/GPmzZVwccee0PmGq2TnOz5BSHm3UMAivHPraWDcpmNfFmbhqWG4m+r4G8DQYi
	KwHXnLnNek9fh05GPDZN2uh2+c1oL+lcW9ZG8qs6+xix+Qrbf1ofHjlQhMpS5FFi
	jWPabFC2WjClUYmJXs0y+LbW0mMQop17dI41ZrJ0/TyYNcWI1u6RwajxgtBQ9gxx
	l8FZY5+YTQeEwRsb/p5XCIxJnhFSDM+eNvUTvO+M+/gfPqfcX73XFurKzBaZW269
	nq721UgeBGXQEfCgcEcSA==
X-ME-Sender: <xms:5DO9aQWvqMo0jpp0hxi7QXYcYQbLbcQZfaKRyjuJJ1PJgpmb6fen5w>
    <xme:5DO9abgXTSzJo9O3fINcHKTs7Wm8fKOhg4mPhicaiMb5IDKQI_w_E2M12i2cfukKx
    dYqJ5EmSr-zOGxMUVmTI3yINuA0rGQR9HHuJTNdvaAQAmycDJp_Iw>
X-ME-Received: <xmr:5DO9aaDU5Al0c2RTh9lUQtYJlUJ1xp07vsbtsSh_1mSQb_ovt8b7kB85Se84LqM8x6-djFf14_Z4DqkAqPPDp1YblbNMYmKTcoCs8ZGx42FZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:5DO9aUfJa_l8QgBZEg36hH7UrZEoPtQTv_2JPuBZL2GTC1aquxpWJw>
    <xmx:5DO9aadyU8oUVNcU6DpXJJfpDAaYYAxQDIT70Okod81h5K0FuT68bw>
    <xmx:5DO9aQjIKGSfcsJ_RKwrg6NaO6BtVZ2_hzQ-SS_JNbcol3Nz3wgY3g>
    <xmx:5DO9aeRkc686WFigsCxtuqpB8ONRb6AxJd4UQ6TqMPHw_YEqhieXJw>
    <xmx:5DO9aXn4EGKhsICggzCHv--9VAKVOzPvAGwXOwVNQtXgmxjjRdlNx9r->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 20 Mar 2026 07:47:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 62957b38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 20 Mar 2026 11:47:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 12:47:07 +0100
Subject: [PATCH 02/14] fsck: drop `the_repository` in `fsck_finish()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-fsck-without-the-repository-v1-2-6594f997926b@pks.im>
References: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
In-Reply-To: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The function `fsck_finish()` and  its transitively called function
`fsck_blobs()` implicitly rely on `the_repository`. Remove this
dependency by injecting the repository as a parameter instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c           |  2 +-
 builtin/index-pack.c     |  2 +-
 builtin/unpack-objects.c |  2 +-
 fetch-pack.c             |  4 ++--
 fsck.c                   | 13 +++++++------
 fsck.h                   |  2 +-
 object-file.c            |  2 +-
 7 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 15477767c7..8f994010da 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1075,7 +1075,7 @@ int cmd_fsck(int argc,
 			stop_progress(&progress);
 		}
 
-		if (fsck_finish(&fsck_obj_options))
+		if (fsck_finish(the_repository, &fsck_obj_options))
 			errors_found |= ERROR_OBJECT;
 	}
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index a3d37d34cc..3d1f7dbd5f 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -2123,7 +2123,7 @@ int cmd_index_pack(int argc,
 			die(_("cannot perform queued object checks outside "
 			      "of a repository"));
 
-		if (fsck_finish(&fsck_options))
+		if (fsck_finish(the_repository, &fsck_options))
 			die(_("fsck error in pack objects"));
 	}
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 52b62ff6d4..9596b3ea4f 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -676,7 +676,7 @@ int cmd_unpack_objects(int argc,
 	git_hash_final_oid(&oid, &tmp_ctx);
 	if (strict) {
 		write_rest();
-		if (fsck_finish(&fsck_options))
+		if (fsck_finish(the_repository, &fsck_options))
 			die(_("fsck error in pack objects"));
 	}
 	if (!hasheq(fill(the_hash_algo->rawsz), oid.hash,
diff --git a/fetch-pack.c b/fetch-pack.c
index 6ecd468ef7..6fd534633d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1231,7 +1231,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	if (get_pack(args, fd, pack_lockfiles, NULL, sought, nr_sought,
 		     &fsck_options.gitmodules_found))
 		die(_("git fetch-pack: fetch failed."));
-	if (fsck_finish(&fsck_options))
+	if (fsck_finish(the_repository, &fsck_options))
 		die("fsck failed");
 
  all_done:
@@ -1876,7 +1876,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	string_list_clear(&packfile_uris, 0);
 	strvec_clear(&index_pack_args);
 
-	if (fsck_finish(&fsck_options))
+	if (fsck_finish(the_repository, &fsck_options))
 		die("fsck failed");
 
 	if (negotiator)
diff --git a/fsck.c b/fsck.c
index c6b6f533be..1f7d568acf 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1331,7 +1331,8 @@ int fsck_refs_error_function(struct fsck_options *options UNUSED,
 	return ret;
 }
 
-static int fsck_blobs(struct oidset *blobs_found, struct oidset *blobs_done,
+static int fsck_blobs(struct repository *repo,
+		      struct oidset *blobs_found, struct oidset *blobs_done,
 		      enum fsck_msg_id msg_missing, enum fsck_msg_id msg_type,
 		      struct fsck_options *options, const char *blob_type)
 {
@@ -1348,9 +1349,9 @@ static int fsck_blobs(struct oidset *blobs_found, struct oidset *blobs_done,
 		if (oidset_contains(blobs_done, oid))
 			continue;
 
-		buf = odb_read_object(the_repository->objects, oid, &type, &size);
+		buf = odb_read_object(repo->objects, oid, &type, &size);
 		if (!buf) {
-			if (is_promisor_object(the_repository, oid))
+			if (is_promisor_object(repo, oid))
 				continue;
 			ret |= report(options,
 				      oid, OBJ_BLOB, msg_missing,
@@ -1372,14 +1373,14 @@ static int fsck_blobs(struct oidset *blobs_found, struct oidset *blobs_done,
 	return ret;
 }
 
-int fsck_finish(struct fsck_options *options)
+int fsck_finish(struct repository *repo, struct fsck_options *options)
 {
 	int ret = 0;
 
-	ret |= fsck_blobs(&options->gitmodules_found, &options->gitmodules_done,
+	ret |= fsck_blobs(repo, &options->gitmodules_found, &options->gitmodules_done,
 			  FSCK_MSG_GITMODULES_MISSING, FSCK_MSG_GITMODULES_BLOB,
 			  options, ".gitmodules");
-	ret |= fsck_blobs(&options->gitattributes_found, &options->gitattributes_done,
+	ret |= fsck_blobs(repo, &options->gitattributes_found, &options->gitattributes_done,
 			  FSCK_MSG_GITATTRIBUTES_MISSING, FSCK_MSG_GITATTRIBUTES_BLOB,
 			  options, ".gitattributes");
 
diff --git a/fsck.h b/fsck.h
index 4bd54865fe..bfe9b3ffc9 100644
--- a/fsck.h
+++ b/fsck.h
@@ -255,7 +255,7 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
  * after completing all fsck_object() calls in order to resolve any remaining
  * checks.
  */
-int fsck_finish(struct fsck_options *options);
+int fsck_finish(struct repository *repo, struct fsck_options *options);
 
 /*
  * Check whether there are any checks that have been queued up and that still
diff --git a/object-file.c b/object-file.c
index c62e5496e0..ecbcc501dd 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1285,7 +1285,7 @@ static int index_mem(struct index_state *istate,
 		opts.error_func = hash_format_check_report;
 		if (fsck_buffer(null_oid(istate->repo->hash_algo), type, buf, size, &opts))
 			die(_("refusing to create malformed object"));
-		fsck_finish(&opts);
+		fsck_finish(the_repository, &opts);
 	}
 
 	if (write_object)

-- 
2.53.0.1055.ga2ffed1127.dirty

