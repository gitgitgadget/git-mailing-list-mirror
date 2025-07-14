Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D9525A34B
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511057; cv=none; b=p3jQBL5ZUXxXBHz0fJqHrnIysKvfhwGWOrIFSeSYAhg7b+/HwS6LsiJTO5SGldJ7Pr/W1dNeB4S7+IDLIm5h9GlUqOwYrqYYgG4rUtxOTW2QMqRlGcGl0N1ibmKUKODKjAEjUt08Bt5H3ZzrVS76iYDCf1jfz/D8r9wRY9ya6+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511057; c=relaxed/simple;
	bh=PC25EklDo6ai0uoRx85gxy1U3lNVYjPWQLDGEoBqSlI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=um2hdE2rIrp17K7Fb+ki3Ehu2T15e3QFylhZC0XCq827AJf1m1D2IVblzMKhQDxBqAsk2Z5fLb0EH3SXG3TUAhaDbmt95Rw24DXetvDjyfcfnBBM6bTacXNLMZT/MV+cLqUxNlcq9UZUQPuQ0SqIYYDnxm8N8H9ZAKwsy5Kcv6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TxZY7PGQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MHIrFAyk; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TxZY7PGQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MHIrFAyk"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 702D014004DB;
	Mon, 14 Jul 2025 12:37:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 14 Jul 2025 12:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752511054; x=1752597454; bh=KRxkb+vnw5
	tSPQomcipRuWYuKPiOx73k0zNs6QZkDZ0=; b=TxZY7PGQjDUpCLkEF8xoFg8HI8
	Vz0VrVK3okC/A5JHFPsyoKkR+WvZxynNyJPh4YnPPuulLVd/1GCUs8DhMYqkVxrF
	trDaOiVGtoEfMFhmTWfDLuxeg6+J7hCiqjwBVA/lD0C3fzS8qY6Ofns/hxY1fmu8
	a30pQne+PeK+q5t5oQ+vM/rBBGuyrwyUyRAFHimQWI18DxSbM4BVN4oH9KdTA0cc
	FyEgATHq0p6SJWL6bKCoYEmNvrmCnVRndir2w0Yg8EYkbB9/7L0yh1OLgHCxKm4t
	6t66mm4XNWYf40mAjzCI1EYO4nJOU/lAW7gpadBD9Q9+LxdYqJSVN2bZOYkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752511054; x=1752597454; bh=KRxkb+vnw5tSPQomcipRuWYuKPiOx73k0zN
	s6QZkDZ0=; b=MHIrFAykRRPE7udYwPnZYEPK83ZSa75OM5g6ZUf5RGQGRcxnilY
	h0G5wqK7kWJDk3NdVThPXqmU/QCTSwt1jn+r7d0DNi5BahJCckwW/aQCPjzHg/Yx
	kmRBVC93RaGSj1qc6IkBc0U4jmtaojexyqYVGEOUFxiiMviYBf+uAZ9Z1F1SP+MA
	hNn6lyE7uxUN0jl+5YyjmiaTcH1Djq/1B03MPFf1TUAqtPSYQE8zTiwg1CS003fC
	6+51YPF/2hpl8rEdI8C8P55vcZynBiInIPdbmVqCzUQUwyN++ok52b3uBOmMI8xy
	6gBZe+7wG1KQVRs0XSsne7B2ZYOtl+1/vxA==
X-ME-Sender: <xms:TjJ1aCMCHVRAObMNFfZSZX7mPTPxsdjm6zsPG0a8N6ePvnS7lDlmAQ>
    <xme:TjJ1aLhoc6BfBQY6-eHWzbI-TMPqKUYqqox_uUbGDIBEQ3hLIRjIBunwDkUdu5oPR
    vmJJyRQ4yD1R4q6Kg>
X-ME-Received: <xmr:TjJ1aF30-PP7U_L2P6-KYy0o1oiZeevcJWV4HCMNChZ23CgkL4P9TSrXO_bvB-o8Ar2D1URdul0YLp-4tqnnY_4bEjOjxj56AWc17Xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehvdeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:TjJ1aFjPiCUeM9UJTI26XZMNfU5WqvPFjjAKAJTn4BN3C-YaxmN6PA>
    <xmx:TjJ1aFemP6nMEH4p993FYB8SrnD4MBBmr4N_x3TOhiSeDcqbz6H0hg>
    <xmx:TjJ1aIkQq5G8BPGjQdQ63_Qh4z4W1Qy2OSNJdXeGZohsPgCrK0KYLg>
    <xmx:TjJ1aOsGKt5a8TLlHCefx-WAfYYinxHb6XyslUgWl-hWOWu6szidGw>
    <xmx:TjJ1aD_LfOqd34jIZwBjameeRfPeAz0vyXkyzxtrP0Uha4lCuo89ARYw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 12:37:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/3] CodingGuildlines: allow the use of bool
In-Reply-To: <352f80c49b74053d611e7d64991fed1c16d857a4.1752499610.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Mon, 14 Jul 2025 14:27:00 +0100")
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk>
	<352f80c49b74053d611e7d64991fed1c16d857a4.1752499610.git.phillip.wood@dunelm.org.uk>
Date: Mon, 14 Jul 2025 09:37:32 -0700
Message-ID: <xmqqv7nuu3sj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> We have had a test balloon for C99's bool type since 8277dbe987
> (git-compat-util: convert skip_{prefix,suffix}{,_mem} to bool,
> 2023-12-16). As we've had it over 18 months without any complaints
> let's declare it a success.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  Documentation/CodingGuidelines | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 6350949f2ef..528b42d1dd1 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -298,6 +298,9 @@ For C programs:
>     . since late 2021 with 44ba10d6, we have had variables declared in
>       the for loop "for (int i = 0; i < 10; i++)".
>  
> +   . since late 2023 with 8277dbe987 we have been using the bool type
> +     from <stdbool.h>.

Let's see the other ones in the same list.

 * initializer elements that are not static (used since 2b6854c8
   (Cleanup variables in cat-file, 2007-04-21), declared official
   with 442c27dd (CodingGuidelines: mention dynamic C99 initializer
   elements, 2022-10-10).

 * trailing comma in enum definition (used since e1327023 (grep:
   refactor the concept of "grep source" into an object,
   2012-02-02), declared official with cc0c4297 (CodingGuidelines:
   spell out post-C89 rules, 2019-07-16).

 * designated initialiers for struct and arrays (used since cbc0f81d
   (strbuf: use designated initializers in STRBUF_INIT, 2017-07-10)
   and 512f41cf (clean.c: use designated initializer, 2017-07-14),
   declared official with cc0c4297 (CodingGuidelines: spell out
   post-C89 rules, 2019-07-16).

 * variadic macros (used since 765dc168 (git-compat-util: always
   enable variadic macros, 2021-01-28), declared official with
   56a29d2c (C99: remove hardcoded-out !HAVE_VARIADIC_MACROS code,
   2022-02-21).

 * declaring a control variable in for(;;) loop (used since 44ba10d6
   (revision: use C99 declaration of variable in for() loop,
   2021-11-14), declared official with 82dd01d8 (CodingGuidelines:
   allow declaring variables in for loops, 2022-10-10).

A year and a half sounds roughly the average timespan.

Will queue.  Thanks.


