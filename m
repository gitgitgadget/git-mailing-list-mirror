Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26760201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 14:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932627AbdBVOFs (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 09:05:48 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36167 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932612AbdBVOFq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 09:05:46 -0500
Received: by mail-pg0-f66.google.com with SMTP id z128so536017pgb.3
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 06:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rmRuWvfsI/Ve1eoimZTaQp8gb0ES5zkmWZNNtH8PVaY=;
        b=od9tpzB8VZiWIAdEWKJhJQomgnrV64btalGJycvQ/4SF8xwxXVNvw8hx26uPAK951X
         m7kjcsNAsgnQ4qEbB52QSpZtenAUAtRR+U+veHp7EbkkhBq1GmJdpw6+DbrwTbA5qfiA
         9Jn3YvaNJjOQuI/2UfxYsfAM+gOuqMOfbjdNeKzsBTchpiCbeilZz6b7pid5da7nRDzP
         rKcRSN2U1xa1AsImQPlEDQA49UgEWdo1MF556df7Wi6c8Tm32EY9uVQ1nKxBpidOPuo/
         y+te5FDmwRnppL3Nwy5u35HUkGMXZL8aujiEFig65cIXDvVRFQn8BGBHv2Sw6yLEI1j1
         zoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rmRuWvfsI/Ve1eoimZTaQp8gb0ES5zkmWZNNtH8PVaY=;
        b=VmWpHPzt6sr+6LlQVRoN20YK8G7ucebdnaaxyXEcGih1IgQ5G8URD5iArP486JwXDy
         eAyWd2KcFQsKvnjnnZ+wMLbz3JA09YTQKEk7IHDesyGQEKmayv0QZDKW3AZMgk4hhDpK
         2EIhmTvAt5VAEh0YrSl2e/h0qvFdS/B1sFRuwUCU5CxiZxqWdmXmcgDGNcP9eFK1JLzl
         T0fQFUg76T2f9qfvLZ/NvJoAaJQyeQJkytLzvyGsPfh319DTwJ7/37B0Yha93ZB5qFQz
         V+MFCDC7smWhmLisuuL3pj8/4f1DUOEdYvOfOomlUkNsngP2OtE+mUjqol8wKek1t7sl
         a75A==
X-Gm-Message-State: AMke39lLtMe5/Yrj3RBIyliFuQVUXqP9euHgoXscgRl7t5LqhwejXe6BmE62o926IQv36A==
X-Received: by 10.99.115.8 with SMTP id o8mr29120522pgc.36.1487772345249;
        Wed, 22 Feb 2017 06:05:45 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id v8sm4125188pgo.14.2017.02.22.06.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 06:05:44 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 22 Feb 2017 21:05:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 02/24] files-backend: make files_log_ref_write() static
Date:   Wed, 22 Feb 2017 21:04:28 +0700
Message-Id: <20170222140450.30886-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170222140450.30886-1-pclouds@gmail.com>
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Created in 5f3c3a4e6f (files_log_ref_write: new function - 2015-11-10)
but probably never used outside refs-internal.c

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 3 +++
 refs/refs-internal.h | 4 ----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index db3bd42a9..1ebd59ec0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -165,6 +165,9 @@ static struct ref_entry *create_dir_entry(struct files_ref_store *ref_store,
 					  const char *dirname, size_t len,
 					  int incomplete);
 static void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry);
+static int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
+			       const unsigned char *new_sha1, const char *msg,
+			       int flags, struct strbuf *err);
 
 static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 {
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index fa93c9a32..f732473e1 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -228,10 +228,6 @@ struct ref_transaction {
 	enum ref_transaction_state state;
 };
 
-int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
-			const unsigned char *new_sha1, const char *msg,
-			int flags, struct strbuf *err);
-
 /*
  * Check for entries in extras that are within the specified
  * directory, where dirname is a reference directory name including
-- 
2.11.0.157.gd943d85

