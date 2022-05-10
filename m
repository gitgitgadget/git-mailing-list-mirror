Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5A5C433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 07:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiEJHhX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 03:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239078AbiEJHL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 03:11:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A62F292785
        for <git@vger.kernel.org>; Tue, 10 May 2022 00:07:30 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ch13so2607976ejb.12
        for <git@vger.kernel.org>; Tue, 10 May 2022 00:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pEVrCyxkKI4mu2ZozVP/1SVQHGj6JPtzB82QduL9how=;
        b=mlxo1TX3DuxpUSA6fzSi+X9+cSGG/mNT3sEZH4UtVN5AUP8M/dK36p1vbkDfhaHgve
         qSbOs7h+viAPoZC2dmbiV1D2BeUWqNEAKxAY5Zqj9NiFGPO/RgzNnKmoAkvZ5I1H3rT6
         Fw1pd4sgGbbd9uIrDmJ6eBXa84kBah+I49MtGdluFKcgxOlLGMsYpsrj6r53f60fJpuI
         FPk7/5mJvwH6cz9yVpIuPCSaHInHR593swpIKj5H3EVCCmbXXsWLKADZp7vf5bNBFtQ4
         S8lNP9pNkf7cKMQAwR0sXu3YKCxn3HdogZII2eAgwmTu3vrEPvBDajhk0x3N+GUxnw/9
         MoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pEVrCyxkKI4mu2ZozVP/1SVQHGj6JPtzB82QduL9how=;
        b=BJEw64iFINwzbyqPIGtFEh4Jz47vV80/Vgyn9zY8IxFqTjts81TPU3ZYJOZ88uoeNS
         J7LxMQK5mPFUJjBoAWLvQEN7fuvRV3b0ePZMz10/5C1oVRCUNr2FxhWU3RLLGxRtR3H1
         rcJXARb6bR5edH5uhQDZ5JiqRHSWd1oQt2xYRvuldWlrBvpXCJKd77Z88RYIH78QOzsR
         nqxE47QeKgwdRwHd+IDMwB3EBfP7VarNwS5JXpzQZbtGJzBqLVTDSZMXqDMVlwBRfgWh
         S5cm7ZBvHJdWGivOsxWgTihx67+gUeBTSH90hOFFtXQS2XdqGynVnvaVYEDcXHjB2sU2
         Uz5Q==
X-Gm-Message-State: AOAM530Ji+VZvFeOKOnfv+VUT36fquWg59hIdmq/wH1CZ15gOf+34x8R
        WVrAJSmasuUSJEPTwbG89e0WMDh1T4BYfF7+HiY=
X-Google-Smtp-Source: ABdhPJygcX7j1+Rl+B/Bczi43lFxHssj59hQVlzx4IqJnUffybjEsYvGebMmyaLK+ORJEa+J14hkuvdgfV9xdtR5gxs=
X-Received: by 2002:a17:907:7f26:b0:6f4:69c:196f with SMTP id
 qf38-20020a1709077f2600b006f4069c196fmr17640180ejc.613.1652166448856; Tue, 10
 May 2022 00:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8S8rh+VYcuaqBeNtmphiRqw7HropLFpkxfnTJq6BngGXw@mail.gmail.com>
 <CAP8UFD2p+Evqv_MBAgv23zooppsNWjOw6ZU2GLqAq_skZoJPOw@mail.gmail.com>
 <CABPp-BGD3AZvXwmSHfQQ_xh_UqevH23kdBYijAWUk8GHu1q0Qw@mail.gmail.com> <CAOLTT8STRfqq4bfobCK8Q5uvtXzgNYY0x0wNh4HNyAhv0Mc07A@mail.gmail.com>
In-Reply-To: <CAOLTT8STRfqq4bfobCK8Q5uvtXzgNYY0x0wNh4HNyAhv0Mc07A@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 10 May 2022 00:07:17 -0700
Message-ID: <CABPp-BEFYjTvK4ZNSg+yiahRAzXW=KU11a-b+QRdcBDGb-movQ@mail.gmail.com>
Subject: Re: Question about pre-merge and git merge octopus strategy
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, vascomalmeida@sapo.pt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 8, 2022 at 7:44 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=887=E6=97=
=A5=E5=91=A8=E5=85=AD 12:09=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Fri, May 6, 2022 at 10:24 AM Christian Couder
> > <christian.couder@gmail.com> wrote:
> > >
> > > On Fri, May 6, 2022 at 10:15 AM ZheNing Hu <adlternative@gmail.com> w=
rote:
[...]
> > > > I think it's not useful for git merge-octopus, because if we meet a
> > > > merge conflict, we can't find
> > > > MERGE_HEAD at all! How can we abort this conflict merge?
> >
> > MERGE_HEAD doesn't have anything to do with aborting the conflict
> > resolution step.  When you need to abort, the thing you want to go
> > back to is HEAD (which represents the commit you had checked out and
> > were merging the other stuff into), not MERGE_HEAD (which represents
> > the branch or branches you were merging into HEAD).
> >
>
> Thanks for clarifying. As I reply to Christian, when I just use "git
> merge A B C" happily,
> and there is a conflict, so I try "git merge --abort" as usual, but it
> can not work... git tell me:
>
> fatal: There is no merge to abort (MERGE_HEAD missing).

Sounds like a bug to me; .git/MERGE_HEAD should be written.  That file
is created for me when I set up a simple octopus merge that has
conflicts.  Do you have a set of steps others can use to reproduce the
problem you are seeing?
