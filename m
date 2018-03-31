Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BC9D1F424
	for <e@80x24.org>; Sat, 31 Mar 2018 10:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751509AbeCaKpu (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 06:45:50 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46900 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbeCaKps (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 06:45:48 -0400
Received: by mail-lf0-f67.google.com with SMTP id j68-v6so15167132lfg.13
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 03:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rhvzNA32oiPFmI5YUqlxYjJMh4TtNwdfyVK6sDjAI40=;
        b=ZzRWSp7qG3bzYZDA8XXyFMgyF31159G2YkNHQxkFi8TzMSwTqSTaeMSyOrIU9PtuFa
         Gvjg/OXMRd1tAmfFh08SF/qjtUlvZUsfWXtvYNTNv+JaMZroPQAPAjsagxvwchW4DVXe
         fM7JaHu861QnLecWQQ22kvmR6+OeG5PXKgdZVNAM8jYisBuQ2A5lmG9l8Lfo+eP7V31b
         gu/xI2IJ+DJDubsZFy7d2aVHknjV7OHwj9wm4cdTVzqFlmPaiVptwcG7Alfa2CulQ6Fq
         Rp+77XSj3j6JPMe/sCyzSjXBSh2qw1iNL78JI6I7iOfRXlz354KRX6OY67UmTIeVb/g0
         T2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rhvzNA32oiPFmI5YUqlxYjJMh4TtNwdfyVK6sDjAI40=;
        b=lnb1q5cSFvQfvckH+w+cKzzTIBZEThSleUpaNkiJJBNevUIFBxEixxMAsZGSajoT52
         4Z+Kv2kP1nkgGlZQ6m//YeKRvrY5PNQqDHeolU12I8yAFfU1xFFdZXgt7Np0mCb0CNvH
         JjAzLs2Qr7gFDNX2RYKmu171EY4ZlkrNjW8HNG0dKTMOCweTRzCROWhadn0Af6l7XfQR
         0dtLl3ZbB5BmHBXAkAQSLV8uJKMXNcIEqdbH2iUqlsQ2ZEaqgACyNv+mvdjGXEqUPLvE
         5Uf1Q2DraoDNXoSPzunhTvUaVtAQZESSG3XRSeP/yJdftLWtrLMhBjzz61F3YHtJf+tB
         RWkg==
X-Gm-Message-State: ALQs6tAVdyBo+19n7zpNOrjIYePbKmRJE76NZUSyurQQ6MQLXVGtcQjJ
        3y0dyk+waMQp8/r2JweE12I=
X-Google-Smtp-Source: AIpwx4+j+SuFNCH6T6OOGK3HS16yIIql/eLhFt1vcHDElU4ChBnTiaFghQdcArfH7Euuj6+4oWw2RQ==
X-Received: by 10.46.130.72 with SMTP id j8mr1591793ljh.89.1522493146795;
        Sat, 31 Mar 2018 03:45:46 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t81-v6sm2029272lff.81.2018.03.31.03.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Mar 2018 03:45:46 -0700 (PDT)
Date:   Sat, 31 Mar 2018 12:45:44 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 06/13] pack-objects: move in_pack out of struct
 object_entry
Message-ID: <20180331104544.GA16426@duynguyen.home>
References: <20180318142526.9378-1-pclouds@gmail.com>
 <20180324063353.24722-1-pclouds@gmail.com>
 <20180324063353.24722-7-pclouds@gmail.com>
 <20180330204812.GE14782@sigill.intra.peff.net>
 <CACsJy8Dma-xrDcK1vQ-s4F+Dwt4oWOQ89yr33OPJdO1g0ryQWw@mail.gmail.com>
 <20180331102007.GC32290@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180331102007.GC32290@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 31, 2018 at 06:20:07AM -0400, Jeff King wrote:
> On Sat, Mar 31, 2018 at 06:51:10AM +0200, Duy Nguyen wrote:
> 
> > >> +#define IN_PACK(obj) oe_in_pack(&to_pack, obj)
> > >
> > > How come this one gets a macro, but the earlier conversions don't?
> > >
> > > I guess the problem is that oe_in_pack() is defined in the generic
> > > pack-objects.h, but &to_pack is only in builtin/pack-objects.c?
> > >
> > > I wonder if it would be that bad to just say oe_in_pack(&to_pack, obj)
> > > everywhere. It's longer, but it makes the code slightly less magical to
> > > read.
> > 
> > Longer was exactly why I added these macros (with the hope that the
> > macro upper case names already ring a "it's magical" bell). Should I
> > drop all these macros? Some code becomes a lot more verbose though.
> 
> I'm on the fence. I agree that the macro screams "magical". I just
> sometimes see a macro and think something really weird and
> unfunction-like is going on. But really we're just replacing a default
> parameter.
> 
> So I dunno. If you get rid of the macros and I look at it, I give even
> odds that I'll say "yech, put them back!". :)

It would look like this (on top of v8). I think the "&to_pack" part is
most distracting when it's used as part of an expression (or a
function argument). I probably went overboard with SET_ macros though.

