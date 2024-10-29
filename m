Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CEB196D9D
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730225248; cv=none; b=WSi0ELWp1C4tNNh9kf9NxZX/TjnRDw+/HKK+/kQYVX8aUmBCwTYsGe9tyMuUfmdht53bGfI2XuG/bTa7X1W8nh5YuPNwwfkQZp13TxwCrOAn7uoTKOyXJgsE+pk9TqsAEaS6N1Yhqzj8NaOVPlt3R9rORQepTSKbsYUujIqAMuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730225248; c=relaxed/simple;
	bh=xA4JK/xK1Xh0vgENt2EDDOZiP1lsNB/U0hPDLO0NP6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/bj8e43LQtTRQsx/zjxCKJannBlMm3fzvpkZnhZFz2eWmsfYPyXEG2Mevc5wqt8B1lZDNEz4mxO73I5p495Z2pit9e6UIx2233xVdFnyLWkAt5Ymboz6zM5ubUvKOSz5URrWXmj3YbVDiGo5Q2fFyW2fEzIu9lQiSHQOM1j/74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=09yE9fkW; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="09yE9fkW"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e29327636f3so6112826276.2
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 11:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730225245; x=1730830045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wC2hRX+lCZNdSc4W2QLlCgfxrG7Y+p7cYluSgmnzvYw=;
        b=09yE9fkWjO+t8TDQxTb9krD3LOsErakf8W+CgvEJ+MNX5o69wDWIFu3I8WmFa2nfo6
         89j3DbwL2u4+Ou+v+gL6DNuzb0fwlDNmy+Fn8dIlt5+KxlrYtzAdY7RGD/WBIp47vwfJ
         8utqob0W91XjzSidsRjfu7rrH9gOaQEQwBZOwbd55+MfO6ctDmUyPyySntKaS+6eh1aC
         vp7qm++EZNgoPioicjbmPUApPQ+o53woB0YuvDolv+804DXbRr96tUfgr6smq+PR7zx1
         6jz4Zooa5RRxq9PYhjojHKx7zCS4o5KdHQE8Wefvj/O1cwGH7imzfoISEvTbCt8cAj3q
         CkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730225245; x=1730830045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wC2hRX+lCZNdSc4W2QLlCgfxrG7Y+p7cYluSgmnzvYw=;
        b=MBl8Bc2OIa4uLBoebps8mZBVW6T9LZhGLQsjqiPlTeXHcNWvUhgJJ5qsqYcRtSPqPl
         XLlf0h/6jy8vN3opc1pEF20eWebnyG8FwhQmgExJR1oG13tIRmHzShl3z3RWgHiAYpkb
         eyX7P7kBinlaCD70SNsLnupOgKwV04v0RZPmv3Lg7wU9UdJWgVvIvjqva6ukWso0k5z2
         nx5frNJ06mYu54RrDnBchqfyZNidoK+IB9l0rbRNhnQ5HyxEqUxRa4q/mLBYkFaF9Gdz
         ElfJNDy+HEIJaYlu6XMD3zEHYrQLiyLJsIBBJV3fE8mLwlC2UYUX3tJLoVxW9qyTRuBX
         4dpg==
X-Forwarded-Encrypted: i=1; AJvYcCUmFOCzK9MyVGEkMANTysR3T63KLqgh0totmPCeEDmxeSeinBuTRHOWKaHVK83MmLqXVXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB+17OO/n5jXkLlQepzFiFetxuHCySRL46x/k+YuHfG+nPmrBO
	2wL0mZCJLYPCacMuVQz1LJZnBnrG4+v63sUepKWe2m5PkYeanT4U9rTbWee6p4I=
X-Google-Smtp-Source: AGHT+IHRSTiouAvn75IpnoMsCAMCJsP5ECbRCJ/s6EGRo08nZnJt0jAu9pPL6wj4uZdWJOTis0/ZaQ==
X-Received: by 2002:a05:6902:1008:b0:e28:f0e5:380b with SMTP id 3f1490d57ef6-e3087a4ca34mr11442755276.4.1730225245447;
        Tue, 29 Oct 2024 11:07:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e3079d52296sm1878020276.11.2024.10.29.11.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 11:07:24 -0700 (PDT)
Date: Tue, 29 Oct 2024 14:07:23 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 08/17] pack-objects: add --path-walk option
Message-ID: <ZyEkWyB/C/lGb36b@nand.local>
References: <f8ee11d3003e743affb39835ba3583dd2498e576.1728396724.git.gitgitgadget@gmail.com>
 <20241028195404.4119175-1-jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241028195404.4119175-1-jonathantanmy@google.com>

On Mon, Oct 28, 2024 at 12:54:04PM -0700, Jonathan Tan wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > This new walk is incompatible with some features and is ignored by
> > others:
> >
> >  * Object filters are not currently integrated with the path-walk API,
> >    such as sparse-checkout or tree depth. A blobless packfile could be
> >    integrated easily, but that is deferred for later.
> >
> >  * Server-focused features such as delta islands, shallow packs, and
> >    using a bitmap index are incompatible with the path-walk API.
> >
> >  * The path walk API is only compatible with the --revs option, not
> >    taking object lists or pack lists over stdin. These alternative ways
> >    to specify the objects currently ignores the --path-walk option
> >    without even a warning.
>
> It might be better to declare --path-walk as "internal use only" and
> only supporting what send-pack.c (used by "git push") and "git repack"
> needs. (From this list, it seems that there is a lot of incompatibility,
> some of which can happen without a warning to the user, so it sounds
> better to be up-front and say that we only support what send-pack.c
> needs. This also makes reviewing easier, as we don't have to think about
> the possible interactions with every other rev-list feature - only what
> is used by send-pack.c.)

Is the thinking there that we care mostly about 'git push' and 'git
repack' on the client-side?

I don't think it's unreasonable necessarily, but I would add that
client-side users definitely do use bitmaps (though not delta islands),
either when working in a bare repository (where bitmaps are the default)
or when using 'git gc' (and/or through 'git maintenance') when
'repack.writeBitmaps' is enabled.

So I think the approach here would be to limit it to some cases of
client side behavior, but we should keep in mind that it will not cover
all cases.

My feeling is that it would be nice to pull on the incompatibility
string a little more and see if we can't make the two work together
without too much effort.

Thanks,
Taylor
