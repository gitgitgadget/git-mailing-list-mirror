Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCC336B07A
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771336723; cv=none; b=YmnFa9MwJMV4M8Eif/Rl+gU2WCPjyFKb30B/MVYW434xwAuqjZ7wK5RkZTBzPcWipw4UwTviqApFUUCi9YgJ2TWlBKBkU9R5Zyw6PSjfqAvt45vxkT8aFHzKLipuct0TALdl45eDX6ctT93uqACg1eVqHZwinFfNl5GhpdTWO4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771336723; c=relaxed/simple;
	bh=+9YJQah0AS9/Smrp2aGNFejoryFZUYpPhMbx/TjARG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lqwTprLM2NvTMXDTGnM1nsT/pATLgG7L9h7ZS2ILSCRnvWjUrtcYUWVGJMgyskdEZKo9MSTGNgpFOkSYlDdF4q3ULY1ydBYt02iXv8Mwk78EGVUhTW+VR4A6VwxxBBcH1RQQFGp/XVRtehGj+7O0ApljbSKsSHs2/wFHAq3tGOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i+R2M78f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FbNal7w8; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i+R2M78f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FbNal7w8"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F34251400176;
	Tue, 17 Feb 2026 08:58:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 17 Feb 2026 08:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771336720;
	 x=1771423120; bh=C8fjnlJvorIrHv+yC8EwHiWeZKbP/PX05MTujbEVWsA=; b=
	i+R2M78f8X2FfIrrprcQaNO9q187nc8mFmMeSt7GaYzEZwXxnw1b6lu0ujWAPZJn
	E6ZwExHXYUd8Z1b8jlVP6L4a5x2JBlGBgB+eVxcB285DUyxtEna9tCGkknpzN6R1
	rzEPH7V435BUl9uAviWBIhS9bcPFaY2CyIUYcTl8x42IpBNS1twt6tuxp081xwAW
	KYd72HOIKNdwckVHRLhwhGNBTYcQj7DiAPgfTT6VkodneslP5FPBx49dlyNt/wUw
	e6FOHcrG3CUkv/R7KPYZ1/WHDA2P+yjsjFyYgkbiGlfe8mtK3fm22bLRpu+8Vvmz
	3uNR0OCjserwvPWiECqFeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771336720; x=
	1771423120; bh=C8fjnlJvorIrHv+yC8EwHiWeZKbP/PX05MTujbEVWsA=; b=F
	bNal7w8PF+T0ggSmhL7R12mZ4TPYz8aRVuNGh9jEY2K3irv+Y6PGIUJrUAjw1o/U
	dJ/XiZb4dppLDC6adz+D+en6NZG6YJgHsYFAKzohgxO3slAr+iE0wSsoAPlMSz3Q
	AzqsBwscirmP1Zgh28inoCle5zdZBJW1QfN/TuahuN/vTfJQs5ieZ4n8Gka9o6gh
	Q/XLxJrNqvXUnQLTdCp8ps2UY8mR17L0uJGPxswbRLn808jipd00iJ60nemnVdMB
	+jrFwPEk7YN6s/8laF8PztU2QUNGGugcpcyX40Km5cUm7JmTwYFcVhoUy5zGBVLU
	xTmBL/Irp2ZqIZfevQY0Q==
X-ME-Sender: <xms:EHSUaVW_4FA5-wg__1WC1fNqXnX42FF6VvLHmvvLrhAfji0g69E9tg>
    <xme:EHSUabl0h0zSfylfQvA9mIS0QdcFxehISOMeH00-7Hw9bUYv0ZrC2qUKmpzsSCoXZ
    zGFkTffzOotZXIRKi47BiMdnY7PT9NsyPkRWjJd643gqZqyyHRna5E>
