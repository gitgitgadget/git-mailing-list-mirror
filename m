Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BDD1DF26E
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864772; cv=none; b=C4FjSnwQkcFxOBcdAnF0mGfuMBKo7KcD+FDUuAi2yJQG9VEHX8AdgjC7pWEVlbtgl5D++uW9oNlvyouIJ0USFzR2lTtf2Klr+zParqgQdCfoy01FnPUr/dxOFUjfc20jv8mEuGJp8/8QtL8C+DLKmaIgmwg768KKTXfLO6+Feu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864772; c=relaxed/simple;
	bh=mY4lzOivTptFMKbuCLdMMve6j/1W5yee0LWySaRZWxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hVcfcdAn500lUseUZeIPVCd9VXFDmBxk+/Bb0zCnYnNZOZzLcFul0v90+1qXBDJWH7Q5z4BkNzLpO991rIRyhsvadg2gaJUeHVvBeQLdJ308oml5Q+/CqHYvgXs+wJ1Bae5Y42/UPYFZ7DEeljCMiSE0sAsVu42gCGRuQpuSX4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l7OHxX6Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NDEvqxwV; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l7OHxX6Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NDEvqxwV"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E9C3311401F6;
	Tue, 18 Feb 2025 02:46:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 18 Feb 2025 02:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739864769;
	 x=1739951169; bh=coYQ0IU816FHyvUOYVSuNNf+UUjRIMrOXaV9KEb76Rg=; b=
	l7OHxX6ZfpxU9x+ocQccIvPIL1/TryWU/+rBRevxw0j72LtjxtCv9ag2ng9itIqf
	giq3l1Esr2qjqnjn2Tklt6ihoC41nosNXfpr8xQkc/pxnA3vmXluQo8rcW74x0je
	jDFE45KlJH+uM+bC1Hk2MyeRiXiz3vHzkhHqeFm2KbcT7gX8V/Myo2oYYfs1FZfv
	6Axy4MEUqJnERJgDkTmC21QwmdFgqXykjgSYS2AyeSptMRcXBSKjBFLydUxQdSKS
	GvoQhp0+E855Y26zIVZfrs2bTPCJoFHj1fi8BFcH0F8E5znJzJLWrG5VWLKLl6Of
	UId8gLPmlBQvsa3dxeA8Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739864769; x=
	1739951169; bh=coYQ0IU816FHyvUOYVSuNNf+UUjRIMrOXaV9KEb76Rg=; b=N
	DEvqxwV7CusXOH6gvKvNfi6FLYNB0WZSrb4QR7cXcAhs314kAejvt25VjF2TB6P+
	YSptx+ouqR7m/pX1cyyznN3osquTmEuO6F4XJgMmWgynMadbc3kuMEm9PwUfcM81
	aRyxgDouBkOi/2zm/yeNISpNAkgd5yfeHy8D67plmhuzrh44+cypQiNFFyiTpl2d
	K2HmMpHl3rbA2Ttm4S3a12XVAETfnunuUgKL1Zh4SyV33rCoWfXFvo9T3B9pRrHE
	zvPVMJFuM1BB7PSWbCcOSD+HE4czSMLAnf7XWOATUBnQuX3j5U9Siy0oc6kvtfn2
	7FEU83/61G2wZ+igAbz5Q==
X-ME-Sender: <xms:wTq0Z0z4CrOzMHrmpGOcNrWvh7cdJ1CzORc2rGFnGR6S4OuvlsoEMg>
    <xme:wTq0Z4Qcxiwi6qjblv2f0JrjmlOShrO0bUWjQnM8g_amQfSn_f4vC8xFgiEAp38bu
    1kzUp8Q2Dr_-vGRKQ>
X-ME-Received: <xmr:wTq0Z2UUCceEFXZ-SX37s5QAFRBpqKAWTQAd2PSt0G4kjc1U2HLrxbb5Ran03norHLPr_cFSmVFqCPh6oLjSSOXptfK2V7ZKbjQUMrOUD5x15qny>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhrugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:wTq0ZyjZL48TfXDd6HwXwLeSixvroX4-Spg7AitFZdH7tVIyS182UA>
    <xmx:wTq0Z2AqnRFgnzslqSrpKpJ2UStRjx8n6oJLzhEPbsaZ6wGG3BuoBg>
    <xmx:wTq0ZzLnY4X6Cp6AW6AF8QRmVA3yLOT2vGy81Wsu1x-gYchDBtHWcQ>
    <xmx:wTq0Z9Dt9X0Gx1U8XBvXEHl90_k6bisPecK5raBE8UtJozgOwDEndg>
    <xmx:wTq0Z5MjP1-Pd-FPceLAs2ikJNDzPeLG8N1B5tNKnQl5Aou2511rw7rd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 02:46:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a9ce3810 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 07:46:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 08:45:53 +0100
Subject: [PATCH 05/12] contrib/credential: fix compilation of "osxkeychain"
 helper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-b4-pks-meson-contrib-v1-5-c3edd292beb8@pks.im>
References: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
In-Reply-To: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>
X-Mailer: b4 0.14.2

The "osxkeychain" helper does not compile due to a warning generated by
the unused `argc` parameter. Fix the warning by checking for the minimum
number of required arguments explicitly in the least restrictive way
possible.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/credential/osxkeychain/git-credential-osxkeychain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index 1c8310d7fef..611c9798b3a 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -422,7 +422,7 @@ int main(int argc, const char **argv)
 	const char *usage =
 		"usage: git credential-osxkeychain <get|store|erase>";
 
-	if (!argv[1])
+	if (argc < 2 || !*argv[1])
 		die("%s", usage);
 
 	if (open(argv[0], O_RDONLY | O_EXLOCK) == -1)

-- 
2.48.1.666.gff9fcf71b7.dirty

