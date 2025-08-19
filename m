Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633973115A4
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591587; cv=none; b=gpy6hltzJb/ou/asCZcqRP7UgBUk3Y+cZgQjZjnYx63jSVtPRdqr/ZHlj2fqFl10Q2MNZwViq1jZPU+W12YjS7M5ujY+uvMiQBe793j9xiSiQ3i5jjIrzLcN0Ts84nMjMnEc7zLv+SR1M9ONxNYnTWT8Ox5yFSXuFFpMoLQOtto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591587; c=relaxed/simple;
	bh=/q9Itolzng6RBA4jeUeEf8BleLiosehuXSZZo3pLJ2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dpXxBEHMCbjihOpWiuF9GLLbfV4RTJvj7yrFc2AQbiuZQfqL16cIdB+zB2grGwTltm2L1nT9I05lJvkQsXjnvsn7B6id+Cg33VV0yc1GRK/1dNbsNcOqcEwUMGHL+IxlGLxGHCY0T96PNB2/ZeQg2/Gz5lyGWh0lQNGwVjsWtcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g0OG8aW1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ms+HL66+; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g0OG8aW1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ms+HL66+"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 800CD7A027D
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 04:19:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 19 Aug 2025 04:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755591584;
	 x=1755677984; bh=H/AzIPtjMwnLRAnbmEl9iKkPwpQuvfDBlwX92KOtmsE=; b=
	g0OG8aW1360BrSulGP4Uh5nH0SrZn5U/+5+Hco/JhE+NEhUjun580XKRb4U1ZG2Q
	xcSzMAGkjxLzrSEhir31BPgdFeCqPGXxXy/Cqyhb/tf4wwleCSe4eMf4xLybmeWd
	XsWYpUqRXcUW7GSm/6eWIzcke7b2a8CGgBuOCXZ7zyTDnqAET4WXIEKXvaAi7aIv
	RlSh2hLsPgJnv+OgzbkJAbRlT6c9hAivtub1/5Qf4P8e04Pg5T/GWIJ8eH/ydL9e
	Hs2oR4IWTMFNqE5k7W5MNTjfXbo9uRAGIf1UnBz7M/+GLAdlKnmiafXabm2O2g9T
	2Y9rsYvUlTD9fKj2pakk2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755591584; x=
	1755677984; bh=H/AzIPtjMwnLRAnbmEl9iKkPwpQuvfDBlwX92KOtmsE=; b=M
	s+HL66+mQtz+huTt/tQEPfvAkpsFp6ruTuEtyHmAzD4OxBbH/ZofhBdEVYetNJ1I
	atcpaApcIoFILHO9SHCBM+SbGhA17et7DihH4URJVUSBa2TL6mCb10YZavxysV0P
	yStKw5T/f9Hp+BuU7TZeHs4Tyvb78BwuGheQWcjj7xfM7IIUVkRALcc6UQ9PBt6C
	LzVgOZOQY9pitJTqwe0y3dU67BgFfhLtHgOkJoCQ2BVMR9YXMxTR3CgXMXYwh9zt
	gyqKju3CZKA0+IjKp1rZK4NJSukryDJRvCT21iW9DXkRIWge/Gkn/7ipZTVAPBuZ
	hLO5Ja+A07jx21pp40rVw==
X-ME-Sender: <xms:oDOkaOLQ2DJ64yUe9qKVjS4uQGhY7UZIkJLY5zzsGxV0i0gp5wjQMg>
    <xme:oDOkaIJndnocp0riukM-oFwvpbgsZ-T8CPkD_y3HFtmgxzhYcOAvq0-KpXVdf2ztu
    4lb_toQXQa5D8sZiw>
X-ME-Received: <xmr:oDOkaIFfthXQo40BL78K-7TSg3jIMMa3hCCLj6NlyZitnOKnmR4gbibhbFadsH3i4osk-5lcEszJXbp_80jN1BVUjs6xGYzCzrh9tJXBKNVV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:oDOkaFmFhaLFLYOKDm-zWidWEKISOftR738j-7kHxYPR3eQwliOncQ>
    <xmx:oDOkaNKpXgYEbEjgINwO4aQ7XXQym_nSnf5jR_7KfhGYGR3NTjFSPA>
    <xmx:oDOkaOYDeHtHvvYovABlPh8zcA-CkjxC0_eGrrS66BrrQtV7EUJ2Pw>
    <xmx:oDOkaHbsNUqlziCJAv8s8KHVrM4QRns1fz_ULfdsodFEoNf1MubJaA>
    <xmx:oDOkaIiycO2PFAU2YS-9ZjqllMULb8tdatW_etL3z0-XEIfhdEuMjCwn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 19 Aug 2025 04:19:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 45594568 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 19 Aug 2025 08:19:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 10:19:32 +0200
Subject: [PATCH 03/16] odb: move initialization bit into `struct
 packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-packfiles-store-v1-3-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The object database knows to skip re-initializing the list of packfiles
in case it's already been initialized. Whether or not that is the case
is tracked via a separate `initialized` bit that is stored in the object
database. With the introduction of the `struct packfile_store` we have a
better place to host this bit though.

Move it accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.h      | 6 ------
 packfile.c | 6 +++---
 packfile.h | 6 ++++++
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/odb.h b/odb.h
index 273ad0ceaa..970919403d 100644
--- a/odb.h
+++ b/odb.h
@@ -162,12 +162,6 @@ struct object_database {
 	unsigned long approximate_object_count;
 	unsigned approximate_object_count_valid : 1;
 
-	/*
-	 * Whether packed_git has already been populated with this repository's
-	 * packs.
-	 */
-	unsigned packed_git_initialized : 1;
-
 	/*
 	 * Submodule source paths that will be added as additional sources to
 	 * allow lookup of submodule objects via the main object database.
diff --git a/packfile.c b/packfile.c
index 6478e4cc30..4e5f84eb09 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1027,7 +1027,7 @@ static void prepare_packed_git(struct repository *r)
 {
 	struct odb_source *source;
 
-	if (r->objects->packed_git_initialized)
+	if (r->objects->packfiles->initialized)
 		return;
 
 	odb_prepare_alternates(r->objects);
@@ -1039,7 +1039,7 @@ static void prepare_packed_git(struct repository *r)
 	rearrange_packed_git(r);
 
 	prepare_packed_git_mru(r);
-	r->objects->packed_git_initialized = 1;
+	r->objects->packfiles->initialized = 1;
 }
 
 void reprepare_packed_git(struct repository *r)
@@ -1061,7 +1061,7 @@ void reprepare_packed_git(struct repository *r)
 		odb_clear_loose_cache(source);
 
 	r->objects->approximate_object_count_valid = 0;
-	r->objects->packed_git_initialized = 0;
+	r->objects->packfiles->initialized = 0;
 	prepare_packed_git(r);
 	obj_read_unlock();
 }
diff --git a/packfile.h b/packfile.h
index 1404b80917..573564b19e 100644
--- a/packfile.h
+++ b/packfile.h
@@ -64,6 +64,12 @@ struct packfile_store {
 	 * list.
 	 */
 	struct packed_git *packs;
+
+	/*
+	 * Whether packfiles have already been populated with this store's
+	 * packs.
+	 */
+	unsigned initialized : 1;
 };
 
 /*

-- 
2.51.0.261.g7ce5a0a67e.dirty

