Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E4823BD1F
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771079804; cv=none; b=BGii6jGdMMIVdiODlAPkIgdtDoyyP+KOdttLrAPWJqDIHQjSDwTX80OaJ2g48lDbkpvMyhEdC4yoe/1Ly/2oWWppljQqsp9CrB0Sj43NIWXwYOljk68Efb4zSuhB9mXtOv0e0kkGgeUq01XUschBoma1AGV858m4vuESQM918PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771079804; c=relaxed/simple;
	bh=+QlAnng/2rYPLHZbm6UhRJv1JPGgMWt+3V6TtAf4nso=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XQ+tcMoafB+EF+wh3kwcHYrd/zoxCz7MDh2kA7FOEr2UXhcqtbA6adiU58GEEfRGBajv74LWAJ1+TDaj+0+6lcloFwxY/d+81KiY5/buwXsRiJWo0GxKrOeD39+2qGr6GVD6LQmxS1m3M3sKr6c8FN6A65I3SBjhLY4t/dLQDXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQKn8ZQ3; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQKn8ZQ3"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4836e3288cdso10865115e9.0
        for <git@vger.kernel.org>; Sat, 14 Feb 2026 06:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771079801; x=1771684601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kk8P5kSmvEmdWbKiY8DwqpLnrqGF6SXlBdQ12uLbAyU=;
        b=UQKn8ZQ31U9UyalLVWdTiose6ZJxr9fwSpQxNJkd/i1fMEpZyFe1twd4LjpCWSfAbB
         PPPDL0wJFSYPevs7PdRDBIurzaoc1wAQIgfAqZq1Rts03CsEw8yAgC4iiGmsOrmL9iQZ
         l09sM0ltYwVqKODCaYrmPlQJRCQKjnscrd546G8l+Tq91AGlTWpgqV80EFkk2J9zfhFB
         HUCGx4b4y1KDe8z8J1YBpolLN3ustUigDhUCLHjjLgzqT9aQKoP0y2/47ka8BPhtQX5K
         CIAAihFLwqdzopSSWEUW0mJPPE3sMTGAEbKnzouyNOBDccL+QPNtrhNYegZ+EJsRYUKf
         9G/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771079801; x=1771684601;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kk8P5kSmvEmdWbKiY8DwqpLnrqGF6SXlBdQ12uLbAyU=;
        b=JAtWVulCnazh8WYDxZUHF20rQIKyJGqwjPBe5+e8o2IrnDW8XCpXwu//9Rt+1ovXqp
         yHBsG5BUSTr7g/TzlKvjGGy9LJ0EZG/74ILKQsAjDk/rkYQ1G8/5yBB3x1yWiy2CtE4j
         vvHhOUbELtgCkRwFjE198oUG74em1o9dzsLJ1Nf1ChC7HCRL1LfQSyzU9Jg7DcBZxIF0
         5yjjATImNb5CBXsyMRtfNQUTDr8EYWFPyTUnrlCslw1jZOoMYUlJt4U46odntEA42wWy
         C7sAFhD4ZEpawAZNj/jZBakg1dQ4iWiBZGTkxcUlDCAPlhClRf9gePw8ua5uMfmqmGQY
         Mkug==
X-Gm-Message-State: AOJu0YzqaIom16VFm2LbAb3OiqpLsJRZmoDzyMxtDmRw/bDzGREQjXcf
	PN460ACPAJjtRcTD1lRYRqr7Yz5JxglUt6CRUPEHDmcBI2vQyfHZpElC
X-Gm-Gg: AZuq6aJTtfc1UNo7ifDAVh83sQkpAX6TXoGmMbPYelUWALBWwkk3GJZt1SkBzLEJie9
	UP73x69qotlMiQ25p2ExhSJ0vrhZ3aAe+RtglcXu9eFjk0vejw6NXNYJetjFu/eMlxfrOdtVXTA
	WEgfEDUZWLAkgknr0dtPNYBLUP0ATZzdAaGfXsdfNl/BXTFqsVoV0XbWg/5RlYMN9KnXm6ksKWl
	rWIoqzNkAPW976X2GYJTWudV3i3oelWmvo5Qd6fopxAj8mpkfeht6PM59dAC9EN/4neEU1V3Cl1
	aw5Xularas9oeFuEqO6BJgX8rRg6XkLvBTByGzTRYyk0zuF+qkLfKcmSXWucPgKRfjgAeG5LW0e
	T0jaIUC0B3f1Y1bUH5w5yeNQTHy0lGydp9C4qV/ubG1cP9L7zDujr3yd+yWimS0V3nNK6F2XsYI
	c6xQ+dwb7dtp4jjEceaTc1Jp6WYa7gBOugg4soweN78M5SYdjnfLekp4HKoSJpSKsj5kAOeo0eV
	t/V/w==
X-Received: by 2002:a05:600c:4446:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-48378d58817mr56844415e9.3.1771079800927;
        Sat, 14 Feb 2026 06:36:40 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc85csm12942831f8f.22.2026.02.14.06.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Feb 2026 06:36:40 -0800 (PST)
Message-ID: <20ed1f26-f60b-4e30-a0a5-8bd01dee19d1@gmail.com>
Date: Sat, 14 Feb 2026 14:36:39 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] templates: detect commit messages containing diffs
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
 Matthias Beyer <mail@beyermatthias.de>, Jacob Keller
 <jacob.keller@gmail.com>, pyokagan@gmail.com
References: <20260206090358.GA2761602@coredump.intra.peff.net>
 <cover.1770993281.git.phillip.wood@dunelm.org.uk>
 <494f4df6865f81eba42584ead81327c9a305d0d4.1770993281.git.phillip.wood@dunelm.org.uk>
 <xmqqfr74msm9.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqfr74msm9.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/02/2026 17:59, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> If the body of a commit message contains a diff that is not indented
>> then "git am" will treat that diff as part of the patch rather than
>> as part of the commit message. This allows it to apply email messages
>> that were created by adding a commit message in front of a regular diff
>> without adding the "---" separator used by "git format-patch". This
>> often surprises users [1-4] so add a check to the sample "commit-msg"
>> hook to reject messages that would confuse "git am". Even if a project
>> does not use an email based workflow it is not uncommon for people
>> to generate patches from it and apply them with "git am". Therefore
>> it is still worth discouraging the creation of commit messages that
>> would not be applied correctly.
>>
>> A further source of confusion when applying patches with "git am" is
>> the "---" separator that is added by "git format patch". If a commit
>> message body contains that line then it will be truncated by "git am".
>> As this is often used by patch authors to add some commentary that
>> they do not want to end up in the commit message when the patch is
>> applied, the hook does not complain about the presence of "---" lines
>> in the message.
> 
> "git format match" -> "git format-patch".

Thanks (I was confused for a minute because it says "format patch" above 
not "format match" but you're pointing out that it should be hypenated)

>> The trailing ".*" when matching commented lines
>> ensures that if the comment string ends with a "$" it is not treated
>> as an anchor.
> 
> I am not sure what this means.  Wouldn't these three
> 
> 	sed -e '/^#/d'
> 	sed -e '/^#.*/d'
> 	sed -e '/^#.*$/d'
> 
> work exactly the same way?

They do, but if the comment string is '$' then these two

	sed -e '/^$/d'
	sed -e '/^$.*/d'

have different meanings

Thanks

Phillip

