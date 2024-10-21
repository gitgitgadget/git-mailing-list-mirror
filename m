Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C795F1E8820
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 12:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512052; cv=none; b=unW/TQNnvtWQpQx2eUqLAS11n59y/jcr6FyYykTUl1bjZmJ44KrWmynd5H03VZ23RIvONW5Ji0nr96YSHos29Gi/lwXVAbM80YYXsAkVQbZ2qVc2PEsEZyEwI3G6JbO5Y40MY+JozRyt8tDpGpNTzG0ksjvrrm0AibhjOZSz27k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512052; c=relaxed/simple;
	bh=bEA4jACupPxNQDCXMkdsyBuRCNZnkfqNRcpzR6/sc1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPrdu0xR5H69sK+S8qTOY9CDwZodeDtiPuknoL1ULc6AIy2PP2wjnnSic0jNuV05BOByh6dN76SALGA/vVhivlR5f0Cj0DRcAw+iiZ/SfxpbNGWc2lz3cKhno9e8wOAuT5uG4MnWLTIJi0qJ9bNkqij2bkx06IWgYPjjo3s1tsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CZgNWhBY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LSLdBeUC; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CZgNWhBY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LSLdBeUC"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id E18A413806A8;
	Mon, 21 Oct 2024 08:00:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 21 Oct 2024 08:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729512049;
	 x=1729598449; bh=PSD9PHGPB3zKne0bhgeBnRgAyfWYwLX5I5D6MnA8470=; b=
	CZgNWhBY+3lAhlOG+5iqKgbDNENj0X7LID03c+RBiKUbFzMg8GTpDDa1qaU06RL/
	DyVYkc4JIUsNpWC9MIqjA1NiN7v8AkyHGWPvUZrEoGwI5f/wdSwbQ0QPBQoj1RUL
	MDAshtOq8jfjTpYaetmBIcHHoOyvbsOTeYQGpXp8svT7/hSvf3HUJXBNElc6bEE7
	vR7wO9ReRseZysQ7XivckzkutiVpdgrSveOXocM7MABadtVMPXkThldkZDX0gvzk
	VXe/4v+CevJeqTrdkqEkqazVOKVR3x55uCuAxSRrYyzfedqABJxhVea6tsA2dfsB
	etAQPeKJsIZwo2ja9NfCbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729512049; x=
	1729598449; bh=PSD9PHGPB3zKne0bhgeBnRgAyfWYwLX5I5D6MnA8470=; b=L
	SLdBeUCU3u/WcgWJKpArfF3UWocKf1PJT323csdYgkVBls9+8p9cBGIpBZG/5NXk
	IlYX08f5t1jlkZm3TeVFYMkygJJu7TUljhn+mKMpik1dgPG1Pzwpg3rJfFsWjlIH
	nVfkKG+kGx5DNL3pd3gkcwkDbx9DdAz5/wW4iGftn0bgWIpqKNI8Hbeuq6GjQI6/
	z8rldJj6BlcCMr+ZGvCD4b1SHSyqWtoNQ2jfdE4eNAaBPyCT/5f73qFeImqwF3Iu
	/N5Pk7q2FN1QPmotX6WAvW83DFZX6Ru2np2bUGrLpFb1I+5xS1YboMhL/P/BBOa2
	sOZjaOmW7yhTh+ZtTWE5g==
X-ME-Sender: <xms:cUIWZ9hq_oE9uZtJQ9FKe1GzAAMP_Ik05-Q8D8xdA4EWT5j29i14VQ>
    <xme:cUIWZyCqZwQJkPn2FEWndj7YRmB8qbZu8fxYM3fHC5Qntyn24TIuUN5a2Eisln4qA
    GeGejtWV7KR8li9ww>
X-ME-Received: <xmr:cUIWZ9GH3I_bKFSaUKjtHqfW41-EmW7jtEB8pJgrpoN28XRuniHwwOwWj4CPRB7vbDQnV9C-nWhWmTZ69eT_6MQIMrtNmG5nP-N9ThYAjZJR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgurhep
    fffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghkuc
    futhgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeev
    gefhkeduleeuleeftedtheduvdffueelteefvdfgjeffffevffdtleehudevgeenucffoh
    hmrghinhepghhithhhuhgsrdhiohdpphhusghlihgtqdhinhgsohigrdhorhhgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    uhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsh
    hhrghmihhmkhhhrghnuhhmseihrghhohhordgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cUIWZyQGexopCQPR9o-5nNqA_AIAS9w3N_gICvQb-f5ubDPe6CXa5A>
    <xmx:cUIWZ6y5WeuGHkJ7_ONkKMJS5Q0Xe4biddvUHax2c8kxLtlM_gIAlA>
    <xmx:cUIWZ44ye6VSw_zj4rWl2bOcSeeR4eioMX_arUoZHKfn3UoH4vyRwQ>
    <xmx:cUIWZ_yrZVa8AUkldFCzsJfe1cd5Nc2a0OCuiG1QFtEG7F98ritGjQ>
    <xmx:cUIWZ-8bdj_XYOSQlNoA7x74ahNJCLwsgTvBq3SNC82i2_K9DM6SIfr3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 08:00:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6808e08a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 11:59:20 +0000 (UTC)
Date: Mon, 21 Oct 2024 14:00:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: "shamimkhanum@yahoo.com" <shamimkhanum@yahoo.com>, git@vger.kernel.org
Subject: Re: Oureachy: Microproject (Modernizing a Test Script in Clar
 Framework)
Message-ID: <ZxZCbGeBubPb43t8@pks.im>
References: <705912536.3510460.1729265181938.ref@mail.yahoo.com>
 <705912536.3510460.1729265181938@mail.yahoo.com>
 <CAPSxiM_4nBcB53+pfvC4YUsVz5wtJYgFEVuWQdCdo=2VWLj=Tw@mail.gmail.com>
 <1075918304.3566148.1729271777281@mail.yahoo.com>
 <CAPSxiM8sXud=J9pQro28=F9UCbf-PR_gmEp=uyp6d6prCHHxzw@mail.gmail.com>
 <1692736727.3717090.1729300501716@mail.yahoo.com>
 <CAPSxiM9=k8NQ1ExkRS49=1A6GwMn+A3wu-dkv+0R=2vOVDGvzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPSxiM9=k8NQ1ExkRS49=1A6GwMn+A3wu-dkv+0R=2vOVDGvzw@mail.gmail.com>

On Sat, Oct 19, 2024 at 03:48:58AM +0000, Usman Akinyemi wrote:
> On Sat, Oct 19, 2024 at 1:15 AM shamimkhanum@yahoo.com
> <shamimkhanum@yahoo.com> wrote:
> >
> > Can you please share me little bit method how I can search previous micro project? I search it show me multiple folder. And you also tell me I choose this topic " Modernizing a Test Script in Clar Framework" can someone else work on it or not? Please verified this and guide me. And mentor show me ideas link for micro project we choose those idea or new idea?
> > Pleasure for me if you guide me.
> Hi Shamim,
> 
> This is a link to some microproject as shared by Patrick -
> https://git.github.io/SoC-2024-Microprojects/.
> If you want to search what other people have been working on, you have
> to go to the mailing list (https://public-inbox.org/git/)and filter it
> by outreachy. The results which contain the PATCH tag are the
> microproject that has been worked on by the other contributor. As I
> understand, no one is yet working on the topic, since it is what is
> supposed to be worked on during the internship.

Thanks for answering their questions, Usman!

Shamim, please let me know in case you have more questions. I'd also
strongly recommend to use reply to all recipients of the mail so that
you don't lose the Git mailing list as recipient :)

Patrick
