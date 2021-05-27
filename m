Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604A4C4707F
	for <git@archiver.kernel.org>; Thu, 27 May 2021 23:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35BFD61176
	for <git@archiver.kernel.org>; Thu, 27 May 2021 23:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbhE0XKT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 19:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbhE0XKS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 19:10:18 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B795BC061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 16:08:43 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so1776922otc.12
        for <git@vger.kernel.org>; Thu, 27 May 2021 16:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qIhSk5USd9TYXKsoecieaUQvN4VVbFYW1TQcxIyOl8g=;
        b=s9oDgFDgvdXa8UTeKEHmwoI4c3YqOFGzEgA+JoRcpuh2V2HkAMOsqPyTyETRdChBBx
         ugX9K4khPdAnu1g1KQwrIhhF8SUGEqmn/PTqOTvL/3QvNZSxbDo/wljkVwsJsENUKTid
         /F6cQKa1xNNXoz6bGJhjce7h66CoVk1ioodKjpYiR3bzliljIbCVz+4mik6e/TqdRNyM
         8yj5G3AHN8Tsj3YJUBa70QyZ+7jyrAtKPjRsf+r5F+Qm2x9wsSNJmkhQdenrDcPM/faF
         jr5yLo0p3uXziUi1tCkfBQbrS4ATLf/HduampchH3BL4i92GRJ/jdB0IXBOgrIET+1PJ
         CKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qIhSk5USd9TYXKsoecieaUQvN4VVbFYW1TQcxIyOl8g=;
        b=U8VGBl9xyhWi00z0FYrt4evmPDLKNbULTeQgBzjWF/yfCUMTxRguBkr6iOaLdPIxv3
         05yWgRCEz6oW3uIbXEhxgopVo5cqIT8KfpGFaHtlRwvu9WYYpWWYqiRo+kDbbA5q8GVB
         x8erx22zTkCbeqshW07kIuWfdWm11yUP4hlUw4t33whNGvfzGPCUUqOueY3Bbej6/BGB
         z7/TNoD+Th/h34AfgmstlifvPgos/DsqqRhF606ZsGED3EuoVdG57jWxl56rwvh9AViC
         2RRLpYM3ZpwHY10oc8K5Cgw2uGf/O2YidqR+HG4Q/zEuWqSdojFgbmYlUdUOIEeaKbGT
         gaDw==
X-Gm-Message-State: AOAM533Dt7gEFz8Ma6ZnZuO6M7ifZIAbYpY0mMAlvyPiBCjTDY6Upu4c
        hSj0aajLRtKpBNOL+moHS+zmj5Mi/30q1yeNUz0oQ7xB4Uo=
X-Google-Smtp-Source: ABdhPJwyE48+bhttW3Jun0QYAUVwtt38J4QJ7ZspHdW8CAe0/uKOZsm/UovC6gmshkv7figscMPcT/1PJus4Ou4KuxQ=
X-Received: by 2002:a9d:7096:: with SMTP id l22mr4712821otj.345.1622156922998;
 Thu, 27 May 2021 16:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210526100932.2hw4rbazgvd6mzff@pengutronix.de>
 <CABPp-BGBY9kwqRQ+soa8=W2F+=8eQRYS3vWS_7UCC0K0qNTW1g@mail.gmail.com> <20210527215947.g2mnds6zj5uv5mjq@pengutronix.de>
In-Reply-To: <20210527215947.g2mnds6zj5uv5mjq@pengutronix.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 27 May 2021 16:08:32 -0700
Message-ID: <CABPp-BEVME5Gx=F4HWHBb_0wn6XJF==DzVLo2i1xj63BB+_jtw@mail.gmail.com>
Subject: Re: time needed to rebase shortend by using --onto?
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Git Mailing List <git@vger.kernel.org>, entwicklung@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 27, 2021 at 2:59 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Wed, May 26, 2021 at 07:38:08AM -0700, Elijah Newren wrote:
> > On Wed, May 26, 2021 at 3:13 AM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > I have a kernel topic branch containing 4 patches on top of Linux v5.=
4.
> > > (I didn't speak to the affected customer, so I cannot easily share th=
e
> > > patch stack. If need be I can probably anonymize it or ask if I can
> > > publish the patches.)
> > >
> > > It rebases clean on v5.10:
> > >
> > >         $ time git rebase v5.10
> > >         Performing inexact rename detection: 100% (36806539/36806539)=
, done.
> > >         Performing inexact rename detection: 100% (36806539/36806539)=
, done.
> > >         Performing inexact rename detection: 100% (36806539/36806539)=
, done.
> > >         Performing inexact rename detection: 100% (36806539/36806539)=
, done.
> > >         Successfully rebased and updated detached HEAD.
> > >
> > >         real    3m47.841s
> > >         user    1m25.706s
> > >         sys     0m11.181s
> > >
> > > If I start with the same rev checked out and explicitly specify the
> > > merge base, the rebase process is considerably faster:
> > >
> > >         $ time git rebase --onto v5.10 v5.4
> > >         Performing inexact rename detection: 100% (36806539/36806539)=
, done.
> > >         Performing inexact rename detection: 100% (36806539/36806539)=
, done.
> > >         Performing inexact rename detection: 100% (36806539/36806539)=
, done.
> > >         Performing inexact rename detection: 100% (36806539/36806539)=
, done.
> > >         Successfully rebased and updated detached HEAD.
> > >
> > >         real    1m20.588s
> > >         user    1m12.645s
> > >         sys     0m6.733s

