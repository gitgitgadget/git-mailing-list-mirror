Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEC434D3A4
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094539; cv=none; b=XccR1eOYofOfopNzTMyAOVGc7bRUcM3oTOOp23kn57gpRV8nKCM+N30Vw1u/wlpE9NcolluN+uj/dsnwg2w7xjosSFYcsNdRk9Xr9TIwCh2lCnYJcvB7/SvI7sgldR3dOT546bFUnpONK4drMjqpJj5DUDNOnRezrrFXhIo439E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094539; c=relaxed/simple;
	bh=84w2b3nnaS7ZsYjjzQatBpbeKZ0Geu7x6otVZD+7R9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JNy6UH0ezuqWhkiYfYUFJRKa8tfBhmz4aJGbR3H8CpMKJ5/y334jM8erg6X9qhruxE0JRpdd2pcFMT1/09mg1h5d4I/eRg6LGK7St4a86nxCY0BgTSU+lCeQs2BAQ83b6F6EgF8Ylexr9Q3U7Eurg+SuTlABSdS4imr5hCDS/to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2n3iY/Z; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2n3iY/Z"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c655e0ee70so133029185a.3
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 07:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769094536; x=1769699336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MfCKnph0Tx8f613yYc8kfpdnjW+j5vKoBl/Ci/bO5vw=;
        b=i2n3iY/ZUZ6nyfjZy/MkCaCS2wSCD+7YhoRPb3pH09cA5iTUbwXxLfLtWijHkCzMwk
         ecm0v5whQJArdPojtFMCMz4p1vEur0kXvsjX137L3KaOexk3UjV7unQrHFXxCQjyJHtD
         12Xj2r+tuK2eHRDfkKbHI6ZC9maxqcUp92gmuqm8xS8QzXTsTwiiMV+fbfqhcv4qQbzv
         WQxeNzGSKaebNN+F7OEqx6t11oJrYJU16eBWX3A1n8PdPL3/xCjLHmlMFUEkgg4X3p3j
         smYRjV3dBeZB25BlmuESyj88NU/8F5YQEy9bszSG//KEOO3OSHcr7s3+hLRK5IfhwA8T
         r0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769094536; x=1769699336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MfCKnph0Tx8f613yYc8kfpdnjW+j5vKoBl/Ci/bO5vw=;
        b=ehyoTd2qMNXxxds6kAbpfDllfpP6/BKoTC9a3Wkd3hDHDrnI0ne594dVaBpcAJMpA+
         nnUnpERjVbek/nPkxmTbHoj8P+wBT3b0XdPxUdvcE/jOJ5Z9RTfl7BZGmEzL2Y5WKTVp
         4ynSUZQ8tKYCK45Ob74lAbq871HMgiP+G/GcSjAwn2AvvKDmdQ22fQmE27sUsMTl0AzX
         GPRq585k49NU2mEKfluUf50XzSsMzmlJ4XO+Fe76YlxZhAHQpobsf1KUsU0c5UrztWt9
         aBYL2vHaCLLuOdmVrVHsC4O0kLMG6sVwAMXN2kcl0SDX5bn0e+yICa8ZVnoEX/l054oh
         KzUQ==
X-Gm-Message-State: AOJu0YyFTY45RUPn8wxiVvKTQmfFYT1EAZMrjR3vnO7yGZ/PTyzQcdHP
	PziU9WV45norBD6a+LKiYmNbTpCx/JowjHgH58ew84T4flzjsO//WYAY
X-Gm-Gg: AZuq6aJnUBk9vNkRmf8mxJF/t2yLRNCunSU1IhwwlFJb1XHkyaRuVnwKJVGfr9FRKdf
	TKlzMjGVs6vGsHLHm3UfK3ooaL7Hufso7r7ipFwKSjP5AXrWErNFlzQQXd0TKUjnwR5vSHv7YkK
	kOXi3QQKPq9tColqOOxQqAXk2h9ncbSzCj3QMN5OgFSu/pJNkwFKt4gffTBKpo0WEUs54tMYVAz
	KY8KL1NBAxA8pyxVdURUUIefA5gDFOb3VFYrRphGzzK63XYnEhJOLYtoMQyyo3qqWi0U3SHngqH
	bDoLGE7I+ng9+iddWtU4dCLWY0RSoB3DI//K6M/o+uUqlis1v67UxiWud+sQy5m2nCuHFxy5bdj
	r/rjj/zsIw0PaHO1QL7+LcOmtnAvrGKH1WSZephAXBVIYUDD+D5TQTaUKchsdHpBobrWqS01yXH
	6l2UhT+eaaE+xUZs2ViblDKPuSI8EyJbloRJVet/z+prH4XhiegQAViCarZA9XV8tPGRc+iOBAY
	CDbtDYWoh4eE3R7z/EpKbruBcy9AQSAjy/g
X-Received: by 2002:a05:620a:4441:b0:8b0:f2bd:4762 with SMTP id af79cd13be357-8c6cce54636mr1162859385a.75.1769094535590;
        Thu, 22 Jan 2026 07:08:55 -0800 (PST)
Received: from ?IPV6:2605:a601:8119:700:91d2:4624:f41e:fd3c? ([2605:a601:8119:700:91d2:4624:f41e:fd3c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6de520c60sm102518885a.0.2026.01.22.07.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 07:08:54 -0800 (PST)
Message-ID: <85c6fdce-d48a-4af2-ba19-432885a034ab@gmail.com>
Date: Thu, 22 Jan 2026 10:08:53 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] revision: add --maximal option
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2032.git.1768703645125.gitgitgadget@gmail.com>
 <1da38e88-3f61-43df-9c75-5716d715bf80@kdbg.org>
 <b46885b1-5781-43d8-8751-d85048c45e5e@gmail.com>
 <1ce18cac-f988-4741-b9dd-6c1cf2d4e6af@kdbg.org> <xmqqo6mp3zft.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqo6mp3zft.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/19/26 7:22 PM, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
>> But even if we decide to use "maximal", the option must be named
>> something other than *just* "--maximal"; this is simply too generic.
>> Perhaps "--only-maximal" or "--maximal-only".
>>
>> Other ideas:
>> - --hide-reachable
>> - --range-head
>> - --range-head-only
>> - --most-recent
>> - --most-recent-only
>>
>>> [--maximal]'s interaction with
>>> --boundary is trivial because no boundary commits would be included as
>>> they are necessarily reachable from a maximal commit.
>>
>> So, --boundary --maximal shows only the maximal commits? That sounds
>> unexpected. Boundary commits are shown with additional mark-up; they
>> don't need to be suppressed. But in a first iteration it's probably
>> better to just make the two options incompatible.
> 
> If I am reading the answer to "what is minimal/maximal elements in
> partially ordered set?" correctly, our "--boundary" essentially is
> to show direct parents of those commits that would be shown with the
> (nonexistent) "--minimal-only" option.  So I agree with you that it
> makes perfect sense to make "--boundary" and "--maximal-only"
> incompatible (it is like asking for both "--minimal-only" and
> "--maximal-only" at the same time).

The existence of a --minimal option that doesn't match the mirror
of my suggested --maximal option convinces me to move to
--maximal-only. I will send a v2 shortly that updates this and
moves the documentation next to other filtering options.

I'll also mark --boundary and --maximal-only as incompatible to
avoid confusion.

Thanks,
-Stolee

