Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D47C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 17:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243695AbiCXRyN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 13:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiCXRyN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 13:54:13 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7709986E0
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 10:52:40 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id k21so9372313lfe.4
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 10:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TJYjH5uJYUOzv5/KFcK0Ou30gpekUKA+6dxWf/xOVVw=;
        b=gBbgH7iYxPYjGqQoNwVxhwdZm0QowFdD3Vk1Q17N+DdLTcOTDRAvAJT72p6P7CwAVi
         3mhIvJOo3mnM+YJQmSFzhKEhZ2mi7rtA5VN01kheVMs4LbRpcUb0nGP+8okKkC55r6r+
         GJ+nbQm8SFywtNd8PJsE+NKmyxWyDoPC45kxFHUPIBxhGhqhQ2tv9ytIJYfpCYMLDjoT
         0M6SEmxTuE1IU3X/Ekp0p+hWL2AkXyp4S+InHEzi3gHhc9/dKJUOFZVQ9B51CuSY5uBs
         8Oldju9RNBd2dDEzarKkQJyg7MiF5j3OmIAkkLkWoncoYKGuHwnE87a7nC9niD0Z8gr2
         /Xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TJYjH5uJYUOzv5/KFcK0Ou30gpekUKA+6dxWf/xOVVw=;
        b=XpF2fTxJMdveP8pCfkFMzwwrEAj3PmXXk0fCrmUs54yn0FXqSiPk66Kx65k8I+c3hx
         WUg15D6EL8t5pQhaKc0jaAN0ZNcYKUq5irxxi9CTmaAe+zoOMJZfrDs03VPGXefUxscw
         ybyvMPVyKxRfZp9wIpx9yxe3NIv2gvFBUl5RLZmGgVLAetw/g3YBARI791rwVdszNq/+
         3KerFzgM9tkMHStvxSz0Z6LWZGqPdikCJuOoYXoT86OEed573mp6q4rSqb83ukK7WIwb
         wnj8fzzoYPqeN8kdP2lunWP9pI7Khco8X7qzwY4gyIkNFB78KwTGazYJNOSIPQx0YsYS
         i6Xg==
X-Gm-Message-State: AOAM53178RtP3iktheEeiA4ObUqEFr0EViV8SdI8q0NRbucvaG5Ez496
        xGs9oRaG6yNaky0JB3GD9DjoKWO5wbXl6UKjOBM=
X-Google-Smtp-Source: ABdhPJzGjlxCwFsp+cLd82kKssnS+BU7tAbzSgDxp92VbqafhpMdWWwquDayGG76OEerQCQYHDAi7oHrGkDNvE9o7h0=
X-Received: by 2002:ac2:5dfa:0:b0:44a:15d4:9e60 with SMTP id
 z26-20020ac25dfa000000b0044a15d49e60mr4659098lfq.241.1648144358770; Thu, 24
 Mar 2022 10:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
 <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com> <53261f0099d53524155464fe79d10f9605fe93aa.1648097906.git.gitgitgadget@gmail.com>
 <220324.86y20zmi84.gmgdl@evledraar.gmail.com>
