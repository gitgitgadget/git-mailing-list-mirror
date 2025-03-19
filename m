Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0943213AD3F
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 03:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742356413; cv=none; b=jbcV3rd15eticBs3lmKF/rKTHFScl+CavnajDrndyH0t8GJ47P/2BAqiQhVk8iIOQ7v8utjBWQFW19o4SyrIzw2FQkrmSVILi0Vv2FGEGAEIbi+9Z5pnGR2wQ2K+eI79BlTeW1gftoaozcHtAgUV6t7wZEe5ZgfftT7OO8tmhJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742356413; c=relaxed/simple;
	bh=5FdK6Ecomp9rMNA7iY09FOt1wVPII0zixBtLdIBsdFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNgR2Sgr+Hc730gcstfigBJp705wbe+i9g9zdKn7ODDLiSj+geh0El0qOI21Lg6xIN+xfAVNWj1Sjzzrtxy0OKeRoqG8bb8u0h+HgO/fN8vRT32UUh0PP0NtJQ/+Y19W00gHrM0h0ZcQvBzmnQRaAEAllx0FyEb77mzmU1WQjzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcT5QvIG; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcT5QvIG"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-523f19d39d3so2975472e0c.2
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 20:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742356411; x=1742961211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZo4FY+lqsdpWBDoQ/a2mIWdK+1X7/viz9Lmcs9TAuU=;
        b=gcT5QvIGoFE+dZBn6Ebz0ebIRJjbO4JVOkw2MdBvzCPUMpRtvE2EoW7EAAwbNrNDtE
         eikI1LGsVQrTCRGWISjAWG7C+S6gOWl7yuaWe3sAUgzG873uinf0JncBpapA48P53KMr
         OEx5I/fRh2IMwGOov+xh6BlmYiDj7yIHsvmsYCDDANiVoDB73dLeVFd1KcpeDpdlN+x9
         3Akld8Wncwb2z51mFjaYl254oQaY3JtLeQ38CQL2H1duESm5WGzz+9wYre3tjIXGU3AP
         yQjxSJ+S7Jka9uh16Ox+vfMI8YUGVJXMe+hdZbh6pnxGCxGHrpzIzIRkUprA9+FXBlPP
         coag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742356411; x=1742961211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZo4FY+lqsdpWBDoQ/a2mIWdK+1X7/viz9Lmcs9TAuU=;
        b=Z3s7brZN2hFqPvGzakY5lPhwodBdqVc8kCj6mlHhc6g/8d2tJPUVLhhpGd4DZvlR/z
         gbowhB0gPEmZnT4tvreEYMtx77/YAw8QeVpS6ChcphbGvYAnSCa4d104TgVHxRUVWqbW
         1/SPX8ygtuNIQxhGxBMQ7jKN5fnYNv/oO1Ln2O0bOUDuIi0hKIuMrp9yV2amqjYsD+x2
         Pa0HLWRVeP3qJB4wcVLrFyvJmzlDepAeVIwym70PIg5I6tUZpblfAMWI/IK/L3ANdaNm
         MMD8WRFVUwOBgkAxsGSjJeziBWKQh8c+HTOE9vH9COOe9VzzM9NDMlxXHbHugKPE/v7r
         7lUg==
X-Gm-Message-State: AOJu0YzETifP0TUcbEijCuG7tMtFMRZyFbatUvzxc9Vt1yNi5x01Bh6X
	vhg4ZAlMbVvUp5DpSRlwqVxjJ1+MVv4MTzut3FlZ57H4IBgnA137r7EpExV6gFSjsAKexxJUXsF
	9dlDY8KqSVtwoFPabX/CrUWnPWHzfi1lXoFE=
X-Gm-Gg: ASbGncsL4wp/xt0hmqVXAja794N8MfXbzb4q/0tR0SwvuE9b5hRbLAvS26PXjW5hkFZ
	bE7ke5QEf6mONT9riYsR6vY6dkQAzX8UC5KZOmwotHpgdKEN2UBxFKodgLumk9xr/mNpywM4PjO
	Q8xZHqIxeAnJbfm/Os6L/MNThO+w==
