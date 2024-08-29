Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0634818FC84
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924357; cv=none; b=rl1ynZ28LBAmrnFj2dzWo0+Jjm5i3YVphk9SxLwglTsOn/4qYZziaxX5Eh3aBAlvviOqfG1+Ihvw+nDtLTxHNqvL+Qh8TXmMTaBNFv0bFXeDKVCf487uHQyaidXsz6/M6XeNP06FkjWvFX8mEv0gV1Z3F6w7Of0z6bfRG3Wt3Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924357; c=relaxed/simple;
	bh=8eOG7V/j8a9xbiofvwfUgM8epzyfufMLuIRGC8lIKts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYJQljqP0hxDOxwzdHZsJDHLWbVk+2T9CQVqUkFdtpxKeT1ilJ4GYRxn/AR4S2ybKwaWC4Rtl477OVjrKC2XK/YnZGCd8n303tdT/R4m9e58ZvFwL5fM2VXb0tjY2E51SitHJbxBsB8NdB1SO1H7ZNyUKAmI3PtbFY2660V12Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Sj/YGSkB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k7CCHGrA; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sj/YGSkB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k7CCHGrA"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 138D71151CC3;
	Thu, 29 Aug 2024 05:39:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 29 Aug 2024 05:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724924355; x=1725010755; bh=JTYkqay8tG
	Kra5vGqEltXTgHjzaFkvjI4FmWTrbSPgE=; b=Sj/YGSkBW7a/BXnpaCzlnuYnkv
	BjzEomXDrosjOZ/XsIuhv5UgronOg+5OrYmrRLEmVwUn5QX63sBiAHF8XGjbdSQa
	dWc1UQLf6kWh4xbTwFOzuFtFBgrHvFp9gpsqDdDKddWAL6S22TNNwGsm3HuTtPxt
	rMtikxz1C3IJUkyDc1nUZ0nxegIeDnizt+U9BcX1edPrc3T+YhhuoV1gpeM2HmvE
	cxHVsyedJK5MKcuB8BJlQjyScmUaQYhNBX/8kjTnXewAjPFKU0OII+FLdEnrQa6l
	twi5Z1asWgR3hrAIRpBK3uuNiOhvb0MdOM5raZrp7YxX0Hwc6GU0upH4Txqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724924355; x=1725010755; bh=JTYkqay8tGKra5vGqEltXTgHjzaF
	kvjI4FmWTrbSPgE=; b=k7CCHGrAUTOWnQOZHBIRBA4fgr5Ox9NLHnYjae/gk1Ey
	hR72zbGt+V4K84DJNGMbot5L92VUOssG7TZxF0SfIMpywy6BZv3FCFUumxFuRiUX
	rQELgVFvr935pyAq0RAAilkAXEMhUyJWAlCFCNdLUEmvHn11XtAKaaYHx4gbni2y
	Fqae1xHUQKpdB9ha5RX6aOH1zgKbPerf0WxJojTggKxFrszlISvv6/OHH4XN3vL3
	qePPiStF1IMOiNz9Ex5AbTm5T35UpAZyvR9mJSdCJXwCop92rm89YSZhqgKl1iTk
	MOyD+oPPd8GFFUhg4B8PtA2YgiRPxM4FX5Iw8Vx2dw==
X-ME-Sender: <xms:wkHQZqeqE8vvyl9qdKSOqdFJfTaFB0kW1iAUWbTaV80JhhomwCjjDQ>
    <xme:wkHQZkPPm471y7KbKf3NrkqV1xoQ4bWbV96HGyHTcQeCRrKYqXhghzLByv1dBj1qS
    wYVuyYhf82-exwFGw>
X-ME-Received: <xmr:wkHQZrjJsdfzN9gLhWgt6niP9D4EAbuKunrkOMin1SWTnfs7UqBTqsmMeoDc-GBE5YwtM8Emss2TFcNTu5YEPQS-OLe2fmLbAl6AilXu1nbJSDM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:wkHQZn-fcVzDo7jDNC43k18AV9dCPv_n61onKtscvoPYdSFqttsYIA>
    <xmx:w0HQZmvHBNlWEvL4GNRxVSUidsfntzo9cpLrG9ABAhwV_LmuFdwrcg>
    <xmx:w0HQZuGmvdPPUDppQokkgKwESi0FyM491JPB1jT4IW76iNhAoEV7pg>
    <xmx:w0HQZlPFt_Np6IyWNWKRNuO0wnr74IZ8EsFn1HEdQecLWe6o1T3ObQ>
    <xmx:w0HQZv42u_Wu6GyWyU-cJkaZQi7p1JFV4UzONjibHLSV6F1KOPSL_gIW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 05:39:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c193a4b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 09:39:06 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:39:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>
Subject: [PATCH 15/21] branch: stop modifying `log_all_ref_updates` variable
Message-ID: <f1b6807fae32f58aa8243884205bd8df307856bc.1724923648.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724923648.git.ps@pks.im>

In "branch.c" we modify the global `log_all_ref_updates` variable to
force creation of a reflog entry. Modifying global state like this is
discouraged, as it may have all kinds of consequences in other places of
our codebase.

Stop modifying the variable and pass the `REF_FORCE_CREATE_REFLOG` flag,
which has the same effect.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 branch.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/branch.c b/branch.c
index c887ea21514..08fa4094d2b 100644
--- a/branch.c
+++ b/branch.c
@@ -601,6 +601,7 @@ void create_branch(struct repository *r,
 	int forcing = 0;
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
+	int flags = 0;
 	char *msg;
 
 	if (track == BRANCH_TRACK_OVERRIDE)
@@ -619,7 +620,7 @@ void create_branch(struct repository *r,
 		goto cleanup;
 
 	if (reflog)
-		log_all_ref_updates = LOG_REFS_NORMAL;
+		flags |= REF_FORCE_CREATE_REFLOG;
 
 	if (forcing)
 		msg = xstrfmt("branch: Reset to %s", start_name);
@@ -630,7 +631,7 @@ void create_branch(struct repository *r,
 	if (!transaction ||
 		ref_transaction_update(transaction, ref.buf,
 					&oid, forcing ? NULL : null_oid(),
-					NULL, NULL, 0, msg, &err) ||
+					NULL, NULL, flags, msg, &err) ||
 		ref_transaction_commit(transaction, &err))
 		die("%s", err.buf);
 	ref_transaction_free(transaction);
-- 
2.46.0.421.g159f2d50e7.dirty

