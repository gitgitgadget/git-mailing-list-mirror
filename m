Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7192D312812
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996029; cv=none; b=F/uzV8cVlj8OnNofZOcHDjt+ixlfF2D2ekNPJ80hVIfHacX+1EveUzVyA/B22flnYNDQ4VAuLEcM9pLx9oQB/DH5moYcMfowUSSbp9JMikwV2hGjbIfKfFeo7lsNkN/M8609OWj5ibb6Zk2nXXRMl82gHB+LfgEUhEpQ2ICI6Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996029; c=relaxed/simple;
	bh=behVmye6XMG9aE17csp/HSNxYryHRnq/M+Nodob3pkw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VrljDxWtRUmM6a58ng8q9tJK0Lq+/RjFYe8gMpgi+AXL9jZ8buf74GvY7SvjQ4PlHKxkehx4aOxH2GWPIs42kU6S4jD7p8vcPIA1t2TkNPFXbJSfXRIQu9R5DG8aJLwoj4s1YV+/QN2HYC6F7e+r1NeuX2gZm7fENjV1bZYIi3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DGU/++Nl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PYhi2JIW; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DGU/++Nl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PYhi2JIW"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3C6891D00282;
	Thu,  4 Sep 2025 10:27:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 04 Sep 2025 10:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1756996026; x=1757082426; bh=luSh9qLC91
	A/KILbsoW18jQWM+2jcFmrIExEZUAVd7c=; b=DGU/++NlZnIfp07C5oYozgagv9
	IhupgmdIj3VF58JH8cQxLJrEhrsicaNUkZDY5XtZzeXpmLi/VcHNMqHUpYp+fr7e
	q3dQGim6efl4LTCPXM2Jiuw8EBBctTwDNQQN1a1GK/voWvHtcg08V3nIUXwS2oPs
	4PA6KH5gKurgOX7bdQRVm4Hv3knzx09GQr7S1sBIg7A2HArlNRrmZsVEZ1XSZ3Hc
	pDxd6olrCrIM09wb+WbjXuvvx8IG5F4Wn6ZQbbEsc/GkPYffsJm1uFR5vvEe1B/E
	8yM1YS7JQFtUk82N1hRrbqRxlj1BIgznJr1OmLK+9hxgSznpsAjbgfuWyVww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1756996026; x=1757082426; bh=luSh9qLC91A/KILbsoW18jQWM+2j
	cFmrIExEZUAVd7c=; b=PYhi2JIW3pts1Hmo1+bkTz810Yx28YJmAunlX87Rqtjc
	pzVDNnAjbCC6HuFUyIndu+fiEVoKoc2GmYgsXEZPh+DwjEXYDyUozmI/BeRdjPzp
	S26+wg0WymUN7I8hx4tnMNoUOHlj9zMfsKilH4VXOWN+VFAtHaBsV2bXRe5RbvII
	W3d1c2RPGj8xTSRIQdOuPqVDq09jFHbMcpXorKX5XmCy8q3pqotxI/claaWXntQ8
	QkCN5dkhoJ3O2Ct/rlBRePQoriGbl1J74JXt6Y7lFC0UwRU41wJksR7NnaGXc7zo
	AmLOwG2xFNlHFita72LuMK3b8377yxQO22qU/oQM/Q==
X-ME-Sender: <xms:uaG5aDdhSxnkVUvOUINC8o5bWfQA2ONkJDiD7c676feaC7Hl7OMcvw>
    <xme:uaG5aJVf3xEHMPooJetUgko05Sbh_M32sGEKWbzwy4hkro6taAqr0Md3-RTBdEssK
    dGAeOnpYhwY9njiYw>
