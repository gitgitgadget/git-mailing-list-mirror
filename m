Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFDF1D1F6F
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 12:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514256; cv=none; b=YunXq1oV/VGdFykgyRlCJG+ENoEEfTMKrF97TjovWiRZU53CaDCsxXbgS7DW2d/uHO6r8EH4kqjN/VfrfF/5+yiRlYqt8mJODiYndikWSjgxGyIjUFXCz9U0Gpaemo01F1Bs9ZmD4TcDnB2fBOnAEar8zl6QUS7bHj7AFwntz6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514256; c=relaxed/simple;
	bh=XjyoOXDROofE3Tat2/VVjqAyE8OUHl7gqVFRQGmFdXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GlqJ1N5ctCxH0RHyuDP5XDiY/QxL2OgHfiewTUHAfqQ1HMRsu3f3Fjl+m+RSqFepP7l853H51V3oKg+piZlVK/4RHkvPL1AoSHpXx9R8RNwGZdJPZLBFvFf5BJD4/MgLkqY8cr6AvRoy/C2a6f/mACjuZluSVhP6cf3dhGuGOiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hS54rdrv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hS54rdrv"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4316cce103dso25395115e9.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 05:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729514252; x=1730119052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fe3txmQ7u5Az4UZjVBjfyE/3fwRkP523tYEoMbecuQ=;
        b=hS54rdrvAnAnvn5Dn2W8oEAGPMH+v8V9NL2jZw7xsQu2lrWQS2P7A0YZCeDqbe1IIh
         goH9qFbRzaWJv1ZonW+tRFYHlZbAPhYzh36sqP9ekwdYMt1bnKTNywbjF/qsOh0samJu
         MElHyd4pJXYCpnWu7FDu9RB86JZBe1u1cj0lD0xv4YnkjkBWrECxOCa1K7nIpprqsk6p
         25dl6NnEGY5Eo2LIDQ+rVMWPK4K80l9WiIPfM3Vd7m7p0zG3hbAHCKtyZFr+9Y2Q0wP0
         SiQpetACTY5wthKpkJ8iTHM52Zx1cP7Kz0jU5qsjebM9cSHuhIehLxfYYMBdYJscHyZm
         91nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729514252; x=1730119052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fe3txmQ7u5Az4UZjVBjfyE/3fwRkP523tYEoMbecuQ=;
        b=MHc3LpeOfzSM9wJbSnrZtEZdiL3BFvjdOHGGckirKonAaFcty9vqgylJYKF4PaOy1h
         g3hbHHmTgYk2jnyrpj9zxEunI2y2ZE1tQrcM3okqAevv8vj3WbCGY/hNvAqaUg/26udj
         DV+VCIRYF/P4EibVIpX7qq9V3cYvJ1Jlwf3flEJ6uxtWC2GJ3eHdsP96DlF/WleOFUKS
         uKrAWZ9cPwJHo5kgYt7wn4hSvTOCSVJfjXDhU7TTHQxBGs6ve9DVlVRagxsdnfMlJpUY
         +qgVEjChFHXS8OledMYB5NrKMTA8XGNlPcum7cch7CfviMNqkNWdtMd2OeS5xEqzZlvn
         OTaw==
X-Forwarded-Encrypted: i=1; AJvYcCUkGUFfrrbHYFej/NPL2AQgzPsDIvQNILkywrJ7+rxdkV8wqZCMwYgk0ySqgDCB8XVFAhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP9fF4RDGA8+fmey5dJ1WuGKiMWlqwa2ZQuXx20kHM/LO74nFr
	Sjtlc67suw3tWwvcC0L8NwKK/taEDkZ0IfWmqoVN0olC0zuiKZg1xwkTOUWlv1U9ZtiYPSFVN2U
	FFob69ETcw29pID84cGMokTkLvVc=
