Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBB52874FE
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334304; cv=none; b=UCSSMR5dS+YGWvN2zFQkFQ2n1WYdH6+i+Snd9ZMJpifnzDM99YzAjkqYYywxokxDZnSlnhOsRnW7yKsdHHnN3SnSfcgWP55CV0UqmVZ9n/q0KwNcBTSnTv1z+c77amyHmvnHat9dXRjXQwa0ui9XuZZvi1h6C/w/GN3+ccRCt7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334304; c=relaxed/simple;
	bh=Zx8A3SazfkJmMOvWyNRF4MxGN4N/XlGubRZMCWR6Kp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M3SFSejXb7/v0kKTusE8WcOhg2EKpY4kpDJUP2dTcl9cGQ2aPBbUOAxbzsU/VZlfNk/dLKlPdua/P1wUGKhmcpFg1HnFImjUv+QuTlgI7EB/rLjVgjvfAomGR67rBlvvqhIlqukmtDEBX5joYh8Pk1E7A43ip09kcLUvsMORc6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WvkJMhnq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OprfjUZT; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WvkJMhnq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OprfjUZT"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 89D4D1D00308;
	Wed,  1 Oct 2025 11:58:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 01 Oct 2025 11:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759334301;
	 x=1759420701; bh=Wvs8FIvuie0XF5Py9SOHJbjKQi96DbLTjAtZczFIMpw=; b=
	WvkJMhnqxgmHZUf6+41hfvFEH8AF8FJPLL/tTWCI6DGU6oGt2i6/60qvJeiQddGJ
	mR7UkRjYxeN5AGhPrcLtmhZRmEGfFR/v95MOD76i1Q92vU5XMxqDfqzYY19/HBsX
	vxQ1rOFUhxhKKR1h/YmKE6yyjLFCb7yyFEl/K8g3ScZ4O4sWjnZ+iZFRCUdbJq81
	GuBzoIvDSDK0bC8f2wnfPD86JsVQluEyKs/LiTV8FWcBt+Y+Jgo2Wg+yTM+XgyZ0
	VEaGcwQXuOe0l1xhTgI5XSXrL6ZenkSl2N//OyDqRuNxMYmF4c49DicxNuXG6akz
	7RRimQYe+gsdgSwBMvxrVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759334301; x=
	1759420701; bh=Wvs8FIvuie0XF5Py9SOHJbjKQi96DbLTjAtZczFIMpw=; b=O
	prfjUZTrPieEd74LXKhoxbD15Y4ijY1pidVxj/MWUwmIfddj4OPEUrp043JYPml9
	eRwHAcVXOX9ECcFTjNldXNYlKjhThQf9ppSyvhKoCT4a/f/9s/dUWPBReFjsdd9V
	GLnhD+Wo6Zhr8C6VJxkmARdPZhzicNyetqqVK+EYW1mIsKZJbg7Y4FWqJh9mOz1K
	HxYA3qvKBdrL0WUHXjSEy5Tgm6jcI2MHPHDsrzKRgWpYc6TnojQOJZg3dP/dAYX6
	qAjVMxPPA0bxB53LXw7RvJJdVEQ1COymJpFdRycaYyR8lwBzvy75F7LuT2Rd+93J
	9Kl54N4maBPHlTUc+LTTQ==
X-ME-Sender: <xms:nU_daOiTiBnylJ8MenpQcWK0jk5ng2RUsXXZuy4pCE9BAEkZpfCB6Q>
    <xme:nU_daOFkUqyl8fvzUyc0Gxbh5f9mYzgtbAuv-DtlzkRk8tWTaxZhWL4SBDwYC5pJa
    FegPCud7UAUvxD5gEGJZIqTbxzdpDCQ0h6Tls6Aue8cWEpZtaqU>
X-ME-Received: <xmr:nU_daMTXrxaVgNTglOzYkQfRG4vRhp-NK5z-xpntKYbg539mjPZXaXI50VRUkpx-u5n8Y7NAvgMXC4lALVhkj9FEUDc1YRZokMpKCNynyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovh
    esghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehf
    rhgvvgdrfhhr
X-ME-Proxy: <xmx:nU_daDwUUvrZCA7zSv4veXRS-Lp2s2ThJwrZtjeCEHb-5QCcKaFACg>
    <xmx:nU_daAcUryoJDoroi3sMNch0nbvpjO1UmfNPAtH6kVEERxQlmOVFXg>
    <xmx:nU_daOPOteFvcnE6bI-HnxOE1TCC5ZL1mRNP8oV3SzT4i8W9W2J4Bg>
    <xmx:nU_daDtZUIjusyCQQdjuaqh9ROk4-Q_goMNBhPCocyQ4GnQKKktMnA>
    <xmx:nU_daP-51z_-031EheiLpBNUijCzKBRgbegbFnd9W5oZPODqiXMM5-Bj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 11:58:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9f51755e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 1 Oct 2025 15:58:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Oct 2025 17:57:37 +0200
Subject: [PATCH v4 11/12] cache-tree: allow writing in-memory index as tree
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-b4-pks-history-builtin-v4-11-8e61ddb86317@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
In-Reply-To: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>
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
index d225554eedd..1fe03605225 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -700,11 +700,11 @@ static int write_index_as_tree_internal(struct object_id *oid,
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
 
@@ -724,7 +724,6 @@ struct tree* write_in_core_index_as_tree(struct repository *repo) {
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
2.51.0.700.g236ee7b076.dirty

