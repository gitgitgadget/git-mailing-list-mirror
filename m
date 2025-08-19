Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224D4315760
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591626; cv=none; b=PkKd6NA0jkv7nvYGM7sLQ0cGSPh5JmTtnWHbA25SYL0nDQbNfLeeGXPvlGapktMD2crb++HG/6C+sflyETEM7DDJbLdMhRNov0DKPOI62zdWNC1j2QHlunJWQA1qhDz2yYFVo5EK/YyUrQkyjtw7ylRZs8gd35+iFhvVSUV/hhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591626; c=relaxed/simple;
	bh=rXEAwiHlyrC1yPFiwaxQSTDwYmO9IoQ0MQFvZGcP8Dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NTLNmAxS6Dl5soSf52vd/4myz4OG+ctgBlqOMJus4QTHfwdBoRhjw6nMpVcUtYSEhmhPQg4c9CZ2nT7p9aS7PPzuzdfMuCOSND9sj/5LwFeNiWvmVFdmDPIRf1n/2Qx4jbCrDgRqYFUheK72WjneKWWf97h5tsM/Dx4XVl2GA4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jukzd6Bs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kLEnXWni; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jukzd6Bs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kLEnXWni"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 4FB091D0025D
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 04:20:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 19 Aug 2025 04:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755591624;
	 x=1755678024; bh=pXwsayZ2n5WGaMDhx3HCxq7t1F3bOgZWuE0N1DlUj7g=; b=
	jukzd6BsHdhkikUvN8PwujwhPhu/k9ScmhUQj9AD/7Q2qyg53tJURqAAhmTsXjUO
	fKNIVTHIpC6SO0+N95CfRQs0VdOyiyUaX2xdXrYmfa1fVraBeQn1RLBskVjzLNaD
	EUTHL9ABe6mNDRNy5aTAeRWMg3gSImp0IohJ9LKGWAzgTOa30Nost+Wylfl17Nxm
	SFEnkXDkpYK73LSj9jKJrp9rT2bG9/V0/jYcwEmH86IRcJiaz97U9kP2nxM/PuJb
	B9wzAE2YO0zphduerBcN/gLm2zLTGuV57rqrri+vMSHRInJ48xU8aPk46Mvsay+J
	NDjwLCydmVTYNb++jccVFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755591624; x=
	1755678024; bh=pXwsayZ2n5WGaMDhx3HCxq7t1F3bOgZWuE0N1DlUj7g=; b=k
	LEnXWniLpbzOvkAT+x3FTEvvazlWEdo+mz5FcBf1WQB7Jd/Q+NGLMQAsaYhFOyjW
	jJltgeb01Elhg65naSL0QnXtjZYMZ2pXPTlI7VbSVOqpv96ZUnNSbmB0f16n9fMc
	t0hU+/SBTstmPtGJYB/LiaarNqFMuZcUECX7nczY47LNeeDN6DUAklC4ctQAT8Qv
	STqLHSf/WkwBtewpFn59tQWO1H68s3nV2dFiCfvAYjCbeFOdPbv9o8BSCNdEpsKE
	Fq31DgwiYxGfEjVkYmwQZoimn4tKbXplMk/98TVU45IFSGybXPbIu0wLElFJlqT6
	kHyN4y6fHtSAGfhgFq8DQ==
X-ME-Sender: <xms:yDOkaKh0Dz75Ans0ciWfPVGWhQOVUOxrnhiERFEbPwmaLGtM515imw>
    <xme:yDOkaNAGZgbcbJNGwtvkBaEJkmnCIDhQdhYDsP1x4wTt4tPGKCSzP5ss_byFYnKwy
    mpRP14RpLocYW0p0A>
X-ME-Received: <xmr:yDOkaLdHxXNY-GHtqwTq3OPB-dLknXRecoOdLIqBqvIlcx0MaZxyFHrZL_pxwu1RRzj8cTM-gitCcdi8fmhwVrz1UiyWQbnPnPX_0U48uMSB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:yDOkaFfoRvnFO4wY-eFXB-uwL3fQk4Qm_kGpuNIkY4CbAPJaDBo2pw>
    <xmx:yDOkaPgDzjujVcXmm-KzcKoFVVPtPnM6vEk-DHpLgjvRMSGKJoqstA>
    <xmx:yDOkaBSK51X9tzPvh9NzVNsY83zz5V9Ih4jS2LivqYBNII4-EeaUDw>
    <xmx:yDOkaAxipxSbYJD3o4tXeUWlB5BDVaYrTbtQjbf3WH5C5XBU30goBw>
    <xmx:yDOkaAbRaJIrFnk7-g1Au69CS6VJ4kb05LTgxKBYZ_9jqh_wnwdG4jKl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 19 Aug 2025 04:20:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ab7da3dc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 19 Aug 2025 08:20:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 10:19:45 +0200
Subject: [PATCH 16/16] packfile: refactor `get_packed_git_mru()` to work on
 packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-packfiles-store-v1-16-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The `get_packed_git_mru()` function prepares the packfile store and then
returns its packfiles in most-recently-used order. Refactor it to accept
a packfile store instead of a repository to clarify its scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c | 4 ++--
 packfile.c             | 6 +++---
 packfile.h             | 7 +++++--
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1c24b84510..4e75f14df1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1748,12 +1748,12 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 		}
 	}
 
-	list_for_each(pos, get_packed_git_mru(the_repository)) {
+	list_for_each(pos, packfile_store_get_packs_mru(the_repository->objects->packfiles)) {
 		struct packed_git *p = list_entry(pos, struct packed_git, mru);
 		want = want_object_in_pack_one(p, oid, exclude, found_pack, found_offset, found_mtime);
 		if (!exclude && want > 0)
 			list_move(&p->mru,
-				  get_packed_git_mru(the_repository));
+				  packfile_store_get_packs_mru(the_repository->objects->packfiles));
 		if (want != -1)
 			return want;
 	}
diff --git a/packfile.c b/packfile.c
index b60faf5c3e..69844dd6cc 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1044,10 +1044,10 @@ struct packed_git *packfile_store_get_packs(struct packfile_store *store)
 	return store->packs;
 }
 
-struct list_head *get_packed_git_mru(struct repository *r)
+struct list_head *packfile_store_get_packs_mru(struct packfile_store *store)
 {
-	packfile_store_prepare(r->objects->packfiles);
-	return &r->objects->packfiles->mru;
+	packfile_store_prepare(store);
+	return &store->mru;
 }
 
 /*
diff --git a/packfile.h b/packfile.h
index 8f501f0094..f6dc26d08a 100644
--- a/packfile.h
+++ b/packfile.h
@@ -134,6 +134,11 @@ void packfile_store_add_pack(struct packfile_store *store,
  */
 struct packed_git *packfile_store_get_packs(struct packfile_store *store);
 
+/*
+ * Get all packs in most-recently-used order.
+ */
+struct list_head *packfile_store_get_packs_mru(struct packfile_store *store);
+
 /*
  * Open the packfile and add it to the store if it isn't yet known. Returns
  * either the newly opened packfile or the preexisting packfile. Returns a
@@ -218,8 +223,6 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-struct list_head *get_packed_git_mru(struct repository *r);
-
 /*
  * Give a rough count of objects in the repository. This sacrifices accuracy
  * for speed.

-- 
2.51.0.261.g7ce5a0a67e.dirty

