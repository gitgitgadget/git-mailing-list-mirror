Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A412B54FAD
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921606; cv=none; b=uWBaXlaDNfAHPZ4cUHjVqR3LgEXA/5+yQMSdBo6l9Nwor13FnehvPQmwKprW/uDBRe0QuXeONS14gubUhL0Er0tOyj4c/LOcB4Zz740s7dNbEc6RZJ92jSwGR/N6vORM9wIkAMAsU7rWOWa0BRfrQNySOpcBMB3IctBwNoevFE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921606; c=relaxed/simple;
	bh=9Yak3Ql6KdwHc1pgrDvCiWfTZtwN0EkalQUU0QT0gGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApNFQeGZPl0L3OAqF6EZjrSmk2PzwVoqGd/IuYNoBlGB9PEEqP0o223bOXheJcyasD5cdyNn1HAapz101NjYf1chXY9nu58x+Bk5XEwJtsGiDQu/7kcz31KsIw6pM7LcTAjzC5FSBM+uum/PpKlqGyPEkKi8KHqfKR6gTGhE4Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WL3vox4w; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL3vox4w"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55f279dca99so8987739a12.3
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 06:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707921603; x=1708526403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cz4l//ZIJ6oDFhy0b9zAWeZo93JhyjPgo2RZgbslvrE=;
        b=WL3vox4wj3jLCwgmuYV/5hOpMiR3sK6+auQPMZwNjghk3JkWw2wArhMpdDnLe+04Ft
         OqFHbe3zhKA5EVKOFD/ABE7ZlGWfCedSiui8nJ8+phYAncitQTPy59HkOttjNwWdz7nF
         qkNMc29J8WRPAFcWp56Ool9X0aK0RjLgaHmR5jES64Mz2KjIclLv7n6O1O8sVDLBY5ro
         fMB+KuzxLlWYDC7GJdwXHZM9sFiuNU2EeFWD5FC+DcyYlWB5FLWdRDmMSzWWpmvs6PJ5
         wd1vXhu39IOdXEymI8Mo7Z55Bc++xkLYRxFCemgSvZarUAR6RlUcwDxmJ5l8Lw4u6zNf
         88IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707921603; x=1708526403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cz4l//ZIJ6oDFhy0b9zAWeZo93JhyjPgo2RZgbslvrE=;
        b=kVLEAjDlHr7G5ao63k6j/Z1Szoshwq3A6lrQuW0bSalmq5ptFG0wgVr86M0ax6HUCL
         UUow4F9v7TsrcRtkyGJBlYx245cuAohtxGr3niTiD0U0pLlacQ9k6lPWyrhJSAWvDiJc
         QBuCOULhRduz6nHsWnSH3ent85ac2MfL1oQ9SBgV/qJJ0i8dbYDlw3/cnw7ihpEPjImP
         DCUbquVHCsG3shy9TWZrLJuagBodqkaSQ57zD6roi2Vsol+nAlRHY+Wss0je/SQVM8Pn
         ZlLHM6gXJa/vpnJh/EhgpjI6al5q/6jUpcOnlP4BBwnFDgR54qpXTfeykiB5hDdM9ooC
         bmnw==
X-Gm-Message-State: AOJu0YyAxyLr5PnVx61gnbETD/FWgGlyXEBkZGNejHFMXHmHBNZBfQ1f
	SizwzeJPWyMp+mjm+JQbJiP0CBjBgwdL2bdDd9c54yGjJuZbb7GNgNzHeEfd7RNrOoQcb5eaa+L
	K+iFjYmSLqd8S3af7nY5sGKBF6zE=
X-Google-Smtp-Source: AGHT+IHvsypK65NkPOQjDr9BNPPCmTj7Qdg3eJRY0zsicEzOGbnOGLcnuScL19YFAkcIy2PdmS7SN41e0Nl9nI7TfxM=
X-Received: by 2002:a17:906:5956:b0:a3d:1994:d3b2 with SMTP id
 g22-20020a170906595600b00a3d1994d3b2mr1859854ejr.74.1707921602735; Wed, 14
 Feb 2024 06:40:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208135055.2705260-1-christian.couder@gmail.com>
 <20240208135055.2705260-5-christian.couder@gmail.com> <xmqqeddmonq0.fsf@gitster.g>
In-Reply-To: <xmqqeddmonq0.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 14 Feb 2024 15:39:51 +0100
Message-ID: <CAP8UFD1mNJn-aQnx9m8HNeEB8etuYaJoZB2zBXUPQVMcJhTUCg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] rev-list: allow missing tips with --missing=[print|allow*]
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, John Cai <johncai86@gmail.com>, 
	Linus Arver <linusa@google.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 6:44=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Christian Couder <christian.couder@gmail.com> writes:

> > diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> > index b3f4783858..ec9556f135 100644
> > --- a/builtin/rev-list.c
> > +++ b/builtin/rev-list.c
> > @@ -545,6 +545,15 @@ int cmd_rev_list(int argc, const char **argv, cons=
t char *prefix)
> >        *
> >        * Let "--missing" to conditionally set fetch_if_missing.
> >        */
> > +     /*
> > +      * NEEDSWORK: These dump loops to look for some options early
> > +      * are ugly. We really need setup_revisions() to have a
>
> I would drop the "dump" and "ugly" from here.  It OK to make value
> judgement with such words in casual conversations on a proposed
> patch, but when we make a request to future developers to fix our
> mess, we should be more objective and stick to the techincal facts,
> so that they have better understanding on why we think this area
> needs more work.
>
> Perhaps something like:
>
>     These loops that attempt to find presence of options without
>     understanding what the options they are skipping are broken
>     (e.g., it would not know "--grep --exclude-promisor-objects" is
>     not triggering "--exclude-promisor-objects" option).

I have used what you suggest in V3, except for s/what/that/.

> Everything after "We really need" is good (modulo possible grammos),
> I think.  Thanks for writing it.
>
> > +      * mechanism to allow and disallow some sets of options for
> > +      * different commands (like rev-list, replay, etc). Such
> > +      * mechanism should do an early parsing of option and be able
> > +      * to manage the `--exclude-promisor-objects` and `--missing=3D..=
.`
> > +      * options below.
> > +      */
> >       for (i =3D 1; i < argc; i++) {
> >               const char *arg =3D argv[i];
> >               if (!strcmp(arg, "--exclude-promisor-objects")) {
> > @@ -753,8 +762,12 @@ int cmd_rev_list(int argc, const char **argv, cons=
t char *prefix)
> >
> >       if (arg_print_omitted)
> >               oidset_init(&omitted_objects, DEFAULT_OIDSET_SIZE);
> > -     if (arg_missing_action =3D=3D MA_PRINT)
> > +     if (arg_missing_action =3D=3D MA_PRINT) {
> >               oidset_init(&missing_objects, DEFAULT_OIDSET_SIZE);
> > +             /* Already add missing tips */
> > +             oidset_insert_from_set(&missing_objects, &revs.missing_co=
mmits);
> > +             oidset_clear(&revs.missing_commits);
> > +     }
>
> It is unclear what "already" here refers to, at least to me.

I removed it and changed the comment to just "/* Add missing tips */"
in the V3 I just sent.

Thanks.
