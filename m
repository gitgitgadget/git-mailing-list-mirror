Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4400EC388F9
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2CFA22280
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ufE8ThDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgKBWb1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 17:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgKBWbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 17:31:25 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7EEC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 14:31:25 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id o129so6922000yba.12
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 14:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=BNVRd5T93it6JWEErW0CeCqhga9rTnheZQpf84NSHvg=;
        b=ufE8ThDGG7+n5/BuQd5LFAQf8lCKzz/it1nB/kU94+pMLB3IZEgtZRFm+s73mUwnpH
         3E1hWH0DZFrRGj7R5WYNzmt+i8TCdnlWaj6/YPGeweo2MGYgQeReREgpabNqs0BHjcHC
         Cogfst/S65MTJZwROZWv444nU6n6E1camO51HwzEdeVimphugQ4tAOKscPGAq/wyvgDi
         CxqHFeL4RioJbl3OuIgdZIZBV7U9K8l1uZlHYrp9AJ4OpdRV3DVxcL3lv70+3JkXIIBR
         pXoxbFazX+zFLtXXDyPEPNpmAwx32MDz2qI8lBBWBKhfR/H0QGEH6fqm21SHFGEIeSP2
         4uiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=BNVRd5T93it6JWEErW0CeCqhga9rTnheZQpf84NSHvg=;
        b=RYJ64rUCbKQCvP8rH5hcqyd+ns2Gdqb+cUFwSr0WzvzhzE+EkGMyuPz18MOyW+lyJe
         eHaz+ptvER/uWs62LIf9acANv6VAWRwNKOjyft5n86gdLIYI6UMAzctBershhYzXKR1L
         ddJG9UnRvWqRFHQuwDkLup2p4UQy1wY4Iy+Co1tICw5Ig8DlrBOvxA/pBOAZFl6MR1po
         CM7LV1yTsAAyXJx2oDcdntxYCvY7jU8wPJFolFSJ8bW+/BgVVUULZo4rj+unUfrdK/sJ
         1Vx7OD8wnR7wb1hrNWJw8OltlH1vTa4gpy3eWzj6mELXu4BQvEue8gMB1EbH1wQs8bnf
         i2NA==
X-Gm-Message-State: AOAM530ZqBmPSB72YXXx3zhsvXZKrKMan5NeBLP0cNTaERmZIZEWuEl7
        Y5Ry98G+exMJyTobJM9ycM1yNJ3SMt38PicIMfDV11zBvJaB7WUIVCSr0xsfHhayEB218wayzdx
        l0trkT+wT0eI2k/4qmE3+xvIj0D4T2t5S6RN1y/ahFQoJWNOFmaWSjd0uMal4G9o=
X-Google-Smtp-Source: ABdhPJwtYQp6Z1ViOfjetcubMVYH8DpAKGmmwN/apkpYwKeNAJpHMMgK7RItc/9DGbFkqjGRfsrAbPSJbkUPWg==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a25:d7c4:: with SMTP id
 o187mr23835172ybg.363.1604356284966; Mon, 02 Nov 2020 14:31:24 -0800 (PST)
Date:   Mon,  2 Nov 2020 14:31:05 -0800
In-Reply-To: <cover.1604355792.git.steadmon@google.com>
Message-Id: <21bdbf23f39c800b1722c54b666df7a91b5879b5.1604355792.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com> <cover.1604355792.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v2 07/11] transport: log received server trace2 SID
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a client receives a trace2-sid capability from a protocol v0, v1,
or v2 server, log the received session ID via a trace2 data event.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 t/t5705-trace2-sid-in-capabilities.sh | 64 +++++++++++++++++++++++++++
 transport.c                           | 10 +++++
 2 files changed, 74 insertions(+)
 create mode 100755 t/t5705-trace2-sid-in-capabilities.sh

