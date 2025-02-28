Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5321B4250
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740739854; cv=none; b=st0tv7U/5muYHK1t0EZg7xvHyXGYH5S09xL3+OZfJ8hPLxbEZeR5HJcD+SPE5ub3atH7KPFxqav0ZXET4Fnj2qm8PTiePVlkiM0xIOg7TyL0jXRl52x9IBxeXGmmX1GHgICXHOMmD9l3tmo5trR9nlzYfYf5g19vANUN7DS0C/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740739854; c=relaxed/simple;
	bh=/BEkFb6zu/gTWoJtpgCPYlGZ9VPee90cqMp03uqMLbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9esKIQudBXdL2pqOiNjNgzS8hOkUnavyYHUIKQrIBEVZDulFKsJIvHoZUEEmnaVvny9+Ao6rB1oPZptRk7scYyDl5CEt9lUnat5ukmyMRFwd6hdxPirmBFnYuyd3hJkaPZr4N2N5/mclxORxv77DT7eQvbkVuQIcepD7jZvTbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=btZa4MZb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yrEo22pA; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="btZa4MZb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yrEo22pA"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 813BC1382795;
	Fri, 28 Feb 2025 05:50:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 28 Feb 2025 05:50:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740739851; x=1740826251; bh=/xo91hBNVd
	ARc+Kw9NEb9TZu5WGCPiNuKWkHHDMl5hs=; b=btZa4MZbhwxsRMOFvv47K/joEj
	QoS3SLdiFjD6uvzg9yDA7AcBsiO5cm95oTJ9scjn2uU3o9yE4IYPiTIg6jbxus+M
	UXczjlx4jijO1EyXb9HkwiQvp2AAFjjO9tsXA3HsGeuQQh5C2LytxmXv9pyvPe2c
	xVf4kKDKQeNm+4sNXpSbpQSwDofz9hVng1rRV/Sf2luRD1pFjifPNTlH8mGKztq4
	Rrdfr1mGsOMnecLZKBd68UMyUynG8TTr+xykPzGke2xrimRU4kdtj8TYJHO5LizQ
	wfSJTegEPRDHJUMb/9Eeitsi/u1TvNDFyR4DQLATLIXwlKWflJZoBM9j/DOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740739851; x=1740826251; bh=/xo91hBNVdARc+Kw9NEb9TZu5WGCPiNuKWk
	HHDMl5hs=; b=yrEo22pAoPk88/gp+dKUIi7xViZjVV+Aag86c5yYx28H6LUpCti
	SsNlfUlzEGOEzD85paiovK4BcIGRX3G2HiUiqv6L2pcKZ3x21CNhx7R59pgeGsM5
	pQupoFUjgxF+H59WdJGqF5f4utcmhdx19oU932vhv+czQ4nzomkmNc/3RemObY8U
	H/qiAcOl6kGNFpAdQZXamBj6itt/YN5J80RimVB11wveJ136yBcSaIcjjtWMLpWn
	EbWxNRMWdx6gedBt0yZWmX2aZZOr3C93e+U878G53SjJ2Ib506M7ImBBc0smOjH2
	hxpYxZ1uozbdszhlRuKdmtTH7fxTjKWNwFQ==
X-ME-Sender: <xms:CpXBZ4kWllwa54mpHI-VlQLC_D3TPh3huOJyw01fevZn7yC6t7S3Ww>
    <xme:CpXBZ33KaCAlzhd_LGOilkheo7e8nQWhPiWupRu7Z9CRI2M27AvuFC5ikvx9OjaJf
    8o228t9b-_w973Dxw>
X-ME-Received: <xmr:CpXBZ2rdJvt3YQXUTfgXKukwiKTi0PRZxsn7qMpodHQSjxLJ5eljSzJ0oMa6SIzXk252r_48JaCGNOkqn-0ttiTFwoDJ7YqAgmBpWRFnRH2beZSu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    ghhruhgsihigrdgvuhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:CpXBZ0nuFCnzGE1_Uc9p0ffyDXHcO93cZJjoN1RCekLzbr9tO0cVLg>
    <xmx:C5XBZ23PjoEW9H9a1Rpom4dNwYroyxSvjCFeF2KM9DezPEkR5C_dxg>
    <xmx:C5XBZ7vbjLe0XW-cbTRoTsAHY6zOutkRIw6wXwrpFCXAQXqhBogZ_g>
    <xmx:C5XBZyUiZeFQi5d1Wot4zOxS3WRIOkn9A1X23ONjSGf5H1B0P4RZFQ>
    <xmx:C5XBZ0B9ydCCIdZaQxkeKthk9cWQODO88-eO6t8vGZ4k2COPkQY7__u1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 05:50:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c5837f58 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 10:50:47 +0000 (UTC)
Date: Fri, 28 Feb 2025 11:50:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Michael J Gruber <git@grubix.eu>
Cc: git@vger.kernel.org
Subject: Re: [BUG/WIP PATCH] unit-tests: use clean test environment
Message-ID: <Z8GVAjwZWOM7c2fR@pks.im>
References: <e3be6705d103ccbc165d0fd3b9b7c818d14001e9.1740516033.git.git@grubix.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3be6705d103ccbc165d0fd3b9b7c818d14001e9.1740516033.git.git@grubix.eu>

On Tue, Feb 25, 2025 at 09:48:47PM +0100, Michael J Gruber wrote:
> So far, unit-tests are run in the user's environment, in particular with
> the user's git config which can influence test runs.
> 
> Set up the same clean test environment which we use for the other tests.
> ---
> Hi there,
> 
> I finally got around to checking whether the last test in t-trailer fails
> for me: one of the trailers is present in my git config, messing up the
> test assumption. The reasons is a systematic problem in the way we run
> unit-tests.
> 
> The attached patch is more POC than WIP - it makes t-trailer work again
> for me, at least.
> 
> unittest-lib.sh is a trimmed down version of test-lib.sh, and I'm sure
> it can be trimmed down even more, maybe to the extent of being included
> in run-test.sh.
> 
> Also, I'm not sute the Makefile change catches all invocations of
> unit-tests. (It certainly does not cover direct invocations, of course.)

This to me is the biggest issue with the chosen approach. It would be
great if we could find a way to sanitize the environment in the unit
test executable directly instead of forcing users to run the unit tests
via the provided script.

I suspect that most environment variables shouldn't matter (for now), so
overall the duplication may be acceptable:

  - We need to unset a couple of variables, but we can probably reuse
    logic `git rev-parse --local-env-vars`.

  - We need to ask Git to not read the configuration, which we can do by
    setting a couple of envvars. This should be manageable.

But other than that I don't think we rely on any other infrastructure
exposed via environment variables, to the best of my knowledge. So it
shouldn't be that much logic, which may make it an option to implement
this in "t/unit-tests/unit-test.c" directly.

We still have a couple of other unit tests that have a different entry
point than the clar-based tests. But Seyi has been converting most of
them already, and I wouldn't worry about the remaining ones. So only
doing it for the clar-based tests should be good enough for our case as
we can assume that the other tests will go away sooner rather than
later.

Thanks!

Patrick
