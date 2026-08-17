Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C517A391E4C
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 05:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786945197; cv=none; b=BzgQi45j7fK+oyB0DyOumVC//42eZ+5ZHIed0QQqNM9z3anNNo5N69P4tDvLW9GnB+QeioiQdTLox5SmeHvKQfR8JlrwZlrxW2cGToHYN8jAQQXKJp88+h3I9QftJ5WmNrSI7XeXpWXOZ+7vzZ30WrUcP8aNjuYc74ufGJ581MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786945197; c=relaxed/simple;
	bh=oWLERbmfI+z27hcdYiu0NILJPq71OSEggj8mgjW6Z98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sONz4VVuVVZm7S7bl8HuPR/KQs3wK7Ba2AKgSDBX2gb0T0mw/IDX3/ksf5nnLQwnQvk9x+RNCm3DxBhFy2HTvy5dCU3tYdyWlSjMnYET2r8pqef/I4sX/WlSER3cI+EaYIqLyCpDvdBTduMsp9N/vqxBuYVxJH+ZIhQb1iZXrYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DFw8caaa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dqECNtAW; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DFw8caaa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dqECNtAW"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2B95E7A00E1;
	Mon, 17 Aug 2026 01:39:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 17 Aug 2026 01:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786945193;
	 x=1787031593; bh=ttUqeAv9vTbG9RQYGRefikQOBneqoDuEC8pkNJmk8Xc=; b=
	DFw8caaat6z8bzfxQ0ASvIcGiZcJh4liBUPk39mt+uTKTDVXYojv5KjNBySXn1bC
	olEHVj5lNJzAIipJZiuM01HCdaRD37Hr6ffhO3s0rPM4PCG9z0e5qxydECQT8FP7
	4wBVEJna3nMzRrFOtxu6SVr2G4LLf/rYgXF0W+rBntCvx9r5Ih+eo4NmCIEPs9Ye
	2iVKTvmDu2WCD7eHhXMEAXaUamxCMAJPw73YIgZbWqhTM0kl6hwdZzrQH+xD4oCJ
	dU6umO5b6FYk+cG+nDlKB9IBks9ofdLJQxxL4TTbGzh/TG7kQfZW1MiTn0zsDlql
	I/RiuiWPD2WKbfG92JdcXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786945193; x=
	1787031593; bh=ttUqeAv9vTbG9RQYGRefikQOBneqoDuEC8pkNJmk8Xc=; b=d
	qECNtAWyJAs5wQq3yZF8/iEguIJnz1Z2ebMNX3AShntxJD8mczbllvBhYoYkztkF
	14KmdkJ/LRJldUIpTJMgHklompwH9hOBh3FVJ3L5rgneXhm/Wan1qTM51NmVFFfK
	e5Uf+9kkfT6ygOgX5K5/WLoK9q65eI4eghMnssIploZ+pns7+jkA5jjaAlyTTNft
	U32hbDLdaOhX+ERZTs8lUERXttmP8rEzpQtbQi+Yj0xVHGGV9o3MczPyfhPviGg4
	emErBszyJnkGavLjHnl0ihic9sJCef9xK4teTEh/gHey0MjYxGaDA6neri8bgwk0
	tLGONlgPwVQPeOEafKBEA==
X-ME-Sender: <xms:qJ6CaiH3bIinP6FctX2HZLHBDmGWjY2-naya_AGkV8pN2pAdXrDoKQ>
    <xme:qJ6CapV-bEUCFWX_yEGfqsbJQUj7MfpdmK_WBOz6MUGX1HbfmlWdjAm0ucqwWE-mU
    CvxpS790BRf47U60NpZniRU6ppIq_IjVP_065drVvR-k8WHQGEeQeM>
X-ME-Received: <xmr:qJ6Capy5kCSClhnVrCHB_uVijARKg2XnI_Aid0GMNnyRKM57xlWRDrGgYX1GtuXlOHAGKcaoVcgohOZFMDRLlAGcqoykjsoJf2y4KR0Bjw>
X-ME-Proxy-Cause: dmFkZTE8frn3UvdVJ5GpxbIuqMD9ESMpHxX/h/EAnkdqkXSMqGc5ojVpHeHF8RHZkvOomb
    vIwL4yL13Fs08PKSCsfiq8VnZFkASOlb70n3QoqTaP3rnNmKdh2IGYFwYXgO6qxImRgHha
    uJq23GUu0GL3zTo/resBGM6U1LB/lhr6c449TnnJu86yCmJL+PfJmFg1gSec1zerT9DQmW
    ux3owYC6uGIF3BfICnnC87acgHiJ0wzQlrS1E4/fySG0eROmzTOWQzndP29IKpUHaEojLv
    5k0A3lvSbHzfkih6Rvuc0tIFRQoa90meDZ+YXgyMRxlQL/fVt2jyYjBWMakwFduKJAGhVH
    1faad8r0VMXtGk2Ui3UzHoapyo7Fue4GKriGf78FOypjBcz1gr8vIKYak4V2uI6b/alVeW
    3H1H7sBNyicOEN+jkYCqpaYUwyqI1xG4T9til1BKUcszFDPFi3xREqCHJum1VpYCi1akAe
    xKnVXlDG/5msEx1WU9H/pPCEEB4DxkzkVLvD86+Qd/yErW7MPIDqZVkf86H/afyA/ARMqh
    tguZrjpaLibITg44wBIYSyS9a4kj6upf732wOjlx6SPBT+NFyfxLfwNxBhE2zW4jhrf7Z3
    WOdH/rgiknPX9QJbXDbZi/zLjlqmH/n/I3oKCGfrjN37S6H2ex7xfwGHkk2A
X-ME-Proxy: <xmx:qJ6CanN4CyRTbOXHpElnVs1ujQ0-nF5bi09KFr4Xpo6JboluvWkJKA>
    <xmx:qJ6Caq4Y5FSlnRkiOHh43uJDFJtxVzoV4oaWKI5A8eKk6dsf6U9B-w>
    <xmx:qJ6CaoPBSlUOdmre1KpwYkuYRgnEYCBDBNtzSESOcLPoVLH1_2i7Lw>
    <xmx:qJ6CaonJCFVVTXDWkhNvLn_eFqbs07ezglAsdMBjzlfINo_0CozLxg>
    <xmx:qZ6CatcpGbxXlVVNN7yTe7I3ZXhltaqG7oscj8xs715Aylx44KnmtuAk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 01:39:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 41b547d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Aug 2026 05:39:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 17 Aug 2026 07:39:43 +0200
Subject: [PATCH v2 2/6] upload-pack: generate packfiles via the object
 database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-b4-pks-odb-generate-pack-v2-2-4c8a96ccfdb3@pks.im>
References: <20260817-b4-pks-odb-generate-pack-v2-0-4c8a96ccfdb3@pks.im>
In-Reply-To: <20260817-b4-pks-odb-generate-pack-v2-0-4c8a96ccfdb3@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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
2.55.0.739.g4f2b995119.dirty

