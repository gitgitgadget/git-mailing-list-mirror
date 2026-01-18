Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4777080D
	for <git@vger.kernel.org>; Sun, 18 Jan 2026 00:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768696513; cv=none; b=Shndb0NuguBmURgBQkuw3R/qK+FZR4lkauTJ5P5CDIBq1gRBhCSGRr+WVwu2Ezgihr+WVrQO3xYPXma/aHMMDILpXSl1uTwZzCdNuC3SZpFuJZTePXFNmu5pQS9U6aaz1VUgx0SQaWIY2eHlYkHvDnJbyi/GNokha++x0MOANW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768696513; c=relaxed/simple;
	bh=hovuXBja2z+7/iysQEDnHngb760eIVO4/I/XayF5cws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z7yWIEq0sjcy6bDqYn/aWDPl2WYcoyLz6UA9aXHLvIIEsSPn1ZSwQ3jObR018QSSNXtwgL3vOWMlkR1Dff/W72pwhx3jjUI+Mn8PgB+t8xH/8HV8kqBn3uVqbG6YSreaDUU6rsnoxutwzHxzcoBSEuJjSxUvtI7Q0Bg78SCBjfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gf07ni9m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x0B0ui0Y; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gf07ni9m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x0B0ui0Y"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C4614EC083E;
	Sat, 17 Jan 2026 19:35:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sat, 17 Jan 2026 19:35:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768696510; x=1768782910; bh=XadZnU3RQb
	xlBPv1i896PxWICiY2Y1pqzi+fgpxUoSc=; b=Gf07ni9mteAz6G/kes9KCKPjTy
	ceSz6F1Yii6vKgaZFBP35gYcH5+atIhqv17lxXX9ycGvkPtxTDpN0hPU74fdX8Kb
	5lgO5RndnT0XCTP/X8ZDjey18Y4FSWWHHFb2VZU6RWndziGQfD7rB7FGLzvoh08Q
	ZkmU3AyXwoUeytPTQxivVTjLmvnctXn+CSg1owRBLOssVAd80DuTENu3WQAkZCEa
	XvwnPyHHMDyEE2ZuTgvvw0upWfCV9LBWaERh7oLqjgFr/DkF6H6u+gzEWSyDNP6c
	YZAU14A9ElLZVv2/ND8gEJGjvYOIUiBDSuFlu2BpcHOEXJ9DZBdWveXR6lIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768696510; x=1768782910; bh=XadZnU3RQbxlBPv1i896PxWICiY2Y1pqzi+
	fgpxUoSc=; b=x0B0ui0Y4BZM6lpkyZ5LPitU8ZmON6+W6QRV15hUpBeHoqZSAHJ
	Ew9Axv/avKo7R9O4ZK5nGrV6hEou+rT5iZhFP1GJaD/XJ8f9NsCJPo8NkJzgYaHE
	VX0ARqyemVf0XkipZKy6ou2J533svqtPT9BN9lfW8aQ95LC6sYSe8mE4NBQdfhih
	8vn3j4vUK1cdUlQna0nIl05195IgWtNRy5sADt7I4iVPj2mEeJeWUd/fGm1db0kA
	D/XNFrJgFC18pdq12B+odK5+pSLmk5SANEg6cRQwCtlPLaDJCP5rkwiIWVtFZdVZ
	Esq7SFf1agNyEt7Um6r3Gz4MN5bpmdA91gw==
X-ME-Sender: <xms:vipsaez7B141HurvJGmrcvecIQnWvEHpVOviuYe1OKDZPTNcIaBKYQ>
    <xme:vipsad-MvRJ6ztOtPTM9kZwNfXQvWaP0k-LMwaSe_O3FBvZ0kno8fZx-eNbBNkfRN
    UDO6ORQ2lsLEi50lGzdUl_U4aWv86pbT1GC-Jx9zuF2aZIqFGwZCw>
X-ME-Received: <xmr:vipsaaKvnM9I1g5xF9lg5ISphkR1LwHQNw8MjtcZ0d-xoGx84v_dt7-59mMQsRThmrM_XJM-c0LeV_xFoHCkuf-gmS3mGVUgxPgrifA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeefvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfees
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:vipsabfDx3QRHSsWF5Kp7JxutO6IGKaMiQpdzERnIWxnJXt-OVbbWw>
    <xmx:vipsaR-ODrjIpAsyvyoSRGLUkm3iEDkcqJjYQcFgmvtCgYwV6n8uiw>
    <xmx:vipsaQp8pud67b2VSVIkD7InbjlzIk9_mio8lSFMYLSF1VvAZ8qHgg>
    <xmx:vipsaeBClEhR5jaXVduX6XZfGmVOxkFh3Cpe8JqQ91xX-o4W8nDxkg>
    <xmx:vipsaZNTUiWCPMtiWCjUCl5sX5L-HtUk93pa0H6B33ThwgwoCiL1x6nA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Jan 2026 19:35:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Phillip Wood" <phillip.wood123@gmail.com>,  "Josh Soref"
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Johannes Schindelin"
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(*-leaks): skip the git-svn tests to save time
In-Reply-To: <de592bff-d7ac-41b5-bb24-4ced285a52e0@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Sat, 17 Jan 2026 20:02:16 +0100")
References: <pull.2031.git.1768584676520.gitgitgadget@gmail.com>
	<b649f137-7140-4fb6-848a-b3408e54bbe5@gmail.com>
	<xmqqa4yc5brq.fsf@gitster.g>
	<de592bff-d7ac-41b5-bb24-4ced285a52e0@app.fastmail.com>
Date: Sat, 17 Jan 2026 16:35:09 -0800
Message-ID: <xmqq5x8z69mq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Sat, Jan 17, 2026, at 19:34, Junio C Hamano wrote:
>>>[snip]
>> Yup, I generally like this direction, and introducing NO_P4_TESTS
>> and NO_CVS_TESTS would not be so bad.  Here is how it looks on top
>> of Dscho's patch.
>>
>> --- >8 ---
>> Subject: [PATCH] ci: skip CVS and P4 tests in leaks job, too
>>
>> Looking at the CI logs, the p4 and cvs tests account for another 24
>> minutes of test time and they offer minimal value for quite a
>> similar reason as the previous step.
>>
>> Let's introduce and use a mechanism to skip these tests to save
>> some resources.
>>
>> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
>
> Nitpick: Using the commit ident
>
>     Phillip Wood <phillip.wood@dunelm.org.uk>
>
> might be slightly better?

I didn't even realize there are multiple addresses in play,
actually.  I just took it from the e-mail header's Cc: field,
which my MUA copied from From: field of the message I was responding
to, which was the identity of the person who suggested the change
after all ;-).

So, I dunno.
