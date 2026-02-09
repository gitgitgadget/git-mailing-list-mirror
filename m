Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3FF371056
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770640964; cv=none; b=oNAZ/mC/ORct7qkFZlut6hMOKGGbAM8fcnVhAwHmIS8uvmQIHTGjAI6kloAimmMoEoXxnHyWFn3thzi0Ps5OE5feuG0ztcf6dSnhpXKSjTINttIKkJjMmXyVYCdwsc2mf/JR1kVwkqvopUG+BJVIYGOUCIrwoaxCjRTY9cMQJpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770640964; c=relaxed/simple;
	bh=pwM9UtUPZkCyN2eAdQve5aHhvH4bVpCUpdSt/6vSLWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y8poRVBbkmS/Kg3ztL8Wnb4qnPkitruvoOnq2g+LybHJgMXU+SrsymvWmF/+hZGt0v5Wo9aSwG1VVRKx5wPNs3NcrnyFmj93il2qtnAM4vgehGLCj+/eYffA/ckL7Blm83lHmdnFbVClKEO/pVlm/Amkv97TAKEkgQ6ZmU/aUiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p2/Omxfz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JnKhwcbW; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p2/Omxfz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JnKhwcbW"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 808A01D00084;
	Mon,  9 Feb 2026 07:42:43 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 09 Feb 2026 07:42:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770640963;
	 x=1770727363; bh=v6D28CgkxSvazpVI/MIzLO8aWWzar8aSq0DGEPewsEM=; b=
	p2/OmxfzIwAmSUamaPiuGE23Njqlu8NNfOdI3kYygdh+L86kPe267YXK2PSAVwYI
	8rpGfVlnuLREQxCJunBVCcRT0h7cVPDnxiPEKhPzoxQQStx2clbsY/AtSjFUKY+r
	1MRShxpGqXa0grqRkEz+jVwe1pQXwMVNjB4pxDrU0yKs8LK1UOaeyzNwubI/WYJu
	hBQKhCsv3KPkqUjhctHVaRKIelUArePlWph6PV5P/lRTcVdaxqtOqeHucrc9rip0
	C8p4Ko1OFfqFFCDdD1pphjtZXxPPwn5+n0rzWdP+lfDY8/y8AfQ0HNv5rKGiT/qe
	/itf8Sh6X4OXhqqRBv7usQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770640963; x=
	1770727363; bh=v6D28CgkxSvazpVI/MIzLO8aWWzar8aSq0DGEPewsEM=; b=J
	nKhwcbWL8NSC8YHn0QILGj6pMQWWxoJueS3p3dv62UZobmcXKTtjGY0ndxrK8UXa
	tEf9noPsJZgW+srgjtu/cq1C1g1+YqMeUqTHHABzgsIsVGSu77GkYFrdHJB7WHZb
	1fDX2K3WMbrx/olO1GWUTS1dyJlyPz2tLGv/C+aNLMz6uYeAey28Umir3C1A5WsA
	rZkd7lyIhSZ5E6llMpvl8k/5J/JDeWjYeiRQjLwJR7DhnucGwJe3iUzxUxLxBYbp
	5ZPVgq1ukyz96mchZ/+5Z/WE3caRSi+kH12WK9kRedTFxjyyfBcpzQ+6pqHQqF5+
	GExk7TWZmwFX5vKmg7CbQ==
X-ME-Sender: <xms:Q9aJaVJckRoQlmHY08vJrckMKLQgmtxIFKQhYkZ53KxYQ8kWWzS57g>
    <xme:Q9aJaXKaAfniqq_EDGTusr3i_9CtthI_gr-AEQqxbCTSWSf7D7Tlcd5ufXPR1HYUB
    Qi6FnYmkZV3jRadim0Tf_bwEIgi4wfket5Q5FlYO0l6m7TPB5NAPQ>
X-ME-Received: <xmr:Q9aJabUk0udHKljOSOvffHyu2ICw55s-knTrlMpdMpFfvV4yqUizKWXFaMz7SMZ2eoijymam1reacXkIE9FShv-gYq_YM8Cz9mpzy-i7D50>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleeikeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepkefggeejueeuuefhvdettdduteeuteegue
    dtgffgvdffhfekfedtleeihfeuudejnecuffhomhgrihhnpehhthhtphdqfhgvthgthhdq
    ughumhgsrdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:Q9aJaRiIKnaMwNjRgTCRknkNNHYiPW1APO0dqGh3oSz2SXVHroq2nQ>
    <xmx:Q9aJae__R7bqleK00Mgu8avfXW-t8FPmhgoLTrskAug1Fx58bbnxFQ>
    <xmx:Q9aJaTCehBybw_IldTBLXBFOpdmu1hcok_zvCOk-X1W8diMOAzQi2g>
    <xmx:Q9aJaTIta5o41RSJZnhxuLXVtL9P9rM4UOj-N3m7t_vrZp_EJY29ng>
    <xmx:Q9aJaYj7tJBfkj7nKsP1oGBEJp23yCdgSVKd7V6tPudubai-x_GJl-vI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 07:42:42 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5c172082 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Feb 2026 12:42:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 09 Feb 2026 13:42:06 +0100
Subject: [PATCH 3/4] t5550: add ICONV prereq to tests that use
 "$HTTPD_URL/error"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-3-1e3167cd8828@pks.im>
References: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im>
In-Reply-To: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im>
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
2.53.0.295.g64333814d3.dirty

