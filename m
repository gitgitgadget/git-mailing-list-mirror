Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D6C1E00A7
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 21:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323357; cv=none; b=EFFKs1/rWI5C9UWe75io6QYAv/jqMMfe6B5Ccwj8hLad1GF3r/CPoea72nrkm61mVaUFn+s9nig59m5YtfqFRtsswoxMWsq6lZJ8BhdG1vH2+IMyYG0OhqNVDsFgQzuKKxxgZBgPQGl2XGPH0vowH8oRKxriYgrQVadg0+ldq3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323357; c=relaxed/simple;
	bh=kApp+XIVMDRoatWMrf0VF+W6BPq8sI/DZbyquCQmTd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2wL9Nf5stO0IFDj6HE5zGPUcZXoj2aZDrxc6GnKR4QBNTNyNS0eyJaqvLnk3TcJYKa6IlYi1F6PQjkg9t/1o8JDlPRriHaV2RMBvfpaogh9qiGOTOvm6Xur1OUlN+MKjwHkh4W04RGAdXz1kp9eb4Tbj6PRU33DW3zmsbPiJMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gQ6ZOsmb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQ6ZOsmb"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c87b0332cso24995ad.1
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 14:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730323354; x=1730928154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xy805a8KDbI+8GsRI04AQ6mcHINtm4vHPRImh39Ao5o=;
        b=gQ6ZOsmbIS/zElSXiTOfW9/qgs46n5GON5l4SN/BgeKe0rxbiwNNx0Bb4Cf5jI9sUY
         CMO9L1ZdFLbfG08zTSfdRT6clmgY5VJD1lF5ruQ0NuZ2Gv71hf85+boVQENxGchqfTK6
         CrbS7/Vr5n0ZLuaxzyribSL/FvQBc25Cp5H28tGPsTLwqvmvb33iG8jXywHNINvaeQ2N
         dSnejVJevKyUdzSTKTJkSDPwTAeZFoCbnIzvbIrY3NDLOuFEJx+HK8zQgfmY/NZhTCD/
         LI0WLzlHydz/70koovxZKy++2BtOHcqcnvBkvAojZViWdBArSgVrFXNqZyXAG18bDPAD
         dhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730323354; x=1730928154;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xy805a8KDbI+8GsRI04AQ6mcHINtm4vHPRImh39Ao5o=;
        b=OY5gElw38A5m0WvPqV7ku928BdLM0qsDEN0iQ4maCpWvr1KPXFie7frwo3Y29a4KWO
         tg8WWMjQVjYnqORCWbE1i2iKKkuB+CbTATeTMO1VTou+PEl3+bHSe5HW2KooyZsVUhKW
         CWsl8lG/XU1EDWlDP81T/Q0UdFJpY8YwPXZ+T/yxtWchLMqQeV6jGRn+gkRvLSIu7vu+
         3wdUtHRU60oSu+4ey2Z9dAe1UthGlQE04hK3iwc96hQTwhLqoDCjbin6j/oHQVl0AzWA
         theBAuubc5rg6ZWyW4Yi6+aLOHjqWnH6QfUMQUSK0o1tnD+0HTxuqP0TLSPsHhlJH1hb
         omjg==
X-Gm-Message-State: AOJu0Yz+RcPZ+sijug/hQrcJqd+2r6eQa2Il3LDUm8Nq7eFMQhZ0xjnR
	8XKLNjlLRSQXbJnQWS82t/ZHsFMhWJfjXwGW45ONZyAqFrul6KkrzTwgEChbs2g/WJOuvblS9Em
	qYg==
X-Gm-Gg: ASbGncvbntLLxbA1rZwFu014cfbYdcuwFy9HqnAp6Y0VQaFFq7IpOO6SN0e4fhmOO2v
	0eXZ4qjn7gg9a9An5tKQD9ZU2gMQL2vcM8s75HqZF4fqHJ6vazgMTI+fkvpVdTxIQPkAPS5CYXM
	tS1YbZQKP2jz42t4HvbjZcyO3HUDFa7tAfc8C6vIea3jgzgBbEAdXjuo6ttDR6WX2SPx/aChPU1
	RtuK6ydPU472zk6+JSsfE67XRAssS3ZewnjYreqL0vME4dH
