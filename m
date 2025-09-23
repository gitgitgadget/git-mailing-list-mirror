Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D02263F38
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 21:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758662291; cv=none; b=AkhuEJDEI6xNsssly7bsUGWlyeRT471inN2EFx0RKvn7zRrQ3lp3mrkASArKe5k1DWDd8a1iKbzXpXlQopbOGEF7b/wOTK4tBOBUU/CbPdDKlnvxUGC2obgKORN0JSkb1+cjEY1ZB/3dNCmG6QTbGDx/9QVacnPp+dD0Xk+2iSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758662291; c=relaxed/simple;
	bh=4/p6XtHOGTb/sr18VDEiOTqRRC42u/x6P8DWAB6weHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iKUuQALUu+xyk/UZKsmylhRIKsqnMpwYK/NNKNDORqfiq/ZuIvGdRSoO8GwmCEtNJRVE1OYIJnHcycaEksytuxXKBgTursUYopG3swdd8GRJFjD57+gZ94lebBmv3an5M8HYphtfUU8he/nUvdJDZgTmM0N4q4CP8NxrGVvYfDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jMWjolT7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D2aov/Eq; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jMWjolT7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D2aov/Eq"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B31EDEC018A;
	Tue, 23 Sep 2025 17:18:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 23 Sep 2025 17:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758662288;
	 x=1758748688; bh=j0c4Ur2E3bn8iDfZClUNdDsAcsn6kNgGZyAY2AeZYv8=; b=
	jMWjolT7VRfKrUvrWXwmWZglC93zhGouL9iURwg9fwAIDy1cREZ53KhcuisJy+SF
	7JjMmNGbjRN+3nZoC5LYLML5H8856/O7OjC/2dvQ3UySxcJgGsdv+ATIJsyGj6WU
	dgK8N9B87fgDIjIoGqVQCEMVab2pDtA+Wpf7/0GF4GmjFsMgDL+5qj6SqPKRYeac
	tcvsBkJlZpeELslHP9uymAOu/1+lFeAlRM76de5JGYzON3OmMvUp6v9j0HzZDM4E
	Mly/wUwjaptHMyqXA/4bBgT4A9i1iyozQxU0N2hydmNSupxHQxDrllndZ+62ne+8
	RcCLJSBtwCiSGXwWnHLT+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758662288; x=
	1758748688; bh=j0c4Ur2E3bn8iDfZClUNdDsAcsn6kNgGZyAY2AeZYv8=; b=D
	2aov/EqU/9ULmFTwLF1kqbanerF9EWwWoF/yrSCGDSCpmldFUAkB6WIbjg/9Cjn/
	Kw65f8zTIgAu9KS5xKTpS4fQgXKtCz6P/Ln9AgPrjDscdCv4Eg++FykKri1ORjo5
	zaW7UnWMR7g0SLk4jm2dTdqiVkW7K9Sd+BVBdd3NoS9pBySUEQaNygGv2SXF534j
	ko0yg06AvQ0MowbM4YI1OiArq486wec7pNSPl3Hq7vyQNruczTcY94VG5QnWyNzk
	Ve17PeeH4WHzKucKC6eQtwSq9tsQLuKAlq5r9GzQpU5UTw0zSpMEailhZYYml1wE
	+WuOBNaB0bKRTKEjGwUmg==
X-ME-Sender: <xms:kA7TaKBQEpDrzxk5mM8vxWtbVPfdFITiQ4hxbo2JGVJTy64PU6X86Q>
    <xme:kA7TaL8LjpGyJRDj6G_xWsyPP7rUfwdRHHKInHlAEW1AYb7VwAzS99jrRTkyWH85P
    Mmi-9tmGZ7J-Tc7mSj8IxTEy8I6DZdceV9FQFTFuop4tpxg2lqQ0w>
X-ME-Received: <xmr:kA7TaK-imkLRZ-KGj5OC1-iHsGt_ap9o0RDOmSJPx7HHmkok7rUiiB5oZEiVY8XddmkiWjta-5xufZjx2U6Rx8Nl5HnYX-DmeT9t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:kA7TaCcCH-5uDXfYkEJcc9lKNYNZDqhhMJZQdjs9g_hnPPPskfW04w>
    <xmx:kA7TaDFweHcaWPSfmfq2lw_FIUiP9XifziQAvm-Uv6ffsxwOU0IbZA>
    <xmx:kA7TaAdM0QjpiEgwbj3HQIeBkxolVBcaC3lUYT8IM6xUjbTxylW7Ig>
    <xmx:kA7TaNGysmH_t8qs2XAGJaBr9_AaJ1bmeENSNrkWgv0wGu6-HgwgFQ>
    <xmx:kA7TaEFFjasakkFchpNE1ROSKYRza7RyNgghj8CPOURHB-0H9V2BJN2O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 17:18:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] revision: add rdiff_other_arg to rev_info
In-Reply-To: <f1da0f06-e57c-4abd-b9ce-ef3fd5ce2037@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 23 Sep 2025 19:47:52 +0200")
References: <cover.1758574974.git.code@khaugsbakk.name>
	<bb065767336.1758574974.git.code@khaugsbakk.name>
	<xmqqikharvyl.fsf@gitster.g>
	<ba9b7fb2-c990-44fb-a506-0800d02854a9@app.fastmail.com>
	<xmqqa52loyvq.fsf@gitster.g>
	<f1da0f06-e57c-4abd-b9ce-ef3fd5ce2037@app.fastmail.com>
Date: Tue, 23 Sep 2025 14:18:07 -0700
Message-ID: <xmqqtt0sookw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

>>> Could it be as simple as `log_arg` or `log_args`?
>>
>> Yeah, that is much better than "other" (where it is unclear what are
>> the "primary" things that "others" are in contrast).
>
> I remember looking at the code and having that realization: Oh, *other*
> is *log*.  Huh.
>
> ... Maybe specifically `log_args` since it’s a `strvec`?  `git grep
> 'struct strvec'` seems to give me a lot of plural (style).

If you were asking me about singular vs plural, sorry, I didn't even
realize that was the quesiton being asked.

My personal preference is to name arrays singular so that you can
name its 0th element by saying dog[0], not dogs[0].  "dog[1] and
dog[2] are friends" not dogs[1] and dogs[2].  An exception is when
most of the time you use the array as a single unit as a collection,
passing it around in the call chain, rarely addressing each individual
element.  I am OK to see such an array called plural (but of course,
singular names are always fine)..

An instance of "struct strvec" may fall into the same category as
the latter.  A single "struct strvec args" may be used as a
collection of arguments passed to the program .

So, log_args is fine by me.
