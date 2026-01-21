Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9121A3B52F9
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 23:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769039759; cv=none; b=ThhGnVbUHTZnG3l371DR+PoIsCVInr63eE/ivfLXYemaBLRCfwqJxZs0hdQBKXk42p1Q56JeRxzoJ3XgrQ+boEjtLeU+VixX++LAN9a5tpCh/jHNY8NRA9FGaJt7dIJdIx5fvyMtZLOtNjWOmnHutXkNLDL3uzhoXaC+GdSG4Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769039759; c=relaxed/simple;
	bh=9bhzF/hj3izMVUZbLe2wup+i5DcQh0+DMTQ8o8DNpCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAqkDqqh6ULMlIV6Pdz0ra/4eRUOODK2FawB9+fUK149WCGms/aiv1HFa8snEgRgcIiPOdZ+tLLORgoL/bCvJHp/amrKwgV9ReqjlS4i6F1/YODPzymBygI376LyaNzYuHFeYyoJH2PKD+fQFe1uiGwZSFDknvrGrrBuipkPp7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=LKBnEDyP; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="LKBnEDyP"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78c6a53187dso4290377b3.2
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 15:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1769039756; x=1769644556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V0bXGERJn476yEKyXCmDhLBQhHE++EaQ7Y7FI+S5ZTw=;
        b=LKBnEDyPAZdUY/PzcHI54G4DZqPng/FlJhbApC+RiSLWIcDEEgw3+v23/aXM160yGZ
         H9BexwrgVrSRzPeEzeuF+S0rgYAW8jtybCqJ+ZP+bxhEuArv9niTkqDVX8Xastck+iKF
         /kByVe8N3r5bGuhqop8X2ZHtkqJxqIho8nfG0T4HxB+TsuM2gUEjKdlwbg7p+kx2LXX0
         1otArJ8YIxgoXk2e93BWgtjjsJGIWyDGg52RGPoCczBPKdDaI8k47jPlbl/VXZsMrxoM
         hXEwr8+CsVYZ8ZagwXPJ1sQ+OGvguFH2nXXOnBX/bLFNfdSbA4Z+UhN4ZWym1SrJlwrq
         URzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769039756; x=1769644556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0bXGERJn476yEKyXCmDhLBQhHE++EaQ7Y7FI+S5ZTw=;
        b=xOfc/pQx8/fL5BT+UkAyE+axcmV2N32lAojPgQFoJQQfXbW+MeMGm91lTgopsY2MT6
         klwuUssPw72DYHANU4/ZLWMiXENvVwlJ37vYIeKV/UN6/l/U4Zbc3CsymARzjiAOeLtO
         v9jqSrp4kqNSh0uHMoevftjq/zEIbYbi2mGz06AJGX0l9jO0QyQOWNZovhKnwXJG3wG8
         8VBLp6CnlCxN70h6lBQEN/2O1HHTDFG9q6PJWPm8xl5+jUM0Gy9xHHRjBeQIH7eVGIK9
         0Or4lP2gttWNrDDEP/lHV9pPRaO9JWim8L5lUvhWwpUV7Bbxaw3JKX3C8+QHm43JMHlZ
         f5/g==
X-Forwarded-Encrypted: i=1; AJvYcCUUyec/TCh0tbqDh16VVDWrPVRT+JtmaSFFzQMI3ljDHWKLaHj2Jh+75vERj0MmviP62Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7rKT+gIJ2CUnZNJX56i+vfHeKYWd3c++zlRchbY8rq9GHXkC1
	aggPf3JpkSHdS2Ksk3zuZDvvcK23azZukf1e8R0KuRvOwa8a7I04S2oIcLNJIxAXONE=
X-Gm-Gg: AZuq6aKBt+vKvwpMqt9XLat6uynOJxSB+7d1R2vRwx59jTty7doQFjW1anRM5oJ8D5y
	a/A6c+F1k0ccvScmv0g8Dgleuk9GaDnT4lgbNB3zE7JJBcd/FCQiMrT3P1wYM47YnFaCs941w5z
	r8DsVul+TPkYNhnDsoR1nPdkTqdhoG42koTiUZPsme2jOziHRsF9lXLlrG4xbxAXNnGC9dLMVYc
	tnxGF00cwfaNNKP2f2gB4BgRK3BKstFEvVeK73O3xYxKIQeaixUgyNJ0NscmPxPYiFX8TnfagOa
	7vAGSIxoSvoUKk8jrcaF4utoUfYtvolfV1JtKNEU5n/JBDjgIBcZbLk+ElKgMAqV+RJ6HZaKTJG
	erOx2iFSFaksuvIZcyIOR5rqWhCf5RxzKCU5XybweGXk6ieLw1tjVgKncyPTDKYTohQbjP4Eb9R
	HkyY017AdCVCvmW9cEd2NbhZiffFyBfbwrtmvViODwj/vb6/dLLUFqppSzb0Az7Dr3m5Rg5g1GX
	e+ADGqOU3wPdBKbSg==
