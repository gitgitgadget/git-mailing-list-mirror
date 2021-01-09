Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D22EC433DB
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 13:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D0F23998
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 13:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbhAINdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 08:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbhAINdM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 08:33:12 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E97C061786
        for <git@vger.kernel.org>; Sat,  9 Jan 2021 05:32:31 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id b64so12237119ybg.7
        for <git@vger.kernel.org>; Sat, 09 Jan 2021 05:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z/CKcVVkeoQ9Y/DReg793iytV2KJigYN2r/9LLt0MkI=;
        b=vKBakgE3//H39M5sncAjopL3h7r53NLNXBdpj0x8OMcD2WOy5WBEqoq5RcCoYuMpDb
         m174w9xfdHthzQdsv8P9kQZWNgTNTH8KHr6Epqd8p7FX7X1sFgv03o+YY6sM/N8zrZd2
         4L/pvfxkpP94fwfLX2FkjYo59GWyhSOwxq0GulidUb/Pm5e7u8vvPR0FoHU6U3jJ5QlO
         aI6FTm+H2H2NAbYbgvYRF49b+N6+3i2i0gga4jGuwNiGoA9MHq57DwMJIjvAlgOUcewI
         cxcGt6mV98NOwjxHFOads/kTp/ga2nMUkQXPGope4FNQnb6aFqNwEANMVr0prRAdShbC
         wPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z/CKcVVkeoQ9Y/DReg793iytV2KJigYN2r/9LLt0MkI=;
        b=uYQikXy+VvmzP+UjKopN45lwvHChLOMLjqYJvKCJRUoQs36PSbm9J7GriiXr6GPx0B
         K9row0uh/fbTcvJziGzKSaN0r57U6VLxe7GpHmSvhoYkeUAY9UJoJG5lbzAar2RkhDQp
         wZ7fUfyPRLrvGiVbRZaAbVvyMe4Mpe/9b1EkHJzPy21gQeG5G8adXdzY2DYrgRhfbWyH
         rXmhpUIVPCk1j7cKtJDhHQm2BKOBOa4KM6qYqt4JXK0wW6tRXu5XrR0Mchg04MObO+cQ
         CQyTgJskTLn1lEcYIBBr1oZvm+sO8BqC6ZTz5CiONPCDEInqhfAVHU0n41sA1aFFu2Ns
         ue6w==
X-Gm-Message-State: AOAM5306ud9UQ+Bl1Hxq7RXEadwj8S0yemTmOEEaSvQzMWzhczBpOtsh
        60ZxUIPe5y16VAON6iX0WHYiE42eH1vwFOx5CHwIYLol
X-Google-Smtp-Source: ABdhPJzFWtFlsYZ64rFeygc1eKxKgMEH0iy7bWgFZTsI3qNiYvdzFzvo2q7dxjfNB/Y3V+vGoIcU5+NLNrWt23yJ6GA=
X-Received: by 2002:a25:8249:: with SMTP id d9mr12375695ybn.41.1610199151079;
 Sat, 09 Jan 2021 05:32:31 -0800 (PST)
MIME-Version: 1.0
References: <X/cqrTgilKAW9P9G@danh.dev> <20210108144514.24805-2-worldhello.net@gmail.com>
 <xmqqv9c6g8r4.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqv9c6g8r4.fsf@gitster.c.googlers.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sat, 9 Jan 2021 21:32:18 +0800
