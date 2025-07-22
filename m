Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BB52E88BF
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186893; cv=none; b=q4pl8GUr/UH//3DvxBvY01CU8sPmgtRN99DsCPN2MyE+8ddUni2ZUZNIjF36RpRnLhCT//ZSHiVf8/cEJMJFd69+2Di7rpIkWjmluCm5Vz+FGtSW2e/sUBfurMGbCmuiEV63BUV/GDoQzyjpe/oIsEu23S9Z++ZiYaFkFuIk5F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186893; c=relaxed/simple;
	bh=A9halASLsTZJ62xV6JwEsn5KRqKsbQMIic/3mPFtpPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCd4XSIuXRUpB7RtLYQnFojbNb/H4wv4mdF5PWLrerWotb4KVZEnjjpJInLY+x+PsYwc+Ko+5yN5L2dqKFgfS9j/an1v49xIoBd/AwuMG9cOPI3uH+60mt+czdeDiqm4r+NHoYUi4PsLyyLwChGsK3Ar1N1oVa6RoZSDNMGQrus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tt0UOi/X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OFfxOrWi; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tt0UOi/X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OFfxOrWi"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0C547EC02D7;
	Tue, 22 Jul 2025 08:21:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 22 Jul 2025 08:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753186890; x=1753273290; bh=23FOFedSb7
	+BrN4cyaZUChAp847klcbl1ilRlOXV0BU=; b=tt0UOi/XdcL72UrDEdLxw4hFfd
	ZKZzb8lxtKhuEr9fTK6zGm4Vm5xWriHpoqdHDxGDTk/yr6VrZoSlQlXT1c9LXVeB
	gHdHjyD2agApaZJU78u7fpzDamlCrpJvesZGX7l7X2Zkb7gEKL/WqYUT2hGRW10j
	Qm29NeDfilj+oUdrFqaU+cmaVj65WumvnUumThqC6q/xxnFGNLcMV3jIvZGuDrSv
	D1h6yx7Nl0gwDEKrizfYbP0cV8dUHc6ZstXWbNAltM3iwjYmLhUDdCZeqJCw4IUo
	nIjWMgiKHkjngFFQA+/i3FqGdl2JLq8AsUEIR8PDLkJRVcvjjRUIKCrCq/mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753186890; x=1753273290; bh=23FOFedSb7+BrN4cyaZUChAp847klcbl1il
	RlOXV0BU=; b=OFfxOrWiMbcHpSbjkW6b+rdYG978IW+hcSQxQWeWqBglhndhgLd
	byij2nQAo9vCVe2mRMj6pRYdmmJ+C+OhQRRWrfzG5XgOo72zndpf6EdB2g6CeGEG
	cWkBdackqkQM+4oOlEkhb4NiukuyHe/g/y539XZhmkAYUL81afMxN0yvqwy74kgF
	NISMTwLVxbKiWR4Fwlsw8Oud24Nh+OkAEg7Uo13IyQAwDCGocpqjDqXMMLJ3/1xx
	HgfWt88NnejCD0U9sa0mUlm7IxSVt0Gp5XoxcM69UHbm7o3LrkzwGu5aHObbJiQy
	jgNwleuEaO7j7ohZ1jtsu0QMCGdEqvgKsng==
X-ME-Sender: <xms:SYJ_aMcJntJJ77EKp1eWZHZfM-t_dCV-YZVXyiEqNd2VCJmsyRyF4A>
    <xme:SYJ_aJ4sLbNcJIjqa7-6htcyNQ58qiik4rrYr1Al-sPrID9jnbMQWH5sIlirTgkwn
    8R8KZ28wgmQJgSLTg>
