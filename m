Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16D551FADF
	for <e@80x24.org>; Sun, 14 Jan 2018 16:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751822AbeANQqL (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jan 2018 11:46:11 -0500
Received: from sonic307-6.consmr.mail.bf2.yahoo.com ([74.6.134.45]:43658 "EHLO
        sonic307-6.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751780AbeANQqL (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 14 Jan 2018 11:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1515948362; bh=f3A4fAFw1dg9wNYtsXPQWfduJOMUxe1uHgJDXN90Gdg=; h=From:To:Cc:Subject:Date:From:Subject; b=BLuaVP/rgzjOX27p2KPB6lmzS6M5RTBm4URzUZuUpmXzj2ABiFfKHGJfH/rekUKrNIjwiiD+z6arDQBNoLVHqfC3GVk1dN17iFN2rUcD4vpVV11q0mN37b2LskxZDEXWFOfJMOtroLNntTNAOAOvHqtkvdkuzETE/Rxl3n5jBSORegZdjbhYl9i2Lx56nW2sIrLvagfnYvW1lzsdvJkxBFP/x5VgribVImx+MkcnIDLm4QqHZfvrwLdujytwpoQAtXJ7fkP0iHUR8KQKYSKItXISJ6s4GtecvJEed5LCxeZY7EV3rsDKe0N36SeEHuD7i5fOSq3kQlyt39Hp7bpk8A==
X-YMail-OSG: Ox1Wpj8VM1nq37dLXLLAXAWZ6NwWd0c4xIuL7Dn6Y9hGtI_csW81S77L6MoMZ8B
 cVw2lfIP_oSSgMevM0cRIdtiuxwd0r._3jiBksDaJk_7jYLK4r5mzqApxy9bcTSs3GQ0IEV.SFqL
 5hA1eejBtMALxBxzj59De9_z9IXzEdOiXwuyCjrUshVV_POg3FAJEXsKvB_lRsB3rpz2zRZ9lfBf
 9bQbWvWCEUDSdp45NXUrYQ1YaENH7NepkcyirnRN5xlr.MkFxQ5bXlt5KzenaH12ZLWTQbkzpYxP
 gkKAp3eXDt9HKNASeAapVodScDQ11rb4Px.eVQsbu8ljS1zT7hNkB5Zv8pQPiJTiwJemnFT.v_KV
 hhIiMg3DC4l0Af1kIYPFS3iCJPXqMmhXFg0radsNod5JwH9mcA4pVHRWHjj1YbwBCgor0CQuy.Ur
 b8cnLnvBYEkhNUnSgKc7MBy38OvFATwyFvObYm5pvOffwJ7bh5nBL1RqKc8yC.u.J0RFYtSqWPNY
 MZY760L_r0knHswV2VaYcqA4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Sun, 14 Jan 2018 16:46:02 +0000
Received: from smtp102.rhel.mail.bf1.yahoo.com (EHLO localhost.localdomain) ([98.139.230.207])
          by smtp407.mail.bf1.yahoo.com (JAMES SMTP Server ) with ESMTPA ID c24732bc694c2641f3917d75639c3827;
          Sun, 14 Jan 2018 16:45:57 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH] Remoted unnecessary void* from hashmap.h that caused compile
 warnings
Date:   Sun, 14 Jan 2018 11:45:29 -0500
Message-Id: <20180114164529.10120-1-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

* The while loop in the inline method hashmap_enable_item_counting
  used an unneeded variable. The loop has been revised accordingly.

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

