Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770F12BEC55
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 05:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776836971; cv=none; b=D+QJEks4NI+ilJkF8EV+nyS79s0DckqnmqGFeTXes7kwwiWePAfBgv3bc/gdYc4lusJND2Oex58E7FA2ghKO5t0ERqahVDShx0GiZVq69jB9XxSk7PNIiVZvz4OFKfV6DZyqaGvJdmbZ6L+f9Rb0kTXfYrth2iFzKLCGLSC7d/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776836971; c=relaxed/simple;
	bh=/vOk+YgqMt1CpMdmBt5ku+xMWy3jqhNHk2OLW4+Kajs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Io5Ii8DP5e8ndLMu2SYHKPCcgdBvfuQ3PG0G6uvzl6zHMlMS9qWAcO39FxWdZfV9KJZzXODtsvxgG1d58hDyObM5NL4z8ANSDgUzTukS4xgrB+KS05qmZw3mgAWQJ6G3b9yst43ZWSUhmHz/t9w0D02ytdlJ9oeFH+ZtJKtL5OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjMNXXUx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjMNXXUx"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so66793595e9.2
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 22:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776836968; x=1777441768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=03VzW4i17Zl9fKBilXP3suueMeiR9lMNRQmMPDoh654=;
        b=OjMNXXUxjTvMn83Sxjo/oBGlwx2jPjWJfvjL1DRy8CAW1/98VxtfxzcdHLiyYMqlom
         W8FM5EIdYb6TqWziELH8+5zwlj9LTi/Y5FDhFEJ2gX5ZIEfJE2YuUfwqLG5+k52zBB9P
         IzsrGphTDeiyhJkmGKR/01gHv/kJ1EeD+eDZSU1Wfh2S+wgd+A48MvpwprUCBSN4y7g3
         ZK9UBgxVQwU43wDrhchKC8dMs9Fl+e8e6x0l+lo2CyLg1G95OJXMxT4VAwC+Rv30YMXD
         qWu5ovv4s2D9eQ6TY69usfLbYZpdCu81Ww93N6MYm9PxHOtVZVKbvZn0kW2hIzUOrqHi
         VMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776836968; x=1777441768;
        h=content-transfer-encoding:in-reply-to:cc:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03VzW4i17Zl9fKBilXP3suueMeiR9lMNRQmMPDoh654=;
        b=PKA1kQbn8zf93ge6Z13NVs+22YQl1D+wVI/CQyX1OPCJ9xdV2MnRtJDwkvtJu5R3jY
         rOJYZzsD7TsKp8N9QQ+T7sOv2K/ZSQ/frZlMhutuqr0aIm15SFsV5kzzMdIadcP8+7Id
         knvsxp/QyNc+vzHSla0Y2VsDF8CW/fFnwG/Bl8WigbJJibgL23JVRhAwwYFc4FyyxRKx
         xN8DkzXqJVhr/3Udj3hriBJPa+0GZLrj6Pb2YzEy0IKJsXZ3hkGjo6QzXgmUu1E9Zik0
         1elQ+yk0gODuQR52Q1HzH7yhX8wHcup+Rn8UFZbEc3eF30XgdTg1Oo4vNR8TgaaXZD4j
         HLvw==
X-Gm-Message-State: AOJu0Yw1KGtPlShfUnrvGu4GU3JdSr7lKlGSc499KzNbdAUPJYhfQe4+
	jK3Mr0IqaH7NWLJedRyrx7OWfMCv/RazMk2BwbDWfvYP7uqV8MmW0RrEHg35MQ==
X-Gm-Gg: AeBDieuIghMez4yh5rX2KXpd1g1i1bEpsd73zomkuEgottTLr0unIz6crItz4ecQ848
	QjgY5qaeZXGdTvYXXdP8j0V1PXyJ3m4wauuauBVEtXHgHjtfvzjUxKw6zndtl55GeRMNtX6i3DY
	uu/VsCu5TyqT5k5BDpUFEYFnL/RVX8GR5kKkG/zLkmMDpbJr3q4V2uF6oKcoiyzgq5Bc9la0qZn
	G+BFnROEhkcDl6kyH6r+nYyndCosX+npQ63RFwPPeSIeT/VlKSWygKHHFc0rLvYd4S62V/2YK0q
	IxDhcQVww3kZBbq4SJ0pMGKg1I3kO0sikzXfzxThp5ETJ/GDpLqAc3UhbSrSYhxToobTOHVkBqH
	ZgQkbNlM2XNBSwUEqH4BbfuTDp3GN+X8hTkIvrI16zVN73tpxQqi1z24z4P2TKsRzSYrQV/8I3Y
	YNIn7cHNZj+Lpc0FMBeCWRGJoZ1OLvkGpt76JEH3ylWbr+J7GwQ29rMMBZs7CLc8f8861IDC8X5
	Sfxmb+h07pLVNOmi6oRDI76nogFp/Q=
