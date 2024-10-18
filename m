Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A48115381A
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 05:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729229469; cv=none; b=WPTpQW4D2j38usA9c/t7RJIvdGydRSOxG3E/t5NrJGfsCfcEwngMkTo7FGW1ozuRGrxZxIxoyEllQ0aOY6NcbFuGUQKNYc5vOEI3096/k07eXZDWQg3LSusTvHk112o46Nhg20VaC5wKi9Op6wIvgHxoibVatHUZTdzHeRcsKj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729229469; c=relaxed/simple;
	bh=4R+63cNl+hwP9yBYj031VP4ENd3c02Xs69Ov83Q0a34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjVuETIdGBl1CxwF+kLPd6hLiV2+e0Xu07tA/xXY8RkESul6+zEE8KRHCA5cmYOMTvxCoLpwwtnA64vwYxLLS+M/Om6Z0FXbRbsnLx0GHJeUSAP3SSfsYHo8ihXHNP2xCDxMJGoQOtad68WYwDBuzsx6DKp7wJ5ZeDUuUjGb8Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eVsjsPnc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=McE2YpcT; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eVsjsPnc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="McE2YpcT"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7C9C31140098;
	Fri, 18 Oct 2024 01:31:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 18 Oct 2024 01:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729229466; x=1729315866; bh=fWPEyDw2RO
	a/n23Gf6PMf8yeiPWJB8GH5UfqkHJzfpk=; b=eVsjsPncXy/3iBLtnbakkT6Mxv
	9Mj+1sZxW38Vx68HOyPTJDJa/MlI7lePMUNi8UTcS+5hP7yxAwWXQGDBKCf6w20M
	mubpY9PLHpYUaHbiPMUuTgWUIWb0nsFLgnxoa7N2TxEPx7cU+Q6VjhMeNm2ODdh3
	9hyvICxEuQEJHgjFJlNTVQbxp5+pb1RmPr0zUTNRdZWq4zKGhk4JWjLHAGeMOCw/
	yLrOCveq71BgsrQeTAf313Eaz+35zLVy77yRYgeZHoJ+HG1b0hpuJRj3oWQlq2UI
	FhN2LjOB/vwZMVIqEwc9RMFzRQqQEyc6FI+ivY5qTTwcImFey6wI6u6+LCjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729229466; x=1729315866; bh=fWPEyDw2ROa/n23Gf6PMf8yeiPWJ
	B8GH5UfqkHJzfpk=; b=McE2YpcTFWeCWtogT5XOiJfHO7GtHDtTDTbvXPH4dzf9
	10u2gkeh2vrLYVor1wU5tRHbyE32+oKWhgk3lI7jgsqsGIu/anTTsKfV536bL9I5
	U7o31Je2XNxq5Zdu3Lo44bXxfOPWrpBGb+EP88tFLArWow8uIAgP+9FxDbK132oq
	uvhYvuPUYwETFTaNMlNE/t7voNk1ZkVmWD8C++7ja9UuKuId+wzsJ+3tS2Y/5Gn4
	hihy56EkE0ubQaBS07vnTwgmEqKArWETGQggadcecwzSXrxBHodFNyxZmffzbFHx
	erWADqZWifv21NM6QemyzBreeE+hAGUPEug3vN51mA==
X-ME-Sender: <xms:mvIRZ9y0pSWAEtzjyIsE3cXl-N7nSXVqCaCPO32ugvC54TPkiklzJA>
    <xme:mvIRZ9TF0bJS4L6as_kMMi2fb6ozeXEjLg1lLuIuf31v4zUkEtysUQySTzm948E5n
    5JWPhtS8s6pLpbHOQ>
