Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D22431A5E
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 10:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099547; cv=none; b=WVEe2olAdkR88cse8FrYpIMtmc2O1+gxi+uHkfoZ9LPvjzVhQ3kYEjold/GOoNMaG/VArTPnCqiC8DDxPD9bEpcQXPK75Qf8G9PbJw+lDU5jLj2icIOex8PkLVGKQV4EzLM5R3XRnnWclAE+u6GjVTp1X+ZBvAbkfvIy6era/gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099547; c=relaxed/simple;
	bh=GEX7EfMvZ3Utp5Zypq211bdWZy9InzClPUHVrof31Tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hjk2mxX3zQMplgTkFz+tPe0W2kC23mon2UwUSGOWLsdHEvfvr7qXY5W2iLjJGV+FZe+CszDxoE6pHQt1FfeWqY9Zp0uTNnFga/uIjTn91qhDSrcR2khYYCq4nbMW9BIcvLPF7vITSP+nUmpjV1Mshjt5koJPS5lKYLXyz4QnJGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WbHI5qXP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZI9MB7Ed; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WbHI5qXP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZI9MB7Ed"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4ACE314000BB
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 06:45:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 07 Aug 2026 06:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786099545;
	 x=1786185945; bh=HvkshCuPor/A2T9cEFD0SWLOTfdnHb/E71vuyIQxCXw=; b=
	WbHI5qXPOlM2KwsMUwVUYzqVyDoKx2fPPr6fe9Hq8CZ6hti6wUXihnSdXt8nk37C
	zBB2MDbpdlv6WCZVe+SE5wl8u9h42647AVlMiLGGU9gs5aGFmLut7Ffz+c+waWGH
	GlcVMM00OQ4+b3NJ8RxxGIhB7Y2mp+qJrVhyLFySt/fLDPIvrJCabx902zg7UOu6
	vDTDMIY5LlluPecsHBCUuHQOX2rfPtb3yqsHANE6wB5C16HhGRI+TMUUEzp/p4cc
	aQtZjoR+TojZK6ciNv0/us7DwcBFrbp+zZ62sFYl/g91R0EOUisShEUf0RQvpWfJ
	gNWnwqsnvZ5ya2fijm+ApQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786099545; x=
	1786185945; bh=HvkshCuPor/A2T9cEFD0SWLOTfdnHb/E71vuyIQxCXw=; b=Z
	I9MB7EdsGmSvO+UbByv4nL+meRA+d50UNvaTrR2UnaTIGmrzxRSekL45KRtUrNte
	xuOZ7XsBzqUbuTPDQf1yKP5ynZH+u2Oy5djZ3u/2gfcBCC+sYAQsmJTbLhcbILnT
	U0L1eqm3UAn3fMd2rr/YsS/3RnBjUCqRx1gVMInGqDqm2yTvUOCwlp2yrKAMs7VB
	et26dLCjujDsZlY4XyrJadJkXScKMJZEd0xoJUeLPSbd9zDkEfXzGa8cN28eb5qS
	DM4rUZ4mc6kPssK4lPb3jmsgffGdi6jHdokon5yJ4Ot+/NqBT0MXOe5MtUyHIdg/
	a+EwdNKSNio+eeq44VqMQ==
X-ME-Sender: <xms:Wbd1akZGaNgXQaIq8Vp_hHKy80__AeutXVLbUD8p_rxS82cB40KCsw>
    <xme:Wbd1amXksPab3SF3Dxzay80iJofi_bv2oYugq_oUdA422crjMDFprEgKeGqPUt3J7
    phBL6SN1cWr8EmraQIwnkTR00KiSn_llPA_GSNmcmxYeqrlz6mvDgg>
