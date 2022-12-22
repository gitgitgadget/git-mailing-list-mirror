Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E196C10F1D
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 15:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbiLVPOv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 10:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbiLVPO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 10:14:27 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D629B23157
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 07:14:25 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w15so1950397wrl.9
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 07:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXP7ZJ7T/+kkP8EsJl/0WuAJ4TG9ORZbUaFHwLWlnYQ=;
        b=aaeknxAaHcFZlX5DT7xqol49wp62IV3pS5bUuaz7P2HWdJmyZ2/f5r6990VgIrWtiB
         SvYGapynZUWo8N8cVBTw3G5d/5iIChIZsK4j9PvLmOYSHwrs/4gLPbARs08i7+9S51Wc
         GJFhwpqLMNOjcT0qu1jgBdEw8JWLD3V3S3GuXu5suoqPrXAnXnVRHHdSJ0IJIaEcW47T
         dUAzmFxlTxE8tOQpczYxByR1RcaquqFgFviuU2UEbHpqSCLW6XY4SatIOq5YlWdq1oD7
         qLTOQCCkLhblOQVYn45rdul8cqigv3ll34V5Ai8ZrEdRy6gxnk+a30QL18QPX4cc4u1S
         8wpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXP7ZJ7T/+kkP8EsJl/0WuAJ4TG9ORZbUaFHwLWlnYQ=;
        b=iEFxuSxKGPuT5CRncM+j4fcOrXZv5Ql1q/ed2egJWQwrllKhbLD0Z6rHiDJlAldbUP
         7S5mycgfSxZfCnZFtgYPWg21D9ikGxzkTxC5yrCw4wMNGBGmGxu2nfuknIAxP9DdTVDx
         Ist8qyB3tw1KaQh05ojosXMTnyn/Qs8Meyr59WoNOBv1tzya4XEsEIUWEJVwKFverAwj
         91iiBK4d7WE/0x/0FWVNu7jUIMRgvAeFiddFwfqB9uoqCH+i8RsAPESlY4cIoGDKPMA+
         GYgTzdoY9KxIssWMk0ZAlTjfqzXP83LXq2L5ZC1/51aZC2Dv/d+cuUmvhXOL15QJhxMl
         7wiQ==
X-Gm-Message-State: AFqh2kpEWSp1bYDI31PNc25IgdylWHxro1Mn38PkchTzyH0ZgIYZIP5L
        aalk69DyerOmlUReAGWt8d+LGKyQsY0=
X-Google-Smtp-Source: AMrXdXtV0y+/g54OpNhEEiD+s9z0I3LAVVsZo2kWXUrKd1aHIdsfUqBrKYRhsk/ZbyXRQrMV1mm9xg==
X-Received: by 2002:adf:e8c1:0:b0:242:782c:f397 with SMTP id k1-20020adfe8c1000000b00242782cf397mr3568243wrn.25.1671722064243;
        Thu, 22 Dec 2022 07:14:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w14-20020adfee4e000000b002422bc69111sm984577wro.9.2022.12.22.07.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 07:14:23 -0800 (PST)
Message-Id: <8f5a483c32958b8ab2ac6deeef383165e7214260.1671722058.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>
References: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
        <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Dec 2022 15:14:11 +0000
Subject: [PATCH v4 05/11] transport: rename got_remote_heads
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'got_remote_heads' member of 'struct git_transport_data' was used
historically to indicate that the initial server connection was made and
the ref advertisement was returned. With protocol v2, that initial
handshake does not necessarily include the ref advertisement, so this
member is not an accurate name. Thankfully, all uses of the member are
only checking to see if the handshake should take place, not whether or
not some local data has the ref advertisement.

Rename the member to 'finished_handshake' to represent the proper state.
Note that the variable is only set to 1 during the handshake() method.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 transport.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/transport.c b/transport.c
index b4cf2c0252e..757ad552bf3 100644
--- a/transport.c
+++ b/transport.c
@@ -198,7 +198,7 @@ struct git_transport_data {
 	struct git_transport_options options;
 	struct child_process *conn;
 	int fd[2];
-	unsigned got_remote_heads : 1;
+	unsigned finished_handshake : 1;
 	enum protocol_version version;
 	struct oid_array extra_have;
 	struct oid_array shallow;
@@ -345,7 +345,7 @@ static struct ref *handshake(struct transport *transport, int for_push,
 	case protocol_unknown_version:
 		BUG("unknown protocol version");
 	}
-	data->got_remote_heads = 1;
+	data->finished_handshake = 1;
 	transport->hash_algo = reader.hash_algo;
 
 	if (reader.line_peeked)
@@ -421,7 +421,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.negotiation_tips = data->options.negotiation_tips;
 	args.reject_shallow_remote = transport->smart_options->reject_shallow;
 
-	if (!data->got_remote_heads) {
+	if (!data->finished_handshake) {
 		int i;
 		int must_list_refs = 0;
 		for (i = 0; i < nr_heads; i++) {
@@ -461,7 +461,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 			  to_fetch, nr_heads, &data->shallow,
 			  &transport->pack_lockfiles, data->version);
 
-	data->got_remote_heads = 0;
+	data->finished_handshake = 0;
 	data->options.self_contained_and_connected =
 		args.self_contained_and_connected;
 	data->options.connectivity_checked = args.connectivity_checked;
@@ -846,7 +846,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	if (transport_color_config() < 0)
 		return -1;
 
-	if (!data->got_remote_heads)
+	if (!data->finished_handshake)
 		get_refs_via_connect(transport, 1, NULL);
 
 	memset(&args, 0, sizeof(args));
@@ -894,7 +894,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	else
 		ret = finish_connect(data->conn);
 	data->conn = NULL;
-	data->got_remote_heads = 0;
+	data->finished_handshake = 0;
 
 	return ret;
 }
@@ -914,7 +914,7 @@ static int disconnect_git(struct transport *transport)
 {
 	struct git_transport_data *data = transport->data;
 	if (data->conn) {
-		if (data->got_remote_heads && !transport->stateless_rpc)
+		if (data->finished_handshake && !transport->stateless_rpc)
 			packet_flush(data->fd[1]);
 		close(data->fd[0]);
 		if (data->fd[1] >= 0)
@@ -949,7 +949,7 @@ void transport_take_over(struct transport *transport,
 	data->conn = child;
 	data->fd[0] = data->conn->out;
 	data->fd[1] = data->conn->in;
-	data->got_remote_heads = 0;
+	data->finished_handshake = 0;
 	transport->data = data;
 
 	transport->vtable = &taken_over_vtable;
@@ -1150,7 +1150,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->smart_options = &(data->options);
 
 		data->conn = NULL;
-		data->got_remote_heads = 0;
+		data->finished_handshake = 0;
 	} else {
 		/* Unknown protocol in URL. Pass to external handler. */
 		int len = external_specification_len(url);
-- 
gitgitgadget

