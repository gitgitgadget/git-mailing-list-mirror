Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC641189F54
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720568337; cv=none; b=jWsukdpbJ604Ko8vGTgJnoMDlVl4JiMGqL45QvOIwVDQ3TZlJd+ouX9w2tqb5azuUEEhOt6Ynqjb2qbLf7n4z0wZrXm8VX4FDuPh23LYSZ1HzgZaEgfSdQYW9hnSx82bv/G7m3kzIYLFGnwhNkiNbqjbqQ5dKuwTrj9zxgN8AQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720568337; c=relaxed/simple;
	bh=Ddpg71eDm99y1YtJE85ulYA4kSVEGfhXpF2+21TIyt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibCTZja+mACoLa6C4QqyHonO16zLDWw+/2sQf+izUm4W+90PAez+AxpP+2wtqPqHauZJ3KOJwVha/GD8keXYzcM0Vzdi0gT3oaR/R781jHTdDg+Hmo3FxRPy84diW/UW5luvfPU0OL0HOfSIfzezdbuCl4Udzyg/+JbmbtLXts4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=F/5Q36hI; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="F/5Q36hI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720568334;
	bh=Ddpg71eDm99y1YtJE85ulYA4kSVEGfhXpF2+21TIyt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=F/5Q36hI7Gi8to9/cILUCTGBV3JfOWGmuul0NQ1wJXbJ/EabrxQbOdh6VZ8QPCD9F
	 uR3E42VnvBBawbWYuAgtYFgNULnDm29RGcBHt2nwFcaesOn5tHhKDHj8HUWU62uz+G
	 reF7HKSo4zTtkG15khSNQoqI7qeIpEP2Yu5RKWCDndpnRKwq73+byanSdkZMS2N2RY
	 xX5CRXz4OnS/UfuzxGVfp3j9mnLwUOT/nV09FWC9WU02ZWH0NTcqthNUb5r1FeR4uU
	 cYjW/ypKLpbwG0e9qtmjpB5BE1D7ydt3vsGNui5sszDQPR4Vc86516pGj7XV+VLqpF
	 J6L4LsEBMPn5RJsoD9enNQMFDNED4a+YgWQJpn3iTorjBBo/J6kiHKUpm1gLZN/Y/N
	 YUUyI2E7Dc0fPP2XjbmnQorE1AuUXCMn+do7Yvcn9WxcpUQHBOwWHkMoBQV5zhNZVQ
	 NJUF3dAMxNkOq7YUogg4wYsiT9M6lLcTpW1AnyglTHf0tclt6Kp
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0A3BA209AD;
	Tue,  9 Jul 2024 23:38:54 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Derrick Stolee <stolee@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v4 4/4] doc: mention that proxies must be completely transparent
Date: Tue,  9 Jul 2024 23:37:46 +0000
Message-ID: <20240709233746.445860-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20240709233746.445860-1-sandals@crustytoothpaste.net>
References: <20240704003818.750223-1-sandals@crustytoothpaste.net>
 <20240709233746.445860-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We already document in the FAQ that proxies must be completely
transparent and not modify the request or response in any way, but add
similar documentation to the http.proxy entry.  We know that while the
FAQ is very useful, users sometimes are less likely to read in favor of
the documentation specific to an option or command, so adding it in both
places will help users be adequately informed.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/config/http.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 2d4e0c9b86..a9c7480f6a 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -7,6 +7,11 @@ http.proxy::
 	linkgit:gitcredentials[7] for more information. The syntax thus is
 	'[protocol://][user[:password]@]proxyhost[:port]'. This can be overridden
 	on a per-remote basis; see remote.<name>.proxy
++
+Any proxy, however configured, must be completely transparent and must not
+modify, transform, or buffer the request or response in any way.  Proxies which
+are not completely transparent are known to cause various forms of breakage
+with Git.
 
 http.proxyAuthMethod::
 	Set the method with which to authenticate against the HTTP proxy. This
