Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AEA39282C
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 05:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786945199; cv=none; b=aaSWDLsQ8vIUcp1E1mXbiklCp8fnE9T7NecQB0Rff4ltvu5VdlwhvSTLRTf4EvGedgCX319jEbhej732so23Lssx1U/dcKePcQFkaZNmemK8E+MemdUaFNhiKcZdAvLJoFCwkaz0RBCox/fTbw3tjyZYtL4HFkOZZxOwI+yTRN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786945199; c=relaxed/simple;
	bh=vr75c/yLqA58kZD/Qlup1ok/E2nPq84lo4rGkR5TwkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=unbY56io4AmbOZZS1jj97YTjA2OZBq22gtv/tXt0vY8/yquvATcBwct/O2Txw7DqdhU0V3HHKJ8XD45oo/C8hviHjKpzi4qBZGWUnclEqyfW88GqtZYGrP+e+/ubisby3EWVvve4u9AgdZBBL7v4FmytVkJyoAQPnFRzYaDoaP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YXZVkS1U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RdDRKQcN; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YXZVkS1U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RdDRKQcN"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4B4527A00CB;
	Mon, 17 Aug 2026 01:39:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 17 Aug 2026 01:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786945197;
	 x=1787031597; bh=AA+VbS/B8U9/6eOIiJBfbv1oam3A1zjyhldT8pmUOGI=; b=
	YXZVkS1UDxN69SHkAsyUOjX73ljnA/monBV0vsEQYszl3Jv4BTYZ+VkNIbSbijLr
	eeIE2fDlyNB+/bCj8/1JCBZQ+gqQGrCwuwPk0lnfyImNA7/zRMDp8r+EuDm/g6rN
	WVcaYer221dqhz/di5+tkBL4urXI4dWksZO7GqXr0ZcvAqJXDHcuoF32FdSUrWDp
	DfmIm/O5sq5AagqwyM3pexenhj7lKwVc0mfRl4EYvjpxh6B7srvsUuHj9/ELPWls
	qMVTZpeZpW/ieLkvVwxZW1P4AuJuRhnpHp+WZKowcACyASvUH5sKXqzSjQn38Eyf
	OnzTyj37/VmIgheQQ8gBWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786945197; x=
	1787031597; bh=AA+VbS/B8U9/6eOIiJBfbv1oam3A1zjyhldT8pmUOGI=; b=R
	dDRKQcNZdc0KDd+ugpEG4rf3qwR5K+hpEA/EQEbjfr446FPF8YOg36eJspKSGVq4
	0a+j446dNCSD/hwdUVvudw3Q5ld+zX+Wfdh6fPKFYAe3UYYOE/VBOhL5vXSBoSO3
	wf7B11qAZEZdj+iYbOZn/YLNYmT9eOneEQ2qM9fQNoM3I0yYgK6YtaaV14nkFb/Y
	PwkYEnZOJnxsAU8EXaocOQaO7DR4qdFIkTFonu7oywa3VkG+SZhP8NfL8oSp4cDr
	MZcJ/U4JUxjyjqoFhKfIBpdpw5AN7ibV4SdqP5lLmyDv5vMyarlZALAvuzw+PVrE
	6CHbR96VNnnE4wQLxxW+w==
X-ME-Sender: <xms:rZ6CaqVOHGXl-qEb9pO1fw5dOlnyUQ0MlILAOnfqrSNM6fA8Y1CRfw>
    <xme:rZ6CaslZZepP3Amw60qNDUsh8TUKa9bkV4JLGwuyhwnZsU5zfTGe0_kAZWxiy6W24
    j94vHty6ddcbUfNlWmU3uPDOGahyi80UEyaEQuL21fedw7HncsmaP4>
X-ME-Received: <xmr:rZ6CasDGZiOn7UsjpGxLkC2nSLdB_odWzXQr80LsRzVGG8nsHpGNv_IESUMjNCJVTGDI6QBZ9XE_8iEBcg8ViZdKF-y9GJWu6NR-sQF7hQ>
X-ME-Proxy-Cause: dmFkZTEI/ntatRUg4uSJOdtsVQxV3BwgHyQQhvn3IH0rE+kDrN1Evc7BD9mUecWN2oSRl7
    SxXYAW8/K6E4ruoxvs4iahCoMy/aDavd9wiuvjmv1pA+C2KyS+Vl37sb6eFuRj2zzKm6Hx
    fGgsAC3XEZMEKqXWSpQsYY+1VD8d2OYndD9n/aaEVidluL3W724Y3X9bdmJwBXgCWS6biD
    VAsYYB5qCHPBG6LeMIN/rn8Ed8AMmJ3m9W1NK/q1pMm0eeuKMSLrFJDQE1ePlX6Ikla35G
    iofsr4HtzJ5VYDuZKrCM+3UJ1itFhY49pSO0rt22zqUbVcdaOWDeh4X2AL8EOZ4DCxnKNj
    UK2BH+F0qhrxJ0m+5hcy+jcgWLYt3+yWpK47cCetShj/9MO59/YaziXAPDIxFJ5HznaImj
    XpfJx99fk1EUKPRtQdq8fRWj5wkLsN22FeOjKWLZWxu1/niByZSfQ3he8f/J1MlbvMvcct
    UDiPIguLhb0LxIU1SAF8kIytsW7L9oHuK9kuR2czUASi0uiYKdy6MpmX6b+cm13rmLEU2k
    kXs4yF7mENgkH/VzrlAa9Hry/yRndvRDxj7Jc60moWumU8LNJzxN4IEVtGCqMsmqjyJHMX
    Sc0QATFa2VRyD6Ce+dgM1B+rFaV//bJ1t0/eU/oxAsy3g9JyKHbdEueyT3eQ
X-ME-Proxy: <xmx:rZ6CasdoLUr8E-G4qr8WfqGkS--0aZ9--i-49JFc0Me176UCw6iMAQ>
    <xmx:rZ6CanLksnS9nrWsHC2dam8sEiSygANcx5YfjSNy3-HQOcATRhEQjg>
    <xmx:rZ6CavebGXw75lNEtg9ZEOLzZF1XO2tQ5_PwVLMOUafWLrmsA9vkgA>
    <xmx:rZ6Cau0EUK5sZgvDpY5xvTHJdmb1hYuU6haPbtSKM-i-Hld63Nnqtg>
    <xmx:rZ6CaluTftBnXgk2GkvVIsGgEoje1f96LypsIQlc6irgLKaYoq9tcbvj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 01:39:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d7838076 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Aug 2026 05:39:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 17 Aug 2026 07:39:44 +0200
Subject: [PATCH v2 3/6] send-pack: generate packfiles via the object
 database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-b4-pks-odb-generate-pack-v2-3-4c8a96ccfdb3@pks.im>
References: <20260817-b4-pks-odb-generate-pack-v2-0-4c8a96ccfdb3@pks.im>
In-Reply-To: <20260817-b4-pks-odb-generate-pack-v2-0-4c8a96ccfdb3@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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
2.55.0.739.g4f2b995119.dirty

