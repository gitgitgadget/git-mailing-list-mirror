Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C549C54EE9
	for <git@archiver.kernel.org>; Sun,  4 Sep 2022 09:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiIDJOg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Sep 2022 05:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbiIDJOe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2022 05:14:34 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02019B4AF
        for <git@vger.kernel.org>; Sun,  4 Sep 2022 02:14:33 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id r141so4940575iod.4
        for <git@vger.kernel.org>; Sun, 04 Sep 2022 02:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=PEdwK3ZpSDydQfnIASH6dzxEG2fjhaIOueUxrBrXcr4=;
        b=dDGWhAks9ZDBmis2laESs1a+0q5NE1cilkYgAVl2xCw+b28NW638yMQRaR7gqZIU9a
         Rm8PCEHr3tRUVzyuggCPLTzI6FwE+GC2/TDAM/Oet1A6CJMb+QlPbdSs71QJf7zlQwcl
         GLMc36ylektAxJT62NbqpsONOyJ+YZ/9MLN+582VusI3k3X2zUWy8QyYpgWGNNIt1BHg
         lskeBsfGI8CzM6VDeR/KPeL/NHCsjG310gJR+gtyCeHUb9ltqjRK9N8wdvPdAYhyjQY4
         Vx/sp87ZLBZhjTxs4OvacT+uy/yeAm3hRb4vThq8OR/FyClwwNWt5Ashsyb3TqBOTovU
         VPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PEdwK3ZpSDydQfnIASH6dzxEG2fjhaIOueUxrBrXcr4=;
        b=8RIq2aziCa24MxrEccWI9sk8SCMWC53A40gngyquFFIgXeGAVVgFSi4OpcVaqyyIEu
         UXMp9ozHO56q+8ZLP5gFPbtYi0RETeXw+ZWpEfUoytMfIylmJAW3kE6Ti7/jbnPLtyBN
         GTcWZXxm4dAw8c+Jq8mkvp/IdRA/e5ehM7zg5XyhvFXp4mmxaVThZ6RZuM6muVcxJN0E
         c6bs5dr5butDLYfykkPYpAAhn6Do79aHSZCXrupbyt36swvtfHsYIKq7ARTYx934lRiR
         3hVHkRghxsW002PYjO0A/spl8ulKu87XLQOqmBuWOuZHW4jFqrZXZ7iRpCDZf/788fxs
         Tssw==
X-Gm-Message-State: ACgBeo3Hj2/wWuXVDZDKuzqSCtr8F365xSJrMKKcDyPkP74W+52Zw0Uk
        1Xq72vVp3RxhswHOis8CMsbMepWbZFBA62HOzj4=
X-Google-Smtp-Source: AA6agR6hbDdVonuivYP+9NoaMV22QXbxWWnLtgJKqlor+DfOBJstOcNSTzFM49TeQUMkhSDQAgHhM7sRpST4PXPFe8U=
X-Received: by 2002:a6b:6704:0:b0:688:d06b:2233 with SMTP id
 b4-20020a6b6704000000b00688d06b2233mr20720617ioc.174.1662282872318; Sun, 04
 Sep 2022 02:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1343.git.1662025272.gitgitgadget@gmail.com>
 <a14028be-2fd2-258d-94f5-c010669de8a6@github.com> <o48053s6-5540-1234-5roq-92q6981r2306@tzk.qr>
In-Reply-To: <o48053s6-5540-1234-5roq-92q6981r2306@tzk.qr>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 4 Sep 2022 17:14:20 +0800
Message-ID: <CAOLTT8S2r1gzyF8YAORuGwian+QwSniAPd8br0xn_P5gPyxpgg@mail.gmail.com>
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
=9C=882=E6=97=A5=E5=91=A8=E4=BA=94 21:48=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi ZheNing,
>
> first of all: thank you for working on this. In the past, I thought that
> this feature would be likely something we would want to have in Git.
>

Originally, I just find "full git checkout" after partial-clone will
send so many blob-ids:

$ git clone --filter=3Dblob:none --no-checkout --sparse
git@github.com:derrickstolee/sparse-checkout-example.git
$ cd sparse-checkout-example
$ GIT_TRACE_PACKET=3D$HOME/packet.trace git checkout HEAD
$ grep want $HOME/packet.trace  | wc -l
4060

So I just think about whether this process can be simplified between
the client and the server. In git checkout, users only need all the objects
in a commit. So maybe we can let the git client tell the server about this
commit-id, then the server downloads all objects in this commit. Then I
find it just looks like git clone|fetch --depth=3D1, but the shallow-clone =
doesn't
seem as easy to extend missing objects as the partial-clone.

https://git-scm.com/docs/partial-clone#_non_tasks also said:

Every time the subject of "demand loading blobs" comes up it seems
that someone suggests that the server be allowed to "guess" and send
additional objects that may be related to the requested objects.

So I guess --filter=3Ddepth:<depth> may be a solution, but as you and
Derrick have said: there are still very many problems with this depth filte=
r.

