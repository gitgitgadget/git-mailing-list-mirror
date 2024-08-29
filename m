Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F247B2C18C
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 23:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724973401; cv=none; b=ElynGpWAIRSnuuMYQrMr+/qu1t0GdTts/tkv7MDUFwumzPZb1Gc/sjihe/HB61i1JjdY0bKYYwiFXHEWQUKPk1VhYCs6Dgm52FAGuQ8ZpwnEzgxdqZSQVozzsCBSjgpnkiUKgu9ZzPu3zPs1xdVIBFXqjV9AQz2JOPhN7Xoeb+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724973401; c=relaxed/simple;
	bh=koDO5OWndpo7/m/gp4VRKRqXzLAgo2Sz0YBsyNCZQYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=oj7ezfLOw/rKghKY+muezJnyo3m+8cImW/BnbXyXksED4/6Zdy6QnvRxSpvBYx8Vt3m0pBrJPvWcP5iKDvfDyW6oVhq2Qh6lNAizFWn03XffkoTNM6quZikVWLjRHtCPuzfiQHkvUElr0tSvWhNGhNBWYdFISpX7gzgTNAA3+48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJnNv1ee; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJnNv1ee"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-270298a3b6eso687274fac.3
        for <git@vger.kernel.org>; Thu, 29 Aug 2024 16:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724973399; x=1725578199; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKhRsdA4MaT/uLhZIHxDDBwmoT19ZulitQ3ez5D5Aag=;
        b=cJnNv1eecJyN45Pyy7yBrnIvc4MvswQhehGwPM49rcob6GUMgSDNk+NS+Qi4BfE/zs
         e157I0DLcdZoHzJ8SJxy4TKqE0wn/BF8RPheHeJcaVaN6BV7cbtHSE/gwwwoWZsp2JD1
         5E03LAw/xXQHjBrIwQR04DEEV7FB9uoTy26RRGYKYZEa/yAjYLWT+ttho+IeMoDi5SZ3
         MkmaELNtIoU9NzSAsRgEKAZnQbXlzVjh1BJKUBV5TKZOcSdvRRcm7h98HU/m8e3xj9B5
         E+TBXtgD9NNtMMLFSRBHWMwgygBQl72Lgfy9JUPuHAMD3NKfyrcTsgT1HuftFCuskH1e
         bj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724973399; x=1725578199;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKhRsdA4MaT/uLhZIHxDDBwmoT19ZulitQ3ez5D5Aag=;
        b=R6ozQ/Bqyk1LVlNCdrZlHGQtQvb4idCpe00ERIPxLkGoW5lraOTgddMT5FqcIAwZwz
         /SNBzIKM79o5i8IaifJ+5QmvAWogHSB8ou7tKe5i6jqx/XnQqqHFVjKDlTw5+Uz1uFQN
         ZJqv4XYeXN4y0YsZnrZURT1cSo68O1mz2zOlO0rmRFJzhUvv+6mfHJjIXlGFGP/hYvxo
         Jjk4m7sJVN4DYYwtXTyhkV2ehuFM1zwW7EpQuMNhSsFiV3/HQPsrfbpGmIFkRe0Bz13k
         B9lEuLcX52N7C0MX+QMpGkqJLS3srtWDFjzRzaooADV4TNmnYI5jt8ySmWIxU5nVlZfS
         uY5A==
X-Forwarded-Encrypted: i=1; AJvYcCUh76BLimHa6JIshZS5LyoBVlJY8Ilcnk+MY5pU+I/u4KRgLLiL1IxyiifFDsP/A/ejwMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/u5PR+sTpyXhivaPZiSXzZuJmNCj0ErTxTG/pz3CFUPmV6QX9
	JuVHSZi5rsPuOyb+XpoNOWmww13xjB+/iwqG2BBv8TLc8+6on6385q6AiepgFH9BnSlIobGTw0l
	rFfvh4iHIBIRXFyB3loOsGbkHBcI=
X-Google-Smtp-Source: AGHT+IGqb8/uBVdpV7sh+h7MrTKZEJlXIz3NI973glelqMyPB1jY6HbWgvm9G0Y7QbfupubM8nnOJbdbH+vBhJxTRt8=
X-Received: by 2002:a05:6870:1684:b0:270:62ba:ff5c with SMTP id
 586e51a60fabf-2779013843fmr4746359fac.25.1724973398845; Thu, 29 Aug 2024
 16:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEg0tHRbGBBq7i78bTSfws_WZO=2W7xuDwiT2qFA5iOza8qDDA@mail.gmail.com>
 <ZtDo--AY43-bPTHG@tapette.crustytoothpaste.net>
In-Reply-To: <ZtDo--AY43-bPTHG@tapette.crustytoothpaste.net>
From: Yukai Chou <muzimuzhi@gmail.com>
Date: Fri, 30 Aug 2024 07:16:27 +0800
Message-ID: <CAEg0tHSP60oU8a2tSfTqCOiz2AOfvR46ChWPJDMF_dTVofGymg@mail.gmail.com>
Subject: Re: Tags auto fetched by "git fetch origin" but not "git fetch origin main"
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Yukai Chou <muzimuzhi@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

brian m. carlson <sandals@crustytoothpaste.net> =E4=BA=8E2024=E5=B9=B48=E6=
=9C=8830=E6=97=A5=E5=91=A8=E4=BA=94 05:32=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2024-08-28 at 23:23:57, Yukai Chou wrote:
> > In using `git fetch [<options>] [<repository> [<refspec>=E2=80=A6]]`,
> > - when a branch is specified as <refspec>, no tags are fetched automati=
cally;
> > - when no <refspec>s are specified, tags are fetched automatically.
>
> Yes, this is expected.  Tags are refs, and when you specify no refspec,
> you're asking for the default behaviour, which usually involves fetching
> tags.

According to the doc section CONFIGURED REMOTE-TRACKING BRANCHES [1],
when no refspec is specified,

  remote.<repository>.fetch values are used as the refspecs

Then according to doc of <refspec> [2],

  Since Git version 2.20, fetching to update refs/tags/* works the same
  way as when pushing. I.e. any updates will be rejected without + in
  the refspec (or --force).

So the tags are fetched due to the + in the remote.<repository>.fetch
values, are they?

> For example, if I say, `git fetch origin
> refs/heads/main:refs/heads/main`, it would be very unexpected for it to
> fetch tags as well; ... .

Actually,

  git fetch --update-head-ok origin refs/heads/main:refs/heads/main

does fetch tags "that points into the histories being fetched".

This time the refspec is given on the command line, without +.

According to the doc of CONFIGURED REMOTE-TRACKING BRANCHES [1],

  When used in this way, the remote.<repository>.fetch values do not
  have any effect in deciding what gets fetched (i.e. the values are
  not used as refspecs when the command-line lists refspecs); they
  are only used to decide where the refs that are fetched are stored
  by acting as a mapping.

[1] https://git-scm.com/docs/git-fetch#_configured_remote_tracking_branches
[2] https://git-scm.com/docs/git-fetch#Documentation/git-fetch.txt-ltrefspe=
cgt

Yukai
