Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2CC2913
	for <git@vger.kernel.org>; Sun, 22 Dec 2024 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734878616; cv=none; b=rBsBtDzmMwG0EMG+mFcRnYg/mQtF/KBjLjSGKvK/Keh6iAy4zvF2ZAsMb8moqCa3pOHAZ/UmDXjgaiFrqCrsKWoFCKt8238X8id48n5GWhBNgFdpRbezVLKv1eqvRYz+UYxIhOiPnD1l2jm+9gPR58Kc6dFhpVN+0Q/G+1J4AA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734878616; c=relaxed/simple;
	bh=fsRFkYoZhDiM8imCIUfQOaVBiwsUdcbY9PY4ShVbhpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzleeGsG2UfYtZwe1Ls29s/yFeTd5eYQ8Nm4FJpzS5Pd7Yx7nca0JxeAPih4I5iCKEmvEU5eEFrOHb9c05St5p68TTt7T8E1rrSA/rQPfiW4TDFcfTjEU8/s6aSA9Es8ZUQSHRe8hAbctHSVUR0GI9WSCbyjgsbXsMT5SlXXKK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bNaCuBjq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OyhPmNrP; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bNaCuBjq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OyhPmNrP"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 15F8411400C7;
	Sun, 22 Dec 2024 09:43:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 22 Dec 2024 09:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1734878611; x=1734965011; bh=4Yt1Ad/yTt
	sqjxg3MXyHyw1YoG/QyBD0uEsgIVxFTxQ=; b=bNaCuBjqpH/UXkGIneCIBK45JA
	zPiNC/IvxOtYRy/bWHYhV0iaF+AVleQV9ZMdesYdx/6j19Ew4YU+baggwJhqTycI
	idgbI6LI7PjkLZqJhZl8Lk8JWGPLznVoigU4tUsUyQieJtiANgtJ7PNs+xYZQDq/
	8efPRvGRQnnGBGbJkhF6pN0PMpJC/kPcKaG+Uv8Dl1xbUTAxd2zqHv9Sb+h9GS0K
	mmBolWn91u12gYMklrBFKta5cRe1KeDQK1mgeT3Ys/0So1R8I7mjcj8dV33Z8wv+
	hb766eNp1Qp7od4Z/pYT9hTTtdlo1X1LYGpaMpCiEg3i+2PVeuN9l+1KxFgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1734878611; x=1734965011; bh=4Yt1Ad/yTtsqjxg3MXyHyw1YoG/QyBD0uEs
	gIVxFTxQ=; b=OyhPmNrPd7RfANst4XIPkyl/c1H76sRAIY9oGWHqnrPLeOnZYfv
	qSsyaXH5x0feQBaOYv/SJ3Bek2zBLeNHBTgpiY/XgsNRildYJ+YVxWxe+xasN/K5
	nHWukC2otmvBWc6bdQJrLTy3Xp3QUVZtT+NUQWdJoir6L3zYaQtykJwPK8W4cZSW
	MiQP9EvJexq8EyFI0WZLuWX3WHRkdwOr1dzwNhXmG6GfxL/wRtb9pO4T48coCr1C
	d80LdStr5Gj/7vUtRJzW4L4p0ddqeSxpIdLtJR8gJAWxEnSk78UAl9UGrYMU0ctp
	Io8uxS3rYsVVL4LR/Ihndv5j50HCWbfqPgw==
X-ME-Sender: <xms:kiVoZ4mOyQA-Oh_GYfvYs82BRXKDJ5vMtlSz-6xlRPAXlYbrjJpRew>
    <xme:kiVoZ33iIugxHSVTIrv7Tui1BQ0Rm1sgWWwQgD1YTRGpriKSPny5fzDM4_Of4caZc
    CsvIwXKp1pdd2bzTA>
X-ME-Received: <xmr:kiVoZ2oV81Y6JFHOAMiFTKYBm-Cwvo4AWqfUqKegwh8kuA7G0I1hd7IJe1uzaK1tT_RRmEplwopChJjFDWGvOgXsCZuYbg05Ip2DXjSxJjm04w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtkedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgurhep
    fffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuuf
    htvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepteev
    vdetteegueelveeitdfhgeevhfeufefffeeiudegtdekkeehtddvheeutefgnecuffhomh
    grihhnpehgihhtlhgrsgdrihhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruh
    hkpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kiVoZ0nGWFnppYRTwtgU_qayOnat7anHYDB0sUj9xd8RoVMWXEpqEA>
    <xmx:kiVoZ23HgSJK0lpQmhwm3GAT5EAG6p4RwCQLbhHoVBRvvPHCb1ViVA>
    <xmx:kiVoZ7tz0Cl3atmAWMdiKkHMCKDqDhvGPP0j4SQrTieuMU2XRCIxBw>
    <xmx:kiVoZyXavGKuwQzv-HHoHzY-00IpM5UT3rkjtguOtiXQxr1kZ480xA>
    <xmx:kyVoZ7x1b6BDW3pEm_KVS2yrBVcHvwA975a8xmp1SH5IFUxE7MdxeV6x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Dec 2024 09:43:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 74475847 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 22 Dec 2024 14:41:29 +0000 (UTC)
Date: Sun, 22 Dec 2024 15:41:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Chamber <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [Outreachy] Blog: Introducing myself as an intern working to
 convert unit test to use clar
Message-ID: <Z2glK5uJOX6ARFUa@pks.im>
References: <CAGedMtcSSkmQ2u9yYvKMiWnprWR2VZrbuoT9EX+U6nuxOWiEHw@mail.gmail.com>
 <CAGedMtd9F3tZXC-z-5=csELdPakzFS=QU-e35So3Og_ak0mq3g@mail.gmail.com>
 <Z2e-T0NZzrMwEvmd@pks.im>
 <CAGedMtfDMj5P0T6x3soe3OUhRbpSw_-m1Vcm+rhDat1vvReK9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGedMtfDMj5P0T6x3soe3OUhRbpSw_-m1Vcm+rhDat1vvReK9w@mail.gmail.com>

On Sun, Dec 22, 2024 at 02:22:38PM +0100, Seyi Chamber wrote:
> On Sun, 22 Dec 2024 at 08:23, Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Fri, Dec 20, 2024 at 11:37:23AM +0100, Seyi Chamber wrote:
> > > Hello everyone,
> > >
> > > I just published a new blog post on unit test scripts I've selected
> > > and prioritized for initial conversion to clar. I would love for you
> > > to check it out and share your opinion!
> > >
> > > Find the link here:
> > > https://seyi-kuforiji-902b48.gitlab.io/posts/week-2-prioritizing-test-scripts
> >
> > Thanks for the blog post! The initial selection looks reasonable to me.
> > I was wondering whether it would make sense to evict "t-reftable-tree.c"
> > out of the first batch and then handle all reftable-related tests in a
> > single patch series. But we've got 9 of those, some of which are quite
> > complex, so that patch series would become quite large overall. So I
> > guess it's sensible to distribute the conversion of the reftable tests
> > across different patch series.
> >
> > Patrick
> 
> I suppose I could still make that work if that's your recommendation.
> I could divide the reftable-related tests into two sets and then treat
> them together. What do you think?

I'll leave it up to you, as there is no "right" or "wrong" in this
context.

Patrick
