Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD3C18FDC5
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724158775; cv=none; b=BqvnSgFuMyyVHdALxHfINor3Eh9gEAaPnnjV5F6Ej+EIxW8gDcWnz1pNvSbhB4neFK4a/LdicCq2AhPQ6NbiAgLoUx2FqqvgVkm+hpVEI6g391qpDbexKxd8psmDg1cRJNbGPcwHSa4be5YXwfcOXf/3P6pugJSqdnEzEkYn4bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724158775; c=relaxed/simple;
	bh=XaYs7l3zCXUj5F7RWcI0lpGA/LSbWfHAE4eV8i9XRHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjCQj4wVlteNaWxA3W5ST9r2ryPcElxH+V9FcYZAZRW4N9DQ3O7JAfHh951sbURIY9oRuPOmQw/4c/ItdaXsdtpX++/Igh4XFQkn0cx+FNNaPYpoTqWNYe/6ltE8CDS9LoVQkuKVHqRhBchk8jDCmxJrKTp4nvQi0mOSJhHdqHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BZa3lBhh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nA0pPTws; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BZa3lBhh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nA0pPTws"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id F1E69138FF77;
	Tue, 20 Aug 2024 08:59:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 20 Aug 2024 08:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724158771; x=1724245171; bh=WBRjcsUGcA
	MsWQtfW0o8KuPK/NWa1+X33sGBjooo2Zc=; b=BZa3lBhhGRv6/VWonVl6FQVHmf
	bXDs+sSkARQUxGcOSqbaDSwP27k2d97OP2CLLLo9Xw+I3CMtr5gFvVSaVnvlMPTN
	/xMDZsZmoeo6uEiq6XAH/TdUuBXiP5EdWDWNk8/MW3rEUQYDumWFP3yO+iyuX+S3
	gLggjlofVy2Z0+eVbnrZwAA6CbfhDSIHunMKFSz+Ab8bsujVrNnBzsZI+eI/gz/Z
	oTdLePlDJZD2y4BW7/dvbV/xOjHDmzioDQViW1yT8kv9ijUMHqvSuyNK/hxv3dgt
	npW4jL6N0K+l1vSxhUyGVTk8f9DG04oSy9RKjbaVm5ZBpXOQK6R90a5EBmeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724158771; x=1724245171; bh=WBRjcsUGcAMsWQtfW0o8KuPK/NWa
	1+X33sGBjooo2Zc=; b=nA0pPTws50DxAiNDG4AwGeDOa5i7FYG9pBAVXddKWx0O
	PcgAIpr3DMdn3ijZhQEA4uSDSBzPdB54xYMNTTT1XBTCL0uBHELtqrlIzKi17nt0
	TeFxKV5mCHRqKiMtM8tr1c6E3siVZYYCS9HfpmOKor1lokSnovwafI1UCSGMZAZT
	qgpzanofTQ5EduyonWAymPpStHxV7OmFj+Bgq5A9/ftfRlMuxILZ4KHYX6qfV94K
	E0nwNkotYD8JRqhn8mUbOWPYLnKjRWwx8zTmwlFT9WjqVvyPcec50H7dRIeVf9qR
	LFfv23sO+piupGS+xSgZxb7w6aNlskwuycSaW2zmyg==
X-ME-Sender: <xms:M5PEZtX_dHdSna7SSwkgO5uV0QYrYv9PdGnZz4S2nh1AulfeId6HSw>
    <xme:M5PEZtln_NDxPjUhncLkbUxxLKL7xGnB1sD-1wBZbQeL2QTKCepXNpSHwQ7vROWkL
    HqAHSi4MmBjN-wsfA>
X-ME-Received: <xmr:M5PEZpaFMaLg9Ge4PuCmTtTJ0nKKtWY1s67FJKJOaA1pEfi3VdoH9D2rl-rg56LZrJ938zXJXilXGc752jkoKhpODF9PTYuOtEuB1gyruZq6g5heVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfeh
    tefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsth
    gvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthht
    oheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrg
    hrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepshhpvggtthhrrghlsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorh
    hgrdhukh
X-ME-Proxy: <xmx:M5PEZgURRgxi6G5zSj3dYEkoFvv37XxdgL51hC2gRIqZxfotoceDzQ>
    <xmx:M5PEZnmB_29Qxkx3DykyTUpa_mtaQHJAaODxu4vGu6j-polUWU5Nmg>
    <xmx:M5PEZtdyjwiidN2ZU7Lbod58mk5DuvfLblp4E1otS4-f4VDQUnctag>
    <xmx:M5PEZhGhEkkaQqJR69j8LAOmEO_V_Nelr5jYptOn1udpT03jdJhhxA>
    <xmx:M5PEZp7_RJETcpgEi1TYxmNXRJmeF1KYkOLRpmSuonwa5tO3ZeI10Ik->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Aug 2024 08:59:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fe7390a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Aug 2024 12:58:58 +0000 (UTC)
Date: Tue, 20 Aug 2024 14:59:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH v5 2/9] t: import the clar unit testing framework
Message-ID: <ZsSTLHleGNC2zjw5@tanuki>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1723791831.git.ps@pks.im>
 <369060793306daab1796ae3063b4eaacc287f12d.1723791831.git.ps@pks.im>
 <xmqqr0akcion.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr0akcion.fsf@gitster.g>

On Mon, Aug 19, 2024 at 02:21:44PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
> > new file mode 100644
> > index 0000000000..3fc2c76815
> > --- /dev/null
> > +++ b/t/unit-tests/clar/clar.c
> > @@ -0,0 +1,842 @@
> > ...
> > +
> > +#ifdef _WIN32
> > +#	include <windows.h>
> > +#	include <io.h>
> > +#	include <shellapi.h>
> > +#	include <direct.h>
> 
> This seems to break Windows build
> 
>   In file included from t/unit-tests/clar/clar.c:22:
>   D:/git-sdk-64-minimal/mingw64/include/windows.h:89:10: fatal error: shellapi.h: No such file or directory
>      89 | #include <shellapi.h>
>         |          ^~~~~~~~~~~~
>   compilation terminated.
> 
> https://github.com/git/git/actions/runs/10459342252/job/28963152995
> 
> As we have other topics that I do want to do well in 'seen' before
> merging them to 'next', I'd temporarily drop this topic from 'seen'
> and push out the rest of the topics.

Makes sense. I (or rather Dscho, thanks!) will have a deeper look at
Windows and then also rebase the branch to fix conflicts with the
updated tests in "master".

Patrick
