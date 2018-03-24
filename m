Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CA061F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 06:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbeCXGel (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 02:34:41 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41418 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbeCXGeU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 02:34:20 -0400
Received: by mail-lf0-f66.google.com with SMTP id o102-v6so21247613lfg.8
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 23:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xm+VrRDmATcg4kavmOBzKps0PcmGoalw6Pi77TrmXes=;
        b=IfXShHml3fdkECqObuzPHCWxEWE5TSdeeF34dYo3D8YgvEpn+7EOyLlKuWg3zg5Erf
         eeSkbRSkxB2V3yiovhijT5Pz1QehnSapzrbNFymToxGBJg+cy088mg7gN8z5LVsfElfI
         1DuHHoKS+V7NOoWvJKLGobbc/71jPftjk9Cgzctmy/rHoSzGAiE9Dagn6CGuP6XEMDgg
         fgLTg0pV9hVmfnuj5NPNVd0aPv8GeL05rvONX0fSQ/HxVDF9wVEPX+ibWdfCo1ZeoKEq
         0zGceOmTDnrYy5F+W+epBqdcOiD9DwAKtvxfTIBut9crtNaIFGBfKBeH52g0/Gek1YKD
         YUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xm+VrRDmATcg4kavmOBzKps0PcmGoalw6Pi77TrmXes=;
        b=FxRQcPCaHQmZnZqGid3KCVRCnVPIn38WysV9SO6j3Yi386dWphA+pX9C9yeiF5CK++
         tFE6N90x69i99GhTLRYnQxkAbz+PGOxdmMI5kQ2e9mcOS+bRS52yS+0+k/1E+j3TwwuN
         M3B0SxQ6gXDI6GqyIdknBLAGmrRdwYcl2jO/PLt17j2vOt852fifMbaZIq5OvGb4Bv1r
         pPmUSlQ+8nCm7V55mfKERgeOpBwEsDo/U9V2vOxljRBR+MkMeEizXLiG3jiQAuCUMERt
         f9D0RTkB9RZ+CI+eJ8veQyMNqHsPkoHl3KquTXH3d1wYY69eWqNOgtLpzSQzWjYgRktw
         W4ug==
X-Gm-Message-State: AElRT7FxdhgwxUJz3+x4jFOvR3frbBUY6rRKoIG31+B10UqQYN1iDiUP
        bQ50hY8tw9gibjD6OqmRdKI=
X-Google-Smtp-Source: AG47ELt0XxCKo/bnrUAB0vkl7Z2FQgdH7skJ7TdDMUZAopvvzWq/0IxOX5bYv/PWWD3Bf5XU3zLNEQ==
X-Received: by 2002:a19:1d12:: with SMTP id d18-v6mr20673033lfd.128.1521873258627;
        Fri, 23 Mar 2018 23:34:18 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h8sm2251703lja.41.2018.03.23.23.34.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 23:34:17 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v7 10/13] pack-objects: clarify the use of object_entry::size
Date:   Sat, 24 Mar 2018 07:33:50 +0100
Message-Id: <20180324063353.24722-11-pclouds@gmail.com>
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
index da010f7d19..f054ba9dfa 100644
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
index 415b961245..d23e17050c 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -34,7 +34,9 @@ enum dfs_state {
  *
  * "size" is the uncompressed object size. Compressed size of the raw
  * data for an object in a pack is not stored anywhere but is computed
- * and made available when reverse .idx is made.
+ * and made available when reverse .idx is made. Note that when an
+ * delta is reused, "size" is the uncompressed _delta_ size, not the
+ * canonical one after the delta has been applied.
  *
  * "hash" contains a path name hash which is used for sorting the
  * delta list and also during delta searching. Once prepare_pack()
-- 
2.17.0.rc0.348.gd5a49e0b6f

