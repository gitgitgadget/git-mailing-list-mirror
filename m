Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310AF3B7B71
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 07:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787212546; cv=none; b=oseh3Lnac9HdiLlh37T5I697eG9+apwAsvEmzw6+2NgDjcq4F75nfzk2vdYYkfnLRkREWtjpSg6PSd5g5Hl8rS0JdtgNADCMQ5vF0ogC/9B6EHDrjR8BGAtb4iUym4DuUBtrGtDrNmAva7pzv7TovNI19E+pDMXrUBv9F40uwTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787212546; c=relaxed/simple;
	bh=3NzOC9PBzCf98mgEU+OeT09IcmLPjJ6i6RRpFujOcSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GlhJB3YM7ttuChrPUzH39usec5hhStpI0DRci5Kha4e0kKEWLXYGSY2oK2LALXtUsN3gaSTC0TosnqBZlhzgmzye3AhXlJrFSvoTDZbANnytIAhdO+Rp3G5GHrF5joYk1VVz3FfH7lxUxHVNjvhfWpszRS/Pmz5sZhuh47nEesY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jc3+s6q8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DNmlFDAc; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jc3+s6q8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DNmlFDAc"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 540B01400112;
	Thu, 20 Aug 2026 03:55:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 20 Aug 2026 03:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787212544;
	 x=1787298944; bh=pGSZFHCO45eUjb8iFv+AdJycFW47JQqJo4YyGPRgW/0=; b=
	jc3+s6q8UW4cq6tFy/DuQgcVC/gRpMl27I5Pf6gkVJulvVkL8pVDYremtTyMDxM7
	VHxPvv/FwszqSy34oj0tHi5rm6S/DC4gj4PBnT/9TYv+bQulYDYdnjXAK0nHw+fZ
	TcF9dUSynFkCjPx3IOUGqyQBW0t9ngil6BgKPKO5SyVRlleG24/wajQdxJZTW4mG
	0jx58vckpJ7v3g/c8M0EN1d8vHBAt/q8qA3YPyhsSYPovBK7bfrnY6vh6bRuOyRq
	uW8KWAv0T0qdAwbuPCt0CtIHIKANpTdJki+QtGIdVwrbrsHoALsH1uzHoNSmiWCf
	rP4lkQdeT5auSkSF3aIehw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787212544; x=
	1787298944; bh=pGSZFHCO45eUjb8iFv+AdJycFW47JQqJo4YyGPRgW/0=; b=D
	NmlFDAcMQ30NwB4n6pTIssYAwcODLWizNn1+9Eg8quFVc6aZC66WjFDR2GBiSI5T
	yqSR5rpDgcAqqMWP9lytcl6A1ysLRBn71V+hZd8tf1Di3wSgzdXkXv6lgyrUOCHZ
	Jzr5R0Fu1KIlDHQ0q9iBOoPLBqXtoJtCEiCii2RslVVPRkhLl5w9cvbr5aq1fJYU
	VBOQGYl8yA2rIjAHs68Wdt7RYIJseFrIMtbs9iYD38ihkJeI+etS4o27wtqHiMq5
	uknI6k1ZVBPWRSR8htm7laRk7Mmzi2SKEbCZhNvXlW7lfWspVN5479fOojtY1FvC
	QlOTdyib+G6TWw5+FqM3A==
X-ME-Sender: <xms:ALOGavUAzaD4BOB42x-hudbwDABIU8C58nDojHgbhz1wGX_CWmdecQ>
    <xme:ALOGaulGMGHsJbU2LY1Ft67HjEqbWtkRnuttR-dbRK0ElFYIsXvPoxD386-jCofnz
    wWs1efDVzwB-8D99V-mzBk-c7GJT1JEwHNCp7HMMN878F1MTddXhg>
X-ME-Received: <xmr:ALOGagaV-ZvE23ZkxiTLY8v2lC2qxeIP7fAJLygSIUquE7qlZ7ZWS2H9M8qEoeQaSwW9qk-M6Rke37WygmDt2RgFhj8_jixuGrsLakbPdg>
X-ME-Proxy-Cause: dmFkZTFRy1qVenEeja18xxBUdluv9Bxlw+aOVARUGCa42rybKQa/loe9s6OQFq1FAKSsQG
    3YNB+Nj/6lYw6/CAQ/ceGfCdF/6LJfIPbYiuzTCc2365TVmXhi6UkWyIGAH9V/L7BoXE+D
    kHg3NXUhy9p07QqWUyj84R71n6bc+lNqf60d1YUZxGpC8FrVsqniC8cKxHMNyj+iZPY9Ea
    A7Dbu5DX4V3jXufI1yN8hJrwjw61AXMTjmTXgukBkYKnJq45ricOXUepSfULjR/DsknWKh
    hXFZFAA2B6e1s0pFP9lun9VjAOM6ziOIa90Y/Ds2EadefLfZrbmnL1wDK5qiDNEnnfcsl8
    yr3X7zIVqs6kuWLVSAS/W/eCUIEmH3YofmTtJWqrjKTCRAnVWveJ2nRGuqYFBndxIynQnd
    MAW1HBBA2in2xn6tBvhIGAOJavH7qhy6FHeALYy7/M1f47gxFQlE9LHvLjKiXldvvb2F0H
    YMw2WSkONXOwzzWTvlWGNrOflOfAb+nxx2EY2+nweDklYzI3FAxewDfYPColTEP/JMy/t1
    1tY4ueT86hjoTCFE0C75riADhgT5j2mF8zGBO2qLGpTTEZsmpn31SFTA8hVaWsZlNPpFCs
    FjDw/ovu4DQS9dcwhhCKYG+go5Imd3aMN/WSqeOBEx/p7vrQrASrKamALx/Q
X-ME-Proxy: <xmx:ALOGapPlzxN8G55hoOFDAkk3BOqhtTR_fFBQkfXvPU1O3gixmLRrpw>
    <xmx:ALOGalYHjALkUqZmAcsVurFUbci1Z16Ln7VaYoBuakQc5BEHKREMpg>
    <xmx:ALOGan2xFIoheoSLSKmvD6S2vh9UbQaya6Kw9Iuj2HKzLxjpSerSmQ>
    <xmx:ALOGarfzbO8cOUdY-hPw7T1BpGCYnS0wxherI6tTpxhcHNGt9RlrpQ>
    <xmx:ALOGah2pa8tmFtlgrUvynxMI6B1pTG-bIrU6frCiniqRVQ_PZziuGfB2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 03:55:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cba92732 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Aug 2026 07:55:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 20 Aug 2026 09:55:27 +0200
Subject: [PATCH v3 3/6] send-pack: generate packfiles via the object
 database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-b4-pks-odb-generate-pack-v3-3-bc42252f6169@pks.im>
References: <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im>
In-Reply-To: <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
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
2.55.0.822.g20453c30eb.dirty

