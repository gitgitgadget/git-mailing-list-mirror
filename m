Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE06320E00B
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763913124; cv=none; b=k+RPx78GZkG9yu4+46e1UVNuJRkEtAAhmcP7By2n5bpfYPEE7Gf56Pqkb+IOOayftCn7rZ3u6ac0s9q4nEu5AwCxy/6YfUOVIpRUIBV0kQmPT89p2l0yo0psIi9AzIHa772FWzpt+dyWcl8iC46FPVhhcDe4/Hx3LRwKB43gdu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763913124; c=relaxed/simple;
	bh=ApfQSjg/+YSjkNAA+0qrVZ8z25fhGIxXiKapCjrW/as=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XIVLfBW4YI/FeMec7o21PvFZqtrTr4Wdzrd3Xyp7zrwHz0Lo2S5SHU2wxW+fqDCkoBv2tp5PGZ6XlL5lSvkBmUy2cetloNL551bcmqv5us8qNf1j0K+bhbgnQQtINcAvY4MRFJapeLeUm7Ok3La7tJLBKck3JplSdyHsX7/JMZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsLodkM5; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsLodkM5"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b39d51dcfso2048884f8f.2
        for <git@vger.kernel.org>; Sun, 23 Nov 2025 07:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763913121; x=1764517921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KVLmMgTBevtfA6aVeH8hYEjfUecp51Mo119WpgZAlb0=;
        b=QsLodkM5OgGzBHdh4r5Vl/ULHTDZtJkP2WB45RBFz5QPCaE/pAhydwhuaccsXPQFmP
         xYpg2+4MHaVrPJY5KNMlorNw3uv7Zg01PH9VnSQVFhr/M+e/byx/wvEX2cDWXAbB8s09
         b26Xy7GH9tiN3nxUSWYIJzal6qhIdqSFRYc0zeyR2Pw8kumb0brTwMq774gEiwAm7xf8
         EoZOMJ2Zp/oHimbmFfb16KNyqI0WRLBXc+5GDtqRJIQiiBPS56T+eYf9+vkiflyONZgo
         3sksUw+bICDl4lXR0Kz1Md0kp5I9UgnXrogt3H6T62BOVsjvNwHYtvb37bCWeZVE5BlQ
         2wnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763913121; x=1764517921;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KVLmMgTBevtfA6aVeH8hYEjfUecp51Mo119WpgZAlb0=;
        b=ckMlVLQb6IqAhO31yZyW3TKGfyxNIDNNRhXfjGOQ8H8ueSixXpvRQjanwwzr5Ek/N6
         ICYNv4l9h35ah9Ibb0CK+jThAEhftmVSIM/xa2xHvtrVnGY92GM1llBNxuhhglgoBWO3
         QJE9m9MQ7kev7HjTdObLTIO3UwaV2TLRYri6oJEAIsqr3YOosLAJHfZEZn/OEutkKYQz
         ZRLZps0IBMSqja4OkVX/Y6RdPAPiuZxeW7IvU+vipu34PmvRW3g0SeZOpz1J0MtZpIIU
         W6DLdH3sbCrWA3aKrni8orKgW6BheutI3ami/8YKXc9cN7MbH6t6fWmKfX+iQXved4V7
         kBBA==
X-Forwarded-Encrypted: i=1; AJvYcCXcFw//1axjcjZECSdgOCFojdIa7mee4gP58XMUH8DTulrtjh5E8YY5XKxjNB/rEoLJpag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB09fBBv6lnTYeeFJuH68CpQZhqmRDU63BwG4FzA0YjGQ1ojEr
	27GslI5UcALrdH8efrJiqz/dmipCwdks31UXWvBXhESyzk0yv6JHBWe6
X-Gm-Gg: ASbGncsk+OB4XAyr0Nqcqsy9Gwv4Iwy+rco9AbBaEnSLn5JxIHejbxXXLCq245e1l2T
	KTytZmKQSk7cs4WWndslmZ49O8by+qhdM/aALal+L7mc+6LC6iw+8tynpCkJxeBnvXTXBPafSK7
	UOnI6Z1XwAVrs66Jz/Fu779igOu9at0Gl0anSgXxQRYJhdHI+JXNf2na4oF7UMMbV+6AIljVC8l
	zgC+dzoqAHt5aM+jz8G2gT9L4kOY3ZtXklK8X+uzMj2jdjKSMua7ungNeeOpyJvfW+WMsLw/2rL
	8LrhTNpUPTTFIVj8G6LTPtPQPPFWCEpuP2Okzf//3xD+dJKeJo+OLn5TXLANamUtQqmTqG2WdBZ
	dB+mzAFdlvlmEnlNmRoZ5mEwxMHIg5ZQkblHMYaWcqzE8dgBUFABBb99GRKZumXNdEk+dIwXkcu
	G4sQye+0PBRT/GwX6mqH3F140QpFNR5mvXQhGHXP/B6V7lO1DWd4DaSbfbzznaB9s=
