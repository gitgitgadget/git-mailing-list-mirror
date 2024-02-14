Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2842A5A785
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921528; cv=none; b=U9tjHgashhsDpeu7SJV1IyK5t5HnPfCJqiXrWfoXNY7K4JJawQt5czRmlkBgkWV/Ct5KhNqIFsC+ARlzHxJut5qbOt77v5gAeSZzZRYCe9Qv9W4byTtMDmvzRfUxkVerltJeELN6KFFhfnVvOwe/cYpzBvOEmXdshV+PsMKKlOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921528; c=relaxed/simple;
	bh=AqbTjcd+E2XKoNofSl2w0CdB5MmPNsxPmf6A+uRaJ2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlilS9ZubhmWjBHbOVvqO5W78vODK3Bi1epn9DE88+sgtzYJSBciJkirfV6K8EAqr9Tp+1w3iC0H1Ss73ziTzdJSeLxhAwBWrC3ox58pX/i3YqPxzGdTLj59ObGQtgemZlyo+aB+agbZsEGSsw2eROA7FmBgspI5L3UwbprtNVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqUlvBgR; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqUlvBgR"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3566c0309fso682939066b.1
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 06:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707921524; x=1708526324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubtfpm1iraYPnM9Iiirsyc1mrB3zxo10iEF4M5UD5Fo=;
        b=dqUlvBgRyrHjwC4hHGGlkpTS/Ov4i2M1ofIzZj7u34Gy/TzzyIx3KsEblqbqAvEhf3
         +pFhw2JGvWJ0brCLnoxfWWoVYmqBavu2d8mKgjdHUFvT3ukJMthZiownswG7+P9PAUkR
         MykasBNp3Wq58ZhpbtWWjxCEf3m5x/odzZ/PkM/TjUzANn598kSZgIsyh37M+Ch8Hr0P
         mDH0cXyLxLMuYSRAiNrlfrSu5sB+A1DKqNFFFkVBPHs8K0xD602UH/qtd82oAXZexKoE
         MkBTwOiMF/7E3b7j8EzwPAPmyhfFR5EBlAAby0gRmfW0fjO2LOjKkb4uI55/2c1878AY
         cKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707921524; x=1708526324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubtfpm1iraYPnM9Iiirsyc1mrB3zxo10iEF4M5UD5Fo=;
        b=IbGWCxYsFKz/otWrgoO3z6g9gfswX1RspAXm8xUSMuEGVAELz+pQjqNxpFHaj0ELli
         lqW+U+ZOnduqqXUPoSp+ekM7l47hQj6lZkX5pJHu59agT4POdPElCgAr1A8C39nmIhg9
         x6DZyHEXUl8UfBYB00jjHUSdEuUeLKQr1QSi5s2oyWdOsVV47rTbGu0vlmdQhnoAjUR0
         +12mF4Z+OvP+DJX3ajKJEmGdEfACVO0FbmNixUKq3f+4b3HwReeJouTVCP6Yh/P7FT7h
         TS5xcScEw7yH5KUzE640O2x1gJypnwEJE9JPWLPwNHoqBZHDPyS/dm8t8IBRUboRyGIE
         dzvw==
X-Gm-Message-State: AOJu0YxU81sGi1ppSRGn5HScU/GE0nfXhqSRr6t2zDC4oJZGbTLzPNk2
	IUfMOZY1bDePGbyuqCOAQYm8XeEQePHZrbXoWxgHB3ZCXb7LW/NzVVsjkc3OrbJv/+IwS7l2Mvu
	WrXjy5bWyR0+o0TeXoe33+vjqT3Q=
