Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D8B188010
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687884; cv=none; b=pIZEVjYW9QkWy0SJG6PpL0DgyzDkqJKrjPh+vBu14COeo/qX4mZv05bLJ+1MNV/r/kBdHXcWeHL7OCQx1HIYCUfMLylpdMcxC4QdbYdu2dWIhG1EqJSd5VPE6N+EM8wVfXIm6FOps2nAJaGbB+jeleCqOOAqXYD0COPr9nYEBjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687884; c=relaxed/simple;
	bh=oDa/aKRXH/yDdcKJ0mIRBo0Ui27AHpAS8dd0Q/9D7VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUsh0/EjGaN+eu3V/NtdKRVx41pCoKkoMa7e5eVbR+LN+niyA+c+KjffZGCvkf/aElGJXes3uk0tsT80J8yGZS0GyHBU4cNtGP7Rr6w0kSMRsUfGjDT7wpeg6TXQvqpctQU4xSvUepR4ico/3qhLj6SXmyPqP+Urog2xUlqmE5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQyFL+zZ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQyFL+zZ"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c5b9d2195eso5490988a12.1
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 02:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727687881; x=1728292681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOIX00GkzYl1hX2e6e+W9PFxF2WJv3OXVIEg+BQjZOo=;
        b=UQyFL+zZjEnycxGpaiC9gdVwJOiwtCcaBrVEm8lpmDVUzryOu1ch0+mVTi6Bu9Lql7
         ybJ6Q8AuDofgGu8xYzWor9jSK+ypLb2dpFXKRuKV3ZFMlr2+ayElpe5dcrhhRbHYjLKd
         WISnSKS/l3QG8+O+V4kzL2Ikm7QzIxAEk+k9yRyzlYwGWm68tu0sLavfD4mN9HVCJHug
         7/ugYCYrzZSmNTQQI6+6ZF7DHNEeUEPHN/OvxR48GcneZCgsW/KKVZ9RA/kLFMebLEAF
         Cc/Yl6onI5ApcTVn2S+ryG6zyDu+TnhqixWAiLCJSHNvuo4fyYnqNZ7CRdi0/JdABRUb
         znAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727687881; x=1728292681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOIX00GkzYl1hX2e6e+W9PFxF2WJv3OXVIEg+BQjZOo=;
        b=cSW0bADQ9fD95GLE225VFN/bRdCDcrDbFMwjiN8pVcIwk2u1scYjvCFE+3qXaTh58m
         NTvfru0ewbSx3mFFQqzFoHRDFxTrVAOYQZBlSrOI393liU1aR35rv4hFxMsVSvU64tyk
         pcEJE9BJcbFvjs5cfnZ3Rib//MR0bzt0ARJsPQIqpMiRR53QjWYzArvdMqTdNRLYtlh8
         g20nwrFjRURwR8dTWbbxSJT747LlFFg2pt4oRd/Ucs3lkFc5WJY6xia07TejK442MF4W
         /Af29RYl9rPuFhsiLosbexJccq9oJSkMth/D3sy5dgABMPY/45T56qQKCjYWR3unOSPi
         E2LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUadqrnEvkV7yTfvIk5PXOMiM0RgC8+d+j4uBRCBjeQ7nHlqWG7cUbs5zmpJODmO5nySrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuZ3dWYeFnwM7mDpvVXjapcOYie6LuSRA5ojjlIFaknmYqGqoQ
	ckYELsgKS4bf6BVE6i4lZfIlDSU6bnwFjOfzbxSAv225vFf51m2sD3AJnQHzCW7xaESBHESz+/n
	7dzEM0MqmP0WDkqSekny7vjF/1gjdQSJX
X-Google-Smtp-Source: AGHT+IEYG/uGxyK18lMtpD5huN00tpAOFPHOQAYC+FhGpW2yp3kHuLWnWu5uaQrfNR/saqo9JljSJ4/VwKDnSBgJ3ZQ=
X-Received: by 2002:a50:cc03:0:b0:5c8:79fa:2e4f with SMTP id
 4fb4d7f45d1cf-5c8826084cfmr9400017a12.32.1727687880556; Mon, 30 Sep 2024
 02:18:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240910163000.1985723-1-christian.couder@gmail.com> <xmqqikuijni0.fsf@gitster.g>
 <CAP8UFD34YJ23WSjaP3m8Ao6iZja_NJWfQ0BNEsaNU_F_X3qA_Q@mail.gmail.com>
 <xmqq34lkg1ck.fsf@gitster.g> <ZvpZv_fed_su4w2-@pks.im>
