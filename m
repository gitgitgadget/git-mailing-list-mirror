Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4020D2F83A2
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 11:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564875; cv=none; b=bPrw0bcH9nCYQ348STTYESnpzih+bV5FlusCfRMhYYECjgdgHJEitVD+EHG1e/7LzUKK+yVOfKOo2TFQBia4GH/9SsjGEqw/UP647wmgfqEC/kCBvDyL4BcLDQ8WGg36Z2cDSrqbqlEGtVe4dGDxLm77f74fwO67uk+MjhntbAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564875; c=relaxed/simple;
	bh=oeRfZnb9Nu7hNmkxBH/yk0dd2gLIyiDrUevBbIUwOho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HOYu7pQlQQXExxfOfThWas52pFV2axmes8cxVYdR4EU0vF88vDGIVtCE6iZkC5IlSpUIIE+C+CqvtfUOy/0x+78+wh2pRzREqguom95Ah8iSuAsLnOqucvyeqGhTOxEQJuEHOobH0ypiO+KPu5crGSs8UNCat1leURaZCiF33kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fVDvvCPs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=frVzz9Ar; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fVDvvCPs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="frVzz9Ar"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 63E17EC031D;
	Mon, 27 Oct 2025 07:34:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 27 Oct 2025 07:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761564873;
	 x=1761651273; bh=2fHihBOmUAQJYi5Ef44SAr22vtLSZ1Dd9ibyI9YKYIA=; b=
	fVDvvCPsGSRXJtz9+CsDM8nRkitMSofjKPyULjH+0VR8cABbydX2ERl+DPu0xg7W
	ZZ1Z4wdJhiv9CmFghTyXQMu+at8g+WxJ1AhAT7vmokxJfNVqUZAoR06qrz+JEmnw
	TJZM0AnHUlaAeMW84ZeTE45yeCzv+PArf1DFC/BOjs2q7OuwAtHrOYCpDXhv8OaO
	d7MapEjARSnzO+DYjSqqRQmPXJ8QnZV+6PiAeGS0FUtS2BN45CgL4S+7SawP7x6v
	3o/9YMODzrI0orxnRuyZR+J7I5HsTv6woWSZ05+xHQox1axJqWgjJeXmwv9B6MzG
	zlcHZxowW8ZdnsHHNqekig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761564873; x=
	1761651273; bh=2fHihBOmUAQJYi5Ef44SAr22vtLSZ1Dd9ibyI9YKYIA=; b=f
	rVzz9ArbqCDI6oBzgJyTvZ0QJ3RrLcwIle/81FJZMpXKrAyfTS/wk48ICV9tyJ8g
	rxxMw+GvKTzJZgALbrgHcfjcBHOd/+O4TEk18l7iZHC1oh4hZubwK6n6ry/KD/Gk
	PowjL/tlX/KbdoxXa49ceIHynYs/a0PhM/pfnjSwG93jMLgJYJLt56DGOa0v83eE
	M/zsaSjSWcW3LAdzQH/kvvgzmk6nLIo85KWkzhy5La+qYGZMSF62wvDuSYmqQAWF
	jxu973iZhrxvPNXSn1JTsnHdE22ViT3Fzucw4h2ce5zXJKnpMJ2QyMvRtQ0Tcmh6
	wmAuTu7mwSOd0iCi9TPIw==
X-ME-Sender: <xms:yVj_aB0UObxKljh7aV4KMm-UsaeIWO0jQbt0qj4kLi-GNRP-LNrsAg>
    <xme:yVj_aKp-z0-cwpp__TBq0hjDYs2hhLINX42OvJfOO666pqB6AHn6BCcWQMDMTMkEL
    93NRQnNpzwMrOaoXzcdNo2dJIQbtV0SxhPoO4hAnnFh_-SrWf_I3g>
X-ME-Received: <xmr:yVj_aFh_-x7KxxJePX7xkg7-FspJCFqsNIrVRH1Zb2J7CGvK2vhxsTG1ZYJsQQVamaOPdOwCD57SHCcCejvJ9wPNvfvjLaBG0o2somZe-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrh
    htihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghr
    hhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtoh
    epshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:yVj_aO_9KuifRA3jXjiI3I5ijSXXeWFGrZuB-Ks4b-KSHRJZuWTYZQ>
    <xmx:yVj_aJUIR1amya3CiAGDU43uBuQr7KJ47_mODRv_alvzi_z-iHmghQ>
    <xmx:yVj_aKA78r4tmJum-htX-RmdAoMjTK29YJXh3nVzgpEX93nK-kj24w>
    <xmx:yVj_aGEfPG90XwClngK_r9Omz0JqbbVDrAHDvqfdfCO7L9DvjZIkfA>
    <xmx:yVj_aEjyFQ_SOn627bfsh5TBo0Q1Bj7r8JmoY0JQNlLHx4V4iRxPFh5F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 07:34:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 71e383b9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 11:34:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Oct 2025 12:33:58 +0100
Subject: [PATCH v6 10/11] cache-tree: allow writing in-memory index as tree
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-b4-pks-history-builtin-v6-10-407dd3f57ad3@pks.im>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
In-Reply-To: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
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
 cache-tree.c       | 5 ++---
 cache-tree.h       | 3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index d230b1f8995..0b90f398feb 100644
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
index 2aba47060e9..b67d0d703d2 100644
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
2.51.1.930.gacf6e81ea2.dirty

