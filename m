Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5012284885
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 21:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760047002; cv=none; b=i9i/H1E+/+iuJWAUagVpcq6vLcAoFq60ihyqxkseD9MNK/PVeUuV5LowBXrQNchsQqdAsSfHKV5+w7QeM/chM/CSYSl13OWO0JnEhAgZgFtycOAOZzJKVqPWfIl0eboQ86LMCJ+f+w2DBztpvuUcui4Nhoa9DSIZP0LIBAxeEgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760047002; c=relaxed/simple;
	bh=jnyLe6zHukcuonAA3mAbrd4guvQ80LpZL0Ta5Wg0YaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vF5dt90b+7fBSOzIHzrfbyfY4F38fdOijpm/a7Xc3+3P7QUMr4UHUyXoMQrVEh9mLR9j8rJbOiWQSKNfbMyGSsaplB+80d7o/GS+VOW9JdSRGDbOYh2K8zJWKCGMzUiVyds9nGTBUg4KljQZARVfLZgdoGnf5buVF/kEwwQjoVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=kpxebX+c; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kpxebX+c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1760046989;
	bh=jnyLe6zHukcuonAA3mAbrd4guvQ80LpZL0Ta5Wg0YaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=kpxebX+c0DJK0Fb6O1hBysa1bEHldk75UmadR2kMzFfWQ6t35ypD5+Q4aKtqlXNLA
	 Fx5yFPST8OJl1Xmcg9iJarBjH9pA7cpQPqmZml3Is5/jDc340DY/0V4m8kvhm1DlVc
	 POXgVpMXHpGm85xg18vQbnX7hLhOrdt1BnbslcNvW0caAwgeKNWxUQ1ds0bqpHzHy4
	 PM8/wCPffBaqcbw+kVXKrPIsHcNcLDK7VMdV1dHzC6FIZshrWLH2wc8oBUt6tZvMVi
	 X5Ef17TXAn54vNvKETpgtg5ijIWGR67hQYO7Xx8MF1z8tMeJ5HNnKE7JgB2Z74KIbf
	 uKdJfiuRDpo+Uyy2+9mSD90dkhgveQ3VYippnid3lT1oHuzIGDUqEy+eaBiY+nXOZr
	 CHHB5oqGBl6oucdCNjXQJSAwKwPSUtDJV4VS1qufJYXMKP56FFv09wv5d2OhzCiDlM
	 4Xq5X6SNlIaTbXUwFCmHoGBN0xMcpzqyZQuGf9e01dLfWc8lXwa
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d7d2:5118:6dfb:100f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9D19A231FC;
	Thu,  9 Oct 2025 21:56:29 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 9/9] t1010: use BROKEN_OBJECTS prerequisite
Date: Thu,  9 Oct 2025 21:56:26 +0000
Message-ID: <20251009215626.3089287-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251009215626.3089287-1-sandals@crustytoothpaste.net>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20251009215626.3089287-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When hash compatibility mode is enabled, we cannot write broken objects
because they cannot be mapped into the other hash algorithm.  Use the
BROKEN_OBJECTS prerequisite to disable these tests and the writing of
broken objects in this mode.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1010-mktree.sh | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index e9973f7494..312fe6717a 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -11,10 +11,13 @@ test_expect_success setup '
 		git add "$d" || return 1
 	done &&
 	echo zero >one &&
-	git update-index --add --info-only one &&
-	git write-tree --missing-ok >tree.missing &&
-	git ls-tree $(cat tree.missing) >top.missing &&
-	git ls-tree -r $(cat tree.missing) >all.missing &&
+	if test_have_prereq BROKEN_OBJECTS
+	then
+		git update-index --add --info-only one &&
+		git write-tree --missing-ok >tree.missing &&
+		git ls-tree $(cat tree.missing) >top.missing &&
+		git ls-tree -r $(cat tree.missing) >all.missing
+	fi &&
 	echo one >one &&
 	git add one &&
 	git write-tree >tree &&
@@ -53,7 +56,7 @@ test_expect_success 'ls-tree output in wrong order given to mktree (2)' '
 	test_cmp tree.withsub actual
 '
 
-test_expect_success 'allow missing object with --missing' '
+test_expect_success BROKEN_OBJECTS 'allow missing object with --missing' '
 	git mktree --missing <top.missing >actual &&
 	test_cmp tree.missing actual
 '
