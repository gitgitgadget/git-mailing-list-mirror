Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A635C13B5A6
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 03:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713931189; cv=none; b=CIr7e7F4KcLzjvQMyEYUBJhxATIGaH7SVrbMf+V8eS3+cEe0AMZofc+iHn3gFXBgyFc4h6z2oBLzxejlXSY5CxFYy49OQon93IymMVA/WUD+YREiVBfJZ68pQdqRXiheXT/N2TLk6A4/h/ZXoUT97N07YFVnFsrTmggFuwtUqVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713931189; c=relaxed/simple;
	bh=d6TgesztYRXEiwFlvV2OnruEbqW4Mez0Pslfbow6Jec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIvpNUcsb3LXOIg36ZpTfiYbLbIXsL/NzEY5JnTyWFdvPw6O2E3H7bHT8RcvXUr8ZgAmrvr5MDGqwuwU8hrOku05T1OOs10PtBsQ1I4eEXDci8/8klbu8zIyxA21ExCjWhuixHORIiIOQsPF6g3HJ2ynA1pT4b+bQg+3Pt3EFyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=SA4tkjN8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PsmI1spd; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="SA4tkjN8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PsmI1spd"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id ABD4313800F9;
	Tue, 23 Apr 2024 23:59:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 23 Apr 2024 23:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1713931186; x=
	1714017586; bh=XVCFKCprQRQnFRV5OhH1aHv8oIOrOrQGJ4BkmBH9ebk=; b=S
	A4tkjN8oz1UeJ7UVtsrl3IUC1n17VE9HoPKadHNYoXXTys7zXtHMNKShu69QsOtA
	R5BxsSAjEzgXuE+VVyav8W6IfAmtEN2ejNy+EfwM5aeTek/WEnYqYJE8QhL+VRlF
	Y3uOP1BE4aFsLl33EPgbCNahLKtgtbj6gGuv8O2YRLsuznDo/9QBeIjVLGKRHYxJ
	QViyECmCpIGfdAXKNCOAPsoecmhDRWFAsTTRCmxtszZxA59UnV3TroC+VU+O+flX
	jBmshRpzhwSifkYabfj0IxsYdYXdnqUh+MM0xQTX7UgDfTVu/u/bxmff2BlUWUvj
	OyaxA4J5A7WvEHguNu93w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713931186; x=
	1714017586; bh=XVCFKCprQRQnFRV5OhH1aHv8oIOrOrQGJ4BkmBH9ebk=; b=P
	smI1spdVZLnDa+sHq0MORsPAeD0/rJ4HCHcKgcn1XZ84kCBtfvgabG1sUMt+3jrl
	6sIIlIs02vjy6kuZDvcNPqO7TsMaU5Y5r1WBoP+jFvLk+gabzCAoIwaRdpgJ73U5
	PiA9R8t9IEfq/o2yyIoqmYXJlExmtpaEimg+3ba4Wf5yorjp44GFQprvynUtdeTg
	cuaRTCeRjpOHBFjJ/0xTSgjvhcQej3CnUpSr9vuMuCqZJxHSXv30w85XnrEuWRIk
	ycx+8Fi18ViG+njj7NJ/aW0l0f+mE2SIK2bhjO59lZ9bxH+e0Aoxfxq1AmDIcabR
	k9LJ3AL4JPAkp9/ZDJltw==
X-ME-Sender: <xms:soMoZoLta77dfNpUs6KNPckNh-9j9ZoYtgk4JkRmMsKGyQdQ652X5w>
    <xme:soMoZoIIJQNECf0bWe6-Rh3stMnCyvH3J5CHZ5jpvDw8FOBbqkca8u6d5KRNuEjLe
    LodNtUOg41K_GbGNw>
X-ME-Received: <xmr:soMoZovDoSdCHEWZYxRP9cbClrc6fmWxHQnt3rSuu-VPPolLws_vWbk1CJR2wnqSBCIJ68dmZwcVBcbn-ztdFVb2raltsuSM_aVYOMe85RNIKXjdnquHnWo1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelvddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflrghmvghsucfnihhuuceojhgrmhgvshesjhgrmhgvshhl
    ihhurdhioheqnecuggftrfgrthhtvghrnhepleejtdeuudfgteegfeeiudehleeutedvhf
    euueeuheevleejkeelteetfeevhfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepjhgrmhgvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:soMoZlaQlkgHW0Hlia1IBNzny_EicypWRcmxHN5ddUL-uP7z2jNq5A>
    <xmx:soMoZvZ8VA1XowWUmTKqADz-HlWzdGpDvFu2Fhev5teOwZNBVO9bpQ>
    <xmx:soMoZhDV7JwSdVcjnfwbzF7gY7j7coPEoldXH_58zL_0Kf7iYz4sKQ>
    <xmx:soMoZlapoFVbp-gGg-fWRxh8AE081Vam-Fycif5_K4o_QOgd6ab3cA>
    <xmx:soMoZuny2cfq2RFu6k6sjAvYdnWbIMdxXjbjwncUBZTTh2VJIdRCptDE>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 23:59:45 -0400 (EDT)
