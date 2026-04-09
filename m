Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1326B757EA
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775739187; cv=none; b=A4KTegB7gwe4wTcQPRJ9aKsLhrnvpfnqwqIfDbQjF1m/0rC5d6XN1diFPTD4F80P0q0DCZ4inx9voEVfKIp+mX1CJfTgfInt424U0cXZ7DYp6Ou/5lxPhvyty+bMHUKz1P9fzm3FJGVJaXAlRJ56kV2JQtYdJviaZb7tYfMV5Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775739187; c=relaxed/simple;
	bh=GJynfOd7K6B2um1cEtOnyillEYtso4pJj9Ecuxs0xas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kUkT3iYXtYs57xtX3QNqjmrF8C4RS6BcBUBWpBkvdX6xjQS8iMfDa+Ix/v7fhxuKsLtFf6Qq9vTHK1uwMmfsKGcYWl8B+LCppyUtfUshTsUy0O3Ca3BgwGYK+M0Io+ZhDCcVpcvPTSEaDlCl+o8KOO2xz3Wl8zBkLZtEqZhVXjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWZQhiDg; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWZQhiDg"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-899d6b7b073so8564366d6.2
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 05:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775739185; x=1776343985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BGCLQDmLfAuiVJtJrqSQSEauLn/XuE8rAJaaDkzviQQ=;
        b=mWZQhiDgQVD2e0Mjvbsi+PFcLzzkCNMe3gwWzaL7sxtQA2UyNRRy7zgqREfIx10s+s
         amoY4n2AY0hD31XVpwbStL1Z+xljdKpEYpIIKXmHKH5xRB5yzxI+G5pd59HGWtEz4dWe
         qmMzJS5k7o1nMFVLtiMgl6xaNonoAIEN0D3kK7LA21DuG1ZK8pwHPpJabMbjmoHSdWwz
         rnuXl1uTJ+q6toljDhKpnhAJtZVuj3wSxdFg0COsVP/1XxCSRtlCIlxs/upFXp4yMKbc
         CfgyjsMAflvRqaZkiqfLsKtZKYeKZx0Q1vzhTY93ZTnikg/7jeu+RBmbK9SmK/1WDcK0
         vxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775739185; x=1776343985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGCLQDmLfAuiVJtJrqSQSEauLn/XuE8rAJaaDkzviQQ=;
        b=TztE2fHPqiPmzsoQSiFrGgd+73KTa6hLOrhCgT69cosz77fsTVVRqPpl7EiluKAoMQ
         gUyXfe2RJvbWz2+oUCe8PW17e92loZR+ROl1NwiFOZptTi/Vuo0GnHONNYtHVXi9T9WK
         5bGlKuSdCCshq1Ib/w4NASKbK9K0AIIIeGjEkTb6IlCTkMTIuMvA4rYxSzsHm7bV4btx
         6fB6IyFuyODBVYb+XZ0UprLgDNQKKseLnToqfhYgewdvU2QS9+LqZJ/GhJT6Z0aQiJKP
         OAOhn8TUG+RLlo/jLbdtqAGac25QGkDk0SvNig0BxCwlh2Jm/pqPj3p6f3vRo+XP6usf
         YShg==
X-Gm-Message-State: AOJu0Yzri7uD9JMFqpM9YWYHcHV66+dRZte+QfTtkTTXUi+7narAm6hq
	iYT1CP9qlQcoE7Y6AZ5MJw8zjZDSVL36Z/BCInCqSt+j0RYSQJyQNetEI9inWQ==
X-Gm-Gg: AeBDievv+avUuu45gSWW1Ks35Xn0JiaOhImDUBfR4sdPAOSQp6X7s3WZUQC0BJ0u3dx
	LEIaE83wejViSSIefaebPhM6LIt82JDCJ58ASycfGrws2CZBp2wIUhsev3nFfJ8pq2u4i3tnVV3
	Hd1kIGB1EIGv68LTxYWeW3AMJHPAhv3ZYbsOPYUDPJuznZDI8wBsASSdQxbNqoZSHox9PQdjxpW
	/Onyj0AwSfxO43Se1VwjT2mIXyWx9qf3YkaB8EDefBIudkXrkCwSgnxOnr1/YrlTSA6RrIQjnUi
	BnAfu65HFlH5HMrWpIhd7rHb43slntVPSiwaJ0rhNs9tSP1FSvLHbFS0n+ROt/Dfqu0QUxOMaji
	cL9bsYpUcjIH1D5fCnJQtZVS6wUZHu2JMiHulEdYt2c91Yt/jEtIo+gtaY/p6s1tB097gB4nWFO
	aG3KoEK+aLt5AOWHzwFNzygPImavJ7Hds7QS8WK7pAWCzxMqQoC2w5AXSPhK+f3FBdRDN4tT9wA
	NF4GbsZ
