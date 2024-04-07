Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9842EAF9
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712508461; cv=none; b=sOg5N4bHjZvP/kNUAmC6VER27sYOwxFiUryxbu6OLINt3lF7NnlH4GtMbUMq7fDFA+GqsffHcfY9vV4EK32G5taBz9sEtGgyHC+T4Ko9a2BlKaoxXyDBepLwxIA77gjTFf3rj3kh6oIDbhk3yv9+101nWY69qVeHTX9NapGt/bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712508461; c=relaxed/simple;
	bh=pDuaIxgw5/DlUoQRWQWCWv3cOfNeONhgg7Je6WbCR34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pulXc3uvJXfY6I1honWQXEuIbUYZeQwkC9M6pg/gPxj0rwepPh4bYk+17i6J8o2VsezOnj6PiWmoT2Nrr7pamqlwbuXayTBEk/RkzPB+MXFSlXTWoMv0YetwXGW5Qts5g23Jglw5PC9l+QmAdLAcFl26CpppRnm0rb0VAEAcfvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeWlocYZ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeWlocYZ"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a51aac16b6eso127938566b.1
        for <git@vger.kernel.org>; Sun, 07 Apr 2024 09:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712508458; x=1713113258; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bLyruPQiz1gcAQqQJ/pWNS+JW7VZETJ+GT2wapAZ1Q4=;
        b=CeWlocYZS+DfzPUrl3Cz2vs50nh/AvNTXkGWl6Tz7AqtfjB9OQAUdwmhNWCl3AmNXZ
         wYFl3pCSeqza2Is96bZTBB/U38auGffoRGpnbuspOrxBxCHP7yudUgQwefMFZOHD0yZy
         FbqB5TjkE9wPgv81oHcS1q7eWyFPnEGm88py9qLySaYHjbhLpewqKYO/I+yMlbXj2L+6
         0brMU6Yp+aW99OBFIlepudoUm+iY/4BXaUV0xcpr3en/Ttbhdir6NHQCd8LK6rYK5Ev1
         MYq5rlJFgsRDcPeuNWqqEf+zV3dz4fVoUPV717tM7RgrE2eHeh3k6W2g1FCUGPk0/BC0
         Fk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712508458; x=1713113258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLyruPQiz1gcAQqQJ/pWNS+JW7VZETJ+GT2wapAZ1Q4=;
        b=rugQDShoUlvG3XlPtTEztCo+YMw8J+eojpYCwUXa0Va4Y5XzfaNzQU6sp7oKtLRpRk
         qvQ4xU467lHb1b9EeEp/juornkcifAnYDTwLBVHhniyxvsLN/VVgUK8m002l97CAHOrb
         Q6L255+LaJsNQ3Ep900cBDbDmCe+HF4ZFBVZOE+CbeQljK23bZdjmuXWUz4AquxDmvxq
         mM3WNa5Qws5FcKdCNDnFrgBdunmB/jSlibEmSL70CXhyrFZTxU02n75MVIZsyzziwzHr
         Kt+g1+QzdsJBfNjkboa0nuLohkgtRZ862hOTZs9pAh2j5Mn1K4loU/iIbtzVNSw5VMwX
         bTPw==
X-Forwarded-Encrypted: i=1; AJvYcCUkY2klgFcrsrag5Lbaz+47rmar9XsYz1BhEb8fNsXr5Ppst+6JVpWCV3XFUl+CC4wiA00RHSJL2rPbAfHRSjxVxBKV
X-Gm-Message-State: AOJu0YwMIh15tkpr3WGCK15+/L/X51MBF3VoIgzwuF1KjYTNI+VkZ4aP
	3LQcEzXvMIe+HRousDK3aGwqfKxcvbApv/naw4+IoV6Tz1fbmi3eiHuXD6+tEAQTWKnldGuUxgR
	GgcGqY1QTtPMyiOolaMM2TYZo2dQ=
X-Google-Smtp-Source: AGHT+IFvrm2vBPwI2wBzL9EOLugLgVUWH/u5C2fDGCMRoSN87trOFRpQst1ZyXQbniW0NQsC2ERapSl7gaNhy9AR73U=
X-Received: by 2002:a50:9fe3:0:b0:56e:a76:b79a with SMTP id
 c90-20020a509fe3000000b0056e0a76b79amr6580314edf.7.1712508458150; Sun, 07 Apr
 2024 09:47:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA1Aqdvj6Eyp9jGaAxTf8p0Eh_rCPydOpin3D5QYHy8sqOoOsw@mail.gmail.com>
 <7f0da057773d39add4ede71667e9ff70@manjaro.org> <20240407013843.GE1085004@coredump.intra.peff.net>
 <xmqqzfu5hgs6.fsf@gitster.g>
In-Reply-To: <xmqqzfu5hgs6.fsf@gitster.g>
From: prpr 19xx <prpr19xx@gmail.com>
Date: Sun, 7 Apr 2024 17:47:27 +0100
Message-ID: <CAA1AqduFP-eXgVyiqJcJuThBQ8FD6ZfQbcoEUWU_++hNW8rfMQ@mail.gmail.com>
Subject: Re: Warning message in remote.c when compiling
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 7 Apr 2024 at 06:40, Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > I don't really see any need to mark the wrapper as inline. It's one
> > basic function call (on top of an interface which requires a callback
> > anyway!), and I suspect many compilers would consider inlining anyway,
> > since it's a static function.
> >
> > Ditto for remotes_pushremote_get(), though it doesn't have a forward
> > declaration.
>
> Yup.  I presonally feel that we should get rid of "static inline"
> unless they appear in header files.  The compilers should in general
> be able to do good enough job finding what to inline than we can (1)
> initially mark what to inline, and (2) update by dropping "inline"
> that is no longer appropriate as the code evolves.

The compiler is an ancient gcc 4.2.0 cross-compiler for a
mipsel-linux-uclibc environment.
It doesn't really matter though, as folk seem to agree the definition
and declaration should match, which I think they should.
I also agree that having inline probably makes no sense, as the
compiler can usually work this stuff out itself.
So I don't mind whether all the inlines get removed or they all stay,
as long as they are all effectively consistent, which they are
currently not, and the compiler righty (to my mind) complains.

Thanks.
