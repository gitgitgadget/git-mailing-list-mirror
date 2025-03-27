Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FF520F09E
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 10:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071836; cv=none; b=DBmDR/niVFecPwt829F+Xb9AX3FEWTvvkcMVPkrSDiLEMc83LlYecd3jS0cv8NJZSSBuddN2Ss9BNJmlNywxlTMwEPsp+Tz9Tr/vX28u62kKrio1KSsbvmMPgTPwJjeTrRT5aw3IHHE+0O4mNSkGVNZPjcBJsKxIjBq+HtPhr5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071836; c=relaxed/simple;
	bh=0QvGEqC1CcXw7qB+3oNkUJawQaEJu+9o4Wx89q7QTk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZlXithaEDS5e/tItntvoPipG3gSayrzHxvAjf5hl09Saw6/C5NuCqDrlEDgu59O/mc1HQBuJEBgETcvoiK7xiDyN8zJrfzVosSvi4x6ET8dnXpNZ3imEAr+wBtESS/l1+CY2JyFu4HPZuYGm2/O6cJbJb8d23BwnbRYLUjJP+W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E6bJyd0f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c66JkOqN; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E6bJyd0f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c66JkOqN"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 4EE001383844;
	Thu, 27 Mar 2025 06:37:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 27 Mar 2025 06:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743071833;
	 x=1743158233; bh=TxAb3XKVEc3uafQcc1aYp4YdbmPnHpNoCoLGnfZwU+s=; b=
	E6bJyd0fMp7rPUzFEsJJN637lclVogrzTs4CgHaVpOtc2Ca0bYasIDYRwArXY3qt
	xK+0QKEW3/YwusTFWC6AUrxgdjtFOZtp+U6LgfsS7DZcWUYyGeB03tav/L7090t3
	yj6FNZXuOUfHaiNKOSIMx4fR6AmCx0adEXyQuvtAhtBXby6ijEtT78aYjNwUY6L0
	aRQrV0TzeeTNATMdi3Gle9tXOQHMjWPLxCtyrUiBqsHt7MgmrALQ/prdPta+4AQx
	tV0kDOSxX+g1hm14yHk6uI+W5pnszFEangOAcFgmtYRShtmLTf8FjCHD5sce1IzN
	KJR9qIA2g3eqVlr/4So71w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743071833; x=
	1743158233; bh=TxAb3XKVEc3uafQcc1aYp4YdbmPnHpNoCoLGnfZwU+s=; b=c
	66JkOqNtxwwNqlRlQo7AjRZ0FTTc+Xb7xP7UbCX74etiCmCZYRlWs0OahrEJxIOH
	7dMkzRxGX628DZ3ysNSoC3fdILy9s87JDkJNOa22c+3Ys3FXIuMnLI8JI0OV4n8+
	ddzziwPSl5nMXRiCVz8IIG3fFRFhu/ov6CpqhvGcxmi0uO+VCr0uunbQRJIgk16x
	MKjD1JYeguIaGzJUgpfj3Hm5uywYuwpTL5/O4cLe3nmlVfT3OZTAdIGNQGYACOWO
	vD2cuAcEDsgbEM6mivbWu4BX502uhJmLNUU86Ka/IEJMKD9AFmJO5H/S6Xaklx5W
	sUK28U4T/om6Ve/MQuvNA==
X-ME-Sender: <xms:WSrlZxKus13sOQPanGk2hGH3M5h8ui-c1BkhoYTdZyt2kSdS9Vi1sA>
    <xme:WSrlZ9Jlc7B5gLqsGfhWNLbsrvZr0NWya0T18lazQSm1oCnxcNouVwipF_vL6m6GY
    4xDrpkrn3wb0RK9GQ>
X-ME-Received: <xmr:WSrlZ5telb9kEmB0WkjzRNAsWCC49ZFciKIBGaZ30zCcqlAGTN3yBE8bDg4ypm9_Otvja8YLr7a0AwpEB_yleYBsnSKL2D4S0OJQPo71AROHLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekudelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:WSrlZyb2X6thghVDv4rk52ZG-i2UCZOSJNjUWjDVkPtLjvb5UENEjA>
    <xmx:WSrlZ4a2TUp7nCzDZGfHPBsJhkBOc-sqjZmJHlZsXin9Sgy0cJsuWQ>
    <xmx:WSrlZ2C3gW3h1mPKmcu2Pcs6a07vkLHxPCRFc2jJuCNsmsk11Qa4hg>
    <xmx:WSrlZ2blGOpPIdvFXE0NzWAV-7MZVHrYQkW2l_DiKi92SS87P92z4w>
    <xmx:WSrlZ3xuROe0yS1HLpRzpAhjsG6tUSmJ-6MumVd_uJ9gknrq4UcMGBx7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 06:37:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9e62531c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 10:37:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 11:37:03 +0100
Subject: [PATCH v3 05/20] t: adapt `test_readlink()` to not use Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-b4-pks-t-perlless-v3-5-b436de9da1b8@pks.im>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
In-Reply-To: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

The `test_readlink()` helper function reads a symbolic link and returns
the path it is pointing to. It is thus equivalent to the readlink(1)
utility, which isn't available on all supported platforms. As such, it
is implemented using Perl so that we can use it even on platforms where
the shell utility isn't available.

While using readlink(1) is not an option, what we can do is to implement
the logic ourselves in our test-tool. Do so, which allows a bunch of
tests to pass when Perl is not available.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-path-utils.c | 13 +++++++++++++
 t/test-lib-functions.sh    |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 72ac8d1b1b0..54d9ba98c0e 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -323,6 +323,19 @@ int cmd__path_utils(int argc, const char **argv)
 		return 0;
 	}
 
+	if (argc >= 2 && !strcmp(argv[1], "readlink")) {
+		struct strbuf target = STRBUF_INIT;
+		while (argc > 2) {
+			if (strbuf_readlink(&target, argv[2], 0) < 0)
+				die_errno("cannot read link at '%s'", argv[2]);
+			puts(target.buf);
+			argc--;
+			argv++;
+		}
+		strbuf_release(&target);
+		return 0;
+	}
+
 	if (argc >= 2 && !strcmp(argv[1], "absolute_path")) {
 		while (argc > 2) {
 			puts(absolute_path(argv[2]));
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index c4b4d3a4c7f..bff8c4d1b41 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1979,7 +1979,7 @@ test_remote_https_urls() {
 # Print the destination of symlink(s) provided as arguments. Basically
 # the same as the readlink command, but it's not available everywhere.
 test_readlink () {
-	perl -le 'print readlink($_) for @ARGV' "$@"
+	test-tool path-utils readlink "$@"
 }
 
 # Set mtime to a fixed "magic" timestamp in mid February 2009, before we

-- 
2.49.0.472.ge94155a9ec.dirty

