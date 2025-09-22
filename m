Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ADB2E2847
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758569660; cv=none; b=GOsmzGjIrRHB369jTAC9qB+Ph9E8Xh0mITV3fXXTPMNBZyJZyal0rd/p9yninvBuyUP0bVgPd3HLGxeiKCIc9tRK9Pqv9+sKvflUtGq6azqBKNkD2bS56dCdlrFSKwhDyI4BN6iuls0Ps5BTYPgEYNTwPgtFbuJvl3Uoi8KX4xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758569660; c=relaxed/simple;
	bh=PW2gMztpS8JzGRvGTyQaw2gaFmkEBDfr64xUGDW5VdU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCi/FysH1gpDktGVV4wcK2KTNL0mnaDeC5SM0QFBieRgW5gZ2mzCB23M0eN7++Br2ZRl2MAwkNh3HVER4LbPoWBNU6IvC4iBkn/rFIL11NRuM97n2Saiznv22U8zdJHIEP25F9m6V4o8rY2UX2A8QGW9YpRR8VS80ZH657MNLbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9SbkBcX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9SbkBcX"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46cbdf513d7so16782845e9.2
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 12:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758569657; x=1759174457; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHBp3yioTXfT4ICKdIqCJ4uLrUndIsGPmcSZJnvVKQ8=;
        b=e9SbkBcXOHmQGTTRgLBG07PAiYn/BLW31UET4gtjVpKuzjHvyYBxY3KCz9DRsZuXKZ
         1tGjgoLIgN2/S2qvRO3MKcgyR50XTlIrXo56PIIYWFcX0gAhmxxqMZBqK7HbC775uH95
         hFCP8F1ZT0ROIhvVtUeRHjWoQwkmGPfy0NukbcBqCdQvkMoulrWKAUmppM12/O925OhX
         X5qHZ96rfwbnhU0YAxa/FesKL2B9l/+JqPmLqBAAQDh3BxtVymA6jg163ahulsOKXYvA
         8lDY6O4YxqzSje7kGhOX56X5ZjX+NZiwskFdXugyQl96gsCvgA7/I7X/xttHbVqUtMqu
         NB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758569657; x=1759174457;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YHBp3yioTXfT4ICKdIqCJ4uLrUndIsGPmcSZJnvVKQ8=;
        b=Sz3yVHq3ac9NcZgocj/RfsoIX5bbsqJqzngt2Soqr+VL1VVqtBJ43sE0sbtKDtCg8B
         WFdr5Mm1YzJ4ms/LhlhNUyps8f3fA/jNFFO8DD6ID/jJx5eFeTO28A/QCKUTGykzmKak
         EDKrCwZ4LV0pRc7F6gCqMARtr/+ICTGiMpPZuAkJvC+sjv3ulxCAMp1CZE/s3FDJId74
         m4luNEN69Ns1BGZHdg2k4MQtlAeXNt51MiKYOAhGqoDchMQjbLBaiBi4CHBaJjhHFj4S
         a4USxdNfoy2gIb014sENJLe0bG7lGrolanWxRI1S4vbsIbWV93aw0yD31bytRbJQ7agW
         Q05Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIeQKxCoz/SeogiUm5OWbWgc4nowhEWjCLA4l8PwjtSL5zXVTNqdda5Pr88BhOj7Kjock=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrAa7YN1rtcHN6tsu90h5tgJ6NnhPMe0EK52sm0b71W98JrtiD
	KF16QWr6Qd+t42cNnE740h3sxNEzdUTPAsiUUMcuJsseGeItaoDYF1Ly
