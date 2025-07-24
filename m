Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2B12D77EA
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363539; cv=none; b=QvFT2zDHkzXHLJ1QmuCNhWKai4xET8hkZRizf1Vj9w4JwG7uo9XiobytHihbHmFb4fuqLJFcVKDBTWlWhyD/7qIHrz0BCwZGc9K+zJ1NkFGBF/DrfZHc7mdcDVoxBOHtZ4hZQYo6n8cOcouvvayDeOTSPJrNk9pIzuTUPeG4QXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363539; c=relaxed/simple;
	bh=NHjgKHYicPobpVe2y4TE+UyO/Hv2VpZrAj5ujCZkwBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=omJ1FGeSGkV4wzwLzRwPNMFx5pTm/D1+yxnESBlDFX0sRqqN7r9EuCypvUz01Nv69fNweSfpCOUJa4VCB3GLQ+oaGSTH0taEwYWtUzv4CA2nk9JvTIyK2aCD0bAQvFX8wP+a5NEtOC6KwKV3J04dRZpDwD8hc1ijoTHi9RVZGPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhDvUiER; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhDvUiER"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6fadb9a0325so8196216d6.2
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 06:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753363536; x=1753968336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S12DwU6QZSND9LFt1tU26DXFnAh5iWMOMFM5suUcQtI=;
        b=jhDvUiER6u28Y5wjAgTbGJuGHXF81Bew4zn8jVI3/aMjkKks7zv9ulA3kcI8BNMpSm
         OgZ21DCgR5B2RRnRPPXkDnqtR88V4wp5EJXGBc++KnKrGzOUkYPK6qOgsWMtz5rOPdgb
         Yma5gJiK3W2XOg3BztFwiNXgnvGiw/3/dL7JVPLfVM397UiaTu2uSjqXO93dCEBM25Ww
         VvOpE/Jzhhcux+gh9VFo/9SZbIn6DOk57xaP4TXQ/J3YFAtDvFPlavjJD/p2//YBfwyz
         DTqzEg4co+Qt/pyKkHTVQVEwiAdwN+oI9h1RQVh5Jv2RqRMk/wbMAgI1z0nQ64olDm2u
         +DlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753363536; x=1753968336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S12DwU6QZSND9LFt1tU26DXFnAh5iWMOMFM5suUcQtI=;
        b=fHMYjIMmCr5SJlqV8NhFB47ka8cnCVaQO11NF1u29FPiMMnGIyPDMXaTfrsNF253Fy
         VuqBmSY8IhaayGBGHAbTUOSCzG/0FJn/Vv2q7r2dZ7tSMckKzhvcz4/cdD2WFsTSzE1F
         tZ5x7XP7joZ9BVlVKRrXbFvEojEsnNZj3aaYa2q2128roEBRyo6LfQ6d9Xw75mmaYIG7
         3yp4zaTbPcdERUZ9ppjFsLGiDZJke6gVeCraM8I84gaKIayChjyRheM6VnHYGo7dkFgW
         2Y8dXI9zIP+RPJBTsosEAOj2h2JcCUX1Wyscme8/sYcZb3BAxYBBzso76s6VLPpTMZXI
         GV2g==
X-Forwarded-Encrypted: i=1; AJvYcCWA3EsFwQTnk/OwGfa+D2GOM7ZOg+hLKPUaQERO1nLHIw2YCFxSmNvxukmXptEKB9KMP4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8LP+oqEY3in6zo20wB/fHfHCant6BB8m7A5iWnqETZOFYnAla
	z8nr/W95Kv3Mf1JtatbXjYu++dkuydIiXXhrLJ4vqXRRNiepEOoaYyLV
X-Gm-Gg: ASbGncu9B1RpN4HU6SyeaZ+pMGFysh7IpRjcHHyQ0t8r/zpAgPM8WZqdcpz5OiDPqqc
	5qvBMY2nuT5836Db0ScOxLWDn5Wfsz1Soey99C3r9gb0wv1SLPwwTF7C91QYXylc9maxYwnTfBt
	Uj4o/YT7s/N9LA0DCs+pi6MvwiuysmDxUlKSBQY/8xtl61SGoZi7q+bVhPVYH7siSHjUXouAYh0
	8s0+6mpBr/5gFTn9r8fa8mW+gkv+ZeKvX+dKReKijIhLmerk6RgwRDkwnoJMJngE/Dmp41DVrSq
	i9kVzod6aiNyNkanNPUijH02+6iNDRaunue1FFBkfvWhzySsqPyv/bzDtdKli5QobSzixx6Cr1p
	ZqWBMNbVJEWdlH2yz7pwu3INXmctlwXavzvs2SpFcdEsED8KlhJxJmdjaZqj15BC0OmY3mjqQH6
	ug2SWx3qA=
