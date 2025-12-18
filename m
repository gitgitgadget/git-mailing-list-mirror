Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9412428371
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766045259; cv=none; b=luqetd+mUbwBTKzqLAmgTPbGa9OZrZ6U3mPOBmEPzlvEvT4BgvyxgXT2/TUUAbPo05baBg9lFbCHCXW0xxmhe0jcPnkqxORSAHCWifbTjy/t7ygmTh7cJxQoRlGD04RnTRpIda8QA3i4+jlVN/buiKT2XVwcLEsClLVhN6+1qSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766045259; c=relaxed/simple;
	bh=Nl2qXgHjP72HJv2B27CZJ9/aq5ksm7xaGZjFr7XgX4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6a8oOoxfzaKb0ZojenSnHSvmiNHbGslzxcgT1BpqBTlukA61opiVD888FnGa4FxjGByWlzK0y6WibosXcbLiIG6BgIdiAtdvdF9xLzaY1APzkegbIYxi64SW3YTqnm/xOXu0O2ABH/l9btj5Inzzp+zHhnPb5fvvF1U7lNBtPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MU3i6g4z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T4kCFnqq; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MU3i6g4z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T4kCFnqq"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id B2A031D000BD;
	Thu, 18 Dec 2025 03:07:36 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 18 Dec 2025 03:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1766045256; x=1766131656; bh=gYLOL6b6FZ
	C360WMWVe5Wy+TT+Xza2xQ9cGKhs2L0Fo=; b=MU3i6g4z3qorfYKHSXyzkkc/jM
	RAUAlKJ2f4jiY8VbGBnutforx5vyhFV/P34Bms1eZxg0I+ngvgoXjIrvJ+PzFEb4
	rdL3BvEbf2b0JNgSD3rFZNuIY62wGywB/peMDf2/RVwid1RUf1fXTnY1iKJ0vecI
	8BNAz8b5KUrTbbklILwlDKRBVIq+fT3Arqg3FxbbOVlerORrvnSvr8amQHeZkPRI
	264RkZUA9O9rVjCHRdic/RUdKrhpbhG5q08kbs61sKQ+xQgwAkH7x67VBZFfExSK
	8R+2lFhBps0eTVphYlETILxeMm8utM4ouBaR04ruv0a68JX9W2rvSHMVc5Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766045256; x=1766131656; bh=gYLOL6b6FZC360WMWVe5Wy+TT+Xza2xQ9cG
	Khs2L0Fo=; b=T4kCFnqqiFQf9RYc4Q7F/FrMPnzD4wRoxouq3FHsgPXRDw7smPh
	HGDo3LdDVv2fUG3YOc4fsFqYUdCj0xPeAsx/TLqa7SqO7BtNLmZt65hxpyefQ6Ry
	6jDPCCLFHQuuwfvsHCBS3X44SXCqfU3Qi/rzNh6+d1luSQpKe7jaBlaMIbCE2aAX
	3a0gpAxSy8gH3hC1tW051iWkq5QKeuakR8PbSoc01Mzmlb0gy5c+mzL3Cied0kDB
	oeFkxm2diYCM36hmw8ngZwT4uh6sMwOJzU+mCxlCvDp2P54+TAMlEorDX66I2rN1
	erobXHS2fyHzgHO7s7Om5gAyhCX6fsijI9g==
X-ME-Sender: <xms:SLZDaX411VqgrLoqES2nlWTlFJjb-H3TIpI_FuP0vIGh1Rz4XL8Z_Q>
    <xme:SLZDab_1Z13sC6alzmdLaih4ts70rrhinioa3Jx8Yd-qqquBvsEx6h3s5UikshsIL
    HnZ9XW6puO1-YNobAmLMayqkUSwyiz-snnQl3csA020Ef9YH49C>
