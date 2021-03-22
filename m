Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1304C433DB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 15:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81EC0619AA
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 15:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhCVPAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 11:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhCVO7y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 10:59:54 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56702C061756
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 07:59:53 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id z68so7607884vsb.10
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 07:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IHHK6dI+w5JbJuiREDXNWGXF9AJbUshvfN+ryBYLR4g=;
        b=vCubVdyHwZBmQ1qa+ZkGA6CmNNz8rV0h+mWV5r5wBOH3x40sHHK3WfEwz3Jp8eAS4q
         ZPMO98RaHgzjQJNJlql3Op9p7ckMusxW3AKlihh2Rnh/WRBSeGw2sommoF0G9bRmtG4A
         JdIDJGWG3uJu5JhoDllcy6xfN6Fed0Sl9RQWcTZ/FztmPocOSrBXm8zoY3FCkFV9j3eg
         zZLJR1p2gz6n1N+z9Cv6T4BDOmFraP0UYHKLyMPxFXpOCuaqK7ZZpd+sw3K0brTFDrY/
         TkhvvZ1FifZjKSljjv8ScvdAL7D0gIB0tSlGMEErXnpdJz4WTJDyDttmV9b+VFWQF3TP
         5Qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IHHK6dI+w5JbJuiREDXNWGXF9AJbUshvfN+ryBYLR4g=;
        b=WuXD52wQs0L7EEJ9hLlvx8ryJSilge9bkD/wEsMadOflPzBgHydXZIsRMtJseVR+qc
         kw4x/0gKb7N0/yxMsGIeEU8k0DFPa74uUGHZ03LmUx3QZF/X6so/QkME6HUJLhg/zpv+
         88YQzpiw3D7UDl4svv6+LyTJ8FZUyTriRljEcdSTc5yGXeZ19GfphviBeVU9lhBZ0yDW
         ffPc1g3NawGlIaSZtNBeSZV/o5VShZtSHls8g/oxY9IEMHol6X8EFoSVciKPTdk7KioI
         GSIledgccJ3CR93qBY1B14P/mI2P1aypQ2n1IDzpE0bey9F9dEbtR3GXNRrWybsts9V4
         QwrQ==
X-Gm-Message-State: AOAM5301i7fyYTmfHfzbigFrUHekc39LuZX+x7j92b1sOo9gHQLv1D8s
        psd8ycw0PsClZdohccBmXfXUM0JDIItlCPagk0Oo3Hm/A2bRHg==
X-Google-Smtp-Source: ABdhPJwaN7lgc1GSwEZFlf6I3ks9V2XsdMCQ8ncfzGwmdEaYwLM5em+ck2xQStiqaAWA03KRJ8lNWFoG9HVl1UX++ac=
X-Received: by 2002:a67:7345:: with SMTP id o66mr94817vsc.28.1616425192257;
 Mon, 22 Mar 2021 07:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAFQ2z_MefCwiWdhs0buJv5Zok+nsgaOvUCcsSnfm_PP0WozZKA@mail.gmail.com>
 <87eeg7qpyr.fsf@evledraar.gmail.com>
In-Reply-To: <87eeg7qpyr.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 22 Mar 2021 15:59:40 +0100
Message-ID: <CAFQ2z_NSh3XxjGx56r=xBP2WBk7ggUjh4rXSb5ivPtkS_r4iBQ@mail.gmail.com>
Subject: Re: Distinguishing FF vs non-FF updates in the reflog?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Martin Fick <mfick@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 22, 2021 at 2:26 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > I'm working on some extensions to Gerrit for which it would be very
> > beneficial if we could tell from the reflog if an update is a
> > fast-forward or not: if we find a SHA1 in the reflog, and see there
> > were only FF updates since, we can be sure that the SHA1 is reachable
> > from the branch, without having to open packfiles and decode commits.
> >
> > For the reftable format, I think we could store this easily by
> > introducing more record types. [snip].
>
> Aside from what others have mentioned here, you're talking about the
> log_type field are you not? I.e.:
> https://googlers.googlesource.com/sop/jgit/+/reftable/Documentation/techn=
ical/reftable.md#log-block-format

Correct.

> Has that "log_type =3D 0x0" tombstone proven to be a worthwhile
> optimization past the stash case mention there (which is presumably not
> relevant to the vast majority of Google's use-cases).

I've never really understood the log_type=3D0x0 use case. I think it was
added solely to cater for a use case in CGit's stash command.

> I.e. it's redundant to looking at the record and seeing if new_id =3D
> ZERO_OID.
>
> Similarly can't ff v.s. non-ff be deduced unambiguously by looking ahead
> to the next record, and seeing if the current record's "old_id" matches
> that of the last record's "new_id". If it does it's a FF, if not it's a
> non-FF (or a create/delete).

I don't see how that will tell you FF vs non-FF-ness.  Both an FF
update and a non-FF  update look like 'new_oid =3D 20-random-bytes'.
Barring further info, you have to lookup the commit object for those
bytes, and then walk back to see if you pass old_oid.

AFAICT, a correct sequence of ref updates (FF or not) always has
prev.new_oid =3D current.old_oid.

> > [=C3=86var: snipped from earlier] Today we have 0 =3D deletion, 1 =3D u=
pdate,
> > and we could add 2 =3D FF update, 3 =3D non-FF update.
>
> I've written log table implementations (a site table in a RDBMS) for git
> (one table for refs) which had:
>
>     create, ff, non-ff, delete
>
> I wonder if that quad-state would be useful for reftable too, with this
> proposed change you'd still need to unpack the record and see if the
> old_id is ZERO_OID to check if it's a creation, would you not?

Delete & create are handled with ZERO_OID.

The reftable format makes it so that you have to decode a record in
order to read past it (there is no size framing the table entry
level), so there is no big performance advantage in encoding this
information in the log_type. You merely use a log_type bit rather than
a 20 byte raw ID. Since log records are zlib compressed anyway, it
probably also makes no space difference.

> I also wonder if it couldn't be:
>
>     0 =3D deletion, 1 =3D non-ff-update, 2 =3D ff-update, 4 =3D creation
>
> So the format wouldn't forever carry the historical wart of this not
> having been considered from the beginning.

If you do it like this, you will force that all implementations to
have to compute whether a (forced) update is a FF or not. I don't know
if that is a problem. A 'maybe non-FF' value would be useful. Perhaps
we could even do simply

     0 =3D deletion, 1 =3D maybe-ff-update, 2 =3D guaranteed-ff-update

> It would mean that the few current reftable users (just Google?) would
> have to look at the record to see if it's *really* a non-ff-update, but
> presumably they need to do so now for ff v.s. non-ff, so they're no
> worse off than they are now.

At Google, we currently don't record log records in reftable yet. From
our perspective, we could probably change the standard 'in place'.
JGit has supported reftable since Nov 2019, but I'm unaware of users;
I did hear about GerritForge wanting to try it out in production this
year.

> Then when those users know they're on a version that distinguishes these
> they can hard rely on 1 not being a "ff for sure", not a "maybe" status
> for new updates. Presumably they either don't care about ancient reflog
> records, or a one-off migration of rewriting the records for older
> entries could be done.
>
> Also between my [1] and this proposal we have at least a reftable v1.01
> in the wild (the filename locking behavior change discussed in [1]), and
> this would make it v1.02, but the only up-to-date spec is for v1.00 (and
> maybe JGit has other changes I haven't tracked).

The file locking update has been added to the standard,
https://github.com/git/git/pull/951.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
