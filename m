Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EE7C2D0A3
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 21:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56C3B20838
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 21:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Scwfs8U9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgJ2Vc5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgJ2Vcy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 17:32:54 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A653C0613D2
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 14:32:54 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id t4so2694104qtd.23
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 14:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=BNVRd5T93it6JWEErW0CeCqhga9rTnheZQpf84NSHvg=;
        b=Scwfs8U9rLRQvCfjCz4CzULg2J/DwDevA/4iF9hvTy+vWpzQMdLUWM1OO5k4u7Ucr1
         r6tSzWDPGINsc8ZvOdaRObuaf8c6zqAMexMFvRySCUupJ8Bf4KBC3RQsttYW1uTC+Rl1
         v0UX+EZ4SlH4Rx4MgyymHtCU2Zj9hwCjfZ60a/CNNoiL67/D8SfKfQxt0GN2vNrlqc+9
         EFKSDtfYvKYTefiGtMULAqeTo6mlM2ahAAKIEoUzR82Jvhex8hjs+89ebRqzdz6lAGfr
         YW1m73/fl4VFq6iEdxLK4O9ZB9ROX9x8nIKnFMaVsWjuM27JaDDmhsGLplbzjBQObqr7
         rASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=BNVRd5T93it6JWEErW0CeCqhga9rTnheZQpf84NSHvg=;
        b=K03mo7BTWMgfTjMMIrmfxsuybEHN0lPAkOL7EGjV5yIaCIHChEZ897Kol3kIghg282
         Han2o1D2mN0PpflYk5lhV7REihohDCL6sQRAdiope1tYnHj7ZaWWfrqZQaPTsAKi9wSt
         81s8N3mBsZwZVAyMHWygSulcqDnrMtHGyvYttr0ZpltF8FcPYzLJD/Ej8KfwFVKwKc/0
         WWo3thsxMbnd9jgJsSxCeFh1f2Ci0wO/CizKNnKYYlrHnqDC6GiOLOm05vMyKfmh7NNl
         73u3aRm+LYSOENwe72P0ypVKj8Gy+ELApcXX0OoVFXAaFZeIQ2DnqcVJOGPAbHg54V10
         cpFw==
X-Gm-Message-State: AOAM531AooDWJixEkLdN9FrJ2giVNz2sg5wprCKOPH/U/WBE6TKtGBHc
        /MTCNj2ZybwRvMSMxB3bo8PJLIG1qOltvZNnpT+42YkzNK9iqS74Gr0ogL3N/0sI5Q5iV5j1EVK
        FzDSDOsCPw/tPfZVf+G5sKWm0/cDVS57W1b1zJPPzj6AKB6NngiBJcv5sbNGwi40=
X-Google-Smtp-Source: ABdhPJzwkkjvoxB8MYf1+Mq8PB5L4XzuYIvY+ZzU1YKd3RmDtJ5W6tF08mRKFh/6mz8MC50X8X0SfrE+VA2zaA==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a0c:b410:: with SMTP id
 u16mr6497624qve.52.1604007173253; Thu, 29 Oct 2020 14:32:53 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:32:36 -0700
In-Reply-To: <cover.1604006121.git.steadmon@google.com>
Message-Id: <1519767eadc396fa8de66c8a60b163f005aac503.1604006121.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 06/10] transport: log received server trace2 SID
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