Message-ID: <CANYiYbGcXORT-kryEngy17_J1g3FDKbty9wVXj1U5OWHu8yM8g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] bundle: lost objects when removing duplicate pendings
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=889=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8810:11=E5=86=99=E9=81=93=EF=BC=9A
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
> > new file mode 100755
> > index 0000000000..c4447ca88f
> > --- /dev/null
> > +++ b/t/t6020-bundle-misc.sh
> > @@ -0,0 +1,477 @@
> > +#!/bin/sh
> > +#
> > +# Copyright (c) 2021 Jiang Xin
> > +#
> > +
> > +test_description=3D'Test git-bundle'
> > +
> > +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> > +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> > +
> > +. ./test-lib.sh
> > +
> > +# Check count of objects in a bundle file.
> > +# We can use "--thin" opiton to check thin pack, which must be fixed b=
y
> > +# command `git-index-pack --fix-thin --stdin`.
> > +test_bundle_object_count () {
> > +     thin=3D &&
> > +     if test "$1" =3D "--thin"
> > +     then
> > +             thin=3Dyes
> > +             shift
> > +     fi &&
> > +     if test $# -ne 2
> > +     then
> > +             echo >&2 "args should be: <bundle> <count>"
> > +             return 1
> > +     fi
> > +     bundle=3D$1 &&
> > +     pack=3D${bundle%.bdl}.pack &&
> > +     convert_bundle_to_pack <"$bundle" >"$pack" &&
> > +     if test -n "$thin"
> > +     then
> > +             test_must_fail git index-pack "$pack" &&
>
> This is overly strict, isn't it?

I want to make sure that the created bundle file which contains a thin
pack is not changed, but now I think this check is not necessary,
testing the count of objects is enough.

> Imagine a case where the objects newer revisions introduce have *no*
> resemblance to the objects in the prerequisites' trees---the
> resulting pack will have no object that is expressed as a delta
> against anything outside the pack, and the above "index-pack" would
> succeed.
>
> Besides, "git pack-objects --thin" is *not* obligated to create a
> pack that lacks one or more objects.  The "--thin" option merely
> *allows* pack-objects to omit base objects if it is convenient to do
> so.
>
> > +             mv "$pack" "$pack"-thin &&
> > +             cat "$pack"-thin |
> > +                     git index-pack --stdin --fix-thin "$pack"
>
> This side is good, but do not cat a single file into a pipe.
> The whole "then" clause would become
>
>         then
>                 mv "$pack" "$pack-thin" &&
>                 git index-pack --stdin --fix-thin "$pack" <"$pack-thin"
>         else
>
> I would think.

That's better.

> > +     else
> > +             git index-pack "$pack"
> > +     fi &&
> > +     git verify-pack -v "$pack" >verify.out
> > +     if test $? -ne 0
> > +     then
> > +             echo >&2 "error: fail to convert $bundle to $pack"
> > +             return 1
> > +     fi
>
> At this point, we are not testing the bundle subcommand, but is
> testing "git index-pack --fix-thin" that we run ourselves.  Is it
> essential to ensure $pack is sane here?  I doubt it.

If not check the return error code of `git index-pack`, the report
message will be "error: object count for $bundle is , not $2". I want
to give a specific error message for developer.

> > +     count=3D$(grep -c "^$OID_REGEX " verify.out) &&
>
> And if there is no need to run verify-pack, then we can do
> count=3D$(git show-index "${pack%pack}idx" | wc -l) instead, perhaps?

Will do.

> > +     test $2 =3D $count && return 0
> > +     echo >&2 "error: object count for $bundle is $count, not $2"
> > +     return 1
> > +}
> > +
> > +# Display the pack data contained in the bundle file, bypassing the
> > +# header that contains the signature, prerequisites and references.
> > +convert_bundle_to_pack () {
> > +     while read x && test -n "$x"
> > +     do
> > +             :;
> > +     done
> > +     cat
> > +}
>
> This looks somewhat familiar.  Perhaps extract out necessary helpers
> including this one into t/test-bundle-lib or something similar in a
> preparatory step before this patch?
>
> > +# Create a commit or tag and set the variable with the object ID.
> > +test_commit_setvar () {
> > +     notick=3D &&
> > +     signoff=3D &&
> > +     indir=3D &&
> > +     merge=3D &&
> > +     tag=3D &&
> > +     var=3D &&
> > +     while test $# !=3D 0
> > +     do
> > +             case "$1" in
> > +             --merge)
> > +                     merge=3Dyes
> > +                     ;;
> > +             --tag)
> > +                     tag=3Dyes
> > +                     ;;
> > +             --notick)
> > +                     notick=3Dyes
> > +                     ;;
> > +             --signoff)
> > +                     signoff=3D"$1"
> > +                     ;;
> > +             -C)
> > +                     indir=3D"$2"
> > +                     shift
> > +                     ;;
> > +             -*)
> > +                     echo >&2 "error: unknown option $1"
> > +                     return 1
> > +                     ;;
> > +             *)
> > +                     test -n "$var" && break
> > +                     var=3D$1

The loop ends only if $var has been assigned a value, or no other
args.  Will report error if no other args later.

> > +                     ;;
> > +             esac
> > +             shift
> > +     done &&
>
> At this point, if $var is still empty, the caller is buggy, and ...

See the above note.

> > +     indir=3D${indir:+"$indir"/} &&
> > +     if test $# -eq 0
> > +     then
> > +             echo >&2 "no args provided"
> > +             return 1
> > +     fi &&
> > +     if test -z "$notick"
> > +     then
> > +             test_tick
> > +     fi &&
> > +     if test -n "$merge"
> > +     then
> > +             git ${indir:+ -C "$indir"} merge --no-edit --no-ff \
> > +                     ${2:+-m "$2"} "$1" &&
> > +             oid=3D$(git ${indir:+ -C "$indir"} rev-parse HEAD)
> > +     elif test -n "$tag"
> > +     then
> > +             git ${indir:+ -C "$indir"} tag -m "$1" "$1" &&
> > +             oid=3D$(git ${indir:+ -C "$indir"} rev-parse "$1")
> > +     else
> > +             file=3D${2:-"$1.t"} &&
> > +             echo "${3-$1}" > "$indir$file" &&
> > +             git ${indir:+ -C "$indir"} add "$file" &&
> > +             git ${indir:+ -C "$indir"} commit $signoff -m "$1" &&
> > +             oid=3D$(git ${indir:+ -C "$indir"} rev-parse HEAD)
> > +     fi &&
> > +     eval $var=3D$oid
> > +}
>
> ... it will cause a failure in 'eval' we have here.  Not good.
>
> > +# Format the output of git commands to make a user-friendly and stable
> > +# text.  We can easily prepare the expect text without having to worry
> > +# about future changes of the commit ID and spaces of the output.
>
> Hmph.  This relies on 7 hexdigits being sufficient to uniquely
> identify all objects involved in the test?  It should be OK in
> practice.
>
> Is there a point in having both <COMMIT-A> and <OID-A>?  I would
> have expected that all these "full object name" conversions are
> unneeded.

