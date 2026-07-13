Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B806356749
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 05:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783921961; cv=none; b=OTDyLW7xBE5mbaBzligxtXZWhB+1Ub95zD1Gt9rCa36QngyAd7ToO4flqZJDcyExWz1Kjtrx1QgMM0Tln4WN0IfDOTg0RvZDF58noOhRfE5j/WqRgnhsLGQOPd7CQHBl30oj5tPHPthIaeabtx48D5dBmlzKXvYOE00quLt527o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783921961; c=relaxed/simple;
	bh=gGskTdzuQkTWx/5YvKgtOATaoHZ7F1SNOcoAA4/osjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NX1P6Cxv82v75NbKao33DexE98V2tJajuYG88P8zbO2DLSxj+eogmYU8uJzF0A9gHMPvUPQDas5l+v7FvhYNkvGwrMSZ5ZUqFFbfJhEMM2ahS9BHOuOXeZD60YfBIgmlDGniomYsVbqxlhWOplV0ow/gFfQJfmER42SEygHqXOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DwFF4+ZV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uh2DNv1v; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DwFF4+ZV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uh2DNv1v"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E3F7EC0143;
	Mon, 13 Jul 2026 01:52:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 13 Jul 2026 01:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783921958;
	 x=1784008358; bh=4D8Ja7fuyHtFB08JSwdF5bV0b4+q+K7lveMyURa0Pw4=; b=
	DwFF4+ZVe0Lz2AjHbUczNhvyJBUVZYGCRS9vgOu/N1bwub5gAA1AAdbOGcqkFrVv
	4ZpO4+iNiXByMQK1BEX+jgiMt19SDVOjsDnCcvjK5SwnOlA0z1E2T7zpoR8YT/Ew
	ouNGrFYVigbP6MtXfN0rpjfHAaj71NsP3Zobe32XmrEJiTvxJuHcfbN8pgIRsp0z
	XhjfObjxGrY3PV454CfonootZ4Rjla4BSDcAVs3EqX+OlRXqqHEHevgFtI35gi5E
	kJvbdQPlr3Yg1jsrcHaf7ZN6e88B8i9Tj/Mo7ylpVjgmUqtmrDrip6p4APTlkFbH
	1wMzpE4c5lybhsq5CdKjOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783921958; x=
	1784008358; bh=4D8Ja7fuyHtFB08JSwdF5bV0b4+q+K7lveMyURa0Pw4=; b=U
	h2DNv1v635ZiVrxGV+Jo8Sb0/RG8IeNU6J7qSW5lInuwTND/Tmi+9JRw1SaQ0R4K
	nyOzlHRIUn3RfqXQNdUJLchkTy4dGEJ3G7a1y5HVvHxu8nnJ+Mv8+62u7ciK4GxZ
	XHSeTQwhvFpR+htKMtTyuSxxMqPpEw94dUBPLHIl7cy9ToM/3H78OrTJBn0iKg+i
	pLEcunr/y+BhLteHC0Z2cgG+cBFh110Q4kuZBM7TMVYjRVdKUl85Y3bnxQcg5Ly8
	w9uwRozPAUOZ9l5pugffsxylS7W+it5pDKvefLALpOg8i7QWuHXzHvg6sUhWzElF
	adlqVfKrWS7ZpF0+L+Sew==
X-ME-Sender: <xms:Jn1UahHN8gL-BZGacl6EAkEu11NbaWrpkcq2DIdP1TIma0ucSzc5ng>
    <xme:Jn1UasU13gdMsrikqHrLnf6lwIzz_187RFMizmxRL3pIJC9sKHSe23QLU1PYgzkO6
    twr9pFcPxp2GOdkW4Aj4h4iCDXpQKqhJomJmv-0CePLz5MGtzEtRw>
X-ME-Received: <xmr:Jn1UagzZ0JnRRMPMLEuFDvmPp1jbfOzb-Zx0Sg2SK2JOqpcp_EhalhFneS-8sPNZHNGKprItx0twPjVGLW1IPaFnixVaW3hEbofuRO0z>
X-ME-Proxy-Cause: dmFkZTFpRZHzFF0cadud3kQ7W1YCQBWUhBAdvmPgDT1hhW+kCzY5uaMFg66xdsMBvwnOEi
    M5+tgKwnf6y7czN9dg56aykoi1q5020ya+mZCgZp4MpdIPhjwjIdr0NN+xGxVfV1DxQ4m5
    jNQT2IRbG0t2yp7XiH+5P/dgMS0yRmNxpvuHUazTLfugHNtbpxDxIaupFYBy/UDYzXf4ae
    UhiW0WldhvQmqsGC7zQchWBuaLfzGWD3Yw0TqEKnBjQlhT2KQAD7b36yIdzna3KSyPXbZF
    TFedA855HmeLI+2HIRU0Zg22vUinQiLXJy6ERPoUt2lp++ysoIt5bcgXsMKycb7XxwPOfT
    N7RQ/TA8v9OrqRMwg3BfLBwsVOcgh5ANPvxxfx4vHknwiwJRdfYrkDdPSkukOhWkQx1sSO
    k4Q+JMQ25CDrq3biwp4Slv7/s4zx+w2KvgenN+K8BrBXgaF72E3X8nz79iXYb5L0H8HuFM
    3ztSDxrFKG60rwZegMUY9Qn4HMMVHOoia31nv5ayXYmeOXpYPATrsoidMA3OPqD09i9RY6
    ZiCGtPmlSM1IMyEpsNRXxY/OcjRRekr/Jf90ubZudhXQhZVcpV6eRt87Aed41OUYgu6f+K
    PjHtP19KILd1z5LDpGDrG6yyEPv5IUIhg8/uDmakiuKLQcMtL9l5J4DzOj8A
X-ME-Proxy: <xmx:Jn1UaiN718ebX4o5WtOcgoNKjksFnx50mq-rSrKUO2bENhC047UjJA>
    <xmx:Jn1Uap5da3cCr_vxxf1NL6Rl2PVz0CNhIcjH17IATyNBv2sYz7EdFQ>
    <xmx:Jn1UarO7Ej4ZhTqX2GTgY5PAYYVaMKfQwFjarOtUXVnSnb1TMaOTbw>
    <xmx:Jn1UavlvNWHbki_iaCQ6V-MgcFdMp6y0qGJ9B7FjGgER2SVBmAYNFA>
    <xmx:Jn1Uase3cF2aVAZPlrFCEWxMmbuvU9CV671-gxKdpTzuVkSKV9yYaA5k>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 01:52:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fa568645 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 05:52:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jul 2026 07:52:12 +0200
Subject: [PATCH v2 09/12] builtin/gc: introduce `odb_optimize_required()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-b4-pks-odb-optimize-v2-9-9c2c3ee94b38@pks.im>
References: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
In-Reply-To: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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
2.55.0.313.g8d093f411d.dirty

