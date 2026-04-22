Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C823DB626
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776864489; cv=none; b=fl50dN2jL/wMaTXcFQARrIYTtctlG+N5mSJV4R597v/XvXdKKrAIerHqInNcHVIB9WgKspDMnwGVWXedBAvTAqBUReefn6ntsnq2wm+sE1nEQt3cfeWUANivFRvViaCOTe+C/GPVcNbjSCuQbkcMpnxn0TKl55gs5jAsb6oYlos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776864489; c=relaxed/simple;
	bh=oTMQ+VDSuYtw//xSvzYhSIFz8Vog5znf/BhSxa9X1n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9esJLI3jFJ8k5g9qr2Q2GfAkRIMRgfvsHA0qSytkdmfzT+Sajal8PoSUz3Z587adyWicAlGQzhe7e62AwUTzkvqyD7Ko0YCj3iLTNBtIRcVfun3KmBsN6E9cENm09id/3VG5qBdyg8EwGc+0P4/hSyrDcuCf3O7dTu4d5yffM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rKS8sQLV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nmhVfxJ/; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rKS8sQLV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nmhVfxJ/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B81DA140008B;
	Wed, 22 Apr 2026 09:28:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 22 Apr 2026 09:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776864486;
	 x=1776950886; bh=L1GdCjE2w4y2Ju0f/rwErgacaSq8p1PqfgoVudjFuHo=; b=
	rKS8sQLVfG24b1ELsRxUlxPU490H15MZ2tc3WdwHEOgR4362E5DU6zQcc/Hs4Q9M
	ObUTIW4hLxWTHNRH/sqoosPs8upAP41bh33Y4sDbsVly156dv+ufEaCNLAxkpLkw
	X9eDdLej7wTFeH1dYwIJVQ3soBRYMwL6nhNcdEJpWtNdKLL2RDs2uZ4LcBgPZK26
	Zwnmy1qgK7QUUeZvIvtIcE8bXrEANt2C/kYF0MqdJbnmVO9yLLW+M0Vx8oU3Uub8
	ngKH7ajZvvmsUzOubzpc237sEurra4DWHtqalKpe/ODRCSr6kp9RHbHgB/XR05xG
	rfs6Z4IHmKBBXguZU/wSlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776864486; x=
	1776950886; bh=L1GdCjE2w4y2Ju0f/rwErgacaSq8p1PqfgoVudjFuHo=; b=n
	mhVfxJ/XY4/thS6BXv/bQx1TIlbl6r8SI1pLdnqij2gX5uOdKDgKY3BRq/bCKRbb
	gOmuijA5DS5NircqYMEftNyFRAJsXj5eljtopD/IxJphDuJGUM3f4BJKkWRAVIol
	dudtOrqLa7hI/h/084o+l7Nb+qR6WSo49pg30Nbkz87OZQS/ytkuESW3QFC97Xmp
	gpe8E6PqD8fmbHiyFPutTiiC7RgssyeS+NumXsUd9DBy08H4HpCobaYr3C/BQtxT
	0uzii6pBM7sgmbYu4vpbJ8xQJAmDe/DOwtieVsTVqmeBxXqR1dOq734YQHFTB9pY
	dheUXHt4uSYT7uUv3XiDA==
X-ME-Sender: <xms:5szoaSfykHnfAl9dDNkIvAcW014rnsDzrUdavG8RB1MetJcwIlk_Wg>
    <xme:5szoaaAyWuM9xu7W1kLu-Q0BoeRC5vwobet6n2jUA7Nio9wnQU7KTB7h8Ir3VsSQ3
    nrDlK1-EnyhF8nVRtEkpw80di007nGru1tYt1v1U_g7FYKm2o84Gg>
X-ME-Received: <xmr:5szoad-DpO-Ff-scPqAIiw5qwwqwDzPYL39tS69rrpYi6i5Ajv-6tVNCWi23-8gdbg2VKwF0J4wdhC4dQY5LU77ko2w6YazM9yRNSWY1AwI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeigeeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    hphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehn
    vgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:5szoadLNsBn6IpGnDIMXCMTKiRV2_hULP4Tn5VYxchh0BwNyAgpkJg>
    <xmx:5szoaehhtSr8RNrauMCzM80XzBnUnhuRxzC4T18sBth8ttEiy3ZfQg>
    <xmx:5szoaV4GPrJzzbc1hqBYZJ_w-01X-UcX3THFb0uDPCzmOdrQonZUzw>
    <xmx:5szoaea826N8tBIQGN06yORmoEe5FmD6LjbKwEYwkoCtGuOR70_Puw>
    <xmx:5szoaZoXPGzdyHrde2cCkuZGjZGf0pCJSes8LTlvOourZYKavKfn2w2v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 09:28:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 40d9d1e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Apr 2026 13:28:03 +0000 (UTC)
Date: Wed, 22 Apr 2026 15:28:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 2/2] status: improve rebase todo list parsing
Message-ID: <aejM4EY29MGht5or@pks.im>
References: <cover.1776697483.git.phillip.wood@dunelm.org.uk>
 <d20dc1f6550078883995ae963b91faaa00984c6e.1776697483.git.phillip.wood@dunelm.org.uk>
 <CABPp-BFziRXjuMKqf=RHgCwuCcujXSSrz0f+BS4pvE6EUbk-WQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BFziRXjuMKqf=RHgCwuCcujXSSrz0f+BS4pvE6EUbk-WQ@mail.gmail.com>

On Tue, Apr 21, 2026 at 05:32:21PM -0700, Elijah Newren wrote:
> On Mon, Apr 20, 2026 at 8:25 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> > +       /*
> > +        * Avoid "default" and instead list all the other commands so
> > +        * that -Wswitch warns if a new command is added without handling
> > +        * it in this function.
> > +        */
> 
> Nice. :-)

Do we actually use -Wswitch anywhere? A quick grep in our code base
didn't surface it, so I'm a bit sceptical that we would actually detect
any missing cases via CI.

Thanks!

Patrick
