Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D952E22B641
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 05:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729832831; cv=none; b=P0uMYt25PbGdz7nnuzTCY9K6AmPbzsY8ov2iTcKYxoc0KbnhIiaJgjgCLgoaYXVpwos61uYMbthukCWI+LAjXsCQVAZmGen7vlH38Ut7tumRtJCu2VL6NYlHcoKrEKKmwN/vBZuMxeL7SVI50zKAOPgnTL/w+PBU06K6kmlk3Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729832831; c=relaxed/simple;
	bh=n40CvxJ11jGlsT+fMeGxImQfGGL2ixpX9qfAxGCO9CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyXuRg1/Rn4gDsEoP4/7ctGEKqQrTtlEoZ+0HOzBYIJBsErr2u+IwcWftO4Kfzl1zdrykML8tUJSauP2NJFcKyF9HxGOUno0OBpLxbOXVOsO8RFvgxYeVm1HDP/P/RTu/53TLtzfbVMCU+sHJzu5cBSysxlkjrmjRGObmHeOd9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QR80foDb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kkSIN4dq; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QR80foDb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kkSIN4dq"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id A9BF61380180;
	Fri, 25 Oct 2024 01:07:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 25 Oct 2024 01:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729832826; x=1729919226; bh=oeeJSz7VNu
	wCmAdFwEFOPhBbLZctf4QkbBw0pA0i/20=; b=QR80foDbirwBNtZn1onLXlvuae
	+HzUt70vZqVcGCrmCJRmT8JliPkQEgCE0l57UWwPCWYam2UvAAJxDtamkZRePVE6
	M35Qldf0Pt+95GN/e3MmYCswhow0LZlWw70TRkyqGYM+Pd8TkKiPQ/dlR6AB7nAu
	inBfPDzWewUjuKL22JNxyUIJlqFm0rn4SBgrkAd7ugawsVikN83EMfFcOBWSbpUJ
	xHxfMTIpiUeqf0vmSs/pFrf6GkE1K1FoIYG3rFLqi1uDsx5szw0Av/h/W2RU6YRn
	6UxzUmC27CQ4Hmy0UVDzZo75AaGchxGRIrUTD6Zy5QNyo8kBNEZpj2C4uzhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729832826; x=1729919226; bh=oeeJSz7VNuwCmAdFwEFOPhBbLZct
	f4QkbBw0pA0i/20=; b=kkSIN4dqioBJlPVxPHSmFlzzJRrQ8vs+RqEmiaItoY0z
	8bWuB31ppcM8PL72dFpau3CAlegP5ED0UmXAFu8Jfy9QpwuxT7YwCDTruoF8Yc6I
	92u1Waoqzs+ZHfE0aJg20trYTqGE/MwTdv8OyUsF31Sszy0INDiWTs9GUa/RtkgB
	L/PUy9KRi8C+GMxp2h5xppSlSpjKgHYvJc+Ak8CNQH+RtBFe+VCwwoXdLlg5Kwpk
	M30yBTJ+yURw/ZUfKl+pxJCigt3wRSlXY96/CXoZmw3NAF8JLu/6ryraCL45aeOb
	eO7XSwy/kXMgZX3iwuFkxwDgMGPThWy1OeZ+BHl7Sw==
X-ME-Sender: <xms:eicbZxFQIsI4fXIwtQS8nZ3SG3rb2edH8GEhrnrXS-Uvp3SRfO32RA>
    <xme:eicbZ2V5LVIRVM7pibos0-JqFwdYXqf38W4rlCF9dnMR1rZpXs0xmwhVTGPzC1xGy
    qQuGyexcOhhwLJGag>
X-ME-Received: <xmr:eicbZzLG6U7rxdQbixfIFgl7Lz--jIdyG6k6LjlfXEpuq92J4XaAxEIJ9kudU7TDbiRyTvQdnnw3AUGk4XIHz-ehoXvF1gKNu7Ft2RZ3micHcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejuddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvg
    hmihdvtddvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:eicbZ3G7lfidMwyywIoIj5nzPgy2fZv-x95L0ux7_TdTFW-dxx23jw>
    <xmx:eicbZ3UZmGTI6CnHxH9MpnNKMDFOuOBJhebFpmV1Af9vHIxuaEPjdw>
    <xmx:eicbZyORZOpQy-Qh_IebPI6olSh1wiWYXZhCi6gRWLG-aMcd8uGLeQ>
    <xmx:eicbZ23PGMDLb8g2trdWyaFbjgoddDTI0wxbWRERmYTVVLJlz7b5_g>
    <xmx:eicbZ9z-uS4N9ybsGVmJrsN9n2J91ejotu5cJUtozx7ng6DXQBGnUTSN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Oct 2024 01:07:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7d14bb04 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 25 Oct 2024 05:07:04 +0000 (UTC)
Date: Fri, 25 Oct 2024 07:06:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH v6 0/3] parse: replace atoi() with strtoul_ui() and
 strtol_i()
Message-ID: <Zxsncryo3cdbgxu7@pks.im>
References: <pull.1810.v5.git.git.1729669220.gitgitgadget@gmail.com>
 <pull.1810.v6.git.git.1729729499.gitgitgadget@gmail.com>
 <ZxqL4MId4ah+OmTW@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxqL4MId4ah+OmTW@nand.local>

On Thu, Oct 24, 2024 at 02:03:12PM -0400, Taylor Blau wrote:
> On Thu, Oct 24, 2024 at 12:24:55AM +0000, Usman Akinyemi via GitGitGadget wrote:
> > Usman Akinyemi (3):
> >   daemon: replace atoi() with strtoul_ui() and strtol_i()
> >   merge: replace atoi() with strtol_i() for marker size validation
> >   imap: replace atoi() with strtol_i() for UIDVALIDITY and UIDNEXT
> >     parsing
> 
> Thanks, this new round looks quite good to me. Do others have thoughts
> on this, or are we ready to start merging it down?

I'm happy with this version.

Patrick
