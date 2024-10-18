Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D811282F1
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254284; cv=none; b=HCEMsaPGGHUFdUAblvWxqk9z431DXA0fPFZK+pisNDeDPqEUbIRfVciNytXram/s6pv7v3I5uhR71zcW8S9jsslFklaEgZb3PF2DL+qFBGzMSnXjY/YaawOnKKGRg8LCnC5GfyZtk8BQrg4ZT4xywLaSubVbRjFUgK+KuKmLeJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254284; c=relaxed/simple;
	bh=1quH/1ALJlZhIP0xxWwaA1wszG48eC88izy6YSK5iC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUbJGKuSJ/tW/m6RaKLIOzdQyFX47soWqpFG/dHghwDByenztvT7mRt3KbIh618sWwnOnkSVAO7MCCjFEebYkeR73kDmYY4KR1bqYEkN1ujQoaztl4U4yo8PcMCmREfCpPCIzaie2RiOlOHK54b8oRjm17CKXHkHsT+TBaElgck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jxOH/C4F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XNmHFPZX; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jxOH/C4F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XNmHFPZX"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 540DC25400B8;
	Fri, 18 Oct 2024 08:24:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 18 Oct 2024 08:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729254280; x=1729340680; bh=SM3HJ/IzEh
	tKjzrYBUESeukIaegjRV0Ye9guPSIGLew=; b=jxOH/C4Fu0ikTXbr6eAEHz6NxF
	W+KjWxznowSVmoyC2wP6+1ZZ7xt2mAscomdCklzPpvDvqJ68Sy8Gs18BEfClmxwY
	vWbqk0hok6qtP37W17++b3pFcoLJiek5Bv5/sVgRmiEpiUycXMbnkO9L984fP9Oz
	8w6Wpfl2idBSkuANF+4qnb1UVHFcK2jnJcUgO+dVxcHonxWj6eeXV9Ac4w8zCWd0
	kHbZwLuXvG6nLpouySyuSY+A8QXh3QstKMZk4MYsY2FmQ4TWy+nR00iKTi5rzSFw
	UdD4bRXONGMvl1i9Goh1jawO8Ddqd3LnDllaVAXrvmmYJO6JB+aJUX+TEw7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729254280; x=1729340680; bh=SM3HJ/IzEhtKjzrYBUESeukIaegj
	RV0Ye9guPSIGLew=; b=XNmHFPZX+NQt4owLuaBrW1hm7I6iND56H1crTrzHHFU7
	/ZbG1tN8LZEq+uCzuHMauKS9dYMc42+lG0kwQm9VfQ24dhjmkyXo9NLYGeff/8cS
	iZwbkduLm/kTZapQfxjPE/gD7CBDq/sNGedYLj5dLhYryasLFF4Qbox13xLtbhBX
	BhzFjkXi3rIOAix4MY6uO/kuRM1f1w+kyMVNnjKGRzQJ2xF0Gi9lrD0w1mvEC6Je
	HlnLEMpO9lScpH3cAY8fETXsHzNX1tohN87YD2O4oP8SDl7WJmfCfsf5sDeGCFer
	QLUPbvP7WMOXslnP0sFtQ+N+sx5ZPPhLgW/m6LqRZg==
X-ME-Sender: <xms:iFMSZ7lHydoIc6XVZSW9npEMF4E6oWxu8PIZeBGe7nIYaQTjJ3EXEA>
    <xme:iFMSZ-3bpdJuOQfJMlBMUc2Us7-d4K3tl9jZnlJIxxEXUhyTp7nHhZAkLa5koMMiI
    f0x0yII7HajgWYyyw>
X-ME-Received: <xmr:iFMSZxrqEfBjDwJN1NT46dUU3x_gRTd-gx_zNIOXvmfi05tva-Rd2-JxGeXbmVOhM81JOJrt-SfjtEAYYvN5hDKbTGpTktup8h0jawm5Xf5W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehfedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveefffdtgfekhfdttdejhefgffffjedtfeelueetgfeh
    heehudeihffgjedvkeegnecuffhomhgrihhnpehtgihtrdgruhhtohenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhn
    shhhihhnvggtohdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhooh
    drohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:iFMSZzl1z_Dw5OkVYaW1_IARUBvEKZkUoazUQPwDL2_7wJv_s8FoEw>
    <xmx:iFMSZ53jdaakbznV2u0PKHniNlyPwe098_iIJKtU2msxcJKofEyH0w>
    <xmx:iFMSZyuUU0a5seu5ytT2CbImEDTvsAIQ-6w5ko5FJ-MXvjyH7mkUVw>
    <xmx:iFMSZ9VJ9lzR-9MlSwadZeHGdjHzz-Fgk7GYV8CtdIcgE9ns11MIOw>
    <xmx:iFMSZzoN7KqGC-Ux0xS5K0ufwBKPcxHFPwO8ngGc-0c8DMBnrn1fZc2u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 08:24:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e71c0679 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 18 Oct 2024 12:23:17 +0000 (UTC)
