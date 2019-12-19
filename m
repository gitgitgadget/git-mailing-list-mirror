Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DCEC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 03:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92841206D7
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 03:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4GpkPuE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfLSDrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 22:47:42 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32774 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfLSDrm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 22:47:42 -0500
Received: by mail-ed1-f66.google.com with SMTP id r21so3492425edq.0
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 19:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U5Rm39l2WbnPTw43KDjgznxn0+3zOxNSvDVQfjjnNTc=;
        b=r4GpkPuESfPNPRK56u14oDIO6UeXszBdGuBWpDwEG6BgTp+dLO/lhHRyMco+q1Upnw
         FeK99sMujuOnofcLZ8rOj/WX7fxcJd542hV+3qPFXZ14o3+B9RqSns0PkHhY7Tq92Xat
         rMTu5CXMvyWVpEU4hHdP0xXSkqaveURdbVuWYZDVRSqZBmPO+9CSw8eQr42fAcoB8Rea
         Utc+9yDPQxM3A9NUoZJ5Wdotz8LeIucgT0rGrNyPs78S6nhtX1nlavLhtTCBBHX7wVGj
         b/Rd9MQiyaPkiCAuAK+nb+p9EUOQb3O/Lqgn2ZR2YXoII5NPqyAK/Dcdbno7/0SsQECs
         P5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U5Rm39l2WbnPTw43KDjgznxn0+3zOxNSvDVQfjjnNTc=;
        b=bmH+wkfD0Ku6Nw1uDiPpjper8QPFbQh+UYZ9vyBvpU0nwZtm6dFY/O0S4vScH99btO
         +4o3Wcpqw8UGpa4jPX65QqP0XVMVe8yocAsz6RIpFG5//Kn0kZPy3FoqcjF+pMJ19+om
         cEd46Wg/lVqLc+FQkPxT/DORn2xX8AVxPJMMAV6EvSgvZj8wnDZL1Cbl3pswdzLUt1/0
         YEfI6VdbeR8fsJUnZ6NMJR74iD9iBDGc5StNnp7Rk0LXoIKAbk9Axra5c16MbckIWNqh
         0Uhoz8qQjQ0PWHJkhrxGs69buY5uoAC8d6erNQ6f16F5xP2KTjtEnPN8x8G1r4fkuP3q
         0M9g==
X-Gm-Message-State: APjAAAWUyTBkmpOoVHLItffwJX+eL+RhoIKBOdcn8N10YP+tKNx13wgl
        kTk2r06h3xX1IZXzYVGqm5ItqTAz/ydeQVcR3glC8Uzt
X-Google-Smtp-Source: APXvYqyy/v0H/C537oG++bpJzl4nE6mv9FiSKKT3nWnnZJvRDHaIN5paI0y4dVCBmclJpTp7Hg9mIsTVLNPJA8OkGmY=
X-Received: by 2002:a17:906:2505:: with SMTP id i5mr6989258ejb.18.1576727260545;
 Wed, 18 Dec 2019 19:47:40 -0800 (PST)
MIME-Version: 1.0
References: <pull.495.git.1576574242.gitgitgadget@gmail.com>
 <f23477c5a32e5d638310024194040146026972b8.1576574242.git.gitgitgadget@gmail.com>
 <20191217224541.GA230678@google.com>
In-Reply-To: <20191217224541.GA230678@google.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Thu, 19 Dec 2019 16:47:29 +1300
Message-ID: <CACg5j25np9drh7ofpRJs2nY57Yq2NtxDYc2xjGX2tW-0SmwejQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] commit: display advice hints when commit fails
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 18, 2019 at 11:45 AM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Tue, Dec 17, 2019 at 09:17:22AM +0000, Heba Waly via GitGitGadget wrote:
> > From: Heba Waly <heba.waly@gmail.com>
> >
> > Display hints to the user when trying to commit without staging the modified
> > files first (when advice.statusHints is set to true). Change the output of the
> > unsuccessful commit from e.g:
> >
> >   # [...]
> >   # Changes not staged for commit:
> >   #   modified:   builtin/commit.c
> >   #
> >   # no changes added to commit
> >
> > to:
> >
> >   # [...]
> >   # Changes not staged for commit:
> >   #   (use "git add <file>..." to update what will be committed)
> >   #   (use "git checkout -- <file>..." to discard changes in working directory)
> >   #
> >   #   modified:   ../builtin/commit.c
> >   #
> >   # no changes added to commit (use "git add" and/or "git commit -a")
> >
> > In ea9882bfc4 (commit: disable status hints when writing to COMMIT_EDITMSG,
> > 2013-09-12) the intent was to disable status hints when writing to
> > COMMIT_EDITMSG, but in fact the implementation disabled status messages in
> > more locations, e.g in case the commit wasn't successful, status hints
> > will still be disabled and no hints will be displayed to the user although
> > advice.statusHints is set to true.
> >
> > Signed-off-by: Heba Waly <heba.waly@gmail.com>
> > ---
> >  builtin/commit.c                          | 1 +
> >  t/t7500-commit-template-squash-signoff.sh | 9 +++++++++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index 2db2ad0de4..4439666465 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -961,6 +961,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
> >        */
> >       if (!committable && whence != FROM_MERGE && !allow_empty &&
> >           !(amend && is_a_merge(current_head))) {
> > +             s->hints = advice_status_hints;
>
> Hm. This looks like it turns hints back on specifically for this case,
> but might not fix other places where ea9882bfc4 turned them off.
>
> I think the intent of that commit was to not put hints into the editor,
> so does it make sense to instead wrap this guy:
>
>   /*
>    * Most hints are counter-productive when the commit has
>    * already started.
>    */
>   s->hints = 0;
>
> in "if (use_editor)"?
>

That's a good idea, I tried it and it seems to be working fine.

> I didn't try it on my end. Maybe it won't help much, because we think
> we're going to use the editor right up until we realize it's not
> committable?
>
> I wonder which other cases that commit got rid of hints for by accident.
>

The number of cases is quite overwhelming because of all the options that
can be passed to the commit command, but hopefully after wrapping it in
an if condition as you suggested we'll be more certain of the affected cases.
Will send an update shortly.

>  - Emily
>
> >               s->display_comment_prefix = old_display_comment_prefix;
> >               run_status(stdout, index_file, prefix, 0, s);
> >               if (amend)
> > diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
> > index 46a5cd4b73..3d76e8ebbd 100755
> > --- a/t/t7500-commit-template-squash-signoff.sh
> > +++ b/t/t7500-commit-template-squash-signoff.sh
> > @@ -382,4 +382,13 @@ test_expect_success 'check commit with unstaged rename and copy' '
> >       )
> >  '
> >
> > +test_expect_success 'commit without staging files fails and displays hints' '
> > +     echo "initial" >>file &&
> > +     git add file &&
> > +     git commit -m initial &&
> > +     echo "changes" >>file &&
> > +     test_must_fail git commit -m initial >actual &&
> > +     test_i18ngrep "no changes added to commit (use \"git add\" and/or \"git commit -a\")" actual
> > +'
> > +
> >  test_done
> > --
> > gitgitgadget

Thanks,

Heba
