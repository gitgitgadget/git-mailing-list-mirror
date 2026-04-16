Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E95375ADD
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776373955; cv=none; b=Gpjc1d/VxBuTsVspmzK0HTXhJgOPz/hCnwXff+up+qa2saY7REbChH+X+i/UUmAfM+Ml18b4ZXhlncf1z2RJ2plasJh7yn7ZxswovigDD77wNPv5QLeDYZFFLt38ERShHtl0hM9OcD3tMGMhvzBbjxqvOp5fa5n2DsK53w/8XuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776373955; c=relaxed/simple;
	bh=NYhLG6wdChTetlEpu63Q3r/HjxPDoe1jGFALwm5xOyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pbyct7vf1lsytXPHs1uAKQjCd2PyaXrSnK0WTfZXOM3rF9UCrD7Mxaeb2XZdTiBrBW2Ww+/WV7tCWWUJDJNVEuLSqu0L+peH4FT0NE75YPEsG5WU5y1j7yxzLLoiWy2LglYM6uqWxu1Nd4wu5sSjdHzFKISB4ASs65rF9u5Wk7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=El3XvHA6; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="El3XvHA6"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6530dd51ccaso36833d50.3
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 14:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776373952; x=1776978752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TX+/wMWmLomQmqfbOSDeIW85BwBmIzuepL59z2ms/G4=;
        b=El3XvHA6VG6XOYKBGXl6DSX7CDK5/eSwZ0JGY190LnYD3QFp84ol6jT7KMAJW1hFKd
         mkcAKiWblJRM5Wz4nA6dieDtfJyYYj/SEnwyIuLBjFenAenBf8YefdYgvVVSS1EDMWYY
         oqc0VUNG+8xXGceUuZVMfZfXvITn5PZZP518E4gpzmQFJ266SdObhRJRjqpwieckORWy
         1jBS/TlMY96QQTQIKbHt3ROXCfHbFSfVqsF5lOTQK8IU40d9ZuvQAjvtFjHXXgYBRO4z
         4FKUHw7kHq1x9+FO7u/Ah49Vmq0TO8Br6vBJPB89kkJEpjCuoZaT4Zuany6+IgiB+Pqo
         9rdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776373952; x=1776978752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TX+/wMWmLomQmqfbOSDeIW85BwBmIzuepL59z2ms/G4=;
        b=cXi6vNixEefD/lLbsbxRAlK3gdhjrIufjStSIMNUyq/s3XhNmku2koFlRwHDo/kpoK
         aFBx7sC98vKHz8E+6NGwRdtiXXNt/dMh+YnIh8xPjOl+W4liecbICqDh7qvMN9qLmb5u
         yO56KtnreCvQSW3Sp6udHSpsqvrBVnRL7qiz/ZNRhhViqg1a70p1zIVaAAxTLoG3l97s
         EFMIoG+VYgcnl8+Tnx24ztZewQypibbZAf9/R99k53u9K94mmVOOjL54kju49hxfrQ+V
         Y4Ymdjv/shL45mMqmZX1H32DJfB+Ph6E9eqNqdmsnDOnv8oiZ4JqYX41FlKW6vvX8By+
         OH1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+DS8t87P7levfghPO9c+S0OP9BAmsPzyrTpbEKlbzpnNAX1549XRTuOAnhGs/fvQdHnFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7RTmUCE9KCGhd5fVHfdYdkvpUVDvTMnlag4MHEwD/hGLUb6Pk
	kyNZu0FE2QbCFsapN8FOx/TASSJmWkJDQHGbzhMqvOEyadoX24tTxdW53X34aBJemAE=
X-Gm-Gg: AeBDies3UYpTJTuD8PRbZfwvBSD/gHPPEkzYas2tBWFUVYgt+bBjDFQFIlBWgvsv8kR
	yVr6DIVEakAF5oV5Okt5r6dXToDJx1ARXbn43U7XcZ6vfTimgI93+TJYZd5AAMUyxubxxucMSOQ
	hEfPi0ZJc83ueGfxeejhqE7tBPIqOlsB2LBJ9Bd2NreOmkF/z/JAidraCbfQQ2iRcMJeTgauWt4
	CYUh+ND5HoHOBcATVfLvrjvD6wkBIkYVpFo8U32JytoSeKbJ6BJEbPndtbLYn/3B4dXOfAlALLA
	+HpJddzMSfwLD++bTYwkN3+4GcgoQMcf97uWTHzzcaJP8elIADZMjlXcF+MuZEku+B0U3yiJPHx
	5Fbs5O1dE2dvC0w8nkf5yznMyBzrjomm6ThdiCYhUuV74VrgtdtEy/TQfWaI3t/065Rn1cTB/9r
	R1bRy6B4BkRx3hvvqA3uXRUd2j+wFfZlFIx0W7oPeHJ1jmpiAFU8R2DF4yVNSw30EKKSVx17drk
	rlDEbX+fWcSS8UQ2DapnV6jmekqlQ9xHNEs23lGHBmdRV7L/kDAVCriwsuifwePTE3pHPFiNg4O
	xnm8rhV1OcoLQaPF/Tb2v2/3Hys=