From: James Liu <james@jamesliu.io>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>
Subject: [PATCH 1/2] advice: allow advice type to be provided in tests
Date: Wed, 24 Apr 2024 13:58:56 +1000
Message-ID: <20240424035857.84583-2-james@jamesliu.io>
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

advise_if_enabled() has a special branch to handle
backwards-compatibility with the `pushUpdateRejected` and
`pushNonFastForward` advice types, which went untested.

Modify the `test-tool advise` command so the advice type can be changed
between nestedTag (the previous behaviour) and pushUpdateRejected.

Signed-off-by: James Liu <james@jamesliu.io>
---
 t/helper/test-advise.c | 20 ++++++++++++++------
 t/t0018-advice.sh      | 30 +++++++++++++++++++++++++++---
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/t/helper/test-advise.c b/t/helper/test-advise.c
index 8a3fd0009a..c18b18e059 100644
--- a/t/helper/test-advise.c
+++ b/t/helper/test-advise.c
@@ -5,18 +5,26 @@
 
 int cmd__advise_if_enabled(int argc, const char **argv)
 {
-	if (argc != 2)
-		die("usage: %s <advice>", argv[0]);
+	if (argc != 3)
+		die("usage: %s nestedTag|pushUpdateRejected <advice>", argv[0]);
 
 	setup_git_directory();
 	git_config(git_default_config, NULL);
 
 	/*
-	 * Any advice type can be used for testing, but NESTED_TAG was
-	 * selected here and in t0018 where this command is being
-	 * executed.
+	 * Any advice type can be used for testing, but ADVICE_NESTED_TAG and
+	 * ADVICE_PUSH_UPDATE_REJECTED were selected here and used in t0018
+	 * where this command is being executed.
+	 *
+	 * This allows test cases to exercise the normal and special branch
+	 * within advice_enabled().
 	 */
-	advise_if_enabled(ADVICE_NESTED_TAG, "%s", argv[1]);
+	if (!strcmp(argv[1], "nestedTag"))
+		advise_if_enabled(ADVICE_NESTED_TAG, "%s", argv[2]);
+	else if (!strcmp(argv[1], "pushUpdateRejected"))
+		advise_if_enabled(ADVICE_PUSH_UPDATE_REJECTED, "%s", argv[2]);
+	else
+		die("advice type should be nestedTag|pushUpdateRejected");
 
 	return 0;
 }
diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
index 0dcfb760a2..8010796e1f 100755
--- a/t/t0018-advice.sh
+++ b/t/t0018-advice.sh
@@ -10,7 +10,16 @@ test_expect_success 'advice should be printed when config variable is unset' '
 	hint: This is a piece of advice
 	hint: Disable this message with "git config advice.nestedTag false"
 	EOF
-	test-tool advise "This is a piece of advice" 2>actual &&
+	test-tool advise nestedTag "This is a piece of advice" 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'advice should be printed when advice.pushUpdateRejected and its alias are unset' '
+	cat >expect <<-\EOF &&
+	hint: This is a piece of advice
+	hint: Disable this message with "git config advice.pushUpdateRejected false"
+	EOF
+	test-tool advise pushUpdateRejected "This is a piece of advice" 2>actual &&
 	test_cmp expect actual
 '
 
@@ -19,14 +28,29 @@ test_expect_success 'advice should be printed when config variable is set to tru
 	hint: This is a piece of advice
 	EOF
 	test_config advice.nestedTag true &&
-	test-tool advise "This is a piece of advice" 2>actual &&
+	test-tool advise nestedTag "This is a piece of advice" 2>actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'advice should not be printed when config variable is set to false' '
 	test_config advice.nestedTag false &&
-	test-tool advise "This is a piece of advice" 2>actual &&
+	test-tool advise nestedTag "This is a piece of advice" 2>actual &&
 	test_must_be_empty actual
 '
 
+test_expect_success 'advice should not be printed when advice.pushUpdateRejected is unset but its alias is set to false' '
+	test_config advice.pushNonFastForward false &&
+	test-tool advise pushUpdateRejected "This is a piece of advice" 2>actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'advice should be printed when advice.pushUpdateRejected is set to true and its alias is unset' '
+	cat >expect <<-\EOF &&
+	hint: This is a piece of advice
+	EOF
+	test_config advice.pushUpdateRejected true &&
+	test-tool advise pushUpdateRejected "This is a piece of advice" 2>actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.44.0

