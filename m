Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6858347CC
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 11:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395562; cv=none; b=sSCFhXiKeqkJQrxFVyOMvjUytkO1JgokX96lQvIgpHZ8ALo8PL6wIMtBgtgvNs8NbzHCMF6pZLZJvneaD7/gnfj8Qu8RKmfumVEbBB1sMHhvMt0bPXIIA4zWbxZ95tsVVJWX80OJDuyI9wJxjVZTWWrqMdWSXon3b3uhEf7pTP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395562; c=relaxed/simple;
	bh=vBJM0ZhE60NhOLgpqAb9hAR3u8F5+5NqT5R5oReoF6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbfO0WykGI8ATalhxPCdM8vpDtiFflUKW1i91MLqk5qwz1ooW6YLlM30iPZ5nrDKSOpTPX+oYnMuHQgkUTv4DY9M6yXFnuO1rOHekMIGNGiL4X5HNBA1uGVGNGIuUgk+ZYS2phsJmsOOqJI2F62IjWeEsg4o8Qo3HfXZzm2xWwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o5sWX+zy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hGVIwpcK; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o5sWX+zy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hGVIwpcK"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EBA8925400E3;
	Mon, 24 Feb 2025 06:12:38 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 24 Feb 2025 06:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740395558; x=1740481958; bh=lh27DCKHp2
	rwJ/JU+xYKhKhSsYhn7kb5aBgpDvv1GCI=; b=o5sWX+zyli2CcOx9JJcOlE9K4k
	ksR5WrzAVyLPTjwlMxCoumUpoRyU7D89K5jia3KIC0dLMR7WNqdfLIBe95XNqyNB
	mHkCclKZvzk7qV+d9vpaN5K3c5poc0umFojozfcdxWovLHkldp2LjeTa8pvbQ95o
	Oomz/exOCFR2tJOw5EKM9dRBQCdMVV/HDoYUhOr2eSJ1UH07zZhsdylarfZiKSLe
	qpPvcQVqeZnFbGkZQeQnnKf1Fm4fL9Nl3UPIDeAgKZkEvOglozfD3egAH7/hEdPE
	jbPiIsDcWyLeZ/gighVa0k3VV3YwTXVOhPn4aJmMgfb/SxUVYVEcAQt8sDcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740395558; x=1740481958; bh=lh27DCKHp2rwJ/JU+xYKhKhSsYhn7kb5aBg
	pDvv1GCI=; b=hGVIwpcKFyFPEr8qsUgocOsop4aJaWbqPNyCByLZq0HWgrxzh0U
	2kJexkuPRarB/GGJux6vycuq4QRoYyZFi6ji1z7cbA8QEOfrJHYkOG/d7HU747AC
	06CjFVDGD+p1ZcLxAJV/z4bfIZZIYOGF2TREhtVZFYLoAx1qtQ9gjY7j4dgbfqTR
	a2b8vzgyqtK4yvw/6q7FkSwJKQeyomh3HrfWwW9rKMeivqNenPAtFfe3FNGeC6i7
	iXtOmZx1cssZ0ELAKxunpB8A3sXKg81Kc1oiDclh5dFgWrmMSwcxUDieSyM/Nn2H
	YwhKpeal9LlimPU3/gMAnxWLfjUTTZHfy4A==
X-ME-Sender: <xms:JlS8Z-PLNpHZPHLttuONY0JszneM6ydURGvUiC5VQ-rvkv_A7kceQA>
    <xme:JlS8Z8_dvCasAieH9c3vOngGe0lX_rAxUHNvwRgsyyY-Upw5C45ym9X0fj8ViUed4
    GOD1uu2s_VFCHppAw>
X-ME-Received: <xmr:JlS8Z1TD5iF8JDC1e5siD8reqBe4uAf9bFqLDWsSzTa8YHROmX49g0McdtDkTXW5INwJlRCksrBI83pmFqGfcTkfgoxSic0Fr-5dNwKoGDSAyP0L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpefhiefgvdffvddtuefhlefgleehgfefveeuteffudfg
    heetgfevlefhueeuveeuvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopegvlhhirghhrdhkrghgrghnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhm
    gidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JlS8Z-sOEvFdN-wNMjGCsErE9HaCDg_xi9vWF6lF78pSduD4ibz00w>
    <xmx:JlS8Z2dA_6ThyOUMLXjKoaFDuYy4Ftt9Rg0r2CKk_KRZ9A7sZ73vNA>
    <xmx:JlS8Zy2SZcYI4Klbli2re-AMz5I60Ae0W1EwWidH_6ScfeNDpDS9RQ>
    <xmx:JlS8Z688rfSt69kXHFNazEwhQh-RAkR8pjpkAcWhJJwzWxstHwIdIA>
    <xmx:JlS8ZzE8k3WxZRZ2YdYqO1gP-5L8jTinTek8TVbvrVLAS7zAY1Qnq5f7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 06:12:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9f24165d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Feb 2025 11:12:35 +0000 (UTC)
Date: Mon, 24 Feb 2025 12:12:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Eliah Kagan <eliah.kagan@gmail.com>
Subject: Re: [PATCH] compat/mingw: rename the symlink, not the target
Message-ID: <Z7xUIjRVmmYbwRpF@pks.im>
References: <pull.1864.git.1740139296483.gitgitgadget@gmail.com>
 <xmqqtt8n9mt4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtt8n9mt4.fsf@gitster.g>

On Fri, Feb 21, 2025 at 10:26:15AM -0800, Junio C Hamano wrote:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> >     This contribution just came in as a Git for Windows Pull Request.
> >     
> >     Granted, I have not yet managed to find time to upstream support for
> >     symbolic links (it is in the pipeline:
> >     https://github.com/dscho/git/tree/support-symlinks-on-windows), but this
> >     patch still should be in upstream Git because there are other ways to
> >     create symbolic links than by using Git.
> 
> Thanks, let me mark it for 'next' immediately.

The Windows API continues to be quite esoteric to me, so thanks for
plugging the gaps in my knowledge and fixing this edge case.

Patrick