-- 8< --
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b5bba2c228..dec849b755 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -29,18 +29,6 @@
 #include "list.h"
 #include "packfile.h"
 
-#define IN_PACK(obj) oe_in_pack(&to_pack, obj)
-#define SIZE(obj) oe_size(&to_pack, obj)
-#define SET_SIZE(obj,size) oe_set_size(&to_pack, obj, size)
-#define DELTA_SIZE(obj) oe_delta_size(&to_pack, obj)
-#define DELTA(obj) oe_delta(&to_pack, obj)
-#define DELTA_CHILD(obj) oe_delta_child(&to_pack, obj)
-#define DELTA_SIBLING(obj) oe_delta_sibling(&to_pack, obj)
-#define SET_DELTA(obj, val) oe_set_delta(&to_pack, obj, val)
-#define SET_DELTA_SIZE(obj, val) oe_set_delta_size(&to_pack, obj, val)
-#define SET_DELTA_CHILD(obj, val) oe_set_delta_child(&to_pack, obj, val)
-#define SET_DELTA_SIBLING(obj, val) oe_set_delta_sibling(&to_pack, obj, val)
-
 static const char *pack_usage[] = {
 	N_("git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]"),
 	N_("git pack-objects [<options>...] <base-name> [< <ref-list> | < <object-list>]"),
@@ -137,14 +125,14 @@ static void *get_delta(struct object_entry *entry)
 	buf = read_sha1_file(entry->idx.oid.hash, &type, &size);
 	if (!buf)
 		die("unable to read %s", oid_to_hex(&entry->idx.oid));
-	base_buf = read_sha1_file(DELTA(entry)->idx.oid.hash, &type,
+	base_buf = read_sha1_file(oe_delta(&to_pack, entry)->idx.oid.hash, &type,
 				  &base_size);
 	if (!base_buf)
 		die("unable to read %s",
-		    oid_to_hex(&DELTA(entry)->idx.oid));
+		    oid_to_hex(&oe_delta(&to_pack, entry)->idx.oid));
 	delta_buf = diff_delta(base_buf, base_size,
 			       buf, size, &delta_size, 0);
-	if (!delta_buf || delta_size != DELTA_SIZE(entry))
+	if (!delta_buf || delta_size != oe_delta_size(&to_pack, entry))
 		die("delta size changed");
 	free(buf);
 	free(base_buf);
@@ -295,15 +283,15 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 		FREE_AND_NULL(entry->delta_data);
 		entry->z_delta_size = 0;
 	} else if (entry->delta_data) {
-		size = DELTA_SIZE(entry);
+		size = oe_delta_size(&to_pack, entry);
 		buf = entry->delta_data;
 		entry->delta_data = NULL;
-		type = (allow_ofs_delta && DELTA(entry)->idx.offset) ?
+		type = (allow_ofs_delta && oe_delta(&to_pack, entry)->idx.offset) ?
 			OBJ_OFS_DELTA : OBJ_REF_DELTA;
 	} else {
 		buf = get_delta(entry);
-		size = DELTA_SIZE(entry);
-		type = (allow_ofs_delta && DELTA(entry)->idx.offset) ?
+		size = oe_delta_size(&to_pack, entry);
+		type = (allow_ofs_delta && oe_delta(&to_pack, entry)->idx.offset) ?
 			OBJ_OFS_DELTA : OBJ_REF_DELTA;
 	}
 