X-Google-Smtp-Source: AGHT+IEZeO6upQNoKMj4xEiIkKMGdtszYG3jVWKf0RXnGWtmacLBvMbJA9S+KxM2ZlcGOTtr5y1FfOzFaadN7ghGYrY=
X-Received: by 2002:a05:600c:1547:b0:42c:b508:750e with SMTP id
 5b1f17b1804b1-43161627e3emr124228755e9.11.1729514251501; Mon, 21 Oct 2024
 05:37:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1817.git.1729296853800.gitgitgadget@gmail.com>
 <pull.1817.v2.git.1729382580491.gitgitgadget@gmail.com> <ZxZByGdre-lup2sO@pks.im>
In-Reply-To: <ZxZByGdre-lup2sO@pks.im>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Mon, 21 Oct 2024 13:37:22 +0100
Message-ID: <CADYq+fZ0A-6Odqoe0Yk+DHx13gc84Uk4RVagL7kMoY6+O9kB=Q@mail.gmail.com>
Subject: Re: [PATCH v2] notes: teach the -e option to edit messages in editor
To: Patrick Steinhardt <ps@pks.im>
Cc: Samuel Adekunle Abraham via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 12:58=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Sun, Oct 20, 2024 at 12:03:00AM +0000, Samuel Adekunle Abraham via Git=
GitGadget wrote:
> > From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
> >
> > Notes can be added to a commit using the -m (message),
> > -C (copy a note from a blob object) or
> > -F (read the note from a file) options.
>
> Nit: this would read a bit better if this was a bulleted list, I think.
> E.g.:
>
>     Notes can be added to a commit using:
>
>       - "-m" to provide a message on the command line.
>       - -C to copy a note from a blob object.
>       - -F to read the note from a file.
>
>     When these options are used, ...

Thank you Patrick. Noted.
>
> > When these options are used, Git does not open an editor,
> > it simply takes the content provided via these options and
> > attaches it to the commit as a note.
> >
> > Improve flexibility to fine-tune the note before finalizing it
> > by allowing the messages to be prefilled in the editor and editted
>
> s/editted/edited

Okay.
>
> > diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> > index c9221a68cce..d5505a426aa 100644
> > --- a/Documentation/git-notes.txt
> > +++ b/Documentation/git-notes.txt
> > @@ -9,9 +9,9 @@ SYNOPSIS
> >  --------
> >  [verse]
> >  'git notes' [list [<object>]]
> > -'git notes' add [-f] [--allow-empty] [--[no-]separator | --separator=
=3D<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C)=
 <object>] [<object>]
> > +'git notes' add [-f] [--allow-empty] [--[no-]separator | --separator=
=3D<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C)=
 <object>] [<object>] [-e]
> >  'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
> > -'git notes' append [--allow-empty] [--[no-]separator | --separator=3D<=
paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <ob=
ject>] [<object>]
> > +'git notes' append [--allow-empty] [--[no-]separator | --separator=3D<=
paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <ob=
ject>] [<object>] [-e]
> >  'git notes' edit [--allow-empty] [<object>] [--[no-]stripspace]
> >  'git notes' show [<object>]
> >  'git notes' merge [-v | -q] [-s <strategy> ] <notes-ref>
>
> Nit: I'd move the `[-e]` before [<object>] so that -F, -C and -m are all
> close together.
>
> > diff --git a/builtin/notes.c b/builtin/notes.c
> > index 8c26e455269..72c8a51cfac 100644
> > --- a/builtin/notes.c
> > +++ b/builtin/notes.c
> > @@ -489,6 +489,8 @@ static int add(int argc, const char **argv, const c=
har *prefix)
> >               OPT_CALLBACK_F('c', "reedit-message", &d, N_("object"),
> >                       N_("reuse and edit specified note object"), PARSE=
_OPT_NONEG,
> >                       parse_reedit_arg),
> > +             OPT_BOOL('e', "edit", &d.use_editor,
> > +                     N_("edit note message in editor")),
> >               OPT_CALLBACK_F('C', "reuse-message", &d, N_("object"),
> >                       N_("reuse specified note object"), PARSE_OPT_NONE=
G,
> >                       parse_reuse_arg),
> > @@ -667,6 +669,8 @@ static int append_edit(int argc, const char **argv,=
 const char *prefix)
