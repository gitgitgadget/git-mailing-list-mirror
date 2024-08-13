Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1595818991F
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540463; cv=none; b=uxeaY1taSyuNQZa1RfszueDwLLSUQUZobIN9TXGJdAcDvJO7S6AlyzLON13yBvD/LozWmWhVOzwHmGIO1i7UXwSuWGW8IgMsvDxlXgMKVVANCYEI0mFAsJIJd7glLBS6i7I8tbm6YKm/QYf8Tipe41sp5mqAitEhc6BNOrd8k5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540463; c=relaxed/simple;
	bh=TFyZ/b1npDX+JKwnwotH9hxBjjaaWL468V2GggrNXAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCL1BYzwbrrYubVcXzqhsL/pWqRzO7tKNpaWBkYNK8sN3mr5Puf0auhK/ZYARmQ/VEXZnqktsn3oFpMH3dp7IInmVHYk3fslOEUPvAMnm6cmWQc2+xD9ehp+5aaMXpkCaMynlDy6QIOwuB3He4ETKnLC54gFqmZzJnU0vjfVydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QLd7NW+c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P2ibVGc0; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QLd7NW+c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P2ibVGc0"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 25F7711519E2;
	Tue, 13 Aug 2024 05:14:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Aug 2024 05:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723540461; x=1723626861; bh=nlb5x+Cknl
	MDZbmdgpGY4wVilZNpwJvB3b3/DzG53as=; b=QLd7NW+cJhq2KeZwEbzpT9D60W
	z1KGlsP8O9zm5ZmE/hquEfWa2ETubAdZEZsYkB3ife15ctK20VkwOhM7RwdAOQGa
	+l69wQMtwZq7OztQH97WzJeyvcdzaeDv64vRDLNrU4C7pu+ds+ND/86M6fhM6DCE
	TuV3sbnO+2PxfK+e3cgFfLAHNdEc87nBJ13mJoWvkkl6MsV1OjvuCB9Qvg98345E
	W4t2+Wumc/FQf5YBv9ppPK9NM2jJuLKp4d1Xl2K8sL3zVs3IVnkSdc59RKFaKSzr
	NCuSNqsaPLsI8kqUTgxyXVO593/+wVnL2tK0hs4Oji1MYLW1KaBIy8uJRFrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723540461; x=1723626861; bh=nlb5x+CknlMDZbmdgpGY4wVilZNp
	wJvB3b3/DzG53as=; b=P2ibVGc0su7dXVtxjqRoXfhnUjXWPc6yoDJGC2HmWDzV
	BU7v//9sWTmIO/W9MtYBz23mj3UFH7n/z+T7uTtzC9pMPwr0DIKcy/Wr3/Ugoy3D
	deNFSldwRnJpoil3bJydgYhVl5KWqnNOxf1jAzlZcEHI9Ezb6yOB4qhTsxU7d2P6
	Zw74TastDzYos74kXP31X+6QDU3NYgMZ6uA2NZ2drZb8Utkjlz8+UFI5RlvLnIZ1
	UYTgEUQzBFr8sGwKCcF9sXDmukzegkI4UQ2fmZrG2nRrvkOoCpVPmSfzlsglw2Y3
	l+LcP66oaF4MbnHrs6kaC7cNLBKCfjZ4mn3CPDoFlQ==
X-ME-Sender: <xms:7SO7ZiNbsa81J6dZ6Q5-899amlUN1JoieezQsPF6CmLZid41hhOv4g>
    <xme:7SO7Zg9cn8xaVaTLxbtBGERqmjS-Y0YinDXNCQSeylyjSi0ZPbHYY96fN2Uv7ABwc
    Vmidj3N_Y_b61_Yaw>
X-ME-Received: <xmr:7SO7ZpQExCPmVonJ4gy39AUiWvqMa5TozTXdp1YuCSLTT8WNaVjcYKJEGeQFQvGnq3bnMahYyey6ZUqinKbPn90aCCCe9PJ6AOfTVlIWb0fUVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:7SO7ZitX5ivuILUYnmJeeDOwF5ekCOIylbji4csXI7xSNdGSBg4EmA>
    <xmx:7SO7ZqeDS4VWl1HqHOGXpofvMlGFSQbWLhiaemDdyVvwOfMtt0O7jA>
    <xmx:7SO7Zm20SUqfDFQKEaS9GAY1W9GS5bRSvPYVfi1Z0MsGOnHc261sIQ>
    <xmx:7SO7Zu9RlSad2JLlEhaSKpHGuFjNrbrl81edXyWfoangsqk1D-bLug>
    <xmx:7SO7Zq5a-QbU8ExIi6vCNIzUEUldvcP4jnW_sqm1qDsRjh43QadOAgcF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:14:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5c1ca70a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:14:03 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:14:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 18/20] config: don't depend on `the_repository` with
 branch conditions
Message-ID: <96963364e75bb7bbeff0a9be3269b372fdf9a577.1723540226.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
 <cover.1723540226.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540226.git.ps@pks.im>

When computing branch "includeIf" conditions we use `the_repository` to
obtain the main ref store. We really shouldn't depend on this global
repository though, but should instead use the repository that is being
passed to us via `struct config_include_data`. Otherwise, when parsing
configuration of e.g. submodules, we may end up evaluating the condition
the via the wrong refdb.

Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index 831c9eacb0..08437f75e5 100644
--- a/config.c
+++ b/config.c
@@ -300,13 +300,14 @@ static int include_by_gitdir(const struct key_value_info *kvi,
 	return ret;
 }
 
-static int include_by_branch(const char *cond, size_t cond_len)
+static int include_by_branch(struct config_include_data *data,
+			     const char *cond, size_t cond_len)
 {
 	int flags;
 	int ret;
 	struct strbuf pattern = STRBUF_INIT;
-	const char *refname = !the_repository->gitdir ?
-		NULL : refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+	const char *refname = (!data->repo || !data->repo->gitdir) ?
+		NULL : refs_resolve_ref_unsafe(get_main_ref_store(data->repo),
 					       "HEAD", 0, NULL, &flags);
 	const char *shortname;
 
@@ -406,7 +407,7 @@ static int include_condition_is_true(const struct key_value_info *kvi,
 	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
 		return include_by_gitdir(kvi, opts, cond, cond_len, 1);
 	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
-		return include_by_branch(cond, cond_len);
+		return include_by_branch(inc, cond, cond_len);
 	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
 				   &cond_len))
 		return include_by_remote_url(inc, cond, cond_len);
-- 
2.46.0.46.g406f326d27.dirty

