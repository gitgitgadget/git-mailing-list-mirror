Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144BAC00140
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 01:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbiG2Bsj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 21:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiG2Bsh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 21:48:37 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F504D179
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 18:48:33 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id x11so2415814qts.13
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 18:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DMCa6GiMxodOpkvP8VKX6Bi8FxDbWt8p5tA414OWnB0=;
        b=EfdOhQU/243H2TtJCMCBjMmx+5yR8DxYPISuttrG8rlqXezXyjMLQTKpMJ9grnY13V
         ZgJAL00Kpo+v/69Mglxw0ol4Hc2ZLOBn3qjn80PcQN8ZMb1Y40jZf3X4Rk9TxuvjVT22
         EENHLK7O5nTzlBgq20h2yIh21DOBp6B/VWz4sZe0Fl6nEHnjgg1i+S1g7YAlXfu+xMAH
         x1S0zNlmIXCGOYHKWykM2tUZoalDrV1anfcBhkl2fFbf1NA7MzuOLSvJxSahFAWGGf6x
         zHipuwgMbuRpg+HKBsCPUPozdlFEJ+eX0kQrcE33VAXhBtSMPiwr+OvCHqnilv6GazqL
         7guQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DMCa6GiMxodOpkvP8VKX6Bi8FxDbWt8p5tA414OWnB0=;
        b=3fffVa2P06Azdo/xk+4pgTUf5g6qJO+IFi4f7P0D/1BF5jL6R0LaZbCcbN5Y1Eqi4n
         O2ItzhH6kVSebzCrOYpcMpx7evvq6WUEOVaFxsOa3WrExGt1eeLj8Fo2g1MymmFLUgQX
         9CTGqAdg26QW4dVsQQVIELFdmQlauL+QhtZBQtn8MJGl56p4DDMNr+TSTedV06e0HY+6
         lqFx2swbGdaObOJWvSDzLAwOYBUksArZSys0Kwezxy6DQzjPNJtv4yezlPy1znRGzLZ2
         fXlnlF6/WyB++4u5LiL+75r99fRlBPhSff2l78EaZ+deMBt/ZCBK5COfxOwM6m/3hm/w
         r6kw==
X-Gm-Message-State: AJIora8s+X5MYw0nI846MATEHhwQvhnpHPuCya3CFvkSgT4EROO1txq0
        v3twP+s1uUnNgwqXL4NIsfbmCHq1nm/hZ8eE6UM=
X-Google-Smtp-Source: AGRyM1t0rI7AC3UZTwByIyx0YAdQpO7xsYKeedc5RmeLjG7bkg4UwGlWAKPO3Tk5Y+a9titE4oChGlVzlpjxLcWazx4=
X-Received: by 2002:ac8:5d8b:0:b0:31e:ed61:b5a7 with SMTP id
 d11-20020ac85d8b000000b0031eed61b5a7mr1544408qtx.259.1659059312669; Thu, 28
 Jul 2022 18:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8QusNzdO1mHqQFPz84pznYSpFWJunroRGXQ7qk6sJjeYg@mail.gmail.com>
 <220727.86mtculxnz.gmgdl@evledraar.gmail.com> <CAOLTT8QpYzoKDq6Pf8+YegCWngogy=3hUf-SyV180kntgucMpQ@mail.gmail.com>
 <220728.861qu5kz2c.gmgdl@evledraar.gmail.com>
In-Reply-To: <220728.861qu5kz2c.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 28 Jul 2022 18:48:21 -0700
Message-ID: <CABPp-BH8BYMaG=VK_OpfX3QKBLAOiLH9sTDdTWq5=4C6-663HA@mail.gmail.com>
Subject: Re: Question: What's the best way to implement directory permission
 control in git?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
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

