Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C112E32B98B
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538689; cv=none; b=T3q/PJ2j1PSqFceeRkLAqfdBW0RqTuVQJFP3o+Fdk/Hnd723MhGxwD3cF5CvNjiQem+Lgm8oM3Zak5K5gOmSkMMpXbzhwhwozKipFoYxfHNuQ2PguflgWxzdeE8JRm929hrs7zfjOGAjpv+b0XxFCJ+ImIHyUc52boiDAGsro98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538689; c=relaxed/simple;
	bh=JRww0PFpxPAwKRAVeCDr/PY54Ij/Zpyb7ltZNA8SAf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TH3aj23MAbI7uCJDEFvfEvrhsLpgDQSkHmQguv1sXvLy59q8VAzfgqSNGgTDXun+V6q1NfxfpwyVqclsBDaJpiMX+41uYKslNRmKFOsU4n89Xyt4hW9CB2ZHkpnUbh3pl+469bSUYVNgUPlaEU/OwKYelKX0GegKBEFQgNHO4nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QXmTKq9A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l9OAdVrl; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QXmTKq9A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l9OAdVrl"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 29D81140017D
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:51:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 19 Nov 2025 02:51:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538687;
	 x=1763625087; bh=acQ8njGSenTeKu+TjpHT7NfUrvyXl+ajPPk64GnLE3U=; b=
	QXmTKq9AYaXQYsBAQqFC8BHtqqlu5WtNS6BMUIWs1xxHCvris10mav0LIF365WzJ
	QHKUJmgWbLjK5ej8Oro2GoW9sq9brXS3OhrsIUcVoBKvK+QLcjB7N7qclH9u4bZe
	stKVUVZj2jpJaRgExxE8WoDtXqil+xwBYQsaRTsruAhPqYYoWCTTBAuJ5/RkoJgW
	4Qz+ez0aGnxVSg1JUjdOBzMJ4JjScey5jEvGJowTxNoLG2mUts2qOGK/hXTC6Fu2
	e2EKls4CnXYkp2yF+1q3cNmnLFdgKKCz+Gfm56mtgSSYJ67GCoqFuB+Sg4yMq5bm
	aML5H6WAYnBXcCQirtsR/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538687; x=
	1763625087; bh=acQ8njGSenTeKu+TjpHT7NfUrvyXl+ajPPk64GnLE3U=; b=l
	9OAdVrlNcwiVScNCD6K8ZbnTfnkxjdmtBDvYQdN6GjZO87LonfY9kNEXI1EaPoUl
	g6LZMQJZ84Jjhd+jalYHTL41vgDpTuGR2PCBA502PNl5p7ZQ0MD6iAwPwn5gsQTV
	zbOAbz6LVnsb6FcLzNydS71lNZUQItSspv+DatvzRh9oJ+qhBeuArBNozP2kPgKQ
	hr10hWRE/TgGnEPErFmUtwksA4SyJlGVyMKMb+4r6dgHujKKumE3UaI8/MoEri0Y
	LerphJ98mahlv/bzVpwFyCdzQRTnKOvwZtVdgMlqL9iLAc+7WhBltm1xqiy9QDGL
	1W6iNxc9eN6+3EQGVh5PQ==
X-ME-Sender: <xms:_3YdaZp9LVArCM-8iRppmul7d3IqJDPVacmRZsEIhkWbd1Q-nXk5fw>
    <xme:_3YdaSnrzv68mNahTR_O-6hjlbgho2ZPYCqRCxcXq8a1MPzdvgAJvK9okb-Qi9Ogn
    ljOfEYaBDvBncgt85hSnydI6q2yRYhim9Zh46N7O_PvoJ1yRjECcA>
X-ME-Received: <xmr:_3Ydab1hTzlw1F-drJZ9VA563fftEzJMZ-lmPW2x8qEK7g3uEImqPwS5S5uS5mWYJzbVsv8iWHZhkol-R1vARWyYrUzIILAibmzVXVO3Yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:_3YdaaDsTSEX6vh9MZhDFFGc-DEvp83cDGeD5TGQY4i2ikrVmBoUyA>
    <xmx:_3YdaYx1arWrenRyN0C7dIdEit5ucQxRlIdBj2Hjw9suwbhDodEOxw>
    <xmx:_3YdaYnBqmrbd3jC2-p1Aw17t8X6pYodVQ2Jqy0aANr3Dg635sHNDA>
    <xmx:_3YdadGG4Bu2FPfZScZG3zywhY4eTHNQkHx1_qbsQaoamo2AjiyndQ>
    <xmx:_3YdaRKkFqv34iFcqCUvlw7ZGYKK_ahVU3ZMzcu1a-UUsSVR9Lwfrym7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:51:26 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 681fb2d1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:51:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:50:56 +0100
Subject: [PATCH 08/13] t/helper: stop setting up `the_repository`
 repeatedly
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-creation-v1-8-2b2ed2612cb6@pks.im>
References: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
In-Reply-To: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The "repository" test helper sets up `the_repository` twice. In fact
though, we don't even have to set it up even once: all we need is to set
up its hash algorithm, because we still depend on some subsystems that
aren't free of `the_repository`.

Refactor the code accordingly. This prepares for a subsequent change,
where setting up the repository repeatedly will lead to a `BUG()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-repository.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index 63c37de33d..9ba94cdffa 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -17,10 +17,6 @@ static void test_parse_commit_in_graph(const char *gitdir, const char *worktree,
 	struct commit *c;
 	struct commit_list *parent;
 
-	setup_git_env(gitdir);
-
-	repo_clear(the_repository);
-
 	if (repo_init(&r, gitdir, worktree))
 		die("Couldn't init repo");
 
@@ -47,10 +43,6 @@ static void test_get_commit_tree_in_graph(const char *gitdir,
 	struct commit *c;
 	struct tree *tree;
 
-	setup_git_env(gitdir);
-
-	repo_clear(the_repository);
-
 	if (repo_init(&r, gitdir, worktree))
 		die("Couldn't init repo");
 
@@ -75,24 +67,20 @@ static void test_get_commit_tree_in_graph(const char *gitdir,
 
 int cmd__repository(int argc, const char **argv)
 {
-	int nongit_ok = 0;
-
-	setup_git_directory_gently(&nongit_ok);
-
 	if (argc < 2)
 		die("must have at least 2 arguments");
 	if (!strcmp(argv[1], "parse_commit_in_graph")) {
 		struct object_id oid;
 		if (argc < 5)
 			die("not enough arguments");
-		if (parse_oid_hex(argv[4], &oid, &argv[4]))
+		if (parse_oid_hex_any(argv[4], &oid, &argv[4]) == GIT_HASH_UNKNOWN)
 			die("cannot parse oid '%s'", argv[4]);
 		test_parse_commit_in_graph(argv[2], argv[3], &oid);
 	} else if (!strcmp(argv[1], "get_commit_tree_in_graph")) {
 		struct object_id oid;
 		if (argc < 5)
 			die("not enough arguments");
-		if (parse_oid_hex(argv[4], &oid, &argv[4]))
+		if (parse_oid_hex_any(argv[4], &oid, &argv[4]) == GIT_HASH_UNKNOWN)
 			die("cannot parse oid '%s'", argv[4]);
 		test_get_commit_tree_in_graph(argv[2], argv[3], &oid);
 	} else {

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

