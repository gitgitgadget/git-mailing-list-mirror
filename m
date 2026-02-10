Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC6F31355C
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770747521; cv=none; b=pX9cgOhYjWJz/ZAbl0S9bafw5n86Yi2p+/sTTrJf46sSj5q06j4hJdjEuEZUeKAziDM6PLCqgzXBjFrN6gsHUQQoee/ekuFZRQJYnTgedAquiPuUw/bCLAq7ELEQ6bCLt7ZV3/GH5g/jwMJ5JS/9OwsUlBriJHRrh4om+HoKHGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770747521; c=relaxed/simple;
	bh=+2lER7RmwzKOeZ6dG+OGKTFB2zrZcKvQY2lzDBBYUPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKbf6ghu23WQyYK1fziOUhfrIkulViBuMdWBNfayuiXI58ff9FlCPIhnvJT93atK85DDAaeCGrNhl8YsJl2CLQainhn0fimIHDCDDYjPp0JnJDFaI93bQRdDSFgYEFbAFobz49xM+fMDOBxI7+NxuCtNh93lwiatGO0fmmmARKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbSQL34v; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbSQL34v"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c70ce93afaso123861985a.0
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 10:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770747519; x=1771352319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P9KeR6q3c6A7pP44TomWjGSOUxsIZatEaAvU7l8KErM=;
        b=SbSQL34vog+oXmrCkIyxnCqrQQ+X85XJ2oeqktrFxR/xbc2ViddGlzN4vBpzituLbY
         kY4pp6aZnt7/1ZBTVh26/iHOeupqt/yCWNfZagTab4AVa4glQfgjzHN2SNWYthgz6Cdp
         MEuCUXO098WNQ1HJ3WYffjhkAq0gOZvu0FrtKd8qvcbx3rh/XxqCvCYWJdeLcOq93GfP
         0lbSV9e65mMcSOrk2B8JvUSQ6oVCIkTTtjwBkP62Iset+OWoJsw/3FCrMrF1YyuCUfQp
         uK2oiq0z7MmKTryhPRSHs7HMF4SwN4KrDQqAZJl4cPTT4tIOsa6xFUbRsJn7ybLa9/o8
         XQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770747519; x=1771352319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9KeR6q3c6A7pP44TomWjGSOUxsIZatEaAvU7l8KErM=;
        b=FxlStqhOmFOS7AiO2vgyqfkzxDELr0g4JIX7e9RW/q3vo2NvOSfhmxS6V97RJlRu6r
         /t5jJP15rTVCp/AqsXqh2aRjbdzLYqoe3jEQDen7H0F2ont8GzRfrQ8+VQBKxdCoDyya
         Pfa1tZMFbprqlTW4mj8nfo4bcxHsCjgZtGUA+uh9aSg07cDaFKmjSEpxY/7joyMtv0xM
         ULCRp39F5eMverB8bpItWpfnmoCgoF+8CVaKJVHAox/hjxwT0vddFID7yCcJgx/L1JKz
         sTr4txaRy+dsI4SmrRc9h5+mjnIls4Fuwe0EGaIF2XSpEvFdgxrhgt/0SOE67xk+xbYx
         FH1g==
X-Gm-Message-State: AOJu0YzPafobhA6kkCsfhxDNLeW0nhFtnJDqzvUYXOZk+PYEe4RkRdl7
	bGDPVyDLpAsPLl9F4BtJW/ccQ2B/CGV34vSXKiMqq7zGLVBeUS1JqECF
X-Gm-Gg: AZuq6aJUYSc2ZkkY3Ig9nVOHDvMA+Y5RXUBaiH72Ma3gHvDXhLEDIaGX2UbQjQJspd8
	ZKZ9NOKz3uY6OWSAzGxPjBLQD5mgHOq3daeya+qNGg3u5E3KuC0jVFiXhSoXgHSF7u9hFbNXoeS
	ebaSrAlrawYtKcvfUuEmwaBBfxZUeMPOP5HOA/BhVTWJY+afH2VYILuK0zgFwZHU8DT1IvhFumV
	H6RI/NHMv6XXQ6LK5KDA6syfJqYyR2/+7FUNGtbzMyyVj+0x2TBgKZnaVCO+wQ/u8EjKUigkQ+8
	86FVwfrF/utWkrogyynwbWxB64/dWzr2NdYUN+2uzdB322iYKlF8TdjOVEKne8x7UWOU7fZCF25
	1io9jbmrBRedmXVoZj8Tix/Po4q8ZBYp7N3GMrJrVeVxqjpLgG7W/sols9uPU+1FxqSyhkggtam
	f1w8GnOvMWQW+N7FNX408vrApPxts2ycLsInLQKIMvocOYt1LYSdzKTkyzVCWUjhyANP5oqg==
X-Received: by 2002:a05:620a:4144:b0:8c6:ff8f:58af with SMTP id af79cd13be357-8caf1acb367mr2128059285a.51.1770747518870;
        Tue, 10 Feb 2026 10:18:38 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-896fb9ad27fsm56555286d6.4.2026.02.10.10.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 10:18:38 -0800 (PST)
Message-ID: <ccde188e-267c-479c-a012-a33027b2df63@gmail.com>
Date: Tue, 10 Feb 2026 13:18:37 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] [RFC] Make 'git config list --type=' parse and filter
 types
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
 <xmqqldh119e7.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqldh119e7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/9/2026 11:59 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:...
>> This boils down to the fact that the iterator function show_all_config()
>> doesn't call format_config(), which includes the type-parsing code.
>>
>> This wasn't super trivial to update:
>>
>>  1. format_config() uses git_config_parse_*() methods, which die() on a bad
>>     parse.
>>  2. The path parsing code didn't have a gentle version.
>>  3. The two paths ('git config list' and 'git config --list') needed to
>>     standardize their display options to work with format_config().
> 
> Thanks for dealing with them.  These are what I would have expected
> as part of the "inevitable consequence".
> 
>>  4. Finally, we need to filter out key-value pairs that don't match the
>>     given type.
> 
> This one, however, I need to see the actual code before commenting,
> as I do not think key-value pairs have inherent types.  The _only_
> special case where you can tell what type the thing is is the
> valueless true, which we can safely say is inherently boolean.
> Everything else is text string, sometimes interpreted as boolean,
> sometimes number, sometimes human-scaled number, sometimes path
> (with possible tilde expansion), etc.
This is the crux of this series. If the caller asks for a type, then I
see a couple different ways to react:

 1. If the value fails to parse in that type, then don't list that
    result, allowing the caller to have confidence that every result
    is of the correct format.

 2. If the value fails to parse in that type, then list it in its
    base string. The caller would need to do extra parsing to check
    that the results match the correct format.

I chose option 1. It avoids showing results that would result in
'git config get --type=<X> <key>' to die().

I'd be interested to hear if there are reasons to go with option 2,
or if there exists an alternative option that I don't see.

Reordering your message somewhat:

> As there is no "inherent" type associated with each configuration
> variable (in other words, type of a particular configuration
> variable is something determined by the caller that wants the value
> of that variable), "git config list/get --type=auto" would not work,
> but it would not be too bad to allow "git config list --type=path"
> to treat everything as if it is a path and having to filter nonsense
> out of the result (like "core.bare = true/false" or even "core.bare"
> without value that means true, which may make the "*force*
> interpreting it as path" approach to barf), which is an inevitable
> consequence.

I agree that there is not inherent type, so the user can only
specify the type that they are expecting. To me, this is a request to
filter the results.

I don't think we'll have much success if we try to guess the type,
such as trying to parse an int, then a bool, then a path.

Thanks,
-Stolee

