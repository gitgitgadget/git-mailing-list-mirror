Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C5118FDB4
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540444; cv=none; b=HtmCAABobvarl9dU/6jD4ae0MAE9QJRY7HBXRFz6hJ8C+Ot/Y9ekQXwSdEqZCQ4jMCgjPQR0MYf1Az106D/sRAq21QRVyOIDp0dEOMGN5htP7ROCPaY7CtQVox5HxxsUXScEsN5tiiUCLuGibjHq24xW6hHAHVcFipDoyRsu+YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540444; c=relaxed/simple;
	bh=wGnkQEbPQt5xiNsTYyKqVM7K+xawWo8C+gyzvjyMCGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0b1nf8IAu1+1aF82zQsRHiBtmlh4DHkcvcq+bDY62NqPegqE1yTCGpKC3ButRljLNwYksCN035lOOaiyxibm9GjRFzuw5o7U/Md8O5pJgjVNcimpe1hxM1talplT/1MjIJGwDxrjepxFJInLc1PL2/o4IVWahprNo11prvh45E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DQKYMn1J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NZk9BTf4; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DQKYMn1J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NZk9BTf4"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 46D4F1389D07;
	Tue, 13 Aug 2024 05:14:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 13 Aug 2024 05:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723540442; x=1723626842; bh=hNglt+326e
	/ioZE/3bX2D9q7gOFwv1B6eN5eVR8W4Vs=; b=DQKYMn1JxdLNwapsnAwNGV1NqB
	fcTZ+JPBpdqKWx5qG4j+aC5pYWbbr48cKkOLhyf1I/b5861U16WIqWu75oNZK1/c
	dqwrXfW6ybiyJ1nHCgSOe1oNcDdHWTUb2I9WqaBQvgWLgEpOh+GMjWPZ+6s2B2hv
	kND49ejigbcsIhPBqdk+sA1rM77SuSa4SrcTsBsSb3iUQTBoN5rMq2Zrs6qtsg9h
	EjerozqPRWgVfiYxf5Vs8j9BpRJTbvQERQ4qFtzbUkop3tf0LVE1u19ItlGqLg/2
	om4eU5oSNT+IATpb1KZ3qh4vNY/RicSe+xgLfpg0TzjJcZCUoC/p4urMbnKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723540442; x=1723626842; bh=hNglt+326e/ioZE/3bX2D9q7gOFw
	v1B6eN5eVR8W4Vs=; b=NZk9BTf4HW3iRsV9wmvc55kQxO9IGiFGriOTHLd3hfHe
	NagF9X6imXAkqhmJ1XKFplOrVArX4UJ4IPNKpzCSSKLinO6U9wIY95zHuapv5DV/
	ruDuST4zNFs5j5wK+4a51eYq8b2nGaKS/VU9Ns9hUnDTUSH0o94kOs8J92k8ZfLf
	Ubr7LUG4s4J7hSoQX+JNcRmWKUz3CmIQ1IkKwlOk7CY9HGAxUKMoYsYTC0Cj0G22
	d5SDB2q11Ytkzjdcceir2pAqyQRVHsVcWndkRU22Kg0OrhNy1fUch4ASggLDqMoE
	11f5YG3SO5658ZRayuSZJMPvlJRuJgg9TstjpAv3Qw==
X-ME-Sender: <xms:2iO7ZgSuOzNnDRH1pBG-_LSv6ffq-AE01yv5W2DB0ygNt8MOOw0FRQ>
    <xme:2iO7ZtzLZprDk_6kCXuuxhzGYR2P-RAs5CVC9k4DvqRAKrb7eWYW0ksruh2CVkbO_
    2VDDyfvoW1HKcN4Qw>
