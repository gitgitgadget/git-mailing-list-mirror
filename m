Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A95280307
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 23:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970407; cv=none; b=JiK0jNtWwnLR3op6YKqReqQtB+bnHeVjCdAQ+rBCjf+gaWaqJvXq1OyMWz5RuJUjeSf2kCkLl0mTjlIDTW4XiBgH9lKaoRF+TyuaYI4PEgHXCxrR6crRAn48yp7dMCygqTvDJ0p5O8kYNvAj8KAt2Ixo5dShwNJVPpxxrppcBpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970407; c=relaxed/simple;
	bh=LqlppuWwVcI1mH2SbNBTqcwKFbgUqZDX8dRJs19ke68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BRTw5BIZFY/rdgMrcNbcuoOYdoApxMy6dESGPhBQd8NKgQN7NAjVpFmzgeqyLNAfCY1rBWwfpjmpCTs0SCai3MEwEuIBj8WP9HH9/ZZ6OZ+MKMe3XSHX8e2VcILeiBi5yecagwcVhBkONu/zbmH3YqT/JpwmVZetVlkgnXsryyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WeKdfxyS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WObW2I8n; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WeKdfxyS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WObW2I8n"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 9F08413801DE;
	Tue, 29 Apr 2025 19:46:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 29 Apr 2025 19:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745970403; x=1746056803; bh=LqlppuWwVc
	I1mH2SbNBTqcwKFbgUqZDX8dRJs19ke68=; b=WeKdfxySx5fBdzs9x6Q4ll4itY
	gZYWOA0w6p0tk9RYrNrYlOKY3mWiUr3Vq8yvsviOMwQaNg83lwOcGCyoJuXoBzfM
	CUdZ526dyozNSz6OuSRqNxpttAuOopEl4bN8Jkzsz2ZMqz8U0EJc+pzj/StaG3h6
	SubIPvuW5iFBnTPouA9RMb6pzohNHbOdxHJ2Pk+YDKBegKJ7C6xkGeew0bLQR1N6
	DZmtLAVXt6cIicXasyf68mzgUjyPmPACOVuzeeQvfSWVgmF7/SKw170F7AHlJ6C1
	lAtvnr77jE4JBM5+hOH5y4ISL+ExPR6U803b8c2x0xbM1gzUZuVi5yHMRDQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745970403; x=1746056803; bh=LqlppuWwVcI1mH2SbNBTqcwKFbgUqZDX8dR
	Js19ke68=; b=WObW2I8njngRBB4yHHn4Iy02jwDRv/QY4nuOuCvRrmJvny3O7sp
	MaNhgzArMH/B+SBQ5m2UerwgChnsPHqwuHvnHBAMWRztDQMcW6r7E0yr68boXt2/
	hXFKooEFHxD62ng9lf46fS9Z39mxdEKetfbEjWI8skHkgCmyJJZS+rBH0Z8ZA/cG
	o3Hd4J+J5NSKp/Ba4tx+bJuwT3eaODa3rDobZdCBFmZsq5bdy/R1Fe/TZsXY3B9R
	1gF7QrjBhheAgoy1RBWIyijp6sFy0/Dji9+kmf6Y2fbrYuRmAINaNxrqki59c0up
	o+2qCCgg3ikasOZbv/guuprtmO700MQ5nNA==
X-ME-Sender: <xms:42QRaNs9Hm6r6eqH9LQhtSH3PgmpqKco-KM4zq4JHlX2yQw8Bi3ljQ>
    <xme:42QRaGc0TUYTSWJykFaLHWD2vjHp7bGkn3BpHK7I3TNSy19YY1TuAZHNyjP6l_aIT
    qsrePngyD69BqRkyw>
X-ME-Received: <xmr:42QRaAwySOTE82hcl0Hyl7fbK4b-VGZnvk1z44jjob686RYwskVAZUumVGMZB7FY1TrTZp6XiO9HllUuv1ypa15RIbHvP7J4B1wN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieehudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehj
    ohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:42QRaEODp98Tuqn7v_Kc1orLy0_BAOUHNtoyab0eVpIT8WUSNcpbkQ>
    <xmx:42QRaN_ZSBKGWkj96GT792Sndn5kjjfP_ls1UWUHjrgZeTKFc3XzDw>
    <xmx:42QRaEW6PfmCOxMQTWm4_BpJRkO6Lqj5Yd_T-Aikg8wKXm4VhWpx8w>
    <xmx:42QRaOfe25QesjIFwOrbLzWcQEt5eaFh4VYNUHwQzxSQW2cepVKihQ>
    <xmx:42QRaBfkPDz9ONtYZJwWWfYs0-kHdLdILEUbEtMeiyANczyJoT2zZ2Fk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 19:46:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] diff: check range before dereferencing an array element
In-Reply-To: <20250429233314.GA594987@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 29 Apr 2025 19:33:14 -0400")
References: <pull.1887.v2.git.1743073557.gitgitgadget@gmail.com>
	<pull.1887.v3.git.1745926679028.gitgitgadget@gmail.com>
	<20250429215847.GB36727@coredump.intra.peff.net>
	<xmqqldri4ms0.fsf@gitster.g>
	<20250429233314.GA594987@coredump.intra.peff.net>
Date: Tue, 29 Apr 2025 16:46:41 -0700
Message-ID: <xmqqy0vi350e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Ah, you're right. I was reading the offset check as "are we past the end
> of string" (guided by CodeQL's complaint), and if that were the case the
> logic would apply equally to all values we are checking.
>
> But that is not what is going on at all. The offset check is for "len -
> 1", and so is "do not do this one CR match for the final character of
> the string". And thus applying it elsewhere is wrong.
>
> And CodeQL's false positive is doubly wrong. We do not even need to say
> "the string is NUL-terminated, so it is OK in this case to look past the
> end-of-string". The check is not even a string bounds check at all.

Exactly.

That is what makes it hard to give a reasonable explanation in the
log message, which I thought that Dscho did a much better job in
this iteration.

Thanks.
