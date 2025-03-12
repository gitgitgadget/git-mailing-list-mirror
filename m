Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF62A1E8327
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741815648; cv=none; b=dhGujpaAl2e8R6xdoWIizb0FtsaOqsmKIAScN5qtiHFbPaTLV9bMi5nXGLxrvCR72bMkr9OH723bsMkQkWjbtTjjDTBbkCfdQ82TmHJCA7JU74uK61amDL9f10SA7Mxd6mscnvx4un0pSgrjK/TOWStui9EYugnuMbxDGDgYLUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741815648; c=relaxed/simple;
	bh=nQVWxmnRDv/X8F7YOp4zfT92w8+io2LsX34MFrbWrfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrHusxZpJk9HN1Xs6T98z4q88sRD5Fdt3Blyfe+8/XSYZBJQWqgpPDZXKCvMEsOQM64l+nZaQQ6xYdav/CnMmsc3O2NV3ia5S1+2pyUPa/ypruKe3msVkKxAkcfsYZzrWDqnRJr7fDEwDD8MhEeC9YQYgc5TopVNZpqvqXFI40c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9qRq+rQ; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9qRq+rQ"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-8553e7d9459so6741839f.2
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 14:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741815646; x=1742420446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bU3/efZhptTFNtCmFXchB0F33gwWxIYdvZOYy3OgXSE=;
        b=g9qRq+rQS2oQUIO7pwVyprsrusKp7vSbIub4ozCNMJckStQYUeJdxnwreZfUIw8DSz
         SGtfaz1Da9lEt14QhOCxnCsXXVn90/MgbWKtFL7XEJDEVq6GjsAG5GeFaGzEUIZOeQA1
         4x4kVYCm+Nmc4cpeCTs/pPC9sJ+4lXXNjJLW0nfK70xvZjdO9RpJ6/de3jNLzurc1k/e
         zjmwNd5srPDbzaqvvCHwndM8Nw8MhSVfAG28sh20idpA8FGbS9TwImQwNALVV5dLwRF3
         IQrBu0AwlpICeaTun/UD3D1XSt2Xq+ju4WDST/94PUxFRuqlTf2juTtHpPZ8oDsTzh/b
         ovlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741815646; x=1742420446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bU3/efZhptTFNtCmFXchB0F33gwWxIYdvZOYy3OgXSE=;
        b=PP3H7+EnQImiFJMmoR78shXQVKQCtoai9tM4VTyKA9StYgXzTl/ES7l0EJcxX+8pkj
         yaKuZXgzdnpUVeMM3Y0VDNtChoy8Am90yzMgDi1JMy+/HWJcgJK1VbP14lAfsLNkQ7cQ
         kD9CPS+aY4rWmpOCQ3AMLmqaheS74bGafaXfG5MYOyL/edZDUGDelsMR9UwnF+v0kFOS
         e5RZF9kHk4Y5Ur+yrppHO5f/810QOKRo4WmvBDidY597T04MzGVdHUedklneu1WFlMoM
         1SX8RI2axQNWi2tzsX8U9idpkDEOd4RCxXux8yNRBAbtUtQkpoc5K2DnExBF4Huz6Xti
         qnhA==
X-Forwarded-Encrypted: i=1; AJvYcCVvLTm1gPQ7sQ41etU9rSyh+SdxVFCgs3fX9sdumMZLkZnKYCP7siGCqensgCbxb8qgGYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2SU369DiZiisf7xgsGZkAs5YyqlgttcjReiBZWq84bQPgkufl
	234ckJ29xpmTjcGu1SBJ6HeZD++jXGrgURmq7+l8uzVzXFh3Z6rjEt2qP0VVxf5ZEhJHSqB/qKt
	kzpAnw5BYaiFp7/QIrFDN1RzSS2s=
X-Gm-Gg: ASbGncuXPjJmJLCNDqcdNkRUjetKvQfTxS8sNn3FKZJw5Oa1Cgt2iiNgG+YT0cX7WEm
	UDUSzhtqLuidNOesu7yNgwjYohXiXy5nCeIRJRFrcokYrSRelyYfgpAG7XIYFTi1ySjoig+J7jI
	bhutRFrxLaMYEclg5fRfR0H/vHvUquOhiUjOjwvDA1u4wASvapXfxXBKXH00A=