Will do.

> > +make_user_friendly_and_stable_output () {
> > +     sed \
> > +             -e "s/$A/<COMMIT-A>/" \
> > +             -e "s/$B/<COMMIT-B>/" \
> > +             -e "s/$C/<COMMIT-C>/" \
> > +             -e "s/$D/<COMMIT-D>/" \
> > +             -e "s/$E/<COMMIT-E>/" \
> > +             -e "s/$F/<COMMIT-F>/" \
> > +             -e "s/$G/<COMMIT-G>/" \
> > +             -e "s/$H/<COMMIT-H>/" \
> > +             -e "s/$I/<COMMIT-I>/" \
> > +             -e "s/$J/<COMMIT-J>/" \
> > +             -e "s/$K/<COMMIT-K>/" \
> > +             -e "s/$L/<COMMIT-L>/" \
> > +             -e "s/$M/<COMMIT-M>/" \
> > +             -e "s/$N/<COMMIT-N>/" \
> > +             -e "s/$O/<COMMIT-O>/" \
> > +             -e "s/$P/<COMMIT-P>/" \
> > +             -e "s/$TAG1/<TAG-1>/" \
> > +             -e "s/$TAG2/<TAG-2>/" \
> > +             -e "s/$TAG3/<TAG-3>/" \
> > +             -e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g" \
> > +             -e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g" \
> > +             -e "s/$(echo $C | cut -c1-7)[0-9a-f]*/<OID-C>/g" \
> > +             -e "s/$(echo $D | cut -c1-7)[0-9a-f]*/<OID-D>/g" \
> > +             -e "s/$(echo $E | cut -c1-7)[0-9a-f]*/<OID-E>/g" \
> > +             -e "s/$(echo $F | cut -c1-7)[0-9a-f]*/<OID-F>/g" \
> > +             -e "s/$(echo $G | cut -c1-7)[0-9a-f]*/<OID-G>/g" \
> > +             -e "s/$(echo $H | cut -c1-7)[0-9a-f]*/<OID-H>/g" \
> > +             -e "s/$(echo $I | cut -c1-7)[0-9a-f]*/<OID-I>/g" \
> > +             -e "s/$(echo $J | cut -c1-7)[0-9a-f]*/<OID-J>/g" \
> > +             -e "s/$(echo $K | cut -c1-7)[0-9a-f]*/<OID-K>/g" \
> > +             -e "s/$(echo $L | cut -c1-7)[0-9a-f]*/<OID-L>/g" \
> > +             -e "s/$(echo $M | cut -c1-7)[0-9a-f]*/<OID-M>/g" \
> > +             -e "s/$(echo $N | cut -c1-7)[0-9a-f]*/<OID-N>/g" \
> > +             -e "s/$(echo $O | cut -c1-7)[0-9a-f]*/<OID-O>/g" \
> > +             -e "s/$(echo $P | cut -c1-7)[0-9a-f]*/<OID-P>/g" \
> > +             -e "s/$(echo $TAG1 | cut -c1-7)[0-9a-f]*/<OID-TAG-1>/g" \
> > +             -e "s/$(echo $TAG2 | cut -c1-7)[0-9a-f]*/<OID-TAG-2>/g" \
> > +             -e "s/$(echo $TAG3 | cut -c1-7)[0-9a-f]*/<OID-TAG-3>/g" \
> > +             -e "s/ *\$//"
> > +}
> > ...
> > +test_expect_success 'create bundle from special rev: main^!' '
> > +     git bundle create special-rev.bdl "main^!" &&
> > +
> > +     git bundle list-heads special-rev.bdl |
> > +             make_user_friendly_and_stable_output >actual &&
> > +     cat >expect <<-EOF &&
> > +             <COMMIT-P> refs/heads/main
> > +             EOF
>
> We prefer to indent these more like so:
>
>         cat >expect <<-\EOF &&
>         <COMMIT-P> refs/heads/main
>         EOF
>
> i.e. the indent of the line with <<EOF on it and the indent of the
> line with the matching EOF are the same.  Also, quote EOF to signal
> that the body of the here text should be taken as-is without $var
> substitution.
>
