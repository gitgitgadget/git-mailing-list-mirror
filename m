Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D70430CDBB
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340823; cv=none; b=BrQwdE8rz2SDFkU0txV/PSsrPkAJLY87QHd4qVu1aHj/yhKUEjiyMgZI9zlj9mWa64GqhQs2CywI4LQZ1+N0g+PkOWjI+W3/9zMJD4FGsjToSW8SGnIOSp+mzg5egVgTHa3pr4ZfdFSEJhj73HWQE3R2De6/q0uHCJvbmvYMXro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340823; c=relaxed/simple;
	bh=EABaLnV+4z1CKHZSaieeif0oUWVjbWUfalMmrE9PQJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ev+GkIZ1mSH38tHzpmobI3v1f6FaRSseYrOOCiFz1fTL19+l03Do6ion6d1UJV9vqh2YKQCXeYE1rIBNtjf9IAn+sADt8lzAtrdb1ypcgV664zts+VTIFPUjCOPfA2w9a86fnxIWIbB2Pgr16HmMqRXy4og0KYpDId43x2USO64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B9sgGJyl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O6AwcZYu; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B9sgGJyl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O6AwcZYu"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C037A14000D5;
	Mon,  8 Sep 2025 10:13:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 08 Sep 2025 10:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757340820;
	 x=1757427220; bh=5GFoMq35n/OiRhoMgVUjba1SNodOIuHJhbKunX2irtA=; b=
	B9sgGJylZKwXKUFbVXkHasvQupUfOe5+1iZOAMQEyiV8aihF0kB4wsHsw90vb6e2
	M7t9K/w0ZNqr4wzQdwEBd8/t14hiQrmvnnMuV4vIcZfLKcdcRO9FIW3+N2gK8lXn
	8Y/F2Hsbo7/+jksIIplaBJ7yoozeIZAl1ZmGQ4c7fxHclbQ4YXxJbGizbOvqRnT3
	1EPAlZxBGUEnsCIhtrR7AsCyOMHePoxCVEbkMJvK9A0ilj/6gR0RTgsl3VdXul9W
	tkDZlImjmPOekEcD/rkn8JsPV6Bk/50q0FjlMT2ya38CxuxgsJcy7xHd8nOXiqlr
	EJu2HE7+L+g95YsXf4eMBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757340820; x=
	1757427220; bh=5GFoMq35n/OiRhoMgVUjba1SNodOIuHJhbKunX2irtA=; b=O
	6AwcZYuSeBHWhVj40hpFUhurFhfv/o7u2ISLRxi5UTOO72R/+BrNV0JgL/3ZXNSU
	4Bp8FH+kz4Su+Bhmu06n0UkqC7b4acBuhDDXAgccYAP/pl7CYxJ5HlDt0ih0IGgw
	BSuacvu8rP/w9aTo8Vp9HIvoDB/QVtl18lzvbA0i4uNjij2kvWteZ434GZ5gYpZ2
	uEOXA74ewHh0cy+BziSfkI6zs1L/6Mg3CKbfNncQanSSTVJ7fiwHi132RzonAWQx
	JBpaTZPaYDEhi7g9WDazCCA1JwRTBzh17Le361J92CDOTPF1QYywvG7at90usYqq
	EEO8geXwhP60K3CZcYsyg==
X-ME-Sender: <xms:lOS-aAagXVO6d1pkhgwY-ybTlwTqHB5kIKqClyvOZPAwwS6qk46h6A>
    <xme:lOS-aLgX5phHIHykOAR7RKc59115tyrNuEEvm7j5kThSh5Vy5Zn52M4UFPkgqz0uC
    8Xe1jsY2v-PBf8QVQ>
X-ME-Received: <xmr:lOS-aCZ-HMiEHG4abiUff0dgrGvYlEdvnodhb1ne-ww719e7nerl5-4Gxycapg_DbVTScsC6JPl-gjruzW2ir3ojNcgews_7gI8xg9M9yzPk1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghh
    ihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepphhivghrrhgvqdgvmhhmrghnuh
    gvlhdrphgrthhrhiesvghmsggvtghoshhmrdgtohhmpdhrtghpthhtohepmhgvsehtthgr
    hihlohhrrhdrtghomhdprhgtphhtthhopehsrghmsehgvghnthhoohdrohhrghdprhgtph
    htthhopegtohhnthgrtghtsehhrggtkhhtihhvihhsrdhmvgdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvg
    hnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:lOS-aBN6RrmkRX47UUGnE4HpePZzuUDpsYTzyXnq_m8usrXRbrGtog>
    <xmx:lOS-aDYwmlNxfWvKmJrw9kOVq_Z5EzdDtZkwLS-UPA9v9_SxDttc3A>
    <xmx:lOS-aBUQ6vlE4E7uk5keqqwAUKqgvauNunZC8v2Jqvxf1een27eVOw>
    <xmx:lOS-aCAqIvDL7RpSD35rx2oNIIXqK-MK9RLrG-jp57sD4Jgn_UvYhw>
    <xmx:lOS-aItsv639j2hMlT-yz1mAGRvbysZW6-mnNvHaCEiPWJF69rhj1A_R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 10:13:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id feb97dc5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 14:13:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Sep 2025 16:13:13 +0200
Subject: [PATCH RFC v3 6/8] BreakingChanges: announce Rust becoming
 mandatory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-b4-pks-rust-breaking-change-v3-6-1cd7189fed3b@pks.im>
References: <20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im>
In-Reply-To: <20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im>
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
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.2

Over the last couple of years the appetite for bringin Rust into the
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
 Documentation/BreakingChanges.adoc | 41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index f8d2eba061..b6ae2241f8 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -165,6 +165,47 @@ A prerequisite for this change is that the ecosystem is ready to support the
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
+1. Initially, with Git 2.52, support for Rust will be auto-detected by Meson and
+   disabled in our Makefile so that the project can sort out the initial
+   infrastructure.
+2. In Git 2.53, support for Rust will be enabled by default in case Git is
+   compiled with breaking changes. Breaking changes can be enabled for Meson by
+   saying `meson configure -Dbreaking_changes=true` and for Makefile-based
+   builds via `make WITH_BREAKING_CHANGES=YesPlease`. It will still be possible
+   to compile with breaking changes, but explicitly disable Rust.
+3. In Git 2.54, both build systems will default-enable support for Rust even
+   when breaking changes aren't enabled. Consequently, builds will break by
+   default if Rust is not available on the build host. The use of Rust can still
+   be explicitly disabled via build flags.
+4. In Git 3.0, the build options will be removed and support for Rust is
+   mandatory.
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
2.51.0.417.g1ba7204a04.dirty

