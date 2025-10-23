Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A06A2C0282
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 07:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203866; cv=none; b=jk1+TEcLDZ5GIdUEVghW8JFWQ4Di1IbOVGs1m0tQY399rhqXoutNBdMoECvP2t0EPGZE4JZX3NG+qKg5EN7GPs7qGh0xEvDL4jCfnsLqcUR9DaNIZol2UGzcIn47bOx67ib0S8Sdb32RjCNbKlnwy36V5hAlxCFbC7FlpDqNfhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203866; c=relaxed/simple;
	bh=pwDLKpF547XKydPiE5xwwgkmY788Dm7HQkPmPx6Umao=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IM1YLcurvg6vzDMSeEQHebOo40naELRT/nFt2MVrZ7x5TmTozKesnYgAEmtWVp2kzg1tlfthMYbVLiZw6Ognpg9vswYTiMBJQcOZbqs3Y45VObNdigIpQCyCIgZxubagW1Zum5+t7SvY0f4xo4hNGY3GbYGkP0CMJ5JS3HnRPi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y5R01GtG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DyLi0qwb; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y5R01GtG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DyLi0qwb"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9101C14001B2;
	Thu, 23 Oct 2025 03:17:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 23 Oct 2025 03:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1761203864; x=1761290264; bh=+hob5a+eQj
	3CYKly4WxIJTE4iiXNwY4PPl+67XFNU7U=; b=Y5R01GtGmR2t8lmxs5DRiyeP9Q
	IfsGnU9AKTbGUiQeEyBiejiTMXOxDZhTFAsucQSRfPPRTfuwawINM/WEG4uWa4CO
	t4XOCXPYN8Ac1c1Ir6eESb8qMa9ajJbFGaqc0KcqBNtRZnKZfr5ePcPhIHFRo4Bj
	rbNVZvGXwyigN4LsjNW+CXU+xaFOIDu/KD5X+BkS6+mJxxmBvjF5wGnNJCCv3ESs
	puwgtrblQ/X11mVIcagYX4wW+8bOX8P7z6qtWm3btDBbrFDnENCokELQKmzxv9nm
	GT05JAGU8TedVoVaPqvU++ogpxwS7ZweMz/jLVa1OG4Vb8rr6hMp+FnFsRLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1761203864; x=1761290264; bh=+hob5a+eQj3CYKly4WxIJTE4iiXN
	wY4PPl+67XFNU7U=; b=DyLi0qwbvHVcs4Bw6mduwYFQ8I11138Kgjv5Me8rDKK5
	HlKPuC62KcDK+t0pdYf9AVD7mGnhu9dk7EdDJS+y/Pu0PpPILXKtcs3WHPPfu6n+
	MRKFndsC63xHEE0oVhe65d+w98rUnCcX7QBevN6omRKYCLhn+M18EqRqC9PBhXih
	YpDXVI6zhs17kGDUoNZUb3iaBGv0hG9mhrTdPmEKh0OGXKo17AdI3mPF4TzrbqLx
	bON//ZlLAjqV7JJ70KQIVT27ZD+YupLb8iYT9AvTQsPdXiTOzhUSCA2Aj69i2FOj
	iHbPirjP0+JqvjML0JgSJQc1aMGtMchVX/sH2uwQAA==
X-ME-Sender: <xms:mNb5aACMXWxb5ZQAp7BTCd4h8yNAe29tQmbzVG1WuMNh8TAARJnvpg>
    <xme:mNb5aJ-TbvG-dKy2UBZEFpO-xzuCUwTu0g2YpyYuaV-mjc6IZNQPK4D5rGALujL_o
    ZrUmJ7Fod6ch15tUPHfXD5Y2ADzoHD0MUc9j6ani8-BozFJ1-nK2Q>
X-ME-Received: <xmr:mNb5aA-9x1GSv4R3BnPbakH5yvJ4ZvetlxWRAAqdmDYFTPjaChK34DZda_AFneUXjbjTjLLcvYS2ox48Qzl_eE2Yg7OyQZ51mqj6dYTCK8JmNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeehkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evueegkedtteeigeejueehuedugfevleefveehueehgfetffffvefhuefhueekveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgiivghkihgv
    lhhnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:mNb5aAd9hXq6rGgCMfQXSYwKqeQtH2JoVg9uEX3qKqxh6phSa_xKaQ>
    <xmx:mNb5aJEBANivHDod6zBiczfsB9s8nohgxfrm3GDR_VvSAE7PDYpiOg>
    <xmx:mNb5aOdxpjMBQrZnsaYzS__slD4dVEoykjZwGWE5qGNPB4a7zLQIBQ>
    <xmx:mNb5aDET-0jlSuUG5crKJB6tjdwY2gluOqVrw6rQ-s3hZviPKTBgcA>
    <xmx:mNb5aFpSFfG98NTBrv2XDmPUQnJ-Ow1JmV2fetJoCIzUhAafjVOlTl7r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 03:17:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 350b2ac8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 23 Oct 2025 07:17:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/3] rust: generate bindings via cbindgen
Date: Thu, 23 Oct 2025 09:17:37 +0200
Message-Id: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJHW+WgC/x3MQQ5AMBBA0avIrE1SDaquIhboqImkpINIxN01l
 m/x/wNCkUmgzR6IdLHwFhKKPINpGYInZJcMWumqUMriWOK+CsZTDpxGDs5TQNcoYyw5rWsLKd0
 jzXz/265/3w+5C6edZgAAAA==
X-Change-ID: 20251009-b4-pks-rust-cbindgen-d80779ed2269
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Ezekiel Newren <ezekielnewren@gmail.com>
X-Mailer: b4 0.14.3

Hi,

this small patch series introduces support for cbindgen(1). This tool is
used to generate C headers from `extern "C"` blocks so that Rust code
can easily be called from C code.

For now, the only use case is to verify that our varint reimplementation
matches the C implementation. But later on this can and will be used to
call Rust-specific features from C, as well.

The topic is built on top of c54a18ef67 (The twenty-second batch,
2025-10-22) with ps/ci-rust at e509b5b8be (rust: support for Windows,
2025-10-15) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (3):
      ci: use Debian instead of deprecated i386/ubuntu
      meson: rename Rust library target
      rust: generate bindings via cbindgen

 .github/workflows/main.yml |  3 +--
 .gitignore                 |  1 +
 .gitlab-ci.yml             |  2 +-
 Makefile                   | 14 +++++++++++---
 cbindgen.toml              |  7 +++++++
 ci/install-dependencies.sh | 10 +++++-----
 ci/lib.sh                  |  2 +-
 meson.build                | 25 ++++++++++++++++++++-----
 shared.mak                 |  1 +
 src/meson.build            |  2 +-
 varint.c                   |  9 +++++++++
 11 files changed, 58 insertions(+), 18 deletions(-)


---
base-commit: 8654b230d9afe1326340989dd7082997c672472e
change-id: 20251009-b4-pks-rust-cbindgen-d80779ed2269

