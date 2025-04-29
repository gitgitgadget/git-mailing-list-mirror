Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1FF275878
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 06:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745907359; cv=none; b=Y3iA5SnQyFsM2yMRdEdJ4PXskNQc4ujeHbg9H/7zAGTBiL5vGWK0SOjJsSuaabq4gW0rbzHtA/Y8W2yPbi8sKX7eypUsYUhKk4Kz7IRH29X1gpFmliOV4svm7WS8Z17uXOmWGbmttHqzKybHPWmBAQ34MnVqa5Ls+QAvLKFx9cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745907359; c=relaxed/simple;
	bh=bzbNNUs6CvaHugCT1K6YPt2HlBZZYfh1kRPBE0k+irk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHPiVczrrZa4wBoi2pBFV+2PMGAb2jMOFiZCgUObYV9a/bzEJM3Q0+CgEpVD5TpqbOODGf3KGar6tu5SmQ6EHchdUple6ucqJJLPJEUuxhugcxEOvyp5msrYGiVs33P5W2DTi1b5QdSVBLRaqBBEYP6cxX8TcMAvnOypVsSUoNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aVSSgbEu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C5t6OVE5; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aVSSgbEu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C5t6OVE5"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6B71E114022C;
	Tue, 29 Apr 2025 02:15:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 29 Apr 2025 02:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745907356; x=1745993756; bh=de1p+L5aEc
	+tW0cGCfTqxFr8rEhWCXB2Bfqin8a19DE=; b=aVSSgbEucanEAmuGqJKmFc3TLO
	r/2gVL3VxZyx4yKKTiiFGUZ3932hpqGIjTFL7nsjNn3JSv+fwIiFWaSpgZmlGpoa
	USJOfbXssjM+xBV8lsOOCz7anIFCT7f5c92nJSlvCDqwsIW3Qhb4HC0BRASMrKB2
	/ocnvtQ31iPz4D99jaUUjSQSekiSw46m+46NM3WiQrJpVzMzdL1N4wkS8fwM16Ax
	niEsThPPMwyahDRHveWnLDcQU3RORNmA2hoGLSYcOPTLe9d9iTKl7CryhlqrZtoC
	MPXlbHSIm2kVckkWn3fZcUb7twRrs+ICQlL//cxjSFoN7ltYwj8RHzjGQreQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745907356; x=1745993756; bh=de1p+L5aEc+tW0cGCfTqxFr8rEhWCXB2Bfq
	in8a19DE=; b=C5t6OVE5gXI4myZ3FzyQiqo3ncx2CvyZhtDQAEzDXcGcq1Mx5Ys
	YivX1RbecG2CBGDKePD1Q5xjRvxc6GCGgws33d7lNB1Ws/CmwwxbGGKfSDiNL6wQ
	ZHhYxV91eFZuzZDiPlWSqKdpQTdV0xpM3vCfSiKuV95+Rs2brpXxgWzA4XKMK0qd
	jLSu4nW+GFLxnVeA4nbhSxBKJxwgwgnG5mYoswPGUF5gxfGKBO6qoH6Bk1p5pQn3
	YO45pZR3Olb4FAjrSZAV3qadZqoPBZWvQPvTwzCR/VWLhIlSCUKNKwmEviCj607s
	n5GQ/cN37UVjOq5Z6WiOF3VC3h+ZptEJ2kQ==
X-ME-Sender: <xms:nG4QaMFONe_ph5My7Mc6JX5Egd-MlZbCVhgXFiPGYW_n0f0_SEqrHQ>
    <xme:nG4QaFUKVv50XeCsqVH7YOxiTeaUztJ7nq29kwxiXF69DPTK02GwBCZWrlOJrETWM
    GiukCPwl847bgLZrA>
X-ME-Received: <xmr:nG4QaGIcp8vlKFVmxnX_9zku04BG4DauRWpqCDITFfWTb_hTW3s7jWX1712vjF0PjBCNx2gJXqNSF8WuQVstItTD9XygtjBCsYYtF7__k64>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeftdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nG4QaOGN4kQnFppJQWPj5KUxNHjdm66JomdOQsVQgvkfyune8Aom1g>
    <xmx:nG4QaCVTngWc_k6DDzYsGs5Wk42xa6n_2e9ljNN9cdmRAnt10FEjuQ>
    <xmx:nG4QaBNBH-A-TAMkdHHlTUfWvvYQjr78bBun8fe-QCxZ5YKLfAdCGg>
    <xmx:nG4QaJ1Y52u5Nywanj7XaUCKLz9DG9htd8L-A9_6DV5aXCzuoRRn0A>
    <xmx:nG4QaFDSwHYEB7NKLCU2KaEP3jc_UKV2GGzH_l8pZamux2pFYLG-g1lX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 02:15:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e9f1d325 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Apr 2025 06:15:50 +0000 (UTC)
Date: Tue, 29 Apr 2025 08:15:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 07/13] builtin/index-pack: don't fetch promised
 objects for collision check
Message-ID: <aBBumhDhWoR9LEb3@pks.im>
References: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
 <20250425-pks-object-store-cleanups-v2-7-63f1695b7700@pks.im>
 <xmqq34dsarhv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq34dsarhv.fsf@gitster.g>

On Mon, Apr 28, 2025 at 02:46:52PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Any packed objects indexed via git-index-pack(1) are subject to a
> > collision check. This collision check has the intent to determine
> > whether we already have an object with the same object ID, but different
> > contents in the repository.
> >
> > The check whether the collision check is really needed is only performed
> > in case `repo_has_object_file_with_flags(..., OBJECT_INFO_QUICK)` tells
> > us that the object exists. But unless explicitly told otherwise by
> > passing `OBJECT_INFO_SKIP_FETCH_OBJECT`, this function will also cause
> > us to fetch the object in case it is part of a promisor pack. As such,
> > we may end up fetching the object only to check whether the fetched
> > object and the object that we're indexing have the same content.
> >
> > This behaviour is highly dubious and more likely than not unintended.
> > Fix it by converting to `has_object()`, which knows to neither reload
> > packfiles nor to fetch promisor objects by default.
> 
> It is unclear why you thing it is highly dubious from reading the
> above paragraph three times, though.
> 
> Is it that if we are suspicious of the incoming pack data we are
> indexing, we should also not be too trusting of the object that our
> promisor remote would be giving us?  To put it in reverse, our
> attitude being "we trust the first copy of object we saw", which
> translates to "we trust where we explicitly clone and fetch from" in
> the traditional world without lazy fetching, if somebody else we are
> explicitly fetching from offers us an object that the promisor
> remote would give us, we just do not bother if they are the same
> because it is not like we trust our promisor more than we trust the
> current counterpart we are fetching from?

Yes, exactly. When we don't have an object locally we don't have a trust
anchor for verifying that contents of the object look as expected. So
there are only two ways to do this:

  - Use a trust-on-first-use model. We trust the object we obtain
    initially and from thereon we start to treat it as the "correct"
    object and verify incoming objects with the same ID against it.

  - We only trust what everyone agrees one. In that case though we
    really should be cross-verifying with _all_ remotes, not only with
    the promisor remote.

Right now we do neither, but we end up treating the promisor as "more
trusted" than any of the other remotes.

I think it's completely unintentional that we end up fetching the object
from the promisor to perform a collision check against the packfile we
are about to index. It is highly likely that the promisor remote and the
remote that we're fetching from are the same anyway, so all this does is
to waste resources.

Anyway, I'll evict these patches from this series. I think a couple of
the sites are broken, but for now I care more about the bigger picture.

Patrick
