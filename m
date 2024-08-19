Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7C9947A
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724057806; cv=none; b=bVnlWUU6+ye+A1GnsAQWWQ/T6em/6M11G4wfolrItj5P1AclP+6jnjV2PPqgKJD6JPdF14EFbRfQDUFR0zpKYD2sv8Pp4KznghJMq0YWEHLrpNQyBbR9vzJheMQdiirtJ6NT43vgRZggybXfyUDpsDU7tajd9UcMf4Cv/Ug/jjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724057806; c=relaxed/simple;
	bh=wSG3dHnWnu6j/Rh694vqRgqXqf9g3/0I8AIjraMFwVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIgxZt3KFETLphKB8TvM1PeKrf8s6dQYh3II2i2H8vfyCbPbAhOWI3EyqYIypE1nKQJgdzpL2fJlTLTS2xkW4VhsX6vk9j+g8yN3uQ4xrB8m/TwoD5OXlZ1mw3wvCJclrFG2ztq47zzW7Z2vcLsrD1pcL01QFKI9J52TZmy+UIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bG2RDMSn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sq6H0zg7; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bG2RDMSn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sq6H0zg7"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 82056138FF98;
	Mon, 19 Aug 2024 04:56:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 19 Aug 2024 04:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724057803; x=1724144203; bh=JpDK/52/J4
	PeLzynbUutdU0sLMp04bOu6YQR7U1xCkg=; b=bG2RDMSnTf+XNmksy7PWQObySz
	XC1O9K3S4pf/DFEuIq6BdjVAKtjcgTvVyp9atDUWIF5JS6t/U/xrsLyLEFVKMLPz
	wh8jndGjE/e5u8lEt3sEpCEunesxhHARsujj/H5rT/qvuio6LuNJHbjXXpYqb460
	SBxbjmc9/r4BzSO0KnkNzFUhzdsbdOpCYL2R9QNupJ1rTB8vO8mPLaIgg7BmStx1
	c4iZBkAlKwCgaD5ZsTUwjUPalPvRm48ZuHASjbR+aCafizv0oYDG2nUpPmqVKaJb
	JFAsMuUrA716acwtubV5+ltg4oHALPDh2opgYELjqRXqsYvvO0nxNUuC2o0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724057803; x=1724144203; bh=JpDK/52/J4PeLzynbUutdU0sLMp0
	4bOu6YQR7U1xCkg=; b=Sq6H0zg74eTaIme3R3hR3Pufqv6+Qx6X82CIUGhnjqT+
	T48ZFzLKbUzLko0qsSDqaRQKc3enApNdPCfdX1oL8ncjDsEFm5N0nVEHYw/KoV7w
	sLPp4cG8VbCZyJn0MyRoyC6QR3DyI7cHd7VHnYFHlgX3daFSvHx4b2suiteOzo9k
	8be1NwDrOGn6WbOkeStxNHB9YTccP8k14AikbeBDRnAqI4WMrGVDnXrhp42pd8fq
	zYiHcNobESwtbbzx4GcPkPTBonGcm2f3WXIa+lHkpjjs1l9NkvbWReXl5sCAZCzC
	MZaI7pQiWODGIChvZbm8LCsM8VxZtoZTwH3uMqLwZw==
X-ME-Sender: <xms:ywjDZoODonNbJ7rj7gDlrizq1qZRhg84RoRqjnaUV9AKTr_HA1vOsw>
    <xme:ywjDZu_ME10AHWJn38ZWat5y0UT0oNm3Cq3Z_txEvVzecm-fqstkDPMwqN5Gs-X6e
    yf49n9qmgPlp2PVMg>
X-ME-Received: <xmr:ywjDZvRTQZEU5ku-vxIKNveN-af-W6bIUwMX34Zn4PWtenVQtGsums-iyarGXnETePUIFBjWfgTEOmjNinBSCTOVwGsrQGAr9iybmovpDDo7h1s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdr
    tghomhdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ywjDZgtjEcx9kc3CHAKfsA_X0Saj-FTjj6Dz4bq-yYyPz7oNbSl3uQ>
    <xmx:ywjDZgfSypaB5DEOerizNdz5HCB0uzUd0H-_QauIaA2YfM5_tiQ9UQ>
    <xmx:ywjDZk1TaJ6bV0V-LTBSzdcRsDZvPQ6Zbl4rYlg_WDxtBVwu4l64IA>
    <xmx:ywjDZk833DD7SjIR8Ub49lxgEzZloOg9e4PVgAqBtdM1TEDf3cB9nQ>
    <xmx:ywjDZutwVjiPR14TakxjCuaxKUDnNRYLtOJ7HeChc6xnWf5ml4icWvhm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 04:56:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 34f060a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Aug 2024 08:56:11 +0000 (UTC)
Date: Mon, 19 Aug 2024 10:56:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, James Liu <james@jamesliu.io>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] t7900: exercise detaching via trace2 regions
Message-ID: <ZsMIxmX2Ash9YtEU@tanuki>
References: <ZsLjcjhgI8Wk2tIV@tanuki>
 <cover.1724053639.git.ps@pks.im>
 <9712aae82bcb51dd94fdc10f4156e9c78e4b6d8c.1724053639.git.ps@pks.im>
 <20240819085105.GC2955268@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819085105.GC2955268@coredump.intra.peff.net>

On Mon, Aug 19, 2024 at 04:51:05AM -0400, Jeff King wrote:
> On Mon, Aug 19, 2024 at 09:48:02AM +0200, Patrick Steinhardt wrote:
> 
> > In t7900, we exercise the `--detach` logic by checking whether the
> > command ended up writing anything to its output or not. This supposedly
> > works because we close stdin, stdout and stderr when daemonizing. But
> > one, it breaks on platforms where daemonize is a no-op, like Windows.
> > And second, that git-maintenance(1) outputs anything at all in these
> > tests is a bug in the first place that we'll fix in a subsequent commit.
> > 
> > Introduce a new trace2 region around the detach which allows us to more
> > explicitly check whether the detaching logic was executed. This is a
> > much more direct way to exercise the logic, provides a potentially
> > useful signal to tracing logs and also works alright on platforms which
> > do not have the ability to daemonize.
> 
> Nice, this is so much cleaner than the way the existing test worked. The
> code looks good, but...
> 
> > diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> > index 074eadcd1c..46a61d66fb 100755
> > --- a/t/t7900-maintenance.sh
> > +++ b/t/t7900-maintenance.sh
> > @@ -950,8 +950,9 @@ test_expect_success '--no-detach causes maintenance to not run in background' '
> >  		# We have no better way to check whether or not the task ran in
> >  		# the background than to verify whether it output anything. The
> >  		# next testcase checks the reverse, making this somewhat safer.
> > -		git maintenance run --no-detach >out 2>&1 &&
> > -		test_line_count = 1 out
> > +		GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
> > +			git maintenance run --no-detach >out 2>&1 &&
> > +		! test_region maintenance detach trace.txt
> >  	)
> >  '
> 
> ...I think this "we have no better way..." comment is now out of date
> (and can probably just be dropped).

Oops, yes, that one is definitely stale. I'll drop it in the next
version of this patch series.

Patrick
