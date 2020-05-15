Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170D0C433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9B5F20709
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qqa2AUIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgEOKFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 06:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgEOKFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 06:05:16 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EBDC061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:15 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w64so1985330wmg.4
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FovOELderClvRbKGKOJm679VE4oHeJYLd6RPTpl9PbM=;
        b=Qqa2AUImC9RYlnh/6IfoGEXrAHylcpJCkzDmKZA08cP3PqKDViDFYi6AAAHWJv8B3S
         1h07SmH1zELcVFZNzE0wfGbwEOAdiJ9M2/OKGSXTpqKfXtd4olAEx67VuI9gaMJ3LInE
         JjwbuN2uCHNceJlnr2x/5h/INwc16NuUa0bwujyHj6D0FhdCPdZ7AnJxaXFpw2D6m6qT
         jElYW8UxBRCe8WtFtKVb9WaILk8bI/93lNmvUITnm8Ug/pgyO8fhuTOXMDzHNjRsL65/
         4051aM2B67Y6Qh0WDFt/atiNt8iKqswU0rN7Yx6DnrMQ4DrW/WMmXM9y7VQc1q6l3blU
         /7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FovOELderClvRbKGKOJm679VE4oHeJYLd6RPTpl9PbM=;
        b=rsxUmbP1TfLZWV1XqIVH4BS8tjR3oRB1Si4mCB+ITDv+1tnMwp22TcV5wstDpE2P4a
         XZ3ZthTF49MvDF4Lt2aw7GHwr5CxLm/PHCMPM14gg7oi256wE9jxnTV9kid4+K2w4Ivn
         VJbkO45wF8mLV6cKfkItI2Zj0nQBIKNoMy12XA5ohWTgeIJXy1a24hSy1DdNTHjZnc4H
         IsyjDbFUfmOhZydgeo9iQ/mYpjzyxCME75AysmJfg0mAI3E1Wp8bdABYf9yboOpueNWI
         M7MUdNwjAwiUZLo8w0ttWxyYmSTbv3RoMlonVdFbuIGnVESmzzVqh23JN8ogLk0jqPX+
         ti2g==
X-Gm-Message-State: AOAM532ThvDFkH1EpaaO9C44pt4IDinvr0YLfVqbCBvsTtG6HseuSzbE
        HkqTdUS1B+iriysACk0xolQu1LVVVL4=
X-Google-Smtp-Source: ABdhPJwdRX7CHykSa8fs7tLIutlks6akxehHxFV7j1FCKbMr4BOUdy26WHC8iwyFz1F9h70HJu7rbw==
X-Received: by 2002:a1c:740e:: with SMTP id p14mr3317025wmc.102.1589537114264;
        Fri, 15 May 2020 03:05:14 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.171])
        by smtp.gmail.com with ESMTPSA id m3sm2792326wrn.96.2020.05.15.03.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:05:13 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 04/13] upload-pack: use 'struct upload_pack_data' in upload_pack()
Date:   Fri, 15 May 2020 12:04:45 +0200
Message-Id: <20200515100454.14486-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.26.2.639.gb7dde20fdf
In-Reply-To: <20200515100454.14486-1-chriscool@tuxfamily.org>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
more thoroughly, let's use 'struct upload_pack_data' in
upload_pack().

This will make it possible in followup commits to remove a lot
of static variables and local variables that have the same name
and purpose as fields in 'struct upload_pack_data'. This will
also make upload_pack() work in a more similar way as
upload_pack_v2().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 9aeb3477c9..cb336c5713 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1144,18 +1144,17 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 void upload_pack(struct upload_pack_options *options)
 {
 	struct string_list symref = STRING_LIST_INIT_DUP;
-	struct object_array want_obj = OBJECT_ARRAY_INIT;
 	struct packet_reader reader;
-	struct list_objects_filter_options filter_options;
+	struct upload_pack_data data;
 
 	stateless_rpc = options->stateless_rpc;
 	timeout = options->timeout;
 	daemon_mode = options->daemon_mode;
 
-	memset(&filter_options, 0, sizeof(filter_options));
-
 	git_config(upload_pack_config, NULL);
 
+	upload_pack_data_init(&data);
+
 	head_ref_namespaced(find_symref, &symref);
 
 	if (options->advertise_refs || !stateless_rpc) {
@@ -1169,21 +1168,24 @@ void upload_pack(struct upload_pack_options *options)
 		for_each_namespaced_ref(check_ref, NULL);
 	}
 	string_list_clear(&symref, 1);
-	if (options->advertise_refs)
-		return;
 
-	packet_reader_init(&reader, 0, NULL, 0,
-			   PACKET_READ_CHOMP_NEWLINE |
-			   PACKET_READ_DIE_ON_ERR_PACKET);
+	if (!options->advertise_refs) {
+		packet_reader_init(&reader, 0, NULL, 0,
+				   PACKET_READ_CHOMP_NEWLINE |
+				   PACKET_READ_DIE_ON_ERR_PACKET);
 
-	receive_needs(&reader, &want_obj, &filter_options);
-	if (want_obj.nr) {
-		struct object_array have_obj = OBJECT_ARRAY_INIT;
-		get_common_commits(&reader, &have_obj, &want_obj);
-		create_pack_file(&have_obj, &want_obj, &filter_options);
+		receive_needs(&reader, &data.want_obj, &data.filter_options);
+		if (data.want_obj.nr) {
+			get_common_commits(&reader,
+					   &data.have_obj,
+					   &data.want_obj);
+			create_pack_file(&data.have_obj,
+					 &data.want_obj,
+					 &data.filter_options);
+		}
 	}
 
-	list_objects_filter_release(&filter_options);
+	upload_pack_data_clear(&data);
 }
 
 static int parse_want(struct packet_writer *writer, const char *line,
-- 
2.26.2.638.gb2c16ea67b.dirty

