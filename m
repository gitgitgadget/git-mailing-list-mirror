Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F2C1D68A
	for <git@vger.kernel.org>; Sat, 23 Dec 2023 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLhWIgZ+"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e68e93be1so1726420e87.0
        for <git@vger.kernel.org>; Sat, 23 Dec 2023 14:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703371564; x=1703976364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKs6StjHJQp/k5TxPM5+lx7Itkh1m2TBjY5yHUWkLE4=;
        b=GLhWIgZ+6nclaQl5jt4AtE+SCIFHzACK5I9Ze/OvaO6W5elgk27zG126HyZE/hQWx5
         8/kJP+ndOgQlFA9bskfoEpHlx7JKXzZcjUCUkCBWXhafxoqjJadQGEOt+jBCh0ToTbXk
         R+vVgPZBDpqR8j6CWm0S9cvdIhy0H+CaDpLtbt61np9tV6iRLQ7cu6ieTYnvjpKOdTaZ
         EPemi3d+d0+JF6zhhPBGCouChWZIzhav3RdmxJ6um5OMU384P9Tpil2KMaU4nJgrxJez
         utk2KCicTMIsz+4Z2HNs59Hu1P95bYusjOSM00ucJuGf68ZOU8f5LYAv6BlkmjwRvAGb
         Zjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703371564; x=1703976364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKs6StjHJQp/k5TxPM5+lx7Itkh1m2TBjY5yHUWkLE4=;
        b=XysLm0WHueMYN3sXfrbu3JXCQFxm/7Pr4dnDIvqg151g7tm9kcM6yMuDin+k6zMYPc
         dypq8oTeUBWu8MU2sYt3ORe98vBukjG1khujR+61xOm0Y04ytUGlIEAnhOGhI9JUEBNu
         cysQwMnwC6JBZau0EH/i0q3qphMRXbPv3XCY23zMIgV2GQYI1ZDDUpETeD14GdUFEPkD
         as1mqGdz6/wyY24+nNQBfZUgwxEpfCN0jw67tEuWRhqzjpnJPaw/dqKJyVEsH93qT36w
         nDgDSdLj1tDRebxxB17Uk9jbvo+nv0LWv4wqVZEJukq6Tz0yHqLHWR4v8aZ1fJd7A/nq
         Eo0Q==
X-Gm-Message-State: AOJu0YwxrjMxC9+9jn0e+cHVPYgX9uCptleKz5uPrpGHRev9RTkbLW3Y
	Ozc6TgZr9YykBYF2y2KVhdaIomGKStMGnsUbSvo=
X-Google-Smtp-Source: AGHT+IHH1Cv2DkZLYVGwc3yfJi6VT11pkMh1KsiwBE8CNFUfMnC30wzvzrvI9fl+GWW3qMY5/WFtom32UaI8ifsIyo4=
X-Received: by 2002:a05:6512:14a:b0:50e:4214:10d3 with SMTP id
 m10-20020a056512014a00b0050e421410d3mr1584444lfo.69.1703371563829; Sat, 23
 Dec 2023 14:46:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqbkakqx6s.fsf@gitster.g> <ZYN-5H-2NNoRRpf-@google.com>
 <xmqqplz0p90k.fsf@gitster.g> <20231221084011.GB545870@coredump.intra.peff.net>
 <xmqqsf3vmqug.fsf@gitster.g> <20231221214550.GD1446091@coredump.intra.peff.net>
 <xmqqle9njjp3.fsf@gitster.g> <20231223100229.GA2016274@coredump.intra.peff.net>
In-Reply-To: <20231223100229.GA2016274@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 23 Dec 2023 14:45:53 -0800
Message-ID: <CABPp-BF9XZeESHdxdcZ91Vsn5tKqQ6_3tC11e7t9vTFp=uufbg@mail.gmail.com>
Subject: Re: [PATCH/RFC] sparse-checkout: take care of "--end-of-options" in set/add
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Dec 23, 2023 at 2:02=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Thu, Dec 21, 2023 at 02:04:56PM -0800, Junio C Hamano wrote:
>
> > Jeff King <peff@peff.net> writes:
> >
> > > Right, that is the "gotcha" I mentioned in my other email. Though tha=
t
> > > is the way it has behaved historically, my argument is that users are
> > > unreasonable to expect it to work:
> > >
> > >   1. It is not consistent with the rest of Git commands.
> > >
> > >   2. It is inconsistent with respect to existing options (and is an
> > >      accident waiting to happen when new options are added).
> > >
> > > So I'd consider it a bug-fix.
> >
> > So the counter-proposal here is just to drop KEEP_UNKNOWN_OPT and
> > deliberately break them^W^W^Wrealign their expectations?
>
> Yes. :) But keep in mind we are un-breaking other people, like those who
> typo:
>
>   git sparse-checkout --sikp-checks
>
> and don't see an error (instead, we make a garbage entry in the sparse
> checkout file).

I think you mean
     git sparse-checkout set --sikp-checks
or
     git sparse-checkout add --sikp-checks
(i.e. with either 'set' or 'add' in there)

Neither of these are currently an error, but I agree both definitely
ought to be.  (Without the 'set' or 'add', you currently do get an
error, as we'd expect.)

> > I do not have much stake in sparse-checkout, so I am fine with that
> > direction.  But I suspect other folks on the list would have users
> > of their own who would rather loudly complain to them if we broke
> > them ;-)
>
> Likewise, I have never used sparse-checkout myself, and I don't care
> _that_ much. My interest is mostly in having various Git commands behave
> consistently. This whole discussion started because the centralized
> --end-of-options fix interacted badly with this unusual behavior.

Well, I care quite a bit about sparse-checkout, and I would rather see
Peff's proposed fix, even if some users might have to tweak their
commands a little.

Of course, I'm not the only sparse-checkout user representative, but
Randall commented elsewhere in this thread that he used
sparse-checkout quite a bit, and he feels that "without the --,
--sikp-checks should result in an error."  In other words, he is
basically agreeing that taking Peff's fix seems more important than
strict backward compatibility here.  (His wording may not sound like
that at first glance, probably because of the 'set'/'add' omission in
the example command, but I think what he said actually amounts to
agreeing with this change.)

Finally, git-sparse-checkout(1) does say "THIS COMMAND IS
EXPERIMENTAL.  ITS BEHAVIOR...WILL LIKELY CHANGE".  I apologize for
being pulled from my intent to work on [*], which I think would allow
us to finally drop this warning (I'll still get back to it, one way or
another...), but I think this is a good case where we should take
advantage of the existing warning and simply fix the command.

Anyway, just my $0.02,
Elijah

[*] https://lore.kernel.org/git/pull.1367.v4.git.1667714666810.gitgitgadget=
@gmail.com/
