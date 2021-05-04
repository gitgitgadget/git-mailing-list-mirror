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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BB8C433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 21:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED812613B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 21:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhEDVRK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 17:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbhEDVRK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 17:17:10 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729ADC06174A
        for <git@vger.kernel.org>; Tue,  4 May 2021 14:16:14 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id j184-20020a6255c10000b0290214249d921cso138415pfb.17
        for <git@vger.kernel.org>; Tue, 04 May 2021 14:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8ahVzaEVdw6hdPit0BuynimSDHzBo0Dsx3N4XhKGdQg=;
        b=O1NImt2z3Kkuv0FQ1IFN47DJcJvJDeCmoxE1EJU17g9TAgFdQ8JZHUsZeefFWqWNB5
         MsHsGjjlS43fcFibY+CzT5JuEPBaAmj/UNDVvK0d75yLtngpMU7j+8hzbzX0cRyuXvC1
         u7MblHFFlMsKdCfzPHkh8SQ+GZZ3ui0WjIryLIYeCyzS73cakWcfvKvgTtYKPdKYW1jy
         6aawU+kHNqoXMgnxm8WLjys1PTRAuuxJbqQuGWycOEfh9iB2RKPQINBfYbQ4uJEC07Qu
         hMAVvRFIlYlJxWWTQmIkMSgVApARM6p4+UfxGn7XJOChP84J0VmTZGC2q4JWFZGy1ZhU
         v3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8ahVzaEVdw6hdPit0BuynimSDHzBo0Dsx3N4XhKGdQg=;
        b=JWL3pGQwOvBf4iJ1kSWFLtwrkG5tAx8YpMh3UC3LaOmVTBKHZ6g1LMctU+msPhmw77
         djnVuGRqG5LKORnpyDiZ1ZthX+NkNm87S8BQU+afPEwjCU4MoDho0zLKbrJHc+Pbrkk+
         e2OsypRroX3k42w2XZfQ1t9swLoUkoFpHYROmXVUqLL3wGSlbdKpN8lROFg4wP69NjNV
         TsXrfmYaKE38/mj31vjwJOGWypzn/JKFvlrClR0qAcMQ9EFtADY0Fm1nnjhKUQF91Vca
         hlRW+ZvofgaP9UO0UxUcwVtjIsomJBk4otgNxjY+KH78dMWSP7/hlo1ZZ7FBOHlq/c1E
         cXnA==
X-Gm-Message-State: AOAM530pJMvfb0vyujgl+QDcGEpDAS8bppjKAqyaB8RvirV83nHLKwjX
        qzlg2GCnnZckKpeVV/Ty/uiDiIp0bgFISMdm9l9bfRk15Ezpz9SbAtyUAWa2W6UlQBudSZk83dI
        bowk5ZIHLpicqCjDK5Z8ugbOYfvScvyYZB0F72qUSWpSNhvTP4IAJnCWugbk+1k7NXL5UR+aAB3
        i7
X-Google-Smtp-Source: ABdhPJwOwcjhXntFRxnbCyC89y45NO48vwl7dXDmXn49vPYJqi54VJqzhGv/kQfeipn/BtZGcZcRGLJ5qkrCyZSBCIf3
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:170e:0:b029:1fa:7161:fd71 with
 SMTP id 14-20020a62170e0000b02901fa7161fd71mr25114973pfx.35.1620162973860;
 Tue, 04 May 2021 14:16:13 -0700 (PDT)
Date:   Tue,  4 May 2021 14:16:00 -0700
In-Reply-To: <cover.1620162764.git.jonathantanmy@google.com>
Message-Id: <6871d0cec62dc12d0c5f7390eee8a80614919578.1620162764.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1617929278.git.jonathantanmy@google.com> <cover.1620162764.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v2 3/5] fetch-pack: refactor command and capability write
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent commit will need this functionality independent of the rest
of send_fetch_request(), so put this into its own function.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 fetch-pack.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 128ad47d2a..512fe5450d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1213,29 +1213,23 @@ static int add_haves(struct fetch_negotiator *negotiator,
 	return haves_added;
 }
 
-static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
-			      struct fetch_pack_args *args,
-			      const struct ref *wants, struct oidset *common,
-			      int *haves_to_send, int *in_vain,
-			      int sideband_all, int seen_ack)
+static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
+						 const struct string_list *server_options)
 {
-	int haves_added;
-	int done_sent = 0;
 	const char *hash_name;
-	struct strbuf req_buf = STRBUF_INIT;
 
 	if (server_supports_v2("fetch", 1))
-		packet_buf_write(&req_buf, "command=fetch");
+		packet_buf_write(req_buf, "command=fetch");
 	if (server_supports_v2("agent", 0))
-		packet_buf_write(&req_buf, "agent=%s", git_user_agent_sanitized());
+		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
 	if (advertise_sid && server_supports_v2("session-id", 0))
-		packet_buf_write(&req_buf, "session-id=%s", trace2_session_id());
-	if (args->server_options && args->server_options->nr &&
+		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
+	if (server_options && server_options->nr &&
 	    server_supports_v2("server-option", 1)) {
 		int i;
-		for (i = 0; i < args->server_options->nr; i++)
-			packet_buf_write(&req_buf, "server-option=%s",
-					 args->server_options->items[i].string);
+		for (i = 0; i < server_options->nr; i++)
+			packet_buf_write(req_buf, "server-option=%s",
+					 server_options->items[i].string);
 	}
 
 	if (server_feature_v2("object-format", &hash_name)) {
@@ -1243,13 +1237,26 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
 			die(_("mismatched algorithms: client %s; server %s"),
 			    the_hash_algo->name, hash_name);
-		packet_buf_write(&req_buf, "object-format=%s", the_hash_algo->name);
+		packet_buf_write(req_buf, "object-format=%s", the_hash_algo->name);
 	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1) {
 		die(_("the server does not support algorithm '%s'"),
 		    the_hash_algo->name);
 	}
+	packet_buf_delim(req_buf);
+}
+
+static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
+			      struct fetch_pack_args *args,
+			      const struct ref *wants, struct oidset *common,
+			      int *haves_to_send, int *in_vain,
+			      int sideband_all, int seen_ack)
+{
+	int haves_added;
+	int done_sent = 0;
+	struct strbuf req_buf = STRBUF_INIT;
+
+	write_fetch_command_and_capabilities(&req_buf, args->server_options);
 
-	packet_buf_delim(&req_buf);
 	if (args->use_thin_pack)
 		packet_buf_write(&req_buf, "thin-pack");
 	if (args->no_progress)
-- 
2.31.1.527.g47e6f16901-goog

