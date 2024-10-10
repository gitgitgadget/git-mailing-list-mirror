Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F351E7C34
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 23:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728604599; cv=none; b=CldJqAqFao29CC24yayB5+3Ir5gSfSnVHoP07N595clIO2EziAlDZS4lws4tF+zcLtX2lYSImRvJ5Wh4d01GyecuD9N5u/YLu6JwHp767RF700gXKsKhrs/UeShaiqikdmFXrt9QztODYoNXYG6+vqX19whcmjDzpF979SYXpbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728604599; c=relaxed/simple;
	bh=dtfw2xRbiDHcM4T1nUorlbwVxN0N9b9G/mFEo9WO2M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIPsMV94XT5cBFLeytDorYw9CTxGsY+OzD+2m+IuLOgeHdHLFV/yMV8z+KlmN8AxWIi0fm/k+I2FD66uCyLLEqqvK9C0f/a/F/AgHzgWVzkTRqTCBAeEC2XF7RSVWAq/n+mP7EPw0UpDWp4FycEXAoUi0n4uc0j4O4bgSKfVntw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=DmNlynHn; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="DmNlynHn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1728604594;
	bh=dtfw2xRbiDHcM4T1nUorlbwVxN0N9b9G/mFEo9WO2M4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=DmNlynHnDw1OYCjC7dCVmJ+aA4V2G6Sec73iQX0QPtQa6Kkhspu3mH1Pae6JIZSJL
	 xcCjKbgTUEiRvpJQqapE6aOeLcSlQuYnNCstf1Z77s6qXnZX67vC684vm04xCou1wT
	 a/m+eS8bB6pkOJbGi1UoQ/7OG9sZkBGRn0E6erH9cbVt+GX5MDoqFAQ4pLuYAO7XQB
	 egdIXc4uf3xWmIDxuPmhA2+scKaiSmEB7jqgV3htyaPc4g/kNKJexqebi0GzjY2NfC
	 tVlHo011wx8NahFeuDlxd7k7sGxGNqLUapY2tOCfiSHo1ipY/qYf+g8Dv6dVdEJEQC
	 RP+tzBva5/JNXaiG51beCZ1gLWOwojqYWH21XN3xZeqxTAqKhuF/JfYhAfn2hjqhXV
	 SzAC7e3+wNx943V5JB11EiHVjyDTHq62ogse/lwuz2YHuxjcR4mwrepdve8DhBys9u
	 qhWrjbJ/TJZhtz6hjZeII/Jc96u3IQXGILJfNKGHe7yZV1JEo8w
Received: from tapette.. (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 27047200BC;
	Thu, 10 Oct 2024 23:56:34 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH 06/13] git-curl-compat: remove check for curl 7.44.0
Date: Thu, 10 Oct 2024 23:56:14 +0000
Message-ID: <20241010235621.738239-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20241010235621.738239-1-sandals@crustytoothpaste.net>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

libcurl 7.44.0 was released in August 2015, which is over nine years
ago, and no major operating system vendor is still providing security
support for it.  Debian 9 and Ubuntu 16.04, both of which are out of
mainstream security support, have supported a newer version, and RHEL 8,
which is still in support, also has a newer version.

Remove the check for this version and use this functionality
unconditionally.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-curl-compat.h | 10 ----------
 http.c            |  4 ----
 2 files changed, 14 deletions(-)

diff --git a/git-curl-compat.h b/git-curl-compat.h
index cd970e34d6..6b05d70d42 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -28,16 +28,6 @@
  * introduced, oldest first, in the official version of cURL library.
  */
 
-/**
- * CURLSSLOPT_NO_REVOKE was added in 7.44.0, released in August 2015.
- *
- * The CURLSSLOPT_NO_REVOKE is, has always been a macro, not an enum
- * field (checked on curl version 7.78.0)
- */
-#if LIBCURL_VERSION_NUM >= 0x072c00
-#define GIT_CURL_HAVE_CURLSSLOPT_NO_REVOKE 1
-#endif
-
 /**
  * CURLOPT_PROXY_CAINFO was added in 7.52.0, released in August 2017.
  */
diff --git a/http.c b/http.c
index 945df9a628..bdf8bf7b59 100644
--- a/http.c
+++ b/http.c
@@ -1048,11 +1048,7 @@ static CURL *get_curl_handle(void)
 
 	if (http_ssl_backend && !strcmp("schannel", http_ssl_backend) &&
 	    !http_schannel_check_revoke) {
-#ifdef GIT_CURL_HAVE_CURLSSLOPT_NO_REVOKE
 		curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, CURLSSLOPT_NO_REVOKE);
-#else
-		warning(_("CURLSSLOPT_NO_REVOKE not supported with cURL < 7.44.0"));
-#endif
 	}
 
 	if (http_proactive_auth != PROACTIVE_AUTH_NONE)
