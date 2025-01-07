Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066B01E1A25
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 12:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251589; cv=none; b=iB2WLvzRz5US2xBFYKyWFMWqrjpwCjHbBj/2U2k/TfAfoVoWBhAdjiIhqv2RWViZ3lLczK6vJBrJA9TnS5mdnKmC4fJ6sYcOkka1Tttql0NR+HFvT6vcj3cSmPvTUwrxIUr7WdOTWzYxa8tASVZDL+HbTQQVYawUefKqLnIpExA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251589; c=relaxed/simple;
	bh=YIgUVoJH20mHeg/wdMEFNsEPNG7UKa0IEjv/I8WKDBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMNKeyABgL8KU2Ubk80JGZOpTOsuUq3Z42sFPN572RwZfy83/ladCyrX1Fm+v7LlDnhlgj43GAzozHZd9FSDTcqaFlNxcJPsc017WHMRCs6GSJJT4D5LmOx6Ov1Z/Wevzy1db950Ir7rEO1UJTFeU8/mTHfoPZCC6YP1j5bIXIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Eheya2jv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i+p/D1cu; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Eheya2jv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i+p/D1cu"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id ED6C3138025E;
	Tue,  7 Jan 2025 07:06:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 07 Jan 2025 07:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736251584; x=1736337984; bh=Kaisu1cETl
	VPZ36rQ/ma1KXpSd2m+btXbpVkkEMpJB4=; b=Eheya2jvo2O8cD4gNE9JSF67v0
	HZbUpzIu4bwa6he2lFCTNH9j174fgSXlOAgngZFoRwwDA4EPeE/B+OnKYaM42ups
	EiP2gehtxE+IQlzcpV5u4BswhN3r2Qf1YEXACUQ1sNq/oAVVb582EU9dOsourhUe
	/BLSfcFoivN0fu4cBdOQwz/dISdM6gpqmaPmyAFrWtMw5hyg+h0G5vYYKs1fOets
	hQKefKo69qMzPH90y6kcqieN+QgPo3ePMtOZOx+qXsJDNqdPqubNBG50hqDQ2JDP
	YRFkf5w6Z4z1tq4Q9WR56C+4oKhoKkvJ5oTTdaaWg6mMX4mA1neaen9m0Y6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736251584; x=1736337984; bh=Kaisu1cETlVPZ36rQ/ma1KXpSd2m+btXbpV
	kkEMpJB4=; b=i+p/D1cul6g8cshirm2OlW0al02LvEYzwd/xPj2giE3AOgJCAZS
	NRm5AXq9i2rz8CMgvJmSEOysKqyPjvNgaSS/oUI+gkQ10w24B66SYEU0h2+NZtxx
	jrvH/mj4vyhYD6b43gH2ijUb7hz/JxsKt0qZLHkDN9R41MurZOrUDgON0C2DVlOG
	u65VBag2/ZVOPy0ZWZcrtHrVShEo0QuyQwYbf2OhAA5cgIMef94n4+Zi9XXTi1UW
	DosXB54N/0vg0P1hupDIsJRDv8uR9CJ+j4qWwb//K7H6DIMQXklGWTkzWWsX37ec
	UuXIw5A9bF9MeyLGwuHaqRYveIMOfUMwDyw==
X-ME-Sender: <xms:wBh9Z_saA6olcI_lzoi6umsz_zbnhhlnioO1x3U68MiucJTAyCK8Ww>
    <xme:wBh9Zwcb6v5WvPSXlwufl6Ot4v61kBtQqchkVAZ-yAwLBXCfrop_mCldVl21TZ7qn
    ZW5c-OKJcoUXnbl2A>
X-ME-Received: <xmr:wBh9ZywkytEdjaGLAEKOFy4I06VxscpQs93XpjrqsI3jf-4N0v9VmhysBMTXt9280xRihGQiwGRktHc6SL6pTvZj_1cD_uLzvEgTgNBX6Rtf5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthht
    rgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wBh9Z-NaBLUSpqGbCxsEQlSclOmAzuSL406KcZvB0B2HADhHBB_qKQ>
    <xmx:wBh9Z_9oCty3rJf9KvSbAVipwMMJVtiSWSszal6fAxh94WyUGjlGkw>
    <xmx:wBh9Z-VqvnjhnmS1D2V4F5FWlUsiAzQOU0yHr2azbT3jRbxSX4qXXw>
    <xmx:wBh9ZwfT1hAFZ-LJXJ7S_Jg6cFPZ8vZCUjVF08bJIDZB6JE9ukREfA>
    <xmx:wBh9ZyZosWg1G56ZkMkVtp0zkYfATOCRxoBL2eU6icsk5ANy8Z8cmTs6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 07:06:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 34237efa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jan 2025 12:06:21 +0000 (UTC)
