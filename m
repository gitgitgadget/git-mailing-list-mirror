Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EDC2528F2
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793808; cv=none; b=e8c0s2M7P1wV+Tgt3qyN7fy7Uu1x1ZFONues2GVf6WgkTibib2W42n4Atgq3DGcH9OQYvXghZ0nKYwOIU9FBV6bKkF/K3e4ibZVxOv6Kxhsid7tqs8qyVvgYPmBX6iJovzyvHq5jl45I0C2lIunmPfcT69Ce/0l8Ixyz3IRM0YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793808; c=relaxed/simple;
	bh=9CvSDdFtckfmyQJlDulB9nx2N4QJQUacU8U1YM7sC3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/n2ei0Jzyqr5UxzEikoMMZ1phTk8iVmkhxghZOTfw72Jl4PVxH6x3ox2ATe9WK453JrG23+94ILcy9m0ZKYtmf88Mh8kYMTuh5W6P2Nzy+ENzOgVOTkZ8zZ9NFGWzRsj24+XX53XMnNjd/3GAETk545hC6dibeFybNlfdPfqW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MWSXGrGl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DqBIPgGb; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MWSXGrGl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DqBIPgGb"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 262A825402A4;
	Wed, 12 Mar 2025 11:36:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 12 Mar 2025 11:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741793806; x=1741880206; bh=d28cTP8gpx
	vmLKfmYWN2qJRfyhozgL+OADMKl0J+59I=; b=MWSXGrGlOupwI5fXITHm4be8sM
	jaGY1ucAtNg843yauyhOlkDlk9139wA9RNYOu753usyqOZ/3aiFWvzPeOGXUIl8d
	QcWxK5ZW8OlJGWWfvk3LKiCUTVR71BrvCx3dwNc1nXr9oXNaONrpKNPrpOD/Jkrj
	0Xhm/L9qA8qoQYrEjMu4QPpo+aor/5cCRvC16445FV+HIu0UNqEOGCVR8QH9qeOv
	tESfde1z30gGRes8ug2jdpKTvuM2V/6JvDMO3kACpaNgtT2oCnzLjfUA/hW4giZ3
	cpbuefiLidEmXUhrqo3d06erO03VEOkumCTLpm5oqtrOwWuCNubRNNoLEabg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741793806; x=1741880206; bh=d28cTP8gpxvmLKfmYWN2qJRfyhozgL+OADM
	Kl0J+59I=; b=DqBIPgGb7N09OrifcgZKN4OKN1Lh497N3ld6TUBrFWW1CkenySs
	JJHOhzEbMY5DMiIhWxsuh5Cy5vd1VaV1D01/L5Gz3GA77U/xbdXdQ+FesoLmBeL+
	UsmHlmSOdLqgh9emQKtCBcbHAs4BscZhUakmBDVD0vMCszyndfPEtRZm3ZKPjzMv
	YQrlFQwImAYR0XXoRsFfjM1LR+G5YnP6J0gTdScxgbrA6mExydoslzmz11dzQgOy
	cINRhJaV1/OYUj2DEK2zPcdRwwGdj++35OdS/xSKjWp5r2Rm6uiG4te5nkg3kfzX
	s1fVaqT/d66gNaUnJGeelVdlYDolxf0cdrg==
X-ME-Sender: <xms:DarRZ4ihsgoQ_geAXNcj-AqCOJW1K3qs05KfVWv4RBZ3dIEDr-5fUg>
    <xme:DarRZxAThSx6FUJ0Lijvvl2ueMWAjo_rCkbI37W4fG8wT3QYATKy3NcN37J0AAdJC
    gdrsh62GxXoi92gyg>
X-ME-Received: <xmr:DarRZwHW6e3d7KUrztbWH0MtcM6XpmV20ifKJagQwlC0RvDIhrDLYwLUDP7s984avWXHld2fz42f9QFzeBkvVb_1UxWwd-HHBF4p00MS27RY2qUfCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthh
    hprghsthgvrdhnvghtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtgho
    mhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidroh
    hrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DarRZ5RwpM7jKNNoq9Gw2dfCmZ69dY0ZvMCIGqUqiacfUyGgFCWU9A>
    <xmx:DarRZ1yr3BUNQMBxwXVhN_XNSZelMVp0C1P4GFNLyTGkdz43Lel-kg>
    <xmx:DarRZ346oNLAALZALmlD1AX9QpAamQUlHXcw6gmBjczwxsIQP89p6w>
    <xmx:DarRZyyti0XEPKvTinuHy26zXqgyqWtAq9xt2XHQX3p-1uabpp5SVg>
    <xmx:DarRZ0yBme22K_BvHiFzcGpC1IacQBI8vefwLfP_4qcDKLh0FeKEA1Zj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 11:36:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 36fb7077 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 15:36:43 +0000 (UTC)
Date: Wed, 12 Mar 2025 16:36:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 06/16] refs/files: batch refname availability checks
 for normal transactions
Message-ID: <Z9GqCsobVxnFI-rc@pks.im>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
 <20250306-pks-update-ref-optimization-v5-6-dcb2ee037e97@pks.im>
 <Z9GFBl5AIQZGyI-9@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9GFBl5AIQZGyI-9@ArchLinux>

On Wed, Mar 12, 2025 at 08:58:46PM +0800, shejialuo wrote:
> On Thu, Mar 06, 2025 at 04:08:37PM +0100, Patrick Steinhardt wrote:
> > @@ -2930,6 +2929,26 @@ static int files_transaction_prepare(struct ref_store *ref_store,
> >  		}
> >  	}
> >  
> > +	/*
> > +	 * Verify that none of the loose reference that we're about to write
> > +	 * conflict with any existing packed references. Ideally, we'd do this
> > +	 * check after the packed-refs are locked so that the file cannot
> > +	 * change underneath our feet. But introducing such a lock now would
> > +	 * probably do more harm than good as users rely on there not being a
> > +	 * global lock with the "files" backend.
> > +	 *
> > +	 * Another alternative would be to do the check after the (optional)
> > +	 * lock, but that would extend the time we spend in the globally-locked
> > +	 * state.
> > +	 *
> > +	 * So instead, we accept the race for now.
> > +	 */
> 
> I am curious why we don't sort the `refnames_to_check` here. What is the
> difference between the reftable backend and files backend?

We do sort because we use `string_list_insert()` here. But in fact, we
don't have to sort at all, so I'll stop sorting in the preceding commit
and convert this callsite here to use `string_list_append()` instead.

Patrick
