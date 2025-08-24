Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EA9A55
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756054379; cv=none; b=EyNtez3Ihn0p8F6qada41hiV9X3QKsx/EwTZT+fblYSl8CPSjsfa1gQTK6Q1rKSxLAVj22FMN/uyZIB/rt2/OA/kvP+tRbXae6++0BMu34INw7IBOz0Bl/2zrzdUiRGV40X6/2s0GN6H9z84aeM6nrHZ1TpK15nI2kX9uyPpTCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756054379; c=relaxed/simple;
	bh=Z8nKB7Xh+jvGVs8jacCijEBq8MLqKjVfsCyMsJHqQko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ia2JEdObyt55TaUq0qX3lXFDOVTOUvSYGA/7qYTPlS8a74aJBrPR+JIx1zB7MN9IFYMP0yNPfkFDVxOq0x5qjPUeYQ27p0ukYd6xIXno4QryTM9t3LCKjeiPnNcG6kTEVdFRczJKdOOWE9vur6y1KDlhaWjgogXA3Jy7c+BzeRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q4SkFzw9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XPXjdxB5; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q4SkFzw9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XPXjdxB5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 038D61D00095;
	Sun, 24 Aug 2025 12:52:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 24 Aug 2025 12:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756054376;
	 x=1756140776; bh=CRqQF5CZSTYUnAdsFBzZKtbwktMeByRcpbgKGqFhc6c=; b=
	Q4SkFzw9za6evTzfMObtQXeMN0HzxR4Uc4EiIhnYJWVWdw61+l+v4mhZWK0qdCxB
	PAVMn9V4oS5NCftuSWzh7C5S5KHPYG47QrHTwbLBx82Bgl8MaRSQ0e+T1647cZ7O
	mKJb+4qO5BPNZei6deBVbqbhCqSUmpog17VrbdaOwLOBayHI6Uj04e6430lGTWBA
	Y07IKV3KHlEGtWRK5Jk/V0hx4/ih8T8agHjjpWUIZoL1k+fJ/Y4EH/d1Q4CbpnoI
	OJkJGa3kYty26HYq5rdbq9BvZRiRTMq2/V2qqjDGWiy6pSM7MUTn1TXpEiFZmtFR
	0m/MDglpSxg6mQG0p2nRMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756054376; x=
	1756140776; bh=CRqQF5CZSTYUnAdsFBzZKtbwktMeByRcpbgKGqFhc6c=; b=X
	PXjdxB5yK19vSHH8dSImp3z4phEiSEJTcZM/23cb7zJkAAQXOzUs6a9kh+6EbxM9
	ouhzvCkqTt86GrXfsYRwa/OPp4kIHip2KRoORXitF4EyOgmHnToAKcvbRcGMwcjH
	ytWEVwGRxVSx029oTeh7pnWBt5JC9pAvGZO8W25x6YgKNBg77t81buq/UX672ND+
	+kdHvqcGTsj0sQ08+/RlWE+uOS6RzpEfEhQSblSTo6imvTqEGkrHp6M7a0i6WUb0
	l+QabS7uQr2/OSCETAR/Shuk8VhufcbS5vHp2xA1SYqEGWisFqOstDy6bLVpUjQd
	kEuRdlVEzZf0Dn5fmc2kg==
X-ME-Sender: <xms:aEOraLV3LIlmvJe_-gt4D54n-S4QDwPOthPZSvf4wNCxBw1dqAGXuQ>
    <xme:aEOraNDLmFliA3gZcdFwyD_Vk3T0h4ls5SEYD-LkhWo-5fOtPsZA_oVyY3OfpKBEX
    hzliHz4NBmwItNBDw>
X-ME-Received: <xmr:aEOraG_1gf_vRMzLJfANFp-LcRRltcKNuz_LZ4SO5U9X8DCzrDh6kcoTxk-eWirn_XpbE2xVFu2g6jeBS-koWc3uT9kxEPiQyDlT6fqF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedttdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefheffgeeflefgieduleehueeugfeifeevjeejveelheetvdegjefgkeeguefgtden
    ucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdr
    tghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:aEOraMFNFpkI3Lrj3N_0ssXDGqPgm8o1rtvxwsvwDVHlT__kPlXsoA>
    <xmx:aEOraMNnc1-gG4tGJbqLWvYf56wWY8TrKRYdc3e5vpQMIdShTYLXjg>
    <xmx:aEOraOfyMridHT6mQN2S7hZvkg04B-6jdDbQQD22qlDSphENCEiFGg>
    <xmx:aEOraJsggvj-KGh1JSgQCQvop83_YNMIXbBC8DZ-_r9zrdGsAP2MPQ>
    <xmx:aEOraOE1WETODdFHvdhqRMkQ3wFOPKe6k83UGTSCBkDp4c1SYO0B7c_->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 12:52:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5d3c822a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 24 Aug 2025 16:52:53 +0000 (UTC)
Date: Sun, 24 Aug 2025 18:52:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [-SPAM-] [PATCH v2 00/17] RFC: Accelerate xdiff and begin its
 rustification
Message-ID: <aKtDWW-tXOjlJgSh@pks.im>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
 <2d5ae8f6-69f1-486b-bd38-337f0b54f737@ramsayjones.plus.com>
 <CABPp-BEOVBUa7_sTJybgFsgcwAUMeFFhNJEDVnYp_6TYnqu2rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BEOVBUa7_sTJybgFsgcwAUMeFFhNJEDVnYp_6TYnqu2rg@mail.gmail.com>

On Mon, Aug 18, 2025 at 07:00:16PM -0700, Elijah Newren wrote:
> On Fri, Aug 15, 2025 at 8:10 AM Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
> >
> > On 15/08/2025 02:22, Ezekiel Newren via GitGitGadget wrote:
> > > Changes in this second round of this RFC:
> > >
> > >  * Now builds and passes tests on all platforms (example run:
> > >    https://github.com/ezekielnewren/git/actions/runs/16974821401). Special
> > >    thanks to Johannes Schindelin for patches to things for Windows and
> > >    linux32.
> >
> > Hmm, builds on *all* platforms may be a bit optimistic (it doesn't on
> > cygwin, for instance), so I'm guessing you mean all platforms which
> > have CI defined. Perhaps you could mention the platforms which you
> > have tested on. :)
> 
> Ezekiel says this email didn't show up in his inbox (no idea why), but
> yes what was meant was all platforms where gitgitgadget CI runs.  If
> you follow the github.com link in the text that you quoted, you can
> see all those platforms (various windows flavors, various osx builds,
> musl, sparse, static analysis, etc.).

I do have some patches sitting around for a long while already that
implements CI via MSYS2 in different environments. It works with both
MSYS and MinGW, where I think they are somewhat related to Cygwin? If it
would prove useful I could maybe polish this patch series and send it
upstream.

Patrick