X-ME-Received: <xmr:SYJ_aJ_0bjYuG61Mls84PoOsM79MzMnazZ82r_ehlaEyvIoO_TvnMCfyPENAPdl5y1L6989p-fYmGDfA4kaA8JYs2EfcgUvnoWQpLEC6Mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejgeeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    fhiefgvdffvddtuefhlefgleehgfefveeuteffudfgheetgfevlefhueeuveeuvdenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhn
    rdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtg
    homhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopegtoh
    hnthgrtghtsehhrggtkhhtihhvihhsrdhmvgdprhgtphhtthhopehsrghnuggrlhhssegt
    rhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:SYJ_aLHZtp077J8AbmkdmENpvMz_uC2ddNItkklDEQzTbFlBkR9p7w>
    <xmx:SYJ_aOUtnnQVwTn6SwcfiE-6k2VLGvqDfFRRCDugiBp6kaHhFla-FA>
    <xmx:SYJ_aH-xcT21p7jMprvVe6rkisfwOYiZqumrlUhUjCHUCakYaCe99A>
    <xmx:SYJ_aL69ZtShlvyv-UVUrOMVW8QfzrehVJzK_1pRuT2cUOkZoGO2cg>
    <xmx:SoJ_aKNLZOCMvROT6iLLqesG2wKRHMTHz7_facmIgBOFQrDeUWgmB46I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 08:21:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 76135ac8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Jul 2025 12:21:27 +0000 (UTC)
Date: Tue, 22 Jul 2025 14:21:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Edward Thomson <ethomson@edwardthomson.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
Message-ID: <aH-CROwg57Juo9mH@pks.im>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <f439958d-64ce-417f-8175-720f69387d48@gmail.com>
 <79c1b3ab-af2e-4c93-b033-349221d82ad9@gentoo.org>
 <aHrrZyrDw_CYmFQF@cloudsdale.the-delta.net.eu.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHrrZyrDw_CYmFQF@cloudsdale.the-delta.net.eu.org>

On Sat, Jul 19, 2025 at 02:48:39AM +0200, Haelwenn (lanodan) Monnier wrote:
> [2025-07-18 17:25:01-0400] Eli Schwartz:
> > On 7/18/25 9:34 AM, Phillip Wood wrote:
> > > Hi Ezekiel
> > > 
> > > Thanks for working on this
> > > 
> > > On 17/07/2025 21:32, Ezekiel Newren via GitGitGadget wrote:
> > > 
> > > > So...
> > > > 
> > > > This obviously raises the question of whether we are ready to accept a
> > > > hard
> > > > dependency on Rust. Previous discussions on the mailing list and at Git
> > > > Merge 2024 have not answered that question. If not now, will we be
> > > > willing
> > > > to accept such a hard dependency later? And what route do we want to
> > > > take to
> > > > get there?
> > > 
> > > As far as git goes I think introducing a hard dependency on rust is
> > > fine. It is widely supported, the only issue I'm aware of is the lack of
> > > support on NonStop and I don't think it is reasonable for such a
> > > minority platform to hold the rest of the project to ransom. There is a
> > > question about the other users of the xdiff code though. libgit2 carries
> > > a copy as do other projects like neovim. I've cc'd the libgit2
> > > maintainer and posted a link to this thread in neovim github [1]
> > 
> > 
> > A hard dependency on rust for Gentoo amd64 would potentially require
> > building https://github.com/thepowersgang/mrustc followed by building 13
> > and counting versions of rustc in order to get to the latest version.
> > What is the minimum supported version in this series, by the way?
> > 
> > bin packages for rust do exist but not everyone wants to use non-distro
> > provided binaries, sometimes for auditability reasons.
> > 
> > 
> > For Gentoo HPPA, Alpha, m68k it will simply mean the removal (or end of
> > life and staying forever on 2.50, perhaps) of Git. There is no rust
> > compiler there.
> > 
> > Even s390 support for rust is limited to a precompiled version not
> > everyone is willing to use.
> 
> Also in other distro concerns, if it trickles down to libgit2,
> extra care should be taken to avoid creating circular dependencies
> due to cargo depending on libgit2 (via git2 crate).
> 
> For example with making sure it can reasonably be built via meson's
> Rust support rather than through cargo.

I think it's unlikely that this eventually trickles down into libgit2.
The bundled versions of xdiff have already diverged for a long time, and
unfortunately libgit2 is mostly in maintenance mode nowadays. So I guess
that this change here just means that things will diverge even further
in the future, which is probably okay-ish. After all, the whole xdiff
library didn't really evolve in a fast pace over the last years.

That being said, there is an xdiff fork located at [1] that libgit2
maintains nowadays. So if the Rust dependency ever became a problem for
any of the downstream users I think we could simply redirect them to
that fork and make it the canonical upstream for C-only xdiff.

Patrick

[1]: https://github.com/libgit2/xdiff
