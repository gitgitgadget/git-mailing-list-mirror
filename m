Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A7421ABBC
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 20:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744057533; cv=none; b=FzByTXBVxRtSlR8a+r+zSa1PTXqCr0QkFguhDoXdtX29ALuX/yyFEuXFxu3zZlRYaX4emfp6QqLC64c47nNMCaAHhe6YZ5yyF+119Ct6Lxwsd98NHInoJloGOkuITlETaqTPRBGqy0r9bNnkMr0pq61T3ryOTBbY6OQMm+PrsYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744057533; c=relaxed/simple;
	bh=x9A18UFrjxkz2gZ34ODPMmPKQLHe6hbizGv498fcogI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ckuNmJ28/Bk1AKs/MEishCtzabb9TwFpUB7GBuShLuuiRS4RzC6A+yIxcYS/abq4tGmlVu47lMYGTXI2icMVwVuFOfh5AHyl2UrRnDvUpweSdBhDlLbb6c5va7f9IPYTh4Piv2Bio3nkgS33DFXNZt1zA4I19mkB8fP1wBC8HdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AE6EbJ3Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EZ1iDuRR; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AE6EbJ3Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EZ1iDuRR"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 258E41140172;
	Mon,  7 Apr 2025 16:25:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 07 Apr 2025 16:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744057529; x=1744143929; bh=0OjkjL0tPx
	rRoQS1ELMYI3TZagKmuiTmWWXfQobqx3E=; b=AE6EbJ3ZtEVqw5cPt4cSTwLABn
	4IQ9Zz6al8jXqDfZX7CgENbcgofGlDrGtqr0BwD+gLtmcSQESdWvIj+ZmpDqfXpg
	eXoYRZ2uoXdkLtUGinlSjWjRd1eq1wIMQ/+b4f8rAyzSbmPmR3o36leph++izhgH
	qf0PH6aWBkAxI/GnmoMRNLx1nCVrcl6krTetMSMMg6uU5iGfoJe6dLWcu1GQQbbQ
	jZ6f8x6C6yo1TYoWPO/98PZkUaSQCavfX3cex7o7an1G1GemkvgmtAMvXJUDi/sP
	pjDjR+YV196hBuWH1w5NqmqfOqyHCC4zLAlyJtMviqh7s+W3zDsJn7UMkUVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744057529; x=1744143929; bh=0OjkjL0tPxrRoQS1ELMYI3TZagKmuiTmWWX
	fQobqx3E=; b=EZ1iDuRRH8H/NNGQIq7gcUs/JNRerQgPgeY6mVLbJjPZdGhMfbC
	l+zVTP68Rh76gKOi/3pI97I4/Vg8/MHk7zrDbLkE2a+xeiITgkKxxqbvrKM1j60W
	YpnSFhUrymg2p2pxYxDtnTlWsD0+X/cTxXV1FXGY8f4RmM5Y4E9d1CV5DQZfQsRb
	DBH9/SmGmWeRhThceMmSgSa7vIHiVF6o3gxArTQqmGxOTNIyM0zt9hvEq0n2pJuW
	66j+tmetUcF3knjzyJd4Sp5Bpb1deB9kdRozHJtkCsKgpUTcopF20dW+GRChoYMG
	X2g0DYT3BDqmJNcjrkikaVHLADEHjxKMCdw==
X-ME-Sender: <xms:uTT0ZwbYOcLNbRPMHSZujFLmnRJDHOPRePiXVyul3Spy7MzNZKP47g>
    <xme:uTT0Z7Z6NExtUOOMCaIIKW6X9Ex--RxVF5XX_z9XaWfz5hkra8MshiBnCO3Oxx-OL
    zcZPhFGMhfMG162wg>
X-ME-Received: <xmr:uTT0Z68bwINNSxrnbonIRJFiNsWISDG_EGC5QiuBLYaEBJxdlAS0J-z8RYVjjP4mJh4Gt6SlXa6HRiolJgckmbLQPuIOGhaTpVr3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdduudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonh
    esihhothgtlhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uTT0Z6pv4j0DBvtvVg9C_r32eEShPmOEMe6DrdR-SrpLyjspujr7oA>
    <xmx:uTT0Z7oLuGICro-CC-jWcgUSqyL1Xq1Z5a3q2mT9_hjPlk2428QW5g>
    <xmx:uTT0Z4S2RP_QJT8Uf57SLU4fODI8NRhPXTCO0S45kqaxLuQqMhWCEw>
    <xmx:uTT0Z7rfiZjQo4wNrMXUwnWnjLACw1oMAvZZjfV6AvHhMvJJB9Z4Ew>
    <xmx:uTT0ZwP6MftZVflYgTiB0vXXZcQZjai2LK8xHksQ5w8itxdKHRMy0tsP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 16:25:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  Toon Claes
 <toon@iotcl.com>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 01/10] builtin/cat-file: rename variable that tracks
 usage
In-Reply-To: <Z-0bwFewNxUM7HUe@pks.im> (Patrick Steinhardt's message of "Wed,
	2 Apr 2025 13:13:04 +0200")
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
	<20250327-pks-cat-file-object-type-filter-v2-1-4bbc7085d7c5@pks.im>
	<CAOLa=ZTukdPiciDSyH1oGwYN_bdCw+vYjsHaV9AwHEpxJ5hBgQ@mail.gmail.com>
	<Z-0bwFewNxUM7HUe@pks.im>
Date: Mon, 07 Apr 2025 20:25:27 +0000
Message-ID: <xmqqecy3n2h4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> > -	const char * const usage[] = {
>> > +	const char * const builtin_catfile_usage[] = {
>> 
>> Nit: Style: we use a right pointer alignment, while it is not part of
>> your code change, would be nice to fix.

Sorry, but I do not get the "right pointer alignment" here.  There
is a rule to say that the asterisk sticks to variable (and member in
a struct/union) rather than to type, and since <type> comes before
the <variable> being declared in C, it would be <type> *<variable>,
but that is different from "write asterisk stuck to the right
identifier".

> Not in this case though:
>
>  $ git grep 'const char \*const' | wc -l
>  85
>  $ git grep 'const char \* const' | wc -l
>  180
>
> It's mixed, but we do have more cases of the latter.

I think what you wrote is fine.  Thanks.
