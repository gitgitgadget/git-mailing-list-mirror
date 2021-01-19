Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412ECC433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DDD623104
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbhASXZd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 18:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbhASXYp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 18:24:45 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71397C0613C1
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:24:04 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id c1so15084384qtc.1
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PcVhayTf7fnq2JBG6Qp5ng2A2l0h8mJH3Hk6zzczxWQ=;
        b=zwSkl8MKQXDFlZ01FmnYvUvRHIJy5S163fBA6l50G1cxPEtGgGNLe/Hsi7rqPgda28
         G9yUzbwH7+5wNNpD30lBZS8Eg8vxChlHvpzKsEn5TTcNCYfEVIdxuvl4bwgoVtBKhvwB
         MZZnAHsZoZkm4l2SZeHRzCyKOQet0pvD0jhRmlTNae1emE42tS/BNt97NghDJBNSOwJG
         x6RlQBwqhs9U1/CCPDe81xA9EiosF8SRg1IcEyKjSR1ET81nmWxzHcx4/O/AQCUn19Sd
         5R3NqVY+6YoQoOn/HllrQeFRYUS4+HILHXQuTQnKYRdQEb+VkaLToIcM4d/sA/58Dlas
         GhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PcVhayTf7fnq2JBG6Qp5ng2A2l0h8mJH3Hk6zzczxWQ=;
        b=Ft5EQaC90EUnkgwjcaWute3KXntem52AhdLuOOhSZFMdLlLp5u+uYZd61q5VBetAJ3
         ZD8/PxOpSGmM4/KTR8mrhLv86Bzd5w0ZaMwaNo4dkWyoaxs6WwxHwDTRMMZEVbAe/IGJ
         rdWpl927fhezGG2dz2pbXXfWRi9MfVYVapHtBa4FE4arYw2+cbajvD7BxhztRNuxr1Tw
         rwlaKeNdRokaio4bU1xr9N3MTsdGQnt5zGyUHuW0LVX8V8jQGHtXv0vbf9VmcebeTs2v
         jysbZDVORwfBKjeEP6UF0ebujqeaWG5V3Ta1meO2Y/zklvPP7puekYkpX/RNR/VgHVdv
         GwGg==
X-Gm-Message-State: AOAM530gaIuX4oDCGiGAj7gGmNj7spQPWC4y+DC7F1+dkoBGmYNL7x01
        Hz7lueItguK3l7UJOZHqNSy607hGPKp83Q==
X-Google-Smtp-Source: ABdhPJz4uy7gbuaqby4lA+p+nZ/u8Jy7B9gP6V7jW2ObZuAJu7WTylxe50j3zbOYqbSpw6+JomPqqw==
X-Received: by 2002:ac8:110e:: with SMTP id c14mr6358747qtj.293.1611098643348;
        Tue, 19 Jan 2021 15:24:03 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id m64sm164972qkb.90.2021.01.19.15.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 15:24:02 -0800 (PST)
