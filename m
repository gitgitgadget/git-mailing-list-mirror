Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E898320CB9
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620755; cv=none; b=g6XfizlaIt0dRV8VLQMzjHb5tW/0SEhERJm29e41xYFdwF3h2eyvH1sB/gu1cqX+k46nL6BQp/a7OON44uhJ51vC7C8skCqvG3J8s+Hx/Bnqp2hQbbYXwAplLs25b2FzOgyygHiRRVG3mq18cGQD2KAErdj12FHRGNk91hdFqaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620755; c=relaxed/simple;
	bh=ywIVO4MX8XbZ0lMF2OgimNkQNv9xpx7Eepfc1pcr+4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=npSUmjZWOEf5NWDShwqqZBJHxpObfKjHn2KbnpLmke5H5fa2Mta+vaZ1yMGU7sphx9e7Fconspkemhlp0SdzYmQXJCtijrfU7dKdo4AeU7roFUcEZNxL6zfBHaiH01EXK/Hral5fApBJ8cbIIWZl4EVGLFrsC8yzaL/w3icc0wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GMR1rtsI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AfuDFKV2; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GMR1rtsI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AfuDFKV2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 488CB1D000DC;
	Tue, 23 Sep 2025 05:45:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 23 Sep 2025 05:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758620752;
	 x=1758707152; bh=rGqWQFas0lOhHARNKmY4+a8c0qd8w/brg2+jzT2l1SA=; b=
	GMR1rtsIlLfQX78CP4A4n15LtJlgWLvePupIySD37N0FT7XO1jEjNvthcuCagYLB
	eUl1ZNg7FY11H1iliDZjLQEbSq7an37ijbXmgK9GFWwD95zvrCy6p1UCseV2S7+X
	4V2U0wggMNUaXP8p3sACLna+s+YO1m2dihdjv1tIw8QM3lMWcs0Z/KVWoewxN3IY
	3aCf8Y9Ui5B+LocKD7+O+wqfE50wDpv1k5FSfhE0i/uZhGr3erg9sCC1IV1z7wpQ
	Xs7wOyAcG0xzlbSPdzhC5JAhy7d5lh+pZw7UObjNJL3mLx50n+CMr5Wctvv0lyd4
	mCglSD+2LSIc/QjPVoS4cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758620752; x=
	1758707152; bh=rGqWQFas0lOhHARNKmY4+a8c0qd8w/brg2+jzT2l1SA=; b=A
	fuDFKV2s0Adcz30D9tOWJsaBdWYrd8dllS9a3o9W4ZHzsCNvckcnhEiwX20PtxKr
	PuWFQB1kmRtPR4jvJVU0IkXrZ5WW9O2w/Hk5sePgt/dyAMiNkReoeL+7NXj/Nh/t
	rCaY39KaGIQwCVqpshzoHxakWvfxZmjKLrDI+Y4JQrUUAGm9xSAzo9oMa1RqG1eY
	6nMG/AYXXhMhszxb+auPCl71MlegPmVl90oX+Sh95yzkymQgxfsNxLkYtt/cz6fF
	gFMFyMQ67t+U6gS3GBv21y0ByH2HqRePBO+cppRJRLYRY31ZvggwTcxBWH9k212O
	5nIYM1lX6PDXSeAlCWGMA==
X-ME-Sender: <xms:UGzSaG0l7Yag663RD0A-y6dR_tO3pgRp2-hbQdGCCG6T88zUbGCQGg>
    <xme:UGzSaJhQv7xIU-IbkT-jZB2zhTcFOlgkfqLvHhkLELRRkF_-S7DV9WuX1IILUYRyZ
    JLZQItHkS56q-Ofh-2XSrf-5FYfPckYfVkxmktMaCyESrzp9fOb>
X-ME-Received: <xmr:UGzSaOpQ4bxDZTjVimEpD_CyIHyysYBwPJVgS3xg_2Gk6jwhfLUyEHzzKnXnPUe77IGJuFCmD4N8mnsbkAGaIqXkNnUx7y1EsoWqQzq_Nkwv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslh
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfees
    ghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtoheptggssedvheeisghithdrohhrghdprhgtphhtthhopegtohhnthgrtghtse
    hhrggtkhhtihhvihhsrdhmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:UGzSaEN_67Ta9rjO8wcNz0o6bNCxbD57SC3pSLjqRqEvQKMIU9jvEQ>
    <xmx:UGzSaC1sCiNq8y2KaghRyW1RnexRiyaSYiJCzG3WSONJZiBv6x3leg>
    <xmx:UGzSaKrcz7uVbQzJakZpsYVCIUG1wr58Abkrd3bcmhLoib_NOoSB6w>
    <xmx:UGzSaEc4y6SI1UUDj2C3jaIXLGzdPlNcN6pUI9M0SUL-MTCzZxj7ew>
    <xmx:UGzSaFvp58WhYSDTIt2vokBbA3hX6h-AjqTShgvWMh4eLBMIMMqhxEo3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 05:45:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d7442b73 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 09:45:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 23 Sep 2025 11:45:26 +0200
Subject: [PATCH v6 7/9] BreakingChanges: announce Rust becoming mandatory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-b4-pks-rust-breaking-change-v6-7-59076fee486a@pks.im>
References: <20250923-b4-pks-rust-breaking-change-v6-0-59076fee486a@pks.im>
In-Reply-To: <20250923-b4-pks-rust-breaking-change-v6-0-59076fee486a@pks.im>
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
index f8d2eba061..d249e604b5 100644
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
+in case they need to extend the life of that long-term release even further. In
+that case, the backporting process will be handled by these distributors, but
+the long-term release tags will be created in the canonical Git repository.
++
+We will evaluate the impact on downstream distributions before making Rust
+mandatory in Git 3.0. If we see that the impact on downstream distributions
+would be significant, we may decide to defer this breaking change to a
+subsequent minor release. This evaluation will also take into account our own
+learnings with how painful it is to keep Rust an optional component.
+
 === Removals
 
 * Support for grafting commits has long been superseded by git-replace(1).

-- 
2.51.0.536.g15c5d4f767.dirty

