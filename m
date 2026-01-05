Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBCD23F41A
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767619026; cv=none; b=cnax3RyBAE8FrTVsXDmGMa3s5KMNdqxHCZWrGoSSskXgnNkbhTiXpGTZ+ZgCBTKlPGh+w7grirUkbsGkE8WiRZTDcLc9PC+v9YWrYYkP9/2hZzO7j69o/j5EGUbHAyp43lOf/OZArSonTElK9ISboL513cTOnEY1Y2/BNkDwq60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767619026; c=relaxed/simple;
	bh=fn41G0thdXbMCGqEIRRgPqdxMhNDCoO4qSAwM8gxRYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GQqDzKeVQYFVe6iQ4cAvG4V31xbunXy8gUbhS9LVQIgSPo4OcM1Iry4txGkgeG8eJJhN9LM9udgT6k3aGxzvU7JFFGICMgzm8rtBu7c4sxDdtld45oByg/Db5JC5G62NXQTz79Zs98OS9Q7QUdMxt3KMqbGZCAGF2AiFTofZPL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jZKGugkb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zcxUdM42; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jZKGugkb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zcxUdM42"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 0C7AF1D000C9;
	Mon,  5 Jan 2026 08:17:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 05 Jan 2026 08:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767619023;
	 x=1767705423; bh=3cKICksLMG9PteQXKO62UDltK5KwR71wXmex8/xGMH0=; b=
	jZKGugkbsclahx/9ZWyTTIEz0GmM9Vko3lIgm61FHAuFYJSiH0hOFR6//GcWKWdg
	u+fRXlHnPucma8Kwzy1EXeamIjHV0fM17MQayjDZ29V0Bs9hNDOj5ndFNrwoTz4M
	A2eeEjHq+S9SJdoanvbopiC1miHK4OSrVPNhmoeXIQQx7KhWQwCr6Es6iiLrljlB
	qCuP2t88KKiC9ggN2zRCHpDa5hr7G80EODUW0JXJTiVEcPzlUQTr6LALB7p6fj3X
	thnUHTXUm9AlvePkaTRbbnRNW2Rd8hTrzz7IRcN2Nld7yDoMnszV6Ur7HazfCgy+
	DALySh/UJeycGs7eTCtZrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767619023; x=
	1767705423; bh=3cKICksLMG9PteQXKO62UDltK5KwR71wXmex8/xGMH0=; b=z
	cxUdM42ApxisnoH6kRRNgRIfu55xESWDehw7ATR669sOCV8yh58FZ6Cio0Cs/H0k
	0a4SrYqedcPvsLKMVbEw0eZsGtgE5NVlRk1AUdmgDbGwYadDGbF9vl9oT8nBqHjH
	g0MFXzKZr+zD3Y+39vM+xBx7BRA6YrybbUkiyWhNaN2OeM6ixemUOtEJaQk/teNi
	5Jc63IM4R9ffGrHAB3n/M6Dzhn/F8CHuFtImVlKhvxX3DI2scuGCPOjcBukp7RQs
	Qy5I4EZuysSx1yMNFdqWtutvT1+1+JLzNAabBu6eohH4XZ5AieB/s4g/fadL+DYi
	mQXY9k0vkm+N5dQfsFYKA==
X-ME-Sender: <xms:z7lbaZmgJN6APSs-iqi9TAORjswiP_FT6SGQl-pwI8UO1LivO8PQaQ>
    <xme:z7lbaa12gRFfzAwCA2wh97330Flx1Nw8jdBvMqxT6AG8BimdbN5WG7wyjCSbetITl
    9im4vz7lSuLLMZZvtSqcjlMMDMmkg6nLMcTcKrbVgGwLomJKs7Kbg>
