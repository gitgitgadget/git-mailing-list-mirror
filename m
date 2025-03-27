Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8899212B1F
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071848; cv=none; b=KP1V7mteHci1tu24juzmQOKwYbDq+zaaf4Z9IlKDNXmyPY7gv3s287yCMNyZodm6EKX5o1XL0UDf35IXbi4MO7Mz+TbJxU7aVaiqolT/JrRQ2/LuI+PL1us7x7wE0QmykXLhqWD/j/aGecRxFxr0sgEU77t3gtI1zRzN3E9ykZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071848; c=relaxed/simple;
	bh=x6zEzZpx+bxNQ0VKz0w/3WuCDnWSaMjafPKN/NUggOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qOBPqbClidjuh4jI6HP/1qI5Kij4WTvKo/Ge0ycNiOd9mN0t6hk5IZM3cJTz3IBr7fJLaqc0tWX1Qp8kqP3XUNG1U1laA0xvgHnB8R9a5b7jsp7IkcHWvpyO6uofoyTtEwjXGD3NMv10umIagyeHSdtPDito/Vn9aiik3SUOMAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hzdTO7UY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mxkE8syF; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hzdTO7UY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mxkE8syF"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id EDA5313838F5;
	Thu, 27 Mar 2025 06:37:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 27 Mar 2025 06:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743071845;
	 x=1743158245; bh=RC+oEWj5k77m12uZbDBQ4gke2gQt2GP40yqO8tSB834=; b=
	hzdTO7UYPuK5RlGC2I6i8n2xzF5DDOfhe29qmmaYyyjbCWNV/CEfTIU0m7SJekaO
	jRvpZSXApruT83RC3ggk7+7S0t8kg/8H8ZfjmlvBr3RzpdJhMQ4gmDZzUoT4APGm
	xx6Gkfp0UiNFNxGGLrTfUTSP+W+WmJOVTi0IJdxQEDr0Sf8vYwzLKwJU1NfK0/n0
	CJt+ODXbqdc5g1Uxk8DUIarTE6YUV/7wN1gBzJTUINFN6WgWhFNwdWJeT4wOneq7
	zVXKJNl5Yo0vGuTnXogZjAx12nJ7HxMpA0AoiRnaOqhJ7qXSvwaiMZzHPN6SLd5y
	4W+1F8gtoyYcRKhOk+9yqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743071845; x=
	1743158245; bh=RC+oEWj5k77m12uZbDBQ4gke2gQt2GP40yqO8tSB834=; b=m
	xkE8syFTsnCegMyApw6xSQN38FTQWn4l7+2Kc3sxHO0Cq2L7Cbd4iQ4tET42q1/p
	bu2RoSkM3tn0TH8+AVD81er2riEB0jonMQB0iFkxiPbPx63+nIqsN3r0SnrvIcIq
	g1YzYGBZgjdKhILegN2hcVNZpqXfm5Hrccl294NSFgcehkkHoBpvKki4jOf6dVXz
	VrOG+5GSV4YTkUThjZeJlaQpLDb1exHxTJpPkiltH8WPPpVGj4Fqo+XSbABhNGFB
	AIq7ax8MBBaL/epUCcJnbBy5mfpYPEEAgFU8kkPGKnw8Uomi0J2xQTD+YKO3lwRV
	MjHiamPbUQkQd0Mq514VA==
X-ME-Sender: <xms:ZSrlZ0qKNdtqk6XdpGJq4UImWcd_8wQXnDIpO05KYK4gVNPmlRIaLw>
    <xme:ZSrlZ6p5OGB3eotfQ3-s9votZnnCYS6_x-F1W4joVAoSjhUXlkWRYcY0d-d_EJ1Y3
    kHspOfV4MJEgnGa2A>
X-ME-Received: <xmr:ZSrlZ5PhckGlaCV2BBAct1MWQpTPLa0E2br9NQ8RKXPUfm3BTlhJsgxplkCNjoO3VnM-0Oju2LMDuGPMxL6omp_gWlXykUmuSQo_2iJypOSMEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:ZSrlZ76J-8ahUa1IiaM_Ay-q2F1KZar1mPJtmfY-L_mUD0jOeHK0Sg>
    <xmx:ZSrlZz4eRrIAPn8y04xU49CDI15-SV05WY7sImtJfHi6GsRm8YDvDQ>
    <xmx:ZSrlZ7gwFQ0uNymD23AbQY8fBoickjAF4MsJ0pFpFMRPCJec2geNMQ>
    <xmx:ZSrlZ96fCIgmPtJ8S8Vl_Te81Azfn0ZeqQnjunG2zjjEXHTE4uGtlg>
    <xmx:ZSrlZ5QuNyGwVIHF2RkbvZO8--zZuqOaGPctXsoFZawrTTmxR_wveaq2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 06:37:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e890d141 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 10:37:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 11:37:15 +0100
Subject: [PATCH v3 17/20] t0021: refactor `generate_random_characters()` to
 not depend on Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-b4-pks-t-perlless-v3-17-b436de9da1b8@pks.im>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
In-Reply-To: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

The `generate_random_characters()` helper function generates N
random characters in the range 'a-z' and writes them into a file. The
logic currently uses Perl, but it can be adapted rather easily by:

  - Making `test-tool genrandom` generate an infinite stream.

  - Using `tr -dc` to strip all characters which aren't in the range of
    'a-z'.

  - Using `test_copy_bytes()` to copy the first N bytes.

This allows us to drop the PERL_TEST_HELPERS prerequisite.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0021-conversion.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 4a892a91780..bf10d253ec4 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -20,8 +20,7 @@ EOF
 generate_random_characters () {
 	LEN=$1
 	NAME=$2
-	test-tool genrandom some-seed $LEN |
-		perl -pe "s/./chr((ord($&) % 26) + ord('a'))/sge" >"$TEST_ROOT/$NAME"
+	test-tool genrandom some-seed | tr -dc 'a-z' | test_copy_bytes "$LEN" >"$TEST_ROOT/$NAME"
 }
 
 filter_git () {
@@ -619,7 +618,7 @@ test_expect_success 'required process filter should be used only for "clean" ope
 	)
 '
 
-test_expect_success PERL_TEST_HELPERS 'required process filter should process multiple packets' '
+test_expect_success 'required process filter should process multiple packets' '
 	test_config_global filter.protocol.process "test-tool rot13-filter --log=debug.log clean smudge" &&
 	test_config_global filter.protocol.required true &&
 
@@ -684,7 +683,7 @@ test_expect_success PERL_TEST_HELPERS 'required process filter should process mu
 	)
 '
 
-test_expect_success PERL_TEST_HELPERS 'required process filter with clean error should fail' '
+test_expect_success 'required process filter with clean error should fail' '
 	test_config_global filter.protocol.process "test-tool rot13-filter --log=debug.log clean smudge" &&
 	test_config_global filter.protocol.required true &&
 	rm -rf repo &&

-- 
2.49.0.472.ge94155a9ec.dirty

