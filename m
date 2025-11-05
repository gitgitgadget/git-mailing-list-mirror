Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9B32D24B3
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 08:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762329846; cv=none; b=dZvdQspjEY3QrUNv4JIfUjgC3KCn0uOPYi5TfInfaEmfzzP7T5yP5xFbxrU2oQPdHL9JsetP9+lXjqk4qsqSD9Cpmidck0UXMuVSXgKSueC2zFoHoO3NKsBeqWHJ2E18fMCi1WGuq9ZBgZVZgwmJxPuofS1Wu6fB2vzH71Z261I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762329846; c=relaxed/simple;
	bh=czYPQfZQPCxRIX7Oq0qASwK5ukfo8V0HG4zbeb5jcTs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CObpeNzyukTj9WQY0TJyrd7qs8aPQd3b0afB+wFr6t17oF3DiBN/f494HJlN/1m1yTp+B17SlWcgHMOrVBUxaKyGWaxszSuZ+Exa6foL9OnaI1xIs2o18i+2TgVQ5LJEToishv2XcUL/TQ32yy9PRrejGyrEr4+isWMtr0v24/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gwwd19no; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YDyvM/JK; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gwwd19no";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YDyvM/JK"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id A4EC61D00142;
	Wed,  5 Nov 2025 03:04:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 05 Nov 2025 03:04:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762329842; x=1762416242; bh=rvn9Q9XFAB
	SPZXj8rwnr1E04/af40ip+oiDPi1s0xCM=; b=Gwwd19no4pQRoz/fPWYVu3YyY0
	r8i7sYWMMZYbj0JXTv2EEPvjD0QPrD6ejbWn2jvQlUScfeXk9HqdVV3LcuTRwskx
	rVzHTRlXGIs7Y9EQ13Q3YMGvS2fc4ihYU2g1VYgujKwG/KeEJgTOvqnGLq4XfOde
	8+TQC0ALxnEGzKNQL7PtquIHBujgaeSyhJ5HD3Zz0Mh8CArVApAa97B0LxMjulZb
	orOzDB6RvqzIJmbOAVSJSpjtg7P8pXx55NdouQM86r5rsFZBBu4MyAY8s/jDBWVx
	DUDeRG44KSerqKFP1fy+FRp73xLjrPnikFYsZvhTq5ydnI6Apn/gctGbbunA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762329842; x=1762416242; bh=rvn9Q9XFABSPZXj8rwnr1E04/af40ip+oiD
	Pi1s0xCM=; b=YDyvM/JKVC2ivHduzzihiuGnnvWLhdAIuBCobg0iToDYDMlZyxs
	uImesYT/UORlrV9dw8OzJPesguM3heRx8IKfOvNTH2vwNcYknmMppAXk0LNX8dDE
	nqpGNMK6a+TAOgeMWwhbICUDwvnY5R0Wg8f8EdG9iud4RU3eF5m+Aoe4JU8qYJ2E
	i6mXw6ByPVrlcEqCVC1Mvy+mEeDjMA5pAxoJh5bAfdvgKSyf5/fGrin4oGOT9EZi
	glQQDplvdLQovivY4tO8Xygk6m4QmIAcgDD9pMeMIyP3COM2GPlu4G2OmqesxpE+
	31WgDaG9rJ4Ocz2MHYM3AaNHw+xxNwZ+kBQ==
X-ME-Sender: <xms:8gQLaUvZZ40ji3HpSSKNLM2a9QvGLDwJ8bVPTqJT3dRPCZlYtbDodw>
    <xme:8gQLaYenw0C7AtwKbBg-7Y7FPl6H2aF-YA8EG5PRd8CReweFtPQapdOCTW8EvVRH7
    AJCgyFQLOwwxrPobP1S7VoLwXgzVGbqq0Td-XZOe6XNweX-WanJrXs>
X-ME-Received: <xmr:8gQLaUysL0xaZnKrkaTOWnKDUliVW4TMDextCD6XtcBQ9VnZh_6qlU37A99HM21VbvhE9Y_xs8e8idkf2UEDwTyQBgDQmwbgloGi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeffeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:8gQLaWGySNz7NymeOb7dddrZZ2e49Ng8p0nIHHshfu3xRBxfgrb-7A>
    <xmx:8gQLaQxP5FdqBoslJOIUrNId3oQzDtVWWR9SMDssRdN9hsHBE00VYw>
    <xmx:8gQLafu94CDnFi-TJobxCDppWwA1jdYRf0f9gF-e6RDtZ6pSQ1ydEg>
    <xmx:8gQLaV15rz9pZqNCFeZyyNqNbqL4Hjp3Yq1PlwBxuUpAoixrqzsgGw>
    <xmx:8gQLaYSpvGrnO-DW3qQqggm0uY700FxGwoVbk1hD6cEv4GPhOw1OuSnE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 03:04:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com
Subject: Re: [RFC PATCH] diff: add option to report binary files in raw diffs
In-Reply-To: <nxl3sgs3h2psylifnbwcjmubdfmfhj53jjun5nsa4aqq5robh7@quga463ajvbu>
	(Justin Tobler's message of "Tue, 4 Nov 2025 18:17:05 -0600")
References: <20251104021455.379807-1-jltobler@gmail.com>
	<xmqqa512sfcj.fsf@gitster.g> <xmqqzf92quen.fsf@gitster.g>
	<nxl3sgs3h2psylifnbwcjmubdfmfhj53jjun5nsa4aqq5robh7@quga463ajvbu>
Date: Wed, 05 Nov 2025 00:04:00 -0800
Message-ID: <xmqqtsz8nbwv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> Maybe the output should be something like:
>
>   binary=tt,incomplete=ic,crlf=cl
>
> or something along those lines. That way we could freely extend in the
> future without having to worry about a specific order. If we think all
> of the raw diff extension modes would only report with yes/no for each
> file we could just do:
>
>   binary=yn,incomplete=yy,crlf=nn
>
> but maybe we should be more flexible and leave it up to the mode to
> decide what its values can be?
>
> Also, maybe this info could be on a newline following each raw diff
> entry? Something like:
>
>   :100644 100644 a1961526 e231acb1 M	foo
>   binary=yy
>   :100644 100644 31eedd5c 402a70d7 M	bar
>   binary=nn

I know these are parse-able, but quite honestly, both sounds
somewhat backwards, if you meant to make this easier to parse by
simple scripts.  Scripts do not mind their input line wider than 80
columns, but it is cumbersome if they have to take each pair of
lines and combine them to process.  And repeated keywords like
binary= etc., do not look like it is less error prone for scripts to
parse them out, either.  So, I dunno.
