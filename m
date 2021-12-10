Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5CBC433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 10:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbhLJKip (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 05:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237812AbhLJKio (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 05:38:44 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE61CC0617A1
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 02:35:09 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so7139101pjb.5
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 02:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6CsBZVul8+xpJLD7ZM2E4q6o5VARdqprcFBptZ0+JBA=;
        b=m1yr/N3Uuk7EGf72NefoyQeXJzzJ/sgqPm9QZkVk4lZd+wOi8dCktEQWfYqGeu2Jjl
         BSQmGWcCfAzsYN3ZiaoyIN6bfviz775sSsl6gdiEvxxzecE5m96JmeEKfQ9FC8HOqbtL
         nelssZlc87+ZxknvhJMbj/0wqr5MvAVS5OtZhdvw925i1UAMTGYPfF9ERdPtz1FUz2ir
         xIewXn+1JPmI7gLvAitB6OSgVMkgNob64S3pUpB7b/9jm/3vobFYLp+eU0fL9n7RpFVb
         j4cPbi5mXSgVSik/C8EjgbNlGUZB2NZuAbThBxmeIimWt8gaXczP8yuebqUxs59FUWr0
         QoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6CsBZVul8+xpJLD7ZM2E4q6o5VARdqprcFBptZ0+JBA=;
        b=jClzDYSQ+DfG7WbLA7bfrDeBClV7zpc1hBoN7/ao10GFNXnowFyKPbSBZ0OBpYkvy3
         HxQFMp9Rcg2D62bnXuTq7kUcSfxQfdBfk/0gqwlbb4whjWSrS241KDW75hNPfk9CstOx
         Ex5aBvcGIRRuDEsRGyO43uL0X2ipmsYdRS7O7ynqfXGhZs2Jc21H1xv2w7Xd2UeCYKKs
         dFhOvr1LUvVT78WuhRIONkyJujisNd6yrR3ym3bnbdyjzQTZAixSqbfRYVICgn7pnqtw
         GBNkoT1NdArKL+3W5zGE5f/mBPMaz0ZmrkHr83JT+3h2kyzxzJHFwtmAPLh0EkziZ4Pp
         rjTA==
X-Gm-Message-State: AOAM532Z8RhIO0IR0WveUKmmDrf35y7Zc8egKKbEUYXixQ6FcE03ino3
        jqqoyhU26TirPPg6AXFHJVI=
X-Google-Smtp-Source: ABdhPJzI9J2FEkNSg3a+xLODJuw3aEmgk6PPDw+F9YBg47PVmEQUINx4XzBn1Qm8PeYPyNrX12tM9w==
X-Received: by 2002:a17:902:b084:b0:141:f5f8:1c5a with SMTP id p4-20020a170902b08400b00141f5f81c5amr75052680plr.40.1639132509291;
        Fri, 10 Dec 2021 02:35:09 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.96])
        by smtp.gmail.com with ESMTPSA id 204sm2396250pgb.63.2021.12.10.02.35.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Dec 2021 02:35:08 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v5 4/6] unpack-objects.c: add dry_run mode for get_data()
Date:   Fri, 10 Dec 2021 18:34:33 +0800
Message-Id: <20211210103435.83656-5-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211203093530.93589-1-chiyutianyi@gmail.com>
References: <20211203093530.93589-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

In dry_run mode, "get_data()" is used to verify the inflation of data,
and the returned buffer will not be used at all and will be freed
immediately. Even in dry_run mode, it is dangerous to allocate a
full-size buffer for a large blob object. Therefore, only allocate a
low memory footprint when calling "get_data()" in dry_run mode.

Suggested-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 builtin/unpack-objects.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 4a9466295b..d878e2f8b4 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -96,15 +96,16 @@ static void use(int bytes)
 	display_throughput(progress, consumed_bytes);
 }
 
-static void *get_data(unsigned long size)
+static void *get_data(unsigned long size, int dry_run)
 {
 	git_zstream stream;
-	void *buf = xmallocz(size);
+	unsigned long bufsize = dry_run ? 8192 : size;
+	void *buf = xmallocz(bufsize);
 
 	memset(&stream, 0, sizeof(stream));
 
 	stream.next_out = buf;
-	stream.avail_out = size;
+	stream.avail_out = bufsize;
 	stream.next_in = fill(1);
 	stream.avail_in = len;
 	git_inflate_init(&stream);
@@ -124,6 +125,11 @@ static void *get_data(unsigned long size)
 		}
 		stream.next_in = fill(1);
 		stream.avail_in = len;
+		if (dry_run) {
+			/* reuse the buffer in dry_run mode */
+			stream.next_out = buf;
+			stream.avail_out = bufsize;
+		}
 	}
 	git_inflate_end(&stream);
 	return buf;
@@ -323,7 +329,7 @@ static void added_object(unsigned nr, enum object_type type,
 static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 				   unsigned nr)
 {
-	void *buf = get_data(size);
+	void *buf = get_data(size, dry_run);
 
 	if (!dry_run && buf)
 		write_object(nr, type, buf, size);
@@ -357,7 +363,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 	if (type == OBJ_REF_DELTA) {
 		oidread(&base_oid, fill(the_hash_algo->rawsz));
 		use(the_hash_algo->rawsz);
-		delta_data = get_data(delta_size);
+		delta_data = get_data(delta_size, dry_run);
 		if (dry_run || !delta_data) {
 			free(delta_data);
 			return;
@@ -396,7 +402,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 		if (base_offset <= 0 || base_offset >= obj_list[nr].offset)
 			die("offset value out of bound for delta base object");
 
-		delta_data = get_data(delta_size);
+		delta_data = get_data(delta_size, dry_run);
 		if (dry_run || !delta_data) {
 			free(delta_data);
 			return;
-- 
2.34.0

