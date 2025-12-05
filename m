Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174CA311C2C
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 08:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764922831; cv=none; b=NMrpjSNuIbHbCXFHuwRp7wWZOYUSVGTq+Abals9mdwMTnyaHCCU9WVveQ8FfwaO8nQQZTIqXIXn8WC07892jAm3Ass1kgiuh1exLANGenCqY9HSKD+J/aLQ3DffXYBzl5NMnf6l+GSjysIIb7lHjfol8sBm7grKmLOToGUsM634=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764922831; c=relaxed/simple;
	bh=HJnfuOuYPksQTgt4OlI4PYrerxVjjy9Xqp2o4jFMVZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uvv/uumdQjOTUeL0XBQvcjhehHV0ZAGnsNSL1IAGVsfMNEC3V3U/iy1OaOBb6F9sPHCVyxLWe/hk/z632YQ4wIx0xB9EbAOIaAwNgzmtrmisQ7PBPMahvgn1TU+QmZ1Tvn242T4juPErzAsAxtcsS26uflNCqMUNRyDIJNgKOzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=puP5FPYB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FwK0NVnV; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="puP5FPYB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FwK0NVnV"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 1FCE81D00258
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 03:20:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 05 Dec 2025 03:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764922819;
	 x=1765009219; bh=fOnSxwoGFLo58BrRL2nTqLSlIisPN0YHfVZvIZ18kNk=; b=
	puP5FPYBcJKGRTIP72LoKU4fvpKid8Fszz0BK7NSax6wuXuYC2ph/u2SHiMKuAvZ
	WLgws9XOcvRPvOEfbrmkjsnRUWkBn6mdC9FMjh6F+RZLYVygyO8reqawwUsMW8E2
	N+QLXUPtFR5RVfzOeernwCQ4sEYnbgPP9vI7kPaliWemwGIw82bbR4c59bzI745z
	AlrRSWz9lvBuw7M+4XTPn/iJNdSii2GkXhTnwNhnlgbEwXQO9r4XU3DhQ8pF5c81
	1B3ue2pCx3Y3Ft9RxzsTAcxYk18A8O/zvpISSF9rY+YzSUl1rbDHhANGS+zP7aTA
	nGydNPmylnCZF8G2Gz4dFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764922819; x=
	1765009219; bh=fOnSxwoGFLo58BrRL2nTqLSlIisPN0YHfVZvIZ18kNk=; b=F
	wK0NVnVFuyDIOI2kQ/Gc2J9st0S33cKr2wh/ewMGVPSeWFYRtKfjX7y1g42zCRCi
	0e+bMAnJjQYzhXTjqkWF872gAGf2PSkVRCxiutDwLrlcsnppeKfu2HYLPLpFHi8/
	oQ/NhGEEJ7H2wNON5YLoIf0M4FeOBdpUsrj1mb9aGD8+XwKcjfhowkiPr91S0DYF
	dkxi4lSuUT6lvWs0ZiertiClKWzCmXaucTtMjbiSzD1QubyBlf2kL07367FZpe9S
	pgE7vzfpGUhSuWas35UBYWNJd3seCxCabImyflDN1rhlbsp9k96g4qw8N005s05M
	LJS+9Tj47lEwvYceRwA5w==
X-ME-Sender: <xms:w5UyaZWtim5TNYdg5_D7PxuC7Qo7RL1imWxlk3gny1JSBj6CFQPnzA>
    <xme:w5UyaQjb-4oS2TBEZcZS8rLGMPL5y2nrH4nun8AnVoqdO-VRFoa47Cs4UzQGSPXeY
    Ntg2PSOJetK2Xg5T7dU-RJ0JvpQIRDnqowtKHK7omcm69PHytbIsA>
X-ME-Received: <xmr:w5UyabDdh8vQD-T1zLwcvPLzB1e2JkeqG2LgYWhZ2kFJQQaOsr8oJ_Wxmd7GHU8X9EkW6zuUY7re3a7EUu8jJDHSv7-9Idk-Eh-cPa3cNPs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:w5UyaRcFuyDIulKhKvIwiw9ONVguGRytfQGAYCW0Px9R_t4D-l--DA>
    <xmx:w5UyaTfKjDoG1uxIqZ7-phIe3XXlMH9ZG57-PZnZQWXpBSyk01YhAQ>
    <xmx:w5UyaVhw_kkTk8Tz8RaJUZYUB6BWd-VyuR2a1nf8n3RVQp9lsNDKHw>
    <xmx:w5UyafTuYwqkAxhaoY8y7B_PWplxZGUrSjkhYs7Vfdr8FG5WgZ4svA>
    <xmx:w5UyaUnI5hVHyKBLDZloRmMKQWT1UuWBd7zqGs70WHQeM8SaM4sFF0ss>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 5 Dec 2025 03:20:19 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5926aa87 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 5 Dec 2025 08:20:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 05 Dec 2025 09:20:00 +0100
