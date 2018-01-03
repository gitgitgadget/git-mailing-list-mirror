Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A68661F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751289AbeACAUQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:20:16 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:44239 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751194AbeACAS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:18:56 -0500
Received: by mail-io0-f196.google.com with SMTP id k18so453207ioc.11
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LtPpSRc5ajn5YwoRcj2YxoJpXYThvZlc4Pfqrb8cI2I=;
        b=dVjA9Q/U7CS0qVCPGc/a2Bk6Sx2PIezmGDkxaIc674HoTvta1CMDBwSuCJ9wQIq4uA
         7zdA6fuqEsWtY/ew9QzRWY1eqMvs875n5xYyTgsTeb9KYv+uOE9Uz2NQQkbd8nGEE8SJ
         kJPfiQDV3i/r4O5g6MyAPmtnr2Fh/cRV+a5JNhk6+40WLplvqBGPak9fxVHxMoWs+PPD
         iECuY8a9p9GwRD5OQHLO47AcIQWn2KYNgpOSX5twdgqXFqTB2fGqSda2Jn2QkobBylR1
         tcsp+LokWq3TTY0CdvUstlpgKWXjq2VBhXzOtGcJh/3B8cx5Ja67teel87tvc3QPSWiL
         aN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LtPpSRc5ajn5YwoRcj2YxoJpXYThvZlc4Pfqrb8cI2I=;
        b=Yykq87tBgFuuY6rMBoQ1wrJ9glvO4rJgxsjk2I1jaTa21ARi6u6qoBZ4YsW8EjxmI7
         8Trhx2hr1Gn32JnG2ue0eSv1oxrLagqm47n8zRuYQ4oCtS2OfXwxQ56WaznVVHtA8n9K
         p2Z60u9SQyTEnicMexCYEodm5sTJMle26m3btxqfK68nAN0cuSHeJrYmkX/8rYnDQ4jM
         GNsLQ5t2JYCYrMpI9YQJgIiSwga/XtvlMtzTxFj8fC8tlV47eVpRrseyCYsOpqpK2aD3
         o2+3InTq2XEv+jtWR3f6HdUPFPK3klkOaAW1V0gEUicK6o584lUcQgDnTroVOo/nJxZZ
         iOzA==
X-Gm-Message-State: AKGB3mILsbha0BHkEb6/hUn5k78Xc+7W67w3zpqSvnyv2je2VA9p+9Ad
        yIY/qtYtMoPQuCA/Getd61Oa34b2014=
X-Google-Smtp-Source: ACJfBosGGiSWv79TfHXvrSABX+UUzylKrwwPF5tkm+ejLAAhLHnajW8Dp8J2E69zduZyaNhhz449OQ==
X-Received: by 10.107.195.133 with SMTP id t127mr57512738iof.21.1514938735523;
        Tue, 02 Jan 2018 16:18:55 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q2sm12679ite.17.2018.01.02.16.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:18:54 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 10/26] protocol: introduce enum protocol_version value protocol_v2
