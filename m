Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5B7136331
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729685056; cv=none; b=EfJGqxWjp+3jAidim9ALZHjxsfHl8z87LK5Skp5yG/dr2O60nd20M2EGrazS3azyr/D9IOXEuUwg7v6VXsXxKOGy8fPL4UIuzL/zz+Uc7nYAMfmB2avt9omSTDtAU0haAo88mUht4kRSQnIpP02IQScqV3lW55Q4/YWT4djsXDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729685056; c=relaxed/simple;
	bh=6pAUUwZyBBwrrN9u+b5yqodg34mhVv6eWVRC7jq7/hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCq7Ryr5pvSpCtBzHukduThysk/Evy4whABptKwfKHuujgLWon4iUWXvq3XUT3AheqyvzwQAofAeAib1yEWFJeY9SOq9sfTxR61I6TFbubOYhEoV0pz05yKqTuU+NNpFT6S3AaCr453woSca//YsrHJ7di/GulJQCQDxrWgkLKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GRREl275; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=flT2XkNv; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GRREl275";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="flT2XkNv"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 818451380775;
	Wed, 23 Oct 2024 08:04:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 23 Oct 2024 08:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729685052; x=1729771452; bh=A0iaeIEalP
	UzBn1FKMwXip7ie5g+nG4Gwyh2gmGsBdA=; b=GRREl275lvdS/IfJDaO6iZcb/k
	LblU8CVpu6qoVfJjJUQ/zeUV0CAIBiL+0SXBsAmHbBs4+jfCJ+ckOVejh0iJrtmc
	zu3zKxsoPODXvxqUYMbnzLZMGcbTvvQtHu7u9z4ELfkFKfZGR4/UIgjKaWGyLVMt
	HG10H2dziB+jRilB27+Nsyh3nQoCcO4rjGafb+o/UMG1KGNGD23LWQTVz7a17ibg
	HIS5ce62STCfIxKFcSBwDTaAFqh+CvST9B4cmrmOCeNbRveTXynvD7cWAJ1fzzq7
	1HRm5D9hWKipW3d9Azar1Uk2JoMVAJcRhRx4AfNX0Wm4WZgx9lGIAqEzgwAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729685052; x=1729771452; bh=A0iaeIEalPUzBn1FKMwXip7ie5g+
	nG4Gwyh2gmGsBdA=; b=flT2XkNvJ6EQJWNGvjGxUkPTf+RKvjzcWeZmVMwNKSAp
	a4WTJ7mZoxW69KLS2t5PoFfxErM6eNQ/MEkZ5CoxP48ZH8KSWaaQbkINjBqegjop
	Bwp9PhWsmj2MfrzPJholHUsvL/xpEsPKtZ/2l5LNC9+LtPwcUIm3JzVdmL9SD+Gp
	SlMZzmVvUJ9FVPewihx5VKOXG8yXI1BE/xCLVN0WyHXycpQu/pwqrBIK8GqZsHYe
	44mI/wMEhTPQ8sS/oRTbQGy3fWKwYyrkYxlSipTny1Msr92MY3h2vtfQvtYQZyej
	oB9zykAG2BMrnM8sAIR1AVnN78ief6MDsKl37jpelw==
X-ME-Sender: <xms:O-YYZ8kjMZAQOUEBV3B5zwuefHr5s2NOrOYSruLCwTgV5x-w_0NBmw>
    <xme:O-YYZ73uVB5-2rf8lKf3Xw4_Z1HVWRmfUPWS9zJwb4bQAZEh1WoTa_Xzui0qJS-Hy
    VGyvXzyt55g-9IEWA>
X-ME-Received: <xmr:O-YYZ6rMQyyURohFRFdMJmcfNXUYnGMp2n-SY1B09MimKCvLivwSlKzWiKDcwZ3nskWrmZaaPzZ_lTQr9egx5Vp12f7UYNr1xi5lZ6-KH61e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveeuudejhffgheeugedvveetlefhgfffudegteekgedu
    vdekudethedvfeehuedvnecuffhomhgrihhnpegtghhirdhinhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggp
    rhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhih
    hnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghm
    shgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:POYYZ4lMWiCCW92NJ3F4MRzY8KauLMsUXi4u72FVIonNgdb7uuZiEQ>
    <xmx:POYYZ61wxX-VoflWuxBJvGzSylyZr8g7vUyq22UvjTstnzGVNUQJ5A>
    <xmx:POYYZ_sDrzDx7tlYXkCpwvS9JR4kgNytbBhVek4jE_qeoXRa3K3wQg>
    <xmx:POYYZ2XFGcAXlO3gDg5jdtPaOsT1v3F79MbUl-c5ql1cX4T7VmvYMw>
    <xmx:POYYZ0oNQ0E0_xm8AaEK7mNXyzzbHkLslFCjipCa7suEmvGgIrLO5cXd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 08:04:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 881153cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Oct 2024 12:02:38 +0000 (UTC)
Date: Wed, 23 Oct 2024 14:04:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v3 00/15] Modernize the build system
Message-ID: <ZxjmNtcg8hyCJe-w@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729254070.git.ps@pks.im>
 <86de131b-bdea-4c37-b512-68b8378f4343@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86de131b-bdea-4c37-b512-68b8378f4343@ramsayjones.plus.com>

