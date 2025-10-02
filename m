Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DB2846F
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759390260; cv=none; b=UuiX45v3cGCmFJrPFZ+RbqDcoZOklbFXoF5BeW4oFS3KyoFrGtepE9RVmpic07AO+v6rJL5xyvO8JhOH/lwwy3B/engkZD8F37otdGS/sqmgIzniMoA598vhdEpgBmUm3pxyQTW/SnbVy3yaNstChk24jdZNLdnISCt5XcmUIOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759390260; c=relaxed/simple;
	bh=2zUPvUjOBkJBiacLbtsmLHCLPSkSYmLIDXPUR0d7iZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GVA0FBmI/30lbKgjtFGtvkLZ18tdNS5h31Xun9Omtb2uf9EmHqlDPkIw2vscOI7O8hvEZrycIaBDpd7eeKGwMa3B7GDjYLtoKtuPVAAlBcNAOvP2CmSPJUaoqMzTv9R2wRH2e6u8yjNHSQ3ru/iiJYVK7Zl2ZWRkLiNQQpn5XSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZFQyCem5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iASeb4eK; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZFQyCem5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iASeb4eK"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 499277A0146;
	Thu,  2 Oct 2025 03:30:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 02 Oct 2025 03:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759390257;
	 x=1759476657; bh=30EZAzueJlFe76QwGpQ/CZunhr5dqqJt31OAEy49Liw=; b=
	ZFQyCem5kHyQfy2N7HFUJyH1mm+aVv/q5cGam75jI2T9OvEDXDS8v1T1tCWuZV0N
	JgpV3ZD9ziybLpJPB2/Aa3eGSZSW5uatdpaT4sjsjqZ7Rp8zNjGcNzwus5ZA4OnG
	w8n0ZBD5hvj03t/sK/BAAFsfRLKdyBJVw5ImEgmOy6w2MRj9FHz3w389kZzVr1QY
	/ZiUW4ZxzZC44jDNMjUsCdiJQP5tWHoEQIl2jfWxQXm5M+uBYxrYiQzQV3T7xffe
	29a1SFq+uCdo47Re94kX/HlJBqxBCBbjqgLTtKkXF9GDEO0X5lgJ3BqWUzugNpmK
	t7Z0lIe8Tx/EwbRcw81FpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759390257; x=
	1759476657; bh=30EZAzueJlFe76QwGpQ/CZunhr5dqqJt31OAEy49Liw=; b=i
	ASeb4eKfKjF3FF0yUY5LIhQISj7KrdYY661WnZZhGP0iRT/P7bXYsYvJB5oZyznd
	/YLuexF+tKSEZeHXhv7Aw8vgpIbtH3s5uzSKrZlPAqQQNqpRBb/nVjs+ISMCSsMq
	7jkwWcvsDuqxbgARqtAxVlyTo4ubTW/98rP+5lj0evfYB5et8IAu39bqAIarRz/Y
	I0vTyYoNZXKAGb3z72VwU2AZw8l3nZoTQzPz9tW7i1Rf8IXw2P1mc9eeaRWKiZm0
	LQp0pf+iGzK+kkuJQFhs4aWDBnTYhyBH2GOX9TFOErBmd+VA7+0JjRqN/VTPvF6t
	1VYNIKQ0V25XxRthu/qaA==
X-ME-Sender: <xms:MCreaOWu779DPjg2_ZNJOlztJf1JxI_prdjk4W6HO5rtZx9oI3r-pw>
    <xme:MCreaLCo9RT9m1K2GaWyKMNX4pyC7UdAg_rFC6h8MDn4yCITGqz2Rm6wXyic5iADc
    GH3yf2eJ9remDFN5OHNcbzvJ-Ua5cy19nLFp2iR6kcKmVu2h9zKvxQ>
X-ME-Received: <xmr:MCreaCJjSiWoytdMf-1LSVRNRHnMDnbnO30i0d4e3jur39ct5GFtp8pF1vvIEihO_fOis9hRhBVE7sGXIwc-w68YofijOjTfcDgaKMEikg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopegtohhnthgrtghtsehhrggtkhhtihhvihhsrdhmvgdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrh
    htiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhg
    pdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:MCreaBuRputop9jdUaL094mfT8Zj2ItWHkQYxHsiTzp2iKJpPS3JRA>
    <xmx:MCreaCUV2UVfZ1r-EHiv9PY6_8rDCT1_ShlgqJ3icCL8JbgKxjf7tA>
    <xmx:MCreaEKePA62Jr-SJrrZCk6v5t4u9F_A1YysZ5u8D_ETuv5dFo2FZQ>
    <xmx:MCreaP81KLsWg8ESm1XfgLac2RpTo_FH-DPVpgsCKtnbSyrODBhY1Q>
    <xmx:MSreaFNz_W2rm3Q45kIvIMMHHwIOZ0xEx86C4WDblesgEPriXnEX5hyb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 03:30:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bb44afac (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 07:30:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Oct 2025 09:29:32 +0200
Subject: [PATCH v8 7/9] BreakingChanges: announce Rust becoming mandatory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-b4-pks-rust-breaking-change-v8-7-3a89fd5b1ce7@pks.im>
References: <20251002-b4-pks-rust-breaking-change-v8-0-3a89fd5b1ce7@pks.im>
In-Reply-To: <20251002-b4-pks-rust-breaking-change-v8-0-3a89fd5b1ce7@pks.im>
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
 Documentation/BreakingChanges.adoc | 45 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index f8d2eba061..c21f902134 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -165,6 +165,51 @@ A prerequisite for this change is that the ecosystem is ready to support the
 "reftable" format. Most importantly, alternative implementations of Git like
 JGit, libgit2 and Gitoxide need to support it.
 
+* Git will require Rust as a mandatory part of the build process. While Git
+  already started to adopt Rust in Git 2.49, all parts written in Rust are
+  optional for the time being. This includes:
++
+  ** The Rust wrapper around libgit.a that is part of "contrib/" and which has
+     been introduced in Git 2.49.
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
+in case they need to extend the life of that long-term release even further.
+Details of how this long-term release will be handed over to the community will
+be discussed once the Git project decides to stop officially supporting it.
++
+We will evaluate the impact on downstream distributions before making Rust
+mandatory in Git 3.0. If we see that the impact on downstream distributions
+would be significant, we may decide to defer this change to a subsequent minor
+release. This evaluation will also take into account our own experience with
+how painful it is to keep Rust an optional component.
+
 === Removals
 
 * Support for grafting commits has long been superseded by git-replace(1).

-- 
2.51.0.700.g236ee7b076.dirty

