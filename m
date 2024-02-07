Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1267E78C
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707322316; cv=none; b=G4VXE29xngoYHktzWPS9L7XREdrkzAhH3GeduDex4PsnHWhTOxbN+jcg4BlnZZ6zCgnYZyU0AejEvvK8f2rB7aNhHQmctN2D/PD7TkwfDMqypSlt25TaXBChD1xSc22HLYZHWHflwIHrGUmYTMBQKB6nim71B02odpfMs7oPofk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707322316; c=relaxed/simple;
	bh=d+TpFHHxTN3yqffwFVUNTZtt+5NmuP5sngCYRc8m/xY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqPCybpFof67VGorzlylHWXiDAbGvKoKdyQ4Jbg88Z9WXnN/RjSVsuJLLt4oKtnQ3IePw1vL9ULtkrf33f2ohvdbAP8hM/j2v23o+Q6TOFWzArZzXO6laV3ZPRqMtiBevulqUNBuzBBWYOvPRzljImWoCsUFFflw5BSO2l9PCII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbK1/HXf; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbK1/HXf"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a370328e8b8so102104066b.3
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 08:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707322313; x=1707927113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjJCxA7NmcU8jGv7vvuZyxFcubaYCz/v8kCR+FAreuA=;
        b=RbK1/HXfvKbvB1jG0/yNE1fHAGIKoNlMGmiB2t2zl3waZK3Jx61TuVOM40E2K2rwY6
         KmBcfQts8/g/TFfJTshscaNQb35DouYlNbsFlqUc3nFZO/mN93bQ1jeJHJ//kBUnWpnb
         E38MEev/U7Tx7WEJo4U0wyTWK+aCS/L35JPkCskd9yY4daliw593jhA7mXk5D7SA4pyQ
         yMJN7f6bGg0xaU6QEplYI0Hdt0tBXEeBqydQWzDN7XMa1TJrgBFn1JcHF2HBtjDjWG5E
         NO33uH0bTpHfKa26IjTaZNYK97LwwgWTUCWCyXF5OrsgM6SpQmfyAzJRIRUy59fyQjqM
         ocMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707322313; x=1707927113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjJCxA7NmcU8jGv7vvuZyxFcubaYCz/v8kCR+FAreuA=;
        b=sqCT4DOBoPNSr4Zr9J3+E0lqPZ9IsJ91O7W+Obdld8Q231ejJR92781t5yOjdlnIsS
         G4EFsCfhhPIxzzeJ5Cm69/vQRI/LpqUGF3WHCWp0QwMSN9y7CmMIlYMqklR8DAt5vt97
         oXQlI4z3gyS8rmuSfFD0H6iJYweQgz07vv75wjDh2Xy6FNJzl0BNwveqXAaekphtzu0H
         LGA6S6MCAdg0X/ko6rtr+rPWQ3sy1stZti20ziEEC12A27qRcGeO60S2Fh7CNhuGzBOC
         yq3n2vMI2PpMHSVdIpqeChoS2wk3w3amL4ze4mMSRuubVuflKEKgTOcEFIb4V0y32FzY
         3aSQ==
X-Gm-Message-State: AOJu0YwfFsuXc0Jih0Z+TlvzexRS9c2wJskfYaNb0ElueJorWny4woIM
	pkoCxgxsqC5CCmtymwNpdC6r5wFL8xzHKyemJjieNPZTM3K67GyfLFd8m8kJU2CPnkyrjrGRNoI
	cvtDOfijTXJLlKpJpodyXhDcpHXE=
X-Google-Smtp-Source: AGHT+IFUzcdG0zl57dVkw4ZUQymuCtkDpj4dFGimAp06DSebjh97XAvDj/kfcoYmJhkQJT3nAFNyTYK49aSLKqEF3gU=
X-Received: by 2002:a17:907:77d8:b0:a38:9c33:b46c with SMTP id
 kz24-20020a17090777d800b00a389c33b46cmr535286ejc.44.1707322312500; Wed, 07
 Feb 2024 08:11:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201115809.1177064-1-christian.couder@gmail.com>
 <20240201115809.1177064-4-christian.couder@gmail.com> <owlywmrgmx2j.fsf@fine.c.googlers.com>