X-ME-Received: <xmr:SLZDaUr6re36hB0RUZaByfQFPlxcwsDMlAK7jDB8s5ZesaSZrRXId9pb2jcWh6wb9yXy05F4fMXqxsgDvKC96T7TBl1rZQOS667dHWbIZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    elkeevvdelteekkedtgeejjeegheeuffefhedvueeitefhieeiffdtfffggefhueenucff
    ohhmrghinheplhhotghkrdhpihgunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepphgruhhlohdrtggrshgrrhgvthhtohessh
    hhohhpihhfhidrtghomhdprhgtphhtthhopehptggrshgrrhgvthhtohesghhmrghilhdr
    tghomhdprhgtphhtthhopehtsghovghgihesfigvsgdruggvpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:SLZDaUorE9_J4OgS15Kqo3NB4qlyKcmnJiY8ex_07NeWqeTJKVupyA>
    <xmx:SLZDaf14hHCJbmVJepdvrwjYLCYlBc8nGGKO2NgQR1nU9ltm5WR2hA>
    <xmx:SLZDaaHPDr2YoJrprl7OAbcGbgAtK8NXjhf9-K3CGFOKYgm_MmfmUQ>
    <xmx:SLZDaSFeCFfleIYKuHN3256XQ9ye6lqp5scmh1mWIeK7fX0h1R9AFQ>
    <xmx:SLZDaZqx8R3klFp_A1wup8593d2l3NcAdAIBkmkde30Suf6kzqUFy5WF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 03:07:35 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 96434458 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 08:07:33 +0000 (UTC)
Date: Thu, 18 Dec 2025 09:07:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Paulo Casaretto via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	"Paulo Casaretto (Shopify)" <paulo.casaretto@shopify.com>,
	Paulo Casaretto <pcasaretto@gmail.com>
Subject: Re: [PATCH v2] lockfile: add PID file for debugging stale locks
Message-ID: <aUO2Pb5JQ678ELCf@pks.im>
References: <pull.2011.git.1764688047077.gitgitgadget@gmail.com>
 <pull.2011.v2.git.1765997966593.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2011.v2.git.1765997966593.gitgitgadget@gmail.com>

On Wed, Dec 17, 2025 at 06:59:26PM +0000, Paulo Casaretto via GitGitGadget wrote:
> diff --git a/lockfile.c b/lockfile.c
> index 1d5ed01682..4ee215374a 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -71,19 +74,117 @@ static void resolve_symlink(struct strbuf *path)
>  	strbuf_reset(&link);
>  }
>  
> +/*
> + * Lock PID file functions - write PID to a foo-pid.lock file alongside
> + * the lock file for debugging stale locks. The PID file is registered
> + * as a tempfile so it gets cleaned up by signal/atexit handlers.
> + *
> + * Naming: For "foo.lock", the PID file is "foo-pid.lock" (not "foo.lock.pid").
> + * This avoids collision with the refs namespace.
> + */

This neatly solves the issue that alternative implementations of Git
wouldn't know to handle this new PID file. They already ignore every
file that ends with ".lock", so of course they would also ignore these
new PID files.

But unfortunately this doesn't solve the other issue, which is that we
now have a new restriction: you now cannot have two references "foo" and
"foo-pid" and modify them in the same transaction. Granted, this is a
very specific situation, and I doubt that 99.9% of all users would ever
hit this restriction. But regardless of that I'm worried about the 0.1%
that _do_ hit this restriction now. So I'm afraid that this proposed
naming schema isn't going to work, which raises the question whether
there are any other alternative naming schemas that could.

We could (I'm not saying we should!) do some gross stuff here. For
example, refnames are not allowed to contain some specific characters in
their names: ":?[\\^~ \t*" are all characters that are forbidden to
exist in a refname. So in theory, we could call the lockfile for example
"foo:pid.lock":

  - We know that no reference "foo:pid" should exist because it contains
    a forbidden character.

  - We know that all alternative implementations should ignore it due to
    the ".lock" suffix.

Note the "should" in both cases. I'd consider any implementation that
doesn't honor these "shoulds" to be buggy, but that doesn't mean that
there are no buggy implementations.

In any case though, this may be a possible way forward if we really want
to also cover loose references. Whether we should is a different
question though, and I'm not too sure about it myself:

  - It will regress performance of the "files" reference backend as
    every ref update now needs to write two files instead of one.
    Writing many references is already the worst-case scenario for this
    backend because each reference requires a separate file, and we make
    it even worse by making it two files.

  - We now have not only one file that would block future updates, but
    two. This increases the likelihood that a crash or forced shutdown
    will leave behind stale garbage.

That being said, I also see the potential upside, which is that it now
becomes a bit easier to recover from crashes/forced shutdowns. But in
any case I think that this needs to be opt-in, not opt-out.

Patrick
