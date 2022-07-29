Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B15AC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 13:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236317AbiG2NPW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 09:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbiG2NPT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 09:15:19 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48698DA9
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 06:15:17 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id e69so3584222iof.5
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 06:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dr4wBvXns5VPkgHlWW411kQ53m7LfNqDVfRvms+nxO8=;
        b=ESn35rEJZ5KyGZ2mqDJyt8buJBIQd1k20zKG8dzQ+RbOTCztBCI0LpvoCJpZxXeEth
         Z+VM7N4AHtDdGCWxPXmswwQBeUxVIX0L27RQ6HMYf7Fby5cUmGCXvCyQkjILo1rAlmfW
         O0kzG81GGWfZdrOn8fATqcdFQXgQ8s2lnbuEs1nXSAlEkVFfC5lhT3EkTGwVWcKpEBl/
         Yz0fEpEQ4jSImTC9XFZYwoGNHL5XzhJNiQH++JxGFxFrepkJPnVWs8ZIwpv+lCXERSau
         bENW1kkmrr7rJHFUECGqgp82sAnoT2N1Is2u1jLV0/Xqn4uTm6WFg9udz47ElPcMGS6t
         onTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dr4wBvXns5VPkgHlWW411kQ53m7LfNqDVfRvms+nxO8=;
        b=xmypr4vJbfALkOqCjfGpZ1pu9RPEy++pGdq9v05ilQfcHy1Wpv+12ylrfdemBOEMp1
         /6XxCO8abdk13Lb1ILzquJotWDsDmvi/AfGIcEtW18KHOpwZSBBzz3zGHSYvR4GbYmYH
         bzLV+TiWxaqu8Eabu+dszMS25rVPcDpClkV4MJTBBbphws2fp3zi4Uvz7lOugTMQ1CgK
         vnFqCfM8+N1tlDcYHU9ANsC7iDtmSEtFXvmuhYPGFLCXjvjfuI89z4nHSKDckL7g/kI5
         kH03ivh4Qp1044fQHuAGMHmKOzMWZhf7HelLh/cbVHq74F2DqnQZjJ0pcspVtGP5vCw0
         gsAw==
X-Gm-Message-State: AJIora8rw7IGypc0Y+V+vel0N0Wt9dVftX96K9/XNnYsQZlmQ2JC03cT
        ezaqqxsettdpKEuAWUyXK2I5BFvmSVAA/xjF4Yg=
X-Google-Smtp-Source: AGRyM1tHg5dCef8WwHtPk7tHgUDpyJKZn5K6x7vbRGyNJA+pV+LDLqiM2HjIyicUvyqfR51BvSKwM1gnwLXc25p/zng=
X-Received: by 2002:a05:6638:339b:b0:33f:5a4c:4d8e with SMTP id
 h27-20020a056638339b00b0033f5a4c4d8emr1344667jav.93.1659100516146; Fri, 29
 Jul 2022 06:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8QusNzdO1mHqQFPz84pznYSpFWJunroRGXQ7qk6sJjeYg@mail.gmail.com>
 <220727.86mtculxnz.gmgdl@evledraar.gmail.com> <CAOLTT8QpYzoKDq6Pf8+YegCWngogy=3hUf-SyV180kntgucMpQ@mail.gmail.com>
 <220728.861qu5kz2c.gmgdl@evledraar.gmail.com>
In-Reply-To: <220728.861qu5kz2c.gmgdl@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 29 Jul 2022 21:15:05 +0800
Message-ID: <CAOLTT8SQsxW4WqwVcE951sW7vqP+YUPauLpMhz8jpRYsmv0bzA@mail.gmail.com>
Subject: Re: Question: What's the best way to implement directory permission
 control in git?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2022=E5=
=B9=B47=E6=9C=8828=E6=97=A5=E5=91=A8=E5=9B=9B 23:59=E5=86=99=E9=81=93=EF=BC=
=9A
>
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
>
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
>
> Anyway, just saying that for the longer term I'm not aware of an
> *intrinsic* reason for why we couldn't support this sort of thing, in
> case anyone's interested in putting in a *lot* of leg work to make it
> happen.
>

As Newren said, this is just like what sparse-index does. I use
partial clone + sparse-checkout + sparse-index to do git add/git commit,
git can add and commit correctly without fetching any excess objects.
But we can't prevent users from downloading other directories or files.

> >> But currently a *lot* of things in the client code assume that these
> >> things will be available in one way or another.
> >>
> >> The state-of-the-art in the "sparse" code may differ from the above, I
> >> don't know.
> >>
> >> Also note that there's a well-known edge case in the git protocol wher=
e
> >> it's really incompatible with the notion of "secret" data, i.e. even i=
f
> >> you hide a ref you'll be able to "guess" it by seeing what delta(s) th=
e
> >> server will produce or accept etc.
> >
> > Yeah, there are data security issues... Unless we need to isolate objec=
ts
> > between directories. Or in this case we disable the delta object.....
> > Okay, this seems a little strange.
>
> You can't really just "disable the delta(s)". Well, you can in
> principle, but like what I outlined above it's one of those things
> that's a far way off, and it's one thing to e.g. have a client that's
> able to craft a commit referring to data it doesn't have.
>
> It's quite another to secure a server in such a way that it can serve up
> secret data from the repo to some clients, but not to others.
>

All right... I might have to think of something else.

> I can imagine some hacks to make that happen, but I won't go into that
> here...

ZheNing Hu