diff --git a/t/t5705-trace2-sid-in-capabilities.sh b/t/t5705-trace2-sid-in-capabilities.sh
new file mode 100755
index 0000000000..0870e78f7c
--- /dev/null
+++ b/t/t5705-trace2-sid-in-capabilities.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+
+test_description='trace2 SID in capabilities'
+
+. ./test-lib.sh
+
+REPO="$(pwd)/repo"
+LOCAL_PRISTINE="$(pwd)/local_pristine"
+
+test_expect_success 'setup repos for trace2 SID capability tests' '
+	git init "$REPO" &&
+	test_commit -C "$REPO" a &&
+	git clone "file://$REPO" "$LOCAL_PRISTINE" &&
+	test_commit -C "$REPO" b
+'
+
+for PROTO in 0 1 2
+do
+	test_expect_success "trace2 session IDs not advertised by default (fetch v${PROTO})" '
+		test_when_finished "rm -rf local tr2-client-events" &&
+		cp -r "$LOCAL_PRISTINE" local &&
+		GIT_TRACE2_EVENT="$(pwd)/tr2-client-events" \
+		git -c protocol.version=$PROTO -C local fetch origin &&
+		test -z "$(grep \"key\":\"server-sid\" tr2-client-events)"
+	'
+
+	test_expect_success "trace2 session IDs not advertised by default (push v${PROTO})" '
+		test_when_finished "rm -rf local tr2-client-events" &&
+		cp -r "$LOCAL_PRISTINE" local &&
+		git -C local pull --no-rebase origin &&
+		GIT_TRACE2_EVENT_NESTING=5 \
+		GIT_TRACE2_EVENT="$(pwd)/tr2-client-events" \
+		git -c protocol.version=$PROTO -C local push origin &&
+		test -z "$(grep \"key\":\"server-sid\" tr2-client-events)"
+	'
+done
+
+test_expect_success 'enable SID advertisement' '
+	git -C "$REPO" config trace2.advertiseSID true &&
+	git -C "$LOCAL_PRISTINE" config trace2.advertiseSID true
+'
+
+for PROTO in 0 1 2
+do
+	test_expect_success "trace2 session IDs advertised (fetch v${PROTO})" '
+		test_when_finished "rm -rf local tr2-client-events" &&
+		cp -r "$LOCAL_PRISTINE" local &&
+		GIT_TRACE2_EVENT="$(pwd)/tr2-client-events" \
+		git -c protocol.version=$PROTO -C local fetch origin &&
+		grep \"key\":\"server-sid\" tr2-client-events
+	'
+
+	test_expect_success "trace2 session IDs advertised (push v${PROTO})" '
+		test_when_finished "rm -rf local tr2-client-events" &&
+		cp -r "$LOCAL_PRISTINE" local &&
+		git -C local pull --no-rebase origin &&
+		GIT_TRACE2_EVENT_NESTING=5 \
+		GIT_TRACE2_EVENT="$(pwd)/tr2-client-events" \
+		git -c protocol.version=$PROTO -C local push origin &&
+		grep \"key\":\"server-sid\" tr2-client-events
+	'
+done
+
+test_done
diff --git a/transport.c b/transport.c
index 47da955e4f..d16be597bd 100644
--- a/transport.c
+++ b/transport.c
@@ -286,6 +286,8 @@ static struct ref *handshake(struct transport *transport, int for_push,
 	struct git_transport_data *data = transport->data;
 	struct ref *refs = NULL;
 	struct packet_reader reader;
+	int sid_len;
+	const char *server_trace2_sid;
 
 	connect_setup(transport, for_push);
 
@@ -297,6 +299,8 @@ static struct ref *handshake(struct transport *transport, int for_push,
 	data->version = discover_version(&reader);
 	switch (data->version) {
 	case protocol_v2:
+		if (server_feature_v2("trace2-sid", &server_trace2_sid))
+			trace2_data_string("trace2", NULL, "server-sid", server_trace2_sid);
 		if (must_list_refs)
 			get_remote_refs(data->fd[1], &reader, &refs, for_push,
 					ref_prefixes,
@@ -310,6 +314,12 @@ static struct ref *handshake(struct transport *transport, int for_push,
 				 for_push ? REF_NORMAL : 0,
 				 &data->extra_have,
 				 &data->shallow);
+		server_trace2_sid = server_feature_value("trace2-sid", &sid_len);
+		if (server_trace2_sid) {
+			char *server_sid = xstrndup(server_trace2_sid, sid_len);
+			trace2_data_string("trace2", NULL, "server-sid", server_sid);
+			free(server_sid);
+		}
 		break;
 	case protocol_unknown_version:
 		BUG("unknown protocol version");
-- 
2.29.1.341.ge80a0c044ae-goog

