Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A830A3E558A
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 07:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134040; cv=none; b=cS0aPuRUBLn5wnjXGajdHJ00RXwEfaDadURds4LEK5HXQmZ7b3JjFzh+7uZBxPzWi9JM2CTQ+ta/ZbwcN3/5taJa1Yhxg09KxHQRy2XXRaBAfe8n0kllPZkpdmyeSCZSLIptqQVlxpy5w9si6p4JJTag0ifECcVz2K+YQTgj1Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134040; c=relaxed/simple;
	bh=dv7pA6BlDaFqqnuB5LyDktwDM4GqtfQxlVxpz/g+jKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpW2KoHXtMfN2FgQewLBGlykzWoYTA2qBYsFlq4v9sA9v4aK75RVW+bmbycjxvt3gh27WjtUOuOyoGcSPaSXFRF8IyCH654LM3yODP3UVhLtv+P5Xbvuq2c4gAiX3QqUT4ZWdolPpQcw9Ruup1GXohIB158zCB0vP0opL3DRpGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MirgAdLH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m84ebDOD; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MirgAdLH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m84ebDOD"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E556614000EE
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 03:00:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 16 Oct 2026 03:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792134037; x=1792220437; bh=Pp/BPEjGcv
	Wy5h1TL6c5+qVz+oGWJwliVXbubqnEkh8=; b=MirgAdLHtgrvs+NMIfR/b+iryz
	5ZVPCqw2DUAWer2HC3o3RQoe9WVx40jGKcfRmcBIs+0Wpv65zjbWB6nyEgjqwnTZ
	SO+NzYbeG91vZzr6axKMAhnzssU4fO67hZ9VShOpujy0usJkl+B0StxzTwdlDD01
	RAzjD9BGeiqLmWdkT4NoPEWmhHJE0ZvujZNjvJKVf92Y1crAH3V/OnOO+QuL+gTc
	ObPt0cxvOsFpJVA5pEhxJ0Hx9McZ0oeW/KEKtsVXXqC33EFbxeqfwXNI96ySmuoB
	eZCvCai1jy7un1UEYZ44CUPcwxT1BDAeGo2HYa4ytIckPk/d9uFUUloA5eow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792134037; x=1792220437; bh=Pp/BPEjGcvWy5h1TL6c5+qVz+oGWJwliVXb
	ubqnEkh8=; b=m84ebDOD2oDGypflg41WD0zFryMbefbCFKuZrtfqht1BYyxmKW3
	GFyfGW7QrhqxlKBpzTnWFPi3Mr2J6VkT0pdDQyqNeCd9QlfLE+tio+ugF1CoHwZQ
	/h0VlDk6am6rny9lpbN6xvoOSpUbR+FdfS0X2OmEFdVCF34Qfz/FtcTptbR48Zzt
	dvXY5PEB3u786FzvGEvxjD88RoOwaU6vnlOEyS754QtsdObWR1TstoRW48/1A322
	rcsYX47HWxov9DBENs/jXDYs0SuSuP5+37EmgxF9/GE/1lTt4sAn0nSiPGMJLnsl
	T1SgQ9r7eW8z3/CpvWeJJhqYB6nxoJQ0cHg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792134037; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:YEq9rXSLFPPQM/VAsbv0/ZKIotKomm6Hyn7PoPJ9WgxKRu2
	/z6fKGtehwI9EqZCWX9O2Xw4NOatIPnz7DmFnp1fV/JWQ0lOrRb1wqtjyS1kQDlx
	hRlJBefWYRXYmhWySZEN9ZbtTJaW7qgaMHlqXCt16U7W8yYHf8vuzoJYN8TAP9Bl
	SFvlV+BNow0eTMZLEEsNMF+VPJvFE1OziPtlAXyuBb2qfabESPGgrgPuy2Kl3zFN
	rloFJviUkK841b/gH/Lm9B8ypT100vFl3RrlKj5ikGuVg9cuNmgJ03I6/VjCRabq
	lquBTlh5Aa6UqHfoUku/8vtrRXPQ8HAgpNMA2QQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:/ekJqkVf8I6QldrDqbTGf76ILsM4tctp00hO0vZQaNI=:dv7pA6BlDaFqqnuB5LyDktwDM4GqtfQxlVxpz/g+jKM=;
X-ME-Sender: <xms:lcvRaqCszJa6q4Rxb0fThB3L3H-P73Y2e-RU5ZzMYtrgGDvtRI_2Ww>
    <xme:lcvRargA7F6WEWApKd0VaAJB52Rj2s8MP1UChv0VLJpY4VsBjCkq4wd9fpUe1pb82
    8O-4dOn4UgfSLitn_aCyLtIgJJ_fk2vmeMwKPPnyAc5hsdSGj1jPzg>
