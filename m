Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1AF38657B
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575402; cv=none; b=MG/Fs2fqqjIupAJuyduUnWB8Oyt23imts8R7vKBSd/3Ji/9D6y1toaJT3WWDl/iwowR1kkVMmLPfX7P1XZo43YRXhH1sYrKRfFEu09KzlzALg4yP2NodyYkx1elFpesLp7WDYqugcshNBA024xDreuRvNdg0KiBfTbzFwRjdtgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575402; c=relaxed/simple;
	bh=SRhMWXU/uohFi4Bd1U4Gax5mvfRWfPURNphn+I7SSPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YlGlNfNNNS1UY1EqUOWWiGLhnW7YewfsbP+7aiasrTH6fQ1vI3IV8RQdyEbC9+wPM45CWAod+24ZGk1SwCk8SpVm2FMz5h4zuFWt73SaYgTaSuQhCj6rMRCftk36iBjtX4ZJ4aYIS3/i2UUKhLHg/6g0540axJTyFyoAb1dnfrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ttv95rsX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UBuMLmER; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ttv95rsX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UBuMLmER"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 85962EC0415;
	Tue,  7 Apr 2026 11:23:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 07 Apr 2026 11:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775575398;
	 x=1775661798; bh=UOYANnQkTebVwmiPo2KQuBQau/sxkmxJXtWP8F09yFI=; b=
	ttv95rsXBqFfO08zMOspo2vohSGBnZhdUCMuFeNDe2rxl5YcHkoW/DoEFITJRG5t
	D0mv7GJSXhXTYzEYc44wc3DWKBV9G4cgdVxwxXtEGs48fGxIN/yfxOishfae2hyG
	3bjhv9i8tbKwBaTpzer2vb1FzK+dNKM5QlbskToeKR6GmIm/sqgxBA0QwC8UR8MR
	fLDHES48RUxuH4EujE8xgw8m/63L3FBwHkf9TjnPBuF0SXuKtKz8bRAyRP0JYkdP
	AeTplge/7WCP96JtMa0xK1uN2Ur93CRay1VqiUTnE+AxeiCOH4pyhQzPipS9ITKL
	yznlExnwE2n0VaVZ8HBevw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775575398; x=
	1775661798; bh=UOYANnQkTebVwmiPo2KQuBQau/sxkmxJXtWP8F09yFI=; b=U
	BuMLmERsBLNm66mzVQ4U7DYQwSItlLpuSjxxgRMjyzGGLXu/1QY6kFcHqonLqwLb
	SvI0jHojL/hLjj5GRmzsUA5Eme1BnsPyBUgIOsjhBBtdLSnWTyEjtZSgroDxWBfW
	OWJ+2X49QnMjfb7Xkajbh4v/lVM+KFSDSrbcWjdka1LOu9aA9iKJrhi1M9zAijOA
	nCHFQTFWNfiuwZ+K3ksSR+VaerVgix3KGv/GU/hDqW5PYpawghX/1JD8eJGIydAq
	0D76Ht0nCWY3HlaWgKO2JC1ap2XRyt92gJHK+7V5MeIidcLciAdjSE4QQL9WTYLj
	1ztXJNhWlmauExskPxsMg==
X-ME-Sender: <xms:ZiHVaadN3RqAy7cgm-C48RgImJpdEfg0agKH2BRh1tF6SHZaYPwizg>
    <xme:ZiHVabPaIA8k_A65mOIf0nDAyB63kJzb55e_u7EhN-NqP6Vd8ztc5I3dEHGfC3fDT
    fSMVKnFtGr4fG136h1yYPIYzMweUodY5Vrc8Jx8YVnmmNBJJ26afQ>
X-ME-Received: <xmr:ZiHVaQj-Zzp_86aVMZywTfEyt6c8Ss_qxarBOiFQcC8naOtf95CEgcyoUkZG9zBqzct6BTEmoqRtLRTWbJIj62Dn8lYALcX4gA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvtdellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgvshhkohesshgthhifrghriigvrhhsrdguvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thdrvhhgvghrrdhkvghrnhgvlhdrohhrghesshgthhifrghriigvrhhsrdguvgdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ZiHVaW1nAkV-S8gN34E3hzIhT9gh9J4plKREpftuNAd8Ak9ADchvXQ>
    <xmx:ZiHVaSgtrxYYd6r8dNClS5JR451ZMe1RPLCwFmdhYcGfUG3HxpMq7g>
    <xmx:ZiHVaed3nqpYBTdd7bBi8iDVn9qVgWguWPRtJz0G7iNAFAqpq_PiIQ>
    <xmx:ZiHVadmqEWgveM4-mbQzjmfRi9nH1uid_m2kMTbVwvaxFnKtzMWM0Q>
    <xmx:ZiHVadet2Cxt1430G3TYRS_9TqCbgTEgxaZdN6yDoWXdVIxYx2Up5Ym8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 11:23:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jesko Schwarzer <jesko@schwarzers.de>
Cc: git@vger.kernel.org,  git.vger.kernel.org@schwarzers.de
Subject: Re: checkout: clarify "up to date with origin/" uses local
 remote-tracking ref
In-Reply-To: <956b1bec-99ec-4d28-8229-804eb14e6d3a@schwarzers.de> (Jesko
	Schwarzer's message of "Tue, 7 Apr 2026 15:10:25 +0200")
References: <956b1bec-99ec-4d28-8229-804eb14e6d3a@schwarzers.de>
Date: Tue, 07 Apr 2026 08:23:16 -0700
Message-ID: <xmqq4ilm7q1n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jesko Schwarzer <jesko@schwarzers.de> writes:

> Would the project consider one of the following?
>      1. *Clearer messaging*, e.g. indicating that the comparison is 
> against the last-known origin/<branch> (or similar wording that does not 
> imply a live remote check).

Surely.  Patches to start discussions are very much welcome.

>      2. *Optional context* when available (e.g. from reflog or last 
> fetch time), so users know how stale the origin/* ref might be — if that 
> is technically and policy-wise acceptable.

I am imagining that #1 above would add something that conveys
"relative to the last known state", and this will extend/replace the
phrase you would choose for "the last known state" with "as of N
days ago" or something when necessary pieces of information is
available, right?  That sounds entirely feasible.

> I understand Git deliberately avoids implicit network access on 
> checkout; the issue is only that the status text does not make the 
> "local remote-tracking ref" semantics obvious to everyone.