In-Reply-To: <ZvpZv_fed_su4w2-@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 30 Sep 2024 11:17:48 +0200
Message-ID: <CAP8UFD1yK0vwHYh+jVNUEV0mRnbjyDTOrRjuwjOwSCn-fngVzw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Introduce a "promisor-remote" capability
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, John Cai <johncai86@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Michael Haggerty <mhagger@alum.mit.edu>, "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 9:57=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Fri, Sep 27, 2024 at 03:48:11PM -0700, Junio C Hamano wrote:
> > Christian Couder <christian.couder@gmail.com> writes:
> >
> > > By the way there was an unconference breakout session on day 2 of the
> > > Git Merge called "Git LFS Can we do better?" where this was discussed
> > > with a number of people. Scott Chacon took some notes:
> > >
> > > https://github.com/git/git-merge/blob/main/breakouts/git-lfs.md
> >
> > Thanks for a link.
> >
> > > It was in parallel with the Contributor Summit, so few contributors
> > > participated in this session (maybe only Michael Haggerty, John Cai
> > > and me). But the impression of GitLab people there, including me, was
> > > that folks in general would be happy to have an alternative to Git LF=
S
> > > based on this.
> >
> > I am not sure what "based on this" is really about, though.
> >
> > This series adds a feature to redirect requests to one server to
> > another, but does it really have much to solve the problem LFS wants
> > to solve?  I would imagine that you would want to be able to manage
> > larger objects separately to avoid affecting the performance and
> > convenience when handling smaller objects, and to serve these larger
> > objects from a dedicated server.  You certainly can filter the
> > larger blobs away with blob size filter, but when you really need
> > these larger blobs, it is unclear how the new capability helps, as
> > you cannot really tell what the criteria the serving side that gave
> > you the "promisor-remote" capability wants you to use to sift your
> > requests between the original server and the new promisor.  Wouldn't
> > your requests _all_ be redirected to a single place, the promisor
> > remote you learned via the capability?
> >
> > Coming up with a better alternative to LFS is certainly good, and it
> > is worthwhile addtion to the system.  I just do not see how the
> > topic of this series helps further that goal.
>
> I guess it helps to address part of the problem. I'm not sure whether my
> understanding is aligned with Chris' intention, but I could certainly
> see that at some point in time we start to advertise promisor remote
> URLs that use different transport helpers to fetch objects. This would
> allow hosting providers to offload objects to e.g. blob storage or
> somesuch thing and the client would know how to fetch them.
>
> But there are still a couple of pieces missing in the bigger puzzle:
>
>   - How would a client know to omit certain objects? Right now it only
>     knows that there are promisor remotes, but it doesn't know that it
>     e.g. should omit every blob larger than X megabytes. The answer
>     could of course be that the client should just know to do a partial
>     clone by themselves.

If we add a "filter" field to the "promisor-remote" capability in a
future patch series, then the server could pass information like a
filter-spec that the client could use to omit some large blobs.

Patch 3/4 has the following in its commit message about it: "In the
future, it might be possible to pass other information like a
filter-spec that the client should use when cloning from S".

>   - Storing those large objects locally is still expensive. We had
>     discussions in the past where such objects could be stored
>     uncompressed to stop wasting compute here.

Yeah, I think a new "verbatim" object representation in the object
database as discussed in
https://lore.kernel.org/git/xmqqbkdometi.fsf@gitster.g/ is the most
likely and easiest in the short term.

> At GitLab, we're thinking
>     about the ability to use rolling hash functions to chunk such big
>     objects into smaller parts to also allow for somewhat efficient
>     deduplication. We're also thinking about how to make the overall ODB
>     pluggable such that we can eventually make it more scalable in this
>     context. But that's of course thinking into the future quite a bit.

Yeah, there are different options for this. For example HuggingFace
(https://huggingface.co/) recently acquired the XetHub company (see
https://huggingface.co/blog/xethub-joins-hf), and said they might open
source XetHub software that does chunking and deduplicates chunks, so
that could be an option too.

>   - Local repositories would likely want to prune large objects that
>     have not been accessed for a while to eventually regain some storage
>     space.

`git repack --filter` and such might already help a bit in this area.
I agree that more work is needed though.

> I think chipping away the problems one by one is fine. But it would be
> nice to draw something like a "big picture" of where we eventually want
> to end up at and how all the parts connect with each other to form a
> viable native replacement for Git LFS.

I have tried to discuss this at the Git Merge 2022 and 2024 and
perhaps even before that. But as you know it's difficult to make
people agree on big projects that are not backed by patches and that
might span over several years (especially when very few people
actually work on them and when they might have other things to work on
too).

Thanks,
Christian.
