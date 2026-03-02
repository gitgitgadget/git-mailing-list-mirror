Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B27366816
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 12:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772453610; cv=none; b=ZqMfwEXLA1TU+Xfw7Saoz9QQyLTU42y+wXnU9dfPNtkVC6QvjhzoJqxR8xzyM2Wm/8YzlC8lohH5XoxHW5RauaxWmt1Xxtb7wNC7P52chjQtHjoU6JUGxQVAmJAIKsCzErowZV7hIiMvE+6gU9363jnKWQ4CYQwr2rOHAqZcVfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772453610; c=relaxed/simple;
	bh=S6lGjCCQUBOVu2MVrSfREcQxToi56FKmO3yZM4mbHjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sRyCPffsc3aUwOvj1Za9Qtvy4RJ5V1g2MtmUxH9gphSLBoXhp+r8JzrpE7YMNso/qEalf7f7KAsq0nBFbDB3RKNAVaHoHblanrf6QNx1NE8feFUdZkBc1JKUaJTK6wDuAxqV/8L8Zq1A7VD/iEmErfWfFNG5GDkewdz0d2iEQTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JFSMbiET; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DKT/pwYX; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JFSMbiET";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DKT/pwYX"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id EB0FC1D00135;
	Mon,  2 Mar 2026 07:13:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 02 Mar 2026 07:13:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772453607;
	 x=1772540007; bh=00PAvj9w9rmviIVrF6FK7o00dQO1akon6rbqhxjMtsA=; b=
	JFSMbiET+SKZEbtkDd0iJhQGs3XLmJr2/lx1NY6TnLOutz+u/HG3O2s9ARpy0/UO
	ZbwjW0h95jjhu1NbzBgqZsovWhTs6mE3574HqlocVI6kAV1q/j/FHsjW2575k7yo
	H4nn8XmHYeKq7edzC9VS+B06ftRL5bUVaMxVCcxvU+0bkD6F7+2/MGiuaCmBNN9w
	mMfMbAia5HkfGcs+fn/RC1dHHTaxQqqXorPiyf70n0/5/ZZ7b08SGhVh0aUNf7mi
	A4GAjFB3VDzmLGR7eMAn8AU8QworNZ8i8D1iqKcYZbfwBxDNMVmhcy6m3LI48k0T
	fFu+Nj6ly4HAROuoiRq+Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772453607; x=
	1772540007; bh=00PAvj9w9rmviIVrF6FK7o00dQO1akon6rbqhxjMtsA=; b=D
	KT/pwYXKGG4MFfKTPHJxLSb4Xq+LUS5QEi+g8qEoeANnCuSyKBPlF4i12YJ6eHcs
	1wpZBbt70l3HjtTiPuQ18F6C2obfIfEJI/slYR4jQf1AD6v+iQezc7e/gZgeCyT4
	Aa06TPKoM2LYJunVFbPkLRf9iKmlnw+gXmBmN5ooxmJ9Pz/kwnhFBnfhq7ld6YPC
	gZ3zrhFydbtL8taAVcSYAjuDd+nGNq9nkf04N7zEhfb89p/7ydI6c03RLDeHnOBQ
	NwqpEUBXO1Awk8LZXUb0sBGg5A9KY3OKGcjgtfHCuUzJ10hy+M39Qrz0LSziiDK/
	2rPzYMFCPacfDjsY6+U4Q==
X-ME-Sender: <xms:536laUgPbiJC1Ge51lLHHUve3Rt_dL_mB_8QTis0RP9z0rni9pHBfQ>
    <xme:536laTDRiumpP3QO-h5g7m-jYRbFU8x8GGLdThOI3gaQvvNNwrTVnlSL4CDm6GS9T
    lJ-DtbYr9_o_oyGObdW9ksUY2wyrnoxcMFmvTyxZwxEWfHhZFBe25g>
X-ME-Received: <xmr:536laZsnldRJ2QPT2UT8q6a5T-E_RcXS9ymv4yNILTfQ_zYa5JoB4fGoJV4TWHQ_aim00uzUInCgznEwsqxxs5X_f0fXYtuXc1siyIJYTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheejieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvg
    hnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:536laQZo1Zk4xTG12iD3xO7xhzVYpK1JvMLejwtiJNO7JT7QyDUKcA>
    <xmx:536laUUsoT6ROAil3CHnXtIlCM2KWVRuA7KpagSWJoZ6wBjX-3trEQ>
    <xmx:536lac7CmbuNzUplpKROMffywqvbU57DPzqU6Eir1AxtTv89inwW7A>
    <xmx:536laXi4-RrFMclM2Ix7p46wlHnpZsxnvWVYhrft9VVW3hJmnGZlAw>
    <xmx:536lacS-5kdSrmdsRSZPuyvF-x441hIuZmwwdGThiqmo8vZoRv648hso>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 07:13:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1b133bb7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Mar 2026 12:13:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Mar 2026 13:13:10 +0100
Subject: [PATCH 6/8] cache-tree: allow writing in-memory index as tree
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-pks-history-split-v1-6-444fc987a324@pks.im>
References: <20260302-pks-history-split-v1-0-444fc987a324@pks.im>
In-Reply-To: <20260302-pks-history-split-v1-0-444fc987a324@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.14.3

The function `write_in_core_index_as_tree()` takes a repository and
writes its index into a tree object. What this function cannot do though
is to take an _arbitrary_ in-memory index.

Introduce a new `struct index_state` parameter so that the caller can
pass a different index than the one belonging to the repository. This
will be used in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/checkout.c | 3 ++-
 cache-tree.c       | 4 ++--
 cache-tree.h       | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a8863277f2..f8b3a7b08c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -891,7 +891,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 					   0);
 			init_ui_merge_options(&o, the_repository);
 			o.verbosity = 0;
-			work = write_in_core_index_as_tree(the_repository);
+			work = write_in_core_index_as_tree(the_repository,
+							   the_repository->index);
 
 			ret = reset_tree(new_tree,
 					 opts, 1,
diff --git a/cache-tree.c b/cache-tree.c
index 16c3a36b48..60bcc07c3b 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -723,11 +723,11 @@ static int write_index_as_tree_internal(struct object_id *oid,
 	return 0;
 }
 
-struct tree* write_in_core_index_as_tree(struct repository *repo) {
+struct tree *write_in_core_index_as_tree(struct repository *repo,
+					 struct index_state *index_state) {
 	struct object_id o;
 	int was_valid, ret;
 
-	struct index_state *index_state	= repo->index;
 	was_valid = index_state->cache_tree &&
 		    cache_tree_fully_valid(index_state->cache_tree);
 
diff --git a/cache-tree.h b/cache-tree.h
index b82c4963e7..f8bddae523 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -47,7 +47,8 @@ int cache_tree_verify(struct repository *, struct index_state *);
 #define WRITE_TREE_UNMERGED_INDEX (-2)
 #define WRITE_TREE_PREFIX_ERROR (-3)
 
-struct tree* write_in_core_index_as_tree(struct repository *repo);
+struct tree *write_in_core_index_as_tree(struct repository *repo,
+					 struct index_state *index_state);
 int write_index_as_tree(struct object_id *oid, struct index_state *index_state, const char *index_path, int flags, const char *prefix);
 void prime_cache_tree(struct repository *, struct index_state *, struct tree *);
 

-- 
2.53.0.697.g625c4fb2da.dirty

