Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE8721106
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 10:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893062; cv=none; b=M/gJOjyLT93MPZpSkSLkrAxG4Gz35vLLre0A2weVKhTXIIXZmSvcWR9yiVesk4t5tRqVx5Sitq7ogtgtr1KUduPNSSVP3/Sszd56SdeD4BJy+suX9ZSbQZAU0HxuEf78Yu586K9425e+klBTdbrvrB73yuvuXudyyq1CWSF5gfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893062; c=relaxed/simple;
	bh=AnvhvGvJPlPrYMH/oLXxY3e+HAEFv3lj+Yk+AxP+Reg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pDKz3JnO5BJC46TBH9xsgxoGIHxdVIPTf++NT9S6TwXLA1bo3m9eBaPG4AvQN+KkwCpFh1OuPlmDKVPqwcgi1dQSxspDJtF65uawJ7Wl551vnCG1u0sMbotd5JgfR14b7xQcTbdU7f+WviOVMpDgtihyf489yzjiDJ49aOYkvw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=do8O2EBG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="do8O2EBG"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412e784060cso17845215e9.1
        for <git@vger.kernel.org>; Fri, 08 Mar 2024 02:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709893059; x=1710497859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oavDcsFlXnS+6kjNg5ZDlrp0mawqTI56KUZDYuVTPW8=;
        b=do8O2EBGIwyKDaNRdev7tuWCacryZyhm63LZ5dnhZrMTuwQyW+cUf9EPyXYXah2Pzr
         D8Rc3fq+cJl4N8gpS7+6vvMcSYJXVM6jG4paIXNFn56raRwhy5o8+ejlvEqcXTWdAIbK
         xBDFGt0GpOa/e5fkGCHGyVgR001ke/i1nm2K93fMaSvknKQfPsG/oXAKTYDJQvJHS4Ui
         XR3NO5gCINKiWkZTFNtthz22wp6JE0/Fs+FnK14y1yLgL5rdy3nhYtM6vjH0I1WDkKm0
         Gh3kzsFBrjXLnPaJaVX5IXdEHwNuxXYTAT126ZwruNOWC117ZptB0q4q+WxuxuZ/CpIF
         /VDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709893059; x=1710497859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oavDcsFlXnS+6kjNg5ZDlrp0mawqTI56KUZDYuVTPW8=;
        b=TlSajWERG00zXEpWBuUsPuTXyptp6AvJhljfQ20YCv0vMOFcNayPyVgp2s39j6cq/d
         0lVFA55D1XNygBjx0+KaT7dy0SED522RCLPVesZ46xRSVQiLHKDjYdGdQHM9BKGlBjj7
         FL5H4VzNsHTNxgEVm9EWI2yHpBtHhzndInhGVSgtdt7JOjz/ktiU2+qjZWQum4b5fv3a
         8rhYwXC2c8+RL+PRTN/6f+7ViVZX/0llnkE/ru8lonpMYTSJwohVdr7sAvzNLPyU3+Tj
         atew3IEyReL49s3gV+5j52sAxg0KVvi6UfQbNWBogLfXOv24v0QlKWdQ+dU6ZVY9BGWI
         PKgg==
X-Forwarded-Encrypted: i=1; AJvYcCX6CMj2LSQnn/yCDo8WHbtQuSL9G2VquOaWDEnYdzCwF+FPdyeDosuztSyVUtS/gOssgrwc8euojIA1A6SoXVtlTxRj
X-Gm-Message-State: AOJu0YwutrYP/KQdMuDtFmwv4N/J0N3i69omDnjpnwPXpMwEDRbFeWA+
	vl2cdvKub85H9RI6kbztvNGhmYE+VLVRR8VAtf3jcEyQEEE+ztvT1mktV41wQBA=
X-Google-Smtp-Source: AGHT+IGeonUHKBC199248rKkLRBd3iOCyZy2Z37CgDZPl38RrQONRJPe7nYtFmiEbi5zTSCWK2Z82w==
X-Received: by 2002:a05:600c:4589:b0:412:f82d:c9d7 with SMTP id r9-20020a05600c458900b00412f82dc9d7mr2625876wmo.6.1709893058631;
        Fri, 08 Mar 2024 02:17:38 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6ca:8b01:80a6:cae7:d811:7244? ([2a0a:ef40:6ca:8b01:80a6:cae7:d811:7244])
        by smtp.gmail.com with ESMTPSA id bp16-20020a5d5a90000000b0033e0567e90bsm23353391wrb.5.2024.03.08.02.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 02:17:38 -0800 (PST)
Message-ID: <d82e11f2-15c1-4ecb-8c7c-19667d2c5fb4@gmail.com>
Date: Fri, 8 Mar 2024 10:17:37 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 11/15] find multi-byte comment chars in unterminated
 buffers
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, Jeff King <peff@peff.net>,
 git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Manlio Perillo <manlio.perillo@gmail.com>
References: <20240307091407.GA2072522@coredump.intra.peff.net>
 <20240307092638.GK2080210@coredump.intra.peff.net>
 <3f823e48-572c-4e19-ab76-e6d7cab9461f@web.de>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <3f823e48-572c-4e19-ab76-e6d7cab9461f@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Peff and René

On 07/03/2024 19:42, René Scharfe wrote:
> Am 07.03.24 um 10:26 schrieb Jeff King:
>> diff --git a/sequencer.c b/sequencer.c
>> index 991a2dbe96..664986e3b2 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -1840,7 +1840,7 @@ static int is_fixup_flag(enum todo_command command, unsigned flag)
>>   static void add_commented_lines(struct strbuf *buf, const void *str, size_t len)
>>   {
>>   	const char *s = str;
>> -	while (len > 0 && s[0] == comment_line_char) {
>> +	while (starts_with_mem(s, len, comment_line_str)) {
>>   		size_t count;
>>   		const char *n = memchr(s, '\n', len);
>>   		if (!n)
>> @@ -2562,7 +2562,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
>>   	/* left-trim */
>>   	bol += strspn(bol, " \t");
>>
>> -	if (bol == eol || *bol == '\r' || *bol == comment_line_char) {
>> +	if (bol == eol || *bol == '\r' || starts_with_mem(bol, eol - bol, comment_line_str)) {
> 
> If the strspn() call is safe (which it is, as the caller expects the
> string to be NUL-terminated) then you could use starts_with() here and
> avoid the length calculation.  But that would also match
> comment_line_str values that contain LF, which the _mem version does not > and that's better.

I agree with your analysis. I do wonder though if we should reject 
whitespace and control characters when parsing core.commentChar, it 
feels like accepting them is a bug waiting to happen. If 
comment_line_char starts with ' ' or '\t' that part will be eaten by the 
strspn() above and so starts_with_mem() wont match. Also we will never 
match a comment if comment_line_str contains '\n'.

> Not sure why lines that start with CR are considered comment lines,
> though.

I think it is a lazy way of looking for an empty line ending in CR LF, 
it should really be

	|| (bol[0] == '\r' && bol[1] == '\n') ||

Best Wishes

Phillip
