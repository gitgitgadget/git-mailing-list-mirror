Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92F82F28EB
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192250; cv=none; b=USUJGSDsvP6cPGQ6jlrnDteIIa5d4D+8lxPLvxViTXCHTAo4/LjPxLldnV3bNFodzh1xlA7USZvM1yF9Y65fFJDlxsPN0Tay//gQD3aH3p0/wEQJreXULhRE0XH01mmYoSphCz38t/GEtWp8asDKwAOtV1rK1jMi6zY6pes7zmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192250; c=relaxed/simple;
	bh=q5acU5jhRapq5axLDMnnLSqGN3vx8Kk3bXZ5J7NPjAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBy8ct55muZTVe6X+zsoBypCyzv1NQ17c5Xdn6+xwk9DirnDRKO7iyYI6BHfIv1oe7w9wBGWHbNJ2Eq4K2/7v7M5Vd8GdwmIkVSM3YdU7vdF5l0R03+9L/dUW+dsG49M7Oef9j8/QGbakrdKzObLHc/YvBqdXjMwifWLWn922fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrOCOdqM; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrOCOdqM"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b5512bffbfaso60973a12.3
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 03:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758192248; x=1758797048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yCm7Rf9DgXok5/MpzJJSZh7kvzakxiwyRKZ3lLZAax4=;
        b=WrOCOdqMizxFb5nIdPlGuKsqH7xbcCpRBHVA9afN53HEK/rmND7B8fXdVhXbRmO8U7
         iMxSDtbTTglt611uChJ8kCrP2QB2Vn+Uxx1pNrx1P5BAT1RT8wt+D9jXL4Sbi+9l20U/
         x0aSszefhZbrvAnZVLM4+1WsP8e8675mUjPhTSis2+t5/jX3sVe4i4XyGXw9/iZaLZav
         LeiOvLEvIZBy9xVFeJ1F688opkpo9WEDo9O1PWRdfWHOvtkGi6wuwjDanPLUL8METCrw
         M9BqroIhIlCrG+Z8zK8gxDBOWM3RZwCCMjTkqschF0gUe5C+4EiMeEg33QWnZms+vuQU
         gqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758192248; x=1758797048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCm7Rf9DgXok5/MpzJJSZh7kvzakxiwyRKZ3lLZAax4=;
        b=BhTYsojsyFns2VdFCCdTva36f6+V1sQ18wUgbx0bmOtHpUe242sgIpQfTUewh+7Z6c
         qnNNlMnkBpI9EisdUjPggFmj8UpdpiG0R5qi+8cvYkex+Q3vyFlUrcMdKcdbAwUxW7qo
         oxDQU67zRBUJGXIR9DvZKJugBYEMkcGumBVphcIbnyiJKQtYno2NYfhS4V7L2jp2C6zB
         95jfoJuzpWzHAq6NTiYzgzGQrMjlqNbFdMivhN6GzXgV3u7dtpL0l0AngEgp8CH2JYl9
         xOSz6JeII635t/4f0woR19EC8B2tnbmCu6fvJJ6L2stC2nz47qy+5fB8hfyJ9SUKiI8C
         R88w==
X-Gm-Message-State: AOJu0YxsIPfFdEbrasEsuK5j53yaXLUie9KsOTfgaX3lr5a1guXtyi6W
	TS2fyTZx0B7jPWJa64Xle3PYFmxS9an5nu0FnJOqP7Ih8w0T0yuOgzmMkXsfBg==
X-Gm-Gg: ASbGncvrSWpg2V8MMuMnb4r+w1/eobw3NaH2ZhZEj14aDk4PXQrvSPT5ERierDjKH3v
	fJuwzHN4DEaZoHIlr8hOzL25CuMuYQE/IAfFY/1A9hJ1ALn4B0TzGBsMmfBYLwkw3xWVk73UBIB
	cALJLcSTh6Y1JXfiD2/BuE3CEJ7SWSd31mf2Q8akZk3f5AMSN1nCkNgPqWHVY1HlO8iAGaEkVmZ
	oTWzg6qSrpoGIlPKk8+q94dAMAgRS558wnjAMYaseYSTiXchw73/e7LEcSDpXtJ8JSPI+Dxr7oK
	r3rBj/v0BCqaHNcQDl9J5d/OLJSOaiIU/Ct4ojelvV+SMpYY7Y/SdDveZbuC/udCQDmreuozlMY
	pgP20stPjh71/weBNcT5Hgfrtq1p26xSQ6Znw
X-Google-Smtp-Source: AGHT+IF8+zvfjbiM0b3damRqx/M4H6zjFUgWn4m+pFerfWeV+rKDfU2sXsqP6t8tSfypK4Ry/4c2vg==
X-Received: by 2002:a17:903:28e:b0:24c:c8e7:60b5 with SMTP id d9443c01a7336-26812168393mr66993605ad.16.1758192247754;
        Thu, 18 Sep 2025 03:44:07 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-26980053ef0sm22390655ad.28.2025.09.18.03.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 03:44:06 -0700 (PDT)
Date: Thu, 18 Sep 2025 18:44:16 +0800
From: shejialuo <shejialuo@gmail.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com
Subject: Re: [GSoC][PATCH v3 1/9] refs: add a generic 'optimize' API
Message-ID: <aMvigMLPeQE-n-o_@ArchLinux>
References: <20250906075147.1076656-1-meetsoni3017@gmail.com>
 <20250918054704.544254-1-meetsoni3017@gmail.com>
 <20250918054704.544254-2-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918054704.544254-2-meetsoni3017@gmail.com>

On Thu, Sep 18, 2025 at 11:16:56AM +0530, Meet Soni wrote:
> Add a new generic refs_optimize() API function that dispatches to a
> backend-specific implementation via a new 'optimize' vtable method.
> 

Should "API" be enough instead of using "API function"? However, I think
we need to give the motivation.

> This lays the architectural groundwork for different reference backends
> (like 'files' and 'reftable') to provide their own storage optimization
> logic, which will be called from a single, generic entry point.
> 
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: shejialuo <shejialuo@gmail.com>
> Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
> ---
>  refs.c               | 7 +++++++
>  refs.h               | 6 ++++++
>  refs/refs-internal.h | 3 +++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/refs.c b/refs.c
> index 4ff55cf24f..2ea6fd2218 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2282,6 +2282,13 @@ int refs_pack_refs(struct ref_store *refs, struct pack_refs_opts *opts)
>  	return refs->be->pack_refs(refs, opts);
>  }
>  
> +int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts)
> +{
> +	if (!refs->be->optimize)
> +		return 0;

I don't think we need to check `refs->be->optimize`. Even though for
some backends, we won't do any optimization, we should register this
callback instead of assigning `NULL`.

> +	return refs->be->optimize(refs, opts);
> +}
> +

Thanks,
Jialuo
