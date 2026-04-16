Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DC93612D5
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 20:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776372150; cv=none; b=X+FIUXEY0IJzBsdY+HVpB2jk1mJhPKxn7Tv/3SEzXK/ij8jcgjRCV9jzUKqRrF928PcffOq6ftrlJt52RP93TPTzb2iBaYLkJi2y/v+sS4xQLP/RHMFeUs3CNAuV84eYSvhOlKXh6bW5WlWIPpwuBC62z6iz0uzuWqV0Q2Yxg38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776372150; c=relaxed/simple;
	bh=mNVq6Bgc14Ciiw9BuukHKtZeyY5DQQWXX+8C4sLj8F4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HcSZnWMLmugz62ocDJCv9bBYl+VUqveSjSkGjEJHJKbWh4VA9xyjY3JfxfES0MWVKPqbAYzPZh6uNQVRK9UzVfLSuEbgJR/Zw3sjJV6XoPGtEWKt2CcGqTV5yeUCHRneA8bWMqzR3d7FoCwx0+aB9MdKo8VWmLsd60ctjcKIrCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=q8j+mEtc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GeuhqwrM; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="q8j+mEtc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GeuhqwrM"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 7093AEC0085;
	Thu, 16 Apr 2026 16:42:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 16 Apr 2026 16:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776372148;
	 x=1776458548; bh=p+D7H2RbZBMqPkwYoPt3XekhTVQU58bTTFisa8Nbz6Y=; b=
	q8j+mEtcopjU74BLgRAg45zmu/5PbsPNpIKQMDwWOi6UqXVEnGCQd/bvr+6dAzr7
	NQQgDwbt7oO8VX/E3q/h5LIu0N1U6tGnmwt9OobIwH+0JErZoLgZrA4fguHiwFc5
	Bwva9kh6eebiqtQ5FtuI21LS83w/hWmI43oXyrkDgxRbgQe8dRkGOF3TfmMDwWPj
	6c2varXQ3BVSSjltIzq2UXSdj9FzSF0MvK6FPH3Ohy4dIP6TB/olQLivfv3upqrn
	MYQhHWOaBHK3vt7V6vDozb5W3+JXm4/fcgyckBh2+yPYJF+HgHoUTn7ICTd9J3Vs
	XhYdoBcRF9GdY+3VbZ3OqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776372148; x=
	1776458548; bh=p+D7H2RbZBMqPkwYoPt3XekhTVQU58bTTFisa8Nbz6Y=; b=G
	euhqwrMf3OBn10AO541T53Tn+fUPHD2I0/mtpMeTGme6p1uHWp8Ir/l91NXSnPSf
	o1ro1ntlmhopuoHvjE7mHgBDFaE2JCrkKJ3Z16jsGI46syG0VpS92ZJ2ZKjNUNRd
	7iBBb7o30qpN7rmY/BSYRBSVJVCkorwxXuPZa6l9IcAKga4LSwgWz7N2pLTtcEnS
	B20ZXIrTCu2oysPqhOZZ9/4BJET7sk3yZo/r7C/0oIxlAwXUo2TYB+tnPocMjf5w
	kVSjWH4AUmIx+WU8mmUbV4h7TlB3vrQAME4NhB7XFc03gh/jQSGwGw1VrwO5Gs6K
	qDlQQ4JypMe0qFu2n8Hxw==
X-ME-Sender: <xms:tEnhaW8W04aNHCn0a6ohI2cucFzOR-i285vxBRygzWBXhjQP4GzggA>
    <xme:tEnhadktiRmUAjmvAIkAlj30Gm5A2TeHWXSsXz8Iwerhvjl4MPmtxV0yLSZO8KFbk
    28SQsVXxymdzPykrlSNphtIvTuNIkvthkixV6BHaRzGOKRwllVAjg>
X-ME-Received: <xmr:tEnhaUUOuDOOCps7zGddn3mzsK-Te_q3A88XLvuxxmiDeaiB-T6tR5IzEHOUIjQ_FPxzDtXWiEUWfX4AcgBZmXQrTlG4gq5eZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjeellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekofdttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepkefgtdeuvdejfffgheeufeeugefhtdejhffgkefhhfetieffteehleehtdfg
    hedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tEnhaaE7beUf9QwFejkuoajkJ-L_nlIIIvC4_kcDb10xmKqLh8uuGg>
    <xmx:tEnhaYfGlp4ENE2Wk25k66_jL8D6mQ9GuUOkoPrrzjr9s6E-QxVztA>
    <xmx:tEnhaTIrABd-UispsexBXS7CRc8i1PoM2kJ_Rjs0RDW3SNK934nJhA>
    <xmx:tEnhaVGYMnb82YUxPlg8yRRC5YKSro1kOAK8lChshkZyj6ZsUMmg8A>
    <xmx:tEnhaQmE77A1PZeFdiiVHIzguTHl1u58Yxg3KWFK20XHlEJVRmjDEkf7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 16:42:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v3 11/12] t9902: fix use of `read` with `set -e`
In-Reply-To: <aeFCqhGIWQgE9lq6@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Thu,
	16 Apr 2026 22:12:26 +0200")
References: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
	<20260416-b4-pks-tests-with-set-e-v3-11-7a90e5dccadd@pks.im>
	<aeFCqhGIWQgE9lq6@szeder.dev>
Date: Thu, 16 Apr 2026 13:42:26 -0700
Message-ID: <xmqqbjfizlfx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Thu, Apr 16, 2026 at 01:19:28PM +0200, Patrick Steinhardt wrote:
>> In t9902 we're using the `read` builtin to read some values into a
>> variable. This is done by using `-d ""`, which cause us to read until
>> the end of the heredoc. There is a gotcha though: when the delimiter
>> isn't found at all, then the read builtin will return an error.
>
> The absence of the delimiter doesn't make "read" return an error, EOF
> does (that's why a "while read ..." loop works).

Very true.  So for this kind of "read", failing is the norm.

> So AFAICT what this "read" does is equivalent to:
>
> refs='main
> maint
> next
> seen'
>
> Isn't this much easier to read!?  OK, the first ref is not aligned
> with the rest...  But I admit I had to look up the docs to see what
> the empty string as delimiter actually does, and even after that I had
> to add a printf '>%s<\n' "$refs" command to the test script to see
> what's exactly going on.

Yes, whether "set -e" is used or not, not using "read" there makes a
lot more sense.

