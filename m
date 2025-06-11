Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D22221708
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 09:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633335; cv=none; b=BCNDxpPXM4eTw4DhM8Jpq7vBHF4CCaJGaHYJNqliAOgwvl3fp0sEbro2KrwPy4oiBjm2MJ2ZKyp7iG6JXZy/7AbYvUlYXbBp/iGZctzOZFiyFjR0FM2TgEQfN8P7nbCPoaoGgQL8Ev5D1k+JL0IqhMHyXuRKREBqgC3smDs8q14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633335; c=relaxed/simple;
	bh=oguKBWTucfGzADhA1dB6UT+ZMUz4us1nNwXPbLYt3oU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=m15uzI/HBJaZJBXWjRDD97Jm1FWPSlsewQbcd5Xxb+9WLTkW0gZKM6ti9UtunWdVx+H2N2vsgMI0y1hBW/eFS8l+bp70R8bSQDHw5RwhmOmz12uHbYnEvd3Pm+tdVm8fn7LAttg9h8zlp2k1y9l5hwao754eTkV+9J9bEL21AIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjeplG3r; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjeplG3r"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4f71831abso5947406f8f.3
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 02:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749633332; x=1750238132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E1KfwYodK5zqONt5s/4dWp0JT0mIZ//PPJcLS0BS4zs=;
        b=DjeplG3r1Vyat9q+v2vRvogVVuGbvUI7YfOVeTgimAxxcfFp2ACGupWLgr53sYpSTC
         y8c8scnLKD5tYUrXxH+I6PI59TFh2Cbeto+Y5dHqpHyPsZe3GoQSqV0xJJetRrIneEkF
         81T56b7CA11Iex4xKhaR/8CZJVTZh2ZQe+plNaMLYzxw553w+q5eXi6viamGeafA8slW
         OPZoCM2W2AeVP2aKo+lWEKk7steGQw+6fnVe6yKtyUNqgJSKin5zFQrl0hXKgKrVWH0y
         /04JJ6kGemIUPO5+VB6e50vwqbpc4L12zP3nwxa1O/56qmkdkto6A7yxAZyeSdBudMhx
         f52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749633332; x=1750238132;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E1KfwYodK5zqONt5s/4dWp0JT0mIZ//PPJcLS0BS4zs=;
        b=j3q2pwfEZ6RkAPMzqnv7urC643fY44HcXag/7rHkGAHTrupPZA4kowPUJBdCGHHPY5
         0dwKpnJiH4456V5CbpCgd3C589VGPNEbVJpdVjqua4v55WxbLoOJHs5jenXw7XjpVbx5
         +CDJAwVYot8czhxkysalwwtHygtXLe3fK+y5Kf+fAO9I77ItfmbMSC3FCRt9lyAF8jvs
         gr+sMIA56BMRRUHsNYQtu40ppSCNVQ84ZCmM+dXfO8TcgR2oazGk/O9r77UE9euaHnWe
         Qx1woiC/8dn2Sk/HTrjo7OF2joG5/6oQ3/ZsxouCt25Ya31vuWg4hsQVav97XdVT8Q2X
         RUqg==
X-Forwarded-Encrypted: i=1; AJvYcCUM0Dlimv8IcybGzoQfA1cPpv22e9rFk6rmcZAzzIIvzu4DPdpFZIs0hVBt9Bv1wwZ0gG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQQf7/neyNDS+jlSCyVGGOsM6aVrbMn0iSrZnrxXPRhh/IQBDn
	fQQu66Iy9aH8b4Br5arYxFTDnRvyVgwPgKA3E2bemNCtTB0LanLCUeg+QdwkUA==
X-Gm-Gg: ASbGnctmd9BhZuwiLalb0+tpuOE16JK/JxkNK8Guz7KxGUox7ynLBJI/sGGXfHiw8WO
	XyF3NtL7QPdII00QhsaAx3UgQFZtgjR0n1z475TFF04zElTiYMBpOj4fXLz8LBh04xoOBcaryOO
	4wHExOia2g+oFyNJrxAbtcyK/CjeMZNTxk4r/z7ZDRVET++ydoes43VtDa1zB/FuDiSvbs5D91d
	RoPkxYjbpxo6N4KHsOitjUDNlEhwLbNR+7cPImU+ufLl4dPVPwo1W6JhjuVPwxVSd80dGuBk6s+
	cT8GcRPmLcPbjXVkdaqspuFrxCo63jGAPOsU3n539/z+5jhfW5KxxuqdIFr8fcFRvbKO5K0VJcE
	WsD3z2aGK2ljH8XkYzIBtPyUzh50815iKJGUN3w==
