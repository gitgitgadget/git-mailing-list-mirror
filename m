Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B44C1272A8
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 20:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707338921; cv=none; b=IA0fuJNNBATBLnc+5EXbnD9fO1q5vsj72m3H2lca4GbBOLBjRQ3sjNDFARdBcOUyQy2L8p/dkXJh1yFnGrBxV0odDYznMzW5p/+UNWR2gkOxGZIGcjDCU0CfMNPXS+Tuf9Y7MfkPNdTxhv4Jeto3GGtsI8tDC/ymis80svT2Sdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707338921; c=relaxed/simple;
	bh=bYtS2e37bQvInPUA+JEJjXF6WVzOmSk2iQvNwWuOjbQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hnwT3FkplEVcSnnHc/KfzUIKJ6/RwgiQJXc/C26BoBfBP+/KY5Xm2rt9T4xFZ9aa/ftPbPdj35XaPXV7C/Q6NkhvKCsPJeNWkQ0U+Z4urCPLRRNmZsoL7wZrfKSOtoa0HbgQCyTAHkO3ucv8SVSqNVBGbZLo0zsSXMYQ5SEszk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nz7Igbgg; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nz7Igbgg"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-296974e6d95so934556a91.0
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 12:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707338917; x=1707943717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMGtDQULor7UTFq87Uwys3k0HOU+Dw1bPzZZURjVmgE=;
        b=Nz7IgbggsLDEnnXch5p6FcorpMi/my/hR5z4zRSOuIqkoyo9wX7foFO+njWLJsEWKl
         oamJ7T8ldGgmnYcaBPDNyke1gp4fNa1tfuweZljljIu4uo5vSV6+JOSU9Hnr/ZAur5uS
         4O0y0YKh5YQdATAniHShzdi5+WAqgXoAC07d4RX+FxZ1CWfckOP2qf+sdHBYXTkw+04J
         wWqBWp+AA4ZGUixOTfNcEjarZO8TES2YKgpf8Tl9WE0IfyYgyq+hqLD4R//YEKdAZfTA
         dSABME7vJJczpujvHXdB4OPb+FgNS4/M4rj0bsSdxfSqeogrVr9awSo3KI/pOg3oh08d
         lHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707338917; x=1707943717;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xMGtDQULor7UTFq87Uwys3k0HOU+Dw1bPzZZURjVmgE=;
        b=BhEGXNqTFNi2k1/urbYl9ce3fxiXprsBohvjIVsSfppvS7s5sZ/iWTwSxzMuQrtQKB
         nYNUNakdVV7A+ZBj6lLSzS1XpXjx48/ZZHfBuT2u8NTeEnTjQxUDwj9Q6idsNctpOrrL
         FmpCRMfPv/rZ00we3WNiF2BD/WJ0+t8PsP6UXROuS4yAvsNhvPUvystlvT9bLiaVidbh
         jyDlckRrDy/u4gsPo+Bj+p3bai9PzlaWn8iEDFkW1it/pFM3FzteUVSHyvsdUoN1Vi73
         9xRkkdmbgpIQL/VnqKYyfgYZUcWn6gv7T7HeClR3IW/OJIgZqKPgH203dqfkHHXZRL36
         Idvg==
X-Gm-Message-State: AOJu0YwAa2RikcJmP4xP0hLbuN37s7GuE4K4H9ADnlC1fYRi7zOxdCsO
	iVyHvkgydqklleNrJObwUIZcJA1H4K5BrQUy17GkLxhaxkDDAkN29SjHWQVAPlSXRnF+N7lFhyd
	T0w==
X-Google-Smtp-Source: AGHT+IEEeokOM8adMhQRo8rI/Z+ZUR5tKB+F8yQYB7zhgfQMsKIvEEKa/hYYAKnuzjZyq1m4rsq23V95g/k=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:90b:2d0f:b0:296:df74:a025 with SMTP id
 sy15-20020a17090b2d0f00b00296df74a025mr43169pjb.9.1707338917594; Wed, 07 Feb
 2024 12:48:37 -0800 (PST)
Date: Wed, 07 Feb 2024 12:48:36 -0800
In-Reply-To: <CAP8UFD3D=a-3cVNpjobOdq=F5dC+aW4qYu3fXCxTnDg=GrnSwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201115809.1177064-1-christian.couder@gmail.com>
 <20240201115809.1177064-4-christian.couder@gmail.com> <owlywmrgmx2j.fsf@fine.c.googlers.com>
 <CAP8UFD3D=a-3cVNpjobOdq=F5dC+aW4qYu3fXCxTnDg=GrnSwA@mail.gmail.com>
