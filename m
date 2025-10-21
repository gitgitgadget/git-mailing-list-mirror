Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CAD26E71F
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 21:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761081576; cv=none; b=qgJNW9NU6KykQ2n2eZQS15arAK3jVNbWhjkfHhS9LflBe/b7q8L8huCJouQNU8weoL2Oi4NCf+o/MThK0SG5LT0QFc76l5uHrjL86UFhQQjW/y1NS7rycPYBAh4eYnctmM1OgsBuzwy2GbYwtiE0kqzYsOW39Y6NUu/hdIsyC34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761081576; c=relaxed/simple;
	bh=uELALr/F0ghJ8bZTGzZ+7uL1DCaxw+Y9DnmTJ/gsDaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9SVWsqy0ZgH1Vq+vA8vZVN4kxOEFXOMMPXnucCXRdHka9DOyQItiTDP5bKOOWgrRSTnA+OWuruaNDbMxXOhzqwdq9kwJY9WpGGJUA+1MjXVcOfZSoFjk/TiRslXmyGJrT6caA+2HQ8fPUdnSkW6HN5NmPYlW0UyrbRI8C0/+CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bayi1ztj; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bayi1ztj"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63c1413dbeeso9646101a12.0
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761081571; x=1761686371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqBdC4Q2LQ0/CopILBQxvh6skNCSciA8v9OEg4UV3a4=;
        b=Bayi1ztjskZGSZI5CqZfdLhxugZQuClTK75L8D45myQTGx6yBIIMzTe3uu3W1N5Lr6
         bCTqY3Z8r2Y1PP+4nEYcqFSkGRalKvChf36JlkA+JHvdIqFLMNtw1K0ZMV26vjMZj579
         0vpwKwrMIHtGlqqJCqSOCslo5ijvl2DPuM8MenKViN/tZeBeA5DTmadE9x8yQ7k4/6+B
         nVjRvToJH2SD75/qQy+TYhvpXi6JBuePulw8hr/e2F04lvrsgw/h4d35pIXrUsOObOIv
         +4K5vspULxPXOr1I0U8IW4F7PMcqYSOlEIpwoIR4S0rMyZU5QrjDBBVfO3vZ5YhvcZTF
         Hn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761081571; x=1761686371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqBdC4Q2LQ0/CopILBQxvh6skNCSciA8v9OEg4UV3a4=;
        b=d3iyTrmFROEaER92XBGLVHIlWZgiFslIzvqYYEazwt2id33H+gWPhsQdACKh+gAeVL
         6tDJbDZriDzUCojFDaufoj7zdsBUnVjPUeRHYzyifGUnv/66a/SNTTxpUxxArWUTc85i
         LafYlRxiN3IotXfGdEv/SoZ6lTM76oUc1NY719BIOmf88iUkxHNYNRac+v2hfvT822Tf
         deEUeMGyD5unF72txB0fBDD3T0/ap9uBo40LdhlcpBbTF7N0jeuep0kRFf7Y0P1JS/FQ
         dasVdVJqkkRcPFYZ+X2eUBp7lBCiamMPxR7gAYul2G0pq575/hOKcZf8FvDIi6FBONd/
         y18A==
X-Forwarded-Encrypted: i=1; AJvYcCWVDe6NrlFQbtFVHjUXV2bU78J8f5ElnoqlKP7bzez5eHGrUuOn0aVQDMFpU+GaZ9AN4J8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPl+O5EuY256PfYM18jdzVtSUXC3I3yPUCwqk5wtqrjAlV3Lsc
	aDdnJiPsfdVJzrQo+G78vucbAJ1P/xOAEPRopERon2+DcvKkKKfUbqsKMKJWds757v5vlKC8W8r
	y3tsR4rcKXHG1BhYaME77F1PtzfzrSpI5ZjG74tE=
X-Gm-Gg: ASbGncs/NUu0dNeT3+QeVk1WAsjf/q23RwwOhxmGJeRDsrj1Ck7PgSx52jM06BKVs6z
	KKLYNmFoI8uS39uZw+sPPsnDWiVADYlBMtIs1eHpcu15dlQpB7hcFKkzTi6IMrOoLplJYfNye32
	FwWldVzxy65KzNxneBxkD9QVMxjBfoHMAqcfuBHs3paqJFgRWdwKEmvsUrJN3EWYymU9qQWLDjS
	thC855hwdzUJX3gPfP4Lpf7yqxSpTbHEcpyLKvQPoJYVRIkbaiWp0N7br6dbcrnuMcHAeux9Tj5
	Wg2puVcvVmBL6x3CtD8=