Date:   Tue,  2 Jan 2018 16:18:12 -0800
Message-Id: <20180103001828.205012-11-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce protocol_v2, a new value for 'enum protocol_version'.
Subsequent patches will fill in the implementation of protocol_v2.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch-pack.c   | 3 +++
 builtin/receive-pack.c | 6 ++++++
 builtin/send-pack.c    | 3 +++
 connect.c              | 3 +++
 protocol.c             | 2 ++
 protocol.h             | 1 +
 remote-curl.c          | 3 +++
 transport.c            | 9 +++++++++
 upload-pack.c          | 6 ++++++
 9 files changed, 36 insertions(+)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 85d4faf76..f492e8abd 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -201,6 +201,9 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			   PACKET_READ_GENTLE_ON_EOF);
 
 	switch (discover_version(&reader)) {
+	case protocol_v2:
+		die("support for protocol v2 not implemented yet");
+		break;
 	case protocol_v1:
 	case protocol_v0:
 		get_remote_heads(&reader, &ref, 0, NULL, &shallow);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index b7ce7c7f5..3656e94fd 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1963,6 +1963,12 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		unpack_limit = receive_unpack_limit;
 
 	switch (determine_protocol_version_server()) {
+	case protocol_v2:
+		/*
+		 * push support for protocol v2 has not been implemented yet,
+		 * so ignore the request to use v2 and fallback to using v0.
+		 */
+		break;
 	case protocol_v1:
 		/*
 		 * v1 is just the original protocol with a version string,
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 83cb125a6..b5427f75e 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -263,6 +263,9 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 			   PACKET_READ_GENTLE_ON_EOF);
 
 	switch (discover_version(&reader)) {
+	case protocol_v2:
+		die("support for protocol v2 not implemented yet");
+		break;
 	case protocol_v1:
 	case protocol_v0:
 		get_remote_heads(&reader, &remote_refs, REF_NORMAL,
diff --git a/connect.c b/connect.c
index 1787b0212..caa539b75 100644
--- a/connect.c
+++ b/connect.c
@@ -84,6 +84,9 @@ enum protocol_version discover_version(struct packet_reader *reader)
 
 	/* Maybe process capabilities here, at least for v2 */
 	switch (version) {
+	case protocol_v2:
+		die("support for protocol v2 not implemented yet");
+		break;
 	case protocol_v1:
 		/* Read the peeked version line */
 		packet_reader_read(reader);
diff --git a/protocol.c b/protocol.c
index 43012b7eb..5e636785d 100644
--- a/protocol.c
+++ b/protocol.c
@@ -8,6 +8,8 @@ static enum protocol_version parse_protocol_version(const char *value)
 		return protocol_v0;
 	else if (!strcmp(value, "1"))
 		return protocol_v1;
+	else if (!strcmp(value, "2"))
+		return protocol_v2;
 	else
 		return protocol_unknown_version;
 }
diff --git a/protocol.h b/protocol.h
index 1b2bc94a8..2ad35e433 100644
--- a/protocol.h
+++ b/protocol.h
@@ -5,6 +5,7 @@ enum protocol_version {
 	protocol_unknown_version = -1,
 	protocol_v0 = 0,
 	protocol_v1 = 1,
+	protocol_v2 = 2,
 };
 
 /*
diff --git a/remote-curl.c b/remote-curl.c
index 9f6d07683..dae8a4a48 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -185,6 +185,9 @@ static struct ref *parse_git_refs(struct discovery *heads, int for_push)
 			   PACKET_READ_GENTLE_ON_EOF);
 
 	switch (discover_version(&reader)) {
+	case protocol_v2:
+		die("support for protocol v2 not implemented yet");
+		break;
 	case protocol_v1:
 	case protocol_v0:
 		get_remote_heads(&reader, &list, for_push ? REF_NORMAL : 0,
diff --git a/transport.c b/transport.c
index 2378dcb38..83d9dd1df 100644
--- a/transport.c
+++ b/transport.c
@@ -203,6 +203,9 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 
 	data->version = discover_version(&reader);
 	switch (data->version) {
+	case protocol_v2:
+		die("support for protocol v2 not implemented yet");
+		break;
 	case protocol_v1:
 	case protocol_v0:
 		get_remote_heads(&reader, &refs,
@@ -250,6 +253,9 @@ static int fetch_refs_via_pack(struct transport *transport,
 		refs_tmp = get_refs_via_connect(transport, 0);
 
 	switch (data->version) {
+	case protocol_v2:
+		die("support for protocol v2 not implemented yet");
+		break;
 	case protocol_v1:
 	case protocol_v0:
 		refs = fetch_pack(&args, data->fd, data->conn,
@@ -585,6 +591,9 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 		args.push_cert = SEND_PACK_PUSH_CERT_NEVER;
 
 	switch (data->version) {
+	case protocol_v2:
+		die("support for protocol v2 not implemented yet");
+		break;
 	case protocol_v1:
 	case protocol_v0:
 		ret = send_pack(&args, data->fd, data->conn, remote_refs,
diff --git a/upload-pack.c b/upload-pack.c
index 9a507ae53..2bc888fc1 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1104,6 +1104,12 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 	git_config(upload_pack_config, NULL);
 
 	switch (determine_protocol_version_server()) {
+	case protocol_v2:
+		/*
+		 * fetch support for protocol v2 has not been implemented yet,
+		 * so ignore the request to use v2 and fallback to using v0.
+		 */
+		break;
 	case protocol_v1:
 		/*
 		 * v1 is just the original protocol with a version string,
-- 
2.15.1.620.gb9897f4670-goog

