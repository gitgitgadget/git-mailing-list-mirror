Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BF92571B9
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759956295; cv=none; b=MUOu2s2zpBWXl0+VsqIG6iA1ZV0wa6omzFwgWNpTCXCzTA1t2zqAa9pPnUihozIO19HCwOTCIVijv6SEUzhq8XiBmJ4fjz0Ogx5zoUz2Itp8yL13dmi5WVqoym3X6BemHN8i6kmA6cAhWh+kPRL2aNOnW3IXxOggLFdWVJeMPBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759956295; c=relaxed/simple;
	bh=NPdSc7N9e+chxVQr8B42x6e+IXINob+tvEshKQv77A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlkQEPiBGHAMZykpFk/ZJx2oaBC3TENNCoX8/UFnI2sIOTEcDMgXDLieLnIubaBzEAtRqNLsrzfErQ5GEeUrU3LpbhRuT/tOtBo0RlByFPRL0HzhoAySlRVP4d7w/qf4VgCB4/Rbku1n7ovj3iKxJWZCvjA5xh2Su3asKHewM34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPEKdBh3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPEKdBh3"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e34bd8eb2so2364645e9.3
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 13:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759956292; x=1760561092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GZLXTD7TiAnnVjIS76YVinw9cUnYdtjEDn73fAOJ5fs=;
        b=RPEKdBh3tRVnY60ucQaQrsgTpoKh1Vo9E21rSUmyY69nqi4JHzlA+swQ1C9GoAC58o
         D9DJsfnkAXi6kOHZVy8exgQfWZMC4u0c9yvZX5tBa1bM4OGZWWW3G0vlzmyS7gM3VRi+
         fohySK6a0I2xUd1BiLk6ytAOdkJc1+V634vesrd4VZHkD59FOcg3In0nH6hF6YJDUUtT
         uvvSAYe9TEp76octd8ULOOErpbleeX8XoV2TcpeVOkt1S/IdC+rFYfyDHpbaOBaDXMPU
         q983o71m+AlK/s23NRHO1VKcMU02lvM/tw2W3D46+Zf2K3RWNeA/kCp2S2UlKKayuKGG
         OpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759956292; x=1760561092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZLXTD7TiAnnVjIS76YVinw9cUnYdtjEDn73fAOJ5fs=;
        b=PmJ8lCR9yjFGLQMN2zHNS8F+zqLIO1Kipd6Y+T1KWkHSrnEnGQP2TK/EpFzn4T4MrZ
         rkiGc7ttpaKU1ocfZA0oh08Tpce2GJ5Uww0Yhwu19vky3wBdd175qF/StUX+RdphZ6V4
         t2qIp7gM1QjulfQBh0ZrbzdXZ/gOnXf4jecR5thah1/oy0y2iudMCoQ6F3swZZbu1UVe
         gtCjGkbdUugVqTp5elMb3bZFa/j2f0nXf0n5b8bysVkyTSAEQqTtlskV7I1WDZDx2Xm4
         moH7WLZc7NqU3OLHvCWxXxiARGmtH19TK/4+1LBU8vhLxI+KvYfIsc5LqO6lGQEz4r9J
         +RJw==
X-Forwarded-Encrypted: i=1; AJvYcCXW7rL9ECHM0hpPL3mLaIcv/fzFSbLqRqEfiGMqAtZaIcLAkN3h7dYhhRiWVGSFgBPACL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKkO0aIvWhffvNcslLyz9ry0eGLWZzDwhO0bvANQJwvT+bHsaL
	2NxQhNa50dcBXoIsylfni59w090QCxJ1fzHTz4NF/LfurcG8iyp0Jizl
X-Gm-Gg: ASbGncuU24L2G7hm41hSVLJSrkcD8EOzVPxO177ne4LDHV3KN5qs4SagRiQ5YvLQ4f5
	h8kuvq1udyOJJPwZTcKOOdCYVoJ4QC7lkXuU0t3nVyMePWATTO9MDhk9zR/pGF7wBRqJngW5ROP
	2Z8DjaEmITlOHi0tRAEaPEd/h0q42EfqZKbN4F+osPGhkTEoDCAqzeuLV8jZ/SbXmmwdNxL8Q6K
	pANRJH3RmwNRajhSxWxduR9oB4htq283uQrmU2Fhuej73ATsfX/tCyKLX7BsZ38LBe4PQhjtWqP
	4HexVZBv4yy9IwnMfw05OyKpm6dMrlwWHcYLOgs+JSSLD1mf4HqXSfU0T80H0BxJvSq2RjtxQRA
	6bdwsdLnXxlPAAjtuXBKrSt33026w77eUSJD0DwKa7X9lAVQ3Ycql/iqKG7vD+cfstd2ALhygJX
	tI
X-Google-Smtp-Source: AGHT+IHUMjlgrr6d2tvvRs5iUugz3KhV2L6cjiqXAt8JLrjOiaMtT32/+GNc45H4ZmHF9JDsLG59bA==
X-Received: by 2002:a05:600c:1d18:b0:46e:4c02:c2f9 with SMTP id 5b1f17b1804b1-46fa9b18e0emr35600765e9.36.1759956292360;
        Wed, 08 Oct 2025 13:44:52 -0700 (PDT)
Received: from localhost (94-21-146-170.pool.digikabel.hu. [94.21.146.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab51a968sm21729865e9.4.2025.10.08.13.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 13:44:51 -0700 (PDT)
Date: Wed, 8 Oct 2025 22:44:46 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Luca Milanesio <luca.milanesio@gmail.com>, git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
Message-ID: <aObNPk8ily0EFNxM@szeder.dev>
References: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>
 <E03F997F-1738-4CF6-B7D5-206183FA5BD1@gmail.com>
 <aN1RFvz7uGPnepxe@nand.local>
 <aN5-n_ArhQqaQZgt@pks.im>
 <xmqqfrc1xqsp.fsf@gitster.g>
 <aN6j7giOosGreKUW@kitsune.suse.cz>
 <aOTrC8CRZm5hERgr@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aOTrC8CRZm5hERgr@pks.im>

On Tue, Oct 07, 2025 at 12:27:23PM +0200, Patrick Steinhardt wrote:
> The question of course is how to get such roadmaps. The easiest way to
> do it is probably to gather a list of known projects that would be
> impacted and just shoot maintainers or representatives of those an
> email? From the top of my head, that would include:
> 
>   - Implementations
>       - libgit2
>       - JGit
>       - Gitoxide
>       - go-git
>   - Forges
>       - GitHub
>       - GitLab
>       - Bitbucket
>       - Forgejo
>       - SourceHut

codeberg.org

