Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B251EBA1F
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994373; cv=none; b=cKza8NNILUTmqnnxQxZRabSX3MHr/TADGYgnw+ZSvgTC+dAWNETS9l9dXpMigg0dWMjYHB1kKe4A38N1OxBB0pgRnuKca4Rr5KN2/+eQ2h35AxGfNhPLuWS/qbdUZBtbI1Aq3Kf+MWp/QwdXEFmC/gDJWGZ4Wsz0EaoGslGQqLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994373; c=relaxed/simple;
	bh=BDUaWP7WKvW18XoW8eBgUrsUkxqpyR5TE/SmxcDjcXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poErZ/roU+khtNSpAk4Lv13ls/mCwew5LL0Yeow5r/+Knm/ZiioqsOLQDdLyJciUHebC90tavHIPfYO9CYTbNjRoZxU5dxWAET48a0BrvbJ/PXAWo1WFTay7Pp1QIKaZxYuslBJ2RtxhEOTIgWWA3NggkaGyovzBWqcek+d530Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZK18aAXH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p5jTCMDc; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZK18aAXH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p5jTCMDc"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3AC9711400CC;
	Tue, 15 Oct 2024 08:12:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 15 Oct 2024 08:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728994370; x=1729080770; bh=vEzbYm4kLR
	hmCPbhcGiE1tibsmwtIfNZ3ncwUEsFT1k=; b=ZK18aAXHMPgY3TTAeq/qRAKDk/
	AGC4dVbUG9p8IoJmwdU2GZuCgGipuipIaDwM3AabIB1uywTglrDE28OMqCBf1nTP
	ZC4hNylbeal7wLXPPiMBfToAGq3Pwqu1M7ARou07TqTkIUEeLiezUOycHrewgRoJ
	uryNheDu3+Ulr8mpRyuUKTdprUhAK6pUqnuaAQvwZdCPyRvw6pqkR/nTAg0FmAdz
	8GK9Qd7eDcIw4E3X202U9MZxCA+kHkSkaJpDpOXhr25kHiKLhgUPqyTyCbECwcsC
	l3TbJ/YbGw1Krp02vMeu35ThRQLwiDsnxF7Ak3fL3/cYhkR2m2dy6EqFc/Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728994370; x=1729080770; bh=vEzbYm4kLRhmCPbhcGiE1tibsmwt
	IfNZ3ncwUEsFT1k=; b=p5jTCMDc+kM9wI+qvZs9y2uoeO50Ljgeitm9mvKA7jpu
	x9WxgL9bYuXeOf5mKPh2UEIIeMIWuA8uGnD1ydGaklLr2khFNniPZ+9laSuCXwc3
	N2iif5nb5cicOXjZzLsCuWGaodNLfjdoNrVKTY2QuB5mobu7BP/m1dWnb5XWnRce
	T0q3mVO1wnl95g8ncAu22WeP/ZKh80Xfd5DP5vD9BZG+YMP6QriO/cn85Nwzuqgb
	J2SrwAmzzaOiia9nZDK/FvSmgqtUq7dQE+fU4+VJLoc1vNJZsEK2VLSMWIZ6XG2a
	ait3juYYjwKRXlDVPCBe0dG3sevrnHt5C9Gqrsr5jA==
X-ME-Sender: <xms:QVwOZ0QjYb6Jm9YmFv4mZ1OsvQr_2JANw4DAKvFofWfVthpIovNqOg>
    <xme:QVwOZxw4sRer56IjUIgsPzWYVNx4p5R3eCgSZ6mUzzMV3xBRXLw5F2Fq8k9lf_xav
    9Q1P3kEzdzBuctw6A>
