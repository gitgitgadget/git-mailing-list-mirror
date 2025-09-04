Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF98C2D9EE7
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756986004; cv=none; b=BtQE/2msIKZsrLU4uo1HRmpxGw/Y7nradkZfaOZHdGPOtzYEQ5CQP6DUNC1sTy10frlp1kiF0tPJcinAz4YgdfXYtr38Z9SRsmFZxkLNc0xswi7usu9fJ0QX+atrFm/mR+S/jDfzjcRfov9qp9ySJwUwlYNJuLKhb+uaHP05Grk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756986004; c=relaxed/simple;
	bh=i3pNQsWwNYWjUFoamGXysedJYV0TrKGOytMF5pazNXk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teRQBvYR6A47bIx7sRKo891YVnG7ktc4XtSmltlWSu5+uudm4xz2QCqMStiOSmqvHWWoGcpI2Y6Yaa8eF9seEogZlAfyOWB7HDwxF5I32pExkdS3fxVqfOHb04WoZfEDDQdt1PFN5P9XrvVDtRm2/50fXL73XS75KoRv/AaCiR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=op/NOecT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GmyesIY0; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="op/NOecT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GmyesIY0"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A5FB61400291;
	Thu,  4 Sep 2025 07:40:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 04 Sep 2025 07:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756986001; x=1757072401; bh=jZ/FfpfYoW
	15itGfXhoMi9ER8Qd02LUs0Z/09g1bZBk=; b=op/NOecTFzxs8IMbqnp2Hwcai8
	TlHvD2SVhTPkuSM+MpXqeSn5Dly5E11fXtNs6tRKXoiJI3JuuTyuMPAE/7d0TgOj
	dkH7LFsgnC67NG6iFHepiAnQ36dkg1bYOPry165BuZ0zIY7DSnBlNpPWXGgHFzgI
	p0teSH2rSKsbB0h58PDdt8JnVRJHAnCKcw2cNxhEUUq3usj4bevBCKBYoPigxdTA
	6ywEorZxLrzR+5DEFEKLYMEtxrYV3h07iFeuxmRifcF0mkZbTimjM132mjziXBrq
	Zv4hM59PBxkR9IszNRRI6OqbYqPRhvkUIusiwH0zZOY51DIomHZPNRfMy2tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756986001; x=1757072401; bh=jZ/FfpfYoW15itGfXhoMi9ER8Qd02LUs0Z/
	09g1bZBk=; b=GmyesIY0Om58oD+D+Zr7Mrkf1uxHY1XcTzmsSnsXnvKTflwRuOJ
	ch2hD659nWH0EjTct8ksuPsdjeB4zej0WJtsdCN7ZJ9GQJ5glQyqe+i38trUzvUv
	dTD9wYZewQVzhhbNJgh1UZy/AqfHVmiESOsS34+kun0yC5fRU7EocNX0JGMdcyKx
	JgPd9ptD2lnTeQ4FbgycRagNj8BT6tEd/kY7q8JnoRXZUT5Cm8LWJC8cV+5ojnfK
	Gpk/d3z9hz6ITlG5mSLcBI36oKEWziXLzQK9ckysh64vFRjUxqmTEe1Bp+b0Andj
	P3I+bgcTJZGUo6RmdIyrkTBt94eseecjVFw==
X-ME-Sender: <xms:kHq5aPkjUU1ZENfDRD9TEyYaQNvL86e2hqJZHnFMZi3tKXh64xuGIw>
    <xme:kHq5aKd_IeFraethdPadH5kgchvbl1idhcyp-tiNOz18ddc_Jv9eH_Y9UxhgjPodk
    BKjnhSZi8uero5Crg>
X-ME-Received: <xmr:kHq5aF1rsImU7du6m37qxF54_OWx2U6jlwvWef3Zo5Wm7x5jBQFzXok-mMAesiv--MQlXRbJrKnracnXLrFB_1hj76YQwpZpMByToxpMM1nn6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfu
    thgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehke
    effeeggedvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopedvfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrh
    drtghomhdprhgtphhtthhopehsrghmsehgvghnthhoohdrohhrghdprhgtphhtthhopegt
    sgesvdehiegsihhtrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprh
    gtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthho
    pehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:kHq5aPkpEScRBX9eqq9CxUu8klVh6eLwUx8clZoVKHdlI0E4xBfq5Q>
    <xmx:kHq5aOY7onNCQlPSa1TfZEwyeIam6Q5ISHByYnOnXJFvs8SWKvp2Rg>
    <xmx:kHq5aFrB5ndT0GV9Bfoufbc8332f7m42WItHchITGvRXg4JiUk5Rfg>
    <xmx:kHq5aMgiQKxr0ubyJbqNylXyBIOAs2ZIO6OOVVfYo_ByvjZ6lB_PNA>
    <xmx:kXq5aK1qEIvUPu-2lh6hxosE6-4vt3TT_SgTZ-4w9pdQsREc1W3Ff09W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 07:39:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6095b2bd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 11:39:56 +0000 (UTC)
Date: Thu, 4 Sep 2025 13:39:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	rsbecker@nexbridge.com, 'Elijah Newren' <newren@gmail.com>,
	'Kristoffer Haugsbakk' <kristofferhaugsbakk@fastmail.com>,
	'Josh Soref' <gitgitgadget@gmail.com>, git@vger.kernel.org,
	'Christian Brabandt' <cb@256bit.org>,
	'Phillip Wood' <phillip.wood123@gmail.com>,
	'Eli Schwartz' <eschwartz@gentoo.org>,
	"'Haelwenn (lanodan) Monnier'" <contact@hacktivis.me>,
	'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
	'Matthias =?utf-8?B?QcOfaGF1ZXIn?= <mha1993@live.de>,
	'Sam James' <sam@gentoo.org>,
	'Collin Funk' <collin.funk1@gmail.com>,
	'Mike Hommey' <mh@glandium.org>,
	'Pierre-Emmanuel Patry' <pierre-emmanuel.patry@embecosm.com>,
	"'D. Ben Knoble'" <ben.knoble@gmail.com>,
	'Ramsay Jones' <ramsay@ramsayjones.plus.com>,
	'Ezekiel Newren' <ezekielnewren@gmail.com>,
	'Josh Steadmon' <steadmon@google.com>,
	'Calvin Wan' <calvinwan@google.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
