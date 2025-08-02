Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19ACA48
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754152736; cv=none; b=ltazdaIULrQLnsHYfBQK2wF+3+MtWQ5pQ8jPKxtK7IW0y0X2CRDFa7Szy1nTS/+PB6fV0d8jJacaq0C8J/b3FPcAvH1LUEsG7/zn8CnNc2abvS9cOakIawidYCOS66iFdGNKMcGuPBkcqqmbFSfqNB+xLE7XPwUtK5g+5b1cgMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754152736; c=relaxed/simple;
	bh=nXaGRye/QZ9zpcDsYPhqcxOcx0ByZHjjRsL6FsKFgZc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oxhCwNDBtoAtzFHrM361TTNCF8XDUAVFJ+FKrhzE7URi1VuSnJdPTPu0vPKFGdDqmU2CXp1kyOcGgA4X1eJtIQmCb+Whwrg5KLlyjucdOnMtNSZjKILtjXPsHvpkbsN/Nkqm8LRL7/H8VpB5WtS7gA4nPREu1UG0CwZhwhgcGwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PD9O0R+h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nYx4ZGqd; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PD9O0R+h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nYx4ZGqd"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 196F6EC1689;
	Sat,  2 Aug 2025 12:38:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sat, 02 Aug 2025 12:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754152734; x=1754239134; bh=5ll33Zs2Hv
	0ONSioFr/gyPM+h99X5mdH7/YnVw2JrDM=; b=PD9O0R+hh3661SY/bAff/wmJ4V
	bqY8Isak4/9r3P3/m4WL/XWxi7OwlLFk2eJ+opnf+U13kqXzkX9Mcj27p5FWb1mi
	xMEVpZjahRhrbPpNaR7iDrw5TIfLtGIMTnuT5EAshc6eA5pZX7mJWd+iU4DYGL/F
	C3kdGIG63+eQu9uLgBgc8XFGeLGxVfrOj1AbLV4o492zm6ukUex3odbHtoUPqDx8
	k+hIi9mvmG68GMkI3aChgOZv9hjHRO7Gyc3jADH6HxCUWz47XNSYw8kn5Ktm1g2n
	V4dVjNQEpFPz3HIuZJaAOzXFFyRLS+X0L+FLONfkhSMLeJTDRZwCsBxghzxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754152734; x=1754239134; bh=5ll33Zs2Hv0ONSioFr/gyPM+h99X5mdH7/Y
	nVw2JrDM=; b=nYx4ZGqdF9pAqqxzawsWa+cvnDV4pSArss7l4qN4epJ6mU8fFdu
	6fxkxDb51LO6/grcKXHERwFLxSmj6uTYeSaZkBLs5xFEVqTtL4AQRlPYkDGBBQNK
	YzylkULbEgF8Gv1ziVXNBSa5bmCEOn911Eo8ITM/xie3IE0YGZzKHaw3CMzKVepA
	9ALMOaLh7SZjkTN5xEpjx2AQZVzGKqGOppTay2Sg7lc9MBzZl+qlmKSVTjQNlvXT
	qXG9n81Zz8FUYYRix7mWGF5se6iYYEO4fU367LCzGVnoNHdvWkXbpzwtYlhlWYuR
	2sr6kOTB7ZlWfdqznAtglE7orhpqitGlcSg==
X-ME-Sender: <xms:HT-OaDe20ok6UobSR_EE8aw3YlAUgJI67CVHDohK1zHUYYTk8xqmug>
    <xme:HT-OaMcHn9_R27XK_x1vHr3O13CeKM0qsQOW7aaXaD-gzXwJhKrim9ME2KMdCHXv4
    KkFkjKqmezM765QSA>
X-ME-Received: <xmr:HT-OaF-d8b2ZGkQZjYa3DOAKt5cGx81LfWYK6pcy6KUIX7ki3hDG0oldQyubYrvGt8KJwdVm6A-G6LKCOhfwUSvIztYiv05QfTDLxxk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdejtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhff
    eggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:HT-OaAnXONNkXdneaL3BfiB_GNiO15IeRwauTZmz6Jf9CHDlS_MIeg>
    <xmx:HT-OaP8lQxX4EPVha2kMLuVm0hwLB-bhl4KmaFVbfZsYAEqEQFzVzA>
    <xmx:HT-OaGlRofgoZUA5FFsugtJf_Bg1QPLWvqJUr8BY-sPZ3tw6UBdvvA>
    <xmx:HT-OaE3Azkl4AjzwnP7K3CKXbWV8JU3_bE46_gDzjnlkf35TSogwAA>
    <xmx:Hj-OaOhHivnFv6XD6HtR3n1iGLL9HvoajRhT0KvKm3r1P3i0QJE0IcY2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Aug 2025 12:38:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 4/7] string-list: optionally trim string pieces split
 by string_list_split*()
In-Reply-To: <20250802082659.GB3711639@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 2 Aug 2025 04:26:59 -0400")
References: <20250731224607.3942417-1-gitster@pobox.com>
	<20250801220423.1230969-1-gitster@pobox.com>
	<20250801220423.1230969-5-gitster@pobox.com>
	<20250802082659.GB3711639@coredump.intra.peff.net>
Date: Sat, 02 Aug 2025 09:38:52 -0700
Message-ID: <xmqqzfchispv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Fri, Aug 01, 2025 at 03:04:20PM -0700, Junio C Hamano wrote:
>
>> +/* flag bits for split_f and split_in_place_f functions */
>> +enum {
>> +	/* trim() resulting string piece before adding it to the list */
>> +	STRING_LIST_SPLIT_TRIM = (1 << 0),
>> +};
>
> It might be worth defining here what "trim" means. I can think of two
> obvious definitions:
>
>   1. trim whitespace from each split piece
>
>   2. trim excess delimiters from each split piece (which in turn depends
>      on how we handle multiple delimiters; do we make empty pieces, or
>      do we collapse them? I think the former, which would make this type
>      of trimming impossible?).
>
> It looks like the patch does (1).

True.  "nm git | grep trim" tells us that we most of the time use
the word to mean removing whitespaces, but there are exceptions.

It certainly is a good idea to rewrite "trim()" in that comment to
"trim whitespaces around" or something like that.

Thanks.


