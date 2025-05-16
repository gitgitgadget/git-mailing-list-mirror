Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D8518A93C
	for <git@vger.kernel.org>; Fri, 16 May 2025 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747407871; cv=none; b=CThVoKNcK+H9w/VcZCTJTurhXk56f4pdlW/mz+lnJD4dJ8tq9blhs0Wn6sNJgC8hiUw5IP/CsS8PbPRWDdqLHPesu4wj8EZ7FGtR/lDPc9NMOjRZV31IrsVvS8BRdzSTv7iM14chcuTEAD3YCC6IBkO3JXxFS6xSy2o4N2e3oVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747407871; c=relaxed/simple;
	bh=YoJUFd47zSAbz+3LooDrK7XlR6GaM7qu6OqdbhjYhhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmZ53KJRRCe3VU+j2meypoM9eVwc3iGNCLfcOnXTsagh2Ahq+p3eR2vo3EdgQFJZvoL0vDF7rwf2blY7uu4ypsXh7siGMY4drbM7kI14MLCqCq6o3oVEfHFluGkArE4L8gD45E+jszU+Yw+jgttoZLZnnt+pX7pdLEPyy9xD6jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=pyGk3owQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="pyGk3owQ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so23734755e9.1
        for <git@vger.kernel.org>; Fri, 16 May 2025 08:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1747407868; x=1748012668; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1jXh3jnq3PjkGx3nJz+f2FNMTUEDQBWsBqYgmLTqqo=;
        b=pyGk3owQPxn3mbUTRlmGdLiXVBeeCpwr88NE2CAJt5eqq8pl/ZeRVdh5eryvVbc1ps
         GuLlGTqlVUY/ru9o3SH4EU+WxPzty1xpihi2sLdhNq3MMskWVvwFPWSVJ/fm+wR3JldB
         sbINAuGBMrWA0rKJyf/dfdJl8lQYkTOznLrnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747407868; x=1748012668;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1jXh3jnq3PjkGx3nJz+f2FNMTUEDQBWsBqYgmLTqqo=;
        b=sUl/gp2S2qfM5z0AGvt4Uedu1E4/J51ESQRLA6fDF7D86jxwJMZLisbJ4fLUltk1+d
         QSFBby2yqCby3n5wg9E8rjif3LlIbmHRRR/XQB2hL6PW/ChZmyUqQ40v0lG1dhb0ahf/
         m5yNuAmVdJS3xealBXGVVvPUiUjV8PvrL8Hn7/+jX2CS3rnYf2vUwzSjPfGnJQ9g3zyW
         S9yVKvOar1BIuPbBXvrtAVWiL/i1YEJBa1WLcX0EnxqRapos1dqJyBkfhjrrhWXfCMC6
         YxUwCMsn9bJEs9XMxrCG+wlueZI66cd99sWI1/LPNkbN2C/OeY3bIgaXt611RhDypaGq
         cbfg==
X-Forwarded-Encrypted: i=1; AJvYcCUB1yBTX5HqD84J99yYSsj6wqPIb3B8hpNFNmIjs/dTEm1EdPF7Mnk0YffMUxITXJcbkx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMZ7YNtfgypqD16WnyfozgNYL6YIWv/Tv6++Hgsq9+aCE+3ScG
	uvWUuVO2gewuJbfpLK5dnkaeTDWqYzttMNfKNKHCY61ow0gw856CTjAJ+YuXo1kJgbI=
X-Gm-Gg: ASbGnctvHtT36JGxleXy4orBQAtRQaFJmPM4Ju15VSx0o69RT68rjDqop5+Iy1J+QvW
	/RC9UBajGK/obNQRbPTCM4AcD1tdK/6PtQNL7Vnj5aRDfxcVq27qVSRonw/6eN69T8L11E+yaD9
	2mFGdPDoXMXM79ezZX72IKDEv5iT36PwWW6nZpoCACpFHomFsyOfeWbUqpDAJRiTvxdWZSJYe1O
	HcxYiuxLBqPrUmJcaqh6N9Ks+pGjzOqtpXr4ETu2OwFwfVMAJsL0hH0zGS8QxF/jnkIZmk2a+Jh
	WfSdXHQCMSMB9+oQg+UjK9Znq30MWDMzaJarFhwDFL2+XluG
X-Google-Smtp-Source: AGHT+IHVCNeQ5bveFbr1PQF3hrT+fikC2I2iPs+Kl2Ea6my8yqq/rg/OemOAXvuTsT1RchfNLL6qeQ==
X-Received: by 2002:a05:6000:4287:b0:3a0:b65b:78ff with SMTP id ffacd0b85a97d-3a35c84b487mr4036195f8f.40.1747407868256;
        Fri, 16 May 2025 08:04:28 -0700 (PDT)
Received: from localhost ([93.115.193.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a3631c728esm1487672f8f.60.2025.05.16.08.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 08:04:27 -0700 (PDT)
Date: Fri, 16 May 2025 16:04:25 +0100
From: Chris Down <chris@chrisdown.name>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] commit: Add commit.signoff configuration option
Message-ID: <aCdT-UQtaaTQ8gyD@chrisdown.name>
References: <aCM5JY25NVPgyYRP@chrisdown.name>
 <CALnO6CBdhYFsDN=HPo9HbKeoZH7bb=xVVXUCK7nUdadLg-U_Pw@mail.gmail.com>
 <aCTI7VjK5QMht3ws@chrisdown.name>
 <xmqqy0uy4thk.fsf@gitster.g>
 <aCXqqj6gKc7-fjoF@chrisdown.name>
 <xmqqldqwya5p.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqldqwya5p.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)

Junio C Hamano writes:
>Regarding other problems, the fact that we are having this
>discussion is indication enough, isn't it?  If it didn't exist, we
>wouldn't have had folks who used it as an excuse to promote
>commit.signoff in the first place.

I definitely understand your concern about diluting the meaning of signoffs.  
What separates this patch is that it's not suggesting a config option out of 
feature parity, but because enabling commit.signoff is itself a deliberate, 
repository specific certification, which is arguably more meaningful than 
habitually typing -s for each commit or using a global shell alias.

The repository specificity is particularly important here. Currently users work 
around this with shell aliases, which are global rather than scoped to a 
repository, making commit.signoff in practice a more precise mechanism for 
expressing their intent about what to certify.

Would strengthening the documentation to emphasise that setting commit.signoff 
is a deliberate, repository-specific certification address your concern about 
diluting the meaning of signoffs?
