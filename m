Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D34C433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 06:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBE5A64EB8
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 06:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhBIGDV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 01:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhBIGDM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 01:03:12 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AD6C061786
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 22:02:31 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 63so16542766oty.0
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 22:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QBzh8mB5rEw/H8YWnXgG/1/feaPiEtUoB7/BsG6PADU=;
        b=t77DHwZvgjT1SgerLsa9Osj79rm/sl7UO2Akvj2D/F4BVI273cXYB/ukhAXYU926sX
         Iw72XX3kNs8dyxoOceOGYBVttoCDZRrLE76gq7bjNyfg2Usq3PIz9Ig5lUcTQhvmBfkM
         YByzdsiU7yn88P+DBgNjaRimYVdLbLfRlkHP9Ok+kEkSu0eLSfRcGl7VhiwWUMN9kmtD
         5w5DU3ciWWqyBTDzgr/3q//o1U/LdiNhvceFFKN3k43U6M+CNXsBoCSCXVzHIOBvGOem
         /VNJPsKkSnGwiK5trPmuj9IOgVmSFdlw23ssX8kCNyUQPuXKnwF5SqVgF3ybi2/faFpB
         86LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QBzh8mB5rEw/H8YWnXgG/1/feaPiEtUoB7/BsG6PADU=;
        b=BVpbE4lVkjlgIyw+AQlzTVwABKLlbyiMi4X5BYGzWSE+U/GIkYkvLCznBNMu1epOBk
         jKVMwpmyqZQHo9ZyI+u6Qezi8Hou3XHxxiVOAs/cvaNgKcAuxwDhg5OD1UC8lWWLnoej
         5NAHDyhg2slZHrl7Mqrqjooxskq+jkoftZZpQ7G89gw0CYrWDMsDarGGZnc1BJKm+Sm6
         vmRC5B4jJ25XBbmfa0eLqZhsYUqvUl1/uwmNQyRw8H46IkhWoRSpEqrmv+/FVNKLAxzy
         CKw3kNZ46YsI7UwZ/R+Zy+ikB/Lq+TRwy9JGhVH0rwnCySqYbFAGuRKCWH/iFxitN22N
         jGRw==
X-Gm-Message-State: AOAM530pBfylNPu7WxOU+oimaNY8d3BcY0CtBYG+tbNC1xFRmMkzOGzt
        /bMCj55FOOdafDB7lM+XIxZ/APsBR3wFFX0bapU=
X-Google-Smtp-Source: ABdhPJy1Bfb+HCeYhu5WC9vudv08zzZTDddxD5Tkmqfk2GHt0OySe1opVIhr2d7wYgOadAq06uN/8LB5I0F2+FVdE7Q=
X-Received: by 2002:a05:6830:1318:: with SMTP id p24mr14861345otq.302.1612850551133;
 Mon, 08 Feb 2021 22:02:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.870.git.1612711153591.gitgitgadget@gmail.com>
 <pull.870.v2.git.1612803744188.gitgitgadget@gmail.com> <CAJDDKr4AyxuS-MQ+62XGnK4UvJ+cFDdnMwOK1GSn-oiFrWoxyw@mail.gmail.com>
In-Reply-To: <CAJDDKr4AyxuS-MQ+62XGnK4UvJ+cFDdnMwOK1GSn-oiFrWoxyw@mail.gmail.com>
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Tue, 9 Feb 2021 14:04:40 +0800
Message-ID: <CAOLTT8QBmP8AzTBFMqhAU4yHrY1cvusv5EiXY0Qh402m_wTgoQ@mail.gmail.com>
Subject: Re: [PATCH v2] git-difftool-helper.sh: learn a new way go back to
 last save point
