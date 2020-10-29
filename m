Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2FBC4742C
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 21:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1401D20838
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 21:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ac7zj8+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgJ2Vc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgJ2Vc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 17:32:57 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D249BC0613CF
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 14:32:55 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id z11so2906599pln.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 14:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=5OJKcKg/Rw4YXtrZn7AEtmy0koKjFvf4Oob54ZmmK5E=;
        b=ac7zj8+v+x4zjaZlYFDZw7dbs/FEDZwnVUegQde9CpvlNztmNWmxqleZSZ1eC9IPey
         WbyJoMHtuTf9WQQSSKAFzxGImT6vqGdisstSRvJ8ze5Z6V3oaDp2PTqZT1HinsGL9CCE
         qD1wggiBs1r8mb70iVtFZAJLmX3Ks8rO8gTj6KzEvmSQ4ktzXHqJsi+GDaJ5j0nvnWTH
         y2NlKVdPoHgmc92GoblAFsz3Z1G2+cezgmDf+TOQoLWzCsz5J9hnAOoOWlsQbQaXuJZj
         pMuxxQRTMP8ykrgMY+oqfUaXjWG9XtY389ELJe0azgPiyEOCk/ki0IWH+ea55svXU91d
         h8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=5OJKcKg/Rw4YXtrZn7AEtmy0koKjFvf4Oob54ZmmK5E=;
        b=NbvrDWzZwUOSHrXrqwT8nM54TKrlY67OgOvF2wCnFM/LkCRaKR/TxAglptjrpmoWbJ
         KGOZ+yzssjHhypL9LCFFH3O3S74/7OxOHrw/+wIf2LNj7iLEjYOECaDNVdjokPiKgAYP
         QfPTVJqsCkNGnWURc+/wDMuIkyCUyo6uIKRnyiuq4MsP3684xZFVleNL6K8F/FD5J7eF
         q21Nm1Wkih46/pIysKbHL4S+h2no4ZE9XlcjrG4D1pErsyiI2B+hXwKYHkdHx6YavP1j
         fsxUvtfqxi1Sn/oS2dllv+EDLy/qL137SBEH96M7RvJAj+WnuHbNC7k2se/38LI3CrBv
         SkVQ==
X-Gm-Message-State: AOAM532tsq/XXziF87y9Byi55/DZ1M22ti02ZbfI7gXCJqfybaF3Zf1g
        h69C/+m5Y3S1dmq9R5nKl8eSlwbCHjrYyp6hzLvlAYkQjK2isnbhXHbyrhDDVPtOSrLGCBsYJ/Z
        dsxjgAGQGwctD16kh7/URx9ZGSPaxm/IqKttBr8Tn/GMQLuNEzZclH7+wkuAIPKA=
X-Google-Smtp-Source: ABdhPJzAfvgW8nKeF+ZUH/SVFVqpbL6daRlXyaJ23hB+mdb5STdYQP33Z0xZkiBlX59Y7vyuoClfXmVrerWDrQ==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a63:ec57:: with SMTP id
 r23mr5845982pgj.257.1604007175262; Thu, 29 Oct 2020 14:32:55 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:32:37 -0700
In-Reply-To: <cover.1604006121.git.steadmon@google.com>
Message-Id: <ee4b3a7a55f6823d86f9df4e87d6318019401f38.1604006121.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 07/10] fetch-pack: advertise trace2 SID in capabilities
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When trace2 is enabled, the server sent a trace2-sid capability, and
trace2.advertiseSID is true, advertise fetch-pack's own session ID back
to the server.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 fetch-pack.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index b10c432315..40065fc7dd 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -23,6 +23,7 @@
 #include "fetch-negotiator.h"
 #include "fsck.h"
 #include "shallow.h"
+#include "trace2/tr2_sid.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -35,6 +36,8 @@ static int fetch_fsck_objects = -1;
 static int transfer_fsck_objects = -1;
 static int agent_supported;
 static int server_supports_filtering;
+static int server_sent_trace2_sid;
+static int advertise_trace2_sid;
 static struct shallow_lock shallow_lock;
 static const char *alternate_shallow_file;
 static struct strbuf fsck_msg_types = STRBUF_INIT;
@@ -326,6 +329,8 @@ static int find_common(struct fetch_negotiator *negotiator,
 			if (deepen_not_ok)      strbuf_addstr(&c, " deepen-not");
 			if (agent_supported)    strbuf_addf(&c, " agent=%s",
 							    git_user_agent_sanitized());
+			if (advertise_trace2_sid && server_sent_trace2_sid && trace2_is_enabled())
+				strbuf_addf(&c, " trace2-sid=%s", tr2_sid_get());
 			if (args->filter_options.choice)
 				strbuf_addstr(&c, " filter");
 			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
@@ -979,6 +984,9 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 				      agent_len, agent_feature);
 	}
 
+	if (server_supports("trace2-sid"))
+		server_sent_trace2_sid = 1;
+
 	if (server_supports("shallow"))
 		print_verbose(args, _("Server supports %s"), "shallow");
 	else if (args->depth > 0 || is_repository_shallow(r))
@@ -1191,6 +1199,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 		packet_buf_write(&req_buf, "command=fetch");
 	if (server_supports_v2("agent", 0))
 		packet_buf_write(&req_buf, "agent=%s", git_user_agent_sanitized());
+	if (advertise_trace2_sid && server_supports_v2("trace2-sid", 0) && trace2_is_enabled())
+		packet_buf_write(&req_buf, "trace2-sid=%s", tr2_sid_get());
 	if (args->server_options && args->server_options->nr &&
 	    server_supports_v2("server-option", 1)) {
 		int i;
@@ -1711,6 +1721,7 @@ static void fetch_pack_config(void)
 	git_config_get_bool("repack.usedeltabaseoffset", &prefer_ofs_delta);
 	git_config_get_bool("fetch.fsckobjects", &fetch_fsck_objects);
 	git_config_get_bool("transfer.fsckobjects", &transfer_fsck_objects);
+	git_config_get_bool("trace2.advertisesid", &advertise_trace2_sid);
 	if (!uri_protocols.nr) {
 		char *str;
 
-- 
2.29.1.341.ge80a0c044ae-goog

