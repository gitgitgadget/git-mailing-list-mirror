Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D5C184524
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 21:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759787102; cv=none; b=K8D0BZ+ceLMhos9E8D/SvyiuwOEXXQ778sV9Wi+3HED4uxAfZ0D2OCX64Svg0nK+XkQ+pPaBN/O5Nt8FLvmJl0W/ife7JD+Zmg4czpxIyGn3LOERHVYHOWCYmwtxQVdp4QWqA40YaOYHmPcTI97e9jsFyJhwjaLxEd87aNP0Yjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759787102; c=relaxed/simple;
	bh=QYF3qJmOVPKA0pfNBR87Bd1uo7d1g8XfXilAYDyJXEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGxVpLs2zuKdZwiZc8z6vMfZzD2rYjtvvVwd3PBfOwc7Kt5QpBOuVYJPRxqggHqyOShEgOeczKTH9z0Y0S1/tXsUhAAHJjvFuHNIJm76XzawqNdD036+rJdyHjDJ1Z+4zgz76Y0pqFr24ipbDkyVCl0m6orMaF3D3ovo6qZZqpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2tYiZ1Z; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2tYiZ1Z"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-631787faf35so9925399a12.3
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 14:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759787099; x=1760391899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33r+LESdz3yvVGv6qz4rjsDnDAzwOf5IbTMs/AiDg10=;
        b=D2tYiZ1ZuZE5sf2i9Y19N7B7nnYHw6rbgVfv77jcbO9LFez05jYUeXs37vz0LCH9sn
         WhLgWptlrlLxtaXRPQt+Lf7MhcfY12ANU+qntWO3s3mjHrIQaYate+dO2f25xX6uwNRl
         yOmArTpRqFx9XXgNmJnn/Y1+LMHCEnlqCTAt7b8avYhKDB1M9scHrOpLCjyDorCpxPkx
         9/W64HEtC0EZ6qtPzsJ8tKmKge6jntTRNUpQGWWniB+/j5axG40o4RLGGEnU6WsukjZ5
         VVIu/4AHrhVzfiU+G0bOCQnjvGQsTpdL4wbVf96uOtV8cWFTz/Yl8vLg+CM50etp1axY
         Abug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759787099; x=1760391899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33r+LESdz3yvVGv6qz4rjsDnDAzwOf5IbTMs/AiDg10=;
        b=bRLqU4uuVg5WbmEOkYiLp1NsJ6IlBP1gGIOh51O8GDW0gJmmFr12QkyBR0ifxth4jl
         SAudNMPdj/baAK8/BC9OxpFWXJ8+wKKc7/tK+giSpGmZ3hNuCyRG1WlZBFQFl0/4iS5u
         rfzAs67abpnjf80xfgO/ojiVw9CsWIJZycXZbJ7jfuQMVh8xdD3/gNSJ10qgJdzTe+wT
         htybc9yEoPyESxm8jkyUmchYPYpdZhDxi7rpVKGolMAItSjgD8zINoUuYrl/5RzKeeUS
         R5fvDI3pueD8sNWsZlj2F3e9XpiJajXm52IlV8urtnsP03ZK4hzniv0ntrRBrvaV8iD2
         5eYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXotQ+oe9AHsTYxsXD5VZP/kBDkvfZO7XOseGz7o/3SsorcOmphWR/+Vlda+5ztD0Ix0ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN/dhr9UjkUyU+1ur/zrai7h1RwlQ0O7UppAG1D04Tt1ZElBWW
	PFUIWcfXJxXXmHwme/DwblAybVHL8E2eDY/ITD/NCTL61jDTcglchCCHNfEUGohToJ7EkUssG6U
	gi4sE2XtT9bW/lLwT3b9Ojoih85Ao3pk=
X-Gm-Gg: ASbGncsQop5+GGr/1+4NiIXWhfwun3/073tSlNe2sOwnXhPyUdSbetI6F6gfmiBaecT
	D0uGsEjI73EHgDlsKcMNm/54hu9TNDRibnthKRmySvX0pcCi0MdeEZY4F8dOMIikP2JnP90fb+Z
	kdyPj3O5Kfjn+2IkBG9dwYVp0vwruCOgKFS0EgzIfPj6/ia4VxHvH7BmuhNc+zjMHH7stXFXspP
	QtuHij01ghEvSBGR81YXJwUySO607ANXxokLq+A7tWz8CvUEj5TLeHa6VeEPs0j2A==
X-Google-Smtp-Source: AGHT+IG+AFq8Y3jm1im6W9/ipUjbM14lCv+7okUP3OwNhWDO8cQ81eGL3ln1nMSpBKTz+aAreE3mOk/YXoLjNLY7MX0=
X-Received: by 2002:a05:6402:354c:b0:632:67ba:f9a7 with SMTP id
 4fb4d7f45d1cf-639346c7d6cmr14739473a12.2.1759787099349; Mon, 06 Oct 2025
 14:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
 <8df4c59c-4d27-4f36-a231-f7af32ddf149@app.fastmail.com> <51e0a55c-1f1d-4cae-9459-8c2b9220e52d@app.fastmail.com>
In-Reply-To: <51e0a55c-1f1d-4cae-9459-8c2b9220e52d@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 6 Oct 2025 17:44:47 -0400
X-Gm-Features: AS18NWCg0hALzXYgWNId3h1FRAwvKm40N9q_MGyyEHP816Gd_Iix4oCULOwNmuI
Message-ID: <CALnO6CA29HA_FOQAJp_bkskKF-6Vy0_SKVL_OyJASByvKEZTqQ@mail.gmail.com>
Subject: Re: [PATCH] doc: add a explanation of Git's data model
To: Julia Evans <julia@jvns.ca>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Julia Evans <gitgitgadget@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 3:37=E2=80=AFPM Julia Evans <julia@jvns.ca> wrote:
>
> Thanks for the review!
>
> >> 2. Don't mention that the full name of the branch `main` is
> >>    technically `refs/heads/main`. This should likely change but I
> >>    haven't worked out how to do it in a clear way yet.
> >
> > I think this is worth getting into.  This is a pretty
> > user-facing concept.
>
> I think I'll see if I can figure out a way to mention this and at the
> same time remove most of the rest of the references to the `.git`
> directory when explaining references (which you talked about
> further down), including packed refs.

A colleague will be explaining reflog for an audience tomorrow, and
decided to briefly explain refs, too=E2=80=94which tells me this is
much-needed.

For refs themselves, perhaps "git for-each-ref" is a reasonable place
to start? Since it tells you the refs you have and how to spell them
explicitly regardless of how they are stored?

--=20
D. Ben Knoble
