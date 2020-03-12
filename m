Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEEAC1975A
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 17:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F012067C
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 17:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BD89LZvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCLRgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:36:04 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45140 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgCLRgE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 13:36:04 -0400
Received: by mail-oi1-f193.google.com with SMTP id v19so6316736oic.12
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 10:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3Y2j0+MS8SUs/WwjbJ1pG+Hy60T5n2wEr9skod21RHo=;
        b=BD89LZvLcU1BLQNjQnOeaII9ozhqS3zsohrh1TImZYDSkx5nNAkeMW8rFVhjlKivqP
         ru7kRIVYKTFDNBHuf+fKQTTHzPkqw5qYp1D3FS2mtJERcng6r9ZvOguESFXfpiBIOV13
         AruDvwfROS5ASIUi30wFwGTR6zS4IdtX4QVvD0xxRvfdUUIo5RLiLxifjC972JXNmRlb
         L4Saf/zTMzMcAsVvK/2sqiDAGeLeCnOxTYO57qRp2sqoXJPrdFqA05VBTvI97KpUYsXn
         09KCrv5lZkcrNy8aUlRl3+VnXyjUXgPvPEX0NXx8+3piAu4YrIbbV+FbDYIZUgwm53xQ
         o41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3Y2j0+MS8SUs/WwjbJ1pG+Hy60T5n2wEr9skod21RHo=;
        b=dluOOMwYAxML6h09IHx+H+WoyDvMExgdi5e2mps/hW1svuai+zBzRrHMEsb//+ih7q
         lgt3RClcHL5qnsQvklqoLL7cU7nLoiOPouNKKz8SQ++Lc6kEHyeVpb2coebo9Z3n+cyA
         oC8U0N68xRPFanAFY1jfz9StuPC8b9jGPZyng8dzwgkXNAGcp/gTgrtccwHI0e/V+UY2
         Tw7/NInhhDxn3jQlIU4UAlRA4fFSxhEWwzQfnSTHgIU2Xjzu7txUxCFXK6WVSDqzMqfw
         4WfgqSIhrTDl2p1ZLDM1l+bkVlCbvxLDVykQhUJJPlmVFB1T2oYJnnZGXWIR2goE4xXr
         Lg4Q==
X-Gm-Message-State: ANhLgQ3uxsCk63k27e0LdXOZ4Q9HDsvwJxSsvZFlBK7R+FdAGWSR798F
        i+1SiDJvYNCJezeIozXSnlBQW8Lfpf+yPwmAnb0=
X-Google-Smtp-Source: ADFU+vuqa319vOo4i83tsxTcZb6v22HsIJjyLwDRJQzkqL9tj0SP3qnEtlPryQmGOtPA246ZT/WNeePdshW08iWKGU0=
X-Received: by 2002:aca:dc45:: with SMTP id t66mr3569648oig.39.1584034563118;
 Thu, 12 Mar 2020 10:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <pull.716.git.git.1582762465.gitgitgadget@gmail.com>
 <26d0c34cd1d4a54dab28d0c9c2242336244e8a3c.1582762465.git.gitgitgadget@gmail.com>
 <20200312132032.GD3122@szeder.dev> <CABPp-BEa7pvqgH+EytGPp2AO5nBmEgW0+7HnjK-e3MqrBnthnA@mail.gmail.com>
In-Reply-To: <CABPp-BEa7pvqgH+EytGPp2AO5nBmEgW0+7HnjK-e3MqrBnthnA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 12 Mar 2020 10:35:52 -0700
Message-ID: <CABPp-BGR_eDHJmNOPVQLx8WkL5WLV6J0NtQJ2=AE7CQB2sck5g@mail.gmail.com>
Subject: Re: [PATCH 4/5] t6022, t6046: test expected behavior instead of
 testing a proxy for it
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 12, 2020 at 9:48 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Mar 12, 2020 at 6:20 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
> >
> > On Thu, Feb 27, 2020 at 12:14:23AM +0000, Elijah Newren via GitGitGadge=
t wrote:
> > > From: Elijah Newren <newren@gmail.com>
> > >
> > > In t6022, we were testing for file being overwritten (or not) based o=
n
> > > an output message instead of checking for the file being overwritten.
> > > Since we can check for the file being overwritten via mtime updates,
> > > check that instead.
> > >
> > > In t6046, we were largely checking for both the expected behavior and=
 a
> > > proxy for it, which is unnecessary.  The calls to test-tool also were=
 a
