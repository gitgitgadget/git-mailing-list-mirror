Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC1841F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751400AbeCWRW3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:22:29 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34134 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbeCWRWP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:22:15 -0400
Received: by mail-lf0-f65.google.com with SMTP id c78-v6so14704472lfh.1
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nlnxQuQDupHk9tvme7uv0P86v6A03qu7AhhmUEkw4cQ=;
        b=bkvQQLrALiYl8b7pqgCoCNGHCIZTomxWVO3qNAI/bV16M2BP+7LVezYM3f5Z+a9izs
         EjKMrevmQnUdesEjbunkCqoGSRjHjhkt+K2z3yu7CzbGjVvZmxZMnhrYZ5jMhvv0msvQ
         OlOVoL/kpDOJ1s5J1B2aVf7GXjxSrQQdww3I5fS22bbkorj+342BbAtKzSFoVNFStcKw
         l6kmsnlBVIHA/tZJkY2Yl/rDNo42BPYs/tGbJ8rbtb1Npw2F7avQVlVvDitubf9nx+0c
         HTZ51HjBnWJoes55x3YoG/cb4kV3+uQJdizHHNcILw9grRullYgwDLNKd410rksAvESB
         tBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nlnxQuQDupHk9tvme7uv0P86v6A03qu7AhhmUEkw4cQ=;
        b=CQuq5+BCYnrHxnbo8fHYYYajkWWvtUMB4vkpkrTLDvwZajpXlKJzl4Kg3Rj7SislQf
         fd+feHQK9anLTcQGKH+IVsOD5TL5WmcAqRnHaLm6YEv3bs9PCeapqPb/8PQPEwhhC2Z1
         2DJfgF+POwbqi/maHgBJui4D7aGhPZb2tlersT3PDFfFW0LeZFasc9DeKC0yWIoTMioN
         Fl8kddLH+DTnQN0Xz2FT43WOmB6k+MP2jZkJBuVEnb1do5OKHVzGVsXYyZt0zlBZGD/S
         /2Vzv6xwVqYDV9InkrxR0s9Us6NvWrxzgNqui/aVLpgQ/WzRk3CFggTnN8GrPtkiXDMf
         F45g==
X-Gm-Message-State: AElRT7EqHdBYuqkY7I89AuhacaZtaMbhY7NVt9TT3Rv4CSMaJG+TThJL
        lhIFF1WeFe7UbF6L2AaQqik=
X-Google-Smtp-Source: AG47ELt2pZSKYImIws5XgElfBZ0QjG8SzatBtyBcSOEhs+JZ2nCbS7+E/pWluNyUV87zjOcMkkfvxg==
X-Received: by 10.46.122.15 with SMTP id v15mr4780156ljc.141.1521825733824;
        Fri, 23 Mar 2018 10:22:13 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:22:13 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 25/27] sha1_file: allow map_sha1_file_1 to handle arbitrary repositories
Date:   Fri, 23 Mar 2018 18:21:19 +0100
Message-Id: <20180323172121.17725-26-pclouds@gmail.com>
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

From: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 1fa32c8a06..1d5d23dfe2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -929,10 +929,8 @@ static int open_sha1_file(struct repository *r,
  * Map the loose object at "path" if it is not NULL, or the path found by
  * searching for a loose object named "sha1".
  */
-#define map_sha1_file_1(r, p, s, si) map_sha1_file_1_##r(p, s, si)
-static void *map_sha1_file_1_the_repository(const char *path,
-					    const unsigned char *sha1,
-					    unsigned long *size)
+static void *map_sha1_file_1(struct repository *r, const char *path,
+			     const unsigned char *sha1, unsigned long *size)
 {
 	void *map;
 	int fd;
@@ -940,7 +938,7 @@ static void *map_sha1_file_1_the_repository(const char *path,
 	if (path)
 		fd = git_open(path);
 	else
-		fd = open_sha1_file(the_repository, sha1, &path);
+		fd = open_sha1_file(r, sha1, &path);
 	map = NULL;
 	if (fd >= 0) {
 		struct stat st;
-- 
2.17.0.rc0.348.gd5a49e0b6f

