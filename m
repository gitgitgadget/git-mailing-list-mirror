Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB3E2F0673
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 04:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771389540; cv=none; b=jGlBXXk6M4GdH03jpGOCQjMlf6OTNjhuNJI64h6OsrZ96T244HEt97BN4GBrx6Zbytd1bxYvDEiGKt7lnzbUDBknVGQeDY6TuREc2wDKTtxgHu/erjFJzDV5k/9NNdRK77S2htTtAuuV6+pFUuzNahi40eWQuQObTpnsECkWcaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771389540; c=relaxed/simple;
	bh=btIPlwgpuw78BmbqpBa/gsQ/EiisPpH6WW6V5OVnWs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T3NKJfVIvP/bxkc44Ih8HcJ8IPqq91VAxGLP4dGCw7giFPoUjmWKhz2jgbiq1NNyJPqMAFcvWUhjol8yK0GcoZpd8xNj0QvbfO4NGhUWebBJvvzaZxH/qNUQUTxE+wbTf/GDkV3t4mmUvliGOy0ctw4yOTAtiOcwBg49fkiuJ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZISrRZiL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X8ndine3; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZISrRZiL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X8ndine3"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5547A1400179;
	Tue, 17 Feb 2026 23:38:58 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 17 Feb 2026 23:38:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771389538;
	 x=1771475938; bh=GmiAe11kt99ppBZOx4I33QXRPv35wK6itilhv37joFI=; b=
	ZISrRZiLKTjDC59TACMN/QEzlWg13w8/94u4PjpWmzfkwu2p32zqmP3k9EBmGPrQ
	bVGoVhpI1PNYeFEg+eLgeay5yiZh1V7cKmNzY0/du0LzWG9tRsegm/p2eLRT4oOR
	VbP3nCXeEEpOl3NCUHRnmAYcEutlJNUVMamLE2xM+IcmJ6ORjq7MT/4jukIK2qK/
	oJEEnSV5F8JNFSNLhtX1kHJppBjroACevnERB3DpaeZ8lxvWLGgr+WH5BipAsidS
	yhleVIyAHD3wCb4ZWGDcG5kMDnocxWG4e/LDT0LRxyHBBFbUScXJTYadsW1ykgqh
	fHwtcSzOqvsNCbksux2hVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771389538; x=
	1771475938; bh=GmiAe11kt99ppBZOx4I33QXRPv35wK6itilhv37joFI=; b=X
	8ndine3tDidZUcmVFDA2UYXLKLNq2apycg1wgEk/Peu+S8lRfpQX/7YtGbDJU7Bw
	N4nFcvRfryn/cXRlvtB+g9HD2858hsVkTNW5xQRfFkzycbfi1Vfhkae3M3zZvwWy
	daqta5h/5q0DhdZpRWerDYBbDSwRenPn7HqaN9yEHmXWXZkYE1zKY184UtelpDTt
	lSfgFR07vkZaBX2IFfLFDiKIcAo1QUEfUEzyAj8pxohRuE44pGT6YLZovgp7KR3U
	z7XsdyfL424VZHwiEswvtvGZ2JJpCFviIoNQlmPJV7mu7fiBI5lg2FKHoVkdChO4
	WXuezdG10ock9ebAUSqkw==
X-ME-Sender: <xms:YkKVaUNdH1LDaCzC_QiCsrhDJTkDLyxHVSxI3tqcgy8SDyR0eHHS_A>
    <xme:YkKVaQ-HfBEft6Wep8RKGes39gLRyrZBdNQ9XuTgp-PFYLTHKY3AfJ2JMIhqCDEZD
    dJsVGWnqOs9V-Z6ohyH44bMCRC7qJh4BcCUSH8ECRNHUWPtUMaRzQ>
X-ME-Received: <xmr:YkKVaY7xeQsfqCfMMe_9CizsQm3h1KGAcR5AikW4f6q6Vmu5pW4VWy6ZPWBqrTwEHctRFflHvzwLp38oDGsAwWkEltbDzRIufiWz_bk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepkefggeejueeuuefhvdettdduteeuteegue
    dtgffgvdffhfekfedtleeihfeuudejnecuffhomhgrihhnpehhthhtphdqfhgvthgthhdq
    ughumhgsrdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YkKVaX22s2yv_wIC1ejopZBvJKmYBCurdU37TZ1xdNMwZt0OL_jr_A>
    <xmx:YkKVafB-e0lxnFRH6ivgNZklYxt5GUsFQ-G7OSeQQszKxBEu1l6GDA>
    <xmx:YkKVaZ2XeABbJ7hqIqMqwE1Znfo0n2Yc4m3ztczfHw7b8icHCzlqSg>
    <xmx:YkKVaZtO4FG2CWKxdaQg2I5Qn_LpkOQPEgEb5ckjxWVBwtAApyMU0Q>
    <xmx:YkKVaflIc7Bt96mY6IoUOrNeDUjeiIvLnqUz0o0oYi1MbRP8Spu6n-LX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 23:38:57 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f54e1f45 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Feb 2026 04:38:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 18 Feb 2026 05:38:41 +0100
Subject: [PATCH v3 4/5] t5550: add ICONV prereq to tests that use
 "$HTTPD_URL/error"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-b4-pks-ci-msvc-iconv-fixes-v3-4-08c1ff3ffc9a@pks.im>
References: <20260218-b4-pks-ci-msvc-iconv-fixes-v3-0-08c1ff3ffc9a@pks.im>
In-Reply-To: <20260218-b4-pks-ci-msvc-iconv-fixes-v3-0-08c1ff3ffc9a@pks.im>
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
2.53.0.414.gf7e9f6c205.dirty

