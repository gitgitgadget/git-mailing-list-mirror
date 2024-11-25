Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FC41A4AB3
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528656; cv=none; b=La3biU3Oj/KCgp11YW1JGjAw61KlwrsIowiU3uoKAPVhzMTlwrUUvot7K2Kg58goedgFxHqhFll4fnVa5XxpAZ+tNoqQitisgERTLAK1CK5eRHElOvuRt8YC5u8eGtl5VFi1KFTID/sWUioOBvaRQAAupRYmYrz3a9egX7IMs0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528656; c=relaxed/simple;
	bh=ZXi2mNQWTjyP2iuw+FuyGnrLp0y7oPQEVwIQN1dxbBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XALffpqDyVYuWd2mGzeVuCzoJjl96pMkZE7CVNd4eiIrAJuwz1uCq5bS6pTIuIe4R9IK8EVfTpq1CmYhyVrdvEb0nRc5pWzymomizfloSCODb6T0zq//06NI+jQMEykHtwQBC5vYH3wIxp/nc1qXBYDSUlcaQ3MQQ1VEyQ5MUXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mj5912YC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZGqqcWsP; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mj5912YC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZGqqcWsP"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 1480D1140175;
	Mon, 25 Nov 2024 04:57:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 25 Nov 2024 04:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732528651;
	 x=1732615051; bh=hEGHtkSdsZpiOhEiItBM8LzMH4uHdNu/5lm+NBr4wQk=; b=
	Mj5912YCK3RnukKGjtsNMMDMBwLpm0xAx3T28/ooX6r/md1BU8Ajy7C9uJOO0kZ1
	BwY3+GGMqZ3YuWr09vU0tpbgwHKXW6ycXZXqDdDrKjL+1R+0300CSyoAqhOKWCx7
	2pF/Oj3FDFfbySjC8XJCJ/kqX6QljmVda7gG3TmtZ6nAYD3SAdI0HHuMXIe2fv7C
	ihP72qEW6m4iazKnkH27ciZ8GTsxlUSYLGAjKOGrG3KOhJIMI1lSJzUnCIJmQeNs
	ZfeKXxghwNxy2Kr8cKQuOYPlX1UH6L940Ee1l33v4G3cstTy00B9O6YU+OCFnlLV
	d0NKX0DtxcV5CFOihUsjrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732528651; x=
	1732615051; bh=hEGHtkSdsZpiOhEiItBM8LzMH4uHdNu/5lm+NBr4wQk=; b=Z
	GqqcWsPdqb/KkwxOhH/anGA3rixVIy6RUaKUtQ0HitJWaaz+M/U8ao2Tq/NF5CMM
	wFwXBwECuT8PVGk+EZv5Z0zYh6oxakjjVyqgcFwVk4bVm9oZ+txoYQaj8TQ7PwAI
	dm9kGl6pQbg33B+HpzwyQJ6gXu0CXf5NxZjChvnKXX5m7ImlrVf6yxfKSMQIn3lN
	ftwD1gGRPnceyoWsJyihs3smG1DuMYzUcCgmA+V4y0gddgwB3fSXgwQs3S0lAjhP
	At204SLGrBgNUbyRiC87X67+dZl2KcLfJCwc4BFHjVidjNCSdEujKaVnTS2ta+MS
	IJhqHtG7kZhXxQ6zyr5Bw==
X-ME-Sender: <xms:C0pEZ807q8GMmw7aklFk5WR1fNMTb745QqXzywUJK1g_dBBLq8T4zw>
    <xme:C0pEZ3HAlHwTVq20riFws2R2S0VDkVKV3CpTkHSBpmHVs_P98fWpg7IIBSWezpa7c
    mT2iFoLa2ui4zq4rw>
X-ME-Received: <xmr:C0pEZ07Oxw3E_QGYzCjEmw6HAbSos82DCbF1TpymBP7zVf-RBpHoxVmMcgAjy4SqzVbwTImocOeh9nipRDBrGaj814i3SbrmQRSlA03J0Ypj_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveejhedtudfggfefleffveekveefhedvkefhgfdvtefg
    jeelhfduhfdtgeeghedvnecuffhomhgrihhnpehtgihtrdgruhhtohenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhih
    hllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhif
    rghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopegthhhrihhstghoohhlsehtuh
    igfhgrmhhilhihrdhorhhgpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhl
    uhhsrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:C0pEZ11XOHoQBTIENI3IacHu5asYqG8LK0D8dSEcUQYWg2RIhvlxiw>
    <xmx:C0pEZ_GEehTFirotg4-ZcYukC7nVnztfYp5myLvykU_yMcPNt16tQw>
    <xmx:C0pEZ--8rdhSrepr4f8L2HfSixwEjT4SJGOG2qTT02vgyMWdxpAgIQ>
    <xmx:C0pEZ0m9qTqUeKfySGbpFGUr8VpDtodTdph1QWGt8PFmInLT1IvsqQ>
    <xmx:C0pEZ2_peNpgjDFpl1fJ7lgv5e11akjjdR5sJY2OKZzh_J1V1AQFUsUh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 04:57:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ea04844e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 09:56:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 10:57:09 +0100
Subject: [PATCH v9 21/23] Documentation: add comparison of build systems
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-meson-v9-21-1c6cf242a5f1@pks.im>
References: <20241125-pks-meson-v9-0-1c6cf242a5f1@pks.im>
In-Reply-To: <20241125-pks-meson-v9-0-1c6cf242a5f1@pks.im>
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
2.47.0.274.g962d0b743d.dirty