X-Google-Smtp-Source: AGHT+IHvcs9hVU/7TOMAOUZGK8nIZ161o3WciCww87yStlOyfqhsmViu9cBehB7rnIf4a19d14s/SeWTioJEv34xNaA=
X-Received: by 2002:a05:6402:358e:b0:634:bdb3:e63f with SMTP id
 4fb4d7f45d1cf-63c1f6b1f03mr18778441a12.20.1761081570660; Tue, 21 Oct 2025
 14:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
 <20251001-b4-pks-history-builtin-v4-12-8e61ddb86317@pks.im>
 <CAOLa=ZTnsHxK2+rRsAErY_zc1Rg5WNrmcDBiPgDk38zb9TNfkQ@mail.gmail.com> <aPdyBpuLfuYOLe7q@pks.im>
In-Reply-To: <aPdyBpuLfuYOLe7q@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 21 Oct 2025 17:19:19 -0400
X-Gm-Features: AS18NWDC90m1yDfRkWG7ZtUIVrHgppRri4DD3aRfH_A-ip8o_Dx6pzrBSf-upM8
Message-ID: <CALnO6CAj2Jynun7Ns5222FFevqEF3O7ACVEU-GzT6DqUSxQNjw@mail.gmail.com>
Subject: Re: [PATCH v4 12/12] builtin/history: implement "split" subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 7:44=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Oct 14, 2025 at 09:38:51AM -0400, Karthik Nayak wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > > diff --git a/Documentation/git-history.adoc b/Documentation/git-histo=
ry.adoc
> > > index b55babe206..83d675afea 100644
> > > --- a/Documentation/git-history.adoc
> > > +++ b/Documentation/git-history.adoc
> > > @@ -40,6 +41,26 @@ rewrite history in different ways:
> > >     provided, then this command will spawn an editor with the current
> > >     message of that commit.
> > >
> > > +`split [--message=3D<message>] <commit> [--] [<pathspec>...]`::
> > > +   Interactively split up <commit> into two commits by choosing
> > > +   hunks introduced by it that will be moved into the new split-out
> > > +   commit. These hunks will then be written into a new commit that
> > > +   becomes the parent of the previous commit. The original commit
> > > +   stays intact, except that its parent will be the newly split-out
> > > +   commit.
> > >
> >
> > So in essence we do this:
> >
> >   Before split:
> >   P1 =E2=94=80=E2=94=80 C0 =E2=94=80=E2=94=80 C1 =E2=94=80=E2=94=80 ...=
 =E2=94=80=E2=94=80 CN
> >         =E2=94=94=E2=94=80(target)         =E2=94=94=E2=94=80(HEAD)
> >
> >   After split:
> >   P1 =E2=94=80=E2=94=80 S0 =E2=94=80=E2=94=80 C0' =E2=94=80=E2=94=80 C1=
 =E2=94=80=E2=94=80 ...... =E2=94=80=E2=94=80 CN
> >         =E2=94=82     =E2=94=94=E2=94=80(modified original)  =E2=94=94=
=E2=94=80(HEAD)
> >         =E2=94=94=E2=94=80(split-out hunks)
> >
> > I do wonder if S0 should contain the existing message and the new
> > message should go to C0'. So perhaps more like
> >
> >   After split:
> >   P1 =E2=94=80=E2=94=80 C0' =E2=94=80=E2=94=80 S0 =E2=94=80=E2=94=80 C1=
 =E2=94=80=E2=94=80 ..... =E2=94=80=E2=94=80 CN
> >         =E2=94=82      =E2=94=94=E2=94=80(split-out hunks)  =E2=94=94=
=E2=94=80(HEAD)
> >         =E2=94=94=E2=94=80(modified original)
> >
> > Mostly because when you say split, I would assume we keep the original
> > as is and add on top of it. I don't really have a strong argument thoug=
h
> > :)
>
> Yeah, this has already caused some discussion beforehand. I guess you
> can argue either way, and the suggestion from others was to simply allow
> the user to edit both commit messages.
>
> I don't at all mind going into that direction, but I wonder how to call
> the "--message" switch in that case. We could of course just call these
> "--first-message" and "--second-message", but that feels somewhat
> awkward.
>
> Also, I already have it in my mind that it would be cool to extend this
> command so that you can split into arbitrary many commits. That is,
> after you have split out the first commit we simply go back into
> interactive mode to create a second commit tree. Rinse and repeat until
> we have no chunks left anymore. But if we had such a mode though, then
> numbered parameters don't make much sense anymore.
>
> An alternative could be to just accept multiple "-m" arguments, and we
> then apply the messages to the respective commits? Dunno.

Or *gasp* not support "-m" at all, and require the user to put
_something_ in an editor? =F0=9F=A4=94

--=20
D. Ben Knoble
