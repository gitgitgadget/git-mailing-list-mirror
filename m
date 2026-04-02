Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D673570DF
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145045; cv=none; b=Vo4EoGFJz1/utJlH2sk01PvPrldiX6UGjpv4tCefQN6cuJz1AFYpeL3oLdDBJDjkz8o4SqeUA9sNxeAYvdO1dSQ3Rx1RYTE4UzVn8kTqZ0DH9sA6GbVi5vjwUAphxl724FaxKdtxSxYGKcVxD45Gtnb59lorXT/XAl666XGpZ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145045; c=relaxed/simple;
	bh=sGmGEMBaDrXbwoMzw6jMovz5HqcSA0EkR57r2nDRuAg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ICholUc9by2axeFQijPzXTPc4K2W+fBN3OLpD5I9pISD8Rr2FkqKrZPW0Q5dGnbX18f+KbXlXU/vyU0AoUM4oIQWaDOYwnzSL2Oy2AMayzUId4haHbcww/54sRZElF5U79VNG9OhOr0ySXCdCJGi6CP/FPSBuLbnMw/WKp9XZT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dbtm4kxQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FfoUpepJ; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dbtm4kxQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FfoUpepJ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 3B1201D00365;
	Thu,  2 Apr 2026 11:50:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 02 Apr 2026 11:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775145043; x=1775231443; bh=Si/BJUeHlG
	lj5nJaCq+olOaLjICKUnzjFbWEoF+czKo=; b=dbtm4kxQRUaU1MlVCnEKsNtxKu
	rQFnXHKtMRcVQYWVeg9u8UNfC48R6r76b5FlCfXpnoFjh9OOptTLyGtZX+6ClVIw
	R5VQQWT4n5C9a88HO0HTxaXagzJ13uRbWCo0sQWbgNO9TYMOxYVSZw5NfIYSPRbf
	2oPvXjxDq+AJop94v8qpb0A+brIjbh3SC0prr78SmIxalANYIj/9JdtYpWQtV+O0
	FGynnkIqgGSycT/iNFpNiN35C6j1Dg0LJ+7hbJ3m7VWkIzI3e2O8RO2hpf4Jx9iU
	C+pVSxfgFTF4iegZQwrvmCNn7ecsUxJKXfZqetIFrt8ugt/IOo3/hr5xC8BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775145043; x=1775231443; bh=Si/BJUeHlGlj5nJaCq+olOaLjICKUnzjFbW
	EoF+czKo=; b=FfoUpepJPMBP0GP1otA8sCdimatpoRWV/NyfW5qiTrmGMVk4laJ
	FXjk3fRxkw5469C/QGuucPLTpPweuVJBYg8zs2ISXHOWX6FVkog9IrvUvBHGorgc
	MPrPqMG6O/L5VaNchYRA1xOFuDO7f7y8x1I1N8n7h8w+jvyl4I7BmAV6FCZp228B
	ascy4yCRAyis0DBkWkw06bF11XJPXAvxwZxfU43513qZ0E0ZPvtnOjwU9egFl8AX
	+fNf9aU4CbPXtI3OQ6twsbF8lFsS8ojJSUUa5bYPlcfk4t5ITnF9fDYK0L3uAXU3
	nen7mxn1xK/80W9g/TjOE6bm73TkwFcYhWw==
X-ME-Sender: <xms:UpDOabwSW-r-tTa-avZM7UNrCw7Mc7BMHRDg65Vd8JvsUSRiZP9_wA>
    <xme:UpDOaW8jXeC9FWA-nY7J7Gqttyl7hIqCZq3Nh9G96a_iEv58z2sZl6ZSeNTXVpm3Y
    6ahKF7Bj-Js8W_yk0qyaEC7ISQzspebvui_EM_kri7BvNnJEQvi>
X-ME-Received: <xmr:UpDOafIqlWo7gSfL-Sww3mFabKEJ3d-zdg2VFRky9etfodlkmhaTN0qWHiXwHBQOWf64tjukZjsbvttaOFU8PD56h5sp49lIuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeigeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehgrhhusghigidrvghupdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:UpDOacckHr2cky0t0zLk3C0rcJc6jcCsNjSHv3tAPA-BqRtkmp1CvQ>
    <xmx:UpDOae9Bynpg-DdNsb5KSgEbcgmKgpTFWbkQxxgqJGAjslL60XMrgg>
    <xmx:UpDOaZrr3pjbdpsT8ETqD0Y-mevI5OY-5LDoug5LZUw6rkis4RdiEw>
    <xmx:UpDOaTAjlyoVlHFEDakzasJA27wa-dcmrK_CSrm_MkUVBsFnRu0GWw>
    <xmx:U5DOaWN_DOuDmnbQa57la6tvPMBWjjn7jUeNYsmsexa-_eXPIk1msuyM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 11:50:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Collin Funk
 <collin.funk1@gmail.com>,  Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH v2 08/12] skip_prefix(): check const match between in
 and out params
In-Reply-To: <20260402060119.GA3504521@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 2 Apr 2026 02:01:19 -0400")
References: <20260402041433.GA3501120@coredump.intra.peff.net>
	<20260402041507.GH3501239@coredump.intra.peff.net>
	<xmqqeckyt08e.fsf@gitster.g>
	<20260402060119.GA3504521@coredump.intra.peff.net>
Date: Thu, 02 Apr 2026 08:50:41 -0700
Message-ID: <xmqqqzoxs6ni.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Wed, Apr 01, 2026 at 10:11:45PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > +/*
>> > + * Check that an out-parameter that is "at least as const as" a matching
>> > + * in-parameter. For example, skip_prefix() will return "out" that is a subset
>> > + * of "str". So:
>> 
>> Sorry for not mentioning earlier, but I couldn't quite parse the
>> above with "that" immediately after "out-parameter".  I am guessing
>> that you wanted to say an equivalent of
>> 
>>     Check that an out-parameter "out" is at least as const as a
>>     matching in-parameter "in".
>
> Yes, it's just a typo. What you wrote is what I meant. Can you fix it up
> while applying?

Will do.  Thanks.
