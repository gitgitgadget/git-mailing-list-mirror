Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99383546C2
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 01:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790731733; cv=none; b=u58JnrbzrFEJcxJKeGaxEvFaHCHM6sjkqza8yNIdTmh0EZf5R2Hr/lnmFkM2ffSv2QwPMmxk7oGDDB3PgK74bwnyOwYTrrHgmT79KQTd4zlf92s+cpW994rgRvw66J4Dk6sYeWKec62V9JWeFTxSLRbXa/RwmIL/+r68MKVDaMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790731733; c=relaxed/simple;
	bh=osC/f9k/I7M038sQvfal3X9tYvd9zDpXm8GajseEOys=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Can4LYH6ZYtXunYAdC8Ru4OhOO97Z+HtvzeDCjBIC8HOnx6w20awMe9vNTeCAygB9+Xd6lPbKJe1oohWISwgu5LIFFYqP6x6MIsxV72zA7OsGWTFX5emsCoVhnsQr3NW4bEeHRPRx9KiWQccQr/lZSCqoCLODHNwqX90B26lhiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=F0X7wAC8; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="F0X7wAC8"
Received: by mail-oo2-f42.google.com with SMTP id 006d021491bc7-6d78c92b8f1so2021971eaf.2
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 18:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790731728; x=1791336528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3itDJ0KVedWYb2+SHMXXs+Ep3lN2A7hxF2u4lvkCIBs=;
        b=F0X7wAC8Q8NIzV3e63l8RYU0L2DZFwV7N1BMo0jHXE7lqkhQzBtQY/fopI4TLBGIML
         gWJB1hC/+/RlaPmZRRfSJDzqZJWPuwpEKh9/Jsn+pNjC/zMbpA8oy3J6473sTGMeeeIJ
         8uCKs5jqm/Lqi2ume7nH8VVa/7P6b9IPjxrfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790731728; x=1791336528;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3itDJ0KVedWYb2+SHMXXs+Ep3lN2A7hxF2u4lvkCIBs=;
        b=zcv90UFYXJcRLRbFMXBimsVdecvXZzTgnzgstiGcUFm7w5NSb28Vjav6999kMQQsVK
         30J+y+xJHuKoDy0ZJeAhWBQXoldNiWIhrRuUUoDhURBWpanOuZq7Rluxv4yh+K4htCRT
         SX0R2D4ZJMEPsB8Dw9Eb5mPuKCLhlQ5ktsqE1Rhn0uzym7blrR02RVK6z2nFpaCz1nZ5
         xTIH4RLFw67XIDkMt1YMe9Hsz6accaYV2M21x7f0FD5a8+rb/eUSXZYS0yXOp5Tv8w+Q
         pQBEnjRHBO+RCOGZYFCMgGnsSi4ZR351t4jlAwr5uWDgfdD9K7NNxMpBndCOPwMqWcw7
         +/BQ==
X-Gm-Message-State: AFuF++mMsMnPPFAAL29IioEsQNXJ1UYZUJz7EjZES26tZFyoe8+WJ6Ub
	nTtBDvGuZ3eBl4cjW5gnPmMidG6UeYbRebwxDyBA4utcBq/78DzYE8XdaguuVrxMdEJOYbCNOlW
	BHACwkyc=
