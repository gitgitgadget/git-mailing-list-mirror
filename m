Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E512571B0
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771920200; cv=none; b=etuZMyXdQW2s3lNXTPyrVuyMn3L73TPk4XSGRn4MhP9TdCh/nCggwqHnnYuMFqPiTIl7+BWMEZF1EybTHjnfteqA5QB0VlNoli0RSnbLC7CHenPN066Mc1n7grjWuUJZ+omwVRRsmvk9rJ72hi89IgP3L2LeTOeaS/Vou3esbDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771920200; c=relaxed/simple;
	bh=lhUQJdp/hfiFfk6K7tkz/cAej7yvgWnsZOHtnW8pBqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twOnFF2j3vzUVm+GwZHaJ8Z81zF4IYxshEOlXVOBJiLMRwJbmA9xoUscWwsMgbBqyIWDQpIjJSR5mGZm3bEta77/y45rI0p0En980gYUBKUfNXwbDrXVJwOE7Q1EAQ9arfW5VwANFAdPntg1wp7jXuUUPJH2DqW/JD7LNSm/qPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W/Aboh0R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D+IIaIYD; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W/Aboh0R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D+IIaIYD"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 4F5D4EC0598;
	Tue, 24 Feb 2026 03:03:18 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 24 Feb 2026 03:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771920198;
	 x=1772006598; bh=xlW/MnO/SAwH+dUejE5WHL0NYkFgvUfhEVDP7cj+6jw=; b=
	W/Aboh0R0XkChSYqNd2tzw+pa/so99UjfhzbsTN6oJ3gJi9DhlfeUnUbGONMWMRB
	nz5V9lRf8zyJgCqz6xAEUguqyAx6ieva/wmsnqUtty/X7WroJ8UlMNSN9qAVtEQE
	WRa78RVrgej1iyOOl0F5/ADmwpun9H/39E9D8MBR6US+CTY7B6Tbs446d/1B0ZAo
	JxX0SDiOkO01I2BdWJHYWG/bue2bUiMllY/ig9mNo/O3FBVnUh7zlG1W80MrKhbe
	lr3jcKmBqdUnnjdFwyjjJNLjZO0pzf7A+q6OaQDCsc+Vx8xCd8YkSlwTLCIUiL+V
	JMOW0mn0ZwW2148ZWOryog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771920198; x=
	1772006598; bh=xlW/MnO/SAwH+dUejE5WHL0NYkFgvUfhEVDP7cj+6jw=; b=D
	+IIaIYDhghbZXYTSJHM/SyZP6/ORRTun1l+lyN24gZ6ItdDOTU/5JGvGLSN9o8kA
	YVEX1eO14dUgLli+xEMEp/p+v31qzM1jq3v0nkJ1cgQ9cmRNTwYa479yneEChgq6
	KRWiSszM2EaM6VnME2IbWyupQ2WPrKB4dSawTdLEy6/A6Ll7Hvb/fOOQC/cPm481
	SyUQcJWu7AX+8nPb77iKcXsdP7L1L7uqEPkQdN49RLs1iuz7ybQDbKYXWkldVOgF
	cPfByo44+Vf+NAmxq2N/wsFhGz86d6xJAS3YJwnOCPCricxMA4i1MR9+cS41jlmE
	afk/f1W9kU/fVUYZpEXVg==
X-ME-Sender: <xms:RVudadlsWsuoC5A3k2bISDDD5sXhepKkYXThO_1sO1iuUDLOug63rA>
    <xme:RVudafs0hHRzVROA1IDDHtD52vbBy6DI7dan0u4fZr9i15pylaXVtv6GN2pespxfm
    -r7cB5R3vyHl7pjfuAZKCShnf11jjjW2nbjiZTV2D1zf4d-9NJibB8>
X-ME-Received: <xmr:RVudab-jWogjOil4rQrzBt-oHfMWhVeMjGkybAUkBDYIb4bl2b3zURErNpVWt7u9s2wa3LDUto03vfGTtOauz4atgo68iDbrvGc73HEo4avAsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeelieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefheffgeeflefgieduleehueeugfeifeevjeejveelheetvdegjefgkeeguefgtden
    ucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhhuhgssehprghulhhish
    grghgvvghkrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgruhhlsehp
    rghulhhtrghrjhgrnhdrtghomh
