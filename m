Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D5F1DD9D1
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 06:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417862; cv=none; b=Fi+9XnNcJdERt1LeyAY0Q5lZC85gYlc1p64LampBctT9/av0j9BTItljjng2cq2UmaxtrmTsnWYAUDO/NK7sW5mEv3waa2BlCj9gDOLpX/ZSz1FQPAGgnRQ0BcmMZ029p5ehuwEtpCa8KtXAqsPJRuvrXjR/1Inp/bkBHEEVRhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417862; c=relaxed/simple;
	bh=ZkPZi/zhhNjNhcbuYlJ24iAcKFzZhxa4sihiKlujb2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UIz7f8QbuG1Z7iBYaHwHWkNh8LexLi3MoW86Fw0dEldOapvwRG7OyVwPsIO29x8kGgVavnWyP4danwP1k2ZnsWBVRMtTUHg2kxqzc4T6Die56W4usuZKDDVlfbtT1YdzVeHHB0h/+sIdjRb4OD2NxX4pj8jSL3T65ISYWn6VrnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uq8pN1dY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aNYFM1Oz; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uq8pN1dY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aNYFM1Oz"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B2B7913801CB
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 17 Dec 2024 01:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734417858;
	 x=1734504258; bh=jm5UI4q0nAlJk46tBEpCVCm2dBLkLtgPRvbgqg58MAQ=; b=
	uq8pN1dYGGaqik+T6JgGroFj587xubTlJ4gzSNj+hYeT1EkEN9lshoNBSTQI/5xv
	RqXm0MFwca+Y+vUEI7v4j8V1dlN+/8vREPMFG4EOW+9se/8ZrBKvUwOBNwx4zOv+
	28c1Vbi4VWl3epUnlPZML2OMDcvS2NN0lYkz8wQXyMAiSsvuP3O2TqTukmTA0d/6
	mDDZVDs5apTLX4Jb58XSKUOgNRRLcG0roX5h2ZnuXDpZZMuMo1mKCsZiZ2FZ0dj1
	rlRX3SQuYiQpFueHhvSymZbKM1TGIhg/p2qFIdOWGoct7mw9it2vN9tTTbfnzlI4
	3r+li3PrIY1jXlcNCd1WJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734417858; x=
	1734504258; bh=jm5UI4q0nAlJk46tBEpCVCm2dBLkLtgPRvbgqg58MAQ=; b=a
	NYFM1OzMjhgUnCVQzDw6XovRENLE574kciWdSSk7XSFbG202Ua2ihvkBYxXgSBjK
	xceLg/UcbNXy8/sDYuTkxE6jmvJuITd9LpNhrtlvhDzkLUVSkEh0/Gupc96Z1fkR
	ZeWbohw5xodcSfT4EuS21mSW3zpgYmVqJ0jnb3YqDTtUvzyZUpIfir3aDrGBX9k4
	W68XWUf7zV81uBYz1TeVxF095eKus/UPwduwK5GvH4vbahXFoS/MaNogAvc+Zi8f
	Dcfai9CrZJ9lx5DlT5tqM9hoS7AnB2PwFcLr2SQk2KtgWMbg3eYfS5zJAij4mx00
	xsLRTv6sHiWnnTX/3H17A==
X-ME-Sender: <xms:wh1hZy16QhbhkAAEkR9nXIxltvl1xohoPKDM2-ZrwON9UDhBrOElGA>
    <xme:wh1hZ1GPhCMy8wu_s5Xou1uvsu0TBUGR-KzIoymJMJ6ELC8uDyRhQ414pOP_5KE3j
    QA5YqZ8jZNRvzBkyw>
X-ME-Received: <xmr:wh1hZ64jQIwG8ry_LqTkzlJ4voxAYilvvSQpFd4JU60DfiCIkwagu-PSj8u41ogtOoWhZPjDxwkNwgiVC0Ihtrj829tVchuC_xKVm0Vabwd0Z_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeggdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wh1hZz3xqGQ6vCJEXgnLdhjw5efjQK-kjpJUCx5nd5dQE03ud2yrVQ>
    <xmx:wh1hZ1FJKyt8YWTUZCzGkNUMWNSfsSdzEEaw4BadFKIyUIiOmj5cfg>
    <xmx:wh1hZ8-Z35rFMw4aRpHh8RntL6TsyAkQUe6droU0G561Ofdh1VxDmQ>
    <xmx:wh1hZ6kI1pRYVKhNBhyjpdpYN1tsZ4xzSjJ23AQHnsdPN4HwjaMqRg>
    <xmx:wh1hZzMHxMOoPvzRZqujhgpaX3Br_QLMH5BAx81mX0rpRd1dXFosu7yk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d6d1404f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 17 Dec 2024 06:42:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 17 Dec 2024 07:43:52 +0100
