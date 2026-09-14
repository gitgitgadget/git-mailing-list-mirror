Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F122D7380
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 06:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367941; cv=none; b=LIRLjoEwTkDzaZtNqMDOQJNyYNaKlSIOrVZMIASWS/z0Bne9t6d3ekqYEZxZmdZotd1FQo/Ul+6iiGQzBPUwqP9Urw1JRT0PSCdlg3BDkHd0Wnh0nBVvQ9qfoqWAnOqZ8Nz3vjg6V98cWn8O/+ODVp6IwYAlLhhRhh11eXOVyV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367941; c=relaxed/simple;
	bh=3NrfYZ4v1Ty9PdQEABh9qPOFORs55O/ljXDCCtOLzV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NTPHqm7+lfKDNnYoPeFIlBx7zNCy0dvSpn3dMFL8OvjfIjHs/5jIcLQXoy95GeU5Y8HlYQMzktHwVX/RYqKcX0w3RRpJFkyeQdXRKXC/LQOR01SQZF1ulfztv/dvC5WxpbKtWRdaH2m0HE5d6P1md2h/Si+H8gBrgQ2zjYLvMYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gkes31bs; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gkes31bs"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fb334e72so16664365ad.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2026 23:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789367939; x=1789972739; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3BTyKUv83XPCfJ5ML93dgfSjPgOMf/X2gW2NV+Hl+nI=;
        b=Gkes31bsCXYDhUU+371vd24Y3P54KmszuASiMnIzT87RlHyaXiICmHXm+QBBOZS/SM
         p9t1MHC1ALja/vqJ/9fdfOdh4eqdb/V8YGRUqW22vAPdWwVoE0KslnWoFA2jBvmIDoV6
         Qb2WY7gxsn94BdIP9h5IpDsmX9G/i8+426pqEJw1/qu+UZ5Taqe40Ta4Evi8U0V5Mc1J
         HV+PebZ+KdEn6Y4oZKeoO8GeTRe9RjENvU0hQ4V/EokdVbhMIrhzkZndP4Ul4aJUVvBK
         RSGHGxRHz8kk4Cn8jsC+X7bulDf4UD5AT3SVEOKm91iTqTshisvr4zsgFInB387y84Hb
         jVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789367939; x=1789972739;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3BTyKUv83XPCfJ5ML93dgfSjPgOMf/X2gW2NV+Hl+nI=;
        b=bLsX4w4rOLrIvkcHXD1fHywOQo5UfN8p5A50V2cS2N0+Ot4d01BDshLrArX/UpzOWu
         wLI55Ey6fUWwzKG6/qGsPzVJ4qoq28Cwpi3E9fQTqC7aKKd/rcaEHyV6EwcI8ZpcHJg1
         D2gY2iftkRjPKg9xZjcYFLBAE4JQwIrgy38gVElfUHtlfG+weAORxVbWv1wnTS9yV0PX
         ljiI5qF0p2Zxe5CMWV1ta+LuUkgFc2/P57dm3bFE0vc5jVeLTIY4kMG57gQz7UkC+O/7
         z7z7o9cRZbaorNkL9lOXwMVOuRuf7Q3xdIHlfc1NW/HEzvxjLZc2LKhqT4bh9Uql+ZHV
         /vTQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4+WdLg6fBRpv0hVwAz74k+l3svK84MJ8IADKAuAS3F/epQ0QkCwT8I98F40Qnr3sbzN8=@vger.kernel.org
X-Gm-Message-State: AFuF++k5h9RiZTxX2Cuo5jJKftYga3LkDWMu057cD7c9IWIw9BuiUCmG
	XISz54PuasrD8o5YE7pdQnVdHDk9ANkHCNGcFradXAZe6S738CYfoVmL
X-Gm-Gg: AYBFou1/MifsIZbWjxq1/fbOqbiwPHBdJSekIlctvtwue74A2iyhkp0YuLoy7lnimLa
	ZQYeApuXcJsQbLskjp4530rwc0xHke+FZD8+IcbuIB7BkHh9m5KY6nitzjSLNeSu8o7JGHuqSFN
	oP0WYEzmvk0iLpVAJM8xBgr0ePFDORn1kMbQLyua9zJRReRlyDhi0Yiy4KpvQ8ahHixq/pQup7e
	4pAiIb5Ui25tUzlU2QDjpgiQcFo8jQcp/g7u5/sLT/a8aXXL8iVduqmsmTbB7ETcSDAmRvZcU2x
	PRbl3hn8a9G3xo7Bd1CxugExJ9dJn4NGQAYZ1cEHWsf+Kxt+qLCUka+x+Cwwp++qXP/LhTpST5D
	5ibGhrsY2dUfAHe1mowd5dVY5DZQNS0ajJ+tarSgj7oJ5BdfoigEnK3805VO3nW8GJll02v2sqr
	ETOsS1ugMcaRCaJFcw8njdk7RWPjXCuayfg2xN49Ge6Ej0802j0AbIVb8JkS78ece+TsCgxH/dR
	WoDBs4DdtthFZ4ycOp1DZ1J5eI7CSrRxok6f57Xk7SMqgtZdwZ36i/CjZ7JviTYknrgh/KfMBMF
	aJXerUh6Ig2rdAKF2gwJM7+x7R5JmHiHYOgUPkiBaAjI9T8jJ+MZeRTH+KnxYq4DRXKPeNuZXhO
	ZJqXz5Esjq4AzMwz8jfHsbnW31JY=
