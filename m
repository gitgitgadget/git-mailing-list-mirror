Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5AB1DDA14
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737048180; cv=none; b=hTIkt8LBO3OvfsEL6XuoJANnwFXOw5+WjqGxmVn2c9pnRlksKAjVUUSPD2vNEvXtxMxEkUQ1qu+WfOM/5dpua8CUzL2jwZwUtf9oyYuquna4RMxdjob/cS94vkZkmCuL5ksij0wwkTkilxYUlZkseQ3PK+IHaw/DrMk9BJAa3nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737048180; c=relaxed/simple;
	bh=oFbpu2UUD5rcMTsdkPyDu6mEBXcH+Yu5SKzufBIMilg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gxCzmH84x4GlZuK80CmATM3In7V+GD/8Oa0jANEsfP3/PmFe9FW6I8h+gGOC0jw9FZKXyjshxn7bc6klGwXMZ3jXrHkzqNzMnGS9hUaetsHSRkzPJt9c6VNDz2FEZeb+NURJWUdHRgFuDZBiP9/C90FH7WX4kbznBrL0nJFtJt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bjHkEgWa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JdSvmFNe; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bjHkEgWa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JdSvmFNe"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 40DA711400C4;
	Thu, 16 Jan 2025 12:22:57 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 16 Jan 2025 12:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737048177; x=1737134577; bh=8/tfFLCLHp
	rvqwcC4+II3rSHrJAySEQ78GPwA5O2rjo=; b=bjHkEgWav6dNlu+9sm41MrMjEy
	NUPqcI6fxCZ/wuAHdg2VBiHFCM87rU18U/Hsdp+k2+n3u7h7c6ofhRg67i7W+28m
	5Q7zKJua9Nbq0HpO0HpNub8fMvGnATQ+Y28+18W0vjhu/ywWPagmfUJ8fs1w5dy6
	yYwYFF4cKkY3m1CIh4Y88mTqhFZvw06b2Is4WB9c5UGjTV/kwfGhb9lcfcJkXNWz
	ZgXzqVPeKLdhFNgkllMPR4cDB3/fXvZBKXLdXtMVk+8fzCRAo8XXVvTeQFUm377M
	WYB9BnC8IzhLG4sO3bktTKIZgGSjvOeoyJVUNc1TwXWKez1IZCuVsddysWRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737048177; x=1737134577; bh=8/tfFLCLHprvqwcC4+II3rSHrJAySEQ78GP
	wA5O2rjo=; b=JdSvmFNeiipuT3nARy4hnJOiLUqZ9M+zr9dKJRdh4eQNd2gThVX
	dSi89a80s7mtqyJFEWRXdtiz8XU4hhnBGjL9JprUpcnYCl9HDPNm9FjT3Q0CKWPp
	qjfI4O6srNGp80wMVySVIjTTBd/7nNnaL77HfgK95swEFJGNFbgmrzOOvVs4d4ZS
	a7jDURlQ2yD1DqbZYkPGuW8f7cTeb9Zp6V2VUC2p696RxUoTJSxqgd9KeHbFG5+r
	eAhnnEfviH59G7C4KUKeqlCNCHkQqZ08G8DYIunVLNkjiAoKNdjkfzNlsthUkJlP
	TdLiFWDCppgo35YN2Lm9s7BHYTFBiAmKTyQ==
X-ME-Sender: <xms:cECJZ8jfJoMkcUYpCED34bT8ATBDZzYUmxUd32IGLhWVFD9mibisbw>
    <xme:cECJZ1AU8cgsUmbC5Bzcm3t6xYj-ZDjQtmgJ4Rm955PDr5U2XxqZ2Xm_WAazV7MIn
    pM9r5rZg-_6wwAJTg>
X-ME-Received: <xmr:cECJZ0HeBTjf6yKnu-FN2rn0ZKiaoi-J0FLOxONyrBw8DR2D1XWVwQmESuzcllOGgdgaZ2fgnGFJVzIF5AbXV3RN6fpLVrHjTZno>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:cECJZ9Rz_ab8Fcy5_W4HCxFTfLb8hNzpdBhgcMN45_Q4LbePqk-qTw>
    <xmx:cECJZ5yNrqt9kPfY6ri0eVISYsaI0ov3KXw1m8-S9_FQ3p-TK0sayg>
    <xmx:cECJZ74PQ0EhEINAEb4-6MPDaC1bYACPbkFgYOc-2qqAa9IYqmOhJA>
    <xmx:cECJZ2z5d8MBd2qE2DblKDtsQPXndNtNm02q6vvAohit2Lqqli-6Ew>
    <xmx:cUCJZx9vij5bF8dzYbsGHXweJUzLD2AOuXog_7A6IYUENtpHWE0Xy0-u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 12:22:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 4/6] usage: add show_usage_and_exit_if_asked()
In-Reply-To: <20250116103620.GB773990@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 16 Jan 2025 05:36:20 -0500")
References: <20250116012524.1557441-1-gitster@pobox.com>
	<20250116012524.1557441-5-gitster@pobox.com>
	<20250116103620.GB773990@coredump.intra.peff.net>
Date: Thu, 16 Jan 2025 09:22:54 -0800
Message-ID: <xmqqbjw6u101.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> 	show_usage_and_exit_if_asked(argc, argv, usage);
>> 
>> to help correct these code paths.
>
> I found the name hard to distinguish from the earlier helper,

As we all know that usage_with_options() and usage() exits,

    show_usage_with_options_if_asked()
    show_usage_if_asked()

may be good enough, I wonder?  "show" -> "help" may give us better
names.

> I think the "and_exit" could probably be implied, since showing the
> usage is always a final thing (just like in usage() and
> usage_with_options()). So:
>
>   show_usage_if_asked();
>   show_usage_with_options_if_asked();

Ah, We came to the same conclusion.  The only thing we haven't made
it obvious is that "show" implies the output goes to the standard
output stream, while without "show", the output goes to the standard
error stream.  I wonder if these help better:

    show_help_if_asked();
    show_help_with_options_if_asked()

"show help" explains the output goes to where the "help" message
would go ;-)

But probably "if-asked" is clear enough indication that the output
is made in response to an explicit end-user request, so let's take
the show_(usage|usage_with_options)_if_asked as the final names.

>> -static void vreportf(const char *prefix, const char *err, va_list params)
>> +static void vfdreportf(int fd, const char *prefix, const char *err, va_list params)
>>  {
>>  	char msg[4096];
>>  	char *p, *pend = msg + sizeof(msg);
>> @@ -32,8 +32,14 @@ static void vreportf(const char *prefix, const char *err, va_list params)
>>  	}
>>  
>>  	*(p++) = '\n'; /* we no longer need a NUL */
>> -	fflush(stderr);
>> -	write_in_full(2, msg, p - msg);
>> +	if (fd == 2)
>> +		fflush(stderr);
>> +	write_in_full(fd, msg, p - msg);
>> +}
>
> Gross. :) I think the existing code is conceptually:
>
>   write_in_full(fileno(stderr), msg, p - msg);
>
> In which case vfreportf() could just take a FILE*, flush it and then
> write.

Sure, but these "stderr" are real error reporting that need to stay
to be stderr, and flush needs to be done only when our true payload
goes to fd#2 and I do not think these fflush() are about stdio calls
made by the caller _before_ it called this function.  It may become
a bit tricky to read the resulting code if we pass "FILE *".
