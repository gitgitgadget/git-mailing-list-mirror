Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 948081F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeCORcN (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:32:13 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:52865 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752410AbeCORcM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:32:12 -0400
Received: by mail-ua0-f201.google.com with SMTP id p30so4734663uap.19
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=B5/zRxWjj/ESKrPKqKKq6HkXzJQDQtKN4I18zShM2HY=;
        b=gLQYbzxAKDEjMYiSUx+4fvU5oFcbGDxHu/6k8sdxUidDjVBz1gi2cw26kYx2omqokh
         AcltUYzSBLmmPS0cWkJT6mzkqhzXqB9c/DbT0NOaWYE0Ed6fI8laOxI0UOJvuk51RPEl
         qXITPb4Q0j7xBsolQckPcnLePKFTBTYclXY5Jx+10brdVIk/VhWvxQ6P2DItn7xkxug8
         tmi4Y+iT+q7rLhQw5Qbec+JD9lsrhErEe5NBLsW6ZuAQSPGL3wXYJIQ8dfAY3kkA9DBV
         SN/LhwgviNF/OR8CduPZlA3hpZzrQ48S6VWB5WKWFYalumahTwmCYCv6VlWkGK4NaEqD
         bPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=B5/zRxWjj/ESKrPKqKKq6HkXzJQDQtKN4I18zShM2HY=;
        b=RBiYfawwYm/YBy5gh3VtfXe/AoG9FGKnUYqQkIrgHyq2EbizP4npwLQ0Q6r1lmqKql
         W1o+stNEZDzZHUWRWPlYPEaYqcE9XH94KsOuVAv7Z7N6f3mg2aLiLj68gASDS+6Ss4SH
         0pFRmO4YI/7hHt8yEBZ5VnJq1hmfBCdukxCzEzc2xR9dHnGIIkXlXt1paMAneFPiLQpp
         vQuVkMN/DTYWBjvESSOwWIa2WMmiyJLoYpZcnL4v4NdhtO/Uwjax0Fn7/aCewqmLE+aB
         jqaKlkVB5O0GlHFfTdYvPJlFI5W5IvW+o5ArbVgXvHz5RwyodKjCrFwrY767CrPtb01V
         W5GQ==
X-Gm-Message-State: AElRT7FtxP0YnI4+HyiuD5G/5UelUNjTp8fs7+ot2uxlP29NzwONNoaQ
        m1UKwzSozIy7aMc/4hUH3kkt5fJyfvlXRfvmUk+Y4S7nUkljxnVP7IGkmDlM3oMAcYLmMgfYXRD
        E0SvIx7Uk/2C1NUQUzRlRZiMeGD0bUaiglyB0noAvyenwyf6UUv1Z5+InoA==
X-Google-Smtp-Source: AG47ELv2oibwYWYVd/ZnSSw+XxqS1QEbhlQEX2gEZw6si8WpVNDhrztw54q/a11SFEwNTySi1x33ovRnVXM=
MIME-Version: 1.0
X-Received: by 10.159.49.199 with SMTP id w7mr1260746uad.22.1521135131034;
 Thu, 15 Mar 2018 10:32:11 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:17 -0700
In-Reply-To: <20180315173142.176023-1-bmwill@google.com>
Message-Id: <20180315173142.176023-11-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 10/35] protocol: introduce enum protocol_version value protocol_v2
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

