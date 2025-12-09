Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83CC301005
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 01:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765245598; cv=none; b=JzbSOW01gk6MnNB6U+ejZMTAns03YcV8z7GgH12+M9roMex4erLCnfOOQ6mZ/NJMeQebSmV+WiIV6nhQJh8vuGhHo/gvtNAOPxIdNKoUpw52kITuJocmwZqgDtzJ6TjBByIiEk6JQJ7n8JASW+0q8iT+o1oGY2iRqncp4b01Gow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765245598; c=relaxed/simple;
	bh=/DTu3Qy7ugPeKcpfbRkGtoGLs63gD+pGhAsbKECk4t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QX/tnW1MsKyJE5H+86tW9VADOhhQHFDD7EBl+Lx6aTq1wAFJSmcH+lF8w9MuOp9A+DGpm4ujUhgBoev2jOxzH8RRetLt0UME2HdFPfx5RoqSSZL5dBcpt6zUwnyF70Fm4hi1zEwbyR9UkvSkZtQVvCGCLXKr8myy0pwsGclqHkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=OFR2Kju7; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="OFR2Kju7"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6446704997cso64264d50.2
        for <git@vger.kernel.org>; Mon, 08 Dec 2025 17:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765245596; x=1765850396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kRg7RSIdARbi1ePstWXWO194DjFjIxr5aGFsktYH91E=;
        b=OFR2Kju7S9Tb8cAYb8YNS1D0TS+VLc3jZz7w5uYWevSQUnvf0kL3VVTZcV86gNpZ+F
         lEEm7ZTIhBiHyF11s6HGGnm0bj3uO/iZuNmk1Ks61cXcD5s9HMdyuyDzBaSMQf1qTQXQ
         /RBRUdNPJ+U9Jnd8ZoL46zr5i8CkteU1xwe8qx0DJo7103LRPg7HBL0nFE/m3QKW/GIP
         VZ7kx1O129sznD+O842/HYyZH9HIxcWqu3R4u/uCUFd9Wxyn2quP52xELmWuNLZb2zCx
         oe6NVup7TW7mk5OOZ45EPn5FEsjuroBuZXodhO8fpNCfKL4nK34ueggpd8q3fYlHK0Wb
         LxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765245596; x=1765850396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRg7RSIdARbi1ePstWXWO194DjFjIxr5aGFsktYH91E=;
        b=P0eP3LwqHBLeYJUSsJECae3kIXmEdCPR+KhICfFs2c9NuaXkRhDSt2tEOhxOm7llxi
         gbttK3pmSyx1bjp1saKawqPhjqoFkQlkd0Qplr67idsxhRCorPefvlN5c+noDT77xRhn
         T5uyKmsvOsvPKmtbpdF0pV8iwOUtc1k4BSDMb79u/EZBcqo3Nkel13Fudeo48CLGEom8
         9GtUyfJo3/TjJtNTLba1yWZDqC3HbdHd0dGJ194xVE4LkV3jYb6zYvnjEU0oxOaZRA7i
         rMaL0+4YmPFRwyToeYpdGoA5nvDGESTc+HNi0pam/IGrb9TxitTrwwQ5yK44tsfFGuEp
         t3yg==
X-Gm-Message-State: AOJu0YwSR25lZrW5JMdjXt1JrSASrh0MnZNGyPUWrgBr4jr6b1mDX90D
	tnq4T7Ju+8hQbRXjq9Dq4u1oxQxGv9XGhr9IWnNQ+cmTruFFudWnKZcMQsCLKkKagDFakJLbviX
	WuYR+skI=
X-Gm-Gg: ASbGnctMsq1YawBfr48rOI5E3RK5qa5PRQH4PfNA9U2BdkXmjdJZSxLyTHFF0XsJaXC
	tCxPMPEGRvzyMgCZhIFWnljeXIIQWwa7WH/eobvJiuX8chAYG6+PW03OnHoBmcooCZp/s3vOqiW
	4Y6rq0kV2PQgZBHhQFuFvpFex49YWPdC4Yz86uiKZYVL3wVsayaKi22NU9flFW0IbjWwNawS4/e
	H+xbQRsw1T2EF2Y8WI9/ryNhvSGEU3QQhfEzT35zOfAYBJPH9gVBgSg7F9SE3ilS5C2YHnoz+ya
	6/UlEpuZ4jmtOr9LaYF9ZyIn54UK17POykprh2vMgoXVlheI6HgyY1NAoTGt8FDd8TYJH5SPDcN
	RgZ5iho3de6x8fhqKzcl/56jbZjC+BGJtByx0S/TqXuKBo98Yp3NrFg4eF0ZHOHaAStyC/d8nVg
	Pkq2+XQg/O3aYleBD6LXWx/6nzI3VZmt2fe0l/PINZY7z/V3bBN5LMyjWwDzr/6flP2JzFLhQNq
	ObchrLnMx/4Jqx6Kg==