X-ME-Received: <xmr:uaG5aD-ljCY0qGtx8KP8W0pYZdp2tY_sP0VenQ-6GHBmsNomn5R6RYgukghwMMvit2Cey0cDmqGcRc2Hlz3QjgShnOKgAR-MrH8WR8dMgA9WGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfu
    thgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevue
    egkedtteeigeejueehuedugfevleefveehueehgfetffffvefhuefhueekveenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    phhivghrrhgvqdgvmhhmrghnuhgvlhdrphgrthhrhiesvghmsggvtghoshhmrdgtohhmpd
    hrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    shgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegv
    shgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopegviigvkhhivghlnh
    gvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghh
    ihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhg
X-ME-Proxy: <xmx:uaG5aLiVM2ukR9CzAVDjConkWHV10CDd6-qxr7le9BjgDfKKcyEhbg>
    <xmx:uaG5aHczga5_ScQPUMtW8TVI3x0tMSlUlYtpIXhahEJP7B-tod_UAg>
    <xmx:uaG5aMLYHpnoF9IJt1cLD8E-imwSlXofUd0JMIVokaof4cRfT-dNcw>
    <xmx:uaG5aMkJYyulV-8n67Z638kor_wnyKX6P1e6cadoHPfW44TA4kMLOA>
    <xmx:uqG5aJCTNwCjuHjImgg14kAS4t6nrbgXJfYvbQcxMHenaYkrvVwpP2iV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 10:27:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 33eec17d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 14:27:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH RFC 0/3] Introduce Rust and announce that it will become
 mandatorty
Date: Thu, 04 Sep 2025 16:26:42 +0200
Message-Id: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKKhuWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwMT3SQT3YLsYt2i0uIS3aSi1MTszLx0XahSc0Mz8xTLFONUY/MUJaA
 JBUWpaZkVYNOjlYLcnJVia2sBaDL93nIAAAA=
X-Change-ID: 20250904-b4-pks-rust-breaking-change-7167d9d3e37d
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

Hi,

this small patch series introduces Rust into the core of Git. This patch
series is designed as a test balloon, similar to how we introduced test
balloons for C99 features in the past. The goal is threefold:

  - Give us some time to experiment with Rust and introduce proper build
    infrastructure.

  - Give distributors time to ease into the new toolchain requirements.
    Introducing Rust is impossible for some platforms and hard for
    others.

  - Announce that Git 3.0 will make Rust a mandatory part of our build
    infrastructure.

The test balloon itself is quite uninteresting: I've chosen to convert
the "varint.c" subsystem, mostly because it is trivial and does not have
any dependencies. But it does allow us to verify that C to Rust interop
works as expected, and to play around with tooling. All tests pass with
the "varint.rs" implementation.

For now, the series only contains support for Meson. If we agree to go
down this route I'll also introduce support for Rust into our Makefiles
at a later point in time.

Furthermore missing is additional tooling:

  - At least one CI job to verify that Rust builds and works as
    expected.

  - Tooling and CI jobs to ensure that we have consistent formatting via
    `cargo format`.

And probably lots more. As said, the entire goal is for us to have an
easy playground that we can experiment on and develop the infrastructure
incrementally without yet having to commit to anything.

I'm mostly splitting out the topic of introducing Rust from the larger
series that introduce it into xdiff so that we can focus more on the
actual process of introducing Rust into Git and less on the potential
features that we want to build on top of it.

Thanks!

Patrick

---
Patrick Steinhardt (3):
      meson: add infrastructure to build internal Rust library
      rust: implement a test balloon via the "varint" subsystem
      BreakingChanges: announce Rust becoming mandatory

 Documentation/BreakingChanges.adoc | 20 +++++++++
 meson.build                        | 21 ++++++++-
 meson_options.txt                  |  2 +
 src/lib.rs                         |  1 +
 src/meson.build                    | 13 ++++++
 src/varint.rs                      | 92 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 147 insertions(+), 2 deletions(-)


---
base-commit: 2462961280690837670d997bde64bd4ebf8ae66d
change-id: 20250904-b4-pks-rust-breaking-change-7167d9d3e37d

