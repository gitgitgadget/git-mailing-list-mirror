Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3392868B4
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770299535; cv=none; b=JEFHfaJlJsavYXbqqKPPwBxTNZe6TWNGDKP8h3Yvo0tia1VvFfR5b1NBLOGvF+ZgHqwozyNVIKGb1Bx0rRtrExDvJzM+2v9Ye3ihIDIepNHfWIEPHMnFK+mNR7xUqSMAzOPsXA/njQMMEEVsAShWZXbdXuNhNozRYywRoTAEShQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770299535; c=relaxed/simple;
	bh=BsaApHkxLsK7yjxMT63wjZA1EjFjFrFCNWCXolp0mlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JCCkAUguBMWbxMgDHvlFO3xNJ6ol3qWA5ahi7AjOFkpzX41Qz2V5H47D4VaM26uMQeos/JXqY9LgppMAt08ZPzohFx0m23mq8CmxSTONHkRsTYrvEMnMNk7hlI29qzZPSqLyKM0siywGgD1BX5SmCKlsvEjG0zTuDwf/mCUmYjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOnvHOGo; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOnvHOGo"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88ffcb14e11so13648036d6.0
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 05:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770299534; x=1770904334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cPi5UQ6+r2/qoBP0t/ja8NHI9c9XmP4fU/4yiXL5LuY=;
        b=cOnvHOGo+dzzFUoctd8ibtWgELLPYC59SlopB2ZyU2gekewImQYbOk66IfSOZHSHsH
         B/nvRD22+w5v4qSIhxR5ffqQPNSbWAfrLENIhr0etnHct5YGL+AqSHlfBoPYjtHDw8sC
         DYf6h8sAQVmXTPAsJZxSdRmqThy/dNyLxie0tQ5D0nbxiXGbg6dBgl5yZQ3A74UKTJLV
         S5+jzV8ISMzpSTT6nsOxA53p91bOPfEblbeFIeOXCcoGbXh8q6lEoLIxjX8Pj6s8xxDi
         3QJ+rIPk2H3L+jX8wCNGzPkYLwTb8dTZ4FNluPxwcCBGDJdMxcyl4BlYzoIKwelHO7bX
         A60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770299534; x=1770904334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPi5UQ6+r2/qoBP0t/ja8NHI9c9XmP4fU/4yiXL5LuY=;
        b=QH687oQ99bAy5an/WSy/vjhIy9sGqTksGntBMYYRKcue+fJ0NwWekR2H8+/Tvn3gvM
         KHqE0jk2K2YFK5n0QEkbznJEUvMAMxpQaHGEjyL9ZnORvgOwnlGAAT95Tc/ranNlvk1W
         9rcLYPEB4JtMmRDmIMw7vBs6DAIzwSv9er1UQmRHf7f2TWQSYZpc4EQ7S0Q84bwwk84h
         DQi9jubDgkIuCXdzYoCHnT0f+5eZwQeyDScGpO/xiQNszP4UPJANKMK4J4I4h0gdcjXm
         LrW8aOB5FUbnEXPS7EiKdmanQMjCkecy01KCVoKaNr2lGp2zVL1s1bFukqrPDQPXCwXa
         bOaA==
X-Forwarded-Encrypted: i=1; AJvYcCUJaaquMXimnDZvSMYYNqo/a9EP8ooDB2UKa9Ka1M4J94mpkjnhNsv/LW34rdrMId0z2Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUmxRmjKMegpPWO27jGzgCO3nhsF/C5faT1jjt4w/C4O6HjxuP
	zyhAJfR1SkWmJ0MCY+OUgjef443JPMNfhZjAUyROZc+nHOnNsfWIdfKe
X-Gm-Gg: AZuq6aK0L+KRboHna8zsg9e6e163tfky1CFZxIwVV0WUCTgZN/y44WsvjT6xpIi6hXi
	h+5UV+ap45VT22jTbZ/E3VhJUj5xrfsP+MahlOVL5wlrN09W3ckgp1hL6RMKUJMUgfPFyg/r5fi
	ei4Wi1S68/0jgruGC+75JaGjqYWxC+x8BvpncuZZroYQmStb4TciWm7QuK/8vLV/6COkZfkH7o3
	Vp1cgYqOEZmOPPA5ADGTVmHK/gd3Jb3Odptov9BmlJwOx4rWowUloOG9ojzCp0nK0o1BI8uNec1
	gJfvW9xEG+GPvWzbbjj4DZPA1BWSd9mHBNWEruWKxJ9svw/G09GAQP2gIs/Sh9xCaNUp1zocu3F
	ZKLwbQV0VUPw6PSQ8P9y2cn6VCeWNLxSTIUSQm0q47GIcj56SW2yNyjl0tZTU4ikVzjLpdC8KoE
	Am6CnsFku1ES0HpQFAGZd/VwA6JmkrZQ/z8qrwxVfkS6TR2pTuaV9VjaxyXA==
X-Received: by 2002:a05:6214:194c:b0:895:b3b:228b with SMTP id 6a1803df08f44-8952219cb17mr98275786d6.43.1770299534085;
        Thu, 05 Feb 2026 05:52:14 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521bff135sm40379476d6.10.2026.02.05.05.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 05:52:13 -0800 (PST)
Message-ID: <f6687192-58dd-479e-8df5-a422c01f03f4@gmail.com>
Date: Thu, 5 Feb 2026 08:52:12 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] [RFC] config-batch: a new builtin for tools
 querying config
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, gitster@pobox.com
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
 <aYPeiqkw41ln7De_@fruit.crustytoothpaste.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aYPeiqkw41ln7De_@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/2026 7:04 PM, brian m. carlson wrote:
> On 2026-02-04 at 14:19:52, Derrick Stolee via GitGitGadget wrote:
>> This RFC explores a new git config-batch builtin that allows tools to
>> interact with Git's config data with multiple queries using a single
>> process. This is an orthogonal alternative to the effort to create a stable,
>> linkable config API. Both approaches have different strengths.
>>
>> My main motivation is the performance of git-credential-manager on Windows
>> platforms as it can call git config get dozens of times. At 150-200ms per
>> execution, that adds up significantly, leading to multiple seconds just to
>> load a credential that already exists. I believe that there are other
>> benefits to having this interface available, but I can't recall any
>> specifics at the moment.

>>  * Is this a worthwhile feature to add to Git?
> 
> Git LFS has the same needs, but I believe it can use `git config -l -z`
> to do that and parse the config options itself.  If this is just config
> fetching, I'm not sure of the additional utility that such a feature
> would add.  If that interface _almost_ meets your needs, could we add
> functionality there instead of a new interface?

This is a good suggestion to look into as a potentially-easier solution.

There may be some work required on the consumer to interpret multiple
values and the right inheritance rules. This is relatively minor
compared to attempting a full parser with complicated 'includeIf'
logic.
 > If you need to set many keys, I'm curious as to why that is.

I know that the credential manager does more than just query the config,
but also sets and unsets config. The full interface is here [1]. However,
the performance-critical parts may not require mutating configuration
values, and hence such a 

[1] https://github.com/git-ecosystem/git-credential-manager/blob/main/src/shared/Core/GitConfiguration.cs#L31

Thanks for the pointer to git-lfs as a similar use case. I see that it
has a way to get the full list of config values [2] with '-l' (but not
'-z'). It also has methods for getting values on a per-key (or even
per-file) basis. I have not tracked the uses of config code into its
consumers to know how often one is used over the other.

[2] https://github.com/git-lfs/git-lfs/blob/bb65882304a655ffa8abf2be6922e53ff18af5a5/git/config.go#L208

Thanks,
-Stolee