X-Received: by 2002:a05:6214:3210:b0:89c:bcbd:c26e with SMTP id 6a1803df08f44-8ac743c89e4mr56377716d6.25.1775739184823;
        Thu, 09 Apr 2026 05:53:04 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a596e03cd8sm189161436d6.33.2026.04.09.05.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 05:53:04 -0700 (PDT)
Message-ID: <e9634014-6829-4158-9444-7831640f782b@gmail.com>
Date: Thu, 9 Apr 2026 08:53:03 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] fetch: add --must-have and remote.*.mustHave
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, jonathantanmy@google.com, chooglen@google.com,
 ps@pks.im
References: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
 <xmqqv7e1xoqp.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqv7e1xoqp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/8/2026 2:59 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Based on my understanding, the '--negotiation-tip' option is close but not
>> quite what I want. I could have the client only advertise 'release' and
>> 'main' and never advertise any user branches. But then we'd download all
>> content from each user branch every time it updates. Perhaps this would
>> happen even with opportunistic inclusion of more haves, but I'd like to
>> explore this area more.
>>
>> There's also an issue that the '--negotiation-tip' feature doesn't seem to
>> have a config key that enables it without CLI arguments. This is something
>> that we could consider independently.
>> ...
>> Big picture questions to think about:
>>
>>  * Is this a valuable addition to the fetch negotiation?
>>  * Is the interaction between --must-have and --negotiation-tip correct?
>>  * Is the "must have" name sensical to users? I expect that this only
>>    matters to experts, but I'm open to better names that could be more
>>    self-documenting.
>>  * Should we add a similar config key for --negotiation-tip?
> 
> Just like you, I hate the name "must have", but stepping back a bit,
> would it work if we add a single boolean option that says "use the
> negotiation tips as the primary source of 'have's you'd send, but
> unlike the way how the original negotiation-tip feature worked
> without this bit enabled, which did not send anything other than the
> ones reachable by negotiation tips, do advertise opportunistically
> other tips", essentially turning the existing negotiation-tips
> feature into your must-have feature?  You could even call the option
> "--negotiate-better(=(yes|no))" or something, perhaps?
I like this line of thought. You essentially want to use the existing
scaffolding of the --negotiate-tip option but change it from being a
_maximum set_ to being a _minimum set_.

## Considering --negotiation-tip-mode=<mode>

With that in mind, we could have an option like --negotiation-tip-mode
that takes one of a few options. Here are some word choices that I
immediately thought about:

* maximum|minimum: Are these sets a maximum set to choose from or a
		   minimum set to include?

* restrict|include: Are we restricting the haves to this set, or are
 		    we including these tips by default?

* v1|v2: Use numerical versions to indicate the mode without commentary
	 so it could be extended in the future to v3 or more.

None of these jump out as a clear winner in my head. I'm interested in
more exploration of this space before rerolling.

## To mix modes, or not to mix modes?

One downside of this approach is that it disables the ability to use
both modes, at least in its most obvious implementation. What if someone
wants to force a minimum set of wants but also wants to focus the set
of additional wants to a specific ref space?

Theoretically, we could implement the option to toggle with multiple
options, using

  --negotiation-tip-mode=minimum --negotiation-tip=refs/remotes/origin/main \
  --negotiation-tip-mode=maximum --negotiation-tip=refs/remotes/origin/*

and as we process the --negotiation-tip options we'd put the input data
into different lists. Would this complexity be worth it compared to making
a new set of options?

This also becomes more complicated how to describe the interaction of
these options and any config options that enable them by default. When
exactly does the config get ignored in favor of CLI options?

## Considering --negotiation-(required|restricted)

We could alternatively create two new types of options that are clearly
related:

* --negotiation-restricted works exactly like --negotiation-tips and
  would be a synonym (with the old one being "deprecated" in favor of
  the newer one).

* --negotiation-required works like the --must-have in this series.

---

Thanks for considering these options with me. There is a lot of room
for creativity here. This series isn't even my first attempt at this
functionality because there are so many possible ways to accomplish
this goal.

Thanks,
-Stolee

