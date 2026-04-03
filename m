Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59A519E968
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 01:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775179045; cv=none; b=hZij/hfKx3BkafZKOqx+XoT916UQFoad3jEb1mf9A7i7a052UXqpOoxAIG1Rmf3PnexKhM22ISql8wn+ucFHE3s1vZ0XCuP+G4Q1h5VlTv7rReXm6EPBzGRiL4lZv5Z8uWYCcICvCR81jTTpnGNuHeEOw5ve6GvYciYrlpQ9hOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775179045; c=relaxed/simple;
	bh=ZmdF5O+VNBfa+O9mgvCaEwKCC5+Zl1AC515/4ciOg+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SAOxbVHg+ILfCX4bK9oMEfEvLkVPkQvKGpzWawPktuCmecRr1bsiCgfP8bmSDYureWRlYYfvgBrnIYmuyaG0pj+VnjHX8dCAPdWKdS0isqqwi0xjwi7dym4OETjdMOGsahXoEybsdQmUL0Ay79h665RwL5NbulpP9oBXybX264M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=mJltVW2B; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mJltVW2B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1775179042;
	bh=ZmdF5O+VNBfa+O9mgvCaEwKCC5+Zl1AC515/4ciOg+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=mJltVW2B+qhpIGVFK2mpk3BHTkIr0e9LMIN+klTNL7y/1ihEAJs1S82VIDun85G8W
	 snb7We0afOQ0eRuofbbmTUqFDsIDhFOYg5JEzWETzhBNbgMYkLyjmrSN6Uby4ObMn/
	 cb5VvByhCpLmDOIiNhHAVCcLZLhGxxh6MAYLMUnIoGF6bvHpFy+a3t10IUlDNNGPks
	 jbEAozIRR6TaTPjUhdth59iinjvSHjhYhAtOfZw0ddSpNFkFjETu+XyVL7XVKL+V7S
	 1fgjm2EAcRlH9f9EP0j1s+EOIqzbRoxPYX/7jmhIOguwWNzZxQwF3fJ+HhHnEZJfhC
	 uDsV2c0SxiblNBaY6n0nswVzGYgKKXsr+VIDA5zg4xd4Eo4qWocScn3VWQW3VoTlnF
	 oDkGjvkUKZ+lIUY2Q8w4jLp2XD2kQTzwJ8k67D6DKSagDb/bUTARNqh9qb4Mlc01XL
	 q1dJgFK/jhwY2Ody4Mer5Ab4nclCfI0wJ+7AaM+O2aph0aI+Xfp
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:4fc4:8150:dc47:49e7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id CD31A209F3;
	Fri,  3 Apr 2026 01:17:22 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH 2/4] ci: install cargo on Alpine
Date: Fri,  3 Apr 2026 01:12:47 +0000
Message-ID: <20260403011249.4133372-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260403011249.4133372-1-sandals@crustytoothpaste.net>
References: <20260403011249.4133372-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'll make Rust the default in a future commit, so be sure to install
Cargo (which will also install Rust) to prepare for that case.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index c55441d9df..10c3530d1a 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -29,7 +29,7 @@ alpine-*)
 	apk add --update shadow sudo meson ninja-build gcc libc-dev curl-dev openssl-dev expat-dev gettext \
 		zlib-ng-dev pcre2-dev python3 musl-libintl perl-utils ncurses \
 		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav apr-util-dbd_sqlite3 \
-		bash cvs gnupg perl-cgi perl-dbd-sqlite perl-io-tty >/dev/null
+		bash cvs gnupg perl-cgi perl-dbd-sqlite perl-io-tty cargo >/dev/null
 	;;
 fedora-*|almalinux-*)
 	case "$jobname" in
