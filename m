Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF7B2F0C70
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 11:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765366338; cv=none; b=IB628gifImM9VzAOuDiW53QeTD+x5MWjxS+PEi3w2w7/Aws6Y4DoMFRX3R8j36uWnRwaRjfkyjhXG87NwCk4RtMOODDjlyuWPtdGQMcnrc8bBrYANTGIRWHnnLpFngLCtnwsPDHvCCzT3yCeOKJ7n2Sj3w802fjOE0imoZIIVBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765366338; c=relaxed/simple;
	bh=Q/NhKpS5DzymlzIc06C2sJ9O9nn+qus1GFkI2qP5Dco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WRFBlzhULYzYVuvsM26VBYYF5sxEW1FHW30G1slAHFmkLEItGuYRMcQLWWR6zeJR7vpkeINRwWJS9vJmfog2yWAgdElDU2HH1EZL7dyhOjdgXZ7BDPYLMbLg/TfvHb1+2iLtEGfRwqkUMt82rjJwD2wabT0Q0DsREbraLcRsCVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQDITers; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQDITers"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47790b080e4so39648005e9.3
        for <git@vger.kernel.org>; Wed, 10 Dec 2025 03:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765366335; x=1765971135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vI3qsImfjAaqJ+Kq6zYb/AX7lgNp5I9HBd7cMNgPL+E=;
        b=bQDITersRxouXCtRGlkIDYoXYVUIr9gMgYhb0mCB5DihhMOHS/Dqu1vIITMb07VRDQ
         1Bg/dAtKDqkh2uYIlAcnyLalCVGWiPS3aLSFTX3Ey1PxEUjLcaq7S0f1Gt0nUmKvlKH3
         uRRad/mkoiU+6FMtqvJntpThNCQVqaazCiaMJZKx4JGHW73NPjyPB7n+4F/dGryStW3M
         98FKqaNaTdsKZPs5eNWE1W+ElrRtmHK6Sv2J2Og91+wUUr5B2nHW151FvYWkdTevlXAK
         rMzZCRRvP/kpt6Nlj4LLxo55W++wyBMrd/NPlzVpPL0C1S/Pds6JYpdeVVmf1WoGFJAo
         pREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765366335; x=1765971135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vI3qsImfjAaqJ+Kq6zYb/AX7lgNp5I9HBd7cMNgPL+E=;
        b=Fdiz7Zvoo2ZRhNQVU1JNMmGDLpHwNLGV5wQwRowKnC/SoKJ2E32ap1VX1K4AWiR+Kq
         HvEeZi4cjMeeni2AR5AIzxD+kYQ8sSjfWJyFsmTTF9J3TloWney57T4xFIU8VYjPsvy2
         xFl6Rc/QkVJH69w8ykoPSt1sY8phIoWbwMb4gf6vg0PLDoToP5cUIZPcjFcz+GBjoh7i
         iMLOeTzSIl+YgQ/SvOXCvbSfM1QZOCvOhFiJZdpUPgem7Nf5yIcZKMz4PBXnsBp9+TgN
         4zEOh9Eyk5hK2zTMP0swYikeLvIW/yOem5G772lPt4k09cX0nGGJP8oz+BBM/6qfT+85
         GxYg==
X-Forwarded-Encrypted: i=1; AJvYcCWojtT5ShUHwJuPAzCajWtm7nGZ7AYSZ2mapRsOqzuqv4LsOA+TPWQRigmL/V9q24dw8dM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUSWNfuZ0GtRC/xzGYMn9hagOFcSJfeWhP3zAde0j65v+k4Q18
	oxlVV71XEvkjHUyKPE/d1a2tcj/YOKoSO8rS/nq8RWp7cLrGQlRJ2nyh
X-Gm-Gg: ASbGncuwBYSPHySzwf7TPm2+PYNelQGZQm95nOjnnVOKTLoXDlMJtz3/Xkjhx0gzI7v
	6C6dEgrTELNIQ+uJpf274HYCyUnApFs/MF3Q9Jo99h0TT9umI0FG6ynrdJba8UU3w6rOmOO0tes
	ebshtjjNlo0Z/PVj6dkopy+iNquC24SvXE9HvFReWa5at2DmzmheHViGjiwa7N8WH2Q25fQFGhh
	1irRHaHXpZLFjH9m8l+e+yenttWGi3hRmCR9XcGn2+8glvnlFPpUXSgRUn2LBkm1mYJWyyH5jXI
	Gs19TIeIYr12MQOHvGRgLRg4pxbBbEUrezS8v/I6JBKlJM/s19fLuAYEzuqUixG+cvktgvdPidu
	zFZOkqPp7gbxJt1DWUYE86g0e7HruPRj3EzSJqEH29h9jeWD3Il+aasg9QLN4i0dnrmH7fSSqyp
	Y6n4xaMr1Zk2fj8Fc8u5PK/Vi26qQehshc6S0T2K1FR4J/7ifojjHNQ6UZzoSLSv8=