> But Stolee's concerns are valid, and made me think about it more. See
> below for a more detailed analysis.
>
> On Thu, 1 Sep 2022, Derrick Stolee wrote:
>
> > On 9/1/2022 5:41 AM, ZheNing Hu via GitGitGadget wrote:
> >
> > > [...]
> > >
> > > Disadvantages of git clone --filter=3Dblob:none with git
> > > sparse-checkout: The git client needs to send a lot of missing
> > > objects' id to the server, this can be very wasteful of network
> > > traffic.
> >
> > Asking for a list of blobs (especially limited to a sparse-checkout) is
> > much more efficient than what will happen when a user tries to do almos=
t
> > anything in a repository formed the way you did here.
>
> I agree. When you have all the commit and tree objects on the local side,
> you can enumerate all the blob objects you need in one fell swoop, then
> fetch them in a single network round trip.
>
> When you lack tree objects, or worse, commit objects, this is not true.
> You may very well need to fetch _quite_ a bunch of objects, then inspect
> them to find out that you need to fetch more tree/commit objects, and the=
n
> a couple more round trips, before you can enumerate all of the objects yo=
u
> need.
>

I think this is because the previous design was that you had to fetch
these missing
commits (also trees) and all their ancestors. Maybe we can modify git
rev-list to
make it understand missing commits...

> Concrete example: let's assume that you clone git.git with a "partial
> depth" of 50. That is, while cloning, all of the tip commits' graphs will
> be traversed up until the commits that are removed by 49 edges in the
> commit graph. For example, v0.99~49 will be present locally after cloning=
,
> but not v0.99~50.
>
> Now, the first-parent depth of v0.99 is 955 (verify with `git rev-list
> --count --first-parent v0.99`). None of the commits reachable from v0.99
> other than the tip itself seem to be closer to any other tag, so all
> commits reachable from v0.99~49 will be missing locally. And since revert=
s
> are rare, we must assume that the vast majority of the associated root
> tree objects are missing, too.
>
> Digging through history, a contributor might need to investigate where,
> say, `t/t4100/t-apply-7.expect` was introduced (it was in v0.99~206)
> because they found something looking like a bug and they need to read the
> commit message to see whether it was intentional. They know that this fil=
e
> was already present in v0.99. Naturally, the command-line to investigate
> that is:
>
>         git log --diff-filter=3DA v0.99 -- t/t4100/t-apply-7.expect
>
> So what does Git do in that operation? It traverses the commits starting
> from v0.99, following the chain along the commit parents. When it
> encounters v0.99~49, it figures out that it has to fetch v0.99~50. To see
> whether v0.99~49 introduced that file, it then has to inspect that commit
> object and then fetch the tree object (v0.99~50^{tree}). Then, Git
> inspects that tree to find out the object ID for v0.99~50^{tree}:t/, sees
> that it is identical to v0.99~49^{tree}:t/ and therefore the pathspec
> filter skips this commit from the output of the `git log` command. A
> couple of parent traversals later (always fetching the parent commit
> object individually, then the associated tree object, then figuring out
> that `t/` is unchanged) Git will encounter v0.99~55 where `t/` _did_
> change. So now it also has to fetch _that_ tree object.
>

Very convincing example. I think some git commands which may require
all missing commits history, should fetch all commits in a batch. (so this
depth filter is not very useful here)

> In total, we are looking at 400+ individual network round trips just to
> fetch the required tree/commit objects, i.e. before Git can show you the
> output of that `git log` command. And that's just for back-filling the
> missing tree/commit objects.
>
> If we had done this using a shallow clone, Git would have stopped at the
> shallow boundary, the user would have had a chance to increase the depth
> in bigger chunks (probably first extending the depth by 50, then maybe
> 100, then maybe going for 500) and while it would have been a lot of
> manual labor, the total time would be still a lot shorter than those 400+
> network round trips (which likely would incur some throttling on the
> server side).
>

Agree.

> > Thinking about this idea, I don't think it is viable. I would need to
> > see a lot of work done to test these scenarios closely to believe that
> > this type of partial clone is a desirable working state.
>
> Indeed, it is hard to think of a way how the design could result in
> anything but undesirable behavior, both on the client and the server side=
.
>
> We also have to consider that our experience with large repositories
> demonstrates that tree and commit objects delta pretty well and are
> virtually never a concern when cloning. It is always the sheer amount of
> blob objects that is causing poor user experience when performing
> non-partial clones of large repositories.
>

Thanks, I think I understand the problem here. By the way, does it make
sense to download just some of the commits/trees in some big repository
which have several million commits/trees?

> Now, I can be totally wrong in my expectation that there is _no_ scenario
> where cloning with a "partial depth" would cause anything but poor
> performance. If I am wrong, then there is value in having this feature,
> but since it causes undesirable performance in all cases I can think of,
> it definitely should be guarded behind an opt-in flag.
>

Well, now I think this depth filter might be a better fit for git fetch.

If git checkout or other commands which just need to check
few commits, and find almost all objects (maybe >=3D 75%) in a
commit are not local, it can use this depth filter to download them.

> Ciao,
> Dscho

Thanks,
ZheNing Hu
