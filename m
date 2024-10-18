Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8997E18D63A
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 21:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729285389; cv=none; b=LykUHUgt/Xwkr3EnWhN3v+GWR/qDlWZrVZCAVXvVrFlFCiXQRcSq7ivtpzlWPBYA98JPilj9QmuyIEqOftKKnvCi80/Bj6wYwY+ndaBtGnN4AOUnhycQDaVohOs+K5Brd2Hsm9B4rYrnkwdtxljV0ycqefLKLTHfswE/3zMsWBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729285389; c=relaxed/simple;
	bh=OTvfUHdtYjgR7//39oSafehnLYOXaasSEDxb7gvT5Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6BgIg2uasc2o2PBIjGS9LWa+a8skrg/2kg0Lq8i2kLBmXoFzH0JUgT1GTjcHWc0h3G15jnLCUk8IVzXozYM2ZMx6B4u0ohmSEN3RnbM245wRIU3rjkDRo2Ju2kYflaaSGQldShbN7E3fUWXUWgAk36be7Xc1ycKsd2c7ywrodE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=eZ13BeRn; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="eZ13BeRn"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e38ebcc0abso30332537b3.2
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 14:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729285386; x=1729890186; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KGS5uaZ2WNHuDGT8xCB5MvQnnTi31YR2aLWr9l5k20Q=;
        b=eZ13BeRnqRtb9SYMIscIZUCGUzwPbULRcJ8zVPGmH/38Y2fIPOO3XaGTGkEcX+4NfR
         u8lP8fuL0R3DQf9od4SJ52F22Jb7o95FBUb6JgyWxt1TBOGqKzr/5WQr8x8biZQVEjph
         va0WVBvz/WXA6UGSHt3BTpH2r3vjruevwlVTH9GPYqZckwrPEyqkb/OIcTiP3NkytukI
         i6ZX7yK/PU3xhdmk1jkbR5cElTBwBWPxg9LFosRBX6XqZmX7DNgSf7LPswkzKQby+9F6
         WJF6bfxqVknzouGvpA/gB7vhjstSLd7/mFPeuxNuJZ4puDJC60NvcrgrlmbTi9pIJjo9
         z5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729285386; x=1729890186;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGS5uaZ2WNHuDGT8xCB5MvQnnTi31YR2aLWr9l5k20Q=;
        b=ErvQi/lfbcK0VyzBSM1iIJCjG+Cz+CGvInRJeIf74N6THHRIQDvsrCCiFN133wYKTT
         aHOF0i5zSGWP3Ie5JLSuEDhJ8vpo5i+DTZIEqORKcYwASEgcJWe2fFBsFtMVY57pR07w
         Lm35Q8Ahlc8WSt81QQjUhVpG3iSVeyEz/c7nd0/bm8gN1jZhSQtUDuB1qOL9YGMsG2an
         gifv/irHcLO4AFbeHpndax7SGWt57sx6bcPb8jNlWrv/3zzr2tajdrSfAqIxg86J/5aK
         SC8BBgYuqRcyVqnC3IUTyfKs0I4OtlajXVYkJ55t0HpHu5FXF+vPwA4SZtz+bH5m7A84
         0aow==
X-Forwarded-Encrypted: i=1; AJvYcCVTc2kR24sN/VlR4UGwnrxrShZbl4rtW/432ruTbQgcaxrmfZWeW9Kt/W8yn90Tpz/pakQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPqFk+3YNSj4Ic+zffKRHI76tqLaWytM0yRXf1H80mjqf8j29s
	3LmqZJFUlaCM4qK6asLXZey3YfzcnMAXaSeiaMT4GpnopFsEGHHPb494cilD/blqzj7c8E936gC
	k
X-Google-Smtp-Source: AGHT+IHu4kHeTr1qwBeMN7l+lddaOahAEovA9UyOPAYqu4yFPGmDYz6kpvpJVjb2A57ow/otazM5gw==
X-Received: by 2002:a05:690c:4a06:b0:6e3:a7b:49b3 with SMTP id 00721157ae682-6e5bfc611e0mr42940997b3.41.1729285386422;
        Fri, 18 Oct 2024 14:03:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5c02a9844sm4648827b3.136.2024.10.18.14.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 14:03:05 -0700 (PDT)
Date: Fri, 18 Oct 2024 17:03:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Seyi Kuforiji <kuforiji98@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [[PATCH][Outreachy]] t7011-skip-worktree-reading.sh: ensure no
 whitespace after redirect operators
Message-ID: <ZxLNBxcnTf8nsT1H@nand.local>
References: <20241018191744.209746-1-kuforiji98@gmail.com>
 <b005084c-2710-4567-9217-27f34c2bbc95@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b005084c-2710-4567-9217-27f34c2bbc95@app.fastmail.com>

On Fri, Oct 18, 2024 at 10:04:43PM +0200, Kristoffer Haugsbakk wrote:
> Hiya
>
> > [[PATCH][Outreachy]]
>
> Apparently you can’t nest brackets like this according to git-am(1).  I
> got this:
>
>     ] t7011-skip-worktree-reading.sh: ensure no whitespace after redirect operators
>
> Doesn’t really matter though.  I suspect `[PATCH Outreachy]` would work.

Indeed. With format-patch, you can do '--rfc=-Outreachy' to achieve the
desired effect.

> The diff here is clean.  It only does what you describe in the commit
> message.  Good.
>
> I checked the file and I can’t find any missed instances.  Nice!

Thanks for the helpful review and feedback for Seyi's patch.

Seyi: I'll queue this into my tree, but mark it as expecting a new
version to address Kristoffer's comments above. Thanks.

Thanks,
Taylor
