Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35D0C56202
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E981208B3
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wNtIfUM8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgKLBce (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbgKKXbj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 18:31:39 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67693C061A4A
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 15:29:52 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id l3so2066034ply.6
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 15:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=RjYi5iI4sTMiG22bwX7nd17To2hO8p9K44Ntn5LCF+Q=;
        b=wNtIfUM8T1WxYJyvqVBBDqjgknrWVQKlEDl7HiOz+z4Rg0F3pXrz3Tkpw8HIbgv6YE
         7h1hOEkxpuPMLwyPE+zBMVm/C7jqYA+PhR52hEtJbPGddxdmrnzVnmyj0rZAna2EeVTt
         01jWAzOubfHe2XEj793HBLwsJVdyXCU/IXDxKGxAUXmmtS1luAy6lIW4WkjnQDcseM2t
         fDnJRagJu7PG0i3H1B48ZJD7bFcImwJDOrRjla/eIbc+NVAXm44aoNju4rZ23vnrrlYE
         o7BMjqjXrx7hh0TWqz4f8q4OHRe/qgpWxJv1rIT4KtCbvEMYhaoyKizlSv4rozfK/Ivs
         WSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=RjYi5iI4sTMiG22bwX7nd17To2hO8p9K44Ntn5LCF+Q=;
        b=TbreUboaVC0AwjIfiDSM8V9hsf9YzMJ5kWFurryEfmV07y6L2TV+uapL5NOLwzJpyO
         2AzViWDpycn1v6ueuNqhOi/WdblF5ODiC0MMqiOVDFZV0wWm7PHpIlNTrdCg5BfzuJCW
         jnmRUgEA17t+P1Pfv6i3to3ntOLPprU+JRu5ycSaWfq1hAHxhU2GJ2SGZt+O/gbeySeg
         MYGGI6BXsB516DXUNeEYo2HREZ78lAWwEGoxyzWjuc5vAp9Kyscxo7cyzjlNk1m1UHVR
         znisZSSZJr7x7gv7vX+H7aBfGMggfxxNlAUCfLZNNa315y2Ici7Ppi9gM7LatHlMGeT8
         JYVg==
X-Gm-Message-State: AOAM533eIMR3QV8wHE4ur/7LlfTYQ7lYhYXGT6aHDJz5pVE6+h10bjKP
        ijIsVUQFEQlgk6JYO9Pmc2qRswp74T8bEeAVQUL+EZJEqTNTZ4cECC8DLQ6nw0UBG9ORVnmlhFc
        AnATVBV8ty2UkyOdhBLsDfmPod6IMTqV5aq/gQnOSvW3Gne/L0QhOctgu8Ghprcs=
X-Google-Smtp-Source: ABdhPJzLEhGY3MBQZutT8tGyWaOpTc4t4H2CMLh/lu4TSZD1R0vIxArvmm7+q6JHPPcleXHfde4RpNnEwJCweg==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a17:90b:293:: with SMTP id
 az19mr625130pjb.1.1605137391658; Wed, 11 Nov 2020 15:29:51 -0800 (PST)
Date:   Wed, 11 Nov 2020 15:29:31 -0800
In-Reply-To: <cover.1605136908.git.steadmon@google.com>
Message-Id: <fc9f6c92863e36192a496b4a33e6c8bdecfee4ba.1605136908.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com> <cover.1605136908.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v3 08/11] fetch-pack: advertise session ID in capabilities
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the server sent a session-id capability and transfer.advertiseSID
is true, advertise fetch-pack's own session ID back to the server.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 fetch-pack.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index b10c432315..23179b8dd0 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -35,6 +35,7 @@ static int fetch_fsck_objects = -1;
 static int transfer_fsck_objects = -1;
 static int agent_supported;
 static int server_supports_filtering;
+static int advertise_sid;
 static struct shallow_lock shallow_lock;
 static const char *alternate_shallow_file;
 static struct strbuf fsck_msg_types = STRBUF_INIT;
@@ -326,6 +327,8 @@ static int find_common(struct fetch_negotiator *negotiator,
 			if (deepen_not_ok)      strbuf_addstr(&c, " deepen-not");
 			if (agent_supported)    strbuf_addf(&c, " agent=%s",
 							    git_user_agent_sanitized());
+			if (advertise_sid)
+				strbuf_addf(&c, " session-id=%s", trace2_session_id());
 			if (args->filter_options.choice)
 				strbuf_addstr(&c, " filter");
 			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
@@ -979,6 +982,9 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 				      agent_len, agent_feature);
 	}
 
+	if (!server_supports("session-id"))
+		advertise_sid = 0;
+
 	if (server_supports("shallow"))
 		print_verbose(args, _("Server supports %s"), "shallow");
 	else if (args->depth > 0 || is_repository_shallow(r))
@@ -1191,6 +1197,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 		packet_buf_write(&req_buf, "command=fetch");
 	if (server_supports_v2("agent", 0))
 		packet_buf_write(&req_buf, "agent=%s", git_user_agent_sanitized());
+	if (advertise_sid && server_supports_v2("session-id", 0))
+		packet_buf_write(&req_buf, "session-id=%s", trace2_session_id());
 	if (args->server_options && args->server_options->nr &&
 	    server_supports_v2("server-option", 1)) {
 		int i;
@@ -1711,6 +1719,7 @@ static void fetch_pack_config(void)
 	git_config_get_bool("repack.usedeltabaseoffset", &prefer_ofs_delta);
 	git_config_get_bool("fetch.fsckobjects", &fetch_fsck_objects);
 	git_config_get_bool("transfer.fsckobjects", &transfer_fsck_objects);
+	git_config_get_bool("transfer.advertisesid", &advertise_sid);
 	if (!uri_protocols.nr) {
 		char *str;
 
-- 
2.29.2.222.g5d2a92d10f8-goog