X-Received: by 2002:a05:690c:f06:b0:7b2:64f4:a2c0 with SMTP id 00721157ae682-7b9eceb5055mr2292667b3.5.1776373952144;
        Thu, 16 Apr 2026 14:12:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b769812d1esm28607247b3.43.2026.04.16.14.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 14:12:31 -0700 (PDT)
Date: Thu, 16 Apr 2026 17:12:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] MIDX: revert the default version to v1
Message-ID: <aeFQvu4iqJAQMjCy@nand.local>
References: <xmqqqzohd0sh.fsf@gitster.g>
 <8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de>
 <xmqq5x5s540j.fsf@gitster.g>
 <20260416051732.GA48541@coredump.intra.peff.net>
 <20260416053435.GA646718@coredump.intra.peff.net>
 <xmqqldem22uw.fsf@gitster.g>
 <xmqq8qam217m.fsf_-_@gitster.g>
 <20260416200659.GB1887222@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260416200659.GB1887222@coredump.intra.peff.net>

On Thu, Apr 16, 2026 at 04:06:59PM -0400, Jeff King wrote:
> This looks fine to me, and you can add my S-o-b if you want. But let me
> propose a slight alternative that reduces the test churn and may make
> things easier going forward.

Same here, I agree with the discussion earlier in the thread about what
the right short- and medium-term solutions are, and I think that
including Junio's patch is a good approach.

If we take that, please also feel free to add my Acked-by, or
Reviewed-by, or similar.

> -- >8 --
> Subject: [PATCH] MIDX: revert the default version to v1
>
> We introduced midx version 2 in b2ec8e90c2 (midx: do not require packs
> to be sorted in lexicographic order, 2026-02-24) and now write it by
> default. The rationale was that older versions should ignore the v2 midx
> and fall back to using the packs (just like we do for other midx
> errors). Unfortunately this is not the case, as we have a hard die()
> when we see an unknown midx version.
>
> As a result, writing a midx with Git 2.54-rc2 puts the repository into a
> state that is unusable with Git 2.53. And this midx write may happen
> behind the scenes as part of normal operations, like fetch.

I'm not sure if it's worth mentioning, but I think that it's reasonable
to say "Git 2.53 and earlier", with the implied lower bound being which
version first introduced the MIDX. I think it's equally fine as-is,
though.

> Let's switch back to writing v1 by default to avoid regressing the case
> where multiple versions of Git are used on the same repository.
>
> There is one gotcha, though: the v2 format is required for some new
> features, like midx compaction, and running "git multi-pack-index
> compact" will complain when asked to write a v1 index. The user must set
> midx.version to "2" to make the feature work.
>
> So instead of always using v1, we'll base the default on whether the
> requested feature requires v2. That does mean that running midx
> compaction will create a repository that can't be read by older versions
> of Git. But we never do that by default; only people experimenting with
> the new feature will be affected.
>
> We have to adjust the test expectation in t5319, since it will now
> generate v1 files. And our "auto-select v2" is covered by the tests in
> t5335, which continue to check that compaction works without having to
> set midx.version manually (and also explicitly check that asking for v1
> with compaction reports the problem).

I think that the test fallout that Junio's patch necessitates isn't all
that bad, and in some sense I think the "write version 1 usually, but
version 2 if the feature requires it" is a little magical. That being
said, anyone doing things that would require a v2 MIDX likely already
understand what the trade-offs are, so in that sense I think that this
is less magical and more "do the sensible thing by default".

I don't have strong feelings either way and would be fine with either. I
think if anything I have a vague preference towards the approach taken
here, but either would be fine with me.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I have a feeling there are probably some gaps in v2 testing in t5319,
> since we are no longer using v2 for the bulk of the tests. IMHO that is
> OK to sort out post-release.

Perhaps, although you could make the opposite argument for v1 MIDXs
when we previously switched the default to write v2 MIDXs. The format
differs only in the version field, and the ordering constraints on the
packs within the MIDX. That area and the compatibility issues here are
the "interesting" parts to test IMHO.

>  Documentation/git-multi-pack-index.adoc | 3 +++
>  midx-write.c                            | 4 +++-
>  t/t5319-multi-pack-index.sh             | 2 +-
>  3 files changed, 7 insertions(+), 2 deletions(-)

The patch itself looks as expected to me. Thanks for working on it, and
sorry again for the mess here.

Thanks,
Taylor
