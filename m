Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F24262FD1
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807198; cv=none; b=SsUfRNDmmhxYBnKPYvQYzwVp7S/IGhOxcOMG3/DusFN6PkdI16K/xwO//RBiMuLOMe5sLlgAsV6EqBojmEnabvmbXoBJaKrK4WGhSYV2rKr3pLZE+CrlpwVbjurT+3k5azD6XJ2xUZc9p7A/cgI58CxFZPKJS8KhLwAek7DygSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807198; c=relaxed/simple;
	bh=DQnxXiGoIRv+/o7+hLXFih8efPpsWI6/Y+cu4b9rb7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a3quDUFaHOWGkt4qIe1xz8nn8502OQArPffBXmikKbqjbebBz1eNLAaa6YLsm0EaIgOfaREcRWBHBvrvc9rqls4AJeKr+T6Jk91w4WdvJHAAkY+Z/om0V5Fkq493VmfIe9c159VbKC0ekmQIufR4AZz5lpll5kTL/7AdkLAkrJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LIF4mYrJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a1NxsaG3; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LIF4mYrJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a1NxsaG3"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9CD637A0204;
	Thu, 25 Sep 2025 09:33:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 25 Sep 2025 09:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758807195; x=1758893595; bh=1hVvIrovUL
	mLR0wLZhXos3xzWhUgv8YTwmM2uPiiOfc=; b=LIF4mYrJqH2KF5BOuaFyFMmNeQ
	K7HgaDsfuw4hqmPh+IeyCX0OxMyWNPrSJnSSD/VmYtA5L4VYdglk6jD45y50W6iv
	RI+S3oEg7BHFs/CMQRN+7nsu1X1klKQmoPWC7JCGjauvnqTUY2FG+aoQbbXatp6L
	5zI3pApF3lDEtUsTnuENys58cCgB5q3SK5tUl8vGqSTvSG/YwsjSsPwSON7aYPH5
	r2IZSmGtM+6J98xOlBAJdacssIN/k4agAM3iDvGk6QvThmICxjFIFxjQMAmOwAto
	hRG9kmgC6ZYliU82vim2UHjaUGlKbZrlG0Xww86YXmAJp9C/UmBPOW7kFpzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758807195; x=1758893595; bh=1hVvIrovULmLR0wLZhXos3xzWhUgv8YTwmM
	2uPiiOfc=; b=a1NxsaG3uI70FGFkqoKCNCioCnCU69CIv8NN1mjxTdmQlojTL0z
	U9VD+aW3xk/mP/IKdHGIt1Nh0zo63b3z1wWu2ao9X30RtOdKk7eBJGyhhPdPm5vT
	FuFij60++PlDeh6d2xh/I3Kptof/MSYrbl6jitlX44Vlxjgp1/xGRP2NExiGLlyc
	q+I/rcQo3Qy8OaLHbxjQSjUvxUnBATMVTmpwtLKwRFPJLfv7aXKq8Da8bD/RjI76
	Jaa51faAWJW2yT95jUWt1RbPG+H0a7A9zPe0bCQwhjfkE6BK7U76F7MIjd+qCsXW
	0T5kI0kMKR9Pr4Z40AufnXy5KDZcR0f70lA==
X-ME-Sender: <xms:mkTVaI2hx4EI6mSC35oRsckarp9huiCupRz2Q8EOYl985RfCISuGZQ>
    <xme:mkTVaGy4kciJq_es4ckkFvEXVwUol29_xAi5QMNj3h00ZSOmgdV3L7AiI7eYZ3pAU
    qyNTwgAT0BGiFonTQtN_hYrSfbbRNpo1pnLP1-d20QpK9hPBWri>
X-ME-Received: <xmr:mkTVaKvoD0aog2J959Tjmsjl--gyWKQcuhTZzzYMPLQqJo8AO6vN-n5MjLfjcZlr6XcfXAbZALQJk9C1vi--8ZQIumVSGdR76JxR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiieeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkh
    grrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghl
    uhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:mkTVaIwiYcv4WMkDXJ_12KsYEZwiRih87yZeBOjhftw7xTYGR0Pwjw>
    <xmx:mkTVaNBM64RlnJrjtatAxFh3Km0VL7xBDFRrgXS0sOjFoOTpGXOx7w>
    <xmx:mkTVaGezIr4kD-3pNGJwlLKPCBGiTSn0DQg-orwjmaNjLe6BhGZRoQ>
    <xmx:mkTVaHlj8eQeP6cSFZ-jF4M7GZYWG0pEbJ1eeBmTKmLPdlLJVh7DqQ>
    <xmx:m0TVaDnPo8TcxMZO6LjLre2qK3EAl8Wjzs8m4cxt1VW9mx5DThjFMSsz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 09:33:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Karthik Nayak <karthik.188@gmail.com>,  shejialuo <shejialuo@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/4] string-list: replace negative index encoding
 with "exact_match" parameter
In-Reply-To: <20250925025040.GB3202669@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 24 Sep 2025 22:50:40 -0400")
References: <aMp8yNFiXDyk2hP4@ArchLinux> <aMp9OtXLfRw7dEwA@ArchLinux>
	<CAOLa=ZShms1D-cq=x04dtT2ULTVE3ZDo8DODFnJRP2wcJz0EgQ@mail.gmail.com>
	<xmqq348dovi3.fsf@gitster.g>
	<20250924053601.GC1173044@coredump.intra.peff.net>
	<xmqqwm5om1gy.fsf@gitster.g>
	<20250925025040.GB3202669@coredump.intra.peff.net>
Date: Thu, 25 Sep 2025 06:33:13 -0700
Message-ID: <xmqq5xd6irmu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Yes, but it's much harder to wrap a size_t, especially if the code is
> allocating as it goes (e.g., a loop expanding an array). Because if
> expanding your allocation from "n" to "n+k" items will overflow, then
> that implies the current allocation is within "k" items of filling up
> the entire memory space.

We'd be protecting ourselves by noticing that n+k wraps around with
st_add() and friends, and relying on malloc() and realloc() to
notice and signal an error.  Use of size_t to count the number of
things that are getting allocated is not making these any easier to
do compared to the case you were counting in "int", no?  Either way
we'd need to be careful.

> But if we use size_t inside string_list, say, and you do this:
>
>    for (int i = 0; i < list.nr; i++)
> 	printf("got: %s", list->items[i].string);
>
> Now we have another problem.

It is obvious that in order to count up from 0 to list.nr, you'd
better use a counter variable of the typeof(list.nr) or manage the
wraparound yourself.  So I do not see what is new here.  My point
was that use of size_t to _count_ the strings in the string list is
where the problem stems from.

So, I still do not buy into the religion or superstition that things
must be counted in size_t yet.

