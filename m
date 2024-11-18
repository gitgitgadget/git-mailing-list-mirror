Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7264819E838
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731935123; cv=none; b=sqGU5xOJ5J0+J1Y+R3zaSfXm5obdMhteXAY6HDqlpNcvOjd+IsNvrEuhN2u7LWEQO003mkshzBZQKaHEhiWqCD9qdVjEjzdrBENw6bEpwflueTGKTuTn8mQsvvsPrSbbZo4TvX+XzdJAvQ50jkSMWpXDFmX/hAElGEbKxnuvVKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731935123; c=relaxed/simple;
	bh=6J904jKZvBg6UhNwsMxSMlkH4GqWJfHiOxmWctWiuZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GN/UmsD432nIHmcN9cPsc2bhMz4CGhVZisc1GeoYyLNeT2nL0V5NdBjClzFxPgK2P6dOIONQ/VjFijc0rK3gkm1/Cyyop+RKL9mXigvg2xK6V3Uv6b9+C1mhHotEuslz0LAnhM8Yz8b+9EVuEFjIDilJCvFfkjvNOquo+0kHJOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=1rDASOfw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U/ThD5K6; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="1rDASOfw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U/ThD5K6"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5938B1140240;
	Mon, 18 Nov 2024 08:05:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 18 Nov 2024 08:05:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731935120; x=1732021520; bh=MxfDQP10et
	5G1YtmNQ6sLZA2z7U/CK/gpKx5o4c5jLo=; b=1rDASOfwIIPegYPIetlN5jbTDK
	p1gmXvWmioN09ZN5U1Uz2Gy8yJb/UlH81eETvLBlPdgp46KBajwxC+zqfnQYSEzv
	9qqkNjZZsCUDhnfp6SgtSQGfP/psg8WOGCeT3Q740kbHRREMHoR2cKwA1fXbn/os
	A0WuR48FMRlUlSvW2cROZH1H1oRrloKn/b8eCSls017u1nQkZz/Jo/Y30IioMpYp
	O57rk9+O/3bm/SEWXNXyS2CHLDdNp3JJPTBXjkwRjJLgoubUNgZmUattBxlc//Rh
	5LZyPQcc9mU6mTX5zRBzCr7ve96L7LbgAEN+rL5XjSU49y1bPEtrNWM0c4hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731935120; x=1732021520; bh=MxfDQP10et5G1YtmNQ6sLZA2z7U/CK/gpKx
	5o4c5jLo=; b=U/ThD5K6GmmuLG+rZeb4hYKqpDaB8ecoK/eslws0Nex/yJKdFdR
	1136RQqlZuDRTJe4yFeZfYC/6deufr0bWxtc/6vm/NGfmo1BuRFySTLcx96uGjOT
	/qG62+3YgvsluFzH2+SuSPHLaP3gUHcOoNvkxfeWKmD9SWQPa6iVe3lZ2ZD6IDFT
	5N482cztVHVwG7PoB3ugvVy4ic7lvuGF9530Vw9LwlH3u2n46f8CMF7r2q/rT2A3
	OrzD6bR9h+LeOANPNauBlDFP2SL0EPB/PLw7s1peoJos2yrn0JllPDTaVCKArsy/
	B4TPmpr36RmC/8mpx3vx4vEoanGK6JrqAiA==
X-ME-Sender: <xms:jzs7ZwrIoNO2iQWNCGgvVCDaRtbzAfD52wED32_UhmlBQzn5Zk3-0g>
    <xme:jzs7Z2pEXOxPNGSTZOWTa07F7PkCprpIgUJOyTK8nqEce-m9aR5DkYJbQWroCP6OE
    a0Qb9endaPQzvDu0Q>
X-ME-Received: <xmr:jzs7Z1O12H2n39xLpsc1GSJwhwhCwBBF5tC6Ww_P197wwg5Z5ybSbPO1Ktbf6iLvkk_cyURt12LvhrtBuiFGS7PhQ0hdeBwxpTcnW3fi2TpdKH98>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheptghhrhhishgtohholhes
    thhugihfrghmihhlhidrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgt
    phhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtg
    hpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepuggr
    vhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguud
    dvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:jzs7Z34yla_ewEgQWfe4uKLzsR-i3sHgy8ieog1QHzexCUSrJBTLEQ>
    <xmx:jzs7Z_53T9psvGG1l2WgafNnkrpXCqlYjdWIRrm2JkJ0TMod_vj78g>
    <xmx:jzs7Z3jnsrx9D5cDmkkkweCx4HFC6UeSUVxfaIaG8xhSSYZrcI013g>
    <xmx:jzs7Z57vX_n3UIPhNZeAihgmQ6otTNIM-Q4Aub35QcJUxdvlKb2tdA>
    <xmx:kDs7Z8wFnDzgM_fYsu_smPGtYGUAPdEO5ghnn3cf3_Tf0GEjV66TYVUR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 08:05:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7649b05d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 13:04:27 +0000 (UTC)
Date: Mon, 18 Nov 2024 14:05:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
	Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [-SPAM-] [PATCH RFC v7 00/22] Modernize the build system
Message-ID: <Zzs7gerRLH0WlM-j@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
 <b9e0f631-b2a3-4c48-8745-a4b1e3f58ad0@ramsayjones.plus.com>
 <ZzsJRFQ2KaJCiOyG@pks.im>
 <xmqqfrnok8s9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrnok8s9.fsf@gitster.g>

On Mon, Nov 18, 2024 at 09:48:06PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Now there will be exceptions where it does make sense to make something
> > a build option, due to whatever reason. But I'm in the camp of adding
> > them as-needed and not proactively so that we don't end up with hundreds
> > of options.
> 
> Surely, your system may have openssl installed, but for
> non-technical reasons you may not want your Git to link with it,
> which is impossible to auto-detect, of course.
> 
> To be quite honest, while I am very much sympathetic to the above,
> in practice, I am afraid that these knobs we _already_ have in our
> Makefile are exceptions that was added due to whatever reason "as
> needed".  Dropping any of them would mean that you are declaring
> this: by default, all the past exceptions we made are nullified and
> you have to resubmit for requalification if you want to keep your
> favourite one.
> 
> That's not a very nice way to run the project, though.

There is a difference though: you are talking about actual features
wired into Git, whereas I'm talking about other things like "Does the
system have `uintmax_t`?".

The former is a strong must to be toggled by the user, and it is already
wired up like this: you can choose to compile without OpenSSL and any
other optional library with Meson. All toggles we have in this context
in our Makefile must be supported by Meson. While auto-detection is nice
to have, it is mandatory that the detection can be disabled.

But for the second group I'm sceptical whether these really should be
configurable by the developer. Why would you care whether you use
`uintmax_t` provided by the system or by Git as a compat macro? I don't
see a strong reason to let the developer override this in a build system
that knows to auto-detect the availability of such features.

Now as said, there may be cases where it indeed is useful, but in
general I don't think it is.

Patrick
