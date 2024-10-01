Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63263209
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777778; cv=none; b=GMVZsOO6IjaeH3ZsCyPor+LJSL2WU6u+nsprl+tiM4n/TFH0d6RUloL58aHBdKkvEFa8jxT4vSLtf376ktr+f0RSfDeoLhQFsiywJEUIEgIL1W6h5WbsLJ040pvjl2523HX52xpEjlvz4hxrlWnws11iJpyDFslGiS6Zp8Dnw4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777778; c=relaxed/simple;
	bh=h9sODOiXZrhMvqF/wrRUsi8U5/s+E0TZP3Tp9R/EnLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiNNS0dqyh0h4bdGqe1HQVb1dU2KQwUoDTC9Q84E2oDrrinVKXJFO1FyJSXkMzn/5Gh1Zx5iys44oC15fOc85gpLHrqadMt+e73cpfuOMbTToJsDckaMWslfYRZX35lKI+CvJC2ClWi2i8q8ZNBvprGzEuJrJvaEaa00n796ytM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IZuMQpyL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bS7O/pJ+; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IZuMQpyL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bS7O/pJ+"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D54FA1381D03;
	Tue,  1 Oct 2024 06:16:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 01 Oct 2024 06:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727777775; x=1727864175; bh=O/JCPHbsxr
	AKW6mEVz1rojR6RE6w+LGRBa2Kns/E2ws=; b=IZuMQpyLKrRZ7gYGSiiiEkZlAn
	ILI9FlG27gc4YpK9g1CYehCluAQux1lO7K5VhlDfMroBj5yyK5q9XrGxLp4pOdpd
	fS7OxBxRq/8UYhAZeMbkD2Y/IQ7XZU1/YnBVOh7KUhXl5n2mZi6W8WPaYldmMvht
	7y73lDMKU3UhOIoJi//thapo2h97zQRZsoRHw+VZSrFMbbfOSbh/E5k65XH6TpEv
	2kJUEJb8KbXlkDdcFsWqUPQX/1KZsF0r/NIYDykIZldZ5FB1Q8/dqqUAT0OSUllj
	Mk6jbmsa1YlBreMPB4+I4gEvpS/Rz6j1dblUv0BTEnlrrBKpH0S9mvtNQabw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727777775; x=1727864175; bh=O/JCPHbsxrAKW6mEVz1rojR6RE6w
	+LGRBa2Kns/E2ws=; b=bS7O/pJ+6XyHykU5gB20X/OG6GhTVO/4TxqhH+lvkUnQ
	p0gOwFC1TPGlQwYZzWoJWuI3QzazHWq/kK74gvdFT6KQSR9S8CkS2QqQoWYroibi
	dbuna5m2/GbgPEHwQqGh110+apcuGk6pUL1ZuuT5j1J5STr+rKNF0H7AQmqSOOGv
	Rpf0bj5w3YubqFDdaQCjC0tPZE6WUTzArmmd3I8M1c5vIXCRuKZVpuUnG3tkEqdH
	tAF9lyGj2QvwJUHe34CftaDbkTgFHSLusMPBjfhyzBypxJSg+mLXE5pdPMpGjgpl
	mIYUg83WJzk3QvIXkI2TtXGJ7tx5+W5UUZWGpem1yQ==
X-ME-Sender: <xms:78v7Zj0xYfD6kmHZFCPg-Gjcvo6LQ8Sb2msLrZnaPIOzxjPh9m70Hg>
    <xme:78v7ZiHh0D2izZvEvSMnY2kSWtrBp2CW2-ed8FRRE5Sawml10yXnL0xL1Y3GhbZFv
    pUc_iwR_UfVPqzkbw>
X-ME-Received: <xmr:78v7Zj7Z_xsIV59bhR3N_UanEJxduCGfamSqnoJKNqRcFiNqruT2nIoPUf3VtVlDBWD8Km-M9G8EasgO3KkjlvKyJsuMByHjmH17X2h8_dnW7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedvgeei
    teegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsth
    holhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughg
    vghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:78v7Zo2fKBc80ScYitG_-Qa0Cl0JVZnAEZyA31v3BwFyEaebbCDQUg>
    <xmx:78v7ZmFh5PMCh9p4vY7cnKEwqSvDSm6_GrWM-U5mQdWrCR5qrDtK0g>
    <xmx:78v7Zp84DWzDThf-6d2kVi_O4A7a6iRwdbDSixJMYgU8jf9PlODmoA>
    <xmx:78v7ZjmHsWnd8rEPl-7D-S7gQv9oMARiIS1QsSil4dY_872F8vAyAg>
    <xmx:78v7ZjOL2CiUU2A0i3OeoDioAw_hly0m7BcKqwFnk_0XSRtOSm8XPXcr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 06:16:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2aca1cc9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 10:15:26 +0000 (UTC)
Date: Tue, 1 Oct 2024 12:16:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH 2/2] read-cache: free hash context in do_write_index()
Message-ID: <ZvvL6bdcV-05tFYY@pks.im>
References: <pull.1801.git.1727696424.gitgitgadget@gmail.com>
 <b6fe5b3ef7e5f4ac8cc339685d92e3ac39fcb456.1727696424.git.gitgitgadget@gmail.com>
 <ZvqaRIY1OzOIh1bc@pks.im>
 <0f257003-5a8d-4eca-987d-517d9754f1fd@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f257003-5a8d-4eca-987d-517d9754f1fd@gmail.com>

On Tue, Oct 01, 2024 at 06:01:06AM -0400, Derrick Stolee wrote:
> On 9/30/24 8:32 AM, Patrick Steinhardt wrote:
> > On Mon, Sep 30, 2024 at 11:40:24AM +0000, Derrick Stolee via GitGitGadget wrote:
> > > From: Derrick Stolee <stolee@gmail.com>
> 
> > > diff --git a/read-cache.c b/read-cache.c
> > > index 3c078afadbc..51845c2e611 100644
> > > --- a/read-cache.c
> > > +++ b/read-cache.c
> > > @@ -3126,6 +3126,7 @@ out:
> > >   		free_hashfile(f);
> > >   	strbuf_release(&sb);
> > >   	free(ieot);
> > > +	free(eoie_c);
> > >   	return ret;
> > >   }
> > 
> > Yup, this one looks correct. I've sent out an equivalent patch via [1] a
> > couple hours ago.
> > 
> > Patrick
> > 
> > [1]: https://lore.kernel.org/git/c51f40c5bd0c56967e348363e784222de7884b79.1727687410.git.ps@pks.im/
> 
> Sorry for the collision. I had checked when prepping the GGG PR on
> Friday but forgot to check again before submitting. Your patch is
> better in substance and context.

Nothing to be sorry about, both series were sent out quite close to one
another. Quite on the contrary, thanks for fixing this leak :)

I don't mind much which of these versions lands in the tree, and the
resulting conflict is trivial to solve anyway.

Patrick
