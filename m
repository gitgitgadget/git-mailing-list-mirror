Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8111E572F
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326303; cv=none; b=IT4WPPxSiPVeISjAD/ywqrezHM7bvcHhN7sifHmW9de+eWtaTPXdsB1msKBOhl1DKIjzHmhTD+QjMmcKVDoLBYtUt1dWYFqaa7ZUi6sg48rJkjivql84oe67DbzbYa9Po1ykrvSSM401eAuSaVAy99y23Nj7JlPD+nq/GKUz110=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326303; c=relaxed/simple;
	bh=rtfvFGBst1iCIa8XEwNC62hSuEDeElrxWTKH1mo7aLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuwDizcO/kWiL/pyWYAT//3MMPtAjiVjkVF+VxuuoZire6JYX2tJDeBuQJHiaIqKZxIqLFym+CMIvoDIwDPKJ28ioJjIK0+7AnuASnN3wCty7Lmc+nLuJ/bilPfC7kF6119fBpi2EYLiHRMVX8FabFPUhVvg7i5Re0dK8icttgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpuFBrid; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpuFBrid"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45de6ab6ce7so4438285e9.1
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 03:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757326300; x=1757931100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VA8gSTSRVFzTmjKYeI7zoxbt9lBLchF1WAbAAXVHulc=;
        b=DpuFBridGRWYRKYRwhUhovXS6velXDQG5a9sUYdQ+JD/PbrvxIq9m7uzSD1Y4/FJMi
         gUdHrzdPtgAA262Mo5OOcjNl3nCdMqjzDO5+IOA0M7dKHW6i0f1cxKli7eLImlcJnOj/
         huYew6s68Ato3clp+6UG+BPe7wEchmu7jm+ROMol4vIjJPUEmi/1UGfIh1TycYTG5Kr4
         qZ7yPXdHMAxuYlqwEZAqdtUXi0Dxjez6OOCyefk6pFMT3BaImxC7WLQLtodnwbaVEk71
         RuwlWIf7kiAx/MqozmXCYovFFewgjNWmwP9d5xPj+PcO8PeUhtYNGiZgmx7W3omIhskO
         l0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757326300; x=1757931100;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VA8gSTSRVFzTmjKYeI7zoxbt9lBLchF1WAbAAXVHulc=;
        b=gsuoufKpyJmGasJDqcr8jV8Fw6b5qMFlRdEkqtVISn5qqOFnuC5jQWOlV2Sov1BTWA
         tr15HE0PtKtE5/vmExrL6bt6vaKrd+rl2RSpR5Z5o+mNp/00ryzXI0jzyd7IDc9XX94j
         qW9k2kMMp9CBymhS4kledolokn8LrO2YOtUwSi+888o4Lg+xpZ3kThTPTU6H+ft2uvSS
         /Fl6MUd2bXTvrMBx2qx+REsFCayQOPdmEAhoChYR3ybz2rHqUIeeNOmLPQo7jEBvh1Zu
         IyibsxaBB0sPrDOQKzytQvtMLShYcps7ToYZOcaqkrEjQCmfLQOJqgOox34+bxGDWW51
         DOAQ==
X-Forwarded-Encrypted: i=1; AJvYcCURBOhnpoQBmrzs8UtMwKPFHaE6eZhxsZ8teyZIkazhEMke+nyt5CT+Pn/DaC1GxjvOqo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3o/8KoELaBuUW4DSYDAG9/tk8uuIlpD+YJbsA8AmLNYxnj31P
	LEQUMS4b0x+V9qupRrK0h0WQE9jNyFS/WnAt3HHqoY3oYV3BCSgUS0c4
