Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A51A2F50
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 05:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728537042; cv=none; b=cWaokPgbPFJuMeoavrFKOsdcXXS2uoz2+5cnDrRY4kp0k73gfsVHMSkvRI+BvbbaikD6FqyDKNGykbsGcP+QQo6W1Gpc+6CRpd/SphdgfmHFWVmA3WPz1050bezb2O+m4sCg5PPIUNDMHAjOUC4DDkaQNB1cXgvy6NVhGmJEYuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728537042; c=relaxed/simple;
	bh=TQw0ZG1+tdj1rzCqN0QIEn35pvCb7Wl80iBcEuCYCKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SB0m68t8tJbdWLtCrJ8lrn0dS9YrdpChNSYFHr6bSgD3eET4KvZXXpBt1fzBLC9w/m4JmzSaq7KrjypcmgfpVoh/nyHF770DfCyHHwDKmCkOJQSMOEilflFH3em/4OPYnoALu1+1x8G7nYHaFcuiFRhAZ41hXwNUooZNijWl20k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TJcuyCJX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lOMj47hU; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TJcuyCJX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lOMj47hU"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 407A0114025C;
	Thu, 10 Oct 2024 01:10:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 10 Oct 2024 01:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728537039; x=1728623439; bh=mPbo8Rra+S
	j0IZBiZetVnl8ffp9KOlimdoNpMfwD3mA=; b=TJcuyCJXVAcQr7GsPv1cq7aNEw
	+o64wSnfWaNIvWWaiWJAnjwcB8yih8ZAxnh3eyhJ4rAEYbn0CWR0zfIpNFZMcGW/
	UDoI9Qa9zLxE0Ge5AKvj2hXmgXkQKUGzIPLFgC50k0mojwtte7SqjQdZbWMKfqVG
	dhPSxYe/5+ikhQ3rB2zSED5FG5vhhew0w51fD3C6Y2xaTQUsTJvUKIjuzwC60YSl
	FEDToCVKbn05codEOV4SR3HQVSMloIqRtug6bU4s3RKf41dPJThOJhu+xAo/jQV2
	YqonYUZoXgPWmo4lGNgghbP0+5S03C+kdIDSSnRxmpDjAWhgmCzO+XrREf0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728537039; x=1728623439; bh=mPbo8Rra+Sj0IZBiZetVnl8ffp9K
	OlimdoNpMfwD3mA=; b=lOMj47hUUih8fj6ZkyWD82iAEQz4lJLgDJF3dkPwBBRs
	yi9Bq3Plt6aZ6cBOCFaSv22fpWrDs2q/XkIf9sJEjEdNPnCu00NBaKgwqTLrHfyK
	Wd7oNiUld2Z1C3jRwrG1M6DuFZU2UJPGPuOhQ3GPezekqQXfZZHGZkaR4pQHhjDK
	hPzWYMEF6gplxb1RhQZcs7X5mtoniU5Vru13C/R7ye4OxQx4Ra+tqt3/WI5a9P+9
	liK5+69itBxsHCzbzi5ECSyYQkT7PKSI03OJlqCiNVulG3BkXmGfvIvRWZI30SNa
	cmayLvVMau5FafcPLmUAYiBr3I1LfGFRLthuiMlF6A==
X-ME-Sender: <xms:z2EHZx4UlMiW7rneUhZEpSslzH4aYETqCMywOToeC6_9yLzPcGPD0w>
    <xme:z2EHZ-6gvUhjr3kfOjgi6ROnvPp32ts-Z7p5lvOPznRvUMojtTRb9ILNLF5n-Ugwv
    hHaJpDc-rXevZrGSg>
X-ME-Received: <xmr:z2EHZ4exGw6ZB0kYfWYG1rrEjA7seBfXt67x4uk3hEiF-HMrHd8F5UF3XLdVl-gP2HlM9sCxlaPTUqEoN9MusCdDgysiRS4lF1Iiu1yaP8h227_s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfeh
    tefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehshhhusghhrghmrdhkrghnohguihgruddtsehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:z2EHZ6JMoeKEat7nSyl71pD5aIY38RLErXJ18muDif8G0B-WgrwPnw>
    <xmx:z2EHZ1LxIscQ2YrPp6-wg7ZEXGceP1JSpPki6tXL9rvMCi5lfv-twQ>
    <xmx:z2EHZzwIL0MhxP5JZXfDTUQjFgKFlIWZAUUnLt3ZdqyCOZgSJ9rtOw>
    <xmx:z2EHZxL7We7lhRMP_vX021bjozA_J0uvuHJfc2ic21K0uFtVvj6jGA>
    <xmx:z2EHZ125gTmpkdqQV0q0aCjWncpIBq4B4jDOlw5zdPvOe-nS8Cul1Qya>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 01:10:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id be78b299 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Oct 2024 05:09:32 +0000 (UTC)
Date: Thu, 10 Oct 2024 07:10:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Shubham Kanodia <shubham.kanodia10@gmail.com>
Subject: Re: [PATCH] builtin/gc: fix crash when running `git maintenance
 start`
Message-ID: <ZwdhyeVmjIX48k3X@pks.im>
References: <CAG=Um+0mJW-oAH+YLC3dWEU64JwS-zMkkTiFWYBe4g6HMbe-iA@mail.gmail.com>
 <976c97081af7c62960bd71d1b70039657e7cb711.1728389731.git.ps@pks.im>
 <xmqqbjzu1m2j.fsf@gitster.g>
 <xmqqmsjcoom9.fsf@gitster.g>
 <ZwdeFB2-LUuHVm08@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwdeFB2-LUuHVm08@pks.im>

On Thu, Oct 10, 2024 at 06:54:53AM +0200, Patrick Steinhardt wrote:
> On Wed, Oct 09, 2024 at 04:14:38PM -0700, Junio C Hamano wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> > 
> > > Patrick Steinhardt <ps@pks.im> writes:
> > >
> > >> Fix the regression by again unconditionally allocating the value in the
> > >> `out` parameter, if provided. Add a test that unsets the environment
> > >> variable to catch future regressions in this area.
> > >>
> > >> Reported-by: Shubham Kanodia <shubham.kanodia10@gmail.com>
> > >> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > >> ---
> > >
> > > Thanks for quickly reporting and addressing this one, both of you.
> > >
> > > Will queue.
> > 
> > We seem to be getting:
> > 
> >   git maintenance start --scheduler=systemd
> >   D:/a/git/git/git.exe: error while loading shared libraries: ?: cannot open shared object file: No such file or directory
> > 
> > https://github.com/git/git/actions/runs/11264159690/job/31323795058#step:5:327
> 
> Oh well. Lucky me that I'm spending half of my life in Windows VMs now
> anyway, so I'll have a look.
> 
> Patrick

Ah, the difference between `pwd` and `$PWD` strikes again: the former
uses Windows-style paths, the latter uses Cygwin-style ones. And as the
Windows-style path contains a colon the resulting PATH variable was
broken.

Will send v3 in a bit, thanks!

Patrick