X-Google-Smtp-Source: AGHT+IEzZ+cYiX3zQNUIRknnDkJlw8NMHaDDk1ilRGp0qQfNTUcbVpBLDsdqhel/jciJBYMqPaoRrsqLFE1FW7WFiL8=
X-Received: by 2002:a17:906:4e91:b0:a3d:47dc:e3a8 with SMTP id
 v17-20020a1709064e9100b00a3d47dce3a8mr1486498eju.3.1707921524116; Wed, 14 Feb
 2024 06:38:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208135055.2705260-1-christian.couder@gmail.com>
 <20240208135055.2705260-5-christian.couder@gmail.com> <owlyil2s9eq6.fsf@fine.c.googlers.com>
In-Reply-To: <owlyil2s9eq6.fsf@fine.c.googlers.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 14 Feb 2024 15:38:32 +0100
Message-ID: <CAP8UFD3N8h4FnfvFYYWrV54a7WcOwHY862DjxxPKSKr4jEwU7Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] rev-list: allow missing tips with --missing=[print|allow*]
To: Linus Arver <linusa@google.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	John Cai <johncai86@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:33=E2=80=AFPM Linus Arver <linusa@google.com> wr=
ote:
>
> Christian Couder <christian.couder@gmail.com> writes:

> > We could introduce a new option to make it work like this, but most
> > users are likely to prefer the command to have this behavior as the
> > default one. Introducing a new option would require another dumb loop
> > to look for that options early, which isn't nice.
>
> s/options/option

Fixed in the V3 I just sent.

> > Also we made `git rev-list` work with missing commits very recently
> > and the command is most often passed commits as arguments. So let's
> > consider this as a bug fix related to these previous change.
>
> s/previous change/recent changes

Fixed in V3, thanks.

> > While at it let's add a NEEDSWORK comment to say that we should get
> > rid of the existing ugly dumb loops that parse the
> > `--exclude-promisor-objects` and `--missing=3D...` options early.

> > @@ -1019,6 +1019,10 @@ Unexpected missing objects will raise an error.
> >  +
> >  The form '--missing=3Dprint' is like 'allow-any', but will also print =
a
> >  list of the missing objects.  Object IDs are prefixed with a ``?'' cha=
racter.
> > ++
> > +If some tips passed to the traversal are missing, they will be
> > +considered as missing too, and the traversal will ignore them. In case
> > +we cannot get their Object ID though, an error will be raised.
>
> The only other mention of the term "tips" is for the "--alternate-refs"
> flag on line 215 which uses "ref tips". Perhaps this is obvious to
> veteran Git developers but I do wonder if we need to somehow define it
> (however briefly) the first time we mention it (either in the document
> as a whole, or just within this newly added paragraph).

I did a quick grep in Documentation/git*.txt and found more than 130
instances of the 'tip' word. So I think it is quite common in the
whole Git documentation and our glossary would likely be the right
place to document it if we decide to do so. Anyway I think that topic
is independent from this small series.

> Here's an alternate wording
>
>     Ref tips given on the command line are a special case.

`git rev-list` has a `--stdin` mode which makes it accept tips from
stdin, so talking about the command line is not enough. Also maybe one
day some config option could be added that makes the command include
additional tips.

> They are
>     first dereferenced to Object IDs (if this is not possible, an error
>     will be raised). Then these IDs are checked to see if the objects
>     they refer to exist. If so, the traversal happens starting with
>     these tips. Otherwise, then such tips will not be used for
>     traversal.
>
>     Even though such missing tips won't be included for traversal, for
>     purposes of the `--missing` flag they will be treated the same way
>     as those objects that did get traversed (and were determined to be
>     missing). For example, if `--missing=3Dprint` is given then the Objec=
t
>     IDs of these tips will be printed just like all other missing
>     objects encountered during traversal.

Your wording describes what happens correctly, but I don't see much
added value for this specific patch compared to my wording which is
shorter.

Here I think, we only need to describe the result of the command in
the special case that the patch is fixing. We don't need to go into
details of how the command or even --missing works. It could be
interesting to go into details of how things work, but I think it's a
separate topic. Or perhaps it's even actually counter productive to go
into too much detail as it could prevent us from finding other ways to
make it work better. Anyway it seems to me to be a separate topic to
discuss.

