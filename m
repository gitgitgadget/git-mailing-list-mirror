Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C932E2BE051
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413488; cv=none; b=odGsF9z0L3cNhJoDAGAQSCz6gUO4jNMLBRp7znBpYztBOxxyahtV/TGr2WvRbvCMQix6vdNVc9oiWOuqZmbSWckruct6dvE+7bzOPCjXmON2tnEA5c3Hfe1VfFRgjNcfTet+hQklE4Qe1ip3lPnO/FxBvwL/aS/lsM+pFm8NbQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413488; c=relaxed/simple;
	bh=w88zF8Vr1ztV+QqKPwp/yPPfCvQemLZ8Iy2Amaq+q7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lMjbRdsVnq4MTwIsvt17HGNe6vssLCYuZY3xkQvaKWEx5tKAjolnkqkEBKf7wC0qm0cfshiCZvW+xaHU4ar/Df5+j/bWKLkzqSLSglnrXubY/uUoPwEDvNiEg7xgfuBaoA28P57gYosogJCGMqbImHgeOfBceG+9HLPIZF4Mp7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KdERwn3i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LOtX+qYJ; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KdERwn3i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LOtX+qYJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id BE0441D000F5;
	Thu, 28 Aug 2025 16:38:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 28 Aug 2025 16:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756413485; x=1756499885; bh=yqdq1Z4TIS
	xEcPwtF/042tuL4lI/rZBZNncadANls3s=; b=KdERwn3iyLAZJK/jNvXkkotqBe
	2uJcD23X/vt5Ofdf8uEnOcGQlHOzIcIMMmQeB9FuTOabcLaVj6o809uzPx8LXYW5
	nkQU6R9DCm8fWU7EcVQB3OjlAVPZOljvqb2eS5LO4QhUpGqQQNoSgDLvMIqMIEl4
	fE5Ols6jh58SMWUJcRPFWACOD6ahVezwclygIPP7ssO9WTDNHpiUq4pjoPOVa/lT
	XTvxpaKePAzGS3M18qPKm13/uioZvuoxV19mFBpDsRmCICPrF1OUCMb7e/dMzHea
	4e13S1HxlhaORQrCEdE/TXPFra0dFFgo/LzjQyueXyoaqBtF5iO1TflYdAJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756413485; x=1756499885; bh=yqdq1Z4TISxEcPwtF/042tuL4lI/rZBZNnc
	adANls3s=; b=LOtX+qYJYrh6LqgYs86DswNkHQX/CizNBZCC/BCniFu6msLbdme
	G7VNsGddF93plKEqCegihdjFhqwt4vxJcXHyGjbd9HRZUnt8IIlL2cgDr5uFlPJy
	yubadoI49/ocihBwM2lXXFHswlPlg7kfDquarZe9nFrnooZBO2eQ00UV3+r8xZNa
	NrpjWMx9OCWaIg5UVyu18UYcwrYRur+XtE5/rss1yMInS2M1SFJB6GBwah25XchX
	jzpW+GP57MoKZJgVJvCOWHsEUIy0k9m1DbvW9yC0iC0nzVFofaytuo3ZSjFI2zM6
	SCH3fd7tY1+S++KzWrTEaYAmSYq4PkG13Gw==
X-ME-Sender: <xms:Lb6waEkAasNhl8SHMOfJzEBEHHFWBbUpIdtXktL5Rr1P6jTBW-eRig>
    <xme:Lb6waPVHwqT1XNDeTmVt8ch3b5A75GTHuMTogv5HmLescjWrhuWp7LtXY-olo3BiD
    Rmi-kWmthg2g2SY8g>
X-ME-Received: <xmr:Lb6waJHr2wTkjl3ybo3bHozlkTAsXaiSAjmMiHi2si7UJFzHs9KhkxvH-VeX12q_prYjWMQMUPU4zvdL8kUSpTKzsB6LnvbAU4-Wryo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeduleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Lb6waLdPCcR2UAP34k1ldVWtVohwVx9qqNpYyX12wVIyiA4krUFywg>
    <xmx:Lb6waKK0RQjtEZHbi76e4LytbYXFVLgQl6DkU0Y66mkU2fevubOgJw>
    <xmx:Lb6waAG9iH3dg6ROd3_EgwsQucKkPIgWTa3XsC2LtKerPx2-KO3e1Q>
    <xmx:Lb6waNCgZF8vT0CG5DIryBWeub1DMCkx67py5gLPnnTxPfqo7J2mHQ>
    <xmx:Lb6waO27HG5DbSBbPDigmc6mHCSLMCd7F6Z4YUQULgzPUN86_AM2hXhf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 16:38:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  "Julia Evans"
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 5/5] doc: git-checkout: clarify restoring files section
In-Reply-To: <2efb789d-db2d-4dae-ae81-373bd231c3c6@app.fastmail.com> (Julia
	Evans's message of "Thu, 28 Aug 2025 15:59:44 -0400")
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
	<b641874627b3898831c3965616e936bd4ee310df.1756148933.git.gitgitgadget@gmail.com>
	<CALnO6CDpsgTnC95CzjOL5MuhFNAnYYSQCR-jC_n5JYLEu0BTow@mail.gmail.com>
	<2efb789d-db2d-4dae-ae81-373bd231c3c6@app.fastmail.com>
Date: Thu, 28 Aug 2025 13:38:03 -0700
Message-ID: <xmqq7bynuqqc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> $ git checkout HEAD:Documentation/ git-commit.adoc
>
> to restore `file.txt` into a different directory than it was originally.

It probably is handy when you want to cross a rename boundary to
backport a new thing into an old history (or vice versa).  Something
like

    $ git checkout v1.0.0
    $ git checkout v1.7.1:builtin cat-file.c

perhaps.

> What I would tell a friend is
> "<tree-ish> 99% of the time just means "commit or something
> which resolves to a commit, but Git has made it more general for
> a reason I don't understand", but of course that's not the right
> thing to say in the Git documentation :)

You are describing commit-ish (which allows an annotated or signed
tag that points at a commit).
