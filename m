Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A4F39656C
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 22:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775774679; cv=none; b=qWMPxq0HgiYVhY80AOQ9HZu6Tcr+uxMxZ5Gf49eE9T6f/ZXFAgubWIR+XNfte3AUu99JWtCjOY0URRGhIVuCbmPGhAum3UHoKvMQbuBgWz/0GIoMVK3NyKbug+KKt+GZ4eOKoYMCcY0lR/739WrqPqfMBWM4Gzuu5NGbxDSYCb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775774679; c=relaxed/simple;
	bh=AqkwyLcIBtzWX4buZVFErftdKjHIUs6EBsdTVU6Przw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kLr1vtcKgDPgIoI9E2KaUASVx+PHrMdFw2LPfQf8Kx5nT4n9zJKr4podtVs63QS9l1oVIktFKJVNSxsV6WVFlTTMHlQv9cvWk8nZJT3i4g4NkWUDe4K0ORw8jy/60PSgPytQAoEJohht2DHBsK5ebxK32JOnyCrJHPUsyhHnDYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=YTgSutbY; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="YTgSutbY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1775774676;
	bh=AqkwyLcIBtzWX4buZVFErftdKjHIUs6EBsdTVU6Przw=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=YTgSutbYeHBGhu8NmvQDxxt6QZUenS/x28qyaBQcuHXwt3L32BZg9nAzCAoYAyDyp
	 CM5c7DzFCZ1uCEl0te+JDp4TnWZ48CeVx/LpI4Uqgy7WcKqRngULTzot90HcrNzdIR
	 3nWfoiFWGeZibjwBCUZGBx2z+ZdLisB+rYLzxthbgm7EtbqjvCKn4cPRZIPbmb+gqU
	 8/3Z48mnqFifKa2RbJ7mzMbVj5g8VZR+szCd5gfEdAdBPaSPcXYpD2xqoG0tJw/vjb
	 IBNYck87ZpiHSHSD84k7dP39EVmb4J77r2CAajgyLxieHO9a1pynyK4goC1lJJoWmb
	 VUtXcF4Qz6qr/OkKl28qzNqVWpVOA5Ed4Lo4pyLlQctls74HcyTH1LM+KC1H5y6JYi
	 jkWR7Zg6r9vCy0NwACqRhfc04lqQAa/dGiIxaBbtNZP86L5mNh/p6+6hNeSJhZkIDu
	 PrB2ljAsc58UdS5DBcxdIIe3m/yMzM1H872eFOOGOM/YsSSh/rY
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:fec4:70ef:431f:d174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 39C3020041;
	Thu,  9 Apr 2026 22:44:36 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH v2 0/4] Enable Rust by default
Date: Thu,  9 Apr 2026 22:44:30 +0000
Message-ID: <20260409224434.1861422-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our breaking changes document said that we would enable Rust support by
default in Git 2.53, while still leaving the ability for it to be
disabled.  Unfortunately, we forgot to do that and my time machine is
broken right now, so this series sets it up for Git 2.54.

CI remains passing on GitHub Actions in v2.

Changes since v1:

* Move Cargo declaration to src/meson.rs.
* Add a Meson build without Rust.
* Remove `-Drust=enabled` for Meson, which is no longer needed.

brian m. carlson (4):
  docs: update version with default Rust support
  ci: install cargo on Alpine
  Linux: link against libdl
  Enable Rust by default

 Documentation/BreakingChanges.adoc |  2 +-
 Makefile                           | 10 +++++-----
 ci/install-dependencies.sh         |  2 +-
 ci/lib.sh                          |  3 +++
 ci/run-build-and-tests.sh          |  6 ++++--
 config.mak.uname                   |  1 +
 meson.build                        |  3 +--
 meson_options.txt                  |  2 +-
 src/meson.build                    |  1 +
 9 files changed, 18 insertions(+), 12 deletions(-)