X-Google-Smtp-Source: AGHT+IHfhUNfALJVV46ibFYW2fCmwQ3nbDYJ12u286c51oCR3g3EqjkxEfr0qqvFxqBD2b+Q0MFz/oR7sY+Gka8bD1U=
X-Received: by 2002:a05:6122:1c81:b0:520:5a87:66eb with SMTP id
 71dfb90a1353d-525890dbbffmr913034e0c.3.1742356410810; Tue, 18 Mar 2025
 20:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318115912.2978992-1-usmanakinyemi202@gmail.com> <xmqqmsdi144i.fsf@gitster.g>
In-Reply-To: <xmqqmsdi144i.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 19 Mar 2025 09:23:19 +0530
X-Gm-Features: AQ5f1JoedMWFPayk30_DQx3Woddeg_UufK66jttUDA1sfWU6qiIKvpKBtmRlP20
Message-ID: <CAPSxiM9pW4V5_TxttNrkEKhgv-qaqgRGDgr+jkSCA0vNj71NsA@mail.gmail.com>
Subject: Re: [PATCH 0/9] remove unnecessary if statement
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, johncai86@gmail.com, 
	me@ttaylorr.com, phillip.wood123@gmail.com, ps@pks.im, shejialuo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 1:51=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
> > In an earlier patch[1] which has been merged to the master,
> > We checked `repo` is not NULL before making call to `repo_config()`.
> > Later, in another patch series[2] which has been merged to next,
> > `repo_config()` was taught to allow `repo` to be NULL.
> >
> > So there is not need for checking if the `repo` is NULL before calling
> > repo_config() in the earlier patch.
>
> OK, that sounds good.
>
> Are we confident that our half-hearted choice of "there is no repo,
> so just do a very-early-config thing" is appropriate for any code
> paths?
>
> At least we should be perfectly happy with that choice applied to
> all of these code paths touched by this series.
This is fine for the commands which use only RUN_SETUP. I also picked and
checked those code paths touched by this series to ensure they do what we i=
ntend
what we intend them to do. I mean, if there is any better option, that
would be cool.
>
> > Note, I have already sent the first 8 patches in [2] but, the 9th
> > patch depends on the first patch of that series.
>
> So, is this [v2 0/9] of ua/some-builtins-wo-the-repository?
>
> I think that topic has long been merged to 'next', and it is way too
> late to do a wholesale replacement like this.
It is not a replacement for that patch series but, the last patch here
9/9 depends
on the first patch in that series. That is why I sent everything together.

Thank you.
>
> > [1] https://public-inbox.org/git/20250210181103.3609495-1-usmanakinyemi=
202@gmail.com/
> > [2] https://public-inbox.org/git/20250307233543.1721552-1-usmanakinyemi=
202@gmail.com/
> >
> > Usman Akinyemi (9):
> >   config: teach repo_config to allow `repo` to be NULL
> >   builtin/verify-tag: stop using `the_repository`
> >   builtin/verify-commit: stop using `the_repository`
> >   builtin/send-pack: stop using `the_repository`
> >   builtin/pack-refs: stop using `the_repository`
> >   builtin/ls-files: stop using `the_repository`
> >   builtin/for-each-ref: stop using `the_repository`
> >   builtin/checkout-index: stop using `the_repository`
> >   builtin/update-server-info: remove unnecessary if statement
> >
> >  builtin/checkout-index.c        | 43 ++++++++++++++++-----------------
> >  builtin/for-each-ref.c          |  5 ++--
> >  builtin/ls-files.c              | 32 ++++++++++++------------
> >  builtin/pack-refs.c             |  8 +++---
> >  builtin/send-pack.c             |  7 +++---
> >  builtin/update-server-info.c    |  4 +--
> >  builtin/verify-commit.c         | 13 +++++-----
> >  builtin/verify-tag.c            |  7 +++---
> >  config.c                        |  4 +++
> >  config.h                        |  9 +++++++
> >  t/t0610-reftable-basics.sh      |  7 ++++++
> >  t/t2006-checkout-index-basic.sh |  7 ++++++
> >  t/t3004-ls-files-basic.sh       |  7 ++++++
> >  t/t5400-send-pack.sh            |  7 ++++++
> >  t/t6300-for-each-ref.sh         |  7 ++++++
> >  t/t7030-verify-tag.sh           |  7 ++++++
> >  t/t7510-signed-commit.sh        |  7 ++++++
> >  17 files changed, 118 insertions(+), 63 deletions(-)