X-ME-Received: <xmr:mvIRZ3UL3smGpRfjLpBMJTu-F1NhkrTeW87EXqrn4wkJlZz3nHlP9Mi5jGbLe6QiRQ9fhilew1RKaejCjpTEhSxh9G2uBfMfTbqDSYJ_fMoX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehvddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopegsrghgrghsughothhmvgesghhmrghilhdrtghomhdprhgtphhtthhopehs
    rghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mvIRZ_hqlbyAK5C8y0w5DKAPZzoqqyvQJ5FNfXGvEFFsyepsb1v0-Q>
    <xmx:mvIRZ_AfnXKOPLuD_75lKeU3i5E3RkjawvlWL93ZE8Z4R1A0j6aHUQ>
    <xmx:mvIRZ4LVvgmAd3Vujh5InK81E4Clqd_32V_bhDPwRUUfu_ro0Ax5Mg>
    <xmx:mvIRZ-BFiZzCLpcDkHFWE2WiKiStEQb5_GJdm8LPuMG0F1L_DBtqOA>
    <xmx:mvIRZ65qWh8m4BTvKOwQFg569EOalTbzrA93gtTLYbBBy0rs8uHv-IXO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 01:31:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d56bc3cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 18 Oct 2024 05:29:42 +0000 (UTC)
Date: Fri, 18 Oct 2024 07:31:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: clar unit testing framework FTBFS on uclibc systems (wchar_t
 unsupported)
Message-ID: <ZxHylOLHaxP8crom@pks.im>
References: <ZxCJqe4-rsRo1yHg@archie.me>
 <ZxESP0xHV4cK64i0@pks.im>
 <ZxEXFI80i4Q_4NJT@pks.im>
 <ZxGN9zzt55GcL4Qj@tapette.crustytoothpaste.net>
 <20241018045155.GC2408674@coredump.intra.peff.net>
 <ZxHrIBCdnwdRdXAv@pks.im>
 <20241018052448.GD2408674@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018052448.GD2408674@coredump.intra.peff.net>

On Fri, Oct 18, 2024 at 01:24:48AM -0400, Jeff King wrote:
> On Fri, Oct 18, 2024 at 06:59:17AM +0200, Patrick Steinhardt wrote:
> 
> > > But IMHO this is a good example of where the flexibility of the first
> > > approach shines. We could accommodate this platform without any real
> > > cost (and indeed, we should be able to _drop_ some clar code).
> > 
> > Well, dropping doesn't work as it breaks other projects that depend on
> > the clar-features that depend on `wchar_t`. But other than that I agree
> > and would like to fix this issue, also because it potentially benefits
> > other users of the clar.
> 
> So that's a rabbit hole I didn't go down in my other message. ;)
> 
> But another traditional philosophy the Git project has had is to be very
> conservative in our dependencies. And now we have this new dependency,
> and already it is causing a portability problem.
> 
> I don't think that means we should throw away the dependency. But if we
> are inheriting portability problems from imported code, I think we
> should consider to what degree we can lightly tweak that code to match
> our project. I don't care what clar does upstream. If _we_ don't need
> wchar support, we can drop it or #ifdef it out.
> 
> Overall, I'm a little sad to see all of the #includes in clar.c. We have
> spent 20 years building up git-compat-util.h to meet our needs for
> portability, and there are lots of subtle bits in there about what is
> included and when, along with various wrappers. And now we have a new
> subsystem which doesn't use _any_ of that, and has its own set of
> includes and wrappers. It seems inevitable that we are going to run into
> cases where a platform we support isn't handled by clar, or that we'll
> have to duplicate our solution in both places. I wish it were just using
> git-compat-util.h. I know that means essentially forking, but I think I
> may prefer that to inheriting some other project's portability problems.

Well, I'm of a different mind here. It sure is more work for now, and I
have been chipping away at the issues. But in the end, it's not only us
who benefit, but the overall ecosystem because others can use clar on
more or less esoteric platforms, too. It's part of the reason why I have
been advocating for clar in the first place: we have a good relationship
to its maintainers, so it is easy to upstream changes.

So yes, right now we feel a bit of pain there. But that's going to go
away, and from thereon everyone benefits.

> > The only problem is that the platform seems to be severely broken. As
> > mentioned elsewhere, we have this snippet in uclibc's "wchar.h":
> > 
> >     #ifndef __UCLIBC_HAS_WCHAR__
> >     #error Attempted to include wchar.h when uClibc built without wide char support.
> >     #endif
> 
> Yeah, I have no clue what's going on there. Certainly I have no problem
> if you want to dig further to get confidence in the direction we choose.

Yup, I'll do that, but first need additional input from the reporter. I
don't have a uclibc platform, and couldn't really find obvious Docker
images to reproduce the issue with.

Patrick
