Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40CE2F4A
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 05:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753247875; cv=none; b=SUTX8z4KBUl3h4ZxLOOJu4esZ0uqcZcnqktn/OtPwN3jRU5ZUdo9Q8rGqwqf+o2t601U7cRI7Gbgj382hXqnmJqIbzca7iUDXavxp0BJJdW/kMqj6WrNPhnSh2uaYLe+HPqomfHxN2qy1lhso4q0L0vWxbJe0BQEcBcyBOChUE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753247875; c=relaxed/simple;
	bh=UMXGXJiUh0Edp2PeTj1UU2WAyjaji0B4cl8Tm4SeEr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsEc/vNfB0NxKCWslub9rYnfr9COK7hZFfq1Dw4QRE6tn0D5uD2Nm/fhOWWOt0V5Zi2t7logVb0H3TYI2n8j7uEB4AnaffQc6VZ89d2YLd5im8hTfS7THw0qQNIkifL/3A6jAAcFVeOgEK8q1rYWYj4pEiW93BWu9ZJY9kZRA3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzpCp4UX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzpCp4UX"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23dea2e01e4so76347235ad.1
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 22:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753247873; x=1753852673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1Yfo9g6PtQjBtacTWKS7nZOjgyG64SQCtX3r9z0oHKU=;
        b=SzpCp4UX50CJqAxYbjVlwunm5TsR0vwQmFYqBfKPDhg9GcPFt/DYFiJIbULHxVhHqF
         Eb2522qDTO4jqCvPU1tJPY0IHpe0jSaq/F2yL80EPI1F2HdmTtF9Jj+wB8qdzAN8iKzp
         DCeaZ/wuUUiuyi2fF0itU5k2AHH0w5lSTAWkPKiz3qXX+EPWiEonrlMiQnChJbnSNkBQ
         c2B2liWYE2CSxsqgDmDpU1G5rw2M5iiWAmEYGlySBsxl0InlYj1D69uXumec2xlWu0Dr
         vM0y/IO3PCx7yEA86MtJDkYUo9RCd6HcAFEJNHVAxEhIaXCELPt7QQ7RAjVhk7hdrPgZ
         FSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753247873; x=1753852673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Yfo9g6PtQjBtacTWKS7nZOjgyG64SQCtX3r9z0oHKU=;
        b=p3TEsHpifx10jDAOmJ1rjoOB7dYrAfJ5X0QAwXS+PJSDH24+UklBVUkph/e8/4tdG6
         HJlbaC62DAURJgNGq7VK8bsVSCUeJS6bBNbjH45+aRV6ITlCjQwqNFaZmQ1rLUD1+EJk
         xzj/CIYl07FsflnIlPbcHKTDKoKWrOCarjpKKkDLys/Gz+KT2ub3LDAnkS042a/0nY5n
         Wco95ggo6Lmum9BstIXs0h/TZnb9qPxipS7okW1h1mK+HxJOVtyZXggMLbK549/jYKpM
         mw/WovZtjcwATTLFi0mPjsJxWC7jOQtfIK7YI4WuTDxnKTW2teE02l2/bcLhxMGy3k/j
         6alg==
X-Gm-Message-State: AOJu0YyJ85PY/waBm/3A4+0IlzMD50LeursUE1wgh6oKx9maW1eqtICe
	5zxdPYy8g6HsKJkPn5q2x15m8iW8VBz4Bm/UwLQqi9fTo903Uiq3e58MWE76I4yw6vMdYxlDLC/
	JgdI3vw1Fx9trLZIq+OzLifZKuFDXWZA=
X-Gm-Gg: ASbGnct/RHUIuxswmQ76Fhw9xim98hbFevD7cPy8DMqN3ol5m0LFUF0Ml6wJbqOXpPP
	zzfKVVZ00USK7VeHXMxTRUNYThuX9zta2Xd3gMwChbxU4NMWIgB68oFsiChjy8X4DnMZlfcaOJk
	AuduTOtIlwb+U0i+AlRFbH67HmLO3BSAhfyeu4kRpGPqQV5RtgnI4DlUdXhQpAeKHpIufc5CCws
	KRPAMYu
