Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8DB33557D
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 11:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771329297; cv=none; b=h7l8jb8gm2rLoG/DX2/soLkScLk22BC3CrcoOOQK0Mdq13Uy6KGjSrUpwhlceBuhLxibB09oHODfBovZ2s6tlhuVs+I8yu3UUQwyF9k+pmwg+8h91gg9oJBrJZSkfQl13MbXc/jEVPCZf2hkeqEo0OSDEkjPQID7a48UCVV1rj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771329297; c=relaxed/simple;
	bh=QEm/YY1+caA75u97Ri49F2ie2c/noPPt7Njd/x6oGuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HS/e120f0lLL8fa3oHjK4PjI21OBd4ytEBP6PlgD6uRe9S/nB8948teshMdDhw+cYVDAMTMmdNR+l+60zgpAK+lfYO9HlPNpVf0fO9tN3ecgPgBKYg6UvkdxGTlE/4jKcU0N8fOt7nrBKaCep1e3+abl4CqJkE0DkRHVPHiyWGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fsnL3dM4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zo5BQWiQ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fsnL3dM4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zo5BQWiQ"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C7B227A0099;
	Tue, 17 Feb 2026 06:54:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 17 Feb 2026 06:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771329295;
	 x=1771415695; bh=hzHkh3lZty+EY4LA8wHryphleRU2XHuUMfaa8d0yv84=; b=
	fsnL3dM4Q7IwbPAe1eJAvoPr6+Zf6QS3knbTGGiAWT5Zsu8/QHuDwczDfI7zm5mf
	/COK4IsUkFvqSCgT0/f3Dv+vbiG/xp3xGuenIfrjlIz281U4x7/fhFASIsUTZRdn
	O8gI9c5L6oo+d8f7WXK0kl8qpZAjvk//cK5ZMQAqmxfc/iVWkjCFIlSyqYdb5F7T
	eBBGrAtKgd4F4QO43xwccqA16SnYKeOeg2XcUQSR1ZQYOCVr4VU/foCfnuC1x1XT
	xEzBvXZbMzbkvnRJY1IDVct2/HhVgpWcEI0Q1SignxhTv/ObQZuc7W3DNRQlAywQ
	lnr2r4ynuygN2T5FuiR9oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771329295; x=
	1771415695; bh=hzHkh3lZty+EY4LA8wHryphleRU2XHuUMfaa8d0yv84=; b=Z
	o5BQWiQ2/EjK1zgeRJRGOHpxBcNRfKqWv8ojDSbgHySv1MDsbniXmjleA/JTU8hk
	o+/Oy6Xf2e4209z+RIuqs8F5ECl3gIF9YhX0PVrUC7glO7jarAZlMwYfrRC5a1R5
	Rik6oAfmrMoTcMKyElSU00X7HkrJwfJAveaamPVQIoIaBzub6M1Toly0MK/kS3Tp
	oN+9FUJ6cxIuxHW+U1DkL2r4z6978qiEttnsqJRHv+aHUxmm9ltM3e8pW1XpOcpR
	/CQqVSB8D8uKn2jhQxlfwsN1NbFlTqpyOnBVRjy9WXo9cob4Ox3CXcVNoY81j8ls
	de7pYpIN4dgruZB+5x+DA==
X-ME-Sender: <xms:D1eUablsVH4yLe33UXxGlJ6LmEz6A39G5MFcjas-HW4nnmL2uBX55Q>
    <xme:D1eUaSGJqoDXsWjwHp-gjRaroAUZCwWCKGj0YcmkGWJPVF4gdyTgnzXEqeg5DLi2U
    9aFhmnttBYez9hnD3JGmRdllSathwK8YUKZqlrsnQmpSFelanSVvw>
X-ME-Received: <xmr:D1eUabGMBvEukJ4BBEMxu_mtpfvjvOvTLIIu0o3M4lLNJRnWNVqClk3S508x55yzhZDUuH34ZXpu6D4vxjiISn9uxxQF7Edfj8B3APrO4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeegiefhuefhkeetueeijeehheejveetveefvdfhleelhfeigeejtdfgtefhieeiteen
    ucffohhmrghinhephhhtthhpqdhfvghttghhqdguuhhmsgdrshhhnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgs
    pghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhish
    htihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishgt
    ohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:D1eUafNovh376Fi6T574xsPf0Je5VqXtvTZ8SmDUgA3yi6qOpu44Kw>
    <xmx:D1eUaaGC8kCXQqP9_PRmVwRjeGEcRg6hP1k0AcGmRQfAkoyxo_hxGw>
    <xmx:D1eUaWNO3QBvqaX8XoY8dhU33ltKEgmSy8_BRClhO3z-9Lt0exFa7Q>
    <xmx:D1eUab8SGrOHlywWRyEKjJq4ykXAhH1PwkdpgiYj9p-8m_o4WcYKSA>
    <xmx:D1eUaetQuDzpestbAcpnNO_ssPSixIQ5dCA_ofKv6OcqReYQUswFJDhx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 06:54:54 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c1e7c106 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Feb 2026 11:54:54 +0000 (UTC)
Date: Tue, 17 Feb 2026 12:54:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/4] Fix tests with missing iconv(1) executable
Message-ID: <aZRXCvP17Ple4qBB@pks.im>
References: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im>
 <CAP8UFD0zja_P7fOuCtLt46ubit+QTOME2K4+M9N=CQNceevMBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD0zja_P7fOuCtLt46ubit+QTOME2K4+M9N=CQNceevMBQ@mail.gmail.com>

On Mon, Feb 16, 2026 at 09:57:33AM +0100, Christian Couder wrote:
> On Mon, Feb 9, 2026 at 1:42 PM Patrick Steinhardt <ps@pks.im> wrote:
> > In any case, this patch series causes the MSVC jobs to pass again on
> > GitLab CI.
> 
> I think it would be nice if this could talk a bit about the NO_ICONV
> build knob and how it still relates to the ICONV prereq though.
> 
> Before this series, for example, the Makefile says:
> 
>   # Define NO_ICONV if your libc does not properly support iconv.
> 
> while t/test-lib.sh has:
> 
>   test -z "$NO_ICONV" && test_set_prereq ICONV
> 
> Unfortunately the diffstat below:
> 
> >  t/t4041-diff-submodule-option.sh             |  8 +++--
> >  t/t4059-diff-submodule-not-initialized.sh    |  8 +++--
> >  t/t4060-diff-submodule-option-diff-format.sh |  8 +++--
> >  t/t4205-log-pretty-formats.sh                | 50 ++++++++++++++++------------
> >  t/t5550-http-fetch-dumb.sh                   | 20 +++++------
> >  t/t6006-rev-list-format.sh                   | 29 +++++++++++-----
> >  6 files changed, 77 insertions(+), 46 deletions(-)
> 
> shows no change in the Makefile, or any build infrastructure file,
> despite the fact that the series changes the one-to-one relationship
> between the NO_ICONV build knob and the ICONV prereq.
> 
> In the Makefile, for example, I think something like the following
> would be nice:

Agreed, it makes sense to document this. I'll do so in the test lib
though, and also expand how we define the ICONV prerequisite to cover
the new semantics.

Patrick
