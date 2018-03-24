Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D2AD1FAE5
	for <e@80x24.org>; Sat, 24 Mar 2018 06:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750899AbeCXGeL (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 02:34:11 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38512 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbeCXGeI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 02:34:08 -0400
Received: by mail-lf0-f68.google.com with SMTP id u3-v6so352932lff.5
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 23:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DOEiB5eitX1F+jJH+a4MQ9uOkKjTC4OmZEAwcQbBI9Q=;
        b=ITQLwOnd8nwWgT8Q4D5WmhxEajYX0sLF/NuKJFdQkOUxmjj6DHLp/X0stWNPc6eQNd
         D3mnBAvyaprxYoxg1IbWpwwU1Jqr9X3sUrx3vTsP7uxZf2asVg0rWIUeOLkg14nzhIyl
         aMGszyitQhx59ZELV8QC1lVe3k2uiD15zlRPtXhK5C1KINuLKu61tgzUmIJlElkN8Tmp
         kWaz/8rBI8xx/igcPkd75wsWKk2lKiOMkFYqYRi8eeg/wH1k8tSKC1Kg51zPfuVFjtK0
         rGXg5iKaXRSBNOZ+O9AfXsme4GThthSpJwyWDSzPaV0isc3h6FIkM9coLaZiXVel9qoA
         NFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DOEiB5eitX1F+jJH+a4MQ9uOkKjTC4OmZEAwcQbBI9Q=;
        b=CdvifebpBjpMXM2yX+fAiQyx2MMHsG+8PwuPITEARRC0otppbTGxBpnx80pOQD0d0J
         D5ZkB2UziZsb5tVdkFQxq65TqlUoiOxkOcklUVZRgFlwdgdvVb4M9MRMJcoryGelal2G
         p9UWI+ZvhMgugXrcHdYCyxMNS9YqfAc16S8MIH/6kCmgDQaW+Hk2f1S+gyym0RtZTWMn
         Kfua23UkgGgjeLLcWcI941/+SNLwKAU9IURJMIjN32IglqpY3jxR6hZlG9zf5dHb1F8W
         Q4bgeaDc6ZtzDaNKfAE/t4/9UuNT4wsRxKltaYGvBs+vo0QeK253zA3vyV1qz3MeNJXw
         1iDQ==
X-Gm-Message-State: AElRT7HhbNoIwO4jdjl6BwMG9GIHuJk9i55+8467xzNEnTEDYOTOpRCF
        hfoUnX/JeQpbAT6wgcmzQqw=
X-Google-Smtp-Source: AG47ELsn074JgOAn2R20kKLVuwihL/sPyxauuFN8wGReiujqhRCShfPh1C8/j+dHnZHms81V/NiBWw==
X-Received: by 10.46.23.202 with SMTP id 71mr21186771ljx.49.1521873247215;
        Fri, 23 Mar 2018 23:34:07 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h8sm2251703lja.41.2018.03.23.23.34.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 23:34:06 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v7 01/13] pack-objects: a bit of document about struct object_entry
Date:   Sat, 24 Mar 2018 07:33:41 +0100
Message-Id: <20180324063353.24722-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324063353.24722-1-pclouds@gmail.com>
References: <20180318142526.9378-1-pclouds@gmail.com>
 <20180324063353.24722-1-pclouds@gmail.com>
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
 pack-objects.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/pack-objects.h b/pack-objects.h
index 03f1191659..c0a1f61aac 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -1,6 +1,51 @@
 #ifndef PACK_OBJECTS_H
 #define PACK_OBJECTS_H
 
+/*
+ * basic object info
+ * -----------------
+ * idx.oid is filled up before delta searching starts. idx.crc32 is
+ * only valid after the object is written out and will be used for
+ * generating the index. idx.offset will be both gradually set and
+ * used in writing phase (base objects get offset first, then deltas
+ * refer to them)
+ *
+ * "size" is the uncompressed object size. Compressed size of the raw
+ * data for an object in a pack is not stored anywhere but is computed
+ * and made available when reverse .idx is made.
+ *
+ * "hash" contains a path name hash which is used for sorting the
+ * delta list and also during delta searching. Once prepare_pack()
+ * returns it's no longer needed.
+ *
+ * source pack info
+ * ----------------
+ * The (in_pack, in_pack_offset) tuple contains the location of the
+ * object in the source pack. in_pack_header_size allows quickly
+ * skipping the header and going straight to the zlib stream.
+ *
+ * "type" and "in_pack_type" both describe object type. in_pack_type
+ * may contain a delta type, while type is always the canonical type.
+ *
+ * deltas
+ * ------
+ * Delta links (delta, delta_child and delta_sibling) are created to
+ * reflect that delta graph from the source pack then updated or added
+ * during delta searching phase when we find better deltas.
+ *
+ * delta_child and delta_sibling are last needed in
+ * compute_write_order(). "delta" and "delta_size" must remain valid
+ * at object writing phase in case the delta is not cached.
+ *
+ * If a delta is cached in memory and is compressed, delta_data points
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
2.17.0.rc0.348.gd5a49e0b6f

