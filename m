Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3305128507C
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759444753; cv=none; b=IIZ7ZMzetJA0JIXzW6ECiNxaYESt1kEl2jngeRbe6cly0/5BL+bvKiTP2TUEDBgt12UEA2uYF9ww0FIMUuaHHe1r5dN5ArioTKYXQtRLXlBBOhvfH+GbGv9pkpLbEAio4Vj+Qv9EvdWzzz7jWSWU9+NNlYXAv4b3XHEm4FASIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759444753; c=relaxed/simple;
	bh=jnyLe6zHukcuonAA3mAbrd4guvQ80LpZL0Ta5Wg0YaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJM6IqSqr5QNVH1TGEaadM21o95PNLxOfTcLnUby91kOoI34tIj6Um3TqswQySEPJb8vyq7WrpMGCrZltWkSSxWCkYdH/3b8t1dWZx5ie9Yb7EGFM/BSU9Xxgg/TgbcgJr8M0qJ6Gh1LN5OqmrKNxTpsIQupzpxYAtIuF1g9fBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=EcxOMED+; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="EcxOMED+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759444746;
	bh=jnyLe6zHukcuonAA3mAbrd4guvQ80LpZL0Ta5Wg0YaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=EcxOMED+6v7bMqi41ctBnCsViDPhJbcZkAK0eNlUN4zJvrjGMRWfhqYjnX4n5wQUI
	 eimARJeEhRrx21i1C4NmDfq7nwwFyUcQKRSKM5KkZHLpTFysN5qzJO0qZZuWVmATtf
	 mRKOYl+XTnAXG8M5lPzRHf8+MxhU3oDzj+NdpXWvjKlkeFvADsTYUX42UWtvz7NmVR
	 WAyA0Wuob5j1dEgTkqBiB2Z16e7gpSEicN9fiENiS2IGaZuyJekql0ZHjnpNAOq/nP
	 R6QP/qDJ5yoDqQ1nZnVY6SUqyWYy+kkyqYRHDjfApPk4+zEQEIjfif1WL+uWKeMdim
	 7OrcjrA2uCI+oqtsUeGN8p34RsTqfv7bvz1BzF2qeDdbAoHn3ouXVczEG9Mbca/8vl
	 P/kgTzPgxCLfjHeuOE/Ri4sY2VQIzqHNl30o42480fTns7bMVu7nMuzNS5eS6Kd+EB
	 Hl1ME29TYQQwi063qpQumMxq0dMCQBvk1SYtvX0v41awYEzvkS4
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b8e7:3022:3f31:478d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 74F69231FC;
	Thu,  2 Oct 2025 22:39:06 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 9/9] t1010: use BROKEN_OBJECTS prerequisite
Date: Thu,  2 Oct 2025 22:38:55 +0000
Message-ID: <20251002223855.1022847-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251002223855.1022847-1-sandals@crustytoothpaste.net>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20251002223855.1022847-1-sandals@crustytoothpaste.net>
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
