Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBF826D4DA
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 06:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758177743; cv=none; b=IQFqIeR0PJL4oIEeHDHFrLwCZfPC2cD3bXX97XehhWZ9bYVLa73qLODldH8uL9dUuLGo2Kw69tWX1XtowlyziEGhiGutjJBJhpBV1nsMhA5YkrQBwclshbthRpEGX8n8auSPezfCKe75hMt9Jdl7k9SOJrs2eUALO5CTzd0yHss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758177743; c=relaxed/simple;
	bh=JUQc65t+VrDeBnZhSpmUy65dHAr/EldHOFdM/7jZFEw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jgGmzlPCKNYW64n4Z7gMdNLlQD5ypiqoWLmNNiedXnk96A83eyr0aWaqLAJzqPtwHUT+qvFKsLFhmQM4VY/gfPVn6ZTbjeAZrtsuX+lc4ipG2Tt/Bz6BsKBEutLhJlsRyRul1+sAEHhOjWBXhvRPKO+to/ZY4NibEpcye3TP/v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hurrell.net; spf=pass smtp.mailfrom=hurrell.net; dkim=pass (2048-bit key) header.d=hurrell.net header.i=@hurrell.net header.b=M2DNIjAI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dd0T/epc; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hurrell.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hurrell.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hurrell.net header.i=@hurrell.net header.b="M2DNIjAI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dd0T/epc"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E888614001C0;
	Thu, 18 Sep 2025 02:42:19 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-08.internal (MEProxy); Thu, 18 Sep 2025 02:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1758177739;
	 x=1758264139; bh=tY+hz2aufr/NNRXptlsmmmY44lczMtBaNDZYCTBjPdY=; b=
	M2DNIjAIsl8cbv1JKJaYivVr3Yg1Gv3Cn1mfPiP5xCGz7FV0TIX+ebQ+1iMDfebs
	mp23d6PyBMZdFGGEYeWcUyGZMetPcjBY9hDB8ccyxVKcm9owh/21ZEMv0e8FbyP0
	f7d40YxgVvuuNr0a+huwMSPgB5uKP2s1Y+jwsci3Wm9YqraK2W/LJnnoCCtBNcSz
	lvLbH8GYoskQHwOIyhqXJNCrnb0cfhdMDqbkON3/pvSb4jyh1aPb0QD7KbbUedtQ
	3SG9+RWif4ZSuW298NsJ/aKUd6PzcEDdLj22M8B5w206aie7gmp46Jfe3EPPvCye
	gc89/OkWKKnpw+bCK8Larw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758177739; x=
	1758264139; bh=tY+hz2aufr/NNRXptlsmmmY44lczMtBaNDZYCTBjPdY=; b=d
	d0T/epcbRaq9K1/sDb+u4/hstP9UWs2yxnj2Z8rLWUwmr2jDTnBeuxo1CZZvCdLD
	ecm6tY02TtTeGuxUpSDLQlQRsISNk18tAAEHtGmyAvygkEm/WIpMzZP2dOL4dUIA
	KEMSOySTsBHlmn8w9B035u2eY2DqCMT3G8L3kwWvHp+jnkca5LnxAW/9CA/kTB50
	LXolo48aukNtl6/b/2hSPJKxJJfuLlUV807I6m2aZamfbgHOJpou1NcTVck/dKw/
	88iv7NScoagZt2wKrblrgW0XdTeL0pdCeKlI5a6QZs/z1aYom2zuZxy/J13OXurx
	w8NTpQu0ljjLVNFx2WavA==
X-ME-Sender: <xms:y6nLaAeIr6WDtGjjayIhq9Ma5Ed4YqSqUjYHX0D3MKq_lcV2zYXC2A>
    <xme:y6nLaCNRXQCqumR0m-yNIwvMwaZ5gFykmeEqvCHbcbC5VWPUXld-BM9mBK-Dtojy3
    YeVdXGKfNcOEefOJp4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfirhgvghcu
    jfhurhhrvghllhdfuceoghhrvghgsehhuhhrrhgvlhhlrdhnvghtqeenucggtffrrghtth
    gvrhhnpeejleeuudejfeduleduffeugeelieetudefueehuedtgfeguedukedtjeevledt
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrh
    gvgheshhhurhhrvghllhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhrvghgrdhhuhhrrhgvlhhlsegurghtrgguohhghhhqrd
    gtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:y6nLaD8kyZWWCRi_e-e-KEBee33_OZuk1Q5PSotHyLBkd6gk7WEFYA>
    <xmx:y6nLaM3FXr4GydfzvJWumnFk4aMp_VR-LGdzoXVQ1LpYYO7V9oqWlQ>
    <xmx:y6nLaADACFdJDHvdnqfz-GecwGTP_hUMcb-OGQF8HIhxJQBP5JMBig>
    <xmx:y6nLaAcIc0G_SD30MysWGA7uloB1WqPKe2mld-dWCxXO_7pXrNWZ5g>
    <xmx:y6nLaAbdbC7b4Va3puH6sMZuU6eAwbNG4zxe6x0ahh0fKntIUZlBK6xJ>
Feedback-ID: i12114735:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9BC6EB6006E; Thu, 18 Sep 2025 02:42:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvTNPFUzFlNc
Date: Thu, 18 Sep 2025 08:41:22 +0200
From: "Greg Hurrell" <greg@hurrell.net>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc: "Greg Hurrell via GitGitGadget" <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 "Gregory Luke Hurrell Stewart" <greg.hurrell@datadoghq.com>
Message-Id: <72340d21-0755-4b1b-bf73-5f820266998e@app.fastmail.com>
In-Reply-To: <xmqqtt10adzk.fsf@gitster.g>
References: <pull.1966.git.1756816258606.gitgitgadget@gmail.com>
 <xmqqldmubtnu.fsf@gitster.g> <4d47677c-787e-59ca-84f8-5ebf59947b0c@gmx.de>
 <xmqqtt10adzk.fsf@gitster.g>
Subject: Re: [PATCH] mailmap: consolidate multiple addresses into one
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Sep 18, 2025, at 12:52 AM, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I can vouch for Greg, having worked with him during our mutual time at
> > GitHub that I greatly enjoyed, and can say with conviction that his GitHub
> > handle @wincent corresponds to the name Wincent Colaiuta.
> 
> ...
> 
> Thanks.  It is nice to be supported by a positive confirmation, not
> just absense of objection ;-)

Thank you both!

Cheers,
Greg
