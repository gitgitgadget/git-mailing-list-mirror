Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2EC1E9B12
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575979; cv=none; b=kXGUZp2OlNgFgeu+TWYN05bytXAjRckgOF3bYVC7rvDmwOtNGR/5vyPca+Fd/2+iy4hKPRG75slVrIse3RqMyaifWaqv/CwekIf5+4xh7D7hnazn5e+lFectt0L2OjrmJEYk7OeX6ia+frvxdh/kG5K/O2jPqM78qXXliT+DbCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575979; c=relaxed/simple;
	bh=RTZOKJ32VEGNcZKNh2pIAKgqOUch/F/I3GB51c1QNsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A/Pg49fTHhR4fTfyMCCwXqotod51v98I6ftkklxERGLSu2/8G/+mo45KKSKoBXexS8lXoW/Ulub/a09Kbmi4ehbvTmGwFhYaQz43Ajr+3x7EovwXJfg3wwIVA9HUy92W96OAVN9COQqk330gc8C3L78J24A6KDFqNfC8wqsDM+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TFgFDy2N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EGIh3Iaz; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TFgFDy2N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EGIh3Iaz"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 337101D0016E;
	Fri, 20 Feb 2026 03:26:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 20 Feb 2026 03:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771575977;
	 x=1771662377; bh=ie1GbiI/7LiTKRl6dfv/84rPgfLDTs/QR/4zuSXlHdk=; b=
	TFgFDy2NSDCHYiz/MLRyAXl58RdrkDyLjo6hWCdduR0jd3amFVTEr3NMmNcqzfd+
	LYXvAJ71jEsiETBZN7W/3+lNB2JolPWEDeGIxcqYNbepa8W5Ld08MOVReuPKyk7m
	Ybego6fQ+Ktt6ORMptuUhPu5UEt3GCvqHliLjDQReuL6DJb0iONmkpEVNvBSbANX
	p8tv+bsESTtrumwVXK72o1iZnqRUQ5ibHzne0JPhmgmh/eP6n8T3d7O4+iaOY6f4
	Iq1sSKvkDXNgumJhEQn+5XI6h0KZ1TKDhY4tB3xkMlkMOb7nQAAv8IzhGQocIavP
	LPD8jKh/ePbyIXKHozkYeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771575977; x=
	1771662377; bh=ie1GbiI/7LiTKRl6dfv/84rPgfLDTs/QR/4zuSXlHdk=; b=E
	GIh3IazAyOOn/CF2oJGI86AGs22e7pT/rk2A2HS4YmLlTtNnLhUguG7SLu3CyrYW
	1HoNTXClfUCCYyjlyGu9Tj81OFxQiFuYoPHs7Uy5RHJvc/dTypWuFeaJ0LUJI1f0
	okv/6czVXP8uA5mRfUfv7oeMZb2F9VMB3mGEZN6omc1V85zYvTjyOZxfhnlP4jBS
	LsxdOls8ury4Pt5akTU6rPXLVL6FkYg7Ion/47Edw0oG9Kk6q5RDa0Z52TsgIFok
	u0gpkCx5ZmqBBFbs9CIezB5CSjnsvC47T59nV/K23TgCPet852LcWnyHxNRVMMe+
	MnKUqbQcPVLPhCGQKevgw==
X-ME-Sender: <xms:qBqYaW-vlnRwoZbPph_OPK2wsOA3wXs3Ri42ds2_aUlchzjqVPqi4w>
    <xme:qBqYadssSWWn9nH9rbk3ih4-wdHAOeHlHhvbDR9HRvW0qEHCOVBztsB_iMNWWWZm3
    Hi1x-nGges4YBBAffeoDz1N9tNdBgl0dvkfha5nYqyYl-03C7lZIA>
X-ME-Received: <xmr:qBqYaRDpQpASVHsC419HOJ4MN4mMKLSleZRg5UNWbco1GIYxFVfLp_9oNnnv5kCB1eZHwFU7qLp8awCc3M4Pnv3qakVZd9xcm_vzQg1t3n6e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeekgfegjeeuueeuhfdvtedtudetueetgeeutdfggfdvfffhkeeftdeliefhuedujeen
    ucffohhmrghinhephhhtthhpqdhfvghttghhqdguuhhmsgdrshhhnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgs
    pghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhstghoohhlsehtuhig
    fhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:qBqYadWpwR2Ue7IJTCvr9Zi0v8LKYcp2ZJsNleBKYvE91FET8RV27g>
    <xmx:qBqYaXDjp53pW_GyGpCZskae-QYb9S17uRME889PlNDRSThib1keOw>
    <xmx:qBqYaY_EqBBYcguuVkT-f4lA8FAgn8EHhCZ4YO3KIn2-ZM9Rx4zXTw>
    <xmx:qBqYaWE-M3a2zDiexG09kJJiJSc5haxPuK9Ro-53Kcdc7q2KHUw8MQ>
    <xmx:qRqYaTRZdM8b_KE1CUhkZeM_MXZRbwZoGVbCdBudtMPgWuLt4YuRGD2Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 03:26:15 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d82b4ebf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 08:26:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 09:26:02 +0100
Subject: [PATCH v4 4/5] t5550: add ICONV prereq to tests that use
 "$HTTPD_URL/error"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-b4-pks-ci-msvc-iconv-fixes-v4-4-e0e6bbcaeb5b@pks.im>
References: <20260220-b4-pks-ci-msvc-iconv-fixes-v4-0-e0e6bbcaeb5b@pks.im>
In-Reply-To: <20260220-b4-pks-ci-msvc-iconv-fixes-v4-0-e0e6bbcaeb5b@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.3

We've got a bunch of tests in t5550 that connect to "$HTTPD_URL/error"
to ensure that error messages are properly forwarded. This URL executes
the "t/lib-httpd/error.sh" script, which in turn depends on the iconv(1)
executable to reencode the message.

This executable may not exist on platforms, which will make the tests
fail. Guard them with the ICONV prereq to fix such failures.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5550-http-fetch-dumb.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index ed0ad66fad..05c34db780 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -339,32 +339,32 @@ test_expect_success 'fetch can handle previously-fetched .idx files' '
 '
 
 test_expect_success 'did not use upload-pack service' '
-	! grep "/git-upload-pack" "$HTTPD_ROOT_PATH/access.log"
+	test_grep ! "/git-upload-pack" "$HTTPD_ROOT_PATH/access.log"
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
+	test_grep ! "this is the error message" stderr
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
+	test_grep ! "^=> Send header: Accept-Language:" stderr
 '
 
 test_expect_success 'remote-http complains cleanly about malformed urls' '

-- 
2.53.0.414.gf7e9f6c205.dirty

