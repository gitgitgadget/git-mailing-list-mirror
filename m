Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AE420B810
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 01:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775179046; cv=none; b=ZtiTiumm3WrjFSKjMaT0eKx9nNiXNtNl4sgVvrUieFFCsUL9pIO+QbhASL3ZNcNMm1zL3uc9MOb+pi52gT52wE33UZ8k/rgHBj1A8E0xeMScdsevDHNmdacthyjSkHdD2UKGNhpRe01gz5c08qvQ4A8B0y3Jybo4dsqJiARDEyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775179046; c=relaxed/simple;
	bh=DY5OPhFnecVzGXZfrBFnOKy9rsUKwnI/97JZ01/mQYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XLkq4/4z4W+Y9DBpMoOJrFHuJzNhzlIb4OL80F6y3gR8B+NOMpkjVxLwtbwcNYrdwIVa+8o/cO/qBpWlkvapfD9y1CSfHq36UXIFYpSnpQ/tc9i4KqelrdewUfWgDD1bBhlGLbUNmj+Iohj9tfESW4BWcII6/SWlpWxBn7IGkJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=op7i8RdL; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="op7i8RdL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1775179042;
	bh=DY5OPhFnecVzGXZfrBFnOKy9rsUKwnI/97JZ01/mQYQ=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=op7i8RdLA8a16Fs7xsRzv3KtQiUXDq4+3vF+isBSlaHIbE60EwnNPWBLk6G6LnMq9
	 QsL9N0+k+mteofjt14u+vt1TPQJnUYU0jFCJkO7BOe/FlzUbHuSfUn9RAa2wKj2loj
	 IEOtV8PCMJ4y0Mte2MQCk2r79datctB3RCkMpPzrj913Z+kRzDtp5GtangCEfUGzJu
	 Fxe4oC1Hy4tu6ijLCtRdL26xCqWGxupMaMJHrqdk3NalwZnmpsnJXeNEdZpSrLoGAt
	 YlXiCb6k04njFu1EgUJ0Ylf6CRiqUmhDRu1f4BTnhaqBQhiSfQxIXy9hqIkLAajqho
	 G/5jgjJWg16l7w8f1X4fO0EUrW80XUdcsWrgVPMzXPZt5kmOVYbWZgtT85CqZVwgxV
	 JSyaEOShdPg8X3t0krwlq7NCg5EIxqNPgYCLnnzluM0pZJF4gLck0bwaOVYCO1qr4A
	 LaZPG6q9k2jP4G7zgSuxnBEGW5prEka622v6AwZ58/DKBk/rpWm
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:4fc4:8150:dc47:49e7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id BCE762011B;
	Fri,  3 Apr 2026 01:17:22 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH 0/4] Enable Rust by default
Date: Fri,  3 Apr 2026 01:12:45 +0000
Message-ID: <20260403011249.4133372-1-sandals@crustytoothpaste.net>
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

The first patch updates the documentation accordingly and the next two
fix a few cases that are broken in our CI system.  The final patch
simply enables Rust by default except for two jobs to make sure that we
continue to build correctly without Rust for the moment.

I didn't force Rust on with the breaking changes mode because it's
already on by default with this series and it seemed unnecessary.

The GitHub Actions CI passes on all platforms with this series.

brian m. carlson (4):
  docs: update version with default Rust support
  ci: install cargo on Alpine
  Linux: link against libdl
  Enable Rust by default

 Documentation/BreakingChanges.adoc |  2 +-
 Makefile                           | 10 +++++-----
 ci/install-dependencies.sh         |  2 +-
 ci/lib.sh                          |  3 +++
 ci/run-build-and-tests.sh          |  2 +-
 config.mak.uname                   |  1 +
 meson.build                        |  2 +-
 meson_options.txt                  |  2 +-
 8 files changed, 14 insertions(+), 10 deletions(-)

