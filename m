Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC36C2FDC43
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563540; cv=none; b=A5SIBO3P4hZ4NC1XEie933EEEHCkljSBmZlzaXol714m45oM5HQZa/HELU25w9MaZrNM3PvY5Mng65My9oNWgUlDTLXTgaDHImrcvkMzoCdZaGkzidxa7IAemIKVYjseKWakPuYJaCV17qSejYAJ8d75TYeW+STisXn+nkcHx0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563540; c=relaxed/simple;
	bh=EWkDn6SqhyQBdkjEBkFGvNUharAUHjBXfCptOj1n9hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6KVcbpxD8Yk5Odr/+DmDuNPGvtUPlESDd6R13V+vZHNlbk+1EhokmgIgSBUAZeKb8HOSJnpVjXTrAV4zsDv4gGFPpftL5mwv4NdXCOggUyoKICdcDPbsYOzBOiFkCxgeFhJq4tPnSRiEoRaC3IsUOcc4oxySAbWAfp9Zqlwqh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=pw1rKE1M; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="pw1rKE1M"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78113fdfd07so231857b3.2
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760563537; x=1761168337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ve8dIwhvskyrtIwdBjZP8OFLZ+3qkCHXuRS9AObf9TE=;
        b=pw1rKE1MdF1zWeg0tkfOtRVDH1qiZkjhBWgmgPEHpV08pzQzJWxfmSaRE8vEZ7gVrz
         YTTQcD35R2exCOWPfhoarlh2teC7MEMymOlC8h4mqwHl9r+WDcZqvBqlMjbDCSCAAvVw
         BvbLB46Cndp9FOrD2lsIB8tYJ7aNcElwkjv91yl7yozUnlsOeUlJd/a+COPeJNQCuy3t
         ZPCsVoxE/RylrjPZ+il9uEmas8h6JcVa7WLp1wGg6gTqOdvwDMuLqWu4tNdBbcP4GLN3
         1SyGnuSc9vWlpKXJd9QamzgDl5yix9cfPxuWxnLdSMefd4/IjIyZ/29lhkVJDzUGZPD2
         HtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760563537; x=1761168337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ve8dIwhvskyrtIwdBjZP8OFLZ+3qkCHXuRS9AObf9TE=;
        b=cAFyAqrwlgCpw3nQjoi/nz8SVoBuNHbpBd5vr//DVS3cwBbT/tMdxc3c/KWw2BF6Hs
         4QdJzKxztY52uD9nYSCiY3J3gyHqEzV5MpNq88hYuHouUQYKODHpQZqsxC16UPCzMC5/
         ItrpLi+u5nHn85TGpN7QDeXev39qYwpZpfk1oU6cTOZZj+Pq7hq1XB6vuSMl/naPtk2R
         gNLkIwGvnHiWPJgFfbQJS7pPFzdt8Yx05Hv6d7xCQyIEsM39k1/uCxkHze4wvgToNj0B
         gseHfj3f54aj3AJ4L6ocOz6Pilp7B5dYUiHjfQfmZOXJGyxu9+9LJk6Vs0T8mIZijv58
         7YOg==
X-Gm-Message-State: AOJu0YyhLzOOo2HM7R1Xn3bSoU0P3HMN1rgiVgwdYS5zLZLz9N7/1YTP
	ctpcdFxVkvPt3fGG7zUKXXw49j3K/a/SC4O2jLvZSw9QWIB2YMa2yyrJWCZALe/BKf4=
X-Gm-Gg: ASbGncvRsvUAyAJj/EfIXKORzz8BZLxo7XUTbNHdrAeEIfeKDeGYAC/dVJzHkP+9TAN
	nByjh1maYtKKKCJvG8WQgTowxfdDdX4pmyCCM5Ps5fUt0cEBe9Lk7183tyzLrpGUv5cbAftuiYe
	T5wFTdclrO6uCi3Jr96GlT53JJqmA1oLMfbx+9wn1P0rPxyzqgxLeFrhP/6tHP4sDzgitUfTXqM
	TM9UrSjFajY4nnOz7zulDylYTcZGdwtaOnNLg49mCOAk7TIb4B7GGuQo18Yuw0TcAC0WXwm81ga
	C8GSKg5diAfUIjKwzAkppUOBmm5sqhPbFZR2sSTa6LUz00oS7rRnH+vWNCK2olhkLJZ7QB9MgNy
	7qwROy8xG7lC2Jfe+BETbAG6Ei82PTnijiCli36iT38L+FOoxAcke0NL8OfiajahAHU3naLu2oi
	3SRW/k201a0m32V2Qph36aGL9jLCVlNciI/UqtgwKG6bQqzFhssPEY6NdbVXUSb8glIylKqbRkO
	pLuVk4=
X-Google-Smtp-Source: AGHT+IHo9I9Fk9J7EfbZPYzp4biIOwD0f9C5lF4+D62mt88Ls9cqlfkLeHaFM370A0Q1KAovvswUQQ==
X-Received: by 2002:a05:690e:1917:b0:63e:b48:69c1 with SMTP id 956f58d0204a3-63e0b486a66mr598888d50.46.1760563537487;
        Wed, 15 Oct 2025 14:25:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-63e08e44adasm343016d50.5.2025.10.15.14.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:25:37 -0700 (PDT)
Date: Wed, 15 Oct 2025 17:25:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 43/49] repack: extract `write_pack_opts_is_local()`
Message-ID: <aPARUDOXqsX/niCs@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <1fbe3d0d7f37840b2d9faf6f62e94abd6a664ded.1759097191.git.me@ttaylorr.com>
 <20251015103516.GE2250228@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251015103516.GE2250228@coredump.intra.peff.net>

On Wed, Oct 15, 2025 at 06:35:16AM -0400, Jeff King wrote:
> On Sun, Sep 28, 2025 at 06:10:08PM -0400, Taylor Blau wrote:
>
> > Similar to the previous commit, the functions `write_cruft_pack()` and
> > `write_filtered_pack()` both compute a "local" variable via the exact
> > same mechanism:
> >
> >     const char *scratch;
> >     int local = skip_prefix(opts->destination, opts->packdir, &scratch);
> >
> > Not only does this cause us to repeat the same pair of lines, it also
> > introduces an unnecessary "scratch" variable that is common between both
> > functions.
>
> Hmm. If we are not looking at "scratch", then does that mean
> skip_prefix() is the wrong function to use? I.e., should this just be:
>
>   int local = starts_with(opts->destinations, opts->packdir);
>
> ?
>
> It may still be worth pulling into a separate function to encapsulate
> the policy logic, but that function could be using starts_with() itself.

When responding to Patrick's message on this patch I was inclined to not
make any more changes in this patch than strictly necessary. But having
two suggestions which are both easy to make, and (more importantly) easy
to verify the correctness of pushed me to go ahead and make both
changes.

Thanks,
Taylor
