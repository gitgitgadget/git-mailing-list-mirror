Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5F715F3F9
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687605; cv=none; b=Bkt7XHSSAjSHWw7gyEu4x5QDiEO5UT+dvTmvCKw/5M/hONKq3APfaigpaqw2owhH/nb54hSQHd4KT8WoALU2/oY+C260mfrtiCCSNMjxXZY8rg4c1xQ8tNTcceQPQYgcGAetLRuSPCPMwBgSsqpOONVQu5vFURgHTLG5OgzCh/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687605; c=relaxed/simple;
	bh=2asujhDmKhqlVunaQCiEbX3bSnk3u1s8d7hseHgnI/Y=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hu925s3DZDRlQAbLOoAFXFDmeJfr2jBY4bc4CRHUrMYLQgRj9bgPpQAKL2vmNpQNUH55V8YM636+RVFKN4hYqUAe1tYpamzio3cGmdVCd8iy2AfAsU6yOA3q7R6utw+0LvInThqRVxPEtAy5UUw+ZELaSfEnuJIOEY5UJXQ/1S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SG8XOPV8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ANfpak1/; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SG8XOPV8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ANfpak1/"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 9E25313803A6
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 30 Sep 2024 05:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727687602; x=1727774002; bh=1aDGElKW5+
	WFN+qlvr8WBZwSKex88jYWnf4PI7P9Vzk=; b=SG8XOPV8gNcGGKSOikIjcgMSnS
	BWFdXKBxYZyth8CnzeKSqvtXz4zgZiLLSehlVIpUJeukN/3TH21YiV/J6Ru+r8zB
	rC3SsGdsOlf9N9i6logaMyZiTZJH4M7PuOL4odpzwHlmAQPmgjebYXPq0Fo7t7Iq
	AsXgoGJonrJ9Igt2fGOudQl9bdVRisoqTHMRDSjR9hP4I9WknMdR4Pd2xtIEFRFa
	p/sndJ5CnwFUqoRbDe9DC+l0kvEFklU9ruqzi/GMa3vmptMiI6EU+QGYOEMxzIXi
	h4bkh9uI0Hbv1PvwBkYRYT3Ug/Wo4D2OtXtq+FuEgC979BS7XF0xN81L+NSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727687602; x=1727774002; bh=1aDGElKW5+WFN+qlvr8WBZwSKex8
	8jYWnf4PI7P9Vzk=; b=ANfpak1/dlDAzR8d2YkOXNpVJNIz2LM+Eu8GJA3HRHkU
	P1MUgqDubcWG15wtJvVMf3R0tCcSPhVqW3s2CX4/pZ2NnrOxUTsOIxTyQPwnz/86
	3yLzI+OKlkvqeqQ7286aOOZurKisRwujQfun/9uQpe7tTm6hA0I9aI11cX9E4EGG
	pUxmd7+/9z/oHE5do3wqN2wYS5k2IhOEi6NTKKfZJjF1Q3epJ/VdI7vBXCZHlvv1
	S327fphvB41PwcSodLsRR5wrR4EjEI3s7UiTXlUO33yzjWHjbkVAV/qluThNZw3F
	VmB5JzD5EGqU8IejpsXkI6gCXEl8R8mXlEA7ElHhqw==
X-ME-Sender: <xms:smv6ZsLPiXWTQviK57HQsvgtRAj2b0--8-GKSrEEUMK1znpog-x_8Q>
    <xme:smv6ZsLdI-dg05Jmv-bUzlctSNHPgmXxoDMCRiq8jpetN9V8jfwq9tOWfmfkqKLyx
    t42FdDSiuhL4erGwg>
X-ME-Received: <xmr:smv6ZssPukVjsYX5VPWjHv_LyksNcmWVx08PZ2dWqNxMrRqZE2pkbnaIfdrCBd3rtvSxbhkvwcHul_9RcpfJzJgpTNMzBB9QuwK2ZHcwuEKgvz4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:smv6ZpaHcLht8ciCkw0nzyM08L_NWDYesNl__ZjfgOk6AZ4O_RuwRQ>
    <xmx:smv6ZjZDRvCaCtUFztdAkxWBOvmdos_b1ZDxVLJzoxDCO0ekZjfg1Q>
    <xmx:smv6ZlC--7jN8WSdQ193hXlo1SKf9j7N8TLwBlibbJ3jUMA7ZxtGow>
    <xmx:smv6ZpZ5iTQrzkT8njXMriTjEo8fGr4EPdc5lRiPERAfBYdN7K42pQ>
    <xmx:smv6ZqyvvIgAFQJrKpoE_Knw-gXZX9T_icVevOFJUMIKHzR6mUp2KVHo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7742350e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Sep 2024 09:12:30 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:13:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 02/23] read-cache: fix leaking hash context in
 `do_write_index()`
Message-ID: <c51f40c5bd0c56967e348363e784222de7884b79.1727687410.git.ps@pks.im>
References: <cover.1727687410.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727687410.git.ps@pks.im>

When writing an index with the EOIE extension we allocate a separate
hash context. We never free that context though, causing a memory leak.
Plug it.

This leak is exposed by t9210, but plugging it alone does not make the
whole test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 read-cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/read-cache.c b/read-cache.c
index 764fdfec46..0fb5e0d372 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3124,6 +3124,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	if (f)
 		free_hashfile(f);
 	strbuf_release(&sb);
+	free(eoie_c);
 	free(ieot);
 	return ret;
 }
-- 
2.46.2.852.g229c0bf0e5.dirty

