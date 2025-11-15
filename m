Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A526B39FD9
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763225377; cv=none; b=Te91bLwGwGUPVK/aKdNvsspbKQRQWJc4YlH13coYcd0MKWHQlCs5LvQ/WYcdIk7PLCA871G3cPWxM1q2KEPUjLcBDNH5f6Rd3BQyEhf0LEv195xLAgbenTajsuQOz+0unoaB2LL33dz40SEoReqvIloadnywuNEQc2CqikDjZO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763225377; c=relaxed/simple;
	bh=Vz/E+GbV7C595cNI95rg/EmP++1z5XqEsuFegKacKH4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p5SnRmMn2l/qOUfS5yvmG4Mm/zHqp+1Rz3e0crwTvcvQOL+K9D+9fbEEjihnYgSmP5yyoha7L+NDQxyVG0WS1tNHJel+kV0PLkTKifBHsRA0e+Fr44Dzls/sQ0D/xz4iZZFC5Ybzbmh8RSJU/p0GcQJlbP4+mKexD3OdtOKGQb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lDILji2u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=frQNcGBP; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lDILji2u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="frQNcGBP"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id C336F1D0014A;
	Sat, 15 Nov 2025 11:49:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sat, 15 Nov 2025 11:49:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763225374; x=1763311774; bh=FXrSjQBSsL
	dkGlNcvr406hnEjaNQ7ZI3XVBPDO4a+1Y=; b=lDILji2upE8niJ8O6MQBlNRzMP
	NAJKTMwWZBmor9KOxQv0lFGZhamv6W6BszcuIo6xJEknSklPbU9ziwL+rWAVN2D2
	mT73hODxrLQME2TlHGrwQvc7KStdiixkKS5H1Vco84rsWj/wsjUcCSw1SOOMT+9Y
	bzD0Fes6tFYMLdON9R0+lqV0QXSJ7djq/rISla6ExIGUv6rWLfUbuJ5ByzSl4V4t
	ssGXVhP5ODU7dp2mAqa5KVhoKRb6QlhuHWjilFnteCXSxul1eq9wTSZsSvOD2nAw
	MhsuSfznsIgg2XZHm6Y5kg6Ptgh0DG4t1jcnqiF5cHRY87/3iM4lliNvAsdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763225374; x=1763311774; bh=FXrSjQBSsLdkGlNcvr406hnEjaNQ7ZI3XVB
	PDO4a+1Y=; b=frQNcGBPEDQRAB9kJG+KKWjv8KgU2D+iUKWbnSgZXYJFsI2puXX
	oFDypFlgjs77YWnog37f38lGtYS6s0EUX6tbwdx/JOd+C927B/C9rVgtbt/qm1+b
	sAfo+StTGwcsIIV7zfAhwTy9PDXWwkQWdBm7UT4QVJo06OcsDw96BE4RmiUh0K6a
	shjrdXD3X6Hw3t8Hv1T9IxG+mbMW2viPszLN6tnaTGp42ec7fVnHSAv1/f/vF4Mj
	T/nOAbHPrtIopkucl1ptOWsf51lX9EZkpUpfdR2Ziz4saZDD8i5CJ2r2gTYhMGxN
	+WKrSaZJY74XlnI6cGPMaA7WlWvCJouh0GA==
X-ME-Sender: <xms:Hq8YadVbuJwEVFnsMdepIQF96f-4I_p9zjmiHpZAPrLA9sX7ThbuGQ>
    <xme:Hq8YaUdeidafqtPQsxDfBRb88Snlx2k2xkw41kp3FKWDZOVl6NUAhddCSrYjdyZIN
    9UUrPCbh30F0Xrbw_keaNU66GUnItEgtSZcxeY1bIC0T2QCi2B8>
X-ME-Received: <xmr:Hq8YaRuBt-EzI76rmBrx8CATxNZx5hckxlUX2-nIC5zxB-1JbrVoP6mLbJzu9d80C_4hGcIK4zpIpTdQklc6eVNjXOIJbbsg-EAm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudefvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopeifohhrlhguhhgvlhhlohdrnhgvthesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:Hq8Yab9kpe2mPg1JzvP_yFQE9qMWYXUb6QTdmar1YLb0h2gPlCtgHw>
    <xmx:Hq8YaU08GX-gCuLervpJ-P5WW9BnppYexuuH7dTVnTlE7xprUdrESA>
    <xmx:Hq8YaYA05CoRRGa1Ng8VL-C0rZ4JqtZ7L99y3HV88WCZi7CKBnMhbg>
    <xmx:Hq8YaYeijgaRRno_Ha-tWMvACOx6gqNm6G_9LDIi-docEA0j-YE9jw>
    <xmx:Hq8YabOLiq2heuitoAVIW6ABsGZkvh3lmeF-MouWp7TM0SIeHPoL3tgN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Nov 2025 11:49:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>,  Git List <git@vger.kernel.org>,
  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 2/2] builtin/repo: fix table alignment for UTF-8
 characters
In-Reply-To: <0eee1597-3e83-4a47-90a5-60942da01673@gmail.com> (Phillip Wood's
	message of "Sat, 15 Nov 2025 15:04:11 +0000")
References: <cover.1763098804.git.worldhello.net@gmail.com>
	<cover.1763213290.git.worldhello.net@gmail.com>
	<d0975427c9002ed28e6bbf18403034709f286a2c.1763213290.git.worldhello.net@gmail.com>
	<0eee1597-3e83-4a47-90a5-60942da01673@gmail.com>
Date: Sat, 15 Nov 2025 08:49:32 -0800
Message-ID: <xmqqjyzrfdgj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> How does it ensure proper column alignment for non-utf8 encodings? I
> don't see how it is possible to calculate the display width without
> knowing the encoding.

Correct.  But for Git, pretty much the ship has sailed, I am afraid.
All tools that rely on utf8_strwidth() are "broken" in that way if
you feed latin-1 or ISO/IEC 2022, and that includes "diff --stat"
with pathnames in non-UTF8 encodings (I do not remember if we fully
fixed the codepath for UTF-8---it used to be broken even for UTF-8).

> Using strbuf_utf8_align ends up being quite verbose. An alternative
> would be to keep using printf() but calculate the padding ourselves as
> shown below.

I think that has been the preferred way to do this, utf8_strwidth()
to measure and decide how wide each column can be, then for each row,
we measure and make printf() fit, or truncate when the column we decide
to allocate cannot accomodate the data on a particular row that is
overly long.

Thanks.