X-Google-Smtp-Source: AGHT+IHeTZkHrgRRiENtTikHHMEu5eVM3D2vS7vl667a4h1ZztijvHGvYOYzbkmgZh7YpJF64Wo0Vw==
X-Received: by 2002:a17:902:d2c1:b0:205:753e:b49d with SMTP id d9443c01a7336-2110410109cmr972015ad.0.1730323354211;
        Wed, 30 Oct 2024 14:22:34 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:e2cb:194a:36bf:6b07])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c0a2asm300405ad.193.2024.10.30.14.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 14:22:33 -0700 (PDT)
Date: Wed, 30 Oct 2024 14:22:29 -0700
From: Josh Steadmon <steadmon@google.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] When fetching, warn if in commit graph but not obj db
Message-ID: <ikraw375qal5ioopai5wk3i5vtpnyurxxd2ixsdujehpypuova@in5idqkd6wee>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20241003223546.1935471-1-emilyshaffer@google.com>
 <cover.1730235646.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730235646.git.jonathantanmy@google.com>

On 2024.10.29 14:11, Jonathan Tan wrote:
> I mentioned previously [1] the possibility of not running maintenance
> steps (commit graph writing and "git maintenance") if no packs were
> fetched, but looking at things again, I think that we shouldn't do
> that - in particular, if I ran "git fetch --refetch", I would fully
> expect the objects to be repacked, even if Git wasn't able to detect
> conclusively whether a pack was transmitted.
> 
> [1] https://lore.kernel.org/git/20241028225504.4151804-1-jonathantanmy@google.com/

A note for upstream, because I'm not sure it was ever explicitly
mentioned: at $DAYJOB, we saw this fetch recursion error as a
side-effect of the erroneous GC of local commits discussed at [2].

[2] https://lore.kernel.org/git/cover.1729792911.git.jonathantanmy@google.com/

> So I went back to my original idea of detecting when an object is
> missing. In trying to balance the concerns of both doing something as
> reasonable as possible in such a repo corruption case, and not slowing
> down and/or unnecessarily complicating the main code flow, I decided
> to detect when an object is present in the commit graph but not in the
> object DB, and to limit this detection for objects specified in the
> fetch refspec.
> 
> Upon detection, we can't fix it due to reasons mentioned in the commit
> message, so I decided to print a warning. An alternate option is to make
> it a fatal error (instead of a warning) if an object is detected to be
> in the commit graph but not the object DB. I haven't thought through the
> ramifications of that, though.

At first glance, I lean towards making this a fatal error, but I'll try
thinking out loud a bit:

First, we believe that [2] above should fix the root cause of the
particular case we saw at $DAYJOB (hopefully this type of error doesn't
have multiple root causes). So we expect to basically never encounter
this error again after [2] is merged and rolled out, and all existing
cases of repo corruption have been repaired. However, interacting with a
broken repo even with a client that includes [2] would still hit this
condition and issue a warning.

With the current implementation, fetching in a corrupt repo would still
cause git-fetch to infinitely recurse, and therefore would repeatedly
print the same error message to the console, until either the user
noticed, or we fail to launch a new git-fetch process due to resource
exhaustion.

I don't see any reason why the above situation is more friendly or
desirable than exiting (with the same error message) as soon as we
detect this type of corruption. However, I don't feel super strongly
about it. If the rest of the list is OK with repeated error messages,
then I can live with it.

> Jonathan Tan (2):
>   Revert "fetch-pack: add a deref_without_lazy_fetch_extended()"
>   fetch-pack: warn if in commit graph but not obj db
> 
>  fetch-pack.c | 45 +++++++++++++++++++++++++--------------------
>  object.h     |  2 +-
>  2 files changed, 26 insertions(+), 21 deletions(-)
> 
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 
> 
