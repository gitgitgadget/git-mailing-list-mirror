Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 290942018F
	for <e@80x24.org>; Wed, 13 Jul 2016 15:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbcGMPoi (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 11:44:38 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34111 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbcGMPog (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 11:44:36 -0400
Received: by mail-lf0-f66.google.com with SMTP id a10so3970355lfb.1
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 08:44:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ytK3wLXesn4P/fRPVDqd1nkl3wEdrZqvKDw86ip2LaQ=;
        b=0jSC7wjJiF3+54TAxLsgFysbtRLLm3Ycy+VTnRAO9bYwqtzhvzMrgfWbwym+BvK6cP
         sT3xevkmVOVeAYmbuzqHGmwMNuyQAszrv+N92TRVkSkhCBUEFYGdP/RgV7x9ZM1aVO0S
         ub2+NpAjEHrdqPUxjEAUMa5SlKoKP24WO9GQZrh6VNP4jiDkiesPk4qGIfXLWfg6v1mD
         +eWCKFfHdrYu1W2bKV8TDLULHhVGr0o094CWkMXNGmfTmeo4eaZ2W8yC6VB7cwCxcvmk
         7SEyoKjZSWoHozvQxQVbMSdDh5rCySfX9hBo3a3x2J4JLqY1rWno8ZpXx4cRffDRpXIU
         yBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ytK3wLXesn4P/fRPVDqd1nkl3wEdrZqvKDw86ip2LaQ=;
        b=mCT2KUvJx2oUD5ukY7n39uZ99sb6nh8XuwM7hrTMd48D01FOXVSm1rsmAeYqyZK6fN
         HLbU95aGjrPM1BoMjyNrlrd6Nc5Z4LqN6EHtFlny2dzTKV7aGfWQ3SzYH46PUjC9jqBU
         SQphQJ/2kSG8D1XroXD1NuveucSjsQ1BUOkqFs4miwVZN/Cj4FwJ9otCeMPiwuZbMvbI
         NAUtkWRFjXWTIiBkTLCSQL5KpTo4L4RHAbTU9gPyaNNegD/PlQ9GZxweEzGd1RVZo4lL
         sihaporXLl0zGpGFe2fn0BiRyxX8DaBNdI/9jA96KmaIAt7dbUUQaa8g9CIylmwR6hSp
         7nnQ==
X-Gm-Message-State: ALyK8tKF+EwCx/G4vcuLNM6HQ83zg+CW8FA/opwx3ni+p5huXUtRTchgasZbMnHRd9sncw==
X-Received: by 10.46.0.39 with SMTP id 39mr1983009lja.48.1468424654297;
        Wed, 13 Jul 2016 08:44:14 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 90sm2575484lfw.30.2016.07.13.08.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jul 2016 08:44:13 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, michelbach94@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/7] sha1_file.c: use type off_t* for object_info->disk_sizep
Date:	Wed, 13 Jul 2016 17:43:59 +0200
Message-Id: <20160713154404.22909-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.9.1.564.gb2f7278
In-Reply-To: <20160713154404.22909-1-pclouds@gmail.com>
References: <20160705170558.10906-1-pclouds@gmail.com>
 <20160713154404.22909-1-pclouds@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/cat-file.c | 4 ++--
 cache.h            | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 54db118..13ed944 100644
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
 
@@ -184,7 +184,7 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 		if (data->mark_query)
 			data->info.disk_sizep = &data->disk_size;
 		else
-			strbuf_addf(sb, "%lu", data->disk_size);
+			strbuf_addf(sb, "%"PRIuMAX, (uintmax_t)data->disk_size);
 	} else if (is_atom("rest", atom, len)) {
 		if (data->mark_query)
 			data->split_on_whitespace = 1;
diff --git a/cache.h b/cache.h
index 4ff196c..ea64b51 100644
--- a/cache.h
+++ b/cache.h
@@ -1502,7 +1502,7 @@ struct object_info {
 	/* Request */
 	enum object_type *typep;
 	unsigned long *sizep;
-	unsigned long *disk_sizep;
+	off_t *disk_sizep;
 	unsigned char *delta_base_sha1;
 	struct strbuf *typename;
 
-- 
2.9.1.564.gb2f7278

