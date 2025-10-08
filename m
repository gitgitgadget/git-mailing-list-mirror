Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5EF2652B4
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 21:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759959014; cv=none; b=fxVVhe6O500bMGu2gGkxgs1mSU+4XNdqomZJoYHl1KMxgnL5vxr0pALOSsZsaMeHrtNlpljyFpkS303QyV7B2tpUqHsF5DD57GCT1v+o+nN1QmqW5yQalON6qiq3QsKUpR+8VXS//j4kJB3bQydG/P0dgMPNQQAf1/c4gWJDNVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759959014; c=relaxed/simple;
	bh=IhwYjpJhZsjJHIw77ed1TkmzbUhD2c3qyNcCqWbuYLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBotKXJiIE551i+eS2rBbZ6CJb5524qjqivyiaRA/dhfKwqLp0KNzWn4gqdE35XfU7Y5Jq9DvMtjZSus4WwM2Tz8rbHn++Z4cX/2zTEfkco0IDRLLu3IFT3plzPyC9RdQn9WMETLQkMXmoLuYoBwYnEv93t/IdHZk57DMWjzyDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=WXkG+Z8T; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="WXkG+Z8T"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-887764c2868so26672739f.1
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 14:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759959011; x=1760563811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qDtdk3KM5RFYe1gPiB/VZ6TvJihBOc8r4g9PHebQ6n4=;
        b=WXkG+Z8TcefP3gEAnov/scKsVaACY0bivD5ymFq1aHAzs7tfp4bx4kecgBeHd47WPR
         IKZHfYMViDVg49AAgb0fuAI6DcjfdDqozpNQFPsTDCxYa6ktsIfFyjz0h51VdWjHDobu
         Pm471ZzRJJ/i6Prpjvt+SB0/xnc9UONPndC5p04S6hXN8sGBhGhCtJAbjRUJl6ws2epI
         R6+tiEda8lXfYBv+zTLMuzY1Llm6UEAt/kESLGhuKlXIYodk7NY2nNYvbSqOfi7YQCpZ
         fJkhUnkIABtU0Xf9DA0pWeiCx7KMKIUN51E61/RT8l7Pl4oO9KrH3G+aMgRCu6WM/AgO
         6nYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759959011; x=1760563811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDtdk3KM5RFYe1gPiB/VZ6TvJihBOc8r4g9PHebQ6n4=;
        b=lc4oRsIfxkZN87AsfoW47m6iVekpNIZc8IiJ4663SDwzldzFYcwuR1+JnVGnquXhYk
         x1rKhm6BlMZNF/izE+IJRTyFSD1kJEhNoQTVtnadM0u9RBfFjAf9e0r4RS9067PnDGoj
         QXWm1CYET50TR8iZwwrPQaDCMyjhSt9+D96KEIBOj14SLyVTIFnMuHgXxnnEjeymAJ5W
         qptY95Pivy7JMsZRCn3ZjQUjHUyKxn3oGR9U6JJ4PlcFeGBOjvUU/yrUbodWtonZSoVd
         JBjMSpKQSvhZjIBk7ybpLe4SJOcHzS4HzVGoj8ZuPS9l0xQ0Wv3syBLoezvL1K4kfzfW
         Dx3g==
X-Gm-Message-State: AOJu0Yyu5eFrLpdfxeC3RcY1O08hCvQU38AchJy4Qt9qtw3SJ7Qjbp/h
	o+peRvDVKpm/QqjGhvYqrzzRbIs98oI/gDdU5pBMSRhHQSsoMFoaXWHt2ZNMSyd3bATewda0z4x
	+0YqfttoVEA==
X-Gm-Gg: ASbGncvD7eQ53b4BF+zG8JdltkyHxmDe8gzXUH6HM55hkXXjp0zVEdr0lcQsD1i0Yia
	abFxb+/nsJJ0ivab3/3jwaEKqGuqL9iyO3uQfNQ0XeVqrpN5JyK62yL9Q4qDxK/PHqFCeQb/ydZ
	eJdfFLyHogeD/La9cgd1JcoWDtEPYBa9FzDnRr8xWOX6XMpcTWwg/0Wt1wXsuRJc5v7cfHXLuHB
	mo9qfu1wPNnzcosOq6LLIZqXYadzpJZXIStucGPTpwYGFQuJ1+UnbeHgxnnbDRmxlDsy+fLrJ3T
	4WTaOmX5v3/hFCCq3pZ8bXnofZDfnSdoXb/51C6/i2xL91C7v5nI6M5+m8Ta+fJaCkqdB8Yv/z9
	JHoLq1dSSTJwleedphI7wF3D3Ij+kTP5pwrTDLBsQIpMF9t2tMx76T8N4Tdz8tTtFL3vNv+//J8
	9zcqdLZPy0DuG6MfoF3qrXKTFKn3YjXWTA2M90ejiDC/z0rrsYUSBWHQ2afuW9
X-Google-Smtp-Source: AGHT+IHccqyx18Pl3CkMDoyPfNAJHzKDWXqxlwUoZXJoUqK+jofGtvdUCpaImPvfFlKj2rS8kpjYYQ==
X-Received: by 2002:a05:6e02:1fca:b0:425:8d9b:c430 with SMTP id e9e14a558f8ab-42f873559d4mr50435975ab.6.1759959010589;
        Wed, 08 Oct 2025 14:30:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-42f903888c1sm3133355ab.36.2025.10.08.14.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 14:30:10 -0700 (PDT)
Date: Wed, 8 Oct 2025 17:30:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Michael Lohmann <git@lohmann.sh>
Cc: git@vger.kernel.org
Subject: Re: [RCF] Secure git against involuntary arb. code execution without
 feature loss
Message-ID: <aObX4C7lMHRnjbYq@nand.local>
References: <72F10412-8B0F-4F66-8674-FE194D016DF9@lohmann.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <72F10412-8B0F-4F66-8674-FE194D016DF9@lohmann.sh>

On Wed, Oct 08, 2025 at 11:02:03PM +0200, Michael Lohmann wrote:
> * Proposed solution (keeping all existing features):
> - On first use, git generates a secret "token" (e.g. a random string in
>   ~/.gitsecret)
> - On calling `git init` or `git clone`, the secret is copied into the
>   new .git directory and serves as proof that this clone was created by
>   this user

Sure, but the problem is not with direct clones (at least, not using the
--local optimization), but with clones that recursively clone other
submodules.

If I clone a repository with --recurse-submodules, I imagine that this
proposal would *not* suggest copying this token into the recursively
cloned submodules, right?
proposal improves the experience

> - Editors would no longer need to prompt the user for "Do you trust this
>   repository?" in most cases, because git could prove the clone is user
>   generated.

If the above is true (that Git would not copy the token into recursively
cloned submodules), then I admit to struggling a bit to see how this
proposal would remove the need to consult the user in this case. Instead
of the editor doing it, the user would need to do it themselves?

Thanks,
Taylor
