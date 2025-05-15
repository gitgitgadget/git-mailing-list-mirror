Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3A429AAF8
	for <git@vger.kernel.org>; Thu, 15 May 2025 11:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308665; cv=none; b=OucNACp5N1+MpPIsb+a9msHaKNgQTP5JoZOpaZyF3toUR1oHlQxp8KnBamNp5y0ealy3mPnCJGX3Z6T4mxP95gbRT7xXGnE4tll0FnC/f2EUamGVF1h/SpnRKZKgPpIaFlSi9Tt7p7Awf6J6H23mXuUew2zM9xWF3ZoQy0mmJSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308665; c=relaxed/simple;
	bh=/JDz75w3tHgoK4e/krcEQ3zuP949+ye0RdL6v9T0YWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riPr9HXWWxR3PHilChqhMjoKstLSU6Jy7ckaDYKuN7tocI/fJC7x7SiS8GBnUfBmbvoynMrB7vkMbUw8s1A9uTr3IQMcnfAJQLn9IThVkE5y2QdKamaetwxVSo5ubz+mPZMpPMhvMRSIRa3yP6DRLWz9ec/0peovZaoEpQngnt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ycV8O18m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dS4/jgMy; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ycV8O18m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dS4/jgMy"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F37F0114012D;
	Thu, 15 May 2025 07:31:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 15 May 2025 07:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747308661;
	 x=1747395061; bh=9kq+cdTw0Y3qd8qAYpklxgsgFc/F04ikUozTIZHD24A=; b=
	ycV8O18mMniOi7kSJYtbTOwRoKI3GM+nMOd+6kPcHZPTKA1TAH2vI8mRMXcIwBN1
	aAQ9zjLxcoaTwXJ5XYhsat7b8HfSqeF1FMHB3sq/YrPdVc4nKLKubtOhUNLzanKI
	asyiY+++URaZ0vrhVkxdLvFtK8l5a3Hpha9sJHnJcdx/YBVjMEc3B+yn+dSHsIBi
	n97XJNxRd7hAwhlc2ZTab+fnF+NdyN7tooMvTvXJJbdYC4tvJYZewsplssfKBkNX
	jAjazVfaox+Y7Y2Uyxm1vP8Jpk/yvTjG0iDCWYi6KfPgTFlNcFx00O73YuHOvFK1
	bLJ3ny4RLN0/oFoym4WSNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747308661; x=
	1747395061; bh=9kq+cdTw0Y3qd8qAYpklxgsgFc/F04ikUozTIZHD24A=; b=d
	S4/jgMy+amLZdYRnQSrh4Ztx2B1H9V+C8w5Ks8x+3u/kqm1fP3MI05gcvNAejWbO
	pARMysXbybB45+1iMMoLH8dbLrgq4JSGyPxbI8Q01BSfY74Se8FzDZKHzRlfDIsm
	hevETCnCejbcp0TiHUK4WSo1wPThwXnsvN9gwRRsycyXqMrNrQbveFCjo3fXtZ3J
	1vpHcmb4iwF+KpbbYv0DGDFTbX1wLpo/Z2T/G8hWiuZyHRiWfCU3GSjfSnbCvLRG
	pHEbEMs0AajauYnGGvC3iisNiLtC74c6zOrer5k0BB8fWqnEtkXTsUn3hKN/aIkJ
	dM6go/CneQ2pGkOmssBeQ==
X-ME-Sender: <xms:ddAlaNnnSvKJOodEKCk96aL8ku9dViXKfcyH1BzaBFR_yCy0vs7qRQ>
    <xme:ddAlaI3JM6iIok4stuRR2tw5t0NAYNz6FaMKdWdCIhSQ1iwvwGNikEHp38HCekCRc
    fH4nAU5U8WZgrSv7A>
X-ME-Received: <xmr:ddAlaDrXfTAbisoAJfSQH5wcHIZbHLc9J4EbdtTvMToPzNORoQS1btvfFHUoK6nRy-vPSNCr15wDetdo-pUllzVHipy2ApNVrG0wfw50Q3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeljeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ddAlaNkrTq_nZiv7Z6eipZ-GqriDPC79ZKT_kz9tZFaQZ9gqa4575Q>
    <xmx:ddAlaL1l_bUYbyboBlbGoj39pi5AOB2DgJDz3k1RSfkd0ec_yOyFSQ>
    <xmx:ddAlaMu7blcaf0wsF5l13vozRwJyXGIEgKDKZhpK9-TRO8tafHH71g>
    <xmx:ddAlaPXon1IkfAWj2cOQI_xNVLEi8NIWyapl98MEVGhvk30aR-_MDg>
    <xmx:ddAlaIjHWEXorU--Hq9c3_dmMe6vPV5MqztzuWuMmkiYdu4qyTG60q-7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 07:31:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e1daf749 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 15 May 2025 11:30:58 +0000 (UTC)
Date: Thu, 15 May 2025 13:30:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com
Subject: Re: [PATCH 1/3] fetch: use batched reference updates
Message-ID: <aCXQcSsc4p6u9ljZ@pks.im>
References: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
 <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-1-7c65f46493d4@gmail.com>
 <aCSNFMeh3WMav_Rn@pks.im>
 <CAOLa=ZRbEqs6X1KJj-CikCANX-BC8r4RqbwoT06qmtF=x+7hQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOLa=ZRbEqs6X1KJj-CikCANX-BC8r4RqbwoT06qmtF=x+7hQA@mail.gmail.com>

On Thu, May 15, 2025 at 11:13:32AM +0000, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> >> +	 * since pruning must be an independent step, to avoid F/D conflicts.
> >> +	 */
> >> +	if (!transaction) {
> >> +		transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
> >> +							  REF_TRANSACTION_ALLOW_FAILURE, &err);
> >> +		if (!transaction) {
> >> +			retcode = -1;
> >> +			goto cleanup;
> >> +		}
> >> +	}
> >> +
> >>  	if (fetch_and_consume_refs(&display_state, transport, transaction, ref_map,
> >>  				   &fetch_head, config)) {
> >>  		retcode = 1;
> >
> > Don't transactions handle D/F conflicts for us? Isn't that the sole
> > reason why for example `refs_verify_refname_available()` accepts an
> > "extras" parameter that is supposed to contain refs that are about to be
> > deleted?
> >
> 
> My understanding was a little different, from the documentation for the
> function:
> 
>   If extras is non-NULL, it is a list of additional refnames with which
>   refname is not allowed to conflict.
> 
> This is to capture additional conflicts. We want a way to avoid said
> conflicts. That said, there is a 'skip' parameter which does exactly
> what you're saying.

Oh, right, my mistake -- that's what I actually meant.

> But the transaction logic doesn't incorporate this
> entirely. Specifically in the files backend, where we create a lock in
> the filesystem, this would cause a conflict, consider the following:
> 
>   ❯ eza --tree .git/refs/remotes/
>   .git/refs/remotes
>   └── origin
>       ├── dir
>       │   └── file.lock
>       ├── dir.lock
>       └── HEAD
> 
> This is from the test 'branchname D/F conflict resolved by --prune', the
> test prunes the existing reference 'refs/remotes/origin/dir/file' while
> adding 'refs/remotes/origin/dir'. In 'lock_raw_ref()' we lock both and
> read the reference, but this causes an issue since
> 'refs/remotes/origin/dir' exists as a directory already.
> 
> I would say this is logically solvable if we start treating conflict
> resolution within updates as a first class problem. But perhaps that's
> something of a patch series in itself and better solved outside of this?

Fair enough, makes sense. Might be worth it to add a TODO comment there
then?

Patrick
