Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D635ECAAA1
	for <git@archiver.kernel.org>; Sun, 11 Sep 2022 10:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiIKK7j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Sep 2022 06:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiIKK7h (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2022 06:59:37 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE4F1163
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 03:59:35 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id c4so4889815iof.3
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 03:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=10mJmyzT1KA8sW4qKoE///eahhbRYnPVFmqmUB4DeII=;
        b=nOOcLVDvPjyhcCMrILXAhOMPwlywukib5kG3KHuUMqjAlXUEtG5cZpoDTwEWrN3XPV
         rif3D0tKFMmIncW1pJMYfrb9LFoSBG50mqureAW/7ADqMK/SiYH+d3J+jL8s4zUqKJMK
         IXuHXXtjCl8SheScnWojm5WqZxwqsxVvuim53cvYWhYYWwYpenhsFDaxtoEJhtJBcuKj
         d0GM6/EU301CTI78zpK0vL6MYisgSNcCqmoGzlt/Dd4sk3EKZAESQYPlBTm24tntSsBF
         Cd0G2uPZ+Yiw1tuMJfAv7HsRJIeiyb6Z7vj5aDeooCynEFYx6ceP9zsIihYhnkRGV1aS
         A5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=10mJmyzT1KA8sW4qKoE///eahhbRYnPVFmqmUB4DeII=;
        b=XdJmegg4HhQoUmkgUGUgMZ/4HFDPOPgRUjEV6BrSUcQHq+ahFLeMXJF2EPqdmq6qzL
         LN546nBR0q9wz5gUotx01xZsXTS38wsLfcmHaH/MREHuTbrQIQy91oAdKWySxLaG5/dQ
         kLTiAu08uJ6P5IkDGZEYCzVVRz0U8wadQQfS84o+NhAIggy+muJS5K1hAuRlhnsi8qrT
         RcndRRit+myRq/wf/GaMcIwMw/GHV0Trnm+fH2I9aVTYUdYsHWZHtKCYQ2IHBdrXBKEz
         bBXVk3NyJnZFco0+ZJFlB/D3bMQx5FQj0RCbOEwE9CaxKU5Jnqk5raX8mvJy5Mv17iY9
         +sSQ==
X-Gm-Message-State: ACgBeo1zBjztUsbQrlGHZtLjSOT6s26EKjOpsZIdsurDRsKnIBrvErxK
        F2BGO3Znju1taYbj8yFQGbEt5WiBnExfgLL8DmI=
X-Google-Smtp-Source: AA6agR7T+GcF2JMS/wk0yWF6aL1EYKVJt0L8bSVdnmOWAHBwyLUMh4Lu2y8N4ywV9zS0g4GDo0eOV21o1E8DEODJIjc=
X-Received: by 2002:a05:6638:1683:b0:345:9e65:cd07 with SMTP id
 f3-20020a056638168300b003459e65cd07mr11330449jat.128.1662893975096; Sun, 11
 Sep 2022 03:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1343.git.1662025272.gitgitgadget@gmail.com>
 <a14028be-2fd2-258d-94f5-c010669de8a6@github.com> <o48053s6-5540-1234-5roq-92q6981r2306@tzk.qr>
 <CAOLTT8S2r1gzyF8YAORuGwian+QwSniAPd8br0xn_P5gPyxpgg@mail.gmail.com> <o10o218s-2rq4-9n3p-86np-rn79r7qr2139@tzk.qr>
In-Reply-To: <o10o218s-2rq4-9n3p-86np-rn79r7qr2139@tzk.qr>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 11 Sep 2022 18:59:24 +0800
Message-ID: <CAOLTT8S=4duvizrQQacJ0LjkEKQAL6DY0gwkCuxwDKAFs9XS-w@mail.gmail.com>
Subject: Re: [PATCH 0/3] list-object-filter: introduce depth filter
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> =E4=BA=8E2022=E5=B9=B49=E6=
=9C=887=E6=97=A5=E5=91=A8=E4=B8=89 18:18=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi ZheNing,
>
> On Sun, 4 Sep 2022, ZheNing Hu wrote:
>
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> =E4=BA=8E2022=E5=B9=B4=
9=E6=9C=882=E6=97=A5=E5=91=A8=E4=BA=94 21:48=E5=86=99=E9=81=93=EF=BC=9A
> >
> > > [...]
> > > When you have all the commit and tree objects on the local side,
> > > you can enumerate all the blob objects you need in one fell swoop, th=
en
> > > fetch them in a single network round trip.
> > >
> > > When you lack tree objects, or worse, commit objects, this is not tru=
e.
> > > You may very well need to fetch _quite_ a bunch of objects, then insp=
ect
> > > them to find out that you need to fetch more tree/commit objects, and=
 then
> > > a couple more round trips, before you can enumerate all of the object=
s you
> > > need.
> >
> > I think this is because the previous design was that you had to fetch
> > these missing commits (also trees) and all their ancestors. Maybe we ca=
n
> > modify git rev-list to make it understand missing commits...
>
> We do have such a modification, and it is called "shallow clone" ;-)
>
> Granted, shallow clones are not a complete solution and turned out to be =
a
> dead end (i.e. that design cannot be extended into anything more useful).

