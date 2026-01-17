Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286B31DE894
	for <git@vger.kernel.org>; Sat, 17 Jan 2026 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768676560; cv=none; b=X0L4ii5LdpLUgJ1PVOsMx3K+PUprLG05MOevirUKT2BGsKkSoBUDYq1+nkDpsXLr4cUndzTz77Ih1o6/yAxKqC5SnvR2nvHzvHSpokIGxZ4amUuLT5NYAQHTmEtVoPmLzZ8hPvEJNaDsNt/Pe6i8Q5Spf+1PKl3KxYz2jwx43dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768676560; c=relaxed/simple;
	bh=dUg/EHEU0ZPS2UpqX0DmQhtfqXy0edCoFKNRDhu4cjw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VG1Q7B/CIyXx2ioK8mGup+a3q82DbGi5Kd+OUxe31V4688+BRNjIldmDctg8x/R2zVLjxGlp3u/AyKpp2Jp86gavY0WLnJ3Zq0UpoT4k5580WjHMnyPaey37eXWhpsxxt/3lFVRWCBB+Y5KvsrU2Hcr2J5oV/FbTZJhrIHFPgkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HrXFvWw8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LgGAFapZ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HrXFvWw8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LgGAFapZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 47B7C7A02E8;
	Sat, 17 Jan 2026 14:02:37 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sat, 17 Jan 2026 14:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768676557;
	 x=1768762957; bh=UyqfisZXwc2yhrpyp9QcD6y8T3yxVKVwxTpo0Z9M0ag=; b=
	HrXFvWw8E+FhEN/QDhTcrCqw6GiGyum42VskqnFRhvsuCj1AC1j5kFRKib/qgMMz
	YtrvB9rF1tl8TktJmajnjWgEL/+PCMOOKgjEBgTfUAPhZoBwjXr7d2eeR+owozaT
	Vax51ODOt9ytQdF+Kko5EBzn753XuXW34YqKjFBHyerqMSC0iqCh+VeptgLXSjeo
	+qb0O+yT4YKX9/3DdiBucwetQw8sk3qQk43YIIxHYAjb3G/Fb7j90xUczfskpm81
	Oy2WDH5Wgijp3/kt3tc0fVKn7qTylOXa0hERfr29cIJJFpYtCDfJIUxyM5EL9kSK
	RfSu7jYH71iw9O7Xzqd4kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768676557; x=
	1768762957; bh=UyqfisZXwc2yhrpyp9QcD6y8T3yxVKVwxTpo0Z9M0ag=; b=L
	gGAFapZWVa/7VwrOjjVGuCVxmMPnb2lkE1DbFk+1PAYS71rUBkX8MVM5a5mJM15F
	SoQHoG1jq0SEf+ybD8C06dfgNp1gGU4SZsuyZ6/KYbuJcfSCsh3nWAXvTQRFbQ8H
	2eHIlt9Rh39UqixXbVWeke0tVy9JhKysZKMertOQZkn3eEX9uxpTM27xOHgFb1Xs
	+0TMb6Byif/DmnIyth5B/vtzokx8rWjH7nViiSGMcARDz5LkxsuRIxp6KcTzjABr
	76NSIrGE1l24YS3JVNOcZfrpysOJgq5AWTjYNb+VoWyglz+vHRnuPmwD8V932Nly
	UPH4OW6HOrdW6XcNGRIGQ==
X-ME-Sender: <xms:zdxraXhzQOWkmwD_wl6wYrLk7b-D76c2soiYI4-WsGWBxSgSxZvteeo>
    <xme:zdxrae3NXeL9pCz4eGLZ90r9LeBS-ur-tw2XwJB9uIMWYvmcLEKuRtKaJGSbovQSA
    zRDKQyFHUK3ezlHIUVWPuy6ZaLQ1nBgzuyGtx4hV-WGjJfPNul8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufedviedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidr
    uggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:zdxraYkEJck2qmE0QfzVWQlXj1ujm8ZtZ6QXe3lzOGCds57wrAfMbg>
    <xmx:zdxraZUuw2gxjz5R1iF4MwQo72GP53HCZWS6EoLlqnTy4K7mts9Gzw>
    <xmx:zdxraWtwZlPLC5jmhhQruN4FvMBS1DytpB5eJBcMAIgaVXhyNfJ9Lw>
    <xmx:zdxraUZZPvyownVRzrvb11GYJoiHwa1t3x2TylbFW-W2WV1mPEhv6g>
    <xmx:zdxraQGk6ZB6-aQaL7_auVqqU69VSH0n6VbudFRCgjRoFLVGPveczLO2>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F2BF21EA006B; Sat, 17 Jan 2026 14:02:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aaz6eaLiGO4o
Date: Sat, 17 Jan 2026 20:02:16 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>
Cc: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Johannes Schindelin" <johannes.schindelin@gmx.de>
Message-Id: <de592bff-d7ac-41b5-bb24-4ced285a52e0@app.fastmail.com>
In-Reply-To: <xmqqa4yc5brq.fsf@gitster.g>
References: <pull.2031.git.1768584676520.gitgitgadget@gmail.com>
 <b649f137-7140-4fb6-848a-b3408e54bbe5@gmail.com> <xmqqa4yc5brq.fsf@gitster.g>
Subject: Re: [PATCH] ci(*-leaks): skip the git-svn tests to save time
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Jan 17, 2026, at 19:34, Junio C Hamano wrote:
>>[snip]
> Yup, I generally like this direction, and introducing NO_P4_TESTS
> and NO_CVS_TESTS would not be so bad.  Here is how it looks on top
> of Dscho's patch.
>
> --- >8 ---
> Subject: [PATCH] ci: skip CVS and P4 tests in leaks job, too
>
> Looking at the CI logs, the p4 and cvs tests account for another 24
> minutes of test time and they offer minimal value for quite a
> similar reason as the previous step.
>
> Let's introduce and use a mechanism to skip these tests to save
> some resources.
>
> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>

Nitpick: Using the commit ident

    Phillip Wood <phillip.wood@dunelm.org.uk>

might be slightly better?

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>[snip]
