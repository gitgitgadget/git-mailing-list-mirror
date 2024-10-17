Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C5A12DD8A
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729157795; cv=none; b=ZKQNLEcqAGkBkIQT5F9eup4+PE6bkVS3PIXFHRfflMvMlqUOWtGX407zdWvLgn8Sxohk4M9mGloR/xVtM9D0Olupb0uyufb1jKdequz12pL5P0vbfYtIb6XdWjqxx3mgLlXIPjwuRybsInD8rq4spPDFVt43oPjvfTOyzNyBI+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729157795; c=relaxed/simple;
	bh=bWCI89OnKH5hrYcd9jK32bLfDseZE4JHwXlkaPVSvmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flKDc0YG1bYHI8PAlXPME9v1ZSv/yJm8WwHjcvAYAQXH4CKYYrspQIMgHhBRkCXzuopQ4cYqafgnXSpkoQkuqb1utt16maQ6ifPX+qaU7HwC1oQezp1GzSG8rwiPHzjAmhIu4erQweXEja+GkntPgpitclLQKDt5ayaiOaOuhBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gw/vx9s8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n7kW7uqT; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gw/vx9s8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n7kW7uqT"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 60951254008F;
	Thu, 17 Oct 2024 05:36:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 17 Oct 2024 05:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729157791; x=1729244191; bh=gStjyXUkKo
	JEGuBxVHn1T3kPwLjugBxVcdsXkLKe5Vo=; b=gw/vx9s8lpu4MUj2I9SUo4WyUI
	+GLr/gVTmGmOtQAigPVfV0O8ZeyvYPcP7ReaCzIrhkVuIjyyK4cB/B084JFxJKCD
	LSzqhZHxZPbTFgGsVICm2/q/MofXUMr+plqC63wlsd/GwdOsk++Wkkfkun22kPeE
	l4s5ZXWMgO9kyp5eQTWNRx/jZjWlL4UAhsaj+UuK5qARGU5Z3QU8K4qOj3sHhz58
	nbsKdcF9K4hOSPjOFUlEHmjH1pwV2Bdr+pWSndj7UY2TjLMXWu6uqLsSOUnsP/V1
	92KKRCk7wMSp2ymYZ2fm0wE8avVfd4oYFNzaBNsN+LfXNi1m3ypDYEcpDvQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729157791; x=1729244191; bh=gStjyXUkKoJEGuBxVHn1T3kPwLju
	gBxVcdsXkLKe5Vo=; b=n7kW7uqTwB3ZVTbLI1cGrivZCOYh0mbJ8sNPzVmCld/l
	LJg7eL28EZsmYGGhfH0cy7tZLz1ZAwpiCkNHciQ1yNwz+/34vUrKhP3zp2TpRjH1
	WGWHa9h7oUDof7Nhw+W9KWGeBlLmcKcqQ0aC43H59nCXepmal7M9mHf8uDLcJkFw
	wp0OzHdQf8McuMcQUG7QjT1KneOpVSGIzvPRKfUUWv5drKCrzmmyvFSfY6egK42b
	OTM9i60biX7f3ztAXX6QnoyZdYPoQHU2AQ2QFpJ3m5vIqt53ufCuTV5Wfw/d7Nb5
	o54IXLnv7tIhOMbSG9gr0XkKffA9llWk5TcwxfmkQg==
X-ME-Sender: <xms:ntoQZ3716l7GQQgVQHNgHWhkbjZVNF3DXZaDTisY0DpcCxm0b4sAkA>
    <xme:ntoQZ87Wt15bKlOIsoxstKlesa-e2wAQPY_DMKwa-MfhP3xiQaKMom1ssU8ViB7I9
    -tUzOj-4Hn8AXdhWQ>
X-ME-Received: <xmr:ntoQZ-fhiyB5wsdJ7D7rTcrSu3wcll5duRk_MJKmj1vcfm3VFTUR2YBtZYLy31rsl6ynhl1nBAy_ruuhIq_JhTIaOOyKRz6AP0TepOrOILy7_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehuddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgt
    phhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoh
    epvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ntoQZ4IlXGCfUVV5lDh0Xda6wDDcfFh6Wn5iwQOkd8EnXsI2pungTA>
    <xmx:ntoQZ7KICl3z9IjOdziH5pA-A4k-VggYfglgyHdm3nONuboFaIsg2w>
    <xmx:ntoQZxy8SvXaBvm9FjSU0xDAgr4yK5LeBuHKbwHSuZZm42K1SlMK8Q>
    <xmx:ntoQZ3LRQLoY5w_nc8_kq3OOYDKGAn0gC5NaQ_oivJONGmiMN-u50A>
    <xmx:n9oQZxg_JO5SqiUXg7NW0al4xuBfziLMJebYjI6VEwNyj2tDKV1y8cuK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 05:36:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d3e428ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 09:35:07 +0000 (UTC)
