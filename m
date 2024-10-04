Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA07F1D9A65
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728055356; cv=none; b=RtMk/I6A1trWznA1yNfPQ05SZCIQEt9nQ/o8FStBKqXQPnScgEKicu4+ULjA9Ro02fUN+Ji4NG9qO5/S8UTHUF2y3klpg9kOVXCXMNs0cvBI1WbmJ9c+iP5+htpW7tdI7X/mjeGTQwbQh+M1BzXJlpj8s5NVopqrObqXbj7OpeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728055356; c=relaxed/simple;
	bh=aClx3xIk5jUdnCpkYsR8IaHfwKq+kN4Pl8G2sc1Z4hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiBTn1gJl1ldMLssQjq0nqwoFcXQd4ofJ1vKRMKt51YcjBDZdd9NiIU8j50BIBYLgZvU4vdYk4SmnQ2PMrrDDEFsBxFYmNWb08AwBBjk7bO/om4/n69FptJylsNy+/if6oQhLYUa1SorUEgoYpdIzoynFNHERPqg6oo4DRcf2GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=crY9J8Id; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dp8y6uBn; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="crY9J8Id";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dp8y6uBn"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AA3F311400F8;
	Fri,  4 Oct 2024 11:22:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 04 Oct 2024 11:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728055353; x=1728141753; bh=YdnmEtee1Q
	cgazjg0S834zximSOhy4iKFqqKZPVsoUI=; b=crY9J8Id/+68PZRaX2EkMNvR0f
	eHlMIG3b5mdAGXqeBjU0rgZA9bzWCZsxE8hRHiAp9la+bTnmvqmc3+1EP59ahQjF
	7+DzMek4nBvL4OV9XG0WiTyj2dnDlmVeb8c4hit9Zn3bX7t6k2GJmH+RtGF7Qsda
	JIluTsbSyxf0BPwZkSQg31BD+jwtpYEukhvZoG+t+DcSni7fqeTyEKhgbovBUY4f
	mGRCqD/YSaAvmz9HDTRQPdj7gLrGbiPoHMFPIRASfQTfAJLvOMXpQlsLn6mUqVjH
	818Jp33shJKUFGiBoa/LmN1KW/vxwiJBSC4bo1lzat3XyN4U1rSGZO6rv3Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728055353; x=1728141753; bh=YdnmEtee1Qcgazjg0S834zximSOh
	y4iKFqqKZPVsoUI=; b=Dp8y6uBnzsclL5ftNAcF0kLgrkkXqXT87KhlHKSs9dxE
	y7uk5H4z1xOFAvA7u1izy9BMf88Bthw6BP9snr8rN5CRE7oreivt+jZBApXN/d42
	VDhSycAdCp4zg3T8LeWpsXvoBsulJ7SaaH6LJQPISo2jB100ELPPuSBzxuwoKisy
	29BcAceEoxC+OWWjPONH9gOV0czAERqbbeBEz+Z2FwnQcg+J30ut149eKBYq6IhP
	cgHwQJRf5rXy7VDiYQ0hbLLPFMLlmaTfUjAIsX3IFwr2m4C+5IB4wzq4J8yJWH2C
	oaOTwtz/mPiEZC52h+KMx51BM7P+kdBCx4/DLuBEnQ==
X-ME-Sender: <xms:OQgAZ4epS1so3VPR9Rm5IK2nQAdV3FO47-esMWvFpxnPmadBwfyjYA>
    <xme:OQgAZ6OU8Hsi0ocYkA3G7X8xZDBdHjn4WHOBRm-2sz8nM-EBCbbAzt7zCZrQv6MEX
    uJfT4pr8Pv4NG1Hog>