To:     David Aguilar <davvid@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=889=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=886:16=E5=86=99=E9=81=93=EF=BC=9A
>
> (cc'd Ryan since the thread involving him was mentioned in the commit mes=
sage)
>
> On Mon, Feb 8, 2021 at 9:02 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > `git difftool` only allow us to select file to view in turn.
> > If there is a commit with many files and we exit in the search,
> > We will have to traverse list again to get the file diff which
> > we want to see. Therefore, here is a new method: every time before
> > we view the file diff, the current coordinates will be stored in
> > `GIT_DIR/difftool-last-position`, this file will be deleted after
> > successful traversing. But if an unexpected exit occurred midway or
> > users similar to using "ctrl+c" kill the process,and the user wants
> > to redo the same `git difftoool`, git will view the coordinates in
> > the save point, ask user if they want continue from the last position.
> > This will improve the user experience.
> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >     git-difftool-helper.sh: learn a new way skip to save point
> >
> >     git user may should travel the diff list to choice file diff to vie=
w, if
> >     they exit in midway,they must travel it again. By saving current
> >     coordinates in GIT_DIR/difftool-last-position method, provides a
> >     possibility for this user-friendly solution.
> >
> >     this patch's origin discuss is here:
> >     https://lore.kernel.org/git/gOXOaoqn-E9A2ob7ykWEcDc7ZxmSwAjcP5CCFKf=
r5ejCOWZQ1lfAUZcbgYT9AyQCcDgJvCrnrtziXiels-Hxol3xlkGTVHk24SvAdaSUtKQ=3D@rtz=
oeller.com/
> >
> >     Thanks!
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-870%2=
Fadlternative%2Fdifftool_save_point-v2
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-870/adlt=
ernative/difftool_save_point-v2
> > Pull-Request: https://github.com/gitgitgadget/git/pull/870
> >
> > Range-diff vs v1:
> >
> >  1:  e77c3e33ba85 ! 1:  2468eaff322b git-difftool-helper.sh: learn a ne=
w way skip to save point
> >      @@ Metadata
> >       Author: ZheNing Hu <adlternative@gmail.com>
> >
> >        ## Commit message ##
> >      -    git-difftool-helper.sh: learn a new way skip to save point
> >      +    git-difftool-helper.sh: learn a new way go back to last save =
point
> >
> >      -    `git difftool` only allow us to select file to view In turn.
> >      -    If there is a commit with many files and we exit in search,
> >      +    `git difftool` only allow us to select file to view in turn.
> >      +    If there is a commit with many files and we exit in the searc=
h,
> >           We will have to traverse list again to get the file diff whic=
h
> >      -    we want to see.Therefore,here is a new method:every time befo=
re
> >      -    we view the file diff,the current coordinates will be stored =
in
> >      -    `GIT_DIR/difftool_skip_to`,this file will be deleted after
> >      -    successful traversing.But if an unexpected exit occurred midw=
ay,
> >      -    git will view the coordinates in the save point,ask user if t=
hey
> >      -    want continue from the last saved point.This will improve the
> >      -    user experience.
> >      +    we want to see. Therefore, here is a new method: every time b=
efore
> >      +    we view the file diff, the current coordinates will be stored=
 in
> >      +    `GIT_DIR/difftool-last-position`, this file will be deleted a=
fter
> >      +    successful traversing. But if an unexpected exit occurred mid=
way or
> >      +    users similar to using "ctrl+c" kill the process,and the user=
 wants
