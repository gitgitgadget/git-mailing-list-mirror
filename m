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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B29C2D0A3
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF31422280
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IHnpAt5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgKBWbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 17:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgKBWbe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 17:31:34 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639BEC061A47
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 14:31:33 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x9so93854pff.10
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 14:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=0quhPvqcttL64DwwfKTdxeJXoaOt/BR6lQ3hKOkcjDU=;
        b=IHnpAt5xmfgsfMyxlpJ62jDK3EHumhxF2M4sOOf2UAn20pKZbf/Rftfe+FScI8lBbJ
         1FGip4KGDINbioJ1/9/cxO47v6KkMPS1bksH4MD/XpSZ9Mmp24G7ELap2Mr9GeJ3Qw1n
         mHqgVUPGDeNLu4fdx9wDdkGifF9ZOnmS41aJUE82nTP6uAni9zfNGpGV5S9gTaMhnPaq
         rePLY6seb4obqipo3hg3KMq7wfbUOKbQYzqSk3+rickXPS4WmGkakllAKbD56xfCkPmo
         U89I8xH6stvx7Pz7btT0nOdl9mjp6EEgtiuHy0pDPSbfnJoAW0JYmjUVWPCxzsqZD9TE
         1Adg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=0quhPvqcttL64DwwfKTdxeJXoaOt/BR6lQ3hKOkcjDU=;
        b=UR8/M/lgYs/lmvfn+J4I3tiHFJl7gq0JZmQAKbatXEZUnkq76+Wr9Z6FRj+avolKVD
         IBvmpUAhDIkxkMWEQQx2MsdUR3C8nej6M4outnZgIUW+kQUKa1SlUq98/rVvnPDdgI6n
         nE0+PZmJNGDED3gW0dFG2q0T+lGJMPryUKqX23L2VLVDfU/qTJQsnUAtQANj73Ydtgcv
         4eSYICjdrxNj567qrQr7P3OTxrooLs5uiJuRUqxb4qsjWkc/0DQ79/QuOufTsgSD+HGH
         Za3njhxCRQ00WJQTJkuzMEcgwkUSoRM6X/sZDtPd5YMq72WWI/g+yYy0SXl0yyfj9jGa
         iJFg==
X-Gm-Message-State: AOAM533Ep4+zJuHcslpsySaUKMuQscszFy2thPsee3T0TWNU/ndtCrvh
        3pV74Tv7nBvS+PlGllmrbBA9ERU0zFQHGrsa4hAqwLuqkSTZr6ItHhuHOogaISZQ/ueuwoH+Uel
        v770E8LbYGtRUWCjSBmQ6fOv+j7czQFJSVgreRGjl48xnamrHqMeAP8zfptyZw3I=
X-Google-Smtp-Source: ABdhPJx6IZJ1BIGNjfr+B1pdbCBxM5F7mTwNFPDR2xpPAGbB9mgAswdfwvKswP+/LI/4mFGe6YxrX44Ke1PFLw==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a17:90a:5908:: with SMTP id
 k8mr381823pji.222.1604356292715; Mon, 02 Nov 2020 14:31:32 -0800 (PST)
Date:   Mon,  2 Nov 2020 14:31:09 -0800
In-Reply-To: <cover.1604355792.git.steadmon@google.com>
Message-Id: <c47eddd9df195920d6f8f36d038b79af4aabd293.1604355792.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com> <cover.1604355792.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v2 11/11] receive-pack: log received client trace2 SID
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When receive-pack receives a trace2-sid capability from the client, log
the received session ID via a trace2 data event.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 builtin/receive-pack.c                |  7 +++++++
 t/t5705-trace2-sid-in-capabilities.sh | 20 ++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2fe5a8b4fd..f780a66a52 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2039,6 +2039,7 @@ static struct command *read_head_info(struct packet_reader *reader,
 		if (linelen < reader->pktlen) {
 			const char *feature_list = reader->line + linelen + 1;
 			const char *hash = NULL;
+			const char *client_trace2_sid;
 			int len = 0;
 			if (parse_feature_request(feature_list, "report-status"))
 				report_status = 1;
@@ -2061,6 +2062,12 @@ static struct command *read_head_info(struct packet_reader *reader,
 			}
 			if (xstrncmpz(the_hash_algo->name, hash, len))
 				die("error: unsupported object format '%s'", hash);
+			client_trace2_sid = parse_feature_value(feature_list, "trace2-sid", &len, NULL);
+			if (client_trace2_sid) {
+				char *client_sid = xstrndup(client_trace2_sid, len);
+				trace2_data_string("trace2", NULL, "client-sid", client_sid);
+				free(client_sid);
+			}
 		}
 
 		if (!strcmp(reader->line, "push-cert")) {
diff --git a/t/t5705-trace2-sid-in-capabilities.sh b/t/t5705-trace2-sid-in-capabilities.sh
index 3fad9462d3..15f78cb7d2 100755
--- a/t/t5705-trace2-sid-in-capabilities.sh
+++ b/t/t5705-trace2-sid-in-capabilities.sh
@@ -28,13 +28,17 @@ do
 	'
 
 	test_expect_success "trace2 session IDs not advertised by default (push v${PROTO})" '
-		test_when_finished "rm -rf local tr2-client-events" &&
+		test_when_finished "rm -rf local tr2-client-events tr2-server-events" &&
+		test_when_finished "git -C local push --delete origin new-branch" &&
 		cp -r "$LOCAL_PRISTINE" local &&
 		git -C local pull --no-rebase origin &&
 		GIT_TRACE2_EVENT_NESTING=5 \
 		GIT_TRACE2_EVENT="$(pwd)/tr2-client-events" \
-		git -c protocol.version=$PROTO -C local push origin &&
-		test -z "$(grep \"key\":\"server-sid\" tr2-client-events)"
+		git -c protocol.version=$PROTO -C local push \
+			--receive-pack "GIT_TRACE2_EVENT=\"$(pwd)/tr2-server-events\" git-receive-pack" \
+			origin HEAD:new-branch &&
+		test -z "$(grep \"key\":\"server-sid\" tr2-client-events)" &&
+		test -z "$(grep \"key\":\"client-sid\" tr2-server-events)"
 	'
 done
 
@@ -58,13 +62,17 @@ do
 	'
 
 	test_expect_success "trace2 session IDs advertised (push v${PROTO})" '
-		test_when_finished "rm -rf local tr2-client-events" &&
+		test_when_finished "rm -rf local tr2-client-events tr2-server-events" &&
+		test_when_finished "git -C local push --delete origin new-branch" &&
 		cp -r "$LOCAL_PRISTINE" local &&
 		git -C local pull --no-rebase origin &&
 		GIT_TRACE2_EVENT_NESTING=5 \
 		GIT_TRACE2_EVENT="$(pwd)/tr2-client-events" \
-		git -c protocol.version=$PROTO -C local push origin &&
-		grep \"key\":\"server-sid\" tr2-client-events
+		git -c protocol.version=$PROTO -C local push \
+			--receive-pack "GIT_TRACE2_EVENT=\"$(pwd)/tr2-server-events\" git-receive-pack" \
+			origin HEAD:new-branch &&
+		grep \"key\":\"server-sid\" tr2-client-events &&
+		grep \"key\":\"client-sid\" tr2-server-events
 	'
 done
 
-- 
2.29.1.341.ge80a0c044ae-goog