Note: In your original report you had rename detection and it clearly
took a significant amount of time...

> > >
> > > Is there some relevant complexity in the first invocation I'm not see=
ing
> > > that explains it takes more than the double time? I would have expect=
ed
> > > that
> > >
> > >         git rebase v5.10
> > >
> > > does the same as:
> > >
> > >         git rebase --onto v5.10 $(git merge-base HEAD v5.10)
> > >
> > > . (FTR:
> > >
> > >         $ time git merge-base HEAD v5.10
> > >         219d54332a09e8d8741c1e1982f5eae56099de85
> > >
> > >         real    0m0.158s
> > >         user    0m0.105s
> > >         sys     0m0.052s
> > >
> > > , 219d5433 is v5.4 as expected.
> >
> > That does seem surprising, though if an automatic gc completed between
> > the two commands that could certainly explain it.  If that theory is
> > correct, it would suggest that it'd be difficult for you to reproduce;
>
> This reproduces just fine. The repository is quite big and it is slow at
> times. With the same tree on a different machine, the rebase is quicker,
> but the factor 2 between the two different commands is visible there,
> too:
>
> uwe@taurus:~/gsrc/linux$ git checkout bc2e99c9c9e0d29494b1739624554e4f5f9=
79d32
> HEAD is now at bc2e99c9c9e0 [...]
>
> uwe@taurus:~/gsrc/linux$ time git rebase v5.10
> warning: inexact rename detection was skipped due to too many files.
> warning: you may want to set your merge.renamelimit variable to at least =
8604 and retry the command.
> warning: inexact rename detection was skipped due to too many files.
> warning: you may want to set your merge.renamelimit variable to at least =
8604 and retry the command.
> warning: inexact rename detection was skipped due to too many files.
> warning: you may want to set your merge.renamelimit variable to at least =
8604 and retry the command.
> warning: inexact rename detection was skipped due to too many files.
> warning: you may want to set your merge.renamelimit variable to at least =
8604 and retry the command.
> Successfully rebased and updated detached HEAD.
>
> real    0m20.737s
> user    0m14.188s
> sys     0m3.767s
>
> uwe@taurus:~/gsrc/linux$ git checkout bc2e99c9c9e0d29494b1739624554e4f5f9=
79d32
> HEAD is now at bc2e99c9c9e0 [...]
>
> uwe@taurus:~/gsrc/linux$ time git rebase --onto v5.10 v5.4
> warning: inexact rename detection was skipped due to too many files.
> warning: you may want to set your merge.renamelimit variable to at least =
8604 and retry the command.
> warning: inexact rename detection was skipped due to too many files.
> warning: you may want to set your merge.renamelimit variable to at least =
8604 and retry the command.
> warning: inexact rename detection was skipped due to too many files.
> warning: you may want to set your merge.renamelimit variable to at least =
8604 and retry the command.
> warning: inexact rename detection was skipped due to too many files.
> warning: you may want to set your merge.renamelimit variable to at least =
8604 and retry the command.
> Successfully rebased and updated detached HEAD.
>
> real    0m12.129s
> user    0m7.196s
> sys     0m3.141s
>
> (This is with a slightly newer git: 2.30.2-1 from Debian)

And here, there was no rename detection so this isn't the same thing
anymore.  You could try setting merge.renameLimit higher.

However, the 7-8 second difference (and the likely large differences
between 5.4 and 5.10) do suggest that Junio's hunch that fork-point
behavior being at play could be an issue in these two commands.

> Then I repeated the test with git 2.32.0-rc1 (wgit is just calling
> bin-wrappers/git in my git working copy):
>
> uwe@taurus:~/gsrc/linux$ wgit version
> git version 2.32.0.rc1
>
> uwe@taurus:~/gsrc/linux$ wgit checkout bc2e99c9c9e0d29494b1739624554e4f5f=
979d32
> HEAD is now at bc2e99c9c9e0 [...]
>
> uwe@taurus:~/gsrc/linux$ time wgit rebase v5.10
> warning: inexact rename detection was skipped due to too many files.
> warning: you may want to set your merge.renamelimit variable to at least =
8024 and retry the command.
> warning: inexact rename detection was skipped due to too many files.
> warning: you may want to set your merge.renamelimit variable to at least =
8024 and retry the command.
> warning: inexact rename detection was skipped due to too many files.
> warning: you may want to set your merge.renamelimit variable to at least =
8024 and retry the command.
> warning: inexact rename detection was skipped due to too many files.
> warning: you may want to set your merge.renamelimit variable to at least =
8024 and retry the command.
> Successfully rebased and updated detached HEAD.
>
> real    0m19.438s
> user    0m13.629s
> sys     0m3.299s
>
> uwe@taurus:~/gsrc/linux$ wgit checkout bc2e99c9c9e0d29494b1739624554e4f5f=
979d32
> HEAD is now at bc2e99c9c9e0 [...]
>
> uwe@taurus:~/gsrc/linux$ time wgit rebase --onto v5.10 v5.4
> warning: inexact rename detection was skipped due to too many files.
> warning: you may want to set your merge.renamelimit variable to at least =
8024 and retry the command.
> warning: inexact rename detection was skipped due to too many files.
> warning: you may want to set your merge.renamelimit variable to at least =
8024 and retry the command.
> warning: inexact rename detection was skipped due to too many files.
> warning: you may want to set your merge.renamelimit variable to at least =
8024 and retry the command.
> warning: inexact rename detection was skipped due to too many files.
> warning: you may want to set your merge.renamelimit variable to at least =
8024 and retry the command.
> Successfully rebased and updated detached HEAD.
>
> real    0m13.848s
> user    0m8.315s
> sys     0m3.182s
>
> So the surprise persists.

Yeah, with no rename detection, the newer git version isn't going to
make a bit of difference.

> > running again with either command would give you something closer to
> > the lower time both times.  Is that the case?  (Also, what's the
> > output of "git count-objects -v"?)
>
> After the above commands I have:
>
>         count: 3203
>         size: 17664
>         in-pack: 4763753
>         packs: 11
>         size-pack: 1273957
>         prune-packable: 19
>         garbage: 0
>         size-garbage: 0

So, not freshly packed, but not in need of an automatic gc either.

>         alternate: /home/uwe/var/gitstore/linux.git/objects

You've got an alternate?  How well packed is it?  (What does "git
count-objects -v" in that other repo show?)

>
> (On the repository I did this initially I have:
>
>         warning: garbage found: .git/objects/pack/pack-864148a84c0524073e=
d8c8aa1a76155d5c677879.pack.temp
>         warning: garbage found: /ptx/src/git/linux.git/objects/pack/tmp_p=
ack_X9gHnq
>         count: 2652
>         size: 14640
>         in-pack: 2117015
>         packs: 8
>         size-pack: 574167
>         prune-packable: 856
>         garbage: 2
>         size-garbage: 1114236
>         alternate: /ptx/src/git/linux.git/objects
>
> (Is the garbage a reason this is so slow? Can I just remove the two
> files pointed out?)

If there isn't some still-running git operation that is fetching and
writing to these files, then yes they can be cleaned out.  I doubt
they'd make too much of a difference, though.  I was more curious if
you went from say 10000 loose objects to ~0, or from 50+ packs down to
1 between operations due to an automatic gc completing.

> > I'd love to try this with git-2.32.0-rc1 (or even my not-yet-upstream
> > patches that optimize even further) with adding "--strategy=3Dort" to
> > your rebase command to see how much of a timing difference it makes.
> > Any chance the patches could either be published, or you could retry
> > with git-2.32.0-rc1 and add the --strategy=3Dort command line option to
> > your rebase command(s)?
>
> With --strategy=3Dort added I have:
>
> uwe@taurus:~/gsrc/linux$ time wgit rebase --strategy=3Dort v5.10
> Successfully rebased and updated detached HEAD.
>
> real    0m19.202s
> user    0m12.724s
> sys     0m2.961s
>
> [...]
>
> uwe@taurus:~/gsrc/linux$ time wgit rebase --strategy=3Dort --onto v5.10 v=
5.4
> Successfully rebased and updated detached HEAD.
>
> real    0m12.395s
> user    0m6.638s
> sys     0m3.284s
>
> So the warnings about inexact rename detection don't appear and it's a
> bit faster, but I still see the timing difference between these two
> commands.

Right, this says that --strategy=3Dort WITH rename detection is as fast
as the default --strategy=3Drecursive WITHOUT rename detection.

It's not a fair comparison (you'd need to set merge.renameLimit higher
and re-run the cases where you had warnings), but is interesting
nonetheless.  It basically suggests that rename detection comes for
free with the ort strategy.

> I assume you are still interested in seeing this branch? I think
> anonymising it shouldn't be so hard, the patches are not so big. I'll
> modify the branch to make it shareable and assuming the problem still
> reproduces with it will share it with you.

Thanks.
