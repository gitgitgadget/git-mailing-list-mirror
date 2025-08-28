Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6FD270EDF
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756405497; cv=none; b=tvEg3CvcBQWfCZXiuEbxq2QlhthhIEEO/NSH7U5Yv0AQLCflE1SxfKW9C4KrrZrstDuAauDJwQf1SjgJ3ORZXBI4z+9yAmOFznqzlzn4ZeZ8ZHkjPH8pyFJ9+8nS1NKG4sHshW8TqWBmCwRSxh6OBB9Ls3/ZwXh9szQp8s3ofgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756405497; c=relaxed/simple;
	bh=eu2xrgfb3lxhWyXTNIdJeH4Ayo6/ragwV/5TOIImXMs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eq/mODd5wo/pthE2QIHqNvX1Jq4PVpdrOl1bqVP8MOkJ8NZcwXwRWRvL2brg5kEmUEJsB+astJ61oFYxeyr9MCswEgXZ3sfRdZdQBveVpUGAyrQZMiLCsnMzCof8cLcezcmgQEmEqJ4QbuVVEMEA/KFYIgn1MIJJmLhEhhpEnwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=xVR9oC02; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ivMauFcx; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="xVR9oC02";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ivMauFcx"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D31987A0207;
	Thu, 28 Aug 2025 14:24:54 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Thu, 28 Aug 2025 14:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756405494;
	 x=1756491894; bh=eu2xrgfb3lxhWyXTNIdJeH4Ayo6/ragwV/5TOIImXMs=; b=
	xVR9oC02lzrDcsfUMalEjl02zXcqu51/NMDWkkDvnmNqRnBCFan+gJvcGNulY58R
	UFQQ+EBck4C+LlnGfx4NZtcKUbk+GMeCZDMH0IBAlDcR0mxbTf2bhYbWDQnW+wPb
	Xbmr3Ih73f41U4zj0Yy1WhrimNlrNrMnVni5o+hSvxHt9cJH35zcimGNu71iXyPG
	eXZrF0nguRqJLh0rXfii3s95V9td2580OPwrQIRSja/MAq4cGJ46Xubsb5xlJOFB
	PZyeXPNKJRfoEbDYRXbXtnuGa+99u/aSOUUwZAUmCfor+zX5cgmbjpAPSxz25Kdz
	Bd57TuhET93Dtc+cmM5ULA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756405494; x=
	1756491894; bh=eu2xrgfb3lxhWyXTNIdJeH4Ayo6/ragwV/5TOIImXMs=; b=i
	vMauFcxVzMv1HSdqcCYWpOlqX5z/6us79cVUeoIzA22+59PlNgkaXoICrFxPrMNe
	LqnjqQsp4PCrMqgsUKfh5KrB3bZrZO3bu6kspb1zUL8uJkCqLFKUCn5pGMK9/tUq
	96ZE0qEZ3gGLLjQw9hhzzhy5KHn+jjFLd9eajkz1JNUV7V+BE6XJstM9xq+sajvp
	LRDybedWAfAbOHOIsHwhhv08nn5yFrlePgnWQKzS5aKiDjlNcYr6TsUb77hpG/kz
	iBtADBSTHqqLtXcA6Ujp/0Bbk9m7a9Bg2po2OzPYNnivSUBz+nHEQhgEmUZOnarM
	HrROyk5hs0GwCm9+MElOg==
X-ME-Sender: <xms:9p6waDPDLa4xkFAMdnOQGrsYnwLgRo2OwncEiys0T367WXKeg8tLQw>
    <xme:9p6waN8K1rtXMYqItFTXN1NM9BAona30AbKdaQu_7rXwempE-Cp7rNkm3u3xU4GCz
    SA31D5F8v-tL4PWXQI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedujeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdfluhhlihgrucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhn
    shdrtggrqeenucggtffrrghtthgvrhhnpefgveekudeviedvveeuhefhvdetgefgffdufe
    eguddtkeegtdeltdevhfdtuddttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehjuhhlihgrsehjvhhnshdrtggrpdhnsggprhgtphhtthhope
    efpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9p6waG_XgxIkwu4a_7zP_tqRngRY7xtNHVilB-XWLcyrzzm6PcSkCA>
    <xmx:9p6waG31lTzz4PifHWvsAd6GLaVrbP8CNxFxMpHUKlGuouQLTmtXBg>
    <xmx:9p6waD93qLq-h4KcM9t6dfiJJBaxVH9TgmMk_05PQfSejTn8gZ3YHA>
    <xmx:9p6waGsgIMhFkpNDXaJ_Ngp1iYXa2E61xPT-S_fQ89FUV_U8ySx_6w>
    <xmx:9p6waHwfFw1KfxvpZ-zq4DXZ-u1R7wQsaiIm4iElokHVLX-UgYWwB8Of>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 774597840CC; Thu, 28 Aug 2025 14:24:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvvqYbK4iQrF
Date: Thu, 28 Aug 2025 14:24:30 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org
Message-Id: <006b2c3e-9d73-4781-980c-56f98121b9ed@app.fastmail.com>
In-Reply-To: <xmqq349bxxeu.fsf@gitster.g>
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
 <b8873c4529caeddc85879efd122e5a57278352f0.1756148933.git.gitgitgadget@gmail.com>
 <xmqqldn5ix0r.fsf@gitster.g>
 <276630b8-ad98-4ada-aa85-9f136d653d7b@app.fastmail.com>
 <xmqq349bxxeu.fsf@gitster.g>
Subject: Re: [PATCH 2/5] doc: git-checkout: clarify `git checkout <branch>`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> My assumption was that you are making this a manual to teach what
> "switch to branch" means to folks who do not know, hence my
> question.

Thanks for bringing this up, I think the question of audience is very important.

My main goal right now is actually to make the Git documentation understandable
for existing Git users who have already been using Git for at least a year or
two. From the feedback I'm getting so far, the man pages are very hard
to understand for those users, and even for many users who have been using Git
for 10+ years.

The reason that I've been thinking of "existing Git users" and not
"newcomers to Git" as the primary audience are:

a) existing users are likely to be the main users of the man pages (after all,
beginners don't _stay_ beginners for very long!)
b) my impression is that the Git documentation always aims to explain everything
in a way that's "completely technically accurate" (which I think makes sense!),
and I I think it's often impossible to give a completely technically accurate
explanation in a way that a newcomer to Git can completely understand.

That said, of course I'm not against making things accessible to newcomers :)
My usual approach in technical writing is to think of "a user who's been using
this software for a couple of years already" as the _primary_ audience, but
also to try to keep it as accessible to a newcomer as possible.

I think I can figure out how to say something about what it means to "Switch
branches" that a newcomer to Git might understand, though of course it'll need
to be quite different than the current explanation (existing users generally
don't understand what "HEAD" or the "index" are, so a newcomer likely won't
understand those terms either).
