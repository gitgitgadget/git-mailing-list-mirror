Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E299E42FCD9
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099551; cv=none; b=pbq7cXbrRh3L+vswTcdouf4HR3JSoQtpuH2sqtwGtVSj/O6QEdhBxNMRBLHcpO3ghZGSqcz8Nxk0dz6s+/IIlRJGlNGzaatJUcxKSENe6Hht+x/u6rAf3OM3Mf0q1bd8Il7qdeRrGIKNOnYMUnR1lXgLAl3jy2lQNLOL2XUYrE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099551; c=relaxed/simple;
	bh=w6P3qMxwMZdhWymGVzh4p3kDuZsmaMUeCVgn1XZYPKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c/0/t1Bzt9E7qIjoEl+DYCVuVe4i8TcItgKlRI/MzTwFtTtR3HkqVJvPiHNNjcl6WDSjJt0klSHKALVljV7chZyzYcgDe96JbLakSJxAbl9+0aIIewIvAqq9BihDQB2DKhkyz9IEjYxuyMhr6QnBiVCL31nf4Buc36piZfP5lO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W5N/n7Lq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mlo8buXU; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W5N/n7Lq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mlo8buXU"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F114214000F0
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 06:45:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 07 Aug 2026 06:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786099548;
	 x=1786185948; bh=zRe5hTm8DccdxxBmleRDOZ7Av49nF4w/cpdV/cGdVYY=; b=
	W5N/n7Lq7qVBTx0MASxHW79USqPkPWQpyW5q1DF+8D2+/pYZA/zkL3htkFaPAHXc
	fBjnFLf9KIp2x8VkCCA6KGW+37XFXhlQC1yJD2unYt/q6eCbJB+FnezhmVF7rEfp
	PtSZ+IT+Rq8pdZDLls9kwS+xoOEbCXkqINZ74IUB4CLwCfD+v7lzAQI1vMUbAYNJ
	AaltO6AKauywed6dIAJC9yD+iaKKTkx21yaB5Rtoctfu61uO0evNxczRQa4hyGEi
	avNrPkQIH2BF9e+IDLiNf/zh+GnpIdzidOGV2oGYiE3S+quYsB0dwrv1v52SPKmv
	8uRCNKVWMRxsEGKsa7n3mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786099548; x=
	1786185948; bh=zRe5hTm8DccdxxBmleRDOZ7Av49nF4w/cpdV/cGdVYY=; b=M
	lo8buXUTO8PrvScJcOHtF3kTAoRrs0ueOiOenCuAZ13ND8ra3t86CFNXNrl0QMOj
	b3EOD8tjP/ZNVj3omjNLgVMTVaub8VzCGU5KFg2TaidgEmO3Gd7lWQcO1h3lvocU
	woAlwgvvD3IkJCefGCdSHjJTrqHmy5Qv5IoRKNo9ezxOGA+2aTb5jTgQYXb4x0NS
	qnyK2+1O7YtQR95AINvlXdrUnY8mfnfz/QBtKEGqLts2ZvOiOaZPT7v1hwV6Roc1
	uqTTn9sKWp5HnTFbqYwb6wRqhB8VKC+vCfukJkW+TmmxXoGIvUd6sDu9WtEr+FHb
	r2N5/Xufg3KsHgUcvVm5A==
X-ME-Sender: <xms:XLd1aiEJEYN7TW0ax7DwpzD6Ijl-J2VZSrPUd7ZLbPXPn5fUY6hxzA>
    <xme:XLd1aqSdgMsIGSU8a9o7sT5mjL2iihSxwazD3mUWuMxNT8wxr1VSQ5ulut1HiPdaK
    x9bcSxR_xlLUV6363SOhlSxnTlrZOcs7fRTvX0o5dNMsf-kCQjvkys>
X-ME-Received: <xmr:XLd1ahzitjoGE6_WTSFy5r7n0oyyc4oaE_gCgGAl6I8uYzoRRQWknTAdTyQuo4-RXfoTUJ4rEmDd9Nl71K4i5BnPNGGvKFSa61cYnEWN1w8mLA>
X-ME-Proxy-Cause: dmFkZTETVxw3Bcg6HeXu0uMfrLYqHnY7tqzmbOOVidG8xgwzVy7Oo4PMXAnxSE+PVmv2EN
    R2ae68kliEJ1fAgerVUCtl7aO5JSaiSDt2C3epBGDhlAlgGT/UHB10Ajl77NzDLyHp4KA1
    dqc5XLjh6HM5cwCRHmrY466Qw6dww8P+Cj9qpqMxACEJryL21hZo+QhwDy/ARveUbLX85X
    UySXQOJV60MoyAKJFFEduVFw9Qh86c+oHIw+iP908awxd6bYb0jqLashzG9Vv3Mvv5esQH
    2cYa/8jSPbpYu0pMXhiAloBW8ovsTe8jyeuGz67IDckcpsq6YnHBzaGwgPJr78TttyhfF3
    80zHNFNMEkqyKhQjz4MPiU4YDK+qQeT9p9DeNGZSXO/+IrwVc+GPNKMWWn7ns/qEv0L3DM
    u7mtY9TX/+zu8VXeCz5ARjeG0U1dcMnzYHXHXQ8Eb697cAULFKfTtQcgBZjUBeNxaTjfUA
    IDbDRb3TBO9R//kCdMNKEoycJUmbqGJLodqoupoXXxQKkLEb9N4TeFbNmRpkEr0vXniDf4
    3uXzwW0WLCx6zcFBtO2DTnyxGKMYDIQQz1RqMHb6alvPYKgngIKYAi3YnnCZaP+3FpEDFG
    IIzMQwWjo7y//S1FE/tqHa2b6PEid9qP1maHoor4QS1K6UXIrm1Z+ssQRsaw
