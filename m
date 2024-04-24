Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6857A140368
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 03:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713931193; cv=none; b=qyuDnAHOzELvVJycE9YPKBE37VsLSRUDfaSomAYmL4hPYAGZ8U4mn+MSdUls/XGnUDh43XDj5dFQJa7qjq36UVX2B/h5zcEQI6xDbEgXuJkUiyb8Ze9UddNzz5Qz5nQJNeFssNVnoQtw4k+dyJRM2wjziOMRU5X9jAkJzDM5PA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713931193; c=relaxed/simple;
	bh=VIJSKWxDzt+vBAWdEpobAIE+v4U/IU3Ibr5LohEG37E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEwcSjX6ID41uo/7Q097Rb4j1mSbRxAtJRF0CIgVFQSa4di1i5b8m5Rmr1QLMChtsyNaVoYDV+N0OQoKF61RbyVYYJihXCAYXLoykffV9lDaDJh+R0YNHcWU6jHW3gNaZBR3wyFX4LeSOQjpZEUmm5z3NaHW5bRJQgKAOGMq0FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=l7N+MxJi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FBSWjVj7; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="l7N+MxJi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FBSWjVj7"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7C8FF13800F9;
	Tue, 23 Apr 2024 23:59:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 23 Apr 2024 23:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1713931190; x=
	1714017590; bh=8Rjy5nEAPQAuZy+fC/96rh0MUH6QG2ABKMT+TuHU/uk=; b=l
	7N+MxJiRwptOza72Y0tPWWsPYXdTa1nl3icdhYikE/W7+mWRsW8VJHPLHQx+OxXq
	SOQo3tjYe/U4OIMahdbiDkY9huK8xbaF8vjTyVFjVN+nDngDvlD65q+1Ehq8PPqO
	aZ9SuGh4U59zu6Ui6BhAqJFPl1YXFG5hj9FDCsInnE6PxrJfnN/4kmwuyqw5IbsY
	Gyc7hjTx3VTAGY7MISQkWs50ESkcuvhk4UdKwuUjyCELt84D2smGasJp/DKC6/DC
	M41qEyN95FmaLZd77YuyUDbRpK0bX/CoRCz6NNVwEJE8vJiQPgW+lyv0j3TKVUnt
	GJ9tSGezDBGTWrZWLCwNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713931190; x=
	1714017590; bh=8Rjy5nEAPQAuZy+fC/96rh0MUH6QG2ABKMT+TuHU/uk=; b=F
	BSWjVj7SpuKP/46OIjRjM8Yyji0wlTC+jZIx7wv3u2mX/koU4OmqfdZP5W+DbYVI
	E8fPvjdOuwmy/szlTbyqxnHHOy4J8668vsDm3HS9ySjx8wxiyoOCkGvWPgf7iVJ2
	dnUIwdFFcCg7XEYShMTxA+kx5BqTeMpo8eBq0YpfXWCP2knlTXk/hV38LvBLJiRb
	A7TDA6ZS5jZNG0QVLrjt0Wgzo+43R5vzEBQ2qzfyI7A5HoNAxVmcKd8a33hm70VU
	/cUbIz1jmlAGMEogyM7QI/QrOchUAfkczHd2wRCTbeOrz6w/nRf1gWzmLNqnPe/P
	RBN9hc1FcYudDz0Ou2D7g==
X-ME-Sender: <xms:toMoZpD-fhCe8LTdsQVJ5A8mSMxQw8dfEAYqTav9DrDuSwXbzX3QmA>
    <xme:toMoZnjfffNuJmx6MZv6DAaHnBeZblho82qO8U2iklYOWqjvCUMFeE0bq8wJQ9O0m
    IQXUMkm8ZiJfsZ_ZA>
X-ME-Received: <xmr:toMoZklOXs3nN89sS7Wks9zL54uUyjz4YptIfEpkPDKjRzp_I7fRHSJK3uxD4LlzwqSbY60BNQtU3U_yaj7XAaaDoNNiCQqEPowBGnFYb6IA2RQtPQBGncdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelvddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflrghmvghsucfnihhuuceojhgrmhgvshesjhgrmhgvshhl
    ihhurdhioheqnecuggftrfgrthhtvghrnhepleejtdeuudfgteegfeeiudehleeutedvhf
    euueeuheevleejkeelteetfeevhfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepjhgrmhgvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:toMoZjxXrOmzb2DlR90Oig78TizOZgs1H5K1MQPPQeuvATHIuU2n0w>
    <xmx:toMoZuTQVASGPlEg7ab2m1JaNfpqGVtvr0sGZ8i2ESAy7CvT1uqPEg>
    <xmx:toMoZmZl4NZGSUAOHv1aLA5VdmW73-n3Aaf8i8zGQL7DZ6R5sRm2zA>
    <xmx:toMoZvRhSnk38w3Hq1j7yF6Z8rieK5VityJLy8ZFRuIDuZyTMrd0MA>
    <xmx:toMoZpeWa8blVZMjQKLEbuPE4pwmahm_22rIrTGpsSj6f6-7GxJnQtkk>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 23:59:48 -0400 (EDT)
