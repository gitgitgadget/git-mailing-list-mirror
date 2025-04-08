Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6A21474B8
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 02:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744079182; cv=none; b=k5XagxmA+skxEeP1gjTBgD+jp08ddaftA5CUnBuV7vhhxZep/HIIgs36ILO8SNEqfBKEWQe/4y7ijS4l0sauVS9i95UUjUvAtACw7ji/w861hk2UvCKyE5B3VjvUogg157hCe/vYDnVZuFVmRuU7GRTPXLy8o8XVIzUcrE/t/ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744079182; c=relaxed/simple;
	bh=kSMkU1gdPb68+R9nhyVjMIjUOOiJihpDyYQncynZuiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEpsb88aACFBkyq9zb0E+25cP3yTwsvR4q4nZBPSYD1j8zMcocIwSvCe/gvEmu0pyeRjctz4pWx0s7P0JIGbkW0+8X3Z8BUtfUhckXnHvV3lVu1cIm3tLHHJ3l0RiWN6tfhaOBEVvqhKv9ShkqDO32quOCKRwJ3qnWZER3yeTOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iv4g9QlY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qcesUie+; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iv4g9QlY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qcesUie+"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 209411380391;
	Mon,  7 Apr 2025 22:26:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 07 Apr 2025 22:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744079178; x=1744165578; bh=AJx2aK9WtG
	sbpPajVOnMYzHQ3K63gS4DUWIlsFljpNE=; b=iv4g9QlYiwJ7mkoCOyZSNO7Ox8
	MANj6Rjw0KSMSgstaVJmMKbdqPL+S1jL3mpN0wgxHJBpEac+uJNOlWE9RYraG9ua
	+jjNyHoTsQPn/jRb32Vj38chu1tvHS0rkaMmaL7uqn0KpDQf/agv70mAxwp8mOIl
	SlUEWO68p21/8LU7YC2CqUurC2HORFbqi1oVVtIEhvh/TKXtGCbeNKEe9Tyxim4L
	+4x6CNgZUwOTmIJlKvJL6CVuOZKw0I58WkFx4Im/aXD6mzIgxsT+41J9t/qOecEg
	eIS4ZSKa/ptHySaRemrY9kZh308Fi/WhY9n1qLNw7XosGFfMC1vqkc3FJJtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744079178; x=1744165578; bh=AJx2aK9WtGsbpPajVOnMYzHQ3K63gS4DUWI
	lsFljpNE=; b=qcesUie+GAzrqSTYJnhwn1qRYd8KtLkD1SWYl+5+T2sEKNgF10O
	vwF5O7WiD7wR3wxCHL5b8Ejp1IERG29EYEmMglkmgh18v760Ujb4yr1R6z0LesmN
	Qs9fy7B51hbDUV9lV5wRQ3Xv/n10+tL4cSMpyK83aJof90qMtcqq8pwd03tKG8Dy
	39xjpCXjt+OSQNsFjg+c0IO85sJA32OOTSDGp+6NMOmSrH39OfHQJvnICtOBMjoX
	LVNZ/D4eKQ1eH2NPT3bdj8bSPrZnAZw6hlRwkHd9zkyvdfrKCxPt4sHib6AbhM5x
	juQ8nqSSGi7zbZ9VeaBi08ZO2/MDw4d+pLw==
X-ME-Sender: <xms:SYn0ZwEHWf-vvcKGRx6T6kkhbNAm0ZaUECMUnrYcQlpM2BmQKyiaRA>
    <xme:SYn0Z5X9FFCDgrVx-bSSD5dj9UldsCJq6Bb6vByfw-Z7EAkRLeRcz-MnJesaKb_HR
    SM7p_VQuhJG3QB9Xg>