X-ME-Received: <xmr:QVwOZx1kDkgKULQ2ekgaLVN0GtVDhu_1AXDTKgUpINjRNl_xhKNncpsqjbIfFB9t6J4Wly5JAfWpFtzbRn2ciDdsoeXBDq8wTppqFxSYYcXtvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhu
    khdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthhifrghrthii
    sehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:QVwOZ4AaslG9B9RY0sfmJQIYobbkIK6s3WNBFpegQXtuUirtKwDFFA>
    <xmx:QVwOZ9gM6Hb7OnMYGkAzCD-E73PX2etQBtP68Cik2QWmX1ZgZ7XbMA>
    <xmx:QVwOZ0okXsTPFSevveAMupIwUr_avK3BmPBPM9YaW0kFF1-v2NeuLA>
    <xmx:QVwOZwiBhUO6atcLQglpyl-nHv5MHfyeMrXldvqTP5dCbhc-Dk6-nA>
    <xmx:QlwOZ7aDNh491am6FYTE0WgjSXapo5zBSKceCQY5qFmW09D7haC6tggK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 08:12:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d872d255 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Oct 2024 12:11:29 +0000 (UTC)
Date: Tue, 15 Oct 2024 14:12:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v2 23/24] Documentation: add comparison of build
 systems
Message-ID: <Zw5cMv_fyctQsyT8@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1728485139.git.ps@pks.im>
 <afa2f79d46cb9b2e25cd31b622d5f547e2746f2e.1728485139.git.ps@pks.im>
 <72da40d7-2570-456c-966d-cd09579edd22@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72da40d7-2570-456c-966d-cd09579edd22@gmail.com>

On Mon, Oct 14, 2024 at 04:23:33PM +0100, Phillip Wood wrote:
> On 09/10/2024 15:57, Patrick Steinhardt wrote:
> > +== Requirements
> > +
> > +The following subsections present a list of requirements that we have for any
> > +potential build system. Sections are sorted by decreasing priority, even though
> > +these priorities will naturally differ between users.
> 
> This last sentence sounds a bit self contradictory - whose priorities are we
> using?

I guess it's priorities as received by the author, namely me. I didn't
quite know how to write this, as I didn't want to force my own prios on
everybody else without saying so. But if people agree with the general
ordering I'm happy to drop this sentence.

> > +=== Platform support
> > +
> > +The build system must have support for all of our primary platforms as outlined
> > +by. These platforms are:
> 
> Something seems to have been lost when the first sentence was edited.
> 
> > +  - Linux
> > +  - Windows
> > +  - macOS
> > +
> > +Furthermore, the build system should have support for the following secondary
> > +platforms:
> > +
> > +  - AIX
> > +  - FreeBSD
> > +  - NetBSD
> > +  - OpenBSD
> > +
> > +The platforms which must be supported by the tool should be aligned with our
> > +[platform support policy](platform-support.txt).
> 
> The platform support document does not use the terms primary or secondary
> when talking about support so I'm not sure what distinction we're trying to
> make here. Also where does NonStop fit into this?

Yes, true, and that's an issue from my point of view. I think we should
make explicit the different kinds of support we have and have a proper
list of systems that are supported and their general "support tier".
Anyway, that's a different can of worms that I don't want to open right
now. My table is still crawling with worms from previously-opened cans.

I've reworded this slightly now and added NonStop.

> > +=== Ease of use
> > +
> > +The build system should be both easy to use and easy to extend. While this is
> > +naturally a subjective metric it is likely not controversial to say that some
> > +build systems are considerably harder to use than others.
> 
> The tricky part is deciding how to measure ease of use if we're going to use
> it as a metric for selecting a build system.

Yup. It's part of the reason why I wanted to have all build systems in
the tree, such that it is possible to compare them by just having a look
for how it looks like.

Things are naturally going to be subjective, and that is fine. But I
guess that we can mostly agree on some general things, like "autoconf
looks like gibberish".

> > +=== Language support
> > +
> > +The following languages and toolchains are of relevance and should be supported
> > +by the build system:
> > +
> > +  - C: the primary compiled language used by Git, must be supported. Relevant
> > +    toolchains are GCC, Clang and MSVC.
> > +  - Rust: candidate as a second compiled lanugage, should be supported. Relevant
> > +    toolchains is the LLVM-based rustc.
> > +
> > +Built-in support for the respective languages is preferred over support that
> > +needs to be wired up manually to avoid unnecessary complexity. Native support
> > +includes the following features:
> > +
> > +  - Compiling objects.
> > +  - Dependency tracking.
> > +  - Detection of available features.
> > +  - Discovery of relevant toolchains.
> > +  - Linking libraries and executables.
> 
> Do we want a section about templating (i.e. substituting @XXX@) support
> which we use when installing scripts?

