Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E5A281375
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745310990; cv=none; b=mEMT3f4kOWYZDkWD0mB1nYmxl7gLtLN6U9l2LlXoy0XiaJXRB8XmxyZIC6BXkEhJrGGwRdcRcWSW3HxxLJqPO/29n7ZmvE7OxdXhdXw+MeR9N5wGAN6TeWlfLXJTwh4Akid/WLKjVjGnCN18S3z0/EyrOGSduGdI/LKnqVlycsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745310990; c=relaxed/simple;
	bh=FKJZjDYhiKQU6xOSksMEzqGJGKAdJtO+0F1jBCGPXmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r08wfR6hf87JQOy8SSfaY/yF1/w8roXow0xKtLdB1+prCY0/5ACtIvvt8JOrIGjfa8bhbHPWLBTsrCm+mHdWI5LuGZxc1cihCO76MGf/sQ/2WfxkodNx5HLEJnLM4iGaGKZqDeuB+BwlgNoSU8wf70bYOeYUFB8bp4zxgit8aTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TGCEIDaX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FmP61FF1; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TGCEIDaX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FmP61FF1"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id DBB2C11401DF;
	Tue, 22 Apr 2025 04:36:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 22 Apr 2025 04:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745310987; x=1745397387; bh=zFKLqmMNmg
	aCoh7ClgdHZKKbSEsVf7bjPztHRrlKdiU=; b=TGCEIDaXuDZTvoSTp17jJHlT2c
	QtXmJa6tN56eRkrv239uKW0xjwvLAIXmaSDhicc7vekdaOd9mdwoyd3dAx39oylp
	XJ9Crvnx+wfqmH5iKTRDEDUEF0J3RBuKqczS6Bc8es19gkAfHV8BX1GbS+NU8gXp
	zII7j+wgbtaIXkptHYPKhMDLQMYMC3P2ytzjVk2d0ChYUpOMZcX5htV0FKB/Ioko
	+eKq5v/hxIGEEu3i8F2ZjXiMWgvvHUETc+mXcSHdI3hb1AB8wckBIdt6WWAdeWPk
	P/mH6h02Ces4iRbGcpJyvQwFiztHWCphG3JxtCqTZ/cAcJ0QDeAxSclPl2Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745310987; x=1745397387; bh=zFKLqmMNmgaCoh7ClgdHZKKbSEsVf7bjPzt
	HRrlKdiU=; b=FmP61FF1v+rkZjvc3PuUKHrBtUe+0xFvFHxfzuLJpN4Oy5kyXsS
	yrs5iMzy5NJ5alqWGeXfXdSV3CzKTMjnThplJaKEhH3HyOjjPRSs3lJ/8Ha4EJji
	MdzGnmBvp25ffbXchooz4jlxejbZJmFvkMlljLSZxnK3Xom5ZRsTy0RvEedhLPpP
	VgH1FNHfr7YES5kSOeRBzo/BXVnklvj1KWt5h8pfogy4bvlW2bSxCXSQNTFa/ygL
	MIFyoh7gjZ37/eBYEDPmLbzZir8len4zFSxqJ/oOjQZPTimvMKAHqgciTWNlELtl
	0HSdDb5erQKfcVMH7sh+oi1moaBNr+WYdOw==
X-ME-Sender: <xms:C1UHaJTAZrOzhCujwAp8hbJhl7dJSgf4QaVN32c3WXFltQljHNXJAA>
    <xme:C1UHaCwTK9zUGG02AhL9HSvowwZ1AA2kk3lDjkdgMQIeMvZq69kHbxqA4dxr5iH7g
    wnatOfe3-xlMyBJgw>
X-ME-Received: <xmr:C1UHaO0JgT3GzzusIvFAiPlsNPy7-Zs8QySI-_pUY25Opw7DeRKwmrsrAuZtZ92-1Cqxea5kGNeEPRYEn5u2CteaUpFhd7GjwG6fsMzXaKM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghs
    tghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepthhmiiesphhosghogi
    drtghomhdprhgtphhtthhopehlihhsthhsodhgihhtsegrkhhshhgrhidrihhs
X-ME-Proxy: <xmx:C1UHaBCUOxBFlVKIxj4xagDxYpohVNEnkRI1tunqmagDjULwaBSijw>
    <xmx:C1UHaCgvaAt-Bt4KhL9C3aesM2djeVNfHEXcmxYbqZHk89SHhMs7Tg>
    <xmx:C1UHaFqggB-_OLdOoghkIbSpChSTX9RlJG1ezv8E_QtwvDn6UYhBcQ>
    <xmx:C1UHaNizaksB8Ab8K8KexAj5rS-F9vmTHpFSb_9C7kuY3e-nZ40cMQ>
    <xmx:C1UHaJMdTSx_lxnHywanXRMr2LZie6QXOTz_1gprZskZ8lrHoVKw0-29>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 04:36:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8e0f8fd8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Apr 2025 08:36:26 +0000 (UTC)
Date: Tue, 22 Apr 2025 10:36:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>,
	Akshay Hegde <lists+git@akshay.is>, git@vger.kernel.org
Subject: Re: [PATCH] meson: install shell completion scripts
Message-ID: <aAdVCZf58w-_8USV@pks.im>
References: <20250407-b4-pks-meson-install-completions-v1-1-8a7eb8b9284b@pks.im>
 <Z_RnJEyvtGh_0kFo@akshay.is>
 <Z_SJSKrUdiWzg4pw@teonanacatl.net>
 <xmqq4iyxs02r.fsf@gitster.g>
 <da10dd26-a7bb-474d-8c9a-cac32614d296@gentoo.org>
 <xmqqzfgeeu5g.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzfgeeu5g.fsf@gitster.g>

On Thu, Apr 17, 2025 at 07:31:55AM -0700, Junio C Hamano wrote:
> Eli Schwartz <eschwartz@gentoo.org> writes:
> 
> > bash-completion looks for scripts in a few different places, with a
> > common theme that there is a "datadir" followed by the literal path
> > bash-completion/completions -- some values for the datadir:
> > ...
> > ... since as long as you leave meson
> > datadir and bindir alone you can install into absolutely any prefix, no
> > matter how weird, and successfully invoking `git` itself will as a side
> > effect add the correct bash completion file.
> >
> > And that also means that distros automatically do the right thing --
> > just configure with prefix=/usr and we get
> > /usr/share/bash-completion/completions as expected
> 
> OK, so that is clear and easy.  Next to where we have
> 
>     infodir = $(prefix)/share/info
> 
> we add
> 
>     bash_completion_dir = $(prefix)/share/bash-completion/completions
> 
> and everybody would be happy.  We do the parallel on the meson side.

Okay, makes sense.

> > With zsh, things are a lot shakier. ...
> > ... (a lot of explanation on zsh installation path quirks omitted)
> > So, my personal feelings on this patch are that we can and should
> > unambiguously install the bash completion, but it would be reasonable to
> > defer handling zsh until someone figures out how to do it correctly,
> > which may be impossible.
> 
> Sounds good.  Or just use
> 
>     zsh_completion_dir = $(prefix)/share/zsh/site-functions
> 
> perhaps.  Those who are making personal installation under $HOME at
> least would know that what they have under $prefix mirrors the
> /usr/{bin,lib,share,....}/ if things were installed for host, so
> even though zsh does not look into there, at least the layout would
> be familiar to the user.  But I am even happier if we decide to
> leave it out as you suggested.

Okay, I'll leave zsh out then. We can still add it at a later point in
time if it ever becomes clear what we should be doing.

Patrick