X-Google-Smtp-Source: AGHT+IHOClOc7JFot78xb9XoNuN65S1DzorA9wjx/78RnL4I+S/3BjWkO0BUH7T+RzpflL+9NSSmjPgjquo8nwHx+W0=
X-Received: by 2002:a17:903:1b46:b0:234:f200:51a1 with SMTP id
 d9443c01a7336-23f981328b8mr22942895ad.9.1753247872982; Tue, 22 Jul 2025
 22:17:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627074934.1761897-1-meetsoni3017@gmail.com>
 <20250717075009.26262-1-meetsoni3017@gmail.com> <20250717075009.26262-3-meetsoni3017@gmail.com>
 <xmqqbjpi5y6w.fsf@gitster.g>
In-Reply-To: <xmqqbjpi5y6w.fsf@gitster.g>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Wed, 23 Jul 2025 10:47:41 +0530
X-Gm-Features: Ac12FXw2Tj4HvPQz43ig7MRSeSWZfefGfHB5EHkpPWAVSjw_6Vg2N0p8dpIGMjw
Message-ID: <CAPhwyn0wLrTy0MnNYdQvoVPXUz0PyXDB0MBsDHnDR_zgA8mZmg@mail.gmail.com>
Subject: Re: [GSoC][RFC PATCH v2 2/2] t: add test for git refs list subcommand
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com, karthik.188@gmail.com, 
	Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>, 
	Kousik Sanagavarapu <five231003@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Jul 2025 at 02:31, Junio C Hamano <gitster@pobox.com> wrote:
>
> Meet Soni <meetsoni3017@gmail.com> writes:
>
> > +. ./test-lib.sh
> > +
> > +GIT_REFS_LIST_CMD='refs list'
> > +. "$TEST_DIRECTORY"/t6300-for-each-ref.sh
> > ...
> > -     git for-each-ref refs/tags/fourth-signed \
> > +     git ${GIT_REFS_LIST_CMD} refs/tags/fourth-signed \
>
> I know where your bias comes from ;-) but if this were
>
> > -     git for-each-ref refs/tags/fourth-signed \
> > +     $git_for_each_ref refs/tags/fourth-signed \
>
> it would have been easier to read the resulting test, as
> t6300-for-each-ref is and has been primarily about "git
> for-each-ref" command, and the new test script that overrides
>
>     git_for_each_ref="git refs list"
>
> before including t6300 would be a good demonstration that the new
> "git ref list" command can stand in as its replacement.
>
> > +GIT_REFS_LIST_CMD='refs list'
> > +. "$TEST_DIRECTORY"/t6300-for-each-ref.sh
> > diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> > index ce9af79ab1..74a030371c 100755
> > --- a/t/t6300-for-each-ref.sh
> > +++ b/t/t6300-for-each-ref.sh
> > @@ -5,7 +5,9 @@
> >
> >  test_description='for-each-ref test'
> >
> > -. ./test-lib.sh
> > +. "${TEST_DIRECTORY:-.}/test-lib.sh"
>
> This is probably wrong.
>
> Nobody promises that including test-lib.sh is and will forever be
> idempotent.  While this patch may not give t6300 a serious
> regression right now, I am not sure what future subtle breakage we
> are looking at for t1461.
>
> Probably this should model itself after how 8752d11d (git-blame: Use
> the same tests for git-blame as for git-annotate, 2006-03-05) moved
> a lot from existing t8001 to annotate-tests and so that they can be
> shared with new t8002.
>
> Thanks.

Apologies for the delayed response, I was away last week.

Thanks for the review. The suggestions for the test suite make sense.
I'll refactor it accordingly and send out a v3.

Thanks.
