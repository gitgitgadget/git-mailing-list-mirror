Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764AF2DC322
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840604; cv=none; b=Jesv/6aZ7Si3N6qrkq7czbr/+dzjrT94OmM7Emcg4YoXW7/atoEzWxIclMqBMQPrEdq1oZh+fxq8oI6iEODTnqoCw/t8WAjpf2/+xX30lkVp0dx4zA8CuYtnCVRVHWCCEscHqm9E0NMek7WTwrhV/dXNI2Rc2qxb1sR3OwS7cPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840604; c=relaxed/simple;
	bh=fNLoftBIfwijPwHUXeJqdZ7c8GtHkuEgrOUyC6g8AIw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Pkcdhz/mdj8+jj4dbmn9GXkI1rwsNjuRrCKUraSGDrgUWNPTk3BD4FxlTPCoGI52E3pobkremnplEi7HfgyDicvYaxyKhgK2Got9rgvKwyklnoUGqN+6aOKwDYnKCyP3H1loRDS0F6ZtXlVnzjK7C8G9RZPYSHIUaocGrOSl7e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TSHt6sWY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zTn6DmAD; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TSHt6sWY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zTn6DmAD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A2205140009D;
	Tue,  7 Oct 2025 08:36:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 07 Oct 2025 08:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1759840601; x=1759927001; bh=rViCUFd2GO
	Q3iJysQpogWzf2uoL0Qv8zzBkJIZ5CIc0=; b=TSHt6sWY+d3WJS4wGMRpptLkkR
	CYtUdywE3JcMoMwRyHj/Ntobu4vq7nz+loZlTv1VeRkzWpyk+klHt/HpsNMIRRgq
	UP74WYq0mZ4endHvZFxkHBtGmWe8F35tMjPvJbBKDd8AkfYHBSJ9cYOWBG3TCAW8
	KVt21UWgtUwnS/XStewTgM+SZeh+OvSzAhmhG2ENwjo7ZuHBISFkFwQGLvqyCuQ0
	uMhBwrc+H9D22inGqq5oFEyXrfhXtT6f/UnsBMBTN4OFAHT95zi4zVqhYU2+0UTR
	7NcZv7ZYAOSKiupm8K2hnghlMZsk5kfzmxHGE8ucD8v2qeyNjCEs338QwhAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1759840601; x=1759927001; bh=rViCUFd2GOQ3iJysQpogWzf2uoL0
	Qv8zzBkJIZ5CIc0=; b=zTn6DmADCgKqw2z/6ERI4NvMU8XUed4qvuPGYf2NdDrZ
	nHyBP/77UUUMEl4NzcEhSHGcR56uPZkwi6G89Ei7YbEZkqnko2DPF2i4F4Jr84RA
	KfuHq7I3zJNVJXLedNO2uCJ3Pba+CsvX2CD+BoXAur8H4s9u8244Job33gKFjH4m
	6IHhAwx8plbfxQh3x4mUMRf+a7G+4/IOWINNwmcHr6V0F6ggAOcW/X2LMC9IqMf5
	JNRR34MScDj+I1m6rz1Zp+tvM6xiTjOd1INyHzU9L+ykKJ9TcVJ8cmONlT24NzNw
	9QoWgpW5dzqiBZMnNmOAwpY9VjKbibWcPf4dhQMvQA==
X-ME-Sender: <xms:WQnlaFIiQ5AevXiiBfGHRYAWEFJR3PFSbkctAq3TEdHJuWHEMA_b3w>
    <xme:WQnlaIIJMuDsap0JYLkUJmNcdbPWE5vdy3jQrHQZFZ5mtYJV9TepRkR2B5e-436_x
    t5JeqTttqGPI1d4TpQTzwvV0FDN6Tp9LgQgPqwpnswJMBXk0fV6>
X-ME-Received: <xmr:WQnlaCvmmldIGjWxRX4cYMvK0ekhy2C3B4PLfojDjFg8H8rdvz3sRrUprxD0u9gzT-Uk3BGGPwDmZZe6c7ZUXhrGRup1E3ML4gRyVdIcgxI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ehteeihfegfffgveejvdehtefffffhudetheeivedtgeffvddthfdtjefghfdtfeenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhn
    sehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:WQnlaFSwgsr111izgQq_ewP0ZuQh8HEDIW3iGFBxoQpWfj5fVDqYDA>
    <xmx:WQnlaIPBwbY-3TBdZ8rbrxLAa3MC8jo3JWjNDvCh-sctZf0i8FaQAg>
    <xmx:WQnlaKZktTFD8N1X5FCDskVMI-vHq5KJn-4MAoofwf1YfCDK9GeWnQ>
    <xmx:WQnlaCwSnGeCHEk2u8y0aO6u1eD3HO3-Pq5Bmy4cQIujlZp_UbHpYQ>
    <xmx:WQnlaL56W2-0SKbn8EDdPMSK6ts4cJgp4fiHQORfLLm6BiDTABBhfiUG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 08:36:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9d8d0d44 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 7 Oct 2025 12:36:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/6] ci: improvements to our Rust infrastructure
Date: Tue, 07 Oct 2025 14:36:28 +0200
Message-Id: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEwJ5WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwNz3SQT3YLsYt3kTN2i0uISXQsTI6NUs0QLQ0uzVCWgpoKi1LTMCrC
 B0bG1tQBFV8AtYAAAAA==
X-Change-ID: 20251007-b4-pks-ci-rust-8422e6a8196e
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
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
 src/varint.rs              |  8 ++++++++
 9 files changed, 96 insertions(+), 9 deletions(-)


---
base-commit: 8c8e270f2aba359479c4c2b4ab3c62726e5dac9d
change-id: 20251007-b4-pks-ci-rust-8422e6a8196e

