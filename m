Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9D6225397
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 06:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768546095; cv=none; b=jHw3kLfPKsCql41Zm/U6g1hJyp1Sy+iHu+90C0A5XGmGYFuHmTp/kr48Dki5p+tHY9oChdFptrpd2V45a88b/Q7a/Kn8AU71sZEH/Eiv58iV/AOiEGtWCxCwz91osvLexg3TzOm953apXjpFzHD3+MpuSIcrex+C2h5ZprW8QH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768546095; c=relaxed/simple;
	bh=M2NKcOUohLQfOrlR4JYIkYP8+1r47hxCjfCSC/JdmVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2FQUHuQ9tPB6Z3ldpK92LqyUwy6YXKqyNlRZv/noNhxXNRu46p5Ak+ChbRQOv300TaW5PSCt53TtmCJzzY/Rz963jgrahOz5Err/n1U++yufU9ZD7eILS5lHBVUDOaYeBMoxse+vajMJImJ/iVyDBVlldY2GA1IEBFpTVWaFEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bv7RmA5k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qcgeMpBA; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bv7RmA5k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qcgeMpBA"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BE1F27A013C;
	Fri, 16 Jan 2026 01:48:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 16 Jan 2026 01:48:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768546092; x=1768632492; bh=BQxavbNkRm
	4ChftYzBlq2OQ+SsmBBjUN+LW60HfwGb4=; b=bv7RmA5koAPZcuU02MN+7R7GgG
	oJvlQlZyjXKjyygz0xvV+6Wf0hkFRIyfILFf0PuSQ2uG06/ynW30W3uO7D7Sgd9R
	YTxL5F169LwGe6L1rFQxoWmmPsza6VBUOWMUuSkljkrPYOnR8nxmjdVz0nOWBNKT
	x7J6ZYAYtkPXdlUAlgZvQF8OU+RDtfacTMKb0FVWCM1qZX5XbR6nU4vjzwebDeWp
	fSkp9p29GBWnuNPazin0l46tAgLOi0OrNbj4inV7uri6+rTgTqG4VhpEaZH+I0bk
	9Iq9U+bdMhDu50llp5pLq75M6uOcI4bRJlFNlNy7UO7xqMSEIdqp9g986e1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768546092; x=1768632492; bh=BQxavbNkRm4ChftYzBlq2OQ+SsmBBjUN+LW
	60HfwGb4=; b=qcgeMpBAiGyOridnNn8qnjZVx4jwB3HW53YPK6UvDheP5T6zDwA
	cp8V+SYisHgDaemFh4gD22ikWepyqjWqlWKVvdctzrh26CuZIbsBUp86BeNNSq62
	V8bB/vpNP2R6wEHK8kTLREerQjSypLFH2+KlQZwDi5J3sJWOsHf9PK3IZETx3yW6
	WPbbL2igXDkbx/8kzPcA8TE+Hwy5QLoBrMC3WOkdbrYmIUzm+SU7HsCa28a+oIux
	BUeTx+OKrMiIrK2Z/JpShpZy8pr8i6CedR0kf8SOotPjehl0E2Kl13hdYB1VgcxV
	cyP2J434f9CWPwZpxy3OO1AqEjrrKb9qyiQ==
X-ME-Sender: <xms:LN9paQfNVjuTZiIabKPZKW1uzW3qBgVL96Ad5Smy7FpcCpMuR7tnZA>
    <xme:LN9paZqNbwa7R3JCpySzzwVn0kOu8eo6xeBdStpPtwCJmNCFYDwTgaKeJ0K0E12GB
    LSIKvz_tK4ZKl93HYx1vsyItMPZGdIXx0u3AO4LFxg7NZYmIhc_XA>
X-ME-Received: <xmr:LN9pae6uLUFacErUQhpW664y6o_2J3IC8zOoH0xDF1wh4VEVckD2l-ucig6tvmh-rxvMOcIstnzs2Sgp2eqDMhscnU2DVrbh4VpS1Y5y8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdekvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeevudeggfffffeigeethffgieekveeffeehvedvgeeiteegueejleeihfeitdeunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:LN9pafrSz1s-ATnheaysauraV5scxN34nVU69YdOXLE_knsFyibv3A>
    <xmx:LN9paQjs4oM8TYvI1ocgMsLxxByFd8RBqfb6K78AQcQyvZRpOTNECg>
    <xmx:LN9paZIwn5n7OPcHiW2UU21KYq_kkF-tR9dg5LFVHey0CjT_Z-FWxg>
    <xmx:LN9paQDk1T7sOOpfWNEuDIj6q5I2_wzL_k5jeq8NirHS28utTdNfCw>
    <xmx:LN9paYEv9eaqQX-B9jFxfX0WDmfHY3Nlw3KTN3HFOGUGX6vndxlhPx67>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 01:48:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e5db92de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Jan 2026 06:48:10 +0000 (UTC)
Date: Fri, 16 Jan 2026 07:48:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/17] Fixes and improvements for ref consistency
 checks
Message-ID: <aWnfJ1KKgP_otIMm@pks.im>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
 <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
 <aWjj5wBi71KZy0dd@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWjj5wBi71KZy0dd@ArchLinux>

On Thu, Jan 15, 2026 at 08:56:07PM +0800, shejialuo wrote:
> On Mon, Jan 12, 2026 at 10:02:49AM +0100, Patrick Steinhardt wrote:
> > Hi,
> > 
> > this patch series contains a bunch of fixes and improvements for ref
> > consistency checks. It is structured as follows:
> > 
> >   - Patches 1 to 4 contain a couple of cleanups for the consistency
> >     checks done by the "files" backend.
> > 
> >   - Patches 5 to 7 introduce checks for root refs for the "files"
> >     backend.
> > 
> >   - Patches 9 to 14 introduce infrastructure for shared checks with the
> >     "files" and "reftable" backend.
> > 
> >   - Patches 15 to 17 move some ref consistency checks that were still
> >     driven by git-fsck(1) into `git refs verify`.
> > 
> > Changes in v2:
> >   - Remove unused `errors_found` field.
> >   - Fix a commit message typo.
> >   - Fix a copy-paste error in a function comment.
> >   - Link to v1: https://lore.kernel.org/r/20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im
> > 
> > Thanks!
> > 
> > Patrick
> > 
> 
> The range-diff looks good to me.

Thanks!

Patrick