Message-ID: <aLl6iFXeAvL_hvqR@pks.im>
References: <CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
 <aK5mJI1NfVQDmDXN@nand.local>
 <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
 <xmqqsehc1ypi.fsf@gitster.g>
 <aK9mx2XemppIaKVI@nand.local>
 <xmqqh5xszf91.fsf@gitster.g>
 <aLbSA5KsBdD4wW_B@pks.im>
 <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>
 <aLfU5sEa-RE3X4G2@pks.im>
 <aLjj9cG9_K6YLfeA@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLjj9cG9_K6YLfeA@fruit.crustytoothpaste.net>

On Thu, Sep 04, 2025 at 12:57:25AM +0000, brian m. carlson wrote:
> On 2025-09-03 at 05:40:54, Patrick Steinhardt wrote:
> > If I had the choice, I'd much rather adopt an ancient version of Rust if
> > it means that more platforms can support it.
> 
> I think you may be assuming that gccrs targeting Rust 1.49 will
> magically make it work on more platforms than upstream Rust will.
> That's not the case.

I don't have enough context to be able to tell. I'm mostly going by what
the gccrs maintainers themselves are saying. But if I'm misunderstanding
what gccrs will bring to the table I'm happy to be corrected.

[snip]
> > I think adopting Rust as a mandatory dependency out of nowhere would not
> > be playing nice. It may require significant effort from distros to adapt
> > to the new reality, so we should give them time to do so.
> 
> We've actually had this discussion on the list several times where we've
> proposed the inclusion of Rust.  This is not the first time it's come
> up, or the second.  It was explicitly mentioned a year ago on the list
> that we wanted to adopt Rust in the notes from the Contributor Summit.
> 
> There has been plenty of notice that this is coming down the line.  It's
> not accurate to claim it's "out of nowhere" nor to claim that people
> have not had plenty of time to port their systems.
> 
> Distros and porters should not be insensible to the increasing use of
> Rust or the need for them to get their systems working.  For instance,
> you cannot run a GNOME or MATE desktop environment without librsvg2,
> which is written in Rust.  Python's cryptography package adopted Rust
> over four years ago and there was the same gnashing of teeth[1], yet
> little progress has been made by porters on the same affected
> architectures since that time.  In that time, Debian has bootstrapped
> and released an entire RISC-V port, complete with Rust.

Discussions of theoretical nature are one thing though. The transition
that is actually happening is a different thing, and distributions will
need to prepare for this. We already had multiple distro maintainers
coming into these discussions saying that this will require a bunch of
work, which should be an indicator to us that we need to take it slow.
We should accommodate for that.

[snip]
> It should be stated that there is a very easy way to get Rust working,
> and that's to port LLVM to the platform in question.  IA-64 was removed
> in 2009, but it might be possible to resurrect that out of tree if
> there's interest and maybe even get it re-accepted upstream.  I'll point
> out that AIX, Solaris, and QNX have done the necessary porting work to
> get LLVM and Rust working over the past couple years, so it's not out of
> the question for other platforms to do so as well.  And, for the
> avoidance of doubt, I would be absolutely delighted if we were able to
> support additional platforms with Rust as well.

I cannot really say how hard or easy it is to port LLVM to a different
platform. I'd be surprised though if that work really was that easy.

> Also, the approach of making it an optional component directly
> contradicts the proposed policy I wrote up.  That's a recipe for
> additional burdensome work maintaining two implementations, when we
> actually want to make it easier for people to contribute functionality.
> It also doesn't provide any of the memory safety benefits or address any
> of the concerns from governments, security professionals, and other
> parties about the real and substantial risks of continuing to develop in
> C.

The only reason why we want to have it as an optional component is to
make the transitioning period easier for downstream distributors. And
the intent is not to convert major components -- it should be trivial
components that we can use as test balloons, similar to how we did it
for all of our C99 test balloons.

We cannot just pull the rug away under their feet without advance notice
that this is going to happen.

> For example, there is zero chance I will implement any of the
> SHA-1/SHA-256 compatibility code twice.  I'm already doing that in my
> free time without any compensation at all and it's unreasonable to
> expect me to do it twice or even to #ifdef out all the places it would
> need to go.  I am happy to let someone else take responsibility for the
> project instead, however, if they would like to do those things.

And that's totally fair. From my point of view, this compatibility code
is a _new_ feature that we are adding to Git. And as I mentioned, I
think it is reasonable to say that new features may be implemented in
Rust now already, as platforms that aren't yet ready wouldn't lose any
existing functionality.

> > It would be a shame, but right now it's a risky bet to build anything on
> > top of Rust given that we don't officially accept it in Git yet. We need
> > to first make the decision whether or not we want to have it right now,
> > and if so how that's supposed to look like.
> 
> I think we had made the decision at the 2024 Contributor's Summit that
> we wanted to adopt Rust in Git, so it was more of a matter of sending
> the patches than actually making that decision.  As I recall, the
> decision was unanimous.

I think most or even all of the contributors are on board. But we never
really talked about timelines, or how we want to introduce Rust, so
that's a discussion we need to have now.

Patrick
