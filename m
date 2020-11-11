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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B893DC388F9
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F7720791
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MJ/kWAKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgKLBca (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbgKKX3q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 18:29:46 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBEFC061A04
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 15:29:45 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id h26so2247185qtm.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 15:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=skzlVKFzG6D61ggv/OQ/6vDZJ3tABONq6LxAY7QxIlE=;
        b=MJ/kWAKBF7E5bHr8jv6lVWCidZ0w4e5iYO1bn0Z7idRL3Co9anclO0otaBFOr5HjWv
         BnvFrguTIHhUSwaNNgU64Bhie141etC9UdQg2p2rvFwZvdag1WM30dqaLZU8qlGCXRZh
         ulOnVZGu5B/XsfxTOBVT3UmQ45Hcu1+Wr+1tE5sWHkcBuZ5ARRpxL+EKHQBiK4hTha91
         6Je6DS+GMyXFv+8wcTzAOKa70eD+21PAP+tAEZ+e6A6B2kC26TqyKB2luRaHAPHcKyt1
         fguXFE0t/nNw6li/T+mnsU6v+kZtS8qqlSEX6sE1sOlV1xIC1m8f+LlAk9y2p1u9euzs
         dsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=skzlVKFzG6D61ggv/OQ/6vDZJ3tABONq6LxAY7QxIlE=;
        b=KBPxxguXBAozdmsqHlsmBYJD36tnbZ39MVDGq5jylqcEsEPh4Dt5N9SBOQKP7O9KWz
         Y/Fn6hrGKimRuS1+Z75LnkYTbFt6mDLX8nX9SqJOxGANhb5R1YZqGqbJmknnD09QARz7
         2MXXX/JH4awxU8tDwLbtsEyQ9mcxE2PW+JRm69U+fInBWrJRqweXR2+5uZ06mLDnG6d0
         MZ2bq7U63x35JwTvp+2xOG/C3ZzKDOm9Z1soOWp4XeIJ5rUsBnncsK0bYlsdyxdZX/J+
         7nnylDT1wpMw+o5saF+B/s1caJpJG9jRdDV7Uezhu9H1mbmsBiXWuA+uulbhiNXlohr6
         M/yQ==
X-Gm-Message-State: AOAM532Y8yWG/NPlKlJObniGTSmjNah+hBre/9IOXMvX1C+nOR5ihu3i
        kMVkGpfx2WOokauPpGWlPCswjNbJxLa3L7BUeMv928InvbNH1YEgWw6YhOqMpUwO/DDR/HwN31S
        0YQsLDRlo5NG0fNRn3FtiVuNoGw6k8vg6owmUl1XqJnchKZw/83Rq7ftafdHvVDQ=
X-Google-Smtp-Source: ABdhPJzboFtGFppGaAFXh23dpX3NianwDcEhcm9sElEaCXOL4U6XsLFSC+RI4lmbevj43shonu9GDuu0kF/NPA==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a0c:eb91:: with SMTP id
 x17mr11983372qvo.36.1605137384235; Wed, 11 Nov 2020 15:29:44 -0800 (PST)
Date:   Wed, 11 Nov 2020 15:29:27 -0800
In-Reply-To: <cover.1605136908.git.steadmon@google.com>
Message-Id: <612957b9d56a30a22b4b05c46d9050e3fd2979d8.1605136908.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com> <cover.1605136908.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v3 04/11] upload-pack: advertise session ID in v0 capabilities
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When transfer.advertiseSID is true, advertise upload-pack's session ID
via the new session-id capability.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 upload-pack.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/upload-pack.c b/upload-pack.c
index 3b858eb457..ebb4099268 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -110,6 +110,7 @@ struct upload_pack_data {
 	unsigned done : 1;					/* v2 only */
 	unsigned allow_ref_in_want : 1;				/* v2 only */
 	unsigned allow_sideband_all : 1;			/* v2 only */
+	unsigned advertise_sid : 1;
 };
 
 static void upload_pack_data_init(struct upload_pack_data *data)
@@ -141,6 +142,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	packet_writer_init(&data->writer, 1);
 
 	data->keepalive = 5;
+	data->advertise_sid = 0;
 }
 
 static void upload_pack_data_clear(struct upload_pack_data *data)
@@ -1178,6 +1180,11 @@ static void format_symref_info(struct strbuf *buf, struct string_list *symref)
 		strbuf_addf(buf, " symref=%s:%s", item->string, (char *)item->util);
 }
 
+static void format_session_id(struct strbuf *buf, struct upload_pack_data *d) {
+	if (d->advertise_sid)
+		strbuf_addf(buf, " session-id=%s", trace2_session_id());
+}
+
 static int send_ref(const char *refname, const struct object_id *oid,
 		    int flag, void *cb_data)
 {
@@ -1193,9 +1200,11 @@ static int send_ref(const char *refname, const struct object_id *oid,
 
 	if (capabilities) {
 		struct strbuf symref_info = STRBUF_INIT;
+		struct strbuf session_id = STRBUF_INIT;
 
 		format_symref_info(&symref_info, &data->symref);
-		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s object-format=%s agent=%s\n",
+		format_session_id(&session_id, data);
+		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s%s object-format=%s agent=%s\n",
 			     oid_to_hex(oid), refname_nons,
 			     0, capabilities,
 			     (data->allow_uor & ALLOW_TIP_SHA1) ?
@@ -1205,9 +1214,11 @@ static int send_ref(const char *refname, const struct object_id *oid,
 			     data->stateless_rpc ? " no-done" : "",
 			     symref_info.buf,
 			     data->allow_filter ? " filter" : "",
+			     session_id.buf,
 			     the_hash_algo->name,
 			     git_user_agent_sanitized());
 		strbuf_release(&symref_info);
+		strbuf_release(&session_id);
 	} else {
 		packet_write_fmt(1, "%s %s\n", oid_to_hex(oid), refname_nons);
 	}
@@ -1299,6 +1310,8 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 		data->allow_sideband_all = git_config_bool(var, value);
 	} else if (!strcmp("core.precomposeunicode", var)) {
 		precomposed_unicode = git_config_bool(var, value);
+	} else if (!strcmp("transfer.advertisesid", var)) {
+		data->advertise_sid = git_config_bool(var, value);
 	}
 
 	if (current_config_scope() != CONFIG_SCOPE_LOCAL &&
-- 
2.29.2.222.g5d2a92d10f8-goog