X-ME-Received: <xmr:z7lbadTrg2bzclzFoo2Sr6XYOJRdr4EMhY8gO9slqE0hGovi_dVg8uXFs7qHlulZvsMW3w-PR7njzsilzgOF9t0zAiIbcCUHDGEFH9Z_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:z7lbaUsqVpPe48bQG7hlYDckxmMqojW00rO3vysIJ0TVAiqRJbaMqw>
    <xmx:z7lbaabhmRa5Q6k5OWM_DcQke4shFzqTbF6Dqo_nrM8K42Z-DB7W9A>
    <xmx:z7lbaRsj4HbqnaTmaSzBwjjOwQTcX0yL3obK_DzfQCVCDdYgs01O-A>
    <xmx:z7lbaUHncZ_--XO3CuR-tmQVqgIc9zdUAKGUmXy5k7o1Y3BQZrOkBA>
    <xmx:z7lbaTthPRbte0fjFqgQVjseYvBxnCqQx7m4viff-V4mQMVibq-fDWSO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 08:17:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4ebbf385 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Jan 2026 13:17:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 05 Jan 2026 14:16:45 +0100
Subject: [PATCH 5/5] builtin/repack: handle promisor packs with geometric
 repacking
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-pks-geometric-repack-with-promisors-v1-5-c4660573437e@pks.im>
References: <20260105-pks-geometric-repack-with-promisors-v1-0-c4660573437e@pks.im>
In-Reply-To: <20260105-pks-geometric-repack-with-promisors-v1-0-c4660573437e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

When performing a fetch with an object filter, we mark the resulting
packfile as a promisor pack. An object part of such a pack may miss any
of its referenced objects, and Git knows to handle this case by fetching
any such missing objects from the promisor remote.

The "promisor" property needs to be retained going forward. So every
time we pack a promisor object, the resulting pack must be marked as a
promisor pack. git-repack(1) does this already: when a repository has a
promisor remote, it knows to pass "--exclude-promisor-objects" to the
git-pack-objects(1) child process. Promisor packs are written separately
when doing an all-into-one repack via `repack_promisor_objects()`.

But we don't support promisor objects when doing a geometric repack yet.
Promisor packs do not get any special treatment there, as we simply
merge promisor and non-promisor packs. The resulting pack is not even
marked as a promisor pack, which essentially corrupts the repository.

This corruption couldn't happen in the real world though: we pass both
"--exclude-promisor-objects" and "--stdin-packs" to git-pack-objects(1)
if a repository has a promisor remote, but as those options are mutually
exclusive we always end up dying. And while we made those flags
compatible with one another in a preceding commit, we still end up dying
in case git-pack-objects(1) is asked to repack a promisor pack.

There's multiple ways to fix this:

  - We can exclude promisor packs from the geometric progression
    altogether. This would have the consequence that we never repack
    promisor packs at all. But in a partial clone it is quite likely
    that the user generates a bunch of promisor packs over time, as
    every backfill fetch would create another one. So this doesn't
    really feel like a sensible option.

  - We can adapt git-pack-objects(1) to support repacking promisor packs
    and include them in the normal geometric progression. But this would
    mean that the set of promisor objects expands over time as the packs
    are merged with normal packs.

  - We can use a separate geometric progression to repack promisor
    packs.

The first two options both have significant downsides, so they aren't
really feasible. But the third option fixes both of these downsides: we
make sure that promisor packs get merged, and at the same time we never
expand the set of promisor objects beyond the set of objects that are
already marked as promisor objects.

