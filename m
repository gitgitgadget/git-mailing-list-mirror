Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC291EF0AB
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992740; cv=none; b=nibnl9wSeQyMs0r1r1h5iBjFr1tRZ8lLX182ixgfFVl5WoF+IU+jAIuoq5ErtyX6IZQwzNlkoIdScpV//tlm93IQ4P3Dlaj0fAOzvsstEIYepVn8wZNkWFzuX2OfIjtKGYq36ipD9suay0hnNl1LPzgBHW13d6BRclSFEaHocks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992740; c=relaxed/simple;
	bh=WGsUMN/OhbdSxQHTpJKsXhGTNq4EYp55mRJedIl61jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrwaJUlPmQ3gZ2kae7zht8AS48Srf/1vyLO0tR7ezg27n+UZOINcYwGdgc3Gzvbpriqbqt+sZ95d1buBiy29B+TuSM+/TsI0gt/vhvxlfq7Obdi15FyguH6p7hOfbLQhtwCphmP8CidorVK2EMtO7kO+8gQ56EEo1CWsn1lffVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YRRcCIai; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ko3IAm9J; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YRRcCIai";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ko3IAm9J"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 79C7B25400C0;
	Tue, 15 Oct 2024 07:45:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 15 Oct 2024 07:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728992737; x=1729079137; bh=Ippqaah5zo
	lH/JiAY87V5UgrQLa0e7sxtGw+W68iWCc=; b=YRRcCIaiszwqYEvA/eVe7h+nOT
	hxCeuRVgNWOzyiSCPQHj1Q3wJxhpmUmTK3d/7uYLyed9sbugiwBKf6dqnSkTFko2
	aC8UL++DUoYl6CKz6eAY6L+4p7qkRfs3nKa3G46NkRhsvEtL7tsej6p1n9fArI7d
	a7osFz49VO2AlozKn268poXRIYl7eBzeTYdiCFly99GodKk4kAryPlAc03f6qkag
	zNZLN7gWElTTnCFfFS3Oa+/PWvN/x7wp1zCiSbR+zx2Ks5oRCIdiTk3iluRWMCrH
	IQBme0O+ribKIZY2cQ5mQ/EoFC2gX5u/DUeOD17dEg2pmdaS93EDj4F6Yg2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728992737; x=1729079137; bh=Ippqaah5zolH/JiAY87V5UgrQLa0
	e7sxtGw+W68iWCc=; b=ko3IAm9JyYJmbQGLmC7pCpLdnH86QOBTuts4D1KOY8i/
	ZeVoeCdcyfCpeFHzCegxO9S3tcpWgcERJawPeZvqi2m1HZbmudwBqJYtdEP1i5+b
	E271W8+sIp5OXHmbc6d/yUOa841CP1HWWOIizRzIlQpYVaq5FugzySid/7bvocZM
	c12O/rMKCGYdFOuAzcuiv6Md0c+KDNW459bD7rEwDHtUCGF50wGBE24YPPtMkVo9
	CA6hoWJMnZVoVC1eKwEjDcMyMd22VvwjHfg/MIqRThi4b+ffL1h0bGyo1PEfX0p2
	HCtsMl1Sz0g5SwOdnL5Dyo6TRnyr+TMyRcJO+vCHhw==
X-ME-Sender: <xms:4VUOZ_0bQuiP6KSgahjceLY62_IrmtPZ4J8QQ6JF3SuAnBcQjRk-QQ>
    <xme:4VUOZ-FUfcT7lv1noIW5zcvprfJVbdCb8EToN3qRe67DoznsXfZvHArBufGpxMh85
    9IWWWH-CEGOreegLw>
X-ME-Received: <xmr:4VUOZ_6ha5jOQkoFRE6jgAdDJtizQxufmsrGQlaXmeeIxzPRebS976kJtCaJEG7yBLy5a8mTlx89nTRqNes1wqDZiBGCCwHZ8MZD0TzuWfTrGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:4VUOZ02ZaXgCHfmBj-RHqNLVh4eiX9S_yrjoAM7z7riv-p69UCwaDA>
    <xmx:4VUOZyE48XlZQQM51MD68loQCvlYRZmPkRndhjXohgtTZIucwkIOSQ>
    <xmx:4VUOZ18odYHF4_sy0AeyWGkBsVB6B2vh1G4HSiNPzqPnbvbCrS-JXw>
    <xmx:4VUOZ_kbWW0gZ8CAol1ZnjyfpLuYwA4sHDuuIKDWDHWHW01xCbcxvQ>
    <xmx:4VUOZ-CakDC6sClXClyUuudOjLHYdvsEb6ZB6lZldaFkgVcdnA-eMU3y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 07:45:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6be42d28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Oct 2024 11:44:21 +0000 (UTC)
Date: Tue, 15 Oct 2024 13:45:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 09/10] builtin/credential-cache: fix missing parameter for
 stub function
Message-ID: <5fd78b6d535e8b151e6ff47716b83a97d8e03008.1728992306.git.ps@pks.im>
References: <cover.1728906490.git.ps@pks.im>
 <cover.1728992306.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728992306.git.ps@pks.im>

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

