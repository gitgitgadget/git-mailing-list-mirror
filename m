Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E67C388F9
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C5A520809
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IZpLjLa5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgKLBcf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgKKXbj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 18:31:39 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A19C061A49
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 15:29:50 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h9so3949852ybj.10
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 15:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=SPTfoDU7oaS1izrTItAOGX8PlPGtVfveZVP2zs6SoLE=;
        b=IZpLjLa550r1zFU7t+n8+E3MV5JxyNQa98o/Z/SBkP70YXbtVdJ1rOVhM/JOZEQm1f
         OnuzfsTBexu+cO+8SAY+GtMzFIdXhKiYWbMzAHI9bRdYPWwchQYOxbcZ0uho/Gs02NsT
         4ZOvN7x3yhAXdoLlK5S9FUMinzn/UHVROcHRXAJPMuKvmlqdxsF+DQrmeuoMqKqvjLNU
         7iz+Qiwjc6vrtue1oypb2hEIWsWDcBr2sGgaJlcM8Cs/t9XMvhg/RmEZc6/kekXiP7Cv
         3rf51ZEHcqjNE3a7fyNWIxG4A4VOt9yVejCpcbN0UhmMnRSlM33xQiiZqV0DBXNxq1Cg
         ANXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=SPTfoDU7oaS1izrTItAOGX8PlPGtVfveZVP2zs6SoLE=;
        b=pFcCW1HZx2XDeiqBryamDn/6QMzqLEBUTwByBsqF5ds0EaQ8o6bCNpTF0UW9n6ny1C
         KdsphUYAHG1oEx+/cdOpuJU/bCuGqMFMYvnZ9wcKYaighs1eR65OyWMFhm/93ZweQF0g
         G+4ZPKBnZDFc9o4YtFGFBhyI27/hddEa0+vV4GauhDd6EOiKc7cmB+/vrn/11LjqoX9G
         dyYP9XRE72qA/rxzKuw2X9l5Gbnvi8B9VsFTG9K0wJqGqUS250mN1+mTuedQlfWwRrt1
         Ulj6qNC1xHgvX+5gYfquYGemVM8l3HdQpu5HOSxQvAuRfCFIYYxqGCDq2chHz1GPCr+b
         LFTA==
X-Gm-Message-State: AOAM533fYmowgJbIUScSGMRlMFY740L8CnWlyE0YVRMT2nwPOjNWAFFA
        7G8sUj2qzrYfLO1Yz0qgvYxby8GL8ghSxnGOg6djXmOuq97ygRMycVZpisE9jF0XW7hpzeKrp4C
        bUmNPFl2zbNb1A+MuoFV07nFHeeVmrof68SjE4908iolwO+tu8Xn9Z3Xm0xGacGE=
X-Google-Smtp-Source: ABdhPJzbtGj223IGG9YX12/P6CXpA5COFw/hnDYYyukQtgi32bINojnd6lhQp1TQkOynAR4UFOwYqlOAJSmVWw==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a25:10c5:: with SMTP id
 188mr37704606ybq.181.1605137389612; Wed, 11 Nov 2020 15:29:49 -0800 (PST)
Date:   Wed, 11 Nov 2020 15:29:30 -0800
In-Reply-To: <cover.1605136908.git.steadmon@google.com>
Message-Id: <014cae8dc1c3e03e149f8abc98f2f1a50bb0cb98.1605136908.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com> <cover.1605136908.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v3 07/11] transport: log received server session ID
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a client receives a session-id capability from a protocol v0, v1,
or v2 server, log the received session ID via a trace2 data event.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 t/t5705-session-id-in-capabilities.sh | 64 +++++++++++++++++++++++++++
 transport.c                           | 10 +++++
 2 files changed, 74 insertions(+)
 create mode 100755 t/t5705-session-id-in-capabilities.sh

diff --git a/t/t5705-session-id-in-capabilities.sh b/t/t5705-session-id-in-capabilities.sh
new file mode 100755
index 0000000000..9e782f4413
--- /dev/null
+++ b/t/t5705-session-id-in-capabilities.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+
+test_description='session ID in capabilities'
+
+. ./test-lib.sh
+
+REPO="$(pwd)/repo"
+LOCAL_PRISTINE="$(pwd)/local_pristine"
+
+test_expect_success 'setup repos for session ID capability tests' '
+	git init "$REPO" &&
+	test_commit -C "$REPO" a &&
+	git clone "file://$REPO" "$LOCAL_PRISTINE" &&
+	test_commit -C "$REPO" b
+'
+
+for PROTO in 0 1 2
+do
+	test_expect_success "session IDs not advertised by default (fetch v${PROTO})" '
+		test_when_finished "rm -rf local tr2-client-events" &&
+		cp -r "$LOCAL_PRISTINE" local &&
+		GIT_TRACE2_EVENT="$(pwd)/tr2-client-events" \
+		git -c protocol.version=$PROTO -C local fetch origin &&
+		test -z "$(grep \"key\":\"server-sid\" tr2-client-events)"
+	'
+
+	test_expect_success "session IDs not advertised by default (push v${PROTO})" '
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
+	git -C "$REPO" config transfer.advertiseSID true &&
+	git -C "$LOCAL_PRISTINE" config transfer.advertiseSID true
+'
+
+for PROTO in 0 1 2
+do
+	test_expect_success "session IDs advertised (fetch v${PROTO})" '
+		test_when_finished "rm -rf local tr2-client-events" &&
+		cp -r "$LOCAL_PRISTINE" local &&
+		GIT_TRACE2_EVENT="$(pwd)/tr2-client-events" \
+		git -c protocol.version=$PROTO -C local fetch origin &&
+		grep \"key\":\"server-sid\" tr2-client-events
+	'
+
+	test_expect_success "session IDs advertised (push v${PROTO})" '
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
index 47da955e4f..679a35e7c1 100644
--- a/transport.c
+++ b/transport.c
@@ -286,6 +286,8 @@ static struct ref *handshake(struct transport *transport, int for_push,
 	struct git_transport_data *data = transport->data;
 	struct ref *refs = NULL;
 	struct packet_reader reader;
+	int sid_len;
+	const char *server_sid;
 
 	connect_setup(transport, for_push);
 
@@ -297,6 +299,8 @@ static struct ref *handshake(struct transport *transport, int for_push,
 	data->version = discover_version(&reader);
 	switch (data->version) {
 	case protocol_v2:
+		if (server_feature_v2("session-id", &server_sid))
+			trace2_data_string("transfer", NULL, "server-sid", server_sid);
 		if (must_list_refs)
 			get_remote_refs(data->fd[1], &reader, &refs, for_push,
 					ref_prefixes,
@@ -310,6 +314,12 @@ static struct ref *handshake(struct transport *transport, int for_push,
 				 for_push ? REF_NORMAL : 0,
 				 &data->extra_have,
 				 &data->shallow);
+		server_sid = server_feature_value("session-id", &sid_len);
+		if (server_sid) {
+			char *sid = xstrndup(server_sid, sid_len);
+			trace2_data_string("transfer", NULL, "server-sid", sid);
+			free(sid);
+		}
 		break;
 	case protocol_unknown_version:
 		BUG("unknown protocol version");
-- 
2.29.2.222.g5d2a92d10f8-goog

