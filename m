Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18D719CD0B
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580850; cv=none; b=K4/qXDdmdgvvRF7n3x1H6q8EHSSb6RpDxmaW2q9maaCMzjobi6OQ2xYaDHx15VUUKgiuJeVAwYIk0g+k2Jc+Xr1GDyXohzOR61LdiiTfU43qBd4i6WONwDMbQjjsW0cMHLyWOwDcC5neIuXX+azKei1LJhOdTvB55QFCRrbQoGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580850; c=relaxed/simple;
	bh=nGVfF6gC9v+bWbZnTt6cqGNz9jg/uleUK4sKvHcuYZM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EVzskwA7h7CPae/8u3mN6jDW7x9AwgnPpieHoyGy23i2twf6/E9kBBk8/OE1ksFriO89YJn4ryoTzYv4d4eipZn2u8kjDJGthlbV80jQGTS2+E7yHd5aU0ph1mpv+dp762KrE2kRskPB4mNXTrYq/Zqeb0pu1yUBCNUo5kMizIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TY4WP09U; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TY4WP09U"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so47487985e9.3
        for <git@vger.kernel.org>; Wed, 26 Feb 2025 06:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740580847; x=1741185647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wZWDe2i8XgvCiWaozA/5h3okrNdWZMRLsnaLvqWwGbk=;
        b=TY4WP09U4Dzs5OHANBJuSwOn7ck5Bm+EgWAJouaYhxKY83gg8Q4DZFwCfbl3E7D4av
         AmJ1WyTFN16ggY1j3B/bpi6w+fE3E2az8gPP8/75+vbZDQGkJ1JdRzfY7CxlN0isWMwh
         VgRauZdtUc8pSeb072Ttyuw+Vz6Fynf9+WoRZvY/2Ur/nc2Ry++5d/Vh/F00EDN5RO5d
         +JE2ZJO3Hl6n+e/hZ43Mr+581TWIXfY6ofNk2Ze/SX3cjgHNIwT1UbTKgdD9ZzGYooQA
         bWOTdV7jiRGm4tBDNJRNPnWwpSC6E4XeP3dnRuvikwShdxBVZD/boG8odhV3ycxO6OwJ
         +pHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740580847; x=1741185647;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZWDe2i8XgvCiWaozA/5h3okrNdWZMRLsnaLvqWwGbk=;
        b=xG/YLQYKxGT1shJjH/vwdkBOMqy+QL9ge3+4/4lQXYON2Kf8UJff/PWgY6F21d5PMT
         sFW3uyO6hlUkKLslW9tKhZK/svJJSD4NWvjaMvp5p6/sYsIvyfuZewhjW81gmM6ZpTpe
         HAb9mqqeTW/YLkD3ayWXifaNqFwG7xtm8Gasl6xL+Q7DnG5SYgITjt9eiowEFVVjNKqV
         TisBqngJ+PEMlZJVJMvBW2g9Hxs3PYXfSwYqSQSQ58klh03WdGgf0VbYljH8JbkPUmVK
         qofgK1VdGLWQrcog0TdA1Wd9m6ZhW1eTx5X+r6ewRLumeKWF/MKX7rkcNvS2cwIl4A3T
         253A==
X-Gm-Message-State: AOJu0YzISDTMOm8R18mpOmJGgrn2iAKecsTxwzNyDS7lut8y6xoFGXAK
	drLoJpR3AiFUeiREs1IsNdupbkiCAdsYu/ql6jl2BfdICZyLu+M0
