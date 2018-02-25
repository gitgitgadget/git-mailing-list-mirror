Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F31F1F576
	for <e@80x24.org>; Sun, 25 Feb 2018 11:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751667AbeBYLTI (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 06:19:08 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38505 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbeBYLTH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 06:19:07 -0500
Received: by mail-pg0-f66.google.com with SMTP id l24so5127085pgc.5
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 03:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EVKDsGZM1uaAK1zoGt/uNgQP4cBuKyDyTtyiOMo09u4=;
        b=oaT0+ccAXVdIscdb4JsGmxV/vAtQ9ErVCtnYH6LCnoIR92E1ibR9h4rcM2WDMGwgnj
         cSR3akI+nmteHOPM4bguPvN5wbBGuYjEU0hgAHffZG9n7hDv0j0T5TsiK779Nk6KAguH
         vanL5TYazOKgwDCbxu4ej9METiDc08xX4QKge+OQPSc1csGPhUuIwX6DnKz5dL8eIbL5
         7pSKWtHJa8pMJng42S7KcN6lW0/lcetgGHjS4uglaBOH25e0Yh1yU4lV4vy/SNR5ZHBq
         I2IMx4lqExp3WcnDVNUYlkncFwU9SS227v9EgtMck1FfEehFRmnTiQDgPNSdDLBWmgzq
         zptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EVKDsGZM1uaAK1zoGt/uNgQP4cBuKyDyTtyiOMo09u4=;
        b=YiQYsErwhNsSj8K27xHgk43R96DbuoE59s5DGs+p3/KA+li826Q6SzmMbpJ6sWJH3I
         S0O/HiVMZJGE7elA8obguM4/YNN39uuAYcQKVmkbW4+7IR39StjT0PpTA7OnrKsUB3f8
         phhxjCS7E8FXZTL7gaFvWIcrtHDd2NvPBOwxhMfvhSTqzXrjFA+Bx7HCBDw3fLI5HFqb
         kW8aNRGW3+IIqR6c604E0LPOyVfMiP+e3bnlJ6Iu2S5Fv0S82jLw4TY1JVwPCL+RYxew
         C/5HnJsonX7s7LIL07GuvKoYHalSfNU8UgO53M0fS3UqAQGOvS5wkD1VdK/Yw+0nKZqE
         0PHQ==
X-Gm-Message-State: APf1xPCfk0faUOJ7EHJqPIGIRauyYNb4f/EM4VFx4QQEarucCsf2IyRG
        /VEI9B2GVLJxPQXtVO2QQxI=
X-Google-Smtp-Source: AH8x224Bl2KD69UgkCEN8kbBdb0FcYhgzaMtp+O9YhHjPtZMWkdvUL07a/cJKPHv6z0fEtXMMLDlhw==
X-Received: by 10.99.96.18 with SMTP id u18mr6030705pgb.124.1519557546779;
        Sun, 25 Feb 2018 03:19:06 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id u13sm14312728pfd.169.2018.02.25.03.19.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Feb 2018 03:19:06 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 25 Feb 2018 18:19:01 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sandals@crustytoothpaste.net,
        sbeller@google.com, sunshine@sunshineco.com
Subject: [PATCH v3 3/6] cache.h: make the_hash_algo read-only
Date:   Sun, 25 Feb 2018 18:18:37 +0700
Message-Id: <20180225111840.16421-4-pclouds@gmail.com>
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

By returning an R-value in the_hash_algo we make sure people can't
accidentally change hash algorithm with

    the_hash_algo = &hash_algos[something];

and go with repo_set_hash_algo() instead. Of course they can still do

    the_repository->hash_algo = ...

but that is more obvious and easily caught in review.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache.h      | 2 +-
 repository.h | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 6b97138264..55b31e9756 100644
--- a/cache.h
+++ b/cache.h
@@ -53,7 +53,7 @@ struct object_id {
 	unsigned char hash[GIT_MAX_RAWSZ];
 };
 
-#define the_hash_algo the_repository->hash_algo
+#define the_hash_algo repo_get_hash_algo(the_repository)
 
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
 #define DTYPE(de)	((de)->d_type)
diff --git a/repository.h b/repository.h
index 0329e40c7f..5092df3700 100644
--- a/repository.h
+++ b/repository.h
@@ -107,4 +107,10 @@ extern void repo_clear(struct repository *repo);
  */
 extern int repo_read_index(struct repository *repo);
 
+static inline const struct git_hash_algo *repo_get_hash_algo(
+	const struct repository *repo)
+{
+	return repo->hash_algo;
+}
+
 #endif /* REPOSITORY_H */
-- 
2.16.1.435.g8f24da2e1a