X-ME-Proxy: <xmx:RludaZN8apmACb8ZQcqeYp4xw6Wrx5RJ_pqedB5LVj2g7ZZN7laiBA>
    <xmx:RludaZHZ3IR3u02Ur-clpxxQdgXfulyj4jIjZC-RZJiFxlSrNJD8Og>
    <xmx:RludaXRCKVHdMGYsrKN5eNYufJAW6AVQrA6V8j_dGhWwRcTZOpwQBg>
    <xmx:RludaWvLbtGJzbpMuHC3qAhew97wibQ2AKwVGxAAgpuPw1A2msjJVQ>
    <xmx:RludaSrZSetkS0dpCA5kCl0kw-o5Bj7_imG5vpZ8M0v38d5XmmNx6Xtg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 03:03:16 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 99a3a5fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Feb 2026 08:03:15 +0000 (UTC)
Date: Tue, 24 Feb 2026 09:03:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Paul Tarjan <paul@paultarjan.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Tarjan <github@paulisageek.com>,
	Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v4] fsmonitor: implement filesystem change listener for
 Linux
Message-ID: <aZ1bOxAW2Y9cssa2@pks.im>
References: <pull.2147.v3.git.git.1767099302592.gitgitgadget@gmail.com>
 <pull.2147.v4.git.git.1767202894884.gitgitgadget@gmail.com>
 <aVuplzNaoCHlZG3S@pks.im>
 <xmqqikbrvz2l.fsf@gitster.g>
 <CALvWuB70kwPAnQ+v4ch1TKMDxbUQgi5NP8NX7tbCZRqivJ=vig@mail.gmail.com>
 <xmqq1piet47r.fsf@gitster.g>
 <aZv02KjfheyFlMfb@pks.im>
 <xmqq342rpiuh.fsf@gitster.g>
 <aZx2WFMtQUB0jIfM@pks.im>
 <CALvWuB5BnCmcoZgdnqdZiczG+DMQTUByHzJPkNH+H7hBEGma_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvWuB5BnCmcoZgdnqdZiczG+DMQTUByHzJPkNH+H7hBEGma_w@mail.gmail.com>

On Mon, Feb 23, 2026 at 06:34:31PM -0700, Paul Tarjan wrote:
> On Mon, Feb 23, 2026 at 5:01 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Mon, Feb 23, 2026 at 07:42:14AM -0800, Junio C Hamano wrote:
> > > Patrick Steinhardt <ps@pks.im> writes:
> > >
> > > > On Sat, Feb 21, 2026 at 09:07:52AM -0800, Junio C Hamano wrote:
> > > >> Paul Tarjan <paul@paultarjan.com> writes:
> > > >>
> > > >> > I'd prefer to take you up on the offer to send the meson support as a
> > > >> > separate patch.
> > > >>
> > > >> This part of your message is one thing we needed from you to unblock
> > > >> ourselves, I guess.
> > > >>
> > > >> Patrick, do you think you can help making this into two-patch
> > > >> series, the original one being the [PATCH 1/2] and update for
> > > >> meson-build in [PATCH 2/2]?
> > > >
> > > > The changes I sent should be sufficient, so I'd propose to just roll
> > > > it into the v5 patch.
> > > > ...
> > > > By the way, I haven't yet done a full review of this patch, I only
> > > > chimed in to help out with Meson. But I can have a deeper look once v5
> > > > was sent out.
> > >
> > > OK, so it is not quite clear to me who is doing the v5.  Is the
> > > "offer to send the meson support as a separate patch" still valid,
> > > or we expect Paul to squash in the earlier patch from you to prepare
> > > the v5?
> >
> > I'd think the latter, Paul squashes my patch into his commit. I don't
> > think it needs to be a separate patch.
> 
> Done. CI still failed in a different way this time:
> https://github.com/git/git/actions/runs/22311198802/job/64543526340?pr=2147

This looks like executing tests got stuck. Makes me wonder whether there
is maybe a race condition in the new fsmonitor implementation that
causes tests to not progress anymore. Let me have a deeper look at the
code.

Patrick
