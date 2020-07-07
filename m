Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B550C433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 13:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EDD020738
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 13:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EpDwCXwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgGGN4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 09:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGGN4v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 09:56:51 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EE9C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 06:56:51 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id b205so9154073vkb.8
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 06:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3CKy8ko8D2A7y+oq6PQH1agXz4ptfnJf8UwmtERiEqI=;
        b=EpDwCXwG+dqcwcCn+iRj8wGKOz9mOxCb2nnPmR+uj9+M0JcBIjaKTpKqw5K3QGFooB
         IOPMsthPZ2hPG2DTmp0F3GfN7rLTvr0c4lMQ+UCJ3m2UI1bi0ph/8GgQuNB6N2G7DS8t
         FQJorj0OHtJoT8TB5JmcVi2VeoO0JrPUHhhyKA5d0CjvBS9ld3yj9qJie4IcOfWhbPbH
         L3w7OvNDm9fLJIBQGcuGby9H/Gn7gH/vG6aox5wZEXGxC/HsV3mOsZKrT3z7W6LUOHDA
         xQCBGCq8ss1ZuZZ96f2yr/N2QUq4Ff3S6BLzfW+E0ubx4lbmwaKOG1Qtz1nj0xWD/e09
         u9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3CKy8ko8D2A7y+oq6PQH1agXz4ptfnJf8UwmtERiEqI=;
        b=qpaWiPIErhe2LGOUN2t42fAEK+ZXSdXPwh4qsaZky+kCM4yXoeQFWyE9A0JiGD5lTT
         sqd2qsSv4RPWTq+ZfBU1xLdP79hvNC+YWu3F9kd9yWA+vujcGa286KAmCQTS2Awwj10X
         EJoS2KPpk/EBdR8fSB1tQNwt7CDgNYy1Gi9gN8touFsCu9xRUUwrsyNS9MY6d97Oixjg
         euk46VZ98xO687hdJKlEqpn/+wQxt16YGSlPtGsK7/4IRNJFyLPq6Caof/gx0rQrRlnQ
         +cU2t1XsSk5bizT1ePEZnK0YRi6fQpQK6X3BJ3kdlMu5HBS1aOlSK0yozFztGJdNTk1k
         kOVw==
X-Gm-Message-State: AOAM5330NDrP9esYaXsU7+B9liGoWzE6A28fF0uJTP/NAPuKMYNvP/4H
        oTKIBeSvjZV1wIt9hmR6E8x4k8Q+3RDvCWpnZLIFtrc+YPM=
X-Google-Smtp-Source: ABdhPJyP96ndiMZj05rvjYl6lK5wxBrnSf85NSRS2PBkQ1SXWsjXOU7RkSg6zcAYEFw0fNBRrfz0ecUsf1vKAohX4D4=
X-Received: by 2002:a1f:3113:: with SMTP id x19mr37625575vkx.91.1594130210196;
 Tue, 07 Jul 2020 06:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.673.git.1594056572.gitgitgadget@gmail.com>
 <6821f57bdf326f161f152a8af0e47b54513c77b1.1594056572.git.gitgitgadget@gmail.com>
 <xmqqimf09ypc.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqimf09ypc.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 7 Jul 2020 15:56:38 +0200
Message-ID: <CAFQ2z_OPbcX9FGsFnmraAUpTu2eKuf2PZ+DO-CTWvaBZD6WQQQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Modify pseudo refs through ref backend storage
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 6, 2020 at 10:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Subject: Re: [PATCH 1/2] Modify pseudo refs through ref backend storage
> > From: Han-Wen Nienhuys <hanwen@google.com>
>
> With what definition of "pseudo refs" has this change been made?
> Those things like HEAD, CHERRY_PICK_HEAD, FETCH_HEAD etc. that have
> traditionally been written as a plain text file in $GIT_DIR and are
> used to name objects by having a full object name in it?
>
> Or the entities that behave like refs and stored in ref backends,
> with all-uppercase-names but do not sit inside refs/ hierarchy?

I thought these were the same? - see below :)

> I think it is OK (and possibly a good move in the longer term, but
> that is just my gut feeling) to make ref backends resopnsible for
> enumerating, reading and writing them (i.e. I think we want to use
> the latter definition for the longer term health of the project).
> And we would want to ...
>
> > The previous behavior was introduced in commit 74ec19d4be
> > ("pseudorefs: create and use pseudoref update and delete functions",
> > Jul 31, 2015), with the justification "alternate ref backends still
> > need to store pseudorefs in GIT_DIR".
>
> ... declare that justification invalid for that purpose.
>
> Is that what is going on?  I just want to make sure I am following
> your flow of thought.

