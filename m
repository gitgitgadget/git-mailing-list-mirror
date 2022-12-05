Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167B8C4332F
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 17:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiLERwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 12:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbiLERvk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 12:51:40 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BC01081
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 09:50:47 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bs21so19828723wrb.4
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 09:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCR2+6odN8ReYZxWt0ja68XfOzXoM3qdriRpywDUfYw=;
        b=nJ0Ta9Pmt/4okxbum/xu3BiaClWqd1rzCJi1FocfP9cXW1q99wgN5n42PXUkmanO41
         pV4lxpsZHIv9HHYFHevj8XB/7PLFFUe3TD+GIaYKwn/tHT8ws7hKGDwHEUlxWGF/5vtl
         FbemQmlCHmPrjywwHh8PFvdrEtIGoXUx1K4wVMItR6cymhKyJkhmvGY8Swzkcfq1xFu/
         aNaEIGCZ7ThIk3+T8Ny39EtVldL+8N63MX33lZw+5lb9GKU7+MhB8wzs6E/44nk6lae/
         aTvfWQWpsu7NlzXwg8mbjmLJjMCcs632F4Av2Zm96xpFLIhvxlhR/9OqQZm4CnfAQKiG
         2y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HCR2+6odN8ReYZxWt0ja68XfOzXoM3qdriRpywDUfYw=;
        b=39mVgzCncHCFHnLUV20hgRlHsuF+mq3laSxnxeaMTvk6mkVoD7HU6b9tiGLXnRDNM7
         ky6VUClD6RjCSRvfTDPoz1MtmUdXd+NbOdcehsZolGj4uotfk5fgRzui5wmqCGZNBiAW
         762esbORLl/02Q58pQCeYzQBomYhQnwZ5tvXx+4U79PsN5fdMWh5LLLez595FYzeKcFB
         TkJoNsIBm23KpU5YFQ8B6glvqOvE2z+duwGtCpRTFLzKhYnNqzWD7QgY+Y1dYiYtdO+s
         v7L1MQle2VNZ5KG6lUS3BCigWESEElTqWaz0CtadJNVOhDk+T+a+lYpA0Tmboouq7hfA
         dGgg==
X-Gm-Message-State: ANoB5pnjRr9EXlQv3EXL9l/vN95zjMRKpfeJLnywrJRcvyos8wCT15Mq
        OeWPEjAGIrno17cuDs8MNsxG38BaJq0=
X-Google-Smtp-Source: AA0mqf7adApuABaNTGK7/bprMl9WZGOEAOX0eEKyO3Bq5hYv4rjaIuYNDKo+KVdC1SGh0QwKsq4IBQ==
X-Received: by 2002:adf:eb0c:0:b0:236:6deb:4498 with SMTP id s12-20020adfeb0c000000b002366deb4498mr52274538wrn.52.1670262645409;
        Mon, 05 Dec 2022 09:50:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l41-20020a05600c1d2900b003d1e4f3ac8esm626969wms.33.2022.12.05.09.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 09:50:45 -0800 (PST)
Message-Id: <b009b4f58ea312e40af385ea5ca7ede5ea07391a.1670262639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
References: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
        <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Dec 2022 17:50:33 +0000
Subject: [PATCH v3 05/11] transport: rename got_remote_heads
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>,
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
index 9f9e38d66dd..a2281d95262 100644
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

