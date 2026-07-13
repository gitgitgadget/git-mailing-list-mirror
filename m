Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206E813B5B3
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 01:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783905133; cv=none; b=XrcAHia4uncdzBoQBiwVI2/QcT+M0x5yMQUsrfkrN/MnPXmySNCMM0kn5gP6qeQj7GdZmQyB3nGVfAAPEOOA9SL4g0L8VeoayklH83oHe/hKLidWoP7osankY2U1HdG1xPZC0aUJUji0p55jJTcYQMRfvQETy0RHFBIGIKKcQ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783905133; c=relaxed/simple;
	bh=cyxAvmpa5fL/hmbHT5/JH1/amA/Ozc9IER11aW/ysgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oigcNJrTxHE5V1BDvVRIlr4TNo2lh+ARANNiwjA5yVJkzYX0SsZ6aYjjLEAxac7pgLFKk8qgYuM9ZAglVrveILZNRkVar0I3OdjbydIvqWjPhOzqAL9h1mwoSECoHmWhPhpLrVGHUTYcChoYzMmhlrdaIhSG0+1FfEc5v7cloAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=grxkOZho; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="grxkOZho"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-664c6304683so2362068d50.2
        for <git@vger.kernel.org>; Sun, 12 Jul 2026 18:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783905131; x=1784509931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jfeeEzlY/ZAGR7FIGksScT9Y0egGjZGAB3tdmQmjcJQ=;
        b=grxkOZho6lG4qU/6WJkD/BgBBz5CKimZJl0kr8s6pfaDuMG6ETEGktwtBOcE4Q5thj
         z7zAr0+vCaavNIADmPBvo7ULcVHEi5drWx38yESDvT0QyU3dYHrU/gb1dJINqc06QFau
         K3VLYf8+kUCWN/va0Qu81U88Zuo12LZDgsggA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783905131; x=1784509931;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jfeeEzlY/ZAGR7FIGksScT9Y0egGjZGAB3tdmQmjcJQ=;
        b=AaBd7CUMdhiOAE+5vilCDL+NJ3tEerF3Z6DQVdmARcK1VQB5lsi+2T7tGTQgVV5zUa
         ecAV2pqNFY5KdkWoU3eVmRQyRAikyNbzNvnsR0VPfIhWSBxxP9S4zShqTlldj5IaDVo6
         azkypoltK9q59vbqOyRj6KMwDW3JL1cJMlK30WinSfWWzdtNg3bJStBCgwYd8nljl6U4
         /pH+NplBcR/5Doj9W3xYLVOUVNeBLGQuXeqRFmxQK/ZQ/Yhh7vXm1D55P+viRyIhhs1c
         QbBhwFqCHJNls47a5rw/4SyS01PbBv4erQWrL0/hYUrmLfCfrEbj6ZxInFBUWG2QqXGE
         9Bkg==
X-Gm-Message-State: AOJu0YxZWgzswEdH7yNHnoV7wDYM+eSaN7ejF4ArZzD+9dZUhobxVN1d
	X6wX5RO2v3Tejiz53OI5BvuGsXkJaGoV3h5cYMKz4cenIKZ4M5N5zE9ZyassWlI7uJg5DB41XHm
	dKUeObyKQYQ==
X-Gm-Gg: AfdE7cnDra4KXpumeaOXiyyGmWQJL27wlulXv7Cm3E2Wdy0KIBicno5H3bv4pYzTTGj
	poDcNGBzgNuikV6XE9zckPPjlsDO2YYV52H3C6IHHNjfGg5GAyFvDQvkFKRPQBl0YbDQSgmiRIb
	w1/EOOxXvUGzuD6HpMuJGT+9xmEYyXLNwIsS+oPueFTyjMznlme2FTMU8qlAYHYFcOBuvWdwJVg
	/E+j8W0cdhdG70/xc2iwic3NqP0f37K7dZdM+qnUQlo1EF+RH+ub4cT1xGhIWor3JeXzhC2tdaJ
	XDxuhatY1yivcoCmqgHTne7vvQmXqe7rKciUb8ACOBTOhRApgI7SJA8UlOV0sGmszAL1zYD6g18
	xKx2JvqxhyHkcqxzL9kJRSk4YWQoHOnDJV50d5E6UrXzhm1ZozRVZc89vd0vrcB0OVd4p68KfSG
	asXA9UAdUd1KaLlcf2TOXo3Q8riHDjKHCb
X-Received: by 2002:a05:690e:4510:10b0:664:eb60:f60e with SMTP id 956f58d0204a3-667d7c7deadmr3816672d50.65.1783905131014;
        Sun, 12 Jul 2026 18:12:11 -0700 (PDT)
Received: from com-79390 ([12.187.141.7])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-667c2efa583sm8212833d50.15.2026.07.12.18.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 18:12:10 -0700 (PDT)
Date: Sun, 12 Jul 2026 18:12:07 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] send-pack: honor `no-ref-delta` capability
Message-ID: <alQ7Z8V9gJq2Pq33@com-79390>
References: <cover.1783905084.git.ttaylorr@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1783905084.git.ttaylorr@openai.com>

Add a 'no-ref-delta' receive-pack capability and teach send-pack to pass
'--no-ref-delta' to 'pack-objects' when the server advertises it.

Keep this separate from 'ofs-delta' so that a server may request that
`send-pack` omit `REF_DELTA` without also accepting `OFS_DELTA`.

Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
 Documentation/gitprotocol-capabilities.adoc | 17 ++++++++++++++---
 builtin/receive-pack.c                      |  5 +++++
 send-pack.c                                 |  4 ++++
 send-pack.h                                 |  1 +
 t/t5516-fetch-push.sh                       | 14 ++++++++++++++
 5 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitprotocol-capabilities.adoc b/Documentation/gitprotocol-capabilities.adoc
