Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B04824BD0E
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157880; cv=none; b=pxEbk9xuyuN2Tp4/w01jQfld+nU+vK7As9LAR2IRsyP+HkpfFyzYPGZ/EWrgLhphIj8fcD0iyyRidb1r25z3BYJ3xNKvGT3eh1BpN2tzAbnpVWtu7aOs/gXIV5wrvvuq91iNYddxEdbiJJidFTCe+7XP+gl+P3SGuFbkIn40JL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157880; c=relaxed/simple;
	bh=9+KeJ8BR+xyhxUHu/SR1UypqaNfegT3V9uX9ynMXbDg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rw/AopExga9JPocrQ0ZxLY1VLQObFzagk1Cvm9Q7S6Lri4wCchTLoQKf+rv+cZyqltwVHrOhH+bof+suf31Y2ks20E/Hu6j6YsM5fIYOf9WqezW9+x8mhGWnKuvr7fwP0ZoHCPx7ImomIbac2ZM4Tc8PFiyoln4FRua/lXCzuE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eHKmfF8t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FWuVS7Hh; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eHKmfF8t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FWuVS7Hh"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 556941140095;
	Fri, 21 Feb 2025 12:11:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 21 Feb 2025 12:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740157875; x=1740244275; bh=zR0wXy7oQe
	Y09cna58f/4figtVrjoKnzY9xCwDNv5CU=; b=eHKmfF8tU0gcRzY7PRffEQ101W
	J7HK8JhGyDolFxIQQhamYxETB6bbpsTVawlt+0fbTpENodXvU34wfRYz9Np1FcQs
	DdSPZTnIHxwOJnv7SbipuY1CPbzjqE0XWxAFM6KPfGMy0lKpIc1sBRaeJenKRStW
	LBVU2wrELNwCsAFUr5dJ4HKxJvPxVnLRKfn8a0yHJdS9H5zDVt2IBsuVJoqZap0y
	zYKSMCUe8hXMBog3DsZfmwYII1VENngGMd0rUen9EV2HIUKObli7FYdTVv3TIs0j
	RjTSUJIHq57OUd1SoPn1T3RrgZc9DGyd2G+1YvZe4M3Oap/5/rnsJ+gIM35w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740157875; x=1740244275; bh=zR0wXy7oQeY09cna58f/4figtVrjoKnzY9x
	CwDNv5CU=; b=FWuVS7Hhus5chfXVyQ4J4TcL+dTCs7PYtnWJQXka43UxMN1v6/n
	2CUn+vxNzTn8Ij6jQfuTD+7gLTFjIYdl5y9z5SC1IEmasCeAqXDpp0k/DG+TYdlg
	LGBEuWY6IC9WUFupO5g2jmV8zv7Zv1s+XdlptBaI/oj5llsGCp7Cv5w4vsGeK1dA
	IJGxPIMhQ8tUPm/ysJk1qWZQPpBKdxdJssDNuMZcDPvaYmQni0i0tdjf13M79Ks8
	ShZvIUBwfslnbXBtj0MowVU2zWL6LLRoSAOt6edLKA3kZb4rRARFyRewKrBH1T21
	+1K8FTMwPGlWXKMZGJIGFY8Ei/G5y9Lzy7g==
X-ME-Sender: <xms:srO4Z_QplKoCproC90J5TS6GQPgtw5VJeeV50jyb3jU5oa8rJAE6UA>
    <xme:srO4ZwwxrUsfYlu1sW4XP7AsTMvpRzCANMrKISFH-b93bFkjfOhu05MT-yVZm3UX9
    3E_4s1eck0OUFc6dg>
X-ME-Received: <xmr:srO4Z00CP2kWKUNW-PodxQRM9hA4iQO5AdkY_Dr7XyeI_oI3qdlBxDUqwnYqfwLDD4ii1sARFsDpLGuvdxk4SjCXkCIQUhghOT4Lrsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejtdehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjvghllhihrdiihh
    grohdrgedvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:srO4Z_CUxJWR52mSVvaPkwAqIqroQ9zlTzBFzuYesMEularcoxaShQ>
    <xmx:srO4Z4jOBgyKiwMPaH6rmw5pW-qV5G0nC6AG59kHNyEoifYTkzgwNw>
    <xmx:srO4Zzq8uhKPelbER9uuSEs9vM8kZTp2XvMfR6oMeA41XLahMVaFxg>
    <xmx:srO4ZzjSswII_J8Pstma8SjIKilz0jmjFA9hZJJEyfdzkgTXj9DJWQ>
    <xmx:s7O4ZzX076XU0D1hOWi5SAFtYa8RPi2O6IIsuta1rSHiBHhsTdffCw8K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 12:11:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Zejun Zhao <jelly.zhao.42@gmail.com>
Cc: git@vger.kernel.org,  newren@gmail.com,  ps@pks.im,  karthik.188@gmail.com
Subject: Re: [GSOC][PATCH] apply: address -Wsign-comparison warnings
In-Reply-To: <20250221063705.15539-1-jelly.zhao.42@gmail.com> (Zejun Zhao's
	message of "Fri, 21 Feb 2025 06:37:05 +0000")
References: <xmqqpljfxhvp.fsf@gitster.g>
	<20250221063705.15539-1-jelly.zhao.42@gmail.com>
Date: Fri, 21 Feb 2025 09:11:13 -0800
Message-ID: <xmqq34g7cjf2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zejun Zhao <jelly.zhao.42@gmail.com> writes:

> On Tue, Feb 18 2025 09:49:46 -0800, Junio C Hamano wrote,
>> Doesn't it mean that a change that makes these line-number
>> variables to size_t is wrong?  Of course the change is not made to
>> break the code but may be to please some code paths in other parts
>> of the system that wants these line-number variables that are
>> currently "int" to compare or assign without range-checking with
>> "size_t" quantity or variable,
>
> Sorry but I don't think the change here is wrong. These line-number variables 
> are used as unsigned integers (compared with unsigned, used to index arrays, 
> ...).

I thought that we made it "int" not "unsigned" as functions that
compute these line numbers needed to signal an error "oh the input
is not a valid line number" and one of the most natural ways in C to
do so was to return a negative values from them.  Isn't that what is
happening?

For that kind of use, the storage (i.e. variables and structure
members) does not have to be signed as long as we check the error
returns from these functions (and I think we do), but then compilers
may give you needress warnings when you do assign such a value
returned from the function to the final storage after checking the
validity of the value.  You may use casts but that is trading clean
code for clean compilation without complaint from needless warnings.

Or you can make the storage also signed and we do not have to worry
about squelching the warnings with ugly casts.  When we know we are
not handling patches with a billion of lines, losing half the range
by going signed is rather a no-brainer choice between the two.

I do not see any good justification, even if we buy "the final
storage should be unsigned, since we always check before assignment"
(which I am not too opposed to), for using size_t instead of
platform natural integer (be it signed or unsigned) for the line
numbers, though.

Thanks.

