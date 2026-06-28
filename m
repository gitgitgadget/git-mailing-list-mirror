Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3851A0BE0
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 01:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782610917; cv=none; b=Z8KSTa2wk7TZZ2NZoyVwGdBBJGZtQcONcJPjgORPPWjbJwrqLUsxop5RjhUw//OiUfS+K37JEjjuyhhpSAg410aAIqj1S8ZDZA5Uj1CJQctyFtUINQqKJJRiGMEjQupkiCxxXLcG0yLsopHnP46Fu/zuGcfS+VLQ0yPAbg6K7fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782610917; c=relaxed/simple;
	bh=7YT3sugYH64MUDe0641oDEKTRY2n3DOzHUKDzpvaLmQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gPvGWCyJgRbRfesf9rPwErUlH81pDFEKJM8qHv8HOvTLJuM3a6bqEVVGo7pZp4cnUaosZyk45lMcY527RvIFNKMtrmSBI9dMtWSNQFZRFjEINHOGjug0m6FHrxzS3Y3W3v0RTrrTdFmeibKXni/fCH4S3M+0M/4S6bkbW1phB6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IALy8lrs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DoFtqfwO; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IALy8lrs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DoFtqfwO"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A82941400062;
	Sat, 27 Jun 2026 21:41:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Sat, 27 Jun 2026 21:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782610914;
	 x=1782697314; bh=JCPqDOMhh/RF4ENXaVheCmQWMu5Hc9DffCrouWtaehA=; b=
	IALy8lrsehAP/I3tUNv1jBfJggeUbLMX2Es/dLOvNozvgCKY1tqzorCVW3pF/3kQ
	8MfOtbwOWKmN6leJNj0vkOhSILFG/uzfqbU1S1PFV/QvXNHEn3l7Pllg+bF4el3/
	qOvJt3Zs4LN5g0iF7qdCKHQ9ZJwJuOIDdyx9Ski7+U6MMgO4/sNqJVsyaBLFHZc+
	0h1UF6obuEEhd8OTLmJxPsk3UbQ44vXOgCoJ56vaVVUCNLjIa5o2Z7fKrGXmgL99
	m+j9hWYTsRYPTVd3FNvs+Hf0kJAQ+EiSYF+xP22Wcp978PTml6RaQzt5u45n4qbF
	lG/8HgPjbHKIGxbtse+EJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782610914; x=
	1782697314; bh=JCPqDOMhh/RF4ENXaVheCmQWMu5Hc9DffCrouWtaehA=; b=D
	oFtqfwOe+LifwkXV9aQx+U23zBBHjAIRej5VmTtsa01XMfCKDZc4E+vLaqrAGvza
	+CxtFvLc+JqreijN/qlQJYnWXUMmxMGN6ubqT2uvVgrHlo+XCqNcn5XmKOs7BI88
	P4x9nTFz/zr28+ON7SHapkNbNpZmOAmYXG2897fKZBYnbYCMb6hHRRxM2VLhS8tn
	FeUrshrgKw7yPaq4CHoHp2ygsz43nUTVJv6R07jHBiL9gyJ69BBAvpS5WyZHHvuH
	ekKXDUStnUEMwcAnp99oUVknshdDfpNO2kxU3oJyP4sp245nhiq2P3UKBFpBnMHW
	CmUM4gILe2JLUuy+nv5kA==
X-ME-Sender: <xms:4ntAarjjKX8xFzh5CflDz30-X35ciSGPotqbUhQhSmBxmxTIStdhYQ>
    <xme:4ntAaqRJ20NOshVAit4VjaVtL24xSUDsm0miEnN4asfv8GfqLVbCJbxQHxQj455QW
    rPAoPBh0iloBxP7K36rOt8ccRp6fBsJD0V5dYbMDEpcIqNionZ0slA>