X-ME-Proxy: <xmx:XLd1ahPvSHEESJq-6ym1eQYmw0MNIjEK3vUPY0j-4qxf8WX2EXH3Aw>
    <xmx:XLd1aoPSgUM9RdVVODWorkQJo6D2vmyZ2jD6qP5m58DvZf6uLEJCBA>
    <xmx:XLd1arRA1811QNEHHSuggKjalnqq-ZIfrNkjz6nabiJK9MJs5VgNWw>
    <xmx:XLd1aiBOt9XqqVDB7Tbo_WYHBi03JC-HOreBJFgHDSh3c5jb5seqLQ>
    <xmx:XLd1akUp8yt_z2EpNOpu0YO-yAaH0JTud5-9o3IMDu_8ZX9lAqeiLLFA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 7 Aug 2026 06:45:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 161343f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 7 Aug 2026 10:45:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Aug 2026 12:45:09 +0200
Subject: [PATCH 3/5] send-pack: generate packfiles via the object database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-b4-pks-odb-generate-pack-v1-3-7dec431ae7cd@pks.im>
References: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>
In-Reply-To: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When pushing, git-send-pack(1) spawns git-pack-objects(1) directly to
generate the packfile that gets sent to the remote. Same as with
git-upload-pack(1), which has been adapted in the preceding commit,
this hard-codes the assumption that objects can be packed via
git-pack-objects(1), which is specific to the "files" backend.

Convert git-send-pack(1) to use the pack generation interface of the
object database instead.

Note that this requires us to adapt t5516 because the parameters passed
to git-pack-objects(1) are changing:

  - The order of arguments changes.

  - We pass "--quiet" instead of "-q".

  - We don't pass "--all-progress-implied" anymore when not generating
    output.

All of these changes are benign though and should not result in a change
in behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 send-pack.c           | 101 +++++++++++++++++---------------------------------
 t/t5516-fetch-push.sh |  12 +++---
 2 files changed, 40 insertions(+), 73 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 3bb5afc687..f20460fbf4 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -42,16 +42,17 @@ int option_parse_push_signed(const struct option *opt,
 	die("bad %s argument: %s", opt->long_name, arg);
 }
 
-static void feed_object(struct repository *r,
-			const struct object_id *oid, FILE *fh, int negative)
+static void append_negative_object(struct repository *r,
+				   struct oid_array *haves,
+				   const struct object_id *oid)
 {
-	if (negative && !odb_has_object(r->objects, oid, 0))
+	/*
+	 * The remote end may have advertised objects that we do not have in
+	 * our object database. Skip those, as we cannot use them as boundary.
+	 */
+	if (!odb_has_object(r->objects, oid, 0))
 		return;
-
-	if (negative)
-		putc('^', fh);
-	fputs(oid_to_hex(oid), fh);
-	putc('\n', fh);
+	oid_array_append(haves, oid);
 }
 
 /*
@@ -62,92 +63,58 @@ static int pack_objects(struct repository *r,
 			struct oid_array *negotiated,
 			struct send_pack_args *args)
 {
-	/*
-	 * The child becomes pack-objects --revs; we feed
-	 * the revision parameters to it via its stdin and
-	 * let its stdout go back to the other end.
-	 */
-	struct child_process po = CHILD_PROCESS_INIT;
-	FILE *po_in;
+	struct odb_generate_pack_options opts = ODB_GENERATE_PACK_OPTIONS_INIT;
+	struct odb_pack_generator *generator;
 	int rc;
 
 	trace2_region_enter("send_pack", "pack_objects", r);
-	strvec_push(&po.args, "pack-objects");
-	strvec_push(&po.args, "--all-progress-implied");
-	strvec_push(&po.args, "--revs");
-	strvec_push(&po.args, "--stdout");
-	if (args->use_thin_pack)
-		strvec_push(&po.args, "--thin");
-	if (args->use_ofs_delta)
-		strvec_push(&po.args, "--delta-base-offset");
-	if (args->quiet || !args->progress)
-		strvec_push(&po.args, "-q");
+
+	opts.thin = args->use_thin_pack;
+	opts.ofs_delta = args->use_ofs_delta;
 	if (args->progress)
