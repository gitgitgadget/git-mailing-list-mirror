Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5FE269CE5
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 22:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751407461; cv=none; b=OtH4saZiv2GHltmsqoalyiYljXIEHBGKEMt7bW2TMdWT137ISfApcUnZpb50vPbNfoe9gKTGW5svy454nZ03ZhHjAYsI4nWdaZKdFZZGz5Yxu92t5lPU28U9vy+Eywk+ylZirj/wkXvllro5gZ14RwxG6WlMtvZFuxDpxjBJIuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751407461; c=relaxed/simple;
	bh=OPnHpcsDPY2lNCOj899cF2LFQTw5KI4zZelWSts7mRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYW0t245b3q3diep2/GRaGHiXeB7r1tD6r1l1duz+PIq8zw7xe+x5YAIOc6cl9tQ4dDlf4GWsY9QClmNjaMF/WsxYX68k//Ri6xFTqt4eBtyDg28lkOF/2QUnrMafQgGn0BcGo2ZcbAGR/XTrjRfhyjN2znGYzZEAdtmTQ43gOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHly5vwL; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHly5vwL"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3141b84bf65so5990602a91.1
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 15:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751407459; x=1752012259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3boEMbhHkSQ0BaqaEoOUGV/5/+uOR8m8Z4H864eZ4k=;
        b=mHly5vwLfnOt7R+8zxj76yXKEoob+1OkQnzawWfC3OEDkKYumencHphXUqgiW3nOYl
         0KONcc5J61PiuZvZSrLUlwDpiNwOVQA/F7Zh25nmWj8el1+vtV6OQZOue8vIGn1FrC75
         GBLNvCMxygFdNoNzdNZlPDwOXSGXtOGrFELr66cUwe+lhYHU1buGC5llRFLGuF0C1yz1
         0jwH9pRCe2ySWeh1b4TD4JApJdY+r3aT9ijJPkXPor1WDK+Oe2Bddv1vp4zbNgkuQIHt
         4zVhnAzXLYHIxmoFyk1XbET2p6x4I68Ld8fi4Zgt+V/65VBR1adqyrY5v/FvbP1i/uht
         9CjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751407459; x=1752012259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3boEMbhHkSQ0BaqaEoOUGV/5/+uOR8m8Z4H864eZ4k=;
        b=ez+4sEHo/yMA9HVQQeknRIbqKRdT1xcxQ/CXJhx8RLobH/kBxT+Aq14pwGs5LH2gi8
         BYd5QX+jnl/7EOJYaFM1Ebq/Q9XUi3SDZr8CX/uJi5mvTFKYktQ+ItLgpNxutn6eIQxy
         wzOYeCzPW4lnhT/vPmi9vd2YA2jN/hu2Mt/zF3dRyegq7n8UyLAMJajgWf+o0JG0svw0
         6CSlAR4Kkzqk5PQM77N9HVD1TtGoIaJ729AnFiT16RlrV9jNV+a1MggQHX2WSKQWn81m
         l6sMQsGJpkOdcFaEqWTVkm2slPVUuxgaq+Cgs+1h+ujCXLlMfCpDNRCWzjCcpUxzWtBM
         VyDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8GZOX0dW9b2FyrLWBS93hYR63hphAC5wqPxdn02tKqmbc3RkYagXwLFvZKTXq7+dr8eA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1OyV/IBR1hH7bH0/mKyTTWBJ/QdmoplhIikyErxRuQ9ESAbCQ
	g0MlLelnS/M/PeRCgVw06mwykUcfBo9fUvewr6oknV+3lXlIJIe3uLcvPnYxEmZX82jsFblaGhs
	DbvKn4vPBwYGZs4trLTHVNwghqVCf/Sw=
X-Gm-Gg: ASbGncu4BlDOSADSDfdeJ1cPspat3zF5sZtJ5Bmv/wJ/LGkQSYeNGxBKDpFeBCJvZV+
	qZWFpZxq+BRfy2RzsxaQwqhbc8L4hSdBxiV38eVUAarV8MVMkOw2ZIrz9Ic0Y5WaYbdF78vvBV8
	wIfI6tk+YFL691eZIwJhV1BbU572pBqceKU+o1fCfChK/4nQ==