> > > bit cryptic.  Make them a little clearer.
> > >
> > > Signed-off-by: Elijah Newren <newren@gmail.com>
> > > ---
> > >  t/t6022-merge-rename.sh                | 15 ++++-
> > >  t/t6046-merge-skip-unneeded-updates.sh | 89 +++++++++++++++++-------=
--
> > >  2 files changed, 70 insertions(+), 34 deletions(-)
> > >
> > > diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
> > > index 6f196aaf276..d97cf48495b 100755
> > > --- a/t/t6022-merge-rename.sh
> > > +++ b/t/t6022-merge-rename.sh
> > > @@ -242,12 +242,23 @@ test_expect_success 'merge of identical changes=
 in a renamed file' '
> > >       rm -f A M N &&
> > >       git reset --hard &&
> > >       git checkout change+rename &&
> > > +
> > > +     test-tool chmtime =3D31337 B &&
> > > +     test-tool chmtime --get B >old-mtime &&
> >
> > Nit: I think it's possible to change the mtime and print it in a
> > single invocation with:
> >
> >   test-tool chmtime --get =3D1234 file
>
> Oh, cool.
>
> > >       GIT_MERGE_VERBOSITY=3D3 git merge change >out &&
> >
> > Nit: The output of 'git merge' is still redirected to a file, but ...
> >
> > > -     test_i18ngrep "^Skipped B" out &&
> >
> > ... the only command looking at the output is now removed.
>
> Indeed.
>
> > > +     test-tool chmtime --get B >new-mtime &&
> > > +     test_cmp old-mtime new-mtime &&
> > > +
> > >       git reset --hard HEAD^ &&
> > >       git checkout change &&
> > > +
> > > +     test-tool chmtime =3D-1 M &&
> > > +     test-tool chmtime --get M >old-mtime &&
> > >       GIT_MERGE_VERBOSITY=3D3 git merge change+rename >out &&
> > > -     test_i18ngrep ! "^Skipped B" out
> >
> > Likewise.
> >
> > > +     test-tool chmtime --get B >new-mtime &&
> > > +     test $(cat old-mtime) -lt $(cat new-mtime)
> >
> > I saw this test fail today in one of my custom CI builds:
> >
> >   +git checkout change
> >   Switched to branch 'change'
> >   +test-tool chmtime =3D-1 M
> >   +test-tool chmtime --get M
> >   +GIT_MERGE_VERBOSITY=3D3 git merge change+rename
> >   +test-tool chmtime --get B
> >   +cat old-mtime
> >   +cat new-mtime
> >   +test 1583967731 -lt 1583967731
> >   error: last command exited with $?=3D1
> >   not ok 12 - merge of identical changes in a renamed file
> >
> > The contents of 'out', i.e. the output of the 'git merge' command
> > before the failure is:
> >
> >   Auto-merging B
> >   Merge made by the 'recursive' strategy.
> >    A =3D> B | 0
> >    1 file changed, 0 insertions(+), 0 deletions(-)
> >    rename A =3D> B (100%)
> >
> > This is a rare failure, this is the first time I saw it, and to make
> > things worse, this one time it happened on big-endian and with all the
> > GIT_TEST_* knobs enabled.
> >
> >   https://travis-ci.org/github/szeder/git-cooking-topics-for-travis-ci/=
jobs/661294571#L4020
>
> This is very troubling.  The workflow is basically:
>   - Manually set the mtime to a file to something old (I happened to
> pick 1 second before now, but picking something from 1970 would have
> been fine too).
>   - Run a merge which is known to need to overwrite the file.  Your
> output ("Auto-merging B") suggests that we should have been in such a
> case.
>   - Verify that the file was actually updated as expected.  Since the
> OS is supposed to update the mtime when it writes the file, it should
> have set it to something recent, i.e. something *different* than what
> it had before.
>
> So, now I'm left wondering how the mtime possibly could have been not
> updated.  Maybe the file wasn't actually written?  (But if so, why
> didn't other people see the failure?  Or your stress runs not see it?)
>  Or maybe it was written but all file contents and metadata were
> delayed in writing to disk such that a subsequent command still sees
> the old file??  Or maybe it was written but the mtime update was
> delayed and the test was able to check it in that intermediate
> state???  Or perhaps the mtime check before the merge raced with the
> setting of the mtime backwards and got the mtime before it was
> rewound????
>
> I don't have a plausible scenario under which any of these should be
> possible; I'm at a loss.

Hmm.  Maybe leap seconds, or clock updates via ntp at an unfortunate
time?  Perhaps just setting the "old" time to something more than one
second in the past would avoid this?

Anyone have a clue if this is a useful guess or not?