> >      +    to redo the same `git difftoool`, git will view the coordinat=
es in
> >      +    the save point, ask user if they want continue from the last =
position.
> >      +    This will improve the user experience.
> >
> >           Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> >
> >      @@ git-difftool--helper.sh
> >        # Copyright (c) 2009, 2010 David Aguilar
> >
> >        TOOL_MODE=3Ddiff
> >      -+GIT_DIFFTOOL_SKIP_TO_FILE=3D"$GIT_DIR/difftool-skip-to"
> >      ++GIT_DIFFTOOL_LAST_POSITION=3D"$GIT_DIR/difftool-last-position"
> >      ++DIFFTOOL_FIRST_NUM=3D"1"
> >        . git-mergetool--lib
> >
> >        # difftool.prompt controls the default prompt/no-prompt behavior
> >      @@ git-difftool--helper.sh: launch_merge_tool () {
> >         # the user with the real $MERGED name before launching $merge_t=
ool.
> >         if should_prompt
> >         then
> >      -+         if test -f "$GIT_DIFFTOOL_SKIP_TO_FILE"
> >      ++         if test -f "$GIT_DIFFTOOL_LAST_POSITION"
> >       +         then
> >      -+                 SAVE_POINT_NUM=3D$(cat "$GIT_DIFFTOOL_SKIP_TO_F=
ILE")
> >      -+                 if test $SAVE_POINT_NUM -le $GIT_DIFF_PATH_TOTA=
L &&
> >      -+                         test $SAVE_POINT_NUM -gt $GIT_DIFF_PATH=
_COUNTER
> >      ++                 if SAVE_POINT_NUM=3D$(cat 2>/dev/null "$GIT_DIF=
FTOOL_LAST_POSITION") &&
> >      ++                         test "$SAVE_POINT_NUM" -le "$GIT_DIFF_P=
ATH_TOTAL" &&
> >      ++                                 test "$SAVE_POINT_NUM" -gt "$GI=
T_DIFF_PATH_COUNTER"
> >       +                 then
> >      -+                         # choice skip or not skip when check fi=
rst file.
> >      -+                         if test $GIT_DIFF_PATH_COUNTER -eq "1"
> >      ++                         if test "$GIT_DIFF_PATH_COUNTER" -eq "$=
DIFFTOOL_FIRST_NUM"
> >       +                         then
> >      -+                                 printf "do you want to skip to =
last time difftool save point($SAVE_POINT_NUM) [Y/n]?"
> >      ++                                 printf "Do you want to start fr=
om the possible last file you were viewing? [Y/n]?"
> >       +                                 read skip_ans || return
> >       +                                 if test "$skip_ans" =3D y
> >       +                                 then
> >      @@ git-difftool--helper.sh: launch_merge_tool () {
> >       +                         fi
> >       +                 fi
> >       +         fi
>
>
> Similar to Junio's question about, "where does this possible come
> from?", I wasn't able to make out the behavior in the following
> situation.
>
> What about when the user switches branches or specifies a pathspec on
> the command-line or some other avenue that ends up with the number of
> files to diff being very different than the last difftool invocation?
>
> Will difftool, for example, skip over a smaller set of files on
> invocation 2 if invocation 1 involved many files and we exited out
> with a counter number that is very high?
>
This is what I worry about.
> One thing that's not too good about having state files in .git/ is
> that they're global data and we also have to think about, "what if the
> user has multiple difftools running?" and those kind of complexities.
>
I admit that I did not consider the situation where multiple `git difftool`
processes are going on at the same time.
> I don't want this to seem like I'm trying to be dismissive of this
> feature which does seem like a useful thing in general, so I'll try to
> come up with an alternative interface that is slightly more general
> but a admittedly a little bit more cumbersome because it's not as
> automatic.
>
> What if instead of global state, maybe the user could specify a path
> that difftool could skip forward to?   For example, we could teach
> difftool to resume by telling it where we last left off:
>
>    git difftool --resume-from=3Dfoo/bar099.txt
>
> Then we don't need the global counter state file?
>
Wonderful idea.But as Junio said, there may be no global state support,
`start-from` will be more applicable.
>
> Finally, I'm going to plug what I believe to be the right tool for the
> job here.  Have you tried git cola?[1]  Difftool is tightly
> integrated, and the UI is such that you can trivially choose any of
> the modified/staged files and difftool them by using the Ctrl-d
> hotkey.
>
> https://github.com/git-cola/git-cola/
>
> Cola is purpose-built for driving difftool, and for interactive
> staging, so not mentioning it in the context of wanting a better UI
> for difftool would be a disservice to difftool users.
I saw the difftool UI of git-cola, and it is great to view the differences
by selecting files.I have been using vscode's git plugin before, and it
works well tool.
> --
> David
Thanks for help!
--
ZheNing Hu