X-ME-Received: <xmr:4ntAatWO--5F_POp7e7fapX0POf5Hp9jfc1yDZa4OmzH5NQ1M7jIPg2kZCkM-5C6ZWHkXQRueN_2QWEjLf0yLie8qvJYVUdLD55dBMc>
X-ME-Proxy-Cause: dmFkZTFvVVdAJfNayWy7LCHUp7UPW1KVNfCDRjRv2NARE9d43ejuJDou8GlnwLTiEawuab
    10arxaDSsCZ3pMT4qPbXzFKndLYWi0J7Qn3wxMLZUgv4STMHRKGHdhEIDtyJSZ0dVhDZR7
    2kn04OcEyjkTyUFZ3iHoqSqV+cbP2i4pBVKnL6WUrKbHmP0uQJKBNVdXi+XbMp2Krx3JRF
    PC2wcZAViu7iJdvBJjyHbaMQqRAXw0sgxE0W4rQh4d6zKQqV5q8IV0k+Y8kzEsqQ8h+5nQ
    eFsI2R0x23OfCJemyI/A6khpl8NI8rQwV/LB40gt/9nMkZqT/ChU/xE80W6FVk19IHPFti
    SFs5WxOn5Kntse2FvZh2uSFybAbuV0sF6PPw7O606iQ2myMBtHuMeuqcunkm/ClNBTRnMv
    FqI4gtPYd8yw5rzdPoxpqz4/4cnCyL+00oibUoeRMYjjt7nhfIBa1TkQD4VRCHa9SCXe1H
    023LebmKzWhbUfvescOnBi7JQUxFpOG/8dtMREVmjo0QYsCVPCTFmNCkqPzJ/xic4w8qYs
    NIqzHO8G12O8IR2uIOvNnyDhk5Ync8puIN9o4REvkoX+uEezpnK0IU5a+ZO+7vgZF19QFH
    hRMFo3zLZP20h9EI92Tmt2wGAZUdUWgbdUx64TAN4gvWAPb2WWf1ZmjHk0SA
X-ME-Proxy: <xmx:4ntAauScerRt2buDTuu8U5n0U_qQKQR6gJwFUigi7WJkcZtg_cEzWA>
    <xmx:4ntAanl5DqOx0v5s3YTvPOm0q3yVcLIz4GOeMwdB2n6fMhxQbNLHfw>
    <xmx:4ntAak7OJaogiP3zL-XtKenmGQ1eVOzBX91RiKLgQbgB-oB3jdLlCA>
    <xmx:4ntAathGNbE4pdzwp10hdYgAfiNthYnXhKYNcNGTSo4qoJDXliQyqQ>
    <xmx:4ntAah8ys7alULkCwUyjnyNgfGoKoo-C1XE4h2nOqvrvxy69C-DAeN94>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Jun 2026 21:41:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Michael Montalbo
 <mmontalbo@gmail.com>
Subject: Re: [PATCH v2 5/6] t: convert grep assertions to test_grep
In-Reply-To: <xmqq4iio59uv.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	27 Jun 2026 07:36:08 -0700")
References: <pull.2135.git.1780559158.gitgitgadget@gmail.com>
	<pull.2135.v2.git.1781323575.gitgitgadget@gmail.com>
	<3a589ef7386303075413f388e61c203c4e325d44.1781323575.git.gitgitgadget@gmail.com>
	<aj93BE8MYatQAjoy@szeder.dev> <xmqq4iio59uv.fsf@gitster.g>
Date: Sat, 27 Jun 2026 18:41:53 -0700
Message-ID: <xmqqldbz4f1a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> SZEDER Gábor <szeder.dev@gmail.com> writes:
>
>> I think in this case checking the file3's contents is wrong, because
>> at this point file3 should not exist in the first place.  I've sent a
>> patch to fix this long ago, but apparently didn't manage to follow
>> through back then.
>>
>>   https://lore.kernel.org/git/20211010172809.1472914-1-szeder.dev@gmail.com/
>
> Thanks.  I guess the test_grep can be extended to catch this case,
> where 
>
>     test_grep ! -e pattern1 -e pattern2 file
>
> does not find any hits, but only because 'file' is missing, as an
> error, ...

Wait.  The necessary check is already there, isn't it?

        test_grep () {
                eval "last_arg=\${$#}"

                test -f "$last_arg" ||
                BUG "test_grep requires a file to read as the last parameter"

So why don't we see it every time we run that test that inspects
file3's contents with Michael's series merged in?  Puzzled...

