Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76573019C3
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764662045; cv=none; b=LrmlLm9xN23b5uejMIGY5k3Hh3T36qADKkdQMAJZ1SYOCZePL80F0ZnxIBoseCn3BxgJJ4ecHsvPGd9FyN8gVfhyuOmF+lmCSKLaF2NtPtmgdQoFmHrDX+YJSCV4hTqcS6XAQ87psyRkap1rd8+XmFQh0vFNgoj2OfiSr1ttf4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764662045; c=relaxed/simple;
	bh=1Fk3QZwJTeqpkHbPlAzV5Rl/5mowutN18uZq7Mttwco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDzObaCsnbR3CPP7nPw1/GsAkV2VsTyh7PHy6gGQrE9C4pnGWO7sHzPlHUveqOpXKvOo6ZD+DSGaZKDFm48aVEO/8bg6YQ1t9UEsIF4tV9H4SIicaBfXC4nIowkywVZWBxbPkKUDEQVJugNBV66uWTfSelBGnMkfa6b78pDx3ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=alL3vifD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jDBq7XSx; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="alL3vifD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jDBq7XSx"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E76101D001E0;
	Tue,  2 Dec 2025 02:54:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 02 Dec 2025 02:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764662042; x=1764748442; bh=v0Nll7X9Eo
	H09ciiG2l9fylGuf4fNsKq8UeGKYDI5Mg=; b=alL3vifDTIm4YNpeg1kwuBbKVW
	vGrOWamVkTIQ1cRmIA/1SZF/cJEEkAhcIV/FrcHnkwvyGES6DxkQVO6wRPql5Ytr
	lTKpjcZ8+7s1Fr57Th1FMel69oSgj3tjgzeeyFm99Fj+n+djVZ/S4W7viEp2wYNp
	nG73X2N2b8RZFANm2WDf5Q3uQB0vTa4k18f/Br8aDlKliqzDkHv/vo/UuYRWib52
	a2g4nivRi3NiYQbCyqDq5zIpyFcYYNF7vOG5WSUZyULLDByx7R++2L0pKx0SnAwe
	GUhELeALPTkvfu6OCsIDbMvG85kcbQR+PbjaC/L//FhOaM05Btob/5IWyfFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764662042; x=1764748442; bh=v0Nll7X9EoH09ciiG2l9fylGuf4fNsKq8Ue
	GKYDI5Mg=; b=jDBq7XSxf8Ahu2ivwaxQJA8th2r9Qn1G5FElntb+jdVIQ47MsQC
	c/rDgvmmT4mBrim3AmClW3H75WS++d1WSpP9MgHI1Z/hoJcDW8IcXLCtf4DrIJYX
	uPHVmo0Lr/upFsYMHxv+EQnTQEqQ7MT2F+sgXd3BOpbVt8LydhfnMvt4MV0FvYMc
	AeOkbxX8WWTrUfUlh8+GxFNyri3XqFk8SEnlnCtPSo9NyF+2kVw15W+TVx2NHCKU
	yiHgw1BZNHRr5bwdaNwkYz9Gfklgfpzu1cm/KvCpEmfbTq6AH6G175KypJLq8yoD
	dC2clCvrgzKodNZfi17Exinit0lxUV+X/1Q==
X-ME-Sender: <xms:GpsuaRY4_hmkUhWf7pRVsd2_SNw5T5_A7BadXds9H80DISzqWz3Weg>
    <xme:GpsuacHmWjcxqi6aIDYNGg2jkBS1BVk2c7yq2KKAYYD6UZT_vYxR5H3Zy4X640FbY
    AWVbSGpO1i_x-XzYVsQC8cIGaFnLp2wDLOovcCixt5mYrANnnw5xg>
X-ME-Received: <xmr:GpsuadwAtZ2NijfmNhXh84d0qnKfM0WYFlM9kZQKrxEk9onOMI3RM5G6KesTfrp7nAWGsHoN8MMPJQs1gcIInaAq1F0XTgTSnPY0tlsM4yo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddviedttddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrthhthhgvfihhuhhghhgvshelfeegsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhl
    vggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhig
    rdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GpsuaWl1lDv5BCPvmpych2p_-GU3elYNRnTtca2FMYW2WseGZQED2w>
    <xmx:Gpsuaeki9HD9d-O2qFz26TDJbTbAAR3rghnnJBUT-aEVWOk8w9CHDA>
    <xmx:GpsuaQxSTDvpkv1lmJ1oo8TCq0kspsDCoCfuibAc76z10kFlWBVWvw>
    <xmx:GpsuabotTur43cfEyfluS1oKs6PRiGYmejYviihzbzwZwjBiopNdTQ>
    <xmx:GpsuaV3vi8Vs3vyVm0sdSYcfdB8Rtkd7IC2xRakBicJaSFQ3V1BZGCvX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 02:54:01 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6eb54e57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Dec 2025 07:54:00 +0000 (UTC)
Date: Tue, 2 Dec 2025 08:53:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Matthew Hughes <matthewhughes934@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 5/5] scalar: document config settings
Message-ID: <aS6bE9iNzAemw7pk@pks.im>
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
 <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
 <ac1627dbd94e3330117fbaeac2e2373104aef531.1764607847.git.gitgitgadget@gmail.com>
 <wqvecbwieexjpp2pgxn66mlvq5foiw6as4doxgyiehzjuo7hv7@jrskhegeuqvg>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wqvecbwieexjpp2pgxn66mlvq5foiw6as4doxgyiehzjuo7hv7@jrskhegeuqvg>

On Mon, Dec 01, 2025 at 05:58:06PM +0000, Matthew Hughes wrote:
> On Mon, Dec 01, 2025 at 04:50:47PM +0000, Derrick Stolee via GitGitGadget wrote:
> > Add user-facing documentation that justifies the values being set by
> > 'scalar clone', 'scalar register', and 'scalar reconfigure'.
> 
> Thanks! This is exactly what I was hoping for.
> 
> > +REQUIRED AND RECOMMENDED CONFIG
> > +-------------------------------
> 
> Would it be worth noting in scalar.c that the config options listed there are
> documented here, So that a dev changing the list in the source will know to
> also update this? I assume there's an understanding that if e.g. you update a
> flag you should know to also update relevant docs, but perhaps this is a bit
> more niche.
> 
> > +gc.auto=0::
> > +	This disables automatic garbage collection, since Scalar uses background
> > +	maintenance to keep the repository data in good shape.
> 
> Checking my understanding: this means there will be _no_ automatic GC in a
> scalar repo? Since scalar calls 'maintenance register' which means
> maintenance.strategy will be set to 'incremental' which won't schedule any gc
> runs

Yes, auto-garbage-collection is completely disabled in repositories
managed by Scalar. And I guess that made sense in the past:
auto-maintenance did not know about maintenance strategies at all, and
consequently it would still run git-gc(1). And that's not really
compatible with the "incremental" strategy that Scalar wants to use.

I changed that in Git 2.52 so that maintenance strategies now apply to
both scheduled and normal maintenance. But I was worried about backwards
compatibility for the "incremental" strategy, so I made the change in a
backwards compatible way so that normal maintenance still ends up using
git-gc(1).

Arguably though, we can now iterate on our infrastructure: if we were to
introduce an "incremental-v2" strategy we could adapt it to have proper
strategies for both scheduled and normal maintenance. And if so, we can
adapt Scalar in such a way that it doesn't have to disable auto
maintenance anymore.

I think that would be a reasonable thing to do. Scheduled maintenance
only runs once per hour, and in a high-activity repo a user may easily
generate tons of objects in that hour that make the repository perform
badly.

Patrick
