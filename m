Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392DA18BBAE
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 01:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764034029; cv=none; b=c8v0x1tK4krPF84ZTdbWhf5bRH0VkvHe3pXqp1dctGmH1QUx4vTkyCg6NStBMx9guOgVfOPAe0FLntXiFJxSmFi3laXscWrDCKBy43jqQMenzOS6MPqbei9itzC0pk1uU1/2ZI70oI+GCTRFmi7saffejtNTjeNXMRW+v9Ac7vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764034029; c=relaxed/simple;
	bh=zg1+lZ0FIqTFzuwM7fVYj3RMk1U3BQBUVAKOuqLgFFI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bE4XNa+KnlnFOKQoSwu9gBfjJGu934l2ESpuynbQuHFLHjx4X1ANj6qdaMtXQFy1fKFsRbnfz/MZ++WDH/yuc7JfCIJXFWrrUvHJm8CDw+RUb68+5mDpigad5DqxmvnLqM9tIk7FYZwSC6jWf3D7OXNvxM3pxaMzPFjmlQE9nZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AqxAWuiT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qjow412n; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AqxAWuiT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qjow412n"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 24155EC0399;
	Mon, 24 Nov 2025 20:27:03 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 24 Nov 2025 20:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764034023; x=1764120423; bh=eXYHlc1Ahd
	z88KewoFAIvAHpGPy5CNr/Pig/19mJKrA=; b=AqxAWuiTod4d82oSurs8hUOBCl
	cDWAE241Ajeq+xpTLNz8StOdOQpjp99xGaVacKX1EU61RA2s5AWbWdeq3z29Kiaz
	ypaewFtVO9h+tjrufdRonnqE6SE93CP8WsYa3bS5JpvKP29dEzx997h99ml5FQqN
	bhFDgbC/qOtdshXrpsVmh71oE5IVE2Wa5AI0laLBE3AyNJ/VDRAuHADSDrcBkfkU
	RVhnYIXRiASoKQHHNw5QMalMlb3yhdI5qpSYebWtZ8yVK2jWS8L4v0Mm1nRG3ZqW
	N9lKr5JJh38b9xcafzR2U0QaCava59nsY+I1pHkOWa03hKk/H6b5aInIyU8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764034023; x=1764120423; bh=eXYHlc1Ahdz88KewoFAIvAHpGPy5CNr/Pig
	/19mJKrA=; b=Qjow412nXF3e9U1uEgV6DvRfKbLNFcDgkrXuJ1sRJboRCIm2Gz8
	q6CXWNO1EdzG/ueUt1oDc17lS6WKfWinugCnw4naK9yYbtdPtmULAS1J7TTG+cVZ
	xjdaYjT0DJBAenGdedXGbRaG3bIt95szauUhYY6BeH0jWbJ/iISWBHrC5zm403pE
	3k3xxEFZJrQ646gPryN3SL826sw0x+NFRIbN0ATI/KHl+ftfzPtLyvx39gT3+OiP
	XB2OK4kNGt6xokW8fdICZtwnaLYzejZL/y5R34xCVg1GlWsoSqVgk1h88ESkDiWS
	txB6zulSndDrlrLFXbu/yRliQKpznHXH/KQ==
X-ME-Sender: <xms:5gUlacGukoEPMVBEH9bZ6cmYpCaI6cutDV4MPlzV_LH3mkcdfpQDig>
    <xme:5gUlaZAP02Pa5F8yq0jCBU5pyHDrkMkb_x5RMp3IEGjjisciMiRReB6kh_7Qfr4wZ
    QR-TKlI4Y4jwJPH9k5tCWC555KJct0QagNq4ioNIPEQnPmGfvHRdOU>
