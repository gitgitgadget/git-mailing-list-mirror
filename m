Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F2A25D1E9
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 06:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760508258; cv=none; b=dgd6JD3GxJIHkXw0xaC+iOmZaBfgOFach5Vsh9fjnBKv7NxtDIBzHSJ/5CWVdM65HOtCT15r4iNZIKMXWRJLhad4mokCvoGvsURGSRky44QecwHKy2W2Bjmd2bk0ALrJrZD7GCy76kgClF0DcDd4BmXe3Vz27Ja+tg5xicW2MqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760508258; c=relaxed/simple;
	bh=SwrahxFcGIcrftvCy6JbApOVLDS4Gy/YksQbhn1jRxg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=iLSyDSRe0EJSTkTKFDQLOP/AO3FZ58krREOMJSp1xKRYwP4Aixz+QHSpB8a/L6dfqLv2ymfPFnBi/1JZ3g7mzs9NnafWlhZE8u/whZQcO8SSfAu2f9Zupygmykz2ueN+v/Grn1olmf1A9kUbfaTM/6/pxz8m5lgAvy5gv1Qw4YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NTiTcg6L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kwRDyFyB; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NTiTcg6L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kwRDyFyB"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id A69851D000EC;
	Wed, 15 Oct 2025 02:04:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 15 Oct 2025 02:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760508255;
	 x=1760594655; bh=7CRilDmIS50cNCNc0Cd9PQjXuT1CV5NM+mqyMvh2fYs=; b=
	NTiTcg6LJ6yrl8CphEn6benpVW2+uB2pidDq6gdBCWbrpfDIZcWXHedoFNoQ+MJN
	NH1d/HEq/qvQsd6IM63b34AeaHKzXV57vXgT+IHrMtE8kGUYT4bTr5JSrBWucWIG
	IHFSpmvmEj20xvNvn84pjjYb6dWwqjVIpkyZwanCiBkRFkh4y9sQqy5kyF+c3b1P
	Sq6bDzFlwXw85ynXmODhQzO7xvoA8ZgJdRPmYpZgigKCt/1y/MJp9vgf+f2zG1f5
	PE6pwxGu7VYDa50ppOrmhRmkPLIwZLmIgwk7ZVA3cWIPhJDrlMXlxOTdpmmVtg2O
	q56sXFK74zBNqpnifdcNAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760508255; x=
	1760594655; bh=7CRilDmIS50cNCNc0Cd9PQjXuT1CV5NM+mqyMvh2fYs=; b=k
	wRDyFyBuEEcxOeysBnAcwfL7cVxque9pnWz3KwlJKH4iCw9GJAY8sQn7ROMC81XE
	7gKy+NJdZg8/jduUh2zuKQKnGL5pX/eiC3gP9ATY+epJgdHd7I6RTTpsRBnpbZ07
	+WgSkGYe3BGzS/H4Ig5RHLmxbOkNbbelf2jst5QplewVd3w2rVvwz/7JSBSYOlT6
	/74pV2bANB1neCuf+7L64a969CqedfeDhW9lPBFUo0SLFWCZJgLQqsJ8L5yneItO
	dWNlb9AOHGtUvnela3QrKTmDtuwvtok9bUEMM7lFEuUa26IpzJw9TWlK0a2fJBWf
	NFROW8RwXBTtN7iWwVcqg==
X-ME-Sender: <xms:XznvaG6cT9lolZCv-qQjaLW0rSDf7QgjgJ-zyck9miIjPPserSS8oA>
    <xme:XznvaO9pQTXy-gV6NKrySoLDCGQBSvQNh32riws9di73LU81SykjOOaLMj96ZFWwd
    HUdaRIAHifdtIXM_6mDq5ySiT-pIFzn3RwHPM0Xd_EVPHiXF7lIcQ>
X-ME-Received: <xmr:XznvaLqS5--LR7Z6YutjI0qRaL7_0cRO4qW2t-uh_19fT2EE_ppW0XLdL-DCMCcw9uQT5kTBFUDc35Sl_D5IhE8sebdp4eDbAyHWHuV0_cjz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffieekvefgfedthfdttdefveetueeggfeuhfetudetgefffefgleekuddvueetgeen
    ucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvii
    gvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghrihgtshhu
    nhhshhhinhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstg
    hhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheptghhrhhishdrthhorhgvkhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhoth
    hhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:XznvaPqyzTdLxoV5Dsw-0StNVExo5VusSPZcl6CSjMvL_r-BbSCXvQ>
    <xmx:XznvaO1eGIRpjXtxjRLSWw8DgviVkNmMkr-srGhxqbkGT8SOrtcCfA>
    <xmx:XznvaNFW3QxkGICKc_vLITwpjD1Xgxvlz2BzmaoXhz_gGhabD0Dqhg>
    <xmx:XznvaJENrR_zyPmfM8BZOOslOW_fILzHvW31pJEZffEczhA4VlUCiw>
    <xmx:XznvaDEhpTjWgvlLsSeGlOmwn-Bp4_ZeSk43tJw2UZC_As-KuNIZsXWL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 02:04:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ccca6128 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 15 Oct 2025 06:04:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/6] ci: improvements to our Rust infrastructure
