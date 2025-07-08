Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1962DEA92
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982748; cv=none; b=uYqiUaOXbvAuynnBWDEgoZUoLOp7RXjilN4rluUCJ+yaghq5UoR2k3ROEiaoLfx933DqgFo2sx+yOtOZKSpXRH0UPN0ooX8Iq36J2zS/w6lCjUs6wtolvS5R247TO8ujV72h9uXq4ja+zmzZ2120DhgANkS6ulF2hEW0T8tSaro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982748; c=relaxed/simple;
	bh=b7HMgee8Ry4mqGjXChiyKs+SBaBLzRp3w4wZt3FHlQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGpeuvQJ3HDnYw2NGJcFz5mfuJr3s9tyv5yZfrP7h/xkyotIaSKPCJr9IhVsXmR+E7ji6JjLY4j/tZNi8I5vm+zwxKn5ilG3gtmrNciORH97fE/Wf7KSMgKlQTPWxy2WXkcYrAcgUXqJaRfJXWsoRzPcK+QsBYD/JLGv/QHlAMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jp0wTtBT; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jp0wTtBT"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-311d5fdf1f0so4063792a91.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 06:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751982746; x=1752587546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4U8JGM0SOhkwjC5pvEeGJQSRmYhaoExVb76UsPRkrH0=;
        b=Jp0wTtBTrfd/9hKYv2tIYgbjQgVty/ZFylGc1+0iGjwHFUHqFG3HTGbetFLrQ+k3l1
         5nQUjcQZ8K8vQga8qvwYay+SEv+wbtS9PO/o0naz6ZirDYP0+mk4lRu/ODtl/Q4Jku32
         HviFzb2wr6QZkorC0JJ7++2kkzlx1ZcoVoi/Q1IoqHsq4rlIFlqDZkDmfaiPmvlZY8um
         m4WjnmTFYz49NGBACNxsauyDerMurfZW/rQ1tI6/vLwN+viUy7cOdsabZg2XI74O4tyy
         Iu2ygsLnLaWWFUj5Dt2i4kndB6xG/FnwuWkLo8swqhEtdf6zxyR6Tl9zWkDoKp1Hbs8I
         kIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751982746; x=1752587546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4U8JGM0SOhkwjC5pvEeGJQSRmYhaoExVb76UsPRkrH0=;
        b=dj4jLxC3C9vzYCvdsKYUZqyv2UFV95yDsiTwbXX9Y0PdZAU4aynADRoW0IbfMGj6yC
         VRlowb5RBdmh97s6AM66E1jvf9YDoJ/twbemJIlrZBYedBMBSDsoPdAlc6AqK8C/NQh2
         LCPi9Vo1f58BxtIK0Ko2zDzacpbEX8EMwO9gEbLFkGPqVW+FEvlZg+41OlQ2ftlkPiP4
         wOCn8uJLDGbuhrb+eolY4bUeZPzWstPaUsaV0VfSgA7k+TEAUE5AYWh3Au5dZSZd7GoC
         2dniuokNOZg2aDmZtmarkV56ZY01DW71mNcbHttDRf6dkutYCjBblH64g06Nf2Oxl1cg
         uvWw==
X-Forwarded-Encrypted: i=1; AJvYcCWFFcNsC6ffCcVY832DZMx4gitU6dXKH9M+4BuW/N+GuoF/Ctaes50yjgCiAoj1UrEOymM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZcA0WsjWEgQCC5QnuIxlW9jdo+U7QCCN38cmkpjYwpfeM3pPA
	tg+MzQIXtD9F2RpFyYSn+46yL2erSdLGkOF6wKLzh+UPl4AMr0spzROp/btAHxB0J/0n0CqDPRC
	CbxZCCCjZIa574/wm8kRAor35D/pAkqQ=