Message-ID: <owlyr0hom257.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 3/3] rev-list: add --allow-missing-tips to be used with --missing=...
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	John Cai <johncai86@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Wed, Feb 7, 2024 at 10:40=E2=80=AFAM Linus Arver <linusa@google.com> w=
rote:
>>
>>
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>> > In 9830926c7d (rev-list: add commit object support in `--missing`
>> > option, 2023-10-27) we fixed the `--missing` option in `git rev-list`
>> > so that it now works with commits too.
>> >
>> > Unfortunately, such a command would still fail with a "fatal: bad
>> > object <oid>" if it is passed a missing commit, blob or tree as an
>> > argument.
>>
>> Hmm, but according to the manpage for rev-list, it only accepts commits
>> as arguments. Conflict...?
>
> It actually kind of "works" when you pass blobs or trees. It looks
> like the command just doesn't use them (except for checking that they
> actually exist) unless options like --objects, --missing=3Dprint and
> perhaps others are used. So yeah, the doc might need an update, but I
> think it could be a separate issue, as it's not new and doesn't depend
> on this small series.

SG. But also, if there's a way to put invisible (developer-facing, not
user facing) comments inside the relevant doc file it might be easy
enough to add a to this series.

>> > When such a command is used to find the dependencies of some objects,
>> > for example the dependencies of quarantined objects, it would be
>> > better if the command would instead consider such missing objects,
>> > especially commits, in the same way as other missing objects.
>>
>> Could you define what quarantined objects are (it's not in the manpage
>> for rev-list)?
>
> "quarantined objects" refers to the following doc:
>
> https://www.git-scm.com/docs/git-receive-pack#_quarantine_environment
>
> So to clarify things, the above paragraph looks like the following now:
>
> "When such a command is used to find the dependencies of some objects,
> for example the dependencies of quarantined objects (see the
> "QUARANTINE ENVIRONMENT" section in the git-receive-pack(1)
> documentation), it would be better if the command would instead
> consider such missing objects, especially commits, in the same way as
> other missing objects."

This reads much better, and is a good motivation to keep in the log
message.

>> But also, I'm not sure how much additional value this
>> paragraph is adding on top of what you already said in the first two
>> paragraphs.
>
> It's a more specific example, and it's how we detected the issue we
> would like to address, so I think it has some value.

Agreed.

>> > If, for example `--missing=3Dprint` is used, it would be nice for some
>> > use cases if the missing tips passed as arguments were reported in
>> > the same way as other missing objects instead of the command just
>> > failing.
>> >
>> > Let's introduce a new `--allow-missing-tips` option to make it work
>> > like this.
>>
>> I assume "tips" means "the starting commits which are passed into this
>> command from which it begins the rev walk". Might be worth including in
>> the commit message.
>
> I think "tips" is better than "commits" because blobs and trees are
> allowed (see above).

Makes sense.

>> > +             oidset_iter_init(&revs.missing_commits, &iter);
>> > +             while ((oid =3D oidset_iter_next(&iter)))
>> > +                     oidset_insert(&missing_objects, oid);
>> > +             oidset_clear(&revs.missing_commits);
>> > +     }
>>
>> Aside: I am surprised that there is no helper function already that
>> simply copies things in one oidset into another oidset.
>
> Yeah, I was surprised too. I only found the following similar code in
> list-objects-filter.c:
>
>     oidset_iter_init(src, &iter);
>     while ((src_oid =3D oidset_iter_next(&iter)) !=3D NULL)
>         oidset_insert(dest, src_oid);
>
> So yeah perhaps we could create such a helper function.

Perhaps a NEEDSWORK comment is appropriate?

