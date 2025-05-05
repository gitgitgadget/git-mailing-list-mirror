Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80872066F7
	for <git@vger.kernel.org>; Mon,  5 May 2025 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746438213; cv=none; b=dLZnXUbMovN4pjkqj1VnnrlTYoSIJU++8W/03Cybwg8Jhjuo7pN+DVB066k5FNU+7eGUUMkVrhTVvGlkaNun/+fFPL2vVxi1ow//eJlh/jMYFFAcJ3wFNyYzQnEwAnxeuAv0VQ8vHCyB8hO/uYhR55carn9u6cigoPRpuaWfYD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746438213; c=relaxed/simple;
	bh=rOGFGAm42TSBvrkxURUx1j+MY+RV88hpVi7ztM7Vi3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAoveO47pbeJuCp4J9SdGV5A6ZenTfgYJuKaP6FeeuxJkXyhsnxz3CNB/bp+ZZ5UAQUUq+hyl6DJ+xlDY8GjjJEfDViObQuZjH3i78SWD0vegzHzOXsOfmWXeFX5KiRowF26rj6KKjloKGoCnlWfvi8p4L2Wdbnw5zYVj8xciws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ulQJPhCd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kVO/s37G; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ulQJPhCd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kVO/s37G"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9955D2540259;
	Mon,  5 May 2025 05:43:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 05 May 2025 05:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746438209; x=1746524609; bh=H/DArusao/
	jTJbSCQyPzqts21T2krZSl1VyjRSaacLQ=; b=ulQJPhCdW5HizZ3ehxyxd5QVd2
	8djDEk7rKP35KgAptP/Ql4ILZTnltchmf1vUb1JLZdAkgtEs4H0xSU5aho3EVaPI
	nKW6ZGlDdVcabERz9qgwKdDhcafwJACTj3vzNDjHXQ+nJPrra+IsyCBQ4IkGUBwe
	J2j/FHKUim9wzKBP+RGbtmEGiTZFvP6U7nwFjmzNRWGeDRNAsuLCEfirRBLg2dWt
	xjcaN+oY1dYRB3YCdMSz5DHouDEoKljHyHRkZeXWWng2KxwB6kTBdIqwl+BozM31
	dauZLOTj0eotx+Ni+HYxi19bxDGJjzTUjUo3xcx1m8Iojnd20sE7pCq3ajnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746438209; x=1746524609; bh=H/DArusao/jTJbSCQyPzqts21T2krZSl1Vy
	jRSaacLQ=; b=kVO/s37GFa5csRk5awpC+d2J7FdkxyBW9+84zgp7mekpmfpc/pB
	aLTS0n6FhwyIYahiExACv4W6kK5cwwMPKNPh7cG9nNK2FDqlxrtJRyK1aZ2xIsJK
	pX/UWrYWm2Hofmmb1b1M4f+HhpOzdAaD86XF9j2xgPzkS+cmjKkK97uWSavDdo/P
	OKgEh99bU5in3wo3K3AfSK7PjA0pTfClMbT0DHvIpMBkK1nqWJBhhZqR+GzOf7pg
	27vEuhA1pObyb/Ln2K6CpszQsYpCy+0OOEHsQK8gegicyyxd9UVDJjlCsb69gAfX
	M7eChzxEsZD7SDFp3/dQ61mSOjO16h9cyjw==
X-ME-Sender: <xms:QIgYaJmjvyXjdNJ2rE8Ylz9i395gdXDPd425_GJ3FVlsjpkcJbHlhQ>
    <xme:QIgYaE06lgaL78gzrZc_IB8CodmtQ9pu18y5xjgcUOvASophjh-_UC9k1Fxp-bfDw
    5V9rQtBWHJk0hdm2g>
X-ME-Received: <xmr:QIgYaPpYtEJQQxaKLfgKztBRsz6RG2upX4Jjxm8C9mmI-2kDUfWHdR0tMWNGcHk4Rn3Y662V7ZLJ_XAUGgAJvVgt-D3JvbS8Zgat7BVTJyvkCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmh
    gvpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
    pdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QIgYaJnqFYbR2bsMm9Y_Ll62R9jsDKOAc8S1_501DeZE2Y2YNV9xxA>
    <xmx:QIgYaH0davfHVbTvb0fTd4E4zH3Y-46N0szy85fC6zLM7PW-XdVF7w>
    <xmx:QIgYaIt4z8TMMMtAsr0W7kl8CiB-8orLXRITyOmExkwgaDuDeHEJwQ>
    <xmx:QIgYaLXGZE_p0R64TQTdzNWxfnYPqyCG1tRXGPB03iNs5v5N_kswsw>
    <xmx:QYgYaCBZHu-VfrpAqTSHuswQmoQyyfkL1AhkJXnLCx3ODyYhIk2SwlQh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 05:43:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9602055f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 09:43:26 +0000 (UTC)
Date: Mon, 5 May 2025 11:43:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] ci(win+Meson): build in Release mode
Message-ID: <aBiIPe7EVTBxENUp@pks.im>
References: <pull.1908.git.1745593515875.gitgitgadget@gmail.com>
 <pull.1908.v2.git.1746282346370.gitgitgadget@gmail.com>
 <aBhVWMabOFYRUjvD@pks.im>
 <5e2fdccc-2c52-805f-ff9c-b9e0e72614ac@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e2fdccc-2c52-805f-ff9c-b9e0e72614ac@gmx.de>

On Mon, May 05, 2025 at 09:27:10AM +0200, Johannes Schindelin wrote:
> Hi Patrick,
> 
> On Mon, 5 May 2025, Patrick Steinhardt wrote:
> 
> > On Sat, May 03, 2025 at 02:25:46PM +0000, Johannes Schindelin via GitGitGadget wrote:
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > >     Changes since v1:
> > >     
> > >      * Rewrote the commit message to reflect that this patch is still
> > >        needed, even if the symptom that originally motivated the patch was
> > >        addressed in a different manner, because it was merely a symptom of
> > >        the underlying root cause that CI builds should not let Visual C
> > >        build Git in debug mode.
> > 
> > Ok, makes sense. I think we should ideally address this issue
> > strategically, e.g. by getting rid of asserts completely in our
> > codebase. But for now I agree that we should just build Git in release
> > mode on Windows.
> 
> I am afraid that getting rid of asserts in Git's codebase won't ever be
> able to address the challenge that Git -- despite much reluctance --
> relies on a couple of external dependencies that might at any point in
> time cause `assert()` to be called, e.g. due to unexpected changes in the
> CI runner images.

Good point indeed, I haven't considered this.

> In essence, we will need both: CI builds in release mode _and_ converting
> `assert()`s to `BUG()` calls (the latter, however, for different reasons
> than to proactively address CI hangs: Git can convey better information in
> `BUG()` calls than in `assert()` calls).
> 
> There are more reasons to use release mode builds in CI, too, but we
> already have a compelling reason to do so, therefore there is no need for
> me to spend more time assembling an exhaustive list.

Yup.

Patrick
