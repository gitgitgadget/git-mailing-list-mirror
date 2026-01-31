Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1E3366054
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769892921; cv=none; b=Lo/ORl8uJsel9Pt7Pndhc9QWXFbHhgwdKBcr/m6FihCf9oquexKhXCay2a6VGeTuIXK2kF0trcrs/bgGI4fh1tj3qoeFtRxrOq8EO3lRj59t8RjZTAgaOeTrWS9eS/l3rvzIMwoqSmVjLF0r5fTnqYFInrsAj9jd0TPwJQxjWrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769892921; c=relaxed/simple;
	bh=roLvNyR74Sxxb4vRIhWv5uWT2Ynik5C9rbddszNKPOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/yHQGUGnbr+NdiAArWoZYPGfkAxQc5NyJZS0zzibnWDCKnwSAGSCmcNVYGtYYsiLhhhROpsxjkmstLPgcnc3znUTflzaAQTquxK9VJkIHkfGxNMioJJWmi2CqkRMU8puUdrIlxuAE8H2P5/KmjbNmL3KExY75TKXo637XDO2Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gqlzQSGo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vleIfd3G; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gqlzQSGo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vleIfd3G"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 567C7EC0304;
	Sat, 31 Jan 2026 15:55:18 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 31 Jan 2026 15:55:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769892918; x=1769979318; bh=laZU9L2Etc
	cAN3analZeEkAskjE41m9JCV8SddPyJ/0=; b=gqlzQSGoZkjS/uzY0/OQaZcRRZ
	qIfJiZK9xY7FAbXXnWAoxKWM7hSsKKA4ZpGCT02in7x9iQGNYrMrWyBi8PVLK/30
	1G7EnSUF5p+4OUtADrh/wS78rTmPWEMHoodURxWVMW2AmmMtpvqDTQ0jxeKJHvbz
	XgJqks1bgM6wCX9JL/s7AqGjdiqni6NR0cGHf0a07Q08Gja9RHY8zhQqOUJ4Doq0
	fHaA696lcbFXOcCK2DDw+Bu+1HqfbjsGch6CnA5jwOgpCYqIvbcyPvfOvwglsnSy
	DYfFxoCKNJHfB7EpjOXfN3Rcu88sQvFiDOcTAebhthaSfxbW+3ecgZ6LWFdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769892918; x=1769979318; bh=laZU9L2EtccAN3analZeEkAskjE41m9JCV8
	SddPyJ/0=; b=vleIfd3Gsj1J4uN1VrwZrfc5hzFGRgZxk19/MB3XMk9D3o3VNH8
	wEV7Rcc7xJHevqEkoubjVN5TROVqkXXpYxWCdCJtBQnzaeDNF4nMsTARivMKTQpc
	JRGb4FctNj7EaVwDLfQf2BonCfDve1L5Pc+IAjbUzm1gNrD+11byvPDQmGtvE7/s
	5qsUPhoU6Ybf69TsW48agLmN9WuB2m8pEGP1y2uMxDHjDA3smIuLxNxIXVZAJLLV
	UzFEKpuZZTrT1cAGuqkRWmkA4CZ02VHhmbqg8xlsN30YonL9I8MkJbnKkqqxgD85
	SVrdBa+OgJ+TrFCCkdIKpl60E6bcK6crB4w==
X-ME-Sender: <xms:Nmx-abJmAsW7v8bwhvDYsjPNVFdDCTVG_DvLyfDhokdUt8ybBLTSew>
    <xme:Nmx-aWJmkHWm26KUmnJtXYlrBbajcwSBzRI3WgK_8VFIpxLvpCyyZrtO2qshgVzR7
    qM6mBrpUPwY6PIarRuU-ioWZ414sZjYM3Un1quv_D5fSp3fRY9iyg>
X-ME-Received: <xmr:Nmx-aYuxuZaw0qogDs6_ztWjiOrkdtqCkroUrih1EkFAtUjje2Jv_NwU2-DvxvO838Cj1BgX9lJJqaO0aqoKm2ZFCrEPYionYW8rRvXIzSoO3-3ElPOrl-0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujedvleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfhougguucgk
    uhhllhhinhhgvghruceothhmiiesphhosghogidrtghomheqnecuggftrfgrthhtvghrnh
    epjedvueekgfdugfdutefgueeitddtuedtkedujedtfeduvdehffduffelffehvefgnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhdpghhithhhuhgsrdhiohdpghhithdqshgtmh
    drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehtmhiisehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepvghnghdrrggsuggrlhhrhhhmrghnrdgrsggurghlmhhonhgvmhesghhmrghilhdrtg
    homhdprhgtphhtthhopehnrghsrghmuhhffhhinhesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Nmx-aTSI1xEmoaSzAc636C3AjeLy2fRy_eSdqHgtbVEuf3Y1qqoorQ>
    <xmx:Nmx-aePrVJI61Z9ozzO2BGReDR8-lggG2beBpMwxgWnxcAzKIUXx3Q>
    <xmx:Nmx-aYav8DdJ6ZpDFB_ANo9RSvUW2f5SX8abuonMrvYZPooJwPdz4A>
    <xmx:Nmx-aYwzoJpI7h66gsXAKXS-_w_5wcgR2UlEf4NUkuIpVa0y3Vek-Q>
    <xmx:Nmx-aS_b2ThXKxYNTnbwORTzglp2eazThuVMAZX8QBMMXDwZfZ2lSttE>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Jan 2026 15:55:17 -0500 (EST)
Date: Sat, 31 Jan 2026 15:55:16 -0500
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Abdalrhman Mohamed <eng.abdalrhman.abdalmonem@gmail.com>,
	Emily Shaffer <nasamuffin@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] .github/CONTRIBUTING.md: fix broken link to
 SubmittingPatches
Message-ID: <aX5sNO4aMVE-qcrz@teonanacatl.net>
References: <20260131161401.48693-1-Eng.Abdalrhman.Abdalmonem@gmail.com>
 <xmqqms1t4l4z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqms1t4l4z.fsf@gitster.g>

Junio C Hamano wrote:
> Abdalrhman Mohamed <eng.abdalrhman.abdalmonem@gmail.com> writes:
> 
>> -In addition, we highly recommend you to read [our submission guidelines](../Documentation/SubmittingPatches).
>> +In addition, we highly recommend you to read [our submission guidelines](https://github.com/git/git/blob/master/Documentation/SubmittingPatches).
> 
> The line is overly long already in the original; can we make it a
> bit more readable?
> 
> As to the contents, referring to our preformatted docs, like
> 
>     https://git.github.io/htmldocs/SubmittingPatches
> 
> would probably be more appropriate, no?

A few lines below, the document links to git-scm.com/docs:

    Or, you can follow the ["My First Contribution"](https://git-scm.com/docs/MyFirstContribution)
    tutorial for another example of the contribution process.

I didn't look at any discussion around b75a219904 (docs:
mention MyFirstContribution in more places, 2020-06-08)
where that was added.  It would make sense to be consistent
about where the links point, e.g.:

    https://git-scm.com/docs/SubmittingPatches

As CONTRIBUTING.md is in the .github directory, it's
probably fine to link there for both.  On the other hand,
having more references to the upstream site might be good
for consistency across the various places the Git code is
hosted.  Maybe that increases the standing of git-scm.com in
search rankings too, I don't know.

Whatever the reasoning, it should probably apply to both
links.

-- 
Todd
