Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279DFC76196
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 00:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjDDAhX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 20:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjDDAhW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 20:37:22 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63982113
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 17:37:21 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h8so124145237ede.8
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 17:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680568640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7docARFwhZaOSwPy7omqXWOOC188zTgpnHxrYoW/bNc=;
        b=dM0qccoNcUse9E8ql1wthI+4mtdlVsuB3wQWXYbnR7Zn2kAGqNu4iUhPg8amO5Q7YD
         CnScqAZ5h8q87EdX/rcaiBmB3iSFykG/NlUjTUDglX+nDUbdl/o7xe8VJayh6MkFWgHw
         vYjEwd/UYJ/XxQnQwzliL6bPMXwbuWkV+e2V/xvfdYR7obI5LNVMxoYIRi8XsIaNkl2e
         qQElpYCFySIgz+XhsnqrRy/zC69xlMTich4aZscPiVHuEzIIOVTlgxfRutMAymxwbaGp
         dChMXWfIvoXF8ynmVQHNyAwi2pqt3tXMxu2z/1jfqKfQNFJWUN3A9hArykPnne3jcf0r
         PSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680568640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7docARFwhZaOSwPy7omqXWOOC188zTgpnHxrYoW/bNc=;
        b=Twxmqx5fPunO4rtFjxE7DTcgSVXABMdUUoqITLE+V+ofDFnc5QnIr9IKYDKNpY/oeC
         drpB8dU7Wja7KRx0vvjR36WpcPNcW2QkYXyF9ZhPScm8PQ1mc4vd/0t+/JN6xewdjvY/
         3sO3fWYeq+uhW7jpO/wL+C3zeeiVCQk+YLNukdSOx273Xf3+ofxl6ESoGnlOji4Nu0Ui
         Fyr4CUY/hseM+PWzzGpLfPCBl0CxE7naeZtgccJg4yUGShA7dYP68kAGlkGAAkTaiMxx
         30gcEdh4UtzCtpbHDU7HT+gpshIve2dvoQQ2PVkufytWM9O2o7Zdusy2ekcE7NKRVhO3
         ogww==
X-Gm-Message-State: AAQBX9eANWhVifSNvX/fS18olX+lGJKH5aS4pW776TGOeOpoAttJIui+
        1ryHMyYb0r7/InjrQDZ6H0NkhOZzo6LXyJzzc1E9Mc0gbeIOJr4lz0c=
X-Google-Smtp-Source: AKy350Z6vAE8iKw6eSNyUuZD5RevBOgFH9TmJrLr1jtHDCl6MroAGmKBl2paYa8rFRlUVO3xhAD0ui7haVP7H7Tjzlo=
X-Received: by 2002:a17:907:6b8f:b0:932:4577:6705 with SMTP id
 rg15-20020a1709076b8f00b0093245776705mr287170ejc.6.1680568640065; Mon, 03 Apr
 2023 17:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAGP6POLrtA_9kjCwUbVB8-F+dgQbhz==oy5SsXULfspNj_Umuw@mail.gmail.com>
 <87edp0ak45.fsf@vps.thesusis.net> <CAGP6POLVpjxO91s1dX98TLepXMrybSWq9y8qJ6b7w+e0SRJT1A@mail.gmail.com>
In-Reply-To: <CAGP6POLVpjxO91s1dX98TLepXMrybSWq9y8qJ6b7w+e0SRJT1A@mail.gmail.com>
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Tue, 4 Apr 2023 08:37:08 +0800
Message-ID: <CAGP6POJr63o67k+7BeokM-pkPbXYrQy4kcWwMXTfoeuFaPaADQ@mail.gmail.com>
Subject: Re: git revert with partial commit.
To:     Phillip Susi <phill@thesusis.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 4, 2023 at 8:20=E2=80=AFAM Hongyi Zhao <hongyi.zhao@gmail.com> =
wrote:
>
> On Tue, Apr 4, 2023 at 2:36=E2=80=AFAM Phillip Susi <phill@thesusis.net> =
wrote:
> >
> >
> > Hongyi Zhao <hongyi.zhao@gmail.com> writes:
> >
> > > Hi here,
> > >
> > > I want to revert a previous commit partially, as follows:
> > >
> > > werner@X10DAi:~$ git log |grep -A3 -B5 -m1 texstudio
> > > commit f18fbd1e16a1ca4215621768d17858c036086608
> > > Author: Hongyi Zhao <hongyi.zhao@gmail.com>
> > > Date:   Sun Aug 1 20:01:02 2021 +0800
> > >
> > >     deleted:    Public/CTAN/IDE/phonon/compile-install-phonon
> > >     deleted:    Public/CTAN/IDE/texstudio-org/texstudio.git.sh
> > >     modified:   Public/repo/github.com/Dushistov/sdcv.git.sh
> > >     deleted:    Public/repo/github.com/goldendict/stardict-relative/b=
igdict
> > >
> > > More specifically, I just want to revert the following ones:
> > >
> > >     deleted:    Public/CTAN/IDE/phonon/compile-install-phonon
> > >     deleted:    Public/CTAN/IDE/texstudio-org/texstudio.git.sh
> > >
> > > Is this possible?
> >
> > If you are comfortable with git-gui and gitk, then I would say just
> > revert it, then click ammend the previous commit in git-gui, and click
> > to unstage the changes you DON'T want to revert, then commit.  If you
> > want to do it from the command line, then git-revert, then git checkout
> > HEAD~1 -- ( the other 4 file names here ) will get back the other 4
> > files then you can git commit --amend.  Alternatively you can skip
> > git-revert and instead git checkout f18fbd1e16~1 -- (the two files that
> > you DO want to revert), then git commit.
>
> Thanks for your tips. I've also figured out the similar solution based
> on the comment here [1], as shown below:
>
> $ git show f18fbd1e16a1ca4215621768d17858c036086608 --
> Public/CTAN/IDE/phonon/compile-install-phonon
> Public/CTAN/IDE/texstudio-org/texstudio.git.sh | git apply --reverse
> --3way
>
> Because the commit I want to revert is done a long time ago, which is
> not the parent of the commit I'm currently on, so I can't use the `~1`
> which indicates that I want to go back one commit from my current
> position.

Sorry for my inappropriate description above. In fact, it's a more
concise method which also will do the trick, aka, as follows:

$ git checkout f18fbd1e16~1 --
Public/CTAN/IDE/phonon/compile-install-phonon
Public/CTAN/IDE/texstudio-org/texstudio.git.sh

> [1] https://stackoverflow.com/questions/5669358/can-i-do-a-partial-revert=
-in-git
>
> Best,
> Zhao
