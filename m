Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFA9C4332F
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 18:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350346AbiC3Sii (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 14:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353443AbiC3ShU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 14:37:20 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0967DDAC
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 11:35:29 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bu29so37465962lfb.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 11:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=owSOgURpp1P1lVTsTXqcmKEQxwJDy1PknHGQMD1MK7Q=;
        b=Nx9AgCMrHg1zTkD+1DCabJhyk+ZDi3vah0Z6dIzEbptLxstX53g92glT52K6+dKWpn
         Soary2kSaJgoOdjAofRg5rFjnT3ErPqmjYPHSbHBQzz4ndgHd8NjhH7yezw8tDAgWQZC
         j5DcG9IyM+VNafheGVMYmwNR9G6ur9lNuYCBRcLK0GkfTCJ6kl5wA7pDMiZrdY+ePB78
         PVK9i590iKSesAMOTRDpdthG+xpsKek4sqTf68OeDJMIt4Vqr65f54bEvV6IhadBo1xQ
         OQgvZAkZLFTHoH0cY0QfwNqQxQcD+KwGEPcownxzTdfeFUTlnEHxJbopKWM7j25/3PUf
         8Mig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=owSOgURpp1P1lVTsTXqcmKEQxwJDy1PknHGQMD1MK7Q=;
        b=XLDf3ZnMvnwJOGGNR8AyWkvJzn0LRldAR/XAVjhXZRrjBo0nTqAjPtIWv0NXBJTepP
         FyKmyaSUKJeUlGxV19/4O/Q7i4l0Wp0kYcABKE9CZpOXNmVbv94eQRmHtoFANNcN1NTy
         3iCwbAAW0LyCzhE/yTGTrs6OjkuYy15gNgVe3Fm+ELUDcuXi1oLgm0ErnjHMeR/nyZT+
         iF3Drwb0uEO0/W+lRPmQR6nDAuhT1MX5Dh91MP+/eF8f6tyUi8Whau/TY3ZXJUqiDcxw
         zQ5WS2X066juY6fAE9QsUWUlnwuFFeFnNATJd6EZwLG5dMzAgM7ktaBd5NJcnOXE4p9P
         Lykg==
X-Gm-Message-State: AOAM532d+8VxjTCaH2qK1FiFdOVoiyvpRFZ87ZSWGLLFF+SzNf+icq6Q
        Xpt0bnnAwkCntmH6oyzuvzNbVd9qMYAGpB7Suy0=
X-Google-Smtp-Source: ABdhPJwGQumC0RjjiEoSdY/CFw+mlVT215mcNTB6wm4MwAemU+1RTjsZRm04yjjZxCgMlNAJSKN8f4ums/rjlngXXUA=
X-Received: by 2002:a05:6512:322f:b0:44a:57a0:6950 with SMTP id
 f15-20020a056512322f00b0044a57a06950mr8123370lfe.74.1648665309812; Wed, 30
 Mar 2022 11:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
 <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com> <c7a2a7efe6d532fc7fce1352b1dfce640cc9f2f6.1648616734.git.gitgitgadget@gmail.com>
 <xmqqpmm39xhx.fsf@gitster.g>
In-Reply-To: <xmqqpmm39xhx.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 30 Mar 2022 11:34:58 -0700
Message-ID: <CANQDOdfWTufEn0NRSAOG991JcS4x8GsCC62UCLUTEc3gD6tfGA@mail.gmail.com>
Subject: Re: [PATCH v5 01/14] bulk-checkin: rename 'state' variable and
 separate 'plugged' boolean
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 30, 2022 at 10:11 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Batched fsync will fit into bulk-checkin by taking advantage of the
> > plug/unplug functionality to determine the appropriate time to fsync
> > and make newly-added objects available in the primary object database.
> >
> > * Rename 'state' variable to 'bulk_checkin_state', since we will later
> >   be adding 'bulk_fsync_objdir'.  This also makes the variable easier to
> >   find in the debugger, since the name is more unique.
> >
> > * Move the 'plugged' data member of 'bulk_checkin_state' into a separate
> >   static variable. Doing this avoids resetting the variable in
> >   finish_bulk_checkin when zeroing the 'bulk_checkin_state'. As-is, we
> >   seem to unintentionally disable the plugging functionality the first
> >   time a new packfile must be created due to packfile size limits. While
> >   disabling the plugging state only results in suboptimal behavior for
> >   the current code, it would be fatal for the bulk-fsync functionality
> >   later in this patch series.
>
> Paraphrasing to make sure I understand your reasoning here...
>
> In the "plug and then perform as many changes to the repository and
> finally unplug" flow, before or after this series, the "perform"
> step in the middle is unaware of which "bulk_checkin_state" instance
> is being used to keep track of what is done to optimize by deferring
> some operations until the "unplug" time.  So bulk_checkin_state is
> not there to allow us to create multiple instances of it, pass them
> around to different sequences of "plug, perform, unplug".  Each of
> its members is inherently a singleton, so in the extreme, we could
> turn these members into separate file-scope global variables if we
> wanted to.  The "plugged" bit happens to be the only one getting
> ejected by this patch, because it is inconvenient to "clear" other
> members otherwise.
>
> Is that what is going on?
>

More or less.  The current state is all about creating a single
packfile for multiple large objects.  That packfile is a singleton
today (we could have an alternate implementation where there's a
separate packfile per thread in the future, so it's not inherent to
the API).  We want to do this if the top-level caller is okay with the
state being invisible until the "finish" call, and that is conveyed by
the "plugged" flag.

> If it is, I am mildly opposed to the flow of thought, from at least
> two reasons.  It makes it hard for the next developer to decide if
> the new members they are adding should be in or out of the struct.
>
> More importantly, I think the call of finish_bulk_checkin() we make
> in deflate_to_pack() you found (and there may possibly other places
> that we do so; I didn't check) may not appear to be a bug in the
> original context, but it already is a bug.  And when we change the
> semantics of plug-unplug to be more "transaction-like", it becomes a
> more serious bug, as you said.
>
> There is NO reason to end the ongoing transaction there inside the
> while() loop that tries to limit the size of the packfile being
> used.  We may want to flush the "packfile part", which may have been
> almost synonymous to the entirety of bulk_checkin_state, but as you
> found out, the "plugged" bit is *outside* the "packfile part", and
> that makes it a bug to call finish_bulk_checkin() from there.
>
> We should add a new function, flush_bulk_checking_packfile(), to
> flush only the packfile part of the bulk_checkin_state without
> affecting other things---the "plugged" bit is the only one in the
> current code before this series, but it does not have to stay to be
> so

I'm happy to rename the packfile related stuff to end with _packfile
to make it clear that all of that state and functionality is related
to batching of packfile additions.
So from this patch: s/bulk_checkin_state/bulk_checkin_packfile and
s/finish_bulk_checkin/finish_bulk_checkin_packfile.

My new state will be bulk_fsync_* (as it is already).  Any future
ODB-related state can go here too (I'm imagining a future
log-structured 'new objects pack' that we can append to for adding
small objects, similar to the bulk_checkin_packfile but allowing
appends from multiple git invocations).

> When you start plugging the loose ref transactions, you may
> find it handy (this is me handwaving) to have a list of refs that
> you may have to do something at "unplug" time kept in the struct,
> and you do not want deflate_to_pack() affecting the ongoing
> "plugged" ref operations by calling finish_bulk_checkin() and
> reinitializing that list, for example.
>

I don't believe ref transactions will go through this part of the
infrastructure.  Refs already have a good transaction system (that
partly inspired this rebranding, after I saw how Peter implemented
batch ref fsync).  I expect this area will remain all about the ODB as
a subsystem that can enlist in a larger repo->transaction.  So a
top-level Git command might initiate a repo transaction, which would
internally initiate an ODB transaction, index transaction, and ref
transaction. The repo transaction would support flushing each of the
subtransactions with an optimal number of fsyncs.

> And then we should examine existing calls to finish_bulk_checkin()
> and replace the ones that should not be finishing, i.e. the ones
> that wanted "flush" but called "finish".

Sure.  I can fix this, which will only change this file.  The only
case of "finishing" would be in unplug_bulk_checkin /
end_odb_transaction.

Thanks,
Neeraj