On Fri, Oct 18, 2024 at 05:08:41PM +0100, Ramsay Jones wrote:
> On 18/10/2024 13:23, Patrick Steinhardt wrote:
> > Hi,
> > 
> > this is the third version of my patch series that aims to modernize our
> > build system infrastructure. It refactors our existing build infra to be
> > ready for out-of-tree builds and then wires up Meson.
> > 
> > Changes compared to v2:
> > 
> >   - I have split out semi-related changes like the platform
> >     compatibility fixes into separate series. More on that further down
> >     below, where I explain the current base.
> > 
> >   - I have polished the CMake-related changes I've been doing as prereqs
> >     while refactoring our build system. Some of the changes weren't
> >     tested before, but now CMake works as expected.
> 
> Just curious, does the cmake build system work on Linux now?
> 
> (cmake is another system that I don't really know, except in a
> 'monkey-see monkey-do' kinda way)

To some extent. Some issues have been fixed and/or improved by this
series, but we're not fully there for CMake:

  - It builds, but the build leaks outside of the build directory into
    the source tree. In theory we now have all parts together to fix
    that, as demonstrated by the Meson build support, but I didn't wire
    this up.

  - The tests do not run at all for me, might be I'm holding it wrong.
    But with the patch that allows us to override the GIT-BUILD-DIR we
    should be able to get out-of-tree tests running, as well. Again, I
    didn't wire this up.

  - Some things simply haven't been wired up at all, like building
    "gitweb.cgi". Any gitweb-tests would thus fail.

But in any case, this patch series doesn't regress support for CMake
anymore like previous versions did.

> >   - Fixed up some dependencies in our Makefile, as I didn't amend them
> >     to depend on the new generator scripts.
> > 
> >   - I have extracted some more scripts to massage our Perl library code,
> >     shells cripts and gitweb.cgi such that they can be used by Make,
> >     CMake and Meson. This also fixes generation of "gitweb.cgi" on
> >     Meson as reported by Ramsay.
> 
> I haven't had time to test this yet (I haven't even properly read the
> patches), but from a quick squint, this looks similar to my attempts
> to do the same thing the other night (minus the cmake stuff, of course).
> 
> However, I didn't notice anything in the commit message about changing
> the format of the GITWEB-BUILD-OPTIONS file, which already exists before
> that commit. I did the same, btw, but it seems that file was only used to
> 'notice' when the configuration changed to enable the re-build of gitweb.cgi.
> In which case, the change in format (rather than content) was not an issue.

Yeah, it's been a bit weird before. It contained sed commands to
execute, but also some other relevant build options. Made this whole
thing a bit weird to use.

In any case, it works the same way that GIT-BUILD-OPTIONS work now,
which I think is a good thing. The plumbing around it is a bit verbose,
but other than that I think it's straight-forward.

> > 
> >   - I have fixed the cyclic dependency in our Makefile that I have
> >     introduced with v2.
> > 
> >   - I have addressed some feedback regarding "build-systems.txt".
> > 
> >   - I have made things work with OpenBSD 7.6.
> > 
> >   - Things now work on Cygwin and MinGW64 as expected, no more test
> >     failures except for t9700, which also fails with our Makefile.
> 
> This caused me some concern for a little while, since I don't recall
> that the t9700 test has ever failed for me on cygwin. I have the test
> output files for all versions of git (each rc and rel) from v2.12.0-rc0
> (5th Feb 2017) to today (all 143 of them) and none of them show that
> test failing. (I remove files from that directory on occasion when it
> takes up too much disk space).
> 
> However, you qualify that statement in the commit message to make clear
> that it works on cygwin, but fails on other windows 'targets'. phew! :)

Oh, yeah, that one seems misleading indeed.

> >   - I have improved how we set up the required tooling on Windows such
> >     that we detect Git for Windows-provided tools as we do with CMake.
> >     Like this, VS Code can now trivially import the Meson project and
> >     configure it. Furthermore, generation of the Visual Studio solution
> >     is trivial as well. So overall, things work fine now on all the
> >     important Windows environments that I'm aware of.
> > 
> >   - Several smaller fixes all over the place.
> > 
> > I've included a range-diff, but it's quite crowded overall.
> > 
> > In general I think that this is in a pretty good shape now. I have
> > tested things on NixOS, macOS 10.15, OpenBSD 7.6, FreeBSD 14.1, Windows
> > 10 with MSVC, VS Code, MinGW and Cygwin, and things are generally smooth
> > and just work. I'm sure there's still going to be weirdnesses on some
> > platforms regardless of that.
> 
> I had a very quick attempt on cygwin the other night, and it behaved
> differently at the 'ninja test' stage. It printed something like
> '[0/1] all tests' and then seemed to do nothing, except 'python3.9'
> was hovering up all cycles (well over 75% anyway) with no indication
> of any progress. This was nothing like the behaviour on Linux (which
> also looked a bit strange, but at least showed progress on each test
> as it ran).
> 
> I ^C-ed it, since I didn't want to wait 6 hours before it (hopefully)
> finished running.

Interesting, that's something I didn't experience yet. I'll chime in
further down in this thread.

Patrick