X-Google-Smtp-Source: AGHT+IE+GChgiYHlfYGbyLB/cfmebJq/smhFThbE75z9WPptAm1RstlBzQkfaZ6IOmoHDU3JtAYFaQ==
X-Received: by 2002:a05:600c:3151:b0:47a:814c:eea1 with SMTP id 5b1f17b1804b1-47a838534b1mr20592165e9.35.1765366334812;
        Wed, 10 Dec 2025 03:32:14 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfeb38sm36936717f8f.12.2025.12.10.03.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 03:32:14 -0800 (PST)
Message-ID: <0ce5a2c6-cdeb-4897-9b64-39292d1b734f@gmail.com>
Date: Wed, 10 Dec 2025 11:32:09 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 00/11] Introduce git-history(1) command for easy
 history editing
To: Martin von Zweigbergk <martinvonz@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean-No=C3=ABl_AVILA?=
 <jn.avila@free.fr>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Karthik Nayak <karthik.188@gmail.com>
References: <CABPp-BGLrVv=maEqhs=j9MmST-F=K=XN6gGqmd9Hox5QRDMiHg@mail.gmail.com>
 <xmqqbjkw78jj.fsf@gitster.g>
 <CABPp-BG+2+vanKAS-cwAD2XZxwx=PPcu5OG58ys+8O7rfZEhug@mail.gmail.com>
 <xmqq7bvk77lr.fsf@gitster.g>
 <CABPp-BEyMFiRdHoseTaYG9rUFO6Ta=dBG88CGRb3CfNf8aSAkg@mail.gmail.com>
 <3fb47b15-ed43-4137-95f8-cee97ab5e44c@gmail.com> <xmqq7bvj5q8m.fsf@gitster.g>
 <CABPp-BEVX85xZ7_1fSfW4-xJod13p2-HvQ-e5ga+m9-Sq7mbdw@mail.gmail.com>
 <aS80z0DxAEBLba-M@pks.im>
 <CABPp-BFtx7-vLFbVqbHar=UZb1CGX5=ufMA4hrJRkSYuB14_Tw@mail.gmail.com>
 <aTfVfenbwY685fDZ@pks.im>
 <CANiSa6hxjghKQMhURx8qC2t=+1gEE7p8YaHbWkg3rYOYa=poVg@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CANiSa6hxjghKQMhURx8qC2t=+1gEE7p8YaHbWkg3rYOYa=poVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/12/2025 17:43, Martin von Zweigbergk wrote:
> On Mon, Dec 8, 2025 at 11:53 PM Patrick Steinhardt <ps@pks.im> wrote:
>> On Fri, Dec 05, 2025 at 12:49:04AM -0800, Elijah Newren wrote:
>>>
>>> (a) check that a commit is only part of one branch before proceeding,
>>> (b) always require the user to specify with a flag how to handle
>>> commits that happen to be part of multiple branches (even when a
>>> commit only happens to be part of one branch, in order to allow us to
>>> not bother checking whether it's part of more),
>>> or
>>> (c) rewrite all branches that contain the given commit by default
>>> (with an option to only rewrite the current one).
>>>
>>> That said, obviously the choice of whether the series is merged isn't
>>> up to me.  And maybe I'm in the minority, and others don't care about
>>> this issue at all.  But it's how I feel about it.
>>
>> I guess it's a matter of workflows and tastes, and there's never going
>> to be the one correct way of doing things. I don't think (b) is a good
>> option as it makes things more complex even for the simplest cases. But
>> I wouldn't be opposed to a combination of (a) and (b) if we can
>> implement (a) efficiently.
> 
> FWIW, I agree with Elijah that (c) is the right end state.

FWIW I think so too, but there does seem to be a significant number of 
people who find that behavior surprising so maybe we need a flag to 
control what gets rewritten.

Thanks

Phillip

> That's
> perhaps not surprising given that that's what jj has been doing for
> many years (as many of you know already, I'm one of the jj
> maintainers). I think it's very rare that we hear from users that they
> want to rewrite a commit and its descendants while leaving some of the
> descendants in place. We have a `jj duplicate` command they can use,
> but that won't move any bookmarks (branches) over. So if you have
> bookmark `foo` with descendant bookmarks `bar` and `baz` and you want
> to amend `foo` while moving `bar` over and keeping `baz` in place, the
> simplest way is probably to duplicate all the necessary commit
> (something like `jj duplicate -r main..bar`) and then manually move
> over `foo` and `bar`. That seems like such a rare use case that we
> haven't had a reason to make it simpler so far.
> 
> Regarding performance of (a), I would think that walking all
> branches/tags until you reach the to-be-modified commit (or reach an
> older generation) can usually be done quickly enough, but obviously
> there are many others on this list who know that better than me :) But
> I have also heard that some Git repos have tens (hundreds?) of
> thousands of branches. Hopefully those refs are just on some server
> where users won't run `git history`.
> 
>>
>> Do we already have logic like this in git-replay(1)?
>>
>> Patrick
> 