It doesn't hurt.

> > +=== Test integration
> > +
> > +It should be possible to integrate tests into the build system such that it is
> > +possible to build and test Git within the build system. Features which are nice
> > +to have:
> > +
> > +  - Track build-time dependencies for respective tests. Unit tests have
> > +    different requirements than integration tests.
> > +  - Allow filtering of which tests to run.
> > +  - Allow interactive tests that drop the user into a shell with `test_pause` or
> > +    `debug`.
> 
> Does this last point mean we want to be able to selectively pass
> --interactive to the test script(s) being run?

What I mean by this is that when I see that a specific test fails, I
want to be able to execute only that single test such that things like
`test_pause` fail. What I don't mean is that the build system should
know to automatically rerun failing tests with that.

I've reformulated it to "Allow running tests such that utilities like
`test_pause` or `debug` work."

> > +=== CMake
> > +
> > +- Platform support: not as extensive as GNU Make or autoconf, but all major
> > +  platforms are supported.
> > +  - AIX
> > +  - Cygwin
> > +  - FreeBSD
> > +  - Linux
> > +  - OpenBSD
> > +  - Solaris
> > +  - Windows
> > +  - macOS
> 
> This matches the list in the CMake README but in practice it is available
> for a much wider range of platforms including all those listed below for
> meson.

I was searching for an official statement, but couldn't find anything.
Do you maybe have a pointer?

> > +- Ease of use: easy to use, discovering available options is not always
> > +  trivial. The scripting language used by CMake is somewhat cumbersome to use,
> > +  but extending CMake build instructions is doable.
> > +- IDE support: natively integrated into Microsoft Visual Studio. Can generate
> > +  project descriptions for Xcode. An extension is available for Visual Studio
> > +  Code. Many other IDEs have plugins for CMake.
> > +- Out-of-tree builds: supported.
> > +- Cross-platform builds: supported.
> > +- Language support:
> > +  - C: Supported for GCC, Clang, MSVC and other toolchains.
> > +  - Rust: No built-in support, needs to be wired up manually.
> > +- Test integration: supported, even though test dependencies are a bit
> > +  cumbersome to use via "test fixtures". Interactive test runs are not
> > +  supported.
> > +
> > +=== Meson
> > +
> > +- Platform: not as extensive as GNU Make or autoconf, but all major platforms
> > +  and some smaller ones are supported.
> > +  - AIX
> > +  - Cygwin
> > +  - DragonflyBSD
> > +  - FreeBSD
> > +  - Haiku
> > +  - Linux
> > +  - NetBSD
> > +  - OpenBSD
> > +  - Solaris
> > +  - Windows
> > +  - macOS
> > +- Ease of use: easy to use, discovering available options is easy. The
> > +  scripting language is straight-forward to use.
> > +- IDE support: Supports generating build instructions for Xcode and Microsoft
> > +  Visual Studio, a plugin exists for Visual Studio Code.
> 
> This is my main concern about meson - it means we either loose the nice
> integration on Windows that we have with CMake or we have to continue to
> maintain both. As I understand it Microsoft Visual Studio support requires
> the user to open a mingw terminal and run some to generate a build
> description which they can then use form the GUI which is what the CMake
> support was added to avoid. I guess they also need to install meson somehow
> as well.

I'm personally not particularly worried about having to generate the
MSVC solution from the command line once, as long as things just work
from thereon without requiring the developer to jump through hoops to
get it set up. It certainly doesn't seem like a particularly high
barrier to me, and should be a huge improvement compared to our current
Makefile.

I'm mostly there by now with the subprojects added in this version of
the patch series, which make it way easier to use MSVC without all deps
having been installed. But I still have to port over the SANE_TOOL_PATH
hack that we have in CMake.

I do understand that just clicking a button to import a CMakeLists.txt
is easier. It's mostly that I personally value the sanity that Meson
brings with it higher, which is of course a subjective opinion.

Patrick
