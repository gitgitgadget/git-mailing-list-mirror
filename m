Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8470BC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 02:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D4660F57
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 02:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbhH3Ctx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Aug 2021 22:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbhH3Ctt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Aug 2021 22:49:49 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57222C061756
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 19:48:56 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id h29so14530127ila.2
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 19:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YXWjraey6WqTcKlYhb7P08QcqlXeqECjIfWJ94dANdA=;
        b=jjY908ZoXtsMa50pIkBJ0Ol6XjVEJ2naRkmB0q+6RlZjzEQY873jFnaQBNeWKcguoB
         gDG4RKQiQqwWO7FN51KqkMvbAiXD2vyB5NaW8IloTANtG5hidGHKez+lACHYyZF7Slq0
         +0p0xn4TFVL+zmzS90I5U04e84UU+rx0ik4hEUddHsf7DUn3aJVzf2BWQUIPVF3xe/8O
         mJLOrkOucccGr1yEzKOg0WUkRMe9o++4uM5ob3/nQMy3VrBgXrBQK+IWonwUEhsd2klZ
         fa2O19eUQXre/TKEDCwU0NJLMZP+bHmBPpRURbzztrUBmUNVoo8VUee7c8SuHJ5b9PE+
         JZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YXWjraey6WqTcKlYhb7P08QcqlXeqECjIfWJ94dANdA=;
        b=lgzCrQrpOMYU6ul1YieTb+az0Cp8XzTBah9KGmv8sec7Yb2dTCatXZo1xT5PElSZoo
         Lhi3sJVTE6+v/vYDOOr+EhKSsqCdtM1REhOzMrbckaiZ4ez8LFwmpalU+JTRzwD0ALmi
         J0+kteLHI73yfhgN56pPaCyjFlZRKYIOxuQi0Q9u1STww6U2TdVAdYtlaB58K3Df2pQJ
         D9IbghTjHazUUyb/9R+lqTipPJg3Wl9RMqFQPNAYjQhYfpcACjMzz890/v2B/Pz0EiZz
         pC7M2kiBwztksHaT1tRSJ+RXphJBrTeQf3cQ/cQKRXoBeGUlJ5HirkNoRa7wRKX6vfqS
         Pwdg==
X-Gm-Message-State: AOAM533jq1ZSZIvMoR4rwzhtSiCMRz8QXwkx48Gl+CdNyT26MpZezi+J
        WrtJV2kpBx5yee2qWncqZ2hj8gV1YSfjdZXJ
X-Google-Smtp-Source: ABdhPJx8uofLgwoZu78HNOncxi8kcaU2GBzh6L1hgg8K8dkLm4q+A0+pHsol7I0MFh8WVlUjMEwfMg==
X-Received: by 2002:a92:c702:: with SMTP id a2mr14835748ilp.210.1630291735659;
        Sun, 29 Aug 2021 19:48:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f5sm7846211ils.3.2021.08.29.19.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 19:48:55 -0700 (PDT)
Date:   Sun, 29 Aug 2021 22:48:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 2/3] builtin/pack-objects.c: simplify
 add_objects_in_unpacked_packs()
Message-ID: <c857e12a032f197626cd6a5eb0eafc66afbb5bed.1630291682.git.me@ttaylorr.com>
References: <cover.1630291682.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630291682.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function is used to implement `pack-objects`'s `--keep-unreachable`
option, but can be simplified in a couple of ways:

  - add_objects_in_unpacked_packs() iterates over all packs (and then
    all packed objects) itself, but could use for_each_packed_object()
    instead since the missing flags necessary were added in the previous
    commit

  - objects are added to an in_pack array which store (off_t, object)
    tuples, and then sorted in offset order when we could iterate
    objects in offset order.

    There is a slight behavior change here: before we would have added
    objects in sorted offset order among _all_ packs. Handing objects to
    create_object_entry() in pack order for each pack (instead of
    feeding objects from all packs simultaneously their offset relative
    to different packs) is much more reasonable, if different than how
    the code currently works.

  - objects in a single pack are iterated in index order and searched
    for in order to discover their offsets, which is much less efficient
    than using the on-disk reverse index

