Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576601397
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762784245; cv=none; b=kyQlIUId3gDRZZ/XRiG1vuJSYPXdJls3eigDQ37uh+vgOswOxLrc9Mb9udsjed3CwUMfQp0DPH2M7X2UtmF0wnpo4ulT4SCxOt/sv++nhEMVDpJOzmOq70EJcD1DvoEICeYBzPybJ8rvsjG8DG3On2e1n1RuE2uPHs0koDM0NPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762784245; c=relaxed/simple;
	bh=BcC+18FcGLvAMsmWOkNzBRWunBEe2BvgWfNVU3T/n2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDA5Yd1xnA0n4GBrCE1UaHxHY9+NlRsQh2GmFN+DX4HDJo2jLENE1OjQc14cAkAfzPwiQEWCSpInabQEr7RsQ5EkNkoeERF1bdQ3f+SsNarnwAsGMf1i8EuVaUUa2fIMESj/IJU94wbVkYDOm4fcM/j9SU/FrjwesYLPhU9KlDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eo5cZ2FP; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eo5cZ2FP"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b403bb7843eso556040766b.3
        for <git@vger.kernel.org>; Mon, 10 Nov 2025 06:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762784241; x=1763389041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIx7L6KdDFBeQ496dkgcwxrkM2Z+8nMTQNDkVf3fJV4=;
        b=eo5cZ2FP1gO4iJE46Ggm7hNnB8L1Um+ynVlH7Uu9M83uRdmVDZ1S+O4Pg6J2xLHr6x
         9QYamI6Z7365IX2dbk24h4hvdP9ZJV1hf8njTNfgVGltJwNfVhGgfbKEeafVWjsY9WQ/
         Dlq7kcSbt9uCYwMezByHe61R0tLdk/nlrt133ylG+QxEkxoAWiRyrOXeGyhzMqfIH3LL
         aU2mPE4L0Lfn04jmP84sCSQ3jwP+8ycoyj9+EEgclfAF6t+2FFORW2JAgCf5TvRBeHvz
         hgLluaar84UOZM7JDKiFUkmIMtgMePMabejTYWSYJjzIACHst8pccWORIO926ml/yQwr
         PnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762784241; x=1763389041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cIx7L6KdDFBeQ496dkgcwxrkM2Z+8nMTQNDkVf3fJV4=;
        b=wlPRIGa8ZQBrcgsHHYfRg51BMkkFZJwBEQBah6jcfZ4e6iiv7eAmcsJYejjIqLZzGr
         Xj0eex18tqh4V1PkJO1V5YFSL7/XwXx8HmCENQ2CLeGXiyTk2fa9Rt6OiT2RSG9q1htW
         lFZh9nKrzSnc0KaFu7HvO7Ou3aieAdws5vcYaMi5dOvMOlNHvZ7Tzec+IDshRdkfxFvs
         eGFhNinZi/XjCmYmaxUxtXsqQ49Hm38bzmvkHODwwnP+Z0PUQELXNAkgB4teyn4pHgcz
         aKIWi8Oi6oDKtSsmyxxEgdsVsliC2qmeaylPMzyc8vp579jFjAnxK5rf1yxAGyAACA4J
         YHvw==
X-Forwarded-Encrypted: i=1; AJvYcCUbJVYXfCBugonlbwnU+OIM3LZ8PQbOwT7dg/MKBxup4Z7PqDzQUU9KDRlRbJoZoBK4DSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXum7O07DGUO4H7s5qTTGqrIhcpTh9B6yh2+QN345n/wifJ/Gr
	3wiFSTU86ToeCPLQAFlR4m/+4vVqxB2XMDNKAqVzBq4dBvyrkjRmbfNFs8LJSYxif6EfsL9IDl4
	BGj8Ye/y+m9oaYxcg4YmKKCDgCuxMkLg=
