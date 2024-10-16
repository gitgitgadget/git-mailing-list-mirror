Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847231B2193
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 08:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066400; cv=none; b=Wsmc1j9zy89l82eqin6J81A79M/CtfakXsV309bc9TTZ5wO6p8g+iVfHFAjKkddC+R0OVCPG/214zAebS+/POX+E7Dp1dsGO6hP2BI5isdCCFxgPmSCGh5OwmUOsDX956rZsSlpPV/vVCE+g4B3bIBOkPGJJIAZejR3KwLGpSSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066400; c=relaxed/simple;
	bh=WGsUMN/OhbdSxQHTpJKsXhGTNq4EYp55mRJedIl61jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCdiTHsV9DPu49YJ84jeJEJhRhEk1a+w5yJVA2//A8Onv+OfyLril91x2+1ElGgIu0ueUHUqzVrs+4bEw8MadIr/X+PgrZIYDk6hoM0+JuGMsUsq659kcX+tX0NcbD+EbRE+FDXnET52MBcLLSVIPhyzxH8kHSt+exP1sAY49W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q0b772il; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fpcn3Xe7; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q0b772il";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fpcn3Xe7"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B01D31380123;
	Wed, 16 Oct 2024 04:13:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 16 Oct 2024 04:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729066397; x=1729152797; bh=Ippqaah5zo
	lH/JiAY87V5UgrQLa0e7sxtGw+W68iWCc=; b=Q0b772il1f5UnpZi80ZMKfDvdO
	mYdxtYiMvFB7PzmvdazNDE1aBM/AcYWuT/s6hZt1HMzWIHdQK07PxQ64+ujVR2D1
	36u1w4+TlI3/0FYxDxa8DKheYOGKF551NbzFjlBoInIFohl+cqBysOBoIenzTmgS
	OAznQ1O8Amj4BnYjaEPv9lDbTOyKh2YDXD0eYXsdSUfrnWGcCdoRL2Tq2/AOMrX9
	72U9CohgPYqrM15Qxq5rcCdaadK81HEevM5rZhk1g8VJh3yO+dLs1pGL4JC1IAqW
	CKSWb/VkumbX03yHha+2aEhGZGfpbREvcw2UpihzboHhPUOkaR6aDzyOtZ8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729066397; x=1729152797; bh=Ippqaah5zolH/JiAY87V5UgrQLa0
	e7sxtGw+W68iWCc=; b=Fpcn3Xe70J3BOKa5kz7RCqPT0P0zO9Bk9atIxm6MGs7R
	PjUFZAw4BsoXPFioKTXsUiG6HMTfgaw7xgt+VHF/9QEVuEZXiNWBRdyZO/WfXKyo
	ymHpiyzAfMhfyJ0aapkxFHRU6iEmYom5eNX/DwEd+o36PBAE5dGQvA2/nx4iuM90
	Al+MYbY+awP/tFF66GfiJgPNj4QMHzyXY/o61Aem5zm73sgga6BZ+OEaznFVZjhF
	SWRLvSw/rmxx5c1jtb5D7kjeMd1VWWIE4UPeN9ANk+35moFVyp+0yuCxqnCoeRpa
	8Vxqvn6Vl9dvlUKjt2BhmQzG6RLbK6h5uydyCqdulw==
X-ME-Sender: <xms:nXUPZ30J0nyYhbt65qKjJD22iaHxbcPMpmE3UReqkaXz_OCgGop1tQ>
    <xme:nXUPZ2F0JkdICg4CwrUhxNlusePNGnmMbsvhLpJPoUuI6rbWKWpKte3XOeLnaN4xK
    kwQ6B4-6udj-hxbGQ>
X-ME-Received: <xmr:nXUPZ34LuzaZYFpo6zN850mhgfKy5nLmDYrEeRnGlM4PsGljLr7x8FKsPH41SUyer7RS_ITrkqgtDQF7pUbhMLoSyhO41Bht7OmTeO4aB4PiWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nXUPZ82EAnub1ySHmvncSPqgVLOMVaayCrf2IYHRUi4BwOx0oVyCkA>
    <xmx:nXUPZ6F9ohKk6s0f45R6r1e6zIjcsAk1F116_oXMzpLw1C7XHQlI2Q>
    <xmx:nXUPZ9-_YNsXV3j2708lJ-v3scTG667yGXXkZirFQUHdDqxImdFrNQ>
    <xmx:nXUPZ3mdxQoozMZfIrAUZdbuUNyyrbyL28aBf-ugZeZq4CyyHpIvaA>
    <xmx:nXUPZ2Cih4Ajv2zcw2ZkmFgl1SXTiNFK1kH_NC5Ngukb0gE_m5kvre52>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 04:13:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1d911474 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Oct 2024 08:12:00 +0000 (UTC)
Date: Wed, 16 Oct 2024 10:13:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 09/10] builtin/credential-cache: fix missing parameter for
 stub function
Message-ID: <aaa6b5a175d6dc91d68f76d4606c605ede9c4c88.1729060405.git.ps@pks.im>
References: <cover.1728906490.git.ps@pks.im>
 <cover.1729060405.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729060405.git.ps@pks.im>

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
2.47.0.72.gef8ce8f3d4.dirty

