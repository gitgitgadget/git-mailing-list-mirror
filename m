Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0FB2F0C64
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 07:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757058861; cv=none; b=q++KVFeGHzkc0KcH5nZEyKLUdhjOSLXlpxYHmgoE+Y2Lixj/J6T997205SLkcnA7pMLG8QWcfwPzDsDudQQP63IaW2Hx++ZGBuOfwJ5eFFi5JBTUG+1A3OehY5FImUN/rHBnrbjCR97cmf0fQ3giagNgALgk0klBUpn4ha3C/wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757058861; c=relaxed/simple;
	bh=xmZhl9G3XgUi252YfGXq3hAIrGMT41748mKigRnYBdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9XO4dutWRD3ocKlD9Bt6fXBKcwBDawePdjAfwSKllMAVMvFQOJ/WQbkrVT1vlHFYnQ/bB8l+JNvlMA399ZninKKULpdPDx/jlCRbIsmXDCyAGLyUMzy284iNDysyUM50T4MJ4bpiGufa6yaVANV45z23GRFaUVEQdC5z2kIG4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=czJHassq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dHN6c60I; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="czJHassq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dHN6c60I"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 9B7BA1D00253;
	Fri,  5 Sep 2025 03:54:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 05 Sep 2025 03:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757058857;
	 x=1757145257; bh=lsScigd+k1msycDeqEQuQcWBRbz1RqdZ41LFH70ZDmQ=; b=
	czJHassqW23EgaLhH1Fr27bQvSnoc+1tH0q5I8x+Vl1VaMu6gxUQhYvyyYLNcyZ3
	ECAnZ15UjwUJC8Lb2+6FiRQpFNzfVahaMBdDO7rJxTjOiXvTSMSjTxLjq4VxSJOZ
	s6qF+nb2PO1LXiTljezQdT16KJ8GYbm1k86puY3O6LY2QS9uYphJVCbt2YgJqbqx
	+fnI4BkWPPvY4ZC6dGADyU1s9IziEkMfYl6Kw6lQZqzll8eDmAmG6bzMX9WMcdpx
	jWnDfYROys5bP/DcU9BPNcMZgt7b4vva8EV0ObiDMQWIyPuPpZP71vLvb/aK78o9
	6Igw8eI7ROf+iPZWql56qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757058857; x=
	1757145257; bh=lsScigd+k1msycDeqEQuQcWBRbz1RqdZ41LFH70ZDmQ=; b=d
	HN6c60IXJKNqmo18bDZY4unG5SCeozG71DeM8ViHMsMPZTIcxadllT+SzuiqrNv+
	jm7HL7wgN7GrRiak9n2s6y10bezytoN9jxjQ6fPikCvJ0C2eImR3Rn9oVDVoQJLM
	Cu8UfGZuPyEA04b+VXQ+FQmibpNElqLn7/W07Ceu4RTw25JrmfjYaWuuK5vXD7mr
	nMkj4lgar32Z6cWaIIyKL+xME1blsYuqmQdjh5SiSTSUAxpWV7txygs7Vc+fP8vJ
	+CI07O4J83tfENXxwr8ifLDMonig0l40R22hV3/1bvXnEYGHgS+I8U+TOoLO3Hxh
	fVL3ADRnQ8Qb270X5Xk/Q==
X-ME-Sender: <xms:KZe6aErWCNuFhKLEUOK06XbKXsMQCLpDzZuw9QDycljlp_wdmvngww>
    <xme:KZe6aLQpZUwp-zAIbLrrgzWYjUx-hcSNJhcJbQKyeGL6KLz_HF6_xeQuA7fUGQrGJ
    wMZSN-b6j4dGugpoA>
X-ME-Received: <xmr:KZe6aEVJDEuEyRw8GKZBgdthLWJV-Nzt-bZ1uJbRQoqYtoo0tVSMJAO9ckvGFWVzsefEuoyeRDXGecRh4FdIDW0cv-xf5r1uj7b1ILZ2Q0BQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    dvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopegtsg
    esvdehiegsihhtrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprh
    gtphhtthhopehpihgvrhhrvgdqvghmmhgrnhhuvghlrdhprghtrhihsegvmhgsvggtohhs
    mhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgv
    fihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghonhhtrggttheshhgrtghkth
    hivhhishdrmhgv
