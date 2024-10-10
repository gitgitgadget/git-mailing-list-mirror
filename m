Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9D81E8849
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 23:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728604599; cv=none; b=RltAJhymoCH/sbXME2ui2PncMfaDT10uU/tL6zOR1AEkYoAL0r6hEDZ55V79N1FVfDe9z9ItiEooVWA42j5FARkVObigBP21X//7ZmtodMgpP8SX9jbFgQoOhybW0TDRMIJiMLrHKwLux2uz4Sn41edUiZ1JeIYSAIg+UjIHPlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728604599; c=relaxed/simple;
	bh=8w0UuLbT1GF7DW2uvm6+8bk6iPrUfl/xm0kSoWBbMtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMMEQX5VUButVaoJRBF+YiTQeo/w7aqjOpdBOPATnwBQgDiSvplx57TVWsWBI/LJ0NIG1banVLWa5Z8gR5+E/x+dsnKEv8BLTARm15MBvRmnwcRBHV046rnfvLHjqKA0fBAAh99ivep33/mfmGpaDSuN/r0jBsa5LaUGgdjgMNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=NTM6pY+x; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="NTM6pY+x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1728604594;
	bh=8w0UuLbT1GF7DW2uvm6+8bk6iPrUfl/xm0kSoWBbMtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=NTM6pY+xzKPCNFKFC8GORBysLxmvw2b809F+Hmng/wzkSpz8qRqHiDRjvjvbj0VzM
	 vPtS4RZvfvtLjdc345U7xJOMKW1sqd769kTyefnLgVurDSlrIiXP1h1yd8y/zVtui0
	 OXhEJkFSV/CLllpLAwSDGNlEaOfbRfwxgYuvrhqXM/KzeuAO0ipmXfYMWaAY2TyT98
	 WZ4ukD60XSUXoKpNUuvAatURgc0JW3bql/kcO5NwmomnHNmIMX/7U1ac1ssrJilXww
	 vKXIzdBVhWycFpVjxk705YOAUvxCTy0dD02JYfiCP6Mm0SNKPf+tgBvognnyyHTwa8
	 YtcbwZ80Rfbyk95uMhpzrDgOg4nvVdSLdFhP8EgIhmY04OvGncmZf3iyCb97ExLRCo
	 hstqbsJ6FYn1L+0Hrdlg51ms0Z15jcXYYh78L8NfwNQmvaqxTSZGC159xzkes57nS0
	 MC5YoktjwEUAsfbfEriG3SdsYX6ytb1RqgEB2YZSy8ZYFg0TdR5
Received: from tapette.. (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4FD0F200BF;
	Thu, 10 Oct 2024 23:56:34 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH 09/13] git-curl-compat: remove check for curl 7.56.0
Date: Thu, 10 Oct 2024 23:56:17 +0000
Message-ID: <20241010235621.738239-10-sandals@crustytoothpaste.net>
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
