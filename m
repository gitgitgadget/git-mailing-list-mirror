Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6F019CC3C
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 05:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743656776; cv=none; b=CFRKc0FwlCBfjEGHmC9JlVpl2mUkmmJPcMklXZlNUeGanCpdZakUJ4YzLNMKBPlQVYDe5bbXv0LW6AVeCjrq4fh5j7PHVlkb+AUuoFBsYvSPlglWf/EQkh5jRfrqMbMcfkbOPJrtekEMkJMVYS68fEHAR+E/KzSe18rUAHLMN3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743656776; c=relaxed/simple;
	bh=WrxfrqlG+G6FaPGBdOIzdvJAsIp+GGiAcGU6lhIGA+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SJM3MNgprHGpCkQkWBmiN+F7tr5tLGyazTEGkvERLvSM5xODqET7aTYTno9N5PLoN85ryKLFg6xY+lgsG1yQm+Tio+9LGE58lNha/rzVBPUdLVKuqqdSMG1U+nX1SVitaOdZdcuWhwIPeM72PjZT/nYkcN/zvVfVzoDET62m4cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ky6tKiEm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nlp7eli3; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ky6tKiEm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nlp7eli3"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C3EAF254021E;
	Thu,  3 Apr 2025 01:06:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 03 Apr 2025 01:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743656773;
	 x=1743743173; bh=WxXPKdWa1e2yuk/M1Sm03ceWzrH1ffD0sRYJiGmJOPc=; b=
	Ky6tKiEmpfGfjutQBE3+8nHk+F2X/Bq8eOJCM5AemTaQDPvWPK3FBkg/YOoDHiQ0
	AdIcxbBxUaouVhZD607w28p1L641nI+8BsQooAioTihxDXX5NPJvBmb2lm3HSMZN
	6fO86KRyRu5MVdn4cgZpUwbCNqqzD5YsV+MUaID456VifF7kr7Q1GBmsOHPIuEqe
	jcrJzjDPH1qxBioLMotPABlb7IuGIs4yXRQkt6UHUa4zsywVgVQd3o7aRIhXhcXD
	3v5xs0NMmJa7ctFFooHJLKKYqg2vM6RYeotDQCfmiJNWKfMnS6ZugcqarfqZYmnh
	LxC12VICUmT4+4N8nekwKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743656773; x=
	1743743173; bh=WxXPKdWa1e2yuk/M1Sm03ceWzrH1ffD0sRYJiGmJOPc=; b=N
	lp7eli3B8BCeFkivNAsGTO5hjjDlsZzTwlfTZGXQmGjKAwy3Y+AnDmrPnJXXf7O6
	ejTiQ+YZZFOJRM1MV5JXay3mj82LAceuRRb/yDg7qmpwkMtmuDzWbXfghkcwFAiz
	BIEyvSSSUVqmWPuld4BxtZ+dg6EJ8zE07hktRWze2TJVfonFiwzsAE5XlH/dSoRd
	ivguEl9PCZXRd2bzhivTutdRdiDflIMgtTm3t4fRxuFmZ66Dnx9vUxk2xBr65uXL
	eCNlS7CYHpa4jWz1fdvfrHcSduZEtDrg0Q30ql/ShEngZYJdhxN9Qb7bXmN9cEoD
	bTQ1hj0ayQX8o3bYkM6ag==
X-ME-Sender: <xms:RRfuZ6Vk0cjWepWV6EbzlwX-aYfpYaZorkj5OQYr2hT9IJJTHq-zmw>
    <xme:RRfuZ2k0psfaO2688SyLNxGaNp53DIICCtwI7Z4xWK-3CoDHqAuqbJ-w862uH9yb3
    5H688tNzUM93vNZVQ>
X-ME-Received: <xmr:RRfuZ-b-Bquf-vDxD4x2UzhswVF-hUR7ECMDMo-IYpomm5mSjR2xt0yKOc202clQi38JOOEuPEexBlmTFCty-LDbZnh8ystpE-RqNZz7kELnmiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtg
    hordgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhm
    gidruggvpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:RRfuZxWY6M9Rl4ps4ZulDr--JR7hGrLyJcF16it97nTiC52xl6WXnQ>
    <xmx:RRfuZ0ljSyTAg1HW6LE6XFAbabOe6BnAvi0nym79D58WrR3u9EecJg>
    <xmx:RRfuZ2d4f4WwPNDC5yWNxeIXSEeROfLwPB5JEdP3FYEifBYsA8KQFg>
    <xmx:RRfuZ2FfBCET9ITroFHWvxQJZI0t10uN3NbD710QIk-m9knVP0wWIg>
    <xmx:RRfuZ9cW3vEeH_5SAZzU4Uyx_OkBxKV3wP8yFq83QolJXO-t-4_2LW6x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 01:06:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0831bf8a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Apr 2025 05:06:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Apr 2025 07:06:08 +0200
Subject: [PATCH v4 17/20] t0021: refactor `generate_random_characters()` to
 not depend on Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-b4-pks-t-perlless-v4-17-be20ac3db39a@pks.im>
References: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
In-Reply-To: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
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
2.49.0.604.gff1f9ca942.dirty

