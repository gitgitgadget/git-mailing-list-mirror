Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D133D3D07
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 07:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787212543; cv=none; b=QYtJgRhcOZCqCRN8xkdlNchOLMAHlOkcwJQ4R7fjSBkhej0/SdZvMXBqI8OCUk3/urGD2KKO/TdIa05A+kf3Y2oRyAhHbQv8A2ZX6gFOwnzSYgEw3swolV9ALXn3KgtGkCMlyH+cTx4tdOpipb9Qqs9fM+ZQ6nkK8JSBlx6PhxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787212543; c=relaxed/simple;
	bh=Ju7iHFc8+kzSyadTGU3WQVtFA0KkClIqFiJNKoR+LxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e3fbykMR5Ny6OuyZkycz5WiN0wuxWEkU+oI59TJvtPGztP7tHR/tSoT2O34aKWGC22d6+y2ubINw+C0KckyXf1wKAFjE3F04fOKrewKhsTGYBJEzyAstOAiWTJRBkVDmYAh7BO1b9TI4qIdkQ28MaKTkZDOvu4/6gq1TEJ1cwSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dqiOip9z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VMUCwKH7; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dqiOip9z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VMUCwKH7"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 44C2DEC01B2;
	Thu, 20 Aug 2026 03:55:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 20 Aug 2026 03:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787212541;
	 x=1787298941; bh=Mn98yEXbLKBt+k24V4GjItViEI9AmzHQmScgP8fvXd0=; b=
	dqiOip9z8D8yHGWsFQf958uSDp9ZDnZ4u7I55zZgRewY9xqTvTbez8DwdDexE5UF
	R/2PUR9LyRR3GFuwKrDznWGKr64iJZ16s71LzqN9QfQt4MrbJU3g1YQcpersowKB
	QDXA7ezJ4TK1v4/OTsAF8RonGM9MtrM1QIT/vgiEuhNxNy0kYT3O7IPjK/L9R/XB
	1phkx1GYNvyfbWqri3vVKpSns6VtcyIvS88djZp6yozhvshKNSDzerxUZcx7sB7i
	2mThjyr60S+uiXzV9odWwzACBg+wtGr4gRcmSRWHihXg+oYIOcJQnIlSJsvczsaZ
	a7B9opX1W4L//jpfGfDmoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787212541; x=
	1787298941; bh=Mn98yEXbLKBt+k24V4GjItViEI9AmzHQmScgP8fvXd0=; b=V
	MUCwKH7+SE6gXlODJeBXbZWa+lsSmeC+6oQ4kon3eKX1zxbaI0AA9lne9ySRh51F
	8RnBLZCYobI4kND8XkpZhlC5k/T2J4GsFFnp16H436FC0mFCLJcKCH2qIYKRHyXF
	zFkq/l/vHAidJRwqdEMgfdLGcfREQp4miNS/Hc4u9q1W5svWxFE/FCajaDWiAkgo
	+1K53EUimjDbZYbniWmEydvodiWNYAW5m8wR4uzGRMQArLQmBcv675JO/8ZY1+9W
	cLg6gdZOT99datlldz8ZgCcG3umW6MDmsUXruYHXh2DlH696OjD5q8chfuiixTd3
	MBdhk3TwQzv2FgRioffSw==
X-ME-Sender: <xms:_bKGalv0WwrZIBExaBQD7bSVDWusKrWut3s6SfpxVng3ABhBaO4vig>
    <xme:_bKGaleNw5c6Ix3Wz36-wfeUsK_O_btfziTScJ9D2N7ncvLezUG_-cprb_-5oM5WQ
    Ewep4UBkx1zVGdvEgqkB4rLh1kzskaMFjj41llmmRqgllLquAbQLfk>
X-ME-Received: <xmr:_bKGatxlXXtHCTl6R6olzYXIbTP0Rp3iEN1hSdmRcpHMhvywT8BZv-jl0FG88oYcGQyWRHopddtaXbGq9ZH7uPTUVaHvAaNTrEjI356j8A>
X-ME-Proxy-Cause: dmFkZTFf6dj8/8V1XaAc7B1kVMFZTKvMbAEygAXbbhBXRMoJE0Q/MsehWCz6Zsr3VItoGJ
    sSOYPjnsDlfrh3lzEARCv0NJnfuJQJusLASMKcwM9uC/Tbs/YIBauNX4V2AuW+yb3o66jM
    JzMl+gjCx01/1zMiYhH+kC59/ghsfTubikmfaAxgUR/millS0tlPNpkYgp4jFToJY+LVEk
    c6s4D4aztX2xzEJ3LDQqGoLTd3S6W+Hcma/glCPpKbDpT9Cmp60wceni6gyM3ckjl3Tvge
    oRcfTlFV6iALm7ps8/b3emKy+rfSopq+d7NQ4EYMi/B5tNUxYa1zjgIENCda7YAb8HlkEj
    B86mfCj79A+oHBXZNwyVx7ZxJORSEqOfJ1Z69jvHjvgWIReYH7Sosa3uS84cXvhfOfwyc9
    TxVcL3FJ/57Vippd3EDFOC3C8kXT0NRXGwWdYn0t2pZWbVkuLeGoPgEzX9cZwoK2kKxGIX
    Tr0HWoeHGwXHvo0NLgqwrPgxuKyHWL3pjYtox7XxOIwJw+GqVT/d/efFY9Pot6gI3007cq
    vmXkgusoSwBxcbvfr+weg0wOYyuUU13nq7Z3OP3T8kuKYR0VWCjJF+tpYt7rATsU6H7NGG
    wwOg5BJiy4wpNpX2cfsnW9uN5g0RgYSCpgtNyah1l6puX+4lLuBiZkU/IaPQ
X-ME-Proxy: <xmx:_bKGarEUOPhTMNnX6t0ZAn5u5BO8aHNa6l02crdv1Kp9PlkSl412KA>
    <xmx:_bKGahwL5VCVQGw4rQgT_QaENUha2Us_v4ruLjjZJcx0qgYdf7vBjA>
    <xmx:_bKGassw5w2mMNdM6m1OWicf-iwiWV3P1Rn4Tt9YvnL4edaFKdjFuw>
    <xmx:_bKGau07VS4-7Nyy2PsW4r-D7g95AFG1BIWA1snl7holbAFZt9wWaQ>
    <xmx:_bKGahT3K2Own_wQuQq1-Iyyd3-9gP9x4ZRtzfiYr75V3ZhVdD3XDAqE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 03:55:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f705daee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Aug 2026 07:55:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 20 Aug 2026 09:55:26 +0200
Subject: [PATCH v3 2/6] upload-pack: generate packfiles via the object
 database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-b4-pks-odb-generate-pack-v3-2-bc42252f6169@pks.im>
References: <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im>
In-Reply-To: <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
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
2.55.0.822.g20453c30eb.dirty

