Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E22877F10
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725554638; cv=none; b=OWZh9QlnPPsVyF4xjV58t7MkObKmbupHDfPbazJ0Op3ItMGJiaLGrdnMNtL/6ziRGNRLeTNX4J5EE5Bqn9lfbUUgtKQ8CwPTxAOcZAyxcw9pIIZ1pmMLN4e2ehPg4m+WD8AM+IaPuZoGHczBCDMawSc0DEfaU6QDQPcxwo4sE34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725554638; c=relaxed/simple;
	bh=caxRU/fjFYiSJloCGSFsZKimX7m5aPVUoXdMbgk/0/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjUz6eEdDrPy/et7wTjLTyG2ScvqtL97O0viSfxCr1I1CEuAUSistyTcogaHOQMi35TN55pbgYEWS9s1+M0Wgra02b8TrTZJzu+z6wRjbf2mnKtEDkAiSwzhR+0nV4pyoOMqa8GdCHr3SFvZoClRT4vacOBGFTaiZPuamhu9exc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVcsWj5Q; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVcsWj5Q"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d8a4bad409so791786a91.0
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 09:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725554637; x=1726159437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EX7/LWTMWLJCbeqRMnlK1U+jes4MgNbzh1dck9mTe6M=;
        b=eVcsWj5Q70YZdIOGBPOLz7XgHx7zw3YSP88r1kE6HdlpckrUvSfDZAmPbYQUyAWNhM
         Agn5Nlb3T8FuomIZz5YycSWl1wxQyCcma/3ooDMIi5lT9ZKV69ioXZQaelyel5m+YMW3
         8t3XSfwv52d2MNm/Vmj3wtHBaEfDzViBDgfZkRDYkHRJabo4AeKPglW1ksY126w3Y73D
         l0HQulfeRnJUeGTJ6bvpUSzYr8g5iVw/BKWDdtfX2Zuz4xK1H0lsMftclf2/f55d91ot
         W0Pj3+w6/q81A7MnN4DsByQYwuyVdtqM4pGUgSYFNiJBns475zP5YJOu05LvuzfUx5bJ
         t8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725554637; x=1726159437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EX7/LWTMWLJCbeqRMnlK1U+jes4MgNbzh1dck9mTe6M=;
        b=LcY4CqubQS1MIno6KWCZOnn4oISyS6+0BY94YwXMb36bj19FblHnm/9+xpZSSHQIrk
         qm5sbo1iq0krcyVom6dVNOpIWGZ4OXyMBzpok9EpTbRKkmcohGEDmLg2uKWHjT9A/gRt
         sSGKkdvS4wZJBwf9a+I9VAB6o+WEEbgM0TCUePX2P1yWzgbBkhIalZOIt47K8wRV4w6J
         LRJZCz8cSSYf0BxEGYkyU7Of/2uUiBvWFPUZd0Int5/9tTVgDRI40l5s7UfO9V8H3bbP
         Rd7HpNpdoYA2C5JQebbv4Bts3ZwzZjAkdoUHm5OobCayApDQkp0mKY2FE/FJMb9BOX72
         2yhw==
X-Forwarded-Encrypted: i=1; AJvYcCWbcgP9sd09KsTXq5fiOiMy/1VHLf2L+HwYSRPjcI2DTZuecp2qbWaAZfujordHIOlZNr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDB1OI4d9dugQTCCY8RDDAmbr8aiFj7b2yCuYHBO+EA0Pr6bGN
	n3yYnSouy7A1ULBMedWBflkuzYqZqe+tyDw/dh3TJrOO2RQPzP3vh8/EYPInlkqXSIe1Qy5Xaqv
	DbIDfSAxAK3C5eCNaoJuMp8VSYE8=
X-Google-Smtp-Source: AGHT+IHftfGItng86p/lDVDum2ejtav8rGh8tBCoGn9lY+UBTlAffEbyKD9lCMBNBLlUml0D71h36EakKlcnEf/MO+U=
X-Received: by 2002:a17:90b:4b10:b0:2cb:4e14:fd5d with SMTP id
 98e67ed59e1d1-2d89348e171mr16398961a91.17.1725554635631; Thu, 05 Sep 2024
 09:43:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1779.git.1725472799637.gitgitgadget@gmail.com>
 <pull.1779.v2.git.1725504725976.gitgitgadget@gmail.com> <xmqqcyli3x1w.fsf@gitster.g>
