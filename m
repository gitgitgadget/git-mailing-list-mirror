Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93FD38E5C5
	for <git@vger.kernel.org>; Tue,  5 May 2026 06:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777961379; cv=none; b=ZU24utb+W9IeIze61izJU8IwdnZDhnWFByVNM2JvAt/q7JLuKMBrNQWRhGWwKzYmGWgxlkkEwwdqxS4API/WsxGWsA43PJ/Wworqrz3VLxbWdhjruD66wDWAVwikHPBZS5U89AsSuIYgP1mUG0h5PJ6RDiTUlZksKPpAUSGmhf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777961379; c=relaxed/simple;
	bh=GzSduC9zylCS+Hs0OMaw5NhamOkc1Q06ymk++5OTxQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gF40c8OKdb95+e5djflBXRqqt8xcKL3lN7k2t7GWJm+zHO0WMVGZRUY2WFnR0IdRX6C0u0FDwKmBKqvSSOMqbXBMN3UJ4FRslr2oh3oFWx/K8VESRA7seEFD0pbhconmRXYZ4E5J6nPoe45KoI+vwJER21E/U8wzP8Cq3xb5o4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YRE9h7Jn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W09pU6uE; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YRE9h7Jn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W09pU6uE"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1F36C1D0001C;
	Tue,  5 May 2026 02:09:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 05 May 2026 02:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1777961377; x=1778047777; bh=5db8bloRw1
	HgXl4qBYjAByDR17gMac6W5/dOHkag+Jg=; b=YRE9h7JnaXASEjdxNIy8DfCwdP
	xc/uzXPqopKtFN4UZHn37v/n9PPoeS4Uh6R4BvwGDMjnlEwIhrApaFfe+N2vQik8
	QjwGM/+z5KiAteJhlAEIIFt5nnSUyOqjmHe8s6QRBzHhmLBv9occTCy0Go8KUNSw
	lLs/SczdyA3Yor8sp51vnpodNxiJW7HDx4NFVVQaciPrmIEQ/E9egV1zhhfWeIFQ
	BoVa//oUjDEhMLx0uiLk2o/Gvr43Gne2icXirT9UunhiyYaI9yKKkRSj+0jr0vCL
	wmFiR6x3ulwPvm5t+s67Miw5vm+6q3R7ivNlb2+jL1qwqn/3jU1zcshBhOEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777961377; x=1778047777; bh=5db8bloRw1HgXl4qBYjAByDR17gMac6W5/d
	OHkag+Jg=; b=W09pU6uEfTf+dAfXprBQ8OkC8uTmPFi7vPAtDItC0qwOI7QpBER
	13kyBVrm3Qlw/ODP4Rs+q2rExoF2GcwIt4DsXZr3oJVemjYBBAhu2v5P3+yFC9T+
	GF+gMzCgCzKnC5Zb0XCO9rKmxwcL8JFwqYCseKIHpZykaASQnaxi4fXgNWhCPnmi
	NyyDvoedp/9V6UZ8qvrHh22WWyskX/ifgLbQeiRgY33xh7WrRfg7zLR2l1f923hA
	zcEGnCYQZmM/+JZy1+E3RO8vCcnCYkwqdS33Yw/8pjkP0XrTs18VnQJtNVmVSD/6
	ApGBAkXcvdAZGedMCdamr1/HrEXEmN6Evdw==
X-ME-Sender: <xms:oYn5acHrJ94O3Bp1-_RTomhkrgWbj0qxA61evHlVsvgJsDBIa3mtqw>
    <xme:oYn5acy-jNoIeG_dec9kOVLIKVkcMqgLyWl0DFDZyUXGYXtUUGWKp8k-R7pn9SzQO
    tt4MlshEi4-UTvGu86E7ic_miqB1bLDXyc4Kd7J1QzYYE3I8_bO>
X-ME-Received: <xmr:oYn5aTiN5oEOQGx4nAuJcAaYOhfhbM735SJ2W30gogwBFP7lcByohFtFBJkHnmUuWdA3SHwgJ52Zh_-HNYOqx0zTvszOx3idodN7RX0fsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddtleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnh
    gvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:oYn5aXz0dBpi4l7z3VsH_JvyZAMZHKTKksQJ4VKesuUkRW_NDDwc4g>
    <xmx:oYn5aWL8JKycuNRKPP1_9_HM0m-FdPRDD7nm6OS2ySFg8JSY4ki7xQ>
    <xmx:oYn5aeQCaTdOdXtzkdRbg_H0w_0Bm9kyAra0vn4VohUOkd8-MI47TQ>
    <xmx:oYn5aeocUsBAByj0ySptbBvm1qaPkfaCzSVmf50O1vjMVFpMnyZqew>
    <xmx:oYn5aaSC7n02tSIQUYF9FHBd883Hf9vyEGnR0d4VZrIzipOM0qHuDVa7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 02:09:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 08a44812 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 May 2026 06:09:35 +0000 (UTC)
Date: Tue, 5 May 2026 08:09:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] mingw: stop using nedmalloc
Message-ID: <afmJnZXeWtNEru4q@pks.im>
References: <pull.2104.git.1777811392756.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2104.git.1777811392756.gitgitgadget@gmail.com>

On Sun, May 03, 2026 at 12:29:52PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Rather than patch the unmaintained vendored sources to silence the
> warning, stop opting into nedmalloc altogether on MINGW. The platform
> allocator is what every non-MINGW build already uses, and a fresh
> build of git.git's master against a minimal Git for Windows SDK
> upgraded to GCC 16, with `USE_NED_ALLOCATOR` removed from the MINGW
> section, completes successfully.
> 
> The compat/nedmalloc/ subtree itself is left in place to keep this
> change minimal; nothing in the build links against it any longer, so
> it can be removed in a follow-up if desired.

I guess this is fair as an intermediate step. But seeing that this
removes the last user per our "config.mak.uname" I do wonder whether we
want to maybe drop nedmalloc completely. Not necessarily in this patch,
but maybe in a subsequent step?

Thanks!

Patrick
