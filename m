Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A438FC433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 18:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42ABC2065D
	for <git@archiver.kernel.org>; Wed, 13 May 2020 18:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkcUaKD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390027AbgEMSFR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 14:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732488AbgEMSFR (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 14:05:17 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0435EC061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 11:05:17 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id a136so170733qkg.6
        for <git@vger.kernel.org>; Wed, 13 May 2020 11:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T3RQyxwzk5eD5Tov/2/bHuda9GtTYa6j6s5ayYwMMTI=;
        b=SkcUaKD1QpHw16kT9rxFaay2g4awwogg+smjQUl3TWry/JInOcK+lAvjAx/3rFtSab
         Y9lC4v4qhkMIActRtivJN4BOUMyD1ZutPuP5JNL3HLxzvzxI8LCUA4k1cmTFjfKgVh1X
         s/NmtXZR/hkOyEJIu4+MYiKddlYYZWtJcmJWzFPUTox/jnXPOS6RJZrhULd0U1hxSs7Y
         yxTWCC1NuG5a4ne0+VK0LmvULoVqFWt0/r2eIp2hAO8mCF1HF8Ts4a9qNorMMrImmmrL
         Q+t2EVbYKcc6z9MBDPDcjaAbCp5cr1qJgVuoaUvMYQ3PVRm8aS/2lt/D5qfCW+SQ2oQf
         sNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T3RQyxwzk5eD5Tov/2/bHuda9GtTYa6j6s5ayYwMMTI=;
        b=SiMfPtxG8hz3E8Zcg/klhQaOilMCJLTcByuDDWJqG00OohYo+2oFV3XkGeS3C+Iqt9
         UDmB/vwS2cwdyL37d/nnFwZBMwA3ALK1I9Raaidhal2RDvJ6hPwAPFDQGAH+eOzf6+hJ
         aDzZunC3tiXYr4FK74KWTtpkcqXS5YOvpOlUkgWQqHS7zIUGByopj4vLjXHvLYO4wNuu
         jdIJFhD+r0NO9sv5rccbi2TB8+5/enDxCtP5Dh9qirIH+zYG9GPSB85d1kjSWD3er3o5
         WpfDKH7+DDZmqgIGXW4vyzcVqiHKvZprgKrehSapjECj6dMSbvx19FfKZtaR00VQEQoM
         VAWA==
X-Gm-Message-State: AOAM533EUN+RA8sHGVdvOzTMkGYMv4uL8vrA0l4JRnNigWxwemDku/J7
        ru/5aRDdfGa1n5mm8z6xWG/u1L4p
X-Google-Smtp-Source: ABdhPJx0yZnuMps8QyGu0igDaqGLGlIXUw8Rkh+4128HbImWZUqu0AZMZJX+VXECti0ROqYvGZMsKA==
X-Received: by 2002:a37:6e42:: with SMTP id j63mr868458qkc.495.1589393115892;
        Wed, 13 May 2020 11:05:15 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id z60sm301153qtc.30.2020.05.13.11.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 11:05:14 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 5/6] remote-curl: error on incomplete packet
Date:   Wed, 13 May 2020 14:04:57 -0400
Message-Id: <3ed7cf87aaa40ee66b20aa929d89d28fefcec312.1589393036.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.706.g87896c9627
In-Reply-To: <cover.1589393036.git.liu.denton@gmail.com>
References: <cover.1589393036.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, remote-curl acts as a proxy and blindly forwards packets
between an HTTP server and fetch-pack. In the case of a stateless RPC
connection where the connection is terminated with a partially written
packet, remote-curl will blindly send the partially written packet
before waiting on more input from fetch-pack. Meanwhile, fetch-pack will
read the partial packet and continue reading, expecting more input. This
results in a deadlock between the two processes.

Instead of blindly forwarding packets, inspect each packet to ensure
that it is a full packet, erroring out if a partial packet is sent.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

Notes:
    Unfortunately, I'm not really sure how to test this.

 remote-curl.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index da3e07184a..8b740354e5 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -682,6 +682,8 @@ static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
 struct rpc_in_data {
 	struct rpc_state *rpc;
 	struct active_request_slot *slot;
+	struct strbuf len_buf;
+	int remaining;
 };
 
 /*
@@ -692,6 +694,7 @@ static size_t rpc_in(char *ptr, size_t eltsize,
 		size_t nmemb, void *buffer_)
 {
 	size_t size = eltsize * nmemb;
+	size_t unwritten = size;
 	struct rpc_in_data *data = buffer_;
 	long response_code;
 
@@ -702,7 +705,42 @@ static size_t rpc_in(char *ptr, size_t eltsize,
 		return size;
 	if (size)
 		data->rpc->any_written = 1;
-	write_or_die(data->rpc->in, ptr, size);
+
+	while (unwritten) {
+		if (!data->remaining) {
+			int digits_remaining = 4 - data->len_buf.len;
+			if (digits_remaining > unwritten)
+				digits_remaining = unwritten;
+			strbuf_add(&data->len_buf, ptr, digits_remaining);
+			ptr += digits_remaining;
+			unwritten -= digits_remaining;
+
+			if (data->len_buf.len == 4) {
+				data->remaining = packet_length(data->len_buf.buf);
+				if (data->remaining < 0) {
+					die(_("remote-curl: bad line length character: %.4s"), data->len_buf.buf);
+				} else if (data->remaining <= 1) {
+					data->remaining = 0;
+				} else if (data->remaining < 4) {
+					die(_("remote-curl: bad line length %d"), data->remaining);
+				} else {
+					data->remaining -= 4;
+				}
+				write_or_die(data->rpc->in, data->len_buf.buf, 4);
+				strbuf_reset(&data->len_buf);
+			}
+		}
+
+		if (data->remaining) {
+			int remaining = data->remaining;
+			if (remaining > unwritten)
+				remaining = unwritten;
+			write_or_die(data->rpc->in, ptr, remaining);
+			ptr += remaining;
+			unwritten -= remaining;
+			data->remaining -= remaining;
+		}
+	}
 	return size;
 }
 
@@ -920,6 +958,8 @@ static int post_rpc(struct rpc_state *rpc, int flush_received)
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, rpc_in);
 	rpc_in_data.rpc = rpc;
 	rpc_in_data.slot = slot;
+	strbuf_init(&rpc_in_data.len_buf, 4);
+	rpc_in_data.remaining = 0;
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &rpc_in_data);
 	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
 
@@ -936,6 +976,9 @@ static int post_rpc(struct rpc_state *rpc, int flush_received)
 	if (!rpc->any_written)
 		err = -1;
 
+	if (rpc_in_data.remaining)
+		err = error(_("%d bytes are still expected"), rpc_in_data.remaining);
+
 	curl_slist_free_all(headers);
 	free(gzip_body);
 	return err;
-- 
2.26.2.706.g87896c9627

