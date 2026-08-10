Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F55063CB
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 23:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786403306; cv=none; b=i0aPXq8rXAp7KuIOIt5iDewp8XSZdSwai6B6//Bl3hMdBrXQDOTgV8gqmNGHW/Kl0RJn5Ql/0S9pXWaxh8lNWYQWO4NzYq03ptQDnHeB/Gf9uo5mymC6ag7hce26JO2duPEJBWb46TKH6Yu4gyazfID200lvWJ2AsLkk68+MYiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786403306; c=relaxed/simple;
	bh=7cJF/A6L6GYJ/SwH1/dPVt0f2gL1jj3kl/IXUkEjR9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rvenFvOfyS2jyHP+TSBtXrpl7zJ7kN3S+uDFXv4aJhxIdWhz9/dv/LeOCWhEoycml1LBW4vUgkwx22brvz0pWxbqFRYeTT005SC8KkaUQfnuOpTBgtnrfnybbVBzeGnxzReTh43dO+swoFuRJ734euH/HvZzdxnXnTe9un33Fww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=H//p4fyt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OEvA5rNH; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="H//p4fyt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OEvA5rNH"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 8CCEDEC0209;
	Mon, 10 Aug 2026 19:08:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 10 Aug 2026 19:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786403303;
	 x=1786489703; bh=VCuKmTWuCwqLuk/eRg+jHBHAq2zu6cW6vNZSTPFxlSI=; b=
	H//p4fytIy0WtBV9QndpEVQK25iHG74+ERKcDVd46Ujvs2eMQ2COSdUO8nSPtskF
	87W2wcEpeoCqMT1uHgTbvbL1Su1TYTTCvwG/9sG/sokjNTlEwr3dPwNJk+JYWo6s
	0OF/Zq6xAlMA2JkzE5ThWNFUtr8SQGQws2hBGfBTYreDRc4TJcnCP5leaTY8whx/
	YXbyEnp+A+cc2lIN3emIxMRjZJa+0pSD0PBKcyuGzUzG9H9kDzEpKPTNKl8kQosI
	UAZ9piEjdoORC1w7pmYtgWjuZvWtBPQw5zcUlXdA1m1fCgXYOK3wEKDv/8BzDMDm
	8ATl1hy9c3vXsCY4vx3VLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786403303; x=
	1786489703; bh=VCuKmTWuCwqLuk/eRg+jHBHAq2zu6cW6vNZSTPFxlSI=; b=O
	EvA5rNHJaSiA6AzDc9fb1JVxFo5fv1Ah3Dh7N7sAbvUW7FMDbI1SrPR4g4rIEM2M
	GKjw3ijzmtOdpFW2ej3gBYB/px/qADCAPs1C1AnIy9skIe0hsl8v2aWn34AXS5DH
	fc6Hx9IvO3bw7XxmgDaPakjyx4qKJfZDtOnMELrUFU6W5ieSIEdQH1HHO/vlDxA7
	S7DAThLiQXxFl+Cy3jWg6tBMYb3ar1/pB1z9YACugwI+lgVyhRa+Fw8+wHAkcTLG
	wnOJFQzytcd2MMIaNQl1YH5hAI6iqZcNR4sEL3EWXktIFIPU4em+xGsrEMCqlQGR
	BnJBqyW1hTfWPzy2cEIRw==
X-ME-Sender: <xms:51l6au-blqHlaS1nKRy9TCA7IpD2een5SQKOgRi9kpyG6kBYzkjYJg>
    <xme:51l6ahT_QFJD4-lr90tPY3mRacTEMinBXRNFTskLLLNb_AjxI-IiMTO5FWK9OPVjJ
    EgtzLDA-JC2m8zSgY1lJ_bbAIn4qX6Ur-3PzP7MDVOd9fz-KK9VUw>