X-Gm-Gg: AYBFou29V/8IDl4NmiVD/GferRICX7KVqw5XYDmMcy9UWp67Mb/dW5Joh5PlpPWQd1I
	eB72YT+wKsplwMe/t7PYP3No849Kb3VMBcd5foTXUNbbXSK9CT2So7kjkFDg2Qi/ePxQB1kjztP
	z6F588TVDyf5XhEBcVXnZiIeM+lm8fwpA+uG8dqIEbh+Egi8TvhPXifsj/6jZV+JRgnc1T5UBgL
	2t335bFlJZmLVLgW/egVlwOEeQ/xOZtrFC2jkN/Ah/I5EnxDQEoW1lS8/s4Zqe03nFF3ejIAqbw
	+zQ0T0zPqDj6NmfBNLZ6X7aTbTY4tYdx9F3bVQ4Ew9s+DVUJmpvyHnoiXwa2yQz8H4mzUpARJYe
	WFbo3Bkxgx+j9nknVpmvAiw96rvkqiZWfnxIgKp8arbnB9//bVEcjxaEw8Rj1DmmpDsTplaEzxn
	xfCPUMYpITFAHX+CK3M88cbIoKFblWgnWNIdnREm4jl6w7lufSJRtqxoDotBU6nN7bW5Rq7Sqj7
	VhdP3Aw75s5FTvhkzzE/mle3v/MLRaH13EX/hXv3BB8NpE3mrvU1bLku6nFFN0MaYwAt5+McH4x
	cO6NlCQe
X-Received: by 2002:a05:6820:290c:b0:6dc:7dc3:387b with SMTP id 006d021491bc7-6dc7dc34159mr908625eaf.25.1790731728535;
        Tue, 29 Sep 2026 18:28:48 -0700 (PDT)
Received: from com-79390 (vpn-centralus-01.tradc-corp.com. [172.169.249.3])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49dd14980e3sm989304fac.16.2026.09.29.18.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 18:28:48 -0700 (PDT)
From: Taylor Blau <ttaylorr@openai.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date: Tue, 29 Sep 2026 20:28:45 -0500
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: [PATCH 1/4] pack-objects: introduce `stdin_packs_context` struct
Message-ID: <64bb13e2db2e5c22e842c188e08861d63e99dc77.1790731662.git.me@ttaylorr.com>
References: <cover.1790731662.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1790731662.git.me@ttaylorr.com>

`stdin_packs_read_input()` currently receives a pointer to the
`rev_info` struct and '--stdin-packs' mode separately as arguments, but
the object enumeration callbacks only receive a pointer to the
`rev_info` struct.

Wrap the pair in a new `stdin_packs_context` struct so that a future
change may reference the '--stdin-packs' mode within the various
object enumeration callbacks.

Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
 builtin/pack-objects.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index af9390a46b9..01adf80a2bc 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3804,11 +3804,17 @@ static int git_pack_config(const char *k, const char *v,
 static int stdin_packs_found_nr;
 static int stdin_packs_hints_nr;
 
+struct stdin_packs_context {
+	struct rev_info *revs;
+	enum stdin_packs_mode mode;
+};
+
 static int add_object_entry_from_pack(const struct object_id *oid,
 				      struct packed_git *p,
 				      uint32_t pos,
 				      void *_data)
 {
+	struct stdin_packs_context *ctx = _data;
 	off_t ofs;
 	struct object_info oi = OBJECT_INFO_INIT;
 	enum object_type type = OBJ_NONE;
@@ -3827,7 +3833,6 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 		die(_("could not get type of object %s in pack %s"),
 		    oid_to_hex(oid), p->pack_name);
 	} else if (type == OBJ_COMMIT) {
-		struct rev_info *revs = _data;
 		/*
 		 * commits in included packs are used as starting points
 		 * for the subsequent revision walk
@@ -3840,7 +3845,7 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 		 * However, we'll only add those objects to the packing
 		 * list after checking `want_object_in_pack()` below.
 		 */
-		add_pending_oid(revs, NULL, oid, 0);
+		add_pending_oid(ctx->revs, NULL, oid, 0);
 	}
 
 	if (!want_object_in_pack(oid, 0, &p, &ofs))
@@ -3954,8 +3959,9 @@ static int stdin_packs_include_check(struct commit *commit, void *data)
 }
 
 static void stdin_packs_add_pack_entries(struct strmap *packs,
-					 struct rev_info *revs)
+					 struct stdin_packs_context *ctx)
 {
+	struct rev_info *revs = ctx->revs;
 	struct string_list keys = STRING_LIST_INIT_NODUP;
 	struct string_list_item *item;
 	struct hashmap_iter iter;
@@ -3994,15 +4000,14 @@ static void stdin_packs_add_pack_entries(struct strmap *packs,
 		    (info->kind & STDIN_PACK_EXCLUDE_OPEN))
 			for_each_object_in_pack(info->p,
 						add_object_entry_from_pack,
-						revs,
+						ctx,
 						ODB_FOR_EACH_OBJECT_PACK_ORDER);
 	}
 
 	string_list_clear(&keys, 0);
 }
 
