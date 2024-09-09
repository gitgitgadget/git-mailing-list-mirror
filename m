Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B15E1B3722
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873227; cv=none; b=T02iSxo4T7w5arveWnveDPSUPJXRyNz4b5O82d9PJhst6s6gYg0CpoGw8Dy3RjVX/BVj9hvPTCU42++XMB3963fq/9VvEYahpQErC8rstn8RXOSwO2CoWj15E17DkGhmpeQ6IGi9tu7lJIiceGSc1Z/lwDOHv39LcFDwxKOyrI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873227; c=relaxed/simple;
	bh=iQy0Un0TSyjwOBeCg0pWZkAOZhKIRjPM5W3uV6nUkDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGWHNF0Dty4Q4i8wYcTzDa7uAUJvPlqBoLukKiqY1EG8swO75XENQIIJdlvN8IYP2xk/AZ1w7vhLISzWipNUCf9Al7zxXaAQt14A7NE8x2qvYU8ce3HQYFnO+sfMYFzSI0CigrT3/Jd7zQ9uKoTocbzJvz+ie0TfUfvQsHMQfm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCFyOAI1; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCFyOAI1"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374c4c6cb29so3707015f8f.3
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 02:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725873224; x=1726478024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N/urotPDNpRMt+KMAR/CkHFx+LYYRhl88FQLh5IZey4=;
        b=DCFyOAI10R9yL4RMUendUk1G5IdEkyPAp5zCSobUBQO7Zg9yl3Dc5JWkDqpoq8p3o8
         XNLktSRfSFCZL5DgCcWZpCzHKfGazOheKjO5KI/+PtOi3uVnn+N93v7EI59KvZEOsq3K
         0KUPfBogI1wOlha3oWfUn8J5qbDu8JJhLCoQ2ULLaO/jHs1zi2stowCZLkvVU292Eild
         WgeOBtFowHPUaTYoIlVewMIof7q7j0T/jzd8weTRPQO880AbEdQYtX2zgz5lKznhgi7a
         kWqOwNlZwDEEQCNJKm6AbPUW0x+RacHnPzr0emRocuv+SUMVvpH20oynSm+fWyNiVRlb
         637w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725873224; x=1726478024;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/urotPDNpRMt+KMAR/CkHFx+LYYRhl88FQLh5IZey4=;
        b=kPTidDBUikQsAhP9op/wL3c6PBml1VgvLvyqEZ9kfrIWaECAUDgJajvydtV2fnVK/j
         SOAmL/28tq6sut7Iy98pQ0CfmWmhXwo2MRe6apKRmlswK4WD32fjEHVhFxCLrXm4IAxp
         +VXQmuKVPBw9eKvO7DZmv1wQr0uDwsdQGqNsOuGwUYOi1Uto/8Z4tA4BBlkuAHtvroGa
         McQ5YvcpBk+jXMCRA5JSQePcBi2gG24f57uLm6pgRRztYd8zB5V1jTLFDQ5r1dOwIZwZ
         ayiA9HMnciJha0xrOC5B24+cCupTiF5vx6J+7pPgE7R39weP2kF2ef1s0JF1mVQWs6m7
         l2iQ==
X-Gm-Message-State: AOJu0Yw47TZJdm8D6duvKNtOIEHVYupFU5fUxEcHCKbZt3vapgo1Yl1v
	PVY9IKsnOcQnTfyKdEAEihXjZd2OhyzDEWFio4KzCGvBycVn2D97
X-Google-Smtp-Source: AGHT+IH7US3BY/kE0Jljix1wUh/E62tXYoBEr+mYIcfbdLEUoLhqFVsolLWd/2vO6HFgx5z9R1vwRQ==
X-Received: by 2002:adf:fcca:0:b0:374:c90e:990c with SMTP id ffacd0b85a97d-378922b7aefmr5626761f8f.33.1725873223727;
        Mon, 09 Sep 2024 02:13:43 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956dd9a1sm5465596f8f.101.2024.09.09.02.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 02:13:43 -0700 (PDT)
Message-ID: <5f804f35-a69c-454e-a505-4ceeb9859387@gmail.com>
Date: Mon, 9 Sep 2024 10:13:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] interpret-trailers: handle message without trailing
 newline
