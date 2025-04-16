Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BE92DFA42
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 22:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744841768; cv=none; b=F1VnJH49Pr/Mk3kFpRthimuH8WYT/LBtYx5uuI9kQITpONHrX32PZuWMTM3BzFfByUyTJEXpnz4x2RA3JArtB6ZH6p5H67a+cXvxk/LFGOxWVl0KOnqDrH1L6KLeZC4BkYOKiV4pZSMlSr5zzI26p16VOLHQH6J6IDZEuyYwmy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744841768; c=relaxed/simple;
	bh=DMIuR5NMTL6/0Cpwxm4agcouHDi5z8xAZ4IqFs+gC9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJfFBOeFQ3H341HL6c3vhJfZtvxjrOeZs9fKk+4k6y9noRJiF6ZlX4u/pFB+gEOJ4s6D27ciXsG+02dGQ7AKqEanjJrrRX9+I+HyTAoeeDCdd7goavpgBl9Yjb1/9O8gCqrQ3eN2VC5JGc3Hkhvk0MlUEjPEiJf9G/kpvhAgjuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=nJ2p9MQ8; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="nJ2p9MQ8"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-476a304a8edso1184331cf.3
        for <git@vger.kernel.org>; Wed, 16 Apr 2025 15:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744841763; x=1745446563; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tlUyaBG1a9AvfW5b+I2GB4HV/5VquHjUivwgZFPFBLU=;
        b=nJ2p9MQ85eREXIA3uaRrRPJ2mNEW2so9jRf2tkE7kwh5AmN4Mm29zWUNdnaMxWYX9w
         9ANHKpEv6EV1cYwO2abgfWuu+hIRjUSR9Yz/jnuJa65veBwVdOR6dxCByGbl05bpdnBR
         XqjmLFaGEKOHwJCAbOf09+epGwjmrx5uLn7+qo7Cs0ZAAhOitCbzzkhcjw+Szv2XClFl
         9fCZrwfMoT9bO+HmsWbYzQnUpctGQ3+KkghzqMSdZuKZgGcsfXdortmqKEaIeZ9iE+Gq
         3UL40sNb57yw1xPv06v6/sV/B9uem00nKslNSpOBIoPMnTNYno/AghXB8UgX0jFXKRiL
         4wDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744841763; x=1745446563;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlUyaBG1a9AvfW5b+I2GB4HV/5VquHjUivwgZFPFBLU=;
        b=L7pPSpJhJnbMD+FO6iQHmwWb0ToI2aTRr4cix1eUIP4ios2DMJ2WPaaDdc512pXVfB
         jFcRRzcrb7UHQXFN73Lp3oWuIeZHMBULWSHQJOBv6KlERzKrw+yqredzIeTvrW8AFKiH
         MmjfoPeESv9huZeZtyb31rt4pfJWx2GSNPsUZryns3CZW5lC+G7e3AkCakyGVGm/Kc30
         6tHT2AYOApCP4bhvh4N/MAuw5A5FBF9b7qbC2fw2Rv7dIUiOpPJhTnrYcodMXLB1KUgv
         P7RK+x85oBgNsp8PyUxwM+ZnDBRHA4xHoVP6lu/iFGuBMngyRQXcwmmexcCEO+nLEgmD
         SSvg==
X-Gm-Message-State: AOJu0Yx0uAkxGuAltznzZWFUD6AgOVbDSE8M/Pu7dUZnC2hbs5IxGTKl
	qwSrijd/fqLOsgHDbuAE0R6KWRWSyZiDlDjlHsbdWIkovgxURUA6qN6+P1DZ6/o=
X-Gm-Gg: ASbGncsQ/3r9Dro9u2LMU1RMs/rH+ENqdsXJpD/IB99zR0EE5WMQdQGaPW8f6xrB6ID
	6b9iWRtVsvYo1ZzkBHZ0EpHIP1K7e4w4w/dWLO2ZFnW9IBz6ckRnhkHvbjFEwNDEJv19SNz4ORr
	BgsdkeKpNNGruj1+OPZ2+OAbe6CJOIW1C9G0D634aH/yPJ9SXxWzlYaPF/QOG6B9XWqx2DsQtG8
	HK5Fd6sTckmgaZrrddTC8vcoEK3oH8oZWE8vKvvX4gMf2TPJtYcGC6SxFqkQbKJfW28VrYpNNJB
	2U0LjC2L/eNxIjgvjRx7LQOoLD/wKwEYctJJEMsifCHjR3UGNpgaVVUAvfMAzVcjfYqwKVNaPCC
	go6mhtqeqJ7Kift4Qfp5nx4A=
