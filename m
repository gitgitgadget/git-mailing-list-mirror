Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82641AA3CC
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722462592; cv=none; b=KmSqoDVVyhUYO/lWlWNFYZOq+lj5rbg0R4+dmLwbbLtwxJHckHOPE4c6g8sYrZjholxBpI2gbWfBUVW98/SxNO1gESNnsKw6GO5TtpcremilsShslvYFhxh2MJyNDULgBb5T6bsh130/u1ihZK91qoMmQ+x58aGpZzEwH0NHxVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722462592; c=relaxed/simple;
	bh=3iIavGiQQ/Gr3D3kh0wI9SluK3hdGtfWmjR71idI64M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrukUyMc2sqOzerv5ZqwlaR583QIqrISDcUJRwsq2gUP71xra6/aC7uNRMiCUC1qtrdElfxbVjYOGc9Jv8qfmCq0Dsf8NRyCiEoQA/fM9Ds22N0FfFu+9PWM+rCBU4HVkZ/akQtR8m/8+DcSaxEYPfRzJhKGaQ6hsgdXf7ud40g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=orCz2OPi; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="orCz2OPi"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1dac7f0b7so392984185a.0
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 14:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722462590; x=1723067390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TWK9WFjLXPIIwWqsgVC6lxCwqrIEQPzjhJbtJsU6fYk=;
        b=orCz2OPiYewCtvVTe9yd8WbQrEZfCzUYvOzCw6dGDlu+9l948PqTLw0wqxxMbqrUAA
         7GSNUjxRfBWncoQpQ39eoYmOYxCR0pvFBSI/golyxXUJ2e7dNJ09mm6UlQshpsB2ZwsM
         6YtakurlhAknshh0Evs3QlHh8T4x4TgAt5IRfrxd9wPhqp+gIIJAKZU/MzFq1JpaL0lB
         oQ9TBmrM6j1f3t2r6iExHHo7xua6L7HIYtkYpRYrxz2Oq3dWFnyI/cc3UQNxFT0DsC8C
         D/zgnclGUp0K+l8gdS8mYoUkxpKnxdwpEzhd/X/NjOD3rDo5MYQj1gfTK5fSaE/kpwl4
         +xVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722462590; x=1723067390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWK9WFjLXPIIwWqsgVC6lxCwqrIEQPzjhJbtJsU6fYk=;
        b=qXm97pzfqxZnaf3YuqQXdXzH+3+eZyUQpyS0j+Ezn6UWEiVoh71iUDFZ17Nfbcy5lz
         N+oChaJljK37gaDn0gxmfFe4HAhd9HnhZGRp9RCZxa020rPpaqOWgP2e5yeNuO1xeg6c
         797qsXAds/YVvOjgp4vlpgJy6hZZcR42EvN15ZjP36AkF3irmZy8EB1Mj6OrY/aoysRX
         e/6gWjnKXPA5S6nn8tRofhqeGM+R2hDz9vafdhZVLJHyMRiK5ttqwMHLdOvRFhRYT7r4
         2TdoUbBOhIYMYu+I5IYzfdPR/qPbdEsmTRlGOpw4X8WjMbjraCUAJcfTcgjYpfcBgVo+
         K1fA==
X-Forwarded-Encrypted: i=1; AJvYcCW42wegtSxm4oUIXP8e0U/R/YrtzYiMPCdXpV+nR1zwSUKVkJOoqKheW5RYeq88ZVwSBUMhnQgPiM6vO+zJ1B8tkVcd
X-Gm-Message-State: AOJu0YxkHb3kMlxf9UxaYBlvn8J2bsbCzCMIsxrUFBu9sO63ve8YJwgD
	avhxG1hWRfXNS99XIu7+r0CJ9Bb/XEPY3WLWbdrUdcuxHiXimZ5O8yS02C5QtvQ=
X-Google-Smtp-Source: AGHT+IE7HNl/slFjZuI0n0DidKySFeqTtFp2ROr6cbhizGhvTADABlQBKkB0cM90VMWQFWJRm5+YRA==
X-Received: by 2002:a05:620a:2491:b0:79e:f9c8:a22a with SMTP id af79cd13be357-7a30c637b59mr57741185a.12.1722462589607;
        Wed, 31 Jul 2024 14:49:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a20ea4db1esm73087185a.104.2024.07.31.14.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 14:49:49 -0700 (PDT)
Date: Wed, 31 Jul 2024 17:49:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	John Cai <johncai86@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/4] strbuf: refactor strbuf_trim_trailing_ch()
Message-ID: <Zqqxe5p79kt9yc2n@nand.local>
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240731134014.2299361-3-christian.couder@gmail.com>
 <xmqqle1h5v37.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqle1h5v37.fsf@gitster.g>

On Wed, Jul 31, 2024 at 10:29:00AM -0700, Junio C Hamano wrote:
> > Let's introduce a new strbuf_trim_trailing_ch() function that can be
> > used to remove any trailing character, and let's refactor existing code
> > that manually removed trailing characters using this new function.
>
> It is disappointing that this new one is not adequate to rewrite any
> of the existing strbuf_trim* functions in terms of it, but that's
> probably OK.

I don't think it's possible without some awkwardness. strbuf_[lr]trim()
both trim characters for which isspace(c) is true, and this new function
only trims a single character (also from the right-hand side of the
string, so strbuf_ltrim() would not be a candidate[^1]).

Likewise for strbuf_trim_trailing_dir_sep(), which uses the
platform-dependent is_dir_sep(). strbuf_trim_trailing_newline() is also
complicated because it only removes '\n' or '\r\n' from the end of a
buffer, but not a lone '\r' character.

Thanks,
Taylor

[^1]: Unless you had a function to swap the order of the underlying
  buffer, then call the trim function on the right-hand side, before
  swapping it back. But that's obviously disgusting and clearly a bad
  idea.