From: James Liu <james@jamesliu.io>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>
Subject: [PATCH 2/2] advice: add "all" option to disable all hints
Date: Wed, 24 Apr 2024 13:58:57 +1000
Message-ID: <20240424035857.84583-3-james@jamesliu.io>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424035857.84583-1-james@jamesliu.io>
References: <20240424035857.84583-1-james@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Advice hints must be disabled individually by setting the relevant
advice.* variables to false in the Git configuration. For server-side
usages of Git where hints aren't necessary, it can be cumbersome to
maintain configuration to disable all advice hints. This is especially
the case if/when new advice hints are added.

Add a new "all" advice variable which acts as a toggle for all advice
types. When this is being used, individual advice hints can be enabled
by setting their respective configs to true.

Signed-off-by: James Liu <james@jamesliu.io>
---
 Documentation/config/advice.txt |  5 +++++
 advice.c                        |  8 ++++++++
 advice.h                        |  1 +
 t/t0018-advice.sh               | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index 0e35ae5240..0516a23b6b 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -5,6 +5,11 @@ advice.*::
 	that you do not need the help message by setting these to `false`:
 +
 --
+	all::
+		Convenience option that allows all advice hints to be
+		disabled when set to false. When false, individual
+		advice hints can be enabled by setting them to true.
+		Setting this to true is a no-op.
 	addEmbeddedRepo::
 		Shown when the user accidentally adds one
 		git repo inside of another.
diff --git a/advice.c b/advice.c
index 75111191ad..9f0860f143 100644
--- a/advice.c
+++ b/advice.c
@@ -43,6 +43,7 @@ static struct {
 	const char *key;
 	enum advice_level level;
 } advice_setting[] = {
+	[ADVICE_ALL]					= { "all" },
 	[ADVICE_ADD_EMBEDDED_REPO]			= { "addEmbeddedRepo" },
 	[ADVICE_ADD_EMPTY_PATHSPEC]			= { "addEmptyPathspec" },
 	[ADVICE_ADD_IGNORED_FILE]			= { "addIgnoredFile" },
@@ -132,6 +133,13 @@ int advice_enabled(enum advice_type type)
 		return enabled &&
 		       advice_enabled(ADVICE_PUSH_UPDATE_REJECTED_ALIAS);
 
+	/*
+	 * We still allow for specific advice hints to be enabled if
+	 * advice.all == false.
+	 */
+	if (advice_setting[ADVICE_ALL].level == ADVICE_LEVEL_DISABLED)
+		return advice_setting[type].level == ADVICE_LEVEL_ENABLED;
+
 	return enabled;
 }
 
diff --git a/advice.h b/advice.h
index c8d29f97f3..b5ac99a645 100644
--- a/advice.h
+++ b/advice.h
@@ -11,6 +11,7 @@ struct string_list;
  * Call advise_if_enabled to print your advice.
  */
 enum advice_type {
+	ADVICE_ALL,
 	ADVICE_ADD_EMBEDDED_REPO,
 	ADVICE_ADD_EMPTY_PATHSPEC,
 	ADVICE_ADD_IGNORED_FILE,
diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
index 8010796e1f..19318cc9bb 100755
--- a/t/t0018-advice.sh
+++ b/t/t0018-advice.sh
@@ -53,4 +53,37 @@ test_expect_success 'advice should be printed when advice.pushUpdateRejected is
 	test_cmp expect actual
 '
 
+test_expect_success 'advice should not be printed when advice.all is set to false' '
+	test_config advice.all false &&
+	test-tool advise nestedTag "This is a piece of advice" 2>actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'advice should not be printed for pushUpdateRejected when advice.all is set to false' '
+	test_config advice.all false &&
+	test-tool advise pushUpdateRejected "This is a piece of advice" 2>actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'advice should be printed when advice.all is set to false, but specific advice is set to true' '
+	cat >expect <<-\EOF &&
+	hint: This is a piece of advice
+	EOF
+	test_config advice.all false &&
+	test_config advice.nestedTag true &&
+	test-tool advise nestedTag "This is a piece of advice" 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'advice should be printed when advice.all is set to false, but advice.pushUpdateRejected and its alias are set to true' '
+	cat >expect <<-\EOF &&
+	hint: This is a piece of advice
+	EOF
+	test_config advice.all false &&
+	test_config advice.pushUpdateRejected true &&
+	test_config advice.pushNonFastForward true &&
+	test-tool advise pushUpdateRejected "This is a piece of advice" 2>actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.44.0

