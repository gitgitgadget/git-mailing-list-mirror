Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491BDC2D0EA
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 07:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CAD82074F
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 07:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwUvsoc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgDHHFE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 03:05:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40100 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgDHHFD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 03:05:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id c5so2918546pgi.7
        for <git@vger.kernel.org>; Wed, 08 Apr 2020 00:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JYkTw+9ipDyvovT5b6Vwg13pxsjEqbA1/jPrEeTNxIk=;
        b=dwUvsoc4oWD91ADjM4C1s+xVIO0pGXSxrr8AYMzXFf1KVhVs2X8q213v1lPZQ5p8/7
         e4F/AfZcIANSIF4zs5aOemyYIx5tj8KE2oxa9P7o6H8ZqDBGNkiclg9/SRoQX1Encych
         IwWpsgbEC1x0EZQErFXL/tkgyS3l5BwgCDOh30JgVRsXLHh3QIi5EuF4hC2/wXc9z69r
         lcqYg5YoHd9C8j7erdj8NgifQU23vECJJ3NXkErq2C/YXW9CKvHdB0biFZ1ROMkIM/AU
         j72TQY+yI4ztnv+qy0tkmqwd0D81yhTNBVPUtXCT0rMgeFr0ONsno4LdsPHwnBQm9JUl
         ShxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JYkTw+9ipDyvovT5b6Vwg13pxsjEqbA1/jPrEeTNxIk=;
        b=Cmows9Ef0kz+YIgCzRECI5DKMB1XiVUeWvMJiIjr2plmVUVWl0NvTq5URVRiOB+fqy
         kSmerF7p1uhyXsxO9hqKwCanRAjffdLwQFQm61Zpo3Y9vEwfgJW5zYHarI2s9ye04rEo
         v/9BQxn8BQzoyVez7sDYg7nbyBfgtle/Qgz6j8R3/IyLS8ZjjLF4YUGP+T5B1huPjpP6
         UwthLCTk8QS2igADctFN0n14HjIwSOslbPeEpCtCZHBPj4E7re9/SzjZPU76vFqqWbma
         tLtDCT/BWIe5ilXm6HA8FZCGZOK5AJIuaHsyUx5jxnxG5vGcdmobifWE2Ml787mJG1Tl
         5AtQ==
X-Gm-Message-State: AGi0PuZbLDP/Bsb1bHUPeKs8FkN5tqpd8CxlDSC152VzJsln9jrM+eYU
        SaHYHNzAq6Ei9Qh95ArVvQb/IAH8MxM=
X-Google-Smtp-Source: APiQypIx2cxufagj/6tvYfPe6QxI4blzq1jEuAcfMahtPks3q5ECG5ghI7RlKqjZm96BrgEE6f2RqA==
X-Received: by 2002:a65:6409:: with SMTP id a9mr5441483pgv.245.1586329502071;
        Wed, 08 Apr 2020 00:05:02 -0700 (PDT)
Received: from localhost.localdomain ([2409:4064:2182:8a2e:a277:ba54:a2ce:8862])
        by smtp.gmail.com with ESMTPSA id d26sm15669489pfo.37.2020.04.08.00.04.58
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 00:05:00 -0700 (PDT)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 1/2] oidmap: make oidmap_free independent of struct layout
Date:   Wed,  8 Apr 2020 12:33:45 +0530
Message-Id: <20200408070346.24872-1-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200408040659.14511-1-abhishekkumar8222@gmail.com>
References: <20200408040659.14511-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

c8e424c9 (hashmap: introduce hashmap_free_entries, 2019-10-06)
introduced hashmap_free_entries(), which can free any struct pointer,
regardless of the hashmap_entry field offset.

oidmap does not make use of this flexibilty, hardcoding the offset to
zero instead. Let's fix this by passing struct type and member to
hashmap_free_entries().

Additionally, remove an erroneous semi-colon at the end of
hashmap_free_entries() macro.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---

Changes in v2:
- Fix references to earlier commits.
- Grammar fixes.

 hashmap.h | 2 +-
 oidmap.c  | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hashmap.h b/hashmap.h
index 79ae9f80de..6d0a65a39f 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -245,7 +245,7 @@ void hashmap_free_(struct hashmap *map, ssize_t offset);
  * where @member is the hashmap_entry struct used to associate with @map
  */
 #define hashmap_free_entries(map, type, member) \
-	hashmap_free_(map, offsetof(type, member));
+	hashmap_free_(map, offsetof(type, member))
 
 /* hashmap_entry functions */
 
diff --git a/oidmap.c b/oidmap.c
index 423aa014a3..65d63787a8 100644
--- a/oidmap.c
+++ b/oidmap.c
@@ -26,8 +26,10 @@ void oidmap_free(struct oidmap *map, int free_entries)
 	if (!map)
 		return;
 
-	/* TODO: make oidmap itself not depend on struct layouts */
-	hashmap_free_(&map->map, free_entries ? 0 : -1);
+	if (free_entries)
+		hashmap_free_entries(&map->map, struct oidmap_entry, internal_entry);
+	else
+		hashmap_free(&map->map);
 }
 
 void *oidmap_get(const struct oidmap *map, const struct object_id *key)
-- 
2.26.0