X-ME-Received: <xmr:5gUlaf9aXKIx_reuXsggAZJcWU8DNmMq-LGVFjODW87gUEF7uHGPjypXKpitVSbqSGWQsWTbmXL8Bur5npGm4PJc7TCStClkLP0x>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedtudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepjeevffeludelfeelgfetjefghfeugfejtdeijeffudevteffffeuuefhgfeh
    veevnecuffhomhgrihhnpeigkhgtugdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheprhgrnhdrrghrihhguhhrodhgihhtsehsrghmshgrrhgrrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehrrggrrdhlkhhmlhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5gUlaVBIFQQrLwUDMD-2ZiMNp9SpG6i92Xe0aPE1UseemWidD1ozTg>
    <xmx:5gUlaUR5PUyDOMSwqhGDj2Jze0tq0hhz_KdIs7LB_Sh7zhynfS8Lmg>
    <xmx:5gUlacvY_wK1uG7RItnAq3gw94ooeAgFCVYMQaB4qHqPd7C7wV63Iw>
    <xmx:5gUlaQ0n4hZnunGyZ7nRle9kI6x1omvF0lwTgIbMIFWZMvIpgGVLkw>
    <xmx:5wUlaUtkKcoaKYJalqS3lYLPhdXuOETF8lHU8etcYQuULz2PQjdIK3GC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 20:27:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Ran Ari-Gur
 <ran.arigur+git@samsara.com>,  git@vger.kernel.org,  "raa.lkml@gmail.com"
 <raa.lkml@gmail.com>
Subject: Re: [BUG] `git clone '-c KEY=VALUE'` no longer works
In-Reply-To: <20251124235530.GC2051672@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 24 Nov 2025 18:55:30 -0500")
References: <CAN1UxBvk_GJjLWd0XexRxp8FFhYozGCNcodai0eqnjrhjKEh7Q@mail.gmail.com>
	<CALnO6CBJppT3ELyu54rJvP+uqcMomJS9Nr_JTgfssn8iqG7MWA@mail.gmail.com>
	<xmqq8qfvw2lh.fsf@gitster.g>
	<20251124235530.GC2051672@coredump.intra.peff.net>
Date: Mon, 24 Nov 2025 17:27:01 -0800
Message-ID: <xmqqo6oqucka.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I was surprised that a single "-c foo" argument would work, but it makes
> sense: it is the "stuck" form of the short option "-c". So:
>
>   git cmd -cfoo
>
> should be the equivalent of:
>
>   git cmd -c foo
>
> whenever "-c" takes an option. It is just surprising to read because of
> the leading space in the value.

Ahh, OK, so

	git cmd '-c foo.bar=baz'

was doing

	git cmd --config=' foo.bar=baz'

or an easier-to-read form to express in the "stuck" form of the
short option

	git cmd -c' foo.bar=baz'

which I totally missed.  I agree that the option parser is doing the
right thing for that case, including passing " foo=bar" with a
leading space as its value.

> So yes, we did allow that until recently, along with:
>
>   git clone -c ' foo.bar   = baz'
>
> which keeps the space in the value "baz", but otherwise sets foo.bar.
>
> I agree it was certainly surprising. Despite the real-world report that
> started this thread, it is oddball enough that I do not think we want to
> continue supporting it even for historical reasons. It is not quite at
> the level of https://xkcd.com/1172/, but especially the form that the OP
> showed looks like a mistaken invocation that happened to work (and would
> not work for any other option in general).

After you explained the "that's stuck form with leading whitespace
in the value" I missed, I wasn't so sure.  "The value is supposed to
be a configuration variable, followed by an equal sign, followed by
its value; what good does it do if we retained the leading
whitespace---stripping is a usability feature" would work as an
argument in this particular case, even though it may not work in
general.  Of course, the right thing to do when "git clone -c"
option was introduced would have been to notice that the stripping
of spaces is unwelcome complication of the UI and reject/correct it,
but it is way too late for that now.

The right right thing to do at this point may be to fix the
regression and at the same time mark the "feature" as deprecated,
and remove it following the usual deprecation procedure, but that
certainly sounds like an unnecessary waste of engineering effort.

So, I dunno.