X-ME-Received: <xmr:SYn0Z6IugOegrNrxG0YzaragrAeimAHrcCK8fz37VFyISQ8yINYLQLBcdP78Oo1lby6zoSXG_a-plQ_aqC67LHaqtySsqNTiUY4-fv3ErgTq3bguQY0e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddukeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepvfhougguucgkuhhllhhinhhgvghruceothhmiiesphhosghogidrtg
    homheqnecuggftrfgrthhtvghrnhepgfevfeeviefhheehhfegtefhvdffheefheeuleeh
    ieffuedvvdeuhfevffeigfeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepthhmiiesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhishhtshdoghhithesrghkshhhrg
    ihrdhishdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:SYn0ZyHTtHlcX7bOVa7xh5vzIoErT1b60lJDHVTGh6lgX_RHBcQGGA>
    <xmx:SYn0Z2VPXcS9JtRBc9I1NN4R9H0DpTyw0vPPOHoslAJLZ_xeqP4y5g>
    <xmx:SYn0Z1MoErlXOGN6lgUhH52Er5dTXnKcU-qqcwiMK0Vp_jkRCA2ifA>
    <xmx:SYn0Z91OF7Z0O_48grAMgSLlijlHjSlM8U509SJWx310Id75WepNaA>
    <xmx:Son0Z4ptIDZgmJccloQ5F5l-6fGcVTcirRYPJA162hAY_7NSVvDzeTvF>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 22:26:17 -0400 (EDT)
Date: Mon, 7 Apr 2025 22:26:16 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Akshay Hegde <lists+git@akshay.is>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] meson: install shell completion scripts
Message-ID: <Z_SJSKrUdiWzg4pw@teonanacatl.net>
References: <20250407-b4-pks-meson-install-completions-v1-1-8a7eb8b9284b@pks.im>
 <Z_RnJEyvtGh_0kFo@akshay.is>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_RnJEyvtGh_0kFo@akshay.is>

Akshay Hegde wrote:
> Hi Patrick,
> 
> On 2025-04-07 09:42 +0200, Patrick Steinhardt wrote:
>> Hi,
>>
>> this patch is a result from the discussion at [1]. Thanks!
>>
>> Patrick
>>
>> [1]: <Z-uLqQd7QHZq-tB7@akshay.is>
> 
> Awesome, thanks for the patch! I applied it on top of git 2.49.0 and can
> confirm completion scripts get auto-installed at their appropriate
> locations under datadir. The datadir can also be customized by passing
> in '-Ddatadir' to `meson setup` so it's pretty flexible.
> 
> One thing of note is that the git completion script for zsh also depends
> on the bash completion script.
> 
> So if you use a non-standard install location like I do (I'm pretty
> weird, I use macOS with a package manager I've written myself), you'll
> get an error with the git completion not being able to find the bash
> script. The fix is to tell zsh where the bash completion script is
> located. This is also helpfully communicated in the completion script
> for zsh:
> 
>     # You need git's bash completion script installed. By default bash-completion's
>     # location will be used (e.g. pkg-config --variable=completionsdir bash-completion).
>     #
>     # If your bash completion script is somewhere else, you can specify the
>     # location in your ~/.zshrc:
>     #
>     #  zstyle ':completion:*:*:git:*' script ~/.git-completion.bash
> 
> Adding the zstyle line to my ~/.zshrc made the completion script work
> without issues.
> 
> Most people won't run into this since if you have this installed in the
> standard locations, it should just work, and the zsh script does have
> logic to look for additional paths it may be under. I just wanted to
> mention it for info.

I wonder whether it is proper to install the completion
scripts relative to git's $datadir by default.

I think the default ought to use the pkg-config call to get
the completionsdir variable, as the zsh completion script
suggests.  I am presuming that's something meson can do
rather trivially, just as it would do to find the compile
options for git's various build dependencies?

I don't know if that becomes too messy to be worthwhile when
determining whether git is being installed by a normal user
in $HOME or by a privileged user in a system-wide prefix
like /usr.

(Or, perhaps more confusingly, in /usr/local, while the
bash-completion bits are in /usr.  /usr/local is one of the
prefixes bash-completion uses by default, so that one would
happen to work.)

-- 
Todd
