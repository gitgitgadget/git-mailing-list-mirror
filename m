Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D9D1D130C
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882165; cv=none; b=mSjFF4Vf6Sr2oyjJlBVO7Bo5bMO/u+Ar9uMK3lRLMGYv2pnn5WB1RMlh0+4T+3u77FmAgNNka7nrcIMPXbdvPlnVlQ2P/vqxsHvcovsnnYCgET6BnG/R+tCD9lFOtHKNTDgg1O0kvBgOD5DD+C47wvCVwuM8ZCQ/W259CbGD5e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882165; c=relaxed/simple;
	bh=f95UTIwt8t7uQeU96cETUzINe6UYvF7DEQElrpalhJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXdN0wDCMAtr0I882LueiCxb+pyHrlmik59tW9nIu5Y/uv+TsCnYam9AFY4qbtguLRliQjAtShgskuvBZV+f3+QaoDfa+BeHzNrvvL1FEkYOE+4JUEnDgqgEJejkVyDmBxV+s9vtHfcohziC6RqzwMcamN8MZxcdjdlw52lyu4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gCvhjP3b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RphDSqny; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gCvhjP3b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RphDSqny"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 84411138017B;
	Wed,  2 Oct 2024 11:16:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 02 Oct 2024 11:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727882163; x=1727968563; bh=N4O17Tch5m
	2ACD3nyl3e157QJGqhaF/9S28wrCBxjHo=; b=gCvhjP3bQnbLEGkYSVEDEyui7E
	ZolrlpOP4OG3+2uqFnhgpJwA/W4G2HXdsu6wPSsWpxB/xoXRVx5A7PAAizYegO6i
	jB8PpnJ5AkSBS5rwAuywfcarOsCKAhEbReRinv3LzdwU5mDldWtOCH1nnRSjgPbC
	6GBRAvfKmlyXpNkVJWNP9Jfwk0dw5ce7b8ktiK93qlZOjf27dfF0wTuIsC5Tyrv2
	uiS2ZTt1QxHP7sjnyeSdi4U5AB7sgio1x6IP7z/2BFaNYpPiZ2Lu0a8+B3z5pdhL
	moasINRC1sulukI2iIYiFcC+7RrkBDEqCcjbG8FiqoSgzz5xD4gzy2aDvY+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727882163; x=1727968563; bh=N4O17Tch5m2ACD3nyl3e157QJGqh
	aF/9S28wrCBxjHo=; b=RphDSqnyAkpjA8g4TzAxqO1vXtaW4tTB/UUJrNhImV5I
	UTAhITypy5Vh9juyworYh3u9k4UR52E9fouqSghRthVaPyUMpvIcCAEtRFMxtzrQ
	7WiW3eSMk88WExSZ1tOzgNRFkYADvSbnDz4tsKe3UnjGUSpoHg8ZBOw2XeOdUo1q
	Xf4PREEyLIJ03DL62WzakuZoc7PzeAGGtUVnzlmE/VXM2MRzSpOCy8rXlmavRz9/
	o04Nwi+hHYoEUB9SGRLcqX5Op0IyAzle9t2SU1oH5gd0PTAjtSIZT2zrox4BJgNo
	xA/h6BgXvf3hcKeHZLVgY+Nd4SfyekzrREeuI02ztA==
X-ME-Sender: <xms:s2P9ZlAzR0n0Fueot-YgrfYushAVD0U1RHYwKyMXtfJvQY_8W3ldJQ>
    <xme:s2P9ZjjVICH6YE5W059Obdyf7oNYHvHcr-Q_ELr-dMxDORb5DHwc3ddKrwshVR1oO
    D41pivblpqPpHJjeg>
X-ME-Received: <xmr:s2P9Zglxi7HGXtY0tdRn8wVR05DH6RMY_IchS_g9Omd0KZiSMZkNa62Pc9ptqMWvTyLah1GwEkWFrihbRyylE93MzzfGlqqTycoJQ_Sw1km9Do05>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:s2P9ZvyiHCfLdHYU1D1EYO7U2CdenRsKRS62LBkFmntnY0RVRo7G7w>
    <xmx:s2P9ZqSRM2ZgyOLzliv6OOhwVGlYsea3FBZmpf5jj9hu101aSXKbzA>
    <xmx:s2P9Zib35NTmyGC5a4LAlyeSTq44Uhrr34Xb4xjWasGmvlg8rGsipA>
    <xmx:s2P9ZrTwLpkqyMjEsYWAPSBr3ahoVbryteBz0kn4l7uRK8tP6s0ciQ>
    <xmx:s2P9Zlevmdm13jJdpkNCjdN2qk5-geQgYR8om0QmedvL_xsj3O92h7u2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 11:16:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dac9d9d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 15:15:12 +0000 (UTC)
Date: Wed, 2 Oct 2024 17:16:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>
Subject: [RFC PATCH 08/21] builtin/credential-cache: fix missing parameter
 for stub function
Message-ID: <7a36ad58384df4d3b0335ffb0c4b63b3e89ccdfb.1727881164.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727881164.git.ps@pks.im>

When not compiling the credential cache we may use a stub function for
`cmd_credential_cache()`. With commit 9b1cb5070f (builtin: add a
repository parameter for builtin functions, 2024-09-13), we have added a
new parameter to all of those top-level `cmd_*()` functions, and did
indeed adapt the non-stubbed-out `cmd_credential_cache()`. But we didn't
adapt the stubbed-out variant, so the code does not compile.

Fix this by adding the missing parameter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/credential-cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index 5de8b9123b..c51f7fc2ad 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -189,7 +189,8 @@ int cmd_credential_cache(int argc,
 
 #else
 
-int cmd_credential_cache(int argc, const char **argv, const char *prefix)
+int cmd_credential_cache(int argc, const char **argv, const char *prefix,
+			 struct repository *repo UNUSED)
 {
 	const char * const usage[] = {
 		"git credential-cache [options] <action>",
-- 
2.47.0.rc0.dirty