In-Reply-To: <xmqqcyli3x1w.fsf@gitster.g>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Thu, 5 Sep 2024 22:13:19 +0530
Message-ID: <CAG=Um+0WinvE4CQPTwKdxMxj4xBJ9Z1SBWVrGzTMKM3CbMni0w@mail.gmail.com>
Subject: Re: [PATCH v2] remote: prefetch config
To: Junio C Hamano <gitster@pobox.com>
Cc: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"Patrick Steinhardt [ ]" <ps@pks.im>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 9:36=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/builtin/gc.c b/builtin/gc.c
> > index 427faf1cfe1..2ca3a3e7d6a 100644
> > --- a/builtin/gc.c
> > +++ b/builtin/gc.c
> > @@ -1027,6 +1027,9 @@ static int fetch_remote(struct remote *remote, vo=
id *cbdata)
> >       if (remote->skip_default_update)
> >               return 0;
> >
> > +     if (!remote->prefetch)
> > +             return 0;
>
> This, while better than ane xplicit comparison with "=3D=3D 0", is a bit
> tricky in this patch, as it is not saying "if we are told to prefetch,
> fall through to the rest of the function".  It is saying "leave if
> and only if we are explicitly configured not to prefetch".
>
> It might warrant a comment.
>
> > diff --git a/remote.c b/remote.c
> > index 8f3dee13186..05edb3a5f40 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -140,6 +140,7 @@ static struct remote *make_remote(struct remote_sta=
te *remote_state,
> >       CALLOC_ARRAY(ret, 1);
> >       ret->prune =3D -1;  /* unspecified */
> >       ret->prune_tags =3D -1;  /* unspecified */
> > +     ret->prefetch =3D -1;  /* unspecified */
>
> Or, we can just assign "1" (and drop "unspecified" comment).
>
>         ret->prefetch =3D 1; /* enabled by default */
>
> If I understand it correctly, we want this to default to true...
>
> >       ret->name =3D xstrndup(name, len);
> >       refspec_init(&ret->push, REFSPEC_PUSH);
> >       refspec_init(&ret->fetch, REFSPEC_FETCH);
> > @@ -456,6 +457,8 @@ static int handle_config(const char *key, const cha=
r *value,
> >               remote->prune =3D git_config_bool(key, value);
> >       else if (!strcmp(subkey, "prunetags"))
> >               remote->prune_tags =3D git_config_bool(key, value);
> > +     else if (!strcmp(subkey, "prefetch"))
> > +             remote->prefetch =3D git_config_bool(key, value);
>
> ... with a way for the user to turn it off.
>
> > diff --git a/remote.h b/remote.h
> > index b901b56746d..4522fdec354 100644
> > --- a/remote.h
> > +++ b/remote.h
> > @@ -77,6 +77,15 @@ struct remote {
> >
> >       struct refspec fetch;
> >
> > +     /*
> > +      * The setting for whether to prefetch from a remote
> > +      * when a fetch is invoked with a prefetch flag.
> > +      *  -1 =3D unset
> > +      *   0 =3D don't prefetch from this remote
> > +      *   1 =3D prefetch from this remote
> > +      */
> > +     int prefetch;
>
> And then we can get rid of "-1 unset" from this list.  The comment
> can become a lot more brief, as such a change would make it a simple
> Boolean flag that everybody would understand immediately.
>
> "prefetch" in the comment is superfluous, as that is the name of the
> member anyway.  "from this remote" is superfluous, as that is the
> point of having the member in "struct remote" that gives settings
> that are per-remote.
>
>         int prefetch; /* is prefetch enabled? */
>
> If we really want to have "unspecified yet" state, what we commonly
> do is
>
>  * to initialize the variable to -1 to signal "unspecified yet",
>    which you did in this patch.
>
>  * after the configuration reader returns, check if the variable is
>    still -1, and then explicitly reset it to the default value,
>    which your patch does not do.
>
>  * the code that uses the variable assumes it is either 0 or 1 and
>    there shoudl be no "unspecified yet" value.  It indeed is a bug
>    that the ariable is left unspecified as it is a sign that the
>    code to do previous step was somehow skipped.
>
> But I do not think it is needed in this case; initializing the
> .prefetch member to whichever is the default should be sufficient.
>
> Thanks.

Fair. I kept the initial value as `unset` as that could be interpreted
as a special case to do something else in the future =E2=80=94 but I agree =
that keeping
it initialized to default keeps things clearer for now since such a
case doesn't arise.

Updating my patch =E2=80=94 please let me know if there's anything else I c=
an
improve here.