Subject: [PATCH 05/14] send-pack: stop using `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-pks-use-the-repository-conversion-v1-5-0dba48bcc239@pks.im>
References: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
In-Reply-To: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Stop using `the_repository` in the "send-pack" subsystem by passing in a
repository when sending a packfile.

Adjust callers accordingly by using `the_repository`. While there may be
some callers that have a repository available in their context, this
trivial conversion allows for easier verification and bubbles up the use
of `the_repository` by one level.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/send-pack.c |  2 +-
 send-pack.c         | 77 ++++++++++++++++++++++++++++-------------------------
 send-pack.h         |  3 ++-
 transport.c         |  2 +-
 4 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 59b626aae8cd8291104d83b5ec201207c97715e8..8d461008e2e860a3de91a69412d66dcbde4d7b96 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -317,7 +317,7 @@ int cmd_send_pack(int argc,
 	set_ref_status_for_push(remote_refs, args.send_mirror,
 		args.force_update);
 
-	ret = send_pack(&args, fd, conn, remote_refs, &extra_have);
+	ret = send_pack(the_repository, &args, fd, conn, remote_refs, &extra_have);
 
 	if (helper_status)
 		print_helper_status(remote_refs);
diff --git a/send-pack.c b/send-pack.c
index 7e8321368379efe2600a1f573e2e4cd5140a008d..772c7683a0157004ede74e56157e3a5d7f082e75 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "config.h"
 #include "commit.h"
@@ -44,10 +42,11 @@ int option_parse_push_signed(const struct option *opt,
 	die("bad %s argument: %s", opt->long_name, arg);
 }
 
-static void feed_object(const struct object_id *oid, FILE *fh, int negative)
+static void feed_object(struct repository *r,
+			const struct object_id *oid, FILE *fh, int negative)
 {
 	if (negative &&
-	    !repo_has_object_file_with_flags(the_repository, oid,
+	    !repo_has_object_file_with_flags(r, oid,
 					     OBJECT_INFO_SKIP_FETCH_OBJECT |
 					     OBJECT_INFO_QUICK))
 		return;
@@ -61,7 +60,8 @@ static void feed_object(const struct object_id *oid, FILE *fh, int negative)
 /*
  * Make a pack stream and spit it out into file descriptor fd
  */
-static int pack_objects(int fd, struct ref *refs, struct oid_array *advertised,
+static int pack_objects(struct repository *r,
+			int fd, struct ref *refs, struct oid_array *advertised,
 			struct oid_array *negotiated,
 			struct send_pack_args *args)
 {
@@ -74,7 +74,7 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *advertised,
 	FILE *po_in;
 	int rc;
 
-	trace2_region_enter("send_pack", "pack_objects", the_repository);
+	trace2_region_enter("send_pack", "pack_objects", r);
 	strvec_push(&po.args, "pack-objects");
 	strvec_push(&po.args, "--all-progress-implied");
 	strvec_push(&po.args, "--revs");
@@ -87,7 +87,7 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *advertised,
 		strvec_push(&po.args, "-q");
 	if (args->progress)
 		strvec_push(&po.args, "--progress");
-	if (is_repository_shallow(the_repository))
+	if (is_repository_shallow(r))
 		strvec_push(&po.args, "--shallow");
 	if (args->disable_bitmaps)
 		strvec_push(&po.args, "--no-use-bitmap-index");
@@ -104,15 +104,15 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *advertised,
 	 */
 	po_in = xfdopen(po.in, "w");
 	for (size_t i = 0; i < advertised->nr; i++)
-		feed_object(&advertised->oid[i], po_in, 1);
+		feed_object(r, &advertised->oid[i], po_in, 1);
 	for (size_t i = 0; i < negotiated->nr; i++)
-		feed_object(&negotiated->oid[i], po_in, 1);
+		feed_object(r, &negotiated->oid[i], po_in, 1);
 
 	while (refs) {
 		if (!is_null_oid(&refs->old_oid))
-			feed_object(&refs->old_oid, po_in, 1);
+			feed_object(r, &refs->old_oid, po_in, 1);
 		if (!is_null_oid(&refs->new_oid))
-			feed_object(&refs->new_oid, po_in, 0);
+			feed_object(r, &refs->new_oid, po_in, 0);
 		refs = refs->next;
 	}
 
@@ -146,10 +146,10 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *advertised,
 		 */
 		if (rc > 128 && rc != 141)
 			error("pack-objects died of signal %d", rc - 128);
-		trace2_region_leave("send_pack", "pack_objects", the_repository);
+		trace2_region_leave("send_pack", "pack_objects", r);
 		return -1;
 	}
-	trace2_region_leave("send_pack", "pack_objects", the_repository);
+	trace2_region_leave("send_pack", "pack_objects", r);
 	return 0;
 }
 
@@ -164,7 +164,8 @@ static int receive_unpack_status(struct packet_reader *reader)
 	return 0;
 }
 
-static int receive_status(struct packet_reader *reader, struct ref *refs)
+static int receive_status(struct repository *r,
+			  struct packet_reader *reader, struct ref *refs)
 {
 	struct ref *hint;
 	int ret;
@@ -172,7 +173,7 @@ static int receive_status(struct packet_reader *reader, struct ref *refs)
 	int new_report = 0;
 	int once = 0;
 
-	trace2_region_enter("send_pack", "receive_status", the_repository);
+	trace2_region_enter("send_pack", "receive_status", r);
 	hint = NULL;
 	ret = receive_unpack_status(reader);
 	while (1) {
@@ -221,10 +222,10 @@ static int receive_status(struct packet_reader *reader, struct ref *refs)
 			if (!strcmp(key, "refname"))
 				report->ref_name = xstrdup_or_null(val);
 			else if (!strcmp(key, "old-oid") && val &&
-				 !parse_oid_hex(val, &old_oid, &val))
+				 !parse_oid_hex_algop(val, &old_oid, &val, r->hash_algo))
 				report->old_oid = oiddup(&old_oid);
 			else if (!strcmp(key, "new-oid") && val &&
-				 !parse_oid_hex(val, &new_oid, &val))
+				 !parse_oid_hex_algop(val, &new_oid, &val, r->hash_algo))
 				report->new_oid = oiddup(&new_oid);
 			else if (!strcmp(key, "forced-update"))
 				report->forced_update = 1;
@@ -271,7 +272,7 @@ static int receive_status(struct packet_reader *reader, struct ref *refs)
 			new_report = 1;
 		}
 	}
-	trace2_region_leave("send_pack", "receive_status", the_repository);
+	trace2_region_leave("send_pack", "receive_status", r);
 	return ret;
 }
 
@@ -293,9 +294,9 @@ static int advertise_shallow_grafts_cb(const struct commit_graft *graft, void *c
 	return 0;
 }
 
-static void advertise_shallow_grafts_buf(struct strbuf *sb)
+static void advertise_shallow_grafts_buf(struct repository *r, struct strbuf *sb)
 {
-	if (!is_repository_shallow(the_repository))
+	if (!is_repository_shallow(r))
 		return;
 	for_each_commit_graft(advertise_shallow_grafts_cb, sb);
 }
@@ -426,13 +427,14 @@ static void reject_invalid_nonce(const char *nonce, int len)
 	}
 }
 
-static void get_commons_through_negotiation(const char *url,
+static void get_commons_through_negotiation(struct repository *r,
+					    const char *url,
 					    const struct ref *remote_refs,
 					    struct oid_array *commons)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 	const struct ref *ref;
-	int len = the_hash_algo->hexsz + 1; /* hash + NL */
+	int len = r->hash_algo->hexsz + 1; /* hash + NL */
 	int nr_negotiation_tip = 0;
 
 	child.git_cmd = 1;
@@ -466,7 +468,7 @@ static void get_commons_through_negotiation(const char *url,
 			break;
 		if (read_len != len)
 			die("invalid length read %d", read_len);
-		if (parse_oid_hex(hex_hash, &oid, &end) || *end != '\n')
+		if (parse_oid_hex_algop(hex_hash, &oid, &end, r->hash_algo) || *end != '\n')
 			die("invalid hash");
 		oid_array_append(commons, &oid);
 	} while (1);
@@ -480,7 +482,8 @@ static void get_commons_through_negotiation(const char *url,
 	}
 }
 
-int send_pack(struct send_pack_args *args,
+int send_pack(struct repository *r,
+	      struct send_pack_args *args,
 	      int fd[], struct child_process *conn,
 	      struct ref *remote_refs,
 	      struct oid_array *extra_have)
@@ -518,17 +521,17 @@ int send_pack(struct send_pack_args *args,
 		goto out;
 	}
 
-	git_config_get_bool("push.negotiate", &push_negotiate);
+	repo_config_get_bool(r, "push.negotiate", &push_negotiate);
 	if (push_negotiate) {
-		trace2_region_enter("send_pack", "push_negotiate", the_repository);
-		get_commons_through_negotiation(args->url, remote_refs, &commons);
-		trace2_region_leave("send_pack", "push_negotiate", the_repository);
+		trace2_region_enter("send_pack", "push_negotiate", r);
+		get_commons_through_negotiation(r, args->url, remote_refs, &commons);
+		trace2_region_leave("send_pack", "push_negotiate", r);
 	}
 
-	if (!git_config_get_bool("push.usebitmaps", &use_bitmaps))
+	if (!repo_config_get_bool(r, "push.usebitmaps", &use_bitmaps))
 		args->disable_bitmaps = !use_bitmaps;
 
-	git_config_get_bool("transfer.advertisesid", &advertise_sid);
+	repo_config_get_bool(r, "transfer.advertisesid", &advertise_sid);
 
 	/* Does the other end support the reporting? */
 	if (server_supports("report-status-v2"))
@@ -554,7 +557,7 @@ int send_pack(struct send_pack_args *args,
 	if (server_supports("push-options"))
 		push_options_supported = 1;
 
-	if (!server_supports_hash(the_hash_algo->name, &object_format_supported))
+	if (!server_supports_hash(r->hash_algo->name, &object_format_supported))
 		die(_("the receiving end does not support this repository's hash algorithm"));
 
 	if (args->push_cert != SEND_PACK_PUSH_CERT_NEVER) {
@@ -596,7 +599,7 @@ int send_pack(struct send_pack_args *args,
 	if (use_push_options)
 		strbuf_addstr(&cap_buf, " push-options");
 	if (object_format_supported)
-		strbuf_addf(&cap_buf, " object-format=%s", the_hash_algo->name);
+		strbuf_addf(&cap_buf, " object-format=%s", r->hash_algo->name);
 	if (agent_supported)
 		strbuf_addf(&cap_buf, " agent=%s", git_user_agent_sanitized());
 	if (advertise_sid)
@@ -646,7 +649,7 @@ int send_pack(struct send_pack_args *args,
 	}
 
 	if (!args->dry_run)
-		advertise_shallow_grafts_buf(&req_buf);
+		advertise_shallow_grafts_buf(r, &req_buf);
 
 	/*
 	 * Finally, tell the other end!
@@ -686,7 +689,7 @@ int send_pack(struct send_pack_args *args,
 	}
 
 	if (args->stateless_rpc) {
-		if (!args->dry_run && (cmds_sent || is_repository_shallow(the_repository))) {
+		if (!args->dry_run && (cmds_sent || is_repository_shallow(r))) {
 			packet_buf_flush(&req_buf);
 			send_sideband(out, -1, req_buf.buf, req_buf.len, LARGE_PACKET_MAX);
 		}
@@ -711,7 +714,7 @@ int send_pack(struct send_pack_args *args,
 			   PACKET_READ_DIE_ON_ERR_PACKET);
 
 	if (need_pack_data && cmds_sent) {
-		if (pack_objects(out, remote_refs, extra_have, &commons, args) < 0) {
+		if (pack_objects(r, out, remote_refs, extra_have, &commons, args) < 0) {
 			if (args->stateless_rpc)
 				close(out);
 			if (git_connection_is_socket(conn))
@@ -724,7 +727,7 @@ int send_pack(struct send_pack_args *args,
 			 * we get one).
 			 */
 			if (status_report)
-				receive_status(&reader, remote_refs);
+				receive_status(r, &reader, remote_refs);
 
 			if (use_sideband) {
 				close(demux.out);
@@ -743,7 +746,7 @@ int send_pack(struct send_pack_args *args,
 		packet_flush(out);
 
 	if (status_report && cmds_sent)
-		ret = receive_status(&reader, remote_refs);
+		ret = receive_status(r, &reader, remote_refs);
 	else
 		ret = 0;
 	if (args->stateless_rpc)
diff --git a/send-pack.h b/send-pack.h
index 7edb80596c7b0edf607ea5cd0f01315106d02b73..d256715681b363d46db284b7ed22658960781571 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -6,6 +6,7 @@
 struct child_process;
 struct oid_array;
 struct ref;
+struct repository;
 
 /* Possible values for push_cert field in send_pack_args. */
 #define SEND_PACK_PUSH_CERT_NEVER 0
@@ -35,7 +36,7 @@ struct option;
 int option_parse_push_signed(const struct option *opt,
 			     const char *arg, int unset);
 
-int send_pack(struct send_pack_args *args,
+int send_pack(struct repository *r, struct send_pack_args *args,
 	      int fd[], struct child_process *conn,
 	      struct ref *remote_refs, struct oid_array *extra_have);
 
diff --git a/transport.c b/transport.c
index 10d820c33353f695691506560f817c7515218139..81ae8243b9a32ab5289149e51a5a4b46340ac1fe 100644
--- a/transport.c
+++ b/transport.c
@@ -932,7 +932,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 		break;
 	case protocol_v1:
 	case protocol_v0:
-		ret = send_pack(&args, data->fd, data->conn, remote_refs,
+		ret = send_pack(the_repository, &args, data->fd, data->conn, remote_refs,
 				&data->extra_have);
 		break;
 	case protocol_unknown_version:

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

