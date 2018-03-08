Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50A441FAE2
	for <e@80x24.org>; Thu,  8 Mar 2018 11:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935804AbeCHLmw (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 06:42:52 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39726 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935789AbeCHLmv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 06:42:51 -0500
Received: by mail-pl0-f65.google.com with SMTP id s13-v6so3164548plq.6
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 03:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aA0b1GYSKM/oKZvaNrbMg87i/hfzYb9nchsYNTCw6B4=;
        b=HF/5y8K0rM0uaWkGSG2tN/VSsWoQtO1FOa++KtmBX3GFoYjRzGD5xaLj0BSBhBsgnW
         LnSUdW9RWkVY5+QUO/k2ggljKigtHOfyH4av0CElNF6G9tl7NivvSmdiDNRawfIABAf8
         oPKn+vnL8xTjA0IdLGF9U8MgYd71A2FscRlQP7stJq0/SxRfRutw5w0i3yrnsfmZT+9M
         krylHIo9bkxbCzmJxmtMocZp5K0Yy0WzvMN5l45VDYvxvuVzQtYLuO/EL/Zj/DyMGhJm
         dzI8YNzHw1YZdBgq9AyNmVDPAQIBq9s9TuRWoj5/KkNlDOUOV5oXZpdCrdYaKAxe3aX+
         4SwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aA0b1GYSKM/oKZvaNrbMg87i/hfzYb9nchsYNTCw6B4=;
        b=gXNPxAyEs5mjW1i1SBjK7eIDs6IJxOujtnQFXdDiVO5Ka+k40kUF/6AK/kiYnf011T
         JWKFME4YZUxNAvV19ErozgM5qO4/dPeHtfi/GhEMuegkHWjapfILuqUSfCtKFk0JHZ1x
         mERQ7sBM6x5e7C9It6pG32cO7EJ+sxqA0rX27awane2lZ/aKv+4zC/gi6eMKcG1KdU6w
         39mZnY8PUysltvlht+KwSWQD3dlWNO334+KiSLpRFn03OD9YFkdbiMlP2VhiHzWOsrg8
         gxhEbxpKSx8velxag+Se7Z+vYeUocV2/HBqqs03okQQZCxBb6gR1PXiU0TZHFbdI/2Pu
         DOyQ==
X-Gm-Message-State: APf1xPALBE3+2Id0MYwwpKb+T8GtOh0v60QYih0JJMdoWz0n3Ge1Jn2J
        +8Y0sJq1N/7m9BS8t4nyomY=
X-Google-Smtp-Source: AG47ELs7yRJX1DEwhVuK1eBZXSlv7MIODku0hQCetT9FsRrVSnizfw1TlpNnqRxxTA2qwYPGkJSQ/Q==
X-Received: by 2002:a17:902:42e:: with SMTP id 43-v6mr24388127ple.186.1520509370841;
        Thu, 08 Mar 2018 03:42:50 -0800 (PST)
Received: from ash ([27.78.177.129])
        by smtp.gmail.com with ESMTPSA id h26sm30901497pgv.22.2018.03.08.03.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 03:42:50 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 08 Mar 2018 18:42:45 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH/RFC v3 01/12] pack-objects: a bit of document about struct object_entry
Date:   Thu,  8 Mar 2018 18:42:21 +0700
Message-Id: <20180308114232.10508-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.873.g32ff258c87
In-Reply-To: <20180308114232.10508-1-pclouds@gmail.com>
References: <20180303024706.31465-1-pclouds@gmail.com>
 <20180308114232.10508-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The role of this comment block becomes more important after we shuffle
fields around to shrink this struct. It will be much harder to see what
field is related to what. This also documents the holes in this struct
according to pahole.

A couple of notes on shrinking the struct:

1) The reader may notice one thing from this document and the shrinking
business. If "delta" is NULL, all other delta-related fields should be
irrelevant. We could group all these in a separate struct and replace
them all with a pointer to this struct (allocated separately).

This does not help much though since 85% of objects are deltified
(source: linux-2.6.git). The gain is only from non-delta objects, which
is not that significant.

2) The field in_pack_offset and idx.offset could be merged. But we need
to be very careful. Up until the very last phase (object writing),
idx.offset is not used and can hold in_pack_offset. Then idx.offset will
be updated with _destination pack's_ offset, not source's. But since we
always write delta's bases first, and we only use in_pack_offset in
writing phase when we reuse objects, we should be ok?

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 pack-objects.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/pack-objects.h b/pack-objects.h
index 03f1191659..f834ead541 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -1,6 +1,52 @@
 #ifndef PACK_OBJECTS_H
 #define PACK_OBJECTS_H
 
+/*
+ * basic object info
+ * -----------------
+ * idx.oid is filled up before delta searching starts. idx.crc32 and
+ * is only valid after the object is written down and will be used for
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
+ * If a delta is cached in memory and is compressed, "delta" points to
+ * the data and z_delta_size contains the compressed size. If it's
+ * uncompressed [1], z_delta_size must be zero. delta_size is always
+ * the uncompressed size and must be valid even if the delta is not
+ * cached. Delta recreation technically only depends on "delta"
+ * pointer, but delta_size is still used to verify it's the same as
+ * before.
+ *
+ * [1] during try_delta phase we don't bother with compressing because
+ * the delta could be quickly replaced with a better one.
+ */
 struct object_entry {
 	struct pack_idx_entry idx;
 	unsigned long size;	/* uncompressed size */
@@ -28,6 +74,7 @@ struct object_entry {
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
 
+	/* XXX 28 bits hole, try to pack */
 	/*
 	 * State flags for depth-first search used for analyzing delta cycles.
 	 *
@@ -40,6 +87,7 @@ struct object_entry {
 		DFS_DONE
 	} dfs_state;
 	int depth;
+	/* size: 136, padding: 4 */
 };
 
 struct packing_data {
-- 
2.16.2.873.g32ff258c87

