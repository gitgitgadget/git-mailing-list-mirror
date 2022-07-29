Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8905AC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 14:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbiG2OWO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 10:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbiG2OWN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 10:22:13 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACA94C605
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 07:22:11 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id g18so2494463ilk.4
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 07:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r6Vs54M4XQNBdgjf1DVmKFU4MMi5O4HM0EC5eb2Xsgo=;
        b=Xrabxb4kvJ/rArnwXz0vMuhm9LJ38t15nUtITr+/JsDicAJGVyhcwTAxxxEidC5PdL
         hBllOwEIdAdXYNolGvjT2BerpW6DALGSLUy2urtD8QF/HavxbtOovUgESeYctniV3P8c
         pOVI6zAXddI3un0CHKhDkysNSya2IJLeFr271mh4PEkbkTvv9jhc3CvlKiNyuKEEcNQw
         I7icaRIOMS059Pz2pLiWQ6FQ52L1DGmS3SNX6kuNJsbWP/Wqow86o+yoJ2iW/IJwrkzp
         rCH360KGvRa+jedQ03z9dcdq2ghdUPtEg9aWDLqq9WHJ1JnAImhNj4zqxWtFeGDwfoTd
         NBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r6Vs54M4XQNBdgjf1DVmKFU4MMi5O4HM0EC5eb2Xsgo=;
        b=4S0ko8GudPxx4/F+ExR8HdhlESrZ1bnSLvv1CsaLtrDdKk+ci16khyxRQZBM2EOlEE
         VKVu7PQGpScVJTj7yet7Ai6EWqu0AXCssvjogoaWX3sMTQFEFynxTrGDSk7+3iT7NBEk
         QY+dWgslR3bPJTc4hHV9vdloIXIvMk/HTGtt5achQvZgsenctmxsXJyPd0F8BPDeJ9c+
         oPE0GylFSYkUxWzMjxlmxKNq90boA+e+wwknjQRjPhbeLCNpWLO6bBTlfvOleKPt6C05
         rexFKv2iNiZaOCjMrP5gadhpbULf9hYGeZhTAeDJDM+3ntmfUva+67jllibiRQgXItIY
         c0Ow==
X-Gm-Message-State: AJIora9/bhrL8uN6v/1ndi7wlHoCI7h1kLgJ3K2C1hl8x9g8wA2eYAk8
        2ODUCV2zLRTObFw/Y1BB54jJ0R+dXW//96y+3lKUG9wYDAVUAw==
X-Google-Smtp-Source: AGRyM1uTWbdUq8KduKUDUFWXPjZUBLJ+LfAwijl4VYo/vy+UBW6ClJcNI8YoZa5jpvGr6iwn6Rsv84CmfzplAD+LuqI=
X-Received: by 2002:a05:6e02:180a:b0:2de:20c8:572 with SMTP id
 a10-20020a056e02180a00b002de20c80572mr1334710ilv.213.1659104531260; Fri, 29
 Jul 2022 07:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8QusNzdO1mHqQFPz84pznYSpFWJunroRGXQ7qk6sJjeYg@mail.gmail.com>
 <220727.86mtculxnz.gmgdl@evledraar.gmail.com> <CAOLTT8QpYzoKDq6Pf8+YegCWngogy=3hUf-SyV180kntgucMpQ@mail.gmail.com>
 <220728.861qu5kz2c.gmgdl@evledraar.gmail.com> <CABPp-BH8BYMaG=VK_OpfX3QKBLAOiLH9sTDdTWq5=4C6-663HA@mail.gmail.com>
In-Reply-To: <CABPp-BH8BYMaG=VK_OpfX3QKBLAOiLH9sTDdTWq5=4C6-663HA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 29 Jul 2022 22:22:00 +0800
Message-ID: <CAOLTT8R1WQyqLNfymJgxTgCuoOKEe0Vu+7k9D+85u-x53FYJiQ@mail.gmail.com>
Subject: Re: Question: What's the best way to implement directory permission
 control in git?
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B47=E6=9C=8829=E6=97=
=A5=E5=91=A8=E4=BA=94 09:48=E5=86=99=E9=81=93=EF=BC=9A

