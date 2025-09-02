Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022BF32ED2D
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831152; cv=none; b=eP+/Wa00gLFAGqZK5I8++ZSo0AW2QSce59srb+SHqJcXD4zSmvb8ZFOwJXuxcsSKW2yAr0VKlgNfAcfG92SFWJ4oHVRtkc8Fcy/bgvbcCSUfq/zwR4u9vDu0Ot39ispkqrzLCUjrqLulfM6tZLLiEBQP7o46o9clUuKdwF1zsJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831152; c=relaxed/simple;
	bh=AWCTxMy0Pmsg7n1O1AYc6gNNUWkkDjA+6ZKWsexTeRM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eBr1XvKcDN19MLTdaDfQXBl8Y0dnQdM3t7p5pMw3z+0mLcuIPkv5US5WbCQPN9webju5lONZ+/uT5B3cTqTCgw+w9803W4yhbkBjt6SsdBAWVAHXilTCduYX1eZyOcB37cTeoEGkmfMaKgeMOU99c+pIiLyauGnpmm9u6nXzjAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ml1.net; spf=pass smtp.mailfrom=ml1.net; dkim=pass (2048-bit key) header.d=ml1.net header.i=@ml1.net header.b=bP87pvvM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JZPQdM+W; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ml1.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ml1.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ml1.net header.i=@ml1.net header.b="bP87pvvM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JZPQdM+W"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 02D5E1400223;
	Tue,  2 Sep 2025 12:39:09 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-02.internal (MEProxy); Tue, 02 Sep 2025 12:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ml1.net; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756831148;
	 x=1756917548; bh=AWCTxMy0Pmsg7n1O1AYc6gNNUWkkDjA+6ZKWsexTeRM=; b=
	bP87pvvMeGYySrYxchhBXaywyELCuN5nus9ep/t9pblm7zzGFNBslNZW+3upOOak
	FYyB4HFiJwskngaezWPYf/kcp5x3iTHur0RctKRoxJhoyAzetMH5uwuJfGtGUQfR
	f8LoS5qaMScK8PvCFsKq32HnW67ZE41+ZAf1NfbxRA1uMV4JmrEgL2H4rkqpV2ZG
	7vhCPjRpECCbUJ0ZbollIcE66AmEBlmF6G2wrvVMxlY1iIIwV/Hue50GAdyBVhei
	a2od2C8amuuLOerWLlLniv8FDD5UdPc/cIMfviNIujFBemc35h84tlDSz82tF6pZ
	3Qt9IwFCyBUjVbbddFR2Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756831148; x=
	1756917548; bh=AWCTxMy0Pmsg7n1O1AYc6gNNUWkkDjA+6ZKWsexTeRM=; b=J
	ZPQdM+WE8iDWoD/u3839d3+k5Q76e8MtMO13RtzPeqIoW4qfeZDdA2MP+p5S1mhf
	z2RDUVZ7Zvz9rhWOlYb5B0hYvIPXXkaJ+WyQ0e5clXnDpw/YxAd0fux7EFjFPZQh
	pCdSgsjVqBG9OFKTG+cPHMtUkp3aNz+CtIhSrI7dCO73U7VDHHnwMq1bR3DPuVmi
	ht5nCLTQ4kzQsudvkxH5+c+tUtaJdugjRiYw+Mm+rsLVJxO5x4ACoYgLQEahYVvy
	q2uV2hFiR7/oazGyC+vUKJTjg4NmresKLJUWPPY0i6NtM+K7DayuocXkASkVYahk
	N1vP+QDPVSTjLchjBb3fQ==
X-ME-Sender: <xms:rB23aMZNdFS_snLlNO7BaMkFHyDOiY-CfhWkmB-eX7uEWCUqWOTqiQ>
    <xme:rB23aHYd4yHDPMOQ2J5byK5zskbXYZiSUytNpdy4tiLZ28HZ_0tBSaTIwxSMl1igg
    TC7bY0Qzrus-CJ9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecunecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertd
    dtnecuhfhrohhmpehjohhrghesmhhluddrnhgvthenucggtffrrghtthgvrhhnpefhtdei
    ffetkeduvdffleffudelkeetgefffeeujeetveeiveelfedttedtvdfgieenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjohhrghesmhhluddr
    nhgvthdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rB23aIewSIM5TIDkvTk9N2dTHZlxw5EHufKtMOy0vDAyBYqQLEsT6g>
    <xmx:rB23aDLxxuzkPUCTetNMRhgEXwxNmayvf7dGW7aQVPIZexUAfAZMxw>
    <xmx:rB23aLeJF-Gu887Q3iL7uXyCG8Se-jYZ7_xh35yBUtoThAXZf9Z3mw>
    <xmx:rB23aK2_CH-7yc_20O57X5W5Ol_cOtPHE4RY8AAJgMf8FTK59AZVfA>
    <xmx:rB23aBu0LmmQdwCMmL-8XjCGqpeJy0X5MvZfi2tNaS2yDe-Aput_4OXP>
Feedback-ID: i470841e3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BFBD82CC0083; Tue,  2 Sep 2025 12:39:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AaL8HUsuz1kN
Date: Tue, 02 Sep 2025 19:38:31 +0300
From: jorg@ml1.net
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <6597b201-8087-462e-adc0-0ddaa8a7402e@app.fastmail.com>
In-Reply-To: <xmqqcy88lsw3.fsf@gitster.g>
References: <74c5f07d-6376-4787-a5e2-bb09abc58ce1@app.fastmail.com>
 <xmqqcy88lsw3.fsf@gitster.g>
Subject: Re: Still using "git whatchanged"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 2, 2025, at 19:29, Junio C Hamano wrote:
> jorg@ml1.net writes:
>
>> apart from what's stated in the subject, I think it's not logical
>> to use "--raw" when I want to see what has changed.
>>
>> "git log" shows me the log. What's the raw part about wanting to
>> see what's changed?
>
> But that is what "git whatchanged" gives, so when one is so attached to
> what "git whatchanged" does, "--raw" is what we cite as "compatible"
> option.

My point was merely that IMO "raw" is not the best name for that option. When I specify "--raw" on the command line, I usually expect the program to output similar data than without that option, but of a less refined state or kind.

In this case "--raw" means "do the same thing as without --raw (i.e. git log), but _in_addition_ tell me which files changed". That's why I think it's not the best name for that option.

I'm not sure if this is the right forum for this discussion, but if I were asked, I'd vote to rename "--raw" to "--whatchanged" and be... almost happy with removing "git whatchanged" (insert tear-smiley here).
