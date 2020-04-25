Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B227C2BA1A
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 03:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3357A20776
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 03:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4quOshE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgDYDAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 23:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726061AbgDYDAp (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 23:00:45 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACC6C09B049
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 20:00:45 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x77so5760672pfc.0
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 20:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IdR/3Fffl4M9t68AFzXOlWGcALAqrjh3uQEZtnynuvY=;
        b=o4quOshEPfWNODcp5xFir3GdXzktOTBwUeCQOhPT7pxq8q7C+Bos3bLmaWV6789PoT
         4lhzznWJtxBQap+mL7cDQuu/ziRyLAgcCN3LuvjwNfs/F3yDEyL7AIKRTkE8WdVrusHf
         D66wg2bdFww9q1Wlo/NkvB5zgl1zakHeUhLElDZ5QATR/bhTnqHJ0C2B/g/WFuADZBd0
         Ors0NMBSQsDOWZDubI8ZerM2+mp1i0805VhbPzNniC1ERKKcgDbNDAVSaOtUV+3PB/QW
         LuzXy7/fVXN3Iw5frDiZoG00D5s9rnBiizZBI4Zo9i0Cl30xioWEgJooismpN9MkfuBh
         k8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IdR/3Fffl4M9t68AFzXOlWGcALAqrjh3uQEZtnynuvY=;
        b=d90LyHnIY1qCstZcLdbl4tVBgyMbUoOXERMvRy55ltQGR7j6X7hvG2R//G3vMvVRyu
         3so9vVcFkmmuFHRiF94Qq/uE1gW9mXSrJQe1vQrNpe4jB/1okV6BXIjuSPihDURZvbq/
         //zQxPtS77qo2bhmJ1E7MV9N0XMXL6q2Obr570PSJIA0KenPNZV0fAEdXHfLCVHXAq+q
         nYcvpsrYYVQW9rQwq5wT6/F/nd+9rosOWDLaQJy3nRjw4vHkECcGelLExWjUNbiZk+MA
         QjN9oNDmGV4Zocylz+cOUOUqh3pjqGJ/xh/E9mW/8tmIlpNGJiRYd1E/VHlkGar4nSRF
         b3xQ==
X-Gm-Message-State: AGi0PubCom75N2ppTcyWfVjUSqa3VpDN3UEimxc9ERfNaHwxIr6fyOG0
        GobAU1CbGIjHpMocBsxg+l/+Qz5cHfs=
X-Google-Smtp-Source: APiQypIpNDSOlUHO8pP8zFHW2PhpY/yNpzsQTIs1vochS7vWHJ5v7MILe6c5xTyDEbPuNuz8PTUs8A==
X-Received: by 2002:a63:e94f:: with SMTP id q15mr12433071pgj.339.1587783644347;
        Fri, 24 Apr 2020 20:00:44 -0700 (PDT)
Received: from localhost.localdomain ([2409:4064:79a:d9e8:1f9e:c3b5:9fc6:c4b2])
        by smtp.gmail.com with ESMTPSA id f99sm5990992pjg.22.2020.04.24.20.00.41
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 20:00:43 -0700 (PDT)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 1/3] oidmap: make oidmap_free independent of struct layout
Date:   Sat, 25 Apr 2020 08:29:19 +0530
Message-Id: <20200425025921.1397-1-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200408040659.14511-1-abhishekkumar8222@gmail.com>
References: <20200408040659.14511-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

c8e424c introduced hashmap_free_entries, which can free any struct
pointer, regardless of the hashmap_entry field offset.

oidmap does not make use of this flexibilty, hardcoding the offset to
zero instead. Let's fix this by passing struct type and member to
hashmap_free_entries.

Additionally, remove an erroneous semi-colon at the end of
hashmap_free_entries macro.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 hashmap.h | 2 +-
 oidmap.c  | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

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
index 423aa014a3..44345a8cf2 100644
--- a/oidmap.c
+++ b/oidmap.c
@@ -26,8 +26,11 @@ void oidmap_free(struct oidmap *map, int free_entries)
 	if (!map)
 		return;
 
-	/* TODO: make oidmap itself not depend on struct layouts */
-	hashmap_free_(&map->map, free_entries ? 0 : -1);
+	if (free_entries)
+		hashmap_free_entries(
+			&map->map, struct oidmap_entry, internal_entry);
+	else
+		hashmap_free(&map->map);
 }
 
 void *oidmap_get(const struct oidmap *map, const struct object_id *key)
-- 
2.26.0

