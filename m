Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50221C3027
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810364; cv=none; b=qx/SkOu/6n0QMMc/j6MFuED0yZiAixqbJBDpnCdEYZjGq0XEsWQDvKrOu99Qb/n1a7IETC1YYkp1m9AZG/RcSLpms3tPfe/RepaeuRWJO4wud0aSC4PQuA3YJiIDhN+DyqwgeozvBgozjIkH74Um21Qb/3GO92wcdbF7SCjXuOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810364; c=relaxed/simple;
	bh=KSFnxzPsxoTLx1ciEsQmtyJlbRxZOmC52C95SqhcRzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y6o4+8LqnVTFzhbREhHTFLzSk63v63WJixFgW5m+1x3cssSO7lc6Lhe6GBJkPv5saQC0Q73YfXx8uA7B7Xy12o9QQUQhQeZvBNi1G4wj/xTNqDdfR8T3ky3andUR76ktyK0gvU2fTOv4Kh39wGnkEVqfhv0Q+0IWa4D9FzxKXVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kL5d83iH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HCxK6dSN; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kL5d83iH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HCxK6dSN"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F1001140147;
	Thu, 28 Nov 2024 11:12:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 28 Nov 2024 11:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732810362;
	 x=1732896762; bh=rGJY59pkYk/u2ixcBS9MGb9HbW+5myDq1XErNzPIb+k=; b=
	kL5d83iHUiQcYlHlac/jsZAhZd/iamId1A6R97WphnPqdVogDGeSxDtAE2PF2kTZ
	9tD3viqv88dGY/Jz6LySRB4uVUUlPNl5/j29Igz/9fgqTlPHJ4wB5K9VBzl2AiAD
	FN5CRpqsD3dUlHiuYbn6vyrdlELUXPu04P/8jSEj5w8su/0JYDX9d3NT+Ki5/cbq
	jkvpbezsjhIGCdQRhr8oDVr7tmkx4wwbl7nSfU9jNXSrHFZYFdQQal8OUCmuabgC
	orOp8tri0GMzE5g3YYnhUFgJF2FVqSsuUhodsvgldusu6miALzM2rpafEEu63V1d
	Am5dIVAj1l1+2wzobbWq3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732810362; x=
	1732896762; bh=rGJY59pkYk/u2ixcBS9MGb9HbW+5myDq1XErNzPIb+k=; b=H
	CxK6dSNgFdIONUJj6Ph+KYZ4xRLT9lR1l62Y2BLwiTRn/qNwBiH4Dfig35iftiKa
	k7tmqDXD41lZlbcKeykowaTx9wkoNNJotcCXhlMKuNWjJ714zqE8W057/uDQm7Q1
	1S2mrgCGfbjZy9r2gFTryNmMrGw3ApxvTSTqNbLUF60/nCacD4Od5PzzG034PtD4
	2nHcms+DRHIbSBnt7r5LVBS2TknOxhOItW9s1/1WFPW05sRXezuX6tDdATiJeKvd
	Hyg7npHfptM4BTFgvW5ZXpvNt/hp/VOaOW6FKVZ3K5LmBDBvebFN7beczFNBM1Za
	ZLQSvbkdIaAA3g/jUvnHw==
X-ME-Sender: <xms:eZZIZ-08UMy2YI4DY-dqr20_ID1sJsJ_BOqPGfi8j7u6tqs8atZyHQ>
    <xme:eZZIZxH7WA2f8D_EroAijV7wYBUMkmkBCOvJhT6036VsqG3t4Ol19Mokvu55eqm46
    BM6yD_6XU76iI4duA>
X-ME-Received: <xmr:eZZIZ26EgMl78ag_5FJbcBXHFeSGaKT_9pYVvZfgtsPQ5iyFmB2csY1ZySU5TbT892qp1f5DzwKEWgHbg-f3KUJug-i57AoDCArOlQbjq8krXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveejhedtudfggfefleffveekveefhedvkefhgfdvtefg
    jeelhfduhfdtgeeghedvnecuffhomhgrihhnpehtgihtrdgruhhtohenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjheith
    eskhgusghgrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvg
    esshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluh
    hsrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhr
    ghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:eZZIZ_2i_gBMy4bcui7pG4kp14AawZCqapLORiLuOUxWjBX5-mvgPQ>
    <xmx:eZZIZxF4WhZMraycywlg78kc8dQPwC4thsLyatticCVCdU1lRNP9Ag>
    <xmx:eZZIZ48B97ol3BjsK_v2A2BfUpn1za7itARJhx1ani47c2h1JfVkFA>
    <xmx:eZZIZ2m1A2uAZskUF2qd8_fzuYseCY5lIeDD04XWjH8OFDK-S-PjAw>
    <xmx:epZIZw-WHPofFIjNRRrM9TgRoJKAm--UsDfM3YyfYAMwi_VFXZbF-ivg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 11:12:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a9f7aabc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Nov 2024 16:11:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 28 Nov 2024 17:12:22 +0100
Subject: [PATCH v10 21/23] Documentation: add comparison of build systems
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-pks-meson-v10-21-79a3fb0cb3a6@pks.im>
References: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>
In-Reply-To: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Johannes Sixt <j6t@kdbg.org>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

We're contemplating whether to eventually replace our build systems with
a build system that is easier to use. Add a comparison of build systems
to our technical documentation as a baseline for discussion.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/Makefile                    |   1 +
 Documentation/technical/build-systems.txt | 224 ++++++++++++++++++++++++++++++
 2 files changed, 225 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d19ee3c399f337ea9ac7c9a1b595ac760ebed095..d18603ed50c654f1c7f2ef44140a00840557747e 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -113,6 +113,7 @@ TECH_DOCS += MyFirstObjectWalk
 TECH_DOCS += SubmittingPatches
 TECH_DOCS += ToolsForGit
 TECH_DOCS += technical/bitmap-format
+TECH_DOCS += technical/build-systems
 TECH_DOCS += technical/bundle-uri
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/long-running-process-protocol
diff --git a/Documentation/technical/build-systems.txt b/Documentation/technical/build-systems.txt
new file mode 100644
index 0000000000000000000000000000000000000000..d9dafb407c40902756ca0bde9d9dad8ced8788dd
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
2.47.0.366.g5daf58cba8.dirty

