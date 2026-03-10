Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C535E34844C
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 19:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773170351; cv=none; b=FSJl5b1FJ1GGAmGyxiHn3Fgg2G5fJ/ZXEHC6WsgWApUXZT9mPPtcslb5A6a4QtGTDdbdbITBhpJ7ttt/TDEEv7XkWIQZ8nvtZ7rtOBsKpMPXnQ0o3cVoXCB4tGoB3ulSQS3OPjk7dHgDORPQIWuODDtH9o1/TgVGPCNwVxXutYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773170351; c=relaxed/simple;
	bh=ejosiDbbSSCmyEwPyLEZmTGDbNJ4cPPGPKq2YvqBoTU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ibXlyX1h3SWhq3d4VlDswi0tV29euyY/gU8Q7f26PhW6zGAifk9STk4szjusyz/ojcQaYT9w6/NAYQZ6HrBCBXJeVA2rkdNwxNBr/suZsqxE9n3ecrU/Xg/qthJdH9IVMcb2MLX2Uuf5+epyJhOruCTyZ87Zcz00Wzn993/Ig5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i128/ujk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TWyq9YBq; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i128/ujk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TWyq9YBq"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0A0B3EC05A7;
	Tue, 10 Mar 2026 15:19:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 10 Mar 2026 15:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773170349; x=1773256749; bh=WbRANWIfpz
	/40YsSnhltUpIJpxOcS1Jw4aIpQvHKZVI=; b=i128/ujkyxRswsFf4ZuNyyUht2
	0aFcYy+/cNQ8RYTH2M5lx9g+Q+xXyXf//ALAbzXf6d/np6cQzMKHFnEiFNDqImXS
	VrBzb0NNwomCumF3bjpExbgXj5/sQT+UeYCJF5Mz/xv4aeUkqTVA/VCi2Gju0nIq
	CQzqjxfoYVQZgV1XuUqyYCxryJjMgCEsaoK3oFAF1R4do6mu3WGahe3jIt1FWQcU
	rXh9gX4g7Vh0blWNZVU/VCNl/CPUWwDlRI+12kQ6bGJcyhlmb+iM3cY4KDJYJL7D
	1CDUytsdV/hvz/NViGj/C9qSgphlfn3lLNR87ip2LzJ5u/OMepqcnQeI+/KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773170349; x=1773256749; bh=WbRANWIfpz/40YsSnhltUpIJpxOcS1Jw4aI
	pQvHKZVI=; b=TWyq9YBqJ5dMGimwWMBk0M0VjH6kgJKQCdP9T7XQ1LmpuF1Dn4A
	EUqjg/oQg+PnTrClwvSLzPnmoQ3jOKhm8DtVWe+P6420LmuvcrCJRUqP7sj4QWvd
	PO0h93kuGgR860vT/aW7oGqYeEK4uk9CzUZRch1lixQLZgixBvKAjaHjRXEaR8we
	7dKN6Es0S5oFYIgAOcz07m2R3HTc9sgeYzOjqBZOuH1oi36g86zkLQr2MYTBC5Fv
	cYKecmjP0vBRWz9X4tW0obx9Kfspf651hmP+Rvnbpjdhsfw0RWwV7vAAXTeYF1KM
	M5Xc66tqmEiNExPRIEHQf9LQqL2LP/Ck73Q==
X-ME-Sender: <xms:rG6waek1Jj5jnrgocqXp_C9IDgGmUNJaWkHzZmaV1WFFx7ceZn6Jnw>
    <xme:rG6waZiL8YIhQqPdnfQWeazfZqXdiiPLTYpsiy57udBTJfkjQcpSvaOTey3ygW0VY
    5Q71yQRN15VjwQNvZhobTceLnKP63XCbl0s6xOTz8YvPj3-TuDsag>
X-ME-Received: <xmr:rG6waWdaJo3vpO8sVxDh8T7x5ma7ROz-fYoxV4NBLJXUWJIqUYNOahzXam3W65NBA1mlZAMbETkE4-43gNL9isxOT_u_aahPqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedukeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homhdprhgtphhtthhopehvrghiuggrshdrphhilhhkrghushhkrghssehshhhophhifhih
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:rG6waZh3bhsQZb206f0AdYserWsnIIwCvJ0zpVRouS0uRpTvV2vQkA>
    <xmx:rG6waexKEWS_YLE7koP8cJQsszPmRc3OjP99kjp9XeEgWOKyYBzlJw>
    <xmx:rG6waVMNbW1rBTvOY5ejQuyZxGbk3HGpCfoPmpdhkf0E6hHembgNzw>
    <xmx:rG6wafW08-FV9sUgpuh1e241HodXw1T2NVEn3HuIX8fF8HtsUgThVw>
    <xmx:rW6waZdF7Cr8liHeinJI7fBrMn5na1uBhOmGXU1rPjEYpBVeVLknYz8L>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 15:19:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Vaidas Pilkauskas via GitGitGadget
 <gitgitgadget@gmail.com>,  Taylor Blau <me@ttaylorr.com>,  Vaidas
 Pilkauskas <vaidas.pilkauskas@shopify.com>
Subject: Re: [PATCH v5 0/4] http: add support for HTTP 429 rate limit retries
In-Reply-To: <20260310191019.GA589481@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 10 Mar 2026 15:10:19 -0400")
References: <pull.2008.v4.git.1771423748.gitgitgadget@gmail.com>
	<pull.2008.v5.git.1771856405.gitgitgadget@gmail.com>
	<xmqq5x7nknrd.fsf@gitster.g> <xmqq4imo1sse.fsf@gitster.g>
	<20260310191019.GA589481@coredump.intra.peff.net>
Date: Tue, 10 Mar 2026 12:19:07 -0700
Message-ID: <xmqqsea7trv8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Mar 09, 2026 at 04:34:25PM -0700, Junio C Hamano wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
>> > writes:
>> >
>> >> Changes since v4:
>> >>
>> >>  * fix only strbuf_attach() calls which don't need reallocation
>> >>  * remove patch, which enforces strbuf_attach() contract via BUG()
>> >> ...
>> >> Vaidas Pilkauskas (4):
>> >>   strbuf: pass correct alloc to strbuf_attach() in strbuf_reencode()
>> >>   strbuf_attach: fix call sites to pass correct alloc
>> >>   remote-curl: introduce show_http_message_fatal() helper
>> >
>> > These three patches looked quite reasonable to me.
>> >
>> >>   http: add support for HTTP 429 rate limit retries
>> >
>> > I'd feel comfortable to see somebody more familiar with the HTTP
>> > transport code base to take a look at this step before we declare
>> > victory.
>> 
>> Any volunteers?
>
> Sorry, I'm way underwater on things I could/should be reviewing, and
> this one was quite non-trivial. ;)
>
> I just left some comments. A lot of it was about how to more cleanly
> integrate with the http code (which I admit is a mess, especially with
> respect to which "layer" things should happen at). Some of that may be
> debatable, though I hope we can make things a bit cleaner.
>
> But I think there may be a logic error in how http_request_recoverable()
> loops, which certainly needs to be fixed.

Thanks.

