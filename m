Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125221FDE35
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974224; cv=none; b=f2rQiIuKG6q5yFkrimx49Op21YkMM4puLC+qEdBnDVg0OFFYmbhzal18ZhFDxKyiaMJW83/lwfALdgIS1UTkI+iWY5Y/Xdc93RUzoaTX/B0Q0/gHPnCfZeYcyDGl4f4ArZ5e5DEI9WSg+k/MdvvQbIbQ65X+XrY2NjT7QDBd6II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974224; c=relaxed/simple;
	bh=OJYMikqwlxaIMQunpun/jmG23Slc9d5zQDvrjQStjsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcUeDEq8fZXb3qa+2iC/UCPrSIgi2q2xdXEDE7MoL3xmQ+dtFAr68w7ZzMJLo5J5xHWOkOucZQ2ExiVfaZvywZuk8FSsXpvHNF4euhdNLAiJwZvB9kHKV4kPCnM8NtYFAQkRctZni3CrfANQqhVBKrpBl0m8HBzzravxl3A6jnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QCedFrUA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BtKs6dHz; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QCedFrUA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BtKs6dHz"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 167AF11400AF;
	Fri, 14 Mar 2025 13:43:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 14 Mar 2025 13:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741974221; x=1742060621; bh=aHEkxf47nU
	2FxcXNuxYAHJJdAb9fNPrQzvFLfPJVDUM=; b=QCedFrUAKSiBQuAoNkJQU1I3GO
	OnNy2Sv6jo7GENECHgzy90jcDY6UFCt8HJRtDZvBn/6K/Q4/9gh6K/CI+D6a+/7X
	Aoz5/D/c1aqRzc3ey7cHvkmOpq+X7rrw0cKLT53Rl97rvc8QruDPjxxQiCyyFuG8
	WhBFvTkhIWlNOfYx4bbKA65cN/KIsZm7RfcBjcYWu7YvNR8TISOGIlDgFravzJ1M
	CHE2IrBioF1jGk0WqV0y1RhHEJIPptdZmpHvPyQEjNvOxvi5drmu0C2Hum63+gNg
	9TMVK/sRZMeI3Z7SPFE3+vOfjP94L4tEaLAtLYhlNGgrPUAoamxwPuDAM7QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741974221; x=1742060621; bh=aHEkxf47nU2FxcXNuxYAHJJdAb9fNPrQzvF
	LfPJVDUM=; b=BtKs6dHzSoE/tVnUeZPmcZ6Kji00U6TeWKfHpbKux+XVooSiSi1
	gl0r0iOik39JIoqhT40HOFIwUGGhvjNS9JBQjkhAQDLJqHnKPrvlkjQ2mBlqKH0n
	SJydsNAz1OEfs2chebW7q80zHyzFrPmwIwM7tJ/TD+y0Ktx/3OPasn/Guga6MpBt
	wCkmr1JiWyLtTidLzESyMhkvK0EUTRCOHDPQiQXx+VTcUOGMVNh4lMwyTvYSWBYd
	LwyBHUmiKaDgl43PEVmTZj0OW7ep5UgHcKYRB4rzKwkKLGtjMyPV9HIn+mZpyYgB
	D5n6NnRkkd5Drt+1M1FLJfI5+Nk+kN9NNzA==
X-ME-Sender: <xms:zGrUZ6WZJKlOtllU2SbkArGAyK1F2dZBHzdDFe9hZ9lHnh4MBgXy9g>
    <xme:zGrUZ2nFseg9Jly7ApivAvWuEyfSWYnwVjUxAuKCATvBUl6_jELOEk2z8YI57rQLo
    c1VOY9O5rGUM7NnNQ>
X-ME-Received: <xmr:zGrUZ-a7Oc05DnQGyxX4DL0JxPptcuQRMRGN8befi-mKj6tMvFn9MVCNd4XuPoaT1ERL2KjOg4N332s1uxDb8Hhs4COrXZnuFvOh81RY7Q-D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedugeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepleelteegkeeftdevheetheevteekhfejieffheek
    hfdvledufeevveevgeetfeefnecuffhomhgrihhnpehmrghkrdguvghvnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhih
    hllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhh
    ihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:zGrUZxURUTE4Y9kL11m12kgF-XzgVTil1gvWTsYrHyFGTt-l_A4llQ>
    <xmx:zGrUZ0nofAY3LS1i8IeLP1VdIj-t8xHLtKbMoBVSADqaXtQf0TrK8A>
    <xmx:zGrUZ2cZE-6W4ywKBRPfYOh0en_DFlP5wVfEDcPRfg_lu2pW3-RFvA>
    <xmx:zGrUZ2HshbZrU7oQZAPSGaWXWEqncKkcdpMcqg0uSrmRjv3gAdSQxg>
    <xmx:zWrUZyayr2X_513NloH9huZBQoamekzf_S73dqo28VfuJn1LW_MeSQct>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 13:43:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2d4e6cbe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Mar 2025 17:43:37 +0000 (UTC)
Date: Fri, 14 Mar 2025 18:43:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	git@vger.kernel.org, jltobler@gmail.com, phillip.wood123@gmail.com
Subject: Re: [PATCH] config.mak.dev: enable -Wunreachable-code
Message-ID: <Z9Rqx6CuXB_6JQoL@pks.im>
References: <xmqq34foefh8.fsf@gitster.g>
 <20250307225444.GA42758@coredump.intra.peff.net>
 <20250308032309.GA584028@coredump.intra.peff.net>
 <xmqqfrjkao75.fsf@gitster.g>
 <20250310160440.GA26189@coredump.intra.peff.net>
 <xmqqsenk7mab.fsf@gitster.g>
 <20250314161010.GA8522@coredump.intra.peff.net>
 <20250314161347.GA9440@coredump.intra.peff.net>
 <xmqqv7sbh698.fsf@gitster.g>
 <xmqqr02zfr3r.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr02zfr3r.fsf@gitster.g>

On Fri, Mar 14, 2025 at 10:40:24AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Jeff King <peff@peff.net> writes:
> >
> >> -- >8 --
> >> Subject: [PATCH] run-command: use errno to check for sigfillset() error
> >>
> >> Since enabling -Wunreachable-code, builds with clang on macOS now fail,
> >> complaining that the die_errno() call in:
> >>
> >>   if (sigfillset(&all))
> >> 	die_errno("sigfillset");
> >>
> >> is unreachable. On that platform the manpage documents that sigfillset()
> >> always returns success, and presumably the implementation is a macro or
> >> inline function that does so in a way that is transparent to the
> >> compiler.
> >
> > Would it work to instead do this here
> > ...
> 
> I forgot to say a more important thing.  Between the "let's excempt
> developers on macOS" and the "let's see how far we can go with the
> warning turned on everywhere and wack-a-mole this particular one
> with errno check" patches, I prefer the latter at least for a short
> term.

Yeah, I'm also in favor of generally enabling the warning and seeing
whether it will end up being a pain or not. This particular edge case
here is ugly, but it's manageable and may protect us from mistakes in
other places going forward.

If we do so, could we please also include the following patch for Meson?

Thanks!

Patrick

diff --git a/meson.build b/meson.build
index efe2871c9d..a0a602864a 100644
--- a/meson.build
+++ b/meson.build
@@ -721,6 +721,7 @@ if get_option('warning_level') in ['2','3', 'everything'] and compiler.get_argum
     '-Woverflow',
     '-Wpointer-arith',
     '-Wstrict-prototypes',
+    '-Wunreachable-code',
     '-Wunused',
     '-Wvla',
     '-Wwrite-strings',