In-Reply-To: <owlywmrgmx2j.fsf@fine.c.googlers.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 7 Feb 2024 17:11:39 +0100
Message-ID: <CAP8UFD3D=a-3cVNpjobOdq=F5dC+aW4qYu3fXCxTnDg=GrnSwA@mail.gmail.com>
Subject: Re: [PATCH 3/3] rev-list: add --allow-missing-tips to be used with --missing=...
To: Linus Arver <linusa@google.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	John Cai <johncai86@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 10:40=E2=80=AFAM Linus Arver <linusa@google.com> wro=
te:
>
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
>
> Hmm, but according to the manpage for rev-list, it only accepts commits
> as arguments. Conflict...?

It actually kind of "works" when you pass blobs or trees. It looks
like the command just doesn't use them (except for checking that they
actually exist) unless options like --objects, --missing=3Dprint and
perhaps others are used. So yeah, the doc might need an update, but I
think it could be a separate issue, as it's not new and doesn't depend
on this small series.

> Also it took me a second to realize that you are talking about
> missing objects passed in at the command line to `git rev-list` and not
> the objects that this command encounters during the normal rev walking
> process. It would have been a touch nicer to say something more
> explicit, like
>
>     In 9830926c7d (rev-list: add commit object support in `--missing`
>     option, 2023-10-27) we fixed the `--missing` option in `git rev-list`
>     so that it works with missing commits, not just blobs/trees.
>
>     Unfortunately, it would still fail with a "fatal: bad
>     object <oid>" if it is passed a missing commit as an
>     argument (before the rev walking even begins).

Thanks, I have used your suggestions in my current version, except
that I still use "passed a missing commit, blob or tree" instead of
"passed a missing commit" as the command also accepts blobs and trees.

> > When such a command is used to find the dependencies of some objects,
> > for example the dependencies of quarantined objects, it would be
> > better if the command would instead consider such missing objects,
> > especially commits, in the same way as other missing objects.
>
> Could you define what quarantined objects are (it's not in the manpage
> for rev-list)?

"quarantined objects" refers to the following doc:

https://www.git-scm.com/docs/git-receive-pack#_quarantine_environment

So to clarify things, the above paragraph looks like the following now:

"When such a command is used to find the dependencies of some objects,
for example the dependencies of quarantined objects (see the
"QUARANTINE ENVIRONMENT" section in the git-receive-pack(1)
documentation), it would be better if the command would instead
consider such missing objects, especially commits, in the same way as
other missing objects."

> But also, I'm not sure how much additional value this
> paragraph is adding on top of what you already said in the first two
> paragraphs.

It's a more specific example, and it's how we detected the issue we
would like to address, so I think it has some value. I am Ok with
removing it, if others don't see some value in it though.

> > If, for example `--missing=3Dprint` is used, it would be nice for some
> > use cases if the missing tips passed as arguments were reported in
> > the same way as other missing objects instead of the command just
> > failing.
> >
> > Let's introduce a new `--allow-missing-tips` option to make it work
> > like this.
>
> I assume "tips" means "the starting commits which are passed into this
> command from which it begins the rev walk". Might be worth including in
> the commit message.

I think "tips" is better than "commits" because blobs and trees are
allowed (see above).

> But also, it's curious that you chose the word "allow" when we already
> have "--ignore-missing". I assume this is because you still want the
> missing tips to still be displayed in the output, and not ignored
> (omitted from processing altogether). Perhaps "--report-missing-tips"
> is more explicit?

I think "allow" is better as it makes it clearer that the command will
not fail while it should fail without the option.

Anyway I think I will implement Junio's suggestion to just avoid
adding a new option and just change the behavior of the command when
--missing=3D[print|allow*] is used.

> > @@ -753,9 +765,19 @@ int cmd_rev_list(int argc, const char **argv, cons=
t char *prefix)
> >
> >       if (arg_print_omitted)
> >               oidset_init(&omitted_objects, DEFAULT_OIDSET_SIZE);
> > -     if (arg_missing_action =3D=3D MA_PRINT)
> > +     if (arg_missing_action =3D=3D MA_PRINT) {
> > +             struct oidset_iter iter;
> > +             struct object_id *oid;
> > +
> >               oidset_init(&missing_objects, DEFAULT_OIDSET_SIZE);
> >
> > +             /* Already add missing commits */
>
> Did you mean "Add already-missing commits"? Perhaps even more explicit
> would be "Add missing tips"?

Yeah, right. I have changed it in my current version.

> > +             oidset_iter_init(&revs.missing_commits, &iter);
> > +             while ((oid =3D oidset_iter_next(&iter)))
> > +                     oidset_insert(&missing_objects, oid);
> > +             oidset_clear(&revs.missing_commits);
> > +     }
>
> Aside: I am surprised that there is no helper function already that
> simply copies things in one oidset into another oidset.

