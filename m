Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38C713B5B6
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533809; cv=none; b=VkkmJ1o7/2RZTO3ok6YzJ8rpDOkrg/z7T04djMfXj5Xm/7gjgUvRDG+yYTgUzJ00kYRiq6Wgf+80RGvb7X9TvHSNIlcEDVXlZrx0hltKIx7HxHainXgVGCyxw5zqVHRJoqegw0GDUM4rfskpBd4ylnvXsDtfhlh2AdL1Df7uWwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533809; c=relaxed/simple;
	bh=qiz59V9yaClIilT/4L3PHgUEgXs/775H0GPQIMbOkFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/YsFxXVXfFPwP/oP9OPFNchrzkxwpyDzKWdAuFQRx1s1Rk0N+GH4VCDGGXqrPdcyG7/nwmajpSmTadr7yVA9W681ay3UrVvNWaSPcJDeT3CcE5nT06z5SkcNLWZ799aOUXiRrgM043YeYTdYKmxtVt1zX4obJ250Menzp7NmPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qiAfUtSd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R0AjqEjg; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qiAfUtSd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R0AjqEjg"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id E5E65138D263;
	Tue, 13 Aug 2024 03:23:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Aug 2024 03:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723533806; x=1723620206; bh=lPpVV7ownA
	yAb1ftdePornJciS1dyPXeYwXIKJPF5Pg=; b=qiAfUtSdQH0RXgjZ3W0RpJqVgy
	r4iroyHf64OrdOvkkToHvBU9SYE+PFsHknWmYbDE6IOF+IWI9Z+RuNO9xuepYdI5
	nPYYr283p2q8btiM69DPOLW9PDpaPYpteM7X2U4NabF+jrrW+PmHUbaAXANZP6gO
	pQTg+xkn6HSS0nFlJ72HhhNvu5RuJKqmlAfwqdmQoh1h6/kqNpzfQEjV8io1F285
	Ml9N3zMzWiPU03rHwGZDLYWu8d6Q/IgGSMC9vZWAq4gpT33gTJMIKsDGU97e+xER
	rQ7KQquLKTaKKisb9fs5GU0ba69ofZGoveNBIQwRp/NMy9w8W499Ctd4UwFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723533806; x=1723620206; bh=lPpVV7ownAyAb1ftdePornJciS1d
	yPXeYwXIKJPF5Pg=; b=R0AjqEjgwGfVeEAnLwxY+UX3Db38NPGrLBc7Df9z7Rs0
	AlyWpAr9WmIXTcqQBvvtc6fkKAtDONGvilANfqGnz6CKgHIgiM8w220GhX+Gdt6/
	xERK8M0498tETbIIfSBdQuR9LN5IctbvtBkRyIjYxCjnCSkRMW/YyC986klQRKhn
	3PcXDrooy6a+y9goFaQBpG1OXJ9tD2vdynhPsXRUjqJSBheHs6QylxqC/uhb02CT
	VH69DmdYKNju3uJRIwrzyHIocUBoJZl+A41jqiwndMqJDp3RDrFzZRUUJGW1BHOY
	NWSagBeK6TWG9gerUC3N3ER2X5K/59soBiB7Cr9TaA==
X-ME-Sender: <xms:7gm7ZmcVijaHzIBdc8VoXdihN4pI7E1K-FkgW_6zxUA9HJBez31HIg>
    <xme:7gm7ZgPD75y8QAJ5_gaLttnYSyiwQpo1siI2VulYP2gv9qOkFgMZOEzlrUqcHRA34
    Te1OFZyjDiYj0MFjA>
X-ME-Received: <xmr:7gm7ZngSb5NEZFJy7QDocajSOQGyG4ObqT4PRYDG-exsoX23kmiALAD6ZtVGUtmnY-qsHSZsJCIiEr9txH5503Fu16Q2iDlMPPEBUAclqG9-SA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegvthhhoh
    hmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehrshgsvggt
    khgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehsthgvrggumhhonhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvg
X-ME-Proxy: <xmx:7gm7Zj8ZZuzqT7zHciVtHPtauRyvLLVF1ZLV-6KvqpESVrQHxkPT9A>
    <xmx:7gm7Zisef4bzxNoAH91z4cYjrr3KJFKRyb3u0mE-YzszFrElPL2SBg>
    <xmx:7gm7ZqEWxRMr6yo8kKonq3BnsoVNrrKKS0bfaLmte75pBDL5h4gA4w>
    <xmx:7gm7ZhPaSGp8F5qdxecovlj321OKfu-PzjSmXf7I5jlBuW78HOBQ6A>
    <xmx:7gm7ZgCJZ-Pmx26_Oqb3lMyM2bUlZHB51B3rf41MoGmIu41moL-Uqgq3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 03:23:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 55b2972a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 07:23:07 +0000 (UTC)
Date: Tue, 13 Aug 2024 09:23:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, 'Josh Steadmon' <steadmon@google.com>,
	git@vger.kernel.org, =?utf-8?B?J1JlbsOp?= Scharfe' <l.s.r@web.de>,
	'Kyle Lippincott' <spectral@google.com>,
	'Phillip Wood' <phillip.wood@dunelm.org.uk>,
	'Edward Thomson' <ethomson@edwardthomson.com>
Subject: Re: [RFC PATCH v3 0/7] Introduce clar testing framework
Message-ID: <ZrsJ6sYURdsxAZiQ@tanuki>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1723095269.git.ps@pks.im>
 <k6uar46lu7ffbnboguca65afwegpcpfrivzfm7gspcorfefxnw@csqkd7wsoggk>
 <xmqqy151zcsc.fsf@gitster.g>
 <033401daecfa$773fa5d0$65bef170$@nexbridge.com>
 <xmqqplqd9yp8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqplqd9yp8.fsf@gitster.g>

On Mon, Aug 12, 2024 at 03:13:39PM -0700, Junio C Hamano wrote:
> <rsbecker@nexbridge.com> writes:
> 
> >>For something as small as "clar", I think it is fine to start with the currently proposed
> >>layout and see what happens.  If we can keep going without touching the imported
> >>part of the sources at all, and the system proves to be useful and stable, that is a
> >>good time to suggest moving it out and binding the selected version of the
> >>upstream as a submodule.
> >
> > I think we already have a copy customized for git's use. The main clar repo on its own
> > has portability issues. I have contributed a few fixes, but they need work.
> 
> Yup, but as long as the changes we make are all upstreamable, the
> story does not change all that much.  Changes like "#ifdef TANDEM"
> would be totally uncontroversial thing for them to accept and we
> should be able to upstream them fairly easily, and once we thin our
> local customization down to zero, we'd reach the state I outlined.
> 
> Starting out with a local copy helps us making these portability and
> other changes without much friction, regardless of how responsive
> the upstream is, and the request upstream would see is "here are the
> changes to make it available on more platforms and/or making it
> generally more useful. all of these changes have been used and
> battle-tested in the context of the Git project for N months, please
> apply."

Yeah, agreed. My intention certainly is to upstream all required
changes. Right now, it's only two minor fixes that we need, one for
NonStop and one for whitespace fixes.

While I'm still one of the maintainers of the clar, I first want to
connect with Ed before merging any of these fixes. I would otherwise
consider it a bit overreaching to just go in and merge things after
having been absent from that project for such a long time. But when
things are sorted out I think the upstreaming process should be easy
enough.

Meanwhile, I think keeping this in the tree is fine. We can then
optionally convert the code to a submodule once the necessary changes
are upstream.

Patrick
