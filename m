Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 519A320706
	for <e@80x24.org>; Tue,  5 Jul 2016 17:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755145AbcGERGj (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 13:06:39 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36474 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755205AbcGERGa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 13:06:30 -0400
Received: by mail-lf0-f66.google.com with SMTP id a2so20219364lfe.3
        for <git@vger.kernel.org>; Tue, 05 Jul 2016 10:06:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2LTTbxn9ml/mGg6dgVUiCqAZ1lO7e2mtdYJr9b3pXSQ=;
        b=zR74cvZqCYsV8qlyzNsx/WMzeWG7/kkojuWDTR3Xl4EIes0NYv1zbtWONBoifnJMw6
         EZTFpYlb1rZXw/qtUd+J6lFRnc0010WYO6/CXmZaZi2fu2LmBPALSIczyAE2qvsAZKWs
         GMdEPZagtH+G7qqLeu8sAQ1YDRULxH+gwe1vNKKCfIMOT7oWZrtpwB83jzjMQ9vR6FMQ
         D9I9WifHA4RfLsNLV4V7gebwIn/SvoakQ1MkJBg7TSSufqZ+q3K437l9xNNIZ37cayTH
         bLE6XeKVI8hurLgZmdS1V7Qri52AzjZL/kvNGMkdwSSxFaMpGc2WobSaAyY18hQOZgQu
         jdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2LTTbxn9ml/mGg6dgVUiCqAZ1lO7e2mtdYJr9b3pXSQ=;
        b=jXYty69rkq7iCzM0V4af9rVaZNkB/WbhGQ28DyZzL3qwt/ej67yd6xrkFHLYzgyFzi
         rj2NkZAUjXTGqVYLtMYluiY2T0Ohm9/R20+bfBLL7xbwD7Bb4ajPrU/pGC6cj5Km+SQR
         Z/Y+dn9kw7MJAIY2fS+9qN2mpgP6i/itjDVIylhQRCCaS+x2zYpV2ShavrAKI5sawQwL
         OJv3PvHWnhFlrd4ARQFmQPdGS2z6fMon30xZ2Wd0nOn5lbgczZS30jKrVKkNwk7XA46k
         +XOH082tqtjfy6MaOBlb5WfKv8vvK1VeVEIC3qK8Haa+jVNNvMNuB6NMYIAkFWUgbX7I
         rcMw==
X-Gm-Message-State: ALyK8tKvLfmymif11+FDSI2safJNoKMG06P+tVb/8ztbDZkErkGg9GkesokNSL6M3sel7Q==
X-Received: by 10.46.9.2 with SMTP id 2mr4810907ljj.1.1467738383708;
        Tue, 05 Jul 2016 10:06:23 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 142sm5693793ljj.4.2016.07.05.10.06.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Jul 2016 10:06:23 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, michelbach94@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/5] index-pack: correct "len" type in unpack_data()
Date:	Tue,  5 Jul 2016 19:05:56 +0200
Message-Id: <20160705170558.10906-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.537.g0965dd9
In-Reply-To: <20160705170558.10906-1-pclouds@gmail.com>
References: <1466807902.28869.8.camel@gmail.com>
 <20160705170558.10906-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 32-bit systems with large file support, one entry could be larger
than 4GB and overflow "len". Correct it so we can unpack a full entry.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/index-pack.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index e8c71fc..cafaab7 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -549,13 +549,13 @@ static void *unpack_data(struct object_entry *obj,
 			 void *cb_data)
 {
 	off_t from = obj[0].idx.offset + obj[0].hdr_size;
-	unsigned long len = obj[1].idx.offset - from;
+	off_t len = obj[1].idx.offset - from;
 	unsigned char *data, *inbuf;
 	git_zstream stream;
 	int status;
 
 	data = xmallocz(consume ? 64*1024 : obj->size);
-	inbuf = xmalloc((len < 64*1024) ? len : 64*1024);
+	inbuf = xmalloc((len < 64*1024) ? (int)len : 64*1024);
 
 	memset(&stream, 0, sizeof(stream));
 	git_inflate_init(&stream);
@@ -563,15 +563,15 @@ static void *unpack_data(struct object_entry *obj,
 	stream.avail_out = consume ? 64*1024 : obj->size;
 
 	do {
-		ssize_t n = (len < 64*1024) ? len : 64*1024;
+		ssize_t n = (len < 64*1024) ? (ssize_t)len : 64*1024;
 		n = xpread(get_thread_data()->pack_fd, inbuf, n, from);
 		if (n < 0)
 			die_errno(_("cannot pread pack file"));
 		if (!n)
-			die(Q_("premature end of pack file, %lu byte missing",
-			       "premature end of pack file, %lu bytes missing",
-			       len),
-			    len);
+			die(Q_("premature end of pack file, %"PRIuMAX" byte missing",
+			       "premature end of pack file, %"PRIuMAX" bytes missing",
+			       (unsigned int)len),
+			    (uintmax_t)len);
 		from += n;
 		len -= n;
 		stream.next_in = inbuf;
-- 
2.8.2.537.g0965dd9