Yeah, I was surprised too. I only found the following similar code in
list-objects-filter.c:

    oidset_iter_init(src, &iter);
    while ((src_oid =3D oidset_iter_next(&iter)) !=3D NULL)
        oidset_insert(dest, src_oid);

So yeah perhaps we could create such a helper function.

> >       traverse_commit_list_filtered(
> >               &revs, show_commit, show_object, &info,
> >               (arg_print_omitted ? &omitted_objects : NULL));
> > diff --git a/revision.c b/revision.c
> > index 4c5cd7c3ce..9f25faa249 100644
> > --- a/revision.c
> > +++ b/revision.c
> >
> > [...]
> >
> > @@ -2184,7 +2189,7 @@ static int handle_revision_arg_1(const char *arg_=
, struct rev_info *revs, int fl
> >               verify_non_filename(revs->prefix, arg);
> >       object =3D get_reference(revs, arg, &oid, flags ^ local_flags);
> >       if (!object)
> > -             return revs->ignore_missing ? 0 : -1;
> > +             return (revs->ignore_missing || revs->do_not_die_on_missi=
ng_tips) ? 0 : -1;
> >       add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local_fl=
ags);
> >       add_pending_object_with_path(revs, object, arg, oc.mode, oc.path)=
;
> >       free(oc.path);
>
> With a few more context lines, the diff looks like
>
> --8<---------------cut here---------------start------------->8---
>         if (get_oid_with_context(revs->repo, arg, get_sha1_flags, &oid, &=
oc))
>                 return revs->ignore_missing ? 0 : -1;
>         if (!cant_be_filename)
>                 verify_non_filename(revs->prefix, arg);
>         object =3D get_reference(revs, arg, &oid, flags ^ local_flags);
>         if (!object)
> -               return revs->ignore_missing ? 0 : -1;
> +               return (revs->ignore_missing || revs->do_not_die_on_missi=
ng_tips) ? 0 : -1;
>         add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local_fl=
ags);
>         add_pending_object_with_path(revs, object, arg, oc.mode, oc.path)=
;
>         free(oc.path);
>         return 0;
> --8<---------------cut here---------------end--------------->8---
>
> and it's not obvious to me why you only touched the "if (!object)" case
> but not the "if (get_oid_with_context(...))" case. Are there any
> subtleties here that would not be obvious to reviewers?

I thought that if we can't get an oid, we cannot put anything in the
'missing_commit' oidset anyway, so it might be better to error out.

