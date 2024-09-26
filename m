Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1721798F
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351948; cv=none; b=WDZmsAW4d0ZY24KQvJ1jjsegvChORI+Fw7Vwy/51EnTpqrrjcgH1UWNdGbvaJO42reN0GPp+gP7+/ChWCWJVzXccdLyASdt7qBns0zem8Wxo7aW8pTNAhc9XOBRfKlAlrDmUl4/+8SIMk7UoKwIXEXtApl9PMSGJt65ZJEH6TYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351948; c=relaxed/simple;
	bh=A/jUOYeidjpOD7wRXKsRHDgSJpocR7mOBOZl3AicEuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdk2Io6Eb1svQm7OtFzQVHFEInnjBInPSfrTK/LJsSNv+ZFnMRvk2QcDkiTSEi1CX6ldCaAXoC0UN2wJE2lfCRWjX2yLdNZuKv2Ww4CPzhSijYF0ngwT2IU1MXTntx60UOdm8kYHpLm+Iv9Fr6S1oyvokYZTxkjCchZvLSooGig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JI8EDN2Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=puKmxHkD; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JI8EDN2Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="puKmxHkD"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id C054213803AB;
	Thu, 26 Sep 2024 07:59:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 26 Sep 2024 07:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727351945; x=1727438345; bh=SRB0OpjWf2
	7WRXS7hXAAyyjtwcHx3c5kElwRiZQwlds=; b=JI8EDN2YF/mTu44m866kA0j2Rv
	4V7yWcVz5vjVUAGkhGzihN3t35DL38tz/SZFoaVlQSTRe1mckJAd/9niTNfWhBGB
	JNUea1kUrWy9u7WxiCq7iYHtoNSR8ziqlIf7P862osYxkbRL1YsrgChR6uLVmlyy
	V2jwyoWqyvufv47SXqOaWPFmbMZJJfDz2ol03B0ummw3ezKLhH+a7+UqtZjtfxDa
	gvCbJ0tUrz03bhdscUHZrNufn28tpPORzIPPtv8lMnha0Nxa3X6AWEEKK8yStioK
	Amly11Sx/WgEd2NB7VJp2eIq/EzKukHe5ZcymdlRK5rr8uuiZDbyO8M9qDag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727351945; x=1727438345; bh=SRB0OpjWf27WRXS7hXAAyyjtwcHx
	3c5kElwRiZQwlds=; b=puKmxHkDyVkHBuMMvNCoaPo+lFwN8DkMcY3WvIcxb1N7
	3xh904qRzjAD94lkM8iOflK1xvL7LNBSIdknwffPNxYscccXAi/GbeLkH/keBRxQ
	cHvX0A+QqKOOcjaTRCDg5sTIDpRMIYrwnCjKx8gvRhzme1waYQ0rkHPsNh6BhBKh
	ZHI4bs5PFTGs5BFDFta2fTpSmfd8MxYpl4XPJZ7jbaZBc6vuHfclnPL9qvO78K7v
	BPvCnSlNXeIVA2IBGz0bs6XkGOx7f/9/zxZAiNSuzDOeo7rFVoBX+I0mlkhE+oOp
	6QCYE7vVO5NuWUEy47uOHljxNtrMVDs29q8rQ56miA==
X-ME-Sender: <xms:iUz1ZlWnmp6_F6lHzu5v-N-_3TaZLd20fq2dEtARwPVxWKr1ZKCw-Q>
    <xme:iUz1Zlm5gbrAWhQzSnZSFjx15iU_01yyTMM9ZfVMbK3vRGQ8Ee5dxeUv-VWvlTPTT
    TMYBrDWVEBHlKpPeg>
X-ME-Received: <xmr:iUz1ZhY5LvmuWjQWaZZ14N9uAMPfZiSDtLwTPEms4g4QbIDNmbNkk9f--n1rFl167XJC3hReXvX5nMoNFkXLRIxFPhiTFJTAKg8Q6rAY65mMkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:iUz1ZoV-I5kzmrIHEyV_h7AucLXhWD_YNKuX6AFNvYMWU5MsHTYNqA>
    <xmx:iUz1ZvkgqEw8NbzA5fsf1UUcQtImekVAKw9VSRwoo-KbXN5xNvo5dA>
    <xmx:iUz1ZldcqIUKt69zsfUDPJ38s43KBmDYmTtgHZjAiZgIFCCXR2xOSA>
    <xmx:iUz1ZpEMdzCMkStgbb5IzQO9k9FLJl-sRY2JlOWSM1uWQ11gi9iX_w>
    <xmx:iUz1ZthVSRPJOuX92vixImYkX9sdPReyx3poCRH7z8FJsrbawitaYptD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:59:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3d93d1e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:58:26 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:58:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 08/23] builtin/submodule--helper: fix leaking remote ref
 on errors
Message-ID: <ZvVMg2kJR97JuVyG@pks.im>
References: <cover.1726484308.git.ps@pks.im>
 <d088703d317a8598e1cc4eb068234c105cdeffe6.1726484308.git.ps@pks.im>
 <l5aljv4zlvkfpjsizofsypgfaxdzkihwghd3voxin5oxibuixz@fesroo5tihzi>
 <ZulXjXSozNrXgMUM@pks.im>
 <xmqqbk0bo4ye.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbk0bo4ye.fsf@gitster.g>

On Wed, Sep 25, 2024 at 01:26:17PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Mon, Sep 16, 2024 at 01:51:21PM -0500, Justin Tobler wrote:
> >> On 24/09/16 01:45PM, Patrick Steinhardt wrote:
> >> > When `update_submodule()` fails we return with `die_message()`.
> >> > Curiously enough, this causes a memory leak because we use the
> >> > `run_process_parallel()` interfaces here, which swap out the die
> >> > routine.
> >> 
> >> Naive question, is `update_submodule()` itself being run in parallel
> >> here? Is that why the die routine gets swapped out so a child process
> >> dying is handled differently? Also is it correct to say leaks are not
> >> considered when we "die" normally? 
> >
> > Hm. Revisiting this patch: my analysis was wrong. It's not the parallel
> > subsystem that swaps out `die()`, but it's the fact that we call
> > `die_message()`, which actually doesn't die. It really only prints the
> > message you would see when we call `die()`, nothing more.
> >
> > I'll amend the commit message and send out the amended version once
> > there is more feedback to address.
> 
> So it has been a week and half since the series was posted and it
> seems that this is the only thing you might want to touch up.
> 
> What's next?  Just have an updated patch [08/23] and nothing else
> and be done with it?  A v2 round of 23-patch series hopefully will
> see somebody other than Justin and I lend an extra set of eyes to
> double check before we merge it to 'next'?

Makes sense, let's do it this way! I've sent a v2 a couple minutes ago.

Patrick