X-ME-Proxy: <xmx:KZe6aAc7Vnqfrpq9lpMkAcl9ZXafkxpzPSXzYKZ-ASYtQ-8vcyvwDQ>
    <xmx:KZe6aHzL5r95-W1byFttczwG6OsESxI8EwQoTHO3_2L7l2hDe_vpMg>
    <xmx:KZe6aLGTt0IX0W46_7QidJ6ZXFgWLlj-tbx-X_0k-M7lHQOrUCAdUw>
    <xmx:KZe6aG0mjdvhETrKSuV2jqWILf1s3W1FVcT0TSaxMjY0GK1CQ9MjFg>
    <xmx:KZe6aCS_oKVt6KYsBZ9NmEu3HQ7xd5UTfBjxOibjGEyvXHN7tTYD8lR9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 03:54:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e14d2ca0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 07:54:14 +0000 (UTC)
Date: Fri, 5 Sep 2025 09:54:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
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
Subject: Re: [PATCH RFC 3/3] BreakingChanges: announce Rust becoming mandatory
Message-ID: <aLqXIwIU_L1Z1wIL@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250904-b4-pks-rust-breaking-change-v1-3-3af1d25e0be9@pks.im>
 <CAPig+cThyuo7=A2f7_XkE_TZmSRc5i=EFgZOw_pKgu+Ckgx70w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cThyuo7=A2f7_XkE_TZmSRc5i=EFgZOw_pKgu+Ckgx70w@mail.gmail.com>

On Thu, Sep 04, 2025 at 01:38:52PM -0400, Eric Sunshine wrote:
> On Thu, Sep 4, 2025 at 10:30 AM Patrick Steinhardt <ps@pks.im> wrote:
> > Over the last couple of years the appetite for bringin Rust into the
> > codebase has grown significantly across the developer base. Introducing
> > Rust is a major change though and has ramifications for the whole
> > ecosystem:
> 
> s/bringin/bringing/
> 
> > Instead, preceding commits have introduced a test balloon into our build
> > infrastructure that convert one tiny subsystem to use Rust. For now,
> > using Rust to build that subsystem is entirely optional -- if no Rust
> > support is available, we continue to use the C implementation. This test
> > balloon has the intention to give distributions time and let them ease
> > into our adoption of Rust.
> 
> If it's entirely optional and automatically disabled on platforms
> which don't have Rust installed/available, then it isn't a test
> balloon, is it? All previous test balloons in this project were
> architected in such a way that Git would fail to build if the platform
> in question lacked the feature being "test-ballooned", and the idea
> was that packagers of those systems would alert the Git project about
> the problem or somehow resolve it themselves via the platform's local
> build infrastructure.
> 
> However, with the approach implemented here, Git will build as usual
> on all platforms on which it already builds successfully, which means
> that the Git project is unlikely to hear complaints from packagers,
> especially if packagers haven't followed the relevant discussion
> threads and are unaware that a Rust test is being conducted. Moreover,
> the project has already heard from some packagers/maintainers that
> Rust support is lacking or (currently) impossible, so the project
> already has the sort of knowledge that a test balloon is intended to
> elicit.
> 
> That's not to say that the changes implemented by this series can't be
> valuable, but rather that for these patches to be valuable, you
> probably need some way to advertise the test more loudly so that
> packagers actually attempt the Rust build. One possible way to rectify
> this shortcoming would be to enable the Rust code by default in the
> Git project but give packagers a way to opt out of it if they can't
> make it work on their platforms.

Very true indeed. Thinking about this, how about we make this a
multi-step process?

  1. Introduce the feature as "auto"-detected on Meson and disabled in
     our Makefile. This allows us to get comfortable with the tooling
     and address any issues we find iteratively.

  2. Change Meson to default to "-Drust=enabled" and change our Makefile
     to make Rust opt-out instead of opt-in. Distros can still disable
     this, but should now be alert that something is upcoming.

  3. Remove the feature toggles altogether. Rust is now mandatory.

If this patch series here lands (1) would be the status quo. In one or
two releases we could then do (2). And with Git 3.0 we can finally do
(3).

I'll add this process to the BreakingChanges document to give readers
some guidance.

Patrick
