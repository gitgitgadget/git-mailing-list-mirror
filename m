Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE3AF1F404
	for <e@80x24.org>; Sat, 14 Apr 2018 15:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbeDNP1N (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 11:27:13 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37571 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeDNP1G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 11:27:06 -0400
Received: by mail-lf0-f67.google.com with SMTP id m200-v6so16373074lfm.4
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 08:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HExZgc329GG9APyuVEx0/TuB/d5C1hYkUbrNNkzgEds=;
        b=ckPUGsg2uHyvA+twQ54uzWZiKlzcO3MpfO9ikfkPd4VHqhtt7OAtNAOr3dRJo1rQYJ
         WYD5eapeGg7cPPB6Mj2/c7+CPVQYNkINrKQLYM0wt1shhTVGmIaCBsHhRfQ2OIdEMIWp
         t2W88DfdcsfFdoWekIIg6qKdBL5SGRGvO2l3DpRt88LtQItVgYSGaXPircSg1l5EY4+J
         AtNeA4i+P7ONjg6eR/dJii023DqqVveVvSydjSRYlz02HSUHy3OfX3qH70y2VttXyfH1
         rBwHJ8Wio0VeMyb0WQ3EfqOMUoPpOxSwkmT8CgJr52DO97pkMmQIRWTB19EQ+gBkmLqH
         ri3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HExZgc329GG9APyuVEx0/TuB/d5C1hYkUbrNNkzgEds=;
        b=XzmB28E3ZnqyGRIo1ufO9etoVxUkbNsG5VPb8qchlo0z0W++9oS1SWAeXRYuB7/mbZ
         FJER7QCKjfy6oRx4XAh1/Q7QExE2nO7AJeT+VnsoW8vyh/ar0bKydgXkDQY4oFw0bKiE
         HaD8zNUlDDXjCECPkL9HSSdTmzdlLCQBq+Z0Y+Xf5gelK+AOrxw4lrsn9mClczT0MrBa
         jxtxpdnshG2uvRXpq6sF+z+b5YujEfFW6GbxdH3oaKjrJEbipcNB2UsjfESrnGoVFl8d
         2FlibdzIrkxf5RR2YIRuzy96USRwP68QJ08hOZjh+KKwKNMG5aO9OwTCeZYgQejRkPv6
         uWtg==
X-Gm-Message-State: ALQs6tAl6MV6ybfDBRtRrmbkZO/PtdNeMUFwIbQ9fPbFI3KvxiO2E7So
        tlr6fumPuWP/I1z6tL6C1vuuKg==
X-Google-Smtp-Source: AIpwx49mlgm4O3D6MY4gcHiWrZm6HHwEvm/0/PKn7+QLsF8tmtxsb+9wK0Wm/gPX3Dwihux2hP122Q==
X-Received: by 2002:a19:1294:: with SMTP id 20-v6mr380747lfs.21.1523719624440;
        Sat, 14 Apr 2018 08:27:04 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f133-v6sm1803378lfg.28.2018.04.14.08.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Apr 2018 08:27:03 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 5/7] gc: handle a corner case in gc.bigPackThreshold
Date:   Sat, 14 Apr 2018 17:26:40 +0200
Message-Id: <20180414152642.4666-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180414152642.4666-1-pclouds@gmail.com>
References: <20180414152642.4666-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This config allows us to keep <N> packs back if their size is larger
than a limit. But if this N >= gc.autoPackLimit, we may have a
problem. We are supposed to reduce the number of packs after a
threshold because it affects performance.

We could tell the user that they have incompatible gc.bigPackThreshold
and gc.autoPackLimit, but it's kinda hard when 'git gc --auto' runs in
background. Instead let's fall back to the next best stategy: try to
reduce the number of packs anyway, but keep the base pack out. This
reduces the number of packs to two and hopefully won't take up too
much resources to repack (the assumption still is the base pack takes
most resources to handle).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt | 6 +++++-
 builtin/gc.c             | 8 +++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 40516675b6..4c3f1d7651 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1564,7 +1564,11 @@ gc.bigPackThreshold::
 	except that all packs that meet the threshold are kept, not
 	just the base pack. Defaults to zero. Common unit suffixes of
 	'k', 'm', or 'g' are supported.
-
++
+Note that if the number of kept packs is more than gc.autoPackLimit,
+this configuration variable is ignored, all packs except the base pack
+will be repacked. After this the number of packs should go below
+gc.autoPackLimit and gc.bigPackThreshold should be respected again.
 
 gc.logExpiry::
 	If the file gc.log exists, then `git gc --auto` won't run
diff --git a/builtin/gc.c b/builtin/gc.c
index 81ecdc5ffa..23c17ba7e9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -253,8 +253,14 @@ static int need_to_gc(void)
 	if (too_many_packs()) {
 		struct string_list keep_pack = STRING_LIST_INIT_NODUP;
 
-		if (big_pack_threshold)
+		if (big_pack_threshold) {
 			find_base_packs(&keep_pack, big_pack_threshold);
+			if (keep_pack.nr >= gc_auto_pack_limit) {
+				big_pack_threshold = 0;
+				string_list_clear(&keep_pack, 0);
+				find_base_packs(&keep_pack, 0);
+			}
+		}
 
 		add_repack_all_option(&keep_pack);
 		string_list_clear(&keep_pack, 0);
-- 
2.17.0.367.g5dd2e386c3