X-Received: by 2002:a05:600c:3216:b0:489:1ff1:74d3 with SMTP id 5b1f17b1804b1-4891ff17521mr80719585e9.20.1776836967539;
        Tue, 21 Apr 2026 22:49:27 -0700 (PDT)
Received: from ?IPV6:2001:778:e27f:a23:36c4:e19f:3c1:8a8? ([2001:778:e27f:a23:36c4:e19f:3c1:8a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5c24d82asm1889265e9.7.2026.04.21.22.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 22:49:27 -0700 (PDT)
Message-ID: <0b2370ed-f3e1-4011-8a2c-8da539759881@gmail.com>
Date: Wed, 22 Apr 2026 08:49:25 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] git-credential-libsecret writes secret to stdout on store
To: Lutz-Christian Quander <lcq@wateringcan.de>
References: <b7b6b94c-7e42-42a5-95e5-d44a54d6da0f@wateringcan.de>
 <2d5b37b0-3442-42f8-81f4-18b48e95a617@gmail.com>
 <60cf5f7c-9ccb-4dfe-82e4-9b6e54b3c2c0@wateringcan.de>
Content-Language: en-US, lt-LT
From: =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
Autocrypt: addr=grawity@gmail.com; keydata=
 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
 aETxZy4lQ+jpsbG/q9fvS/sAZA==
Cc: git@vger.kernel.org
In-Reply-To: <60cf5f7c-9ccb-4dfe-82e4-9b6e54b3c2c0@wateringcan.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

(Re-adding list to recipients.)

On 21/04/2026 14.47, Lutz-Christian Quander wrote:
> Thanks — fair correction. I tested `git credential approve` with the
> libsecret helper and it does not leak: git discards the helper's
> stdout on `store`, so the documented user-facing interface is safe.
> The leak only manifests when the helper binary is invoked directly.
>
> That narrows the argument, but I'd still submit that the fix is
> worth landing for two reasons:
>
> 1. gitcredentials(7) specifies that helpers should use stderr (not
>    stdout) for messages on `store`/`erase`, and that helper stdout
>    is ignored on those operations. The current unconditional
>    `credential_write()` violates that contract regardless of how the
>    helper is invoked -- it just happens to be harmless when git is
>    the caller because git discards the stream.

The API contract isn't violated IMO, as documenting "output is ignored" 
gives permission to produce output, even if that output is unnecessary. 
(that is, from my reading, it implies that output *will* go to /dev/null 
– and running the helper manually is what really violates the API 
contract from the other side by not ignoring the helper's output...)

I agree that the unconditional credential_write() is a bit weird upon a 
closer look – it and the entire main() was just copied as-is from the 
older "gnomekeyring" helper, under assumption that that was "the 
expected way" the credential_*() functions were to be used.


>
> 2. The direct-invocation pattern shows up widely in distro docs,
>    StackOverflow answers, and automation scripts -- empirically the
>    "internal protocol" boundary is porous. Fixing the helper is one
>    line; documenting the internal boundary across the ecosystem is
>    not.
>
> If the preferred answer is instead "users should only use
> `git credential approve`", that would also work for me, but it may
> deserve a note in gitcredentials(7) to steer people away from the
> direct pattern -- the current docs don't actively discourage it.


I think it should be fixed to remove the useless output, especially if 
the command is as widely documented as you say (although I'm actually 
surprised that any CI environments even have a libsecret backend running 
*in the first place*; I would have assumed that they would use 
git-credential-cache or something instead). You should send a patch.

At the same time, I also think it's a bit too much 'self-inflicted' of a 
security issue to be CVE-worthy, so to speak... I mean, I don't like 
automatically blaming the user for holding it wrong, but in this 
particular case, I'd like to think that one would test the command on 
their own machine first and see how it behaves before putting it in a 
script.


>
> Happy with whichever direction you prefer.
>
> Best regards
>
> Lutz-Christian Quander
>
> p.s.
>
> Thank you for your very quick reponse and your Open Source work
>
>
> Am 21.04.26 um 13:37 schrieb Mantas Mikulėnas:
>> On 21/04/2026 14.03, Lutz-Christian Quander wrote:
>>> The documented pattern for seeding credentials non-interactively is:
>>>
>>>     printf "protocol=...\nhost=...\nusername=...\npassword=...\n\n" 
>>> | git-credential-<helper> store
>>>
>>> Running this at a terminal prints the secret into scrollback.
>>> Running it in a shell script whose stdout goes to a log file
>>> persists the secret in that log. Running it in CI captures the
>>> secret in the pipeline artefact. Every real-world use of the
>>> documented pattern is affected.
>>>
>>> Severity is moderate: the leak requires the user to run a legitimate
>>> command -- no attacker-controlled input path -- but the leak happens
>>> on the "correct" documented workflow, silently, with exit code 0.
>>
>> Is it actually the correct documented workflow? I couldn't find it in 
>> the Git docs. My understanding was that writing to "git credential 
>> approve" was the sole user interface, while "git-credential-<helper> 
>> store" was the internal interface between the git-credential builtin 
>> and the helper.
>>
