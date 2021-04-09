Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E742C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 01:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDE7F610C7
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 01:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbhDIBKZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 21:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDIBKY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 21:10:24 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238C8C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 18:10:12 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id g5-20020a17090a7085b02900c0e864bc61so323311pjk.5
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 18:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0p4XllSE8aBFa4fQc7spcXOxtBkighnOA4rj0nIkUxI=;
        b=HV67n9IhGfXgxC+8kv1tHU704lyESp63uqY/RVP/x/0C1VL8C4Uce7RifA40jQEhuE
         NOQzaTyk0Kn9v/kTF/ejX38YFp2oVvFH23mu5tNcIjiwv4eE/i6PM5LHFZ9scW9k3H2l
         7ugXjyLNYRvrt7UeM+R0TlLq1KkAxuxOXtXX5tzA2UU6dKwiwr2ITvMvg/EQD/3X6UPq
         V7KVKQ0kLv6Oh9pLDQXBhM7QtuXxSMSd2Eg4gpplpaZeQ31/+0RRJBde1vwB/EhKUj9i
         5iWWcW7I4Xhcx8Dzu0mrpXiwUJvnCcL4Qgx0YMn0pDK6gUDXRws1kdHDEp5006yVi8cf
         DnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0p4XllSE8aBFa4fQc7spcXOxtBkighnOA4rj0nIkUxI=;
        b=JQr+yWUEZR5MnXESiI4YyF5E2qIfjljJDlb2FrTMZA5FqXrgo3+h8WCHpAqAI+Lfex
         3GJKCoNaqI7wERatXlXQ0SXSY7GgMTmDo4cqFaQ8JNhNEifWO2a/91+A2i+gmeJ3M67P
         T+ZICFOjYnGStEQzJOgEfXtY6zfJufuP44h+tEh6/qAl5RZDACtQjWRFCCYNHH395Nw4
         EtZJ1Ur6WAe7DqMV8NBkJTSs75CyOC8Rdq0aJtm09RJrncJqateNSAQJqpumc9cUDrxy
         7o953mEF58cJ331koYX39wNd9nuV8ZXstJRmUsqzH/weazcMd++iAitaf0sNG9br7TBN
         iZLw==
X-Gm-Message-State: AOAM532rmHZW7IFJW7tRiU9Ev1Yj8imaUW1JEOlxmf9XlqWPoiFJO+DM
        Etg086C8B2e4ay5UYqbmO8LXA7HhG/mJYnb14+XMQuKftJf6Cg3XcD107c29dYL2wIFvaTt3qKA
        Gl5YIEtY22WFFdEHm9VyZoqwubuOoGoe3+ex8HCzRUdTLESvFytshQyxybm6XCDSxjfikZ94o+w
        HL
X-Google-Smtp-Source: ABdhPJwmniyFzJCqejmPAEE7zUGWFIQ7DsWbo3NoV4FE3XZX6UWjnGcvaHN80WXtwa4nFkB0RK9/egJLCl22mHMvKJAZ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:361:b029:e9:8392:7abd with
 SMTP id 88-20020a1709020361b02900e983927abdmr7098751pld.8.1617930611586; Thu,
 08 Apr 2021 18:10:11 -0700 (PDT)
Date:   Thu,  8 Apr 2021 18:09:59 -0700
In-Reply-To: <cover.1617929278.git.jonathantanmy@google.com>
Message-Id: <6a9f78df1a3513df04ac3275cd1feccfb6cf87b1.1617929278.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1617929278.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 2/6] fetch-pack: refactor process_acks()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent commit will need part, but not all, of the functionality in
process_acks(), so move some of its functionality to its sole caller
do_fetch_pack_v2(). As a side effect, the resulting code is also
shorter.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 70 +++++++++++++++++-----------------------------------
 1 file changed, 22 insertions(+), 48 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 2318ebe680..9f3901cdba 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1351,35 +1351,11 @@ static int process_section_header(struct packet_reader *reader,
 	return ret;
 }
 