X-ME-Received: <xmr:Wbd1aklowpU-OuiMQ5XK01vk9K6LLq08pp6SfB-h9yFS93i6NI-6vVNCS3LJ184IVE5il2pzLkcthb1efrK3m28q9laie5gDb6cytkV6h2_Msg>
X-ME-Proxy-Cause: dmFkZTGNsvSFSUECcu2Nh0FGOfZ19l5LxGfcGph13wKJT4TAzUBJREfYOszHqXAiQ3n7iU
    lqzIMoX63uJA32W3RBYcZ1/RyQqX26JNaPlBXTGD/ls9dTd0VZhbyytEvDxvkaEG0PK67L
    JGkzA9lNwINefEzvYZKwdjhramO6e3IPfqAJZG0u2o9u3xqlHWQV4mjs6csBpBWYeIfq6t
    8Z7hNK95Hh9RzVMFiF3lT8k+1IfFEkOfZOp6vFPBbw6UfNt0jStcDh7rvbhnMOCy09Xr8t
    YSyUhF+HhFTVABaqOv1R5YNe4ByqU5empe4W0yKQu/SyfLZzc4QHCbGw1hYoAGreUqXRUR
    eoxOJNzaJtdVR9TUmGG/2F5+n1lLOkc7tjzfo5CW3H2Ni4pmXIH+KVitm8l53tf5hV3Ui3
    GAfTKeneMZuzErUweSYnRQEVnd5FnMh7TLb+be1zAvDZ8dwFoMtV2cwIAnqDTACbO2ocpR
    TiTg0NBgdfPiNpDavW+UTiquPYiy6HfDp2cSpN3kdlRHnEX0fSdihBe4rNE9jnxnw9RPm8
    pst4+NAy0LtPw1G562KSVxFV45kmNFbp4CJHLSEUBL0HoqZiLhm4udRamIC83+yqEoGEj7
    pe9nzzUQycxYTMGt0adTFsBWf9OsrmijIV+gOZZtUd8Tqm8W3D8i862ydMFQ
X-ME-Proxy: <xmx:Wbd1ajx-OUcbtKxAh_VyVqxEIYoIJtyX8PRVN4VFA7W5tft_1EBJDA>
    <xmx:Wbd1avicWQOPbmabcXd6YWKw8BzFyzG_O23yY-I4nGPd9-UpqJnnlw>
    <xmx:Wbd1aoWSeXaaZZPjcUGWdNhNT1MTmapJa_lw52PqJgncEKuqj6EILA>
    <xmx:Wbd1ah3qASP5eVJ2eKwqK8NUqBLozs8_Ut-UKlQiiEeoqC5mT_ggaQ>
    <xmx:Wbd1aq7UuZ11682oUvM6sZpMZBsJLzFAhFpP2bIJXo6WeZpSNl_s2bCe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 7 Aug 2026 06:45:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7905516a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 7 Aug 2026 10:45:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Aug 2026 12:45:08 +0200
Subject: [PATCH 2/5] upload-pack: generate packfiles via the object
 database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-b4-pks-odb-generate-pack-v1-2-7dec431ae7cd@pks.im>
References: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>
In-Reply-To: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When serving a fetch, git-upload-pack(1) spawns git-pack-objects(1)
directly to generate the packfile that gets sent to the client. This
hard-codes the assumption that the object database is able to serve
packfiles via git-pack-objects(1), which is specific to the "files"
backend.

Convert git-upload-pack(1) to instead use the pack generation interface
of the object database.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 upload-pack.c | 125 +++++++++++++++++++++-------------------------------------
 1 file changed, 45 insertions(+), 80 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index a52856d869..75a857eaa8 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -197,11 +197,11 @@ static void send_client_data(int fd, const char *data, ssize_t sz,
 	write_or_die(fd, data, sz);
 }
 
-static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
+static int append_one_shallow(const struct commit_graft *graft, void *cb_data)
 {
-	FILE *fp = cb_data;
+	struct oid_array *shallows = cb_data;
 	if (graft->nr_parent == -1)
-		fprintf(fp, "--shallow %s\n", oid_to_hex(&graft->oid));
+		oid_array_append(shallows, &graft->oid);
 	return 0;
 }
 
