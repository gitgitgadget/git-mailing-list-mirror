Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D476C432C3
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFBBC23A7C
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbhAHSSW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbhAHSSU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:18:20 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5B7C0612FD
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:17:38 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id h4so9279686qkk.4
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r4lkHcEzjDWu67TnmEgApqdMZar61EkpRl4C7kmXzrk=;
        b=wi1bPYDYQX7KNh4WaX2zrWHlgSgHXLRRdREDnLqp13zKPewqk6fPrLIgwiU7v1hVVw
         d+XvDQu9wHjMh/9pfRyzfxXrNpxlcy207MG8hFpH0eYydfmxP0GqryrVOpdcavPRQDtq
         rh+gZL0k/AIT3RwUfc/Qy9qbisdKi3flVWlc50+K22Ah7UyA/W+I5jWzAUHeB+arECMA
         1cpO8js/fs7SzdPNI00TDbYBcgm8Tk1A3OwzKmAx2uw+3PQe41IGHzP1F9ZZLS/df2+g
         /pf3BFVageNoW19JQQ0YRS6TmtDNqiwkKAGhHiDtGnb2tLOabn5auxFil2+G+RQKNzeg
         I0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r4lkHcEzjDWu67TnmEgApqdMZar61EkpRl4C7kmXzrk=;
        b=CjzKXmzeijbbXdGc4ltdQC1hU8p29mKiUozpe3eO8mhAJWrkjd7t426ahQI90GDxon
         MSv4kc7GoDon6DnG8eBQYPkCSl62hjkpXmtodytH+Bf2E6+40mpxsUgHuq0vKccSqWVy
         vqLhOTCpomSCeGjOoL14YdKUaDijravQ0x5txBhT2cG+HIhnNDkk2Lw/oz61llUzT0UE
         cWhV31ILzgBvmqy9uHMB9tPf33otQAfpRCWR2ma3RW/D9kv8tIs5l6mZRfz7xbpJ/2JD
         imL7Zv35wf1gSfLqx+Bbn96cS9876FbWzezIrIEgWRyh/HofgHs1WA139XsQu8mOBgkm
         ySNw==
X-Gm-Message-State: AOAM533RtWjhx42dFB5raNSwlyoaKdHepIivvNU1KJdV/K9IFuacpHUi
        ct5dIL4G37puL0EBXA57K5dE881pos0zsQ==
X-Google-Smtp-Source: ABdhPJwMlKyR20hRInU49gGgQy3o7/ZKesUoAYzPEx6bD9silpN5n9FJUm+LNOVBUo51Gg/pvtkZvQ==
X-Received: by 2002:a05:620a:1467:: with SMTP id j7mr5091684qkl.266.1610129857742;
        Fri, 08 Jan 2021 10:17:37 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id 70sm5151871qkk.10.2021.01.08.10.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:17:36 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:17:34 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 13/20] packed_object_info(): convert to new revindex API
Message-ID: <eab7ab1f35fa9703f56a99fa539839869fe4e54c.1610129796.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert another call of 'find_pack_revindex()' to its replacement
'pack_pos_to_offset()'. Likewise:

  - Avoid manipulating `struct packed_git`'s `revindex` pointer directly
    by removing the pointer-as-array indexing.

  - Add an additional guard to check that the offset 'obj_offset()'
    points to a real object. This should be the case with well-behaved
    callers to 'packed_object_info()', but isn't guarenteed.

    Other blocks that fill in various other values from the 'struct
    object_info' request handle bad inputs by setting the type to
    'OBJ_BAD' and jumping to 'out'. Do the same when given a bad offset
    here.

    The previous code would have segfaulted when given a bad
    'obj_offset' value, since 'find_pack_revindex()' would return
    'NULL', and then the line that fills 'oi->disk_sizep' would try to
    access 'NULL[1]' with a stride of 16 bytes (the width of 'struct
    revindex_entry)'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 packfile.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/packfile.c b/packfile.c
index 7c37f9ec5c..469c8d4f57 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1537,8 +1537,13 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	}
 
 	if (oi->disk_sizep) {
-		struct revindex_entry *revidx = find_pack_revindex(p, obj_offset);
-		*oi->disk_sizep = revidx[1].offset - obj_offset;
+		uint32_t pos;
+		if (offset_to_pack_pos(p, obj_offset, &pos) < 0) {
+			type = OBJ_BAD;
+			goto out;
+		}
+
+		*oi->disk_sizep = pack_pos_to_offset(p, pos + 1) - obj_offset;
 	}
 
 	if (oi->typep || oi->type_name) {
-- 
2.30.0.138.g6d7191ea01

