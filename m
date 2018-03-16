Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ED791FAE2
	for <e@80x24.org>; Fri, 16 Mar 2018 18:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeCPScp (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 14:32:45 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34472 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbeCPScn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 14:32:43 -0400
Received: by mail-lf0-f68.google.com with SMTP id l191-v6so16763175lfe.1
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 11:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xBMKDzTJ6UvWYz8VfUPjxtgniOZdrld5sbnZd4lc8rM=;
        b=PQroT7tcMc1j7p/u7sq6vtsqbCFT3ojPAfCNL6XivaUIYBWSI3joeqQIQzjgjpKRDF
         aLsE+4ig0PWrx0T1eXQBWokn/jXc4K8w2mpafU0wLbNsq5Imer9bPBxaOWyat8laFxg2
         8Vs33jSommlF7clq+74WghV0kHMJLZwV032omqGX0Nfk06Hys2siW5rgI5lREZjqvpn9
         k4Ki7hgsAGP1sclMkEEcaQZHC4ZsOJiJ8FwTC6+fa0pMmpV+rvrKcCDWJEiS1LkGBCpA
         Al2t6k32fGIQL1LmKYUwu3ICxsuXdg9IURKgqZvKgLoLFZiR9i3Br/FnAFORiQiIi2iM
         UhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xBMKDzTJ6UvWYz8VfUPjxtgniOZdrld5sbnZd4lc8rM=;
        b=HUmGEKjzfDros/fIxYLTH6uVz+9d9sAFvXxT5K4bfSnNwnLtV2SzWe55fIpBMYVea0
         YUXz7UIEwGXzwDHEIyWOKTAe/x9btfiX+SBrbt94IAMIrW0XD/EfMoNWPal47YdVXkVI
         YgZ8e0ut2lz4ATXSbi5c51IzxaIabL69KR+8fVLakN26glm/i/IhT4NgB1gZ3md6kwrV
         YWFGWKCb9a1alQ48LgHeU6bGZ8vjsoybRb/O6TAXgQWnOSOPH+ItyX6xlneJvsFIsRzH
         waH3EDPl3NJmAqWHOyAcOern4RAVRAkkY/uevj90tXxWeEAI3TLnSQ3fN0OOuyHqbVZe
         cUMQ==
X-Gm-Message-State: AElRT7FQJOJ0eePj/2CF4eGaZh8FqHff0IgEK3tcPO0YRu9/iKvFO7rc
        FW+/eInEXr3N4c6UOTqhP+ePeQ==
X-Google-Smtp-Source: AG47ELtT3SvvuJlP2xo2R+5TGqsh1PXup/T4uif0r7e8puHUPdO7wu5ko/t2ryEmNuqO3Y1azmiijw==
X-Received: by 10.46.137.71 with SMTP id b7mr1999099ljk.39.1521225162179;
        Fri, 16 Mar 2018 11:32:42 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j199-v6sm1033275lfe.53.2018.03.16.11.32.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Mar 2018 11:32:41 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v4 01/11] pack-objects: a bit of document about struct object_entry
Date:   Fri, 16 Mar 2018 19:31:50 +0100
Message-Id: <20180316183200.31014-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
In-Reply-To: <20180316183200.31014-1-pclouds@gmail.com>
References: <20180308114232.10508-1-pclouds@gmail.com>
 <20180316183200.31014-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The role of this comment block becomes more important after we shuffle
fields around to shrink this struct. It will be much harder to see what
field is related to what.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 pack-objects.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/pack-objects.h b/pack-objects.h
index 03f1191659..85345a4af1 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -1,6 +1,50 @@
 #ifndef PACK_OBJECTS_H
 #define PACK_OBJECTS_H
 
+/*
+ * basic object info
+ * -----------------
+ * idx.oid is filled up before delta searching starts. idx.crc32 and
+ * is only valid after the object is written out and will be used for
+ * generating the index. idx.offset will be both gradually set and
+ * used in writing phase (base objects get offset first, then deltas
+ * refer to them)
+ *
+ * "size" is the uncompressed object size. Compressed size is not
+ * cached (ie. raw data in a pack) but available via revindex.
+ *
+ * "hash" contains a path name hash which is used for sorting the
+ * delta list and also during delta searching. Once prepare_pack()
+ * returns it's no longer needed.
+ *
+ * source pack info
+ * ----------------
+ * The (in_pack, in_pack_offset, in_pack_header_size) tuple contains
+ * the location of the object in the source pack, with or without
+ * header.
+ *
+ * "type" and "in_pack_type" both describe object type. in_pack_type
+ * may contain a delta type, while type is always the canonical type.
+ *
+ * deltas
+ * ------
+ * Delta links (delta, delta_child and delta_sibling) are created
+ * reflect that delta graph from the source pack then updated or added
+ * during delta searching phase when we find better deltas.
+ *
+ * delta_child and delta_sibling are last needed in
+ * compute_write_order(). "delta" and "delta_size" must remain valid
+ * at object writing phase in case the delta is not cached.
+ *
+ * If a delta is cached in memory and is compressed delta_data points
+ * to the data and z_delta_size contains the compressed size. If it's
+ * uncompressed [1], z_delta_size must be zero. delta_size is always
+ * the uncompressed size and must be valid even if the delta is not
+ * cached.
+ *
+ * [1] during try_delta phase we don't bother with compressing because
+ * the delta could be quickly replaced with a better one.
+ */
 struct object_entry {
 	struct pack_idx_entry idx;
 	unsigned long size;	/* uncompressed size */
-- 
2.16.2.903.gd04caf5039

