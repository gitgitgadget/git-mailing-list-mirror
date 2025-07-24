Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317B061FFE
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374231; cv=none; b=C6qmMpdunAF003QYrifhZsAgo4665dO8CWbwOd2Dte0FVhEw0a7wt2qEckkYXqtZVz9kD4hybLxsWqGODJ8VRwdC7qAZzwoxsRuwDdpLfwW8fQHpu3ttD4TlA++LHufELOcLG14iDDHZzCSML1LNNFBdh26q3S3XiaZlDc1aLp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374231; c=relaxed/simple;
	bh=jc7LxVt+sC713R/Ly/lijbvCg4wFIBsVuQoRnNwDwi4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jGGJYFRNUsuDYCvt/bOtkGv4FtGI4vZElUph20WhB1nbJLvDPoGGEklH57yYVF+en0SK2nAyprvq6YZattu3NegxGREwyrn1o1rNnPFWLRZYvxhko+nAi4YFdacdfrQgIefl2JUQWhAaXpxVMjuOL2L1GBKiw12XuOosfGo4OeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=olXEpxYc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cYHdyGzz; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="olXEpxYc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cYHdyGzz"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 090E51D0001C;
	Thu, 24 Jul 2025 12:23:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 24 Jul 2025 12:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753374227; x=1753460627; bh=UbqLYg0smb
	I30nI5V7HT5xxNT/D+6B7B4ED0/Ae98Vc=; b=olXEpxYc9kliJzqSPJOGxLy4Ox
	lfpk4IjRkz4LMOC4q54PjU9HSQ4ZmoPYb9+Ou0pQPxh4beLyHz0V7q4jVb3hOIPX
	YBzx69lypyLSNe7cRC/fquwqaJyWJTgXM6wW0v8HeuS6JWtuZX/i21T/8Y+wD6yu
	q/aG59EAT01k6chbqk9ioBqjjp0T5GHXpTcovRCJQJdzCqGLaAgDrkV19jtUUx51
	LhZyDLP/Yj2P7CY9eZiPyvAKpkwqIOpZm+AG5dCMPxgwafUYmFYws+J3uo9SPS7n
	035KWQvMPf1dfH9wJlqtokvaEVGRyRolSnK41t4D0t6ufZ7rs30PupVrDH4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753374227; x=1753460627; bh=UbqLYg0smbI30nI5V7HT5xxNT/D+6B7B4ED
	0/Ae98Vc=; b=cYHdyGzzlnKnVelMiGFkthvf56veaiii2/HoTzkLywfbXyCbz1X
	/1VpT76WgPRjb+e7uz+L8Fz5RXP+JGkBZZIT+bZg/GlTDX+jIYMI91IZmwsshho7
	we6FNVWKNCiTURzpMFfssCR18XV5M3hqNDFEz9SWQJQ5obmB3FPWArfTKLYW+exs
	aSCf3j2kl5jybZxeiV9FHOLS5CU53hqKcrDsLzMuPo1J2vRwWnYDhw3u0DEemFmI
	Bo8YZYM5q0RbnIDYJ3k1BC1kdUjXAPKzZ6lyvhm8Aw9gfBLDdzQZ02SBF6SDGvtJ
	llL+bzxb/+Q8LSL6ASWzC+/bbvi6yUNz4LA==
X-ME-Sender: <xms:E16CaEOX_g3tCQ4utuLsxGj9Cj7gBRqlnGRn6Kyk5DWnMdvXuIRrmQ>
    <xme:E16CaFin-qrrvifIAkUCURykkGM8VHOg2wGseNbOIq4MvYMPqdCmUVWNeLgTkAdz0
    V1KeG382P6Z0XJ1ng>
X-ME-Received: <xmr:E16CaH1eUm0W0UBRM6QyfkETdJd2mapXX_-Kehuwyu1uVQo__0MWaiR3CTdl4C10AX0S-asHJcyYEP_UPDwzj0gzPz_K-4sEgtjPLLI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:E16CaPi-c7vDL_g4Bo58nLRdV_ljAeJ9Sd5KxDvmJZN9okSz_N-qFw>
    <xmx:E16CaHdtETk5PfeJ77GehXtE7bBVLslQY6a7Dr1L4i3lJJ7Or1t3GQ>
    <xmx:E16CaCmZY5iTG1La0xV6RMAkrgfqDX3hEEqsTu3nT12NZyJejR2OLw>
    <xmx:E16CaAvz-ziHGXJ1WjwUnDCkI8Emzzuo2Nxn40_g_CY7jLMv4qC9GA>
    <xmx:E16CaIeqPJQbE4B0gKMdm2W1XMhlqf6wuUxonEii0Eb1Q5CRQuI9Yhkj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 12:23:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] CodingGuidelines: document test balloons in flight
In-Reply-To: <f954683b-b0be-4608-814d-23993316fcc2@gmail.com> (Phillip Wood's
	message of "Thu, 24 Jul 2025 15:26:33 +0100")
References: <xmqqldoen5v3.fsf@gitster.g> <xmqqecu6n1pt.fsf@gitster.g>
	<f954683b-b0be-4608-814d-23993316fcc2@gmail.com>
Date: Thu, 24 Jul 2025 09:23:46 -0700
Message-ID: <xmqqseilimlp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Junio
>
> On 23/07/2025 20:31, Junio C Hamano wrote:
>> Due to portability concerns, we do not blindly say "It is in [[this
>> standard]], so we will make liberal use of it" for many features,
>> and use of C99 language features follow this same principle.  When
>> we contemplate adopting a language feature that we haven't used in
>> our codebase, we typically first raise a test balloon, which
>>   - is a piece of code that exercises the language feature we are
>>     trying to see if it is OK to adopt
>>   - is in a small section of code that we know everybody who cares
>>     about having a working Git must be compiling
>>   - is in a fairly stable part of the code, to allow reverting it
>>     easily if some platforms do not understand it yet.
>> After a few years, with no breakage report from the community, we'd
>> declare that the feature is now safe to use in our codebase.  Before
>> that, we forbid the use of the language construct except for the
>> designated test balloon code site.
>> The CodingGuidelines document lists these selected features that we
>> already have determined that they are safe, and also those features
>> that we know some platforms had trouble with.
>> Let's also start listing ongoing test balloons and expected timeline
>> for adoption.
>> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> I'm not sure what I've done to deserve that - it was Patrick that
> pointed out the test balloon already existed. The patch and the commit
> message look good to me.

Let me assign equal credit to Patrick.  Thanks.

>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>   Documentation/CodingGuidelines | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>> diff --git a/Documentation/CodingGuidelines
>> b/Documentation/CodingGuidelines
>> index c1046abfb7..0776d15a95 100644
>> --- a/Documentation/CodingGuidelines
>> +++ b/Documentation/CodingGuidelines
>> @@ -298,6 +298,14 @@ For C programs:
>>      . since late 2021 with 44ba10d6, we have had variables declared in
>>        the for loop "for (int i = 0; i < 10; i++)".
>>   +   C99 features we have test balloons for:
>> +
>> +   . since late 2024 with v2.48.0-rc0~20, we have test balloons for
>> +     compound literal syntax, e.g., (struct foo){ .member = value };
>> +     our hope is that no platforms we care about have trouble using
>> +     them, and officially adopt its wider use in mid 2026.  Do not add
>> +     more use of the syntax until that happens.
>> +
>>      New C99 features that we cannot use yet:
>>        . %z and %zu as a printf() argument for a size_t (the %z
>> being for
