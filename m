Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4E713DB92
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 11:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873382; cv=none; b=bylGbMKDgVAqVVP/5GabN43gyNU+S6RaU7R0/DNOdKovAPN7y2e80CDP8EOIGrfRc8jsLqHRNu3KPRthnyHp49qnSuA0meRPLWPnZ5LIygyGcmc4TDVz10D7mFwZQCfpx6mF9icRKJu6Jd74SOAUbT2ARYq+vlFsYfftKBFUKY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873382; c=relaxed/simple;
	bh=mXlS96cf5gpbPIdh3YPY3TmK9lrgPI3Dx8H0mhKCJJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhlJmlKr63uCJakDjAhwOqoKWyhA2lZ/voahEinryySavuLeU5NNK+BCc4wYuJYxK9m20B56rqu+ou9UpczLQNrZODQx/1Sju95LTtuYA8+Vcexzsg5V/Qb/ljf0H7HnTpDdQLryDOIA49tdCQmRKVGt0KYfZxKI3DT8QP2yYDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/Jag1lX; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/Jag1lX"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a30e445602cso660523166b.0
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 03:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706873378; x=1707478178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Imm3BbaX3hedRD5TsqjHvdtCGE5gvkVojKW1pgfNerU=;
        b=X/Jag1lXlrbaDDXk31FiTu8Mi4wa4k9Ss+3Wo+wtRqCXDO+C/E2lEEp9d3kCtF6JcE
         4UIZUmre8hhPxHdEGgEh8nyjdAxZ6jx5Ry0/T7JkGrjO72A1KkYnBlDj1CYV2vO9/oql
         BwWKd0XYHUZCFq5wtWg1mbKTMC/kpthhx34VtM9clJI/IQS+VzhpRJHbavTMvbDv0AS4
         6r9qXp2liq7IPO6KBimYl+iRLUQayEmAlr5GWi1KfzqldkFa11iTahUpKz8zGkwLMy1G
         t38ACh/vl0ICRpQT5wVCwPieE9KCm1hhXCN3r41zk1+EH6Kd1ZhP+fARmw1yrCZt3Ed2
         dUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706873378; x=1707478178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Imm3BbaX3hedRD5TsqjHvdtCGE5gvkVojKW1pgfNerU=;
        b=LrJXg0RAh0MAOBO4nnm6rxpKJJSs6GbFBQd7jFLXlbvClFE/RwnB9PGk5jwE7eCW7H
         sYZWHDNTAg3YaCIoW06ckgAAQVsxkTzy9UPKS2roTmhXt1u1XueQhR6w9/GfwLUqASp3
         jGNccqW4P/swZqi5qPcpYESUgln7yLgRa/bWcclLe8Hpwidui8ctG2p9cUhAFI461EYE
         Na3vE9AvnWc7cbyk+OCZVCxiK9yoJWbcfZx8adKYsF8mgh25Uv2pjfUI9NlnyI0jYWxV
         U3+o7Jf+7YQWUPXpBDUK2OOS3+nWvSBTt4HJuSDccwei03nAxOOLf/aqn+gKHhn2cyWG
         AoSA==
X-Gm-Message-State: AOJu0YxaML4EcnTbl6TnunHxIKtbNRkqQJn4dd8P+5osYkYXIcqTKhTm
	oeKPLVa+0l6N/U+y1ajLl0D63UPr8M+z8YVm65RxSrq+iNdi0CzL451UEzGf1wQhy2RuT9r4Ree
	r8amMFqL3KCtSOwy/0mnN2bCsQUhMjV2uowY=
X-Google-Smtp-Source: AGHT+IGVoJD/DMoJPrq0JH/PNqeonQyO0dajPROLeMe51ffbD71OeMoaAHURdQ7zDGbv0oytgRj+TpY2MhOZrmjw5U4=
X-Received: by 2002:a17:906:2b07:b0:a37:23e1:7705 with SMTP id
 a7-20020a1709062b0700b00a3723e17705mr332379ejg.7.1706873378161; Fri, 02 Feb
 2024 03:29:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201115809.1177064-1-christian.couder@gmail.com>
 <20240201115809.1177064-4-christian.couder@gmail.com> <xmqqo7d0x7fm.fsf@gitster.g>
