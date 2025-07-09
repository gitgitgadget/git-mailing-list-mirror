Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FBB36D
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 00:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752019405; cv=none; b=ms6TlaD2JAP0NYwsrEu340nhOZm97fimhGwDCsiuyGSxB8T4bzDcovYK9StRYko7IYOj4eY1c2fGg7E2C+KIgQspPDqbUmN8rT08YKHb/0+CTXzM49WQ95z7ZUhoa5Xag4v58XaZC5Bx10w1v8xprQWP9Vw94Lp0MqCOPjzqFlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752019405; c=relaxed/simple;
	bh=BGWyT+pwrV1K453v/RwsscCB/RgmcBf59wmhdPqcuNY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YfKf3g+LPlcdYGOjq5j7hECndjMY3QTKjNTm3DflHSQeX3mL9YPYQBn05QoXMy0L0Kry6ZOC/K3MR9Qlgz2yDOBzguuQ09+l9Pt1cQPNSe+wzbnVPofmcNLA93exadHZKYVAoXOQEqoI9o5+8hUJei/3PIy/4HmiAKWYh2mN6Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Exg8P01k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oHiSn/vy; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Exg8P01k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oHiSn/vy"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B92A07A01B7;
	Tue,  8 Jul 2025 20:03:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 08 Jul 2025 20:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752019402; x=1752105802; bh=eFFt6QhRfF
	STBA09jkoWIdhGM1hrpFxT/W4Ai61g+wk=; b=Exg8P01k9qqh3yfpgYc82Z6Z4i
	jRlRNUCKxPCPelFqDb8JxrMg5xajZ2c3Vo+pqwj1Bf2H74lj85sV8t3o0dP9YA9O
	xYX2n1IAveghE2uTr6BqvzPzuzQwJ3SWRWlPUnFLR/ANyYvAVLph6eg1xEbmJ6yS
	upYU7SYScfrLTRmraWN+3mGpd9ESX/Sao1QC8xrucRYkr9nEB9F0MEAxeY/HX2gk
	411IWrkxF02lg72/D/UB+8p1RZ7/BRtB+PTnB4ySy9WLs2CDCj0/bQB9RRVB6IOz
	tawaOgD/SDerNj8e01CpOUjY1eskMYF/LxgTTpBQobBkurVODVyaW9/x28tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752019402; x=1752105802; bh=eFFt6QhRfFSTBA09jkoWIdhGM1hrpFxT/W4
	Ai61g+wk=; b=oHiSn/vy+P4PcRJJ/JC7MYx/duVri/L28HXRcVmuRlM42TpXJOh
	G3zYCxawmKPk1T1I9+I/hXavGI5Ez0YpYokPrPyY46W2FcnztMqrde1aZuQHGpPb
	npG/I5Qm5p1rTZtmouX1ULDh+h+TB2DWF3MLgDDikwHmRpEGN+37bg4PtQ6VgKFt
	MH4jZ/O57GVIj8hXHDH//6j4Z2uI6QFo1TmZheMjidmSftn6rqhmJC35eUHmrK0Y
	M3xIvzD5nsDEyxj074HR/YvXlRtcWLkvjY+piRPCssG8CuuQofV9rZBF4T3xd0e8
	hZ5yxCkeVfe9vlPRab0be1/A/Xw5HDHsYvA==
X-ME-Sender: <xms:yrFtaC8XHZjVfZYuwsKHzEhHGoRzDQa_VgR0ti8gie4FXrR1J1CRhA>
    <xme:yrFtaPntqI8sDJqNxXGbMnuLLwGrsrkgI3Th3dXmU5c4sIwICALtwjgeJPgVSEr7Y
    tfs2vJEM8dvTvOiJw>
