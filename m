Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A0BA1F576
	for <e@80x24.org>; Sun, 25 Feb 2018 11:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeBYLTC (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 06:19:02 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36006 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbeBYLTB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 06:19:01 -0500
Received: by mail-pf0-f193.google.com with SMTP id 68so5391303pfx.3
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 03:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VjBuujGFkFRxhrZfH7bzsFY4cLnSvp2Z+zMU3GH6ZSk=;
        b=KJZ0Nimd60YZeOf/LTIFc3u6z8rYiICJsiNuluy6oPv6BCmxbZrYgXImix+F0H0E29
         XIt1JhPUotzMBjCoLxPMJRj/a60HKy7+PjSCTqal933Q9N1VQtNpmguv4zfTZtGYjTEg
         h68BxxTXe5gFRJur+d88X1ZDxyLc9tvZlMp+m9s3F28PuulAcA4e0rqSmV15V5Db2fYY
         Wg2+Mwb9buSPuOkJp1BHMuyIIXBoqzdssqHgDRHXnmuBu9SXQlv8Psgbnv6bVu8ed/vc
         0Ua3MnNqdsltQRc1bXHVtZkUocii1coD4SCOiZ0TE+bS6wmDKQeumcH9VeVtv1zeFVwV
         4eVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VjBuujGFkFRxhrZfH7bzsFY4cLnSvp2Z+zMU3GH6ZSk=;
        b=lvTju4OjG5uEzuwLow3HP0w30cfFMQid/MMw1X/d+06I1RUVrliRFzpZYNZ3HpCacA
         49WVCjM+nF3v6Ww4HgCSxQ6i7xn91VfEeR4Ge5Y1E+w9kLxF7eStcQXguZmcNGxgpO6G
         KPeKVxywH1qkAPoLwPHzUlS4eomDSOMbCA8P1FrL8dt6kLKR4DC75YEtdgzAvg+1zhvH
         Z4UwiZsx4SHylMUa2Xa+qBZRCUFamHgfhiyQvBPQHB9hzuFyVZCAdJhohHn0hZRpqSy6
         TeFaDBhRZ5UnfKPOs1NmieiiU29pAkXivNuV5lIuFSPy3dzJEGB6BVmKMQ+zWz61JfSD
         eHpw==
X-Gm-Message-State: APf1xPD+uSJNK+UwxAr4mCp157mtRnLbZ2ix4wbBdzbb7kJPumGHO3ww
        WwlfcysliLf0oWcDYwrGTbY=
X-Google-Smtp-Source: AH8x226UmIifl/w8Al4r9LhnSt4v+GFG2jxct/73kmK5EUNVC0PpLQuGu9c1ZwxpYqt9k5ZujGnInQ==
X-Received: by 10.98.9.5 with SMTP id e5mr7316715pfd.189.1519557541257;
        Sun, 25 Feb 2018 03:19:01 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id s127sm14171818pfb.178.2018.02.25.03.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Feb 2018 03:19:00 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 25 Feb 2018 18:18:56 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sandals@crustytoothpaste.net,
        sbeller@google.com, sunshine@sunshineco.com
Subject: [PATCH v3 2/6] sha1_file.c: keep a good name for "unknown" hash_algos[UNKNOWN]
Date:   Sun, 25 Feb 2018 18:18:36 +0700
Message-Id: <20180225111840.16421-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180225111840.16421-1-pclouds@gmail.com>
References: <20180224033429.9656-1-pclouds@gmail.com>
 <20180225111840.16421-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is mostly for displaying the hash algorithm name when we report
errors. Printing "unknown" with '%s' is much better than '(null)' in
glibc printf version (and probably could crash if other implementations
do not check for NULL pointer)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 826d7a0ae3..4b266b1c68 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -71,7 +71,7 @@ static void git_hash_unknown_final(unsigned char *hash, git_hash_ctx *ctx)
 
 const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 	{
-		NULL,
+		"unknown",
 		0x00000000,
 		0,
 		0,
-- 
2.16.1.435.g8f24da2e1a

