Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A69C388F9
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1D5D22280
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BBAYstPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgKBWbW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 17:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgKBWbV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 17:31:21 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28931C061A47
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 14:31:20 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 19so10138918pgq.18
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 14:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=vy7mkvYBm7mdY0gYwpQpbvWIVN02epUA9FDKba3FbIU=;
        b=BBAYstPRY1EYdy0JlkNjRIaQlgzywqwnaWsb8dT3c8Y1JvQIOZbsGflILh+LhJftDS
         WyycZp3hYZfoJB0pRkgS6U0NqCvh3J52YGm1sgBZirhtmqsE9KOnfcsTeVtjrM5nFm/C
         C9kviHzrIoXphIVj/4WwW5ecZUeuBOIoCraIAd9/HMo7dEOZn4mQmt97gd0lXbUjUpV1
         VgdEQuIprZJN2/WUSZAYSI68+fgdOBMSEege0tUBjPn7eLxXMwuyYZr9q3awhniQB++6
         2MaY+Tenx019uL7ini1OrlL9ZUXkehPLnA9y8GM2uGKCxWYSxDqw8J31Eajrwiu2ql/u
         CCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=vy7mkvYBm7mdY0gYwpQpbvWIVN02epUA9FDKba3FbIU=;
        b=JzV0q4De+uhNnU4HHWlUtPB6S/gkBqtYV+Ausy0yQF7GXOQEviGNPUhouhLhDNrPvf
         jhIDS1FLlFDiY6qMUzfeiWxPHZGndJ+uoFlqYjTusGCgD1tFXfFrtNNKbpgTJmhvQqPw
         ESPphcWW4a39BwENWAH2A63S4MQKExhyN4rf4ZV7SRH28Eaa+a75fKn8t1fyNJieO2HG
         6otm5Ez+WqtKQP02VcgjnaAEC63F9PyZxFIh0hr487xSUb7GKk8X4jTIcgCrbuutQbjZ
         sdFM7OZzM+Ep3oLqUVxXnmNTfv+h54E2JsA2qztKQwzUeGz2Ypw5CXz/rptikWpwWWKu
         GoeQ==
X-Gm-Message-State: AOAM533la50+Z5rBRzq/jXpu8rfbSM2cBzkv2TTiv+dBpeA4NFPYJED1
        olZIpP/KI8kgAGU+hcskI6MTK4bEtgBCup5x4eRiQey/I0Ss8q4D7/XNvYLyyeT0daa9k3iTgX2
        24IUTJrwYnbXRwCuebkhl+PWhU/BltJC8cIAjLHiMIXMAaWnQ04MVdqyA6TinBcY=
X-Google-Smtp-Source: ABdhPJw0v1wvzyGGf3wwrVuVAu2cK2/Ah0iD4zGa1QdJf6KcNrTDpVsGJSo8CLcIZt++qZS4GLTWs5NHB6VxKg==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a17:90a:ab16:: with SMTP id
 m22mr350251pjq.219.1604356279596; Mon, 02 Nov 2020 14:31:19 -0800 (PST)
Date:   Mon,  2 Nov 2020 14:31:02 -0800
In-Reply-To: <cover.1604355792.git.steadmon@google.com>
Message-Id: <4912af5f2b949b9944b37843a9ebabdd33e66215.1604355792.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com> <cover.1604355792.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v2 04/11] upload-pack: advertise trace2 SID in v0 capabilities
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When trace2 is enabled and trace2.advertiseSID is true, advertise
upload-pack's trace2 session ID via the new trace2-sid capability.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 upload-pack.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/upload-pack.c b/upload-pack.c
index 3b858eb457..3bb01c5427 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -110,6 +110,7 @@ struct upload_pack_data {
 	unsigned done : 1;					/* v2 only */
 	unsigned allow_ref_in_want : 1;				/* v2 only */
 	unsigned allow_sideband_all : 1;			/* v2 only */
+	unsigned advertise_trace2_sid : 1;
 };
 
 static void upload_pack_data_init(struct upload_pack_data *data)
@@ -141,6 +142,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	packet_writer_init(&data->writer, 1);
 
 	data->keepalive = 5;
+	data->advertise_trace2_sid = 0;
 }
 
 static void upload_pack_data_clear(struct upload_pack_data *data)
@@ -1178,6 +1180,11 @@ static void format_symref_info(struct strbuf *buf, struct string_list *symref)
 		strbuf_addf(buf, " symref=%s:%s", item->string, (char *)item->util);
 }
 
+static void format_trace2_info(struct strbuf *buf, struct upload_pack_data *d) {
+	if (d->advertise_trace2_sid && trace2_is_enabled())
+		strbuf_addf(buf, " trace2-sid=%s", trace2_session_id());
+}
+
 static int send_ref(const char *refname, const struct object_id *oid,
 		    int flag, void *cb_data)
 {
@@ -1193,9 +1200,11 @@ static int send_ref(const char *refname, const struct object_id *oid,
 
 	if (capabilities) {
 		struct strbuf symref_info = STRBUF_INIT;
+		struct strbuf trace2_info = STRBUF_INIT;
 
 		format_symref_info(&symref_info, &data->symref);
-		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s object-format=%s agent=%s\n",
+		format_trace2_info(&trace2_info, data);
+		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s%s object-format=%s agent=%s\n",
 			     oid_to_hex(oid), refname_nons,
 			     0, capabilities,
 			     (data->allow_uor & ALLOW_TIP_SHA1) ?
@@ -1205,9 +1214,11 @@ static int send_ref(const char *refname, const struct object_id *oid,
 			     data->stateless_rpc ? " no-done" : "",
 			     symref_info.buf,
 			     data->allow_filter ? " filter" : "",
+			     trace2_info.buf,
 			     the_hash_algo->name,
 			     git_user_agent_sanitized());
 		strbuf_release(&symref_info);
+		strbuf_release(&trace2_info);
 	} else {
 		packet_write_fmt(1, "%s %s\n", oid_to_hex(oid), refname_nons);
 	}
@@ -1299,6 +1310,8 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 		data->allow_sideband_all = git_config_bool(var, value);
 	} else if (!strcmp("core.precomposeunicode", var)) {
 		precomposed_unicode = git_config_bool(var, value);
+	} else if (!strcmp("trace2.advertisesid", var)) {
+		data->advertise_trace2_sid = git_config_bool(var, value);
 	}
 
 	if (current_config_scope() != CONFIG_SCOPE_LOCAL &&
-- 
2.29.1.341.ge80a0c044ae-goog