@@ -327,7 +315,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 		 * encoding of the relative offset for the delta
 		 * base from this object's position in the pack.
 		 */
-		off_t ofs = entry->idx.offset - DELTA(entry)->idx.offset;
+		off_t ofs = entry->idx.offset - oe_delta(&to_pack, entry)->idx.offset;
 		unsigned pos = sizeof(dheader) - 1;
 		dheader[pos] = ofs & 127;
 		while (ofs >>= 7)
@@ -353,7 +341,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 			return 0;
 		}
 		hashwrite(f, header, hdrlen);
-		hashwrite(f, DELTA(entry)->idx.oid.hash, 20);
+		hashwrite(f, oe_delta(&to_pack, entry)->idx.oid.hash, 20);
 		hdrlen += 20;
 	} else {
 		if (limit && hdrlen + datalen + 20 >= limit) {
@@ -379,7 +367,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 				unsigned long limit, int usable_delta)
 {
-	struct packed_git *p = IN_PACK(entry);
+	struct packed_git *p = oe_in_pack(&to_pack, entry);
 	struct pack_window *w_curs = NULL;
 	struct revindex_entry *revidx;
 	off_t offset;
@@ -388,10 +376,10 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 	unsigned char header[MAX_PACK_OBJECT_HEADER],
 		      dheader[MAX_PACK_OBJECT_HEADER];
 	unsigned hdrlen;
-	unsigned long entry_size = SIZE(entry);
+	unsigned long entry_size = oe_size(&to_pack, entry);
 
-	if (DELTA(entry))
-		type = (allow_ofs_delta && DELTA(entry)->idx.offset) ?
+	if (oe_delta(&to_pack, entry))
+		type = (allow_ofs_delta && oe_delta(&to_pack, entry)->idx.offset) ?
 			OBJ_OFS_DELTA : OBJ_REF_DELTA;
 	hdrlen = encode_in_pack_object_header(header, sizeof(header),
 					      type, entry_size);
@@ -419,7 +407,7 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 	}
 
 	if (type == OBJ_OFS_DELTA) {
-		off_t ofs = entry->idx.offset - DELTA(entry)->idx.offset;
+		off_t ofs = entry->idx.offset - oe_delta(&to_pack, entry)->idx.offset;
 		unsigned pos = sizeof(dheader) - 1;
 		dheader[pos] = ofs & 127;
 		while (ofs >>= 7)
@@ -438,7 +426,7 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 			return 0;
 		}
 		hashwrite(f, header, hdrlen);
-		hashwrite(f, DELTA(entry)->idx.oid.hash, 20);
+		hashwrite(f, oe_delta(&to_pack, entry)->idx.oid.hash, 20);
 		hdrlen += 20;
 		reused_delta++;
 	} else {
@@ -478,20 +466,20 @@ static off_t write_object(struct hashfile *f,
 	else
 		limit = pack_size_limit - write_offset;
 
-	if (!DELTA(entry))
+	if (!oe_delta(&to_pack, entry))
 		usable_delta = 0;	/* no delta */
 	else if (!pack_size_limit)
 	       usable_delta = 1;	/* unlimited packfile */
-	else if (DELTA(entry)->idx.offset == (off_t)-1)
+	else if (oe_delta(&to_pack, entry)->idx.offset == (off_t)-1)
 		usable_delta = 0;	/* base was written to another pack */
-	else if (DELTA(entry)->idx.offset)
+	else if (oe_delta(&to_pack, entry)->idx.offset)
 		usable_delta = 1;	/* base already exists in this pack */
 	else
 		usable_delta = 0;	/* base could end up in another pack */
 
 	if (!reuse_object)
 		to_reuse = 0;	/* explicit */
-	else if (!IN_PACK(entry))
+	else if (!oe_in_pack(&to_pack, entry))
 		to_reuse = 0;	/* can't reuse what we don't have */
 	else if (oe_type(entry) == OBJ_REF_DELTA ||
 		 oe_type(entry) == OBJ_OFS_DELTA)
@@ -500,7 +488,7 @@ static off_t write_object(struct hashfile *f,
 				/* ... but pack split may override that */
 	else if (oe_type(entry) != entry->in_pack_type)
 		to_reuse = 0;	/* pack has delta which is unusable */
-	else if (DELTA(entry))
+	else if (oe_delta(&to_pack, entry))
 		to_reuse = 0;	/* we want to pack afresh */
 	else
 		to_reuse = 1;	/* we have it in-pack undeltified,
@@ -552,12 +540,12 @@ static enum write_one_status write_one(struct hashfile *f,
 	}
 
 	/* if we are deltified, write out base object first. */
-	if (DELTA(e)) {
+	if (oe_delta(&to_pack, e)) {
 		e->idx.offset = 1; /* now recurse */
-		switch (write_one(f, DELTA(e), offset)) {
+		switch (write_one(f, oe_delta(&to_pack, e), offset)) {
 		case WRITE_ONE_RECURSIVE:
 			/* we cannot depend on this one */
-			SET_DELTA(e, NULL);
+			oe_set_delta(&to_pack, e, NULL);
 			break;
 		default:
 			break;
@@ -619,34 +607,34 @@ static void add_descendants_to_write_order(struct object_entry **wo,
 			/* add this node... */
 			add_to_write_order(wo, endp, e);
 			/* all its siblings... */
-			for (s = DELTA_SIBLING(e); s; s = DELTA_SIBLING(s)) {
+			for (s = oe_delta_sibling(&to_pack, e); s; s = oe_delta_sibling(&to_pack, s)) {
 				add_to_write_order(wo, endp, s);
 			}
 		}
 		/* drop down a level to add left subtree nodes if possible */
-		if (DELTA_CHILD(e)) {
+		if (oe_delta_child(&to_pack, e)) {
 			add_to_order = 1;
-			e = DELTA_CHILD(e);
+			e = oe_delta_child(&to_pack, e);
 		} else {
 			add_to_order = 0;
 			/* our sibling might have some children, it is next */
-			if (DELTA_SIBLING(e)) {
-				e = DELTA_SIBLING(e);
+			if (oe_delta_sibling(&to_pack, e)) {
+				e = oe_delta_sibling(&to_pack, e);
 				continue;
 			}
 			/* go back to our parent node */
-			e = DELTA(e);
-			while (e && !DELTA_SIBLING(e)) {
+			e = oe_delta(&to_pack, e);
+			while (e && !oe_delta_sibling(&to_pack, e)) {
 				/* we're on the right side of a subtree, keep
 				 * going up until we can go right again */
-				e = DELTA(e);
+				e = oe_delta(&to_pack, e);
 			}
 			if (!e) {
 				/* done- we hit our original root node */
 				return;
 			}
 			/* pass it off to sibling at this level */
-			e = DELTA_SIBLING(e);
+			e = oe_delta_sibling(&to_pack, e);
 		}
 	};
 }
@@ -657,7 +645,7 @@ static void add_family_to_write_order(struct object_entry **wo,
 {
 	struct object_entry *root;
 
-	for (root = e; DELTA(root); root = DELTA(root))
+	for (root = e; oe_delta(&to_pack, root); root = oe_delta(&to_pack, root))
 		; /* nothing */
 	add_descendants_to_write_order(wo, endp, root);
 }
@@ -672,8 +660,8 @@ static struct object_entry **compute_write_order(void)
 	for (i = 0; i < to_pack.nr_objects; i++) {
 		objects[i].tagged = 0;
 		objects[i].filled = 0;
-		SET_DELTA_CHILD(&objects[i], NULL);
-		SET_DELTA_SIBLING(&objects[i], NULL);
+		oe_set_delta_child(&to_pack, &objects[i], NULL);
+		oe_set_delta_size(&to_pack, &objects[i], NULL);
 	}
 
 	/*
@@ -683,11 +671,11 @@ static struct object_entry **compute_write_order(void)
 	 */
 	for (i = to_pack.nr_objects; i > 0;) {
 		struct object_entry *e = &objects[--i];
-		if (!DELTA(e))
+		if (!oe_delta(&to_pack, e))
 			continue;
 		/* Mark me as the first child */
-		e->delta_sibling_idx = DELTA(e)->delta_child_idx;
-		SET_DELTA_CHILD(DELTA(e), e);
+		e->delta_sibling_idx = oe_delta(&to_pack, e)->delta_child_idx;
+		oe_set_delta_child(&to_pack, oe_delta(&to_pack, e), e);
 	}
 
 	/*
@@ -1414,8 +1402,8 @@ static void check_object(struct object_entry *entry)
 {
 	unsigned long canonical_size;
 
-	if (IN_PACK(entry)) {
-		struct packed_git *p = IN_PACK(entry);
+	if (oe_in_pack(&to_pack, entry)) {
+		struct packed_git *p = oe_in_pack(&to_pack, entry);
 		struct pack_window *w_curs = NULL;
 		const unsigned char *base_ref = NULL;
 		struct object_entry *base_entry;
@@ -1451,7 +1439,7 @@ static void check_object(struct object_entry *entry)
 		default:
 			/* Not a delta hence we've already got all we need. */
 			oe_set_type(entry, entry->in_pack_type);
-			SET_SIZE(entry, in_pack_size);
+			oe_set_size(&to_pack, entry, in_pack_size);
 			entry->in_pack_header_size = used;
 			if (oe_type(entry) < OBJ_COMMIT || oe_type(entry) > OBJ_BLOB)
 				goto give_up;
@@ -1508,11 +1496,11 @@ static void check_object(struct object_entry *entry)
 			 * circular deltas.
 			 */
 			oe_set_type(entry, entry->in_pack_type);
-			SET_SIZE(entry, in_pack_size); /* delta size */
-			SET_DELTA(entry, base_entry);
-			SET_DELTA_SIZE(entry, in_pack_size);
+			oe_set_size(&to_pack, entry, in_pack_size); /* delta size */
+			oe_set_delta(&to_pack, entry, base_entry);
+			oe_set_delta_size(&to_pack, entry, in_pack_size);
 			entry->delta_sibling_idx = base_entry->delta_child_idx;
-			SET_DELTA_CHILD(base_entry, entry);
+			oe_set_delta_child(&to_pack, base_entry, entry);
 			unuse_pack(&w_curs);
 			return;
 		}
@@ -1529,7 +1517,7 @@ static void check_object(struct object_entry *entry)
 			canonical_size = get_size_from_delta(p, &w_curs, delta_pos);
 			if (canonical_size == 0)
 				goto give_up;
-			SET_SIZE(entry, canonical_size);
+			oe_set_size(&to_pack, entry, canonical_size);
 			unuse_pack(&w_curs);
 			return;
 		}
@@ -1546,7 +1534,7 @@ static void check_object(struct object_entry *entry)
 	oe_set_type(entry, sha1_object_info(entry->idx.oid.hash,
 					    &canonical_size));
 	if (entry->type_valid) {
-		SET_SIZE(entry, canonical_size);
+		oe_set_size(&to_pack, entry, canonical_size);
 	} else {
 		/*
 		 * Bad object type is checked in prepare_pack().  This is
@@ -1561,8 +1549,8 @@ static int pack_offset_sort(const void *_a, const void *_b)
 {
 	const struct object_entry *a = *(struct object_entry **)_a;
 	const struct object_entry *b = *(struct object_entry **)_b;
-	const struct packed_git *a_in_pack = IN_PACK(a);
-	const struct packed_git *b_in_pack = IN_PACK(b);
+	const struct packed_git *a_in_pack = oe_in_pack(&to_pack, a);
+	const struct packed_git *b_in_pack = oe_in_pack(&to_pack, b);
 
 	/* avoid filesystem trashing with loose objects */
 	if (!a_in_pack && !b_in_pack)
@@ -1604,12 +1592,12 @@ static void drop_reused_delta(struct object_entry *entry)
 		else
 			idx = &oe->delta_sibling_idx;
 	}
-	SET_DELTA(entry, NULL);
+	oe_set_delta(&to_pack, entry, NULL);
 	entry->depth = 0;
 
 	oi.sizep = &size;
 	oi.typep = &type;
-	if (packed_object_info(IN_PACK(entry), entry->in_pack_offset, &oi) < 0) {
+	if (packed_object_info(oe_in_pack(&to_pack, entry), entry->in_pack_offset, &oi) < 0) {
 		/*
 		 * We failed to get the info from this pack for some reason;
 		 * fall back to sha1_object_info, which may find another copy.
@@ -1621,7 +1609,7 @@ static void drop_reused_delta(struct object_entry *entry)
 	} else {
 		oe_set_type(entry, type);
 	}
-	SET_SIZE(entry, size);
+	oe_set_size(&to_pack, entry, size);
 }
 
 /*
@@ -1645,7 +1633,7 @@ static void break_delta_chains(struct object_entry *entry)
 
 	for (cur = entry, total_depth = 0;
 	     cur;
-	     cur = DELTA(cur), total_depth++) {
+	     cur = oe_delta(&to_pack, cur), total_depth++) {
 		if (cur->dfs_state == DFS_DONE) {
 			/*
 			 * We've already seen this object and know it isn't
@@ -1670,7 +1658,7 @@ static void break_delta_chains(struct object_entry *entry)
 		 * it's not a delta, we're done traversing, but we'll mark it
 		 * done to save time on future traversals.
 		 */
-		if (!DELTA(cur)) {
+		if (!oe_delta(&to_pack, cur)) {
 			cur->dfs_state = DFS_DONE;
 			break;
 		}
@@ -1693,7 +1681,7 @@ static void break_delta_chains(struct object_entry *entry)
 		 * We keep all commits in the chain that we examined.
 		 */
 		cur->dfs_state = DFS_ACTIVE;
-		if (DELTA(cur)->dfs_state == DFS_ACTIVE) {
+		if (oe_delta(&to_pack, cur)->dfs_state == DFS_ACTIVE) {
 			drop_reused_delta(cur);
 			cur->dfs_state = DFS_DONE;
 			break;
@@ -1708,7 +1696,7 @@ static void break_delta_chains(struct object_entry *entry)
 	 * an extra "next" pointer to keep going after we reset cur->delta.
 	 */
 	for (cur = entry; cur; cur = next) {
-		next = DELTA(cur);
+		next = oe_delta(&to_pack, cur);
 
 		/*
 		 * We should have a chain of zero or more ACTIVE states down to
@@ -1791,8 +1779,8 @@ static int type_size_sort(const void *_a, const void *_b)
 	const struct object_entry *b = *(struct object_entry **)_b;
 	enum object_type a_type = oe_type(a);
 	enum object_type b_type = oe_type(b);
-	unsigned long a_size = SIZE(a);
-	unsigned long b_size = SIZE(b);
+	unsigned long a_size = oe_size(&to_pack, a);
+	unsigned long b_size = oe_size(&to_pack, b);
 
 	if (a_type > b_type)
 		return -1;
@@ -1923,8 +1911,8 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	 * it, we will still save the transfer cost, as we already know
 	 * the other side has it and we won't send src_entry at all.
 	 */
-	if (reuse_delta && IN_PACK(trg_entry) &&
-	    IN_PACK(trg_entry) == IN_PACK(src_entry) &&
+	if (reuse_delta && oe_in_pack(&to_pack, trg_entry) &&
+	    oe_in_pack(&to_pack, trg_entry) == oe_in_pack(&to_pack, src_entry) &&
 	    !src_entry->preferred_base &&
 	    trg_entry->in_pack_type != OBJ_REF_DELTA &&
 	    trg_entry->in_pack_type != OBJ_OFS_DELTA)
@@ -1935,19 +1923,19 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		return 0;
 
 	/* Now some size filtering heuristics. */
-	trg_size = SIZE(trg_entry);
-	if (!DELTA(trg_entry)) {
+	trg_size = oe_size(&to_pack, trg_entry);
+	if (!oe_delta(&to_pack, trg_entry)) {
 		max_size = trg_size/2 - 20;
 		ref_depth = 1;
 	} else {
-		max_size = DELTA_SIZE(trg_entry);
+		max_size = oe_delta_size(&to_pack, trg_entry);
 		ref_depth = trg->depth;
 	}
 	max_size = (uint64_t)max_size * (max_depth - src->depth) /
 						(max_depth - ref_depth + 1);
 	if (max_size == 0)
 		return 0;
-	src_size = SIZE(src_entry);
+	src_size = oe_size(&to_pack, src_entry);
 	sizediff = src_size < trg_size ? trg_size - src_size : 0;
 	if (sizediff >= max_size)
 		return 0;
@@ -2016,9 +2004,9 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		return 0;
 	}
 
-	if (DELTA(trg_entry)) {
+	if (oe_delta(&to_pack, trg_entry)) {
 		/* Prefer only shallower same-sized deltas. */
-		if (delta_size == DELTA_SIZE(trg_entry) &&
+		if (delta_size == oe_delta_size(&to_pack, trg_entry) &&
 		    src->depth + 1 >= trg->depth) {
 			free(delta_buf);
 			return 0;
@@ -2033,7 +2021,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	free(trg_entry->delta_data);
 	cache_lock();
 	if (trg_entry->delta_data) {
-		delta_cache_size -= DELTA_SIZE(trg_entry);
+		delta_cache_size -= oe_delta_size(&to_pack, trg_entry);
 		trg_entry->delta_data = NULL;
 	}
 	if (delta_cacheable(src_size, trg_size, delta_size)) {
@@ -2045,8 +2033,8 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		free(delta_buf);
 	}
 
-	SET_DELTA(trg_entry, src_entry);
-	SET_DELTA_SIZE(trg_entry, delta_size);
+	oe_set_delta(&to_pack, trg_entry, src_entry);
+	oe_set_delta_size(&to_pack, trg_entry, delta_size);
 	trg->depth = src->depth + 1;
 
 	return 1;
@@ -2054,13 +2042,13 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 
 static unsigned int check_delta_limit(struct object_entry *me, unsigned int n)
 {
-	struct object_entry *child = DELTA_CHILD(me);
+	struct object_entry *child = oe_delta_child(&to_pack, me);
 	unsigned int m = n;
 	while (child) {
 		unsigned int c = check_delta_limit(child, n + 1);
 		if (m < c)
 			m = c;
-		child = DELTA_SIBLING(child);
+		child = oe_delta_sibling(&to_pack, child);
 	}
 	return m;
 }
@@ -2071,7 +2059,7 @@ static unsigned long free_unpacked(struct unpacked *n)
 	free_delta_index(n->index);
 	n->index = NULL;
 	if (n->data) {
-		freed_mem += SIZE(n->entry);
+		freed_mem += oe_size(&to_pack, n->entry);
 		FREE_AND_NULL(n->data);
 	}
 	n->entry = NULL;
@@ -2129,7 +2117,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 		 * otherwise they would become too deep.
 		 */
 		max_depth = depth;
-		if (DELTA_CHILD(entry)) {
+		if (oe_delta_child(&to_pack, entry)) {
 			max_depth -= check_delta_limit(entry, 0);
 			if (max_depth <= 0)
 				goto next;
@@ -2169,11 +2157,11 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 		if (entry->delta_data && !pack_to_stdout) {
 			unsigned long size;
 
-			size = do_compress(&entry->delta_data, DELTA_SIZE(entry));
+			size = do_compress(&entry->delta_data, oe_delta_size(&to_pack, entry));
 			if (size < (1U << OE_Z_DELTA_BITS)) {
 				entry->z_delta_size = size;
 				cache_lock();
-				delta_cache_size -= DELTA_SIZE(entry);
+				delta_cache_size -= oe_delta_size(&to_pack, entry);
 				delta_cache_size += entry->z_delta_size;
 				cache_unlock();
 			} else {
@@ -2186,7 +2174,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 		 * depth, leaving it in the window is pointless.  we
 		 * should evict it first.
 		 */
-		if (DELTA(entry) && max_depth <= n->depth)
+		if (oe_delta(&to_pack, entry) && max_depth <= n->depth)
 			continue;
 
 		/*
@@ -2194,7 +2182,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 		 * currently deltified object, to keep it longer.  It will
 		 * be the first base object to be attempted next.
 		 */
-		if (DELTA(entry)) {
+		if (oe_delta(&to_pack, entry)) {
 			struct unpacked swap = array[best_base];
 			int dist = (window + idx - best_base) % window;
 			int dst = best_base;
@@ -2515,7 +2503,7 @@ static void prepare_pack(int window, int depth)
 	for (i = 0; i < to_pack.nr_objects; i++) {
 		struct object_entry *entry = to_pack.objects + i;
 
-		if (DELTA(entry))
+		if (oe_delta(&to_pack, entry))
 			/* This happens if we decided to reuse existing
 			 * delta from a pack.  "reuse_delta &&" is implied.
 			 */
-- 8< --