-		strvec_push(&po.args, "--progress");
-	if (is_repository_shallow(r))
-		strvec_push(&po.args, "--shallow");
-	if (args->disable_bitmaps)
-		strvec_push(&po.args, "--no-use-bitmap-index");
-	po.in = -1;
-	po.out = args->stateless_rpc ? -1 : fd;
-	po.git_cmd = 1;
-	po.clean_on_exit = 1;
-	if (start_command(&po))
-		die_errno("git pack-objects failed");
+		opts.progress = ODB_GENERATE_PACK_PROGRESS_VERBOSE;
+	opts.shallow = is_repository_shallow(r);
+	opts.disable_bitmaps = args->disable_bitmaps;
 
 	/*
-	 * We feed the pack-objects we just spawned with revision
-	 * parameters by writing to the pipe.
+	 * The pack is either written directly to the remote's descriptor, or,
+	 * in the case of a stateless RPC, read back from a pipe so that we
+	 * can wrap the pack data into pkt-lines.
 	 */
-	po_in = xfdopen(po.in, "w");
+	opts.pack_fd = args->stateless_rpc ? -1 : fd;
+
 	for (size_t i = 0; i < advertised->nr; i++)
-		feed_object(r, &advertised->oid[i], po_in, 1);
+		append_negative_object(r, &opts.haves, &advertised->oid[i]);
 	for (size_t i = 0; i < negotiated->nr; i++)
-		feed_object(r, &negotiated->oid[i], po_in, 1);
+		append_negative_object(r, &opts.haves, &negotiated->oid[i]);
 
 	while (refs) {
 		if (!is_null_oid(&refs->old_oid))
-			feed_object(r, &refs->old_oid, po_in, 1);
+			append_negative_object(r, &opts.haves, &refs->old_oid);
 		if (!is_null_oid(&refs->new_oid))
-			feed_object(r, &refs->new_oid, po_in, 0);
+			oid_array_append(&opts.wants, &refs->new_oid);
 		refs = refs->next;
 	}
 
-	fflush(po_in);
-	if (ferror(po_in))
-		die_errno("error writing to pack-objects");
-	fclose(po_in);
+	if (odb_generate_pack(r->objects, &generator, &opts))
+		die("git pack-objects failed");
+	odb_generate_pack_options_release(&opts);
 
 	if (args->stateless_rpc) {
 		char *buf = xmalloc(LARGE_PACKET_MAX);
 		while (1) {
-			ssize_t n = xread(po.out, buf, LARGE_PACKET_MAX);
+			ssize_t n = xread(generator->out, buf, LARGE_PACKET_MAX);
 			if (n <= 0)
 				break;
 			send_sideband(fd, -1, buf, n, LARGE_PACKET_MAX);
 		}
 		free(buf);
-		close(po.out);
-		po.out = -1;
+		close(generator->out);
 	}
 
-	rc = finish_command(&po);
-	if (rc) {
-		/*
-		 * For a normal non-zero exit, we assume pack-objects wrote
-		 * something useful to stderr. For death by signal, though,
-		 * we should mention it to the user. The exception is SIGPIPE
-		 * (141), because that's a normal occurrence if the remote end
-		 * hangs up (and we'll report that by trying to read the unpack
-		 * status).
-		 */
-		if (rc > 128 && rc != 141)
-			error("pack-objects died of signal %d", rc - 128);
-		trace2_region_leave("send_pack", "pack_objects", r);
-		return -1;
-	}
+	rc = odb_pack_generator_finish(generator);
 	trace2_region_leave("send_pack", "pack_objects", r);
-	return 0;
+	return rc;
 }
 
 static int receive_unpack_status(struct packet_reader *reader)
@@ -768,7 +735,7 @@ int send_pack(struct repository *r,
 			goto out;
 		}
 		if (!args->stateless_rpc)
-			/* Closed by pack_objects() via start_command() */
+			/* Consumed by the pack generator in pack_objects() */
 			fd[1] = -1;
 	}
 	if (args->stateless_rpc && cmds_sent)
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index f3b3efc47f..b982b209bf 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1903,20 +1903,20 @@ test_expect_success 'push with config push.useBitmaps' '
 	test_unconfig push.useBitmaps &&
 	GIT_TRACE2_EVENT="$PWD/default" \
 	git push --quiet testrepo main:test &&
-	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
-		--thin --delta-base-offset -q <default &&
+	test_subcommand git pack-objects --revs --stdout --thin \
+		--delta-base-offset --quiet <default &&
 
 	test_config push.useBitmaps true &&
 	GIT_TRACE2_EVENT="$PWD/true" \
 	git push --quiet testrepo main:test2 &&
-	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
-		--thin --delta-base-offset -q <true &&
+	test_subcommand git pack-objects --revs --stdout --thin \
+		--delta-base-offset --quiet <true &&
 
 	test_config push.useBitmaps false &&
 	GIT_TRACE2_EVENT="$PWD/false" \
 	git push --quiet testrepo main:test3 &&
-	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
-		--thin --delta-base-offset -q --no-use-bitmap-index <false
+	test_subcommand git pack-objects --revs --stdout --thin \
+		--delta-base-offset --no-use-bitmap-index --quiet <false
 '
 
 test_expect_success 'push with config pack.usePathWalk=true' '

-- 
2.55.0.679.g6767b8d81c.dirty