To: Junio C Hamano <gitster@pobox.com>, Brian Lyles <brianmlyles@gmail.com>
Cc: git@vger.kernel.org
References: <20240905173445.1677704-1-brianmlyles@gmail.com>
 <20240906145743.2059405-1-brianmlyles@gmail.com> <xmqqy144wy60.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqy144wy60.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/09/2024 17:21, Junio C Hamano wrote:
> Brian Lyles <brianmlyles@gmail.com> writes:
> 
>> When git-interpret-trailers is used to add a trailer to a message that
>> does not end in a trailing newline, the new trailer is added on the line
>> immediately following the message instead of as a trailer block
>> separated from the message by a blank line.
>>
>> For example, if a message's text was exactly "The subject" with no
>> trailing newline present, `git interpret-trailers --trailer
>> my-trailer=true` will result in the following malformed commit message:
>>
>>      The subject
>>      my-trailer: true
>>
>> While it is generally expected that a commit message should end with a
>> newline character, git-interpret-trailers should not be returning an
>> invalid message in this case.
> 
> I am not sure if the above example resulted in "an invalid message",
> though ;-)  As far as Git is concerned, a commit log can contain any
> sequence of bytes.

I assume it means invalid in the sense that the trailers are not 
separated from the rest of the message by a blank line, not in the sense 
that the resulting commit object is invalid.

Best Wishes

Phillip

> But of course, various tools to manipulate the messages (e.g.
> "commit --amend" and your editor that gets invoked by it,
> "interpret-trailers") may not be prepared to see any arbitrary
> bytes.  I would have written
> 
>      While a commit message can contain arbitrary byte sequence, the
>      fact that the user invoked the interpret-trailers command on it
>      means that the contents is expected to be a proper text, which
>      should not end in an incomplete line.  Instead of detecting and
>      erroring out upon seeing such a log message, complete the last
>      line if it lacks the terminating LF.
> 
> or something like that, if I were working on this change.
> 
>> Use `strbuf_complete_line` to ensure that the message ends with a
>> newline character when reading the input.
>>
>> Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
>> ---
>>
>> The range-diff from v2 is not included since the patch is so different
>> that range-diff is not able to provide anything meaningful.
> 
> Very sensible.
> 
> Will queue.  Thanks.
> 
>> diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
>> index 3d3e13ccf8..d78cae3e04 100755
>> --- a/t/t7513-interpret-trailers.sh
>> +++ b/t/t7513-interpret-trailers.sh
>> @@ -175,6 +175,46 @@ test_expect_success 'with only a title in the message' '
>>   	test_cmp expected actual
>>   '
>>
>> +test_expect_success 'with a bodiless message that lacks a trailing newline after the subject' '
>> +	cat >expected <<-\EOF &&
>> +		area: change
>> +
>> +		Reviewed-by: Peff
>> +		Acked-by: Johan
>> +	EOF
>> +	printf "area: change" |
>> +	git interpret-trailers --trailer "Reviewed-by: Peff" \
>> +		--trailer "Acked-by: Johan" >actual &&
>> +	test_cmp expected actual
>> +'
>> +
>> +test_expect_success 'with a bodied message that lacks a trailing newline after the body' '
>> +	cat >expected <<-\EOF &&
>> +		area: change
>> +
>> +		details about the change.
>> +
>> +		Reviewed-by: Peff
>> +		Acked-by: Johan
>> +	EOF
>> +	printf "area: change\n\ndetails about the change." |
>> +	git interpret-trailers --trailer "Reviewed-by: Peff" \
>> +		--trailer "Acked-by: Johan" >actual &&
>> +	test_cmp expected actual
>> +'
>> +
>> +test_expect_success 'with a message that lacks a trailing newline after the trailers' '
>> +	cat >expected <<-\EOF &&
>> +		area: change
>> +
>> +		Reviewed-by: Peff
>> +		Acked-by: Johan
>> +	EOF
>> +	printf "area: change\n\nReviewed-by: Peff" |
>> +	git interpret-trailers --trailer "Acked-by: Johan" >actual &&
>> +	test_cmp expected actual
>> +'
>> +
>>   test_expect_success 'with multiline title in the message' '
>>   	cat >expected <<-\EOF &&
>>   		place of
>> --
>> 2.45.2
> 
