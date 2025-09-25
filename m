Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8C12F6173
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 06:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781844; cv=none; b=Lv9jT6LteM0onq6aJa4J5ZC5oOJrI7/dEgRQpRhKy/vKMfV7fJ9rBmFZXIWFIfuWPjhu212K4lYlzPVRcAM3J+ussxLXlHhjBwSwZQACRlGSgnIb0An9YJJFQpe3GCmT3hU7hcdxGVZuQlLNJWYx+hGOUF8rhSPPxT/b3llGP3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781844; c=relaxed/simple;
	bh=GChFZPek48zlnsZJ/Lcqooz40ciMi9Bz1pPDl+Nvk48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cqRdh3zOqzFqVZSXxm8AJHPUC2vnQs8/SHeVgSRTiuVpdvBJeYqzlTIF5Fvqxmc6o7ZRzoYbcvT4gqY8E0VxcCUIYv1RxFibMqACvITcTvOG8+TKqXhKU9xWlYg5FK37615XSH99QpJ+zbYo4Wjnklz9AUEm/kLSnEUXRfSTiUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GQNcS0IP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WYhZLHK4; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GQNcS0IP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WYhZLHK4"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 44D0E7A0146;
	Thu, 25 Sep 2025 02:30:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 25 Sep 2025 02:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758781841;
	 x=1758868241; bh=zOyauCcZWQHljVVYvbb6mJMojgX35aeGr5IIRjaeM00=; b=
	GQNcS0IPOSKu7B17WSg2/ihF1KCwRzKS3kna+mTwP7wE+dsQo6Vg0h25cgpf+FDL
	zrVX7QQQaYPVWR6v4dkz+9Hm9IXGKFv4mJm/KSUTjPFPnuZ6+vrtOCIaDFwXRylG
	pfDPVZM6TWBGFQ6u+B8ojLyOos+aWeUSgSYaeCCN6OIYj3og8c4ZW4WE24uQFbF8
	nGFN5mqky8SbXtDoqfKjDp+35BRMt5xajmD2rx7jwCazk7fCZ+2a0beeyW9xF3bM
	pYlgl8AfwRW6D6Gd3K5P7I/1/U7b3bo5nPtySpoDOU2ClhjVduFkpJpb02LxXXW/
	ezsiIGKYB18ljxhyHxefDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758781841; x=
	1758868241; bh=zOyauCcZWQHljVVYvbb6mJMojgX35aeGr5IIRjaeM00=; b=W
	YhZLHK4WkS08E6fiTihI+L/JTlONo0qZod330GrbGTO1diTYcIKZ3UvdDV0ACF+o
	Hc2uJ0uFcDfe8BG4ozkrzKSW+4Z3oqdWIZMOC2cGUi4Cm7piykxEQ2tFFsoqKfpM
	HFD8eiER66/JSRJXO+w75Ig41wj/jYCsxtJGivkLAGdMWbdaOcK1b6WlbWcTFXbz
	f8/PnJDlN4nwRekiy3jxLnSsLpoITaBMuhOyngG4OaBz+seIA+O48J9Q+DETUzyR
	kJ5pFvkdxyE+ZfxsABVCxHFCXGn+WmXUPmhRshys+0wH4+z8GUR/sRSBFrwcI/yi
	Akna1EKFMTLhwWiGVFYtw==
X-ME-Sender: <xms:kOHUaIGD3vC0i-92pitRAmyXpFBwDIOZd1Bxz6KMma3YrEZOzx7Saw>
    <xme:kOHUaBxXesV-AFVjwHfwd7gWUJYKu4M6mXgHVh7m79Beh3W3j6mcQ0ZbwGh593kY6
    1YeGnbwWbh2vK0RrupXm4e70FwWCMYnGogkRFWu1wv2M574E8ZJOOg>
X-ME-Received: <xmr:kOHUaB6vDfZrQa1pBAEHP6Gjj10KQI8B0NW9n5C6woGuBIU4W3DgrlP1p_NhGtLbXHo-Peu2vt7eogUd252VzDYy3LJVvWLJaLoTqp62NIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdp
    rhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgt
    phhtthhopegtohhnthgrtghtsehhrggtkhhtihhvihhsrdhmvgdprhgtphhtthhopegvii
    gvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhivghrrhgv
    qdgvmhhmrghnuhgvlhdrphgrthhrhiesvghmsggvtghoshhmrdgtohhmpdhrtghpthhtoh
    epjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:kOHUaGdTYtn_0J5AebeW7nu6j5rfXcyijE-KILsKn0jjSJICnz_v7w>
    <xmx:kOHUaIEXazVceTHFAoTu9EtrZ9YWqSB6KFCrxMaE9ej6XR-S-TXgVw>
    <xmx:kOHUaG5HVjLXRa-HG4Zi1A_1WYFami-n5pDOcl4DJmRxHi7T1vCdDQ>
    <xmx:kOHUaLvFokTomczxRWIcEG-VFjqiHwkQrcs-uNF2X8AaAjV7lIeq7A>
    <xmx:keHUaC8qTZTYKaOkZ2tuVGmBlzIfivM5C2FW682GBjLmT7n7W5Tg4Yjb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 02:30:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2a86ed51 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 25 Sep 2025 06:30:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 25 Sep 2025 08:30:09 +0200
Subject: [PATCH v7 7/9] BreakingChanges: announce Rust becoming mandatory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-b4-pks-rust-breaking-change-v7-7-4e49dcb904d5@pks.im>
References: <20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im>
In-Reply-To: <20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im>
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
2.51.0.618.g983fd99d29.dirty