In-Reply-To: <220324.86y20zmi84.gmgdl@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Thu, 24 Mar 2022 10:52:27 -0700
Message-ID: <CANQDOdfx91dbgvLQkEqjjZjx1=qOGvq_fZJQMQLww9SgqE157g@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] bulk-checkin: rebrand plug/unplug APIs as 'odb transactions'
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 24, 2022 at 9:24 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Thu, Mar 24 2022, Neeraj Singh via GitGitGadget wrote:
>
> > From: Neeraj Singh <neerajsi@microsoft.com>
> >
> > Make it clearer in the naming and documentation of the plug_bulk_checki=
n
> > and unplug_bulk_checkin APIs that they can be thought of as
> > a "transaction" to optimize operations on the object database.
> >
> > Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> > ---
> >  builtin/add.c  |  4 ++--
> >  bulk-checkin.c |  4 ++--
> >  bulk-checkin.h | 14 ++++++++++++--
> >  3 files changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/builtin/add.c b/builtin/add.c
> > index 3ffb86a4338..9bf37ceae8e 100644
> > --- a/builtin/add.c
> > +++ b/builtin/add.c
> > @@ -670,7 +670,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
> >               string_list_clear(&only_match_skip_worktree, 0);
> >       }
> >
> > -     plug_bulk_checkin();
> > +     begin_odb_transaction();
> >
> >       if (add_renormalize)
> >               exit_status |=3D renormalize_tracked_files(&pathspec, fla=
gs);
> > @@ -682,7 +682,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
> >
> >       if (chmod_arg && pathspec.nr)
> >               exit_status |=3D chmod_pathspec(&pathspec, chmod_arg[0], =
show_only);
> > -     unplug_bulk_checkin();
> > +     end_odb_transaction();
>
> Aside from anything else we've (dis)agreed on, I found this part really
> odd when hacking on my RFC-on-top, i.e. originally I (wrongly) thought
> the plug_bulk_checkin() was something that originated with this series
> which adds the "bulk" mode.
>
> But no, on second inspection it's a thing Junio added a long time ago so
> that in this case we "stream to N pack" where we'd otherwise add N loose
> objects.
>
> Which, and I think Junio brought this up in an earlier round, but I
> didn't fully understand that at the time makes this whole thing quite
> odd to me.
>
> So first, shouldn't we add this begin_odb_transaction() as a new thing?
> I.e. surely wanting to do that object target redirection within a given
> begin/end "scope" should be orthagonal to how fsync() happens within
> that "scope", though in this case that happens to correspond.
>
> And secondly, per the commit message and comment when it was added in
> (568508e7657 (bulk-checkin: replace fast-import based implementation,
> 2011-10-28)) is it something we need *for that purpose* with the series
> to unpack-objects without malloc()ing the size of the blob[1].
>

The original change seems to be about optimizing addition of
successive large blobs to the ODB when we know we have a large batch.
It's a batch-mode optimization for the ODB, similar to my patch
series, just targeting large blobs rather than small blobs/trees.  It
also has the same property that the added data is "invisible" until
the transaction ends.

> And, if so and orthagonal to that: If we know how to either stream N
> objects to a PACK (as fast-import does), *and* we now (or SOON) know how
> to stream loose objects without using size(blob) amounts of memory,
> doesn't the "optimize fsync()" rather want to make use of the
> stream-to-pack approach?
>
> I.e. have you tried for the caseses where we create say 1k objects for
> "git stash" tried to stream those to a pack? How does that compare (both
> with/without the fsync changes).
>
> I.e. I do worry (also per [2]) that while the whole "bulk fsync" is neat
> (and I think can use it in either case, to defer object syncs until the
> "index" or "ref" sync, as my RFC does) I worry that we're adding a bunch
> of configuration and complexity for something that:
>
>  1. Ultimately isn't all that important, as already for part of it we
>     can mostly configure it away. I.e. "git-unpack-objects" v.s. writing
>     a pack, cf. transfer.unpackLimit)
>  2. We don't have #1 for "add" and "update-index", but if we stream to
>     packs there is there any remaining benefit in practice?
>
> 1. https://lore.kernel.org/git/cover-v11-0.8-00000000000-20220319T001411Z=
-avarab@gmail.com/
> 2. https://lore.kernel.org/git/220323.86fsn8ohg8.gmgdl@evledraar.gmail.co=
m/

Stream to pack is a good idea.  But I think we'd want a way to append
to the most recent pack so that we don't explode the number of packs,
which seems to impose a linear cost on ODB operations, at least to
load up the indexes.  I think this is orthogonal and we can always
change the meaning of batch mode to use a pack mechanism when such a
mechanism is ready.

Thanks,
Neeraj
