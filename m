Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A472018A920
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 10:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926268; cv=none; b=bO4BVl41AZiUPXzZPpx/Fz3gnMe5XtVSVt1pkhqknvr4woS+gkZ5cWMzGUE6z3b9kCOP7nVWl74a0xnlyphSR71c4Xwg0lCcEuL1tB2XXX9AQwc+izwIvJrjIUc+dZlx582sRd51iG4joz5JfXNZey5ak7mOYoKHOHpidSWxlhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926268; c=relaxed/simple;
	bh=al+jqDHS7LeQEyBjaVBkw9dEhfNZwpt9RH3pkhI8g14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLNxDCA1VfwMGDKSvE/2Fc2mVqJtppCDi1ophaOcwoTMegQuXSJ6zYqS+0MIEh6aysINb8Icc1PdgtW+FLlNme7GJmqGa9vC9ci03KNsk8rUL4XI7cgvq53lfZm+u1QlXML5/7y+vujxjyb4agWwAmNiZOz5fkZVXPc6yng8bHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pxA7rrpr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ckwOrOGm; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pxA7rrpr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ckwOrOGm"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B08AD1151BE5;
	Thu, 29 Aug 2024 06:11:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 29 Aug 2024 06:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724926265; x=1725012665; bh=glj2IMRn3K
	GORhSwiyzkPpRDUXHTew7Lo2rr7PJo4wI=; b=pxA7rrprxIcE+syt7wDbLyN0+4
	DC45fOCXrAimIDiuSqLr0DOuQRIJYvoV1bTOpd/g51JAl88XL1gjUGtcv4UD6CCW
	NPj3HOoxWktcEQEAeyo8A+lzb4XOTipJaHzXWJ1cmW1VaEsQDmSBT2qGJnfjLe9m
	4m2RV290YDxPcSxubapF6cV/47bohxq6EovJNCfS6tTXNQT89+RB+7n378cTsOvv
	724+NcuaRqMUk1CtJ1ydmfuz8cPfaQbV3DNzEAdxUPsOIEmliEyxAQ20OFmLj3TT
	xiL3QzDVFr8M0i+M3Ycv3+g5J3JtUxJB/CQUEjn/H5DGB5ratkBD9fvXK+Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724926265; x=1725012665; bh=glj2IMRn3KGORhSwiyzkPpRDUXHT
	ew7Lo2rr7PJo4wI=; b=ckwOrOGmBty7RKqpryPZYlX/RM6BeRz44gEkEYY1d8F2
	hztYfqkTaR+vUsiYF1o3B6FzEdisqqnoDHAa7sycgjBlvX3d+ceSYqJfa0FD4TCZ
	0fCjLylOQEm1GC4919A0vp0YRBxgPN8SWJeJIloZJZ/+FB+rJvwd6Zo4mlXAqf8i
	W+8i4UczRt/oN0WUp8yWQPo6rpzwPPsSz5QA+khDKsaibe6+gv/uToVKVBm0j01x
	5lSrHAVXSVMEcoA/SP3h+kQNfiZJWnvCimELkIdIrLbhEAy1CV8QgwZhdw0gEiTR
	zcYUapiK8XsxaT8CWV/qVU9FN09qnEFItjYYfitbbA==
X-ME-Sender: <xms:OUnQZqppq11yIKTEcBvmm3lXvR6qQAMZ5_rc6d_JPk1wvPnKwMJeoQ>
    <xme:OUnQZorVmP90lAOz6yGfOc1Ixo9egJIUA-FsSeun-qz7r8KZenmrEt6GueWmKZSFN
    t_MBqgXKZoKaVK77A>
X-ME-Received: <xmr:OUnQZvM_haJaz55gyqugSTJgDje_9M6A65pbPmSxJCSChqrjbf3QItbArPvSomH5bhC5f-gxLDujRrJ0z3Uqv-M8IKe7GPyoIHDrMV2gWB91714>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeekse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:OUnQZp74F93DFeku4Pi7XVnz9NrhpolidoIXhQwCjvbDvEH_Xa7EkQ>
    <xmx:OUnQZp6Tfh4EglV8aDT4rAwUpGLXgrlvp0Pk_84rAAGEgvKYRqpZ2g>
    <xmx:OUnQZphqE0_XniDSkdIZ5Lr0gkvuoKdPyAZbJ_KveaIu-qIjNiOhVg>
    <xmx:OUnQZj6ExqP5_imjE7snbAgLm-RTsRDcRZy_xi5VDdDM2l1ks6-qtA>
    <xmx:OUnQZs0coVz5RmJT2vwMHsNWXhvqwDHOceRFqQh5NEp-TGFp7EoYiFd9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 06:11:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0987a659 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 10:10:55 +0000 (UTC)
Date: Thu, 29 Aug 2024 12:11:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 3/4] ref: add symbolic ref content check for files
 backend
Message-ID: <ZtBJLVou0UnImuIn@tanuki>
References: <Zs348uXMBdCuwF-2@ArchLinux>
 <Zs3558scHssaG_XS@ArchLinux>
 <Zs8dAc0ss9KbwIDs@tanuki>
 <xmqqbk1c3baj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbk1c3baj.fsf@gitster.g>

On Wed, Aug 28, 2024 at 08:41:08AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Also, I think we don't typically call the value of a symbolic ref
> > "pointee", but "target". Searching for "pointee" in our codebase only
> > gives a single hit, and that one is not related to symbolic refs.
> 
> Yesterday while I was studying for reviewing this series, I saw some
> existing code that call them "referent".  There may also be "target".

Ah, true, I totally forgot about "referent". I guess we use both, but it
would of course be great if we only had a single term to refer them.
Referent seems to be used more widely, at least in the refs subsystem.

> >> +	if (!newline_pos || *(newline_pos + 1)) {
> >> +		ret = fsck_report_ref(o, report,
> >> +				      FSCK_MSG_REF_MISSING_NEWLINE,
> >> +				      "missing newline");
> >> +	}
> >
> > The second condition `*(newline_pos + 1)` checks whether there is any
> > data after the newline, doesn't it? That indicates a different kind of
> > error than "missing newline", namely that there is trailing garbage. I
> > guess we'd want to report a separate info-level message for this.
> >
> > Also, shouldn't we use `strchr` instead of `strrchr()`? Otherwise, we're
> > only checking for trailing garbage after the _last_ newline, not after
> > the first one.
> 
> None of the above.  It should strbuf_rtrim() and if we removed
> anything but just a single terminating LF, we are looking at
> something we wouldn't ahve written.  The next check_refname_format()
> call would then find "trailing garbage".

Fair.

>  - "refs/heads/master \n " gets rtrimmed to "refs/heads/master",
>    which is "valid but curious".

Okay. This _may_ be something to generate an info message for, mostly in
the same spirit as we want to do it for direct refs.

>  - "refs/heads/main trash\n " becomes "refs/heads/main trash",
>    which is outright bad.

Yeah, this one should be an error indeed.

Patrick