Date: Wed, 15 Oct 2025 08:04:04 +0200
Message-Id: <20251015-b4-pks-ci-rust-v3-0-13810af33bd5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFQ572gC/3WMyw6CMBBFf4XM2jF9UCiu/A/josAoEyOQFhsN4
 d8tLIyJcXnuzTkzBPJMAQ7ZDJ4iBx76BHqXQdO5/krIbWJQQhkpRIl1juMtYMPoH2FCmytFhbO
 yKgiSNHq68HMLns6JOw7T4F9bP8p1/ZuKEgXqKjdCuZpKcsf07vkOayeqb9f+uCq5rTEFkdWNt
 vLjLsvyBrW2ROLlAAAA
X-Change-ID: 20251007-b4-pks-ci-rust-8422e6a8196e
In-Reply-To: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Eric Sunshine <ericsunshine@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Chris Torek <chris.torek@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.3

Hi,

this small patch series introduces some improvements for our Rust
infrastructure. Most importantly, it introduces a couple of static
analysis checks to verify consistent formatting, use Clippy for linting
and to verify our minimum supported Rust version.

Furthermore, this series also introduces support for building with Rust
enabled on Windows.

The series is built on top of 45547b60ac (Merge branch 'master' of
https://github.com/j6t/gitk, 2025-10-05) with ps/rust-balloon at
e425c40aa0 (ci: enable Rust for breaking-changes jobs, 2025-10-02) and
ps/gitlab-ci-windows-improvements at 3c4925c3f5 (t8020: fix test failure
due to indeterministic tag sorting, 2025-10-02) merged into it.

Changes in v3:
  - Clarify why scripts don't use `set -e` exclusively for error
    handling.
  - Link to v2: https://lore.kernel.org/r/20251008-b4-pks-ci-rust-v2-0-d556ee83c381@pks.im

Changes in v2:
  - Adjust comments for `encode_varint()` and `decode_varint()` based on
    brian's feedback.
  - Some small improvements to commit messages.
  - Not changed is the default column limit used by Rust. I think using
    the column limit of 100 used by the Rust ecosystem is sensible, but
    if there is a majority advocating for a limit of 80 I'll adapt this.
  - Link to v1: https://lore.kernel.org/r/20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (6):
      ci: deduplicate calls to `apt-get update`
      ci: check formatting of our Rust code
      rust/varint: add safety comments
      ci: check for common Rust mistakes via Clippy
      ci: verify minimum supported Rust version
      rust: support for Windows

 .github/workflows/main.yml | 15 +++++++++++++++
 .gitlab-ci.yml             | 13 ++++++++++++-
 Cargo.toml                 |  1 +
 Makefile                   | 14 ++++++++++++--
 ci/install-dependencies.sh | 17 +++++++++++++----
 ci/run-rust-checks.sh      | 22 ++++++++++++++++++++++
 meson.build                |  4 ++++
 src/cargo-meson.sh         | 11 +++++++++--
 src/varint.rs              | 15 +++++++++++++++
 9 files changed, 103 insertions(+), 9 deletions(-)

Range-diff versus v2:

1:  dc9d75f47c = 1:  cac74c6387 ci: deduplicate calls to `apt-get update`
2:  8537190491 ! 2:  6164bbd971 ci: check formatting of our Rust code
    @@ Commit message
         edition is automatically derived from the edition we have specified in
         our "Cargo.toml" file.
     
    +    The implemented script looks somewhat weird as we perfom manual error
    +    handling instead of using something like `set -e`. The intent here is
    +    that subsequent commits will add more checks, and we want to execute all
    +    of these checks regardless of whether or not a previous check failed.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## .github/workflows/main.yml ##
3:  8f7232e650 = 3:  1c87940646 rust/varint: add safety comments
4:  09810edff2 = 4:  0b09774307 ci: check for common Rust mistakes via Clippy
5:  bdb4e9df32 = 5:  93d6111ae7 ci: verify minimum supported Rust version
6:  40edae19a8 = 6:  3f58a9b9df rust: support for Windows

---
base-commit: 8c8e270f2aba359479c4c2b4ab3c62726e5dac9d
change-id: 20251007-b4-pks-ci-rust-8422e6a8196e

