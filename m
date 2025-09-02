Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8C6E573
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803081; cv=none; b=gQ+9Ort2j2Nm2PXyFYs0BuIRelG/FG1g3ZNGWdPXwEi/W9TA40NeR0I1lP/xBC0MH2gyGZZmcRqsNr+tJRNFBY9mmaHjzOnDpiB3hBUCPo1vHNXS+X7hDq3IcXBjKVTX4yZ1VTL9DP1p8IIs++hQ+Al4KjbMLt0DjlaEIv23K/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803081; c=relaxed/simple;
	bh=WQ/bXRLMtJTd5WwV0XwXjZFAxQuIgHfshzhAbwkR30M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scC9j845AJar5M/E4Y2PVnid/U8EYR2QOC4oO/1znOWlann8R+nzN0kCCRdy6iVrKGZYazEjKsufC8a2HItfJX2YYdep0edpsrnPQpjQjNW/WWKG2ByynQ4qh65jYbiEgweW/OwqjCQhgFjodrRLSB+B3vujF3qlPu4wu5XcL8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MgtuMnpa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LgUeLCvk; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MgtuMnpa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LgUeLCvk"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 3FC86EC036F;
	Tue,  2 Sep 2025 04:51:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 02 Sep 2025 04:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756803079; x=1756889479; bh=MeI2Rf8qRN
	W+tZ9jaZgp4fgcS9NFPQ9bjMdvJcZXkHw=; b=MgtuMnpaAnAzFcJ4WrF9WUt6Ba
	JWV7B8FYqzH5wM3Nt3aPLk0P+BJxgbDCWhCBbCVDQOGTz5vltqcKXkwcGVharweD
	0nVjgilR+UZPrUS5VMWWBetuY2BhX5mpLHrmtO8M4vOd4SLFCpglBUMjq8wk2+Xp
	/ICeJjO9hBt4yezuhNbdyQcGHB343sOw39V8rYa6B4yQ3F0EhiWJYdz5NG0E7gHR
	BcogTBqFWNalfzLO4tlzyMzceNIEHVT+PMB8J9VDKMsvgJx/hGa/mhoO3J5irSTy
	TB4wYeVr/Rg4wOg8DTpWPPHk0CnJTcOo2X+FtDLOFyIntQg4y9GrB2CwgnrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756803079; x=1756889479; bh=MeI2Rf8qRNW+tZ9jaZgp4fgcS9NFPQ9bjMd
	vJcZXkHw=; b=LgUeLCvkwJRnIR2Sz6kgDPZVIbC66Pdn2twAHBYuwdbikZWM5b3
	5be4WRN6JsExO+rty/8zNTfuIrSENtjWY9uW4erYmESlAlXbgHSVeSQmx/hBEw/i
	IEgVDVm6we9A1FXqSNS79tOi2BimqIQULQXP+h7UgdTasrXyzu141hh+2Iod6A+H
	T1A9rsHVlSUTmmcSdWu8XjFlx+mIH7G2QvMYn8WBJ/vx1GqxSBRXPhYY5/LXYuA/
	IagvZV05C4YM2LH8R3DVgKpKYemrqgf2XnAPKVlfG5lJ/hiabJOOTDrGaRz4uQ4d
	AWMUMh8A/wuemHqNxbTmHYNTHzVesP/JBPQ==
X-ME-Sender: <xms:B7C2aHRmt0Q6Vgb6J6VWgr4JNY5TXPdYOKojn-TloV8OhEoBsb5YBw>
    <xme:B7C2aDXl_ICSP1pQX2BHQqEKIrJf1HNmA0mOCU1jj3UqYdvRXdtoNnFQZXlh1B-01
    sMwWgKe3ueEuuHiRg>
X-ME-Received: <xmr:B7C2aJZDlz2Qi3nTIzI_FoydHFgSNa_wc6d6Nmh9pZjzKMZhxnt_2UX-vEQXHs1waDhJsBmbCpV5ZQEQ68TuSjdzaNsnZEcBsB8gYenJREdA9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleegiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:B7C2aJ3AqS-HPouYMhO29Wbpxf0RDdmFbUUFmOGCL7Ap575zdsI2sw>
    <xmx:B7C2aLheptNT9LaGX9cUUymttVZOAigiRmTF-ZMF1NEz_COjIrQZFQ>
    <xmx:B7C2aNa3egBMbQARZSh2kxwun39Uy9jddj06Vw5A_aVMIuPNDkX6xg>
    <xmx:B7C2aLRw352pBVlbJhtjfJOJP4NBaGsbuDFOjmcOJmhWCv_EHfhheQ>
    <xmx:B7C2aOqfHshCF53aUOl_pyhuWw9nnSjBhfn2iEm0RimX2A6bk3YI33A7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 04:51:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b299cf49 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 08:51:17 +0000 (UTC)
Date: Tue, 2 Sep 2025 10:51:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 15/16] packfile: refactor `get_all_packs()` to work on
 packfile store
Message-ID: <aLawAalFhp9j0qVz@pks.im>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-15-d10623355e9f@pks.im>
 <aK5jK2Q3McLnJ9Uw@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK5jK2Q3McLnJ9Uw@nand.local>

On Tue, Aug 26, 2025 at 09:45:15PM -0400, Taylor Blau wrote:
> On Thu, Aug 21, 2025 at 09:39:13AM +0200, Patrick Steinhardt wrote:
> > The `get_all_packs()` function prepares the packfile store and then
> > returns its packfiles. Refactor it to accept a packfile store instead of
> > a repository to clarify its scope.
> 
> I think that clarifying the scope here is a good idea. But I am a little
> sad to see this patch proposing that we drop get_all_packs(), which IMHO
> is a useful convenience function.
> 
> In effect this is pushing out the implementation details of the
> packfile_store out to every caller that wants to use get_all_packs(),
> which I am not sure is a win. Should those callers care where the array
> of packs is found, or have to write
> 
>     packfile_store_get_packs(the_repository->objects->packfiles)
> 
> each time they want to get the set of packs in a repository?
> 
> I could see an argument in the future where we have object stores that
> aren't packfile-based and thus calling "get_all_packs()" is not
> meaningful. But I don't think we are there yet, so I think that this
> patch is pushing the burden of that future hypothetical on all existing
> callers of get_all_packs().

We aren't there yet indeed, but the entire goal of this patch series is
to prepare for that future. So we have to do some steps into that
direction that might not yet be entirely sensible by themselves, but
that are necessary prerequisites.

In the end there ideally shouldn't be that many callers that want to
access packfiles directly, but it should be the case that most of them
go via the ODB. But many of the callers that we're adapting in this
patch are callers that are deeply tied to the actual ODB on-disk layout,
and we'll have to tear down the abstraction layer between ODB and the
actual backend used to store objects. It's unfortunate, but we cannot
really avoid that in a bunch of situations.

> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index fce0b06451c..7124c43fb14 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > @@ -854,7 +854,7 @@ static void batch_each_object(struct batch_options *opt,
> >  						 batch_one_object_bitmapped, &payload)) {
> >  		struct packed_git *pack;
> >
> > -		for (pack = get_all_packs(the_repository); pack; pack = pack->next) {
> > +		for (pack = packfile_store_get_packs(the_repository->objects->packfiles); pack; pack = pack->next) {
> 
> If we do go this route, it might be nice to introduce the pattern of
> having a stack variable to hold the packfile_store pointer, since the
> line above here is getting a little long at >100 characters just to
> enumerate packs.

Okay, will do for now. In a subsequent patch series I'm going to
introduce a helper `packfile_store_for_each_pack()` that'll make this a
bit less verbose, too.

Patrick
