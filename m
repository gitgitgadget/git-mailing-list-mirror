Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9904439A06D
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438398; cv=none; b=ahVeD6DKi3iA+5LYm9TwvYS5gYeKL/32o8KuwkjmIfgV0WYX9LPcqrX1Kc+WvOdXXJ22iVm90UGXm6jb1oYnEZ4rXN2OZduLWJhOlIzS3f/e93OpJv0tDRKNIaXLyRafObw0cUx2i1w9MAEXhFODSNsT0/EDJm83PBXltkJVItQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438398; c=relaxed/simple;
	bh=tiSC4O6bFEHdWk9xecK47mybs/myfwDjzz2VqhPJizw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eF7cJ8rn3YVSF3IHQEJTBoBQtOYe0lDZSY9jw5KvEGVGGyX4jtljJf1zJsXbw9fjuGYBzfRQQnjA9tYC9nh9sSsdV0GxPc3ly8ll/lCOiV9EijFggUN26Bfi8tsfju4XKAHCsEuTOSbm19mnSrLGTi8xVBlpxDGZhbWyHewXKxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gOGUSTAc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ELQOHNYw; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gOGUSTAc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ELQOHNYw"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id E8731EC0227
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 11:33:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 07 Jul 2026 11:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783438395;
	 x=1783524795; bh=JMcsoz1rnflR2IWPYniuJ1FbN0sJMr2V2+YyuZzos5c=; b=
	gOGUSTAc9xmVUX7d1qSu30p7XXa+Fn7Zjd9MNEj4LKhYF2YIXZ6aOUJpqcQYQpqC
	hPh5XOOFATwv2dqKyeaebeU5cTNvV9OEG7ZVQY/tXAyLpY9qE0iJk0YfpJo/TaqM
	hCZ0hk522VMhZ/hEPeSWd+KJjQ5LuEvRI+2rEtt95mkJCyixdY5W45NQTnTcWIdy
	JSUyfa3gs2iFNN6lNYRh5bIXmX9EqwyOq+rV3xlithu57T0cxJdXPos0T9DV2gcT
	PjBlodjkFPWD3eB2MiA4e1VUCiZryLl8chqb2LUEeUUw6GFVZ+CO7pyHJf5G5vCG
	IAOF67ppXNNgzkdUj19VRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783438395; x=
	1783524795; bh=JMcsoz1rnflR2IWPYniuJ1FbN0sJMr2V2+YyuZzos5c=; b=E
	LQOHNYw2y4z72unlnB22tcxs+SB0NQIdYk8hxa+vZBvbFGvwwYCS4PxB5Q6AGP+8
	n3Dbb+R6OfFgJ17PF3C7D/V8lpVwJPLwvpymMcQPH/5IedVNlmIaLQn6es1re5H6
	FFBjhY7ZrASkuf0SW+xwhdI8c4nILrEbq5L4Xe6SJPshXWZcdh6PhiIfoMaeDYZm
	nUUWBXeGC8ciBcUafEDctEWCChWYMmJEg6xc0Wclp0rSqErlH6a0hDn0vu1HKk6s
	cqoereyPR1EYzTmL6tTYc6I0Uw5hL6F3SekulFn3/7KsvGRher1RgBahhFXeiL/n
	UtnwCKpQYqavqXmhhpYDw==
X-ME-Sender: <xms:OxxNagoYVh1p-bhsviXYuxqB-eKpxkIEScXYv2mlt_q_PBQZYd-mbw>
    <xme:OxxNatlMGVPYHGFBCpmmTML7muXFnXskwRVEpLWrxhg_On20WFIZNHFFmSFYcjZw8
    AnYHAcEHeQEvet6oHXzcWvhoFaco95dTKfFAQiRiyoXS7Gz4z-d-w>
X-ME-Received: <xmr:OxxNaq0Z_543KU-MClBoCrdNyJDqcPjB8IU6H0lo1JqEbnYA-UbN6G6MdcMKT953ItMcx2ZR3jELlhDFJ1mMI8XlQkqPnTYshU797K77Wg>
X-ME-Proxy-Cause: dmFkZTE6/iD3iHEuKBNru2cNsbN07kG+Ccd2z4KEMYhG2RvUCd+cOj2SmvRaPW6JdQJxYg
    yIYZJCovWU1j7v3nEEWcH2j/Wq2UWDCGC2XEGJ5SCvILUi8Rz9tCTiiZ51Icbkoyae9CJ8
    HA8uVCKObebcEoJ5TV2ivYrxy86qhazOGtYwH3j6uB5bc16miFoGFC2lxYTBbwQoWDP8w7
    Lah7PP1UuH619unN5/HqL3nPvgy44p1ofkS+7wWIRtYeq/lSVpeXB8M8nm5c7cDYw5zp91
    a1JFX+mSXwg6Bda7Ouf5RKV965olucpDrzFt45zWO9w5zYNzijwyqnCRczzOvzF6BX93Eb
    8ZjGSKeUeieYxyG+oeYddL0Ig/HAshhTQlCmZLUrSYk9xnjJ43NMAtF8M61KCaNJSKmjwU
    /GdR8W/g68CezHl8X0fe9ByfHK4PZk2Oe4VJ3ZndXQvhyMkhEnnQKDachICj0+BH43zsAo
    UQlTkAtLRKZ1WEWqSIsIGIIRBc3mr7bokLwp7u54LKN7ZGmobPlPzQHgnd5uN5dQ67Zzag
    A9oRjnpC2b99JoFYgAYVSaTlmugA+1RhNW8x/aSyOrhv8LS+lGWxBPKaLxdQH/O0rqfv/W
    ZnrIihz9x+eUYEMvKGdTLPTg4W5bf+NJaFqIT7RRFWH7K+Qh/Lb9XpEIu0xg
