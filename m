Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4848BC4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2998460E8F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhGWQVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhGWQVW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 12:21:22 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EAEC061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 10:01:55 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id u10so2516746oiw.4
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 10:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=57SLFrOBebfYS4528bEFeEap3vo+eFHkbZ9bo0HckgA=;
        b=FtmYfYkWmDH4bm8gBqTug28YXGjZn484CmbLAvgiv2VruVXdQFM5twbkKZgeyuMeMY
         nslNDUb5swXdxdUBvq4Z6WUeg7FmjUb30zwZ0N1bnnvPkdLWkcW2Y+xZJkq8Hu9WOqdq
         ZekyHIv8zTY7dAbU/sSExfaEC4IAgvy2/STCrnzOVfgRdE9BYqtUrk2aHM6wH/1cycOx
         zpbxA33uLQMXvApAgoc2GIM+2tuqOWLZ9U/Ctbx1M49ER1llNfCEDCwuLXYFgSuf45c5
         iBuQRt7VpByXB+6G7sSWmi2UxDmsWTyEIOHnrp4I5iOZLnu+KsZS/+mnC/iJnh+bMTZz
         XFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=57SLFrOBebfYS4528bEFeEap3vo+eFHkbZ9bo0HckgA=;
        b=h4/+oF7uVGQ0zU/k528zaPxs2IqUxhFdtJaIZ/xrNk4YgojzONVGmRklT/0BFnM20Y
         3pbug07QvohFseiiVtU3ZVVc5tE9W+D3t7cW2VFmfH4juis3zooJ7bxBMV4GFNwPsx3u
         XvvWQ530O94ZzENxd0tAQtodDj3jsgeVr4+kVlHaUylN5x4s7vOdRp2Vd9UG+1MHqh0v
         zYI4ePRxeiSEOpw+PX3uAeItvo/PV1eDQ6CDGTA+YxK0WdDRToejsK0Pnhh/y5VCp9bn
         6LA8pKakle/eKDERR8GRIik+ag2SFCYpSUvUMxILoVtOQIAasUbXVfrH6efOSkNjeyas
         MkfA==
X-Gm-Message-State: AOAM530WPy5PE29BbeVvWa5C1NvnCb1odum0KDw4Qy5gM7wChsbEIUkr
        /DCUiabbnVOfSIQ9Wf1cyMw=
X-Google-Smtp-Source: ABdhPJyCR1fiT5uKHOwipnLCnkhHmm4iP7LYAIuCr8B/tMq6QiI59kzXPvN8eL2jacjvjnpzqd5PgA==
X-Received: by 2002:a05:6808:14c6:: with SMTP id f6mr9117992oiw.171.1627059715338;
        Fri, 23 Jul 2021 10:01:55 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id i16sm6118447oie.5.2021.07.23.10.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 10:01:54 -0700 (PDT)
Date:   Fri, 23 Jul 2021 12:01:53 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     ZheNing Hu <adlternative@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>
Message-ID: <60faf601bcd7c_defb20881@natae.notmuch>
In-Reply-To: <CAOLTT8Ty47fyY7T3d68CYPKh9k+HAHsnCLJ=F0KaLm+0gp3+EQ@mail.gmail.com>
References: <pull.1001.git.1626962763373.gitgitgadget@gmail.com>
 <xmqqo8au82i0.fsf@gitster.g>
 <CAOLTT8Ty47fyY7T3d68CYPKh9k+HAHsnCLJ=F0KaLm+0gp3+EQ@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] cherry-pick: fix bug when used with
 GIT_CHERRY_PICK_HELP
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu wrote:
> Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=885:25=E5=86=99=E9=81=93=EF=BC=9A=

> >
> > "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > From: ZheNing Hu <adlternative@gmail.com>
> > >
> > > If we set the value of the environment variable GIT_CHERRY_PICK_HEL=
P
> > > when using `git cherry-pick`, CHERRY_PICK_HEAD will be deleted, the=
n
> > > we will get an error when we try to use `git cherry-pick --continue=
`
> > > or other cherr-pick command.
> >
> > I think that the GIT_CHERRY_PICK_HELP is an implemention detail for
> > various forms of rebase to use cherry-pick as a backend and not for
> > use by end users.
> >
> =

> But someone complain to me that the cherry-pick advice is not good enou=
gh.

I agree it's not good enough.

In my opinion `git cherry-pick` should be a more prominent command, and
a lot functionality is missing.

> Think about a git newbie is cherry-picking a patch series containing
> several commits,
> E.g.
> =

> git cherry-pick dev~3..dev
> =

> And then he (she) will see these advice info:
> hint: after resolving the conflicts, mark the corrected paths
> hint: with 'git add <paths>' or 'git rm <paths>'
> hint: and commit the result with 'git commit'
> =

> After he resolving git conflict, execute 'git commit' according to the
> prompt, A terrible thing happened: CHERRY_PICK_HEAD is deleted
> by git and no errors are output. But in fact .git/sequencer still exist=
s,
> Wait until he uses the cherry-pick command next time, the error appears=
:
> =

> error: cherry-pick is already in progress
> hint: try "git cherry-pick (--continue | --abort | --quit)"
> fatal: cherry-pick failed
> =

> So we should not encourage users to use git commit when git cherry-pick=
.
> It would be great if it could provide advice similar to rebase, like th=
is:
> =

> Once you are satisfied with your changes, run
> =

>   git cherry-pick --continue

Agreed.

-- =

Felipe Contreras=
