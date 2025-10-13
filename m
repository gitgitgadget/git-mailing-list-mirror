Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B071D201017
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 06:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760336001; cv=none; b=dxLvlMCX1Bup1EfTBcg+2hmQct95cwXOLNbf21E/EA3gkmRMkDGmyvdyWdnoU9JZitQcQmW8sIrne45b2pyi8U7itbdPB7DOnbsOIeAiOPvjhV7gDcGsYx8EuujFrodIU0VPP+ju0rlXeRYvS/W/s7QSoJrX5WHGMbVjas+M3dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760336001; c=relaxed/simple;
	bh=BgV5iXZa1Ef4BH2ck/EBaQNnDJIzlbnd9EOJDFXkdUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPbnWD35aQHkWlgQL0WkYe2BVzD58rRLjZ2slbSzGEyEMwnqIaOlFufaXvaP4BEj/18Qe556AO54PbqaKiaV7BNAJaI3MBGSFmaRthv9TMS3odoH8tJ4PNaNzreaYTpGfCZW9+A7iYTa1qdcEsfx9yWBeGtq1jMN4vFbs5P0vms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jqGHGx/8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aS7Wug2z; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jqGHGx/8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aS7Wug2z"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 8BF151D00069;
	Mon, 13 Oct 2025 02:13:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 13 Oct 2025 02:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760335997; x=1760422397; bh=le6g90OMol
	Ij31xttKQl6vgSOe+mCHurr6K7yOZp29Q=; b=jqGHGx/8oZcRZFsrus7vsF/bUk
	wOR2af2lpZwuHF3CAuBSV/K2C/sPB6gF3ojmzoDjmArP3yEsKOxx7nX7xRAafQRt
	G4V6v1p8cEalTPf44EXNcxY1TN8mb1CUFnfLoZL2U6wTbAZPdd9u0JIfBWlYoudF
	9B4vIIbzqg+ZTLOAl6k43YP3mrtKtGk0R4SJAU9ZwTRqtZMDiSAYDYdczAd2jQAw
	iFSgOjHN41TM14qiL8347Z7JWTyiU0Xax9uBWV6TY6t5GgLTIG/4n0eJlaaBflIC
	B85NEfrGaJzFgSwW+uyGR7F5utMwfuw+qlaYF+1P+O3hvPpox09/pGuSBWtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760335997; x=1760422397; bh=le6g90OMolIj31xttKQl6vgSOe+mCHurr6K
	7yOZp29Q=; b=aS7Wug2zvHeXiJLA/1FLeIcEMYMXQMrA2diI+cZ72Xcf5ilX6f1
	EsitvRgTZsCd0gY67cD0ZR/iyAbUTPQOWv/bChv39r8uDOsUsk1oAA6UXHbGp94I
	bEjJUUQWtPwdMuyvFyCVJEyyiMIXdBM9AOBiAGKUHQJCNNtaD7tC7uWzd+d0mNpw
	TNFVYGaLtkSVNgzKyPW59/ReuEYIM/xr9/0RfQ+RZXk5C/pDJha8bEGNLgrJ6/9E
	tw6OxDxSYQjp52CYcxfS65S3ngo4yiwFLvX84KdgQNYmmUKZBAVmIqeESXCRVl83
	HnuyotcyGN0yEwQ7C15OHgsA5+I04rmM9+A==
X-ME-Sender: <xms:fJjsaC0NEVCBKEE1ORajklVv7f0MPOueUf2A3iCpmD0MfAaxZqQUrQ>
    <xme:fJjsaIxLBoyfjuO4SMAMQOqowohntTCi4lvTlcV_BvmZwc-DiJbTzFYN9VTc43T5w
    6JgsKKbNqciH6FuzKgd7c4WvlhH0LMxdi-SZtD0SDGgOrDbawuAwQ>
X-ME-Received: <xmr:fJjsaEtNYZzXEHjINGgVahnM86q-kGA6MEKCp5HM7TiOEv1I_0Gdgt5eJiPgCFxTANvzm1PxpcC10pY16wp_d4mbFHHsuKUXXptmzU1R-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudeiledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtoh
    gslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsuhhnshhhihhn
    vgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:fZjsaKy68C_6oX1SzAXnbgPXVcqG8A4c0sRsHBtMMa7XKqNHQhAqLA>
    <xmx:fZjsaHDSO1Yb6FzjZRWEOGgmYbWGIPS3lo1LuLH-m5A5zbyTj2G-2Q>
    <xmx:fZjsaIdY-STzLQo7HWQPwpm919QRQZxjx_oQYFLlaj8syhyJxFJA0A>
    <xmx:fZjsaBlyMIA0M6vohmrfvBzEl7S7Eh8iEcl6TegiBczoR7qLE7sphQ>
    <xmx:fZjsaD4weZGrsIAcyzVltI_myCnlw4RpWz0j_L2iqrzyFOD_ej25r711>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 02:13:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 648989e5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 13 Oct 2025 06:13:13 +0000 (UTC)
Date: Mon, 13 Oct 2025 08:13:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	karthik.188@gmail.com, sunshine@sunshineco.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4 4/7] builtin/repo: introduce stats subcommand
Message-ID: <aOyYWQ5mU4zc1oCH@pks.im>
References: <20250925232928.3846-1-jltobler@gmail.com>
 <20250927145049.723341-1-jltobler@gmail.com>
 <20250927145049.723341-5-jltobler@gmail.com>
 <xmqqfrc797pk.fsf@gitster.g>
 <qdot36lscj2jzuej2zixdlgocubiimh54dkxzl2xgcy3g2n42m@gpdi7jwc2oyd>
 <gzjaa3nmv6s44dszregri7kcnfxg6optkycg2wggtib6bxvdgq@elearr6dishf>
 <aOithKtHf_U9S_m3@pks.im>
 <lnk4zvu5zgokd3p5lxnl2nwbqu3fi3yer753tr2f2jaknrtb3h@fcbjvvu6irtc>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lnk4zvu5zgokd3p5lxnl2nwbqu3fi3yer753tr2f2jaknrtb3h@fcbjvvu6irtc>

On Fri, Oct 10, 2025 at 09:34:54AM -0500, Justin Tobler wrote:
> On 25/10/10 08:53AM, Patrick Steinhardt wrote:
> > On Thu, Oct 09, 2025 at 07:42:40PM -0500, Justin Tobler wrote:
> > > Thinking about this some more, a single "stats" command is indeed rather
> > > vauge. Furthermore, as Junio mentioned, there could be other aspects of
> > > a repository that we want to display stats for in the future.
> > > 
> > > Since the goal of this command is to surface info about a repositories
> > > structure, may we should instead call this command `git repo structure`?
> > > Or something else along those lines that in more specific and related to
> > > goal of the command?
> > 
> > Some alternatives that come to my mind:
> > 
> >   - inspect
> >   - analyze
> >   - scan
> >   - survey
> >   - measure
> > 
> > I don't have any specific preference. What I like though is that those
> > are verbs, which makes it a bit more natural to use them.
> 
> If we want the theme of this command to be the repository's
> structure/shape and have a name that matches this scope, I'm not sure
> any of the above examples would move us closer to that. Aligning the
> command name to its scope is beneficial if we forsee the potential to
> introduce additional subcommands for git-repo(1) that target other
> aspects of a repository.

Fair.

> From my perspective, the main question is: should git-repo-stats be a
> generic command that can eventual provides all sorts of different stats?
> Or should it stick to repository structure/shape information? I think
> I'm currently leaning towards the latter.

Yeah, I'm leaning towards the latter, as well.

Patrick