yep.

> >               const char *refname =3D refnames->items[i].string;
> > -
> >               if (refs_delete_ref(&refs->base, msg, refname, NULL, flag=
s))
> >                       result |=3D error(_("could not remove reference %=
s"), refname);
> >       }
>
> Unreleated change?

oops.

> > @@ -2436,7 +2435,9 @@ static int lock_ref_for_update(struct files_ref_s=
tore *refs,
> >       update->backend_data =3D lock;
> >
> >       if (update->type & REF_ISSYMREF) {
> > -             if (update->flags & REF_NO_DEREF) {
> > +             if (update->flags & REF_NO_DEREF ||
> > +                 (ref_type(update->refname) =3D=3D REF_TYPE_PSEUDOREF =
&&
> > +                  strcmp(update->refname, "HEAD"))) {
> >                       /*
> >                        * We won't be reading the referent as part of
> >                        * the transaction, so we have to read it here
>
> The old "if we are not dereferencing" condition in if() exactly
> matched the comment, but the condition in if() after this change is
> not "if we are not dereferencing".  Even if we are dereferencing,
> under some new condition, we would still drop into this block and do
> not follow the "else" side that creates a new update for the
> referent.  Is this part of "modify pseudo refs via backend" topic,
> or should it be a separate modification?  Why is this change needed?

There is a  test (mentioned in the commit message), t1405, which does

$RUN create-symref FOO refs/heads/master nothing &&
# calls refs_create_symref()
..
$RUN delete-refs 0 nothing FOO refs/tags/new-tag &&
# calls refs_delete_refs, which calls delete_pseudoref
..
git rev-parse master >expected &&

Previously, the delete_pseudoref code would delete just .git/FOO file.
Without the change here, going through the ref backend ends up in the
!REF_NO_DEREF case, deleting the master branch.

I don't know what the correct semantics are (are symrefs used for
anything except HEAD ?), so


> It seems that no matter where in the refs/ hierarchy (or even
> outside) a symbolic ref resides, the way to update itself (not the
> referent through the symbolic ref) should be the same, which is what
> the original says, and we want to change that reasoning here, but it
> is not quite clear to me why.
>
> > @@ -2782,8 +2783,10 @@ static int files_transaction_finish(struct ref_s=
tore *ref_store,
> >               struct ref_update *update =3D transaction->updates[i];
> >               struct ref_lock *lock =3D update->backend_data;
> >
> > -             if (update->flags & REF_NEEDS_COMMIT ||
> > -                 update->flags & REF_LOG_ONLY) {
> > +             if ((ref_type(lock->ref_name) !=3D REF_TYPE_PSEUDOREF ||
> > +                  !strcmp(lock->ref_name, "HEAD")) &&
> > +                 (update->flags & REF_NEEDS_COMMIT ||
> > +                  update->flags & REF_LOG_ONLY)) {
>
> And this one stops the files backend from touching all pseudorefs
> other than HEAD with this codepath.  That somehow feels totally
> opposite from what the log message explained above---weren't we
> updating the code to write these pseudorefs through the individual
> backends, which the files backend is one example of?  Isn't this
> change stopping the backend from writing the pseudorefs other than
> HEAD instead?

There is a test

  'core.logAllRefUpdates=3Dalways creates no reflog for ORIG_HEAD'

that wants there to not be reflog updates for ORIG_HEAD. I don't see
why that behavior exists, and would be happy to change it, but I'm too
much of a newbie to decide what is right here.

> > --- a/t/t1400-update-ref.sh
> > +++ b/t/t1400-update-ref.sh
> > @@ -476,7 +476,7 @@ test_expect_success 'git cat-file blob master@{2005=
-05-26 23:42}:F (expect OTHER
> >  test_expect_success 'given old value for missing pseudoref, do not cre=
ate' '
> >       test_must_fail git update-ref PSEUDOREF $A $B 2>err &&
> >       test_path_is_missing .git/PSEUDOREF &&
>
> The reason why I asked what this patch thinks the definition of
> pseudoref is is because of this thing.  Shouldn't this line be fixed
> not to depend on the files backend?  Likewise for $(cat .git/PSEUDOREF)
> in the remaining two hunks.

This patch doesn't introduce reftable yet, so both definitions are
equivalent for the sake of this  patch.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