In-Reply-To: <xmqqo7d0x7fm.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 2 Feb 2024 12:29:25 +0100
Message-ID: <CAP8UFD0HwQr+qj=FrDQXJeY8PhVH1e7oErbVopgtv2X8ig7a7Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] rev-list: add --allow-missing-tips to be used with --missing=...
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, John Cai <johncai86@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 9:20=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > In 9830926c7d (rev-list: add commit object support in `--missing`
> > option, 2023-10-27) we fixed the `--missing` option in `git rev-list`
> > so that it now works with commits too.
> >
> > Unfortunately, such a command would still fail with a "fatal: bad
> > object <oid>" if it is passed a missing commit, blob or tree as an
> > argument.
> >
> > When such a command is used to find the dependencies of some objects,
> > for example the dependencies of quarantined objects, it would be
> > better if the command would instead consider such missing objects,
> > especially commits, in the same way as other missing objects.
> >
> > If, for example `--missing=3Dprint` is used, it would be nice for some
> > use cases if the missing tips passed as arguments were reported in
> > the same way as other missing objects instead of the command just
> > failing.
> >
> > Let's introduce a new `--allow-missing-tips` option to make it work
> > like this.
>
> OK.  Unlike a missing object referenced by a tree, a commit, or a
> tag, where the expected type of the missing object is known to Git,
> I would expect that nobody knowsn what type these missing objects at
> the tip have.  So do we now require "object X missing" instead of
> "commit X missing" in the output?  If we are not giving any type
> information even when we know what the type we expect is, then we do
> not have to worry about this change introducing a new output logic,
> I guess.

Yeah, we are not giving type information in the output, only a `?`
before the oid.

> > diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> > index b3f4783858..ae7bb15478 100644
> > --- a/builtin/rev-list.c
> > +++ b/builtin/rev-list.c
> > @@ -562,6 +562,16 @@ int cmd_rev_list(int argc, const char **argv, cons=
t char *prefix)
> >                               break;
> >               }
> >       }
> > +     for (i =3D 1; i < argc; i++) {
> > +             const char *arg =3D argv[i];
> > +             if (!strcmp(arg, "--allow-missing-tips")) {
> > +                     if (arg_missing_action =3D=3D MA_ERROR)
> > +                             die(_("option '%s' only makes sense with =
'%s' set to '%s' or '%s'"),
> > +                                   "--allow-missing-tips", "--missing=
=3D", "allow-*", "print");
> > +                     revs.do_not_die_on_missing_tips =3D 1;
> > +                     break;
> > +             }
> > +     }
>
> It is unfortunate that we need to add yet another dumb loop that
> does not even try to understand there may be an option whose value
> happens to be the string strcmp() looks for (we already have two
> such loops above this hunk).  I have to wonder if we can do better.

I am also not happy with adding yet another dump loop like this. I did
it because I couldn't think of a simple solution to avoid that.

> An idle piece of idea.  Perhaps we can instruct setup_revisions()
> not to die immediately upon seeing a problematic argument, marking
> the revs as "broken" instead, and keep going and interpreting as
> much as it could, so that it may record the presence of "--missing",
> "--exclude-promisor-objects", and "--allow-missing-tips".  Then upon
> seeing setup_revisions() return with such an error, we can redo the
> call with these bits already on.

When we discussed rejecting some rev walking options before calling
setup_revisions() in the context of `git replay`, one thing people
seemed to agree on was that there should be a mechanism in
setup_revisions() that allows us to tell setup_revisions() which rev
walking options it should allow or not. I think that such a mechanism
might need an early parsing of options which could be reused for
options like `--exclude-promisor-objects`, `--missing=3D...`  and
`--allow-missing-tips`. But I think adding such a mechanism does not
belong to this patch series. It's some cleanup and refactoring that we
might have needed for a long time already.

In my current version, I have added the following NEEDSWORK comment
before the three dump loops to make sure we remember about this:

    /*
     * NEEDSWORK: These dump loops to look for some options early
     * are ugly. We really need setup_revisions() to have a
     * mechanism to allow and disallow some sets of options for
     * different commands (like rev-list, replay, etc). Such
     * mechanism should do an early parsing of option and be able
     * to manage the `--exclude-promisor-objects`, `--missing=3D...`
     * and `--allow-missing-tips` options below.
     */

I have also added the following to the commit message:

"We introduce another dump loop to look for that options early, but
addressing the dump loops should likely be part of adding a new
mechanism to setup_revisions() which is a different topic. Anyway
let's add a big NEEDSWORK comment to remember that we really need to
do this."

> Anyway, I digress.
>
> > diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
> > index 527aa94f07..283e8fc2c2 100755
> > --- a/t/t6022-rev-list-missing.sh
> > +++ b/t/t6022-rev-list-missing.sh
> > @@ -77,4 +77,55 @@ do
> >       done
> >  done
> >
> > +for obj in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
> > +do
> > +     for tip in "" "HEAD"
> > +     do
> > +             for action in "allow-any" "print"
> > +             do
> > +                     test_expect_success "--missing=3D$action --allow-=
missing-tips with tip '$obj' missing and tip '$tip'" '
> > +                             oid=3D"$(git rev-parse $obj)" &&
> > +                             path=3D".git/objects/$(test_oid_to_path $=
oid)" &&
> > +
> > +                             # Before the object is made missing, we u=
se rev-list to
> > +                             # get the expected oids.
> > +                             if [ "$tip" =3D "HEAD" ]; then
>
> Style:
>
>                                 if test "$tip" =3D "HEAD"
>                                 then

Fixed in my current version. In it, I also fixed in patch 2/3 a
similar style typo in the tests before these ones.

> > +                                     git rev-list --objects --no-objec=
t-names \
> > +                                             HEAD ^$obj >expect.raw
> > +                             else
> > +                                     >expect.raw
> > +                             fi &&
> > +
> > +                             # Blobs are shared by all commits, so eve=
n though a commit/tree
> > +                             # might be skipped, its blob must be acco=
unted for.
> > +                             if [ "$tip" =3D "HEAD" ] && [ $obj !=3D "=
HEAD:1.t" ]; then
>
> Ditto.

Fixed too in my current version.

> > +                                     echo $(git rev-parse HEAD:1.t) >>=
expect.raw &&
> > +                                     echo $(git rev-parse HEAD:2.t) >>=
expect.raw
> > +                             fi &&
> > +
> > +                             mv "$path" "$path.hidden" &&
> > +                             test_when_finished "mv $path.hidden $path=
" &&
> > +
> > +                             git rev-list --missing=3D$action --allow-=
missing-tips \
> > +                                  --objects --no-object-names $oid $ti=
p >actual.raw &&
> > +
> > +                             # When the action is to print, we should =
also add the missing
> > +                             # oid to the expect list.
> > +                             case $action in
> > +                             allow-any)
> > +                                     ;;
> > +                             print)
> > +                                     grep ?$oid actual.raw &&
> > +                                     echo ?$oid >>expect.raw
> > +                                     ;;
>
> OK.  We do not say anything more than the object name (and the fact
> that it is missing with a single byte '?'), so my earlier worry was
> unfounded.  Good.
>
> > +                             esac &&
> > +
> > +                             sort actual.raw >actual &&
> > +                             sort expect.raw >expect &&
> > +                             test_cmp expect actual
> > +                     '
> > +             done
> > +     done
> > +done
> > +
> >  test_done
>
> THanks.

Thanks for the review!