X-ME-Received: <xmr:yrFtaHy-003d6zo9Aux95Hk5pvzwIEPDHbyckAJNZxYHdLee5noYXV9wSm0_WjptiOX71PFxudBklsiCA-FwptjJ-JPyxeyoK_IXXqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefiedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtth
    hopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheptghhrhhi
    shgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:yrFtaJ6yGwQK8LvrDz7kMZMhfeNyhv8D6BZkfKCdTat56yY96UppOA>
    <xmx:yrFtaHW3jmGYFxaeUJ5em3nkIHx37MtSabJ-AYCy3Cgiwu8PH_4SKw>
    <xmx:yrFtaBI3eiGTUMzEKCQJfNhvv5tEIYjM8OC-R4R4tcxakWt6627adw>
    <xmx:yrFtaJuF5-YJa-_8dNrS5xAoTxd7h6ZYLt3LNUADoyNILk1SvCg7AA>
    <xmx:yrFtaApu06KGxsV_uUu_XAvSzWJ2FcAcPZGKi9cc2AViUc1ucRNJ5bcy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 20:03:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>,  Jeff King <peff@peff.net>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5] fast-(import|export): improve on commit signature
 output format
In-Reply-To: <CABPp-BF6OvH8oh=jG_8fWoC5gW+9E+wx=uDEk1uerJTOva5isg@mail.gmail.com>
	(Elijah Newren's message of "Tue, 8 Jul 2025 16:08:06 -0700")
References: <20250619133630.727274-1-christian.couder@gmail.com>
	<20250708091738.4072857-1-christian.couder@gmail.com>
	<CABPp-BF6OvH8oh=jG_8fWoC5gW+9E+wx=uDEk1uerJTOva5isg@mail.gmail.com>
Date: Tue, 08 Jul 2025 17:03:20 -0700
Message-ID: <xmqqqzyqqlh3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> +       if (!space)
>> +               die("Expected gpgsig format: 'gpgsig <hash-algo> <signature-format>', "
>> +                   "got 'gpgsig %s'", args);
>> +       *space++ = '\0';
>> +
>> +       sig->hash_algo = args;
>> +       sig->sig_format = space;
>
> Really minor nitpick, but it might be clearer to pre-increment space
> here than to increment it above.

FWIW, I find what Christian wrote easier to follow.  We find a " "
in the buffer, point it with a pointer and NUL-terminate the
substring.  We know we want to further process bytes that follow, so
the pointer is post-incremented after the NUL-termination.  The next
user of that pointer relies on the fact that the previous user
concluded its use with that post-increment.

If 'space' variable were named more genericly, like '*cp', it would
have been perfect.  Perhaps only the first half of the code was
written first, and it looked for a space, so the name was chosen,
but then later ...

>> +
>> +       /* Remove any trailing newline from format */
>> +       space = strchr(sig->sig_format, '\n');

... it is used to point at a LF X-<, at which time the author could
have renamed it to keep readers' sanity ;-)

>> +       if (space)
>> +               *space = '\0';

I also wonder what should (not "does", as I can see that the code
does not do anything) happen if we do not find the LF we were
looking for.  Is the caller of this function so loosely written that
it may or may not guarantee that the data it calls this function
with is properly terminated?

>> +test_expect_success GPG 'export and import of doubly signed commit' '
>> +       git -C explicit-sha256 fast-export --signed-commits=verbatim dual-signed >output &&
>> +       test_grep -E "^gpgsig sha1 openpgp" output &&
>> +       test_grep -E "^gpgsig sha256 openpgp" output &&
>> +
>> +       (
>> +               cd new &&
>> +               git fast-import &&
>> +               git cat-file commit refs/heads/dual-signed >actual &&
>> +               test_grep -E "^gpgsig " actual &&
>> +               test_grep -E "^gpgsig-sha256 " actual &&
>> +               IMPORTED=$(git rev-parse refs/heads/dual-signed) &&
>> +               if test "$GIT_DEFAULT_HASH" = "sha1"
>> +               then
>> +                       test $SHA1_B = $IMPORTED
>> +               else
>> +                       test $SHA256_B = $IMPORTED
>> +               fi
>> +       ) <output
>
> This last bit seems a bit fragile; could the redirection of output to
> the stdin of `git fast-import` be made specific to that one line
> instead of to the whole range of commands?
>
> Otherwise, I very much appreciate the work to create a testcase with
> both signature types on a single commit.

Yup, thanks, both of you.  It seems that we are getting closer to
the finish line?

Thanks.
