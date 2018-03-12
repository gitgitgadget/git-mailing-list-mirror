Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD6131FAE4
	for <e@80x24.org>; Mon, 12 Mar 2018 17:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932592AbeCLRvS (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 13:51:18 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41026 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932231AbeCLRvR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 13:51:17 -0400
Received: by mail-lf0-f68.google.com with SMTP id m69-v6so24588530lfe.8
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 10:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1AHG9rLScSOo/jk/UbEOThB776SW6vO2dkarCTgnwys=;
        b=vU6s7+w8cX2tu5yOOZlD/SOeqBG03z0uye1n74q1yPwj9dSS28RJMJxZGQ93hWBVTC
         c8ShmQTIhV/LLbCr6w9CUSou+UMgSsMGStWXRqecx4H4pUMeVCte3z3W5C+ci38IoCw7
         T8W6Fgb/JXy01CcW9CjITMY9U1U61QFPnJDrMjKxnakwYTWYsQYqVNYQON/Go5SOJy4R
         Wd9MCqM/gg0XoVaaxm9+1KJhtjIh0gBsgz8Z6osEabPfCI/eyOxtRHd3Z2j0+6ZTBtJF
         MNfLNMG2hwpubcGA6fmSzp93t0B6RLbWWCaWyqm4ElioZBolyeOt+GSBrK1vkQEQFFIG
         0fJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1AHG9rLScSOo/jk/UbEOThB776SW6vO2dkarCTgnwys=;
        b=Whp2E1YX33P3ZsabJ1ZvTOnsoFWjOELmP+/fiPdVNnr2U4r04+egv52y14geVwUSZc
         d7U/bfGVBws1G+nZYvmaQv37fhvgOfdBaNZ0osNy8toJGvy6FV1co8KbksaB14nnJdHu
         KIK4HpE35eR7SItJurxm6IUBPDdJc5erTb3EWd7IRZR1GnkwRWyknBzIc76a979A3YlP
         zDB2bCsqVfu08prwztd1slPwGA72VJhX62/XK5/fO2MrXvWqBsHVVGwjxDRz84Uro2RE
         G1KNgFy+kkBIx5Q5KkMuz364ozr7deNFYhnpR/I0JLJGKLo/tWVK9EqEaPEvYJ+zk0FG
         YZnA==
X-Gm-Message-State: AElRT7GEGB9+SBCXqhIp/lIkDaDQ0VL6Q2bSGcqMk1WB9zSS4HJWLE6H
        KbNVIEttBGMq6uzadmMm0+o=
X-Google-Smtp-Source: AG47ELvjTN8TQZFmdf4EzYdQq7B1A1S8ChYvh/6IL3zx7hZo8jiubBfWI2nt/REct8x9RnXuoTyo3w==
X-Received: by 2002:a19:c1c8:: with SMTP id r191-v6mr218827lff.45.1520877075253;
        Mon, 12 Mar 2018 10:51:15 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h67-v6sm1899599lfb.80.2018.03.12.10.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Mar 2018 10:51:13 -0700 (PDT)
Date:   Mon, 12 Mar 2018 18:51:11 +0100
From:   Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH/RFC v3 02/12] pack-objects: turn type and in_pack_type to
 bitfields
Message-ID: <20180312175111.GA4842@duynguyen.home>
References: <20180303024706.31465-1-pclouds@gmail.com>
 <20180308114232.10508-1-pclouds@gmail.com>
 <20180308114232.10508-3-pclouds@gmail.com>
 <xmqqk1uk5076.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqk1uk5076.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 09, 2018 at 02:54:53PM -0800, Junio C Hamano wrote:
> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
> 
> > @@ -1570,7 +1576,7 @@ static void drop_reused_delta(struct object_entry *entry)
> >  	entry->depth = 0;
> >  
> >  	oi.sizep = &entry->size;
> > -	oi.typep = &entry->type;
> > +	oi.typep = &type;
> >  	if (packed_object_info(entry->in_pack, entry->in_pack_offset, &oi) < 0) {
> >  		/*
> >  		 * We failed to get the info from this pack for some reason;
> > @@ -1580,6 +1586,10 @@ static void drop_reused_delta(struct object_entry *entry)
> >  		 */
> >  		entry->type = sha1_object_info(entry->idx.oid.hash,
> >  					       &entry->size);
> 
> The comment immediately before this pre-context reads as such:
> 
> 		/*
> 		 * We failed to get the info from this pack for some reason;
> 		 * fall back to sha1_object_info, which may find another copy.
> 		 * And if that fails, the error will be recorded in entry->type
> 		 * and dealt with in prepare_pack().
> 		 */
> 
> The rest of the code relies on the ability of entry->type to record
> the error by storing an invalid (negative) type; otherwise, it cannot
> detect an error where (1) the entry in _this_ pack was corrupt, and
> (2) we wished to find another copy of the object elsewhere (which
> would overwrite the negative entry->type we assign here), but we
> didn't find any.
> 
> How should we propagate the error we found here down the control
> flow in this new code?

Good catch! I don't have any magic trick to do this, so I'm adding an
extra bit to store type validity. Something like this as a fixup patch
(I'll resend the whole series soon).

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index fd217cb51f..f164f1797b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -265,7 +265,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 	struct git_istream *st = NULL;
 
 	if (!usable_delta) {
-		if (entry->type == OBJ_BLOB &&
+		if (oe_type(entry) == OBJ_BLOB &&
 		    entry->size > big_file_threshold &&
 		    (st = open_istream(entry->idx.oid.hash, &type, &size, NULL)) != NULL)
 			buf = NULL;
@@ -371,7 +371,7 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 	struct pack_window *w_curs = NULL;
 	struct revindex_entry *revidx;
 	off_t offset;
-	enum object_type type = entry->type;
+	enum object_type type = oe_type(entry);
 	off_t datalen;
 	unsigned char header[MAX_PACK_OBJECT_HEADER],
 		      dheader[MAX_PACK_OBJECT_HEADER];
@@ -480,11 +480,12 @@ static off_t write_object(struct hashfile *f,
 		to_reuse = 0;	/* explicit */
 	else if (!entry->in_pack)
 		to_reuse = 0;	/* can't reuse what we don't have */
-	else if (entry->type == OBJ_REF_DELTA || entry->type == OBJ_OFS_DELTA)
+	else if (oe_type(entry) == OBJ_REF_DELTA ||
+		 oe_type(entry) == OBJ_OFS_DELTA)
 				/* check_object() decided it for us ... */
 		to_reuse = usable_delta;
 				/* ... but pack split may override that */
-	else if (entry->type != entry->in_pack_type)
+	else if (oe_type(entry) != entry->in_pack_type)
 		to_reuse = 0;	/* pack has delta which is unusable */
 	else if (entry->delta)
 		to_reuse = 0;	/* we want to pack afresh */
@@ -705,8 +706,8 @@ static struct object_entry **compute_write_order(void)
 	 * And then all remaining commits and tags.
 	 */
 	for (i = last_untagged; i < to_pack.nr_objects; i++) {
-		if (objects[i].type != OBJ_COMMIT &&
-		    objects[i].type != OBJ_TAG)
+		if (oe_type(&objects[i]) != OBJ_COMMIT &&
+		    oe_type(&objects[i]) != OBJ_TAG)
 			continue;
 		add_to_write_order(wo, &wo_end, &objects[i]);
 	}
@@ -715,7 +716,7 @@ static struct object_entry **compute_write_order(void)
 	 * And then all the trees.
 	 */
 	for (i = last_untagged; i < to_pack.nr_objects; i++) {
-		if (objects[i].type != OBJ_TREE)
+		if (oe_type(&objects[i]) != OBJ_TREE)
 			continue;
 		add_to_write_order(wo, &wo_end, &objects[i]);
 	}
@@ -1067,7 +1068,7 @@ static void create_object_entry(const struct object_id *oid,
 	entry = packlist_alloc(&to_pack, oid->hash, index_pos);
 	entry->hash = hash;
 	if (type)
-		entry->type = type;
+		oe_set_type(entry, type);
 	if (exclude)
 		entry->preferred_base = 1;
 	else
@@ -1433,9 +1434,9 @@ static void check_object(struct object_entry *entry)
 		switch (entry->in_pack_type) {
 		default:
 			/* Not a delta hence we've already got all we need. */
-			entry->type = entry->in_pack_type;
+			oe_set_type(entry, entry->in_pack_type);
 			entry->in_pack_header_size = used;
-			if (entry->type < OBJ_COMMIT || entry->type > OBJ_BLOB)
+			if (oe_type(entry) < OBJ_COMMIT || oe_type(entry) > OBJ_BLOB)
 				goto give_up;
 			unuse_pack(&w_curs);
 			return;
@@ -1489,7 +1490,7 @@ static void check_object(struct object_entry *entry)
 			 * deltify other objects against, in order to avoid
 			 * circular deltas.
 			 */
-			entry->type = entry->in_pack_type;
+			oe_set_type(entry, entry->in_pack_type);
 			entry->delta = base_entry;
 			entry->delta_size = entry->size;
 			entry->delta_sibling = base_entry->delta_child;
@@ -1498,7 +1499,7 @@ static void check_object(struct object_entry *entry)
 			return;
 		}
 
-		if (entry->type) {
+		if (oe_type(entry)) {
 			/*
 			 * This must be a delta and we already know what the
 			 * final object type is.  Let's extract the actual
@@ -1521,7 +1522,7 @@ static void check_object(struct object_entry *entry)
 		unuse_pack(&w_curs);
 	}
 
-	entry->type = sha1_object_info(entry->idx.oid.hash, &entry->size);
+	oe_set_type(entry, sha1_object_info(entry->idx.oid.hash, &entry->size));
 	/*
 	 * The error condition is checked in prepare_pack().  This is
 	 * to permit a missing preferred base object to be ignored
@@ -1584,12 +1585,10 @@ static void drop_reused_delta(struct object_entry *entry)
 		 * And if that fails, the error will be recorded in entry->type
 		 * and dealt with in prepare_pack().
 		 */
-		entry->type = sha1_object_info(entry->idx.oid.hash,
-					       &entry->size);
+		oe_set_type(entry, sha1_object_info(entry->idx.oid.hash,
+						    &entry->size));
 	} else {
-		if (type < 0)
-			die("BUG: invalid type %d", type);
-		entry->type = type;
+		oe_set_type(entry, type);
 	}
 }
 
@@ -1757,10 +1756,12 @@ static int type_size_sort(const void *_a, const void *_b)
 {
 	const struct object_entry *a = *(struct object_entry **)_a;
 	const struct object_entry *b = *(struct object_entry **)_b;
+	enum object_type a_type = oe_type(a);
+	enum object_type b_type = oe_type(b);
 
-	if (a->type > b->type)
+	if (a_type > b_type)
 		return -1;
-	if (a->type < b->type)
+	if (a_type < b_type)
 		return 1;
 	if (a->hash > b->hash)
 		return -1;
@@ -1836,7 +1837,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	void *delta_buf;
 
 	/* Don't bother doing diffs between different types */
-	if (trg_entry->type != src_entry->type)
+	if (oe_type(trg_entry) != oe_type(src_entry))
 		return -1;
 
 	/*
@@ -2442,11 +2443,11 @@ static void prepare_pack(int window, int depth)
 
 		if (!entry->preferred_base) {
 			nr_deltas++;
-			if (entry->type < 0)
+			if (oe_type(entry) < 0)
 				die("unable to get type of object %s",
 				    oid_to_hex(&entry->idx.oid));
 		} else {
-			if (entry->type < 0) {
+			if (oe_type(entry) < 0) {
 				/*
 				 * This object is not found, but we
 				 * don't have to include it anyway.
diff --git a/pack-objects.h b/pack-objects.h
index 3e5a89569a..90fbbc9394 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -58,8 +58,9 @@ struct object_entry {
 	void *delta_data;	/* cached delta (uncompressed) */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
 	unsigned long z_delta_size;	/* delta data size (compressed) */
-	unsigned type:TYPE_BITS;
+	unsigned type_:TYPE_BITS;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
+	unsigned type_valid:1;
 	uint32_t hash;			/* name hint hash */
 	unsigned int in_pack_pos;
 	unsigned char in_pack_header_size;
@@ -122,4 +123,19 @@ static inline uint32_t pack_name_hash(const char *name)
 	return hash;
 }
 
+static inline enum object_type oe_type(const struct object_entry *e)
+{
+	return e->type_valid ? e->type_ : OBJ_BAD;
+}
+
+static inline void oe_set_type(struct object_entry *e,
+			       enum object_type type)
+{
+	if (type >= OBJ_ANY)
+		die("BUG: OBJ_ANY cannot be set in pack-objects code");
+
+	e->type_valid = type >= 0;
+	e->type_ = (unsigned)type;
+}
+
 #endif
