Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CCDC25B0E
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 04:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbiHSE1T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 00:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbiHSE1S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 00:27:18 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4D0D1E16
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 21:27:15 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id l18so2600804qvt.13
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 21:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=egPgEZcmEtu8uI2t/65ZoICxf709uo9elU2R0AnvDtI=;
        b=Q3ynS0psOAWuyF6qT942xUv+r7xReLW0kZ7SjDQg6OqZp5lyA5CMYwabuNjwprhy2u
         rIs+fhO8jV+nGORrHVgtKLjfwW+hHGXywmu10Tc/2Dc+m7hG5a3vS3MBPctkQJZ/5Qx7
         YrTYZmqAXud7LpT0o/F8GX+csl3hFf0yZqb5V+d2xU8yHV48QA6LDPqhndo+9qxfzEmQ
         6LvVnarQzixPzk7XWd093rTRiENJIRRMgzgOLZbwywMNKdVMpWl3hpxlQ7pzx2qNzUGh
         yP8gJegtzOe7GFWKCZ19UCl858kftJ1iZDedax8icrTngPqJgUfM4iz64Ppz+rY5N+4s
         GhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=egPgEZcmEtu8uI2t/65ZoICxf709uo9elU2R0AnvDtI=;
        b=AiX+4S/bnEnejSWLzCPyH4DlsbRTVRnYQzHui0mCxCpQwcZ2m0XAq8hdYlztHzd3p+
         MUUr/NG3zuMJJ0bXvOYMLhzFh1dMdMTXYyh/fU8SyGe1U+8qjVMBG4oG+N9AZ60R/woQ
         wIumwGrbmZXHZwCyiXXMHq+OrEcSdO450EAzKXluMko7tsFh+fBjBvXPgb8EudfzjZss
         LwvHKe2ZIXCRjFNwLQzI0eS8dkTfnZOedVFQfC1tDHrWRLGsh0/EwxrzS80t76NO7KYm
         2aaO32NB/E3/pjvmSoNdwVu1M1InOnsr9YPN4kyM5pnMChxymYKJzxMrJP75mnjWtk6Y
         eZLQ==
X-Gm-Message-State: ACgBeo1YVYCWof/wW4UXQyph0iXKKineWwIasxOyMUKvOaRF9UaePCcp
        VLZMdp73gOedPDZ6uCtEXmtG5uwjCbtauW75TR4=
X-Google-Smtp-Source: AA6agR4gZfI2TRAHAqV6Gj+/H2Swg/waa8zFlAwl+TPhPnpZ+iyQtcpP9ihIFqIYDOs5jIPIs1friB9hlpJAPmzV9Dg=
X-Received: by 2002:a05:6214:2a82:b0:476:b707:e1c4 with SMTP id
 jr2-20020a0562142a8200b00476b707e1c4mr4878733qvb.99.1660883234137; Thu, 18
 Aug 2022 21:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210317204939.17890-1-alban.gruin@gmail.com> <20220809185429.20098-1-alban.gruin@gmail.com>
 <20220809185429.20098-9-alban.gruin@gmail.com> <08ea1eec-58fb-cbfa-d405-0d4159c99515@gmail.com>
 <xmqqilmzkd7p.fsf@gitster.g> <qs23r0n8-9r24-6095-3n9n-9131s69974p1@tzk.qr>
 <xmqqedxgt1zx.fsf@gitster.g> <848p4p89-2219-7874-ss50-2o0rp4r02902@tzk.qr>
 <CABPp-BGSFYWvA5HktLf33=w7JB95iDLDNoE0gdA3oUtb+qYoQQ@mail.gmail.com>
 <xmqq7d36vfur.fsf@gitster.g> <220818.868rnlaa0h.gmgdl@evledraar.gmail.com>
 <CABPp-BEvn5ovFF8DzjVW-H9rQ-UdU56uT_dk80w9p7DHokD+rQ@mail.gmail.com> <220819.865yip7xi0.gmgdl@evledraar.gmail.com>
In-Reply-To: <220819.865yip7xi0.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 18 Aug 2022 21:27:03 -0700
Message-ID: <CABPp-BGmukb=C_wzg8774hYRRobGmNJybzh2kCSuLhqV+m4GqA@mail.gmail.com>
Subject: Re: [PATCH v8 08/14] merge-resolve: rewrite in C
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2022 at 7:55 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Aug 18 2022, Elijah Newren wrote:
>
> > On Thu, Aug 18, 2022 at 7:42 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>
> >> On Wed, Aug 17 2022, Junio C Hamano wrote:
> >>
> >> > Elijah Newren <newren@gmail.com> writes:
> >> >
> >> >> There's also another concern you tried to address in your other ema=
il;
> >> >> let me quote from that email here:
> >> >>
> >> >>> If you want to have an easy example of a custom merge strategy, th=
en let's
> >> >>> have that easy example. `git-merge-resolve.sh` ain't that example.
> >> >>>
> >> >>> It would be a different matter if you had commented about
> >> >>> `git-merge-ours.sh`:
> >> >>> https://github.com/git/git/blob/v2.17.0/contrib/examples/git-merge=
-ours.sh
> >> >>> That _was_ a simple and easy example.
> >> >>
> >> >> ...and it was _utterly useless_ as an example.  It only checked tha=
t
> >> >> the user hadn't modified the index since HEAD.  It doesn't demonstr=
ate
> >> >> anything about how to merge differing entries, since that merge
> >> >> strategy specifically ignores changes made on the other side.  Sinc=
e
> >> >> merging differing entries is the whole point of writing a strategy,=
 I
