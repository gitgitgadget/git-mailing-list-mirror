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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8579FC4742C
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 287CE20809
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XcUD/VZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgKLBcp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgKKXbm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 18:31:42 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57332C061A4B
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 15:29:54 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id r29so146287qtu.21
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 15:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=EZ1S8he6bsQtn6muv0AwuEDICejKhOzYgoSAnkb6c4g=;
        b=XcUD/VZF50Ozih5mSO9iJFhgKaY4JYohpfeUiDI7hVXbapEcoFQThQdGrF6Bu11wZO
         +uXqRIETXfe9NC2ltFekFeR/oOmUu5be0kEPdeH++KI8YN8jWFyIYuFR2is8ts+pXmTB
         xdoOaLx0LGWzm4KJ/z0mVTID9pdvSdjtEax32xBr/smV0ufEnDXFAkI2IXxW7NQGlNNz
         QjJyqgdhfkwcpZ1Di7PXx+Idx5ahVfjZwQxnDaJIZrZiOfQTOHTU8Yuf7Wd45xW93IiD
         jE+/MfXrv0bzE+gGunvJ7a/b61Jsj4nrccOWt6uWZAADKMj9mgjRCgo/vem4dG/fU+HS
         yOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=EZ1S8he6bsQtn6muv0AwuEDICejKhOzYgoSAnkb6c4g=;
        b=TPBsAo5VDETEegkyGmW8bK1Gbxl9LHiXrm9tgv3dgIGYgjSvSeIJ8EXvWVXcWL6dgk
         54R6pB2TQX8isrcn1WDjejrUKxaNjNLhUBDDS5uDUf6H5eMeQqqg5nkrO0w5H3z1B9Ca
         TELzac3KcIu9wXEL+a/6slV1b1E7ohNsf3JmAmv4wLWx7v0nBv0zc0c7KjiirXlLYquN
         4L+hX4aeUReohU1iqGtsPGdwuAOl3YBmN395wqrVY6Z6/bqzsm/qYatN3wRGQ3w7fWdT
         /xl6S99ilEOVVDwn+azcZD+qpRSBqnB53y4t1GhyWY0hlboz7CvPC5pXlbeh1DCqyzW+
         hl0Q==
X-Gm-Message-State: AOAM533Ey5+K0Mrp/6wkFpB6RWXZ8nYMzAFCJbHkWm9oIawzLg3VXkMD
        6eZ9NFRFPlWWLR66IHuRYnUxNXBdODAOd84c6RLXYFd63GQ7EeAFdD/WsMVUSFxiBnRdbRKagiT
        V+DxbDlOAV0owIUFp9NFFlsbuwOJEGpqpjiDc//EhFWBYSYs6MgTtcEV/Sn1jDeo=
X-Google-Smtp-Source: ABdhPJywprrN3NyD9NBsQqcYov8l4UhyNUD1XOb2AkX5wPyf1Ih1kfjHkTbwnXsz0IwlE+TyoUByqwL619zs2g==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a0c:fca7:: with SMTP id
 h7mr22017304qvq.18.1605137393502; Wed, 11 Nov 2020 15:29:53 -0800 (PST)
Date:   Wed, 11 Nov 2020 15:29:32 -0800
In-Reply-To: <cover.1605136908.git.steadmon@google.com>
Message-Id: <bde9c1d97a295d99d9da867410743b5c237bf7ae.1605136908.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com> <cover.1605136908.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v3 09/11] upload-pack, serve: log received client session ID
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When upload-pack (protocol v0/v1) or a protocol v2 server receives a
session-id capability from a client, log the received session ID via a
trace2 data event.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 serve.c                               |  4 ++++
 t/t5705-session-id-in-capabilities.sh | 18 ++++++++++++------
 upload-pack.c                         |  8 ++++++++
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/serve.c b/serve.c
index 8c0bb84f37..eec2fe6f29 100644
--- a/serve.c
+++ b/serve.c
@@ -201,6 +201,7 @@ static int process_request(void)
 	struct packet_reader reader;
 	struct strvec keys = STRVEC_INIT;
 	struct protocol_capability *command = NULL;
