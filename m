Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 574051FAE2
	for <e@80x24.org>; Fri, 23 Mar 2018 17:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeCWRWp (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:22:45 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35972 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752282AbeCWRWG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:22:06 -0400
Received: by mail-lf0-f67.google.com with SMTP id z143-v6so19392654lff.3
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+QDVpxYveTPV2SlS75AHE8V6Ynrv3KXrJ80MQrxkhEk=;
        b=u0BqSTAnb7Q2fIQClhBic2OqjwR91qS2b5KchI1fLCTPqJstpoLGca/6VH3M3XFSkQ
         H5X7IAMVu9ebSDpUy1mVogj2ML7CIdkUMlbjhb4Fty3di42Ll4/Z3vrITcezlTRuLqUi
         JwutX1y5tvmoCC0Hw4H1+x2UbAM1X5fLVNewT2V9bNYpFAWsNiJNp/PfjtxfTTf4SZ57
         A+/kCYuWqFHgj71NtyDtmBsyVKHwuxrMOVIrpy8juQlDactbxPI97LIgA+8qQzXAPP6/
         bsNuxy+0zg3+Qxyvpm6I6VChGQi5zppNRTYFtv81uYhwFHaJzr+yKScdZt7btb4zl5WR
         h83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+QDVpxYveTPV2SlS75AHE8V6Ynrv3KXrJ80MQrxkhEk=;
        b=aKlzDt448uyBax3g/xUGaAgT1hmS75cRJANuOjcx4+1dUmpimbiF8AiYnBeVlYnwOS
         SXLDYN2Wnn4/k9GbG6/OjxRqQyQzzRq/fbbTt8wuwqYLTIcgMYZLj/DAHo5a+o1XvynH
         UPTwwt/O8JxE3H/ybwoYKYeTt8ytSFbjXlmdHuySamwd6s0OeM0to+veDYeWmHxxhtIH
         RTGoz5tSpccSIkwqCK0CBfSegGFsaUn7yRbwydgTtX4L2euOwOxlpNz5t0caY98S0FzN
         +PE3KwLlEodR9x4PJGg0O6ytKh89Jmpx3wWt/SeeGY+zSnpK+Bkf75wpdMrxshfSDxrR
         EqIw==
X-Gm-Message-State: AElRT7GpuLAadmb5cZX1CnIsr8P2NEF/enrL33kwXvY1nbp8srzoOban
        Rie7K7vjb8SnKd4bDUQPswc=
X-Google-Smtp-Source: AIpwx4/lq2vIT0ebOhF66nMorKaHdi518tk7h4BMx73Ju4p+DNaf7zTSkwbMfRv2bRfSsFVUpUpGtQ==
X-Received: by 2002:a19:ca41:: with SMTP id h1-v6mr3207761lfj.81.1521825725363;
        Fri, 23 Mar 2018 10:22:05 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:22:04 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 19/27] sha1_file: add repository argument to map_sha1_file_1
Date:   Fri, 23 Mar 2018 18:21:13 +0100
Message-Id: <20180323172121.17725-20-pclouds@gmail.com>
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

Add a repository argument to allow the map_sha1_file_1 caller to be
more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index a2ab2b82c3..4b6144b7cd 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -931,9 +931,10 @@ static int open_sha1_file_the_repository(const unsigned char *sha1,
  * Map the loose object at "path" if it is not NULL, or the path found by
  * searching for a loose object named "sha1".
  */
-static void *map_sha1_file_1(const char *path,
-			     const unsigned char *sha1,
-			     unsigned long *size)
+#define map_sha1_file_1(r, p, s, si) map_sha1_file_1_##r(p, s, si)
+static void *map_sha1_file_1_the_repository(const char *path,
+					    const unsigned char *sha1,
+					    unsigned long *size)
 {
 	void *map;
 	int fd;
@@ -962,7 +963,7 @@ static void *map_sha1_file_1(const char *path,
 
 void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
 {
-	return map_sha1_file_1(NULL, sha1, size);
+	return map_sha1_file_1(the_repository, NULL, sha1, size);
 }
 
 static int unpack_sha1_short_header(git_zstream *stream,
@@ -2192,7 +2193,7 @@ int read_loose_object(const char *path,
 
 	*contents = NULL;
 
-	map = map_sha1_file_1(path, NULL, &mapsize);
+	map = map_sha1_file_1(the_repository, path, NULL, &mapsize);
 	if (!map) {
 		error_errno("unable to mmap %s", path);
 		goto out;
-- 
2.17.0.rc0.348.gd5a49e0b6f

