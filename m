Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DDE27F736
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762533684; cv=none; b=TRC8itT/Z69/bre9r6ydy0/D+QTEiMxyBnuHxQaI5IkybeXKkx7w/g0n3cCEzbtwtYZbOYejzL1uzsXVx/6bf6YEGpZ3ieulYzfdX/K7c9JQDTZICpJffXxJC2BnZ7CkmYX5P0wvERqeokZ/ZmXzWQ6EZa3Ys1XPxnWtGO+vcew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762533684; c=relaxed/simple;
	bh=92kWemCGPhJ0RxZZSKspuAFwlC2T/ex4E906aTwbJGg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iqUGrrv5OqqwFdeU+XhymUojH6Bxji3vyBUxcYvHfA4x8SOCBnifczRE9f1H43EYhDev7pjXSXKYWOHrbEXBaRDkWYCgnMq3eWB4MD2W65hYdcStD2/VbIh3Q6E33dtxnFupc8K6WXlBcdF1X6SWgoHO0ku/g0bvW18oMr2SrZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lc+MtAML; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yooYWbZL; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lc+MtAML";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yooYWbZL"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B741E7A0158;
	Fri,  7 Nov 2025 11:41:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 07 Nov 2025 11:41:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762533681; x=1762620081; bh=nc0kejgySz
	g9gDBzoQwrzPE/EXS8dJtJnjUz1TzdKCs=; b=lc+MtAMLJBLZ9KFa3W5JUcD6Vb
	mrIqtkBgsQax9Z6uoToWcCR1RnYSH/bFeRBfMzqTPTENWCyEYCBDhblhQHjDgExZ
	VZ+CJrQR9igucpqO9RXFKIeDILmCcnipxmg9tpS0ww828dA6WdYkS3zpM64jEO8/
	5NDUrXtKMUerd+5unyHoOvgpGEm8LYrX/I2a+6L2ef2tQ7/EAJOvC/rVaXMA5pl2
	zEkcDXSVYR/MiLqd5N6KXp8VytJ9vLG5nGWRKiiSGWBN/nkuPEfbfd9pRSG4RLQO
	IR+woM3LAEeHzTVallQaDa5PXabnx3X3v1slOLer39tHmsPCnks627SKEEUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762533681; x=1762620081; bh=nc0kejgySzg9gDBzoQwrzPE/EXS8dJtJnjU
	z1TzdKCs=; b=yooYWbZLiTxhBTPexmiCXedCWz98EU141mQ4nwBgLCwbzQ6Tskc
	1la/laAjV++u8f5BYIJUl6NCIeQNLTLe04JE1XVUV5ylbtIvLDq0Lbm805caJ5Wj
	cPLfhSNdNeGafIHDxveGnay71cJ8/vtTlFL1S5kyT8f9rrnGa0UD7o7kCVfRGTKj
	lYE/POcC9htM/4qJQfFgsKdrsr6hSbJU/1EKAr+2VqMdE4oR/qOmb8rUSHVck6zD
	BNHigtkNCgpueWGHdaIWp8Ao1tZ3HO//c9Xd8cLVO5DzPCULK3h5a4tPEq3PdpA3
	V/+/xrABCvXJazb6sgOq/qwmksdiBrsWbKw==
X-ME-Sender: <xms:MSEOaZ-5upb74152z2T4iWYZXvoKQ4lGuh8dabYVaqCPB_SHzuo9zA>
    <xme:MSEOaUnJBgy9fi0S36vaFO-cT1d84RRzkJFTojv42TtauVDM3ofh7II5oXwTC7HfE
    zwaI_v6UXBB_hHS3m2AwewyqSfcUweLcUoKLsCAZPw_gvq7pCeP>
X-ME-Received: <xmr:MSEOafXcGbh_NFC1AxDAjh82hAToso8-6hTelPugpc0JtDxz_SCAQdOC5TXwUE9cNfHzoBOziIhkOaxyrqcLyO3WXCwdRDguekWu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduledtudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MSEOaZFcBE2BMW2y_2ZBFULrUpZK0tcV-CmkgXgbe_3pHRhDQw5iqg>
    <xmx:MSEOabdsx_57XN9pOrJyAHYSjfHNXss73BdOwphd3FwqCmu0R-8_PQ>
    <xmx:MSEOaaINRpW3qwAt6IsSjMbnICs57u77OChC-EHIdQtBqBhl0o0nyA>
    <xmx:MSEOaQGipOI3H-IPMLCEFJWitjpexGu7ExFXsoYW7k3_k0xk6h5JQg>
    <xmx:MSEOaQW-TB3uh8ngSK_8CqyBR0RgdD3YdXjaJJOMXJz4sstkBVHhhzEQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 11:41:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  jltobler@gmail.com
Subject: Re: [PATCH v3 4/5] maintenance: add checking logic in
 `pack_refs_condition()`
In-Reply-To: <CAOLa=ZT6CnTRz5bX+Vv7pb_3oqV0XNSMEzh=57sF6O5bFYxWhQ@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 7 Nov 2025 07:58:21 -0800")
References: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-0-d611a2a95cf5@gmail.com>
	<20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-4-d611a2a95cf5@gmail.com>
	<aQyNSOdPWAxm15U3@pks.im> <xmqqpl9vjiaj.fsf@gitster.g>
	<CAOLa=ZT6CnTRz5bX+Vv7pb_3oqV0XNSMEzh=57sF6O5bFYxWhQ@mail.gmail.com>
Date: Fri, 07 Nov 2025 08:41:19 -0800
Message-ID: <xmqqo6pdg5hs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>>>> +	/* Check for all refs, similar to 'git refs optimize --all'. */
>>>> +	string_list_append(optimize_opts.includes, "*");
>>>> +
>>>> +	if (refs_optimize_required(get_main_ref_store(the_repository),
>>>> +				   &optimize_opts, &required))
>>>> +		return 0;
>>>> +
>>>> +	clear_ref_exclusions(&excludes);
>>>> +	string_list_clear(&included_refs, 0);
>>>> +
>>>> +	return required == true;
>>>
>>> Tiny nit: I think in our codebase this can be written in a more
>>> idiomatic way by saying `!!required`.
>>
>> Comparing for equality with Boolean in general is stupid, as
>> Booleans are designed to be usable as-is.  If it is "true", it is
>> true, and you do not have to compare it with "true" to ascertain
>> that it is true.
>>
>> I do 100% prefer "!!required" over "required == true" or "required
>> != false" all the time, since it is more idiomatic, but I vaguely
>> recall we had something that contradicts it in the CodingGuidelines
>> document.  Perhaps we'd want to fix that.
>>
>
> I could only find
>
>   - Some clever tricks, like using the !! operator with arithmetic
>      constructs, can be extremely confusing to others.  Avoid them,
>      unless there is a compelling reason to use them.
>
> I think its okay? This is more of a suggestion than a rule.

"Unless there is a reason to use" sounds like an outright
prohibition to me, though.

By the way, in the on-topic part of the discussion, "required" is a
bool, the helper function that takes &required takes a pointer to a
bool, and the function in question returns a bool.  So I should
update my preference above.  "return required" is the most natural
way to write, and it uses "bool" as it was designed to be used.
When the reader knows that required is a bool already, "return
!!required" is just as pointless as "return required == true".

If required and the helper that takes a pointer to it were "int",
and this function returns a bool, then my original preference would
apply; even if an "int required" has 3 in it, we probably can still
say "return required" and the function would coerce that 3 into
"true", but manually coercing it to 0/1 with !!required is more
explicit and less confusing.

Thanks.

