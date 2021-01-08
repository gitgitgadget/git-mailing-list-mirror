Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA780C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A348723A7C
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbhAHSSu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbhAHSSu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:18:50 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A55C06129C
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:18:09 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id m23so10685308ioy.2
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J+jW+1X1QIgtpR9XJFTsWi1rtNV9LEBigXUeAGkVWmI=;
        b=lumj/snH0t8dRbDA31AUasA88JiXZ/Y30+CUy3Fr9J3CPKJOd8Ay3BJ/bijkokQ+Nn
         NTGnadBnI9rlc33qNosKmxpylhg3nmX47GRQjbewooKNnaxoCMi41bpCpumH1vbAotIj
         6SwNj9qxuiEhnCnZ/+fX+lvYY0itpRncnfYR2xqKuy2VN2jpl3qMwdKhnnvVWedOoHbu
         BzD+eJuGT+5xpEZYQ2v2vtUkofiGBVPHucyc7MGl+jcS468EvsR3FR5tCxVwMe5wZJe9
         FNNwWZ4DIqnJKZHBPEQ9B5YnnxM75wvTOCEECMX+RyEhFanx23OJOmlWubh5uNGsWpqC
         6lqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J+jW+1X1QIgtpR9XJFTsWi1rtNV9LEBigXUeAGkVWmI=;
        b=I7KHkmXNDcAcitJYxhgGLLAwAYVaEomwyyuvCTGwD1jrAzOkeU5jSlGnapk10Mc5NZ
         TwC2MAMBakpsK5a0HGDPK/DI/iWWLz/5JKMUu12jmyikr4Gj/aK2jIWYiNI+SG/snFhI
         oILU3Ab49e/bqAaRFGs/xI/0g9EnfmNnpLT2Iqspywm/FPSTSFaI55OkGJpFPTtQzVOh
         MJLip1sVIx/VVGB+qjQFSUKlSiOJqutRzNx2oNEA2WxeYDJ8S9lQ9mJBeQOqZ+s8NJ4r
         SjHXWumM5YbWjMA6LW1GFEWqln0mK3enKNAm5tMbXDCOKWnpAcEUOXhb4NGlsU6/05VE
         NvyA==
X-Gm-Message-State: AOAM530DvQCBJG8PTatk62XaiE5KA2G3FXXhsSADtBLeLWcLjZlm7IcS
        +BCHmD2WKTH8kd8DvynAWn+mv9jhYbhqMg==
X-Google-Smtp-Source: ABdhPJxPts4jeZIOg2ZP8VAhmvfIKL9FRkjecNsgJriArisbgFH6ixc+TMmCt0jFhbLity8xfz00jQ==
X-Received: by 2002:a02:a419:: with SMTP id c25mr4472512jal.91.1610129889085;
        Fri, 08 Jan 2021 10:18:09 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id g2sm7313343ilh.41.2021.01.08.10.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:18:08 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:18:06 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 20/20] pack-revindex.c: avoid direct revindex access in
 'offset_to_pack_pos()'
Message-ID: <eada1ffcfafc3fb57de80626e368672cb8b22318.1610129796.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To prepare for on-disk reverse indexes, remove a spot in
'offset_to_pack_pos()' that looks at the 'revindex' array in 'struct
packed_git'.

Even though this use of the revindex pointer is within pack-revindex.c,
this clean up is still worth doing. Since the 'revindex' pointer will be
NULL when reading from an on-disk reverse index (instead the
'revindex_data' pointer will be mmaped to the 'pack-*.rev' file), this
call-site would have to include a conditional to lookup the offset for
position 'mi' each iteration through the search.

So instead of open-coding 'pack_pos_to_offset()', call it directly from
within 'offset_to_pack_pos()'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-revindex.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/pack-revindex.c b/pack-revindex.c
index 36ef276378..2cd9d632f1 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -178,20 +178,20 @@ int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
 {
 	int lo = 0;
 	int hi;
-	const struct revindex_entry *revindex;
 
 	if (load_pack_revindex(p) < 0)
 		return -1;
 
 	hi = p->num_objects + 1;
-	revindex = p->revindex;
 
 	do {
 		const unsigned mi = lo + (hi - lo) / 2;
-		if (revindex[mi].offset == ofs) {
+		off_t got = pack_pos_to_offset(p, mi);
+
+		if (got == ofs) {
 			*pos = mi;
 			return 0;
-		} else if (ofs < revindex[mi].offset)
+		} else if (ofs < got)
 			hi = mi;
 		else
 			lo = mi + 1;
-- 
2.30.0.138.g6d7191ea01
