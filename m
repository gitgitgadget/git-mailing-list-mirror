Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9751EF37D
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743592403; cv=none; b=TDt9O+ivO1qejk36XedAT7oL96VHi68jgvfozZtimFZorvAoFqy8MX3jO7yM2SRFwZHMOa9QUKcZ/bx/jXTJA1dy8m8pOCBwdh0Z3GM4KJ4yrIh7h3LNYDzoIR4pnK+siu4UKKWRyeLVRVJtu6qrIAeeeHZ4tR5vhfGb/GeE5jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743592403; c=relaxed/simple;
	bh=7f2hEQUo4oHwEsi99baiZpPVr2rbby57zGTIYP6k8bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlG6+Qtfblcck6LFl/jY4SIZchMbnJu8DgVSXZMXdEDTZNRXdAQmcj/CfVISIke4fpXq7qfUvvXrFMhpbwUiYDzDTrERog6N6ANwAr7y2BJBpSJykX5cgM/vHuHhjjvIWodfc4eG39Y09cmVTFM2RIEnfUhMB7hDqPU5A1sOjiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MO3YrZ2h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lw3KLAp1; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MO3YrZ2h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lw3KLAp1"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 85A072540253;
	Wed,  2 Apr 2025 07:13:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 02 Apr 2025 07:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743592400; x=1743678800; bh=RI55WSvmjg
	1DUPUb8DIT8m3jmzfintSy1Z6nRREoC4I=; b=MO3YrZ2hjKom7+JfvA6+4BU7yl
	ikPqkQanRwejFIEoBQrmLkBDGYKNnnfcMLpC6JPhJn1+CyGYc6ibMsvrWGCNMRNb
	ZJ7DW6wReVBmN6wXeEurW8oxJGMXoo3OEjTJ7Y8gETUoXMSfljsbeKDRvG/kzWt8
	hFRp6YAO6KCjsETOcAPzqLj5Zv9aM4LK3sciLq3vOEw+IQnhQSEP+gmsh+I+sQ/h
	no1zBBy0857Z5qAzg1DHKxsfAzSVZagFMap0X3dlaDvvL4bmLSUiIOVVcETQZRlu
	JfbHoYHBbaRt9i0t2zoC/FQlKinosfu8LKFn8qLEkELQxwGmypLaH7m2D7jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743592400; x=1743678800; bh=RI55WSvmjg1DUPUb8DIT8m3jmzfintSy1Z6
	nRREoC4I=; b=Lw3KLAp1PTDUMfOE6I+AVT23IVGjcAQBzFHc7oIBq/4Mk9hwuH4
	N+yXpPuqzg4HOAnWOnVQceTnca3FAckOL+WWoej4EkhxAQRTV2DeOQqZT4gPzf14
	wCF5T0AC8UVybo0/gCUsPIPnfsmo/GfUVSgFu5YtS5ktF0B+W0R//l6mL365JmYp
	8pBjf1V+xdgxFhmOZOjzgONBB/4RL2tULcYYYaa2rt3ty0oWmTjldiDUcl70Lc6n
	B1Tf1lESk690yeLvcJ9a7AoT/Sssv28Hjop/qzh5ydzvaSIU2hHPW8X7tyvRnpJH
	2KNZu8TjvMeTHQuIPPOXiLPNKERM0VGIs5Q==
X-ME-Sender: <xms:0BvtZ-NLOn3R3sZX1BYrdi9zmomOh0EFX3ikn_Og7fFXVlJJvK1jvg>
    <xme:0BvtZ89dOsmXBvzApIOXEsh7uy-QoxRL_RYFDTPbOHmY7N0Shbtt3krA1O2tIoS_U
    zRMkhr8fzNyR6G-1w>
X-ME-Received: <xmr:0BvtZ1RDVhKQ_VIY89MGgX_i4wFfKPCHG9nl--sTHlPukPwJjSUwOGhOrWRyBcK77bJWJSs27WqJkFIZ5B3GiaBd8n7n44aV9TJGGx1orKQLlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesihhoth
    gtlhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:0BvtZ-uOi33rAOvIizGFvyveJvgufqMa7wg9rCXRi7PTPd7cQgoGGA>
    <xmx:0BvtZ2fAup1bB84SiWUGzjJi-P71MEtIig8yK4GA93E-ZMl_0P_q1A>
    <xmx:0BvtZy0SOyNvtYN2qLzpRtXBef5KwT-O-tZg93jTjGZFCDSCRgrqQg>
    <xmx:0BvtZ6-8lEzDCxnh7hL90Rs93YCNIma1DO95WzH2oZxEwLaGS4D3kw>
    <xmx:0BvtZ4C26wW62skyjzlYA5NSn1oVdGO8A6NHLE69Ve4-9fVG-Tij8KGR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 07:13:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 13b9d023 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 11:13:18 +0000 (UTC)
Date: Wed, 2 Apr 2025 13:13:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/10] pack-bitmap: introduce function to check
 whether a pack is bitmapped
Message-ID: <Z-0bzW56m8IJ_ysa@pks.im>
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
 <20250327-pks-cat-file-object-type-filter-v2-8-4bbc7085d7c5@pks.im>
 <87plhwf6ke.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plhwf6ke.fsf@iotcl.com>

On Tue, Apr 01, 2025 at 01:46:09PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Introduce a function that allows us to verify whether a pack is
> > bitmapped or not. This functionality will be used in a subsequent
> > commit.
> >
> > Helped-by: Taylor Blau <me@ttaylorr.com>
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  pack-bitmap.c | 15 +++++++++++++++
> >  pack-bitmap.h |  7 +++++++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/pack-bitmap.c b/pack-bitmap.c
> > index 6adb8aaa1c2..edc8f42122d 100644
> > --- a/pack-bitmap.c
> > +++ b/pack-bitmap.c
> > @@ -745,6 +745,21 @@ struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
> >  	return NULL;
> >  }
> >  
> > +int bitmap_index_contains_pack(struct bitmap_index *bitmap, struct packed_git *pack)
> > +{
> > +	for (; bitmap; bitmap = bitmap->base) {
> > +		if (bitmap_is_midx(bitmap)) {
> > +			for (size_t i = 0; i < bitmap->midx->num_packs; i++)
> > +				if (bitmap->midx->packs[i] == pack)
> > +					return 1;
> > +		} else if (bitmap->pack == pack) {
> 
> Here, and two lines above, we compare packs by their pointer address,
> this doesn't seem to be common practice to me. Or is it in the Git
> codebase? Do we expect any problems with this, for example when we stop
> using `the_repository`?

I don't expect any problems unless we have multiple `struct repository`
instances pointing to the same underlying repository. We never do that
to the best of my knowledge though, and it would feel somewhat broken if
we ever started to do that.

If we had structs pointing to different repositories though this will do
the right thing as a packfile from repository A shouldn't be indexed by
repository B.

Patrick