> >               OPT_CALLBACK_F('C', "reuse-message", &d, N_("object"),
> >                       N_("reuse specified note object"), PARSE_OPT_NONE=
G,
> >                       parse_reuse_arg),
> > +             OPT_BOOL('e', "edit", &d.use_editor,
> > +                     N_("edit note message in editor")),
> >               OPT_BOOL(0, "allow-empty", &allow_empty,
> >                       N_("allow storing empty note")),
> >               OPT_CALLBACK_F(0, "separator", &separator,
>
> Nice.
>
> > diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> > index 99137fb2357..ffa1d21671d 100755
> > --- a/t/t3301-notes.sh
> > +++ b/t/t3301-notes.sh
> > @@ -1567,4 +1567,60 @@ test_expect_success 'empty notes do not invoke t=
he editor' '
> >       git notes remove HEAD
> >  '
> >
> > +test_expect_success 'git notes add with -m/-F invokes editor with -e' =
'
> > +     test_commit 19th &&
> > +     MSG=3D"Edited notes message" git notes add -m "Initial notes mess=
age" -e &&
> > +     echo "Edited notes message" >expect &&
> > +     git notes show >actual &&
> > +     test_cmp expect actual &&
> > +     git notes remove HEAD &&
> > +
> > +     # Add a note using -F and edit it
> > +     echo "Note from file" >note_file &&
> > +     MSG=3D"Edited note from file" git notes add -F note_file -e &&
> > +     echo "Edited note from file" >expect &&
> > +     git notes show >actual &&
> > +     test_cmp expect actual
> > +'
>
> I was surprised at first why the MSG ended up in the commit message. But
> the setup of t3301 writes a fake editor that listens to this environment
> variable, so this looks good to me.
>
> > +test_expect_success 'git notes append with -m/-F invokes the editor wi=
th -e' '
> > +     test_commit 20th &&
> > +     git notes add -m "Initial note message" &&
> > +     MSG=3D"Appended edited note message" git notes append -m "New app=
ended note" -e &&
> > +
> > +     # Verify the note content was appended and edited
> > +     echo "Initial note message" >expect &&
> > +     echo "" >>expect &&
> > +     echo "Appended edited note message" >>expect &&
>
> When you want to write multiple lines we typically use HERE docs. E.g.:
>
>         cat >expect <<-EOF &&
>         Initial note message
>
>         Appended edited note message
>         EOF
>
> > +     git notes show >actual &&
> > +     test_cmp expect actual &&
> > +     git notes remove HEAD &&
> > +
> > +     #Append a note using -F and edit it
>
> There should be a space after the "#" here.
>
> > +     echo "Note from file" >note_file &&
> > +     git notes add -m "Initial note message" &&
> > +     MSG=3D"Appended edited note from file" git notes append -F note_f=
ile -e &&
> > +
> > +     # Verify notes from file has been edited in editor and appended
> > +     echo "Initial note message" >expect &&
> > +     echo "" >>expect &&
> > +     echo "Appended edited note from file" >>expect &&
>
> Same comment here.
>
> > +     git notes show >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'git notes with a combination of -m, -F and -e inv=
okes editor' '
> > +     test_commit 21st &&
> > +     echo "foo-file-1" >note_1 &&
> > +     echo "foo-file-2" >note_2 &&
> > +
> > +     MSG=3D"Collapsed edited notes" git notes append -F note_1 -m "mes=
sage-1" -F note_2 -e &&
> > +
> > +     # Verify that combined messages from file and -m have been edited
> > +
> > +     echo "Collapsed edited notes" >expect &&
> > +     git notes show >actual &&
> > +     test_cmp expect actual
> > +'
> > +

> >  test_done
>
> It would be nice to have another test that uses EDITOR=3Dfalse to
> demonstrate that we abort when the editor returns an error.
>

Thanks for the review, I will effect the changes.
> Other than that this patch looks good to me, thanks a lot!

You're welcome, Patrick.
>
> Patrick
