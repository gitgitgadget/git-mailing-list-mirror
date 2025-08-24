Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE6123817F
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 17:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756057391; cv=none; b=LRQyAujGU/tvqpX3zHeVxusEZdY0lNgnCgR3I142Dc5zpyFJI1ZtN1DrnxoDi22FLG7Mrar+GgbJA8DBRZvMGYgohBIfhBTOMUl1b+Xa0HEBaDrzjc91qD3PRS4iYi5jQyBGxP7VNN+TNIv+hMgxU/IaiIFE5S0gRBanluxIy+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756057391; c=relaxed/simple;
	bh=JYGe9ugfz5+xdwWzP3W3Www3KS1a4JEQzfX5ypTYKjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YmjDj13zAFgPWHOstQasG8wza5UYwZFjKJkPL+ck1HTbr40f9PFEni9dwAPur7HEc3kaJCqrYfLGEWAs3Fnbcin5aKO2+V1ecDYR3DOfPI+VHOuc/azx9bALxZllN6POqxKEdGR0HkQDzvTAe/6gt+01NoVOKO9DmNiAKtGz1B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RReZF+CH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eaPNtTMt; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RReZF+CH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eaPNtTMt"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 49F037A00C1;
	Sun, 24 Aug 2025 13:43:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 24 Aug 2025 13:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756057389;
	 x=1756143789; bh=ict6gecSN8LkEhaF7/1aAkynq3bhBiG3TEH/NA7Zk6M=; b=
	RReZF+CHTHl+zobtaFts+3lR6sk9B9BRMqBEa0D4hOYVQS19tSlVXC4tswJA/A7j
	LRzkMhYki+YO1owhFnxo93Evq6LvW8cxLfHoAFej5YqOpQ3Av4pEaCXjBMLQLQcM
	zjJKVXacvMPrpTotDUL9pDn4zKp8WobFzxs+Whuv9K8WRYSo7+VJQhgC9xWt6Vz6
	0nUcJhGiedsPhHNTi1DcTa6YXkuLBW3DIHRwmqQ2eSobBhwJFORWdjrGkitIbYXO
	hWfMqq4hg44PXCivjtD1CBc1qovs8paA9cuGHVBYQfHa2m5K39r/hsh1RXTKIy9B
	4hqhXWoPZ8N2/vBZh1xFQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756057389; x=
	1756143789; bh=ict6gecSN8LkEhaF7/1aAkynq3bhBiG3TEH/NA7Zk6M=; b=e
	aPNtTMt9aa6ZWolRxleke15uIwLB34gY+YTfer0KLgC6n4v1J9ucrxaeKYXBQoyR
	M7zvMkpvg+WUD2Cpd8QRIYM/fKtDq6kih3J+GluzN19TcwtfThowoiC9hd+MS3Qu
	BDHp8BBVvOVigvtADJSAtFjaQVoa/ow52efCrg8urS74fLBie++doO8jiUtJX0gu
	jqLUGO6MhsXMod+Mo1qbfswtE41uQuWCL13o4h5YSIZLrHcIuL/4OOHLzHUj7rOf
	YcorNghSOBWLSTwqb5hn6htWpEqYeldtnTy9eeAvppsIj45md0+vbJqth8pSZGu7
	RpDlehS9RITrh2trDzc0A==
X-ME-Sender: <xms:LU-raLhKDtltYqjJNvjl8OhF0oTrSzaBzGeUTeweIZNnckLfycAugA>
    <xme:LU-raFn8Gp8bHNDAxpjMgnlKNs1SxfGA79RpxYPepjWqBrZeANrECfedFTOCcjoEh
    gQvc6GGmfbQcpHLLg>
X-ME-Received: <xmr:LU-raBjW8FsEfxWKem22yJq-gtyyrmacap3UpLp_2diHtDs19-FYmOHY5jz6u2At0lQyU9adPRN_9hUBFg_mnk-H8fcvfzMfHm50we5k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LU-raJ2MufuHPqZG6Q96A7faH-sDYK_jj4l3UCxrVLGVz-sXl8G7dw>
    <xmx:LU-raKJMX_sRgc0_tDJKpbolfYfDHMVKcAcyzgU2PQpfmjF4Y1T8TQ>
    <xmx:LU-raJyInzs6-_c70tLT1MumDKR216oosWl51XxWQp4SBvMyDJfybQ>
    <xmx:LU-raIVN4n1QA8AQS53h55sGzJk2Vsd13tgkSb_1J05ceyDfE0grJg>
    <xmx:LU-raLci07LThEamm2T4Dsm-_JPs89kAumZOrLDoRDMpE4abX7Na090W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 13:43:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ff3c439a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 24 Aug 2025 17:43:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 24 Aug 2025 19:42:18 +0200
Subject: [PATCH RFC v2 05/16] cache-tree: allow writing in-memory index as
 tree
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250824-b4-pks-history-builtin-v2-5-964ac12f65bd@pks.im>
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
In-Reply-To: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
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
2.51.0.308.g032396e0da.dirty

