Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3DF165EED
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731313803; cv=none; b=Qm0vpy0mQH5V0csr4S12++YuIBNZd1XRXb1apHu3b1VpsSVHVtthOdu9qz+jpntqmae5QEFU5Kx+Na28lDciLFOixyDdr+G8FrmcyTOOc03r4LnvBmWir+gcpa6RIU8k+/5FQCGh9dI0+1w1EOnJ50pkbBWBDuithOsR62lu/oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731313803; c=relaxed/simple;
	bh=VDCRclbRyP+G/pFrAsuAAhiVDpTvpV14MXLrXkJ6T4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q10tHXVfdKzKLiXFpZNM4ZWSyEQ6+P15KakJsh7HIMUJwKqkeg5Aj7SWObhGbH4ysJwlRYEKXPWTPMNvS99fm0/BtDRG71iq4hp5Uys6dYFhHEE+3GVnfrN7B2Vg9zzgxq5E0L8eEfB1XNQnLvTggjkiKOTPz6/gSZUD9kfXJTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=3r48Kjrx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FPGI3l1+; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="3r48Kjrx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FPGI3l1+"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 7645A1380280;
	Mon, 11 Nov 2024 03:30:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 11 Nov 2024 03:30:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731313800; x=1731400200; bh=XtZtd2Uu3m
	9LZ423iG6JyBBIZ10VSiP2rsyTQ0Us/o0=; b=3r48KjrxQZaHdSPMRLC9vCqr7f
	WHcWKiOL1CXrJ6byF4IoiavvuiQr9AulEHT4d7s1DGherS0X7iyVHGlm/2jh+41B
	IG7tiovlMnG4Mnh8PKR5vJgodXB3Uz7de8PFfue/F6lCxmv6Xf36k8gumB6dMXDl
	CEP9bBE0qWlg60DB8hVgu3aBDJDP6NvBlVUJXu5djEWnOOiH7+VVycNpOB/8T0/L
	3tU56laiLrrtjdXZT/xKWbauiWU245PU5aimiTqr473yOpXxEV5wcQUtgIWjU7ST
	13OUY1FfufjXm//JE7dMcpFBSLElghM9xPkEurlNgqS+LOA0qDnjoMMq61rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731313800; x=1731400200; bh=XtZtd2Uu3m9LZ423iG6JyBBIZ10VSiP2rsy
	TQ0Us/o0=; b=FPGI3l1+fttETLvxFWsBnOMz2uF4WQC0q+1DqoPL4bTae9VIOs3
	CgCqiOrX12z2zEX7PbwQSrX6Kz5SI9ga0xGpVALinmSC6A+ImcgPvo96axi2SBXy
	rwcMd4AIjF83/NzvddZaJqAnVQbTNCEIKFQjjqoCc3erb81z2Cfzb1fpHUk+00tp
	qz0AY9OKlZa5JSd1uCaaMh/adnEJ5Il9Hu1t3rKzbfQhy/EmP0tnIotlWZ2KuWlk
	NHJDUp9qn7vwJUwZGl6RB9+4oCCXAYo7wChcKjX4pL0ncV/2exNI67PqY9jF/DVC
	tDMkabsU9JjI4+PNy+GuBmkParVZkLWs/gw==
X-ME-Sender: <xms:iMAxZyirMl5VTXpKrIEX7pA-Nrb7jucIzKX0AcOjAhrUM9RvoQAYsw>
    <xme:iMAxZzDsLmJP-Nqmyax5po_fxrsTdaKhWob4oJ0SxuY2AKGpuFW0M6YtLS2Oh4Jgd
    XPO2QNty-aal1Pd5g>
X-ME-Received: <xmr:iMAxZ6EIzklKfuGLSy3ATmYz9kqwO-KX0qwWRdSxZRv30lWVuES0QlPMgoCzTKWwkknBFX8KxUVNaP-zKtpAA0ScRovVW6IxmmFePFDUB8z_niuD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnh
    gvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:iMAxZ7S-yV-FGBAyWeImfEpZDxf5KCi-oP19wDZOK_CkkkiLPv_PPA>
    <xmx:iMAxZ_yubyyHM9RhesAmdY-YqnS4lBf_9OG3cvPOkqhpSv9ialUQkg>
    <xmx:iMAxZ56F-puNqAxyEVXqRqRTbM8SEMa54634cdtJw-kZJCVq32Ii6A>
    <xmx:iMAxZ8xp_CHkOYK6o-K43xkRhEz1sGjSYGgEbzWgjbgCLTO3zV3vQA>
    <xmx:iMAxZxvmrHp5dM144B5g7NBgb1wYGwc4iwsvjSBqaNaRZhgtA0nzhx11>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 03:29:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7dfe3dca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 08:29:24 +0000 (UTC)
Date: Mon, 11 Nov 2024 09:29:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Build improvements for clar
Message-ID: <ZzHAfgR_NpBfTkpV@pks.im>
References: <20241108-pks-clar-build-improvements-v1-0-25c1fe65ce37@pks.im>
 <890b423c-9756-4e1b-a6d0-3990f1091f5b@gmail.com>
 <xmqqiksuk0yk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqiksuk0yk.fsf@gitster.g>

On Mon, Nov 11, 2024 at 10:34:27AM +0900, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > I've been using the CMake build in Visual Studio the last couple of days
> > as my hard drive with linux on it died. I ended up with a slightly
> > different fix using "sh -c" rather than putting the awk script inside
> > a shell script. See the diff below. I don't have a strong preference
> > either way but it would be nice to fix the line wrapping and add
> > VERBATIM so that paths containing special characters are quoted correctly
> 
> Thanks for comments.
> 
> I've committed the same sin number of times, but a scriptlet written
> in a third language as a string literal in a shell script is
> somewhat awkward to maintain, so I may have slight preference for
> your variant.  Either way, we are now letting the shell, and not
> CMake, to spawn "awk", so if that was the reason why the file needs
> to be changed (i.e. CMake perhaps failed to or found a wrong awk),
> either of your two approaches would solve that by delegating the
> task to the shell.

Yeah, I don't think it's particularly beautiful either. Personally, I'd
still lean towards my solution, mostly because it allows us to iterate
more readily in the future in case we ever need more logic in this
context, and it avoids having to handle the redirect in the build
system.

So I'll take the VERBATIM and line wrapping suggestions, but for now
keep the shell script. I'll adapt though if you think that this is too
much of an abomination.

Patrick