X-Gm-Gg: ASbGncsREPCB0Xchsu7WqUoMLn9iQV9kIBSbuxDo7QHTyMiyuHopQWGhLG4Xo0IVE1v
	amMfFAX55PiBzzIog2Nkw0AxOWOBdhK79LDKkTGvfFjWKCYvAF83mA/0IhM50642VfzBTQUV9W3
	ZvPYZHlXv6oBD+hgJ8NwYFjR3XCwqhk36YtymH9qZNTy33fa/FtDNZnz5iBom3MuoGohe84cjcH
	a5shfSzlp5iBttTwt4wJ8oAqbJBFrYKVGysAQSppCY8ZC4dP3OIMoxjOrq7FcA7zf6A7yHnH7N4
	Ett3eqsWMqGUPs8jZkqBbzHQtWGS5sKwtKMrRI9Ukufljse1xmqy62ETkN9PSpqDBhGUVwwq682
	E8X8i
X-Google-Smtp-Source: AGHT+IHNxYnUoxJB0QR+/bEXPJpXh9Od7saD7N7aL50Gfs4Gzb4R5dYEzQvCHkXAjDgDSarYerGhLg==
X-Received: by 2002:a5d:694d:0:b0:38f:5014:22d with SMTP id ffacd0b85a97d-38f6e97a02cmr12049067f8f.30.1740580846667;
        Wed, 26 Feb 2025 06:40:46 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710f6sm25064955e9.29.2025.02.26.06.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 06:40:45 -0800 (PST)
Message-ID: <618d4a61-7480-46b7-8563-221264290ed1@gmail.com>
Date: Wed, 26 Feb 2025 14:40:43 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] add -p: mark split hunks as undecided
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1863.git.1740149837.gitgitgadget@gmail.com>
 <43a0592a462cf68bcfdc54373da2319431c3c1ca.1740149837.git.gitgitgadget@gmail.com>
 <xmqq34g79e8k.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq34g79e8k.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio and Justin

[I'm replying to both of you via Junio's email as you both raised the 
same question]

On 21/02/2025 21:31, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> When a hunk is split each of the new hunks inherits whether it is
>> selected or not from the original hunk. This means that if a selected
>> hunk is split all of the new hunks are selected and the user is not asked
>> whether or not they want to select the new hunks. This is unfortunate as
>> the user is presumably splitting the original hunk because they only
>> want to select some sub-set of it. Fix this by marking all the new hunks
>> as "undecided" so that we prompt the user to decide whether to select
>> them or not.
> 
> Good.  I am very sure that the design of the current behaviour goes
> back to the very original version of "add -p" with hunk splitting I
> invented; I simply never considered a workflow where people may
> first select and say "oops, let me take it back and redo it".  What
> I am getting at is that I do not think the current behaviour is
> something I designed it to be with too much thought, and debeting if
> it makes sense or it would be better to force them to be undecided
> is probably a good thing to do now.
> 
> Having said that, I have one small concern about forcing them to be
> undecided.  This now allows it to
> 
>   1. Add the whole hunk
>   2. Go back (with K) to that already chosen hunk
>   3. Split
> 
> and makes the resulting minihunks more obvious, as you do not have
> to use the uppercase J/K to visit them.
> 
> But if one is very used to do this intentionally (as opposed to
> "oops, let me take it back"), this would be a usability regression.
> "Ah, here is a big hunk with 10 changes, most of which I like, but
> one of the lines I do not want to include" in which case I may do
> the "Add the hunk to grab 10 changes, visit that decided-to-be-used
> hunk, split, and then visit the one minihunk that I want to eject
> and say 'n'".  This makes the workflow simpler and more stupid by
> requiring the 9 minihunks to be chosen individually after splitting.

If the user wants to deselect the 10th mini-hunk then they have to wade 
through them all with or without this patch. If they want to deselect an 
earlier one then they will now have to do more work.

Currently after a selected hunk is split we always prompt the user to 
make a decision on the first mini-hunk even though it is marked as 
selected when it is split. This seems inconsistent and confused me when 
I first tried splitting a selected hunk which is why I wrote this patch. 
I can see that in some circumstances this patch does make more work for 
the user, but I do think it makes it easier to understand what happens 
when hunk is split.

Best Wishes

Phillip

> So, I dunno.

