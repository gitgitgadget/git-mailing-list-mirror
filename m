Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3917B26E174
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751757; cv=none; b=Gh00YcrNjSE+HUzlH0tQ0lgZ4e7Yl+vmEKfG+EhfAu495nBPLGDarWo/M9IxcGPCaJP0Pxr5jXyYNgxAd3OAExsPSfjZMi30pGk7HUXIcSGWA9yM29LRNQxUJCYzAQHeqcIvQC7+QWYcAHWY1Ey4ahRBSyCGBmFYeM2Q9+XNgos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751757; c=relaxed/simple;
	bh=Ft5l8tbMLgQySmam21IKBsyXam8Ly3aoVaYKr9IM0fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxBgVisC56/OmT2QBjaO63ZukgzB8EPuqvLUeuyRN8D2AAP4CaPwK0xI7WEsTACJrkKDxI+1Nn7kFxzHh/8QhPyiQrULVUqIkiToo7WRzfkPlZWkt1asJVDnJeKJQ7G2E8RszSMTYwPS/QDdsYh4KCXVL0HhncR34eadJfhI78M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xn3sQNwD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pHYf+3SX; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xn3sQNwD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pHYf+3SX"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 233312540133;
	Fri, 28 Feb 2025 09:09:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Fri, 28 Feb 2025 09:09:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740751753; x=1740838153; bh=1Gvk2+EZQc
	KIb00utsqGfFPutIRFw5K6h+N2BPszXwk=; b=Xn3sQNwDFOoqNtaEx1A2tuJRnp
	4Oq64f29W10eHw+IQfiVGLgciLf+x8oICqWtyE1fCxLHb3Bn/ZniWsLgIw8zAcU2
	4vsCiXhlpp/pAYkemjYEjO5LJLwDTWR0bjH9EHO7Lt6HXuQ8cHHJpA+AJjjrWiOm
	Sz1w9fsCMuJTfyaHMQ0dqnnrEOIWu46y62rc6yXYms5/jPohW5OZ1q5f7S28rX6I
	ClZ1rOz3CLzPCuJl4ZkAA+o0tw7rg+lzgH4NCcfE4gieuLqRUTBglIHUjCTX469T
	sPdjswmcZv/YSgG1ZJT7ZtBzfJEwUwdrqaa6TIqi0Dx5TzCt0nTOCuWrea9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740751753; x=1740838153; bh=1Gvk2+EZQcKIb00utsqGfFPutIRFw5K6h+N
	2BPszXwk=; b=pHYf+3SXJIs+r3oT/J3rwQc0PSNvUnNQsbKMu5oEY6diDB96sT0
	xR/jzLH6C+hdW7DYzwuUD8g0eje8plfGt0ABuKcbYeYXpMotUFWd9groUu831gw1
	GmO/rGgvuOFdCb5JwJJis1NltMIFEwbf7cofNtB3OuTjur+fy0eYty8DQMuPS7eN
	23Zs3iYXd2/cfi9m/6Xlco93BkCsq5iMzvxDonOEs3WzRD8a5CkqTzUbc1C8OyxG
	qGXk2DUVfEBFw4KzZwWgHeew3jdRvPBhZ21k60pRIUDy0x7nIi0u0QLTNBBYvHEz
	cQ6pxuvJ/NJ/1OsQt74Fq7z0mNswwRKty6A==
X-ME-Sender: <xms:icPBZzvRw9g1f4-ryiUThr6_I2SypzAiTgPfiyEem3uqW2BLJHCWtw>
    <xme:icPBZ0c0tY3w-zTLdBSDlf3VOXdGPo17wPFw-PP66e2qNyDX09zbfqryu7kGqTrXp
    OwFUn8e2w5WXIB6Tw>
X-ME-Received: <xmr:icPBZ2xk891Z5VvY8FesiqNeDwIWRM60cF7mZrAMNWo0YXhrXCKTlrebKN2af3_KWrRgWDyFbonnWU-7-HiLYsop5a8jrIH0tK_zqFmWlwC_ict1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtmhiisehpohgsohigrdgtoh
    hmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhn
    vght
X-ME-Proxy: <xmx:icPBZyM2Tq1XiiM9ZacRQ_p1fKVMM7U0tZ6axGdPuJZqJItLOADtuA>
    <xmx:icPBZz9DeI3PzIdf_P40dSv6j5B4mMrFLJ50y_mFAjKx6e4mjgT8EA>
    <xmx:icPBZyXYmWnffwRpG0EFaeC6B8cepBfe46sIugsjBJf-4etmTMHvEw>
    <xmx:icPBZ0fXa_kaAOHioTfH3oH1_v9t_L42kBRC5Uh7ChQpUsINc_y9oA>
    <xmx:icPBZ2Y9FUhX_BY5JeDZ_KhEpw37z3__mFPiF3-s2MQFlfGTxLsGDT16>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 09:09:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9b6722d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 14:09:10 +0000 (UTC)
Date: Fri, 28 Feb 2025 15:09:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 3/3] contrib/subtree: rename .txt to .adoc
Message-ID: <Z8HDhZ7I5D6Zrr-E@pks.im>
References: <20250228034713.203461-1-tmz@pobox.com>
 <20250228034713.203461-4-tmz@pobox.com>
 <Z8FwG_q7NmRDUqof@pks.im>
 <Z8G_Ia-oXgRcgVvs@teonanacatl.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8G_Ia-oXgRcgVvs@teonanacatl.net>

On Fri, Feb 28, 2025 at 08:50:25AM -0500, Todd Zullinger wrote:
> Patrick Steinhardt wrote:
> > On Thu, Feb 27, 2025 at 10:47:06PM -0500, Todd Zullinger wrote:
> >> The .txt extensions were changed to .adoc in 1f010d6bdf (doc: use .adoc
> >> extension for AsciiDoc files, 2025-01-20).
> > 
> > Same here, we also need the following change on top:
> > 
> > diff --git a/contrib/subtree/meson.build b/contrib/subtree/meson.build
> > index a752a188df1..9c72b236259 100644
> > --- a/contrib/subtree/meson.build
> > +++ b/contrib/subtree/meson.build
> > @@ -32,7 +32,7 @@ if get_option('docs').contains('man')
> >        '@INPUT@',
> >      ],
> >      depends: documentation_deps,
> > -    input: 'git-subtree.txt',
> > +    input: 'git-subtree.adoc',
> >      output: 'git-subtree.xml',
> >    )
> >  
> > @@ -63,7 +63,7 @@ if get_option('docs').contains('html')
> >        '@INPUT@',
> >      ],
> >      depends: documentation_deps,
> > -    input: 'git-subtree.txt',
> > +    input: 'git-subtree.adoc',
> >      output: 'git-subtree.html',
> >      install: true,
> >      install_dir: get_option('datadir') / 'doc/git-doc',
> 
> Thanks.  I have not yet looked at the meson build so I
> didn't remember that should be checked.  I still build a
> full set of packages for rpm-based systems and there were a
> few remaining items which were not covered by meson in
> 2.49.0-rc0 (or so I thought). :)
> 
> In particular, it was contrib/contacts and contrib/subtree;
> although the latter is obviously not true and the former
> won't be for long.  I'll definitely have to take a stab at
> building my local rpm's with meson very soon so I have some
> better testing there.

That would be great indeed and very much appreciated!

Patrick
