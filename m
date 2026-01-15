Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F44536215F
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768473107; cv=none; b=GHySugeLxe13RCmrAO7enf7edesAa5m2AqGH7kvof9K3HUVjzRy/lFZA8kLYuNk1A8tYFZb9h0PIs5wTGXm0nA0SZcVbMSP8Rud1O7PmifEnoOlZjmZ+1VHW77O4WmpxJ5UuaTeBy64HIG//KtvpHwahgMxfwC5xYn+gE7JTbwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768473107; c=relaxed/simple;
	bh=pRtUFjIxvuoj800cL1iUX7j9lFBn1pZvU02OCfuiOGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKgD/D6E6nuD4zCTmCq4ib+muwBX/LyG5mBpkS1vovx0J/w3SCU4ZQKWSDpD80oMJtfYgw3MAFMZx4iKF6uDU9t0KXPGCuWG3k+ijBh5Ck9gm532QFbrzFJo4voy/7mozRnPvdY54jjbfWkh9UVybcbrMSSJx4yWISMBaFfr7sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZKs50gr; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZKs50gr"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-47ee974e230so6520935e9.2
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 02:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768473103; x=1769077903; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i/zl9ymhj04MhDWpOlJeaHoiBViBwAk5hvOjY8XP5vY=;
        b=IZKs50grqv/TBt24QlwxoOnCDhK7xsOr/QW13B8vGIT8Kf3juA3zx0KqeHQkMPJUzj
         5IUs/GaxwAObDtNA7TzKl2OM4Wjzlh5+hX7pqOs064L1IPpLzkufP8MRllu1CQv80MV5
         HBcPQkMwDEoY4aHIbrlecFcNkB4UEzFb38eEseTeZwAVPuLZoPWHOfYvMYOXfYVXpSdw
         lOAadmzEcx8qyt8jt0rRk+cCO+KjRGdxHdhVr2U43UOAOMYDnJyIVcapS9hIw5bAHyh1
         8DfvE1yzUdzcaeXUtMkzwUO+qYGjCDGF4YBJigAbkjq76JRLYY9gPR20IobIsuUwXp/f
         Ilig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768473103; x=1769077903;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/zl9ymhj04MhDWpOlJeaHoiBViBwAk5hvOjY8XP5vY=;
        b=J8G5U+Sv58wtGXwtpcNkm9fKBhvwUgTdlk5hT+Rii0P8e06Jfbb3AuNUWMDDSZ7q1I
         5RVogwS0F9vko15yQQw4GWznUoW9Mv5RDzbgfoZsgpZ4zKJcwX7aauexQ3iTMVaWHkg9
         LFmDWyN9soGZhoIOhRbBRvw4BaCz6tDvjwy015yUcEumur1DRXSKYIV8gZ/uJBMzKM0t
         1veAg/Eh4UgQfCsxHcs/KIreDcbIx9iyb87YM6uyUNMDPLoBtG4K4QeKcRBjc8+BxCvb
         Lh2XPB4j7vf25c0NleZCnB4rkMxods62YC3VFih+GO0PqHU/zdA4A+9brTarXsmI9Fag
         eCvQ==
X-Gm-Message-State: AOJu0Yw205jwCxLRR5ThEhe5fn4aYkiVGmPvuVi/IFiRN1XBHwqb+RvH
	+6QPcgVoI5fuJG4ycSreNohGwwo74znbSS9uLqFaQG/u8gmyUYWKdzMI
X-Gm-Gg: AY/fxX6ganXTtjgu2RGsZNzFMeC244+gLwHnmqUiSxq+nrzbcyeHS0tzcDMhQli+k9m
	wvgBQZuwOLO+WMyi8mVgmFfX0FkUcBfSKn2lXINp4rB1Cgr0Q1wrwMEwb9MJtUjj6KScywn/EYb
	Y1riUsm25KGYZwEaXE2g3fh0iwTIF7F50VWUbTAi2KU6yjL3cs2pfEImU6+9NeQ1232CNRKEP+2
	SEhS8WK1hlI3p9NcXiEiMpXBFjNJ5CCW79isI/UHREhdK0iMzFeCuVMJVospIy7tcW7Ygu4Nzmj
	IzEYp8+NCEB9330FOgKONTKXwV+VCPLRYmw9L0Ttn2bJEI+QHoJYAmXIWBYF5A14EiaSeGMz0/S
	lxT/csAehAaYZBnnWtdrW7vE/LPOZPIpA04/PYqW7oHy+Tm4DG2hCxBCuK3B5ok2WkwujZeusZr
	PtJXD57HX3HbaGRStKcwCXZqj/uQmYyOyiaPgwBd4/G5/qOmAaLhPGURjuDTAuW8GTbQ==
X-Received: by 2002:a05:600c:1f08:b0:479:33be:b23e with SMTP id 5b1f17b1804b1-47ee335357amr78247495e9.17.1768473103098;
        Thu, 15 Jan 2026 02:31:43 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f941a670dsm15829185e9.5.2026.01.15.02.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 02:31:42 -0800 (PST)
Message-ID: <0037e6b9-e57d-4cd3-b156-c8cbf439347a@gmail.com>
Date: Thu, 15 Jan 2026 10:31:41 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v25 2/2] status: show comparison with push remote tracking
 branch
To: Jeff King <peff@peff.net>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <pull.2138.v24.git.git.1768298118.gitgitgadget@gmail.com>
 <pull.2138.v25.git.git.1768306316.gitgitgadget@gmail.com>
 <fa744efc598cd902e9a3a4a17b24134351ca5803.1768306316.git.gitgitgadget@gmail.com>
 <20260113170321.GA265671@coredump.intra.peff.net>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260113170321.GA265671@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/01/2026 17:03, Jeff King wrote:
> 
> Can we make this configurable?
> 
> I build my daily driver off of the 'jch' branch, which now includes this
> series, and I've found that for my triangular workflow the ahead/behind
> for the push branch is just useless noise. I treat my push destination
> like a mirror, where I always just push up everything at the end of the
> day.

This is a slight tangent but if we're taking about making things 
configurable I've never found the actual values of the ahead/behind 
numbers particularly useful. In a triangular workflow all I'm really 
interested in is whether (a) my local branch is behind the upstream 
branch and if so is it going to be a pig to rebase it, and (b) my local 
branch matches the push branch (i.e. do I need to run "git push"). I 
don't really care exactly how many commits ahead or behind the local 
branch is, the counts are just distracting and don't really answer the 
"is it going to be a pig to rebase" question - the only way to answer 
that is to try it and see.

So as well as configuring whether we show the comparison the push branch 
it would be nice to be able to configure a simpler output as well. That 
does not need to be part of this series but perhaps we should design the 
configuration to be extendable.

Thanks

Phillip


> I know that the output can be disabled with status.aheadbehind, but:
> 
>    1. I noticed this first via "git checkout", which does not have such a
>       flag (AFAIK).
> 
>    2. That flag would also disable the upstream branch ahead/behind
>       output, which I do find useful.
> 
> -Peff
> 