X-Google-Smtp-Source: AGHT+IHUgdQhMv71wPFHk4i0cyj2ke5zcSi0bFIAHYfjN2YkXSYKCeEEphoS8CZArCJkELF7eH/ogg==
X-Received: by 2002:a05:6000:2010:b0:3a4:c713:7d8 with SMTP id ffacd0b85a97d-3a558aa3a97mr1932144f8f.16.1749633331927;
        Wed, 11 Jun 2025 02:15:31 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53229e0dcsm15079232f8f.15.2025.06.11.02.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 02:15:31 -0700 (PDT)
Message-ID: <407631ab-1184-41b1-8043-fd91d860e845@gmail.com>
Date: Wed, 11 Jun 2025 10:15:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/2] trailer: append trailers in-process and drop the
 fork to `interpret-trailers`
To: Junio C Hamano <gitster@pobox.com>, Li Chen <me@linux.beauty>
Cc: phillipwood <phillip.wood@dunelm.org.uk>, git <git@vger.kernel.org>
References: <20250610123459.278582-1-me@linux.beauty>
 <20250610123459.278582-2-me@linux.beauty> <xmqq8qlzkukw.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq8qlzkukw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/06/2025 01:09, Junio C Hamano wrote:
> Li Chen <me@linux.beauty> writes:
> 
>> * `amend_strbuf_with_trailers()`
>>    – parses the existing message,
>>    – merges trailers from the command line and config,
>>    – formats the final trailer block, and
>>    – rewrites the supplied `struct strbuf`
>>    without ever leaving the current process.
> 
> If such a helper function exists, shouldn't "interpret-trailers" be
> able to lose quite a lot of lines, at least nearly as many as the
> new lines introduced to this new function, by making it call this
> function as well?  And that would ensure that the internal call can
> safely replace the external call and produce exactly the same
> output?  If so, that can be a pure refactoring patch that can become
> a commit on its own, I presume?

Exactly - I was expecting to see a refactoring of interpret_trailers() 
in builtin/interpret-trailers.c that moved most of the function body 
into a new function in trailer.c that added the trailers to an strbuf. 
This seems to be a parallel implementation which doesn't sound like the 
best plan.

I'm going to be off the list for a couple of weeks, I'll take a more 
detailed look at this series when I'm back

Best Wishes

Phillip

> 
>> * `amend_file_with_trailers()` becomes a thin wrapper that reads a file
>>    into a `strbuf`, calls the new helper, and writes the result back.
>> * `builtin/rebase.c` now calls `amend_file_with_trailers()` instead of
>>    executing `interpret-trailers`.
> 
> And then these two changes can become a separate patch on top?
> 
>> -int amend_file_with_trailers(const char *path, const struct strvec *trailer_args)
> 
> This lone "removed line" can be avoided if the patch did not touch
> this line ...
> 
>> +static size_t first_comment_pos(const struct strbuf *buf)
>>   {
>> -	struct child_process run_trailer = CHILD_PROCESS_INIT;
>> -
>> -	run_trailer.git_cmd = 1;
>> -	strvec_pushl(&run_trailer.args, "interpret-trailers",
>> -		     "--in-place", "--no-divider",
>> -		     path, NULL);
>> -	strvec_pushv(&run_trailer.args, trailer_args->v);
>> -	return run_command(&run_trailer);
>> +	const char *p = buf->buf;
>> +	const char *end = buf->buf + buf->len;
>> +
>> +	while (p < end) {
>> +		const char *line = p;
>> +		const char *nl = memchr(p, '\n', end - p);
>> +		size_t len = nl ? (size_t)(nl - p) : (size_t)(end - p);
>> +
>> +		/* skip leading whitespace */
>> +		size_t i = 0;
>> +		while (i < len && isspace((unsigned char)line[i]))
>> +			i++;
>> +
>> +		if (i < len && line[i] == '#')
>> +			return (size_t)(line - buf->buf); /* comment starts here */
>> +
>> +		if (!nl)              /* last line without newline */
>> +			break;
>> +		p = nl + 1;
>> +	}
>> +	return buf->len;          /* no comment line found */
>> +}
>> +
>> +int amend_strbuf_with_trailers(struct strbuf *buf,
>> +							   const struct strvec *trailer_args)
> 
> ... like this?