On Thu, Jul 28, 2022 at 9:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Jul 28 2022, ZheNing Hu wrote:
>
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2022=
=E5=B9=B47=E6=9C=8827=E6=97=A5=E5=91=A8=E4=B8=89 17:20=E5=86=99=E9=81=93=EF=
=BC=9A
> >>
> >>
> >> On Wed, Jul 27 2022, ZheNing Hu wrote:
> >>
> >> > if there is a monorepo such as
> >> > git@github.com:derrickstolee/sparse-checkout-example.git
> >> >
> >> > There are many files and directories:
> >> >
> >> > client/
> >> >     android/
> >> >     electron/
> >> >     iOS/
> >> > service/
> >> >     common/
> >> >     identity/
> >> >     list/
> >> >     photos/
> >> > web/
> >> >     browser/
> >> >     editor/
> >> >     friends/
> >> > boostrap.sh
> >> > LICENSE.md
> >> > README.md
> >> >
> >> > Now we can use partial-clone + sparse-checkout to reduce
> >> > the network overhead, and reduce disk storage space size, that's goo=
d.
> >> >
> >> > But I also need a ACL to control what directory or file people can f=
etch/push.
> >> > e.g. I don't want a client fetch the code in "service" or "web".
> >> >
> >> > Now if the user client use "git log -p" or "git sparse-checkout add =
service"...
> >> > or other git command, git which will  download them by
> >> > "git fetch --filter=3Dblob:none --stdin <oid>" automatically.
> >> >
> >> > This means that the git client and server interact with git objects
> >> > (and don't care about path) we cannot simply ban someone download
> >> > a "path" on the server side.
> >> >
> >> > What should I do? You may recommend me to use submodule,
> >> > but due to its complexity, I don't really want to use it :-(
> >>
> >> There isn't a way to do this in git.
> >>
> >> It's theoretically possible, i.e. a client could be told that the SHA-=
1
> >> of a directory is XYZ, and construct a commit object with a reference =
to
> >> it.
> >>
> >
> > I guess you mean use a special reference to hold the restricted path wh=
ich
> > the client can access, and pre-receive-hook can ban the client from dow=
nloading
> > other references. But this method is a little weird... How can this ref=
erence
> > sync with main branches? If we have changed client permission to access
> > server directory, how to get the "history" of the server directory?
> >
> > I believe this approach is not very appropriate and is not maintainable=
.
>
> It's not maintainable at all, and I don't believe any current git client
> supports this.

I agree it's not maintainable and a bad idea.  But I did want to
correct one small thing, and I do have an alternative suggestion at
the end...

> But due to git's commits referring to a Merkle tree I can tell you that
> a subdirectory "secret" has a current tree SHA-1 of XYZ, without giving
> you any of that content.
>
> You *could* then manually construct a commit like:
>
>         tree <NEW_TREE>
>         ...
>
> Where the "<NEW_TREE>" would be a tree like:
>
>         100644 blob <NEW-BLOB-SHA1>     UPDATED.md
>         040000 tree <XYZ>       secret-stuff
>
> And send you a PACK with my new two three new objects (commit, blob &
> new top-level NEW_TREE). To the remote end & protocol it wouldn't be
> distinguishable from a "normal" push.
>
> But nothing supports this already, as a practical matter most of git
> either hard dies if content is missing, or has other odd edge-case
> semantics (and I'm not up-to-date on the state of the art).

Actually, this is what sparse-index (as a sub-option in
sparse-checkout) already basically does.  See
Documentation/technical/sparse-index.txt for details, and note that
we're basically in Phase IV of that document.  In short, the
sparse-index makes it so that common operations based on the index do
not need and do not use information about some subtrees, so if someone
has a partial clone starting with no blobs, they will only have to
download a small subset of the repository blobs in order to handle
most Git operations, and many operations become much faster since the
index is so much smaller.

However:

* Users can run `git sparse-checkout reapply --no-sparse-index` at any
time to force the index to be full again.  This is documented, and
even suggested that users remember in case they attempt to use
external tools (jgit? libgit2? others?) that don't understand sparse
directory entries.  So, removing this ability would be problematic.

* It makes no guarantee whatsoever that the sparse directory entries
are not expanded by less frequently used Git commands.  Notice the
"ensure_full_index()" calls sprinkled throughout the code.  Some have
been removed, one by one, as commands have been modified to better
operate with a sparse index.  The odds they'll all be removed in the
future may well be close to 0%.

* The `ort` merge strategy ignores the index altogether during
operation.  If it needs to walk into a tree to complete a
merge/rebase/revert/cherry-pick/etc., it will.  Further, it doesn't
just look into those paths, it intentionally de-sparsifies paths
involved in conflicts, so it can display it to the user.

* Just because the index is sparse does not mean other commands can't
walk into those directories.  So `git grep` (when given a revision),
`git diff`, `git log`, etc. will look in (old versions of) those
paths.

> Anyway, just saying that for the longer term I'm not aware of an
> *intrinsic* reason for why we couldn't support this sort of thing, in
> case anyone's interested in putting in a *lot* of leg work to make it
> happen.

And on top of the technical leg work required, they would also need to
somehow convince everyone else that it's worth accepting the increased
maintenance effort.  Right now, even if someone had already done the
work to implement it, I'd say it's not worth the maintenance costs.

However, there are two alternative choices I can think of here: You
can use submodules if you want a fixed part of the repository to only
be available to a subset of folks, or use josh
(https://github.com/josh-project/josh) if you need it to be more
dynamic.
