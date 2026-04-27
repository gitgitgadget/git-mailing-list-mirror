Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFC534DB6C
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777328328; cv=none; b=Lh3JD/QEotYUFfklucLdZYm1dtyxL0hpllRDGP5jvMxcPJlbUJuXF9L3tfnjXaglEmfUbE9l/b0bubkZJ6uhaS3OolzbikzQcqcU+uGfx+zEXcAxCDqlyuznwCzgXVVqNAQ+0njN0wE14W8Qw+7YP9jgterVOGGxl/3yeoobi9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777328328; c=relaxed/simple;
	bh=xxyXi1qV1OJMgwi2zGKJXTjI0j8ZvTUWove0WajEQdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGI0zwHTqk8AJLrsae0KgbdcB5OMbOphT2d5bpMXU1MLU2RvgajGWl+ufpPYd3IY1bMR0FBSMTt8pgbTguIpCCxgLsT6XXBBKEBsAVMqFqWGwEcmu2G8aFO6nGdEhB3Z0wfpa5+zXmQ48GpNx/HFY8uGEwnXYIS72r+gFqbG9MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=TpXuwA8v; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="TpXuwA8v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1777328319;
	bh=xxyXi1qV1OJMgwi2zGKJXTjI0j8ZvTUWove0WajEQdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=TpXuwA8vXOSIoJDxWYEkbHgZ6hmkPfG8eufUB9+DbDw0cxm1iRTHnm7YjWM6odrFB
	 Wn3RcO3c+BScsQy6N7PaEHo4hZZFRokuaJ96DxVMQ5pYQO+Ve13s9WFYFxMI+c4P88
	 v4/N1HCrs0RWGQOBjp9nYsGTukVSVz7DSq+lJMZh9sqReJRLsR0bXbioE0nLTYSGLR
	 JwNQiL3YPeZScGXiuprh/p4Di5zZytvytAacyu+QMLrqJQWZZV4pUxWG8H/WoiHm1c
	 be9n1iWuaCt8GY+KQrtyRapstAloe862ARZQbjUTP9EWI+8GS1stYFIr9+Y+1LFiPe
	 bF3qjmBJBnTyta51bpGqM19ln+bp+tQYnrjprJdfp76V7+3PkKwE8zV78xDtn0O3np
	 MNkcl4D+Xed9jeRLi1QgJ2jq9BvpylCOd3jqj+R+VuaZvi2eacN8RUAwnKgTSsnx+/
	 0ge/QLHu8ktUp2syHCmhtRxTi3cFS09Z3QMv/YHe3phvKtqbABu
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:83ef:6e6f:372d:4e85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 2D1902006D;
	Mon, 27 Apr 2026 22:18:39 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kushal Das <kushal@sunet.se>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 1/2] commit: name UTF-8 function appropriately
Date: Mon, 27 Apr 2026 22:18:33 +0000
Message-ID: <20260427221834.1824543-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <aeakf0xcjSteTMZp@fruit.crustytoothpaste.net>
References: <aeakf0xcjSteTMZp@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have a function named verify_utf8, but it does more than verify, it
modifies the buffer if it is not UTF-8.  This is different from what
most people would expect, so call the function ensure_utf8, since it
mutates the buffer in some cases.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 commit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index 80d8d07875..790dd2faed 100644
--- a/commit.c
+++ b/commit.c
@@ -1637,12 +1637,12 @@ static int find_invalid_utf8(const char *buf, int len)
 }
 
 /*
- * This verifies that the buffer is in proper utf8 format.
+ * This ensures that the buffer is in proper utf8 format.
  *
  * If it isn't, it assumes any non-utf8 characters are Latin1,
  * and does the conversion.
  */
-static int verify_utf8(struct strbuf *buf)
+static int ensure_utf8(struct strbuf *buf)
 {
 	int ok = 1;
 	long pos = 0;
@@ -1819,7 +1819,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	}
 
 	/* And check the encoding. */
-	if (encoding_is_utf8 && (!verify_utf8(&buffer) || !verify_utf8(&compat_buffer)))
+	if (encoding_is_utf8 && (!ensure_utf8(&buffer) || !ensure_utf8(&compat_buffer)))
 		fprintf(stderr, _(commit_utf8_warn));
 
 	if (r->compat_hash_algo) {
