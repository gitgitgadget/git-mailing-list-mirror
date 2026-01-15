Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5653557EF
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768484336; cv=none; b=GIXGsMhtf9/ZpZ9/y6xF9t63ckL9qU13kWqr8Lud9hTtg4jeLR8lCOP5z++/mpImB82VWKmHnogr4xKUzalonzPfLnnpStNzhHSzmCZDqgS4RYflnIuZ9qbuQzdPY/TztClov0yJ1JlfJnGlkI7IHw0aOU7WTaYc2BPROyR46nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768484336; c=relaxed/simple;
	bh=HReE9AmCBnfMd5uyERtPRGXuaFyztOL+2TilywVy/Ls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UbaLT8IXmkB4VD66ET6G07sBneVFo6S37sS+Vm5Nam1q5E0Jpjg9XA4F00qSphYzye0kp9kee8RA9Z5IJMu+WyRPWANuGJFTvvOYa2RSAKJlr6KBqsa4BBQMPG5EGO+JvstQediHMu9u4aVinqCXLQ9mZSTfNJPzfVM7Mptef0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Utoy92lH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dg6Ta17Q; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Utoy92lH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dg6Ta17Q"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 172EB7A0126;
	Thu, 15 Jan 2026 08:38:54 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 15 Jan 2026 08:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768484333; x=1768570733; bh=a4xARJRttR
	SwFni1X3rn32dS3Nkyjdr5qYoSncmx/mA=; b=Utoy92lHsP6cMudEls3E4AUmnp
	a3LllWkQEiLZ2cIlJWuLKbvAbMmUQXc1VVBLshGXSP89NFKXrUpb52jAemdowls3
	qNCYT2a8DlguSlNMO9ORFrRmrA90hqTc11fBpD5y/so/migWmOdqKP8HJ/ZRiEBo
	1mjlt+7xlOM7xkFo/7VIQ1KjbEmf4FFmNWf1bN+PAX0a0uFbmKJxvu6Irdm8AaUJ
	52TOUKY2JBXBmPq9YijWrPCQOtEXjmwL2OA3wzxbJz0O2/OhG0S8leHSHNy5s6iH
	iE8/cEtBJCZ1X33jk1UWytdbituoU3MltmGlB/24c2fDjiJ6fRrLxsbSpyBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768484333; x=1768570733; bh=a4xARJRttRSwFni1X3rn32dS3Nkyjdr5qYo
	Sncmx/mA=; b=dg6Ta17Qx2pt+eAjl7ujzhwOlMS1E+p8lKVubDEi92FOqIpjPP5
	svegx/uL7y9mfqFKsppFgbMCtyXmYL/7Qb/A90D/OK9bJ9v/dYBYN+HwzqyjhO0/
	UFM9W0vEXA9g/CHnVsXLG+PXKdMY4XVqnTDjaTmzU4nRRIxnaRVSi863uInjNtFi
	CShyhG4G6GfX8HY4eIArTWlJXhwNsOUD1rRROb280K9ii7wXyyJT5xqpprFbQxei
	ULl0TLXM6yrBh7BUgIeZbhK8w6geYVmQ5X8C11VHQ4NAKglKFrrdZb1r4QhdlfDt
	F893iuR1pU3ayRKHgPJu3PKIebCFWov94Aw==
X-ME-Sender: <xms:7e1oaShHXlSNVgtN6Bdr7v9kPXl-kigJA_dikcEQFmedPR_LydHiLw>
    <xme:7e1oaWt9Y-B287vA2VMT1-j3TY70zo-fqfvYy3Ay3EmmhkLzqMApXU4Tx59V8aYnE
    wU6tPKryf2g9PmsGDaOERNmq4IlbmHTfRJxEuPeV_U8gftUsqRFXA>
X-ME-Received: <xmr:7e1oaT7jcZ5CxG9WQAK3sC0yOL-0G-w3cCD5oKlrwHVv2l7LuJY7oClf4fuPlJ1jTn_k80LnWDYhhLCeJv6VDoaxSP8Psgl6TKf2X3E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeivddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhi
    thhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7e1oaSPlvO2y7sUgs1V_HsNE_BOsMh5NcOWsJTZdODkTXZDooE4waQ>
    <xmx:7e1oaRvRBOzzJd3OvEfOuoSsPEvOjOZsZmLHAs8dxtAOKCsBnSS9Lg>
    <xmx:7e1oaVZp_48XfYFINUiY3RCDo48TjKOJy6ryf0Y3B-3Xdd8Rf0RDVw>
    <xmx:7e1oaTyUs4Vrg6tywErXbiPqtwhup8EinaXcUPkWO346qIJQXxYgsA>
    <xmx:7e1oaaRVSo7R7lhF8BSCvJDHWqSM39kgr2k8AC8eizWwD5VPNqHgZR86>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 08:38:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Jeff King <peff@peff.net>,  Harald Nordgren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v25 2/2] status: show comparison with push remote
 tracking branch
In-Reply-To: <0037e6b9-e57d-4cd3-b156-c8cbf439347a@gmail.com> (Phillip Wood's
	message of "Thu, 15 Jan 2026 10:31:41 +0000")
References: <pull.2138.v24.git.git.1768298118.gitgitgadget@gmail.com>
	<pull.2138.v25.git.git.1768306316.gitgitgadget@gmail.com>
	<fa744efc598cd902e9a3a4a17b24134351ca5803.1768306316.git.gitgitgadget@gmail.com>
	<20260113170321.GA265671@coredump.intra.peff.net>
	<0037e6b9-e57d-4cd3-b156-c8cbf439347a@gmail.com>
Date: Thu, 15 Jan 2026 05:38:52 -0800
Message-ID: <xmqq5x93dmhf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> So as well as configuring whether we show the comparison the push branch 
> it would be nice to be able to configure a simpler output as well. That 
> does not need to be part of this series but perhaps we should design the 
> configuration to be extendable.

So, there are orthogonal axes that might benefit from
configurabiliity.

What other branch to compare (e.g., @{upstream}, @{push}, something
else?) and how detailed comparison we want (e.g., only tell me when
we are ahead with just a single bit, give me ahead/behind count,
only tell me when we are behind with just a single bit, etc.).

There may be other interesting axes people may be able to come up
with in the future.  We do not have to be exhaustive on values on
all axes on the first day, but it would be nice to have a fairly
complete coverage of what axes matter to users, and it is a great
suggestion that the level of details can be one.  Thanks.