Yeah, the depth filter would have been possible to overcome this
shortcoming, but
it may require very much network overhead in some special cases.

> But that approach demonstrates what it would take to implement a logic
> whereby Git understands that some commit ranges are missing and should no=
t
> be fetched automatically.
>

Agree. Git uses the commit-graft to do so.

> > > [...] it is hard to think of a way how the design could result in
> > > anything but undesirable behavior, both on the client and the server
> > > side.
> > >
> > > We also have to consider that our experience with large repositories
> > > demonstrates that tree and commit objects delta pretty well and are
> > > virtually never a concern when cloning. It is always the sheer amount
> > > of blob objects that is causing poor user experience when performing
> > > non-partial clones of large repositories.
> >
> > Thanks, I think I understand the problem here. By the way, does it make
> > sense to download just some of the commits/trees in some big repository
> > which have several million commits/trees?
>
> It probably only makes sense if we can come up with a good idea how to
> teach Git the trick to stop downloading so many objects in costly
> roundtrips.
>

Good advice. Perhaps we should merge these multiple requests into one.
Maybe we should use a blob:none filter to download all missing trees/commit=
s
if we need to iterate through all commits history.

> But I wonder whether your scenarios are so different from the ones I
> encountered, in that commit and tree objects do _not_ delta well on your
> side?
>
> If they _do_ delta well, i.e. if it is comparatively cheap to just fetch
> them all in one go, it probably makes more sense to just drop the idea of
> fetching only some commit/tree objects but not others in a partial clone,
> and always fetch all of 'em.
>

Delta is a wonderful thing most of the time (in cases where bulk acquisitio=
n
is required). But sometimes I think users just want to see the message of o=
ne
commit, so why do they have to download other commits/trees that are not
required?

Sometimes users may better understand the working patterns of their git
objects than the git server, It may be nice if the user could download the
specified object just mapped by its objectid (it is only for blob now, righ=
t?)

> > > Now, I can be totally wrong in my expectation that there is _no_ scen=
ario
> > > where cloning with a "partial depth" would cause anything but poor
> > > performance. If I am wrong, then there is value in having this featur=
e,
> > > but since it causes undesirable performance in all cases I can think =
of,
> > > it definitely should be guarded behind an opt-in flag.
> >
> > Well, now I think this depth filter might be a better fit for git fetch=
.
>
> I disagree here, because I see all the same challenges as I described for
> clones missing entire commit ranges.
>

Oh, a prerequisite is missing here: after we have all commits, trees,
then use the
depth filter to down missing blobs.

> > If git checkout or other commands which just need to check
> > few commits, and find almost all objects (maybe >=3D 75%) in a
> > commit are not local, it can use this depth filter to download them.
>
> If you want a clone that does not show any reasonable commit history
> because it does not fetch commit objects on-the-fly, then we already have
> such a thing with shallow clones.
>
> The only way to make Git's revision walking logic perform _somewhat_
> reasonably would be to teach it to fetch not just a single commit object
> when it was asked for, but to somehow pass a desired depth by which to
> "unshallow" automatically.
>
> However, such a feature would come with the same undesirable implications
> on the server side as shallow clones (fetches into shallow clones are
> _really_ expensive on the server side).
>

Agree. letting git shallow clone to be smarter may work, but there are
big challenges too.

> Ciao,
> Dscho

Thanks,
ZheNing Hu