X-ME-Proxy: <xmx:OxxNatDdoP2QB5oaehM_8zsTfNq8Y_Nkaen1sSzVdzZMXIC4cgo2JQ>
    <xmx:OxxNavxGrAFhDIAW5Yb8yWcB2ItYMgsGaMf9QLBks2GW5FfEwRi71Q>
    <xmx:OxxNajmOGzhBtqD1kqceMbvrpdECZrvgy31pq_527q8aGB4qRKyBMQ>
    <xmx:OxxNasHNDT--xcy66acCYlcT-KrDsssMlrMxqcvwsCPb4FGEy93D4A>
    <xmx:OxxNakJByItzu19xmMBmByVpPSN72uVUdM3uCWu_1VNXOhfvDb6ELefO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 7 Jul 2026 11:33:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 890b5373 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 7 Jul 2026 15:33:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jul 2026 17:32:40 +0200
Subject: [PATCH 08/11] builtin/gc: introduce `odb_optimize_required()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-b4-pks-odb-optimize-v1-8-aae607667be4@pks.im>
References: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
In-Reply-To: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When invoking either git-gc(1) or git-maintenance(1) with the "--auto"
flag then we only perform those maintenance tasks that are actually
required. This logic is inherently an implementation detail of the
object database backend that's in use. But the logic is scattered around
multiple different functions, which makes it hard to make the logic
pluggable.

Introduce a new `odb_optimize_required()` function that allows us to
check these conditions in a generic way.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 160 ++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 92 insertions(+), 68 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c8504f4456..e119930adc 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -676,25 +676,84 @@ static void add_repack_incremental_option(struct strvec *args)
 	strvec_push(args, "--no-write-bitmap-index");
 }
 
-static int need_to_gc(struct repository *repo)
+static bool odb_optimize_required(struct object_database *odb,
+				  const struct odb_optimize_options *opts)
 {
-	int gc_auto_threshold = 6700;
-	int gc_auto_pack_limit = 50;
+	switch (opts->strategy) {
+	case ODB_OPTIMIZE_INCREMENTAL: {
+		int gc_auto_threshold = 6700;
+		int gc_auto_pack_limit = 50;
 
-	repo_config_get_int(repo, "gc.auto", &gc_auto_threshold);
-	repo_config_get_int(repo, "gc.autopacklimit", &gc_auto_pack_limit);
+		repo_config_get_int(odb->repo, "gc.auto", &gc_auto_threshold);
+		repo_config_get_int(odb->repo, "gc.autopacklimit", &gc_auto_pack_limit);
 
-	/*
-	 * Setting gc.auto to 0 or negative can disable the
-	 * automatic gc.
-	 */
-	if (gc_auto_threshold <= 0)
-		return 0;
-	if (!too_many_packs(gc_auto_pack_limit) &&
-	    !too_many_loose_objects(gc_auto_threshold))
-		return 0;
+		/*
+		 * Setting gc.auto to 0 or negative can disable the
+		 * automatic gc.
+		 */
+		if (gc_auto_threshold <= 0)
+			return false;
+		if (!too_many_packs(gc_auto_pack_limit) &&
+		    !too_many_loose_objects(gc_auto_threshold))
+			return false;
 
-	return 1;
+		return true;
+	}
+	case ODB_OPTIMIZE_GEOMETRIC: {
+		struct pack_geometry geometry = {
+			.split_factor = 2,
+		};
+		struct pack_objects_args po_args = {
+			.local = 1,
+		};
+		struct existing_packs existing_packs = EXISTING_PACKS_INIT;
+		struct string_list kept_packs = STRING_LIST_INIT_DUP;
+		int auto_value = 100;
+		bool ret;
+
+		repo_config_get_int(odb->repo, "maintenance.geometric-repack.auto",
+				    &auto_value);
+		if (!auto_value)
+			return false;
+		if (auto_value < 0)
+			return true;
+
+		repo_config_get_int(odb->repo, "maintenance.geometric-repack.splitFactor",
+				    &geometry.split_factor);
+
+		existing_packs.repo = odb->repo;
+		existing_packs_collect(&existing_packs, &kept_packs);
+		pack_geometry_init(&geometry, &existing_packs, &po_args);
+		pack_geometry_split(&geometry);
+
+		/*
+		 * When we'd merge at least two packs with one another we always
+		 * perform the repack.
+		 */
+		if (geometry.split) {
+			ret = true;
+			goto out;
+		}
+
+		/*
+		 * Otherwise, we estimate the number of loose objects to determine
+		 * whether we want to create a new packfile or not.
+		 */
+		if (too_many_loose_objects(auto_value)) {
+			ret = true;
+			goto out;
+		}
+
+		ret = false;
+
+	out:
+		existing_packs_release(&existing_packs);
+		pack_geometry_release(&geometry);
+		return ret;
+	}
+	default:
+		BUG("unknown maintenance strategy '%d'", opts->strategy);
+	}
 }
 
 /* return NULL on success, else hostname running the gc */
@@ -1076,13 +1135,19 @@ int cmd_gc(int argc,
 		die(_("failed to parse prune expiry value %s"), cfg.prune_expire);
 
 	if (opts.auto_flag) {
+		struct odb_optimize_options optimize_opts = {
+			.strategy = ODB_OPTIMIZE_INCREMENTAL,
+			OPTIMIZE_FIELDS_FROM_GC_CONFIG(&cfg, 0),
+		};
+
 		if (cfg.detach_auto && opts.detach < 0)
 			opts.detach = 1;
 
 		/*
 		 * Auto-gc should be least intrusive as possible.
 		 */
-		if (!need_to_gc(the_repository) || run_hooks(the_repository, "pre-auto-gc")) {
+		if (!odb_optimize_required(the_repository->objects, &optimize_opts) ||
+		    run_hooks(the_repository, "pre-auto-gc")) {
 			ret = 0;
 			goto out;
 		}
@@ -1379,9 +1444,13 @@ static int maintenance_task_gc_background(struct maintenance_run_opts *opts,
 	return run_command(&child);
 }
 
-static int gc_condition(struct gc_config *cfg UNUSED)
+static int gc_condition(struct gc_config *cfg)
 {
-	return need_to_gc(the_repository);
+	struct odb_optimize_options opts = {
+		.strategy = ODB_OPTIMIZE_INCREMENTAL,
+		OPTIMIZE_FIELDS_FROM_GC_CONFIG(cfg, 0),
+	};
+	return odb_optimize_required(the_repository->objects, &opts);
 }
 
 static int prune_packed(struct maintenance_run_opts *opts)
@@ -1681,58 +1750,13 @@ static int maintenance_task_geometric_repack(struct maintenance_run_opts *opts,
 	return odb_optimize(the_repository->objects, &odb_opts);
 }
 
-static int geometric_repack_auto_condition(struct gc_config *cfg UNUSED)
+static int geometric_repack_auto_condition(struct gc_config *cfg)
 {
-	struct pack_geometry geometry = {
-		.split_factor = 2,
-	};
-	struct pack_objects_args po_args = {
-		.local = 1,
+	struct odb_optimize_options opts = {
+		.strategy = ODB_OPTIMIZE_GEOMETRIC,
+		OPTIMIZE_FIELDS_FROM_GC_CONFIG(cfg, 0),
 	};
-	struct existing_packs existing_packs = EXISTING_PACKS_INIT;
-	struct string_list kept_packs = STRING_LIST_INIT_DUP;
-	int auto_value = 100;
-	int ret;
-
-	repo_config_get_int(the_repository, "maintenance.geometric-repack.auto",
-			    &auto_value);
-	if (!auto_value)
-		return 0;
-	if (auto_value < 0)
-		return 1;
-
-	repo_config_get_int(the_repository, "maintenance.geometric-repack.splitFactor",
-			    &geometry.split_factor);
-
-	existing_packs.repo = the_repository;
-	existing_packs_collect(&existing_packs, &kept_packs);
-	pack_geometry_init(&geometry, &existing_packs, &po_args);
-	pack_geometry_split(&geometry);
-
-	/*
-	 * When we'd merge at least two packs with one another we always
-	 * perform the repack.
-	 */
-	if (geometry.split) {
-		ret = 1;
-		goto out;
-	}
-
-	/*
-	 * Otherwise, we estimate the number of loose objects to determine
-	 * whether we want to create a new packfile or not.
-	 */
-	if (too_many_loose_objects(auto_value)) {
-		ret = 1;
-		goto out;
-	}
-
-	ret = 0;
-
-out:
-	existing_packs_release(&existing_packs);
-	pack_geometry_release(&geometry);
-	return ret;
+	return odb_optimize_required(the_repository->objects, &opts);
 }
 
 typedef int (*maintenance_task_fn)(struct maintenance_run_opts *opts,

-- 
2.55.0.141.g00534a21ce.dirty

