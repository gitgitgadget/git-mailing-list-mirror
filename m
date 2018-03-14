Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D93171F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbeCNScn (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:32:43 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:54161 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752588AbeCNScl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:32:41 -0400
Received: by mail-io0-f201.google.com with SMTP id t27so3520082iob.20
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=B5/zRxWjj/ESKrPKqKKq6HkXzJQDQtKN4I18zShM2HY=;
        b=duIJRA6fksX9PIsNTpl0oc6A8YHxl7CPJsxtyONPHHpd+AlwYUqulObAIhAY6+pdh5
         vqiZho0yI5rSzi9QcuSCYgeC4W8xa5xcKKDbeunrPAXqzZChie8Z75AW0WDEAkNJf/wm
         rHBfpG8MBQaDT8l74EYKBjbpXIE/uoE7yGSeccocNo49ZlLoIkTdVJ7SClJxcfvMLnq4
         9fMfOEOEkbI/qXE9H3k8YMfmwx6yFt/8AnvTaf5Gxhvyhx6xU4t3nmPteetf2VrHob0b
         h2Bv4WJhmlWPbZY/1kFHbFM3CYv/B+j1jZatkmJaf/3OFl6pyq4R3PU7e9hvTQS9SVGy
         /wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=B5/zRxWjj/ESKrPKqKKq6HkXzJQDQtKN4I18zShM2HY=;
        b=gSOONoHn/VaywjrenBTqTmwGGY3cyV2b7gVu4TphUhCniU6L5GBxxYWILOia815gjU
         7Y2zneNYOzrQovSsMvUcrwF//ETlOq6PGrHFniszN8+k0851l2Vn6kFH8zemAGBHn1fc
         q7olMRSR5FqYfZLrHVfbajyJuPAu8Au9gZ9oJmFMIagTN1gLTNNu92C9XjoDktya6t4w
         ew/vdq1iVtqAtzoOFE8bRNrq1Xlo3fuLlfs5eI6CNhcLwYg3hkKbw+GlYQj+omr0iVa7
         U/PVfD6g4P5NLJWV8ZT5Gm3gibBzOnzYw47WaJdqB6u0YgmgKX7uU96x82tgz0+hq0Ad
         pIGw==
X-Gm-Message-State: AElRT7F012QCwgiDHZQM3wbKIcGZz4g6tJLut12ysEguKQgyCnXPdUcn
        tieKf6MYV0AH2d3YZTlUN6DdfGK1a6ranr5EGl+PtFS1ApVvsQrPOTqIP5jc3kynuMxuz8TblWw
        olPgcPLA7vpYelfoP5aOFzVZa/dm6jY06Hfz8yjPQTXbH9OWt7O4SUHyTQQ==
X-Google-Smtp-Source: AG47ELsw+b1+9lgYhY1hyzfNfx3BNcjk6WyNTCRhX/NXrW9AJ85mLqWNIQyJ/GJSPhqMGeP2FM7NqFlVEzo=
MIME-Version: 1.0
X-Received: by 10.36.73.66 with SMTP id z63mr1365572ita.14.1521052360555; Wed,
 14 Mar 2018 11:32:40 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:31:47 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180314183213.223440-11-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 10/35] protocol: introduce enum protocol_version value protocol_v2
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
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
 builtin/fetch-pack.c   | 2 ++
 builtin/receive-pack.c | 6 ++++++
 builtin/send-pack.c    | 3 +++
 builtin/upload-pack.c  | 7 +++++++
 connect.c              | 3 +++
 protocol.c             | 2 ++
 protocol.h             | 1 +
 remote-curl.c          | 3 +++
 transport.c            | 9 +++++++++
 9 files changed, 36 insertions(+)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 85d4faf76c..b2374ddbbf 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -201,6 +201,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			   PACKET_READ_GENTLE_ON_EOF);
 
 	switch (discover_version(&reader)) {
+	case protocol_v2:
+		die("support for protocol v2 not implemented yet");
 	case protocol_v1:
 	case protocol_v0:
 		get_remote_heads(&reader, &ref, 0, NULL, &shallow);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index b7ce7c7f52..3656e94fdb 100644
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
index 83cb125a68..b5427f75e3 100644
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
index 2cb5cb35b0..8d53e9794b 100644
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
index 0b111e62d7..4b89b984c4 100644
--- a/connect.c
+++ b/connect.c
@@ -83,6 +83,9 @@ enum protocol_version discover_version(struct packet_reader *reader)
 	}
 
 	switch (version) {
+	case protocol_v2:
+		die("support for protocol v2 not implemented yet");
+		break;
 	case protocol_v1:
 		/* Read the peeked version line */
 		packet_reader_read(reader);
diff --git a/protocol.c b/protocol.c
index 43012b7eb6..5e636785d1 100644
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
index 1b2bc94a8d..2ad35e433c 100644
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
index 9f6d07683d..dae8a4a48d 100644
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
index 2378dcb38c..83d9dd1df6 100644
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
2.16.2.804.g6dcf76e118-goog

