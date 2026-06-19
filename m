Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9306B37B407
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781878085; cv=none; b=Pahc7XESiDT2Zd70QRuPQRBo1NNyo6VIZy/4Yfjb93vyl+lEOHJ0z7DIGQaYsZWIlucJHtHbUk/wOqccsLWOgmV/1NlhIDD4lMjxPuPhR4kqjediZS3gcn0Yg/c5PN3jG5S7Xu38Vfspo7P6f0nGhsCW/lEKiNqPB/PKNAw/37A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781878085; c=relaxed/simple;
	bh=sW1WG2uzBadjYdwBzPkw16MPx9zfAMVvrpT4OJ/dF3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWbJ2Yo55ROh/qwt29RjrnHs+kQVuyp3qTbparjLFjZqY0c2i8H7h0esQVVklgvCRTg+M1o8C3RXcexeDCoAVsikt5DL4tZpU3RRru8rGbb+mX2Rq8koPuobCPs/RqcnrnV27I5BBQF3yp/4aZPd1eaVTuFOE8MhKEkYuFCXvOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=DdOfzkgr; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="DdOfzkgr"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7ea6923cc94so24533807b3.3
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1781878084; x=1782482884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rK4HFa6CRA/V5N2QY3JTGPx+hEvSTuetZzSWVLAoGQY=;
        b=DdOfzkgrGIr+GdBxCLqACs+jzhw0kDBxzVFAoABhA589BMNfoVxEgGcA8INeRw2Xdp
         dgUGVmKwYNVGZYi2Cp8khd/7MyQRwQlJuvQXg4XK3ulPEb/5gMmU0cvc2/fMA0gFN7de
         cSacVXhz2bhv5OcWVJwk/ETzWBbuvMTkLVO4DnjOKlAztuN+FR3Yc5H810V7cLn1CH2d
         wXXM5av2fIr6l+yfvMNHQMyU16MtdJ4dMU+e6CQjqkof9Qu/6TO5kPBF2fOdFIfqtCXp
         DxsgxAHnAaVD8oF08KY+Y2AaCo27A0TFlbRM1Jtbgk/Hx4seQY4tAon7uafiIacnCMx0
         ssoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781878084; x=1782482884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rK4HFa6CRA/V5N2QY3JTGPx+hEvSTuetZzSWVLAoGQY=;
        b=pD6D+JQRmRYHdCmGv/8ImjBuvSd/TBZDZouPkCEckvhai673x1k3BbPPyq2VJ76yBI
         YHruBPEfr4RdoUGQw8CGIy6Yp09BHbwp7wumXd9OlvrwKY0RO+iWIvJ4gwN3jic/eOHo
         G2OP6nMyVPR9NxwA21v70OIAd6Ba4WX+0VCmZB2pkbYjppYayec7lzAG6rHe45GJWygM
         IZRXziE9ypC0nHQDt1iYES/08xRylaMYLwezyV/vcMB3hdTjtK6Qe+eOgz25/wQX9vgn
         6r8osum3t9M+yYzNd5MUeLA5HgzEPC+qsNP4Sa5nCB0jQjR28jzOCnvLFP1S6kGGv6b7
         7obQ==
X-Gm-Message-State: AOJu0Yx5gaeqvAsyYiwEX2GfCKnG50W2iMVd8bP2KdXRY236PIxT9+ab
	jVi0+csf8GfBIpQdT4tiKFtWIBJYJyGyCTuTfb9y4zNXNAN00uhuvGzxIlXCnLIB0bA=
X-Gm-Gg: AfdE7cnohfLh8uzoShn42BgdNlbmeAcN7XQQ08Sc8dxXnyIWiyJ9wWL+IrDhgh+/yf7
	3+uB0F31eo7vqpDnDyFNUsocBh/VeeM2IN1VFez8xtYNwCGqzp4EeIBZPrUaiadcT51PGJuKMfO
	TuhTINSfA8JLLb7iA+TkKEkdymhuqszUs1JpcCwUXyxvPkL0iiHBiArMMeNcsJPvoia2Doa0mIq
	VOrRZE3KlFzJ8YwnDH9DZ6g04bMjbDq9Zt6zmatTdhaN6lP/RfKQ3cSlpqLIGhlQfyWMzcbU8KQ
	uQ20ijG5KfkzyepBTRQf8pgfWG6bW7GmCNgkmVmJ052j5gJ4koJ8YiVBqkmrUoYuqw1NmDm+BWa
	zLD7LeYIO7O96L+jcqwrjMULF4bRTUJjS5wrUy4iL9QnY5ngxiMd36Ytouk4xkzB+y0XRUwVtm4
	eoC3v5Ar68hS6c4Isj2lGWptYoOAlOrWqmE0+cuVK4/TViieIa276EqPBC3gM7s9hX9Zu6qHLI6
	JTbXXAB6UWlTS6xPKJZn+EAzK5sx8JiPB24JKLbsjL9EEkiSPRvLY+Atqjg1ocj426BdfmqT6pk
	yu6L3A==
X-Received: by 2002:a05:690c:968a:b0:7f8:7e11:d023 with SMTP id 00721157ae682-801349890bfmr32577097b3.49.1781878083587;
        Fri, 19 Jun 2026 07:08:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8011d509708sm11828847b3.36.2026.06.19.07.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 07:08:03 -0700 (PDT)
Date: Fri, 19 Jun 2026 10:08:01 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Michael Montalbo <mmontalbo@gmail.com>,
	Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/4] pack-objects: support reachability bitmaps with
 `--path-walk`
Message-ID: <ajVNQYo9ntbKyPvB@nand.local>
References: <cover.1779923907.git.me@ttaylorr.com>
 <cover.1780438896.git.me@ttaylorr.com>
 <ffad584a43ebf3cb2138e8dce7daef84ab72712f.1780438896.git.me@ttaylorr.com>
 <xmqqjyrzbjyf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjyrzbjyf.fsf@gitster.g>

On Mon, Jun 15, 2026 at 01:57:28PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> > index f693cb56691..69c5da1580a 100755
> > --- a/t/t5310-pack-bitmaps.sh
> > +++ b/t/t5310-pack-bitmaps.sh
> > ...
> > +		for reuse in true false
> > +		do
> > +			: >trace.txt &&
> > +
> > +			GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
> > +			git -c pack.allowPackReuse=$reuse pack-objects \
> > +				--stdout --revs --path-walk --use-bitmap-index \
> > +				<in >out.pack &&
> > +			grep "\"category\":\"bitmap\",\"key\":\"bitmap/hits\"" trace.txt &&
>
> This gets flagged by updated test linter X-<.  Use test_grep to
> pacify it.

Oops, thanks for spotting.

Thanks,
Taylor
