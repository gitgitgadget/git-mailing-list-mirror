Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E82329E44
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538686; cv=none; b=AXtENWrETXmS7xewSRH0nGnIuKyzPux254yPisL4MQunwfAU7Pb1bYxKm+DYcD5hK3yQxVJCEnqpzHN3HtfECpl4+JUHLlKy3iFU773HMnAPM4YAToVfLSULsoh27n3S4a8643xadjmVjfDNA3yeNrEK1wIaOJ8kTZvahS3hVnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538686; c=relaxed/simple;
	bh=ATP3W9/Q9cfFsnwo0CWOSAnacJbNGqgQ4iT0b715tmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LsfaSeJFWGWef16crfJV6SzXTOmesm6sbVWTFc2LV/HahsMcewSnUMXIAZ3Hg1+n2b56hCXKclJif/FubG6cHpD2reT9cBXABGl7FEdN9YkAO1LM4p+jCyITiY5vbNUzRBHKdvYtvm+iDCvs0OOUNpkIu26p8en3b1q539juxRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MnZpEl4x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kl4lJYFM; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MnZpEl4x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kl4lJYFM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6FEAA140017D
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:51:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 19 Nov 2025 02:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538683;
	 x=1763625083; bh=7/W5vh1XgWkWSgrjxkY4VmYmq8Y1eOK2sdYqP+OJwQU=; b=
	MnZpEl4x91Ey84AUIr34QnRqv07qIETrCEHZkuuqTSF1adG2ICGYXVYtGJrnNzDL
	nbB6hRV3/J+0N52/I2yB1cV+90hBe7VIxoP/pL2P4upXgSvErwOX6gL2iFWyiNA/
	kI+qwTZjkRQHq21Mhdc3Z96e3hfmL+KauftG3j5MfszL5dgd9idIqw/82OAus3FR
	GUkklJ9lCf9LzBGwOgEEzbs9zoMM8+5GhQMKz+eNSdKUtceuh5LpSJPRD4k4PNl4
	9DIj3h5i3ob+l+MnuHlKTxqaguN94cVi2EW7ln5HBpkOS6NlaX1+R/RzvqYwBR58
	74RSbNOIlaMBh2Bd2QBKKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538683; x=
	1763625083; bh=7/W5vh1XgWkWSgrjxkY4VmYmq8Y1eOK2sdYqP+OJwQU=; b=k
	l4lJYFMnSw5d1vkx/FEKX8NgUv8MhjqEQx4DVl2i4j9zHCdz+lI4Lcheei1fI5mB
	w8+RfeMl106b/i/CWpBjcF/9huKA9Tr1IOAcUV3nCbZLJZ4X7Fu0EooFFsGFtNCm
	SCTBZnZI1w0mps9l9A+Z2+T4s7DNTYdq59nuRTSlvrgMz6Mylxz16YyQHelboAZo
	LynClMcy8Wr4nBDN/PPLPAEy+b5bY/HhF3/8y/aX+Tv1u2GDgsGM0hclzQm3UolY
	LlL3XMTgngqtavzRhkgZ5PBxWOPE+HI3708DL0daz6VLqIOGQwBlIUg27Qn5HHYN
	gU0dNRGy6q4pubaTeu7BA==
X-ME-Sender: <xms:-3YdaeiGkYx17NFmL0HsqJRaQCJ3cWOzmOUKR8pgbzTd5JryuL76Zg>
    <xme:-3YdaV_1qs109AH7wTSkCR3oJjGLNoPMT4hJyXweccScznHsvT5bIEDEdjTsDu-lL
    kPFhU7zkKTpYEivK8sUClmx6Ngt_q0dE3GR8mJMPB7KefeqO6IWow>
X-ME-Received: <xmr:-3Ydabs-9Dv-r68_xAW_Xxr1Pu5vIRL1XhqNYreWlpZmBSkWsBvXsUJSqPeYFzsss2-EfOZc5rrm5vTpIiSBblhGcTUbAbEWlsfvyWaogQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:-3YdacY4NF6QdXmtXC4Ca_WGcLoToIMDw-11ost-4ivnM7skM4dvgw>
    <xmx:-3YdaboF67IjUkDUreoyMb7bCvTIDbowNE1oxhlFTTfkUCdJ5uC1EA>
    <xmx:-3YdaR95WaoxL9obMKXqstzlPvx3WUggyjYiKDYIxzvdzhN7Le37qQ>
    <xmx:-3Ydaa91fYSt39EcfRI-4Vo3VQlJpYaY5gUN2R3hyeyi5ivQe3sSFg>
    <xmx:-3YdabhFYK9mB7k6lT_jD0Oty3qa3k7wN89mHRpeG_ytK1fjfqyhoXew>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:51:22 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2877b9b4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:51:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:50:55 +0100
Subject: [PATCH 07/13] builtin/index-pack: fix deferred fsck outside repos
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-creation-v1-7-2b2ed2612cb6@pks.im>
References: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
In-Reply-To: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

When asked to perform object consistency checks via the `--fsck-objects`
flag we verify that each object part of the pack is valid. In general,
this check can even be performed outside of a Git repository: we don't
need an initialized object database as we simply read the object from
the packfile directly.

