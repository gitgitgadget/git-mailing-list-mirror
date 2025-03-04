Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0761F4E38
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081588; cv=none; b=cdmpWn5ws9IqgZKff/P7TLx+KIUP+bUyX4QiomMsv/81tf/yDvwYj4bjdzR6icZcSFGCg2aafPwgPf/P89oCcdQpK7HRky1N4kkJWGrZGzaY5rf17LQexb8jT/brWrKIWLUW7Q4ZSsj2sPqXmU/LMi96nabf57Da/6za5K6qj10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081588; c=relaxed/simple;
	bh=PayyfICO5tUvQO3HM+rw9E1fwowT4WlxNOtG+yZe1WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/OQLrHhmLylnNbbOpSu+T6GEurgco8O8E40xiSA/qfDjvuHZT9lD1FvnXNmXs9yvYNl6rEtXORKRyH/Jn0jn3Of+O6FxcrSM56jQNY6/GuORWIpzcyvavE1CrdP4aDWwEsLTtUgl73VjDG/eMlmYUBDDBT+NXSEUn9h2pzLleU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rew7Gbpe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sg/VXLOQ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rew7Gbpe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sg/VXLOQ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 71C7F13814CE;
	Tue,  4 Mar 2025 04:46:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 04 Mar 2025 04:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741081585; x=1741167985; bh=K/dEk3rZlj
	gALlbzpQIf3Che/L/uVdTCFirrofDiJ9M=; b=Rew7Gbpe8D/Rmm5t9ONWSrMfrT
	VUMdDHmS5mvwW0iql34uVvmaFeifroeAOqWHNj25j8FMrPnvAR0e4heZkI3U0aUN
	RA06o7HeeV9b36zKSleH9Blaq/I+/Wrgk3SkQaSed7utar0AhPfS808bXWbps4iE
	35wePXEMm6I4U9WvbkDkOG0VJZe6mk77HyXEmi7k2O2YDQ0TCdo2cDumudjBhVXj
	mtwZBxjrYcgwE7N0Fp+cup2eHssSuP1UrYALGZ8hu5hvNsYO+PnXTbiaMTGHSQB9
	xj7ZMk4G3C3E43K+NjDPOFEqqsrx0Uyj1KB6YRut1HEkaWB/fddRvbgMxsZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741081585; x=1741167985; bh=K/dEk3rZljgALlbzpQIf3Che/L/uVdTCFir
	rofDiJ9M=; b=Sg/VXLOQ4IeJ4Cqr63IWeBMwLRLO6A0HXmmsuDiE5Buy4/uN0bM
	xobqlr08OuCAg0gZ8Un5yv1LmNo/ugNINNEV2ZHcIbweTPLPAJLenQu/S9IZlmlx
	4GRNkoLEzslOSThCVvuBsLtvQk64BROCd78T0/6y0frXBjOQmjciR+O3FtEOL+TU
	S0pf26utHX+js385iLKy8G25BKE/UJkYY+xs+g1Sm1LEepJ9aSHTT50WIlbH8W0Y
	2WoAOqroZXD2vnripTwbeDgB3oU7x+mmBSrQMA41rRTIfFmPJmvsPZYyX1uSXQCM
	Jwvo3qjmlp7mmgkd5SBixNSXAJP8JC6jlxQ==
X-ME-Sender: <xms:8cvGZ-EftaB_OWE4bfJgqH77-awyc1h_fI1fYXNSZ1L2OWalfXPHKA>
    <xme:8cvGZ_XUJPGSe_WdFKwGgfh6ZPCiPoWkFzda6UkeXjLK-TATWg671lcwf0PjYuBZU
    T-LhOFhIVTY4O-kGg>
X-ME-Received: <xmr:8cvGZ4IiP4MpzAScptY7W5DA9PlpMEf_w_2a_gaevQBkjwgwSLd7VZFajwPtOM6NedqHi6OuojHJsyepZKaPuTCkgYy25sUNm8ZTLi0QcGkMYUo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdu
    gfehtefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghs
    rdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:8cvGZ4HpnWtfTxrMXwMbHsfBH4RKTr3hPzcTnTY93A0-2Hh2V_IBCg>
    <xmx:8cvGZ0UWNg9V1Uaob0LNUpSiXW-sNLC3mXXpWbrqLEBHQfElU9iZsg>
    <xmx:8cvGZ7MVjPD4sb_hFqHeddXoTvkutg4oLXviBZ--mtvVd2UX5YLY-g>
    <xmx:8cvGZ72gxfSjluZ40rxiTFQ3F2-HqWIhGWf8cTFGlx2_ES8PEkyeqQ>
    <xmx:8cvGZ7ReEDk3qxxEMqoOXGlQpl2Qwt7TZiwk3LG1G62-d3K_CH7yK7ol>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 04:46:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 78a68dc5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Mar 2025 09:46:21 +0000 (UTC)
Date: Tue, 4 Mar 2025 10:46:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: ps/reftable-sans-compat-util, was Re: What's cooking in git.git
 (Feb 2025, #09; Fri, 28)
Message-ID: <Z8bL0HUuQqj7LlTp@pks.im>
References: <xmqq7c591sus.fsf@gitster.g>
 <Z8aeLc-xelujEjTE@pks.im>
 <0c808b85-d97c-ecd3-0b1d-fba546a1124b@gmx.de>
 <9cc294f6-03de-d88f-9734-510a23fc8991@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cc294f6-03de-d88f-9734-510a23fc8991@gmx.de>

On Tue, Mar 04, 2025 at 08:40:13AM +0100, Johannes Schindelin wrote:
> On Tue, 4 Mar 2025, Johannes Schindelin wrote:
> > On Tue, 4 Mar 2025, Patrick Steinhardt wrote:
> > > Johannes, did the new version of this patch series make your life any
> > > easier? As far as I can see the conflicts in your "shears/seen" branch
> > > seem to have been fixed, and the failing pipeline seems to be due to
> > > other issues. If so, we would be able to move ahead with this patch
> > > series and the dependent fix for Windows below.
> >
> > Honestly, I cannot say whether it made my life any easier. As you can see
> > from
> > https://github.com/git-for-windows/git/actions/workflows/main.yml?query=branch%3Ashears%2Fseen,
> > the `shears/seen` branch failed to update automatically since I updated it
> > manually last Thursday. According to
> > https://github.com/git/git/activity?ref=seen, there have been 5 updates
> > that were hence missed.
> >
> > I'll try to update the `shears/seen` branch now, but I'll time-box it to
> > half an hour because I really planned on taking care of other issues.
> 
> It seems that there are the usual CMake-related breakages (not related to
> ps/reftable-sans-compat-util, but to the introduction of the
> `CLAR_TEST_OBJS` or at least the `lib-oid` addition to that). I hope that
> the tip commit of `shears/seen` that I just pushed addresses that, but I
> ran out of time to monitor this.
> 
> And there are some pretty bad `exit code 127` problems in the unit tests
> on Windows, see e.g.
> https://github.com/git-for-windows/git/actions/runs/13648196783/job/38151312208#step:5:213
> (but again, I ran out of the allotted time).

Interesting. All of the errors relate to reftable stuff. Curiously,
those errors only seem to happen in the MinGW build, but not with the
Meson-based MSVC build. I can reproduce the issue in MinGW indeed, so
I'll investigate. Thanks for the hint!

Patrick
