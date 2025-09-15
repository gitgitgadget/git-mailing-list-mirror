Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC622FF157
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 11:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935411; cv=none; b=KeGLUqozmXXS5tfTbSzVAhQIuzf6u9wpt8TPzXWxKDokfv8eugJYIOfBAo3QWOXu67CojW57vktHQ/jRkQCtP+IaeZA0RReAYmz+959YMbRGZcOeJl4j15dYjJC/lKZJ/60c3U6NUfet8U3NO0ARXkJ5CKwUMaz8TC3UvZJYufg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935411; c=relaxed/simple;
	bh=3t24RFtZ+OSaMbOvrFxrX5E9EfisKetQ/N5arM78pU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Po9iC/a9n1k22143Ri3LZrynjJ2qxs+jlEl4hApV86Ajo1MQCkn1Dxu0GiEFtvTj/qbRajfqeGErKpovFLGAxVG/IknS6kjeqFwdh1GZ07v2OMP7fX6MrsV3oBTOPa7PxNSQNIlZQDGz7Q79wOVyLwrFw9HNTFjpbxKXWKwwFXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QpCdVc6U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WP8SUQ2Z; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QpCdVc6U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WP8SUQ2Z"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 72702EC02D0;
	Mon, 15 Sep 2025 07:23:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 15 Sep 2025 07:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757935408;
	 x=1758021808; bh=JM0M7eWMfpcHHEwqCBM8JzjsY7c6NNmYqAqCqshToDM=; b=
	QpCdVc6UsQ7k2H7o7EOhm2I+ESqqpY0o4QGRM/TlneGib4Raf3WFbZGBsngAdvj3
	jIG3G/2MDdMPcvnucDt2wF/Yt/sC9lIZd0xsIcvYACh4+OjiDwJjxOVKr5DRsFyX
	/o0jV6A84KaQafMcJUpar0r4TCPku2VMj2C14N6fdzsqoRqLXMOxliSYNfjx/fHx
	DOJ7En41SdpAiKvjNWy9N1nmCxfD7GgREfTacAcqK9jyiHi9XO/jZ8ljmBYIwgK0
	Rx5swO8LXUl2EdFqkL4ksGHcevM9zuI0Z3IZgkZBf+K/Nequ/TMjgz0LWDN3Rk8/
	RVkeSeWtWJeKvpDo0UzpNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757935408; x=
	1758021808; bh=JM0M7eWMfpcHHEwqCBM8JzjsY7c6NNmYqAqCqshToDM=; b=W
	P8SUQ2ZZcplDBsroVHVtCHkZaeI2uPUy+8IOxHlN0kVEBVI454By3mfGoQ28kcOi
	wz0AdZv5gyWd9gJiSIqIb8XkZ7aWfLu8neDTc+BORcfij+YPuwinHvRBc05vQnNX
	XnU5WUlx3rRiAZzTz+oAWwukyTxon7xNDMMNhlX9FXQEmAJS0R/mLHMIFxEWt4sm
	2mmZf/X6mfRyeA9j4x+obhtr2TJhGWb5K9WbsZ5SZKC/6V3ycqj2f/2DbZQzuEgV
	5yrvPzxM0bxJTnkZ5glgsw5ZznJOjOnK6EDG3tbQ16bbrgl3fDDkI35HbSpUno4H
	451opU59OCvYaRVp8rEVg==
X-ME-Sender: <xms:MPfHaEx6M5VppVM1qYNONF70tzc2G2O--pQ86ISjmNBhlewtOMdOcA>
    <xme:MPfHaP0pbcNCjZO5aasRW-gGe9TT8ZrGUoAkLG8EkMQTpY9DL2nWCue5n5p9_h60p
    A5mIc250oijHrZvLA>
