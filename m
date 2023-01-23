Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E63C05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 15:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjAWPgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjAWPgB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 10:36:01 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790EA2915F
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:36:00 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id a9so15302497ybb.3
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2e6ByVIMxxzA4R0SBIQICq6efBeP0XiH5WNJW5hq+iM=;
        b=MtC7cx8xRyw7PbduPV+V58YAAvXTUSwJK/wiLxYY3/RQN9FOy6crRvs/2EkWLPIXys
         ZUGi7T1oD/hyIEen2tKhdqKXZqWkXrNAW60wIWyl3d22UPfsVA3X1jjBVVa2US2rnnIA
         HZNQGIEzyD3XO4rHrsZ9UhpvCtyoYYYlWaY2cIyL9/R85sCDzOKgbWeEV585UkLjDNZc
         LEIE71y2ai0nh5IPueHhAO9YQlIL/qd6dMUTbj1FDT+zqONcbOUTELiAotsItFXidZLO
         huVA2pOVlkEseyLhUlXAIAYAOorZDANPatyny/9SN9V/IUBAKZtIecKjDmRuu1NeGdSI
         05wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2e6ByVIMxxzA4R0SBIQICq6efBeP0XiH5WNJW5hq+iM=;
        b=F7z6cUtCyfS6RxeJevCS8vfGrQpJE6szNfgvmGMoc5h+guScIBhUYcYXxKuh604pC8
         WKYd1razJKQqQ23WNzekJNq32yMHbQwjBnv0oubiAMZJxv17tv5+M1LsRsdEaR2EBMln
         IxwswmdEGEECDObB33mGtJ6HpxBorAndx2M3JVkctlcKHQ0EGpnUplcfRiP4tqBr4enh
         ljETarR+ZI0kBVmVCs567Pg/yoK5y68SaiC7Ikk76ik6+528eFHvsKmvj+0MwImhl0ws
         mYklW+NC+H1cXRoO+waFeYQzG1fb1g83TqeZjL1OUY/P2EKv3bLBLo6d5t7Y9EW+rj0N
         aJyQ==
X-Gm-Message-State: AFqh2kosjeXiamduv0B02uzIuYvNJO+vio7gvIYklYA5Nhw/TqiRgnX3
        r3S5k46gD7w1vlLquAAn7jRkg5aGbwIjGjDJqME=
X-Google-Smtp-Source: AMrXdXuyOXAN8IuA0yHe6v/lvtP3waJih9OIfQsBrK3gmWm05DmHt1P5JaE4gzmmwmJqrs9m5tZN1IjuJIxoMGk5168=
X-Received: by 2002:a25:13c3:0:b0:802:f667:b222 with SMTP id
 186-20020a2513c3000000b00802f667b222mr1080727ybt.100.1674488159644; Mon, 23
 Jan 2023 07:35:59 -0800 (PST)
MIME-Version: 1.0
References: <pull.1458.git.1673451741587.gitgitgadget@gmail.com>
 <pull.1458.v2.git.1674149666.gitgitgadget@gmail.com> <9ebd6b77a69be414388a52a482912173f2a4e7d8.1674149666.git.gitgitgadget@gmail.com>
 <CABPp-BGLmhoHAcuLoz_yQ4TmNBvDU6Ehymy_3rh0wguSw0hjGw@mail.gmail.com> <xmqqcz79xizc.fsf@gitster.g>
In-Reply-To: <xmqqcz79xizc.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 23 Jan 2023 23:35:48 +0800
Message-ID: <CAOLTT8TztbirR9FmD0s_5iPQ9+NETfecXHE8xeJDNXQUNojSJA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ls-files: add %(skipworktree) atom to format option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=8821=E6=97=
=A5=E5=91=A8=E5=85=AD 00:34=E5=86=99=E9=81=93=EF=BC=9A
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Thu, Jan 19, 2023 at 9:34 AM ZheNing Hu via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: ZheNing Hu <adlternative@gmail.com>
> >>
> >> Because sometimes we want to check if the files in the
> >> index match the sparse specification, so introduce
> >> "%(skipworktree)" atom to git ls-files `--format` option.
> >> When we use this option, if the file match the sparse
> >> specification, it will output "1", otherwise, output
> >> empty string "".
> >
> > Why is that output format useful?  It seems like it'll just lead to
> > bugs, or someone re-implementing the same field with a different name
> > to make it useful in the future.  In particular, if there are multiple
> > boolean fields and someone specifies e.g.
> >    git ls-files --format=3D"%(path) %(skipworktree) %(intentToAdd)"
> > and both boolean fields are displayed the same way (either a "1" or a
> > blank string), and we see something like:
> >    foo.c 1
> >    bar.c 1
> > Then how do we know if foo.c and bar.c are SKIP_WORKTREE or
> > INTENT_TO_ADD?  The "1" could have come from either field.
>
> Perhaps it becomes useful in conjunction with %(if) and friends,
> when they become avaiable?
>
> Until then, I agree that the output format looks pretty klunky.
> The calling scripts still can do
>
>         --format=3D'%(path) A=3D%(A) B=3D%(B) C=3D%(C)'
>
> and take an empty value as false, though.

Can this strange design be considered as a bad design of %(if) and
%(else) in ref-filter?
