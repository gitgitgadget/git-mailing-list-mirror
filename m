Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6019C20E6EA
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491546; cv=none; b=B396iZU8/oeYBn1icuGfWLYk/koSShVT6t9/lRbRQkI7AekjwvhRoP/QU28OaSPKaZMLx20/vFVNGqU3dxAUpvgUDamXHdYipaj5LkUv/V1WhrDadPiN1S807sMcin5kY9d+xZeM3bLHKGWCFdoUBsuRUxj3vEgfvJpMKwhnQqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491546; c=relaxed/simple;
	bh=JnmfGVEgDJ+YrMtgM1ElPtYMsedQjXxl2y8xe1VJ0rQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p8caH/dvjxmfXKzt4VVrESEEJSSLZ26IOyyZOpXSG8vxUKKYO+O5tVzhEUi2jY1KPfIjAVm+NB9fAuePEaxzY8Ove2npjRd775jO4miVivTwzNKTaLehcH6DGAaQtt7/f8poiRa6GITt1ytUpk9Ui5pXIeyV5CT5WPCLY6hDdz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YFYGvEAP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e5EoBY8i; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YFYGvEAP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e5EoBY8i"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5E2F5254016F;
	Fri,  6 Dec 2024 08:25:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 06 Dec 2024 08:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733491544;
	 x=1733577944; bh=Er5fasMw6Jf32mRr5b55od91h4kR6mcame2y+pB7aBU=; b=
	YFYGvEAPW6d4uqeHl0gnKcPe8+WG9ieNqIgnHtYrjwcc9XC3txuaYXuOc4nFzr7k
	YcuH7+UkxjJ7nisLLUWOsPtzVehgsHay0ouygWCGGX/TMiqwjsxDx7k9VfttnPEI
	mxSXIIoe1WaagBxf1cP4eBJ7M9b7NqXbjx6cj87Mla4g+uwawBCXF75OHidyf8LD
	TUUEELK58uTHonm7xRVKyZAlMReAcI+/nLKWnnTI1yIoYAPJtUXy0q472FUuV+gb
	RP2FrHp/WVpRkNbVA1Nq5i4c1SLxbiSO6WMojXD8YnxySCh5hIjwtInpnuem3KJi
	dUqDgnmhlYWcR+XZhnoczg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733491544; x=
	1733577944; bh=Er5fasMw6Jf32mRr5b55od91h4kR6mcame2y+pB7aBU=; b=e
	5EoBY8inu/OiO95n0TsgzpmrEDACD61my10SIR+UWanQxZY5dOHXwWaJW/U9LFvA
	5/IeMIZ4u/nNFXV9AIxbDte0qSBWa1CNFGp583zQW/ld7EDi+4ha7lR4yiGyt9up
	PQmyyO8PdIlvdyLET5ZsvjaA3qjqAZFwNm8ZaFO4a7cJwb1PmGqngM11dLiCpyml
	hb930bT2RO6ujjmN7RXg96dsik5VAO2efF6nPrbC/7sLfec8RBXDgfLM4hVySD+m
	WUWewzrfPJsBSzW1qzwlE4eq2vRuXbwuZNYfCY3ZVfq+zT+42TMP502791iVAYLK
	ssFbp/N+pMHW3SQIPufBA==
X-ME-Sender: <xms:WPtSZySoQm-G7N_xfXAjzToepfn_5ddmc3w66JvyDoZJviaxn1BFaA>
    <xme:WPtSZ3wLmMPcA2QbzyFUD2blma2JzsVi-o5rCfJlnRT1dvZidYP4D2NkDfJPg9Vf5
    4TYuJ7BoExcwRwESA>
X-ME-Received: <xmr:WPtSZ_2jvvd9Mg2xBU42NE7B7DjKcIoadny4ivD9EonnOrPoGThKYZst_st2mY2v4CU2Xrjws5D8plL3Cql8DHU1rZ_npPvB3ZFW0ds2sWV67Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrph
    hluhhsrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstg
    hoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepjheitheskhgusghgrdho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehphhhilh
    hlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hm
