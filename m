Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD3C1EA65
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767619016; cv=none; b=f9Po8lB3rT5ktveMRCP0Hd4EDNWEhneAxJKfguUcae5hM/DdCNvPiiPn5iM4aBBcwM6FVLKm7Xc1d6wYnnKmrnoSdhWezJ2qZBbtoPoEJpIlv95547At7+jALQE6x7NHO3mGvzGfWXj8XLPwrdrlf/A/ii+HtrPYNgtguC6F9pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767619016; c=relaxed/simple;
	bh=LtP1gHDi41zHyECS/acXbGQrnfF7o8TMSPO35jgE+hc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oGttpj9DgCmNr6Azg2/4vpgXLn3odP604JQjNrB1AdElXb3evvEyq2NyGODdbLBjOD2bjk7WneQnt3zq5soMFq0W5jyBRNgReuxblc05jTNCtw/0HghJiQujAF9SH+G6tEYmsmM031dED5MtR01NG99MWoRfKg++HeLdur5W4SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dxuKYY5p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uj4ktMcj; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dxuKYY5p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uj4ktMcj"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 991461D000AF;
	Mon,  5 Jan 2026 08:16:52 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 05 Jan 2026 08:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767619012;
	 x=1767705412; bh=e0F535lD2VLd3UwbCKImjMf8HoqvLY4qwPu2dENMfek=; b=
	dxuKYY5pDlo/APqJkaEK4WNR+23cN8dFHAHZPU2UqUaHSKCuXRavzvvvWJsYgxAR
	JLEzjKg6X/GCCnC8f7DA2VmnTKP0sg24pYyjd/6+oEIusEsvyL95pyPZ7i3Nk9Y3
	JJ/FlqFN9fFQRI4g4ZEUxQJVrHOiO5kincpqjd8OH2kSMqAdLR4WQj2JZbVdYTta
	pslxEHgipNbDwHBk1/TSZIM4Bi7g5kS9QvwiWu4+57HaO8BUUKFPI4up+ZGUlNr1
	JOBuyLO57GcUg79hFP/CpwhNYFmuRfj/sz+b3U+c3PHdikCkXzlH9OREq57fPH8B
	hNDiFKnEWfH+g4H6gNU1KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767619012; x=
	1767705412; bh=e0F535lD2VLd3UwbCKImjMf8HoqvLY4qwPu2dENMfek=; b=u
	j4ktMcjLrI4dUuv1oFuzPTINuFt971Z/Y1ztvmuh4qq2U/QD4EiXLhwS4+tPflaL
	ub41xP3mm/Iijg/CkvzEu10JeqVPYBuolx5VVvjw8BHcetZAEERcNOYFB29OMH3m
	zSL/ZilJy2MIkHWYD+L45+rpMnYUcmCCyTj/afpfmeUL1UVHZpCoIFL7OZsXeeS4
	oM9/q+7K2gMPNHS5Ugt1pMtz4Kg9g7l52zRTU+Zh2Dmjkb62HpUhH7yDfvSf0MyR
	JNaYiYJ/AIimpPt5ErxuTWpTuDkdrfd8M2LgUaDdmQt2uk87zSMtg0/iT7dubOIK
	MHhQXw17izT1XXzm45FgA==
X-ME-Sender: <xms:xLlbaSUha_jJAZcRQq5qDqmMdCGs58ZLPv3WU3n9OmiTBACAUJW5Mg>
    <xme:xLlbaUn6E4KD_VduVcF79eGEaVT2mirirviZNJ4uMCkcQHSeKnUQNUe-W9y7zwK2W
    oG_Cs4LTqNTPwDc3aDUrccNxVBgOptbDMHMvywst-Rl2IzxdBGM>
X-ME-Received: <xmr:xLlbaUAd9JJNi1gZtIZh2U8O166j-g2hWVifurdMYcZWOrTpGhbn9tcstPY7qCgvNZA6pxxODbRjCuL3ygTgNGJtMIZghdaYGcyAh_Xp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xLlbaUc9EoNS2s5sIs6Y5w6nTokKu6UNke6jGzxy6TxuOKci_64vbw>
    <xmx:xLlbafJeDCuY-4wjz_5es5YVq-EO1w4-ZvcssLvhFtKuj3siL5kbww>
    <xmx:xLlbaXfEQXIAN2o4W7zUAyfmScE5gIoe7BdyYpDY1fRWA1EIGAeDRA>
    <xmx:xLlbaW1DzOcPy-owtqJ6FqMNf8WU0saCWWc6RU_pdDwtXVwOZDr3yw>
    <xmx:xLlbaQfdLOd0_xKDzXLgU4hklwAFWiexuYslqVahNsreyNMIrABIVEPH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 08:16:51 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d5f537bb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Jan 2026 13:16:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 05 Jan 2026 14:16:41 +0100
Subject: [PATCH 1/5] builtin/pack-objects: exclude promisor objects with
 "--stdin-packs"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-pks-geometric-repack-with-promisors-v1-1-c4660573437e@pks.im>