>> >       traverse_commit_list_filtered(
>> >               &revs, show_commit, show_object, &info,
>> >               (arg_print_omitted ? &omitted_objects : NULL));
>> > diff --git a/revision.c b/revision.c
>> > index 4c5cd7c3ce..9f25faa249 100644
>> > --- a/revision.c
>> > +++ b/revision.c
>> >
>> > [...]
>> >
>> > @@ -2184,7 +2189,7 @@ static int handle_revision_arg_1(const char *arg=
_, struct rev_info *revs, int fl
>> >               verify_non_filename(revs->prefix, arg);
>> >       object =3D get_reference(revs, arg, &oid, flags ^ local_flags);
>> >       if (!object)
>> > -             return revs->ignore_missing ? 0 : -1;
>> > +             return (revs->ignore_missing || revs->do_not_die_on_miss=
ing_tips) ? 0 : -1;
>> >       add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local_f=
lags);
>> >       add_pending_object_with_path(revs, object, arg, oc.mode, oc.path=
);
>> >       free(oc.path);
>>
>> With a few more context lines, the diff looks like
>>
>> --8<---------------cut here---------------start------------->8---
>>         if (get_oid_with_context(revs->repo, arg, get_sha1_flags, &oid, =
&oc))
>>                 return revs->ignore_missing ? 0 : -1;
>>         if (!cant_be_filename)
>>                 verify_non_filename(revs->prefix, arg);
>>         object =3D get_reference(revs, arg, &oid, flags ^ local_flags);
>>         if (!object)
>> -               return revs->ignore_missing ? 0 : -1;
>> +               return (revs->ignore_missing || revs->do_not_die_on_miss=
ing_tips) ? 0 : -1;
>>         add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local_f=
lags);
>>         add_pending_object_with_path(revs, object, arg, oc.mode, oc.path=
);
>>         free(oc.path);
>>         return 0;
>> --8<---------------cut here---------------end--------------->8---
>>
>> and it's not obvious to me why you only touched the "if (!object)" case
>> but not the "if (get_oid_with_context(...))" case. Are there any
>> subtleties here that would not be obvious to reviewers?
>
> I thought that if we can't get an oid, we cannot put anything in the
> 'missing_commit' oidset anyway, so it might be better to error out.

Ah, makes sense. This is a subtle detail, and perhaps worth keeping
either as a comment (just above the "if (get_oid_with_context(...))"
case) or in the log message.

>> > diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
>> > index 527aa94f07..283e8fc2c2 100755
>> > --- a/t/t6022-rev-list-missing.sh
>> > +++ b/t/t6022-rev-list-missing.sh
>> > @@ -77,4 +77,55 @@ do
>> >       done
>> >  done
>> >
>> > +for obj in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
>> > +do
>> > +     for tip in "" "HEAD"
>>
>> So far from the patch diff it was not obvious that you wanted to check
>> for the empty string as a "tip".
>
> We want to check that things work as expected both:
>
>   - when we pass only one missing tip, and:
>   - when we pass one missing tip and a tip that is not missing.

Ah, I see. I think you could add a comment like

    We want to check that things work as expected both:
   =20
      - when we pass only one missing tip (when $tip is ""), and:
      - when we pass one missing tip and a tip that is not missing (when
        $tip is "HEAD").

at the top of the test case, and probably rename $obj to $missing_tip,
and rename $tip to $existing_tip.

Aside: it's a bit unfortunate that the meaning of "missing" becomes
overloaded slightly here because one could say '$tip =3D=3D ""' is a
"missing" tip becauuse the name is not provided. Subtle. Plus there's
some interplay with the "if (get_oid_with_context(...))" case above
because we will (?) hit that path if we do pass in "" (empty string arg)
as a tip to rev-list. It might be worth saying in the comments in the
implementation, something like

    The term "missing" here means the case where we could not find the obje=
ct
    given the object_id. For example, given HEAD~1, its object id (oid)
    could be 82335b23aa7234320d6f8055243c852e4b6a5ca3. If no real object
    with this oid exists, it is considered missing. Providing an empty
    string to rev-list does not touch the "missing tip" codepath.

I wrote the above hastily so it may need further edits to make it
succinct. But the point is that this definition isn't spelled out in the
test case, which makes the "" argument for $tip that much more subtle.

