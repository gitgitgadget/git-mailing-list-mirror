Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD777C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 10:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237990AbhLJKim (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 05:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbhLJKil (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 05:38:41 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32395C061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 02:35:07 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id x5so8180630pfr.0
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 02:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jU5XJfnHQH6Wp8fcR3m4XFy0zXzChs6IdGe7NS2r+5c=;
        b=cgo0y/qcW6mF0e6tE91AGrCyTAvzYEiRwU1j/H1IZnbT7wAuAp00Jr3LzjzQPHXQcO
         4WhAgaBWYTOTFHasvIIliaS/bRyqFgaI2Jvf/VaUrWaAzcHVvOVosJyDyXTHW6rO1ijo
         xc3V9Y6VlQ/vcFowhbGvXxbprXxx26Lktx0lKaJp4/DQTBHOwrJtVkYk7rdWo2T29GKn
         I4wujCRlCCRRBIjX1KjS2LvsPlkOPBhG1c90wNbhQZ1Wyud/4mhfQ7fH0iFXWNqK+e6+
         19/xBN5qZONrFVSxTiH6amGctKW+qg67OuBmVL/vkow666CKHkjcLWZYeJu+Exmqwbt/
         w/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jU5XJfnHQH6Wp8fcR3m4XFy0zXzChs6IdGe7NS2r+5c=;
        b=VkqiYyteqofbJSF9q7bFB5tgtgKlSN4uPUu9/xIF1bS3RC2iTwKb5JDY/8YmKlD9Qv
         jU8BBO0W/QlTjhqJ8DO8Ez+p9S7A/AVcNdSOIUwbAkj0A8xcvKyiSvs845xZ3TZZj/99
         nqc2QGUam/Ax6g8Jzz0yiD2/ISFnLAIdh7yaLnJKCYq8jI3StcJhCP8r5zPTmLMAbcVU
         tf4ZohVWaBXxSJzf8JJgO5g3OyDmseVVX9lmIzZXnS6ztYxj2bLrxTiRrM6MoeVjQnvj
         QTzyJvSrXZJPrNavx5GNJeoejz+ovE1MSeqskKS0dZ/WGCZoVdG6IwfvEJhh2RGaRncg
         c3Mg==
X-Gm-Message-State: AOAM530sZL23QDskfpITajiSq3KI3S3a8m6/vQhiHlJ1vE8eZUh2xb7o
        v7EL1rv2Y4kxqMUoHH2Z6lOQrqj8uuzygQ==
X-Google-Smtp-Source: ABdhPJziIzaklXVPglMRU9H4gBbTj251K5Xi0Yk0oGfk7Vwo+pi90IVD8Z6Pdz8VnNRbXivzdWEgaA==
X-Received: by 2002:a63:8c0a:: with SMTP id m10mr39004118pgd.142.1639132506710;
        Fri, 10 Dec 2021 02:35:06 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.96])
        by smtp.gmail.com with ESMTPSA id 204sm2396250pgb.63.2021.12.10.02.35.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Dec 2021 02:35:06 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v5 3/6] object-file.c: read stream in a loop in write_loose_object()
Date:   Fri, 10 Dec 2021 18:34:32 +0800
Message-Id: <20211210103435.83656-4-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211203093530.93589-1-chiyutianyi@gmail.com>
References: <20211203093530.93589-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

In order to prepare the stream version of "write_loose_object()", read
the input stream in a loop in "write_loose_object()", so that we can
feed the contents of large blob object to "write_loose_object()" using
a small fixed buffer.

Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 object-file.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/object-file.c b/object-file.c
index 41099b137f..455ab3c06e 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1864,7 +1864,7 @@ static int write_loose_object(struct object_id *oid, char *hdr,
 			      int hdrlen, const void *buf, unsigned long len,
 			      time_t mtime, unsigned flags)
 {
-	int fd, ret, err = 0;
+	int fd, ret, err = 0, flush = 0;
 	unsigned char compressed[4096];
 	git_zstream stream;
 	git_hash_ctx c;
@@ -1903,22 +1903,29 @@ static int write_loose_object(struct object_id *oid, char *hdr,
 	the_hash_algo->update_fn(&c, hdr, hdrlen);
 
 	/* Then the data itself.. */
-	if (flags & HASH_STREAM) {
-		struct input_stream *in_stream = (struct input_stream *)buf;
-		stream.next_in = (void *)in_stream->read(in_stream, &len);
-	} else {
+	if (!(flags & HASH_STREAM)) {
 		stream.next_in = (void *)buf;
+		stream.avail_in = len;
+		flush = Z_FINISH;
 	}
-	stream.avail_in = len;
 	do {
 		unsigned char *in0 = stream.next_in;
-		ret = git_deflate(&stream, Z_FINISH);
+		if (flags & HASH_STREAM && !stream.avail_in) {
+			struct input_stream *in_stream = (struct input_stream *)buf;
+			const void *in = in_stream->read(in_stream, &stream.avail_in);
+			stream.next_in = (void *)in;
+			in0 = (unsigned char *)in;
+			/* All data has been read. */
+			if (len + hdrlen == stream.total_in + stream.avail_in)
+				flush = Z_FINISH;
+		}
+		ret = git_deflate(&stream, flush);
 		the_hash_algo->update_fn(&c, in0, stream.next_in - in0);
 		if (write_buffer(fd, compressed, stream.next_out - compressed) < 0)
 			die(_("unable to write loose object file"));
 		stream.next_out = compressed;
 		stream.avail_out = sizeof(compressed);
-	} while (ret == Z_OK);
+	} while (ret == Z_OK || ret == Z_BUF_ERROR);
 
 	if (ret != Z_STREAM_END)
 		die(_("unable to deflate new object %s (%d)"), oid_to_hex(oid),
-- 
2.34.0

