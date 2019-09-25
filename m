Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68CD81F463
	for <e@80x24.org>; Wed, 25 Sep 2019 02:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633770AbfIYCEv (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 22:04:51 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38721 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389401AbfIYCEu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 22:04:50 -0400
Received: by mail-io1-f65.google.com with SMTP id u8so9506772iom.5
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 19:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=emP8HLXIdhnDe1CO0mklPRn7VoRC1V/45QLG5AAMtKE=;
        b=Oj/1HM5680bd0eAatyiD6P1Aw4IARxax1t0exeYZzovSmzQxP6Pam3jW9Tz1HDiaZ4
         p80OYiDpnuXE0EzxffOnFWhNRwRjnclO8ZP0FdVlSnnh2HZhuA62uoqk6RTc+/WRz1/R
         ViRBf1rmJcegvCiD1knmR/XuelsmaQrU2+nbjct3r+5adJ7HZ8CbUXyioEPvlGiWSMdX
         6pw6diNHdjzcHt0kL5mJ3op9BYHG1zTcJPyw5fmXmjL9epo3XRQPvXzt7/U8gsVk+sGB
         ZJUDaGRgp4Tooy1sAg2nXgb6eYYuSMBF6+9t+UU0Bgn8HSXh8LwEPBjOToNdnzKRC8M/
         yfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=emP8HLXIdhnDe1CO0mklPRn7VoRC1V/45QLG5AAMtKE=;
        b=efA+rTjvqKeTxqHX3wZYA3ZAcxHrVGsy8YBiWQo4yr8kJLimqLSZoUxHvET61f2p6a
         CHKnOqzF676ogJjuJU++o81W8198xqzBJ6AF09/woF5pHd4iC50ocxVdePHWw7bKRPTq
         w6PPBoVvBTj1Yp/wdlM5GCYTux8sQE8HGy3eyoFoZWPCVdMVqnn6v+CB9PUdZw53J4TW
         iAWvpDFSWI1eGm2T5ZHY0119PQ5UU7EwfFI46jKvzwToyvi03lO+z953Cnbzz8BJZZGT
         hrZbs5QxO+ONG9Y0RTkykk6jM9v7XqgZSbekq8jhozAZ0Ix5xtGLbi7MvdeYCjmIQdD3
         +LkQ==
X-Gm-Message-State: APjAAAWKLYKGY9+cwRcrYLCn+VNB1ILdSOd4+GBPMoDEd/JQC5zwd5d7
        ZkFYzV1zav6VoiMH6SCYYCftt7+spCE=
X-Google-Smtp-Source: APXvYqx/r2GvnSbIW5eKYkUaFy5GDgUbwdchc6VEkMCBWXZURXoZqxqUrloAZkTei4tWycRDfCMrPg==
X-Received: by 2002:a05:6602:10d:: with SMTP id s13mr6966440iot.244.1569377089537;
        Tue, 24 Sep 2019 19:04:49 -0700 (PDT)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:4100:375e:3837:c90c:13fa:5c01])
        by smtp.gmail.com with ESMTPSA id u11sm5341777iof.22.2019.09.24.19.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 19:04:48 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        davvid@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH 3/3] wrapper: use a loop instead of repetitive statements
Date:   Tue, 24 Sep 2019 20:01:58 -0600
Message-Id: <20190925020158.751492-4-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925020158.751492-1-alexhenrie24@gmail.com>
References: <20190925020158.751492-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 wrapper.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index c55d7722d7..c23ac6adcd 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -469,13 +469,12 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 	filename_template = &pattern[len - 6 - suffix_len];
 	for (count = 0; count < TMP_MAX; ++count) {
 		uint64_t v = value;
+		int i;
 		/* Fill in the random bits. */
-		filename_template[0] = letters[v % num_letters]; v /= num_letters;
-		filename_template[1] = letters[v % num_letters]; v /= num_letters;
-		filename_template[2] = letters[v % num_letters]; v /= num_letters;
-		filename_template[3] = letters[v % num_letters]; v /= num_letters;
-		filename_template[4] = letters[v % num_letters]; v /= num_letters;
-		filename_template[5] = letters[v % num_letters]; v /= num_letters;
+		for (i = 0; i < 6; i++) {
+			filename_template[i] = letters[v % num_letters];
+			v /= num_letters;
+		}
 
 		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
 		if (fd >= 0)
-- 
2.23.0