But there's one exception: a subset of the object checks may be deferred
to a later point in time. For now, this only concerns ".gitmodules" and
".gitattributes" files: whenever we see a tree referencing these files
we queue them for a deferred check. This is done because we need to do
some extra checks for those files to ensure that they are well-formed,
and these checks need to be done regardless of whether the corresponding
blobs are part of the packfile or not.

This works inside a repository, but unfortunately the logic leads to a
segfault when running outside of one. This is because we eventually call
`odb_read_object()`, which will crash because the object database has
not been initialized.

There's multiple options here:

  - We could in theory create a purely in-memory database with only a
    packfile store that contains the single packfile. We don't really
    have the infrastructure for this yet though, and it would end up
    being quite hacky.

  - We could refuse to perform consistency checks outside of a
    repository. But most of the checks work alright, so this would be a
    regression.

  - We can skip the finalizing consistency checks when running outside
    of a repository. This is not as invasive as skipping all checks,
    but it's not great to randomly skip a subset of tests, either.

None of these options really feel perfect. The first one would be the
obvious choice if easily possible.

There's another option though: instead of skipping the final object
checks, we can die if there are any queued object checks. With this
change we now die exactly if and only if we would have previously
segfaulted. Like this we ensure that objects that _may_ fail the
consistency checks won't be silently skipped, and at the same time we
give users a much better error message.

Refactor the code accordingly and add a test that would have triggered
the segfault. Note that we also move down the logic to add the packfile
to the store. There is no point doing this any earlier than right before
we execute `fsck_finish()`, and it ensures that the logic to set up and
perform the consistency check is self-contained.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/index-pack.c  | 21 ++++++++++++++++++---
 fsck.c                |  6 ++++++
 fsck.h                |  7 +++++++
 t/t5302-pack-index.sh | 16 ++++++++++++++++
 4 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 2b78ba7fe4..699fe678cd 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1640,7 +1640,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 	rename_tmp_packfile(&final_index_name, curr_index_name, &index_name,
 			    hash, "idx", 1);
 
-	if (do_fsck_object)
+	if (do_fsck_object && startup_info->have_repository)
 		packfile_store_load_pack(the_repository->objects->packfiles,
 					 final_index_name, 0);
 
@@ -2110,8 +2110,23 @@ int cmd_index_pack(int argc,
 	else
 		close(input_fd);
 
-	if (do_fsck_object && fsck_finish(&fsck_options))
-		die(_("fsck error in pack objects"));
+	if (do_fsck_object) {
+		/*
+		 * We cannot perform queued consistency checks when running
+		 * outside of a repository because those require us to read
+		 * from the object database, which is uninitialized.
+		 *
+		 * TODO: we may eventually set up an in-memory object database,
+		 * which would allow us to perform these queued checks.
+		 */
+		if (!startup_info->have_repository &&
+		    fsck_has_queued_checks(&fsck_options))
+			die(_("cannot perform queued object checks outside "
+			      "of a repository"));
+
+		if (fsck_finish(&fsck_options))
+			die(_("fsck error in pack objects"));
+	}
 
 	free(opts.anomaly);
 	free(objects);
diff --git a/fsck.c b/fsck.c
index 341e100d24..8e1565fe6d 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1350,6 +1350,12 @@ int fsck_finish(struct fsck_options *options)
 	return ret;
 }
 
+bool fsck_has_queued_checks(struct fsck_options *options)
+{
+	return !oidset_equal(&options->gitmodules_found, &options->gitmodules_done) ||
+	       !oidset_equal(&options->gitattributes_found, &options->gitattributes_done);
+}
+
 void fsck_options_clear(struct fsck_options *options)
 {
 	free(options->msg_type);
diff --git a/fsck.h b/fsck.h
index cb6ef32f4f..336917c045 100644
--- a/fsck.h
+++ b/fsck.h
@@ -248,6 +248,13 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
  */
 int fsck_finish(struct fsck_options *options);
 
+/*
+ * Check whether there are any checks that have been queued up and that still
+ * need to be run. Returns `false` iff `fsck_finish()` wouldn't perform any
+ * actions, `true` otherwise.
+ */
+bool fsck_has_queued_checks(struct fsck_options *options);
+
 /*
  * Clear the fsck_options struct, freeing any allocated memory.
  */
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 413c99274c..9697448cb2 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -293,4 +293,20 @@ test_expect_success 'too-large packs report the breach' '
 	grep "maximum allowed size (20 bytes)" err
 '
 
+# git-index-pack(1) uses the default hash algorithm outside of the repository,
+# and it has no way to tell it otherwise. So we can only run this test with the
+# default hash algorithm, as it would otherwise fail to parse the tree.
+test_expect_success DEFAULT_HASH_ALGORITHM 'index-pack --fsck-objects outside of a repo' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		printf "100644 blob $(test_oid 001)\t.gitattributes\n" >tree &&
+		git mktree --missing <tree >tree-oid &&
+		git pack-objects <tree-oid pack &&
+		test_must_fail nongit git index-pack --fsck-objects "$(pwd)"/pack-*.pack 2>err &&
+		test_grep "cannot perform queued object checks outside of a repository" err
+	)
+'
+
 test_done

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