X-Google-Smtp-Source: AGHT+IE8UJA8kcIJHJtqfIsYmQcApu4dir6uj2fWrSRGYAEV9eucxiTitxmuWXQZXsUxsiThqrEq9Q==
X-Received: by 2002:a05:690e:12cc:b0:644:60d9:8650 with SMTP id 956f58d0204a3-64460d9874bmr2318213d50.95.1765245595829;
        Mon, 08 Dec 2025 17:59:55 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6443f5a3c93sm5882712d50.14.2025.12.08.17.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 17:59:55 -0800 (PST)
Date: Mon, 8 Dec 2025 20:59:54 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/17] midx-write.c: don't use `pack_perm` when assigning
 `bitmap_pos`
Message-ID: <aTeCmrLnRtYRm/ah@nand.local>
References: <cover.1765053054.git.me@ttaylorr.com>
 <1fc359d9a98cdd61f6986fa1d9a1190f57dacb9b.1765053054.git.me@ttaylorr.com>
 <aTcYU_yVYyXL9TXv@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTcYU_yVYyXL9TXv@pks.im>

On Mon, Dec 08, 2025 at 07:26:27PM +0100, Patrick Steinhardt wrote:
> On Sat, Dec 06, 2025 at 03:31:19PM -0500, Taylor Blau wrote:
> > In midx_pack_order(), we compute for each bitampped pack the first bit
>
> s/bitampped/bitmapped/

Ugh. My "bitamp" typo strikes again, thanks for spotting!

> > to correspond to an object in that pack, along with how many bits were
> > assigned to object(s) in that pack.
> >
> > Initially, each bitmap_nr value is set to zero, and each bitmap_pos
>
> I assume `bitmap_nr` is the number of bits, whereas `bitmap_pos` is the
> position of the first bit?

That's right!

> > However, we enumerate the bitmapped packs in order of `ctx->pack_perm`.
>
> Which is the "permutation between pack-int-ids from the previous
> multi-pack-index to the new one we are writing"'. So it's basically
> tracking which new packs correspond to the old packs.

Ditto.

> So obviously, the permutation will only ever be different in case we've
> got at least one dropped pack, and that only happens when we expire any
> packs. So the explanation matches.
>
> Of course it may be a bit more fragile now if we ever added a caller
> of this function that _does_ expire data. But we don't have any, so that
> enters the territory of overthinking things.

I think that with incremental MIDXs we will never have such a caller
without a mechanism to tombstone objects in existing packs, but
definitely worth calling out.

> > diff --git a/midx-write.c b/midx-write.c
> > index 73d24fabbc6..c30f6a70d37 100644
> > --- a/midx-write.c
> > +++ b/midx-write.c
> > @@ -637,7 +637,7 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
> >  		pack_order[i] = data[i].nr;
> >  	}
> >  	for (i = 0; i < ctx->nr; i++) {
> > -		struct pack_info *pack = &ctx->info[ctx->pack_perm[i]];
> > +		struct pack_info *pack = &ctx->info[i];
> >  		if (pack->bitmap_pos == BITMAP_POS_UNKNOWN)
> >  			pack->bitmap_pos = 0;
> >  	}
>
> The change looks simple enough.

Yeah, I almost wonder if the commit message was more harmful than not.
The main points that I wanted to get across were:

 - Ultimately we want to enumerate a list, and there's no reason to do
   that in a permuted order.

 - Iterating in that permuted order is fine today because the array of
   values in ctx->pack_perm are always addressable indices into
   ctx->info.

 - That won't be the case in the future when we are combining packs from
   MIDX layers that have a non-zero m->num_packs_in_base, so adjusting
   the implementation now prevents us from running into that pitfall in
   such a future.

Let me know if you think that I should adjust the commit message here.
It's hard to know whether something resembling the above is better or
worse than the current version of the commit message from a reviewer's
perspective, so I'm happy to do whatever you think is cleaner ;-).

Thanks,
Taylor