X-ME-Received: <xmr:2iO7Zt3MHMcqVVtBrpq7QbE2860sv2Hd7v8jx0VMoZtNzeH7FsisjSZ4opMau3SGgguofwTAS4qFFk9XF7_YIij_y09aMJt89l-uTybkOezmAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2iO7ZkA08W1PTwbdFC2eAYVLgyWV39HKRTQXAI8BnZaL7xnSCyfAIw>
    <xmx:2iO7ZpiD6GuRHU58jDqe0rpAoWTH_PbbkAJXl5h96T7XC2StkIw0fg>
    <xmx:2iO7Zgo0QXm4ybfxh_2VzPAfUqIKgnVUt3n4QyseC0bPrdUPw5k3iA>
    <xmx:2iO7Zsi1WU1j34VnRtoBZLjZ631Bc5E7Y0Vw3A36Ns_pZIShRGxJ6Q>
    <xmx:2iO7ZutQ1MHztYion4fqnawBI_9mtHCyGd3Ub9t8aiRaEuMY0IECysyJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:14:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0552e414 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:13:45 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:13:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 13/20] config: pass repo to `git_config_get_expiry()`
Message-ID: <f39d4a32440dcebdad6084f570723d967abbde17.1723540226.git.ps@pks.im>
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

Refactor `git_config_get_expiry()` to accept a `struct repository` such
that we can get rid of the implicit dependency on `the_repository`.
Rename the function accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 6 +++---
 config.c     | 4 ++--
 config.h     | 2 +-
 read-cache.c | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 2ca6288c6b..dc87c65906 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -167,9 +167,9 @@ static void gc_config(void)
 	git_config_get_bool("gc.autodetach", &detach_auto);
 	git_config_get_bool("gc.cruftpacks", &cruft_packs);
 	git_config_get_ulong("gc.maxcruftsize", &max_cruft_size);
-	git_config_get_expiry("gc.pruneexpire", &prune_expire);
-	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
-	git_config_get_expiry("gc.logexpiry", &gc_log_expire);
+	repo_config_get_expiry(the_repository, "gc.pruneexpire", &prune_expire);
+	repo_config_get_expiry(the_repository, "gc.worktreepruneexpire", &prune_worktrees_expire);
+	repo_config_get_expiry(the_repository, "gc.logexpiry", &gc_log_expire);
 
 	git_config_get_ulong("gc.bigpackthreshold", &big_pack_threshold);
 	git_config_get_ulong("pack.deltacachesize", &max_delta_cache_size);
diff --git a/config.c b/config.c
index f1d2fb6d4c..4138dc50ce 100644
--- a/config.c
+++ b/config.c
@@ -2766,9 +2766,9 @@ int git_config_get_pathname(const char *key, char **dest)
 	return repo_config_get_pathname(the_repository, key, dest);
 }
 
-int git_config_get_expiry(const char *key, const char **output)
+int repo_config_get_expiry(struct repository *r, const char *key, const char **output)
 {
-	int ret = git_config_get_string(key, (char **)output);
+	int ret = repo_config_get_string(r, key, (char **)output);
 	if (ret)
 		return ret;
 	if (strcmp(*output, "now")) {
diff --git a/config.h b/config.h
index dd7127b8e9..7674617a1d 100644
--- a/config.h
+++ b/config.h
@@ -715,7 +715,7 @@ int repo_config_get_split_index(struct repository *r);
 int repo_config_get_max_percent_split_change(struct repository *r);
 
 /* This dies if the configured or default date is in the future */
-int git_config_get_expiry(const char *key, const char **output);
+int repo_config_get_expiry(struct repository *r, const char *key, const char **output);
 
 /* parse either "this many days" integer, or "5.days.ago" approxidate */
 int git_config_get_expiry_in_days(const char *key, timestamp_t *, timestamp_t now);
diff --git a/read-cache.c b/read-cache.c
index 1e52db7f36..18394d7180 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3184,8 +3184,8 @@ static unsigned long get_shared_index_expire_date(void)
 	static int shared_index_expire_date_prepared;
 
 	if (!shared_index_expire_date_prepared) {
-		git_config_get_expiry("splitindex.sharedindexexpire",
-				      &shared_index_expire);
+		repo_config_get_expiry(the_repository, "splitindex.sharedindexexpire",
+				       &shared_index_expire);
 		shared_index_expire_date = approxidate(shared_index_expire);
 		shared_index_expire_date_prepared = 1;
 	}
-- 
2.46.0.46.g406f326d27.dirty

