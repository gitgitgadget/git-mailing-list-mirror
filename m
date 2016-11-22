Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 620B61FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 12:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755434AbcKVMbT (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 07:31:19 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34416 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755489AbcKVMbR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 07:31:17 -0500
Received: by mail-pg0-f66.google.com with SMTP id e9so2033297pgc.1
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 04:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HHxpql8Quvs8/Lvh2z0Bq8or0H3/XknAmShiNnhyhO4=;
        b=b7kwEfUVIcS/ei8v04Bj2uA4h+SE2c13GiOA0LayvAATtYG0X1A23g7CHvVm7reYB7
         SclxIeVXI6t9zt2GaG4JEPTMEEaNyOPAHntW0w6I4tqxXQcjYSaOMp2Yt+VMZhJxlS4e
         jQQps9qybBjkBng/cW76tb/BQ6Uyk20tXWRY/FfizxBru/XMUi2+evwPaWOD0Ooe2nhu
         OXiA3ZYk0eO8F2/WFNdmw8Yd69Mq3TyZPKpKM+BJPAPelkW0NOlSZ/RvK7X3FxRpqMio
         xmTdvq6XShwAi6rTYQ2jnI+MejZZBDEtoSMd7+COP3pZBhy8ui3QU0huLhQXeqyV5SuZ
         GiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HHxpql8Quvs8/Lvh2z0Bq8or0H3/XknAmShiNnhyhO4=;
        b=Cg+M/biF9APP2fVozPhcWAIqNY1OzTW+MFJEZfIprnCLkyggMeVMFwl3pfp0DDh4qV
         VfS+x8mZxSUwPq/3+FsW9dFZLdIU4QKCiVnjnn722jdy+qLT51rPj4vTFbjwLodyNLx+
         uaQiFxIdRcnAIGrO665rtbihe+mNN31InoYZUg/lGUL7Hof6IpfNieQIs0YkyEudI5CA
         FIcalH1yVpUiGEcquwZvDgvLilFGpkG/2JSz6Ns5dP7cq519/7/FUUUzv5EUXGbcFuXB
         qtmHF+ZECnhtDrhh4ysIP61rI9lkYDOjYfsKgxpgzi1dkeK8MWudXQE7vWR1V/GY4lxN
         ATAQ==
X-Gm-Message-State: AKaTC01LLGWcDdOVAyaWaV6JeWUMhFSkHM1jAg0vE/VeZQnmTkT0TAmDx7ZdRfPV6pTaqw==
X-Received: by 10.98.17.80 with SMTP id z77mr25390862pfi.166.1479817876278;
        Tue, 22 Nov 2016 04:31:16 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id n17sm45064019pfg.80.2016.11.22.04.31.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Nov 2016 04:31:14 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 22 Nov 2016 19:31:08 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] merge-recursive.c: use QSORT macro
Date:   Tue, 22 Nov 2016 19:30:19 +0700
Message-Id: <20161122123019.7169-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the follow up of rs/qsort series, merged in b8688ad (Merge
branch 'rs/qsort' - 2016-10-10), where coccinelle was used to do
automatic transformation.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
  coccinelle missed this place, understandably, because it can't know
  that
  
      sizeof(*entries->items)
  
  is the same as
  
      sizeof(*df_name_compare.items)
  
  without some semantic analysis.

 merge-recursive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 9041c2f..2d4dca9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -451,7 +451,7 @@ static void record_df_conflict_files(struct merge_options *o,
 		string_list_append(&df_sorted_entries, next->string)->util =
 				   next->util;
 	}
-	qsort(df_sorted_entries.items, entries->nr, sizeof(*entries->items),
+	QSORT(df_sorted_entries.items, entries->nr,
 	      string_list_df_name_compare);
 
 	string_list_clear(&o->df_conflict_file_set, 1);
-- 
2.8.2.524.g6ff3d78