Implement this strategy so that geometric repacking works in partial
clones.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repack.c            |  3 +++
 repack-geometry.c           | 28 ++++++++++++++++-----
 repack-promisor.c           | 28 +++++++++++++++++++++
 repack.h                    | 10 ++++++++
 t/t7703-repack-geometric.sh | 61 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 124 insertions(+), 6 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index d9012141f6..f6bb04bef7 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -332,6 +332,9 @@ int cmd_repack(int argc,
 		    !(pack_everything & PACK_CRUFT))
 			strvec_push(&cmd.args, "--pack-loose-unreachable");
 	} else if (geometry.split_factor) {
+		pack_geometry_repack_promisors(repo, &po_args, &geometry,
+					       &names, packtmp);
+
 		if (midx_must_contain_cruft)
 			strvec_push(&cmd.args, "--stdin-packs");
 		else
diff --git a/repack-geometry.c b/repack-geometry.c
index 0daf545a81..7cebd0cb45 100644
--- a/repack-geometry.c
+++ b/repack-geometry.c
@@ -66,15 +66,25 @@ void pack_geometry_init(struct pack_geometry *geometry,
 		if (p->is_cruft)
 			continue;
 
-		ALLOC_GROW(geometry->pack,
-			   geometry->pack_nr + 1,
-			   geometry->pack_alloc);
-
-		geometry->pack[geometry->pack_nr] = p;
-		geometry->pack_nr++;
+		if (p->pack_promisor) {
+			ALLOC_GROW(geometry->promisor_pack,
+				   geometry->promisor_pack_nr + 1,
+				   geometry->promisor_pack_alloc);
+
+			geometry->promisor_pack[geometry->promisor_pack_nr] = p;
+			geometry->promisor_pack_nr++;
+		} else {
+			ALLOC_GROW(geometry->pack,
+				   geometry->pack_nr + 1,
+				   geometry->pack_alloc);
+
+			geometry->pack[geometry->pack_nr] = p;
+			geometry->pack_nr++;
+		}
 	}
 
 	QSORT(geometry->pack, geometry->pack_nr, pack_geometry_cmp);
+	QSORT(geometry->promisor_pack, geometry->promisor_pack_nr, pack_geometry_cmp);
 	strbuf_release(&buf);
 }
 
@@ -160,6 +170,9 @@ void pack_geometry_split(struct pack_geometry *geometry)
 {
 	geometry->split = compute_pack_geometry_split(geometry->pack, geometry->pack_nr,
 						      geometry->split_factor);
+	geometry->promisor_split = compute_pack_geometry_split(geometry->promisor_pack,
+							       geometry->promisor_pack_nr,
+							       geometry->split_factor);
 }
 
 struct packed_git *pack_geometry_preferred_pack(struct pack_geometry *geometry)
@@ -234,6 +247,8 @@ void pack_geometry_remove_redundant(struct pack_geometry *geometry,
 {
 	remove_redundant_packs(geometry->pack, geometry->split,
 			       names, existing, packdir);
+	remove_redundant_packs(geometry->promisor_pack, geometry->promisor_split,
+			       names, existing, packdir);
 }
 
 void pack_geometry_release(struct pack_geometry *geometry)
@@ -242,4 +257,5 @@ void pack_geometry_release(struct pack_geometry *geometry)
 		return;
 
 	free(geometry->pack);
+	free(geometry->promisor_pack);
 }
diff --git a/repack-promisor.c b/repack-promisor.c
index 125038d92e..73af57bce3 100644
--- a/repack-promisor.c
+++ b/repack-promisor.c
@@ -109,3 +109,31 @@ void repack_promisor_objects(struct repository *repo,
 
 	finish_repacking_promisor_objects(repo, &cmd, names, packtmp);
 }
+
+void pack_geometry_repack_promisors(struct repository *repo,
+				    const struct pack_objects_args *args,
+				    const struct pack_geometry *geometry,
+				    struct string_list *names,
+				    const char *packtmp)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	FILE *in;
+
+	if (!geometry->promisor_split)
+		return;
+
+	prepare_pack_objects(&cmd, args, packtmp);
+	strvec_push(&cmd.args, "--stdin-packs");
+	cmd.in = -1;
+	if (start_command(&cmd))
+		die(_("could not start pack-objects to repack promisor packs"));
+
+	in = xfdopen(cmd.in, "w");
+	for (size_t i = 0; i < geometry->promisor_split; i++)
+		fprintf(in, "%s\n", pack_basename(geometry->promisor_pack[i]));
+	for (size_t i = geometry->promisor_split; i < geometry->promisor_pack_nr; i++)
+		fprintf(in, "^%s\n", pack_basename(geometry->promisor_pack[i]));
+	fclose(in);
+
+	finish_repacking_promisor_objects(repo, &cmd, names, packtmp);
+}
diff --git a/repack.h b/repack.h
index 3a688a12ee..bc9f2e1a5d 100644
--- a/repack.h
+++ b/repack.h
@@ -103,9 +103,19 @@ struct pack_geometry {
 	uint32_t pack_nr, pack_alloc;
 	uint32_t split;
 
+	struct packed_git **promisor_pack;
+	uint32_t promisor_pack_nr, promisor_pack_alloc;
+	uint32_t promisor_split;
+
 	int split_factor;
 };
 
