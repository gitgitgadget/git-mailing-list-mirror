Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE27F313267
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775836068; cv=none; b=B4Si/8rDouveD8g8Q5DonI8b0FxtO32ZygebJDzwnsWmkt9I8CBeGSNroinbWC+4gLcU5QTWPnbcZScWfSioLLi6fDmhoa+2wxpfuYmKnsgKAlD7Kq3oOYjE7lVmH2ob8plZmzRXlpd+RI/RfREtunGUHWa/25Mlhp+oz01ymPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775836068; c=relaxed/simple;
	bh=YMHkmZcyH4bI2XU8tprFvQ6gbImOLpF4J5B4brh9cLk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eDTZ2toRExrE8gjsYrThKfinqmjtk/1Eqhrb9wECOwgIzrAT65ljqY5/KwehY8TLY1T2Qv58sRRRqkGlCWVxhp7+JGH1LI9t5yYaPyYOIriebknABGi2N1aDVNCbQNGo5av2tx0pqAEZQ2rlze0R5UezO2IcXGF0IPy7t+vPVv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yVAKVqQs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uZRM3va8; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yVAKVqQs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uZRM3va8"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 38CCA140013A;
	Fri, 10 Apr 2026 11:47:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 10 Apr 2026 11:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775836066; x=1775922466; bh=KR+jWJWaCw
	e2BLDLJY8mtO2hd3AiEVe29+F67wF9mR0=; b=yVAKVqQslrxhgUpqMfIBb/2Ek0
	GlgdHFCgarZapbjs2LDK/GLklkuf4CgHkGeNh7K2/VAhFinIJ2F+mkO0d4drMiMH
	gsV8jj6Lk4q1teQ6THbgJvh+1PWqajQqSnex6432kqLW3+LDEwAIzloDqRAxCZ9x
	FBElmqlmPROta3/Pr/bR5WC8hXbLf0jWZjhGRa0KYBNnMWsxvVPCvnzes+peOw6u
	IF/dG4DPISANojhykWFbQykVHu5xV6mZuG4WbLmXrDdcx6QrVVAGFmYnwid3SW5s
	Zs4i95C4XUE3ZcSsbF9kPxd1xcqWsESCCsMtt3xrsuSULrIHx+6baBXyuxxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775836066; x=1775922466; bh=KR+jWJWaCwe2BLDLJY8mtO2hd3AiEVe29+F
	67wF9mR0=; b=uZRM3va8LsDzjQVQFsT3tUgjFtjhajdDGWSMO99R80DGyTx95u4
	qufjGbMWV2GldjmvVbHijF6eH5Er5JAlhcJkncvL4rmJfogEiGh+5mi+j7yVWwxe
	8jHddQ63nwEPtcU5vGd7V6OcHlq7UeRtqwnOCahc482FBWoXtc3vbGUHPi0QN5A6
	9Ibezrc80xoRpLIg3ALNT1luZOqFLYnKHDMDoQEuS2CGexGcRvVGnY6mB+Mt+PpR
	u8hk07tpWITQ1Fvabw9tPE0QJ1PgauZVubvRUOVeqx1Ienekmx8T0E4ry/3RfEOO
	OW8a2z5mToMDqHTP+8k63xO+/zeTewaGx4g==
X-ME-Sender: <xms:oRvZaa5HBvIV8C4-O8AUX-RXrkGXanVvAjoDgF7p3AaTA2iAmlYGuQ>
    <xme:oRvZaWe5Ltz2wDyyQo0XnqEYaW4JH68obDbT7g0QqtIHPuojeNm2uao2PM6UwRvaz
    -bFuCqdkie2LtvNv0JQ3j1drf6x6G3ulEA_YWuq4cBzyVgI6Mdu7g>
X-ME-Received: <xmr:oRvZadFPiX4WucDjvhw0y-mMtICtibLOM2L61Ee522X3l60xqZF4V7-tAQ9VzlkgjtKO8YOY22mlYM189joPTJWMnbTNLGwPag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehlohhrvghniihordhpvghgohhrrghrihdvtddtvdesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvse
    hsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopegtrghtsehmrghlohhnrdguvghv
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:oRvZaXR3ZR4n7eVEmJ8mxqwqcR8MW10q_0m-bcan0tMvnHRlJqt8gw>
    <xmx:oRvZaTZE9lIH9DwSW4aJAJ4-nAb20PSconSCZBEA2eo7mUBvZCETog>
    <xmx:oRvZaS1FjVvFLF-HIqDkGNjwujBYqGKeZzeebxokW1CzsRzU360JaQ>
    <xmx:oRvZaWrez3sZZLURQpzfoabiH4MmwYy4I9yUqNBZQMxHAwfNjws1ww>
    <xmx:ohvZaZPZGU2OHGUTbEsx2NxfvN4_Q6JAhU6ItoWTrsn5-5eoPlSACcoK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 11:47:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Patrick Steinhardt
 <ps@pks.im>,  Derrick Stolee <stolee@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>,  Tian Yuchen
 <cat@malon.dev>
Subject: Re: [GSoC PATCH v4 0/5] preserve promisor files content after repack
In-Reply-To: <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
	(LorenzoPegorari's message of "Fri, 10 Apr 2026 17:01:26 +0200")
References: <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
	<cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
Date: Fri, 10 Apr 2026 08:47:43 -0700
Message-ID: <xmqq1pgmrf4w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:

> QUESTION:
> The "CodingGuidelines" explicitly state that:
>  "A C file must directly include the header files that declare the
>   functions and the types it uses, except for the functions and types
>   that are made available to it by including one of the header files
>   it must include by the previous rule"
> where "the previous rule" is (if I understand correctly), the one related
> to "<git-compat-util.h>". From what I understand then, I should have
> added an include for "strmap.h" (which is needed for `strset`), correct?
> And if I am correct, shouldn't "strbuf.h", "hash.h", "odb.h",
> "string-list.h" and "strvec.h" also be included?

If you are using any of the facilities declared in these header
files in your program, yes.

In practice many header files pull in other header files for
definitions they themselves use.  For example, <X.h> that defines
"struct X" may include <Y.h> for the definition of "struct Y" because
the former embeds an instance of the latter, instead of having a pointer
to an on-heap instance of the latter.

If you use both "struct X" and "struct Y", your program may compile
with only <X.h> included without <Y.h> included in such a case, but
the guideline suggests against doing so, because it should not be
relied on.  The implementation of "struct X" may change in the
future and stop depending on "struct Y", at which time <X.h> stops
including <Y.h> itself, and your program would start failing to
build, because you use "struct Y" but without including <Y.h>.

But in practice, use of strbuf is so widespread and the header is
included in some other headers that do not need to, so your build
may happen to work without including <strbuf.h>, for example.
