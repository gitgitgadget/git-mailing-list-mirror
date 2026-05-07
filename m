Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD2F370D77
	for <git@vger.kernel.org>; Thu,  7 May 2026 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778160274; cv=none; b=m9xvIP2G7EvdbmQGEQjT+Q6nWRG2NMYq9opCY+4hjvmTYvuwdbZSLdpuqKhoApivS3X1BWVxW7R8eVI2JGIQTcgWP0k41A7ZwzqPBc3iEU97tlz4WCzZffNVhYRVkMYvYFiNN9cn0Z+tKY94S8xKpWLcuQq4X/W6t8+Klgm0aH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778160274; c=relaxed/simple;
	bh=vCeZX1iLN0FJsLYBDro+1DijlKcKkSdWH7gX9fKIVpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9rCDfxXZYvItykHMKLwSy2eTBKVa9hKL2foV3IV/CutPlXBjrWxSIEoYuFVJ2Ko7T+gT+2xdOo+StxvHUDIwdGH86Yteg1UeN4kL1rZZIYH6VXPmvBDMBQBElPvrw485idkEJ3qGucuH5GakDmqIGOLuZvShmFVG8mF3ASUqmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/sBZHsC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/sBZHsC"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso8139845e9.3
        for <git@vger.kernel.org>; Thu, 07 May 2026 06:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778160268; x=1778765068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V6McZO7JZZ/EOp4CQeeQcZEr8uukwq5UOhzb/IZLZ2o=;
        b=V/sBZHsCZ4xNQvzdTPg3cC50dKCLjvQA1aELoVsDNfyy5bHtBEj5dNy4g4lzW+q1A7
         2nWP+e6ydIsZteILMzt3lVk5I9IBf+vRcBO4aZA3Xk+7HJ1nwQTBSeC8cciukXPqg+9Q
         fBL4+gm2XE9OpxU+z9sMum8JW2Pr1XugDxyG7n1GTBtMxASzKlf+fapq7LwZKOCU803Y
         HM+4s6MXSHhDNQ/D1H3ByJSu+aYZ5YzjwUTIbf1WZBPws5ksUdbiPQsOtq6Sak+0vT66
         HxCSEJYOMfXuydRLpRaAh/IuXQO3oozyBjUtcLyfHCh6EExC9UtHmo3jC9H//Pr/gWwq
         sOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778160268; x=1778765068;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6McZO7JZZ/EOp4CQeeQcZEr8uukwq5UOhzb/IZLZ2o=;
        b=RGg/40X/3PQL8Z0niE+2ba6MHjvqt1OAYK0LMBljAysgxTKtUPuqTqdm3eiWjdOUIg
         6pO+Dwf1HOoYBLriGcefpQBpNA9IkKsqBArA8MZk9Kf2BvX3xEofAH6dh3lBkNly9vta
         JUWoIBtlxpAiZbTN9SJli/ONIZINXF0lqiZCj3gGcMX0aWzEe4/XUwq/jl8yzZCznuTX
         MMQ0sFJ8T/2K8M7ltzkY6mJzRjf2/TFXbMBphNC+r1O/YnZZTEWlVmwvULtrhqp7uUJU
         VASGNiSjpY8aW6SIeNJjeVIAGX3JfHi/ilC1qcihd0QnuOtvjDjZcirvKVz0H2iugOL4
         a3DA==
X-Gm-Message-State: AOJu0YzU4utGHt5olXghFPv8CtUokIYVSDasu5Njd2ieW0KCkPqTcIxj
	oHzMTWuoCHkBCIl7zfU5tCR5UDFOtUHP+YiFIjXfMf2tCcMfFXSkpPCF
