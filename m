Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DEF3A8D0
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 19:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532252; cv=none; b=p1qW3WcncRSScdmRaAqFVhyUmoZdzInTpicAs3Nl93yb+Hfs/0ZTjrvHbDTg4WmtUfcuP0QoDPxu65omjcQK6GqPqOpYW7uKM+t1Elo6Necld5QpJDoNVr8QxS+TqczDsRz1OYUFNCvqTyOyWpbvE5vL0osLKSdIwStMWlLHADs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532252; c=relaxed/simple;
	bh=omsktvnsm4jOxMJSAT/wNda6HN9O2A37jkfz1uo9zuA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=s+te3i2uelF4lx4zuOmFQ10qdSy97jBHDnDw29M14ZxapPZCsiXcdxsET78EnaMKYUPV/z3JR4Xi8bXbsSPBPiBg2zdeGE4sW+4+mhvUm1elGxjrSKYgYWtpcaGTVTnhQcIOBiqcZXzHcQGSO0i8NClF4hPsxa5gE/FZFEm0DOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ib4NVsAb; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ib4NVsAb"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710532246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YdLA8n9Xz8bgcNaI47dLPW27U9UWLYoJkmBDsdQujLs=;
	b=ib4NVsAbcfxuTm4Zl/1Nx2v+rALdwW2r9mAg8Ej5OrNRd1zFkZbN5M1B5fXz5TBEJL04lJ
	ZLibXy/yOu/CrwN+k/sU5dOySG3cHv8c0yKSIxYuciGyuz+5sa3PrBd+OLfgBUtcbZjzB3
	TclxKFcvSOa+KipYiaIV4poWgm0VE9/bKOjREcrPfsgwihJw2mbX0K35HTELHPd0/UZOS2
	mlB5wMQdUA3tPb4445LNjnEhzCiBvQros+/MgrEgaAv5oi4VWzSRTNxm1raMkM69QaWHFu
	ttitw1R1GIsxDv8wuH1KlWPcUbJctlNqgeD787g5g7snoNenj94/Vb9H5tcbow==
Date: Fri, 15 Mar 2024 20:50:45 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, rsbecker@nexbridge.com, github@seichter.de
Subject: Re: [PATCH 2/4] config: really keep value-internal whitespace
 verbatim
In-Reply-To: <xmqq4jd7qtg6.fsf@gitster.g>
References: <cover.1710508691.git.dsimic@manjaro.org>
 <cd890a7015733e311e0e0a4939c539d2894e31cf.1710508691.git.dsimic@manjaro.org>
 <xmqq4jd7qtg6.fsf@gitster.g>
Message-ID: <1b6cfdd62b08b7bdc817e3c106e3ef50@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-15 18:46, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Fixes: ebdaae372b46 ("config: Keep inner whitespace verbatim")
> 
> No need for this line.  You mentioned it in the text already, and
> more importantly, grepping for trailers is not the right thing to do
> because we may think we fixed all bugs in ebdaae372b46 did with this
> patch, which may in 6 months turn out to be false but we cannot undo
> the trailer.  On the other hand, the discussion of the problem in
> the proposed log message gives readers a richer context and the
> future developers can understand that this fixed one thing in
> ebdaae372b46 but didn't even know about other bugs introduced by
> that old commit and make more intelligent decision based on that
> better understanding.

Got it, and I agree that the discussions linked in the patch description
provide much better ways for understanding what brought us to the 
current
situation, and what led to the proposed bugfixes.

It's simply that I'm kind of used to providing "Fixes" tags for patches
in other projects;  I'll make a mental note not to do that for git.

I'll also send the v2 with no "Fixes" tag, after the v1 spends a few 
days
on the mailing list.

>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  config.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>> 
>> diff --git a/config.c b/config.c
>> index a86a20cdf5cb..5072f12e62e4 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -817,33 +817,38 @@ static int get_next_char(struct config_source 
>> *cs)
>> 
>>  static char *parse_value(struct config_source *cs)
>>  {
>> -	int quote = 0, comment = 0, space = 0;
>> +	int quote = 0, comment = 0;
>> +	size_t trim_len = 0;
> 
> 
>>  	strbuf_reset(&cs->value);
>>  	for (;;) {
>>  		int c = get_next_char(cs);
>>  		if (c == '\n') {
>>  			if (quote) {
>>  				cs->linenr--;
>>  				return NULL;
>>  			}
>> +			if (trim_len)
>> +				strbuf_setlen(&cs->value, trim_len);
>>  			return cs->value.buf;
> 
> So the idea is that we copy everything we read verbatim in cs->value
> but keep track of the beginning of the run of whitespace characters
> at the end of the line in trim_len so that we can rtrim it?  That
> should be the most straight-forward implementation.

Yes, that's it.  It's as simple as it can be.  A different, somewhat
more complex approach of putting the encountered whitespace in a 
separate
buffer may be warranted if we expected _a lot_ of whitespace, i.e. much
more whitespace than the other characters, but that shouldn't be the 
case,
which makes the simple approach a good choice.

>>  		}
>>  		if (comment)
>>  			continue;
>>  		if (isspace(c) && !quote) {
>> +			if (!trim_len)
>> +				trim_len = cs->value.len;
>>  			if (cs->value.len)
>> +				strbuf_addch(&cs->value, c);
>>  			continue;
> 
> While we are not inside a dq-pair, we keep ignoring a whitespace
> character at the beginning (i.e. cs->value.len == 0).

Yes, that "eats up" any leading whitespace.

> If we have some value in cs->value, however, we add the whitespace
> character to cs->value verbatim.  trim_len==0 signals that the last
> character we processed was not a whitespace character, and we copy
> the current length of cs->value there---this is so that we can rtrim
> away the run of whitespaces at the end of the input, including the
> byte we are adding here, if it turns out that we are looking at the
> first whitespace character of such trailing blanks.

Exactly.  By the way, please know that I _really_ appreciate your
highly detailed patch reviews!

>>  		}
>>  		if (!quote) {
>>  			if (c == ';' || c == '#') {
>>  				comment = 1;
>>  				continue;
>>  			}
>>  		}
> 
>> +		if (trim_len)
>> +			trim_len = 0;
> 
> If we are outside a dq-pair, we reach here only when we are looking
> at a non-whitespace character.  If we are counting a run of unquoted
> whitespaces, we can reset trim_len here to record that we do not
> have to trim.

Exactly.  It resets the "need to rtrim flag", so to speak.

> But can we be seeing a whitespace that is inside quote here?  Is
> resetting trim_len to zero what we want in such a case?  Let's see.
> Inside dq, we'd want to accumulate bytes, possibly after unwrapping
> their backslash escapes, to cs->value, and these bytes include the
> whitespace characters---we want to keep them literally without
> trimming.  OK.

Yes, any whitespace inside a quoted option value is to be taken
verbatim, so we basically reset the "need to rtrim flag" in that case,
because value-internal whitespace isn't to be rtrimmed.

> Looking good.  We should already demonstrate that this works well
> with a new test in the same patch, can't we?  If we can, we should.

Sorry, this sounds a bit confusing to me?  I think there are already
more than enough new tests in the 3/4 patch I sent?

Could you, please, clarify a bit?

>>  		if (c == '\\') {
>>  			c = get_next_char(cs);
>>  			switch (c) {
