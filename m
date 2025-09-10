Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA2A327A3A
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518583; cv=none; b=PbrB9Z4UXYlVvOwp9y880i/M7GQjUniQvcH8YjStG8qDfLwBFu+a3DuT5co2EXj4wW7JpXfXixDUjhg7SVsMGEEfnEmL3wel3Eagw+BBf/3oH9+L6OLuEMlL0CEiwdMeIBjXtjCWgl3Z4mV1mxNxvXysID3pg1p36UVIxGPyHZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518583; c=relaxed/simple;
	bh=B8uD/O/6LUwi5S+n+xfYyKuHp+6XsxN3i1iIkOKVpUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g8Av0tVZLMA/RDTyXFUxEzx6UOIN4kaZx+NqPwK5l0hYxV8XO7nYN6CVudkbr9SjdxtMpMZTqtNqQgAq5rn5QhihFc7+KJv0/uDQrPqsivVXiK8ZMsvZtLNmZBqHrf+2cq9MhZE6tJV0gH+NthrscuuYkCoq8pkIYQSgXNzUb1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M+pR+0Ad; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T+ZsZizq; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M+pR+0Ad";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T+ZsZizq"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 4A34BEC03C8;
	Wed, 10 Sep 2025 11:36:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 10 Sep 2025 11:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757518581;
	 x=1757604981; bh=fZey9yDSK/y5Nnol6wR1ndq3WnJKtHzBrhwp2j9qax0=; b=
	M+pR+0AdaI+rn7z8/Ev27pUkLeNi9r3YL2yKdGdnIJ6kX3RBDCFeGWnlAI55hC4c
	YJPQmRBpr7cZnZzck+0c4Sggq/LNOn/4sTKJTo8wKcSuuhHvvIJlV4VHKiJepDtt
	RXzRHcKBFAmQ1fur4kl3LLomw0BGEGF79DHbbuZU8KZY+B4gb6SnUbuGRw6k1x3+
	keDkCfg1jfPy9HNwLyLVLFXxlHKgQXzxiWar4BaEphPU9Mv670h5OPKoU8ysuyOJ
	j98gR/7k90NoUadHoqpQN+s1qlo27ikFyFHXv3lyebHBy0g+RO8U4r+gCzGMhZqR
	lKbrXo28E49tR7r282NMUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757518581; x=
	1757604981; bh=fZey9yDSK/y5Nnol6wR1ndq3WnJKtHzBrhwp2j9qax0=; b=T
	+ZsZizqu1IZ0xR7rwXqRpcTumJEQ9r55MWs7yUo2z5cgOR4jh4nmmKtsZ8/O0cek
	evDZvWGYQz1D/zk58XbtSATxAqTrIfpcXpg4AOLFa8csHsFyOo+oW+mh9FIlRoAW
	DyvsacOzh9dCHC0xKjio7ERmK31YxKV0QhhRPEwABGmY9mxk6wl7K8zm2tgMDniw
	Mc7ITUCH9G5SR/5pLUV1ECCa60E3IAkOvGMvTaAAurEAeP2tvfD4dWb3KGCr4vO9
	1sHhphra/eEmVwoMOA4yPlqSU0fB0X2WZdOcV+mPfoiySFx2OCxE0OEwVtwDHYbC
	RWsKQMD/XXI+uNinG7nTA==
X-ME-Sender: <xms:9ZrBaFJMJ7NTZHohsMuatvsksiJtj6IxHdLAtThOkchN10yqmGgOrA>
    <xme:9ZrBaBS8oFD21kvWxtvVtWv-9-ZuFECNw2wQgiVbdDSHQ9Hd3dOHogw-eo-Vh6Dmh
    DRnw0rxxaiCFfLAZg>
X-ME-Received: <xmr:9ZrBaFIhD_8qpD1wJVdnlWCXzex83rlJIqWw8twDZMZFQ7qJUEkjMpXtKvwYtfGWi4ZZu-8ecm7r4vQ--a0_aHv72_E_HhEKluGTogvG7L8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopegvii
    gvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrmhesghgv
    nhhtohhordhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghn
    thhoohdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvg
X-ME-Proxy: <xmx:9ZrBaM97v7GbEhV6vpIN3hOxeYSnQGkLgH4eeVlhwZ1AT8mLLsZcbA>
    <xmx:9ZrBaELV_neVE5nOA5wZq3-ZpTX7kUonyQAgkHCmKCht63n9JLMxVw>
    <xmx:9ZrBaDEeHXQqjtSoYWKgrr5EkanpenTlreOvxh2DH391L4ntB6wS4w>
    <xmx:9ZrBaAxUXCAGbg7LBR50QEBmcGZQ__xKqJj6XVrqL8UE-0UqHdE9_w>
    <xmx:9ZrBaMc2RiTfLwvgXOmAsMkQ-ko848jZ8IH5wHrhTZfA81TaDJQ98ny1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 11:36:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0ac7bfa7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 10 Sep 2025 15:36:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Sep 2025 17:35:53 +0200
Subject: [PATCH RFC v4 7/9] BreakingChanges: announce Rust becoming
 mandatory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-b4-pks-rust-breaking-change-v4-7-4a63fc69278d@pks.im>
References: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
In-Reply-To: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
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
 Documentation/BreakingChanges.adoc | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index f8d2eba061..3550e9fc27 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -165,6 +165,42 @@ A prerequisite for this change is that the ecosystem is ready to support the
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
+2. In Git 2.53, both build systems will default-enable support for Rust.
+   Consequently, builds will break by default if Rust is not available on the
+   build host. The use of Rust can still be explicitly disabled via build
+   flags.
+3. In Git 3.0, the build options will be removed and support for Rust is
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
2.51.0.450.g87641ccf93.dirty