@@ -299,7 +299,8 @@ static int relay_pack_data(int pack_objects_out, struct output_state *os,
 static void create_pack_file(struct upload_pack_data *pack_data,
 			     const struct string_list *uri_protocols)
 {
-	struct child_process pack_objects = CHILD_PROCESS_INIT;
+	struct odb_generate_pack_options opts = ODB_GENERATE_PACK_OPTIONS_INIT;
+	struct odb_pack_generator *generator;
 	struct output_state *output_state = xcalloc(1, sizeof(struct output_state));
 	char progress[128];
 	char abort_msg[] = "aborting due to possible repository "
@@ -307,78 +308,42 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 	uint64_t last_sent_ms = 0;
 	ssize_t sz;
 	int i;
-	FILE *pipe_fd;
-
-	if (!pack_data->pack_objects_hook)
-		pack_objects.git_cmd = 1;
-	else {
-		strvec_push(&pack_objects.args, pack_data->pack_objects_hook);
-		strvec_push(&pack_objects.args, "git");
-		pack_objects.use_shell = 1;
-	}
 
 	if (pack_data->shallow_nr) {
-		strvec_push(&pack_objects.args, "--shallow-file");
-		strvec_push(&pack_objects.args, "");
-	}
-	strvec_push(&pack_objects.args, "pack-objects");
-	strvec_push(&pack_objects.args, "--revs");
-	if (pack_data->use_thin_pack)
-		strvec_push(&pack_objects.args, "--thin");
-
-	strvec_push(&pack_objects.args, "--stdout");
-	if (pack_data->shallow_nr)
-		strvec_push(&pack_objects.args, "--shallow");
-	if (!pack_data->no_progress)
-		strvec_push(&pack_objects.args, "--progress");
-	if (pack_data->use_ofs_delta)
-		strvec_push(&pack_objects.args, "--delta-base-offset");
-	if (pack_data->use_include_tag)
-		strvec_push(&pack_objects.args, "--include-tag");
-	if (repo_has_accepted_promisor_remote(the_repository))
-		strvec_push(&pack_objects.args, "--missing=allow-promisor");
-	if (pack_data->filter_options.choice) {
-		const char *spec =
-			expand_list_objects_filter_spec(&pack_data->filter_options);
-		strvec_pushf(&pack_objects.args, "--filter=%s", spec);
-	}
-	if (uri_protocols) {
-		for (i = 0; i < uri_protocols->nr; i++)
-			strvec_pushf(&pack_objects.args, "--uri-protocol=%s",
-					 uri_protocols->items[i].string);
+		for_each_commit_graft(append_one_shallow, &opts.shallows);
+		opts.shallow = 1;
 	}
-
-	pack_objects.in = -1;
-	pack_objects.out = -1;
-	pack_objects.err = -1;
-	pack_objects.clean_on_exit = 1;
-
-	if (start_command(&pack_objects))
-		die("git upload-pack: unable to fork git-pack-objects");
-
-	pipe_fd = xfdopen(pack_objects.in, "w");
-
-	if (pack_data->shallow_nr)
-		for_each_commit_graft(write_one_shallow, pipe_fd);
-
 	for (i = 0; i < pack_data->want_obj.nr; i++)
-		fprintf(pipe_fd, "%s\n",
-			oid_to_hex(&pack_data->want_obj.objects[i].item->oid));
-	fprintf(pipe_fd, "--not\n");
+		oid_array_append(&opts.wants,
+				 &pack_data->want_obj.objects[i].item->oid);
 	for (i = 0; i < pack_data->have_obj.nr; i++)
-		fprintf(pipe_fd, "%s\n",
-			oid_to_hex(&pack_data->have_obj.objects[i].item->oid));
+		oid_array_append(&opts.haves,
+				 &pack_data->have_obj.objects[i].item->oid);
 	for (i = 0; i < pack_data->extra_edge_obj.nr; i++)
-		fprintf(pipe_fd, "%s\n",
-			oid_to_hex(&pack_data->extra_edge_obj.objects[i].item->oid));
-	fprintf(pipe_fd, "\n");
-	fflush(pipe_fd);
-	fclose(pipe_fd);
-
-	/* We read from pack_objects.err to capture stderr output for
-	 * progress bar, and pack_objects.out to capture the pack data.
-	 */
+		oid_array_append(&opts.haves,
+				 &pack_data->extra_edge_obj.objects[i].item->oid);
+
+	opts.thin = pack_data->use_thin_pack;
+	if (!pack_data->no_progress)
+		opts.progress = ODB_GENERATE_PACK_PROGRESS_STANDARD;
+	opts.ofs_delta = pack_data->use_ofs_delta;
+	opts.include_tag = pack_data->use_include_tag;
+	opts.missing_allow_promisor = repo_has_accepted_promisor_remote(the_repository);
+	if (pack_data->filter_options.choice)
+		opts.filter_spec = expand_list_objects_filter_spec(&pack_data->filter_options);
+	opts.uri_protocols = uri_protocols;
+	opts.pack_objects_hook = pack_data->pack_objects_hook;
+	opts.pack_fd = -1;
+	opts.progress_fd = -1;
+
+	if (odb_generate_pack(the_repository->objects, &generator, &opts))
+		die("git upload-pack: unable to fork git-pack-objects");
+	odb_generate_pack_options_release(&opts);
 
+	/*
+	 * We read from generator->err to capture stderr output for the
+	 * progress bar, and generator->out to capture the pack data.
+	 */
 	while (1) {
 		uint64_t now_ms = getnanotime() / 1000000;
 		struct pollfd pfd[2];
@@ -393,14 +358,14 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 		pollsize = 0;
 		pe = pu = -1;
 
-		if (0 <= pack_objects.out) {
-			pfd[pollsize].fd = pack_objects.out;
+		if (0 <= generator->out) {
+			pfd[pollsize].fd = generator->out;
 			pfd[pollsize].events = POLLIN;
 			pu = pollsize;
 			pollsize++;
 		}
-		if (0 <= pack_objects.err) {
-			pfd[pollsize].fd = pack_objects.err;
+		if (0 <= generator->err) {
+			pfd[pollsize].fd = generator->err;
 			pfd[pollsize].events = POLLIN;
 			pe = pollsize;
 			pollsize++;
@@ -437,15 +402,15 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 			/* Status ready; we ship that in the side-band
 			 * or dump to the standard error.
 			 */
-			sz = xread(pack_objects.err, progress,
+			sz = xread(generator->err, progress,
 				  sizeof(progress));
 			if (0 < sz) {
 				send_client_data(2, progress, sz,
 						 pack_data->use_sideband);
 				last_sent_ms = now_ms;
 			} else if (sz == 0) {
-				close(pack_objects.err);
-				pack_objects.err = -1;
+				close(generator->err);
+				generator->err = -1;
 			}
 			else
 				goto fail;
@@ -455,15 +420,15 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 
 		if (0 <= pu && (pfd[pu].revents & (POLLIN|POLLHUP))) {
 			bool did_send_data;
-			int result = relay_pack_data(pack_objects.out,
+			int result = relay_pack_data(generator->out,
 						     output_state,
 						     pack_data->use_sideband,
 						     !!uri_protocols,
 						     &did_send_data);
 
 			if (result == 0) {
-				close(pack_objects.out);
-				pack_objects.out = -1;
+				close(generator->out);
+				generator->out = -1;
 			} else if (result < 0) {
 				goto fail;
 			}
@@ -498,7 +463,7 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 		}
 	}
 
-	if (finish_command(&pack_objects)) {
+	if (odb_pack_generator_finish(generator)) {
 		error("git upload-pack: git-pack-objects died with error.");
 		goto fail;
 	}

-- 
2.55.0.679.g6767b8d81c.dirty

