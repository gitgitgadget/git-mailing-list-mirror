Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE2A2DECAA
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 22:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764799575; cv=none; b=t5U5z8s6N6m//JAuCr/hAukD2hCZv9ztVioVCCFuvVKc/2ylRBThTlHj6bUmRX966hqDkQeO7FSwLFu+9nkTYPzPKMuLsTgAN/m4eLuQOE3D2LU5S3ABzH+JMjmDB9kWx8sC789JmGOUZwlEKlF2DibFbdcDey6lPCbBe9UpR3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764799575; c=relaxed/simple;
	bh=CsQhRG8rSUDcj+hjcjQyjypjpAN21cgtROHGavmCNSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mkGGsamOSKtXsa3nkyjprYNXkJle/7R5x5HEe+3ABsEo3wuXUa09KWz+XCkbdoo2pzAM8ILqCHAcY/+BHk01FjaQkW/XuS0pmr7OzRC+j+IcieyHCXHPvJzbHduQSPMyE2d74cqjp0+6QXT85uil4VSDiKd5SdbyjhN/gE80vCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G/gUgUQn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pU5Chiq2; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G/gUgUQn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pU5Chiq2"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5F83814000F5;
	Wed,  3 Dec 2025 17:06:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 03 Dec 2025 17:06:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1764799571;
	 x=1764885971; bh=BAU/UnhBQNJ3HxSvW70q2Ddr3mPwSuNUPcoMwU7NH+c=; b=
	G/gUgUQnP++hCVZkht8yUMdRN66sbNjA4lIoQ7Enz1SI4tcLdVQxwp+Ya7ZQNYOO
	Zw2/bsiFGDt108L0UEl9sp5252ePQE1Gsfv8P5bRtx5eeh+40kxYTX6ANSElM6OH
	k+HkEfM7Kj7sZ6XsanCgtdVFo3btcnHyjrzvT4OrrKfvlmSofy8cCzhwKnQYOoPO
	77A61dv4Ih0EGpJjUnnV/dR0FWlD/jhcSsun3y4QfTg042+gmgPRryn1h9J75ipz
	VpdRb54MU2rT1AIuLFDfQNA+Y1p4FsTfs0J+yNpuMH2ySryXad5FBW8keEpyABbG
	00na1eyyOzgLvVbhmaP4zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764799571; x=
	1764885971; bh=BAU/UnhBQNJ3HxSvW70q2Ddr3mPwSuNUPcoMwU7NH+c=; b=p
	U5Chiq2pKhhH6uqU8I3+KI73NrR1Mnr9PtuAZqy8Pcr1z9plc7sERLt9QpAUc4uy
	Z33G/o2o8iRNcrHuNCKZZLPBNPKIFEqpRsHoE3h1pVjAkAnaVZIvZV7oSSvCmq3v
	ZId3UZe8d1jsGNib5UiyREeAbQ4zmupjgvITTaAT0JfDDtSicZO9GDUOOANXsTtO
	mMtBBa7k17to+z5U2qmghNczkhYZqz2FkZgZZ9vsR7Re777LeqcSWLiSrfvIOUi3
	B8p39tSDMJ5R0/EqBOyoRNopy1o85qgYCXoITT1Czmn+YLB8pgKhVZQnDEnGAVWx
	OFtCY9pMWpVVGKHLYcCFg==
X-ME-Sender: <xms:U7QwaRPizUd7ORqp2XGJ4t36km8fksGCn1I_eeQ1pS0PFOtu5QoFbQ>
    <xme:U7QwabZLHCFRHso1sXd3sJ4fDq6kueHrSA-m0dmLSq-Nr2VQ5PYyFwjE3B6R7Ihcj
    mqGWDkL-fATS_Q5fzHBS90dAUfMTEWEdY-hTRmLZAmUnYpqQtIDzw>
X-ME-Received: <xmr:U7QwadrIV1mZtkfJ5jjkzjXGYzgY2jCsKk7FH8Km_xFcl4M2WEaMgePlNBZltOZUohqeyFKJmiU21dX60A3jJef7_QEr5vGZU_Hz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedt
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:U7QwaXbklgaJYnJqMbL4Sqr2iHlwZUSUp6kaIVYohDOl6959vu1D_w>
    <xmx:U7QwadTFqrrMgo838UUVyLOw_zJvoKE-ypGuNSh7-s-I9P1-uvODVw>
    <xmx:U7QwaW40dCq-PZvKVQrh6LiReDttiTRM9P_kG63pUUgR8RwkxkPG4g>
    <xmx:U7Qwaaww0KHqSXD9eTcyWTUCR7Lgp4ZVGiXXsxOqvNkWH3h-G0WDyQ>
    <xmx:U7QwabjM5TwzgXyZtIb1OEaHt2qpmRKz74aOwF5thzgG6QYBaloL5mAN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 17:06:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: diff: should warn about EOL when --no-index ?
In-Reply-To: <03643900-db0b-48b7-93a7-4d96632af57c@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 03 Dec 2025 17:26:49 +0100")
References: <03643900-db0b-48b7-93a7-4d96632af57c@app.fastmail.com>
Date: Wed, 03 Dec 2025 14:06:09 -0800
Message-ID: <xmqq4iq76x0u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> When using `git diff --no-index` on some CRLF files with my setup 
> and config:
>
>     warning: in the working copy of '<something>.csv', CRLF will be replaced by LF the next time Git touches it
>
> To my mind, I’m saying that I don’t care about the working tree per
> se. In particular, in this case, I’m just using git-diff(1) as a
> difference utility on some non-Git files (this happens to be outside a
> Git repository).

"git diff --no-index" is "we cannot bother to add our diff goodness
to other people's diff (like GNU) and instead we tweak our diff
machinery to work sufficiently well without repository", aka "better
alternative to GNU diff".  So you are correct to notice that it is
wrong to give the specific error/warning message that is only
applicable when the thing were found in a Git controlled working
tree.

But at the same time, the "better alternative" part comes from the
fact that our diff machinery can be tweaked with configuration
variables and attributes (mostly coloring, but diff algos and even
textconv filters may be good things that may want to be usable
outside a repository), so it would unfortunately not be a solution
to stop reading these Git controlled files.

The warning seems to come from check_global_conv_flags_eol() that is
called by crlf_to_git() and environment.c defines
global_conv_flags_eol to ensure everybody calling convert_to_git()
will get the warning when their contents would not round-trip
cleanly across CRLF-to-LF and then back with LF-to-CRLF.  Perhaps we
should disable it in "diff --no-index" but the right way to do so is
unclear.  E.g., if we want the same for "git grep --no-index", it
may be that "disable the warning because 'diff --index' is calling us"
is way too narrow and "disable the warning because we are running outside
a repository" may be a better alternative.  But do we want or not
want the same warning when we run "git diff --no-index" inside a Git
controlled working tree?  I am not sure.