> But also, I realize that these documentation touch-ups might be better
> served by an overall pass over the whole document, so it's fine if we
> decide not to take this suggestion at this time.

Right, I agree. Thanks for telling this.

> Aside: unfortunately we don't seem to define the relationship between
> ref tips (e.g., "HEAD"), object IDs (40-char hex string), and the actual
> objects (the real data that we traverse over). It's probably another
> thing that could be fixed up in the docs in the future.

Yeah, and for rev-list a tip could also be a tree or a blob. It
doesn't need to be a "ref tip". (Even though a ref can point to a tree
or a blog, it's very rare in practice.)

> >  --exclude-promisor-objects::
> >       (For internal use only.)  Prefilter object traversal at
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
> > +      * are ugly.
>
> I agree with Junio's suggestion to use more objective language.
>
> > We really need setup_revisions() to have a
> > +      * mechanism to allow and disallow some sets of options for
> > +      * different commands (like rev-list, replay, etc). Such
>
> s/Such/Such a

Fixed in V3

> > +      * mechanism should do an early parsing of option and be able
>
> s/option/options

Fixed in V3, thanks.

> > +      * to manage the `--exclude-promisor-objects` and `--missing=3D..=
.`
> > +      * options below.
> > +      */
> >       for (i =3D 1; i < argc; i++) {
> >               const char *arg =3D argv[i];
> >               if (!strcmp(arg, "--exclude-promisor-objects")) {
> >
> > [...]
> >
> > @@ -2178,13 +2183,18 @@ static int handle_revision_arg_1(const char *ar=
g_, struct rev_info *revs, int fl
> >       if (revarg_opt & REVARG_COMMITTISH)
> >               get_sha1_flags |=3D GET_OID_COMMITTISH;
> >
> > +     /*
> > +      * Even if revs->do_not_die_on_missing_objects is set, we
> > +      * should error out if we can't even get an oid, ...
> > +      */
>
> Perhaps this wording is more precise?
>
>     If we can't even get an oid, we are forced to error out (regardless
>     of revs->do_not_die_on_missing_objects) because a valid traversal
>     must start from *some* valid oid. OTOH we ignore the ref tip
>     altogether with revs->ignore_missing.

This uses "valid oid" and "valid traversal", but I am not sure it's
easy to understand what "valid" means in both of these expressions.

Also if all the tips passed to the command are missing, the traversal
doesn't need to actually start. The command, assuming
`--missing=3Dprint` is passed, just needs to output the oids of the tips
as missing oids.

I also think that "ref tip" might be misleading as trees and blos can
be passed as tips.

So I prefer to keep the wording I used.

> > +      * ... as
> > +      * `--missing=3Dprint` should be able to report missing oids.
>
> I think this comment would be better placed ...
>
> >       if (get_oid_with_context(revs->repo, arg, get_sha1_flags, &oid, &=
oc))
> >               return revs->ignore_missing ? 0 : -1;
> >       if (!cant_be_filename)
> >               verify_non_filename(revs->prefix, arg);
> >       object =3D get_reference(revs, arg, &oid, flags ^ local_flags);
>
> ... around here.

In a previous round, I was asked to put such a comment before `if
(get_oid_with_context(...))`. So I prefer to avoid some back and forth
here.

> > +++ b/t/t6022-rev-list-missing.sh
> > @@ -78,4 +78,60 @@ do
> >       done
> >  done
> >
> > +for missing_tip in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
> > +do
> > +     # We want to check that things work when both
> > +     #   - all the tips passed are missing (case existing_tip =3D ""),=
 and
> > +     #   - there is one missing tip and one existing tip (case existin=
g_tip =3D "HEAD")
> > +     for existing_tip in "" "HEAD"
> > +     do
>
> Though I am biased, these new variable names do make this test that much
> easier to read. Thanks.

Thanks for suggesting them and for your reviews.
