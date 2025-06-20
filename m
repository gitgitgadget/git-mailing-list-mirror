Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579FA8632B
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 01:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750382402; cv=none; b=eDdHNdQQQtWhes8zcei3DsD0RQczak8G33X9+GsVchckzAjtov8SuSSYO+Wawm1dkDv6E3PoNolDZDXvKd94WNIhTf3TOeizrG97Yrn+Aq/1+sM+BCMqdXxrkWc+oLGVgK/enjHfB19nH+tEa28LV0Apk8qAYhStyfMKW8I0s/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750382402; c=relaxed/simple;
	bh=rrl3PdMlpdzHY1uP19vVOuZl5fwWr3QCU4IohSbHtrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPEKdVDQbQWaca3JZgtvlBilFpQJDD1A0C6sGZ25ZdTpLjfTU2SzTpx4amDDXG3k7D1P1cxZWXJ+L/OrQLX+1K/8aGQCimS+HqbytRgG3qgdv1k6o43C4AhpLEic66ODBtW1fG5x1IrI2GRfjxrVG2pPS7BoE+UIiNfAoWAcljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Jw2S/Jib; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Jw2S/Jib"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1750382395;
	bh=rrl3PdMlpdzHY1uP19vVOuZl5fwWr3QCU4IohSbHtrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=Jw2S/JibFZFZZwRpQaJ/Wbho9EcKVsFhHxL+up7RFpuyuUjzXfbkhjtZAkCAOYTMK
	 V55+mF8vaw7PqRIlg7E5mbqkeJ7f4iHTg/TPWk63kiuf3grB47W+TItFK1pMC/ZVl9
	 sOC9dgD102O6UXth23E/19ynmpPcmGYFCSTwMX0PNzSm0mZ36zXhzMh6BWJT7eCUQm
	 3RwOAMiM6JPkOShZf+k8Jck2o19Kx6ikawene/gpjeIaJ0nSVZNSWXayZ5+IW3+Ftf
	 mP2J4pRvM+uKLvPt90z7cS5w76BrO3QrjUzF+KUT6uqdH7xLeRaAtUq+RPCQUcxNxE
	 vctOigpyu65dV/MxC+OhgXnLPYcyY82++DMZQCN8NsYf1B3+8YgknPZ7hbLRebxjTJ
	 zGF3z9VfQsPd1Zg+kq5dyUZEXZYCrqCo8HeMe70AWNFssq22pgSayNEr/aQ+SeNOwY
	 ZuOsBeGcWLn9DpVnV6PaBliPyfp7NTuug/8/zJwsDMVQMfuHosu
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f445:674a:9eb4:f272])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1C3EA2019B;
	Fri, 20 Jun 2025 01:19:55 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 10/10] Enable SHA-256 by default in breaking changes mode
Date: Fri, 20 Jun 2025 01:19:42 +0000
Message-ID: <20250620011943.586596-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422f
In-Reply-To: <20250620011943.586596-1-sandals@crustytoothpaste.net>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our document on breaking changes indicates that we intend to default to
SHA-256 in Git 3.0.  Since most people choose the default option, this
is an important security upgrade to our defaults.

To allow people to test this case, when WITH_BREAKING_CHANGES is set in
the configuration, build Git with SHA-256 as the default hash.  Update
the testsuite to reflect this configuration so that the tests pass.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hash.h        | 6 ++++++
 t/test-lib.sh | 7 ++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hash.h b/hash.h
index 0e14cade4e..144b53b7d6 100644
--- a/hash.h
+++ b/hash.h
@@ -174,8 +174,14 @@ static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *s
 #define GIT_HASH_SHA256 2
 /* Number of algorithms supported (including unknown). */
 #define GIT_HASH_NALGOS (GIT_HASH_SHA256 + 1)
+
 /* Default hash algorithm if unspecified. */
+#ifdef WITH_BREAKING_CHANGES
+#define GIT_HASH_DEFAULT GIT_HASH_SHA256
+#else
 #define GIT_HASH_DEFAULT GIT_HASH_SHA1
+#endif
+
 /* Original hash algorithm. Implied for older data formats which don't specify. */
 #define GIT_HASH_ORIGINAL GIT_HASH_SHA1
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ef3759ec80..bb18dd0606 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -536,7 +536,12 @@ export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
 export EDITOR
 
-GIT_TEST_BUILTIN_HASH=sha1
+if test -n "$WITH_BREAKING_CHANGES"
+then
+	GIT_TEST_BUILTIN_HASH=sha256
+else
+	GIT_TEST_BUILTIN_HASH=sha1
+fi
 GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-$GIT_TEST_BUILTIN_HASH}"
 export GIT_DEFAULT_HASH
 GIT_DEFAULT_REF_FORMAT="${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
