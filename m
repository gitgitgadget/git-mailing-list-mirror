Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6063E34A308
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 11:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073085; cv=none; b=KCLVoxNuhJWGHX79gvNstzAq/F7YvEsTARbcvPfwOmZQz8VchZwt6jX5vJ6+Qf5oOrXRKQ/iWFj7zeZa5go5KDBScfsG05gS4KvRQD45DUsvK+rMW6PA6G2JTCdUIZPdC4YukXuSdS0GZq3Twe9SHw3/yY4h+Y7dG7bAgEaw5cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073085; c=relaxed/simple;
	bh=wHJ9JC5WhxIxQ3aGw4D7qXIk9XAeph0TW1IJ3RCnR8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j5JFrAPMxK+XtZGz93Agw2ezAw93mc+RFNaMaFed2vxOC5cpG9RdGO2mC4npZre5R4fHmngPU5hdcqGsP8qYQk7LJqv6Gl5egRXoJ9BSibweznENm/bJWbXnjGCqJIjnZJBNul06jNPZ2IKylH31Z+DDt1plI1O0iXeQklZWdh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N4/aqrOR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LjGfyq6g; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N4/aqrOR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LjGfyq6g"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 175A97A0461;
	Fri,  5 Sep 2025 07:51:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 05 Sep 2025 07:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757073081;
	 x=1757159481; bh=nnMNZ1e9mnkc2TlrnB+/FeDXNIBU4UC1VtfBeQJPEFY=; b=
	N4/aqrORcN1p3UJLHEqIUEvV7RmzL0DXYQZ2lwT6gy6R8pO1CWmXgYg9YgI6Kxtj
	zKbwScp4geVWKsxMOC/wI1aJRgIDEzoobawKzECqO603KcqvJy+uVkyVgUhZvoOU
	fjmPsjiTz3q6hSUa0LJqNFSRptwlg5YX9mKw2zHCUKKTwN9KO06Ceh1dv+hxlM6r
	Siud6oInvN9h4iSJ0AMtRTrPk9imsP/uZ3Q3nAz63mzCMI3sifavzrY/tI2qEOYa
	tPvF3cJcdyup71TXJ2GCWIpHbiXCDs1FWtVv2Halw3PaYAzUDCo5jFNxV9DFzyAe
	stbdtYrJtaRwT3KMbHLKlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757073081; x=
	1757159481; bh=nnMNZ1e9mnkc2TlrnB+/FeDXNIBU4UC1VtfBeQJPEFY=; b=L
	jGfyq6gTDSPnjszImZRKVK9Z5lx0i/31pGZ0EbH15PPAewNaufYYTdLqEUBUXMNt
	uuremYm2TaRa+4dpS/DJedN84wo3lGZZu+eRQ01zvKTvYD9b9MiTpB3nNAjeuZV+
	1B8YdFt9O7Qanp1ZfvJKbfIUIY7dGwyPVBUVu+QLUupA1yjW3XGF4pmdNmmF6q6e
	F2VmZBqgoJbUJgwcM5Ipj7GmR7iO013jxu+VdzEEqF5+6mY0G7lSv9tWwPX6mp2q
	3SNJQT4/cW85fRm9Z9g0FAWK+VS5zXkSw/MSD+lIOOLqic7I1CJvQtoXTbkRhF8e
	wT7gZNxUC4WEd6uGvqYBQ==
X-ME-Sender: <xms:uc66aPQ36POxWBhoLzNRTtSkPGi-qZiEWaLR8Ljv_33pFv6_si6jyA>
    <xme:uc66aLIfSjBNCwZJiq7sNSZMRyLtBMMyv-pVjyi6ijHEIIl-EV9IGaXFwOXXbnenN
    JfSB8sxaFRZ6RcodA>
X-ME-Received: <xmr:uc66aK8K6GgVR2c3Z6tkVYLD2X1QWlzqGCRHtTMtFOQLqMGSmTjrIw6rrw3NsCZUVQC-RmQ2w56EaWJhf0ONZGZX0z1Isog1Lq87P_6HP1P6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhivghrrhgvqdgv
    mhhmrghnuhgvlhdrphgrthhrhiesvghmsggvtghoshhmrdgtohhmpdhrtghpthhtohepvg
    iivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhk
    nhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopegtohhnthgrtghtsehhrggtkh
    htihhvihhsrdhmvgdprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthht
    oheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstg
    hhfigrrhhtiiesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:uc66aKLqINti9LhY9NBbiakHIrCtXr2hHMdkHVaK9kuJd-3-uVOaKA>
    <xmx:uc66aBF4VD1iPnAXJ6i2Sa1jhIP0tRxv7qQJERJsiMv48qnWuuvTVw>
    <xmx:uc66aGzYLKKLv2v1qZnC2olX2et8YQjZEOpu2YI6RYNo2Ypy1m9dIQ>
    <xmx:uc66aC6e_OMMIXE_5hq7CKfhL5GBOBGU1Usb4B6uxHID-dVzOdFsEQ>
    <xmx:uc66aC16T7-BdYixyYgzQT0XOo1nVVYjMwkGzr6a-1mbEFYlIAKdxxi->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 07:51:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 79ad9ff5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 11:51:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 05 Sep 2025 13:51:01 +0200
Subject: [PATCH RFC v2 5/7] BreakingChanges: announce Rust becoming
 mandatory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-b4-pks-rust-breaking-change-v2-5-6939cbf4a0b8@pks.im>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
In-Reply-To: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
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

  - Some platforms haven't yet been able to implement a Rust toolchain,
    even though it is possible in theory.

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
index f8d2eba061..dbb15b6a57 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -165,6 +165,42 @@ A prerequisite for this change is that the ecosystem is ready to support the
 "reftable" format. Most importantly, alternative implementations of Git like
 JGit, libgit2 and Gitoxide need to support it.
 
+* Git will require Rust as a mandatory part of the build process. While Git
+  already started to adopt Rust in the Git 2.52, all parts written in Rust are
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
+1. Initially, with Git 2.52, support for Rust will be auto-detected by Rust and
+   disabled in our Makefile so that the project can sort out the initial
+   infrastructure.
+2. In Git 2.53, support for Rust will be made mandatory in case Git is compiled
+   with breaking changes. Breaking changes can be enabled for Meson by saying
+   `meson configure -Dbreaking_changes=true` and for Makefiles via `make
+   WITH_BREAKING_CHANGES=YesPlease`. It will still be possible to compile with
+   breaking changes, but explicitly disable Rust.
+3. In Git 2.54, both build systems will default-enable support for Rust so that
+   builds will break if Rust is not available on the build host. The use of Rust
+   can still be explicitly disabled via build flags.
+4. In Git 3.0, the build options will be removed and support for Rust is
+   mandatory.
++
+You can explicitly ask both Meson and our Makefile-based system to enable Rust
+by saying `meson configure -Drust=enabled` and `make WITH_RUST=YesPlease`,
+respectively.
++
+The Git project will declare the last version before Git 3.0 to be a long-term
+support release that is maintained until alternate Rust backends like gcc-rs are
+able to build Git. The Git project may need to rely on distributions to help
+with identifying and backporting important bugfixes.
+
 === Removals
 
 * Support for grafting commits has long been superseded by git-replace(1).

-- 
2.51.0.417.g1ba7204a04.dirty