X-ME-Received: <xmr:51l6anpoZnBKs1A6CnAqXiNJIT7BRkopux60wgOOr4JkLizrEeoK0r-7rBcx_ypm1IKdRjpNuB-CXtFoBFqF7Jmee7phQ9auHA>
X-ME-Proxy-Cause: dmFkZTET+r8HdZOnujXI7XCSC4e+ngFpPAwieLO8p7BcT+/4ISFDq7FZDy5lcSrhngnthf
    KtBES0gELug39Dba5Zh6K6OAfbHObYPPrFiOIojtqFHyG+MSW80OXLcSFTsDDKoL62XHh9
    6ysTuvt2rhtvZiVFhZ+DvMDV1rwP6bjHZfTrroqWFjDBj5jmbD5k/r1ZPbR1Z8V4inDvvW
    YQ3ZOVtoCCnR9YDzEvl4ItpgSqIE+GCDw+rYGrTgJzmagJvXgf4LTLDsF6mHTQdVo6ELZW
    uoeVOd1zOtsFWyOAETSnVT/nsfWc5RwDUaD9iMARBkWJ7cw0AE/5CeQD3y4XQz872EyNJG
    JIfEbGn0eedu7gx1pZibYbp78kPi5GYQkUskyiXP/26s9TBFXjDKjoakA1chngX+fdVOuI
    HNzvw/bEOKyLn+Gxe529sPwj0l9IyrQC8UZ+giO6IZt8PRNIchBJfIumnUEROc7+8Gx2us
    bpoNPVLHnVBAdeUT//8zGwU5yjiXGtCQPvB8gVpwlBYYVtWWijBO3/FvJdhi7LU6BEH44D
    FhPTbA7QZ+XpejbpHxsEmM6pDPDVVez0TOMFmgNLZX1Ze3LA7AhxUbQpXkZNUUXuRScacw
    kxNaxVXgrdYbwGR6OhdXKJnMHCww7ojjAf5miGOAPhEiGGYEKgxdunWXFa5A
X-ME-Proxy: <xmx:51l6amnNfAebtjZWo0UI8nRfjt7p3tYVfulgKAjN-AAfkCDjIgNCHg>
    <xmx:51l6aof7-zy5gQJcvswejZo3IIamrWQLhI9ykmkmQe0nTjKZfe7QyQ>
    <xmx:51l6aqoYW18hkwMNPL56F1NVPbFBEEUv-ATmZMw8-dyUFgMlW2HNiw>
    <xmx:51l6aqM4sWPFsvB1KADVomrSMRyetC0LRZJNlYWWz0DWm472YfUukw>
    <xmx:51l6asIQ6TB07DmGlZk-xxoGH0o_5AOA2mWKJrUDbJO9WHoVZmwgkFMi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 19:08:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: kristofferhaugsbakk@fastmail.com,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>,  christian.couder@gmail.com,  Brendan
 Jackman <bhenryj0117@gmail.com>,  Linus Arver <linus@ucla.edu>,  Matt
 Hunter <m@lfurio.us>
Subject: Re: [PATCH v5 00/11] doc: interpret-trailers: explain key format
In-Reply-To: <0687D60D-DF6B-4547-868C-FCFC5B27ECAF@gmail.com> (Ben Knoble's
	message of "Mon, 10 Aug 2026 07:16:56 -0400")
References: <V5_CV_doc_int-tr_key_format.b26@msgid.xyz>
	<0687D60D-DF6B-4547-868C-FCFC5B27ECAF@gmail.com>
Date: Mon, 10 Aug 2026 16:08:21 -0700
Message-ID: <xmqqpkzp60be.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>> § Link to v4
>> 
>> https://lore.kernel.org/git/V4_CV_doc_int-tr_key_format.ae2@msgid.xyz/
>> 
>> [01/11] doc: interpret-trailers: stop fixating on RFC 822
>> [02/11] doc: interpret-trailers: replace “lines” with “metadata”
>> [03/11] doc: interpret-trailers: use “metadata” in Name as well
>> [04/11] doc: interpret-trailers: not just for commit messages
>> [05/11] doc: interpret-trailers: explain the format after the intro
>> [06/11] doc: interpret-trailers: explain key format
>> [07/11] doc: interpret-trailers: add key format example
>> [08/11] doc: interpret-trailers: join new-trailers again
>> [09/11] doc: interpret-trailers: commit to “trailer block” term
>> [10/11] doc: interpret-trailers: rewrite new-trailers paragraphs
>> [11/11] doc: interpret-trailers: document comment line treatment

[...]

>>    @@ Commit message
>> 
>>         Comment lines have always been ignored but this is not documented.
>> 
>>    -    The primary motivation here is to reasonably complete in the
>>    +    The primary motivation here is to be reasonably complete in the
>>         documentation of how trailers are parsed; this is after all the only
>>         documentation page that documents this format. However, and going beyond
>>         that point, we could imagine that someone would want to use this format
>> 
>> base-commit: 5361983c075154725be47b65cca9a2421789e410
>> --
>> 2.54.0.22.g9e26862b904
>
> I’m trivially satisfied with the range-diff (note again I’ve reviewed primarily the end result, not the per-commit history).

Heh, that is like saying it is better with "be" than without ;-).

I think the topic was already in pretty good shape by 'v4'.  Shall
we declare victory and mark the topic for 'next'?

Thanks.
