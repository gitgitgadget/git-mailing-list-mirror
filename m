Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5778E54F86
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 19:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707508633; cv=none; b=pp6KpXQcDq3sbwFkRi2ANHzXCzCgWh/OY19M8ZaD/6HAeC43ZHcO6o13rH9LXhH2T0XeAZuIQXSb9IkCiwVs/wsL4Wmv3u2tb0WlKmIy0FD1ognkhuCiT71OXEolsFNqmM9sHxWLT8b8fkuq96rOeGaKC1vN0cVVBVt6rFiyd1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707508633; c=relaxed/simple;
	bh=1dlJNd3TfBABcRgItH0o+73LFjfMYUomxr0/w/FCoLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h02hxlJLdveCjjFETc7u9SrXgqzy1aWN7nSfecTEvKPnm5cRsq3hT6sP7JbcqwP1R7th3PJzqJVqIU2hvVFlGqGp1iJo+Q64uzqyO7GKfTarhCf3EmRrp56EtDu1A2y4yozaygtsZhVlmipNZr2qv4f4AAxSNl1y0wfc3KVmmnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ovnq3Xc6; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ovnq3Xc6"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5611e54a92dso1739028a12.2
        for <git@vger.kernel.org>; Fri, 09 Feb 2024 11:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707508629; x=1708113429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vvSyYPijVEB9Ujgvqwh0PVZCm0zetE6z2l9vkRpsn0=;
        b=Ovnq3Xc6jYZEUKNHd1q9q7qSvAsYhngHCN06PYwKJ86lcmk3yOWiQ1Pw2G9zsAtXOw
         lsQ4lQwzlSyGwQxorTmTOHQaGzMzqUrMgx9ffCGRZwnmIjbgwtthLzziIAciiEEWgdTe
         THRTeOnaTpY+yV0llDx3XCTdfukiZmd5R5sHqus1KEmR2809GNK8oOsqWf/3kdguppbC
         vctnpFeO/MSfR641tol0JofmA8bWNt6rsZ7TY4xlLaTn9KsskJQ22Hu/OfwPw5KZe0HZ
         zCz9CiHFYLPsr4YZpiUImztBLPoC9Zjbtvv8fsO7t9BS09Vdp8iGQ0wjRbyQnem+fWD1
         00OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707508629; x=1708113429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vvSyYPijVEB9Ujgvqwh0PVZCm0zetE6z2l9vkRpsn0=;
        b=Mgcb7WTLQr2Ka1hdblORF+35fRYM9DfT1ZJtMTNwg545+uevQbudmMzt+AgKplmlIr
         trRqEPb9o6diMfTkcnkFJ/Elgi7oGkfwhHXGiveNweDDDQS89kr6gnE+1CFN/IgLLZYr
         pE3QzGI8DpI30YDB92JbI0dqwLYJipoE3dtu1WiqnEgtVFRACIbjZnjsLj3Lrp4iQEPd
         jVbDH8Q78ol8wrqJokGZSE/i9WPk5gjt8uAQ1rOMzG5w6Gh2z//U7bJgWZjBGus9AL6J
         wcIXOZZOqoWqycqv7gF49nOWp/PLamFVUSZ3waXHmplGlC3NJm8BI2HFRmO5VoMq6QGk
         qiKQ==
X-Gm-Message-State: AOJu0YwkaHl0G+jUsIx44xBhB0QTTBI5IBXTARElml33RFyIH2kkOkBe
	/ACjo8veNYvQ290oJvyHGa8O8S0Tud7UvI3+8wQJyiDpw/4/2kUtbPV0HeTXurixdewFAv/AVgL
	DAeZ8jehInx+7MWdXw1mg/MH3gdvpTmf8wCc3
X-Google-Smtp-Source: AGHT+IGOBHiJ/N/rhnRwslHQoYRUcM4EsR4Z95ukiFvQ3KnPTWjostvDJ+xW4jhxRqko67juiI+FKIfnw2zJzlMcgGA=
X-Received: by 2002:a17:906:4095:b0:a38:6d3:ac5c with SMTP id
 u21-20020a170906409500b00a3806d3ac5cmr67261ejj.48.1707508629330; Fri, 09 Feb
 2024 11:57:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1650.git.1707143753726.gitgitgadget@gmail.com>
 <CAO_smVhrMn=-uF1B6+RA8A+VLCEN=o57zbQPtr8hpxRKY=qJRQ@mail.gmail.com> <5fd95ae0-cd50-ddc4-5095-ee953c2640b3@gmx.de>
In-Reply-To: <5fd95ae0-cd50-ddc4-5095-ee953c2640b3@gmx.de>
From: Kyle Lippincott <spectral@google.com>
Date: Fri, 9 Feb 2024 11:56:52 -0800
Message-ID: <CAO_smViXpcwo6_zd3iqpM175nEnH_mjca7XqJ=V4bBobY_02wQ@mail.gmail.com>
Subject: Re: [PATCH] Always check the return value of `repo_read_object_file()`
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 12:06=E2=80=AFAM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Kyle,
>
> On Mon, 5 Feb 2024, Kyle Lippincott wrote:
>
> > On Mon, Feb 5, 2024 at 6:36=E2=80=AFAM Johannes Schindelin via GitGitGa=
dget
> > <gitgitgadget@gmail.com> wrote:
> > >
> > > diff --git a/builtin/notes.c b/builtin/notes.c
> > > index e65cae0bcf7..caf20fd5bdd 100644
> > > --- a/builtin/notes.c
> > > +++ b/builtin/notes.c
> > > @@ -716,9 +716,11 @@ static int append_edit(int argc, const char **ar=
gv, const char *prefix)
> > >                 struct strbuf buf =3D STRBUF_INIT;
> > >                 char *prev_buf =3D repo_read_object_file(the_reposito=
ry, note, &type, &size);
> > >
> > > -               if (prev_buf && size)
> > > +               if (!prev_buf)
> > > +                       die(_("unable to read %s"), oid_to_hex(note))=
;
> >
> > This changes the behavior of this function. Previously, it would not
> > add prev_buf output, but still succeed. This now dies.
>
> It does change behavior. The previous behavior looked up the note OID,
> then tried to read it, and if it was missing just pretended that there ha=
d
> not been a note.
>
> I'm not quite sure whether we should keep that behavior, as it is unclear
> in which scenarios it would be desirable to paper over missing objects.
>
> In GitGitGadget, I am a heavy user of notes and it wouldn't do any good t=
o
> have this behavior: It would lose information.
>
> And even in scenarios where the `notes` ref is fetch shallowly, I would
> expect all of the actual notes blobs to be present, and I would _want_ th=
e
> `git note edit ...` command to error out when that blob is not found.
>
> Does that reasoning make sense to you?

Sounds good, thanks for talking through it with me.

>
> Ciao,
> Johannes