X-ME-Received: <xmr:lcvRaimsqxoxEpngOQ4VcvFDFNAlp0zQqDUfsCM6XRuhY3gdCfTXNQ>
X-ME-Proxy-Cause: dmFkZTE+1DBjQJDVhhoguk8nOg0cFYTbelc0uufa8TCgK3uBv/4cB3pME9sRv0ue7iuAVu
    nV3y835YgOVh8mAFLHP/vYvVBO7cDKADO1WnNx/A3LVKFi0dEXl8xK7L3SkTeLpZr+1Djr
    gnBbAu3j2N9U+s5BNo1NnKTvlbvwkDBC2Lyy+xQ3aERV/fDDek2qGPukfBUNWdasZquACP
    m00AnvyXg6pXa+D0xNShlOR35pIPwhBFQKg7Pxf1b4alhgH5Yfmfn/dRivTwOjG+pgwb74
    P2xFnU4rbPr7IxYKxVB4BCMi395PQIyxgLSTuFpon9ow1JFUxC86OOFqEvDsit5bRrNzU1
    PZ54aEDQEXIhqPc7cu2MnXD4Cu3eWIwqrWvHccHj7ZLX4zD/8C7AQXOi/x8BNsO1T845O0
    K2zRcEV+ksbWqtk/w3rsb011sUj+af2vIaJfB2CY1+wVIH5hEjrSvww62YVnretyqJtLXs
    7elxuSgG2c5f6A5+d+IxoLX4VuLM1FWDQIeJPJtWEbtSitt7gWYImCipAZZPz9Fjh0CtnC
    i/o93cinudwXH9s9Sv+yoDqCvDIrBRCH54/UGp+wHRAUub+21JWsAKAQhZ6bky/V4fGV5A
    LW3qtW8e1IMDYow64pOpZltrbYj0UEYhd32R6kPI4HzGOQXHNv7g/zQTPGPg
X-ME-Proxy: <xmx:lcvRanoxsbTqLTzA-2GfefZIO1tu_FRzfkZEqExg_G_bjJbumyFHyw>
    <xmx:lcvRarHinjfoWHPEjuXI6HgWpUBhXVBhMrx-bv-W1IXwlEOi2roelw>
    <xmx:lcvRajzZEzYGRTYQ-aSo8ZhPnPXBG0iJH5J6Ie273novP37AVxVP4A>
    <xmx:lcvRagp62q4vt04GRu3VmwtDDsDohf7SDVglVb9ep8RwB423Q00DWA>
    <xmx:lcvRaqE_RyjuVQsjtetsUR-zknoo3nxt9pgAC2BEWsTjobqhGLFPNMlA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 03:00:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0af21aa1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Oct 2026 07:00:35 +0000 (UTC)
Date: Fri, 16 Oct 2026 09:00:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] refs/files: keep root refs out of loose ref cache
Message-ID: <atHLkIADa6BlO_a-@pks.im>
References: <20261014153208.2194727-1-andy.koppe@gmail.com>
 <atBraYoY1SVwnezN@pks.im>
 <xmqqmrseooor.fsf@gitster.g>
 <CAHWeT-Z4n=txTGaBNuGPj3jcOou91owB59gvaPvF=2_p50eFHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHWeT-Z4n=txTGaBNuGPj3jcOou91owB59gvaPvF=2_p50eFHA@mail.gmail.com>

On Thu, Oct 15, 2026 at 08:43:06PM +0100, Andy Koppe wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >>> +/*
> >>> + * Create a separate ref cache containing only the root refs. These are kept
> >>> + * out of the loose ref cache, which may already exist and is shared by
> >>> + * iterations that should not include them.
> >>> + */
> >>
> >> This raises the question whether an alternative fix could have been to
> >> teach the cache itself to skip over root refs in case the caller is not
> >> interested in them. The answer may very well be a "no", but I would be
> >> curious to learn why you settled on the proposed fix instead.
> >> ...
> >>> -    loose_iter = cache_ref_iterator_begin(get_loose_ref_cache(refs, flags),
> >>> +    loose_iter = cache_ref_iterator_begin(get_loose_ref_cache(refs),
> >>>                                            prefix, ref_store->repo, 1);
> >>>
> >>> +    if (flags & REFS_FOR_EACH_INCLUDE_ROOT_REFS) {
> >>> +            root_refs = create_root_ref_cache(refs);
> >>> +            loose_iter = overlay_ref_iterator_begin(
> >>> +                            cache_ref_iterator_begin(root_refs, prefix,
> >>> +                                                     ref_store->repo, 0),
> >>> +                            loose_iter);
> >>> +    }
> >>
> >> It's a bit weird that we recreate the root ref "cache" for every single
> >> ref iterator we create that asks for root refs. Is there a reason why
> >> you have decided to not actually cache the root refs the same way as we
> >> cache the loose refs?
> >
> > Curious.
> >
> > So an alternative would be to have two caches, the primary one for
> > things under refs/ hierarchy and the other one for those outside,
> > and callers can choose to use only the primary one or use both of
> > them?
> 
> Thanks for considering this.
> 
> I think it makes for a simpler change with less overhead to not
> actually cache them, as there are only two uses of the
> REFS_FOR_EACH_INCLUDE_ROOT_REFS flag: in builtin/for-each-ref.c for
> `git for-each-ref --include-root-refs`, and in builtin/refs.c for `git
> refs migrate`. And both only invoke it once.
> 
> I considered keeping the root refs in the loose ref cache but skipping
> them during iteration if the flag is unset. But that would mean more
> impact on that much more common case.
> 
> A cleaner approach might be to drop the flag and change all call sites
> that currently ask for all refs without setting the flag, so that they
> explicitly ask for "refs/" only. That way root refs wouldn't need as
> much special handling. But of course that would be a much bigger and
> more risky change.

That's fair. I guess the part that triggers me is that it's called a
"cache" whereas we don't really use it as one in this instance. But
that's a historical wart, and I agree that the proposed solution is good
enough.

Thanks!

Patrick
