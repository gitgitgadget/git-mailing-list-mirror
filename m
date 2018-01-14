Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F3BB1FADF
	for <e@80x24.org>; Sun, 14 Jan 2018 18:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbeANSIF (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jan 2018 13:08:05 -0500
Received: from sonic310.consmr.mail.bf2.yahoo.com ([74.6.135.253]:34430 "EHLO
        sonic310-17.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751726AbeANSIE (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 14 Jan 2018 13:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1515953284; bh=hUHnpMjTw2TB9DyPJcSeSpwtIaHSAp3d0Bk0xm4rNkg=; h=From:To:Cc:Subject:Date:From:Subject; b=gsThYjyLznN8OhVOhAjjdYL5GXEA6dj/fb3+nbKB3c8ojW54pMlXtsVBbLtZ0Zx6eC0ZHtkDobT3hZOBcMtXLTn9FIcYGHCSidJ6Wcns417+Zr2k11ktzcVAf++5LYKiLRStYHvP7F7Rt39awlqiYHteeS0CB0pepRPmEYjCStOxqoEnpgXb6ATtx1lpMEhAgkwUTLx4nuYppE8TX2b/Fgz2kWI74WH/dyBfBLeTk3RpUnN5OeSKaRBlY2I2yrhbCDNzFrY5h/1xE7WnHWwM+gbMmpGMZMI8MM0RyaqYLfnX5PqFaCXISIvefy10wzBoaid5hslcApA1GND18TGmLQ==
X-YMail-OSG: D86D2uwVM1nmEl4nRDI83ZTRk1TM3oJvcvXq8g03rygF8URR4sCMFKXqZJVYktY
 ZO8NaMbqKvODQB6bQ1S0rYr.3SRnDOWXHcvt7Nt96euwSBUxJpBMq32rdZOCmpxan8jczEOZYsVV
 o2AQXdwCXap1RE4GM_SAm3_XZ5hJNNiQLtE3nbK.m0wNkXvdCANn1794fR8MeRIC14DoClxU0fe5
 u.X6zI3iQWwy48vz92e5IWLvlkXdS7s8bWcFstqfpe0sJb3KurrhEu7A.CjaqoXAezcRJ31_Nsos
 uHOFaWI_U3rB_1C95OfB_b1KgJEjgN0myavYfb6Zkhyu2ARPaxIRAnys9JnKrCnEA6K4tFcatm93
 NmGhwWkR96LX2lhVZtITmBZ8lEdkh.Z4G7ybSWkQi0Q5u5dMDBAklDPD2Ece.zUIlkQjp.ZhDvwI
 Ow5cas04_Xh2hurrCEbg75c7CMJpObE3ASeGGxrR2A99DoPD_NHWR48IuXXB6MQVEq3yXqN4oJ3v
 M2YsAtDQ5r2vtYQJnDIbA02k-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Sun, 14 Jan 2018 18:08:04 +0000
Received: from smtpgate102.mail.bf1.yahoo.com (EHLO localhost.localdomain) ([72.30.28.113])
          by smtp408.mail.bf1.yahoo.com (JAMES SMTP Server ) with ESMTPA ID 1347393a116b5de1922c505584f97cf3;
          Sun, 14 Jan 2018 18:08:01 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH] Removed unnecessary void* from hashmap.h that caused compile warnings
Date:   Sun, 14 Jan 2018 13:07:48 -0500
Message-Id: <20180114180748.14584-1-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

* hashmap.h: Revised the while loop in the hashmap_enable_item_counting
	to remove unneeded void* item.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 hashmap.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hashmap.h b/hashmap.h
index 7ce79f3..d375d9c 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -400,7 +400,6 @@ static inline void hashmap_disable_item_counting(struct hashmap *map)
  */
 static inline void hashmap_enable_item_counting(struct hashmap *map)
 {
-	void *item;
 	unsigned int n = 0;
 	struct hashmap_iter iter;
 
@@ -408,7 +407,7 @@ static inline void hashmap_enable_item_counting(struct hashmap *map)
 		return;
 
 	hashmap_iter_init(map, &iter);
-	while ((item = hashmap_iter_next(&iter)))
+	while (hashmap_iter_next(&iter))
 		n++;
 
 	map->do_count_items = 1;
-- 
2.8.5.23.g6fa7ec3

