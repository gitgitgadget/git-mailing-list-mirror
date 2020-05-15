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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885F4C433E1
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65D6E20709
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBjARWVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgEOKFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 06:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgEOKFT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 06:05:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5119EC05BD09
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l17so2848050wrr.4
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g2XmECCDpN7avLXXM5UDqxaEKa6CbOJoQ4eZmU9tV8o=;
        b=lBjARWVEvU2t5eA1Uxq7qS90eCBiaBHp6UksnAFEGey7CuZdhI/8YCj1gxtZ5CC9hV
         KD8XlQZVKoOGyNRvsYZyZ1X0sps0+ND6rGX0oUF8Fal7hoQDWPQkKna90fs/Adg9Z3Xw
         Y82/PJOtG8PDthOkYymXMQ9Eu4gCZNUI3cD9dexnkKhXIHft/YA2TXjZ1QLXLqYQ/PV2
         AW/4s0ZIVghicdPUWc6eM5rnacu4pfhgQ/y0gwurGrrC1eP6wwoshWgbJ8JzawjdEW19
         4wkKhiKU8sRUloynwfLeHjGSL16Sj0XGCDTYK+Mf8MOQC+kbdAqq7ZUCpA4GxoGo4C2M
         0Cng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g2XmECCDpN7avLXXM5UDqxaEKa6CbOJoQ4eZmU9tV8o=;
        b=MiL5Xk9hCLZVXqzopC11BgvGy0Inz7LPiFLgRKVWUjnk+4UF6Y90FjYwRwmMUkxNJC
         FccHOOpsefH0R+7QXK9nlwQp3dA8Alh6eZmyZcTs9P8F8imH+znmT3zGr4kn4ZglaE0i
         0MXYot2X0BvD9NvOy1ntCH4z0uYL87WGfUN7r+mOTq2hclJ52uHQ2foVQ2wKhcjAwBRm
         3loRud3pnKovdrgTLpc9kf3g+S2e8Xw2OfM/diVeUeit3tFX1Sd3cCOEB788W1U45FWI
         QOymB8J91DlYmfyFmEpvxT6yLIAmWK+Vok33momgBmfjvBwsPK+4OFe8LW9miKUut6ez
         Wgjw==
X-Gm-Message-State: AOAM533v4HBwGz8plx0/e7IHDgZy9ZXdP63vcFcCHOzkQg2xzjL5zMwi
        GEck5MFxC0otLtYtDnrX8WCubBi5adk=
X-Google-Smtp-Source: ABdhPJws/pEhYpUSYhOqNVrAe859EoHeAomOFI7vUZ6DWvGP/dWBVD07MYw4ZScMIiWTECYaKToXLA==
X-Received: by 2002:adf:a118:: with SMTP id o24mr3305114wro.330.1589537115623;
        Fri, 15 May 2020 03:05:15 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.171])
        by smtp.gmail.com with ESMTPSA id m3sm2792326wrn.96.2020.05.15.03.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:05:15 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 05/13] upload-pack: pass upload_pack_data to get_common_commits()
Date:   Fri, 15 May 2020 12:04:46 +0200
Message-Id: <20200515100454.14486-6-chriscool@tuxfamily.org>
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
more thoroughly, let's pass 'struct upload_pack_data' to
get_common_commits(), so that this function and the functions
it calls can use all the fields of that struct in followup
commits.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index cb336c5713..7953a33189 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -414,9 +414,8 @@ static int ok_to_give_up(const struct object_array *have_obj,
 					    min_generation);
 }
 
-static int get_common_commits(struct packet_reader *reader,
-			      struct object_array *have_obj,
-			      struct object_array *want_obj)
+static int get_common_commits(struct upload_pack_data *data,
+			      struct packet_reader *reader)
 {
 	struct object_id oid;
 	char last_hex[GIT_MAX_HEXSZ + 1];
@@ -432,12 +431,14 @@ static int get_common_commits(struct packet_reader *reader,
 		reset_timeout();
 
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
-			if (multi_ack == 2 && got_common
-			    && !got_other && ok_to_give_up(have_obj, want_obj)) {
+			if (multi_ack == 2
+			    && got_common
+			    && !got_other
+			    && ok_to_give_up(&data->have_obj, &data->want_obj)) {
 				sent_ready = 1;
 				packet_write_fmt(1, "ACK %s ready\n", last_hex);
 			}
-			if (have_obj->nr == 0 || multi_ack)
+			if (data->have_obj.nr == 0 || multi_ack)
 				packet_write_fmt(1, "NAK\n");
 
 			if (no_done && sent_ready) {
@@ -451,10 +452,11 @@ static int get_common_commits(struct packet_reader *reader,
 			continue;
 		}
 		if (skip_prefix(reader->line, "have ", &arg)) {
-			switch (got_oid(arg, &oid, have_obj)) {
+			switch (got_oid(arg, &oid, &data->have_obj)) {
 			case -1: /* they have what we do not */
 				got_other = 1;
-				if (multi_ack && ok_to_give_up(have_obj, want_obj)) {
+				if (multi_ack
+				    && ok_to_give_up(&data->have_obj, &data->want_obj)) {
 					const char *hex = oid_to_hex(&oid);
 					if (multi_ack == 2) {
 						sent_ready = 1;
@@ -470,14 +472,14 @@ static int get_common_commits(struct packet_reader *reader,
 					packet_write_fmt(1, "ACK %s common\n", last_hex);
 				else if (multi_ack)
 					packet_write_fmt(1, "ACK %s continue\n", last_hex);
-				else if (have_obj->nr == 1)
+				else if (data->have_obj.nr == 1)
 					packet_write_fmt(1, "ACK %s\n", last_hex);
 				break;
 			}
 			continue;
 		}
 		if (!strcmp(reader->line, "done")) {
-			if (have_obj->nr > 0) {
+			if (data->have_obj.nr > 0) {
 				if (multi_ack)
 					packet_write_fmt(1, "ACK %s\n", last_hex);
 				return 0;
@@ -1176,9 +1178,7 @@ void upload_pack(struct upload_pack_options *options)
 
 		receive_needs(&reader, &data.want_obj, &data.filter_options);
 		if (data.want_obj.nr) {
-			get_common_commits(&reader,
-					   &data.have_obj,
-					   &data.want_obj);
+			get_common_commits(&data, &reader);
 			create_pack_file(&data.have_obj,
 					 &data.want_obj,
 					 &data.filter_options);
-- 
2.26.2.638.gb2c16ea67b.dirty