X-Google-Smtp-Source: AGHT+IGIDB3VSjLmon/qhcbS5kMI7iN02S2ogIJM3TQBaK8Sdl7dIz22HvktyPrTt/Irq8oH1qYdWIIkmTG+jQX/sjM=
X-Received: by 2002:a17:90b:5345:b0:311:abba:53d2 with SMTP id
 98e67ed59e1d1-31a90bcae27mr960299a91.17.1751407459133; Tue, 01 Jul 2025
 15:04:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751296633.git.ayu.chandekar@gmail.com> <f70de9d549f2cb744810df7a9ee09e0b3626e62a.1751296633.git.ayu.chandekar@gmail.com>
 <aGPcKgR0G72JRSlM@pks.im> <xmqqikkbkglx.fsf@gitster.g> <CAE7as+YtmRxD3P-T4bzccgJnd0Ocj0kdW00g-=3gtdoWhTRVeA@mail.gmail.com>
 <CAPSxiM8EkctHgD=to=JxwDC8L6=5xgu=vpb5=bfhQ7bL592eWQ@mail.gmail.com>
In-Reply-To: <CAPSxiM8EkctHgD=to=JxwDC8L6=5xgu=vpb5=bfhQ7bL592eWQ@mail.gmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Wed, 2 Jul 2025 03:34:07 +0530
X-Gm-Features: Ac12FXyBxtyuX4B4C2r5J8UeEDQ0UXOlmwM4JyCjvKd7bhJcmDLTxr2VqgLe_IQ
Message-ID: <CAE7as+ZC-sXs11YN-247fG5ikFUNxcGTgH2a8SQUaeAuUN7=YQ@mail.gmail.com>
Subject: Re: [GSOC PATCH v2 2/2] builtin/prune: stop depending on 'the_repository'
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, christian.couder@gmail.com, 
	git@vger.kernel.org, shyamthakkar001@gmail.com, shejialuo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 1:14=E2=80=AFAM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> On Tue, Jul 1, 2025 at 11:40=E2=80=AFPM Ayush Chandekar <ayu.chandekar@gm=
ail.com> wrote:
> >
> > On Tue, Jul 1, 2025 at 10:12=E2=80=AFPM Junio C Hamano <gitster@pobox.c=
om> wrote:
> > >
> > > Patrick Steinhardt <ps@pks.im> writes:
> > >
> > > > On Mon, Jun 30, 2025 at 10:11:05PM +0530, Ayush Chandekar wrote:
> > > >> @@ -173,20 +171,19 @@ int cmd_prune(int argc,
> > > >>      expire =3D TIME_MAX;
> > > >>      save_commit_buffer =3D 0;
> > > >>      disable_replace_refs();
> > > >> -    repo_init_revisions(the_repository, &revs, prefix);
> > > >> +    repo_init_revisions(repo, &revs, prefix);
> > > >
> > > > Does this work correctly when running outside of a repository? In
> > > > general `cmd_prune()` is not executed and would instead die as it i=
s
> > > > declared as `RUN_SETUP`, without the `_GENTLY` suffix. But when the=
 user
> > > > asks for help we may still execute the function with a NULL pointer=
.
> > >
> > > Good eyes.  "git prune -h" would safely exit in parse_options() in
> > > such a case, but this part happens before the parse_options() call.
> > >
> Hello Ayush,

Hi Usman,

> >
> > Thanks for pointing that out, Patrick. Right now, `parse_options()` is
> > called just after the `repo_init_revisions()`. I can move the call to
> > it before this.
> >
> > Although when I tried running "git prune -h", it still gave me the
> > expected output.
> Do try this outside a repo, i.e outside a git repository and try to
> run the all the test if it works.
> >

Yes, I tried it. All my tests passed as well, you can check it here:
https://github.com/ayu-ch/git/commits/precious-objects-3

Thanks,
Ayush
