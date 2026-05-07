Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F853B3C18
	for <git@vger.kernel.org>; Thu,  7 May 2026 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164253; cv=none; b=TfLVV5eSxo9eCLnCczEKdRvytaGE3+FDcSMOXUUGEZY4N/TrOEj7GlsPrOj/u76KR79O0cc/DeDqPbbegQhS6x4LAqIEXFVIPgvw9dOo4ifGbdCPoEBw4g7qUGJ5jqEjey2Gp5I9pDLeJDDv7Hu3gi6a37VAcGiaPNZf3sav/pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164253; c=relaxed/simple;
	bh=YydKDrraiEm+yYsYgNByta30G/MZ0PtKxa7Q5smjY1A=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SO8/p7Vs1PTOmrS0+J/v+veasGMXWwF7n2BKvdzATey6I2IxPqqXV1MRKhnNSCpH4MvrhLqyx5r+aAWOvBi9tNjiCsKN7VT3SvasnjQSo4qMbW0XY1ETnAt0CBCG4VNSyqk+3WshdcdLrxTD5PCg1v8JFYXwdZ8ck4bF0Q9wKHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LxU7V0pn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o0wgxpAL; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LxU7V0pn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o0wgxpAL"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D4AB71D00022;
	Thu,  7 May 2026 10:30:50 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-06.internal (MEProxy); Thu, 07 May 2026 10:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778164250;
	 x=1778250650; bh=tqbnr4/uovuGtcBTdrPDbPKS3EE92ZscG8vjudoekhE=; b=
	LxU7V0pnKEDhMA8B781993mWeFYq8OB3jVx2/jw9jP3rvWUZ1dkMBpOMwmCTpETC
	/COUKpoynZtX7xmfvjiKAb8K26FNWhOWSco//S+vdN5Lgqkd5UYE9c/Ol3ebNla6
	D7+Vpfzs/oJFBdrSKlGZlXR6h5JTRClRt0O7cO1n4zmiEiWVaYhRZImiU4ROYLsD
	TxxL3f+aOS+K8+B/Xq65rpQ9a40qXkgOc9IpWbg20KDhzVNJHUaFgy8fyRdEmB9x
	S2E9hrg1E1jo7ERMZGkFj7cdfImEHgu5hYinxwCCY0+3Kz/11ISeTxbInPDdaA6O
	9DWXNL3R6GWlKWy3KFPePg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778164250; x=1778250650; bh=t
	qbnr4/uovuGtcBTdrPDbPKS3EE92ZscG8vjudoekhE=; b=o0wgxpALU1Gakb0Ux
	EWAPtnqQEqukb5ecmnC8my02me7EP8VTvqxuhx3CPO4JjC1T6apzQrJhEw2EbfTc
	kKVv4qrfg5HawOLhGsXJ0UoXoCAeIcj/my605B6xwr91VsnLWpJ0AsHl400YnP4z
	DR1P/21s76i/eLM3XY212IHbtdTCrFQIJhNEjfZFirz7XODtwnn+ho2cibmHrKFj
	UnhTMKnxulDqWUquTd81lRRrDOWtmDIv7m/FLhRZtQTnX/HZAzyUwiIeYjbl/O7e
	m0bwCJeBd3nVXNABgeYe6UvFyynmMfzlPQ+mqWQT5VhHdtCuKo1Wv4zck9NuYvXW
	uolcA==
X-ME-Sender: <xms:GqL8aegIZnfFRuKeZGBlkJsvFL-GPRHjRLLl70Fga22f1w37Y9qJMJ0>
    <xme:GqL8aZ0O4cOWGSs3jCANvkJ6mZLoWrfDzJ2gvxe065CAO0MdI32VAKuQ7FtGVV823
    dER55O1Ca5p1v1LVqF_eK2KTmnSAr0Lgc3NjkJBQ9zRAiE4tYlqdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdejjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfffteetudel
    hfefkeehtefggeefjeevieekfeefieekkefhveeiledtkefgueenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:GqL8aR5V06j7OoTSXDbPDhc9x0RGZHNzE9nOsssSq_1ejFFYJuI10w>
    <xmx:GqL8aX2v4iVFaVU5sgW6btmieg-mqovS8xojcdNgelxLzVKaOd8EIQ>
    <xmx:GqL8aabxApakZdQPLhU-2QXs0GQKA05-diopSb96gX9uLgqUPQn57w>
    <xmx:GqL8aXC6-BihEOtY7lIABoy-gP1uy7_8fq4E_LfvAXaJmqnrs9fvBA>
    <xmx:GqL8afw5ikPuKBIUaGuylXQWODyEoeptnrkw3RF9s6GTv6kEYgZ6QuZj>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 90E4AC4006E; Thu,  7 May 2026 10:30:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: APJPVL9XindV
Date: Thu, 07 May 2026 16:30:30 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Derrick Stolee" <stolee@gmail.com>, git@vger.kernel.org
Message-Id: <3f0e03e4-f1ca-4010-aacf-72b3ce0aebd1@app.fastmail.com>
In-Reply-To: <5f9f4998-4538-4bc1-a245-4248e18c4e86@gmail.com>
References: <caveat_commit-graph.671@msgid.xyz>
 <5f9f4998-4538-4bc1-a245-4248e18c4e86@gmail.com>
Subject: Re: [PATCH] doc: add caveat about turning off commit-graph
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026, at 15:59, Derrick Stolee wrote:
>>[snip]
>>
>> But this isn=E2=80=99t mentioned in the user-facing doc. Let=E2=80=99=
s mention it on
>> git-replace(1) and git-commit-graph(1).
>
> I like your initiative to present this incompatibility in the
> user-facing docs.
>
>> +CAVEATS
>> +-------
>> +
>> +The existence of replace objects or commit grafts turns off reading =
or
>> +writing to the commit-graph. See linkgit:git-replace[1].
>> +
> This does seem a little weak. It doesn't really say how this will
> impact the user. Perhaps we could add something about how performance
> will likely degrade in this mode?
>
>   The existence of replace objects or commit grafts turns off reading =
or
>   writing to the commit-graph, which can cause performance issues. See
>   linkgit:git-replace[1].

Thanks, that=E2=80=99s good. But I think this addition makes sense only =
on
git-replace(1). In this (example) git-commit-graph(1) case the whole doc
already explains what the commit-graph is about.