X-ME-Received: <xmr:MPfHaF85G3-9zXZ6oOCrxIc9kVuOgyuSpXgzOVQLaXGolMmkGF6MrfCgDRrtRbgDuhaHbjtuWhIoaemfGzzhuf1lJ1NUCv6njw5_BDo0DSTnow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthho
    pegtohhnthgrtghtsehhrggtkhhtihhvihhsrdhmvgdprhgtphhtthhopegvshgthhifrg
    hrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehsrghmsehgvghnthhoohdrohhr
    ghdprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:MPfHaPQmao0E2xhckLuAUUGWAloTl7R5G_TbiBrHCMgNt0-hrLMbcw>
    <xmx:MPfHaMlVcyrQpl2bWs8LKJOVZFMmwV_yDqJJvktS4Z05cxccKmuhNg>
    <xmx:MPfHaKVaAPXof5mLqxBg7ZnhkK8JetI9gQNODtH5iYU3kU1ixuAiZA>
    <xmx:MPfHaBfyrr7EPWBi9WFsTMM_GR2qecUndBJ-cOblPxOGdCb1UfBJuQ>
    <xmx:MPfHaL9W0nij_49Of5ytk700HonUK_fBHbXASfokEhzliR6dnu86njqX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 07:23:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 80ff0b42 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 11:23:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Sep 2025 13:22:54 +0200
Subject: [PATCH v5 7/9] BreakingChanges: announce Rust becoming mandatory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-b4-pks-rust-breaking-change-v5-7-dc3a32fbb216@pks.im>
References: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
In-Reply-To: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
To: git@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>, 
 Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
 Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, 
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

Over the last couple of years the appetite for bringing Rust into the
codebase has grown significantly across the developer base. Introducing
Rust is a major change though and has ramifications for the whole
ecosystem:

  - Some platforms have a Rust toolchain available, but have not yet
    integrated it into their build infrastructure.

  - Some platforms don't have any support for Rust at all.

  - Some platforms may have to figure out how to fit Rust into their
    bootstrapping sequence.

Due to this, and given that Git is a critical piece of infrastructure
for the whole industry, we cannot just introduce such a heavyweight
dependency without doing our due diligence.

Instead, preceding commits have introduced a test balloon into our build
infrastructure that convert one tiny subsystem to use Rust. For now,
using Rust to build that subsystem is entirely optional -- if no Rust
support is available, we continue to use the C implementation. This test
balloon has the intention to give distributions time and let them ease
into our adoption of Rust.

Having multiple implementations of the same subsystem is not sustainable
though, and the plan is to eventually be able to use Rust freely all
across our codebase. As such, there is the intent to make Rust become a
mandatory part of our build process.

Add an announcement to our breaking changes that Rust will become
mandatory in Git 3.0. A (very careful and non-binding) estimate might be
that this major release might be released in the second half of next
year, which should give distributors enough time to prepare for the
change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/BreakingChanges.adoc | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index f8d2eba061..0512411030 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -165,6 +165,44 @@ A prerequisite for this change is that the ecosystem is ready to support the
 "reftable" format. Most importantly, alternative implementations of Git like
 JGit, libgit2 and Gitoxide need to support it.
 
+* Git will require Rust as a mandatory part of the build process. While Git
+  already started to adopt Rust in Git 2.52, all parts written in Rust are
+  optional for the time being. This includes:
++
+  ** Subsystems that have an alternative implementation in Rust to test
+     interoperability between our C and Rust codebase.
+  ** Newly written features that are not mission critical for a fully functional
+     Git client.
++
+These changes are meant as test balloons to allow distributors of Git to prepare
+for Rust becoming a mandatory part of the build process. There will be multiple
+milestones for the introduction of Rust:
++
+--
+1. Initially, with Git 2.52, support for Rust will be auto-detected by Meson and
+   disabled in our Makefile so that the project can sort out the initial
+   infrastructure.
+2. In Git 2.53, both build systems will default-enable support for Rust.
+   Consequently, builds will break by default if Rust is not available on the
+   build host. The use of Rust can still be explicitly disabled via build
+   flags.
+3. In Git 3.0, the build options will be removed and support for Rust is
+   mandatory.
+--
++
+You can explicitly ask both Meson and our Makefile-based system to enable Rust
+by saying `meson configure -Drust=enabled` and `make WITH_RUST=YesPlease`,
+respectively.
++
+The Git project will declare the last version before Git 3.0 to be a long-term
+support release. This long-term release will receive important bug fixes for at
+least four release cycles and security fixes for six release cycles. The Git
+project will hand over maintainership of the long-term release to distributors
+in case they need to extend the life of that long-term release even further. In
+that case, the backporting process will be handled by these distributors, but
+the backported patches will be reviewed on the mailing list and pulled in by the
+Git maintainer.
+
 === Removals
 
 * Support for grafting commits has long been superseded by git-replace(1).

-- 
2.51.0.450.g87641ccf93.dirty

