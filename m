Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 085F120136
	for <e@80x24.org>; Thu, 16 Feb 2017 11:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932161AbdBPLtB (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 06:49:01 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33950 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932119AbdBPLs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 06:48:58 -0500
Received: by mail-pg0-f67.google.com with SMTP id v184so1833153pgv.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 03:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bo3vDQk7f011U6wKVRvDwPig6hJtnp6rHHRthhhM0E0=;
        b=V1MuSegOYIOs41FKmkl75Kg7B4y1E85uMbig28SY1LZD0DwHDrfUtEfnPxBk9ESeYm
         CviY+zyCvB25/Py08jKU6eBua6yBIrikOWHxCDK2QNXAAARMVTkJ/Ika6qKToAK1HDjf
         oMc+ao4tmGLzgnKotLvTkP8GSsDkqY6viDYazdO2nuua+kdRQV7bDLORsxGiVJrTdBb2
         +BUeZLqMEX8ddK7kR+1a2tnIQdg9okxWsFjEAWTTa1DCJVC+TU4d4nXH1IHITnz1E3dZ
         o3BJu5ULCrJtjdlZg3iX6ADZ+atrSBB0LPDBzTRK+76brvr5n3fWU2LbXSFxIIShXgGZ
         rKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bo3vDQk7f011U6wKVRvDwPig6hJtnp6rHHRthhhM0E0=;
        b=Dubfld/Uxi9/RxGGAdjsGmFOZ9o1Zz8CReT6PzXyRn7oq6KbEr4pycWzwq7uEcazFf
         5kfAUHgz9ZwxLq6LgFjVgcmTVkqTOO1WvwF7UfFt6puSeOseY+sM88aYWidiWKRRBOU0
         IjR8XfWw+3CcnPFaaEG05GOc+NvduWY0XLtn05+zhEyO0WWsZk5tiU3vdz52jhiv4YRs
         /t3Ml0IRJElRJbvIYICvnwiCETbXpjYwJnjYDBMgWob54xVhrjHaSuB+L7g23zWO/mDo
         g6pUhFheZ+3d7zk6Jp6wyE/2tvClTFaKCPuZfk9uyvpBnGRoNdPHSJTqy9VieUrUYgpm
         xocA==
X-Gm-Message-State: AMke39kLpKIu+uNPN+47IEx19Vzlh28PTcyjIgABZOLe93xCRFupWevdjJewLdbf7c79jA==
X-Received: by 10.99.199.69 with SMTP id v5mr2316919pgg.90.1487245737973;
        Thu, 16 Feb 2017 03:48:57 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id a2sm13288311pfc.72.2017.02.16.03.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 03:48:57 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 16 Feb 2017 18:48:52 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 01/16] refs-internal.c: make files_log_ref_write() static
Date:   Thu, 16 Feb 2017 18:48:03 +0700
Message-Id: <20170216114818.6080-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170216114818.6080-1-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com>
 <20170216114818.6080-1-pclouds@gmail.com>
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
index cdb6b8ff5..75565c3aa 100644
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
index 33adbf93b..59e65958a 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -222,10 +222,6 @@ struct ref_transaction {
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

