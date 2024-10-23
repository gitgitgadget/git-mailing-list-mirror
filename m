Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5648224B34
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 00:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729644370; cv=none; b=PfF1Uf73THkNGcSjyMRov/7iqbiFWMlvgJlRyNjNC8+z/QCx9x4hSqbfqgyImVqNy4vz005OL2gYDTtZW3GHGOtc447/YNT8VnOHXPdVbDl+3CVJFlUNF8T39ftyv0lLofsZeoofsMyLvdLsaeRjBZOFqZAbaAZ+Fnv7r1vuP44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729644370; c=relaxed/simple;
	bh=8w0UuLbT1GF7DW2uvm6+8bk6iPrUfl/xm0kSoWBbMtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJr3VLpQ6168Jdk6Y8GtQPpebA5lzKsXdER4EVL7hlyfOExIuswuLT6jV6EjzxMubrFOrlLPjKCAj7i+RMqefF3fl2jZuC1oCnlCBvUOCKLCCM9LcB2XcmjjZKNTHCEIdLEy8ctBM95nU0CQIdbrt4mPFSAaO/zyOWSwl8SG7HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=acTiVAmg; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="acTiVAmg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1729644364;
	bh=8w0UuLbT1GF7DW2uvm6+8bk6iPrUfl/xm0kSoWBbMtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=acTiVAmgr6GnK0VOOAhmn2kqOkT2c86v6OD/RYTefx24nW74kpiDyBW+tXv04FtS4
	 QQ4kWhySmZpDED4h6V36dS53LZlVHwFMBFNUFlGljOEY+cnHpW6Av3zWWk79bTuhqP
	 nquaCeUdYe+Ro/h+nosbnulKwav/DluKfregRaquwraxxZmqpc783V00T7RLwU1ajP
	 gdTZkTe3xyrVDMjGGJruHCK5HSDTw9rHK6+JsS7u+o4CsXRWje8IkaTAfX+SfxWva0
	 ie/0iqYe3ihcJ3gVRysIS6JNNZ2cQg6sXooUJxZOGrrwe6SpXxLhQssksX/Mq/aE54
	 /qzaCv74+BQqpEk8/sZXLDp7/t6WGbMu4/m2HuadOKYMDwHokZ//ElI06oxvtINxXX
	 iEB8HmGt39myNmQ6KKpvEEz175E0/CJCFLzfhWBujFfEaThLNEY5A+PnU0yf/FZcfZ
	 Fjy2M+4fr9Nlf/wds2jCzcLpQNE7p0cjtS93a2CYwIlfT5cr71E
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 79D60200C3;
	Wed, 23 Oct 2024 00:46:04 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 09/12] git-curl-compat: remove check for curl 7.56.0
Date: Wed, 23 Oct 2024 00:45:57 +0000
Message-ID: <20241023004600.1645313-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20241023004600.1645313-1-sandals@crustytoothpaste.net>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
 <20241023004600.1645313-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

libcurl 7.56.0 was released in September 2017, which is over seven years
ago, and no major operating system vendor is still providing security
support for it.  Debian 10, which is out of mainstream security support,
has supported a newer version, and Ubuntu 20.04 and RHEL 8, which are
still in support, also have a newer version.

Remove the check for this version and use this functionality
unconditionally.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-curl-compat.h | 8 --------
 http.c            | 2 --
 2 files changed, 10 deletions(-)

diff --git a/git-curl-compat.h b/git-curl-compat.h
index 65ba1ee0f8..703756ba85 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -28,14 +28,6 @@
  * introduced, oldest first, in the official version of cURL library.
  */
 
-/**
- * CURLSSLSET_{NO_BACKENDS,OK,TOO_LATE,UNKNOWN_BACKEND} were added in
- * 7.56.0, released in September 2017.
- */
-#if LIBCURL_VERSION_NUM >= 0x073800
-#define GIT_CURL_HAVE_CURLSSLSET_NO_BACKENDS
-#endif
-
 /**
  * Versions before curl 7.66.0 (September 2019) required manually setting the
  * transfer-encoding for a streaming POST; after that this is handled
diff --git a/http.c b/http.c
index c5fdf1cd4c..4d59f11ad2 100644
--- a/http.c
+++ b/http.c
@@ -1275,7 +1275,6 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	free(normalized_url);
 	string_list_clear(&config.vars, 1);
 
-#ifdef GIT_CURL_HAVE_CURLSSLSET_NO_BACKENDS
 	if (http_ssl_backend) {
 		const curl_ssl_backend **backends;
 		struct strbuf buf = STRBUF_INIT;
@@ -1300,7 +1299,6 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 			break; /* Okay! */
 		}
 	}
-#endif
 
 	if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
 		die("curl_global_init failed");
