Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CE43C1F
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 08:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736755508; cv=none; b=LJ9Ch0j6pbM8vjj6HC8cQimSDxdwITOqMBy5/77UCrJdqlKMz2k1EcgUW+6YYFcakBgB50HpylE7DNnYFVW02Miaqx4KVop7Zu+W0sffXqXPUNb9CgLZLNCjA0bk1sKi426iv6PH061MQJ8RHtFjQwcZcFwP5j83xJ/mDmN5fY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736755508; c=relaxed/simple;
	bh=xnWPffwCPuIHv/SluB8bC4xXtgRqimXECtctcVQDFvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCL1m3dVKLzsT5cKVQd2A+VfReupuBXT5rNTjZT6uXdl38anDg4HivPEGzOwiq+eWPEAGmOEwJ81kttWnOZek29tAr+5pUIypSCbO2MztQ4ZCYht7YD5reVTVMtzajs56DSL3YW2hEcAVEroUiSmktErP/fCpLVZ3Kl5GUXqHks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vB3vHmV0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WbkKgruo; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vB3vHmV0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WbkKgruo"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id BB5C111400F8;
	Mon, 13 Jan 2025 03:05:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 13 Jan 2025 03:05:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736755504;
	 x=1736841904; bh=gFLIpWWMs1m+j23xn4jVR53/xhX3lAsjihyBu6Mmzfc=; b=
	vB3vHmV0uoqYbgA6ddy8Q0D0nnCNkJoRl38z7wI1tGDrmggTGsSz193W+fRkGs/H
	2FO0mFr+bG+12tjanBiP0db/QAiUakz/OjyFT56wZc5A/UC6q8x51ecaGUnNYAM8
	yuXIUUKPgTA6Z4YVT65j6zzwHHk94CekZSmdRV2yyA2VOa4CXUZD7ToGnJqny8KC
	7pSOg9vbf/kEHm4GcbcHaR2L3CBM/lEKbmbz1vks63XHyuJcJkeG8x+pveMxm/lR
	B7lU5kwdetuLbUdktTkthfxpgJzjeDwxKLQusOcjbNdYVp9H16kgYxiUFwritOTV
	ujHtBkxVvngFwarEOFuBnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736755504; x=
	1736841904; bh=gFLIpWWMs1m+j23xn4jVR53/xhX3lAsjihyBu6Mmzfc=; b=W
	bkKgruoEGMklSSJFXl8tY0v7oFt5MIlp//etULeFWZhN2cxhs5T5KGYp8dbjWe0S
	L80tfjpUTe98GmOQANfGsw1OLcAeckj6Wkaa0iZ4iMYDhX6OpH+j/w3awTQ4dsFy
	iJr/bfGPKhlmb5fmSn7/FoPdHNupR40lNCTjo86ZHMJ3IzdNwUv4fGYZDGoDFb7F
	1xcx5c08+/MLi763k2tjurOpK6UtE2/jT8eKLtDDwYdhHbkYpOH7MOl1JLsm4MUS
	19HQny/qhF0Q4bOeoT8JktZhsZaLKgizzXIj7RFSkp+099yps7FJbdG/8Du6RWad
	JoCBSKha4/Nrwmopa/AtA==
X-ME-Sender: <xms:MMmEZ7_4vOFsMcxQwW7cZjna5MN44IvVTgEdSQXqtkmfYlGTzrHZpQ>
    <xme:MMmEZ3uf-x7Us_2HOteW4uedMqFs3n5rz7FkFyAuhVAzsw19OuavOU-GeiXSLIxb5
    U0kX1y-pj5zwHzElg>
X-ME-Received: <xmr:MMmEZ5DBL-ntJm2f7A03I4E7T_62BwfoXY5RIrvR4_sxqNjRp9HNEPuLpqkL7kgHAguarFKr9KG8ViwtBWBN21nSvLgRf5iDGXN_Q4seomCu0xqb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehfedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdev
    teffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepnhhosghoiihosehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MMmEZ3c24MYv4BZaIcn9EA5fYI7Q__UTcYaDY1IhKr3Q5QmUCk3Iyg>
    <xmx:MMmEZwPfXcKrfeH6w3_DuK0X-A8oIQE-UgA61PT4Vl41dlT4q2dQRw>
    <xmx:MMmEZ5lC_8kUP4e7_OGiz-z6igY3fu00MP5eLntcOwoe5nxMZQ1EzA>
    <xmx:MMmEZ6tiLt3I3oHHkPNiApRSpa3kIsq0ad8DsujILR7k3uiFalOgcg>
    <xmx:MMmEZ1oCCiE3lhF8oGcXpXLTGEsjxQMZqBdAWlqYRbRzvDYb8Z7R4SF->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 03:05:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6c2ce5e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jan 2025 08:05:00 +0000 (UTC)
Date: Mon, 13 Jan 2025 09:04:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Jon Forrest <nobozo@gmail.com>, git@vger.kernel.org
Subject: Re: Using Visual Studio Code to Debug/Trace Git?
Message-ID: <Z4TJIzVc4Ib2QyPV@pks.im>
References: <vlrkbd$a0r$1@ciao.gmane.io>
 <A53D82B2-4F5F-4BCA-9C85-88B2A89139DC@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A53D82B2-4F5F-4BCA-9C85-88B2A89139DC@gmail.com>

On Fri, Jan 10, 2025 at 03:38:51PM -0500, Ben Knoble wrote:
> 
> > 
> > Le 10 janv. 2025 à 12:16, Jon Forrest <nobozo@gmail.com> a écrit :
> > 
> > ﻿I'm interested in using Visual Studio Code to help understand
> > how git works. I'm thinking it would make it easy to see what
> > actually happens when git commands are run.
> > 
> > What I don't know is how to integrate git's build system into
> > Visual Studio Code. Has anybody tried this? If not, what tools
> > do you use to debug git?
> 
> AFAIK, it’s make (with some autoconf stuff) and C debuggers like
> gdb/lldb. But maybe someone has a better answer. I’d expect VS Code to
> support this pretty easily.

There are two ways to realize what you want right now:

  - Import the CMake build instructions that we have in
    "contrib/buildsystems". It has existed for a rather long time, but
    is not an officially supported way to build Git. It's also lacking a
    couple of features that you can expect from our Makefile, like
    building docs. It may be good enough though.

  - Generate a Visual Studio solution via Meson by installing Meson and
    then running `meson setup --backend=vs2022 build-msvc`. This has
    only landed in Git v2.48 and is thus really new. As such it is still
    marked experimental, but will become an official way to build Git
    and is more feature complete.

I'm aware of an issue with Visual Studio right now though when using it
with Meson that keeps it from working -- I'll send a patch series later
today to fix that issue, and then it should be a good way to build Git
on Windows via MSVC.

Patrick
