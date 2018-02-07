Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC98C1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 01:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932212AbeBGBNl (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:13:41 -0500
Received: from mail-qt0-f201.google.com ([209.85.216.201]:53167 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932208AbeBGBNj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:13:39 -0500
Received: by mail-qt0-f201.google.com with SMTP id z13so3029424qtb.19
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=6s7g3A2zvxRKiokMPqwE2mERgJ1017ZccBj57cXJANU=;
        b=nstZyDC8dz7eUktYYEdi7U5/XSF4SRpFygVGLOtX6JSV4AwrYmMW7+DWncOA/svD51
         XUYi/C5xoyAREBeRoPlrntllTRzfEpNAm9e0W5GjoRqPq3JZ81vGRZaESrSSN7JkBGW9
         vGXAbpTUqOkPSb1OuAwK+eh0gLps/DC9c3J4293RPLQ4lp7P7RKGgubL2QTKqjgJCs4Y
         D+NTOSBg0LCCcvu1U/2EggdC3er+4/UnHFcKuCtMoURGW4L/WNCHea2FKB/bqy7u26u8
         4PPtn7p1ILkn+VP9Kzl7S5bO0LKHAxUzF2PuS4zTLhxASqmfMCk5Z7WRCnP8gg54+ajw
         bfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=6s7g3A2zvxRKiokMPqwE2mERgJ1017ZccBj57cXJANU=;
        b=qP9J4rYpyDORJj85Qq67PLBIX8fdQUxiNHOvbQHzt+MstlZ5NU8YW40ubGt1oh0kQz
         BS5Rb+Nv3cOgZazGQxlvxlpyF9NJ/LHOiEh8954FZC7NCI6ARpLHZqKqRoLuWH0PQh0t
         DICIOLK824poxHrN5nBOTbyr3ZyQJQ8B6npN9MKsYWLueWeC9RVBDDf/ORQVdMIu4w2W
         pyPygoiNfxisTjNw/Voj2EFoHrzjPmozsE6mxiruz1uzykPYdQFew2pv9JJHUGzvxM4D
         KxChQam+5dK5salirLm1r38qhx8WhJjuG3LHJptXmmGGbh5BOg6ay1jv69JitIf2TPt8
         d5Pg==
X-Gm-Message-State: APf1xPCpMRsIjj/PJhfqEVfl3EuWjjLXFNiuGOeUyJmhzZmjyufpNmpn
        d2B3aiycHfWSD3Tpyp9kCPoaUbfsc1Gck2oiiCtFHUDhHkMgNHojYC1Y3jllIpIq086BiODiQMh
        kvwxGZCeEYziS3Tu3YjPTEig5WpPv7yqRpNPG5hsOPZfXCLeCzfrZ45ziMQ==
X-Google-Smtp-Source: AH8x227XLXcCJidHyRXur98No/sJXVELbCqJJ8/sT6XnxGoSSLnHt/2mUb6lEb4u0EMmDTXUc/yJUnv+7yE=
MIME-Version: 1.0
X-Received: by 10.237.36.182 with SMTP id t51mr3368468qtc.12.1517966018648;
 Tue, 06 Feb 2018 17:13:38 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:12:47 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-11-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 10/35] protocol: introduce enum protocol_version value protocol_v2
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
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

