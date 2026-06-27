Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711BB13777E
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 00:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782521024; cv=none; b=Y5xGz0YOMnchmundb0G92LTYPecqzfurnpd1hS6gfR5sf5Pa7NBMP6GCS0APgnkmnkDSKOn4GIJ2v83PJCAAa/ZBqVwF2n4qr+Hb5YuHr4WRZdlzaHu0O4UPDNSn6OmUf4DuRtDSjq6eDxj2O8G3NWJ5YeB5cPASyCWB34ILHT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782521024; c=relaxed/simple;
	bh=ktTOvdk5UfvOcdqgRGIbkm7t5AfBXXLCLmlBbj2ZJFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjSa2Sww9+Jqcavz+5LgB+46/f9DYoVx77NG/Mza3DzLfBEhyYSO4AdglIbbnBFqs3DcoTLFY3N8+lpnaE/l6E2VoOR4LmqcH0Q1cAO13MO7oAYgZFDZR9kbxus696JsaJpVsRhP2vi1rUEXTGltF3udAeMn9W+AIVk5no9N7YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=HugpWLyv; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="HugpWLyv"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-664346e66daso1474567d50.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 17:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1782521022; x=1783125822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rYxKBOyE/+3t5us32RdUbgUE4u33mDA2rmd0AYF62qw=;
        b=HugpWLyvAy8T/NN1EPh3vsIHV6wvLztRIFN2j9Ei1/wA3+mU+xc3dOHmkjgLs8iZrm
         Y5PcFy9Nh2f6vV5CTD8RT0e4wJ1Syo/C4lXd8orNxBHkUaIbL6EsFjqaydtjjg8It/+O
         Q9HCwW2QibRYItKXc88741a3GBBPSKGg4rVSN6iLFBiYoARBElSj76g1xgdPZW3ayYJr
         6Lqs8/i+BJWuRAJXo71fAlHx6T16Z3UXKt1NYiuaejPwkPTLmYxI4AcWWWOPQZ3lst+V
         tiVlJrh8LROMq6jTLAhTJ+7EhYWNbEsmiBiMgLFSSGOINfRc9dHKSPkfOePRniQG6rXa
         uRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782521022; x=1783125822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYxKBOyE/+3t5us32RdUbgUE4u33mDA2rmd0AYF62qw=;
        b=PvTIke454xAoBdKa9a78cKG/Q8f6l5r3X9DYUUMy2iZc8641z2miaNPmydPHmSWte/
         DTCMCz0B9wHrxHHpsN2JEdiHYHTwAp3Z1WOKX0K4UXfJLKbrzkoz3ERDJGTH4kc7pG0X
         k2gIA3pXCMpOCmLhOlqAmQXDJeFdCRAiw2bb2juMOwmnZOXDtH0jjlMsE4gGkx8Uxyp7
         xJGRNIN+pYcDtVHs2rzBJXa2FJA+UX34rmyDgbqDvXb2MPFYj8svZPZyVAH/SsxrZzSA
         5EIqiQuOWcetooT8A5Z6mfH/5hyHodkgnBZLOW3pENCnKP3mkZXUQscW3WrWhiKLqHaR
         YWAw==
X-Gm-Message-State: AOJu0YyczfDzu3LQUQKa9CxbQwHNUdztppDPHI4JRW/M1iRq/IOpGdQ7
	h2kHImkixo6oMyhAsdCHPBDWOG+/obNVYtLI2mCByas61zxm1Kqe+uXePxuWjy5dxKDL1VKImgf
	1gGpNIlHizw==
X-Gm-Gg: AfdE7cl4qgHjGWIeje9/Nj192+vueZe0uwWnifXwYWfAgzOyhZ6I4sra9lJWZNDuKr2
	DxfBMUENLHsJYdrKDN/OLHHqjhIuxr1jRK8V+FillWJEjmOaWBl2g5ng0dZQEkOUy/+nlDCAkBz
	bXlwRr03pctCFChTZgouJUAv1GdGXHoEw/znmatvxYV1/ri4gBz4RZcyf21+yLOdiPbI6CBq+QJ
	5k2x3q66yLso/qvRV0RCq64bMSFknzs2UbOskeqA2RGRsy8RHQPLd/SY1GzwWKfdVEKP3w65XYK
	pg3Ao7vwpGvZrVHO0z7m9IsEzYnuj34wQ3P4UI2l89bFYhMNg/EVWmzEr+W1s98dwIZkiUR/Lyp
	A4O4MTifzWItjoPIzQWFn1A+xtQ1Cri/B/kCXPc+XsXYizm7CXBpn98GfGbQ+bnLKh307LfYT0/
	4u627vygp/XLKB/EvFLqjOnNHsgxIb9fxV1KcRbgIaI2wyOWQF4BOsYHhJmLRinrv1IGuAhNbgb
	3wHz5ij/IpuBmrFAy9cvLlVLZQwh7aBCSG2sZNzqzHBliIEGIut59NG9Y/IwjcBbQOQDltijjvo
	CAxuMYUbefs0oDwx