+void pack_geometry_repack_promisors(struct repository *repo,
+				    const struct pack_objects_args *args,
+				    const struct pack_geometry *geometry,
+				    struct string_list *names,
+				    const char *packtmp);
+
 void pack_geometry_init(struct pack_geometry *geometry,
 			struct existing_packs *existing,
 			const struct pack_objects_args *args);
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 98806cdb6f..04d5d8fc33 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -480,4 +480,65 @@ test_expect_success '--geometric -l disables writing bitmaps with non-local pack
 	test_path_is_file member/.git/objects/pack/multi-pack-index-*.bitmap
 '
 
+write_packfile () {
+	NR="$1"
+	PREFIX="$2"
+
+	printf "blob\ndata <<EOB\n$PREFIX %s\nEOB\n" $(test_seq $NR) |
+		git fast-import &&
+	git pack-objects --pack-loose-unreachable .git/objects/pack/pack &&
+	git prune-packed
+}
+
+write_promisor_packfile () {
+	PACKFILE=$(write_packfile "$@") &&
+	touch .git/objects/pack/pack-$PACKFILE.promisor &&
+	echo "$PACKFILE"
+}
+
+test_expect_success 'geometric repack works with promisor packs' '
+	test_when_finished "rm -fr repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git config set maintenance.auto false &&
+		git remote add promisor garbage &&
+		git config set remote.promisor.promisor true &&
+
+		# Packs A and B need to be merged.
+		NORMAL_A=$(write_packfile 2 normal-a) &&
+		NORMAL_B=$(write_packfile 2 normal-b) &&
+		NORMAL_C=$(write_packfile 14 normal-c) &&
+
+		# Packs A, B and C need to be merged.
+		PROMISOR_A=$(write_promisor_packfile 1 promisor-a) &&
+		PROMISOR_B=$(write_promisor_packfile 3 promisor-b) &&
+		PROMISOR_C=$(write_promisor_packfile 3 promisor-c) &&
+		PROMISOR_D=$(write_promisor_packfile 20 promisor-d) &&
+		PROMISOR_E=$(write_promisor_packfile 40 promisor-e) &&
+
+		git cat-file --batch-all-objects --batch-check="%(objectname)" >objects-expect &&
+
+		ls .git/objects/pack/*.pack >packs-before &&
+		test_line_count = 8 packs-before &&
+		git repack --geometric=2 -d &&
+		ls .git/objects/pack/*.pack >packs-after &&
+		test_line_count = 5 packs-after &&
+		test_grep ! "$NORMAL_A" packs-after &&
+		test_grep ! "$NORMAL_B" packs-after &&
+		test_grep "$NORMAL_C" packs-after &&
+		test_grep ! "$PROMISOR_A" packs-after &&
+		test_grep ! "$PROMISOR_B" packs-after &&
+		test_grep ! "$PROMISOR_C" packs-after &&
+		test_grep "$PROMISOR_D" packs-after &&
+		test_grep "$PROMISOR_E" packs-after &&
+
+		ls .git/objects/pack/*.promisor >promisors &&
+		test_line_count = 3 promisors &&
+
+		git cat-file --batch-all-objects --batch-check="%(objectname)" >objects-actual &&
+		test_cmp objects-expect objects-actual
+	)
+'
+
 test_done

-- 
2.52.0.508.g883dcfc63e.dirty

