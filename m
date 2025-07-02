Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CCC28FAA5
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 23:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751500305; cv=none; b=npOfjvm9tDsc3pxRaw29Wdm+4GerIOdGDgyz7zJjkllx+PrS0zJ7VSKIY+mj/uiSWKulTilQ42Z/AcVwwBWEiRKhK3ZtEUAtygoYbhDYXsYrCGXai+6+/X6J0SNgoq6OFnxeBvSMlyEixIniMDFKg1kwlq6B78sanGy9QX3eSqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751500305; c=relaxed/simple;
	bh=iQyg4NRIMWIA3ixms1Io1yU2zbZw+WO9X5FCW1VEj1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9UpvyLSvWtlQt4bWJVaWP2hRJoIWfAahYM1bRrpzznlKmvaoegzHhAkEdmm5buunlTrYnv5w2fvZXkjBQg1tS3Wi5BZd/+vn+lr2zPp2c1E2JfZ3T26ybqewFN4XxfaC4YZ0GSZnXYUhKfC5eJA+adZ5rrZr42UTV4wCeCVjl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ule9/izX; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ule9/izX"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3138b2f0249so6014795a91.2
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 16:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751500302; x=1752105102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DF7cOpMcxFs/IIxi1mF2cuq3Agrx1htdjAyoi4mRKcc=;
        b=Ule9/izXh/RoMmCQcybEvVWHZMUq4fIV3kD7mVzX5YC9tFZmaJKPuSsgz72mHb7HVS
         z59X3yg4qFn2XN3NnMuLp98Ftv8IHzOOA/o1zFCor39TRrTZMsEN8za3GHInPbRe4LXP
         sIf33jN3L3IrNnLWebhrdMcqiwO8zGqTVGCq4zc1Efd7SqfqNwxGGsNDSIhVJoVyMpv3
         M6Lxn1gVmMuPjHxr9vraZ8QYqFj9r0Lu+1gRbhHv5baE+yqRHvw1YxyUZAnQs7y0fRAy
         34X9/GVJfmtO0v7oYBPFYHsimwHmmTd9/zNkQeAFIVtEz5hbJQhoTfXYt99ZJq9Wtlv9
         uOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751500302; x=1752105102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DF7cOpMcxFs/IIxi1mF2cuq3Agrx1htdjAyoi4mRKcc=;
        b=Oazssx0KzdFSRCHuk+pTQqeMgF49qe+UNgL9rpBC/jgUwDERv/s3CFyGIuvCkCpi++
         HkOxI+Y+D81GpH1dIVrur8nCrO25QLy5CgY9itKZt5AkzTQMLTWPrZcb3hDkZHYm78Yz
         Sr5wda+ZctevkPsUwfTGigtO4IMLsZVg7hSFYsMu16dhwaDFMjT4//AWGS0n46h3HTgY
         qvLK1gnJYFoOLgzmBC4+XKpUc8hMKqmuyemZQHklv3GO6KQL0HxRVOB40c79pb8o7Zt2
         82UeXms3CNmIr8NanMKoJ3XgcygEiNIzsnQ+0BEd0jJl45MV2/slVQT9FMN++hAuvUII
         kQHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo6Lg/zicofqWQLqpuzN1JpIccx9/A6l1Xa4iqn3ozLjKiA36JbG9wwCrja5wMe94YVYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYEJdrk11tEXodz5RCtKCmlvJpZZ95/6Dzy8DaU75SwX37WvRD
	Gru/hYppFGSYqsbDt8+8qjnETRzmlCWkiZJgcBqABubdcbQiAQ/eiI9JT8V0Y+mcUFDGb/I2AyM
	FubUKY/zs4RG+LZUVnseqtlb56O3+PWo=
X-Gm-Gg: ASbGncv6oE8KDcpgQ5j+YbPPWdIlJRUNdj9g7n+6XhIjqQ8V+8CRcHlX1WW0d9n1u7H
	mZWw/80LKF6MoNdKad+JPe+aNtvqwwy/IeubbSBcxXf8bFcBPRo1LkWlTjX6PeiAN9eR+E4DmHn
	VdZQ+1f3TpVUkjCv5AUESHEOuN8KbBGtMmc24e7hqLKR938HD+XhRuL/FTGnFt3wHonm9I8W6AB
	LY=
