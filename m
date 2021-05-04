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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859C4C433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 21:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58247610C8
	for <git@archiver.kernel.org>; Tue,  4 May 2021 21:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhEDVRG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 17:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbhEDVRG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 17:17:06 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFC9C061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 14:16:10 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id t12-20020a170902dcccb02900ed4648d0f9so4916231pll.2
        for <git@vger.kernel.org>; Tue, 04 May 2021 14:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0IMAuqN5/iGGsfjFiR7C/NsteBCnP9nr/SAnifwGE+g=;
        b=U+G+OUUBjmRh8r/UFXvcHYDBf4UmKCdN+Jeovr69/OqTSfwVCnHyi8oq8lODXSQ6LA
         iLx809qZSy3ZkmluosOgVILKeRsBumWyvft8RvCx7wqGs/tdPNOzz52BWP3a/ruXld8E
         OJ5Sb1o/97vz9ywJ5Mg5Htnz+uXVH2Yqt4JFyYiTdp+eEqqm9qrVF/W3VzMRy3WdAQiT
         dTk/RvNVKxCSqG7OJ4YH1Xi/VkNqGz/bK7Sr+yCVhCbvL/ITCalls7un8WI5kFsJsUPz
         tGEJV9J4jZ6saifO5TtQpH6mRYsZUb6hlIrz59LWPazrRK58+fL7z8DvzHiNv6w32H/E
         Y80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0IMAuqN5/iGGsfjFiR7C/NsteBCnP9nr/SAnifwGE+g=;
        b=k2rnXIQZtL0eqS3UNKwXsv5tcQRc85Z2hCdvbtURvTsFFqhWBjPdLDxmTOO5DVYWr7
         yI1c8ERvXFl2ZRl8Z3GC1tlNqZCoilggrqnVvWV/PiYWcwUImw0FI+AGzFFE/5yhVcOq
         Fjyk7DbEgAJUPheXY6P6azkDf/z1yHmi5KtcPslyYodrFTMUFe3bwY0gjjXbkWGfVBf2
         6Qa23AtMPJEDKHS0LNvE4Lps0/Qihd5+VpcNbf3UxSdkiLep2BmvQFSEPgqf4ZQFLa5o
         B8Yy8k/BUfpFNS91qvfFjQK6ulqeYtqrUyuuiyf+oj3qibRLmkETJLoGVnPAc/NmIYJo
         iJfg==
X-Gm-Message-State: AOAM530LPnnjsI6QkUGT3itGz+q0T+yQg6wVsUMjAaJ6AZkc1Hb9kdVS
        6YOST3LzLcQqbzVHAmuWA84+NuFzSI+dIBzFeZBzbWcn5hJnxvbH+7OCCZq5XfXXW/zAJmp4W9d
        CN3aSHcCkhSCTQIQZxeKsl/KEsJ+Btz7lcVUfuTkbRUbkkkJaAlo4ckeZ4n3Ro/mhXGujyUTupV
        PZ
X-Google-Smtp-Source: ABdhPJzQK8FpbtfJQppa+H2LO8ao3v8CSWk4n4bUrBkf4orbmGmxBD6B2wbOExwpZHu5AkqzAZHloRCuZqcmkvmwuKa+
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:e051:b029:ed:7646:49c4 with
 SMTP id x17-20020a170902e051b02900ed764649c4mr28268222plx.55.1620162970239;
 Tue, 04 May 2021 14:16:10 -0700 (PDT)
Date:   Tue,  4 May 2021 14:15:58 -0700
In-Reply-To: <cover.1620162764.git.jonathantanmy@google.com>
Message-Id: <8102570374a87c032bff2d7114c67390f55f9a1b.1620162764.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1617929278.git.jonathantanmy@google.com> <cover.1620162764.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v2 1/5] fetch-pack: refactor process_acks()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent commit will need part, but not all, of the functionality in
process_acks(), so move some of its functionality to its sole caller
do_fetch_pack_v2(). As a side effect, the resulting code is also
shorter.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.31.1.527.g47e6f16901-goog

