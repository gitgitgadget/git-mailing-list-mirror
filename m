Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1E6194C96
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 21:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776805333; cv=none; b=p5V4iija659WxgxOjl9D9fuqbpc3Vzg0t8UqVdscB4KqYDRSBTzmjHFD0yQlV5n7uBI5JAunSMSIq+3cw5uo2EYTMsBe9gDWhpmT0HgZYskJEHn57XtwVOphRZnWhqFNX6hFrVva97QhhDvjJWm2upKdtDzSMT8CaIOFS3IBKmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776805333; c=relaxed/simple;
	bh=n3bAr3zE3ldNldk594b77c4u8pH6YRn/TBPiOgrr6T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oi4ClJYkqctUKDKHPHJFlpC01OlAw9nRl5dUOT1JQk91ElOOFrVs5niMBXXOXrksyOA0TcinTcxHRJU0l5ZG5oMbyvs3abOjPyvO2SbL8KOQeC9dPPqmqKGvxNiClm+R4Ah1qcABMIkgNetyNIB7H++6lEV7BfCC7bG54f26lqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=XLJAq+bI; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="XLJAq+bI"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-415b23dd6e5so1760279fac.3
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 14:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776805331; x=1777410131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iHuUnv1fuwpc+Z2JxURxviiurbwFTkZqTyncQBiSJAY=;
        b=XLJAq+bI9IKDMH2QoVPhuzhfCpzJ1j3HuOHC1qQFckSvgVQt6CqMwHhcPb3OKs/d5t
         RMlFIv1Sy/Rlb1xLyNE9FHdOKhFgtloqFlZKdpJBvhdfSFCtEOBdlBtuzGXvXepTT9ji
         GgqjYZgWaMtuWeQzKxw6j6dUTGZGit/3sjYOnWJbvy63aVWR0DJ/NCidFWVWSFRN0kSv
         vWMVaZhyCvU9zZnjlRVxCKJ8db42dQ/Dte4mUNLfxvW4g3KEu6HJmRThcx9y7NMxFfS5
         AJQNA1FuXD77/vVk3R8O3PgSIMSJKMegDkweg7aenvfnWnxY3FMDPYElLEP6gt8RqQ2W
         /VsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776805331; x=1777410131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHuUnv1fuwpc+Z2JxURxviiurbwFTkZqTyncQBiSJAY=;
        b=RwPWp/aqxGrpDNHtvGkxrBU9JM/+vSpP4BZb+6Yv1yyftoXqci7yAeI5G0+BtMG2fc
         aeV4Jx1+3GdoCEmcYQJGhXPKOjbB+yW4C7mpshIio06R8HcidYcxDh43EZvSI4SD/+Yc
         aKYrg4y+JB4MXvsWT0Vle3tddsqNSm9CtuQA3sbDtmYf/SdsRS+kAnKARxpfbMyGW5gK
         5n2pNDodN4hYcpBz26xwMBhbfXWEl46oo5sUJIszadb8OBHDSajgtg+hn9jJq6GkxDRm
         5M6iaiP64iLyikxYDhAWCjKdjg00xn7XrtNtDUsUxdVn9523oCthMVojgFIo+IpYfmZd
         vxpA==
X-Gm-Message-State: AOJu0Yzi+cwoYZIEQtBz+PGPlR1nc+Z3C9NzUQuz3OfxQB/X6OWn63W2
	qicy+5jsKVR9rfrka4L+a3QFAW5Mnz81qbLpHozoL5akq3XHVamDpvVv1gpi+ZPeExh54z4Hgg3
	V4s65SF8=
X-Gm-Gg: AeBDietG+wnqtJM7UcwuhJppws6pI1GcNGawGYkJaAyzEdyRlFI88kYglMUUfcpwkql
	ndQUyyJ6aE/p5R5xGn5keTvbn5zj3jL/HJBOQ3IMEbCdxrCa6YVii9Am3STfLQs0cpGvHvrSKzG
	rIj9tfJovil74MizACyKU2BENRH/6hw3qDpOHGm3oPfSe29J9+P+Q07dnExoo/VOD2rE0YRSyNl
	VO/lWnu+jzR0S5/J0DqV4Je/GYJEs9zBEnv3gXEjB7YBFVIuaAYH9BysmHuGlhavv8fVacV1fH8
	bwXziqnId4sXKpxDTNAI/EvTb+RSwz58jVket0hkwxc8PjRtN5Mt9I+OOlN3LyYx2iDwLEu1DXr
	EJr3442DHCvi8cD/sZ7qXTxr7JcbTLu+R2rMcBl3m8M78h0CR1zpKa4omOc1a4SeGrYImoaYK9y
	MnQ4meA2J3tJGJp6zDSmpY0BNl3JvbuDwt/bLrJa9rSh2h9m/FXUdxzlpr2A2yiU1lSDBWcoJqZ
	1z/OP6oYca1IdsThM3rm91gdpYupq/nP0fBDnkhfQoByyVOeUtJxb9rYhkEj20wyQmdXXuxIm68
	1ueDRlb4BaoZJpmCuP27oUmV5aw=
X-Received: by 2002:a05:6870:d154:b0:417:392e:4e67 with SMTP id 586e51a60fabf-42aded189acmr11403022fac.20.1776805330976;
        Tue, 21 Apr 2026 14:02:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42c05ca16e2sm5373946fac.15.2026.04.21.14.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 14:02:10 -0700 (PDT)
Date: Tue, 21 Apr 2026 17:02:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 15/16] repack: introduce `--write-midx=incremental`
Message-ID: <aefl0ZQ0H3w7xi8a@nand.local>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1776803827.git.me@ttaylorr.com>
 <6119f15d3e8619f75c7dfb2e5dcf67e9f5fafc41.1776803827.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6119f15d3e8619f75c7dfb2e5dcf67e9f5fafc41.1776803827.git.me@ttaylorr.com>

On Tue, Apr 21, 2026 at 04:37:57PM -0400, Taylor Blau wrote:
> ---
>  Documentation/config/repack.adoc   |  18 ++
>  Documentation/git-repack.adoc      |  39 ++-
>  builtin/repack.c                   |  49 ++-
>  midx.c                             |  31 ++
>  midx.h                             |   3 +
>  repack-geometry.c                  |  13 +-
>  repack-midx.c                      |   5 +
>  repack.c                           |  56 +++-
>  repack.h                           |  10 +-
>  t/meson.build                      |   1 +
>  t/t7705-repack-incremental-midx.sh | 500 +++++++++++++++++++++++++++++
>  11 files changed, 701 insertions(+), 24 deletions(-)
>  create mode 100755 t/t7705-repack-incremental-midx.sh

I squashed a new test into this commit, but meant to squash it into the
latter. That test depends on functionality that is not yet introduced
until the subsequent commit, hence t7705 fails on this commit.

Since the maintainer is offline currently, I'll avoid re-submitting for
now since this won't get queued anyways. Once there is some review, I'll
re-submit the series with the test squashed into the right commit,
alongside any changes from that review.

Sorry about that.

Thanks,
Taylor
