Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD7D5674E
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824051; cv=none; b=KftBMZQXGWAScoJmgH2pEQY5b06J0Cj36o4ameJB0O5VwME+8qtQX/THFSaREEfsQnR6YPs1fGt0A7uuTjCNsaCHRPK6R140BnvcnHvkQEmzGA0AesOGp2KlpReog4o+GdVTWOhWhGETSW3yi/AQ6ORABNBOwCvEXTd4QViyozc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824051; c=relaxed/simple;
	bh=fh3eqtkNIBpvyqBylBYp/7u0dyIecBKYOvHCQS7111c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2NOAbrIHHRbXeLos+1nQp1FXjts7h6FYCjo3kgzgAXOmaq+Rzu7wL8yFyrZiFQVeT5Iw/HkaLcIkVvh7QkEehzz+MihVIzl+/UCmVeTOL4lCGY6ProZ4EM7gxu7PQU8XIXSY7TOLFxsxhfBPosYP95fsXNoC0XbWfSnUVhb+yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmvgTnjn; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmvgTnjn"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e5a0177531so4341458a91.2
        for <git@vger.kernel.org>; Tue, 05 Nov 2024 08:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730824049; x=1731428849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jonhj6PixXRetqdxzgabmljSOTQQC0V6XiFmgoTIAZE=;
        b=PmvgTnjnBvxW/Eb7ewTIz+4vpDWFN3pTW5q0nRcZ5iTpyjfQICZtuWsJRdI6X5Bbuc
         DtQD1ii2xhjOPcKx5nB0WllMsH9gM1DPRS5fgK3WmKrP43lY20lCpQGtyN0lN5zpf0lC
         lOmRaCIbRWxB1IWXz0TuWdeBF7QcQrClgy97WcE4Dm4i/rLt/BhMFQHZJ1GNPGfru9k6
         6Ham7RKDE32XF93uQa106EANydhylJuYeZE/eOTIb1vtVBIKBd+otkT6iCPDiGgkpg3y
         UmLeN5o90lbfSjyQYqaSo+T0xen/r04wvKYUEcluacHhvVfqeQSL52ykGdkKwCuu46G9
         Px0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730824050; x=1731428850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jonhj6PixXRetqdxzgabmljSOTQQC0V6XiFmgoTIAZE=;
        b=JwCuZUjlhh5pHE2SFII+8ejpFma75NPBAwpqcVU6pZLDPUcgH4BRBu23fZsV8w2BkC
         PJFdg2O5cHZ7KOAwekYwfHQH/ndvscOy+4iD/r1TmrJ9jnVcVsS1xmgeW20QKDh8uIUo
         /OqVQZ7Q2QB3thz3oaF4L9EP1HKBNEpulC5zfNhG5lE8j/VtXw6BavnExXcLpCETZ4g9
         7Gx0VZSS8un/pxeG891j+6PvHlY50plHOq9OWBjhCr4jcW9OxRlcnGmYh4HT038GsAs6
         Ej7dPrJxkh5v2/Dmf95911xu5ItNqF2PyJfmgQyK6ucSgbO6uN+uTc7qiPs3Y280VtxZ
         gpWw==
X-Forwarded-Encrypted: i=1; AJvYcCX8uljXIUVpNx6QSr5ltW9OvixyYOAgWQq266u/t8SbnVR77Le7SdA+pPThvwv19Mq8a3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+16+r9OvVPnChSeXmF2NXst/uXHYxj+XWD+0nXfkeLPwUbW9U
	nSCWXO5B0uWgkwcPwfX3mZqekI35oBW/ouUvJswgn8MQL/bnIYpggk1Kcd156cYcgF059DNeNTx
	MWxbR7Lb6BGIiLrBgDLWzYwLVJbU=
X-Google-Smtp-Source: AGHT+IFjNNi/XHGMTzqI1vlxnTiO9u9zREF6Yx5vpXUqhKUTbHSR0L2N04Q64rVEOru/KZ1HITgIjhKqA8TDjJBrtuE=
X-Received: by 2002:a17:90a:c70e:b0:2e5:5ab5:ba4b with SMTP id
 98e67ed59e1d1-2e8f107b5b4mr39663665a91.22.1730824049533; Tue, 05 Nov 2024
 08:27:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1782.v3.git.1726741439445.gitgitgadget@gmail.com>
 <pull.1782.v4.git.1728073292874.gitgitgadget@gmail.com> <Zym--GVNJt_lsQEz@pks.im>
 <b548c532-e54a-4edc-94aa-f3c2925602e6@gmail.com>