Date: Tue, 7 Jan 2025 13:06:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/10] builtin/fast-import: fix segfault with unsafe SHA1
Message-ID: <Z30YvHKjA_b6_xwt@pks.im>
References: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
 <20241230-pks-meson-sha1-unsafe-v1-2-efb276e171f5@pks.im>
 <Z3LNVzw9UlS7SWqe@nand.local>
 <Z3fhK1ACzJfVehM2@pks.im>
 <Z3wsZjAqbfI/EdVe@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3wsZjAqbfI/EdVe@nand.local>

On Mon, Jan 06, 2025 at 02:17:58PM -0500, Taylor Blau wrote:
> On Fri, Jan 03, 2025 at 02:08:01PM +0100, Patrick Steinhardt wrote:
> > On Mon, Dec 30, 2024 at 12:22:34PM -0500, Taylor Blau wrote:
> > > On Mon, Dec 30, 2024 at 03:24:02PM +0100, Patrick Steinhardt wrote:
> > > > diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> > > > index 1fa2929a01b7dfee52b653248bba802884f6be6a..0f86392761abbe6acb217fef7f4fe7c3ff5ac1fa 100644
> > > > --- a/builtin/fast-import.c
> > > > +++ b/builtin/fast-import.c
> > > > @@ -1106,7 +1106,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
> > > >  		|| (pack_size + PACK_SIZE_THRESHOLD + len) < pack_size)
> > > >  		cycle_packfile();
> > > >
> > > > -	the_hash_algo->init_fn(&checkpoint.ctx);
> > > > +	the_hash_algo->unsafe_init_fn(&checkpoint.ctx);
> > >
> > > This will obviously fix the issue at hand, but I don't think this is any
> > > less brittle than before. The hash function implementation here needs to
> > > agree with that used in the hashfile API. This change makes that
> > > happen, but only using side information that the hashfile API uses the
> > > unsafe variants.
> >
> > Yup, I only cared about fixing the segfault because we're close to the
> > v2.48 release. I agree that the overall state is still extremely brittle
> > right now.
> >
> > [snip]
> > > I think we should perhaps combine forces here. My ideal end-state is to
> > > have the unsafe_hash_algo() stuff land from my earlier series, then have
> > > these two fixes (adjusted to the new world order as above), and finally
> > > the Meson fixes after that.
> > >
> > > Does that seem like a plan to you? If so, I can put everything together
> > > and send it out (if you're OK with me forging your s-o-b).
> >
> > I think the ideal state would be if the hashing function used was stored
> > as part of `struct git_hash_ctx`. So the flow basically becomes for
> > example:
> >
> >     ```
> >     struct git_hash_ctx ctx;
> >     struct object_id oid;
> >
> >     git_hash_sha1_init(&ctx);
> >     git_hash_update(&ctx, data);
> >     git_hash_final_oid(&oid, &ctx);
> >     ```
> >
> > Note how the intermediate calls don't need to know which hash function
> > you used to initialize the `struct git_hash_ctx` -- the structure itself
> > should remember what it has been initilized with and do the right thing.
> 
> I'm not sure I'm following you here. In the stream_blob() function
> within fast-import, the problem isn't that we're switching hash
> functions mid-stream, but that we're initializing the hashfile_context
> structure with the wrong hash function to begin with.

True, but it would have been a non-issue if the hash context itself knew
which hash function to use for updates. Sure, we would've used the slow
variant of SHA1 instead of the fast-but-unsafe one. But that feels like
the lesser evil compared to crashing.

> You snipped it out of your reply, but I think that my suggestion to do:
> 
>     pack_file->algop->init_fn(&checkpoint.ctx);
> 
> would harden us against the broken behavior we're seeing here.
> 
> As a separate defense-in-depth measure, we could teach functions from
> the hashfile API which deal with hashfile_checkpoint structure to ensure
> that the hashfile and its checkpoint both use the same algorithm (by
> adding a hash_algo field to the hashfile_checkpoint structure).

I would think that it were even harder to abuse if it wasn't the
hashfile API, but the hash API that remembered the algorithm.

Patrick
