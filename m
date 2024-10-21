Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DAE1E3779
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502901; cv=none; b=tbl4ylyp6fr5bPpzoDRQ3Rxa9hAi9bo+xtq4hVhQLfne+FIvd71nd05OOex2UQSkx4/ajnoA6f66G2il2uLTCwjNmvgimZhPG40+n1Nfwo9GtszgSbXPvmOKeG5HHIwXPGNPpGXeEmHYoDI64VWV9QreMwXvoEkGu+E4nJJP158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502901; c=relaxed/simple;
	bh=11mMtxMqLu5J2bMjsJILoXZ5vDZfIiivuEyII53fQuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G61A8VRuXpiF+i5OT4ZbV7PVmvWVpWP32XweM0qTjgvDaqs3PNyAKs5rNv0/XKIxVBlfLrGF8cE8uZJ1hQdNplitbI0saTN3ARANzVBX0Akc53Bob1erFHCFw6Uvm2opLvkgNpsz4/uYpNvEtyDD6dm+f9HwWoxzYfKotUhjIDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q8QrEWqY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JIhDM656; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q8QrEWqY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JIhDM656"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id AB1BF13805F3;
	Mon, 21 Oct 2024 05:28:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 21 Oct 2024 05:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729502898; x=1729589298; bh=hYZLYbf7wr
	P+u1Y8dgceXiaOeNPM1auDWc2j3t8Haxs=; b=q8QrEWqYxzrrn5j9bo3EBP3un4
	8OA/mmGJdmyetbSnW5YLxcRsPnjN4Y0kHkR2DzCok+zYI66vQI73zgYzC7Z73XXc
	q/Nup0rD2Gg9Py+FPW3oQvQfbQe06yqLN10RoEkIPnlTS3K5TJ8ewHdbQj4WLmnV
	ExbCr72A/yWzLHNGhCegfBR1eYQkGc1QjP+vVYMtSmMGzTj2hDOimUef4ZedBSYC
	AbcK4n88D8AXDnf/vtNnF9h9BCx0O5Jxe2I2rZbo/U6fXNq2R+CUAKqo+LJ61s+o
	xW2/YfUTIYlZ4+b8otjxlMl+lC0jnJPd7Fxm5wksWgJwidW9sLTeQuzCNgrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729502898; x=1729589298; bh=hYZLYbf7wrP+u1Y8dgceXiaOeNPM
	1auDWc2j3t8Haxs=; b=JIhDM656p5/PtC16HkDJ0meWMuXTfvkYQFBbOcAFOL1B
	uMwNKmBMgxQVBF6J7Bc9HGgLcgFVauSmFzmD8dZnBVjnPjT/8uDi17zhXjx+hPbb
	BVDv8u2mFdJzlfG9aPodlB0NDY+8PuYM94y0jHn9zdd46qiWadi7HZ+MW5bib5QS
	3BNks3Veo72mev6cjxMniVg30ivtEg4kTE90zdxXU0Lp7ktJa8HyJRkzdAEZi4i6
	T1aaMezMGlVP/IWdI/IuKeNq/RYQPCLQonD+OyDyzwyXC9NMWIU6fMgp07W4/P5t
	tz3W/rACiBta0XO1a+kesFUJrzAnTxriJgd1QvxlMQ==
X-ME-Sender: <xms:sh4WZ7r4SSmq0Pq4xLSTFeOIsnV0S2HKGRe1t_oRS31-uFcrZH1aiQ>
    <xme:sh4WZ1ofZOnwMAHwCwrkM1KpcyXlqSGsRT9LqJu02FnbE6PUCThm_gqFlU9Luu-Am
    zOIv-qhV_TCMNfDFQ>
X-ME-Received: <xmr:sh4WZ4ONJD7XEIl5oAhUtdv6w-Hfnj5THds3imYwITAh8Lo0pSptp8KRvwW9vSDeoUTyIBZu4k7idTK9yC16ABRugoUUJl1MPKI0cgoHygj0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepthhoohhnsehi
    ohhttghlrdgtohhm
X-ME-Proxy: <xmx:sh4WZ-5eW6AU26YM9wAAaYzo8K4IcI7LRjVgRPFzHfOFV2ynxZhIIQ>
    <xmx:sh4WZ64D3YEJ54ZrQvHNkfXtMaBL0jEarQLyfWIkyBRViZ0jonK4bA>
    <xmx:sh4WZ2iBt6VuKxoXgkAgs_cpbv387CUdWtx8k5DHCx3WnCNxizQg5A>
    <xmx:sh4WZ84a41u80TxwtQV6pHTSlw_pgClOPGkEthS8E1ytI4o6LK51DQ>
    <xmx:sh4WZwmst4dnD5Tct94_04GI1AmrtlKhYB3eoN4wDaemjuiuiZcbsNwl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 05:28:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 99d147ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 09:26:50 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:28:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 05/22] revision: fix leaking bloom filters
Message-ID: <7527b31a28f4c9d2e689c9749b6f9f0615ba1261.1729502824.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729502823.git.ps@pks.im>

The memory allocated by `prepare_to_use_bloom_filter()` is not released
by `release_revisions()`, causing a memory leak. Plug it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 revision.c           | 5 +++++
 t/t4216-log-bloom.sh | 1 +
 2 files changed, 6 insertions(+)

diff --git a/revision.c b/revision.c
index f5f5b84f2b0..8df75b82249 100644
--- a/revision.c
+++ b/revision.c
@@ -3227,6 +3227,11 @@ void release_revisions(struct rev_info *revs)
 	clear_decoration(&revs->treesame, free);
 	line_log_free(revs);
 	oidset_clear(&revs->missing_commits);
+
+	for (int i = 0; i < revs->bloom_keys_nr; i++)
+		clear_bloom_key(&revs->bloom_keys[i]);
+	FREE_AND_NULL(revs->bloom_keys);
+	revs->bloom_keys_nr = 0;
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 3f163dc3969..8d22338f6aa 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -4,6 +4,7 @@ test_description='git log for a path with Bloom filters'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-chunk.sh
 
-- 
2.47.0.72.gef8ce8f3d4.dirty