Date: Fri, 18 Oct 2024 14:24:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH v3 14/15] Documentation: add comparison of build systems
Message-ID: <bd59e31bb5585934ae364bd194a0213284d87026.1729254070.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729254070.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729254070.git.ps@pks.im>

We're contemplating whether to eventually replace our build systems with
a build system that is easier to use. Add a comparison of build systems
to our technical documentation as a baseline for discussion.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/Makefile                    |   1 +
 Documentation/technical/build-systems.txt | 224 ++++++++++++++++++++++
 2 files changed, 225 insertions(+)
 create mode 100644 Documentation/technical/build-systems.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 0f55baa252f..e23cffb5f9a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -111,6 +111,7 @@ TECH_DOCS += MyFirstObjectWalk
 TECH_DOCS += SubmittingPatches
 TECH_DOCS += ToolsForGit
 TECH_DOCS += technical/bitmap-format
+TECH_DOCS += technical/build-systems
 TECH_DOCS += technical/bundle-uri
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/long-running-process-protocol
diff --git a/Documentation/technical/build-systems.txt b/Documentation/technical/build-systems.txt
new file mode 100644
index 00000000000..d9dafb407c4
--- /dev/null
+++ b/Documentation/technical/build-systems.txt
@@ -0,0 +1,224 @@
+= Build Systems
+
+The build system is the primary way for both developers and system integrators
+to interact with the Git project. As such, being easy to use and extend for
+those who are not directly developing Git itself is just as important as other
+requirements we have on any potential build system.
+
+This document outlines the different requirements that we have for the build
+system and then compares available build systems using these criteria.
+
+== Requirements
+
+The following subsections present a list of requirements that we have for any
+potential build system. Sections are sorted by decreasing priority.
+
+=== Platform support
+
+The build system must have support for all of our platforms that we continually
+test against as outlined by our platform support policy. These platforms are:
+
+  - Linux
+  - Windows
+  - macOS
+
+Furthermore, the build system should have support for the following platforms
+that generally have somebody running test pipelines against regularly:
+
+  - AIX
+  - FreeBSD
+  - NetBSD
+  - NonStop
+  - OpenBSD
+
+The platforms which must be supported by the tool should be aligned with our
+[platform support policy](platform-support.txt).
+
+=== Auto-detection of supported features
+
+The build system must support auto-detection of features which are or aren't
+available on the current platform. Platform maintainers should not be required
+to manually configure the complete build.
+
+Auto-detection of the following items is considered to be important:
+
+  - Check for the existence of headers.
+  - Check for the existence of libraries.
+  - Check for the existence of exectuables.
+  - Check for the runtime behavior of specific functions.
+  - Check for specific link order requirements when multiple libraries are
+    involved.
+
+=== Ease of use
+
+The build system should be both easy to use and easy to extend. While this is
+naturally a subjective metric it is likely not controversial to say that some
+build systems are considerably harder to use than others.
+
+=== IDE support
+
+The build system should integrate with well-known IDEs. Well-known IDEs include:
+
+  - Microsoft Visual Studio
+  - Visual Studio Code
+  - Xcode
+
+There are four levels of support:
+
+  - Native integration into the IDE.
+  - Integration into the IDE via a plugin.
+  - Integration into the IDE via generating a project description with the build
+    system.
+  - No integration.
+
+Native integration is preferable, but integration via either a plugin or by
+generating a project description via the build system are considered feasible
+alternatives.
+
+Another important distinction is the level of integration. There are two
+features that one generally wants to have:
+
+  - Integration of build targets.
+  - Automatic setup of features like code completion with detected build
+    dependencies.
+
+The first bullet point is the bare minimum, but is not sufficient to be
+considered proper integration.
+
+=== Out-of-tree builds
+
+The build system should support out-of-tree builds. Out-of-tree builds allow a
+developer to configure multiple different build directories with different
+configuration, e.g. one "debug" build and one "release" build.
+
+=== Cross-platform builds
+
+The build system should support cross-platform builds, e.g. building for arm on
+an x86-64 host.
+
+=== Language support
+
+The following languages and toolchains are of relevance and should be supported
+by the build system:
+
+  - C: the primary compiled language used by Git, must be supported. Relevant
+    toolchains are GCC, Clang and MSVC.
+  - Rust: candidate as a second compiled lanugage, should be supported. Relevant
+    toolchains is the LLVM-based rustc.
+
+Built-in support for the respective languages is preferred over support that
+needs to be wired up manually to avoid unnecessary complexity. Native support
+includes the following features:
+
+  - Compiling objects.
+  - Dependency tracking.
+  - Detection of available features.
+  - Discovery of relevant toolchains.
+  - Linking libraries and executables.
+  - Templating placeholders in scripts.
+
+=== Test integration
+
+It should be possible to integrate tests into the build system such that it is
+possible to build and test Git within the build system. Features which are nice
+to have:
+
+  - Track build-time dependencies for respective tests. Unit tests have
+    different requirements than integration tests.
+  - Allow filtering of which tests to run.
+  - Allow running tests such that utilities like `test_pause` or `debug` work.
+
+== Comparison
+
+The following list of build systems are considered:
+
+- GNU Make
+- autoconf
+- CMake
+- Meson
+
+=== GNU Make
+
+- Platform support: ubitquitous on all platforms, but not well-integrated into Windows.
+- Auto-detection: no built-in support for auto-detection of features.
+- Ease of use: easy to use, but discovering available options is hard. Makefile
+  rules can quickly get out of hand once reaching a certain scope.
+- IDE support: execution of Makefile targets is supported by many IDEs
+- Out-of-tree builds: supported in theory, not wired up in practice.
+- Cross-platform builds: supported in theory, not wired up in practice.
+- Language support:
+  - C: Limited built-in support, many parts need to be wired up manually.
+  - Rust: No built-in support, needs to be wired up manually.
+- Test integration: partially supported, many parts need to be wired up
+  manually.
+
+=== autoconf
+
+- Platform support: ubiquitous on all platforms, but not well-integrated into Windows.
+- Auto-detection: supported.
+- Ease of use: easy to use, discovering available options is comparatively
+  easy. The autoconf syntax is prohibitively hard to extend though due to its
+  complex set of interacting files and the hard-to-understand M4 language.
+- IDE support: no integration into IDEs at generation time. The generated
+  Makefiles have the same level of support as GNU Make.
+- Out-of-tree builds: supported in theory, not wired up in practice.
+- Cross-platform builds: supported.
+- Language support:
+  - C: Limited built-in support, many parts need to be wired up manually.
+  - Rust: No built-in support, needs to be wired up manually.
+- Test integration: partially supported, many parts need to be wired up
+  manually.
+
+=== CMake
+
+- Platform support: not as extensive as GNU Make or autoconf, but all major
+  platforms are supported.
+  - AIX
+  - Cygwin
+  - FreeBSD
+  - Linux
+  - OpenBSD
+  - Solaris
+  - Windows
+  - macOS
+- Ease of use: easy to use, discovering available options is not always
+  trivial. The scripting language used by CMake is somewhat cumbersome to use,
+  but extending CMake build instructions is doable.
+- IDE support: natively integrated into Microsoft Visual Studio. Can generate
+  project descriptions for Xcode. An extension is available for Visual Studio
+  Code. Many other IDEs have plugins for CMake.
+- Out-of-tree builds: supported.
+- Cross-platform builds: supported.
+- Language support:
+  - C: Supported for GCC, Clang, MSVC and other toolchains.
+  - Rust: No built-in support, needs to be wired up manually.
+- Test integration: supported, even though test dependencies are a bit
+  cumbersome to use via "test fixtures". Interactive test runs are not
+  supported.
+
+=== Meson
+
+- Platform: not as extensive as GNU Make or autoconf, but all major platforms
+  and some smaller ones are supported.
+  - AIX
+  - Cygwin
+  - DragonflyBSD
+  - FreeBSD
+  - Haiku
+  - Linux
+  - NetBSD
+  - OpenBSD
+  - Solaris
+  - Windows
+  - macOS
+- Ease of use: easy to use, discovering available options is easy. The
+  scripting language is straight-forward to use.
+- IDE support: Supports generating build instructions for Xcode and Microsoft
+  Visual Studio, a plugin exists for Visual Studio Code.
+- Out-of-tree builds: supported.
+- Cross-platform builds: supported.
+- Language support:
+  - C: Supported for GCC, Clang, MSVC and other toolchains.
+  - Rust: Supported for rustc.
+- Test integration: supported. Interactive tests are supported starting with
+  Meson 1.5.0 via the `--interactive` flag.
-- 
2.47.0.72.gef8ce8f3d4.dirty

