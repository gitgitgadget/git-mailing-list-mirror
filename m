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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4944AC433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 01:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19F04610C7
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 01:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhDIBK3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 21:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbhDIBK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 21:10:27 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA685C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 18:10:15 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y22so2384326qkb.23
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 18:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AmiAFUWmc3T1ej5C6alEbnc8klyjc/DyvsLEQJhI0vk=;
        b=LG3tLN/zNmIypQNQ2wiKg/ZzUEVQJe4cqK0bjnh+seYRGFagKJwGxkVWUlJQM59D69
         HPLVurCrutRMRknRGP/eX/eRQM2kPMOYAR1G3V2jKF0d1Ixv3d01HK3DJVLa2023Mk5f
         poBE3mMadTdthfMa+rMgg61IWlUhD/h7TYaqc8PI0SfYmFPDsNh4Ar00wHdkTzwDhg+b
         4GMllCyfMbu4haMEyLNSJxcUaEOgWK8XGqPRjENn8Pxfxrc85FcVQE4KXb/GjX5uSY7Q
         9JIeOWOadweUIOJwDaoAwBSGKWRa/DYSQ8zKch2iiIFRXl2voro0/tPrXWbeJnqXqHPa
         JToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AmiAFUWmc3T1ej5C6alEbnc8klyjc/DyvsLEQJhI0vk=;
        b=cQ74mfcb2gZA61+vQd12xPGFIiGhKSyj/eg1+fJAivTTE4DpxlCNPdFDfRTGAqTncu
         51vx7E3fgRvwxutl7U+JaKxQuRyaC/YI/cK1VuQcxyYFodPmDvGsNw2mODjXn7PAJlcV
         08BcvoBKKDB5twQ/U9PZ865FiKItI/bfdEhgUkYFAd06m8mMxQkdErybvE6K7WuYj6PU
         Steg+BzXH+L3t6nEnaFRSrIONL1u0dl+ueEKZeA1AZ7wFAM24DTGQml4mOfdBv1UWHSN
         pvapiQfdHiRFD9PDGQC27oVTW6925UQ2zW2FD2TuDtU0OWsXIPAt8Vi9hUck5/3D16WZ
         AIdw==
X-Gm-Message-State: AOAM532AjfvSDHPK7JejXmTk5zgafAtlGMlRbbRCtR5iKO82bKiFYibc
        HRPRohRhydN+UdDmR+qBtEJg+2p8Q/YfnQHuziGa1PaTiI+m6H44wR1TTBXslsSZuf6cynY8oP3
        mZw2bAKiwOPK45twtcWADgXT9WsogfnxfcyVJTCH8pWNGufTTEcJ7/VhjAcwPozcnI0nOuhtTFG
        SR
X-Google-Smtp-Source: ABdhPJw87ltKJ3pRidfKZVohk7Lf0LaIHc31bmp1bJVaDM2m5vhmK5rXcjiYb3kY/mVjevcWxgpWkKmDB2fEKmj4KyWF
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:f74d:: with SMTP id
 e13mr12186703qvo.8.1617930614919; Thu, 08 Apr 2021 18:10:14 -0700 (PDT)
Date:   Thu,  8 Apr 2021 18:10:01 -0700
In-Reply-To: <cover.1617929278.git.jonathantanmy@google.com>
Message-Id: <7988c106873332ac6e5c2f9dd143cfa1f50e067c.1617929278.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1617929278.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 4/6] fetch-pack: refactor command and capability write
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent commit will need this functionality independent of the rest
of send_fetch_request(), so put this into its own function.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
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
2.31.1.295.g9ea45b61b8-goog

