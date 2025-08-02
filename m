Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DDF1DC198
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754154604; cv=none; b=Gz8EAboeDDzLowTW+QcxJz6iIiD2lEFrGgCpX3of5gF2Q9f7AMFSXnBKVurmHutN3GxhraBlNwvxu3Z7BsQxdI/K2Ui9aK9hZVB/guOU2ba0zTnmebhxR4+aaxy3TC8mRhTab6bBL418kL9DInoXNVdRbMMxPuJib4klCI9TaH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754154604; c=relaxed/simple;
	bh=gIlazTToSQfsU68Ay4Q6zLQnI60cpXzFGVoY0r5R3K8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YNTNJNlRVqLN5Am3jiFYRfV89jhZUiKcm9mOrpP0eitB9mvkJGGHzZHXORGM5PV6RyGESC9ZhKQnx6q5vSaEldaGiKrhmvaC/cvGQdv+eW2m+BLwMZFKEWGjkGZ62oGbzwXcZ3vyChyc3+RgaTMNzcjQDPeVmn2oRFtSUNwAR48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=drqfS8+m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IJfaknCc; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="drqfS8+m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IJfaknCc"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 403BAEC1272;
	Sat,  2 Aug 2025 13:10:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 02 Aug 2025 13:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754154601; x=1754241001; bh=FaGlhfeaYl
	t9V8BYM6vpqXPAmJi9QKhL982PvHz32ao=; b=drqfS8+mGn/4Y68uXScruBlmDE
	SHxDfO8UrhHj+rpI6W5MGuINpy7LYpLiO2+i6Wayeo2tGaZBH3uVmMa7iWpUdyeN
	5N5Sfz2vgydoM1yGtaZ8qhpD0R0PowJCBoS6cy1nECvQw+MK6+rE7oB4Ba/ecjip
	ChD+I4xx4GT/kqghDML+ULgHvWi/mFQzwM7gMdUKLkCKTW7/nrsgtiKg2BwTurRe
	+7PsUeriFrJGRrdYsgLcMUS/9am6YMKBCa5LGHFdLFNKGVP2WWGj54g8TkVfgBZX
	oB2ett2Mz24zo+IuXK9PeG4umNqsDPxRVlL/IryeT0MiZmWBo8er7SV0n0lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754154601; x=1754241001; bh=FaGlhfeaYlt9V8BYM6vpqXPAmJi9QKhL982
	PvHz32ao=; b=IJfaknCcdJuY6r8dPlYtC2mTO2xsA6NU/DfCJwrhhDPoQubU3HL
	M7HD6LODHP84NAePEH/uOLhJ3sMrnN8RQDpUSvfIapuTRfXbWWUdcz3h9GSMjD/W
	K3UJyMsxfwS8K2eMHoVdQKx4AxUszqoZRLSAHtRKwNfVtG1+QSR+j6oTmqmyeDhH
	1JfDhhS131bPuQEO3UFkOA7R+SPKfPWxcHCzrA9AyA6NhuLn+P1iv1ZnJ1zYjv3X
	ZKz6ARWmBTKX5FJ/p/9bCUupEMUIVl5fT08UrSr926FYpcukV+ZKLwijxw9PZyiC
	ocIFZwZpUKd0NZjY8BKNZGF2AjkBL/zciog==
X-ME-Sender: <xms:aUaOaKH_hNdyWH6-rbyScEnGjwzH-ZMEr8cjrFHvs_4UY550uukUEQ>
    <xme:aUaOaOmFNbzCgyLgwfmNNgr8JPd09WJYdm3JCfaMusdMkWRnhqQPmqRa-1QgmuqRz
    mWXDYvobMLpQQ7FUA>
X-ME-Received: <xmr:aUaOaNndr6JDKqo47ycRTlkFfJ9gUdpRYpI9xhOFkilZaotoLESRfZY_3clzHz-5Vk3N1mvK1L2tnELRC8wsyicwsQYPca9WrONoue8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdejudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:aUaOaPvmn2Kd4N7fqrWd0W5fRl6R8rllTPzT55QFQOu-LO0uY0vGFg>
    <xmx:aUaOaAlckEtKnx6_GKLOzZoGjHskmndvEuWYuBFL9O4XpT-1hLjONg>
    <xmx:aUaOaKtPRvMBlXiCIYXOuv0P5eeusDisE5pHElwLimiyvEKC7WpNMw>
    <xmx:aUaOaGdOVt-bPDWcxdiJWsedKmQknJJmK0_LddfuOaQnd-eMT5-LNQ>
    <xmx:aUaOaEqBIzCmBVOJAPOJsWvDhmRT8_OdMUg6pRD3Wbftj0kgEm21PdJ9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Aug 2025 13:10:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 00/11] do not overuse strbuf_split*()
