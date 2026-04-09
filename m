Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0C8379EF6
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775774678; cv=none; b=FydbVKsI5wjhxCZj0MUIBAdWHXCCsDdIqyO+8r0ag6Jr2JoLRZjbYsumR7qkFKtf1v5xMY6ji0MGZgLX25C8OTJbGkmxkiSF1uS22BGOeRv+1hiHcT6R88BC4wS9Gwo2LKKtLgwbK7WMDVJ3Ik+V7CdoRZ5l7RcUGj+Dd41lwLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775774678; c=relaxed/simple;
	bh=ZmdF5O+VNBfa+O9mgvCaEwKCC5+Zl1AC515/4ciOg+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WneXGs8crtKo72BrFGB93UxgJEy0538cVTL+yll+aNMQrSWM+fScLzH9Jlz2qwZlQbMkNJ3jsgUUiktVUpAethlDBoGEfIqt7o2iGiCEpK69ndf9ostYxoMvWJ3EruswYTi+OCo1zqrRzHgdIk1CFOUDpi9wsO/F7k/x8nR4whY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=cFF/U/t9; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="cFF/U/t9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1775774676;
	bh=ZmdF5O+VNBfa+O9mgvCaEwKCC5+Zl1AC515/4ciOg+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=cFF/U/t94lde+KMLw4s32Zk6qsVsJZEZ4p1w9CPhF3FOf09sfOtJXCoSy09dIP6sQ
	 4X6qnjNMuD9hD2PwcrriXlHBnVyc/NHOZhBifj3dRp11AX+0tXYcQhd9QGiy43n2Bx
	 JMj7kt0xsP8mYPPY+XZhjeOp5bY37ZLrDApWILAgLKl/vuH/VdowRUljKmEAxHVl48
	 ev1Z73LOGbbZfwLgLyj7vbDAIugckMpM+Ao3CMyu4wLrD4HZ+dtBxxDnZJfN1mrd46
	 6S8J4Qvc0XPPh8b31NoNzCQyDt/3xJfYrUqNSS6m33PsH37m5sgtppQkV9MGl9ZjTV
	 uBKcI7kPJ24+vANzMZNQvyJ3F+k9XxwPig2759UROlEpNV7/0m1cCIXYE9UI8+uSJo
	 Uoj7EABZLMqpsEap4M92W/YiqxzLPOXtoiuUoAPEcXZKRbhl++gef3wY6aZ8IatwYK
	 RW1t7QrYjn+SOiWFLYGFzKj1INhtLhTciU8IteqySaxGBL306KI
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:fec4:70ef:431f:d174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4C03D24401;
	Thu,  9 Apr 2026 22:44:36 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH v2 2/4] ci: install cargo on Alpine
Date: Thu,  9 Apr 2026 22:44:32 +0000
Message-ID: <20260409224434.1861422-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260409224434.1861422-1-sandals@crustytoothpaste.net>
References: <20260409224434.1861422-1-sandals@crustytoothpaste.net>
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