> > But due to git's commits referring to a Merkle tree I can tell you that
> > a subdirectory "secret" has a current tree SHA-1 of XYZ, without giving
> > you any of that content.
> >
> > You *could* then manually construct a commit like:
> >
> >         tree <NEW_TREE>
> >         ...
> >
> > Where the "<NEW_TREE>" would be a tree like:
> >
> >         100644 blob <NEW-BLOB-SHA1>     UPDATED.md
> >         040000 tree <XYZ>       secret-stuff
> >
> > And send you a PACK with my new two three new objects (commit, blob &
> > new top-level NEW_TREE). To the remote end & protocol it wouldn't be
> > distinguishable from a "normal" push.
> >
> > But nothing supports this already, as a practical matter most of git
> > either hard dies if content is missing, or has other odd edge-case
> > semantics (and I'm not up-to-date on the state of the art).
>
> Actually, this is what sparse-index (as a sub-option in
> sparse-checkout) already basically does.  See
> Documentation/technical/sparse-index.txt for details, and note that
> we're basically in Phase IV of that document.  In short, the
> sparse-index makes it so that common operations based on the index do
> not need and do not use information about some subtrees, so if someone
> has a partial clone starting with no blobs, they will only have to
> download a small subset of the repository blobs in order to handle
> most Git operations, and many operations become much faster since the
> index is so much smaller.
>

I think this is mainly due to sparse-checkout instead of sparse-index.
Without the sparse-index, we also can do git add, git commit without fetchi=
ng
other blob objects.

But sparse-index can help reduce the size of indexes.

> However:
>
> * Users can run `git sparse-checkout reapply --no-sparse-index` at any
> time to force the index to be full again.  This is documented, and
> even suggested that users remember in case they attempt to use
> external tools (jgit? libgit2? others?) that don't understand sparse
> directory entries.  So, removing this ability would be problematic.
>

Or `git sparse-checkout disable`? Whatever, when git finds other objects
missing, it will fetch the objects from remote, and we may do ACL check her=
e.
Just let jgit/libgit2/others fail to fetch objects (in this special case?)

> * It makes no guarantee whatsoever that the sparse directory entries
> are not expanded by less frequently used Git commands.  Notice the
> "ensure_full_index()" calls sprinkled throughout the code.  Some have
> been removed, one by one, as commands have been modified to better
> operate with a sparse index.  The odds they'll all be removed in the
> future may well be close to 0%.
>

That's good...

> * The `ort` merge strategy ignores the index altogether during
> operation.  If it needs to walk into a tree to complete a
> merge/rebase/revert/cherry-pick/etc., it will.  Further, it doesn't
> just look into those paths, it intentionally de-sparsifies paths
> involved in conflicts, so it can display it to the user.
>

So the user has to care and deal with a merge conflict in a directory
that he "doesn't have access to"...

It would be nice to have the user only care about conflicts in directories/=
files
to which he has permissions. I don't know if it would be very
difficult to design.

> * Just because the index is sparse does not mean other commands can't
> walk into those directories.  So `git grep` (when given a revision),
> `git diff`, `git log`, etc. will look in (old versions of) those
> paths.
>

Agree.

> > Anyway, just saying that for the longer term I'm not aware of an
> > *intrinsic* reason for why we couldn't support this sort of thing, in
> > case anyone's interested in putting in a *lot* of leg work to make it
> > happen.
>
> And on top of the technical leg work required, they would also need to
> somehow convince everyone else that it's worth accepting the increased
> maintenance effort.  Right now, even if someone had already done the
> work to implement it, I'd say it's not worth the maintenance costs.
>
> However, there are two alternative choices I can think of here: You
> can use submodules if you want a fixed part of the repository to only
> be available to a subset of folks, or use josh
> (https://github.com/josh-project/josh) if you need it to be more
> dynamic.

Thanks, I will take a look.

ZheNing Hu
