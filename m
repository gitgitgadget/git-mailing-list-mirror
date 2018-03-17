Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 152D11F404
	for <e@80x24.org>; Sat, 17 Mar 2018 14:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbeCQOLJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 10:11:09 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42942 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752398AbeCQOLC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 10:11:02 -0400
Received: by mail-lf0-f65.google.com with SMTP id a22-v6so19309170lfg.9
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 07:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xQ1ipxTv8XRBrsFgkSSD3+BP/xuzGHIidtwFPabnrkk=;
        b=kAyCad2ak2H7TMvxy5wjx0hV776R6FZxRlT1687d7Nex8aFKDa4FbJR0xrnFzo7vlt
         Uoi4wF9uuZ9DVfJM2E0Jz/4JtdeFOGIbDBECrmxFEukymMgyu4FPN8c90/D0NWpnfBQt
         1I1ELLimyWm5phWIJSh5vMhsSj1UlsBlThRueGNgqz5PkFBSO/BxA3duBJzhVn3RRjRO
         01bShyftrPslkU402/G1WDkl2t0j3/LUgQrJyzw877AEsBsD0yeenkxhQ83CK9Lu0DM4
         1pMPhkGy2U6gJKswRTMIQxQ65fnbIzz8gnvU/iuW1+ZN66f16VXKrgwGMpo8+amR49ZX
         xVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xQ1ipxTv8XRBrsFgkSSD3+BP/xuzGHIidtwFPabnrkk=;
        b=tHM6TMuHjPYFhqljP/8BbI2E0EfZVgIBW/e6PXOWX01T7yjnP7FSFHRVYeKeFILpjL
         sYf8H/LdtBlwHwdamyAz/6MJ+fZc2FiZSzjtx+YEn4/n98pgwL6GCSfH/uSLQqiZfxMn
         qUicdBQ1tc7MFyDr2Y2vvDn3UKn+I5sPqxkFvMNBkzsdis3ngy4wSxH6BXXANETP36Vf
         VgbHZbprYpoUjCkiK6RCpxLYtJXaIXyzcqiE3Fz06Cv6ilMbDE+EWQGjn/7bBSXS9/Ek
         aUlPvMowbT+69svpz2C9d7MKwDkUXH/xR0EKm6WPLmm1z9TlvJHgZ3cQCtokKs9DtN9I
         JIkA==
X-Gm-Message-State: AElRT7EFQ3W8nkRl1wqPw3cA5F9iXarMpwAPO2RJlJcSF3Juq4Ce7WFU
        stfwz0e54j3fr8fWvXl6iSM=
X-Google-Smtp-Source: AG47ELtVkgLaw9UC+OM72zYxYKXUTpbJzZ5nd2BsOpW+UZwvz6yXXINetCFxUzLwhZUacsZ47yIOiA==
X-Received: by 10.46.153.76 with SMTP id r12mr3756209ljj.67.1521295860565;
        Sat, 17 Mar 2018 07:11:00 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f7-v6sm625648lfb.2.2018.03.17.07.10.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 07:10:59 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v5 11/11] pack-objects.h: reorder members to shrink struct object_entry
Date:   Sat, 17 Mar 2018 15:10:33 +0100
Message-Id: <20180317141033.21545-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.347.gf9cf61673a
In-Reply-To: <20180317141033.21545-1-pclouds@gmail.com>
References: <20180316183200.31014-1-pclouds@gmail.com>
 <20180317141033.21545-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previous patches leave lots of holes and padding in this struct. This
patch reorders the members and shrinks the struct down to 80 bytes
(from 136 bytes, before any field shrinking is done) with 16 bits to
spare (and a couple more in in_pack_header_size when we really run out
of bits).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 pack-objects.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/pack-objects.h b/pack-objects.h
index 2507b157d5..8979289f5f 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -71,35 +71,36 @@ enum dfs_state {
  */
 struct object_entry {
 	struct pack_idx_entry idx;
-	/* object uncompressed size _if_ size_valid is true */
-	uint32_t size_;
-	unsigned size_valid:1;
-	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
+	void *delta_data;	/* cached delta (uncompressed) */
 	off_t in_pack_offset;
+	uint32_t hash;			/* name hint hash */
+	uint32_t size_;	/* object uncompressed size _if_ size_valid is true */
 	uint32_t delta_idx;	/* delta base object */
 	uint32_t delta_child_idx; /* deltified objects who bases me */
 	uint32_t delta_sibling_idx; /* other deltified objects who
 				     * uses the same base as me
 				     */
-	void *delta_data;	/* cached delta (uncompressed) */
 	uint32_t delta_size_:OE_DELTA_SIZE_BITS; /* delta data size (uncompressed) */
 	uint32_t delta_size_valid:1;
+	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
+	unsigned size_valid:1;
 	unsigned z_delta_size:OE_Z_DELTA_BITS;
+	unsigned type_valid:1;
 	unsigned type_:TYPE_BITS;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
-	unsigned type_valid:1;
-	uint32_t hash;			/* name hint hash */
-	unsigned char in_pack_header_size;
 	unsigned preferred_base:1; /*
 				    * we do not pack this, but is available
 				    * to be used as the base object to delta
 				    * objects against.
 				    */
 	unsigned no_try_delta:1;
+	unsigned char in_pack_header_size;
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
 	unsigned dfs_state:OE_DFS_STATE_BITS;
 	unsigned depth:OE_DEPTH_BITS;
+
+	/* size: 80, bit_padding: 16 bits */
 };
 
 struct packing_data {
-- 
2.17.0.rc0.347.gf9cf61673a