X-ME-Received: <xmr:OQgAZ5gTnkIjVGPAOJII6a1_kljEDN6A7WDXBSiZ8fdZGcBiVM-MiZukKDdv4_VlAlRAWVJ5W4RltmicPAcMpVcntY-jgkpoVIJNlLwYaIjU1fDL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:OQgAZ99T7Ieb06_0c5ZlMWR6Nu1U9rekkCBKU5Czsrh4AlrgHHTqHw>
    <xmx:OQgAZ0vU0SJJiiuatplBcucn8UO7HAx5lwdzhVArTz37tEDselpBkA>
    <xmx:OQgAZ0FiHZjn5jyTrOdsG-qJvVAGuKICHRdWwzmgvhG0DzYM7pgwQQ>
    <xmx:OQgAZzPNUo98yOLdR8CpjSBsxaXJJdiJI0PSVjlWkrtOfAScpQbZzw>
    <xmx:OQgAZwJv3VPoaOgGRO0uWH0NicDOxVfDzqukFdy9TOykQX8Q1n6dO889>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 11:22:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c556ba1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Oct 2024 15:21:36 +0000 (UTC)
Date: Fri, 4 Oct 2024 17:22:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: the latter half of october, the maintainer goes offline
Message-ID: <ZwAIM6GO3VtoG3ZM@pks.im>
References: <xmqqh69thzd0.fsf@gitster.g>
 <Zv7aLRXwt9cfqW58@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv7aLRXwt9cfqW58@nand.local>

On Thu, Oct 03, 2024 at 01:53:49PM -0400, Taylor Blau wrote:
> On Thu, Oct 03, 2024 at 10:26:19AM -0700, Junio C Hamano wrote:
> > It can be somebody stepping up and say "ok, I'll self nominate and
> > run the project as the interim maintainer, just like it was done in
> > the past years", or "let's do something differently, how about
> > everybody throws a merge request to this mob repository, use this
> > (possibly different) review procedure, and give back the tip of
> > 'master' when Junio returns", or "OK, we'll discuss and exchange
> > patches for these two weeks among ourselves and we can cope without
> > a central meeting place".
> >
> > IOW, I am interested to see if the community comes up with a
> > day-to-day project structure that may be better for the contributors
> > than what I have dictated in the past during my vacation time.
> 
> Interesting. If list participants would prefer to use the same structure
> as when you're not on vacation, I'm happy to shuffle the patches and
> send regular "What's cooking" reports for those couple of weeks.
> 
> I guess that amounts to the "I'll self nominate and run the project as
> interim maintainer" option you mentioned above :-).

First things first: I wouldn't mind you doing it again.

But I'd also like to take this opportunity to think a bit about the
bigger picture: what do we all do when Junio stops working on Git at
some point in time? Right now we don't really have a plan for that at
all, to the best of my knowledge. I know this is going a bit further
than what Junio has hinted at with this "fire drill", but thinking about
such a potential future is certainly important. And if we can come up
with good ideas, then we might as well try them out and experiment a bit
while Junio is out.

First, let's talk about the requirements that come to my mind for any
replacement:

  - Doing Junio's work certainly is a full-time job, whether that
    full-time job is handled by a single person or split up across a
    team.

  - As far as I can see, doing the maintainer job doesn't allow for a
    ton of hacking. So whoever is taking over likely wouldn't be able to
    land much code anymore.

  - Junio is doing a great job of being independent from any kind of
    company agenda as far as I can tell. A replacement would have to be
    just that, either because that person is being independently funded
    or because it is a team set up similar to the PLC.

  - It goes without saying that the person would need to have deep
    knowledge of Git and the codebase such that they can make informed
    decisions.

There are two maintainership models I can think of: either a single
individual or a group of people would take over.

  - A single individual needs funding. The ideal situation would be if
    that funding came independent of any of the large forges. Or
    alternatively, the big players in this context come together to all
    pay into the same pot to fund that person. In theory, the role could
    be elected and serve for a limited amount of time so that overall,
    the community is in control.

  - A group of individuals could take over, sharing the responsibility.
    There would be a ton of different questions in this context: how to
    form the group, how to balance its interests, how to distribute the
    work across its members, how to resolve disputes, etc.

So... that's just me dumping a bunch of thoughts. I'd be quite curious
to learn about everyone else's thoughts.

Patrick
