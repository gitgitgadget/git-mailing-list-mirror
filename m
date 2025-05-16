Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D4C635
	for <git@vger.kernel.org>; Fri, 16 May 2025 04:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747369837; cv=none; b=EFptvOo/lMex9rdjPI5tPPQaVMOKHvGyHRqeueXfH4TcrFizONuyhn9cJDt33ToeYwxtm6wderwJzCKpLxxHI1OF5hMB4DMFd47R0fOrRUz78vqFUcJ9PZHMAnp66WCOsoyDOpTN1Spptf26csRCeTxKvtNJpiWgEba5VkByXxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747369837; c=relaxed/simple;
	bh=aeEIoSdDoij4wqpL7tqfeePkkrm6DhHphWdW5wlx/k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvXd9iX6DZbK8VNEOzN+lQIhzyyWRm2mZy/plWLwROTitb2cMhbMIEQ+1QcI/BX5LnNeNI30TrzDwLKCwxFqECh8yjbvhJseILCNgnT0D9EVGF4FK/qxs4TcIMwykOiOqDDR0Hd1d9W9K3/pFyJG3G08PXQaoknzH6cbu8rFjik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uRPCTpQ8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GpaeANH7; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uRPCTpQ8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GpaeANH7"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 208A111400DA;
	Fri, 16 May 2025 00:30:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 16 May 2025 00:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747369833; x=1747456233; bh=DuXpP5rTZw
	JNp2jhgsSHnKUCaoc2nIUVHHK12p+V/YI=; b=uRPCTpQ8HRgxks+DwHE+ynB52g
	AnjSd/f/su3Tt5IQA4DcbstLCUDFGq1vMky2ta6xgnh/V7d9ujiE4hAsQ/omEtI3
	7zEfpKOYSOsxPmuOyoVVZSH8nOESVKnGmuK39M+pSuTx3uI/mUUW+/a7iQanSyda
	pbb+TvJNnxPZWFIJheEHiYymLWQUVWDs65WoAJoprFCyo1RHj4tjhD1UxxkZJM93
	GY/JBNunQss7bgJolpF1QXmXZSpBsmzhvzK+5hS+SZm+oherngkZEgGaL4itWJEy
	4EFuqs86Fu6lUXDHooA6W5L+WkKs2pUGYqR7F9Q/MLbFmDsTH9WjPGSfygoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747369833; x=1747456233; bh=DuXpP5rTZwJNp2jhgsSHnKUCaoc2nIUVHHK
	12p+V/YI=; b=GpaeANH7nEZh+PBVJI731aq/b5fEos6FDk9+UjEqFJV1FNfHaMu
	PC2UyGTqhkZUS7JIhl+BQWdQ5MtNEERkMRhksdZDPqH+aaoTle08Q8aw6QDqLaT+
	dA3m1DwSvK+wUNpcQBUEYJDhruNRGCjf5uzDKE+xhqcDMa0w4VKwBnPKRTMaygOV
	YkL3+qFI6SI431h+DpNkSDav5m/PcnnwF9XudHpcF5Gxkfm1f9GEqcgVhGFKC49B
	6+9wZ1uPBQaegKZTm2xVxG0pwy1uEn5/enfQm4t5Fc5hoF7UjbFJ4c9SPTvrn2+v
	84+U1IAg9oWL7qm+zdMy+OgC27QPJT2SsHA==
X-ME-Sender: <xms:aL8maBiJODZ2OCy4p1f20MH5MukO56CYvZeeFo7Sknl4Va5otPYzNw>
    <xme:aL8maGALVFs24XjI-iGrYrdR0kYf11W6yhlUJ6i5YhOs7iXsORqoRIZtJpnUgQ1AY
    NWnCFnksc_NyZQ76w>
X-ME-Received: <xmr:aL8maBFw4Rit4BZPI88B5ClUa0ylyoe7g4jIIBcGqF84GycQkMoE24XzKoFAKwideDlqrpGNNexuEtmRQeMEQ9q-B9_9K2ur2xqTB3Nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddujeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhgtnhgrrhgtseigihhplhhinhhkrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehm
    vgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrd
    gtohhmpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:aL8maGRpO3XHSvUbXyUn8qGiJLCriTvlX6oBFQ6AVk9K1XUXqArmdQ>
    <xmx:aL8maOx7b2duiUzwtxEPrUAbZILxATg8yRk_QxS-g-XDSRYWgtQo3A>
    <xmx:aL8maM5nRJr4VLDFcgHYtn0Mka7y8jEulQ3IVKmFV0KhuAmkwroD9w>
    <xmx:aL8maDzY6OzVAktKS95JriyYNgFXHBgu1yyPvkbWlMAq4X8YdYE4VA>
    <xmx:ab8maFwPrtc-xWBDyo1AMH32QQc8ictmsDDIzpXBFXtLx7jXt8aQNSIM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 00:30:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 95b3b68d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 16 May 2025 04:30:28 +0000 (UTC)
Date: Fri, 16 May 2025 06:30:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Marc Branchaud <marcnarc@xiplink.com>
Cc: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH RFC 0/5] Introduce git-blame-tree(1) command
Message-ID: <aCa_Y2th6xaYeSs8@pks.im>
References: <323dc2c8-41bb-433a-a1c9-662609e359ea@xiplink.com>
 <xmqqjz6sb15u.fsf@gitster.g>
 <7a6afafc-6dee-4a09-8779-83748a4d3fc4@xiplink.com>
 <xmqqldr789gr.fsf@gitster.g>
 <9109a8ab-d4b2-4ada-8969-bc72edac5ecd@xiplink.com>
 <874ixnjltf.fsf@iotcl.com>
 <xmqqy0uz7zzh.fsf@gitster.g>
 <0f491261-bbe1-474d-a240-0ddbf22cc754@xiplink.com>
 <aCXsKHiP4uIzCMrt@pks.im>
 <f01e1e88-c161-43ba-9845-4fc7c9f85d0e@xiplink.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f01e1e88-c161-43ba-9845-4fc7c9f85d0e@xiplink.com>

On Thu, May 15, 2025 at 01:30:47PM -0400, Marc Branchaud wrote:
> On 2025-05-15 09:29, Patrick Steinhardt wrote:
> > On Wed, May 14, 2025 at 05:15:30PM -0400, Marc Branchaud wrote:
> > > in its name.
> > > 
> > > How about [[consults thesaurus ...]] "git ascribe-tree"?
> > > 
> > > Or maybe fold it into ls-tree, e.g. "git ls-tree --ascribe"?
> > 
> > I think anything that needs a thesaurus to come up with probably isn't a
> > good name for non-native speakers. I personally had to look up what this
> > word means.
> 
> Yeah, that was a bit tongue-in-cheek, sorry.
> 
> (Honestly, "ascribe" would be really bad, precisely because it is a synonym
> of "blame"...)

There's no need to be sorry, even if it hadn't been tongue-in-cheek :)

Patrick