index 2cf7735be4..bbe88defdf 100644
--- a/Documentation/gitprotocol-capabilities.adoc
+++ b/Documentation/gitprotocol-capabilities.adoc
@@ -34,9 +34,9 @@ were sent.  Server MUST NOT ignore capabilities that client requested
 and server advertised.  As a consequence of these rules, server MUST
 NOT advertise capabilities it does not understand.
 
-The 'atomic', 'report-status', 'report-status-v2', 'delete-refs', 'quiet',
-and 'push-cert' capabilities are sent and recognized by the receive-pack
-(push to server) process.
+The 'atomic', 'report-status', 'report-status-v2', 'delete-refs',
+'no-ref-delta', 'quiet', and 'push-cert' capabilities are sent and
+recognized by the receive-pack (push to server) process.
 
 The 'ofs-delta' and 'side-band-64k' capabilities are sent and recognized
 by both upload-pack and receive-pack protocols.  The 'agent' and 'session-id'
@@ -174,6 +174,17 @@ The server can send, and the client can understand, PACKv2 with delta referring
 its base by position in pack rather than by an obj-id.  That is, they can
 send/read OBJ_OFS_DELTA (aka type 6) in a packfile.
 
+no-ref-delta
+------------
+
+The receive-pack server can request, and the client can send, PACKv2
+without deltas referring to their bases by an obj-id. That is, the
+client MUST NOT send OBJ_REF_DELTA (aka type 7) in a packfile when the
+server advertises this capability.
+
+This does not imply that the server understands OBJ_OFS_DELTA entries;
+that is negotiated separately with the 'ofs-delta' capability.
+
 agent
 -----
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 19eb6a1b61..1c516cbdc6 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -66,6 +66,7 @@ static struct strbuf fsck_msg_types = STRBUF_INIT;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int advertise_atomic_push = 1;
+static int advertise_no_ref_delta;
 static int advertise_push_options;
 static int advertise_sid;
 static int unpack_limit = 100;
@@ -290,6 +291,8 @@ static void show_ref(const char *path, const struct object_id *oid)
 			strbuf_addstr(&cap, " atomic");
 		if (prefer_ofs_delta)
 			strbuf_addstr(&cap, " ofs-delta");
+		if (advertise_no_ref_delta)
+			strbuf_addstr(&cap, " no-ref-delta");
 		if (push_cert_nonce)
 			strbuf_addf(&cap, " push-cert=%s", push_cert_nonce);
 		if (advertise_push_options)
@@ -2631,6 +2634,8 @@ int cmd_receive_pack(int argc,
 		OPT_HIDDEN_BOOL(0, "http-backend-info-refs", &advertise_refs, NULL),
 		OPT_ALIAS(0, "advertise-refs", "http-backend-info-refs"),
 		OPT_HIDDEN_BOOL(0, "reject-thin-pack-for-testing", &reject_thin, NULL),
+		OPT_HIDDEN_BOOL(0, "advertise-no-ref-delta-for-testing",
+				&advertise_no_ref_delta, NULL),
 		OPT_END()
 	};
 
diff --git a/send-pack.c b/send-pack.c
index 3bb5afc687..2beb1c4be9 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -80,6 +80,8 @@ static int pack_objects(struct repository *r,
 		strvec_push(&po.args, "--thin");
 	if (args->use_ofs_delta)
 		strvec_push(&po.args, "--delta-base-offset");
+	if (args->no_ref_delta)
+		strvec_push(&po.args, "--no-ref-delta");
 	if (args->quiet || !args->progress)
 		strvec_push(&po.args, "-q");
 	if (args->progress)
@@ -570,6 +572,8 @@ int send_pack(struct repository *r,
 		allow_deleting_refs = 1;
 	if (server_supports("ofs-delta"))
 		args->use_ofs_delta = 1;
+	if (server_supports("no-ref-delta"))
+		args->no_ref_delta = 1;
 	if (server_supports("side-band-64k"))
 		use_sideband = 1;
 	if (server_supports("quiet"))
diff --git a/send-pack.h b/send-pack.h
index 13850c98bb..30be2be0f2 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -28,6 +28,7 @@ struct send_pack_args {
 		force_update:1,
 		use_thin_pack:1,
 		use_ofs_delta:1,
+		no_ref_delta:1,
 		dry_run:1,
 		/* One of the SEND_PACK_PUSH_CERT_* constants. */
 		push_cert:2,
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 1b986349a8..c00074afe8 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1548,6 +1548,20 @@ EOF
 	git push --no-thin --receive-pack="$rcvpck" no-thin/.git refs/heads/main:refs/heads/foo
 '
 
+test_expect_success 'push honors no-ref-delta capability' '
+	test_commit no-ref-delta &&
+
+	rcvpck="git receive-pack --advertise-no-ref-delta-for-testing" &&
+
+	GIT_TRACE2_EVENT="$PWD/no-ref-delta" \
+	git push --receive-pack="$rcvpck" no-thin/.git \
+		refs/heads/main:refs/heads/bar &&
+
+	test_subcommand git pack-objects --all-progress-implied --revs \
+		--stdout --thin --delta-base-offset --no-ref-delta -q \
+		<no-ref-delta
+'
+
 test_expect_success 'pushing a tag pushes the tagged object' '
 	blob=$(echo unreferenced | git hash-object -w --stdin) &&
 	git tag -m foo tag-of-blob $blob &&
-- 
2.55.0