Simplify the function by addressing each of the above and moving the
core of the loop into a callback function that we then pass to
for_each_packed_object() instead of open-coding the latter function
ourselves.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 84 ++++++++----------------------------------
 1 file changed, 16 insertions(+), 68 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index df49f656b9..87ddbd5553 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3505,79 +3505,27 @@ static void show_edge(struct commit *commit)
 	add_preferred_base(&commit->object.oid);
 }
 
-struct in_pack_object {
-	off_t offset;
-	struct object *object;
-};
-
-struct in_pack {
-	unsigned int alloc;
-	unsigned int nr;
-	struct in_pack_object *array;
-};
-
-static void mark_in_pack_object(struct object *object, struct packed_git *p, struct in_pack *in_pack)
+static int add_object_in_unpacked_pack(const struct object_id *oid,
+				       struct packed_git *pack,
+				       uint32_t pos,
+				       void *_data)
 {
-	in_pack->array[in_pack->nr].offset = find_pack_entry_one(object->oid.hash, p);
-	in_pack->array[in_pack->nr].object = object;
-	in_pack->nr++;
-}
-
-/*
- * Compare the objects in the offset order, in order to emulate the
- * "git rev-list --objects" output that produced the pack originally.
- */
-static int ofscmp(const void *a_, const void *b_)
-{
-	struct in_pack_object *a = (struct in_pack_object *)a_;
-	struct in_pack_object *b = (struct in_pack_object *)b_;
-
-	if (a->offset < b->offset)
-		return -1;
-	else if (a->offset > b->offset)
-		return 1;
-	else
-		return oidcmp(&a->object->oid, &b->object->oid);
+	struct object *obj = lookup_unknown_object(the_repository, oid);
+	if (obj->flags & OBJECT_ADDED)
+		return 0;
+	add_object_entry(oid, obj->type, "", 0);
+	obj->flags |= OBJECT_ADDED;
+	return 0;
 }
 
 static void add_objects_in_unpacked_packs(void)
 {
-	struct packed_git *p;
-	struct in_pack in_pack;
-	uint32_t i;
-
-	memset(&in_pack, 0, sizeof(in_pack));
-
-	for (p = get_all_packs(the_repository); p; p = p->next) {
-		struct object_id oid;
-		struct object *o;
-
-		if (!p->pack_local || p->pack_keep || p->pack_keep_in_core)
-			continue;
-		if (open_pack_index(p))
-			die(_("cannot open pack index"));
-
-		ALLOC_GROW(in_pack.array,
-			   in_pack.nr + p->num_objects,
-			   in_pack.alloc);
-
-		for (i = 0; i < p->num_objects; i++) {
-			nth_packed_object_id(&oid, p, i);
-			o = lookup_unknown_object(the_repository, &oid);
-			if (!(o->flags & OBJECT_ADDED))
-				mark_in_pack_object(o, p, &in_pack);
-			o->flags |= OBJECT_ADDED;
-		}
-	}
-
-	if (in_pack.nr) {
-		QSORT(in_pack.array, in_pack.nr, ofscmp);
-		for (i = 0; i < in_pack.nr; i++) {
-			struct object *o = in_pack.array[i].object;
-			add_object_entry(&o->oid, o->type, "", 0);
-		}
-	}
-	free(in_pack.array);
+	if (for_each_packed_object(add_object_in_unpacked_pack, NULL,
+				   FOR_EACH_OBJECT_PACK_ORDER |
+				   FOR_EACH_OBJECT_LOCAL_ONLY |
+				   FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS |
+				   FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS))
+		die(_("cannot open pack index"));
 }
 
 static int add_loose_object(const struct object_id *oid, const char *path,
-- 
2.33.0.96.g73915697e6