> >> >> see no educational value in that particular script.
> >> >>
> >> >> `git-merge-resolve.sh` may be an imperfect example, but it's certai=
nly
> >> >> far superior to that.
> >> >> ...
> >> >> If someone makes a better example (which I agree could be done,
> >> >> especially if it added lots of comments about what was required and
> >> >> why), and ensures we keep useful test coverage (maybe using Junio's
> >> >> c-resolve suggestion in another email), then my concerns about
> >> >> reimplementing git-merge-resolve.sh in C go away.
> >> >>
> >> >> If that happens, then I still think it's a useless exercise to do t=
he
> >> >> reimplementation -- unless someone can provide evidence of `-s
> >> >> resolve` being in use -- but it's not a harmful exercise and wouldn=
't
> >> >> concern me.
> >> >>
> >> >> If the better example and mechanism to retain good test coverage
> >> >> aren't provided, then I worry that reimplementing is a bunch of wor=
k
> >> >> for an at best theoretical benefit, coupled with a double whammy
> >> >> practical regression.
> >> >
> >> > Ah, you said many things I wanted to say already.  Thanks.
> >>
> >> I may have missed something in this thread, but wouldn't an acceptable
> >> way to please everyone here be to:
> >>
> >>  1. Have git's behavior be that of the end of this series...
> >>  2. Add a GIT_TEST_* mode where we'll optionally invoke these "built-i=
n"
> >>     merge strategies as commands, i.e. have them fall back to
> >>     "try_merge_command()".
> >
> > In the portion of the email you quoted and responded to, most of the
> > text was talking about how git-merge-resolve.sh serves an important
> > educational purpose, yet you've only tried to address the testing
> > issue.  I think both are important.
>
> *Nod*, I meant (but should have said) "on the topic of the test
>  coverage"...

Ah, yes, that would have helped.  :-)

> > The easiest way to fix the
> > educational shortcoming of this series is to reverse the deleting of
> > git-merge-resolve.sh, and restore the building and distribution of
> > git-merge-resolve from that script.  Unfortunately, that generates a
> > collision between both the script and the builtin being used to build
> > the same file (namely, git-merge-resolve)...
>
> I'd think if we were shipping it as an example we could give it a
> different name, or not install it as an executable, but in the "shared"
> part (along with the README etc.).

Seems reasonable; I'm slightly partial to the name
"git-merge-strategy-demo" (though "--strategy strategy-demo" might
look weird), or perhaps just "git-merge-demo" (though that makes
people wonder what kind of demo).

> Or keep it in-tree in contrib, but we did try that sort of thing before
> with 49eb8d39c78 (Remove contrib/examples/*, 2018-03-25) :)
>
> I think the best way forward is to just note in the documentation some
> examples of how to write a merge driver, either by linking to an older
> version of the script, or quoting it inline.

Nitpick: "merge strategy", not "merge driver".

A merge driver is something defined in .gitattributes and only ever
functions on three versions of one file, never having bigger knowledge
of the wider tree.  A merge driver is thus a special purpose three-way
content merge of a single file (replacing the normal xdiff merge
stuff) tailored to a specific file type.

A merge strategy, in contrast, is given multiple commits to merge and
thus has a view of the whole tree.  A merge strategy needs to decide
whether and how to handle directory/file conflicts, differing modes,
submodule updates, recursive ancestor consolidation, file renames
(including weird cases like colliding renames or renamed differently),
directory renames, etc.  A merge strategy may well call various merge
drivers (assuming some are defined in .gitattributes) for different
paths within the tree, and/or fall back to calling (directly or
indirectly) the code in xdiff to handle the three-way merge of
individual files.

> > which is yet another
> > reason that the easiest solution available here is to just not rewrite
> > this script in C at all.
>
> I think there's bigger benefits to moving more things to C & built-ins,
> so I'd prefer to see some version of this where what we do by default is
> to call this C code (or similar), and not as a sub-process.

Yes, in general I agree there are big benefits to moving towards C &
built-ins.  I'm unconvinced any of them apply in the specific case of
merge-resolve, as noted at length earlier in this thread.

If someone wants to do it anyway, they should just make sure that (1)
testing of external merge strategies doesn't regress and remains well
tested, and (2) there is a good story for educating users about how to
write external merge strategies, or at least as good as what we have
now.  If I feel either is being ignored or regressing, I'll likely
express my concerns again.

> > There are certainly other possible solutions to the educational issue,
> > and might not even be too hard, but we'd need someone to implement one
> > before I'd agree we found an "acceptable way to please everyone".  :-)
>
> *nod*
>
> >> So something like this on top of this series (assume my SOB etc. if th=
is
> >> is acceptable). I only tested this locally, but it seems to do the rig=
ht
> >> thing for me:
> > <snip patch>
> >
> > How did you test?  I'm a bit confused...unless I'm misreading
> > something, it appears to me that ci/lib.sh sets SKIP_DASHED_BUILT_INS
> > unconditionally which would probably cause your proposal to break.
>
> Admittedly not very thoroughly, but I'm fairly sure it does the right
> thing when it comes to this, and SKIP_DASHED_BUILT_INS doesn't enter
> into it (and all my local builds use SKIP_DASHED_BUILT_INS=3DY).
>
> The try_merge_command() invokes merge-what-ever, and does a
> run_command_v_opt(args.v, RUN_GIT_CMD). At that point we'll invoke a
> "git merge-what-ever", i.e. we don't need a "git-merge-what-ever" binary
> to exist.
>
> This is what we do in general when git is invoking itself, and we'd need
> to go out of our way to have it not work in this case (i.e. build it as
> a stand-alone program, like git-http-fetch, and not as a built-in).

Oh, right, I was mixing up git-merge-one-file (which merge-resolve has
merge-index invoke, and yes including the dash right after "git") and
`git merge-resolve`.  Sorry about that.
