Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1598D32E154
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767704348; cv=none; b=f/dZZ9L/Kl6jQy12U6iLjGnZFIypKXPIdKeLoTz32dGFAYI6bc2Ru3Gngy4wqPRj9tankMlZih3aFkazNcztTFGIVliwhlVWgrFa/03r+g9cNpPFoivJfJQ1cKqIPFcpmkudU1eTyxt9Ib1EE3ZVqdESqfnp8B7utdqMais/D+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767704348; c=relaxed/simple;
	bh=lfvRWwfxT8bxeh1PnBCvljtF3j4H3aaTChbjDfsQP/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pmDGjw/0hdyn/kZcODZsgz22mwHvH0nkaN+8428dMYPMylcD1nNRfpptjKrdmE7pYV1EZKVL8Sz89U2/yXeRrGCP2Q8ZgE5/kUBiey5cwLoAYF7zbzyu0DyerLraXOS3WoECmGLX4nHWz90DGO37eRSARalerqT4ju/cGPfIl5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IAgX2RdT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cjHh9o6x; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IAgX2RdT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cjHh9o6x"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 46BC17A00EC;
	Tue,  6 Jan 2026 07:59:06 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 06 Jan 2026 07:59:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767704346;
	 x=1767790746; bh=LiTItXuJIjIl9syemXtP2iKrHreoidphSB2wfNaahvY=; b=
	IAgX2RdTxgOF2GHf71FdbldH/dMZmH7x+qHJpaG8AFBbL1hhrMgfyx3kmpvEBrtI
	o2u44tWU43ujX6n853qqhraLtaO0IVZmJ+KDiETLDUi/B3I3zx/sYtqAXpJ9zNgg
	haNeS78AnPmMljt6i0rICtW4MNLFCJm/emFEv2P1l7lfmB49ztwoT44Kq8BBRvu0
	PT3mzcvq/encPh5NlrL1oxso6jI7RjE2Vg7nSR1W4JMY/BvYIaj4PSSPFe2GmFya
	6RpmNdP6x5GWtN2GM0QU5hsGrJ/AnFb7ICA8rbV0Gw7ArL7UN8JUBsF62O9rJNJE
	1GvBTy2LzbAlhNu6Ae8A1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767704346; x=
	1767790746; bh=LiTItXuJIjIl9syemXtP2iKrHreoidphSB2wfNaahvY=; b=c
	jHh9o6x3S1EX9RnjEqR3/qncPVIo/mLLLErK6Lizz07FOAkwPv2Mx+kHG/zsjdSA
	D/C3EASN74mNEgK24SjoQtvos9MLFe6HLu1DrQge9kG9v3mek9E3XSFclXrbtgMY
	tgvJpRB2xrGsfBLxF0K3ldRGCF+5x3B8kXeCp5NHpWZH8FSEQYu3WVx+TSY1h+w6
	U7s6bY7AgwD6wII9OT+djn1IwLux/LAx/FSPVBlKkSLXda6YVd3glVzXNMJJ1BRL
	hBvu8AeHHuWlDseeWlxXMXVhZvU7koqmd1dKnue36M7YVCGbJNC+FCKg0i8yOVIs
	sNY1d/bRGc4W53odLc0WQ==
X-ME-Sender: <xms:GQddaVKq9v5VNms1-xMkTeWoWvG2Jd2RGd8rXgLrzTk2bm0Tmb64_A>
    <xme:GQddaYLx0q4S_x3E07W4WoFUOfNaIIfH-BudoIH0SOqPkyg8DRkt-Spjj8oPnXpxe
    H1uPzlotxxuMvLtccOS4yvmSqrSbc4pdy5SPTl2x2d3_Cmqc4Y7Gw>
X-ME-Received: <xmr:GQddaSuujcLHaJN3ieQVd8OBSymrS1rfI5XyrqY_5lCCxYYM7RN4Y9OUXeoLyPO6B_aOvdC3IVfaC9lZzQk0p3JOC5ceTXG8p0rW__dd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshh
    hinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddu
    keeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:GQddaVTYkdNS_Kv8AQFUVOmbkEOaiSt8-xSNdRY1p6gpNl0YuiOb2Q>
    <xmx:GQddaYPJJRBUQn4TAgYh0aveY7NBHDNU5dXGjrrInajyIPL6ONWYTA>
    <xmx:GQddaabMfIDz4dWBPGxq2oXaP6QhZbNz9pO_DIwfO7JcERa9eaEpww>
    <xmx:GQddaSxa8_me_LFqz5j_P0_p3k7Sa3KB-rZl4wCYg_Fec733h9J54g>
    <xmx:GgddaSMYvbaB3oTO56kBOL9UOXe4WTPzY6M0USguywyMUekQOlP74jR0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 07:59:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 65421781 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 12:59:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 Jan 2026 13:58:50 +0100
Subject: [PATCH v3 2/2] odb: properly close sources before freeing them
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-odb-related-fixes-v3-2-7ac157207b20@pks.im>
References: <20260106-odb-related-fixes-v3-0-7ac157207b20@pks.im>
In-Reply-To: <20260106-odb-related-fixes-v3-0-7ac157207b20@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

It is possible to hit a memory leak when reading data from a submodule
via git-grep(1):

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
2.52.0.508.g883dcfc63e.dirty

