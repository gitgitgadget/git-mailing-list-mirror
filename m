Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EFC1632E4
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 06:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736403655; cv=none; b=mAPgV9LaL0riygy3EBxGwF9jtvvW6qiZFlLmufOUpM8werzyxoLy1PDdTu2RVUgVdteDxxPn1FxCKXrLe14Xh64C2UTmdfOY6V/md+z1vizreBZX8eFrcSAzBeGyWUp1tFypJx6luvq0X296GhrFF0Y1Ryus1pPEQTVUg6+q0nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736403655; c=relaxed/simple;
	bh=6J1qbX77BLx7TJ1NnZpxDnH9JXiZ+PQP2LfLdm//hzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+p8tEtZ1aYP5pGoBPkjJuPW95bb2mWId+d5kZgtT6AV13loQFHH3DZD8qNr722C3WOYDmny47zmAp1Ft5bj3vf/cJM2V+Rm8R6urHRDJNnSCktczf0MoVBPVL2lnPt2+bywjzpsYrXjNpLt7Yg3V+2FAQZEsgsdzzGCdvo3cPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aBMfGqN6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IRCssD+s; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aBMfGqN6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IRCssD+s"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 3653E1140159;
	Thu,  9 Jan 2025 01:20:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 09 Jan 2025 01:20:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736403652; x=1736490052; bh=DgqaHrPmap
	Mr1E9k34ub3CwcuaWMVdFCNbSP/m7HbMU=; b=aBMfGqN6CISo4X+SMpfeuEKeuZ
	tkv+uBkA3xUGiZJbwicO4yRfhO0ShC3KsPMMw5Z2HyHKUPqJTRrKUgilXhutW8W8
	wdCtP/RntXParNQ8i5tTwVTMDMlqYFfO1MDsU+3KBXE7lUO1haxlmG53ITe0Yy+V
	ZYeZJPOcdwHS6DYT/WVt6mp2+cH19lhck/KKxSePCA1NIJXdHrpJ3I9Q00Hp3NSM
	lY8MlrJyCnbBjSf/BdyrhTmYhunaVBHJedB7SO06e68mkj00smMoXNxwKCQfVEw+
	+flUf7j/eBL48IH5SAJF/0NEVt/njpIxLhGzCt5YutbkA4s9NN0v7idHx9Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736403652; x=1736490052; bh=DgqaHrPmapMr1E9k34ub3CwcuaWMVdFCNbS
	P/m7HbMU=; b=IRCssD+sLGO2Yi66+FGUtSXpfbmeKVfeWNp7VAgmf+QXQmuuUde
	px5dwdVBnK4yCOXBolHZVJ2WldS5fr5/jxlJglIOKBlovVcAkY1TfonJwcpnymLI
	EXUfjDcLaO6Jussx1pP2oQIbS9kY3lHnU5GMRIA4lE/lYBqOGTryq+uGsMfOnjQJ
	yc6A9CRIVCeCtEiTUXGzbHp4D26uHpTw/0D9BP5jJ9FBTDKjmrIanXVf+SMKSk7s
	pZVz8OhL4tyCWJ7v/c+0ccIQEdBZegxeLwA8/2HHOaXuPuLqR5kkdbpv/ofTWm3v
	NUvsyibDuWw58KGbFDcEo84a6pE8TyJAJpw==
X-ME-Sender: <xms:w2p_ZxN9Rs0xUoq68JdrNoyC0Mm3OEl1LtRsvFhLADNK7NJeL8D9ig>
    <xme:w2p_Zz9v3MqMsxofwRrZfDs5_QuAyIWa9XNWHXOQ7pJ6RlJ9GcD-bW11aacQCeqXI
    WbCubaHbVLnB5m4lA>
X-ME-Received: <xmr:w2p_ZwRQQpP5bdywQkNoV3wHg9VXlnz1SpW2_x4zEAz66CLB8AFdfg86N2WNV8VzMSHUfsT_Fcm09Ayk2dgS5caiTXt8AXtiG2En7iNjCIm46reo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeghedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgr
    nhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:w2p_Z9sVs8eacaFTSfn3srwewoV2NuAhG05k3_EtnA98IuN20lhkyA>
    <xmx:w2p_Z5fUCjnvzSFHklCK41EN-x3v-Oi6herqgVz9vW7iQD6A2g3JMQ>
    <xmx:w2p_Z53KtnIRqnoELvODOUxykpq7XOli3TIVMn39fADKGVtYPutWAg>
    <xmx:w2p_Z1_kNnOmGXvrLTsh9fmb7xbuE596Z9EbK05K7z0Q0yb4eHvaZA>
    <xmx:xGp_ZyGQiGQcxhABQxizLo_QzMF31AavEb7lx_uYkL-D3FEyGnggrUph>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 01:20:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 026b5f3b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Jan 2025 06:20:49 +0000 (UTC)
Date: Thu, 9 Jan 2025 07:20:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, shejialuo <shejialuo@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 13/16] builtin/blame: fix type of `length` variable
 when emitting object ID
Message-ID: <Z39quLJkI42TwuaW@pks.im>
References: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
 <20241206-pks-sign-compare-v4-13-0344c6dfb219@pks.im>
 <4d812802-afbc-4635-7a19-73896fcda625@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d812802-afbc-4635-7a19-73896fcda625@gmx.de>

On Wed, Jan 08, 2025 at 08:17:23PM +0100, Johannes Schindelin wrote:
> On Fri, 6 Dec 2024, Patrick Steinhardt wrote:
> > @@ -501,7 +505,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
> >  			length--;
> >  			putchar('?');
> >  		}
> > -		printf("%.*s", length, hex);
> > +		fwrite(hex, 1, length, stdout);
> 
> I just noticed this, and would like to point out a difference of behavior.
> Try this at home:
> 
> 	git blame --abbrev=99999 git.c
> 
> The difference relative to the previous behavior that I am observing is
> that the `fwrite()` call does not stop at the NUL character and hence
> happily continues out-of-bounds. The `printf()` call would have stopped at
> the NUL character.

Oof, of course, that's an embarassing one. I'll post a patch in a bit.
Thanks!

Patrick
