Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D56C414DF6
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787293818; cv=none; b=Kq++LF4Lrcg49P9XMpH/mm4UhCGHY4Zu7rbYFrtS9WuT33QdyFD2UZ3yVNa2f5ebWsxMwzWxfnVgVopTsrZ6rFS2UJb1/gGwgNV2vOmZxuPhWTvX/9CsBVl7TrPVodcBNbTM1Tcq9M0eY4ISCAo9cPgNiDMm+Yri4zfJbd/K+nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787293818; c=relaxed/simple;
	bh=3NzOC9PBzCf98mgEU+OeT09IcmLPjJ6i6RRpFujOcSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=faS+rstxIXYT0p2TD4vpt+G7nf4bE7CYqexBY/MTL5oG+BHFfF1hXlHIEoo6WkLpRbyKb06TfkvoXolQhUPIrf2VMr7DCjM4k1V98/Iongbw3I7N/xjB2ZUkeR8hFKdQ/hMGJq2GJwOAm9ZDwXmByyaRMDi7D1lpJ4jPYHmzfjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FFkcg6Q7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kWVmZXLL; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FFkcg6Q7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kWVmZXLL"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4B78614001EB;
	Fri, 21 Aug 2026 02:30:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 21 Aug 2026 02:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787293816;
	 x=1787380216; bh=pGSZFHCO45eUjb8iFv+AdJycFW47JQqJo4YyGPRgW/0=; b=
	FFkcg6Q7iDvQ1L7rYvXpp0lhgNRkSiwFljjcf+KeXSftVLNWzQcsaKTdU2JgYDoG
	EcBihJIT7CUeymxrEWDcniIEkcAxFwZH2+qQ8hHCS41cPnmd7n5M/o+NmK5Vpjr+
	mrGo7pB1lMKFuwWQxWyuCt4IOtIQ/0pZZ34eq1KgG6KJPlv12R0akguNM4CSBTii
	x7IJW3KwCzerdGJdI7LCY7heyWqNqDBsb6xAbBMUr1jsJHcxcy7+H5aGXZAPW2ag
	Wpzdyk/XVCmUzpyuVLH+RunJAXdIm5dq+3YkjGm+DGamEp598FDrszygeYFv21CS
	4y/C5Aq+4u72NhI+9kxMBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787293816; x=
	1787380216; bh=pGSZFHCO45eUjb8iFv+AdJycFW47JQqJo4YyGPRgW/0=; b=k
	WVmZXLL1Fo69oESsAMMFOkoUR+SzYErM2bSIa0faasl0IqvX7YQ+ItGGz+joF/m4
	mPcHjB9JOOqSf/wopAPq0UOJj3+H3ZvzAdMn+zNglXktXtQVUYNiWyuOpXdcFKB2
	8aSRR6qSLg9LTBFAfgzE9wGVIGcEZ90efRepK6yJiOIdtrQhl4w5FOorpU78WXzG
	ip61idrcLfYm5FXLeweA7rrAp7T+lFy29i48ZxOEUwvv0q7x9thegUe4lgXc49Bb
	stsV468/zraG5vQcykgHRCWBMol5F/FH5PetxQ4cmsbHf7mPC4U5E1s7q3Pm5Ilp
	gFN/2DNcsbYo5yuqkPUVA==
X-ME-Sender: <xms:ePCHaloak9wvCKNo2t8_rOwn6uaG6mLA6VsLzQvE1__4Ab-wh9HeXQ>
    <xme:ePCHauj6c4Z9FqCjZi3M78rECcqFJyXjHU-TE-x3jVRc0V1-fQjpLfouLojHSgieG
    EPDneHTpC8jK5N1PFOiJ34OLyy8OR52X8lNeWKToQfkRzOfyqGvKWg>
X-ME-Received: <xmr:ePCHaqjXwJNIU2sTQ57JmqDGxM_RTLi3SpR0SS0Ec0Qvhb1fL2UPSRAjjDttGVfiNpL9AAgTBaEnJU-_X8So9X4II7RIwvyyQkmvvDlQPctl>
X-ME-Proxy-Cause: dmFkZTGvGr7AfD8DCnwMaod+pFuPIsXtrfEPPcql2hViDk1ZB8UQGHOuXDkGbeRxx2570l
    cRxGSWWWMovYlUT44fOZtzhNuR2uyD1biL8STN/BNnE9CfvJalG+92PvRA5Rf5iSe1mIQp
    rQDnz14/uoDmFci+eTs3zjZowpnDp9o/yN2BM5n46dTwTmCzgXr3dk5OdMbE9RmJ5o+Srm
    Fd7KdtJ89qrpxh6A/yke8ZFpXrtJo/ItD9nlo9XiiDqbg2xEI+4gp82nM6vzDGnM4fkm9p
    69ZV+W2vom486+Rw7nic5ewj1j03AB4c4xKwZ8M1/tlzf/fE/UHatBuW2LwjNnelus2Uf+
    qDxLmELuOz5kRgbycW3m97oEUilCCvxr+E1bS2Meo8s7QhSH8XH6G54bSgclMbM2hbZQDy
    1+bCF2z7jaIud/jc65eVGpXC7YU3qMMGBmdua2FBLbb6RJI/r7310lbSl0dQGDW7psYVG+
    JyiJmiS7Apnrn4J5YsW+emhov/9Y3etdLO6B9wBLXisqZ+P1GiCKkwCyi5SeBkMB+xVZ8w
    Auzdl4P7ffni4aFbaLY+hkgF/j91UtR3zBaaCTumq9lOvOOUyUvMhNNV97flO9dvq2s2GB
    jnwNg9ddXLuVv/PkpMNaM7vWmlSn9DtbPDkRnjteRj5phInPGkDDr0ZY++NA
X-ME-Proxy: <xmx:ePCHasjsXS8Bl0CkOwFULlQxH0cS2VKXTtiJHRGq6dEJz-wAqfN_4A>
    <xmx:ePCHaiI-L3uVXSyVbPpWY3Eo-wc83ll8EhmwVtupHxUrkuNySclRmA>
    <xmx:ePCHajFaRKwzlk4G-Am1PDMyzkHh4wYMZrVh7HjI4OwstAaywgTFaw>
    <xmx:ePCHauS0h7uZ0ZDzPYTyRcpBIJcUUkgQh_DhIRmh4gJ0LCswOc1PRw>
    <xmx:ePCHavwYkRgNn_W8JG0ibNAVz70kRxMlFZkPj-i6r--WoC1SL008M10t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 02:30:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5d170218 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Aug 2026 06:30:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Aug 2026 08:30:03 +0200
Subject: [PATCH v4 3/6] send-pack: generate packfiles via the object
 database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-b4-pks-odb-generate-pack-v4-3-074e8bd641f8@pks.im>
References: <20260821-b4-pks-odb-generate-pack-v4-0-074e8bd641f8@pks.im>
In-Reply-To: <20260821-b4-pks-odb-generate-pack-v4-0-074e8bd641f8@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Patrick Steinhardt <ps@pks.im>
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