In-Reply-To: <b548c532-e54a-4edc-94aa-f3c2925602e6@gmail.com>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Tue, 5 Nov 2024 21:56:52 +0530
Message-ID: <CAG=Um+3D3iGPRv4t4DcCP=Bh7gbAQ6cSJ79jmg2h-qbSiQRkUA@mail.gmail.com>
Subject: Re: [PATCH v4] remote: allow specifying refs to prefetch
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 8:17=E2=80=AFPM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> On 05/11/2024 06:45, Patrick Steinhardt wrote:
> > On Fri, Oct 04, 2024 at 08:21:32PM +0000, Shubham Kanodia via GitGitGad=
get wrote:
> >
> >> diff --git a/Documentation/config/remote.txt b/Documentation/config/re=
mote.txt
> >> index 8efc53e836d..186f439ed7b 100644
> >> --- a/Documentation/config/remote.txt
> >> +++ b/Documentation/config/remote.txt
> >> @@ -33,6 +33,13 @@ remote.<name>.fetch::
> >>      The default set of "refspec" for linkgit:git-fetch[1]. See
> >>      linkgit:git-fetch[1].
> >>
> >> +remote.<name>.prefetchref::
> >> +    Specify the refs to be prefetched when fetching from this
> >> +    remote. The value is a space-separated list of ref patterns
> >> +    (e.g., "refs/heads/main !refs/heads/develop*"). This can be
> >> +    used to optimize fetch operations by specifying exactly which
> >> +    refs should be prefetched.
> >
> > I'm a bit surprised that we use a space-separated list here instead of
> > accepting a multi-valued config like we do for "remote.<name>.fetch".
> > Shouldn't we use the format here to make things more consistent?
>
> I agree that would be a good idea. I also think that it would be helpful
> to expand the documentation to explain exactly how the patterns are
> matched. I think "remote.<name>.prefetch" would better match the
> existing "remote.<name>.fetch" and "remote.<push>.name" config key names.
>
> Best Wishes
>
> Phillip
>

Thanks for taking the time to look at this!

Let me add context here based on a few things that have already been discus=
sed
as a part of this thread or an earlier discussion on
https://lore.kernel.org/git/CAG=3DUm+1wTbXn_RN+LOCrpZpSNR_QF582PszxNyhz5anV=
HtBp+w@mail.gmail.com/

> I'm coming rather late to the party and simply want to review this so
> that the thread gets revived. So my context may be lacking, please
> forgive me if I am reopening things that were already discussed.

I don't have a particular preference here, and this was discussed in
an earlier thread
where Junio opined (https://lore.kernel.org/git/xmqq5xrcn2k1.fsf@gitster.g/=
=E2=80=94

> I agree that it is the right place to configure this as attributes
> to remotes.  It would make it handy if we could give a catch-all
> configuration, though.  For example:
>
> [remote "origin"]
>       prefetch =3D true
>        prefetchref =3D refs/heads/* refs/tags/*
> [remote "*"]
>        prefetch =3D false
>
> may toggle prefetch off for all remotes, except that the tags and
> the local branches of the remote "origin" are prefetched.  Instead
> of a multi-value configuration variable (like remote.*.fetch) where
> we need to worry about clearing convention, we can use a regular
> "last one wins" variable that is whitespace separated patterns, as
> such a pattern can never have a whitespace in it.

which is what my implementation is based on.

> This is essentially open-coding a bunch of logic around how we parse
> refspecs. I'd propose to instead use the APIs we already have in this
> area, namely those in "refspec.h".

Is there any that you would suggest? I don't see anything in `refspec.h` th=
at
might cover a similar logic. I'd previously used `wildmatch.h`, but
that is really
only suitable for glob-style wildcards.

> Is this rename really necessary? It is not mentioned in the commit
> message, so this is surprising to me

What was previously `match_name_with_pattern` is now exposed out
from `remote.c` to be used outside. I thought given that its now applicable
outside `remote.c` it might be clearer to rename it to be more explicit
(match name of what? remote? refspec? etc)

However I agree that the higher level `refspec_match()` is a better
function to expose
anyway, and am happy to make that change.