-static void stdin_packs_read_input(struct rev_info *revs,
-				   enum stdin_packs_mode mode)
+static void stdin_packs_read_input(struct stdin_packs_context *ctx)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strmap packs = STRMAP_INIT;
@@ -4017,7 +4022,7 @@ static void stdin_packs_read_input(struct rev_info *revs,
 			continue;
 		else if (*key == '^')
 			kind = STDIN_PACK_EXCLUDE_CLOSED;
-		else if (*key == '!' && mode == STDIN_PACKS_MODE_FOLLOW)
+		else if (*key == '!' && ctx->mode == STDIN_PACKS_MODE_FOLLOW)
 			kind = STDIN_PACK_EXCLUDE_OPEN;
 
 		if (kind != STDIN_PACK_INCLUDE)
@@ -4082,19 +4087,23 @@ static void stdin_packs_read_input(struct rev_info *revs,
 		info->p = p;
 	}
 
-	stdin_packs_add_pack_entries(&packs, revs);
+	stdin_packs_add_pack_entries(&packs, ctx);
 
 	strbuf_release(&buf);
 	strmap_clear(&packs, 1);
 }
 
-static void add_unreachable_loose_objects(struct rev_info *revs);
+static void add_unreachable_loose_objects(struct stdin_packs_context *ctx);
 
 static void read_stdin_packs(struct repository *repo,
 			     enum stdin_packs_mode mode, int rev_list_unpacked)
 {
 	int prev_fetch_if_missing = repo->fetch_if_missing;
 	struct rev_info revs;
+	struct stdin_packs_context ctx = {
+		.revs = &revs,
+		.mode = mode,
+	};
 
 	/*
 	 * The revision walk may hit objects that are promised, only. As the
@@ -4131,9 +4140,9 @@ static void read_stdin_packs(struct repository *repo,
 		 */
 		ignore_packed_keep_in_core_open = 1;
 	}
-	stdin_packs_read_input(&revs, mode);
+	stdin_packs_read_input(&ctx);
 	if (rev_list_unpacked)
-		add_unreachable_loose_objects(&revs);
+		add_unreachable_loose_objects(&ctx);
 
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
@@ -4541,7 +4550,7 @@ static void add_objects_in_unpacked_packs(void)
 static int add_loose_object(const struct object_id *oid, const char *path,
 			    void *data)
 {
-	struct rev_info *revs = data;
+	struct stdin_packs_context *ctx = data;
 	enum object_type type = odb_read_object_info(the_repository->objects, oid, NULL);
 
 	if (type < 0) {
@@ -4563,8 +4572,8 @@ static int add_loose_object(const struct object_id *oid, const char *path,
 		add_object_entry(oid, type, "", 0);
 	}
 
-	if (revs && type == OBJ_COMMIT)
-		add_pending_oid(revs, NULL, oid, 0);
+	if (ctx && type == OBJ_COMMIT)
+		add_pending_oid(ctx->revs, NULL, oid, 0);
 
 	return 0;
 }
@@ -4574,10 +4583,10 @@ static int add_loose_object(const struct object_id *oid, const char *path,
  * add_object_entry will weed out duplicates, so we just add every
  * loose object we find.
  */
-static void add_unreachable_loose_objects(struct rev_info *revs)
+static void add_unreachable_loose_objects(struct stdin_packs_context *ctx)
 {
 	for_each_loose_file_in_source(the_repository->objects->sources,
-				      add_loose_object, NULL, NULL, revs);
+				      add_loose_object, NULL, NULL, ctx);
 }
 
 static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
-- 
2.56.0.4.gbee41d2fc68