In-Reply-To: <20250802090825.GE3711639@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 2 Aug 2025 05:08:25 -0400")
References: <20250731074154.2835370-1-gitster@pobox.com>
	<20250731225433.4028872-1-gitster@pobox.com>
	<20250802090825.GE3711639@coredump.intra.peff.net>
Date: Sat, 02 Aug 2025 10:09:59 -0700
Message-ID: <xmqq4iupira0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Jul 31, 2025 at 03:54:22PM -0700, Junio C Hamano wrote:
>
>> strbuf is a very good data structure to work with string data
>> without having to worry about running past the end of the string.
>> 
>> But an array of strbuf is often a wrong data structure.  You rarely
>> have need to be able to edit multiple strings represented by such an
>> array simultaneously.  And strbuf_split*() that produces result in
>> such a shape is a misdesigned API function.
>
> Yeah, I agree it's a bad API, and I'd be happy if we could eventually
> get rid of it.

I'd be happy to mark it #leftoverbits for aspiring Git hackers to
look at.  Perhaps a good microproject material (there are still
several instances left---I talked Christian out of adding more in
the series he is iterating right now).

> Conversion to string_list mostly makes sense (though I especially like
> the case in sub-process.c where we can just parse with skip_prefix()).

Yes, for that one, strbuf_split() was really killing a butterfly
with a musket or cracking a nut with a sledgehammer; or whatever
translation of the idiom you'd like ;-).

> I looked over the patches and didn't see anything objectionable. But I
> tried to think of subtle incompatibilities we might run into:
>
>   1. I saw the different handling of "max" you had to deal with in one
>      patch. Yuck. It might be worth tweaking string_list_split() to
>      count "pieces" (which is how every other split function I've seen,
>      like the one in perl, works). But that can be done later (and is
>      tricky to do safely, since we wouldn't be changing the function
>      signature).

Yes, I think I whined about it in one of the commit log messages.
That part is one of the things string_list API gets wrong, which we
may want to fix.

>   2. Is the handling of repeated delimiters the same? E.g., if I split
>      on "/" and we see "foo//bar", do both split implementations yield
>      the same output. I could see either of ("foo", "", "bar") and
>      ("foo", "bar") being produced.

Same between?  strbuf_split*() seems to be happy to produce an empty
piece in the result (and there is no "omit empty ones" feature).
You can choose with STRING_LIST_SPLIT_NOEMPTY both results, but for
a straight conversion, the vanilla one without that flag would do
what we want, I think.

> And...
>
>> The most common use case of strbuf_split*() family of functions
>> seems to be to trim away the whitespaces around each piece of split
>> string.  With modern string_list_split*(), it is often no longer
>> necessary.
>
> Some of these sites do strbuf_rtrim() on the split pieces. But
> STRING_LIST_SPLIT_TRIM does both left and right. Is this OK? I think so
> because in both cases we are already splitting on space, so we wouldn't
> expect left-hand spaces (of course you could have a stray tab or
> something, but I suspect the new code matches the intent more closely).

I did wonder about these "rtrim-only" callsites strbuf_split(), but
I did not think they needed ltrim, since they were splitting at SP
and rejected when the element were empty (remember, strbuf_split()
happily creates an empty element in the result).

Their use of rtrim() is primarily when they split at SP they want to
remove that SP (remember, another misdesign of strbuf_split() is
that it leaves the delimiter itself at the end of each split piece).
Both 05/11 step for merge-tree and 06/11 step for notes are good
examples.

So in short, yes, the new code is being a bit more lenient (the
original parsers were more strict and insisted on non-trimming
behaviour).  We might consider tightening them by removing the
STRING_LIST_SPLIT_TRIM bit to be more faithful to the original, but
as you may have noticed, doing so would make it more strict at the
right end.  The original that split at SP and then rtrimmed allowed
trailing HT after the data to be removed, but I do not think it was
part of the designed behaviour of the original anyway.  So I am
inclined to say we should probably drop STRING_LIST_SPLIT_TRIM;
nobody would scream.

Thanks for carefully reading.