X-Google-Smtp-Source: AGHT+IHHaYP8DfNjaenUKfhzsBvCVWeLg75LH60Q/oSFyHsya/UNZuuqhI30IKPFFdz5Z7DiEPXI8X6bkEcbxPnNnPg=
X-Received: by 2002:a05:6602:b96:b0:85b:4484:182c with SMTP id
 ca18e2360f4ac-85b448419e1mr1704039839f.11.1741815645969; Wed, 12 Mar 2025
 14:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
 <4292b22723f759c3e0f84ac1000992187a9c7f7c.1741362522.git.gitgitgadget@gmail.com>
 <Z9FAix-VKGte8UKk@pks.im> <Z9Hobtp+9esKkY/O@nand.local>
In-Reply-To: <Z9Hobtp+9esKkY/O@nand.local>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 12 Mar 2025 14:40:35 -0700
X-Gm-Features: AQ5f1JogYWSg0KCZ5ne-Om-TGmnJ9hVz_MdB5kU1a1oBR--fYPUppgbNIrzxccw
Message-ID: <CABPp-BFj08mpXGiSoZ3xZ4KamwTJ4k5wPLTCJh6hUtKSxWE52Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] merge-ort: allow rename detection to be disabled
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 1:02=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Wed, Mar 12, 2025 at 09:06:35AM +0100, Patrick Steinhardt wrote:
> > On Fri, Mar 07, 2025 at 03:48:41PM +0000, Elijah Newren via GitGitGadge=
t wrote:
> > > From: Elijah Newren <newren@gmail.com>
> > >
> > > [...] Also, there has been at least one request to
> > > allow rename detection to be disabled for behavioral rather than
> > > performance reasons, so let's start heeding the config and command li=
ne
> > > settings.
> >
> > It might be nice to provide a link to that request for more context.

Will add.

> I don't know if a link exists; I suspect the request referred to here is
> an email that Johannes Schindelin wrote to Elijah privately).

It exists: https://lore.kernel.org/git/CABPp-BG-Nx6SCxxkGXn_Fwd2wseifMFND8e=
ddvWxiZVZk0zRaA@mail.gmail.com/

...which wasn't Johannes' request.

> But I am almost certain that the behavior requested here is to disable
> rename detection to match the behavior of GitHub's prior use of libgit2
> to perform merges, where we also had rename detection disabled (for
> reasons that are unclear to me, but Peff might know).

No, if that were the sole reason, I'd say it probably only belongs in
our internal fork.  Disabling of rename detection within GitHub was a
temporary internal migration measure, not a desired end state -- at
least that's the way Johannes portrayed it to me.  I know that
"temporary" sometimes lasts longer than we want, but now that I've
become internal to GitHub, one of the things I want to do is add some
weight to that "temporary" modifier.

> > > diff --git a/merge-ort.c b/merge-ort.c
> > > index b4ff24403a1..a6960b6a1b4 100644
> > > --- a/merge-ort.c
> > > +++ b/merge-ort.c
> > > @@ -3448,6 +3448,11 @@ static int detect_and_process_renames(struct m=
erge_options *opt)
> > >
> > >     if (!possible_renames(renames))
> > >             goto cleanup;
> > > +   if (opt->detect_renames =3D=3D 0) {
>
>     if (!opt->detect_renames)
>
> ?

Yeah, I wanted an opt->detect_renames =3D=3D DIFF_DETECT_NONE, but we
never defined that and only defined DIFF_DETECT_RENAME and
DIFF_DETECT_COPY.  I'll switch it over.

> > > +           renames->redo_after_renames =3D 0;
> > > +           renames->cached_pairs_valid_side =3D 0;
> > > +           goto cleanup;
> > > +   }
> > >
> > >     trace2_region_enter("merge", "regular renames", opt->repo);
> > >     detection_run |=3D detect_regular_renames(opt, MERGE_SIDE1);
> >
> > Do we want to add a test that demonstrates that the option works as
> > expected?
>
> Yeah, having a test here would be nice.

Will add.
