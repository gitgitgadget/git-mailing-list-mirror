Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C87A2D5940
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 09:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759828324; cv=none; b=B9uULkLDqJTLDPLxYe5k0CSlXXqB2+6jjVjWxEwRY6u4e6V47QezXUMuf8H2iqRy7rdK1N9KeOKvgt3foZFmskDcoS8tSJ6qzawoHENlP6iD1YIk/4dUp/FktfK+bh9naJTbiCUstjo/AfHSpEAkztRLdJn0ckvoeNk9f2OTCfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759828324; c=relaxed/simple;
	bh=VLhuOgmmjNhUVNcIU1ku5foQ4/Ld47uwvkzjinzn5uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sO51CxFUaWSFGN3mvbvRvT9UEKsZwAEpSDzldOdIjPie+Z7btDTeRXmnKT41TlP2irOBfEDdkRB9Ag8I6jSREjoBJapMd12iwqJpQoTc2hm9l4LA4Tnlz0FDZ5huz2+md8H1JG1Ey1MJZkBHuSiujtwZJNM+VvGoOCatH7uwabU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D9dF/uz0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P0xRNwFX; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D9dF/uz0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P0xRNwFX"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 1E26E1D00146;
	Tue,  7 Oct 2025 05:12:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 07 Oct 2025 05:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759828319; x=1759914719; bh=NxNvsU+vRd
	aKEHXkIoTh4g4vrTTFMQtDfxcXOteeo2c=; b=D9dF/uz0VybM0p5MoINAG/ltmg
	832Wgk8ydR9gevvDRCK1RX0maVb4YCPUH5I0noI7AvcO+2oPs1xwuNi0ZyzPteTD
	/a7NPH6L7YI33i7D26f4TbyK/1ITTOo8d9/TSi42xKZQaWhTetUGt2SkhbmtPtOs
	urlCG4GcOjju6Z5gA1awW0VsUukSC42sbOoma9B+vhNn2wVABvml4A20BfP/Zyh9
	XaiDBefg1pzyyfmxbWoofR6eBGChciR9fjcx9DFVCnqyzdNavL3rpzeU1mhEzl9o
	O2QfzxTyrpA0bypXA5l6rQb73J4QHe615OKMNP7vKD5EoZYJ+MKznCYOjY3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759828319; x=1759914719; bh=NxNvsU+vRdaKEHXkIoTh4g4vrTTFMQtDfxc
	XOteeo2c=; b=P0xRNwFXrLFA1k5ZlKQuqNgvXXbcWEnDX5IweIpQq28p72wyyQ6
	XgSW4K5RQHFZtd+eYr3KeuZ92sBZPvcND3sIOavq08B6ov+aranRgLIiaM5ilwiK
	O5o5zGIztqDK8SHbVPN6fCqV2YUiWt7Pc3gUY3e3c9A5JIChm0Z4GU+o0gAj/J6q
	VSf3CAozkfrS6b+6Q43Z7PE/0rhQheOHutdz264oeOjw8gwCv1EzKRR/Rmq48IrD
	SjpIQu5QHn8KasUi4nV/pU6EBvmRrwXUnVbu0v98iWa+demvvDoidlY39jWaeg3r
	S2n0kWXba7d7Teopy6jF5Iil3JCP7XLoq5A==
X-ME-Sender: <xms:X9nkaL7WC6gPQscR_0j5TNzRWBCwkHRbPX8J_GUIvgeYzaIjaEz2eg>
    <xme:X9nkaPKomU2JFXHetqxmkFQ766xFbnCumAbOPJxnwk_YQeeuX1-1QpA8KuaGrgH_e
    _k6mbO27yhtqVx8MX78EGm_Qi7oe0zDM2HxFkvdJ7N6z4icpQC6>
X-ME-Received: <xmr:X9nkaLyenKr1bvW4sYDT8iEohEbllmJF7y-8Wud-5j6z2mDQhlwkzX8jEuHCqTP3bwmguUWbmQrrLSzrMANn0RMz_CZG1YDO074vnfgGu-c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddttddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdr
    uhhkpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehjoh
    hhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehsrghn
    uggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:X9nkaPJQga_VbEW_XT16_t5wmhO3956NHTyPt32Mvd9fdtLlVfur7Q>
    <xmx:X9nkaCX-qzOA0uYZjzjsmJMX8OXAkh1GwfK1x5CPn7-CaqaBEQzTVQ>
    <xmx:X9nkaKbe3aOojp3JtyRsv_e0GR_YlgJ8VjaK7-Z9tyMNqQMyrrjpRA>
    <xmx:X9nkaBwq2hhv4bDtZKx-1TCPGcW1x4cRhjbqOApsQXZDtvaygXbYLA>
    <xmx:X9nkaB9S2dgNo6juzu4dCmS8uJ-9HpXNttJIDPfnw8kxlQRjW31CkaDG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 05:11:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 765e8e83 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 7 Oct 2025 09:11:55 +0000 (UTC)
Date: Tue, 7 Oct 2025 11:11:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: gitoxide-compatible licensing of Git's Rust code, was Re: [PATCH
 6/7] xdiff: conditionally use Rust's implementation of xxhash
Message-ID: <aOTZUpVzEjWNQIND@pks.im>
References: <5a959c9bdad79cf972b95dcf4324135dd7c94dac.1752784344.git.gitgitgadget@gmail.com>
 <5596e569-6632-c2b1-37af-a978de5408cd@gmx.de>
 <dd3a7ab0-947b-4592-a086-8c7028f02ffd@gmail.com>
 <9818dc92-3569-3e6f-0252-245c2bf0bf84@gmx.de>
 <20250923174825.GB1136654@coredump.intra.peff.net>
 <bfaaf26f-5759-4812-9057-b3e0bf7c7949@gmail.com>
 <20250925022555.GA3202669@coredump.intra.peff.net>
 <20140030-6bf1-4393-a941-bfdbc69c79fb@gmail.com>
 <20251003031805.GB6381@coredump.intra.peff.net>
 <ea27273a-378e-4f75-90f2-6615ce297a43@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea27273a-378e-4f75-90f2-6615ce297a43@gmail.com>

On Fri, Oct 03, 2025 at 10:51:47AM +0100, Phillip Wood wrote:
> On 03/10/2025 04:18, Jeff King wrote:
> > That probably needs to be explicitly granted
> > permission to relicense, whether to a specific project or not, and it is
> > hard to pinpoint a definitive author for a lot of it (even if many
> > authors have agreed to relicensing) because it has been touched by so
> > many people over the years.
> > 
> > So there are probably two separate legal issues to consider:
> > 
> >    - how the explicit re-licensing grant is worded
> > 
> >    - what problems may came up with porting existing code that has been
> >      touched by many people
> 
> If we want to seriously consider this we should probably reach out to
> Conservancy for some advice. Did this end up being discussed at the
> Contributor's Summit?

Not really, no, as we didn't have enough time anymore towards the end.

But I agree, seeking advice from the SFC might be helpful in this
context. At least until now I haven't heard from anybody who would be
against the idea itself, excluding the potential re-licensing woes.

Would this be something that the PLC can do? I don't think it makes
sense for random Git folks from the mailing list to approach them.

Cc'ing the PLC.

Patrick
