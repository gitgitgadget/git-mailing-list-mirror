Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 664631F404
	for <e@80x24.org>; Sun,  9 Sep 2018 08:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbeIINna (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 09:43:30 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:42458 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbeIINna (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 09:43:30 -0400
Received: by mail-lj1-f179.google.com with SMTP id f1-v6so15372336ljc.9
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 01:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R2x+ptiH6yMlquVbxSyB7bNzW2ZWiPs8BVVAg79ejSw=;
        b=DH6+xo1qBHSyUH/phbFQCGj9rpx0Vs24ArPRu8u2yeg0V+EqBN1dtvzfoPeAkXbo1c
         IXlTqWE/i8CL2StLSJZUnkTnClI0EAmB7ebVozL0jNpu0gK8a1dsRlrZ2j/t80oM4hnq
         +nVrT5V+dO8PPhnDUfRsM9K5ZmEAxPtTh381kORZl31XdxQSLqd3getCHrxsDezwozB8
         ll9ao6RHUMEgtH0a0qmupY604sUZPkESKopU+w+yYS951CGzNGr/5albG3i0yEOzBtYS
         ph5uU3VFjRmsR3ADXYU7tFsphRXeYYGdaujLym0P4eB63y6nROqSXxdZ0nd/c75Pcsar
         himw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R2x+ptiH6yMlquVbxSyB7bNzW2ZWiPs8BVVAg79ejSw=;
        b=s5meSRHo/iaNsqiB53pR2CguxQ1MV2f/SkPuNPXQmUhxkdJL2ajy3GL1DB2btO9AUW
         t10CuH3QJczcSmlDusHitcbC8u74qNGcWO6SLnSqaz/JFyJw+KWf9HyEl0Qn21QmjB8n
         QplC5ZOySi2VYr8ncXD8KLVl0pz0EtApsOV+7QvpCZEBTyA9sNTHnEu43CBjJVrTiz6T
         kLwBbU0xfcEj6UFAxw3/WWDC5iqt3YEViiHfKtBSvuP7ctfiSWgKfg7v9qDQRVFfF0hJ
         kfKHAx0XnscnPSi9aMJdN0lIHe+CSjY6Xho5I9wHo5IrorZT2fJcc4t7JQAdgtJ3Z1hG
         0K0A==
X-Gm-Message-State: APzg51B+u1P/bLjSCwS6P5Ia3hMlK+KQxC0HH8+0Tlw+J6+WoZUGPE3C
        XlqmeJOnSqf2nVriqBOfjgs=
X-Google-Smtp-Source: ANB0VdYFV1qdykKQJ/RAlthOifhX9BYEGau5dHZXAuImlpwaic2m20YZxr2vH42ifmPSmNw8kkLh2A==
X-Received: by 2002:a2e:6d0a:: with SMTP id i10-v6mr9817225ljc.145.1536483271786;
        Sun, 09 Sep 2018 01:54:31 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g16-v6sm2102525lfb.5.2018.09.09.01.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 01:54:31 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 01/23] archive.c: remove implicit dependency the_repository
Date:   Sun,  9 Sep 2018 10:53:56 +0200
Message-Id: <20180909085418.31531-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180909085418.31531-1-pclouds@gmail.com>
References: <20180903180932.32260-1-pclouds@gmail.com>
 <20180909085418.31531-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new "repo" field in archive_args has been added since b612ee202a
(archive.c: avoid access to the_index - 2018-08-13). Use it instead of
hard coding the_repository.
---
 archive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/archive.c b/archive.c
index 0a07b140fe..994495af05 100644
--- a/archive.c
+++ b/archive.c
@@ -391,7 +391,7 @@ static void parse_treeish_arg(const char **argv,
 	if (get_oid(name, &oid))
 		die("Not a valid object name");
 
-	commit = lookup_commit_reference_gently(the_repository, &oid, 1);
+	commit = lookup_commit_reference_gently(ar_args->repo, &oid, 1);
 	if (commit) {
 		commit_sha1 = commit->object.oid.hash;
 		archive_time = commit->date;
-- 
2.19.0.rc0.337.ge906d732e7