> > @@ -3830,8 +3835,6 @@ int prepare_revision_walk(struct rev_info *revs)
> >                                      FOR_EACH_OBJECT_PROMISOR_ONLY);
> >       }
> >
> > -     oidset_init(&revs->missing_commits, 0);
> > -
> >       if (!revs->reflog_info)
> >               prepare_to_use_bloom_filter(revs);
> >       if (!revs->unsorted_input)
> > diff --git a/revision.h b/revision.h
> > index 94c43138bc..67435a5d8a 100644
> > --- a/revision.h
> > +++ b/revision.h
> > @@ -227,6 +227,14 @@ struct rev_info {
> >                        */
> >                       do_not_die_on_missing_objects:1,
> >
> > +                     /*
> > +                      * When the do_not_die_on_missing_objects flag ab=
ove is set,
> > +                      * a rev walk could still die with "fatal: bad ob=
ject <oid>"
> > +                      * if one of the tips it is passed is missing. Wi=
th this flag
> > +                      * such a tip will be reported as missing too.
> > +                      */
> > +                      do_not_die_on_missing_tips:1,
> > +
> >                       /* for internal use only */
> >                       exclude_promisor_objects:1;
>
> IIUC, we won't get to even do the rev walk though if all tips are
> missing. So perhaps a more precise comment would be
>
>     /*
>      * When the do_not_die_on_missing_objects flag above is set,
>      * we could prematurely die with "fatal: bad object <oid>"
>      * if one of the tips it is passed is missing before even getting to
>      * the rev walk. With this flag such a tip will be reported as
>      * missing in the output after the rev walk completes.
>      */

Thanks for the suggestion, I have now:

            /*
             * When the do_not_die_on_missing_objects flag above is set,
             * we could prematurely die with "fatal: bad object <oid>"
             * if one of the tips passed to a rev walk is missing, before
             * the rev walk even starts. With this flag such a tip will
             * be reported as missing in the output after the rev walk
             * completes.
             */
             do_not_die_on_missing_tips:1,


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
>
> So far from the patch diff it was not obvious that you wanted to check
> for the empty string as a "tip".

We want to check that things work as expected both:

  - when we pass only one missing tip, and:
  - when we pass one missing tip and a tip that is not missing.

We are setting 'tip' to "" in the former case so that when we will use
"$oid $tip" in the `git rev-list --missing=3D$action
--allow-missing-tips ...` command below, it will be like we passed
only "$oid" to the command.

> > +     do
> > +             for action in "allow-any" "print"
> > +             do
> > +                     test_expect_success "--missing=3D$action --allow-=
missing-tips with tip '$obj' missing and tip '$tip'" '
>
> If I run this test without the new --allow-missing-tips flag, I get
>
>     fatal: bad object 82335b23aa7234320d6f8055243c852e4b6a5ca3
>     not ok 11 - --missing=3Dallow-any --allow-missing-tips with tip 'HEAD=
~1' missing and tip ''
>
> and I think the last "tip ''" part is misleading because IIUC it's not
> actually passed in as a tip (see my comment below about shell quoting).
>
> > +                             oid=3D"$(git rev-parse $obj)" &&
> > +                             path=3D".git/objects/$(test_oid_to_path $=
oid)" &&
> > +
> > +                             # Before the object is made missing, we u=
se rev-list to
> > +                             # get the expected oids.
> > +                             if [ "$tip" =3D "HEAD" ]; then
> > +                                     git rev-list --objects --no-objec=
t-names \
> > +                                             HEAD ^$obj >expect.raw
> > +                             else
> > +                                     >expect.raw
> > +                             fi &&
>
> OK so you are using this empty string to clear the expect.raw file. If
> that's true then what stops us from doing this at the start of every
> iteration?

I am not sure what you mean. Both:

    git rev-list --objects --no-object-names HEAD ^$obj >expect.raw

and:

    >expect.raw #2

are clearing "expect.raw" as ">expect.raw" is used in both cases.

If we did the latter at the start of every iteration, then when we do
the former afterwards, we would clear "expect.raw" raw again, while
there is no point in clearing it twice.

> > +                             # Blobs are shared by all commits, so eve=
n though a commit/tree
> > +                             # might be skipped, its blob must be acco=
unted for.
> > +                             if [ "$tip" =3D "HEAD" ] && [ $obj !=3D "=
HEAD:1.t" ]; then
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
>
> The fact that $tip is not quoted here means that this is equivalent to
>
>     --objects --no-object-names $oid >actual.raw &&
>
> and not
>
>     --objects --no-object-names $oid "" >actual.raw &&

Yeah, right, and that's what we want.

> for the case where tip is the empty string. I wonder if we could avoid
> being nuanced here with subtle shell quoting rules, especially because
> these are tests (where making everything as explicit as possible is
> desirable).

I think it's not very subtle, but perhaps a comment would help. So I
added the following to my current version before the loop:

    # We want to check that things work when both
    #   - all the tips passed are missing (case tip =3D ""), and
    #   - there is one missing tip and one existing tip (case tip =3D "HEAD=
")

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
>
> Wait, but where are we actually making the $tip commit's object
> _missing_? Hmm...
>
> Ah, actually the tips are just the $obj variables. So it seems like you
> could have done
>
>     for tip in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
>
> in the beginning to make it more obvious.

The previous tests in this test script used "oid" as the variable name
for possibly missing objects, so I did the same in the tests I added.
I could have used "tip" and "extra_tip" instead of "oid" and "tip" or
perhaps "oid" and "extra_oid", but I don't think it makes a big
difference in understanding these tests.

> Also, given how most of this is identical from the loop already in t6022
> just above it, it would help to add a comment at the top of this one
> explaining how it's different than the one above it.

The one I added has an extra `for tip in "" "HEAD"` loop. Anyway I
think I will just modify the existing test in the next version I will
send, as I plan to implement Junio's suggestion and there will be no
new option.

Thanks for the review!