>> > +     do
>> > +             for action in "allow-any" "print"
>> > +             do
>> > +                     test_expect_success "--missing=3D$action --allow=
-missing-tips with tip '$obj' missing and tip '$tip'" '
>>
>> If I run this test without the new --allow-missing-tips flag, I get
>>
>>     fatal: bad object 82335b23aa7234320d6f8055243c852e4b6a5ca3
>>     not ok 11 - --missing=3Dallow-any --allow-missing-tips with tip 'HEA=
D~1' missing and tip ''
>>
>> and I think the last "tip ''" part is misleading because IIUC it's not
>> actually passed in as a tip (see my comment below about shell quoting).
>>
>> > +                             oid=3D"$(git rev-parse $obj)" &&
>> > +                             path=3D".git/objects/$(test_oid_to_path =
$oid)" &&
>> > +
>> > +                             # Before the object is made missing, we =
use rev-list to
>> > +                             # get the expected oids.
>> > +                             if [ "$tip" =3D "HEAD" ]; then
>> > +                                     git rev-list --objects --no-obje=
ct-names \
>> > +                                             HEAD ^$obj >expect.raw
>> > +                             else
>> > +                                     >expect.raw
>> > +                             fi &&
>>
>> OK so you are using this empty string to clear the expect.raw file. If
>> that's true then what stops us from doing this at the start of every
>> iteration?
>
> I am not sure what you mean. Both:
>
>     git rev-list --objects --no-object-names HEAD ^$obj >expect.raw
>
> and:
>
>     >expect.raw #2
>
> are clearing "expect.raw" as ">expect.raw" is used in both cases.
>
> If we did the latter at the start of every iteration, then when we do
> the former afterwards, we would clear "expect.raw" raw again, while
> there is no point in clearing it twice.

Yes but doing it that way would separate "set up a clean environment for
this test case" from "find the oid of the non-missing tip" from each
other in the same if/else stanza, which I believe helps readability.

>> for the case where tip is the empty string. I wonder if we could avoid
>> being nuanced here with subtle shell quoting rules, especially because
>> these are tests (where making everything as explicit as possible is
>> desirable).
>
> I think it's not very subtle, but perhaps a comment would help. So I
> added the following to my current version before the loop:
>
>     # We want to check that things work when both
>     #   - all the tips passed are missing (case tip =3D ""), and
>     #   - there is one missing tip and one existing tip (case tip =3D "HE=
AD")

Great, thanks.

>> > +                             # When the action is to print, we should=
 also add the missing
>> > +                             # oid to the expect list.
>> > +                             case $action in
>> > +                             allow-any)
>> > +                                     ;;
>> > +                             print)
>> > +                                     grep ?$oid actual.raw &&
>> > +                                     echo ?$oid >>expect.raw
>> > +                                     ;;
>> > +                             esac &&
>> > +
>> > +                             sort actual.raw >actual &&
>> > +                             sort expect.raw >expect &&
>> > +                             test_cmp expect actual
>> > +                     '
>> > +             done
>> > +     done
>> > +done
>> > +
>>
>> Wait, but where are we actually making the $tip commit's object
>> _missing_? Hmm...
>>
>> Ah, actually the tips are just the $obj variables. So it seems like you
>> could have done
>>
>>     for tip in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
>>
>> in the beginning to make it more obvious.
>
> The previous tests in this test script used "oid" as the variable name
> for possibly missing objects, so I did the same in the tests I added.

Didn't the previous tests _always_ make those objects missing?

> I could have used "tip" and "extra_tip" instead of "oid" and "tip" or
> perhaps "oid" and "extra_oid", but I don't think it makes a big
> difference in understanding these tests.

I agree that it doesn't make a big difference now (to me at least), but
I worry for the other future Git developers who'll need to do that small
amount of mental effort to gain the same understanding as us in this
review process. I would still prefer the names "missing_tip" (or
"possibly_missing_tip" if my immediate comment above is not correct) and
"existing_tip" as suggested in my other comment.

>> Also, given how most of this is identical from the loop already in t6022
>> just above it, it would help to add a comment at the top of this one
>> explaining how it's different than the one above it.
>
> The one I added has an extra `for tip in "" "HEAD"` loop. Anyway I
> think I will just modify the existing test in the next version I will
> send, as I plan to implement Junio's suggestion and there will be no
> new option.

SG.

> Thanks for the review!

You're welcome.

Now that I have your attention (was this my plan all along? ;) ), I will
take this opportunity to ping you directly for a review of my own patch
series for the trailers subsystem:
https://lore.kernel.org/git/pull.1632.v4.git.1707196348.gitgitgadget@gmail.=
com/
which is in its 4th iteration after many helpful comments from Junio.
Please don't let the patch count (28) raise any alarms --- they used to
be 10 but I broke them down into smaller steps to ease the review
process.

Thanks.
