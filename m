Received: from mail-oo2-f34.google.com (mail-oo2-f34.google.com [74.125.231.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374AD431A4A
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 04:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790827901; cv=none; b=mvovzD68TbZOesGs/kxygeIDBAIoV1J/Fc/fNrC2MKN2RqWWSXxClYDIsiG5klElkAiVP2krpsdJvZGo13XrecWiAeq8WToYxPfE+FoLvjP6iFdNACHBW6WyGTuktsXVEuRVT+z2lzYIephvV2bAyUXyfEFIseWc9zT+5ECyFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790827901; c=relaxed/simple;
	bh=LW7FBHWkh2wQ3p1FeSbt32759iiLtjm/Qc6tjyis47Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UT+71rB/Lag3NzJmFcuADvPy9mgqF23drQiouLMw4QmqKlYUKXFsJYUIIOyd8kxKV5r7KJcANKcBBoYTC4qnLfvmxYZkSDbMfnO94Is64YmCRepiKIZEWfnADFalZs6aTL41q2ZDveCjDm1eWrXrfkqqVZp9Dp0XSl/n77WJWvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=bbXnLxqL; arc=none smtp.client-ip=74.125.231.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="bbXnLxqL"
Received: by mail-oo2-f34.google.com with SMTP id 006d021491bc7-6de5d816853so33381eaf.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 21:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790827899; x=1791432699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bFkvyQlbwT/1rcgN9VGQnETg+FOWq74De/37jZVmBmk=;
        b=bbXnLxqLVZjn3CTZ7DQi2BMG93TyiSx/E5eqq0lWmgcClg7fIo0QJdV5AfHfqV0KiM
         AvsGiquLdtnbBx0hJOwpGhkLHc63Ypj2oPBZWgIMGOicKUnoRLhBK4sz5NSkRMVD0UGt
         m2a3edMepn4qUZx9U5Td9pGJHlolWpe5NhUNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790827899; x=1791432699;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bFkvyQlbwT/1rcgN9VGQnETg+FOWq74De/37jZVmBmk=;
        b=mbsv5S0DtJ1HRnfJs79/fSt34xzYKR388CTqoIOAuohmPkK93H41x9mn2P6/lPhntg
         LWpyuMT7DevOnHkoKgfRcpkDwRzaq75LQc63X9v1KaU3oG4oMf2DEpkD0FjNtv/NOTZI
         7qliMxyitSougBESdF1u+4ubqmg9kdZqbGEBk6UIHuis+3TI9wBlzbYA4DZHgE/hU98r
         P8UYgwMZsR4S1+1I5/Dveyk0QNuUAxM4per1I9CR1wQqAhCBrYwSkgse8X1W4JL3L9m4
         VuWotpC9j1ne1zKA+x4pO7adSSjYmgVzWRQSuwtphV2n32nwJYPgeWVtIOepP+8nFzts
         tLMg==
X-Gm-Message-State: AFuF++nwZGQvwRSEdUO8L8ul61wKzeKnXvF3wg5AmdAMqJHBAZl5/Kzm
	I7Vhr0mQoktENt0aYzZVP41yF7sNLKLgr4vsMNI/VcsijRdc1Z81ZZUGz+RUUNvqX21T0iV3JOh
	8LDYrqm8=
X-Gm-Gg: AYBFou1nZBoONGj5y0v7ZSOEbSayuk+r/DpM4LJ4fC9/BCGNeZiTe1v+gFs+JpETDyZ
	SUY0n8KxfO/itEGHQqqIsCP1JPTJjQRfTzmTowFCojaT1GDTEwRkDCnmM6cfyEm5F+lHTtvEUYq
	eWfemiNHLBxC1g7isrnSJsWOjzQ4aNbcP850nNTR/qoIDsY5PAAEySzOsQN1iwC1jODtuYDvtCl
	BnITgWsz+dSygbTvfw+Aw9oqQ8vQCViU+7fRxnusgZw3AJDx53qcSAuo8p1JtWVREEinbpL/Xob
	FE3wBY64kSOamWjc1BHNcoa6Vxy51gCL6JCNjQ1ESJg9aFGPVsHPhTfax7iuLrWm2nHckhv5R9y
	hkW2s9740LR6Sy/ahDS++BL1899S1pUx9VzgFE4sTSiAS6Q/97Y5NuYykAgVRwldlS1N2YEsKaP
	7Tt3A5Ie7/+V0wFCYxkT4ULbbbtcrkOfxVa0taUhr24f6FL9QaOAoA0FWO6T//PWNjwN351P11V
	DV6Mat5iAku3bhFcof+UXVgzC0P2YBnOBmIoyC+vLXKVV8yvMdfodd5O3jFixAH9ssq8cMrHudg
	LAiGCUyb9g==
X-Received: by 2002:a05:6820:806:b0:6b1:afc8:3162 with SMTP id 006d021491bc7-6dcf1ab2024mr3737919eaf.7.1790827899024;
        Wed, 30 Sep 2026 21:11:39 -0700 (PDT)
Received: from com-79390 (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6dd985dfee1sm1873248eaf.12.2026.09.30.21.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 21:11:38 -0700 (PDT)
From: Taylor Blau <ttaylorr@openai.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date: Wed, 30 Sep 2026 23:11:35 -0500
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: [PATCH v2 1/8] pack-objects: introduce `stdin_packs_context` struct
Message-ID: <354c29cae732703e75b22fa347cb07d898304f01.1790827875.git.me@ttaylorr.com>
References: <cover.1790731662.git.me@ttaylorr.com>
 <cover.1790827875.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1790827875.git.me@ttaylorr.com>

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
index af9390a46b9..a553064fcce 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3804,11 +3804,17 @@ static int git_pack_config(const char *k, const char *v,
 static int stdin_packs_found_nr;
 static int stdin_packs_hints_nr;
 
+struct stdin_packs_context {
+	struct rev_info *revs; /* must be non-NULL */
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
2.56.0.8.ga42f775cbe2