Subject: [PATCH 3/3] odb: properly close sources before freeing them
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-odb-related-fixes-v1-3-ef4250abb584@pks.im>
References: <20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im>
In-Reply-To: <20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

In the next commit we are about to move the packfile store into the ODB
source so that we have one store per source. This will lead to a memory
leak in the following commit when reading data from a submodule via
git-grep(1):

  Direct leak of 192 byte(s) in 1 object(s) allocated from:
    #0 0x55555562e726 in calloc (git+0xda726)
    #1 0x555555964734 in xcalloc ../wrapper.c:154:8
    #2 0x555555835136 in load_multi_pack_index_one ../midx.c:135:2
    #3 0x555555834fd6 in load_multi_pack_index ../midx.c:382:6
    #4 0x5555558365b6 in prepare_multi_pack_index_one ../midx.c:716:17
    #5 0x55555586c605 in packfile_store_prepare ../packfile.c:1103:3
    #6 0x55555586c90c in packfile_store_reprepare ../packfile.c:1118:2
    #7 0x5555558546b3 in odb_reprepare ../odb.c:1106:2
    #8 0x5555558539e4 in do_oid_object_info_extended ../odb.c:715:4
    #9 0x5555558533d1 in odb_read_object_info_extended ../odb.c:862:8
    #10 0x5555558540bd in odb_read_object ../odb.c:920:6
    #11 0x55555580a330 in grep_source_load_oid ../grep.c:1934:12
    #12 0x55555580a13a in grep_source_load ../grep.c:1986:10
    #13 0x555555809103 in grep_source_is_binary ../grep.c:2014:7
    #14 0x555555807574 in grep_source_1 ../grep.c:1625:8
    #15 0x555555807322 in grep_source ../grep.c:1837:10
    #16 0x5555556a5c58 in run ../builtin/grep.c:208:10
    #17 0x55555562bb42 in void* ThreadStartFunc<false>(void*) lsan_interceptors.cpp.o
    #18 0x7ffff7a9a979 in start_thread (/nix/store/xx7cm72qy2c0643cm1ipngd87aqwkcdp-glibc-2.40-66/lib/libc.so.6+0x9a979) (BuildId: cddea92d6cba8333be952b5a02fd47d61054c5ab)
    #19 0x7ffff7b22d2b in __GI___clone3 (/nix/store/xx7cm72qy2c0643cm1ipngd87aqwkcdp-glibc-2.40-66/lib/libc.so.6+0x122d2b) (BuildId: cddea92d6cba8333be952b5a02fd47d61054c5ab)

The root caues of this leak is the way we set up and release the
submodule:

  1. We use `repo_submodule_init()` to initialize a new repository. This
     repository is stored in `repos_to_free`.

  2. We now read data from the submodule repository.

  3. We then call `repo_clear()` on the submodule repositories.

  4. `repo_clear()` calls `odb_free()`.

  5. `odb_free()` calls `odb_free_sources()` followed by `odb_close()`.

The issue here is the 5th step: we call `odb_free_sources()` _before_ we
call `odb_close()`. But `odb_free_sources()` already frees all sources,
so the logic that closes them in `odb_close()` now becomes a no-op. As a
consequence, we never explicitly close sources at all.

Fix the leak by closing the store before we free the sources.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/odb.c b/odb.c
index dc8f292f3d..8e67afe185 100644
--- a/odb.c
+++ b/odb.c
@@ -1132,13 +1132,13 @@ void odb_free(struct object_database *o)
 	oidmap_clear(&o->replace_map, 1);
 	pthread_mutex_destroy(&o->replace_mutex);
 
+	odb_close(o);
 	odb_free_sources(o);
 
 	for (size_t i = 0; i < o->cached_object_nr; i++)
 		free((char *) o->cached_objects[i].value.buf);
 	free(o->cached_objects);
 
-	odb_close(o);
 	packfile_store_free(o->packfiles);
 	string_list_clear(&o->submodule_source_paths, 0);
 

-- 
2.52.0.239.gd5f0c6e74e.dirty

