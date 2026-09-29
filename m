Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E463AC0ED
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 07:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668030; cv=none; b=Y5TMdQK7oAgBuREognByf1eFIBjp2UYpSOzAXzfE4OTNGFLBGuTy1EvfYrN5odepPefWHhdrmRpV9sazJYDOfidCTImiF//hfFZCcAFo/k2S/r3MPy36PCkscx3UyioNiBQobdgEAMeaElPbcolPg7EGMXrLq7WpRm6Ncpj6c08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668030; c=relaxed/simple;
	bh=wgE2HFP8N4KGIVJR5SRlwS8bTO6nuDRShX1m6luQDrE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Rpo4gz9ruXYOEt73VwHQb8MxfZX/aExyckOSLJu0NcgDHFti9yFjWFspG2pDgon4A5ytOhnZra9Jsg5UUdCE4WlVuBL0qyJWfQxM/7bJAKUgnNc3AmWQ1wpqh5UJXd23eIEI2b/gkGW6folpE5jgGkvEpi+EeUku5RgcmB3R0SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Zog5nDu8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r01XQzfg; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Zog5nDu8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r01XQzfg"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BF7C37A0082;
	Tue, 29 Sep 2026 03:47:07 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 29 Sep 2026 03:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790668027;
	 x=1790754427; bh=97kGE84TzEdTKqE9QaFsHE4OdfdQS5yF1bvX+YGwIEo=; b=
	Zog5nDu8W/udkjtxYty4/ApjztLik0GTfp//gg2HsxOp8ITWCJ3JBp9DIkiklUSH
	YSUFWDJ6P2tOKc55IGh54ANAnnMNrN/Uet9JZZsdvxR3dkdETgyD9ZoPuOxpnyLr
	G0Zl388q5RsjlOD5gnY+SpY3S/+qxJvZNLNBSSrPllDgEvW7p5kOKxTiY3cQHJqj
	3+csC6u8PD9Djs8Qyq5Gwe9K968UPpyIpaccLse//L6AbUg7o/AIVrRt1muBd4B9
	kmYFTOKROkMnK9PISsuwLEBgNHpLjLGD4mD82yGfk12E4FoOTX5BiPCiHe5JA3nf
	HAN7/rHlNuWcePjZL4Wvdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790668027; x=
	1790754427; bh=97kGE84TzEdTKqE9QaFsHE4OdfdQS5yF1bvX+YGwIEo=; b=r
	01XQzfgILHwFhRai7ZAGCN/KxtlgLTJ5OOuq2ergk3QanA9+OeImFn/dkYbtxqJp
	2f5cfSx6LV5IG7lvkRtk8E0bPa5QLTnT6zOMuHe5SelV+TJ/EzudgvaDtUEZ5JmN
	fIMzYgP5iWj9uIEtr3/tNTl6RnZVaz9qve0XpnwD2NVHOfSFmfJr8NLHYdUYuy3/
	AgJ5XV1PC/Vrl/V/l+CfG0VcKscE5CXA7kAZqnUYN+EdaRvmU4l3Cwc8vI6SePi/
	s8/4LfTaq8wSzoBmm5IaLstHFTsQpaiACeu9W3qPS77+zYOUloZc7jKYTrqlHQyG
	9P2Sly6TC55qEnQEYWjXA==
X-ME-Sender: <xms:-my7ai6IwoRPpumDDTLIQNCxn97dNlFyo7emSarg8uvSO8JSk5eRToI>
    <xme:-my7amsjJJdiqtqAXB9PmuwunqZ7X2ixr5T42kDh0rC4ywGQrx6oBiDzQdQLrMMb6
    S3jKx0Z6X9Fkz8RqNt8OSmt-_SNK4N1ZnSqodZcfByqBm_IC3pG4eo>
X-ME-Proxy-Cause: dmFkZTEefSNmDRYqi5ZA87QZuQ9ySMreWrRcB1um9HgII2tlCOWtt7RfV8zJwKEaI9e0wt
    59m2a/QwkYy4aYTL+E9isyPrtxt+q6upgqREIAz6gp36rhIpYvaTHBAyufDKegLD2NWm/U
    5SBhgShj4VOHRe1vGGpv8YBM/GfxMuFNX+AP5fIgOR9mHe1BuhzSGnpsFa+HiG7ZLR1Qxk
    ACDpoqlixT+wRmF+FqQBW5eOJRL7/W+ck7ObVRsqJivRT0KMUztvxmvDIgKQ8Cg36w80T9
    4sVYM9f87VX/Xu00eBQHR0frgqKfKeh9qoPYERNhS1GbynRhuS5gWekZ+barXsj0SOK0kl
    QttWKb/+dtxFeihMoY2A6KGJTcmrCncaaZ6eQGfw9NT7P4C+kSz+tiLLITunFwtvA0viGM
    J96H3jsv9gMWxc88XM1aVX7Zq9ILoOyJKWpR1jndhvdW/CmGbbRq3tdebybiJ+0Jh4FTD4
    11s4oDr/m3mMKNBXR3JBCLEve+J9EJsxlwFEm8JkPKkjrBQjSgw+kwQJ+pZARL9FbcDE7O
    rKOzf9sB5kMWAX2OOfzy2o6sMCE3ZpnkanQLQVdATMiWXju/58lduRsUACfFDG7aJYt9xE
    rhXSUDEIgrrEbYJi5GNJ//F4pxrfWN/q03+T9He/YAM9C/OSW5glGd2EP5yA
X-ME-Proxy: <xmx:-my7apUPMvZ6XQmiBiK-QOTWUyCdvOu5BV54YhQWHUrevcdHshFQxA>
    <xmx:-my7ahUEd0lErqHH1RIb_WtBvA98SGAqMtt-B_x7N8aXJnnMQI2XCQ>
    <xmx:-my7aocWFZlZWFR9Wh6uE9Wk5bIrLgqYF0Sbsc6Aj8fSnRDOb3POew>
    <xmx:-my7aqViPQEO_arML-v64QBaFvtkXfkzMtAevNTxI6uyYz2zd-wYlA>
    <xmx:-2y7at09PM-5UAMTkA1hSczSm9r7mTtjTOiYkjpyJGoaiPGqpBcjBMB0>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 10ED622C008B; Tue, 29 Sep 2026 03:47:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ACf_4gHdHLcR
Date: Tue, 29 Sep 2026 09:46:45 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org, GITGITGADGET <gitgitgadget@gmail.com>
Cc: "Harald Nordgren" <haraldnordgren@gmail.com>
Message-Id: <9a6bfc3c-8759-4fbe-9e90-5dec9d00e278@app.fastmail.com>
In-Reply-To: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
Subject: Re: [PATCH] branch: let --delete-merged find squash merged branches
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026, at 09:30, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Branches merged on GitHub with "Squash and merge" or "Rebase and
> merge" are never deleted by "git branch --delete-merged". The upstream
> holds a rewritten copy of their work, so their tips are not reachable
> from it and they look unmerged forever.

An example closer to git(1)=E2=80=99s home:

    git merge --squash
    git commit

>[snip]
