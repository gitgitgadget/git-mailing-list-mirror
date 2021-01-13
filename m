Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8C5C4332B
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 828F023442
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbhANCGE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbhAMW0G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:26:06 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A2AC0617B0
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:24:49 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id c14so2321412qtn.0
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OL4+MFWWUkFQnxJB84R/V4ovdVtSz8QV0aL6M7LI5Uw=;
        b=nsyVB12vBEmTu9ASaaIexG3gOWdn6iIZFGZKxS+5HL36aBQzstMAVs8uGzkL9klZmP
         +/7nmOWfo8b90BhNoBuEMAEMGJT4XiUtearGYsNnnF1i2cp+YaJ2rrd6OazCeQ0eEHXs
         QeXiNLJTeJvIs9cvIpIbcDfwpgGuhGjSi2dsOsf23tQ4MJH8sR+spp7k/TKbGM9wPSb2
         j2fUGgCgJB6Mh1YsskXxKWNTs0f9OEKLInxQPPnfAowH3mIGt9mM4/uzJWdBnnsd2ttL
         KGHBIHR91jhdn7k/g0cXeFnmLIRYACRIRI2OmW4qGGWYPEfGGGufkfm0+vcAB7Io+Yfb
         betA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OL4+MFWWUkFQnxJB84R/V4ovdVtSz8QV0aL6M7LI5Uw=;
        b=NbmbkevndPmJiSOCwzlJXV0dZ6YLkT+ADmYft7VkYkai5FwwUNgvWb0+pcaSlS7QsI
         20LiIFK+4UCZicLv3iE57xC0ITt5TEEbH2YiEr0tvt9cCPlp4p36sRvaEmbAaVsbczGp
         Ed0z/IKOTn2QZ8ylmduk0oZJWTwMlbnreo2biuh9BoGHcpblX6ZTywpE0khkPvEczr+n
         6+Fpc0OaWDN56kPjeWRN3/oCJ0bFIBmqHSRr6wJOX+UeR7QHeVRiT/tIcVHSytNJGsBd
         sQHwlVlh8TC/2DuhZ/j0fMn/DtpvTvy//W8kp4+emPYDwgmqpT64JwWJToOLJcH90W59
         0Obw==
X-Gm-Message-State: AOAM532cVXr8RGmICjmaIxYYG9Zo/M0nD9CS9k9vxGfot/RNiSapB/98
        hio7M5gD2QLWtXMwU2iN4ApO8Ofq1VaJIg==
X-Google-Smtp-Source: ABdhPJyGeLncKpq8CLKbmtPpY55CBrmhbJRuNLZ60HMIxzqVcwdhE8srG/4E+xu1DX+lrV1Tr67vvQ==
X-Received: by 2002:ac8:670e:: with SMTP id e14mr4408972qtp.68.1610576688293;
        Wed, 13 Jan 2021 14:24:48 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id i17sm1875840qtg.77.2021.01.13.14.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:24:47 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:24:45 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 14/20] unpack_entry(): convert to new revindex API
Message-ID: <8ad49d231f5e00e258a2e64443cda16626e289c4.1610576604.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610576604.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove direct manipulation of the 'struct revindex_entry' type as well
as calls to the deprecated API in 'packfile.c:unpack_entry()'. Usual
clean-up is performed (replacing '->nr' with calls to
'pack_pos_to_index()' and so on).

Add an additional check to make sure that 'obj_offset()' points at a
valid object. In the case this check is violated, we cannot call
'mark_bad_packed_object()' because we don't know the OID. At the top of
the call stack is do_oid_object_info_extended() (via
packed_object_info()), which does mark the object.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 packfile.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/packfile.c b/packfile.c
index bb4bb14671..936ab3def5 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1694,11 +1694,21 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 		}
 
 		if (do_check_packed_object_crc && p->index_version > 1) {
-			struct revindex_entry *revidx = find_pack_revindex(p, obj_offset);
-			off_t len = revidx[1].offset - obj_offset;
-			if (check_pack_crc(p, &w_curs, obj_offset, len, revidx->nr)) {
+			uint32_t pack_pos, index_pos;
+			off_t len;
+
+			if (offset_to_pack_pos(p, obj_offset, &pack_pos) < 0) {
+				error("could not find object at offset %"PRIuMAX" in pack %s",
+				      (uintmax_t)obj_offset, p->pack_name);
+				data = NULL;
+				goto out;
+			}
+
+			len = pack_pos_to_offset(p, pack_pos + 1) - obj_offset;
+			index_pos = pack_pos_to_index(p, pack_pos);
+			if (check_pack_crc(p, &w_curs, obj_offset, len, index_pos)) {
 				struct object_id oid;
-				nth_packed_object_id(&oid, p, revidx->nr);
+				nth_packed_object_id(&oid, p, index_pos);
 				error("bad packed object CRC for %s",
 				      oid_to_hex(&oid));
 				mark_bad_packed_object(p, oid.hash);
@@ -1781,11 +1791,11 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 			 * This is costly but should happen only in the presence
 			 * of a corrupted pack, and is better than failing outright.
 			 */
-			struct revindex_entry *revidx;
+			uint32_t pos;
 			struct object_id base_oid;
-			revidx = find_pack_revindex(p, obj_offset);
-			if (revidx) {
-				nth_packed_object_id(&base_oid, p, revidx->nr);
+			if (!(offset_to_pack_pos(p, obj_offset, &pos))) {
+				nth_packed_object_id(&base_oid, p,
+						     pack_pos_to_index(p, pos));
 				error("failed to read delta base object %s"
 				      " at offset %"PRIuMAX" from %s",
 				      oid_to_hex(&base_oid), (uintmax_t)obj_offset,
-- 
2.30.0.138.g6d7191ea01

