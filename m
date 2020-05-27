Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A13C433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7FC12071A
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASvcYUgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387444AbgE0QsI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 12:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729510AbgE0QsF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 12:48:05 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CF0C08C5C1
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:48:05 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y17so16314765wrn.11
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TMV0M3Ku0XaMVshO6irApQtFuX2W9J3TgmH+Vvf0oQY=;
        b=ASvcYUgOEt7Xl/okq5GGBZc/61fHfGZyHBUj8aEwvxIS55Oj4nARqpmJr4bqpBP6kF
         MmC4Qwx7nQZqUYiG70NxOjq2WE8g0yg8Zmrm44Mux6Rm90HKwgAW5hJEh4xw4/KzUtRX
         rfQgJzaAtXj0d6Atc6Bg1XpahwBaaisOyAVoAfGI2g+4HsGxPizBkstDEGKIwRjk/lTK
         oLkngr9GFoAFtviinkZ9laJgcyGiCSoc5cRipGGtnMRbMJcvXnABQ5Q8Hf7VjiVYkwE/
         TFCSMjKuAMTR/gy6HxAX96vlkZ2YMYMyonRCcVVxiRcBrWngm679SVOxNh69UaptnHH0
         LQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TMV0M3Ku0XaMVshO6irApQtFuX2W9J3TgmH+Vvf0oQY=;
        b=Xo5EIvomxjnRt/xzfqIX0h4AlbhLFOH92SwMe/YS8bAFw+/dBxOfnWPNg3Uc+WcuHJ
         Y+K6fJekgLMFvXR5D5L/iGwaJNf9S+4KkXBfeh4HZVNFKKn3aGVefEv8GHnzF+7cYgdA
         q3Fq8+bDtE1GJxVOrFyDL39e3RbOpSIfgvnNkaM9GRvwOMfcPu9fBeYWAMEYALBKcOvM
         2YB4cK+KF4RZ2cjfXBJQBuy8WZJRTbbgQJu5XVSSrfjBus4jG03vkDP0/0rPXfAik14I
         r9FLrNptvy/8NHASyQRHrrd/gCIg5Kk3olLWPLNswAih5z1Jx9ojbfYjm/3Vjh96roSp
         f3bg==
X-Gm-Message-State: AOAM5307SFPc02SuE4RChbHdGWyRoh0Mt9zTMeAMpzw89JRO0ou7Lldz
        vDFyHTYsyEgHD91e5QsQRQYVVhMp+BU=
X-Google-Smtp-Source: ABdhPJyR1CPe3skjAm1dIB/Qwg4ODtHdDlrNiJ7oFSIwTB5Gog0JobhYrmCVcrEOlD3b/PqKGxtCjA==
X-Received: by 2002:a5d:4a8a:: with SMTP id o10mr18624878wrq.222.1590598083655;
        Wed, 27 May 2020 09:48:03 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.40])
        by smtp.gmail.com with ESMTPSA id d17sm2432852wrg.75.2020.05.27.09.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:48:03 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 05/12] upload-pack: move multi_ack to upload_pack_data
Date:   Wed, 27 May 2020 18:47:35 +0200
Message-Id: <20200527164742.23067-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.rc2.38.gc6b4ed14d2.dirty
In-Reply-To: <20200527164742.23067-1-chriscool@tuxfamily.org>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200527164742.23067-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
more thoroughly, let's move the multi_ack static variable into
this struct.

It is only used by protocol v0 code since protocol v2 assumes
certain baseline capabilities, but rolling it into
upload_pack_data and just letting v2 code ignore it as it does
now is more coherent and cleaner.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index e81b326690..385b165bec 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -44,7 +44,6 @@
 
 static timestamp_t oldest_have;
 
-static int multi_ack;
 /* Allow specifying sha1 if it is a ref tip. */
 #define ALLOW_TIP_SHA1	01
 /* Allow request of a sha1 if it is reachable from a ref (possibly hidden ref). */
@@ -76,6 +75,7 @@ struct upload_pack_data {
 	int deepen_rev_list;
 	int deepen_relative;
 	int timeout;
+	int multi_ack;
 
 	/* 0 for no sideband, otherwise DEFAULT_PACKET_MAX or LARGE_PACKET_MAX */
 	int use_sideband;
@@ -435,14 +435,14 @@ static int get_common_commits(struct upload_pack_data *data,
 		reset_timeout(data->timeout);
 
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
-			if (multi_ack == 2
+			if (data->multi_ack == 2
 			    && got_common
 			    && !got_other
 			    && ok_to_give_up(&data->have_obj, &data->want_obj)) {
 				sent_ready = 1;
 				packet_write_fmt(1, "ACK %s ready\n", last_hex);
 			}
-			if (data->have_obj.nr == 0 || multi_ack)
+			if (data->have_obj.nr == 0 || data->multi_ack)
 				packet_write_fmt(1, "NAK\n");
 
 			if (data->no_done && sent_ready) {
@@ -459,10 +459,10 @@ static int get_common_commits(struct upload_pack_data *data,
 			switch (got_oid(arg, &oid, &data->have_obj)) {
 			case -1: /* they have what we do not */
 				got_other = 1;
-				if (multi_ack
+				if (data->multi_ack
 				    && ok_to_give_up(&data->have_obj, &data->want_obj)) {
 					const char *hex = oid_to_hex(&oid);
-					if (multi_ack == 2) {
+					if (data->multi_ack == 2) {
 						sent_ready = 1;
 						packet_write_fmt(1, "ACK %s ready\n", hex);
 					} else
@@ -472,9 +472,9 @@ static int get_common_commits(struct upload_pack_data *data,
 			default:
 				got_common = 1;
 				oid_to_hex_r(last_hex, &oid);
-				if (multi_ack == 2)
+				if (data->multi_ack == 2)
 					packet_write_fmt(1, "ACK %s common\n", last_hex);
-				else if (multi_ack)
+				else if (data->multi_ack)
 					packet_write_fmt(1, "ACK %s continue\n", last_hex);
 				else if (data->have_obj.nr == 1)
 					packet_write_fmt(1, "ACK %s\n", last_hex);
@@ -484,7 +484,7 @@ static int get_common_commits(struct upload_pack_data *data,
 		}
 		if (!strcmp(reader->line, "done")) {
 			if (data->have_obj.nr > 0) {
-				if (multi_ack)
+				if (data->multi_ack)
 					packet_write_fmt(1, "ACK %s\n", last_hex);
 				return 0;
 			}
@@ -952,9 +952,9 @@ static void receive_needs(struct upload_pack_data *data,
 		if (parse_feature_request(features, "deepen-relative"))
 			data->deepen_relative = 1;
 		if (parse_feature_request(features, "multi_ack_detailed"))
-			multi_ack = 2;
+			data->multi_ack = 2;
 		else if (parse_feature_request(features, "multi_ack"))
-			multi_ack = 1;
+			data->multi_ack = 1;
 		if (parse_feature_request(features, "no-done"))
 			data->no_done = 1;
 		if (parse_feature_request(features, "thin-pack"))
-- 
2.27.0.rc2.38.gc6b4ed14d2.dirty

