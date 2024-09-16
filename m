Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A62B156654
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 12:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489709; cv=none; b=i/Teqf8esyr0TeSYN6xOu2ixMBireOQwhJFJxfKjhyE8HNHkco4p+PfA5EH3uDi0PrtptgJXFEpzajhIp3AJ6JTLHrC6sIigIJPGGsLkoJMZcMB+RCkaQCN5ImE6/esWiGCIrFyNYaB05z/LzbalgqdfacyCoJc1l05qzUmHftg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489709; c=relaxed/simple;
	bh=5bIL5JL/dfbksZr0+rpyYOwm7QGHic4eDS6u9ZmAqHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhbWDl5E+QgOuJOseZp2x3ijhDAdIWZ/NKqtMQ+nqj6RppIwsmJABvbpyROBZUXtwaFEzfxYa8TVI1Sas13nn3CZY4EsZrd0fEwdstUMnjDUg2ucLLEUhajAuYEGZfcvxWDvHY8oeOWOrWdgav+lMrQUno64QsvmQHjvXVIeOfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=luNwjszF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gXGOUW5C; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="luNwjszF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gXGOUW5C"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 816111140115;
	Mon, 16 Sep 2024 08:28:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 16 Sep 2024 08:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726489707; x=1726576107; bh=AihXqGP/BV
	tBUS87FVGfjiFOt8NgmLObWKJKqi221Zw=; b=luNwjszFj32tbH6XDm7oFlmogc
	UnRZLYH5mvDQ7yi/4gS4nKoIf5kJKJZw8G7R8YdettfUTO8DvkzqnIieXlhfAJ86
	yJvIgoW13Cx+Nnu39sg+u0SnUu6a5LZzmGSIpL3ZCn74diGU0V0/U88J/eTg/gr0
	q33s4Sv8EBea3OoE8H3FH/TDXeOOB06PTrPhdrwZLOLn6Va2q4eDR0UGl2vvzoYn
	cmcsCUgHSFljhhvYsd4CbMGLdKWa/TGDgWsXk7r1kdeU/acfPIj8d2pMo4srcPLI
	r3mQSPhR2SH6hqY7ZW9o4Nnf4VYWvfLosUSYpNbuOtL9RAdJcsBf7lOFZLHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726489707; x=1726576107; bh=AihXqGP/BVtBUS87FVGfjiFOt8Ng
	mLObWKJKqi221Zw=; b=gXGOUW5CbPFTOJlyzk65s8zrE/u4euaZRxUA6u3uJ9Bn
	YHYzJz/yjRi7lq/v8rp1RaFRqUnyKUKr3njWZUNDMuuG9rl+IzniZQwYatQZvuWp
	0vkAAVHtXaV+nfAH3WLSyTqYJp9ZqpBTr9xsHGYdZGWE3IVyofIPRVecARm2UTNR
	BkGE73Ps3FV0DigMnqHVfH54uTKhoZzTBnQgsnfOurFxMNOa8u3LKxuYiYhYK8eo
	UY1IuOVyUSfknzkvupbaeb1rgVgs5tmuMwbb88kvh1yMt4O4FgLHAfFEogkgeNnx
	IamZwK2pl4cz8fn44Hdjq6r7cufHc0LvtC9ZXdojsw==
X-ME-Sender: <xms:ayToZgVrBjxUjsP8teOpce7SIdvl_Pt_Q9fXcZHJ5ZzIadZ-PuGDEQ>
    <xme:ayToZkkrdJkSKUCnLzYE-LKAheaFB1sV3Ag6SBiXRmuXlGr44bbuWqZaP24EvMIo6
    zgSDubb_nxDi4bjLw>
X-ME-Received: <xmr:ayToZkZcBuIcqILguBREvJnGLCzDKGUpsvO-2K2qAPKBcWI8R1SULVntbXLiHGvtUzNaTSpjRV94nNrGPDcxxCYuyU9iqmduD0y9XRJPhG8qzjCb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:ayToZvWZB_1B1pTK9Fr-u1CR-H5OujBZj1vC1s2IMejAzdjkLf9Abg>
    <xmx:ayToZqlvrjDVARxPoN0nxaW488g0O11v09gaGT6juV-iSfYx541e5A>
    <xmx:ayToZkf9SXGHrXuCsS7tOiBJxLR5OH9kT7wZhKG6b3HZuTG6XmJFAA>
    <xmx:ayToZsEyIDisceLsWK8Qv8BTTaMlpOyLYxaqBMuCcxudbgnp_z2_mg>
    <xmx:ayToZvxoDnWPpEnqhP2vYfKOFMJ7CKRndjV-y9h2h2xMPR2LmRoAFCVB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 08:28:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0c301e1d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 12:28:10 +0000 (UTC)
Date: Mon, 16 Sep 2024 14:28:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 04/22] reftable/basics: handle allocation failures in
 `reftable_calloc()`
Message-ID: <e6ded75f630ea309d5b76126560a0ec3d526bf71.1726489647.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726489647.git.ps@pks.im>

Handle allocation failures in `reftable_calloc()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/reftable/basics.c b/reftable/basics.c
index 4adc98cf5de..b404900b5d9 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -39,6 +39,8 @@ void *reftable_calloc(size_t nelem, size_t elsize)
 {
 	size_t sz = st_mult(nelem, elsize);
 	void *p = reftable_malloc(sz);
+	if (!p)
+		return NULL;
 	memset(p, 0, sz);
 	return p;
 }
-- 
2.46.0.551.gc5ee8f2d1c.dirty