X-Received: by 2002:a05:690e:4808:b0:662:da40:c98c with SMTP id 956f58d0204a3-66487e73b55mr6008928d50.41.1782521022451;
        Fri, 26 Jun 2026 17:43:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-664a18f653bsm1454059d50.8.2026.06.26.17.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 17:43:41 -0700 (PDT)
Date: Fri, 26 Jun 2026 20:43:40 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC PATCH 04/10] repack: teach MIDX retention about geometric
 rollups
Message-ID: <aj8cvDCMcw+RayyO@nand.local>
References: <cover.1782500507.git.me@ttaylorr.com>
 <ad76f06fc7ed304af97c73a5931e1ebc5f2d3895.1782500507.git.me@ttaylorr.com>
 <xmqqwlvl56vh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwlvl56vh.fsf@gitster.g>

On Fri, Jun 26, 2026 at 02:28:18PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > +static int pack_geometry_contains_pack(struct packed_git **packs,
> > +				       uint32_t packs_nr,
> > +				       const char *base)
> > +{
> > +	struct strbuf buf = STRBUF_INIT;
> > +	uint32_t i;
> > +
> > +	for (i = 0; i < packs_nr; i++) {
> > +		strbuf_reset(&buf);
> > +		strbuf_addstr(&buf, pack_basename(packs[i]));
> > +		strbuf_strip_suffix(&buf, ".pack");
> > +
> > +		if (!strcmp(buf.buf, base)) {
> > +			strbuf_release(&buf);
> > +			return 1;
> > +		}
> > +	}
> > +
> > +	strbuf_release(&buf);
> > +	return 0;
> > +}
>
> It feels slightly inefficient to repeatedly strbuf_reset(),
> strbuf_addstr(), and strbuf_strip_suffix() in the loop.  I do not
> know if my understanding of what existing_packs_retain_midx_packs()
> passes down in buf.buf as base is correct or not, but if so,
> wouldn't it equivalent to
>
> 	for (uint32_t i = 0; i < packs_nr; i++) {
>                 const char *pack_name = pack_basename(packs[i]);
>                 const char *suffix;
>
>                 if (skip_prefix(pack_name, base, &suffix) &&
>                     !strcmp(suffix, ".pack"))
>                         return 1;
> 	}
>
> perhaps?
>
> Starting from "/path/to/objects/pack/pack-deadbeef.pack", you take
> the basename of it to have "pack-deadbeef.pack" in buf, strip out
> the ".pack" suffix to get "pack-deadbeef" in buf and then compare it
> with the base.

I think that this would work nicely. I think that the skip_prefix()
variant is easy enough to read, and is clearly more efficient.

> Instead, pack_name in the rewitten one becomes the basename of the
> packfile path, i.e., "pack-deadbeef.pack", then we see if it begins
> with base and take the remainder in suffix, and finally we check if
> that remaining suffix is ".pack".
>
> Which should be equivalent.
>
> > + * freshly-written pack supersedes them. When doing a geometric repack,
> > + * packs below the split are rewritten into the new MIDX tip and should
> > + * remain eligible for deletion.
> >   */
> > -void existing_packs_retain_midx_packs(struct existing_packs *existing)
> > +void existing_packs_retain_midx_packs(struct existing_packs *existing,
> > +				      const struct pack_geometry *geometry)
> >  {
> >  	struct string_list_item *item;
> >  	struct strbuf buf = STRBUF_INIT;
> > @@ -315,6 +351,9 @@ void existing_packs_retain_midx_packs(struct existing_packs *existing)
> >  		strbuf_strip_suffix(&buf, ".pack");
> >  		strbuf_strip_suffix(&buf, ".idx");
>
> Not a fault of this patch, but it makes the hairs on the back of my
> head tingle to see that a bogus input like "pack-foobar.idx.pack"
> happily is taken, while "pack-foobar.pack.idx", an equally bogus
> input, is not.

Yeah, this is gross (and my fault). Presumably I was swapping out one
variant for another and didn't stage the removal of one of the
strip_suffix() calls.

Thanks,
Taylor
