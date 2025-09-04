Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DCA30AD04
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996079; cv=none; b=quyxTJd6xkjYPQe7mR0yoQ9QNhu2YnikVRNKPRFieh0meZ69FKmekmzmTRYvHhFHXGVgnRLvHZDpb+eKaCbD91PmJ9GfClZTV5CGZqbwDOnK9GezUzVqTYM1c16j4+aZCVg0TU+iVCaASsz3i6gGH+R7593ps8r05DsW4ZjKJcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996079; c=relaxed/simple;
	bh=+YFEwx0wgOljuJfPW3ko+KmLFa4QjQ41vUeENMI2TzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LKnGEsDfCRaHAf4O+i9v3xWOs3mfVsBEsy9Wt2ujngUUvB8aOq/i/qwDhaZtcydbqqoEobR5QqcUTxShD7GJeQBSopvnazDSNAYB9bKgrqvx52M6DN89pjY349S5AFrAVlxmzuvqTLQ2OfomxNCuNGCkmiI00ANGK2N/i4exC0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AG52P779; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C6LwcF6G; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AG52P779";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C6LwcF6G"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7984F7A035D;
	Thu,  4 Sep 2025 10:27:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 04 Sep 2025 10:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756996076;
	 x=1757082476; bh=S4gzwDUhroApVGbGUN5+DClFkxx60qQByfnL2/4jcGs=; b=
	AG52P779vsb+pGcoXR/8LKg+QrGB+B0kjGI3bhNSE3ZOiQgKhCfrDWHDnyn2g/IS
	9w6k3eJlFSqgCRe+HvlUy/vD4BgekHQ5ihZYphkkda8ZHvG95eugzOifqK/Tn1GY
	xRRHS0mgLyIKqv6ZvzQ43ESilKLrQCZ2LuTr2M0skUZTQGtGl4YXVoTkUBx5jkVA
	XSv1skmJ+ZJyb57So2W3vg3A9U7d4KDIOacBVo3QMQM+oueKIyERE/TZgq1+zaox
	lxVhLuv/6cNXZMWhSH+dfVc8ldQwhGS7sl62znqm58l8IgL1tyaQP2KvfKn+2YS5
	KzOvgLUcLNcTdnvw4ERxtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756996076; x=
	1757082476; bh=S4gzwDUhroApVGbGUN5+DClFkxx60qQByfnL2/4jcGs=; b=C
	6LwcF6GqXGw2MM55XruU7sJPd9esu7ud/eYVS/s4MdZC6LkMXmDYxiWgUEn6ni36
	4xrR+LXtwfLme1GaoTiC70YZotekTa0zF5Pv+mQaFDWXFH6aUaqMnr1hQ/FTZK/0
	XkvEJe/2Sr11lLzmiScdqNTvteb13HWj/yIXISsRWjWsyo3xtXoFluaONIl/HGuu
	FupiPoUTHl024QTsNjmv9uab1+IaFjtJWzCunMbkUpKvzgC9IomQhj1Ku4X4zhHv
	dNqRyRtGK4+E9+nDxMX0veHwOW3WX028HtBTt3IurSpZOhMHwLzcGKD1ZBT6RRDO
	0e7kD3d8+YOy+WS4bFPMQ==
X-ME-Sender: <xms:7KG5aNSUOf0hajRLjDYaX41ZWVQSp1YZoD28piEzeCZNc6twA7UB1Q>
    <xme:7KG5aEWy7oPvKsjtWH3prksLnxoP0xNy7rBgMf3Ivd0azGK63ZMyMMnHH-sFDpuZ7
    RvZpJoPHYxkd7hZAA>
X-ME-Received: <xmr:7KG5aJRTF10gldo1ZJRsje3KRRk6EltKU79dWLVYq0pd4EU9NVjRy9wq2_RvK05tw4XOTHcQDiPxsGwBjmJy6IWJm4uq4vtpQe3uDeF4xGC73w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhr
    pdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrd
    hknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:7KG5aGliKkRxdOz6joT0fRbA1cb7WMLg-6oAKhOh1fLTATkmt9htVw>
    <xmx:7KG5aH6cjzNW-NWPWDga8pvCS6OVOuYgX5kY67aiYg4kiO7qk7KP9w>
    <xmx:7KG5aEgxwfbEwzjPfijMdDc6AYhUsVTDYFn-xBk7Frb8j2GieIT18A>
    <xmx:7KG5aMGmUQ_6SR10R4vBqH9qLxo8UN1Nzl16mg4GkiC7Fjvm7rkIww>
    <xmx:7KG5aKMK0NGaNwOKcIo-ztYSlObIDsbWyHXtUeXe0Q4hdMZZKdrOnk3q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 10:27:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3fec013f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 14:27:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Sep 2025 16:27:36 +0200
Subject: [PATCH RFC v3 06/18] cache-tree: allow writing in-memory index as
 tree
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-b4-pks-history-builtin-v3-6-509053514755@pks.im>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
In-Reply-To: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

The function `write_in_core_index_as_tree()` takes a repository and
writes its index into a tree object. What this function cannot do though
is to take an _arbitrary_ in-memory index.

Introduce a new `struct index_state` parameter so that the caller can
pass a different index than the one belonging to the repository. This
will be used in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/checkout.c | 3 ++-
 cache-tree.c       | 5 ++---
 cache-tree.h       | 3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f9453473fe2..43583c8d1be 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -902,7 +902,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 					   0);
 			init_ui_merge_options(&o, the_repository);
 			o.verbosity = 0;
-			work = write_in_core_index_as_tree(the_repository);
+			work = write_in_core_index_as_tree(the_repository,
+							   the_repository->index);
 
 			ret = reset_tree(new_tree,
 					 opts, 1,
diff --git a/cache-tree.c b/cache-tree.c
index 66ef2becbe0..029ec933abe 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -699,11 +699,11 @@ static int write_index_as_tree_internal(struct object_id *oid,
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
 
@@ -723,7 +723,6 @@ struct tree* write_in_core_index_as_tree(struct repository *repo) {
 	return lookup_tree(repo, &index_state->cache_tree->oid);
 }
 
-
 int write_index_as_tree(struct object_id *oid, struct index_state *index_state, const char *index_path, int flags, const char *prefix)
 {
 	int entries, was_valid;
diff --git a/cache-tree.h b/cache-tree.h
index b82c4963e7c..f8bddae5235 100644
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
2.51.0.417.g1ba7204a04.dirty

