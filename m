Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B5623770
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 07:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710919434; cv=none; b=NsS5I+gD1GwKHiwLJLhMQWd4hSpi3wG5rFuPiOd9wEXUQeFJhrn28PY3ZFxl7udgDTU3r1uH2S2zl2sz1fv3j2rqbcWm1/ynJ7SULiIFkMtQWgqt0rYWcgUnl7+3LyDKnUbYDKjEevD9kd3NqvVmU5/BZot497/oMeuFR0JJPO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710919434; c=relaxed/simple;
	bh=E9mRc9/f3PwuQ/HqVUIUHCAxUySepmmTpuJ/x23s3kU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=EQYx4/uzNFrV4ACvFxoP6Vc83hCt+HyFJb0l9dqtJ1072Zyyplh4NtlGAbExCAEt6SWt/VeMn8ea+mkYPCIDVvK1NvUn6akF5LH0j5xjN4M2kv0EqWl+ZPcroWB/inVBhQRcwJ3GRs6eCUce5c1TFY1kRFSYNXVtzD9Qd7K0UX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=BPa99ezt; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="BPa99ezt"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710919429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=36kdfa6smvbG+uIPx+HQzAvt/aSv9q59Zph95kG8p1g=;
	b=BPa99ezt7nHe2/Z5/x2zGH4OpcrNJ2FJ8htXr9LoR01nyLQ0YHgsauN3DpZVtumvAc5S81
	i7bnhKIXMfh1f5grALjAfn2cvBg509/9PqaNgrqLmj1lIJuadW97IKEvZ18LR2oqYRSEWJ
	IS+5WE303G3SdNBCOpZc1wDp4L1Dj8a0HfVDGsePIBYOlzezvPa+M1MJENc2bW6yoCjbvv
	FlWNjDgjpdh2dJf+Z5/iaOGOvBkoDbduvVfoXOreH4lM/SQli4LK4IIu3InMCO0kuIhCJ8
	O2xM+Gx9wvmCjsnvhzIbOBGpiyU+UHvtEEuBTE33nK/X/pN2rCgLC4c9xNLmGg==
Date: Wed, 20 Mar 2024 08:23:48 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, rsbecker@nexbridge.com, github@seichter.de,
 sunshine@sunshineco.com
Subject: Re: [PATCH v3 4/4] config.txt: describe handling of whitespace
 further
In-Reply-To: <xmqqttl1js1o.fsf@gitster.g>
References: <cover.1710800549.git.dsimic@manjaro.org>
 <e389acbfacd5046a926b87346d41f9c7962e3c23.1710800549.git.dsimic@manjaro.org>
 <xmqqttl1js1o.fsf@gitster.g>
Message-ID: <c4f0e7311edce5d4ed4a55f290de9eaf@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-20 08:12, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>>  A line that defines a value can be continued to the next line by
>> +ending it with a `\`; the backslash and the end-of-line are stripped.
>> +Leading whitespace characters after 'name =', the remainder of the
>>  line after the first comment character '#' or ';', and trailing
>> +whitespace characters of the line are discarded unless they are 
>> enclosed
>> +in double quotes.
> 
> Can we directly tighten the "trailing..." part, instead of having to
> add an extra long sentence ...

Makes sense, to make it less convoluted.

>> +The discarding of the trailing whitespace characters
>> +applies regardless of the discarding of the portion of the line after
>> +the first comment character.
> 
> ... like this as an attempt to clarify?
> 
>     Leading whitespace characters before and after 'name =', and the

Hmm, "leading whitespace" and "after" don't go very well together.
Such a construct seems a bit confusing, because it implies there's
something else after, which the leading whitespace refers to, which
may or may not be easily understandable to the users.

I'll think about how to rephrase this a bit better.

>     remainder of the line after the first comment character '#' or
>     ';', are removed, and then trailing whitespace characters at the
>     end of the line are discarded.
> 
> By the way, if a run of whitespace characters are enclosed in double
> quotes, they cannot be trailing at the end of the line, as the
> closing double quote is not a whitespace character, so it is out of
> place to talk about quoted string in the context of trailing blank
> removal.  The unquoting would want to be discussed separately.

I'll think about this as well.

>>  Inside double quotes, double quote `"` and backslash `\` characters
>>  must be escaped: use `\"` for `"` and `\\` for `\`.
> 
> Thanks for working on this topic.

Thank you for your highly detailed reviews!
