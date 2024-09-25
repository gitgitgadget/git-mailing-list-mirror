Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2772E2AE6C
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 06:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727244301; cv=none; b=fFXsJ6WWkVeAN17Jl6vmmSsG9a0qq9TSiHpT2UbEJc0zGrWzYXUmX1vn6MubvplsL49Z+fJA5cmONMTOn1ov/uv9csJHxyb30/yjkkZED11KiOxAQd6zbWuaeP3w8d+XXk414D0K02w4Ofsu5tNr6aUNJjZdkQ6w+C/6XGenXes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727244301; c=relaxed/simple;
	bh=DsP0QKE9XZzhYGQWUZUQVWchf+nGQt/InyxxRVFI3qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbpm8j5S9YMc35GXrauPX7zyHLUbrT1U6BKUfeKQS4K3rAoDTwX5eelWe0VRBlY+4bVM3RNYCMeEg7L4bgbgFWALwna4H0KNPqlC8VKxNF/S313wn9ZkL8xXx8D1S2SDJo00SiI9/JtWYVmv3A758e8OHG6WBTfBUVKSuu+Rw9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JLpeugX7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JgxNcH81; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JLpeugX7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JgxNcH81"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1AE3B1380717;
	Wed, 25 Sep 2024 02:04:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 25 Sep 2024 02:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727244298; x=1727330698; bh=sunyxUIhc+
	kisZPajlwbUOyfFnp88GGAFZtkRkHbss8=; b=JLpeugX7g2qYouU3baS4Nn3SGj
	K0l77DvFAzqYweiPlFO26DEuHWgsFpHbKJzcEdlcO48S+kn5TnqpYn/okgOQSycB
	N1znWYfETWqFnJf7Sn+wEZ+zC58MEDu+bX1mVBlElasPbw8P65zQBaynLWyAHlQe
	cTJQDbgUHlljYsWug81r3rS6SZ+QSsK2HsAkry9+QryZ4NvJh8RrO+eC3ZT5U2Fo
	dTgXAk/QFd0LHXAsx/7DNwoY7MrU220V4pLEdh/UkqcN/Gn/J8jqOsfqkeZ/RBf2
	llAXMjwNGkIq9e2xwWzWGQbAOSVYQJd7Brl4GS7Dh+qo8vPf3ap1yk3sJQbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727244298; x=1727330698; bh=sunyxUIhc+kisZPajlwbUOyfFnp8
	8GGAFZtkRkHbss8=; b=JgxNcH81UgEMSjnGOavxDJv28GnquV/VUPutaszuKJDi
	UU2cifJGx/qcof4SwkhlIXa76dODmL2PeY+Ao4u9AKpiUg2rGyUbwLE7sFAYwYrb
	A5SmtF2ZdH3UsZdUe5UErxCNO/T0yzsJCLEnT/0PziHMW2P/LQNnQSABnh81bpSD
	LRqsdrbQiZKCVSWuYhoF3v0lWQj1Lw2YfwJLw+NMD/w1cfI0bQZ1y7dxpF14cFtd
	t1oMrl+yA4ZxgTXROn3VN9HQ8QZOfZUTdZ/NjPp1udTrSQq8k6lYyy4nviii6UPz
	+px46/Yue8OdIgSP4pNL5jteQnLCUkLGuedpUKPE/Q==
X-ME-Sender: <xms:CajzZk3mM8gLQ1i4GHhWaQCLgpW4dblFwKoyfRyfj7ieoaDqzuVsxw>
    <xme:CajzZvFY9DsfhjQbnkiKu3F5i60FmIMT9kYrCbnH98Xn6zQ13823eCeNwI_5KIll_
    2tAv0oppFQf2HS3Og>
X-ME-Received: <xmr:CajzZs68fgICTiCJq5s50siY1FY-_-CNHchBBJNrZBFQITQrbxdfo9cCPZiFqjKeKabB6q8XlnEd3n_-RaA1_mgxcw2IEAXR0N4D_C-jlTNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtgedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevvdehudfgjeetueefueekkeekgedvkeeftdffjeev
    ffefuddvveeitdehgfdttdenucffohhmrghinhepghgvnhhtohhordhorhhgpdhkihhtfi
    grrhgvrdgtohhmpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhope
    ejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohephhgvnhhrihhkrdhhohhlshhtsehouhhtlhhoohhkrdgtohhmpdhrtghpthhtohepjh
    hohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepvghs
    tghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepjhhrnhhivgguvghrse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:CajzZt3jYuQu4I6WgRLjqWjPT4PBch3a8SBIczrA_uDZ8I-WMneF2Q>
    <xmx:CajzZnFX0widgiy3CVh_JzMS7QbtpzPTmXvmN_OaNggKQH5YrpQNtw>
    <xmx:CajzZm9dnr2uFkGyIlh-Kv7bC-x-llUEZD8yCC9jnpixM8jrlcX1Kw>
    <xmx:CajzZskTUdsWulPhQf7olJh9ARUmHvySITEd5mW0w5PdPM2p_qdgUg>
    <xmx:CqjzZm0BWsEKWCjyiuwcqhbQvEITuIk18akQUx6i_M4vclK-WF-YPAT2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Sep 2024 02:04:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2e22987f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Sep 2024 06:04:19 +0000 (UTC)