X-Google-Smtp-Source: AGHT+IFHEP88PcNRE7PRJ2qS9r5tCqeFL2uW5ZODOiDVl6oYTOk1oRQ28QReAq9z9wLATTocZxv5Hw==
X-Received: by 2002:a05:6000:4012:b0:40e:31a2:7efe with SMTP id ffacd0b85a97d-42cc1accff0mr9373809f8f.14.1763913121003;
        Sun, 23 Nov 2025 07:52:01 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9022sm23146944f8f.36.2025.11.23.07.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Nov 2025 07:52:00 -0800 (PST)
Message-ID: <633f4d92-c258-45a8-9d32-116c94838e68@gmail.com>
Date: Sun, 23 Nov 2025 15:51:57 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/9] cache-tree: avoid strtol() on non-string buffer
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>, correctmost <cmlists@sent.com>,
 Taylor Blau <me@ttaylorr.com>
References: <20251118091127.GA4175601@coredump.intra.peff.net>
 <20251118091218.GD529192@coredump.intra.peff.net>
 <ca6d99cc-d05c-49fb-ab3c-d7668077d32b@gmail.com> <xmqqtsylz2xh.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqtsylz2xh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/11/2025 06:19, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>> +	while (len && *s == '-') {
>>> +		sign *= -1;
>>> +		s++;
>>> +		len--;
>>> +	}
>>
>> This accepts any number of '-' signs but I believe strtol() only accepts
>> a single sign (the standard says "optionally preceded by a plus or minus
>> sign") so this is a change in behavior from the existing code. I'm not
>> sure we really need to be that accommodating here.
> 
> That is true, but at the same time I do not think we really need to
> make it more strict with extra code.

All we need to do to accept a single minus sign is s/while/if/

>>> +	while (len) {
>>> +		if (!isdigit(*s))
>>> +			break;
>>> +		ret *= 10;
>>> +		ret += *s - '0';
>>> +		s++;
>>> +		len--;
>>> +	}
>>> +
>>> +	if (s == *ptr)
>>> +		return -1;
>>
>> This accepts "-" as a valid input, as we're tightening up our parsing it
>> would be nice to require a digit after any '-' sign.
> 
> Ditto.

If we limit ourselves to accepting a single minus sign then this can become
	if (s == *ptr + (sign == -1))

so we need very little in the way of extra code.

> We could try to be more careful, but it quickly became messy when I
> tried.  Here is an unfinished attempt of mine.

A generic helper to replace strtol() that takes a length rather than 
assuming the input is NUL terminated could be useful elsewhere but I'm 
not sure we need something that complicated here. I do like the fact 
that overflow does not cause undefined behavior though. Changing ret for 
"int" to "unsigned" in peff's patch should fix that.

Thanks

Phillip

> 
> static int parse_int(const char **ptr, unsigned long *len_p, int *out)
> {
> 	const char *s = *ptr;
> 	unsigned long len = *len_p;
> 	unsigned val = 0;
> 	bool negate = false;
> 	int saw_digits = 0;
> 
> 	while (len && isspace(*s)) {
> 		len--;
> 		s++;
> 	}
> 	if (!len)
> 		return -1;
> 	switch (*s) {
> 	case '-':
> 		negate = true;
> 		/* fallthru */
> 	case '+':
> 		s++;
> 		len--;
> 		break;
> 	default:
> 		break;
> 	}
> 
> 	while (len) {
> 		unsigned next;
> 		if (!isdigit(*s))
> 			break;
> 		next = val * 10 + *s - '0';
> 		if (next < val)
> 			return -1;
> 		val = next;
> 		s++;
> 		len--;
> 		saw_digits = 1;
> 	}
> 	if (!saw_digits ||
> 	    (!negate && INT_MAX <= val) ||
> 	    (negate && INT_MAX < val))
> 		return -1;
> 
> 	*ptr = s;
> 	*len_p = len;
> 	*out = negate ? (0 - val) : val;
> 	return 0;
> }