X-Gm-Gg: ASbGnct4siqTLf1J7AwlIvKJ1QUkBuQ13QzqfwSOmjBN6KlHiBK3tZ90OGgDqNkX4GK
	thabV5Ruj7QxIwHIVqSkMgprcFU/r1t1qS18cmEE5/pG2+WfNdQrd4+dr1fETa8q8baG8LVHA03
	mMQqS6nSS4kh69ziOeX/JPk48QPqArmKUVvYsyDmrkRWQ+sLwk1tm80wTVMPhvkpuuyKfpYFjO6
	LQbAIfZyFDF7+kQQvDaGOnj2d223fxuSi0s+0SHgT4RNszj6MXIcPbwKOn6p7DKcfTClE0KLLEA
	MN/9IdFpD0Y19k+txV08Y8yHHAvGvk19HT8G2wIT4PPULKMIheM3JYaexNzG8/PRCxJjy5wCYsz
	NWuDNDh3XLsTn/pX6rO8f3cL+JHtijtD7ISLimyR0b5XgIQ84YVBMlNZ2jDAqpVWXFffstcMVxc
	EskfOvdv2b5Q==
X-Google-Smtp-Source: AGHT+IGiM8UC90WTIdnGO7GPXJLmB8XYdpQeL/MzQEA9nYj20kOJiRYaIUtEcsJYMaigI+M+sXWBCw==
X-Received: by 2002:a05:600c:a49:b0:45d:d5fb:185b with SMTP id 5b1f17b1804b1-45dddec84edmr55540945e9.20.1757326299634;
        Mon, 08 Sep 2025 03:11:39 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1751:3d01:9485:10d6:281e:e659? ([2a0a:ef40:1751:3d01:9485:10d6:281e:e659])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45ddfe09835sm42190735e9.3.2025.09.08.03.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 03:11:39 -0700 (PDT)
Message-ID: <ad54bb8f-04e4-4bf7-a13f-6ae7b967b718@gmail.com>
Date: Mon, 8 Sep 2025 11:12:20 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
To: rsbecker@nexbridge.com, 'Elijah Newren' <newren@gmail.com>,
 'Patrick Steinhardt' <ps@pks.im>
Cc: "'brian m. carlson'" <sandals@crustytoothpaste.net>,
 'Junio C Hamano' <gitster@pobox.com>, 'Taylor Blau' <me@ttaylorr.com>,
 'Kristoffer Haugsbakk' <kristofferhaugsbakk@fastmail.com>,
 'Josh Soref' <gitgitgadget@gmail.com>, git@vger.kernel.org,
 'Christian Brabandt' <cb@256bit.org>, 'Eli Schwartz' <eschwartz@gentoo.org>,
 "'Haelwenn (lanodan) Monnier'" <contact@hacktivis.me>,
 'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
 =?UTF-8?Q?=27Matthias_A=C3=9Fhauer=27?= <mha1993@live.de>,
 'Sam James' <sam@gentoo.org>, 'Collin Funk' <collin.funk1@gmail.com>,
 'Mike Hommey' <mh@glandium.org>,
 'Pierre-Emmanuel Patry' <pierre-emmanuel.patry@embecosm.com>,
 "'D. Ben Knoble'" <ben.knoble@gmail.com>,
 'Ramsay Jones' <ramsay@ramsayjones.plus.com>,
 'Ezekiel Newren' <ezekielnewren@gmail.com>,
 'Josh Steadmon' <steadmon@google.com>, 'Calvin Wan' <calvinwan@google.com>
References: <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
 <xmqqsehc1ypi.fsf@gitster.g> <aK9mx2XemppIaKVI@nand.local>
 <xmqqh5xszf91.fsf@gitster.g> <aLbSA5KsBdD4wW_B@pks.im>
 <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net> <aLfU5sEa-RE3X4G2@pks.im>
 <aLjj9cG9_K6YLfeA@fruit.crustytoothpaste.net> <aLl6iFXeAvL_hvqR@pks.im>
 <CABPp-BFNoLC+TdtuEq5Nx+VcFJ-WFga2r0E+eq=fFaaCN_sRGg@mail.gmail.com>
 <aLqIHCdlbwF5X6Cm@pks.im>
 <CABPp-BG3Zcw63vNziy86MvYNubefn1SmPvXefpqpA=a+42KT8A@mail.gmail.com>
 <042f01dc2011$da9dcda0$8fd968e0$@nexbridge.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <042f01dc2011$da9dcda0$8fd968e0$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Randall

