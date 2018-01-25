Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21F891F404
	for <e@80x24.org>; Thu, 25 Jan 2018 23:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbeAYX7K (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 18:59:10 -0500
Received: from mail-ot0-f202.google.com ([74.125.82.202]:51562 "EHLO
        mail-ot0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbeAYX7H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:59:07 -0500
Received: by mail-ot0-f202.google.com with SMTP id w72so1098196ota.18
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=6s7g3A2zvxRKiokMPqwE2mERgJ1017ZccBj57cXJANU=;
        b=rw9wYAxRurnCW8Ydag4ZN5jyamU5+YeQWXFGpx8TH+VcImcJhuZuUM3WN3NT1C6Tu0
         zUhdj5VMM4zJjkzDYGm9O8cc8iK/qfvIn0ZZZ8UvvfBjx4DeyuLh3Q28En1wz7MJXH5O
         KcgPBAIn7i8WtkslQCv/Woc89muuGNh709XVSxizroClZt1LDTXrRCZVCZJ9W8VM85UI
         OcgCT/Bk8ViqPEXepC48q5S4vXXdpBu2q0PpFivF3E8MjaRYOiIEgveYOWLNM0EwKnSY
         +LunXzoezR/RBN8nI6PrxwaTAMlmvPEdwblS8groIg4lf7K4L96DJ4hqGaoGdkrSSEVc
         Ofrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=6s7g3A2zvxRKiokMPqwE2mERgJ1017ZccBj57cXJANU=;
        b=TCuP7jFU3SoECS9cexA5e0tOVhaVsuyCFTfFtIG1P5yxWJOsYtzLnXXTH7U7+UN9Os
         Xzrx8Am1pHjI/43HQ7UghACWa1baFBpu2FrxySXkMPbh8x3TN7iEy94czF4HhWOic9SZ
         Z2pijrqb50ohnOMEOKwItdUWvrK/uqvYz3dt0NitP8QBTKL9177cKUpb/11PxonsfzO4
         9pmfw4G/jlnWm+KlOvfNYv9UVAvAR4DKvBUSGHd+ukwvx/2pODoANPUpEza5uuAO6MBY
         oe+1QYmtu5KoMJoFwjW9BZVUoybMkZJhakKRCTVdFqOjJVyMAVtgqfsa9z77G9o7OrMc
         zTVw==
X-Gm-Message-State: AKwxytcQzi3gcvFgtZ/va3r42xwjq85EGXa0pevrBg6S7yu2bUyrgfGy
        zwuYyXRZCXwhnjuaZqzVMZLnjQse7nEdBZO4Kn004IvLu1O3dOZ0e7nbLeJiSsAT9elvI+Yi3Nw
        9+1LuKs6Xo0XjLGMDOfsrgidMWayw0CBW0/xurzlAe/KhZ70+Y9YvI303Xw==
X-Google-Smtp-Source: AH8x227AD7/SsffL4egzIHMMQWipk7WhDHN0csEPF/1dd7EWuZpT+OZf4+BwemOtsdlUuajk0oq140vn1OA=
MIME-Version: 1.0
X-Received: by 10.202.58.135 with SMTP id h129mr9454956oia.122.1516924746340;
 Thu, 25 Jan 2018 15:59:06 -0800 (PST)
Date:   Thu, 25 Jan 2018 15:58:21 -0800
In-Reply-To: <20180125235838.138135-1-bmwill@google.com>
Message-Id: <20180125235838.138135-11-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180125235838.138135-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v2 10/27] protocol: introduce enum protocol_version value protocol_v2
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
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
 builtin/upload-pack.c  | 7 +++++++
 connect.c              | 3 +++
 protocol.c             | 2 ++
 protocol.h             | 1 +
 remote-curl.c          | 3 +++
 transport.c            | 9 +++++++++
 9 files changed, 37 insertions(+)

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
diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index 2cb5cb35b..8d53e9794 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -47,6 +47,13 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 		die("'%s' does not appear to be a git repository", dir);
 
 	switch (determine_protocol_version_server()) {
+	case protocol_v2:
+		/*
+		 * fetch support for protocol v2 has not been implemented yet,
+		 * so ignore the request to use v2 and fallback to using v0.
+		 */
+		upload_pack(&opts);
+		break;
 	case protocol_v1:
 		/*
 		 * v1 is just the original protocol with a version string,
diff --git a/connect.c b/connect.c
index db3c9d24c..f2157a821 100644
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
-- 
2.16.0.rc1.238.g530d649a79-goog