X-Gm-Gg: ASbGncsgxqu1zyydInRg02w1xehaOkGsVqNwA2HOJzsqEOrLuz3lvWp9Qni9MuSXIV9
	4ywyKF11Cco29mpmBQ31RMmRCP13yb6/LZ3tjoe+KpKUp84AY94xjQ2eFMPrwnhcTDTAocgkp+r
	t+ohxDDXTTdJUs2e6iWG+Ds/njilp6zlmK6YPccerznNWixeSezrU0M34XtrQ2zaGRJB4RLxpol
	Y8p56q9Ywc1tBfD+rUfC5Z9AMrvQnctzQ52+Xsx4s6BcqiAinxTuM8MZxsYpWzAArnSw8o0lwiD
	oa1RQBllPuHLOh2/Kvhz+h2+817vcwdE3NWGh581H8+goCF/VfyKo7HkTf2N63uQ0DV+juwRQzD
	/h7ZSkbAXzwZm2ztFUNfyDRbE2ypgUDdiA/+f3d67gETjGN6tPa5B3tA=
X-Google-Smtp-Source: AGHT+IFZNkG2ttfMIvNauKBrIyuhjBOnY8ebcn5PUHT21k/rxVh1COQljr9leUbeoTvYF1k7s2wNww==
X-Received: by 2002:a05:6000:230e:b0:3ed:e1d8:bd6f with SMTP id ffacd0b85a97d-3ee86b84781mr11121927f8f.60.1758569656895;
        Mon, 22 Sep 2025 12:34:16 -0700 (PDT)
Received: from localhost (84-236-109-231.pool.digikabel.hu. [84.236.109.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-461383b7b9csm256523765e9.2.2025.09.22.12.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 12:34:16 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:34:15 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v5 7/9] BreakingChanges: announce Rust becoming mandatory
Message-ID: <aNGkt/DdnbjNu3s8@szeder.dev>
References: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
 <20250915-b4-pks-rust-breaking-change-v5-7-dc3a32fbb216@pks.im>
 <aMsxhp6ZO2Cdz7+k@szeder.dev>
 <aMteF4VTq2C5sAhK@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMteF4VTq2C5sAhK@fruit.crustytoothpaste.net>

On Thu, Sep 18, 2025 at 01:19:19AM +0000, brian m. carlson wrote:
> On 2025-09-17 at 22:09:10, SZEDER Gábor wrote:
> > Providing an LTS release for those platforms that can't jump on the
> > Rust bandwagon is great, but...
> > 
> > Git 3.0 will switch the default hash algorithm for newly initialized
> > repositories to SHA-256, which, presumably, will also encourage SHA-1
> > -> SHA-256 migrations in existing repositories.  Alas, it appears that
> > the SHA-1/SHA-256 interop feature will only be available in Rust.
> > 
> > How will this affect those platforms without Rust?  What will and
> > won't work on such platforms?
> 
> On Git 3.0, nothing will work without Rust because it will be mandatory.

Well, "What will and won't work with respect to hash transition" was
what I meant but, alas, didn't convey.

> However, people who want to perform the conversion can do that by
> booting a Linux VM[0] and converting the repository there, then pushing
> it somewhere.  The only inconvenience is that you'll have to have a flag
> day for working with the repository on older Git: you won't be able to
> dynamically pull from or push to a repository with a different main
> algorithm than you.
> 
> One of my first patches is that setting extensions.compatObjectFormat
> without Rust will simply die and say that's not supported.  If that
> config value is unset, then Git up to 3.0 will simply function as
> normal, so full single-hash compatibility is assured.  We already have
> that: SHA-256 repositories work just fine with SHA-256 remotes and SHA-1
> repositories work just fine with SHA-1 remotes, but they're currently
> not interoperable.

Thanks for the explanation.  I think this would indeed be a worthwhile
addition to the commit message, or perhaps even to the BreakingChanges
document.

> > I think it should be called out explicitly in the justification that
> > whatever limitations this imposes on those platforms with respect to
> > hash function transition, the project has duly considered that and is
> > OK with it.
> 
> I am fine with this and I don't think this is a problem.

Not sure I can agree with that, though.


> I realize the decision to incorporate Rust was made recently,

Indeed it was.

