Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445EF59157
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 22:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711231248; cv=none; b=Hyn0zPxJCdqVqWcNPK58rei083qAF5ecrcCQIXIaJob45gzA0HR7MXgIIbszT4anAY3ALdeo2PCuYT2K08NStQzngn+7zKx0t6cEEcrlRMci3FFVo7NrPQsbpPMu4vZhUlLaKruu8aXsPTkQzs5bW5mFRIsgW1Uy7FmLw64FqF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711231248; c=relaxed/simple;
	bh=nD2pu2pu/HebiZaRT9Sr7Cqr3/MzGpY9WeDcFroJN5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSzhsaBJDMfVudTgLEtjQImIeJavclvpwNTMcPsnoPt10C1LGi2glxE9ioajTLf/bVQZP66ZrWxEr73HMUSD5Rf0M/iBdpaPuoj27UhOQK6AugUQ6/mevPtvoUn6nsf5WOqF/8xsxQD1ySc01VtisBEnUIfJf7m7Z0/CQCpqHIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UqGf211t; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UqGf211t"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so1523924a12.3
        for <git@vger.kernel.org>; Sat, 23 Mar 2024 15:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711231246; x=1711836046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LVTgveyX1/w4Ix4ZJcZZ2DiUAqtjRyTtEKmiQmvGpz4=;
        b=UqGf211tZx9sKiqqNX0WHsofaQeMZ9SyfP9JrkRW/48tlW+DJKXEeb3vV0AqsKM53M
         TePgJxVVZlMIHHgYl/QGvHM5/UcU+Bg76OCOmUvAZRx6MesyLLoNSWWljlNGNsSdClBM
         ZvMK6XdblA7JWy6kqhd+epsPySw+3K9S7j0gmc3ZnonArjjAKpshY61llLqWqePPnChy
         obSWmrK0q56Qo2ZaASoRqIu1s91kZ6O8EBdD7r4yUPl9nXbXWdB4NVXOR95bsLbJE6S+
         EdRJd9A+LNat3r1CyEX23eaiUhXmnESIvyjOmxmwFcUJztDOTB5T+QvX/97nxyvZB9BV
         ydOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711231246; x=1711836046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVTgveyX1/w4Ix4ZJcZZ2DiUAqtjRyTtEKmiQmvGpz4=;
        b=qkVogkrcfxNedLEYpXQ5OWfyktJ3Rq/KhfNZCSCUSjnfyC1DkgTFSwx0lGVgKirpuk
         gKuBRs5kXSMML3jnvf7+vYqL7ZKukv8WSpAIPIrjMi+5+GHkfOxA5pLngGkJhZif1tZa
         rBnGJAxaJSF8Pvf8EH6G3nc9K+MPEvoUJn8gchSoEYbb4IPd7NWBWANWv1Euxwhz6Qrh
         fV6BQLtEqofhRnZKwT5Ho3hjIs+TH9+MRXP7DFXLU+nJqsYiv575/4DbcJUp3EXi6mTv
         5Dd7dIv10QUqOc8U5Iu36xqZNgiiotay4kADS9vo3PvE0QU6IHhp+dLQNsSPi2dcJhcs
         wfGw==
X-Gm-Message-State: AOJu0Yw71TgTHv5wats5iB4/2hQH8/EyU8lu3X7GRWQfgxTs7MVgx1Yk
	PPhNT9cfOdJIZJEdWVb0jEV7Dfk7iytggtcrUefnEye9RicOSABiqcARKSqqUaABxSRmovn9717
	E4w==
X-Google-Smtp-Source: AGHT+IHIZHq2YfA0/Z0O7Koni/Dpjs3ILR5gTpSo4crKMErYH55AvqIDJGSxuWWbkjcsO+Hysev+Jg==
X-Received: by 2002:a05:6a20:3d17:b0:1a3:ad92:e7b7 with SMTP id y23-20020a056a203d1700b001a3ad92e7b7mr3725197pzi.9.1711231246313;
        Sat, 23 Mar 2024 15:00:46 -0700 (PDT)
Received: from google.com (144.44.83.34.bc.googleusercontent.com. [34.83.44.144])
        by smtp.gmail.com with ESMTPSA id j10-20020a170902f24a00b001e02cd75dd2sm2017906plc.237.2024.03.23.15.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 15:00:45 -0700 (PDT)
Date: Sat, 23 Mar 2024 15:00:42 -0700
From: Kyle Lippincott <spectral@google.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 0/5] Fixes for Documentation/MyFirstObjectWalk.txt
Message-ID: <p5fii3tmfb6l7dgc2p35euwv4cp6ag64qqhb63wfu75iphqknu@tdo5ru6modr3>
References: <cover.1710192973.git.dirk@gouders.net>
 <cover.1710840596.git.dirk@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710840596.git.dirk@gouders.net>

On Tue, Mar 19, 2024 at 12:23:10PM +0100, Dirk Gouders wrote:
> The second spin for this series.
> ---
> Changes since v1:
> * Added Emily to Cc in the hope for a review
> * Remove superfluous tags from [1/5] and [3/5]
> * Replace bashism `|&` by `2>&1 |` in [5/5]
> ---
> Dirk Gouders (5):
>   MyFirstObjectWalk: use additional arg in config_fn_t
>   MyFirstObjectWalk: fix misspelled "builtins/"
>   MyFirstObjectWalk: fix filtered object walk
>   MyFirstObjectWalk: fix description for counting omitted objects
>   MyFirstObjectWalk: add stderr to pipe processing
> 
>  Documentation/MyFirstObjectWalk.txt | 36 ++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 16 deletions(-)

Aside from the small comments on 4 and 5, series looks good to me, thanks for
working on this.