X-Gm-Gg: AeBDiety582Jj6CZPV0D5PZjOewMzogCIER2tIbnwe+hJJWTxdPSFsqcmMV+8qtqpeR
	l+vw1nF43JxKuU65GVsxOeVexiO2D+B4ejGereoJFZ2710nv8vR/OqNaCKJPAPuIWGeUlsoBeJK
	jS2PTedB7LBtTFYrBmdkPSsvCb96xqRq+enXxasgLRJ3EhrXaLIoiRtBsh3DDhkAP7TCk9AOCxT
	g9MTA1gpMgfN5vjYlMSeYpFU5Dx5BYBW02kBiPZYKzGZmJfW3U1Fh1enxPXI114ivUgzIaAyd+I
	glrBmvzG1I1uQEftVxKgcutKNBa74KAv+Mz1ggmNMjOy9CcNBUQdq4eFUarrTIYBnCPQuX/J98h
	y3zmdDJY1yvuevTUEMND3PLtoYWaWehXPqsFExDi8r7lZwWHMAif/nUJuurGd/KMF7OyGKdUkwp
	OF5zrXUKf2z9fo9y1YYQIqRQfPhPLQkPPEdEwqO+0MM0q8JTUDZP6fOq3WRUCe86WKGobpSArwL
	+N+y4BvwcJv2jK91Z//ZQ==
X-Received: by 2002:a05:600d:849c:20b0:488:a2ac:a34c with SMTP id 5b1f17b1804b1-48e51f220e7mr97904685e9.12.1778160267513;
        Thu, 07 May 2026 06:24:27 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:76d:4c01:bd41:1f83:652f:1d59? ([2a0a:ef40:76d:4c01:bd41:1f83:652f:1d59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538a517bsm134242055e9.4.2026.05.07.06.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 06:24:27 -0700 (PDT)
Message-ID: <1f811deb-7cbb-4fe0-ab40-49274b1db165@gmail.com>
Date: Thu, 7 May 2026 14:24:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] add -p: introduce 'w' command to view hunk with
 --word-diff
To: Pablo <pabloosabaterr@gmail.com>, Javier Bassi <javierbassi@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>,
 Rene Scharfe <l.s.r@web.de>, Elijah Newren <newren@gmail.com>,
 Ruben Justo <rjusto@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <20260506235459.529862-1-javierbassi@gmail.com>
 <CAN5EUNRT7V3BrtyU0UYwGVnJ51LWSsNi1OnzMB5WL=w8vhKmrw@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAN5EUNRT7V3BrtyU0UYwGVnJ51LWSsNi1OnzMB5WL=w8vhKmrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/05/2026 08:55, Pablo wrote:
> El jue, 7 may 2026 a las 1:58, Javier Bassi (<javierbassi@gmail.com>) escribió:
>>
>> +static void add_word_diff_line(struct strbuf *old, struct strbuf *new,
>> +                              const char *line, size_t len, char marker)
>> +{
>> +       if (marker == '-' || marker == '+' || *line == ' ') {
>> +               line++;
>> +               len--;
>> +       }
> 
> Maybe a tiny comment here would help, to know why '*line' is being
> checked here instead of 'marker'. They seem the same and one has to go
> to marker declaration and see the comment at 'normalize_marker()'
> 
>    /* Empty context lines may omit the leading ' ' */

That's a good point - it might be clearer to use

	if (marker == *line) {
		line++;
		len--;
	}

instead. That also trims lines starting with '\' but that shouldn't 
matter as the code should be checking "marker" rather than "line".

>> +
>> +               if (marker == '\\') {
>> +                       if (last_marker != '+')
>> +                               trim_trailing_lf(old);
>> +                       if (last_marker != '-')
>> +                               trim_trailing_lf(new);
>> +                       continue;
>> +               }
> 
> Here we check about "\No newline at end of file", after this point I
> believe that 'buf->buf[buf->len - 1] == '\n'' will always be true.
> Same should be for 'buf->len' because "\No newline at end of file"
> shouldn't come first and a '+' '-' line should have been added on a
> previous iteration, but the check it's fine, just in case I'm wrong.
> 
> What I want to point out is, is the 'trim_trailing_lf' function
> necessary? It's only called in the same place and it carries a check
> that could be on the caller instead, leaving  the function only with
> 'strbuf_setlen(buf, buf->len - 1);" making sense to inline it at this
> point.
> You could keep the buf->len check:
> 
>    if (marker == '\\') {
>            if (last_marker != '+' && old->len)
>                     strbuf_setlen(old, old->len - 1);
>            if (last_marker != '-' && new->len)
>                     strbuf_setlen(new, new->len - 1);
>            continue;
>    }

Should we be trimming '\r\n' if the file has dos style line endings?

Thanks

Phillip