Date:   Tue, 19 Jan 2021 18:24:00 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 01/10] packfile: introduce 'find_kept_pack_entry()'
Message-ID: <dc7fa4c7a61f657e779e10385d3e8076d6dac36c.1611098616.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1611098616.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Future callers will want a function to fill a 'struct pack_entry' for a
given object id but _only_ from its position in any kept pack(s). They
could accomplish this by calling 'find_pack_entry()' and checking
whether the found pack is kept or not, but this is insufficient, since
there may be duplicate objects (and the mru cache makes it unpredictable
which variant we'll get).

Teach this new function to treat the two different kinds of kept packs
(on disk ones with .keep files, as well as in-core ones which are set by
manually poking the 'pack_keep_in_core' bit) separately. This will
become important for callers that only want to respect a certain kind of
kept pack.

Introduce 'find_kept_pack_entry()' which behaves like
'find_pack_entry()', except that it skips over packs which are not
marked kept. Callers will be added in subsequent patches.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 packfile.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 packfile.h |  6 +++++
 2 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/packfile.c b/packfile.c
index 62d92e0c7c..30f43a1a35 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2015,7 +2015,10 @@ static int fill_pack_entry(const struct object_id *oid,
 	return 1;
 }
 
-int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e)
+static int find_one_pack_entry(struct repository *r,
+			       const struct object_id *oid,
+			       struct pack_entry *e,
+			       int kept_only)
 {
 	struct list_head *pos;
 	struct multi_pack_index *m;
@@ -2025,26 +2028,77 @@ int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
 		return 0;
 
 	for (m = r->objects->multi_pack_index; m; m = m->next) {
-		if (fill_midx_entry(r, oid, e, m))
+		if (!(fill_midx_entry(r, oid, e, m)))
+			continue;
+
+		if (!kept_only)
+			return 1;
+
+		if (((kept_only & ON_DISK_KEEP_PACKS) && e->p->pack_keep) ||
+		    ((kept_only & IN_CORE_KEEP_PACKS) && e->p->pack_keep_in_core))
 			return 1;
 	}
 
 	list_for_each(pos, &r->objects->packed_git_mru) {
 		struct packed_git *p = list_entry(pos, struct packed_git, mru);
-		if (!p->multi_pack_index && fill_pack_entry(oid, e, p)) {
-			list_move(&p->mru, &r->objects->packed_git_mru);
-			return 1;
+		if (p->multi_pack_index && !kept_only) {
+			/*
+			 * If this pack is covered by the MIDX, we'd have found
+			 * the object already in the loop above if it was here,
+			 * so don't bother looking.
+			 *
+			 * The exception is if we are looking only at kept
+			 * packs. An object can be present in two packs covered
+			 * by the MIDX, one kept and one not-kept. And as the
+			 * MIDX points to only one copy of each object, it might
+			 * have returned only the non-kept version above. We
+			 * have to check again to be thorough.
+			 */
+			continue;
+		}
+		if (!kept_only ||
+		    (((kept_only & ON_DISK_KEEP_PACKS) && p->pack_keep) ||
+		     ((kept_only & IN_CORE_KEEP_PACKS) && p->pack_keep_in_core))) {
+			if (fill_pack_entry(oid, e, p)) {
+				list_move(&p->mru, &r->objects->packed_git_mru);
+				return 1;
+			}
 		}
 	}
 	return 0;
 }
 
+int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e)
+{
+	return find_one_pack_entry(r, oid, e, 0);
+}
+
+int find_kept_pack_entry(struct repository *r,
+			 const struct object_id *oid,
+			 unsigned flags,
+			 struct pack_entry *e)
+{
+	/*
+	 * Load all packs, including midx packs, since our "kept" strategy
+	 * relies on that. We're relying on the side effect of it setting up
+	 * r->objects->packed_git, which is a little ugly.
+	 */
+	get_all_packs(r);
+	return find_one_pack_entry(r, oid, e, flags);
+}
+
 int has_object_pack(const struct object_id *oid)
 {
 	struct pack_entry e;
 	return find_pack_entry(the_repository, oid, &e);
 }
 
+int has_object_kept_pack(const struct object_id *oid, unsigned flags)
+{
+	struct pack_entry e;
+	return find_kept_pack_entry(the_repository, oid, flags, &e);
+}
+
 int has_pack_index(const unsigned char *sha1)
 {
 	struct stat st;
diff --git a/packfile.h b/packfile.h
index a58fc738e0..624327f64d 100644
--- a/packfile.h
+++ b/packfile.h
@@ -161,13 +161,19 @@ int packed_object_info(struct repository *r,
 void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
 const struct packed_git *has_packed_and_bad(struct repository *r, const unsigned char *sha1);
 
+#define ON_DISK_KEEP_PACKS 1
+#define IN_CORE_KEEP_PACKS 2
+#define ALL_KEEP_PACKS (ON_DISK_KEEP_PACKS | IN_CORE_KEEP_PACKS)
+
 /*
  * Iff a pack file in the given repository contains the object named by sha1,
  * return true and store its location to e.
  */
 int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e);
+int find_kept_pack_entry(struct repository *r, const struct object_id *oid, unsigned flags, struct pack_entry *e);
 
 int has_object_pack(const struct object_id *oid);
+int has_object_kept_pack(const struct object_id *oid, unsigned flags);
 
 int has_pack_index(const unsigned char *sha1);
 
-- 
2.30.0.138.g6d7191ea01

