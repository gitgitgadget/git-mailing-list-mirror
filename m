Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 383951F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752446AbeCWRWb (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:22:31 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42944 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeCWRWN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:22:13 -0400
Received: by mail-lf0-f67.google.com with SMTP id a22-v6so19371957lfg.9
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mFMd+s8ksDLSUu/mRGCq1SbRnPifRYwr7dwSdkuI0YY=;
        b=SZtPF95i4Gr9fMwmxz+B6a3sZRGTlq/mOGIAh5lrK3ytBaePBXwyRDTClo4QG0NIWA
         8mZqekDK6257mPLOYYeJbn7FLh8two01hAAX8h8hfgl7RsaGsd/bN6Dpw1KWDmXwesc1
         sCSniymrvksowpM7+9HEJT988Uylkhmglr6tf+GQDg4C2gmBfMkGonQrEvGdw/rhWM/L
         NdFjPWbp9JNXI7m3U1aiMN1+ddQAuVVx/v9skKq495nbFImp1QvTm+jmIPGkqMUFyaFe
         aTWKchuMb6FSVEgn23WBgGEa3tFR7p/qUcq2U0/fu3yBvXj5zoJFjGxhXJcgrAdQimfO
         IUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mFMd+s8ksDLSUu/mRGCq1SbRnPifRYwr7dwSdkuI0YY=;
        b=IVYto//d2WuhvmQzCAYFs/l85Qize/eLUMnXn7wXGLC0kCNCEsldETwxtzdKtquajm
         MhE+cq9urtYIaxzIKT3S2rj1N8n3QNXHEUSj1y19vNahy7bsb6x/DwNh4sHGCoBZnqgR
         GBMZd9TdU2eOeHZ1RFzEOOZFXFY7QP9VTPro+/9ADhlYv5Em0ntzNP361VxD8aOwjcyu
         JUBs4QHRi4fYPyCRCrEoPRzKZ/gDsrMnjuUZTf0P6BfupExA2CU7pxiJxqquCQFOMQ/o
         fGxlXLf9sGaC4Na8bamXRYllwYwSR5GZ8l5NDjqe1XpMR54A8b9vVpBaOME1JAL5UwCb
         x3jg==
X-Gm-Message-State: AElRT7F7I3aVGJVO1lqIwUMpSMjjsSonnyPMdwewEyJIGoWvyAhuw14s
        7xBF+BOUxEpZx/SxdGDSme0=
X-Google-Smtp-Source: AG47ELsd8ig9h+GyRjSKN3idM2FilqxTotwv9L/oqINHILLlVaGkgW5AsNUhNimhNkReOVUOtQoMFw==
X-Received: by 10.46.93.219 with SMTP id v88mr19637632lje.88.1521825732234;
        Fri, 23 Mar 2018 10:22:12 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:22:11 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 24/27] sha1_file: allow open_sha1_file to handle arbitrary repositories
Date:   Fri, 23 Mar 2018 18:21:18 +0100
Message-Id: <20180323172121.17725-25-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323172121.17725-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323172121.17725-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1_file.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index fc4f209981..1fa32c8a06 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -895,9 +895,8 @@ static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
  * Like stat_sha1_file(), but actually open the object and return the
  * descriptor. See the caveats on the "path" parameter above.
  */
-#define open_sha1_file(r, s, p) open_sha1_file_##r(s, p)
-static int open_sha1_file_the_repository(const unsigned char *sha1,
-					 const char **path)
+static int open_sha1_file(struct repository *r,
+			  const unsigned char *sha1, const char **path)
 {
 	int fd;
 	struct alternate_object_database *alt;
@@ -905,7 +904,7 @@ static int open_sha1_file_the_repository(const unsigned char *sha1,
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	sha1_file_name(the_repository, &buf, sha1);
+	sha1_file_name(r, &buf, sha1);
 	*path = buf.buf;
 
 	fd = git_open(*path);
@@ -913,8 +912,8 @@ static int open_sha1_file_the_repository(const unsigned char *sha1,
 		return fd;
 	most_interesting_errno = errno;
 
-	prepare_alt_odb(the_repository);
-	for (alt = the_repository->objects->alt_odb_list; alt; alt = alt->next) {
+	prepare_alt_odb(r);
+	for (alt = r->objects->alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		fd = git_open(*path);
 		if (fd >= 0)
-- 
2.17.0.rc0.348.gd5a49e0b6f