X-Google-Smtp-Source: AGHT+IFIffTAteHxL9wSVmbWFA5uSAM1pyJSBTkZ7uu+aNz/joK0SvrxVHuGxeFH5ziDBAoOMInzmU5Ct/72hhhoq9I=
X-Received: by 2002:a17:90b:3c09:b0:30e:9349:2da2 with SMTP id
 98e67ed59e1d1-31a9de8afa9mr1161244a91.4.1751500301636; Wed, 02 Jul 2025
 16:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751296633.git.ayu.chandekar@gmail.com> <f70de9d549f2cb744810df7a9ee09e0b3626e62a.1751296633.git.ayu.chandekar@gmail.com>
 <aGPcKgR0G72JRSlM@pks.im> <xmqqikkbkglx.fsf@gitster.g> <CAE7as+YtmRxD3P-T4bzccgJnd0Ocj0kdW00g-=3gtdoWhTRVeA@mail.gmail.com>
 <aGSYLJaqDziLqtXk@pks.im> <CAPSxiM9ahAPEr5fj_A1RpgYjJQmv9kZ2jYfR2Knat5yHZNDkEA@mail.gmail.com>
In-Reply-To: <CAPSxiM9ahAPEr5fj_A1RpgYjJQmv9kZ2jYfR2Knat5yHZNDkEA@mail.gmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Thu, 3 Jul 2025 05:21:29 +0530
X-Gm-Features: Ac12FXwwxjRXvGj9M5vnfaPBrEVMr41IAjt5-5N-lD4qWmYBZvGp_AJuECGxgEw
Message-ID: <CAE7as+ac6i9RZK5ay7UnAAXA8H1h9gmiHxPU6ezrVDRENZ4DAg@mail.gmail.com>
Subject: Re: [GSOC PATCH v2 2/2] builtin/prune: stop depending on 'the_repository'
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, christian.couder@gmail.com, 
	git@vger.kernel.org, shyamthakkar001@gmail.com, shejialuo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 4:48=E2=80=AFPM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> On Wed, Jul 2, 2025 at 4:17=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
> >
> > On Tue, Jul 01, 2025 at 11:39:48PM +0530, Ayush Chandekar wrote:
> > > On Tue, Jul 1, 2025 at 10:12=E2=80=AFPM Junio C Hamano <gitster@pobox=
.com> wrote:
> > > >
> > > > Patrick Steinhardt <ps@pks.im> writes:
> > > >
> > > > > On Mon, Jun 30, 2025 at 10:11:05PM +0530, Ayush Chandekar wrote:
> > > > >> @@ -173,20 +171,19 @@ int cmd_prune(int argc,
> > > > >>      expire =3D TIME_MAX;
> > > > >>      save_commit_buffer =3D 0;
> > > > >>      disable_replace_refs();
> > > > >> -    repo_init_revisions(the_repository, &revs, prefix);
> > > > >> +    repo_init_revisions(repo, &revs, prefix);
> > > > >
> > > > > Does this work correctly when running outside of a repository? In
> > > > > general `cmd_prune()` is not executed and would instead die as it=
 is
> > > > > declared as `RUN_SETUP`, without the `_GENTLY` suffix. But when t=
he user
> > > > > asks for help we may still execute the function with a NULL point=
er.
> > > >
> > > > Good eyes.  "git prune -h" would safely exit in parse_options() in
> > > > such a case, but this part happens before the parse_options() call.
> > > >
> > >
> > > Thanks for pointing that out, Patrick. Right now, `parse_options()` i=
s
> > > called just after the `repo_init_revisions()`. I can move the call to
> > > it before this.
> > >
> > > Although when I tried running "git prune -h", it still gave me the
> > > expected output.
> >
> > Well, as long as it works and as long as we have a test somewhere that
> > ensures it keeps working I'm happy.
> To add to the testing part, I noticed that there is no test for
> checking "git prune -h".
>
> You(Ayush) can add that in "t/t1517-outside-repo.sh" there is a
> similar test for that also in the file.
> "test_expect_success 'update-server-info does not crash with -h" You
> can check it out.
>
> Usman
> >
> > Patrick
> >

Hey Usman,

Thanks a lot for suggesting the test file. Will include it in the
updated version of this patch series.

Ayush:)
