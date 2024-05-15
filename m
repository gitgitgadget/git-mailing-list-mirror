Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16896156227
	for <git@vger.kernel.org>; Wed, 15 May 2024 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715788422; cv=none; b=iQsN0qjWWdp+kxFWsn8bLM7DhTm+/HKkD6DK7kkR3IHb44iNvk7vQsFc4guttpqxAIZOqCz6twjogO7m45rU4FrvkTXDLXw04C0wD0p4BJ2eF87AxMa9JkiVryj/9vr8w2GkONlFqWjCgesLsLyN06j5Fe/nM4faU77xMtUv7q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715788422; c=relaxed/simple;
	bh=jk2pSun0MDm7gGav2I9k+72FrcYVCbR6DASxMgLlo28=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=esjL+JZBQo9jebGv1w9aQLHEAqPjn7O4gJ/9ozq/JEgA1sTgJTQZrPzV+TYGgtBK0zolrQu6rz4xg74RVhOnGOxfzqb+T3HGT/etVbcxKetfTlT+gVMmwHywj4KF4Gi6OzP8vcGlJhntVM0WVyHd37+EH+qN0i1od3sndW7E8kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io; spf=pass smtp.mailfrom=alchemists.io; dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b=Jq9vyssf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lJpAl5KR; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alchemists.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b="Jq9vyssf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lJpAl5KR"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 347711C000DA
	for <git@vger.kernel.org>; Wed, 15 May 2024 11:53:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 15 May 2024 11:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alchemists.io;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1715788417; x=1715874817; bh=jk
	2pSun0MDm7gGav2I9k+72FrcYVCbR6DASxMgLlo28=; b=Jq9vyssfb/RrEUQF7s
	kOToYp2nuVSAdEfHiJsaC4gb4cQSQJyNILR04wJ2JyHgKig6S2jm+akCiJV34kya
	efGH98ivy/ScDugPvTNeDknmRLRz6icwKp4MhC3W9NvU3tZWjt/4yLfCJ49jsOtJ
	t9SCYrtyQ2ndMDlHrPnMbRgeNGp0fAhjSC+8zEoScebd+F/XH3x/YWTr7cfIbO3L
	c6Bmw+Edh56w6nyrslbvjF96ZEWylcQk3rLTMQKYySXq7ZBgfnC5I3Bim39PhogM
	hj2YqzrIZiQ9rpX2t/+k80et4pXMB8rF0b0eZIP875hXPpw8soF7oSXz51CJssKD
	kxBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715788417; x=1715874817; bh=jk2pSun0MDm7gGav2I9k+72FrcYV
	CbR6DASxMgLlo28=; b=lJpAl5KRmPt0B7scXciUxEhlh/lfoYKXeAtBCFHeIzA6
	Oz0ZWeyGS7yHbnNv2NrPTcBeZv3AGlONjn2io4DJntcMGJCBHX3oANHo7q7M+8xP
	ja6eEoqK6RLItGCOXxtDD57jDhZ73zMSBtDocPAGhC/INTJOp+oh4YgcKqC5D+xD
	O9ZbrZiUQoy5Ma+iGTIP29zlnUfr8xpfzBXxI43foIm1D7lu39wrjT1HvQMJNazI
	Z6AucIBajq4bZ1lOBOhbPS5Lg25/EttsFk2op188NIr4tnmVdcCeQhF6NAZC3MHA
	Yq7Mxvjj3WY5cijgT8SVsGmUmoifF2MSuRaWE/Fucg==
X-ME-Sender: <xms:gdpEZpzbqxfY1n7l9vMiDfD6wGA5C3uyLaSopeTUBcpKd3uSKYOyBw>
    <xme:gdpEZpTFQH-EM7961AA4bxGclBr-tA1RzHk2ghAqqO3qCeqF0HAjjyLDLFEJv_rEc
    ImZBjGN0n24VNLY>
X-ME-Received: <xmr:gdpEZjVw59PcZpisP14qAmGPbF8HsQvg486C1vZO6yBK-Ib0yBOfzRgQhWj7aJe9-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegkedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhtgfgggfukfffvffosehtqhhmtd
    hhtdejnecuhfhrohhmpeeurhhoohhkvgcumfhuhhhlmhgrnhhnuceosghrohhokhgvsegr
    lhgthhgvmhhishhtshdrihhoqeenucggtffrrghtthgvrhhnpeehteffkefgtdevieeuve
    dthfevfeeiffegudejteefgeekvdfggfetgfdtgefgvdenucffohhmrghinhepghhithhh
    uhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepsghrohhokhgvsegrlhgthhgvmhhishhtshdrihho
X-ME-Proxy: <xmx:gdpEZrjQGdRARCCMDnuYvVX73-hV30T8bFlOe9MEd75fJrGdcpgKXg>
    <xmx:gdpEZrDyZrZIpVttk0mTtiYITRHvxVr6-Mp8gqAdMyLhcFUx7Qyr9Q>
    <xmx:gdpEZkIRBgNDkG8eOWHabOVpucA4L8wXkmcTBGWA-nY9DO_T1u7TMA>
    <xmx:gdpEZqA2jFS6AnpF8Cu8lEum2GqgZti1RsEF-7HSs8ZZlYoj55ACNw>
    <xmx:gdpEZg475e3pgp1clyJW4nWZykuBJkBtUOVCAidkOnYlJeOH48UsOb61>
Feedback-ID: i78e840cc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 15 May 2024 11:53:37 -0400 (EDT)
From: Brooke Kuhlmann <brooke@alchemists.io>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Git 2.45.1 - What is the right way to clone with global hooks
 disabled?
Message-Id: <FAFA34CB-9732-4A0A-87FB-BDB272E6AEE8@alchemists.io>
Date: Wed, 15 May 2024 09:53:26 -0600
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3774.600.62)

Hello. =F0=9F=91=8B

With the release of Git 2.45.1, I can no longer do this when cloning =
trusted repositories (my own) for build and deployment purposes:

git clone --config core.hooksPath=3D/dev/null =
https://github.com/bkuhlmann/infusible

I have automation in place where I want my global Git Hooks to be =
ignored when cloning like this. The solution is to do this:

GIT_CLONE_PROTECTION_ACTIVE=3Dfalse git clone --config =
core.hooksPath=3D/dev/null https://github.com/bkuhlmann/infusible

...but is there a better, more secure, way to clone a repository while =
ignoring any global Git Hooks from firing without a lot of effort?

Thanks.=
