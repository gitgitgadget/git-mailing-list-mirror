Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB2431F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964997AbeB1XXz (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:23:55 -0500
Received: from mail-yw0-f202.google.com ([209.85.161.202]:38315 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964944AbeB1XXo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:23:44 -0500
Received: by mail-yw0-f202.google.com with SMTP id p5so2377525ywg.5
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=lHLjKp7nlhuoXvYLe0VIXquKdIwXTdbb324us90o/WU=;
        b=IJs0PnQdPZcpUDCi2Qr20DaHb4IaW9JnyFXodPTdrThsAMOTiunB7xZE06w/Gwgq/b
         HI4nH8Tn0XliO1ST1WOodC5Ug8P/woX/DgaF2kOx4XygVzg13F90WGke7V01Vo6vU1Gt
         gJ/Dn03ofIkAFbr4X0IUq6NJggjFoIF3xg0VJObdlqSDpuvII3vUiAssrcD2stAabols
         RWmNMF844vuEFqi6+cbPycVewBq3kuc9KoijcXvLXQj3L7jYos5/7n36NSxHQyFoBMFv
         x5ulls6LnYPJDouMGI05jfFIRPhsTp8ql9AYsTWFIrWo4sYI7xbLJ/hix9QHkSXLxbPU
         v7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=lHLjKp7nlhuoXvYLe0VIXquKdIwXTdbb324us90o/WU=;
        b=DdlpxR7bwgBz4wrmG0NMWBdQE44kuEvcSb8AyBH0HwNpwZa9W2DkFVHxtk5TqqXLY8
         Twr9NYezDH0EkBH1SjAqBOKeNJkh0PlwGcmdWo7koHj/cE0Id4ekM60JL8PWXPs6nRHd
         ZVqkJYhBbde24i3VnbgH58/wsHq4Od/ai1j2IoC2jOEde7eqTTl6nF1sWuO6+tvlcHoC
         H1sXG8TYbQ1qny13xdftcnCEmAhWcy2awWdOsOvVRQQzc8NVxOWxZcBqmK85VrRA0sAS
         FaSHmuN/VpMbA5VN2JE4GXoWfgtoMKX5lHxZX7BtdByP6tCzfXe2mbFxE/89vXM+GNBL
         Ging==
X-Gm-Message-State: APf1xPDtivNL7YWUZiuMNcKfpFYhUEI+xHnaZQjQ3qMs0Wg39htlMFUg
        C2JdtNTt2Zv5csiq2TAMO9hJOWZruqAwLBxJBo0JwI+Gzk7p8wBCg03HKE2Er1Wt+4TdHb8edy+
        fmJBNguELL+gPBR95m+aY01l70ZU1796Xxlq/31hrmXx9r6YH8yiJ5sDuvQ==
X-Google-Smtp-Source: AG47ELvzOH2t9tdsC7rtaxOHm5dfzjO4Z01cmP+u8mgPc98uUo7XmImyeUbr9cnZHTCyf97035gcRv3XsxY=
MIME-Version: 1.0
X-Received: by 10.13.224.7 with SMTP id j7mr10618342ywe.102.1519860223240;
 Wed, 28 Feb 2018 15:23:43 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:27 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-11-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 10/35] protocol: introduce enum protocol_version value protocol_v2
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, Brandon Williams <bmwill@google.com>
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
index 85d4faf76..b2374ddbb 100644
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
index 0b111e62d..4b89b984c 100644
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
2.16.2.395.g2e18187dfd-goog