X-Google-Smtp-Source: AGHT+IFnq3a5fpyKCUSMeEwmcUvkeigMyB9FZ5QW5wXYRBMx/vDjeAU5H+cLOFhye5ACJ0Vf7lDoew==
X-Received: by 2002:a05:6214:1c4b:b0:6fd:7520:da87 with SMTP id 6a1803df08f44-7070080ec97mr84337196d6.25.1753363536308;
        Thu, 24 Jul 2025 06:25:36 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6de:d300:b82e:f991:e4a:424e? ([2605:a601:a6de:d300:b82e:f991:e4a:424e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7070faf247bsm13635356d6.11.2025.07.24.06.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 06:25:35 -0700 (PDT)
Message-ID: <43aaec10-2696-44c9-8728-2045b83dc5d3@gmail.com>
Date: Thu, 24 Jul 2025 09:25:34 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSOC PATCH v6 0/3] environment: remove sparse-checkout related
 global variables
To: Junio C Hamano <gitster@pobox.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org,
 shyamthakkar001@gmail.com, phillip.wood123@gmail.com, ps@pks.im,
 ben.knoble@gmail.com
References: <20250603131806.14915-1-ayu.chandekar@gmail.com>
 <cover.1752882401.git.ayu.chandekar@gmail.com> <xmqqcy9qlfm8.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqcy9qlfm8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/25 6:14 PM, Junio C Hamano wrote:
> Ayush Chandekar <ayu.chandekar@gmail.com> writes:
> 
>> This patch series aims to remove global variables related to
>> sparse-checkout from the global scope and to remove the definition
>> '#define USE_THE_REPOSITORY_VARIABLE' from a few files.

Sorry that I missed early versions of this thread. It's an
interesting topic to me, but I've been distracted.

>> Discussions since v5:
>>
>> * For 1/3 and 2/3, Junio told me that it was concerning to put so
>>    many calls to `prepare_repo_settings()` so I tried to minimize the
>>    calls and made sure that there's no useless calling.
> 
> I didn't mean that the number of places is the problem.  What I
> found troubling was that this is not done in any central place, so
> it is hard to notice even if some random cmd_foo() failed to call
> the function before doing its real work.  For example, shouldn't we
> be able to, at least for built-in commands that have RUN_SETUP bit
> set, centrally call prepare_repo_settings() somewhere late in
> git.c:run_builtin() after we figure out what should be in
> the_repository?  Now historically, setting up a repository may never
> have involved opening and parsing tons of configuration files, so
> such a change may be incurring extra overhead we did not have to
> pay, so it needs a lot more thought than just trying to minimize the
> number of calls, but some performance measurement.

I think that the core issue here (and probably causing the issues
that were seen in the user-facing issues) is that the repo settings
struct was intended as a place to fill config for some one-off
"feature flags" and not to replace core functionality for a repo.

There are two ways to change the approach here to fix the problem
of needing prepare_repo_settings() everyhwere:

  1. With the idea that these sparse-checkout variables are
     critical to the functionality of the repo, they should move
     into the repository struct itself and be initialized along
     with all other values there. This changes the patches (and my
     follow-up series) significantly, but mechanically.

  2. If we are going to change the intention of the repo settings
     struct to move from "optional one-off feature flags" to
     "important information about the core behavior of a repo"
     then we should prepare_repo_settings() when initializing the
     repository struct.

My preference is (1). The only argument for (2) that I can think
of is that it is sometimes helpful to share only the settings for
a repo without sharing the whole repo. But that seems like a weak
reason right now.

>> * For 3/3, Phillip told me that it broke user-facing as it will be
>>    parsed quite late in the callchain and might throw an error mid
>>    operation which we do not want.
> 
> So has the behaviour change caused by 3/3 been resolved?

>   * This throws everything in repo_settings, but these settings are
>     inherently per repository and they are meaningful only when you
>     are working with a repository.  What makes us choose to make them
>     new members in the repo_settings structure, not direct members in
>     the repository structure?

(This is the same thought I expressed earlier in this message.)

Thanks,
-Stolee

