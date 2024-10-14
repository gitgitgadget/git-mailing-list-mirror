Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E431A4F38
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908502; cv=none; b=atjBbaWm+68H7jfPwYvi5z7OEq7wIWjgvClphkALWizFeZ8JwkjOPSDlvZjbE/hwxhUkKw5fqwOjHTrtTR22ogDpFIWFBoVU3dpJLyRBhPLMHw0FbY7dIAIxQta7UDA9BnsXBDl0GyG7+wsg5E3wsUTMcacOcHzryT27HvZztAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908502; c=relaxed/simple;
	bh=z5fcBVOlJRoUYkjxuCCNUcYz7u24YP7CyLGAoi69czc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxWY3rjudeqJaI3F1ST7b7xtIOB8pciJi/ot5JRxpgmh6EvyJqGlPwfYZmDowXq48b6uJdoB7L5Pv8yyLHvbM5XQ4u6KMJy14uc//jcZiFEnU7dt05bAAx13b8RDKYpqxmcnchwysLepJrnpf4I/fLXaAlXYjPOdAZqkRSPxRMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fEDKKncT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VmAiUXoy; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fEDKKncT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VmAiUXoy"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1839E11401D9
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 08:21:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 14 Oct 2024 08:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728908500; x=1728994900; bh=OjO+BO/SB5
	iPDMJKqNhiLMNDSumXSGUa9S6Qe2/1BaA=; b=fEDKKncTXwffVIEp1KTUo60pTs
	roFLTSDmJ17lhFjIMTWeBrZECtNlxXlbkE08odVwxC+0h3FnTjdVx14ze4o0wDtA
	d+PpbKFGRhvhCQjT7A/FE4lDTq0dHkx201lkAA7ya5KyLH6/E1LdlR3JKAZ0l0pV
	4+rAgFsaNY3hY0zyRCGymbDFX3pcX03wwiB59sZO7CKOhR9z9sfXrC94+0dstXBu
	jyubYyAyiWwwzSQYf9NUCO7zJ/2LE5d2MU8yLdGGTkw9TTwes9Wc0VAT03E2O1jF
	GgRX75wdtROK6RfwFskfUg26MS7GHCzHY7x1xjdSa/GhjD+n+vJJUbvBAYHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728908500; x=1728994900; bh=OjO+BO/SB5iPDMJKqNhiLMNDSumX
	SGUa9S6Qe2/1BaA=; b=VmAiUXoyk1F6ZkjONnyz/Xd1zi9KjIg01SLPvitsBrNF
	6vR0w/JeUMGUUTRqSM5FSwcw3uBYXpUE7o8a4h0D+oRH/Yt1P00w5SzbwIcU1CaD
	QsVbh0JIdL7CmDhH1MDTYOpYAJAy3vA9UySwfEd55/nN09s5qtGZgmQGGnvTuSB8
	OEMba8QJm8p6/JFWuSNs29wS6qW/xD5eEZ30LBDb0A/bsz5QxWAo3dBZgsfM+6JG
	3TdwrrwTk+WfCQIwY/dcz+1nLysTam/lt459lD9IG510pqd3jC4B+H95Ce8cVfuE
	qzQy7E5Eve73zUT3AeIPk9+7BZzX3JM0NKUyIm1tIA==
X-ME-Sender: <xms:0wwNZzD05o9wgg-YrfA52GVWRcmWHe12tlaI87LUrYArLMRwh9KTOA>
    <xme:0wwNZ5g078jg11ot-tE8cLW197Uf4oCGe5AWzvPrhy_IAi-UB6sILo3ENic8Yt_SY
    -epweSNsvYEyBuryw>
X-ME-Received: <xmr:0wwNZ-lMmrrcMQaaHAg4bGh3bL12jMKzpk-TnIi56qcm2zicd4-DP8UDGJT2n_HtG6smYRNcwh90cIuq56VYtmNPo5fiZsXKDGsbNEHStEHhkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0wwNZ1yBe05EVsQOwqVy2siINX6F0PlpXq1OL0twB5O8_eghyFqz1g>
    <xmx:0wwNZ4SA4qWBMaJWI5YmBjgPcFO1n0SAf0HjeMgX3sU_PGVL0yM6rg>
    <xmx:0wwNZ4bsfZMdcsL1nTyExlrCwIpKmg6gCIC7aZ3cGz_hl2kKzTl_og>
    <xmx:0wwNZ5SqQ6HRtIkX8xNIVHKAqyJwOfHcMz7xJLGvyXBQjpw6PZfDLg>
    <xmx:1AwNZzLc5sRTDw9lGFesDOQzt9XuJa4ivqtVRFQykL3ZZeD3zzf3M7Az>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 14 Oct 2024 08:21:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a06f8c92 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 14 Oct 2024 12:20:26 +0000 (UTC)
Date: Mon, 14 Oct 2024 14:21:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 09/10] builtin/credential-cache: fix missing parameter for
 stub function
Message-ID: <8cce69e5ba63d02ef4eb1e8cf56f47443b5bb1dd.1728906490.git.ps@pks.im>
References: <cover.1728906490.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728906490.git.ps@pks.im>

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
index 5de8b9123bf..c51f7fc2ade 100644
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
2.47.0.dirty