Date: Wed, 25 Sep 2024 08:04:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Henrik Holst <henrik.holst@outlook.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: ./configure fails to link test program due to missing
 dependencies
Message-ID: <ZvOn_wChzEgXtpMd@pks.im>
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
 <xmqqldzsrhyp.fsf@gitster.g>
 <ZufjWR6AJM-DIWPR@pks.im>
 <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com>
 <xmqqy13oa8oe.fsf@gitster.g>
 <ZvKsH1Ct-YwBPA_f@pks.im>
 <b6b131cb-683c-4140-9769-290b622721e1@gentoo.org>
 <ZvOTL0cG8qRY8OXe@pks.im>
 <1f002f86-9212-4639-8804-898bc62726e5@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f002f86-9212-4639-8804-898bc62726e5@gentoo.org>

On Wed, Sep 25, 2024 at 02:02:34AM -0400, Eli Schwartz wrote:
> On 9/25/24 12:36 AM, Patrick Steinhardt wrote:
> > On Tue, Sep 24, 2024 at 09:59:52AM -0400, Eli Schwartz wrote:
> >> On 9/24/24 8:10 AM, Patrick Steinhardt wrote:
> >> Still I would prefer meson over autotools any day of the week. I'd also
> >> prefer autotools over cmake, mind you.
> > 
> > Is that a typo or do you really prefer autotools over CMake? :)
> 
> 
> POSIX sh (used by autotools) has a more powerful and capable type system
> than CMakeLists.txt (this is not a typo either! compare CMake's
> "semicolon;delimited;string" type to POSIX sh's "$@" type)
> 
> 
> m4 is less painful to debug than successfully configuring, spending 4
> hours compiling a ginormous project, then failing at the end with (this
> is because of the type system again, since there is no type for
> dependency-was-not-found they smuggle it along as a string value with
> special meaning):
> ld: cannot find -lCURL-NOTFOUND: No such file or directory
> 
> 
> If you enable cmake's test system, but you do it inside a subdir e.g.
> inside tests/CMakeLists.txt, you cannot run "ctest" (or make test)
> except inside that subdir. ctest will exit 0, and no rules will be
> generated to descend into the correct directory instead. This has bitten
> me a *bunch* of times in Gentoo packaging and it always throws me for a
> loop. I don't understand the point of such a design.
> 
> 
> I have never had autotools refuse point-blank to detect that another
> package is installed and usable for ***shared linkage*** because my
> distro automatically removes static libraries when a corresponding
> shared library exists, and
> 
> CMake Error at /usr/lib64/cmake/libssh2/Libssh2Config.cmake:92 (message):
>   The imported target "Libssh2::libssh2_static" references the file
> 
>      "/usr/lib64/libssh2.a"
> 
>   but this file does not exist.  Possible reasons include:
> 
>   * The file was deleted, renamed, or moved to another location.
> 
>   * An install or uninstall procedure did not complete successfully.
> 
>   * The installation package was faulty and contained
> 
>      "/usr/lib64/cmake/libssh2/Libssh2Config-relwithdebinfo.cmake"
> 
>   but not all the files it references.
> 
> 
> autotools projects have never harmed me by running the square of my make
> -j$(nproc) count due to recursively running cmake inside of generated
> Makefiles -- perhaps that isn't strictly the fault of CMake but cmake
> does very little to discourage it: https://bugs.gentoo.org/921309
> 
> 
> autotools doesn't have much in the way of built-in tooling for detecting
> "packages" instead of "libraries" for arbitrary system dependencies. It
> allows you to use pkg-config or code your own (foo-config scripts were
> popular once and in some circles still are). You might think this is a
> negative, but it's actually a positive compared to cmake, which includes
> builtin dependency finders for e.g. zlib that break on a simple version
> update because they locate the header file, open it up and use regular
> expressions to extract a #define for the package version instead of
> asking the preprocessor... a very brittle regex, too:
> https://gitlab.kitware.com/cmake/cmake/-/issues/25200
> 
> 
> autotools projects don't automatically detect your end-to-end
> integration test's dummy project, integrate its results into your build,
> and install some of your project files twice, once with bad values, but
> only when you run the project tests (this one was very fun):
> https://github.com/nlohmann/json/issues/2907#issuecomment-890580081
> 
> 
> ...
> 
> 
> I'm probably biased, but some of these failure modes are *weird*. And
> they basically never require the CMakeLists.txt to do something
> considered non-idiomatic in order to trigger the issue.

All of this is very valuable data to make my case for Meson instead of
CMake. Appreciated, thanks!

Patrick