X-Google-Smtp-Source: AGHT+IEQrDgf7ESBB6p1D1CrsQuuZ9/xv6gcAtwHQfqdblmEqOu/aQMpbViFT9bt1uQU/0wX5hKlyw==
X-Received: by 2002:ac8:7d90:0:b0:476:8c68:dcbc with SMTP id d75a77b69052e-47ad8098861mr39497751cf.9.1744841762894;
        Wed, 16 Apr 2025 15:16:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4796eb35f00sm116303271cf.47.2025.04.16.15.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 15:16:02 -0700 (PDT)
Date: Wed, 16 Apr 2025 18:16:01 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 9/9] repack: exclude cruft pack(s) from the MIDX where
 possible
Message-ID: <aAAsIUqkqCqjoFHf@nand.local>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1744757204.git.me@ttaylorr.com>
 <58891101f377267df120dc4a9edea2997296dbec.1744757204.git.me@ttaylorr.com>
 <CABPp-BHOSiOSFeqTutAqznTCO6Fh-kM7d2B-jF+LU1iTQzOTOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BHOSiOSFeqTutAqznTCO6Fh-kM7d2B-jF+LU1iTQzOTOw@mail.gmail.com>

On Tue, Apr 15, 2025 at 10:56:59PM -0700, Elijah Newren wrote:
> On Tue, Apr 15, 2025 at 3:47 PM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > In ddee3703b3 (builtin/repack.c: add cruft packs to MIDX during
> > geometric repack, 2022-05-20), repack began adding cruft pack(s) to the
> > MIDX with '--write-midx' to ensure that the resulting MIDX was always
> > closed under reachability in order to generate reachability bitmaps.
> >
> > Suppose (prior to this patch) you have a once-unreachable object packed
> > in a cruft pack, which later on becomes reachable from one or more
> > objects in a geometrically repacked pack. That once-unreachable object
> > *won't* appear in the new pack, since the cruft pack was specified as
> > neither included nor excluded to 'pack-objects --stdin-packs'.
>
> But immediately prior to this patch you implemented
> --stdin-packs=follow, so the once-unreachable object would actually
> appear in the pack if that new option was used.  The "(prior to this
> patch)" addition was meant to help clarify here, but to me it doesn't
> succeed.  (If it had been "(prior to this series)" it would have
> clarified that we aren't yet using the new feature from the previous
> patch.)  Perhaps you meant that geometric repacking doesn't use
> --stdin-packs=follow currently, and therefore the once-unreachable
> object won't be in the new pack, but if so I think it would be helpful
> to call that out explicitly so the reader can more easily follow which
> hypothetical state you are discussing.

Yeah, I am referring to the state of the world from repack's perspective
here. It is the case that prior to this patch (9/9) we don't use
'--stdin-packs=follow' from the repack code when invoking pack-objects,
but I can sympathize with the confusion that this creates since the
distinction between the new mode existing and having real-life callers
from other builtins is subtle.

> > If the
> > new pack is included in a MIDX without the cruft pack, then trying to
> > generate bitmaps for that MIDX may fail. This happens when the bitmap
> > selection process picks one or more commits which reach the
> > once-unreachable objects, commit ddee3703b3 ensures that the MIDX will
> > be closed under reachability. Without it, we would fail to generate a
> > MIDX bitmap.
>
> The comma between objects and commit seems insufficient.  To me, that
> feels like a contrasting thought that should start a new sentence.
> Perhaps the last three lines could read something like:
>
> """
> once-unreachable objects.  Commit ddee3703b3 ensures that the MIDX will
> be closed under reachability by including cruft pack(s); without them,
> we would fail to generate a
> MIDX bitmap.
> """

I think swapping the comma for a semi-colon would have worked as well.
I'm going to leave it as-is unless you feel strongly about it, if that's
alright with you.

> > ---
> >  Documentation/config/repack.adoc |   7 ++
> >  builtin/repack.c                 | 163 +++++++++++++++++++++++++++----
> >  t/t7704-repack-cruft.sh          |  90 +++++++++++++++++
> >  3 files changed, 242 insertions(+), 18 deletions(-)
>
> You addressed the rest of my feedback with this patch, other than the
> two items I highlighted above.  I'm excited to see how this works out.

Thanks, and thanks for the review! I'm curious to see how it turns out
myself, too ;-).

Thanks,
Taylor
