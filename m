Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892092951B3
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313734; cv=none; b=RqNctnlRqMTMsoKbvjA+/dCZ8St+26/Dk8l3FYbxSNQZ613JLCJ8G33nRBA0YIgxLD+3c06l3ea2TnSR8X6h2rA4DxWGe2gHCP6RxXW1ZxdVvOFFijUUV05zUBvA0A/6zZjKiXlNyNet4hnKkWsNAgxEZM7QJXHsCRoFT83Dghg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313734; c=relaxed/simple;
	bh=1OMj7mt1X35BDUD/OH5pj5lTPJd/vXcnlgGopslaLY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osWaRvOnR8bDhJH8PxD8mOUz8/PMgzb9LAeytwNFYiaayMCfQORXMtixeCqaR7CIXv11zOKjqiqv68TadtUArOJmLzu9HLzEcqAAmFy3R+UYy/bKJYQmMbgc2vv1qKJtvWge83BdGc6guNIugui260RVAnEHNk1rIUb6f3uCoR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fCSeUI93; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aaJvQ7KY; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fCSeUI93";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aaJvQ7KY"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 310591D00105;
	Mon,  8 Sep 2025 02:42:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 08 Sep 2025 02:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757313731; x=1757400131; bh=wOacWyuky9
	L6QsB3OARlstYJgfDBXZuG1bMRat0v/2M=; b=fCSeUI93Z/bTBxV+vUmKIfZsBp
	FVxUPj8Isgx4Go98TP0m4+qDw1pTX4I1ekjxe+jYCYFlJQl1BIcTvQIAPAKaKGVG
	jyCW9480GY2h/oHtkf7DxFo6ly1GQIN5cHqmkAmueH+M1zeHWGs68BWLMxqan0sX
	kWzBwCZxq3Jh2Mf1bICILhseGNTaUaEoxLgCUMzJf6xpvhSHpwt0DCHUrcz1rbOl
	AaL7xvSAOe4Zyve3GqjR9RIIVzpmWcIAHjn+H6NHGuyWij7SmaHRgDKkWyjudHAX
	zk+MWIvffl027kb406Xr/WrvLJowFJM70A7GNOe9pMTykYYk54yOAkbafekA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757313731; x=1757400131; bh=wOacWyuky9L6QsB3OARlstYJgfDBXZuG1bM
	Rat0v/2M=; b=aaJvQ7KYtPTYppsTgcAn9pgW6m2mJH7DGu2mR3wpI3Xvo0yQXLI
	DUDMNpVQX82ZC4sl9+9mWY9/c9euL7aoA+X21RrlLuMF6c9vOnnKSYMCZtCv9ed6
	6ap94Ebrhxx5+ZAy0UquN/0E+pM1KvD8Z4/cJQPPaM5VhQGgT84xQYveWxZUndEy
	72hoqUZxb58Nj1//4O7vRTLCFng/H4oN4bb6PlXO32EwyAChBe/AMSCWJvK5Q9k2
	NlQt/B3Ws1+11g0GJZpi+KXlejbQ2iYUDZrc7NMe1UPnElt6RU5NQciyXN+Z8RmU
	7Soglr2nODkNNtHWI0cl1mSZr2/S9fjwnSg==
X-ME-Sender: <xms:wnq-aFNNhxbTd3lh4_rpFI61walJE7-XDQBMA80INrq9UwWbHVL66g>
    <xme:wnq-aInue8pK0RmEtlU81ezdb7eAJVTWflgzoRQvkro0H6UF33t9rRwoBosU7fobN
    2KmJpn3mf_LWt7XBw>
X-ME-Received: <xmr:wnq-aPZ18ZkUGDgtnnw-ETfGuiV4A7xZxmfWzm9IRDB7OoiXLSi9xA0A3Hm4LrQ0AwBZpDYw3utX9LcAIzPINIExwko7928kLf5xRMjByOnCpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhivghrrh
    gvqdgvmhhmrghnuhgvlhdrphgrthhrhiesvghmsggvtghoshhmrdgtohhmpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggssedvheeisghi
    thdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    eptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepvghstg
    hhfigrrhhtiiesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:wnq-aGRIPanOxhLYviEUTLtT3fNZLN8sZEOeVoYsaKu_YKTmlEDaGw>
    <xmx:wnq-aBUKBUYxq3-v5bAFTIIgJQ7XxAUx7aWmJY-TU7hfCg08CbVtKA>
    <xmx:wnq-aNaw4exQCeIA1GzJANWmN6pphkIObnm3u12erFNTdNbgTPking>
    <xmx:wnq-aC7NxhmGgrgE22HZl2bRw3uN2AxoRzq75kRuOb0-EY93qiBquw>
    <xmx:w3q-aL8toSRofDbtZAMC5dFUeYXujwhhOoq0-QSrcZVXpi6jWVkX0PJA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 02:42:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 03486882 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 06:42:07 +0000 (UTC)
Date: Mon, 8 Sep 2025 08:42:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v2 1/7] meson: add infrastructure to build internal
 Rust library
Message-ID: <aL56vFa2SXlCDFWC@pks.im>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-1-6939cbf4a0b8@pks.im>
 <l3apalzo6m5kydmfn6c376rswnfw5h34xpxauqarvxmlaksf6i@dhhdbat6gso3>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <l3apalzo6m5kydmfn6c376rswnfw5h34xpxauqarvxmlaksf6i@dhhdbat6gso3>

On Fri, Sep 05, 2025 at 12:47:20PM -0500, Justin Tobler wrote:
> On 25/09/05 01:50PM, Patrick Steinhardt wrote:
> > +# The 'rust' module was only introduced in Meson 1.0. Furthermore, the module
> > +# does not seem to work on macOS as expected right now. As such, we only
> > +# conditionally enable tests.
> > +if meson.version().version_compare('>=1.0.0') and host_machine.system() != 'darwin'
> > +  rustmod = import('rust')
> > +  rustmod.test('rust', libgit_rs)
> > +endif
> 
> Out of curiousity, what is the problem that we are seeing with macOS? I
> removed the darwin guard statement and didn't notice any problems when
> running `meson test rust`. Is this a well known problem with the Rust
> module?

It's this:

    Rust linker for the host machine: rustc -C linker=clang ld64 1053.12
    WARNING: Unknown keyword argument(s) in target rustxx: prelink, pic, rust_abi.
    src/meson.build:12:10: ERROR: Fatal warnings enabled, aborting

I haven't yet found a time to look into it more in depth, and assume
that it's fixed in more recent versions of Meson.

Patrick