-enum common_found {
-	/*
-	 * No commit was found to be possessed by both the client and the
-	 * server, and "ready" was not received.
-	 */
-	NO_COMMON_FOUND,
-
-	/*
-	 * At least one commit was found to be possessed by both the client and
-	 * the server, and "ready" was not received.
-	 */
-	COMMON_FOUND,
-
-	/*
-	 * "ready" was received, indicating that the server is ready to send
-	 * the packfile without any further negotiation.
-	 */
-	READY
-};
-
-static enum common_found process_acks(struct fetch_negotiator *negotiator,
-				      struct packet_reader *reader,
-				      struct oidset *common)
+static int process_ack(struct fetch_negotiator *negotiator,
+		       struct packet_reader *reader,
+		       struct object_id *common_oid,
+		       int *received_ready)
 {
-	/* received */
-	int received_ready = 0;
-	int received_ack = 0;
-
-	process_section_header(reader, "acknowledgments", 0);
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
 		const char *arg;
 
@@ -1387,20 +1363,17 @@ static enum common_found process_acks(struct fetch_negotiator *negotiator,
 			continue;
 
 		if (skip_prefix(reader->line, "ACK ", &arg)) {
-			struct object_id oid;
-			received_ack = 1;
-			if (!get_oid_hex(arg, &oid)) {
+			if (!get_oid_hex(arg, common_oid)) {
 				struct commit *commit;
-				oidset_insert(common, &oid);
-				commit = lookup_commit(the_repository, &oid);
+				commit = lookup_commit(the_repository, common_oid);
 				if (negotiator)
 					negotiator->ack(negotiator, commit);
 			}
-			continue;
+			return 1;
 		}
 
 		if (!strcmp(reader->line, "ready")) {
-			received_ready = 1;
+			*received_ready = 1;
 			continue;
 		}
 
@@ -1418,13 +1391,12 @@ static enum common_found process_acks(struct fetch_negotiator *negotiator,
 	 * sent. Therefore, a DELIM is expected if "ready" is sent, and a FLUSH
 	 * otherwise.
 	 */
-	if (received_ready && reader->status != PACKET_READ_DELIM)
+	if (*received_ready && reader->status != PACKET_READ_DELIM)
 		die(_("expected packfile to be sent after 'ready'"));
-	if (!received_ready && reader->status != PACKET_READ_FLUSH)
+	if (!*received_ready && reader->status != PACKET_READ_FLUSH)
 		die(_("expected no other sections to be sent after no 'ready'"));
 
-	return received_ready ? READY :
-		(received_ack ? COMMON_FOUND : NO_COMMON_FOUND);
+	return 0;
 }
 
 static void receive_shallow_info(struct fetch_pack_args *args,
@@ -1573,6 +1545,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct fetch_negotiator negotiator_alloc;
 	struct fetch_negotiator *negotiator;
 	int seen_ack = 0;
+	struct object_id common_oid;
+	int received_ready = 0;
 	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
 	int i;
 	struct strvec index_pack_args = STRVEC_INIT;
@@ -1631,22 +1605,22 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			break;
 		case FETCH_PROCESS_ACKS:
 			/* Process ACKs/NAKs */
-			switch (process_acks(negotiator, &reader, &common)) {
-			case READY:
+			process_section_header(&reader, "acknowledgments", 0);
+			while (process_ack(negotiator, &reader, &common_oid,
+					   &received_ready)) {
+				in_vain = 0;
+				seen_ack = 1;
+				oidset_insert(&common, &common_oid);
+			}
+			if (received_ready) {
 				/*
 				 * Don't check for response delimiter; get_pack() will
 				 * read the rest of this response.
 				 */
 				state = FETCH_GET_PACK;
-				break;
-			case COMMON_FOUND:
-				in_vain = 0;
-				seen_ack = 1;
-				/* fallthrough */
-			case NO_COMMON_FOUND:
+			} else {
 				do_check_stateless_delimiter(args, &reader);
 				state = FETCH_SEND_REQUEST;
-				break;
 			}
 			break;
 		case FETCH_GET_PACK:
-- 
2.31.1.295.g9ea45b61b8-goog