X-Received: by 2002:a05:690c:b1e:b0:793:a3c9:7958 with SMTP id 00721157ae682-793c688e470mr151476537b3.66.1769039756433;
        Wed, 21 Jan 2026 15:55:56 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66f66cbsm73417677b3.13.2026.01.21.15.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 15:55:56 -0800 (PST)
Date: Wed, 21 Jan 2026 18:55:55 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 11/18] git-compat-util.h: introduce `u32_add()`
Message-ID: <aXFni2tE7vn1dKFp@nand.local>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
 <c0c1769464b1c8065c2cea59dfd85a1d37de9dd1.1768420450.git.me@ttaylorr.com>
 <xmqqpl7beugj.fsf@gitster.g>
 <aWgSzI30k0BZfZ4Q@nand.local>
 <aWgwn2rk/qw+fRoA@nand.local>
 <aXCTkVpjJkTabx_0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXCTkVpjJkTabx_0@pks.im>

On Wed, Jan 21, 2026 at 09:51:36AM +0100, Patrick Steinhardt wrote:
> > diff --git a/midx-write.c b/midx-write.c
> > index 87b97c70872..6006b6569c8 100644
> > --- a/midx-write.c
> > +++ b/midx-write.c
> > @@ -1738,8 +1738,19 @@ static void fill_included_packs_batch(struct repository *r,
> >  		 */
> >  		expected_size = (uint64_t)pack_info[i].referenced_objects << 14;
> >  		expected_size /= p->num_objects;
> > -		expected_size = u64_mult(expected_size, p->pack_size);
> > -		expected_size = u64_add(expected_size, 1u << 13) >> 14;
> > +
> > +		if (unsigned_mult_overflows(expected_size,
> > +					    (uint64_t)p->pack_size))
> > +			die(_("overflow during fixed-point multiply (%"PRIu64" "
> > +			      "* %"PRIu64")"),
> > +			    expected_size, (uint64_t)p->pack_size);
> > +		expected_size = expected_size * p->pack_size;
> > +
> > +		if (unsigned_add_overflows(expected_size, 1u << 13))
> > +			die(_("overflow during fixed-point rounding (%"PRIu64" "
> > +			      " + %"PRIu64")"),
> > +			    expected_size, (uint64_t)(1ul << 13));
> > +		expected_size = (expected_size + (1u << 13)) >> 14;
>
> One downside this pattern has is that we repeat the computation, which
> makes it easy to get it wrong or forget updating either the check or the
> computation.
>
> I think ideally, we would have interfaces that combine the two
> approaches in `u64_mult()` and `unsigned_mult_overflows()`. Something
> like this for example:
>
>     static intline bool u64_mult(uint64_t a, uint64_t b, uint64_t *out)
>     {
>         if (unsigned_mult_overflows(a, b))
>             return false;
>         *out = a * b;
>         return true;
>     }

I had considered this approach when writing, but ultimately decided
against it, since it felt a little clunky to have to pass a pointer in
to do a simple arithmetic operation. But I think your point about
ensuring that we actually do:

    if (unsigned_mult_overflows(a, b))
      die(...);
    result = a * b;

and not "result = a * c" or some other expression which is not "a * b"
is a good one.

I dunno. The spots in this patch are the only uses of u64_mult() and
u64_add(), so I'm hesitant to keep a helper function around just for
that sole use-case. I wonder if we should do what you suggest here for
the much more frequently used st_add() / st_mult() / st_sub() functions?

> This would let the caller handle the failure and is thus quite flexible,
> which results in the following code:
>
> 	if (!u64_mult(expected_size, (uint64_t)p->pack_size, &expected_size))
> 		die(_("overflow during fixed-point multiply (%"PRIu64" "
> 		      "* %"PRIu64")"), expected_size, (uint64_t)p->pack_size);

It does read quite cleanly, so I think I'm convinced.

Thanks,
Taylor
