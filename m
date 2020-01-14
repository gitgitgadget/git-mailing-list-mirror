Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F79C33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 22:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8270124673
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 22:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdgX1lwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgANWqb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 17:46:31 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:32958 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbgANWqb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 17:46:31 -0500
Received: by mail-ot1-f41.google.com with SMTP id b18so14364891otp.0
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 14:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DsCtlSvPkBZ/C2yy4rjDZ7rwxw2KwjRZDds4nHTX1HQ=;
        b=QdgX1lwj5kTeviK9J2U0zgF3aerLtGyU8WDP9EuT5EdtZICc6ySgFjCmhbDKCkKrqJ
         e/spOjO9y4RAo4vQ7a4KObRaby4lfyfnBUmO4Rzoyzoo9L/d+vMFEfmpv0EO5PqRzMNN
         7HtlJUjtbiy59a7M2lp6Mq4g7yMx6EgnNqgqskej+EhU+af8mweZCPfVUN92P6NrY2mM
         cUz22+XDh2JRQbxASotYbUZKGQw/wy9GONZomt31DRFDrI/QDLIJlgL7T/t1+EO6RdmU
         6K0HDiTyLafPYtnxI6J1MVB6hr584KZBgTL0WPm8hex4g3oDc94jTuKLfu+gr7tgy+xm
         v2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DsCtlSvPkBZ/C2yy4rjDZ7rwxw2KwjRZDds4nHTX1HQ=;
        b=NZiv06rbJHrHnHyehQ5/JmCcTtNAIYE+UjRieafH6JgDfpxgd2b26oOOCSTjbeA+8f
         HNNGaGeZtEHJQLZiSEoKly2W+/Tu/1xRT/qClW2n3aaJ3aELcV7UwWdvaU2fgiryXEB2
         XXeUErY5xNICgHiiL1D72JkvKMp8/bcdc1j/5byLFFKKVYywGMyjWLPp+/o59pZCcbC/
         S8inQ/SIExnyTW0LaWuHEThj0cn8c8M8nZAA/Bzc3iVhSkoxYzsnLhzLoBTtO9IuYWyy
         zFsrw1rbhaPUZBHXQFbKAYupu9VPDJT1AGHJhZCR3ejHzFAjx58JusHY0w6ayCkwmeyG
         29Iw==
X-Gm-Message-State: APjAAAVTGVLeuLdD19FpMsQ1VDSdnaypMo5trYeXXDX80c3qVA7jUOgs
        xywj+xRwBZ/Ra3tjwO2LEldbfbkdP5c8sKJUabg=
X-Google-Smtp-Source: APXvYqyLYWKOuBHx08qroU3oj7dr3yQmC/VxVfAdm26+m0IO1pvbiSJUhuFD/TycPc12a+y+dSluCq3A+b40S8zxfbQ=
X-Received: by 2002:a9d:7d81:: with SMTP id j1mr540782otn.267.1579041990045;
 Tue, 14 Jan 2020 14:46:30 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BF8OHoHo73doekKzf0CmO09_PyAfe4q__DvoftQ+BeY2w@mail.gmail.com>
 <20200114215730.154601-1-jonathantanmy@google.com>
In-Reply-To: <20200114215730.154601-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 14 Jan 2020 14:46:17 -0800
Message-ID: <CABPp-BHBtwxk7B9LLZdCFBTOdTUCnxXyeMXG3XPavp96N+LKHg@mail.gmail.com>
Subject: Re: [RFC] Extending git-replace
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     novalis@novalis.org, Kaushik Srenevasan <kaushik@twitter.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 14, 2020 at 1:57 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > > Missing promisor objects do not prevent fsck from passing - this is part
> > > of the original design (any packfiles we download from the specifically
> > > designated promisor remote are marked as such, and any objects that the
> > > objects in the packfile refer to are considered OK to be missing).
> >
> > Is there ever a risk that objects in the downloaded packfile come
> > across as deltas against other objects that are missing/excluded, or
> > does the partial clone machinery ensure that doesn't happen?  (Because
> > this was certainly the biggest pain-point with my "fake cheap clone"
> > hacks.)
>
> The server may send thin packs during a fetch or clone, but because the
> client runs index-pack (which calculates the hash of every object
> downloaded, necessitating having the full object, which in turn triggers
> fetches of any delta bases), this should not happen.

So if a user does a partial clone, filtering by blob size >= 1M, and
if they have several blobs of size just above and just below that
limit, then the partial clone will work but probably cause them to
still download several blobs above the limit size anyway?  (Which, if
I'm understanding correctly, happens because the blobs just smaller
than 1M likely will delta well against the blobs just larger than 1M.)

> But if you create the packfile in some other way and then manually set a
> fake promisor remote (as I perhaps too naively suggested) then the
> mechanism will attempt to fetch missing delta bases, which (I think) is
> not what you want.

Well, it's not optimal, but we're currently just dying with cryptic
errors whenever we have missing delta bases, and this happens whenever
we have an accidental fetch of older branches (although this does have
the nice side effect of notifying us of stray fetches in our CI
scripts).  Your promisor suggestion would at least permit gc's &
prunes if we use it in more places, so should be an improvement.  I
just wanted to verify whether this problem with delta bases would
remain.

> > > Currently, when a missing object is read, it is first fetched (there are
> > > some more details that I can go over if you have any specific
> > > questions). What you're suggesting here is to return a fake blob with
> > > wrong hash - I haven't looked at all the callers of read-object
> > > functions in detail, but I don't think all of them are ready for such a
> > > behavioral change.
> >
> > git-replace already took care of that for you and provides that
> > guarantee, modulo the --no-replace-objects & fsck & prune & fetch &
> > whatnot cases that ignore replace objects as Kaushik mentioned.  I
> > took advantage of this to great effect with my "fake cheap clone"
> > hacks.  Based in part on your other email where you made a suggestion
> > about promisors, I'm starting to think a pretty good first cut
> > solution might look like the following:
> >
> >   * user manually adds a bunch of replace refs to map the unwanted big
> > blobs to something else (e.g. a README about how the files were
> > stripped, or something similar to this)
> >   * a partial clone specification that says "exclude objects that are
> > referenced by replace refs"
> >   * add a fake promisor to the downloaded promisor pack so that if
> > anyone runs with --no-replace-objects or similar then they get an
> > error saying the specified objects don't exist and can't be
> > downloaded.
> >
> > Anyone see any obvious problems with this?
>
> Looking at the list of commands given in the original email (fsck,
> upload-pack, pack/unpack-objects, prune and index-pack), if we use a
> filter by blob size (instead of the partial clone specification
> suggested), this would satisfy the purposes of fsck and prune only.
>
> If we had a partial clone specification that excludes object referenced
> by replace refs, then upload-pack from this partial repository (and
> pack-objects) would work too.
>
> But there might be non-obvious problems that I haven't thought of.

Cool, sounds like it's at least worth investigating.  Maybe Kaushik is
interested, or maybe I consider throwing it on my backlog and coming
back to it in a year or two.  :-)