+	const char *client_sid;
 
 	packet_reader_init(&reader, 0, NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
@@ -264,6 +265,9 @@ static int process_request(void)
 
 	check_algorithm(the_repository, &keys);
 
+	if (has_capability(&keys, "session-id", &client_sid))
+		trace2_data_string("transfer", NULL, "client-sid", client_sid);
+
 	command->command(the_repository, &keys, &reader);
 
 	strvec_clear(&keys);
diff --git a/t/t5705-session-id-in-capabilities.sh b/t/t5705-session-id-in-capabilities.sh
index 9e782f4413..afa2159657 100755
--- a/t/t5705-session-id-in-capabilities.sh
+++ b/t/t5705-session-id-in-capabilities.sh
@@ -17,11 +17,14 @@ test_expect_success 'setup repos for session ID capability tests' '
 for PROTO in 0 1 2
 do
 	test_expect_success "session IDs not advertised by default (fetch v${PROTO})" '
-		test_when_finished "rm -rf local tr2-client-events" &&
+		test_when_finished "rm -rf local tr2-client-events tr2-server-events" &&
 		cp -r "$LOCAL_PRISTINE" local &&
 		GIT_TRACE2_EVENT="$(pwd)/tr2-client-events" \
-		git -c protocol.version=$PROTO -C local fetch origin &&
-		test -z "$(grep \"key\":\"server-sid\" tr2-client-events)"
+		git -c protocol.version=$PROTO -C local fetch \
+			--upload-pack "GIT_TRACE2_EVENT=\"$(pwd)/tr2-server-events\" git-upload-pack" \
+			origin &&
+		test -z "$(grep \"key\":\"server-sid\" tr2-client-events)" &&
+		test -z "$(grep \"key\":\"client-sid\" tr2-server-events)"
 	'
 
 	test_expect_success "session IDs not advertised by default (push v${PROTO})" '
@@ -43,11 +46,14 @@ test_expect_success 'enable SID advertisement' '
 for PROTO in 0 1 2
 do
 	test_expect_success "session IDs advertised (fetch v${PROTO})" '
-		test_when_finished "rm -rf local tr2-client-events" &&
+		test_when_finished "rm -rf local tr2-client-events tr2-server-events" &&
 		cp -r "$LOCAL_PRISTINE" local &&
 		GIT_TRACE2_EVENT="$(pwd)/tr2-client-events" \
-		git -c protocol.version=$PROTO -C local fetch origin &&
-		grep \"key\":\"server-sid\" tr2-client-events
+		git -c protocol.version=$PROTO -C local fetch \
+			--upload-pack "GIT_TRACE2_EVENT=\"$(pwd)/tr2-server-events\" git-upload-pack" \
+			origin &&
+		grep \"key\":\"server-sid\" tr2-client-events &&
+		grep \"key\":\"client-sid\" tr2-server-events
 	'
 
 	test_expect_success "session IDs advertised (push v${PROTO})" '
diff --git a/upload-pack.c b/upload-pack.c
index ebb4099268..dcd429dc01 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1058,6 +1058,7 @@ static void receive_needs(struct upload_pack_data *data,
 		const char *features;
 		struct object_id oid_buf;
 		const char *arg;
+		int feature_len;
 
 		reset_timeout(data->timeout);
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
@@ -1110,6 +1111,13 @@ static void receive_needs(struct upload_pack_data *data,
 		    parse_feature_request(features, "filter"))
 			data->filter_capability_requested = 1;
 
+		arg = parse_feature_value(features, "session-id", &feature_len, NULL);
+		if (arg) {
+			char *client_sid = xstrndup(arg, feature_len);
+			trace2_data_string("transfer", NULL, "client-sid", client_sid);
+			free(client_sid);
+		}
+
 		o = parse_object(the_repository, &oid_buf);
 		if (!o) {
 			packet_writer_error(&data->writer,
-- 
2.29.2.222.g5d2a92d10f8-goog

