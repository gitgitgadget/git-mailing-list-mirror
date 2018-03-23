Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66B4C1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeCWRWq (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:22:46 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34107 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbeCWRWF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:22:05 -0400
Received: by mail-lf0-f66.google.com with SMTP id c78-v6so14703739lfh.1
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FdEG2A94x3Bkv8hx+N9tdR+498CUzFtzidm3zdZMQL4=;
        b=U3w41ijXLf/PiR/xSHjZsmJp1tYxeK6RP87QCMnC8cpGTxJEAqzXTDjUrFTMOCvSB1
         eGjcroAvSJyG9RP8swfFgHLe/Cd04UkhMTkgp5nlGhW4ptYPXz89XZUQ3UsiRRg0AN1C
         vzL7mjOBZwv2L1O0YCWHseBjnHog4dNjqySz/lAwsIHAujlmAshJNz7H9mSAZ4DbMy9y
         nl14q4VS9+vjLrc/NUfTG1Rv6w4J4N8qsirDMEKnZRgeIIeftYnVP2deJmzcc0vOi0vp
         3iJBF6kyT7KkrpBf4l9nZ5Z9aJrPAdLRamT9BmyK7HlItbEXffkDvdzOt/nqvSfVZYtw
         RNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FdEG2A94x3Bkv8hx+N9tdR+498CUzFtzidm3zdZMQL4=;
        b=X+Db11QEYCLTQ8SAvIVtc6CFMiueILX9fm0+WY0Wam1TMzvj6kG/UdCjsxPxGi7PkD
         JDHRK1/FooCU/uDbxQQ3FxVDUhvkF7cc5etGariNai8a60dxArZriUdYf8WC7CREGafE
         muP5bByWZO/TJtOB8/QLqmrC7qVnRteZRRAACrTuxQLNFUqwh3xtEfUTleiweFoMaLVI
         HLuV2Pt7ytwTfrZhsIlJc29HJQ+sSKKStgLQSdJLsioaIDEoQ9wNrbHqt1SUnhfQpjaj
         5j+4cTZxuNCXedJjeBM0WcHFWLeMaDRy8IUGLpQXWekViq9ViTWgw9hrQojRBOhiJTmW
         TZHw==
X-Gm-Message-State: AElRT7Ghypbjjy/s7WZaj9dSq6ccc1DxKEN+f273PKJSMwzhNjm/l/DQ
        +0EfSjDF8Iy0vrMbPSTPZb4=
X-Google-Smtp-Source: AG47ELuPtX3nhpwf2EpH0+akVKaYdDEBQEAdel1HsnhJTtOjasdsIKhuaOCzEk5q+PQpi5ihx7NeRw==
X-Received: by 10.46.32.154 with SMTP id g26mr10542013lji.71.1521825724010;
        Fri, 23 Mar 2018 10:22:04 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.22.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:22:02 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 18/27] sha1_file: add repository argument to open_sha1_file
Date:   Fri, 23 Mar 2018 18:21:12 +0100
Message-Id: <20180323172121.17725-19-pclouds@gmail.com>
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

Add a repository argument to allow the open_sha1_file caller to be
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
 sha1_file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 80bac89014..a2ab2b82c3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -896,7 +896,9 @@ static int stat_sha1_file_the_repository(const unsigned char *sha1,
  * Like stat_sha1_file(), but actually open the object and return the
  * descriptor. See the caveats on the "path" parameter above.
  */
-static int open_sha1_file(const unsigned char *sha1, const char **path)
+#define open_sha1_file(r, s, p) open_sha1_file_##r(s, p)
+static int open_sha1_file_the_repository(const unsigned char *sha1,
+					 const char **path)
 {
 	int fd;
 	struct alternate_object_database *alt;
@@ -939,7 +941,7 @@ static void *map_sha1_file_1(const char *path,
 	if (path)
 		fd = git_open(path);
 	else
-		fd = open_sha1_file(sha1, &path);
+		fd = open_sha1_file(the_repository, sha1, &path);
 	map = NULL;
 	if (fd >= 0) {
 		struct stat st;
-- 
2.17.0.rc0.348.gd5a49e0b6f

