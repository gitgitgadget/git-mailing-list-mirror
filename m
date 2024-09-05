Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129811759F
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 02:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725501727; cv=none; b=aK+E4gKf2A/mPdXEdc34EgNcJWplps9Miwka4aAHvJPLxYtmLN1qY7wfEuU5wk9TSukyss5NYejEAHQ16BwvHbzRFK/QWk40I9uVr+W/qEgeLnREqoR2z83ZDhCKCJyaSguz8bHWLM2rxQeu/Wk3MGzbWMDUNGYfACw4isRawcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725501727; c=relaxed/simple;
	bh=+1yBStIS5Xgo70ils45tm9KheVsy5DQygtPZRm++HpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sy9jlNZY1Cski+p4rcFGNrCEOjULPFDbdGumST1TcWwxjBpBKc6SPgcdNiuXmfN27ZndCs/rA4mHrecdJ2cWhsMnqFrgsLGJS+kFQbi/BVoqOf1CCwl9IpP+yXXvl1NKr5gNQfGRDd5wjcHgLWRWg8yg6rp085YOzNYZkqRP8+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFn+Kb6h; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFn+Kb6h"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82a22127e97so11333039f.0
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 19:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725501725; x=1726106525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/nqNcIv6t4SO5W4zA2jrF2EJqE98nvEJGdaL7YOXp0=;
        b=CFn+Kb6hCKm4i1irekCLV3/Rf1h2A8Qr5f3HyIR9K01SXfAPmjTEfX72Y3dM0Fq1M3
         V3TC4IpiYP1TptggHtqvPtPxjcatcD9K1znDEOKL+4BSe8+I6PipON97sUtPMrh4Aj5V
         eElCYOrfwaM0I2SsLZhSOAX/XWGWo/U1GYKeu6lN7GAqVyBmX9ZEcEDsS8G0KUXynIsq
         GzU3UJfsPwhbYb6x86zKFSXPkpMff/d7/oKtyKx5YaGE5hQ2KeZxVyqt/6hsL5QR6/0z
         vtZp0SRzDKlkv53za6iHVjFjdv9wZ8aoiZd43A9dHdSAUQLqsc9IKAWV7uY/2Xs1N402
         lOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725501725; x=1726106525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/nqNcIv6t4SO5W4zA2jrF2EJqE98nvEJGdaL7YOXp0=;
        b=EMcKwRztJjJG+e16MCzvR2YZ1j1pBXZ3xTxqyqVg6tmrNcUrJSYXm9nHbDgbPM0WH8
         l1IjX3inoSgCODPS0KhqFT7fDwbCjVuBV3GdyjumtGvLGJ3I/xAg7W+aQ5uQ2hVN9iuD
         2NfanC2FSHqeA9fw5uSYxuAxTntJvnqHDUQZle9Y+R5n2BdxTfTPf/UIraZhbUmjYPiD
         RrqmvzXtWLJyI39488d1NAIoivMASveaelsJTsthpWfO5ktpeb+qR7teHFvrmRrtiOSO
         iaPX+BGP2qKSj5p5DPkXkd/3ew/ve+oMDnkmJWh8K+8t2/AWHFmTMXDxTkRNhA6dIEuP
         2K4w==
X-Forwarded-Encrypted: i=1; AJvYcCVatiFl91b8U/TXeR+k79onf274GiOcyFgKIfoSxWxulWKdY0HJW5kiGPgBkzJpOhZ4WEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT3632wMbbd2wkhz96VN4xhumJzs/Oi2tzMVbiWJMDQK28B1Yo
	oCfjHEjTeI9xXew8gCY6trAdKH4MjU2YsMpuzeOMvvt+I6uO7TBBWl+IP2cZ7hwQTMOPu0U6tWz
	5n5Z/e37ZOVq4IOsSY5qgnG1q3SYz9w==
X-Google-Smtp-Source: AGHT+IFzjlSFySPvQ6a7Ieh8pKb73TnQFJlau9L9dEkTxkbsqihLP+BmOkWxBbw1Ar9iAlC8a5iT0vj2UrQKKZtzmCA=
X-Received: by 2002:a05:6602:2c91:b0:81f:b38c:3537 with SMTP id
 ca18e2360f4ac-82a648b21ddmr1051177439f.10.1725501724976; Wed, 04 Sep 2024
 19:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724656120.git.ps@pks.im> <da1c23a9ccf8c797ebcbe6ce5a8243c1d051fad6.1724656120.git.ps@pks.im>
 <xmqq5xrb6naw.fsf@gitster.g>
In-Reply-To: <xmqq5xrb6naw.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 4 Sep 2024 19:01:52 -0700
Message-ID: <CABPp-BHAnAfyqfRiMg7Xr0DyAqP0CGgT_XOA=tp42+T-knCReg@mail.gmail.com>
Subject: Re: [PATCH 21/22] merge-ort: fix two leaks when handling directory
 rename modifications
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 3:56=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > There are two leaks in `apply_directory_rename_modifications()`:
> >
> >   - We do not release the `dirs_to_insert` string list.
> >
> >   - We do not release some `conflict_info` we put into the
> >     `opt->priv->paths` string map.
> >
> > The former is trivial to fix. The latter is a bit less straight forward=
:
> > the `util` pointer of the string map may sometimes point to data that
> > has been allocated via `CALLOC()`, while at other times it may point to
> > data that has been allocated via a `mem_pool`.

Oops.

> > It very much seems like an oversight that we didn't also allocate the
> > conflict info in this code path via the memory pool, though.

Yep.

> > So let's fix that, which will also plug the memory leak for us.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
>
> May be nice if we can hear from the original author and the area
> expert.
>
> >  merge-ort.c                         | 4 +++-
> >  t/t6423-merge-rename-directories.sh | 1 +
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/merge-ort.c b/merge-ort.c
> > index 3752c7e595d..0ed3cd06b1a 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -2710,7 +2710,7 @@ static void apply_directory_rename_modifications(=
struct merge_options *opt,
> >               struct conflict_info *dir_ci;
> >               char *cur_dir =3D dirs_to_insert.items[i].string;
> >
> > -             CALLOC_ARRAY(dir_ci, 1);
> > +             dir_ci =3D mem_pool_calloc(&opt->priv->pool, 1, sizeof(*d=
ir_ci));
> >
> >               dir_ci->merged.directory_name =3D parent_name;
> >               len =3D strlen(parent_name);
> > @@ -2838,6 +2838,8 @@ static void apply_directory_rename_modifications(=
struct merge_options *opt,
> >        * Finally, record the new location.
> >        */
> >       pair->two->path =3D new_path;
> > +
> > +     string_list_clear(&dirs_to_insert, 0);
> >  }
> >
> >  /*** Function Grouping: functions related to regular rename detection =
***/
> > diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename=
-directories.sh
> > index 88d1cf2cde9..4aaaf38be68 100755
> > --- a/t/t6423-merge-rename-directories.sh
> > +++ b/t/t6423-merge-rename-directories.sh
> > @@ -25,6 +25,7 @@ test_description=3D"recursive merge with directory re=
names"
> >  #                     underscore notation is to differentiate differen=
t
> >  #                     files that might be renamed into each other's pa=
ths.)
> >
> > +TEST_PASSES_SANITIZE_LEAK=3Dtrue
> >  . ./test-lib.sh
> >  . "$TEST_DIRECTORY"/lib-merge.sh

Looks good to me; thanks for fixing up my bugs.

Reviewed-by: Elijah Newren <newren@gmail.com>