On 07/09/2025 17:09, rsbecker@nexbridge.com wrote:
> On September 7, 2025 12:10 AM, Elijah Newren wrote:
>> Sorry for the delay; life outside of work is challenging at the moment...
>>
> 
> I am going to address the critical point mentioned below and snip the rest for brevity.
> 
>> I still don't see why distributors _must_ ship the latest version of Git and why folks
>> on some platforms are considered broken if they are using a slightly older version.
>> Let me ask again: has anyone answered why this is considered mandatory?  If they
>> have, I've missed it, but I've asked multiple times.  Even if you want to lump
>> "distributors cannot build a newer version" under the umbrella of "breaking
>> changes", I argue it's a much different kind of break and one which merits different
>> timelines for handling than e.g. lumping it in with 3.0.
> 
> I do not see that distributors _must_ ship the latest version. Suppose we are on
> 2.51.0 and a CVE comes out that prohibits its use in an organization that does
> not allow any medium-high to high CVEs. This represents hundreds of thousands
> of impacted users in my community alone. How does the CVE get applied if the
> latest cannot be built and the git team does not apply the CVE fixes to old
> versions. Personally, I do not care if git versions are different between work
> and home, or even between CI/CD and other platforms. I don't even care
> if I have to use JGit instead of git in some situations (which I see is a likely
> outcome of this discussion). Is there an official statement of what an LTS
> means?

We're currently discussing what promises we can make about supporting a 
non-rust version of git.

> In other projects LTS is typically, and formally by policy 5 years.

I know commercial linux distributions offer that kind of support but are 
there really open source projects that guarantee 5 years of security 
updates without any kind of support contract?

>  From what others have said here, positions of 6 months, 3 years, and
> "apply it yourself if you want to continue to use git" have been made.

Yes it is still being discussed, and no one is volunteering to offer 
five years of support.

> The core problem of adding a breaking dependency is when a CVE comes
> out that prohibits git from being used at all. If the git team is not going
> to provide a clear statement, one way or another, if how CVEs (at
> whatever severity level) will not have a commitment of any kind,
> then distributors are essentially cast adrift and on our own. It would
> be helpful of those of us who donate our time, for no compensation,
> are able to plan for this in a meaningful way.

Doesn't your company make a front end to git? Are you saying that the 
management does not allocate any staff time to work on git itself and 
expects the community to provide it with free security updates?

> Please remember that
> we have to justify our participation to our management teams to be
> allowed to continue to participate. 
I'm confused by this, as the sentence before say's you're donating your 
time for no compensation.

> Nothing is free from this end
> and if fixing (not just applying fixes) CVEs are now 100% our
> responsibility, if would be critical to know that when we build our
> business cases to our bosses, who I am fairly certain will say an
> emphatic no.

In the long term, unless your platform gains a rust compiler I'm afraid 
I think that is most likely outcome.

> Also remember that without support from the git team, the
> code base is no longer the same, meaning the auditors will not
> necessarily accept fixes from third-party sources.

I think I saw a suggestion/question about the possibility of hosting any 
long term support branch that is maintained by interested parties within 
the main repository. Would that help?

I appreciate that any move to rust would be very disappointing and 
disruptive to you but the community has to weigh up the benefits rust 
has to offer against that.

Phillip

> This particular
> point enabled adoption on some platforms, particularly NonStop.
> Adoption was at 1-2 customers when we had a divergent code
> based because some platform fixes being different from the
> standard code-base and could not be certified as valid. Once the
> code-base because common, adoption was rapid and enthusiastic.
> If this goes away, I suspect that adoption rates will go negative.
> I am aware that that particular discussion is actually happening
> in some organizations in my community right now, with companies
> looking for alternatives to git based on this discussion thread.
> 
> With over a decade of respect and participation,
> Randall
> 

