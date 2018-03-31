Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7733F1F424
	for <e@80x24.org>; Sat, 31 Mar 2018 10:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753274AbeCaKEB (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 06:04:01 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43052 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753079AbeCaKDg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 06:03:36 -0400
Received: by mail-lf0-f68.google.com with SMTP id v207-v6so15124563lfa.10
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 03:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eN4jZm1APMS+m2tYRG6lv0O9NZl22B+AIvExd+7/EKk=;
        b=sVUo14nG0uOwnyx7TMLoT8/s7whqmdRZLyb/RNZTeGnFsEs4w/sJbQLgEItjzAY2E5
         gmg+WEQo3PJJCmVrESnnypsW3LFp/gXeQIrI8DhmK+RVPMH/aiZcGC9+bfjCr85L+hVu
         e0kV7k92pzdHa59pArB2Vbl5082MTlg+UjIRxyHJK7FTF1gFV9AeV8HdtfTHYOhkyRae
         ZPe6JWglS5y4069kw67z73pkadw2zOQ8V+Lae5hQidWu3izK9PtdZNc35mGAq0heyxga
         csk13THJrqSYefdULBmSp+mi0Zi16XN3MAVMjiya02dHF2pejR3GuRXeUOjlkVI8tv2Z
         Qz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eN4jZm1APMS+m2tYRG6lv0O9NZl22B+AIvExd+7/EKk=;
        b=MNlnbuxHMKnfxe3F85Tn5S3UrNxRJngqnolthvznS8qc3b4I7iUdAxYyCX02qdK6E9
         nJZasxI/ifTxlRyJKk2ujHl+U+TFD4HweTfVUsWsn6NzGyGQ+fy7dpoSMvNGryVY7blf
         adKCKCGx/IV9tLf7X3W2owlWHV5GU56zTWPW5Oi9BEGO7eq9puboRvVJiZljqBVG8gQZ
         AoVx7lDwlPSfbYxIwyGVGDmbhIMmGmXaLKW40y5Ikj0+MRxDhhajH6QdvyPY6ABGVSAv
         LCKqsqtpXR20YCCKDsV8dj4OZa4rJ6UdGfCqsf98OZVTj3cSAaqMh//0qhQbjXxTlJap
         TweQ==
X-Gm-Message-State: ALQs6tA/LxlSfphdFsrwde9f6v7+5zk4sOZG1hCbVaDdf5ifQGaapdra
        Wmfp8YKlT6HgKvKssdyOueo=
X-Google-Smtp-Source: AIpwx48vu9vWfMYcDFZAIsVNXq7Wwl29oRgLPYKr4UzQAdOvaurMfNggJz8dEOwMM9sweZ8ty7Mm7g==
X-Received: by 10.46.150.135 with SMTP id q7mr1381464lji.67.1522490615044;
        Sat, 31 Mar 2018 03:03:35 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id a1sm1799175ljj.90.2018.03.31.03.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Mar 2018 03:03:34 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v8 11/15] pack-objects: clarify the use of object_entry::size
Date:   Sat, 31 Mar 2018 12:03:07 +0200
Message-Id: <20180331100311.32373-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc2.515.g4feb9b7923
In-Reply-To: <20180331100311.32373-1-pclouds@gmail.com>
References: <20180324063353.24722-1-pclouds@gmail.com>
 <20180331100311.32373-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While this field most of the time contains the canonical object size,
there is one case it does not: when we have found that the base object
of the delta in question is also to be packed, we will very happily
reuse the delta by copying it over instead of regenerating the new
delta.

"size" in this case will record the delta size, not canonical object
size. Later on in write_reuse_object(), we reconstruct the delta
header and "size" is used for this purpose. When this happens, the
"type" field contains a delta type instead of a canonical type.
Highlight this in the code since it could be tricky to see.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 11 ++++++++---
 pack-objects.h         |  4 +++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 481b55c746..7a84c3f59a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1417,6 +1417,7 @@ static void check_object(struct object_entry *entry)
 		off_t ofs;
 		unsigned char *buf, c;
 		enum object_type type;
+		unsigned long in_pack_size;
 
 		buf = use_pack(p, &w_curs, entry->in_pack_offset, &avail);
 
@@ -1426,7 +1427,7 @@ static void check_object(struct object_entry *entry)
 		 */
 		used = unpack_object_header_buffer(buf, avail,
 						   &type,
-						   &entry->size);
+						   &in_pack_size);
 		if (used == 0)
 			goto give_up;
 
@@ -1443,6 +1444,7 @@ static void check_object(struct object_entry *entry)
 		default:
 			/* Not a delta hence we've already got all we need. */
 			oe_set_type(entry, entry->in_pack_type);
+			entry->size = in_pack_size;
 			entry->in_pack_header_size = used;
 			if (oe_type(entry) < OBJ_COMMIT || oe_type(entry) > OBJ_BLOB)
 				goto give_up;
@@ -1499,6 +1501,7 @@ static void check_object(struct object_entry *entry)
 			 * circular deltas.
 			 */
 			oe_set_type(entry, entry->in_pack_type);
+			entry->size = in_pack_size; /* delta size */
 			SET_DELTA(entry, base_entry);
 			entry->delta_size = entry->size;
 			entry->delta_sibling_idx = base_entry->delta_child_idx;
@@ -1508,13 +1511,15 @@ static void check_object(struct object_entry *entry)
 		}
 
 		if (oe_type(entry)) {
+			off_t delta_pos;
+
 			/*
 			 * This must be a delta and we already know what the
 			 * final object type is.  Let's extract the actual
 			 * object size from the delta header.
 			 */
-			entry->size = get_size_from_delta(p, &w_curs,
-					entry->in_pack_offset + entry->in_pack_header_size);
+			delta_pos = entry->in_pack_offset + entry->in_pack_header_size;
+			entry->size = get_size_from_delta(p, &w_curs, delta_pos);
 			if (entry->size == 0)
 				goto give_up;
 			unuse_pack(&w_curs);
diff --git a/pack-objects.h b/pack-objects.h
index 5613a3d040..534f5a5e4d 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -30,7 +30,9 @@ enum dfs_state {
  *
  * "size" is the uncompressed object size. Compressed size of the raw
  * data for an object in a pack is not stored anywhere but is computed
- * and made available when reverse .idx is made.
+ * and made available when reverse .idx is made. Note that when a
+ * delta is reused, "size" is the uncompressed _delta_ size, not the
+ * canonical one after the delta has been applied.
  *
  * "hash" contains a path name hash which is used for sorting the
  * delta list and also during delta searching. Once prepare_pack()
-- 
2.17.0.rc2.515.g4feb9b7923