X-Gm-Gg: ASbGncvt4PrN3KkjLF3+TwKE9TJaFXcs1l0Zj66trPJ06tA54b9r3BCLLFie7Rgn3VX
	JNLas6Z7bIjMNozQWuYrQAUkgXDUbTD6xJzDxw24gAFou9YDj6DfalYUGz/UKeLtkF9aZ/vVrQN
	gTRjSIu357nG6elwKy8ucZucOoCoqqax+9uIDf6IpBj+hav88J5MB9M/7dfw6HTk7xho/2GlCAt
	BDowoWH7IqBE43qE9bPng/kN72UJQ37VjAV0L3uhFZhq2aQrrNgzuGJ
X-Google-Smtp-Source: AGHT+IEhabM1LqF9jV2TrnI8jc+EN7qAXeOvYbzAVgrjLDKsb8J6K4n2w91vEZVKJ+XHYnmsPR85ypAwSwajCjMBNTA=
X-Received: by 2002:a17:906:eec8:b0:b60:18d5:4293 with SMTP id
 a640c23a62f3a-b72e028541bmr916521466b.9.1762784240366; Mon, 10 Nov 2025
 06:17:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com> <aRGvVwRcsJA9CD9c@pks.im>
In-Reply-To: <aRGvVwRcsJA9CD9c@pks.im>
From: ZheNing Hu <adlternative@gmail.com>
Date: Mon, 10 Nov 2025 22:17:07 +0800
X-Gm-Features: AWmQ_bnskrClfWZSDAvO1f7jOwGdPRgDIGzcXSH1uGXxgmBhqgd2GDaiPt7XABA
Message-ID: <CAOLTT8SC55mEGUDHis+DO5OPijox3xRN-76VkwJ8ryVN59hMtA@mail.gmail.com>
Subject: Re: [PATCH] commit: add --committer option
To: Patrick Steinhardt <ps@pks.im>
Cc: ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> =E4=BA=8E2025=E5=B9=B411=E6=9C=8810=E6=97=A5=
=E5=91=A8=E4=B8=80 17:24=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Nov 09, 2025 at 10:22:54AM +0000, ZheNing Hu via GitGitGadget wro=
te:
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Add --committer option to git-commit, allowing users to override the
> > committer identity similar to how --author works. This provides a more
> > convenient alternative to setting GIT_COMMITTER_* environment variables=
.
>
> Yeah, I can see how that's useful.
>

I'm glad we're aligned on this.

> > diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.a=
doc
> > index 54c207ad45..a015c8328e 100644
> > --- a/Documentation/git-commit.adoc
> > +++ b/Documentation/git-commit.adoc
> > @@ -12,7 +12,7 @@ git commit [-a | --interactive | --patch] [-s] [-v] [=
-u[<mode>]] [--amend]
> >          [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|r=
eword):]<commit>]
> >          [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
> >          [--allow-empty-message] [--no-verify] [-e] [--author=3D<author=
>]
> > -        [--date=3D<date>] [--cleanup=3D<mode>] [--[no-]status]
> > +        [--date=3D<date>] [--committer=3D<committer>] [--cleanup=3D<mo=
de>] [--[no-]status]
> >          [-i | -o] [--pathspec-from-file=3D<file> [--pathspec-file-nul]=
]
> >          [(--trailer <token>[(=3D|:)<value>])...] [-S[<keyid>]]
> >          [--] [<pathspec>...]
>
> Nit: I'd move `--committer` before `--date` so that it comes directly
> after `--author`.
>

Agreed, will fix.

> > @@ -181,6 +181,13 @@ See linkgit:git-rebase[1] for details.
> >  `--date=3D<date>`::
> >       Override the author date used in the commit.
> >
> > +`--committer=3D<committer>`::
> > +     Override the committer for the commit. Specify an explicit commit=
ter using the
> > +     standard `A U Thor <committer@example.com>` format. Otherwise _<c=
ommitter>_
> > +     is assumed to be a pattern and is used to search for an existing
> > +     commit by that author (i.e. `git rev-list --all -i --author=3D<co=
mmitter>`);
> > +     the commit author is then copied from the first such commit found=
.
>
> This matches the description of `--author`.
>

Agreed, I will fix it to use committer description.

> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index 0243f17d53..88e77cbaab 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -690,6 +691,48 @@ static void determine_author_info(struct strbuf *a=
uthor_ident)
> >       free(date);
> >  }
> >
> > +static void determine_committer_info(struct strbuf *committer_ident)
> > +{
> > +     char *name, *email, *date;
> > +     struct ident_split committer;
> > +
> > +     name =3D xstrdup_or_null(getenv("GIT_COMMITTER_NAME"));
> > +     email =3D xstrdup_or_null(getenv("GIT_COMMITTER_EMAIL"));
> > +     date =3D xstrdup_or_null(getenv("GIT_COMMITTER_DATE"));
> > +
> > +     if (force_committer) {
> > +             struct ident_split ident;
> > +
> > +             if (split_ident_line(&ident, force_committer, strlen(forc=
e_committer)) < 0)
> > +                     die(_("malformed --committer parameter"));
> > +             set_ident_var(&name, xmemdupz(ident.name_begin, ident.nam=
e_end - ident.name_begin));
> > +             set_ident_var(&email, xmemdupz(ident.mail_begin, ident.ma=
il_end - ident.mail_begin));
> > +
> > +             if (ident.date_begin) {
> > +                     struct strbuf date_buf =3D STRBUF_INIT;
> > +                     strbuf_addch(&date_buf, '@');
> > +                     strbuf_add(&date_buf, ident.date_begin, ident.dat=
e_end - ident.date_begin);
> > +                     strbuf_addch(&date_buf, ' ');
> > +                     strbuf_add(&date_buf, ident.tz_begin, ident.tz_en=
d - ident.tz_begin);
> > +                     set_ident_var(&date, strbuf_detach(&date_buf, NUL=
L));
> > +             }
> > +     }
> > +
> > +     if (force_date) {
> > +             struct strbuf date_buf =3D STRBUF_INIT;
> > +             if (parse_force_date(force_date, &date_buf))
> > +                     die(_("invalid date format: %s"), force_date);
> > +             set_ident_var(&date, strbuf_detach(&date_buf, NULL));
> > +     }
> > +
> > +     strbuf_addstr(committer_ident, fmt_ident(name, email, WANT_COMMIT=
TER_IDENT, date,
> > +                             IDENT_STRICT));
> > +     assert_split_ident(&committer, committer_ident);
> > +     free(name);
> > +     free(email);
> > +     free(date);
> > +}
> > +
> >  static int author_date_is_interesting(void)
> >  {
> >       return author_message || force_date;
>
> A lot of the infra in this new function is shared with
> `determine_author_info()`. It would be great if we could refactor it so
> that the common parts are shared given that this all is quite
> non-trivial.
>
> Maybe we could have something like `determine_identity()` that contains
> the common bits between both functions? It might ultimately not really
> be worth it, but at least the functionality in the `force_committer`
> condition feels like it should be pulled out.
>

Good suggestion, I will refactor them to use `determine_identity()`,
which should be more generic, and it even caught that I missed
updating `GIT_COMMITTER_*`.

> > @@ -1321,6 +1364,9 @@ static int parse_and_validate_options(int argc, c=
onst char *argv[],
> >       if (force_author && renew_authorship)
> >               die(_("options '%s' and '%s' cannot be used together"), "=
--reset-author", "--author");
> >
> > +     if (force_committer && !strchr(force_committer, '>'))
> > +             force_committer =3D find_author_by_nickname(force_committ=
er);
> > +
> >       if (logfile || have_option_m || use_message)
> >               use_editor =3D 0;
> >
>
> Is it the right thing to search by author here? Shouldn't we rather be
> searching by committer?
>

Yes, there should also be a `find_identity_by_nickname()` or
`find_committer_by_nickname()` here.

> > @@ -1930,8 +1978,13 @@ int cmd_commit(int argc,
> >               append_merge_tag_headers(parents, &tail);
> >       }
> >
> > +     if (force_committer) {
> > +             determine_committer_info(&committer_ident);
> > +     }
> > +
>
> Nit: we tend to not use braces around single-line bodies.
>

Agree.

> Thanks!
>
> Patrick