Date: Thu, 17 Oct 2024 11:36:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v2 23/24] Documentation: add comparison of build
 systems
Message-ID: <ZxDak17cinw2ySKD@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1728485139.git.ps@pks.im>
 <afa2f79d46cb9b2e25cd31b622d5f547e2746f2e.1728485139.git.ps@pks.im>
 <72da40d7-2570-456c-966d-cd09579edd22@gmail.com>
 <Zw5cMv_fyctQsyT8@pks.im>
 <f68685c4-c8c8-45ac-a34c-1cff30cc11f5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f68685c4-c8c8-45ac-a34c-1cff30cc11f5@gmail.com>

On Wed, Oct 16, 2024 at 02:36:54PM +0100, phillip.wood123@gmail.com wrote:
> > > > +=== Test integration
> > > > +
> > > > +It should be possible to integrate tests into the build system such that it is
> > > > +possible to build and test Git within the build system. Features which are nice
> > > > +to have:
> > > > +
> > > > +  - Track build-time dependencies for respective tests. Unit tests have
> > > > +    different requirements than integration tests.
> > > > +  - Allow filtering of which tests to run.
> > > > +  - Allow interactive tests that drop the user into a shell with `test_pause` or
> > > > +    `debug`.
> > > 
> > > Does this last point mean we want to be able to selectively pass
> > > --interactive to the test script(s) being run?
> > 
> > What I mean by this is that when I see that a specific test fails, I
> > want to be able to execute only that single test such that things like
> > `test_pause` fail. What I don't mean is that the build system should
> > know to automatically rerun failing tests with that.
> > 
> > I've reformulated it to "Allow running tests such that utilities like
> > `test_pause` or `debug` work."
> 
> Ah so this is basically "there should be a way to disable parallelization
> and let the test access the terminal"?

Exactly.

With out-of-tree builds the development process is going to change a
bit, and it is going to be closer integrated with the build system.
Right now it's easy to manually execute a test and thus give it access
to the terminal. And while that shouldn't go away, you'd now have to set
up an additional environment variable to tell the test where the build
directory lives. There isn't really a way to avoid that.

But to me that also means that it's important that features we're all
used to remain easily accessible, and `test_pause` and `debug` are two
things that many developers probably use on a daily basis. I was worried
about that a when starting out on the Meson journey, but now I actually
have to say that I already favor the Meson workflow over the Makefile
workflow. Previously, I always used to do:

    $ make -C .. -j20 && ./t1234-something.sh

With Meson that becomes:

    $ meson test -i t1234-something

Which, at least to me, somehow feels way more enjoyable.

> > > > +- Ease of use: easy to use, discovering available options is easy. The
> > > > +  scripting language is straight-forward to use.
> > > > +- IDE support: Supports generating build instructions for Xcode and Microsoft
> > > > +  Visual Studio, a plugin exists for Visual Studio Code.
> > > 
> > > This is my main concern about meson - it means we either loose the nice
> > > integration on Windows that we have with CMake or we have to continue to
> > > maintain both. As I understand it Microsoft Visual Studio support requires
> > > the user to open a mingw terminal and run some to generate a build
> > > description which they can then use form the GUI which is what the CMake
> > > support was added to avoid. I guess they also need to install meson somehow
> > > as well.
> > 
> > I'm personally not particularly worried about having to generate the
> > MSVC solution from the command line once, as long as things just work
> > from thereon without requiring the developer to jump through hoops to
> > get it set up. It certainly doesn't seem like a particularly high
> > barrier to me, and should be a huge improvement compared to our current
> > Makefile.
> 
> It's an improvement on our Makefile but a regression compared to our
> CMakeList.txt which was specifically aimed making it easy for new
> contributors to get started without downloading any extra software or
> running terminal commands.

Yeah, that's fair enough.

> > I'm mostly there by now with the subprojects added in this version of
> > the patch series, which make it way easier to use MSVC without all deps
> > having been installed. But I still have to port over the SANE_TOOL_PATH
> > hack that we have in CMake.
> > 
> > I do understand that just clicking a button to import a CMakeLists.txt
> > is easier. It's mostly that I personally value the sanity that Meson
> > brings with it higher, which is of course a subjective opinion.
> 
> Right, I suspect the people who added support for building git in Visual
> Studio with CMake have different priorities. It's a real shame the meson
> there isn't a meson plugin for Visual Studio.

It certainly would be great to have such a plugin. There is one for
Visual Studio Code, but of course MSVC and VSC aren't the same. Which
reminds me, I should give that plugin a try.

In any case, my hope would be that eventually such a plugin does show
up. My gut feeling tells me that Meson has been picking up quite a bit
of steam over the last couple years, and more and more projects are
picking it up. And that makes me hopeful that we would eventually get
such a plugin.

It's of course wishful thinking, but as said, meanwhile we do have a way
for MSVC by generating the solution manually. So I'd already see it as a
net win if the official build system supports MSVC, even though not as
easily as with the click of a button.

Patrick