References: <20260105-pks-geometric-repack-with-promisors-v1-0-c4660573437e@pks.im>
In-Reply-To: <20260105-pks-geometric-repack-with-promisors-v1-0-c4660573437e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

It is currently not possible to combine "--exclude-promisor-objects"
with "--stdin-packs" because both flags want to set up a revision walk
to enumerate the objects to pack. In a subsequent commit though we want
to extend geometric repacks to support promisor objects, and for that we
need to handle the combination of both flags.

There are two cases we have to think about here:

  - "--stdin-packs" asks us to pack exactly the objects part of the
    specified packfiles. It is somewhat questionable what to do in the
    case where the user asks us to exclude promisor objects, but at the
    same time explicitly passes a promisor pack to us. For now, we
    simply abort the request as it is self-contradicting. As we have
    also been dying before this commit there is no regression here.

  - "--stdin-packs=follow" does the same as the first flag, but it also
    asks us to include all objects transitively reachable from any
    object in the packs we are about to repack. This is done by doing
    the revision walk mentioned further up. Luckily, fixing this case is
    trivial: we only need to modify the revision walk to also set the
    `exclude_promisor_objects` field.

Note that we do not support the "--exclude-promisor-objects-best-effort"
flag for now as we don't need it to support geometric repacking with
promisor objects.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c        | 14 +++++++++++---
 t/t5331-pack-objects-stdin.sh | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1ce8d6ee21..560b3228aa 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3857,8 +3857,11 @@ static void read_packs_list_from_stdin(struct rev_info *revs)
 	repo_for_each_pack(the_repository, p) {
 		const char *pack_name = pack_basename(p);
 
-		if ((item = string_list_lookup(&include_packs, pack_name)))
+		if ((item = string_list_lookup(&include_packs, pack_name))) {
+			if (exclude_promisor_objects && p->pack_promisor)
+				die(_("packfile %s is a promisor but --exclude-promisor-objects was given"), p->pack_name);
 			item->util = p;
+		}
 		if ((item = string_list_lookup(&exclude_packs, pack_name)))
 			item->util = p;
 	}
@@ -3936,6 +3939,7 @@ static void read_stdin_packs(enum stdin_packs_mode mode, int rev_list_unpacked)
 	revs.tree_objects = 1;
 	revs.tag_objects = 1;
 	revs.ignore_missing_links = 1;
+	revs.exclude_promisor_objects = exclude_promisor_objects;
 
 	/* avoids adding objects in excluded packs */
 	ignore_packed_keep_in_core = 1;
@@ -5092,9 +5096,13 @@ int cmd_pack_objects(int argc,
 				  exclude_promisor_objects_best_effort,
 				  "--exclude-promisor-objects-best-effort");
 	if (exclude_promisor_objects) {
-		use_internal_rev_list = 1;
 		fetch_if_missing = 0;
-		strvec_push(&rp, "--exclude-promisor-objects");
+
+		/* --stdin-packs handles promisor objects separately. */
+		if (!stdin_packs) {
+			use_internal_rev_list = 1;
+			strvec_push(&rp, "--exclude-promisor-objects");
+		}
 	} else if (exclude_promisor_objects_best_effort) {
 		use_internal_rev_list = 1;
 		fetch_if_missing = 0;
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index 4a8df5a389..cd949025b9 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -319,6 +319,45 @@ test_expect_success '--stdin-packs=follow walks into unknown packs' '
 	)
 '
 
+test_expect_success '--stdin-packs with promisors' '
+	test_when_finished "rm -fr repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git config set maintenance.auto false &&
+		git remote add promisor garbage &&
+		git config set remote.promisor.promisor true &&
+
+		for c in A B C D
+		do
+			echo "$c" >file &&
+			git add file &&
+			git commit --message "$c" &&
+			git tag "$c" || return 1
+		done &&
+
+		A="$(echo A | git pack-objects --revs $packdir/pack)" &&
+		B="$(echo A..B | git pack-objects --revs $packdir/pack --filter=blob:none)" &&
+		C="$(echo B..C | git pack-objects --revs $packdir/pack)" &&
+		D="$(echo C..D | git pack-objects --revs $packdir/pack)" &&
+		touch $packdir/pack-$B.promisor &&
+
+		test_must_fail git pack-objects --stdin-packs --exclude-promisor-objects pack- 2>err <<-EOF &&
+			pack-$B.pack
+		EOF
+		test_grep "is a promisor but --exclude-promisor-objects was given" err &&
+
+		PACK=$(git pack-objects --stdin-packs=follow --exclude-promisor-objects $packdir/pack <<-EOF
+			pack-$D.pack
+			EOF
+		) &&
+		objects_in_packs $C $D >expect &&
+		objects_in_packs $PACK >actual &&
+		test_cmp expect actual &&
+		rm -f $packdir/pack-$PACK.*
+	)
+'
+
 stdin_packs__follow_with_only () {
 	rm -fr stdin_packs__follow_with_only &&
 	git init stdin_packs__follow_with_only &&

-- 
2.52.0.508.g883dcfc63e.dirty

