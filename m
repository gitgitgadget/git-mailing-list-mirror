Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FC51DF996
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732289232; cv=none; b=sXyL2Q1LDQsAp3KMNU0PZgbnkepYATLPsTNtiR95F0sGYkSoCL52+YcjT6p2HQc4JN3W3MXaNwJKEZQ2A34nUkprv5tkoNlClaXTxp+kwH6JxcLiZRpOF/YLGPUORC1ZUj8HcDzTPY+EPEYV5FqWQ23AUZ3xutBifMdNpkjsU2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732289232; c=relaxed/simple;
	bh=t48HD3UNmhWj2XF4QPLCGyYxZ8d2S5Cd3jMFQOtC+A0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2r3X3SPUPcYV83R+wREATGycJH+4WVnx9RnUA21n2F7Kz7HmxqAUtUbIMXOQpyyY8RZMnn9Isu5/CxhUdvMKC4hYQq0u0eZkQDx64MJc50OnZ2KS7GY6lYOeVHERFotDG/39zaZizvIKDWLQB4wO/k3HFTkSnFZFaVaoyWnSZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RViNxOpP; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RViNxOpP"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e3884cd186aso2404728276.1
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 07:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732289230; x=1732894030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cqbI22+2Sw6WWofdOxHMRB4dU4nqxJgmlhoxVaxpBAQ=;
        b=RViNxOpPQRwfvfAYPxf/Uer/VUnpgMfXVHEdobWWY4piRsGTag4YC+YkIcLOqjCBSY
         ELZvfZqdRIHlzwy0xd6dbRXs7dmLRUSeMgBCpUatPKCB6U9o4H0mZWSkOi59Ie2w2Q+A
         AC64i1ZCKwjyed84+Aav9a+49E7rF2lJFJ9HIY0z8tzvaJLEuP3MQA2T/vaJxSI6Nvu8
         C54ri5Fks1+6qjhRgenMzlF78/k/GiCr3zweupHqRpEDzuKBrlK1OTazj7NO8mCRcNfz
         uCJZJTf3Z+T7LcTXO08Xcz3xxOZOXC6PyMJlL6ia1j/Mhm2Ga8QL3nAZvmy61EReZGkm
         DYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732289230; x=1732894030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cqbI22+2Sw6WWofdOxHMRB4dU4nqxJgmlhoxVaxpBAQ=;
        b=YbrOe3DAfMQ/9vScwnXSTzHVPFoVsue/20ywF8l0QvtCTLr5LV1nJguqS3/weWcExa
         NAcLbYXyqSMzkZVQL3POXkXRqd5b8fme+uFJxJwsEJT9PaWv+HYvP3HpGxSeWhKWnTqz
         2XJK8+5FTnmk28VSS1OrWIzRNCCKW8/K2NwVoIGE3L9sQIYrXXWp7F14952ojPYqPQDG
         N9jwCiJC3tmTpZoXWXoq+/icmLLOlysMQtKkVYJFXrKwQUCzR6740Ig4SON9DvApe8QZ
         o9yBIU+8toFBRQwJnCYyXxVnOiiPlMZacp+d26JauiFNswFjPr5QiMUfx9BxdvM0Xh6Q
         9Uzw==
X-Gm-Message-State: AOJu0Yy91hwxIAmmZVuKrKThnIqHPQdCRaSHjf9sB0el1abAfoe38guu
	tcltGwWZlmXN7R1ADewkaUYAdYEkKb5V9OVc5s8l8ZP9haO1GrcQ
X-Gm-Gg: ASbGnctMRXZGUxl110f7ZrkhViMYejCHVSRYi1kZbHz/5iel+V4VNHfXXoHn1/7Uien
	4a4JwdJaH+yHUmfc7uONJDBlg8kJgG6zoM815QZvpZ4MS36DQKdslPF9lSL8AnZ0+LDC20XQ9d5
	Q8PorbFjgnlR20jd53XV0XVz8iAi5gEuliAonpcS8lf8kl/O+5u2Vv31xUTwpFTRVfNaTiOPjUK
	DSpCqIf655tg4OJq3M+D1Cg03ClvVHCbrep3eNc5i7iov20jwNnFkfzaJfttPaGU7vlXYbN35qI
	FgJIwFLTxRZysL7e/I6FT3bth6ASEOrkLd3shg==
X-Google-Smtp-Source: AGHT+IEbzI/ulLkns2DW5KA8N/wgrbWN3NUm+0TypzCxWteC197IXF5hSTHYAjnECUgq7L+/pDwAng==
X-Received: by 2002:a05:6902:124e:b0:e29:948:69cc with SMTP id 3f1490d57ef6-e38f8b0aceemr3045174276.6.1732289229747;
        Fri, 22 Nov 2024 07:27:09 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:313f:79e7:4a86:b985? ([2600:1700:60ba:9810:313f:79e7:4a86:b985])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38f601cd57sm630127276.5.2024.11.22.07.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 07:27:09 -0800 (PST)
Message-ID: <0314efa2-606f-4a89-b93e-f7a6684d05c7@gmail.com>
Date: Fri, 22 Nov 2024 10:27:08 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] pack-objects: disable --full-name-hash when shallow
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
 <b8a055cb196dd971ac21611c1957be319557b4d3.1730775908.git.gitgitgadget@gmail.com>
 <Zz+ZI7IcfhV3Rw79@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <Zz+ZI7IcfhV3Rw79@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/24 3:33 PM, Taylor Blau wrote:
> On Tue, Nov 05, 2024 at 03:05:06AM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> As demonstrated in the previous change, the --full-name-hash option of
>> 'git pack-objects' is less effective in a trunctated history. Thus, even
>> when the option is selected via a command-line option or config, disable
>> this option when the '--shallow' option is specified. This will help
>> performance in servers that choose to enable the --full-name-hash option
>> by default for a repository while not regressing their ability to serve
>> shallow clones.
>>
>> This will not present a compatibility issue in the future when the full
>> name hash values are stored in the reachability bitmaps, since shallow
>> clones disable bitmaps.
>>
>> Signed-off-by: Derrick Stolee <stolee@gmail.com>
>> ---
>>   builtin/pack-objects.c       | 6 ++++++
>>   t/perf/p5313-pack-objects.sh | 1 +
>>   2 files changed, 7 insertions(+)
> 
> I appreciate demonstrating the value of declaring --shallow and
> --full-name-hash incompatible by showing the performance numbers in the
> previous patch.
> 
> But TBH I think that it would be equally fine or slightly better to say
> up front "when combined with --shallow, this option produces larger
> packs during testing, so the two are incompatible for now". You could
> include some performance numbers there to illustrate that difference in
> the commit log too if you wanted.
> 
> But I don't think it's worth introducing the pair as compatible only to
> mark them incompatible later on in the same series.
I disagree and here's why: they are not functionally incompatible. This
performance-focused change is worth justifying with performance test data
_and_ isolating from the initial implementation with its own reasoning
for future history spelunkers. Having these warning lines blame to this
patch instead of the initial implementation will make it much easier to
understand the justification of this change.

But maybe this patch can be removed if we use Jonathan's function. I'll
check the performance tests to see if this continues to be justified.

Thanks,
-Stolee