X-Received: by 2002:a17:90b:2f8b:b0:39d:f259:3351 with SMTP id 98e67ed59e1d1-39df25936a9mr450376a91.0.1789367939475;
        Sun, 13 Sep 2026 23:38:59 -0700 (PDT)
Received: from ?IPV6:2409:40e3:40e3:cdf9:c527:9f06:6e83:e614? ([2409:40e3:40e3:cdf9:c527:9f06:6e83:e614])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d951d6b08sm19582679a91.8.2026.09.13.23.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2026 23:38:59 -0700 (PDT)
Message-ID: <080f0485-3cf7-481a-8c39-c69afc81fbd8@gmail.com>
Date: Mon, 14 Sep 2026 12:08:54 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Participating in Outreachy's December 2026 cohort
To: Christian Couder <christian.couder@gmail.com>, git <git@vger.kernel.org>
Cc: Git at SFC <git@sfconservancy.org>,
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
 Pablo <pabloosabaterr@gmail.com>, Usman Akinyemi
 <usmanakinyemi202@gmail.com>, Tian Yuchen <cat@malon.dev>
References: <CAP8UFD367UD=AomNVHEBnhY-2DQmqTNRcBX6NW7YZywWgOmxTQ@mail.gmail.com>
 <CAP8UFD0oYnoXgQ84wHbGg3+QhX78Ucn_CXXYOe8uFpReb7X1Ng@mail.gmail.com>
 <CAP8UFD1hAjtPuWL8asZ2LzEMJKHGh2oO73n_tsUSADtEHh9b-g@mail.gmail.com>
Content-Language: en-GB
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <CAP8UFD1hAjtPuWL8asZ2LzEMJKHGh2oO73n_tsUSADtEHh9b-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 09/09/26 14:42, Christian Couder wrote:
> On Sat, Sep 5, 2026 at 10:26 AM Christian Couder
> <christian.couder@gmail.com> wrote:
> 
>> Thank you Usman, Kaartic and Pablo for volunteering to co-mentor!
>>
>> As no one objected to Git participating in Outreachy, I will submit a
>> Community Application for Git very soon.
> 
> I have submitted a Community Application for Git, see:
> 
> https://www.outreachy.org/communities/cfp/git/
> 
> It says that we are willing to mentor and sponsor 2 interns. Hopefully
> we can have two (co-)mentors for each intern.
> 
>> We will still have to sign up as mentors and find and submit projects
>> for interns to work on soon. We have until September 11, 2026, at 4 pm
>> UTC, which is less than one week from now.
>>
>> I have been thinking about the following projects:
>>
>> 1. Continue removing global state (and perhaps start libifying some
>> parts of the code base).
>>
>> I think Tian Yuchen said there is not much work left related to
>> "environment.{c,h}". So maybe we need to adjust the project compared
>> to its previous description or maybe make it about actually libifying
>> some parts of the code base.
>>
>> 2. Improve how command arguments and options are scanned and parsed.
>>
>> There are still a number of places in the code base where command
>> arguments are scanned or parsed using ad hoc hand-rolled code instead
>> of an existing API like the parse-options API or the early-scan API I
>> recently proposed in
>> https://lore.kernel.org/git/20260902161047.476753-1-christian.couder@gmail.com/.
>> Those pieces of ad hoc parsing or scanning code are often buggy and
>> difficult to maintain. I think porting them to an API while improving
>> that API if necessary can be an interesting project and bring a lot of
>> long term benefits to the project. As the parse-options API is already
>> quite feature-full, there are likely some areas where porting the
>> parsing code to it should be relatively easy which is newcomer
>> friendly.
>>
>> Let me know your opinion about these and if you have other project ideas.
> 
> As no other project ideas were suggested, I submitted the project
> ideas I mentioned above. You can see them in the "Approved Projects
> for Git" section of the above mentioned page
> (https://www.outreachy.org/communities/cfp/git/) as:
> 
> - Improve how command arguments and options are scanned and parsed
> (https://www.outreachy.org/outreachy-dec-2026-internship-cohort/communities/git/#improve-how-command-arguments-and-options-are-scan)
> - Reduce Git’s global state to enable Git's libification
> (https://www.outreachy.org/outreachy-dec-2026-internship-cohort/communities/git/#reduce-gits-global-state-to-enable-gits-libificati)
> 
> The links to these projects are currently only available to approved
> mentors and coordinators. I applied to mentor both of these projects
> as this was required to submit the projects, but I am very much
> willing to remove myself from mentoring one of these projects.
> 
> So please apply to (co-)mentor one of these projects, or submit other
> projects you are willing to mentor if you prefer.


Applied as co-mentor on the parse-options / early-scan one.

Thanks,
Siddharth


> 
> Also let me know if you see things that could be improved in these
> projects or the Community Application for Git.
> 
>>> Last year the Git community mentored a single intern. For a long time
>>> GitHub or GitLab used to sponsor Outreachy interns working on Git, but
>>> last year both declined to do it, so the intern was sponsored by the
>>> Git project itself.
>>
>> I will start poking people at GitLab about this, but it would be nice
>> if we could get some kind of help with this regarding other companies
>> too.
> 
> I have mentioned GitLab, GitHub and OpenAI as organizations that could
> potentially sponsor Outreachy interns. I have also proposed an
> "Outreachy sponsoring" topic to be discussed at the Git Contributor's
> Summit 2026 next week.
> 
> Thanks.

