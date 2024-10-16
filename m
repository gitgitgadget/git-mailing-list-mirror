Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCD51862AE
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067234; cv=none; b=no2+xeKXKurMZoFIL9bK2L4oguNiplqZO5Sg13lJHN1zyIRXIo2QBkyLp0DErsSaYyiICkhPgebPqIp58i/hTZACkn3kxqfNQbPzEvPK3OyPW6qL94C2fRbrIjhUsEOdp4qt2F8GdMqKVQF27jSnmwJs+88/c6f4v9qYZ+9P3CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067234; c=relaxed/simple;
	bh=9/+OUuUs26/we6yxsoocdKqKNq3tFgvo+W/fUmoYsKI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=s2tDJXlyTtIahmzxP2FYKhG6hViYt2Yg+9+sOiE/u8ivA5ep0ufQXnxX7safv38TDAGEp48ejLW8BT8nh+fWSTyMjGHX8LbVCxRiFE2ldCODB4lLFOxO5ySVPIYWH0DswukcMWUNQB1YocBNL5p3Eczw6O/GrD3DYm4VCJMxJfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=dD1V582X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QYce9mOI; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="dD1V582X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QYce9mOI"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D3A3E13801DB;
	Wed, 16 Oct 2024 04:27:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 16 Oct 2024 04:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729067230;
	 x=1729153630; bh=9/+OUuUs26/we6yxsoocdKqKNq3tFgvo+W/fUmoYsKI=; b=
	dD1V582XVPSxYZ1APLCzf5yFBGvBqEpHrlQaCfWVSWSkt6C3b7PtWq230H49b1xA
	39HYhuLi+0MydHyDKQz0HoYQU9Wl1raLwZav0k/BYuuGGlKBzDvKOy9bSEYIY1sI
	CZNjR6QSSP0WiiwxxqYM+PyOxT9sMPg9fMO1ditySFuv0qBn9nYalmPYDLz+I/U/
	8O/WSQVW0eIYwbNFodhjCjndQoT6UFSlx/5EAeOg1T2j604+qKJ0YdOJGteAG0jZ
	lFFaR/HleyT8ZEX4Au6SIH8/mSRa48+UI8zgbVEEZOPtIsCmoWdJvhtduatkkaJH
	Wl/FqP5FUadqbMXVfkFxZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729067230; x=
	1729153630; bh=9/+OUuUs26/we6yxsoocdKqKNq3tFgvo+W/fUmoYsKI=; b=Q
	Yce9mOIA1+KBcRG+wEJScfBhuD235983hx4b7O+LwHqTNc/bDUkZjb+Jj+wUePcD
	chp0+y6A+JNoI4jmDptkQijCy95dn8WK1STpGQGYPO2c8SGz8pOoxhoiJv91AaFv
	A1ZRJ7dAPpqPWXJXG7b2EePsnKM946a4t3di9fen+Uctm47MSc2gnqja+PNiazx3
	OhV/0naFJWZnGrNqa8FzlqPKeyHzD8DLd/szKR9RfR4s+rnAYempgAVWntYW+0QK
	zMO62yaDABJuDks/F5BvXex3DbGg8T/0t8RW2ukT8jhMQJYr50wRORXpBtMIS0sF
	pb0Q5WSLl/uzQgc/+SNvw==
X-ME-Sender: <xms:3ngPZwfQ-FF1oNt4M-dly60ebIsgCgSu3O_t5RmGGmBnEDrRBty2xA>
    <xme:3ngPZyP5QJICnNBzIFQFR-pITczagh_zPV0zR_wg77eqb2h2VCurFqLDtYsWc6G1t
    e5pJ0sKAUibMJy1Iw>
X-ME-Received: <xmr:3ngPZxjeI6N9CGRNdQBJWbXlhns8Bf_USpgAqW7VEEP3TtYt0jiHzFS-CDb7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepggfgtgffkffhvfevuffofhgjsehtqhertdertdej
    necuhfhrohhmpedflfgrmhgvshcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurd
    hioheqnecuggftrfgrthhtvghrnhepfeefgfduveegfeduveevveekieffhfetffeukeff
    fffhgeelueekieffhedtveffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdpnhgspghrtghpthht
    ohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvsh
    hlihhurdhiohdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:3ngPZ1-M0oKTdfHv2g_UM5FzFZtgeyIau8DG7YvGUAenmDL4DldnMw>
    <xmx:3ngPZ8vimuMMDA5a7HPiQ71X9cV-Uc3Sufik1WwDGb2_x5Gh2p_5LQ>
    <xmx:3ngPZ8GOv67mRNmES7HZLPG9J9wqyXj5twc1dqj-rzMouKnMyumUFA>
    <xmx:3ngPZ7O_Wuz7E-pPCH6lkRxx9-FF4zrpqeQhEyImcsMz9n3LvtUduQ>
    <xmx:3ngPZ2V_uZL-qD5u5G5ZjYARM5ms7Z8m78OXofb0WbNjBZMqyPD6_AMz>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 04:27:08 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Oct 2024 19:27:06 +1100
Message-Id: <D4X36E9VX8YW.EGVWW94QFFCU@jamesliu.io>
From: "James Liu" <james@jamesliu.io>
To: "James Liu" <james@jamesliu.io>, "Patrick Steinhardt" <ps@pks.im>,
 <git@vger.kernel.org>
Cc: "Taylor Blau" <me@ttaylorr.com>, "Eric Sunshine"
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 08/10] t7300: work around platform-specific behaviour
 with long paths on MinGW
X-Mailer: aerc 0.18.2
References: <cover.1728906490.git.ps@pks.im>
 <cover.1728992306.git.ps@pks.im>
 <13c06a8129b13a672d3b8329db83db103607787b.1728992306.git.ps@pks.im>
 <D4X0SYYSUPWO.CFCUEN5B3MOQ@jamesliu.io>
In-Reply-To: <D4X0SYYSUPWO.CFCUEN5B3MOQ@jamesliu.io>

On Wed Oct 16, 2024 at 5:35 PM AEDT, James Liu wrote:
> On Tue Oct 15, 2024 at 10:45 PM AEDT, Patrick Steinhardt wrote:
> > Windows by default has a restriction in place to only allow paths up to
> > 260 characters. This restriction can nowadays be lifted by setting a
> > registry key, but is still active by default.
> >
> > In t7300 we have one test that exercises the behaviour of git-clean(1)
> > with such long paths. Interestingly enough, this test fails on my syste=
m
> > that uses Windows 10 with mingw-w64 installed via MSYS2: instead of
> > observing ENAMETOOLONG, we observe ENOENT. This behaviour is consistent
> > across multiple different environments I have tried.
> >
> > I cannot say why exactly we observe a different error here, but I would
> > not be surprised if this was either dependent on the Windows version,
> > the version of MinGW, the current working directory of Git or any kind
> > of combination of these.
>
> That's very strange. I'll try it on my Windows 11 23H2 system to see if
> I can observe the same behaviour.

Hmm maybe not. MSYS2 on ARM64 isn't fully baked, and I don't have an x86
Windows machine handy.

