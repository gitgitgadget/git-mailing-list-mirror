Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 985FC20954
	for <e@80x24.org>; Mon,  4 Dec 2017 23:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752127AbdLDX73 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 18:59:29 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43478 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751989AbdLDX7T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 18:59:19 -0500
Received: by mail-pf0-f194.google.com with SMTP id e3so9797790pfi.10
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 15:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wVtKsyPkZg4KQhqVjTby1nIXXUpB+YQo2caYRzUuDes=;
        b=mdFLPGBCxCRf3OKYpKegbNibKeFM6kf2CNqPwFjlm3Q8TqnezcAUFHYwvNGKLcZgHd
         CYnQ8j/GrdTERWXLtVtKiXLaWs2itTnFJvAIbMA2Wh0pcolM0/Ez65DaSSk5gAeHRTNO
         8sVApvNqAfHr2PThm6OtChztgGIf6EEq0E9u4A9ThaYBzA2EXGaNp7Prk3574ppsWRC2
         URZopnvxFOY96lHo0z6s+E4cZnxfLaUFmpuh/Y2kDfDWqevBI1jkWj3rvuwBM87EkyeF
         RT9M5Ws/U+XgblPqlIQZUF+IIn86VsHV9jVk4cuZSTfictLok9mFH/aaoKzDHl2oKRyM
         Kqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wVtKsyPkZg4KQhqVjTby1nIXXUpB+YQo2caYRzUuDes=;
        b=tf7/K7lEOnQZlimrzgoWXHNc0Ww2vz5cktnzqKI5kT0rjHw1El27Zj3LH//45GuAkA
         Nuv1L4Mf0LwjGjdWxnSQNtkQuF3gD+8kZqz2Gutj8/N97BJcgc6VvQDjU4eMKUIuNNWK
         n//0xKfEaq+h77whlIH5BDsXda2qhTdYY4szkhWGQqWc4pzUVA9qIZUOImXYFkD0Cwp+
         6RzWk+eEKKvJinSkCDdRZHPI4txWdQvwNZWZS2chHOB2qEmMLrPhRS3BtiE+a4bDY4zI
         9ufzAS1awfrUf8AgJx35y8MUJMTb2Dxv+M7kG+REbVxH/xpHMpO9Qd7wxBHbeC3mRGmq
         ffJw==
X-Gm-Message-State: AJaThX4nlStpJ5dWHi5d71xDHsTJELQuZCFrQh36Ttdp1yI5JY19HuvO
        EdMphjJePHyUMu+JYXTB8qUvTBFuCK4=
X-Google-Smtp-Source: AGs4zMYm9NzsX01GoTHPfN8vyFjTERBte35Tic1A4+Dt5ayN0zKdvqTMJkTH6JIlN5lViLJtheeEwQ==
X-Received: by 10.99.0.86 with SMTP id 83mr15573787pga.326.1512431958535;
        Mon, 04 Dec 2017 15:59:18 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id b187sm24939223pfg.109.2017.12.04.15.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 15:59:17 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [WIP 09/15] transport: store protocol version
Date:   Mon,  4 Dec 2017 15:58:17 -0800
Message-Id: <20171204235823.63299-10-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081-goog
In-Reply-To: <20171204235823.63299-1-bmwill@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
 <20171204235823.63299-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once protocol_v2 is introduced requesting a fetch or a push will need to
be handled differently depending on the protocol version.  Store the
protocol version the serving is speaking in 'struct git_transport_data'
and use it to determine what to do in the case of a fetch or a push.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 transport.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/transport.c b/transport.c
index 28b744ec2..4160c4167 100644
--- a/transport.c
+++ b/transport.c
@@ -118,6 +118,7 @@ struct git_transport_data {
 	struct child_process *conn;
 	int fd[2];
 	unsigned got_remote_heads : 1;
+	enum protocol_version version;
 	struct oid_array extra_have;
 	struct oid_array shallow;
 };
@@ -198,7 +199,8 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 
 	packet_reader_init(&reader, data->fd[0], NULL, 0);
 
-	switch (discover_version(&reader)) {
+	data->version = discover_version(&reader);
+	switch (data->version) {
 	case protocol_v1:
 	case protocol_v0:
 		get_remote_heads(&reader, &refs,
@@ -219,7 +221,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 {
 	int ret = 0;
 	struct git_transport_data *data = transport->data;
-	struct ref *refs;
+	struct ref *refs = NULL;
 	char *dest = xstrdup(transport->url);
 	struct fetch_pack_args args;
 	struct ref *refs_tmp = NULL;
@@ -245,10 +247,18 @@ static int fetch_refs_via_pack(struct transport *transport,
 	if (!data->got_remote_heads)
 		refs_tmp = get_refs_via_connect(transport, 0);
 
-	refs = fetch_pack(&args, data->fd, data->conn,
-			  refs_tmp ? refs_tmp : transport->remote_refs,
-			  dest, to_fetch, nr_heads, &data->shallow,
-			  &transport->pack_lockfile);
+	switch (data->version) {
+	case protocol_v1:
+	case protocol_v0:
+		refs = fetch_pack(&args, data->fd, data->conn,
+				  refs_tmp ? refs_tmp : transport->remote_refs,
+				  dest, to_fetch, nr_heads, &data->shallow,
+				  &transport->pack_lockfile);
+		break;
+	case protocol_unknown_version:
+		BUG("unknown protocol version");
+	}
+
 	close(data->fd[0]);
 	close(data->fd[1]);
 	if (finish_connect(data->conn))
@@ -548,7 +558,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 {
 	struct git_transport_data *data = transport->data;
 	struct send_pack_args args;
-	int ret;
+	int ret = 0;
 
 	if (!data->got_remote_heads)
 		get_refs_via_connect(transport, 1);
@@ -573,8 +583,15 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	else
 		args.push_cert = SEND_PACK_PUSH_CERT_NEVER;
 
-	ret = send_pack(&args, data->fd, data->conn, remote_refs,
-			&data->extra_have);
+	switch (data->version) {
+	case protocol_v1:
+	case protocol_v0:
+		ret = send_pack(&args, data->fd, data->conn, remote_refs,
+				&data->extra_have);
+		break;
+	case protocol_unknown_version:
+		BUG("unknown protocol version");
+	}
 
 	close(data->fd[1]);
 	close(data->fd[0]);
-- 
2.15.1.424.g9478a66081-goog