X-ME-Proxy: <xmx:WPtSZ-CMoJu1N8MvOauuM_xW2BwKSQ3veG47GfS4wmFAYlBCAwLH4g>
    <xmx:WPtSZ7j_sNxyJaA3YeAUcS031xZvUtaCVUVrykFNG183atpZz1OglA>
    <xmx:WPtSZ6rNosv2SiwvLqWr3P7KDug7k5WK7jQE7lAoDFzwGH2JKmbrQA>
    <xmx:WPtSZ-jebXCorVIEwaiimQDH24gkqh_d46OxngtDKAd4iByXy17Cug>
    <xmx:WPtSZ-qejylh6YhwtpyJRG65OrPQO9cbkp2EdcoJYa8-Owc3tOZkPhBv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 08:25:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f7f43372 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 13:24:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 14:25:01 +0100
Subject: [PATCH v11 26/26] Revert "meson: fix conflicts with in-flight
 topics"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-meson-v11-26-525ed4792b88@pks.im>
References: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
In-Reply-To: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Johannes Sixt <j6t@kdbg.org>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

This reverts commit f5e9b17ebcc547ecfb14c542c06e30e95aa80b1a.
---
 meson.build          | 4 ----
 t/helper/meson.build | 2 --
 t/meson.build        | 2 --
 3 files changed, 8 deletions(-)

diff --git a/meson.build b/meson.build
index 442d7bbabf407aee00cce280f40a4d5527f18d9c..0dccebcdf16b07650d943e53643f0e09e2975cc9 100644
--- a/meson.build
+++ b/meson.build
@@ -235,8 +235,6 @@ libgit_sources = [
   'commit-graph.c',
   'commit-reach.c',
   'commit.c',
-  'common-exit.c',
-  'common-init.c',
   'compat/nonblock.c',
   'compat/obstack.c',
   'compat/terminal.c',
@@ -275,7 +273,6 @@ libgit_sources = [
   'ewah/ewah_rlw.c',
   'exec-cmd.c',
   'fetch-negotiator.c',
-  'fetch-object-info.c',
   'fetch-pack.c',
   'fmt-merge-msg.c',
   'fsck.c',
@@ -350,7 +347,6 @@ libgit_sources = [
   'parse-options.c',
   'patch-delta.c',
   'patch-ids.c',
-  'path-walk.c',
   'path.c',
   'pathspec.c',
   'pkt-line.c',
diff --git a/t/helper/meson.build b/t/helper/meson.build
index 1d6154ce9756db17bc9f69bc3cd71a32b93857c5..5e83884246edc7841738de5085f3255aa1fa3fbe 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -34,14 +34,12 @@ test_tool_sources = [
   'test-match-trees.c',
   'test-mergesort.c',
   'test-mktemp.c',
-  'test-name-hash.c',
   'test-online-cpus.c',
   'test-pack-mtimes.c',
   'test-parse-options.c',
   'test-parse-pathspec-file.c',
   'test-partial-clone.c',
   'test-path-utils.c',
-  'test-path-walk.c',
   'test-pcre2-config.c',
   'test-pkt-line.c',
   'test-proc-receive.c',
diff --git a/t/meson.build b/t/meson.build
index 1c82e27a1d48dd6a163d7b26c74b5ebf6f258d41..13fe854ba0a18f9b83dbc48651f581198042ffd3 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -177,7 +177,6 @@ integration_tests = [
   't1014-read-tree-confusing.sh',
   't1015-read-index-unmerged.sh',
   't1016-compatObjectFormat.sh',
-  't1017-cat-file-remote-object-info.sh',
   't1020-subdirectory.sh',
   't1021-rerere-in-workdir.sh',
   't1022-read-tree-partial-clone.sh',
@@ -830,7 +829,6 @@ integration_tests = [
   't6500-gc.sh',
   't6501-freshen-objects.sh',
   't6600-test-reach.sh',
-  't6601-path-walk.sh',
   't6700-tree-depth.sh',
   't7001-mv.sh',
   't7002-mv-sparse-checkout.sh',

-- 
2.47.0.366.g5daf58cba8.dirty

