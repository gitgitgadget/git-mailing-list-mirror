Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EC118E20
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 05:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758690197; cv=none; b=B/8yOTBE7BSFoUN+ti4Yf9O5gADWcSRmzvXfBsZf/VvvV5HACW5ukI9iwdF9F7A1kXjhaJDz9P2UmNnTqVPOHwo/hffz9yI0NMKJ5eGhIFkO6U3YV7/kpttAe1xjwqKHcW7xsgkIN2tMcR2Qh1LZKgZKX6j60tMsHqOypTHoJNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758690197; c=relaxed/simple;
	bh=zvAt1fZZbwm2XXIcrncj1AIML9aIrrWH8zoqLoh8GvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/zm1cgd59mdDNPWY46MJUjvKwe86l2lkUdwNc3IYlbeQIuM2KSYF9y3PvQUDJJH5NI3tzv0KqcFqHmreWO8d3zLPmOnU1tnJdnVskFj4IFdZ9KEW/pC0hJcaN0Iy1qtZESSdZtdl+DqZP/z1xYFSWgu8XqUrt3P9q6RMVcro/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HiFRMgMQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gpvNU8jI; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HiFRMgMQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gpvNU8jI"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AD1C914000D6;
	Wed, 24 Sep 2025 01:03:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 24 Sep 2025 01:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758690194; x=1758776594; bh=cXUQbfCc/N
	WfyqPmMLEe11cwGd0y1ijYAawC3EJLUco=; b=HiFRMgMQ5zYCxHKFoKii+HFQzp
	GqktyK5QFRsmp2e/MmKhlkNRIt1Aw8cVMn5DFvJ4iiWP4kMJvPspfx9Mxz0tUPOT
	q/fMEf+XoqXodQUFa1q1mY8l1taBN5uESwaCheALi68DXxFNWLhLgp8JiCVSFbpu
	vutWvlgQh4B3lHIQAyjGSS/zjyyqTln6DbTg8JW71NmHWFSfoksyTkTVYKx4mpvl
	fBOKYTHjGROSPqzC1yy3vRHR1oN5Av69dVndhjdbfkcvdhIyS8Bh/pG94Lzjq1jt
	1Mm+wMBFvHHoaMAysMmS/K98mNr4++ROJGUCCINp+Mnj2VRn0G/oUtQniS7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758690194; x=1758776594; bh=cXUQbfCc/NWfyqPmMLEe11cwGd0y1ijYAaw
	C3EJLUco=; b=gpvNU8jIeV3Ps6wL9IDAbDFHNiAHkocoK6PoMGedoaxEnAMD+6B
	b6D4LDH7xdy3TEfUeGtOdQtl93DoyepKiuYs4tfK5aL0B7790O2S22YUtRKVzZfY
	IY9fOIWXtEKX0DsmK894/0u2kgcMCQCaNfraQ16bnPg21q1RcCL5xVNRu3cqmhOT
	k2B6l3E0Vpn9fsVDdVI87rd1akdFL0ThUpN7c6S2GnSN8ARV9c0sZCtcjaM7chzu
	NocB9AbexsMAC63A18FG/7o5GS7ZNcnyd/1PloOdWc8Cwe1Caz0BR6S1J3k8/Cyk
	2WA3bTs5gSkHJc3PRo+A71UskMJkrO93l2w==
X-ME-Sender: <xms:knvTaIfSoqmT_8GL0t7g_NYLOgghiIahpY7G5a1vQj5DVzxIRFhlCg>
    <xme:knvTaKpgl90J59Yo6Ekco4Daze5x0xYeUoqlTgD4emts81LXj103gjqyfLw-9X3mU
    fvlm1uDUfPhXsZ-2Jbzeo9cwvA-XnX2eqYil_eE9NH6_LOf1cNn>
X-ME-Received: <xmr:knvTaJRU6ENnDZlwQoIFy9HdFeg3AjKbrDFClzKtZOgHQSTpTOkJ1CLhS-bGXKHg47H-FkUNYSzuq0tu31GguTdUl1L-QBRiJPVNmTuhkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptghonhhtrggttheshhgrtghkthhivhhishdrmhgvpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtg
    homhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghp
    thhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomh
X-ME-Proxy: <xmx:knvTaKXK6kxyH-ppN5tzRvchOG4ATycBUORfnV2bd7SiT47kv0VbBA>
    <xmx:knvTaOeQz7IpRl4ZPcGkf1s6e5h6cavAg2H_-5xmkytfMDOn8SwbzA>
    <xmx:knvTaNybNznBr2qP6kPtHNMvRX2OJ4OjibihFTWqNAq1Rn3p3CGEsA>
    <xmx:knvTaJGM1t0BPb886yZW6A_YuH0uP3EcZSdQ2l3JYIHBMzXaDZA6Hg>
    <xmx:knvTaNV2XV_5YWOC16zKk3nFiWzaSV45fziYqHJvNeA5ErpfzqhWlxkB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 01:03:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 066076ad (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 24 Sep 2025 05:03:11 +0000 (UTC)
Date: Wed, 24 Sep 2025 07:03:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v6 7/9] BreakingChanges: announce Rust becoming mandatory
Message-ID: <aNN7izfqBprtoAcK@pks.im>
References: <20250923-b4-pks-rust-breaking-change-v6-0-59076fee486a@pks.im>
 <20250923-b4-pks-rust-breaking-change-v6-7-59076fee486a@pks.im>
 <d323c453-a800-413d-82d6-b0db0a4b76c0@gmail.com>
 <xmqqecrxoz5h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqecrxoz5h.fsf@gitster.g>

On Tue, Sep 23, 2025 at 10:29:46AM -0700, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> >> +We will evaluate the impact on downstream distributions before making Rust
> >> +mandatory in Git 3.0. If we see that the impact on downstream distributions
> >> +would be significant, we may decide to defer this breaking change to a
> >> +subsequent minor release. This evaluation will also take into account our own
> >> +learnings with how painful it is to keep Rust an optional component.
> >
> > I think this last paragraph is a welcome addition as it makes it clear
> > we're not going to blindly pursue rust if it causes widespread
> > problems. Personally I'd say "experience" rather than "learnings" but
> > that's probably me being a grumpy pedant.
> 
> If this transition turns out to be way too disruptive even for the
> 3.0 that promises big changes anyway, can "this breaking change"
> realistically be "deferred" to a subsequent "minor" release?
> 
> The only way I can think of that is permissible in a minor release
> would be to pear it down so much that it no longer is disruptive,
> but that would be very different from "this breaking change"
> anymore.
> 
> Or is this talking about waiting until the downstream distribions
> either die out without adding Rust support or start supporting Rust?
> That, except for the risk of having to wait forever, might work, but
> then to surviving distros, it would no longer be a "breaking" change
> even if we ship the same change as "this breaking change", right?

I guess the answer is "it depends". We're counting on tools like gccrs
and rustc_codegen_c to become viable, as those tools may help us quite
significantly to reduce the blast radius. But "reduce" doesn't
necessarily mean that there are no victims anymore.

I'll slightly reword this to say "this change" instead of "this breaking
change" though.

> I don't know.  To me, the last sentence sounds like reserving the
> right to later say "we learned that trying to support opt-in Rust
> component that we have to (partially) replicate in C is so painful,
> so we won't keep Rust an optional component".

We haven't gained a lot of experience with Rust yet, so I think we
should keep all options open for now. I really want the Rust experiment
to succeed (well, otherwise I wouldn't push this series), but we simply
don't know how it'll play out at this point.

Patrick
