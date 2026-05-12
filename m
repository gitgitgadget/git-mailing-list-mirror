Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E697D1FC101
	for <git@vger.kernel.org>; Tue, 12 May 2026 01:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778549213; cv=none; b=ZEyUVXrTfIlecFt6fgVYuycMpVXZvtH52WraYIpQV8hMMGav7QqfmA4NYDv8cLX7MEPOIH9MF2iEaWLHnUPoppnWfM2xCUjDB2iazWoKP/8ZkGawfKXnu/HSRrm2vEM6P6ygs4HSKg4C6601O4GDx0NuJXjkP665gd5rmGpMhns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778549213; c=relaxed/simple;
	bh=S2pyF3efQS4uB3Blb6lGLzUMdY3cYO3V7IlohzO6BYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMypI0Yl551Su+BGVF78wTyE/ltWIaasML+GGVff1Hhih21KAIk4uNyGWn28+wtzJKZPoo80kdvsVX8/m22jbgc2SJwANMpj/x414Pisp0hA2yXPfmRPbCMorzHqPZaMfTDnzQ+TA3TsxvwXQzvYh/n1SnCeAawN4HKFSV7u91k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=TbUqHzmh; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="TbUqHzmh"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7c0dea734bcso24910327b3.2
        for <git@vger.kernel.org>; Mon, 11 May 2026 18:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778549211; x=1779154011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dXcSVAIkCEYEAKXuum+mz927z0BJhnoAn36AZzuJp8I=;
        b=TbUqHzmhM2TpXusukOKqSGd+bvmOZEvnS5fcyf2ddV8e48nNM1HZgeqCaJ/6UeCFMc
         wfs6hzv05y8RCs6DMLpjUNS+Ixl70SDK9Wz54/TLHE6cIGm6GLqNdzLUwsZocORocoCa
         NmfLaW/1ZCmoko9dAw4PFW2EN+ganwdulHeMe5MJ6jFGRrELuL3efx7Vd0xNJalg4gvb
         iLS7gjDqW9M7RxI/lAcps3U/NmzpU9FmCt4aRTADbnmGieCUBBnk2qCKPX8yd+9YsghI
         bLt/PVllVxcqt1fBg1Z24KJYEMHVoOWqr5kcEnuS6ukVcMqapiJoEq6H48HjXDKMQT+x
         dJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778549211; x=1779154011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXcSVAIkCEYEAKXuum+mz927z0BJhnoAn36AZzuJp8I=;
        b=EXhA8XLgCbb5Uj9fep31N4osz1NDcz+VOpUUp6NCIVMzDOZq14NVRtYDpy/diIyOZR
         l/ModURRBPtoA7mcigQSqO3aDGBkaI1vi9oFifqxESzxIuJuE8nhoAvQBjowi1Evcoox
         vPDo0L6oxVkU9ZvldkbRSYcmINZ2ta2bQGgQmk7A6pSNa6wI54bY0mUoAtdN/zv3pJET
         crO0JM00lhejeeI4mkCn+z5P5v+zxEU1xFhMbWwbe6LaPA37HvOQ5mio+QaKiFlamrFT
         Rtl+YobC0KteCt+NUjttMGBwlzkmmKq8A1s9A/hD0BwsoKvcu8WwuhmLHEQrWwHyP+s6
         C08w==
X-Gm-Message-State: AOJu0YxtX4dopI8e00oeMeRNGzaG1Mlj/yXn1uB8oBQxI6CUTHnHq16C
	zzBsTHHxejBkURB/4XjJxe0EeHBxRWl73rQV+0Dq8SsBO3OzyDBYhe6otrpV1yXxMlk=
X-Gm-Gg: Acq92OFCyrv7EOk3rbRAydv6rG8wWWuCJpgiM67zgCHk2k+mNOkwvTZJeJwf7fQZ/N8
	CqNlWucO03Ip6Li8CJo/yNAhphU4l8yPc/7VnbeawgKdrOO4mOlJPTDGmDO5iXU5S8WpiGZJ9LR
	hSXvXK2Io/R9SvMIbtYB0Erk8vKcdHodX1zg1Z7K7i+tivK9ReaFlFk8IqShB0VL0c4Loo5R0cZ
	JvCHrkIdKkHmzTfSP/UebJQGwQlRUXzDJ9rOiO3qh91FsxsqnD6R6MDQzWp6U5cXKfH+MkL1V8i
	Fm6e4zkVlfbp4TVem4OMnGeGaSOX0pxasCkfhWX2JY1l5v7Wwj7sqiCG2gxeFm96R+mFamWvJKF
	L+aD7ZTn/cUmKA9leuswT4e4/YRL3hcTU0KsF4vP0WLmRg+pAEcmaFLIz0kZKpICjmAre5jev9U
	EBvPEdGOPEyPCreAkaFrAQOWHmXP6eNsu0cy9ezcliJPFHRa0tVklXFdUJZz10w7aQgX3qDSY2Z
	kC84y7G85cFAxTTIB9+JlSepP4l/BzaOfsrUy9gfPDQIodOG5c+hE9nYOXgKU1tNl8Nut2Swj2m
	jr6sc+IaErZRz0HY
X-Received: by 2002:a05:690c:39b:b0:7bd:cf35:e33b with SMTP id 00721157ae682-7c102e46ff4mr114824697b3.17.1778549210792;
        Mon, 11 May 2026 18:26:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7c535f8e757sm5537737b3.34.2026.05.11.18.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:26:50 -0700 (PDT)
Date: Mon, 11 May 2026 21:26:49 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com,
	newren@gmail.com, peff@peff.net, ps@pks.im,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 06/12] backfill: die on incompatible filter options
Message-ID: <agKB2bNgtQcztA42@nand.local>
References: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
 <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
 <da191e29e68bd46a56adea35ba1e7a41ff2a15c5.1778523189.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da191e29e68bd46a56adea35ba1e7a41ff2a15c5.1778523189.git.gitgitgadget@gmail.com>

On Mon, May 11, 2026 at 06:13:03PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
>
> The 'git backfill' command uses the path-walk API in a critical way: it
> uses the objects output from the command to find the batches of missing
> objects that should be requested from the server. Unlike 'git
> pack-objects', we cannot fall back to another mechanism.
>
> The previous change added the path_walk_filter_compatible() method that
> we can reuse here. Use it during argument validation in cmd_backfill().

Makes sense.

> @@ -96,9 +96,8 @@ static void reject_unsupported_rev_list_options(struct rev_info *revs)
>  	if (revs->explicit_diff_merges)
>  		die(_("'%s' cannot be used with 'git backfill'"),
>  		    "--diff-merges");
> -	if (revs->filter.choice)
> -		die(_("'%s' cannot be used with 'git backfill'"),
> -		    "--filter");
> +	if (!path_walk_filter_compatible(&revs->filter))
> +		die(_("cannot backfill with these filter options"));

I was going to suggest that we indicate the type of object filter which
was incompatible, but that gets a little tricky if the incompatible
filter is a child of a LOFC_COMBINE filter.

Resolving that does not seem worth our while, so I think that what you
wrote here is more than sufficient.

Thanks,
Taylor