X-Gm-Gg: ASbGncs1p8fZVEcpv5hfdyUhi1IR+tJwtD/XWtTJudm+e8lzmV0o/hmZC+SKPZKjZbl
	iCZHd4oQlbik29DBAslMZExtJhe7gFs5AYSXvKgNo5LCOWhfDdcUXSi5ey3VN3vLiBIopi+Ca8v
	YUEI8RExrnFwblI+XJZ5l3HehQgNTCvmTGS+WHdvMfsT0AHM910UNRc6dddnVWwIsvMrXFUnsZW
	Thpjj2gaPZoqA==
X-Google-Smtp-Source: AGHT+IG+x3XcZGGwXfU6Fn2rNEkXvj/npN3R14nDo0NOOt/uRtkSEtVhwafkjlw2V9bJJlcZ/ZEc3gBnsmoV0z5eBp4=
X-Received: by 2002:a17:90b:3804:b0:312:da0d:3d85 with SMTP id
 98e67ed59e1d1-31aac438684mr23162619a91.6.1751982745832; Tue, 08 Jul 2025
 06:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751630981.git.ayu.chandekar@gmail.com> <22fbbc8cf1b5cd622197e6d9f009acdbbcc0e802.1751630981.git.ayu.chandekar@gmail.com>
 <aGtkZgbJhO-GQ1XX@pks.im>
In-Reply-To: <aGtkZgbJhO-GQ1XX@pks.im>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Tue, 8 Jul 2025 19:22:14 +0530
X-Gm-Features: Ac12FXx4Hymg39X7bVVpWRvwISJP1faM51n9A3g1550zyhEGJOZF9siNanlm_ME
Message-ID: <CAE7as+ZVk0jNb7jXZgrUBHpMAMQqB_3D04qmR-rsjeKNg2mdoA@mail.gmail.com>
Subject: Re: [GSOC PATCH v3 2/2] builtin/prune: stop depending on 'the_repository'
To: Patrick Steinhardt <ps@pks.im>
Cc: christian.couder@gmail.com, git@vger.kernel.org, shejialuo@gmail.com, 
	shyamthakkar001@gmail.com, gitster@pobox.com, usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Mon, Jul 7, 2025 at 11:38=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Fri, Jul 04, 2025 at 07:42:35PM +0530, Ayush Chandekar wrote:
> > diff --git a/builtin/prune.c b/builtin/prune.c
> > index dab3c19b6f..320e9c2341 100644
> > --- a/builtin/prune.c
> > +++ b/builtin/prune.c
> > @@ -173,20 +171,19 @@ int cmd_prune(int argc,
> >       expire =3D TIME_MAX;
> >       save_commit_buffer =3D 0;
> >       disable_replace_refs();
> > -     repo_init_revisions(the_repository, &revs, prefix);
> >
> >       argc =3D parse_options(argc, argv, prefix, options, prune_usage, =
0);
> >
> > -     if (the_repository->repository_format_precious_objects)
> > +     repo_init_revisions(repo, &revs, prefix);
> > +     if (repo->repository_format_precious_objects)
> >               die(_("cannot prune in a precious-objects repo"));
> >
>
> Okay, we now only end up using the passed-in potentially-NULL `repo`
> after we have called `parse_options`. Makes sense.
>
> > diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
> > index 6824581317..8f59b867f2 100755
> > --- a/t/t1517-outside-repo.sh
> > +++ b/t/t1517-outside-repo.sh
> > @@ -114,4 +114,11 @@ test_expect_success 'update-server-info does not c=
rash with -h' '
> >       test_grep "[Uu]sage: git update-server-info " usage
> >  '
> >
> > +test_expect_success 'prune does not crash with -h' '
> > +     test_expect_code 129 git prune -h >usage &&
> > +     test_grep "[Uu]sage: git prune " usage &&
> > +     test_expect_code 129 nongit git prune -h >usage &&
> > +     test_grep "[Uu]sage: git prune " usage
> > +'
> > +
> >  test_done
>
> And we have another test that verifies that all of this works outside of
> a repository.
>
> This addresses my review comments, so this version looks good to me.
> Thanks!
>
> Patrick

Thanks a lot for reviewing!

Ayush
