Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EEF220706
	for <e@80x24.org>; Tue,  5 Jul 2016 17:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294AbcGERGf (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 13:06:35 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34240 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755066AbcGERG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 13:06:29 -0400
Received: by mail-lf0-f68.google.com with SMTP id l102so7946015lfi.1
        for <git@vger.kernel.org>; Tue, 05 Jul 2016 10:06:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AzRyMFTU8iFjDyWN7grnueblYgnHApZZpqnj24crZSc=;
        b=pJz2JweCjj4YC/2MhpSBacH6EgqO+KnUMp5/fv073fwzlrgTTJFntHv9TJTwchWEPr
         4QQj/ypiqbFPb9XW2Cvw+SsqZKbUmXXF+2P7nDN4p+jfKQDkEIum5nAYN+g4IJ4leEZ1
         uzZH/tVYEFGo62qnXagco39XD3D/7LwCJMFR/k1iB5tyfUUK9jpoeJaNJ/YZQgVM4TmV
         i48H/WT+qsHLJ/1dPbjROPqDHjXNUOmLK+Cbf0WRBD6QYbm25FZ5u+7yoYSZR+3gJNJ6
         lS+PKI1CWCcmBcmz9t/sGnihEckXkwTf03FBaFwnjhrH01UcTwKCQN6pZTJHLId0uoni
         jeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AzRyMFTU8iFjDyWN7grnueblYgnHApZZpqnj24crZSc=;
        b=JxHU9XGJngntdZBGDMNsNis1J2uq6IAdgplCyRCvUZE6fiJiuq43nRW4KljDQs5aiC
         hB1Qw8OIRmUZ/wEvoNezmBX5n9fbOd8yjWVzdRszZLPuqd41xTot0ybaTiyvKOeJ9zqv
         iKdluM/hnjPcBxuiMmKYEnR1jbcMqAcEloqClzDHFfyxHLXef9hqBm5K4JSzW5V4rdiZ
         J4Go8HXQrMaq+dcRIU4cPWMhQ5XhnbWEgGlHjtoz3gp3urRs7enEMGzcJ6Fk1Tpwcy4V
         2da7Wm0cKcet3bFuFcBKLpyELxihsWH7CnTL0Llcqq9y8bTXcCedoh9H8DcxZnPEUb3V
         k+YA==
X-Gm-Message-State: ALyK8tKM5fs7inyW1Bucftr22rp6u7MXP/5vc4GiSRTeO9ICWj75X5UGbl5A/lyhqdicMA==
X-Received: by 10.46.32.73 with SMTP id g70mr4626860ljg.28.1467738382747;
        Tue, 05 Jul 2016 10:06:22 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 142sm5693793ljj.4.2016.07.05.10.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Jul 2016 10:06:22 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, michelbach94@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/5] sha1_file.c: use type off_t* for object_info->disk_sizep
Date:	Tue,  5 Jul 2016 19:05:55 +0200
Message-Id: <20160705170558.10906-3-pclouds@gmail.com>
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

This field, filled by sha1_object_info() contains the on-disk size of
an object, which could go over 4GB limit of unsigned long on 32-bit
systems. Use off_t for it instead and update all callers.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/cat-file.c | 4 ++--
 cache.h            | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 618103f..5b34bd0 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -131,7 +131,7 @@ struct expand_data {
 	unsigned char sha1[20];
 	enum object_type type;
 	unsigned long size;
-	unsigned long disk_size;
+	off_t disk_size;
 	const char *rest;
 	unsigned char delta_base_sha1[20];
 
@@ -191,7 +191,7 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 		if (data->mark_query)
 			data->info.disk_sizep = &data->disk_size;
 		else
-			strbuf_addf(sb, "%lu", data->disk_size);
+			strbuf_addf(sb, "%"PRIuMAX, data->disk_size);
 	} else if (is_atom("rest", atom, len)) {
 		if (data->mark_query)
 			data->split_on_whitespace = 1;
diff --git a/cache.h b/cache.h
index c73becb..a4465cb 100644
--- a/cache.h
+++ b/cache.h
@@ -1508,7 +1508,7 @@ struct object_info {
 	/* Request */
 	enum object_type *typep;
 	unsigned long *sizep;
-	unsigned long *disk_sizep;
+	off_t *disk_sizep;
 	unsigned char *delta_base_sha1;
 	struct strbuf *typename;
 
-- 
2.8.2.537.g0965dd9

