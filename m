Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEA0285068
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751922263; cv=none; b=riyQdk9cLeDhNWJDm2jzmAhTT6y5YMezCv/8InSfB1jDm8ZJpNH4TTQA9SdPu/ubygTYs4m61HzOvq4JbSWbiWyRF3FJaQBikbiF/a3CDnyXzmxI1kDnuiBkLZGjMWQQzWgQ4MfoXq7wGbi3K1SH0y0DwS94T4q7Fc8v6pnbJNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751922263; c=relaxed/simple;
	bh=TdSlVX+vNRF6sZmYVXp+4MM4Ii1Ccvc4M0iqlMTJ6v8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LMesDGb+QhR7sPm6TjKxC3wh/5+lFGP1kWGdyY/Vr6aSg/FkZsWZPJJ6N6welF+IOUFdKZHGdmF44znCioQX9RAzYK/qVqDQ8jXvmgMm1rGzufzHEX4SKLsi3VBWXI3O+gm1iHyLvWiI+wQPoRfE7rETB1rvPsohOb36MHu2Sbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qdg2g1o7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dEqU/OZx; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qdg2g1o7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dEqU/OZx"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 33EB414001DE;
	Mon,  7 Jul 2025 17:04:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 07 Jul 2025 17:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1751922261; x=1752008661; bh=33qayJVmsq
	qoLxgY/EhpiNaRCrATzyK0/5pPSRfDsHI=; b=Qdg2g1o7fZFpIbujZa7Y7qgn1c
	ZF3qsO+DOGdSgtNBqpDWFSwZZnGgPGJX1wELLuFMDvq0DlOd/x6pmBL90vY8pkw6
	YN0uI18/0fJL1c+4ZMHqgT7NCfzHONUTIhztzJ8ScfH844U+bZGJWtYtJuE1aDY/
	YjwlFE7IjJXGuUtfQkOvX6AVDyz0x6JSKCoJVt2R1Gn5N9IcwAGPWHD+EHv5PBBE
	tZyN/j2s/9XptDp8J6X/CHd8rPI/lfnBib1fyEY+KeIm4OXwnxegz69Pzt8IHehN
	2BXZpW45N+cM/vM9zCuRDCqCT/WwBv9j1/3cBE1HM+mYKJV104aDYG7DZ0RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751922261; x=1752008661; bh=33qayJVmsqqoLxgY/EhpiNaRCrATzyK0/5p
	PSRfDsHI=; b=dEqU/OZxBMgsPC//wNCq4OZ4u47koP3c7eL59nAu7hBlowGI1bK
	VDWsjSL6fMg3kLDjR5oOGt/uOJINQTxOBF4AkfUaefmWYuEn7KefDdU3IJRYqBeY
	nmyK8fLVx59dLGv6DP9/ONU5XFcBh631Cxr7hWYIjQRqk4OhWtrlIVYyzrsaZxUR
	y7s9DjJKgh7oZuoH3AZwL8wt/493zYE/3Ecla21Y/WKiqeB7IahME+MVnW3wOYmk
	hVrF6cLQi6WMnDTTQ+SX4I8E7Wv/BQ4DnVNk66XCil2m/Oz+9dROmFSkHKLBFHPX
	dskce63SvW5W1Fx9NySeHXAhSOyJirSUgNg==
X-ME-Sender: <xms:VDZsaNP5acTnpQ7AFTeKOwocochERJuV7Wv_9HRPSOsomw1i1OPPlQ>
    <xme:VDZsaNGtLFW3iOPA4fQuO-ExI2F-be0dItMmy24MhZHID77FUA7-3wa04f6Y0cR-i
    nl_KrLSWe7ubqxeSQ>
X-ME-Received: <xmr:VDZsaLQh2ObSFKvx9hUkHW0ItmWMuM84EkFqAB96E9jDEFaXRRwFhRSrbLLZA8AWrJVPXnh9dk52UlTe15zTdaZwf5iHvWiY0wl0dt8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefvdekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopegtvgguvghrsehlhihsrghtohhrrdhlihhurdhs
    vgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:VDZsaKtZd_iGHXMN89stNb-yzZEE33QbiYqkhAmw9W53Qkfjzum_fA>
    <xmx:VDZsaDIRdvCZqdO8q-GfAqcgLX7CGoR9GNRIJ3NwPqtEmXsU2SGSGw>
    <xmx:VDZsaPmYk_RefTF5teOe4ZSVizyOlUpDkqOQojdTnUhj0aQRH5rhsQ>
    <xmx:VDZsaMJHwZUL4iX6rJ9YX1Is26kPuM2-BtJ24kNJV5k9WItp65YNWQ>
    <xmx:VTZsaC1fxAL8o3YFasJWRLwvdUZM62JD4zzYM6Y7_q89YgBSkzLZCuPz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 17:04:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  Per Cederqvist <ceder@lysator.liu.se>,
  git@vger.kernel.org
Subject: Re: [PATCH] remote: detect collisions in remote names
In-Reply-To: <20250707202801.GA3115893@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 7 Jul 2025 16:28:01 -0400")
References: <CAHx6-Um1dq0xJ-RkW+qXe=sEa6JGViSJxjzNw56u55DHLYoT2Q@mail.gmail.com>
	<20250705165750.GA1951664@coredump.intra.peff.net>
	<20250705185842.GA2496172@coredump.intra.peff.net>
	<aGuP3Q5xykmRNp0m@pks.im>
	<20250707202801.GA3115893@coredump.intra.peff.net>
Date: Mon, 07 Jul 2025 14:04:19 -0700
Message-ID: <xmqqtt3n3e7g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Jul 07, 2025 at 11:14:05AM +0200, Patrick Steinhardt wrote:
>
>> > +static int check_remote_collision(struct remote *remote, void *vname)
>> 
>> Tiniest nit: I was a bit puzzled what the `v` in `vname` stands for, and
>> it took a while until I noticed that it probably stands for `void`. If
>> you end up rerolling, I'd suggest to either call this `payload` or
>> `_name`.
>
> Yeah, it's for "void". This is a pattern used elsewhere for callbacks
> (usually as "vdata", but here we didn't need a container struct since
> there's only one item). I think "payload" is not a term we usually use,
> but maybe just "data" would be the usual thing (we only need "vdata"
> when we're assigning to the non-void data type).
>
> IMHO we should probably avoid the underscore pattern. It's OK here, but
> it runs close to violating the reserved names rules (a global variable
> variable _name is bad, and _Name anywhere is bad).

"name_" is available.  In fact I think it is a very common pattern
in this codebase to name an incoming parameter with trailing "_",
and assign it to a local variable with the right name and with the
right type at the top of the function.

> AFAICT "remote add" allows anything that parses as a refspec, which
> implies that refs/remotes/<name>/ passes check_refname_format(). And we
> don't allow backslashes there:
>
>   $ git remote add foo/bar url
>   [no output, $? is 0]
>   $ git remote add 'bar\foo' url
>   fatal: 'bar\foo' is not a valid remote name
>
> I don't think this is platform dependent. It's coming from the
> refname_disposition table, so we're not calling is_dir_sep(). Only '/'
> is marked in that table as end-of-component, and "\\" is forbidden.
>
> So I don't think we need to worry about backslashes here.

That agrees with my understanding.  Thanks for carefully checking.