X-ME-Received: <xmr:EHSUafDeX4UbaXcRIWR75umK3IwENbS5PlxUB6cLPhj0Iw8kmKtZPiclGCwxEc__j7V1O6J2aZJrjRuOeJykvg4ePcAfL7X4I1aaS9lNCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepkefggeejueeuuefhvdettdduteeuteegue
    dtgffgvdffhfekfedtleeihfeuudejnecuffhomhgrihhnpehhthhtphdqfhgvthgthhdq
    ughumhgsrdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:EHSUaTfVN7lvv9kvftxZ5LarWHmbbi2pu0MkA3HX0pah_zGo0aqH0A>
    <xmx:EHSUaSKwzzD1u43FQpiS0KlDzhSDhbiw6wG1Sc3HSnlR44CKLfkfGg>
    <xmx:EHSUaed1nNkO2AucjrF1mMJ4SVK6IFCyMQlJfs3lDvJ3iTmMhoqIow>
    <xmx:EHSUaR1wFBj_sfcfcsFx_F9CAVMRw2aTFwfyoQ_rtFleduWZTI9ulA>
    <xmx:EHSUaQscOSr7ZxbRZHhnN3fqWnH-y7eV-1Qn7ToSyHswH161dJWDW7Wd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 08:58:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5e24d180 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Feb 2026 13:58:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 17 Feb 2026 14:58:29 +0100
Subject: [PATCH v2 3/4] t5550: add ICONV prereq to tests that use
 "$HTTPD_URL/error"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-b4-pks-ci-msvc-iconv-fixes-v2-3-25491bc8dbf8@pks.im>
References: <20260217-b4-pks-ci-msvc-iconv-fixes-v2-0-25491bc8dbf8@pks.im>
In-Reply-To: <20260217-b4-pks-ci-msvc-iconv-fixes-v2-0-25491bc8dbf8@pks.im>
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.3

We've got a bunch of tests in t5550 that connect to "$HTTPD_URL/error"
to ensure that error messages are proprely forwarded. This URL executes
the "t/lib-httpd/error.sh" script, which in turn depends on the iconv(1)
executable to reencode the message.

This executable may not exist on platforms, which will make the tests
fail. Guard them with the ICONV prereq to fix such failures.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5550-http-fetch-dumb.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index ed0ad66fad..55102e702c 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -339,32 +339,32 @@ test_expect_success 'fetch can handle previously-fetched .idx files' '
 '
 
 test_expect_success 'did not use upload-pack service' '
-	! grep "/git-upload-pack" "$HTTPD_ROOT_PATH/access.log"
+	! test_grep "/git-upload-pack" "$HTTPD_ROOT_PATH/access.log"
 '
 
-test_expect_success 'git client shows text/plain errors' '
+test_expect_success ICONV 'git client shows text/plain errors' '
 	test_must_fail git clone "$HTTPD_URL/error/text" 2>stderr &&
-	grep "this is the error message" stderr
+	test_grep "this is the error message" stderr
 '
 
-test_expect_success 'git client does not show html errors' '
+test_expect_success ICONV 'git client does not show html errors' '
 	test_must_fail git clone "$HTTPD_URL/error/html" 2>stderr &&
-	! grep "this is the error message" stderr
+	! test_grep "this is the error message" stderr
 '
 
-test_expect_success 'git client shows text/plain with a charset' '
+test_expect_success ICONV 'git client shows text/plain with a charset' '
 	test_must_fail git clone "$HTTPD_URL/error/charset" 2>stderr &&
-	grep "this is the error message" stderr
+	test_grep "this is the error message" stderr
 '
 
 test_expect_success ICONV 'http error messages are reencoded' '
 	test_must_fail git clone "$HTTPD_URL/error/utf16" 2>stderr &&
-	grep "this is the error message" stderr
+	test_grep "this is the error message" stderr
 '
 
 test_expect_success ICONV 'reencoding is robust to whitespace oddities' '
 	test_must_fail git clone "$HTTPD_URL/error/odd-spacing" 2>stderr &&
-	grep "this is the error message" stderr
+	test_grep "this is the error message" stderr
 '
 
 check_language () {
@@ -406,7 +406,7 @@ ja;q=0.95, zh;q=0.94, sv;q=0.93, pt;q=0.92, nb;q=0.91, *;q=0.90" \
 
 test_expect_success 'git client send an empty Accept-Language' '
 	GIT_TRACE_CURL=true LANGUAGE= git ls-remote "$HTTPD_URL/dumb/repo.git" 2>stderr &&
-	! grep "^=> Send header: Accept-Language:" stderr
+	! test_grep "^=> Send header: Accept-Language:" stderr
 '
 
 test_expect_success 'remote-http complains cleanly about malformed urls' '

-- 
2.53.0.352.gd1286b26eb.dirty

