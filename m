Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E42C2D0ED
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 18:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13212073B
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 18:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qAnjRz3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgC0Sjr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:39:47 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42091 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgC0Sjr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 14:39:47 -0400
Received: by mail-oi1-f195.google.com with SMTP id e4so9653465oig.9
        for <git@vger.kernel.org>; Fri, 27 Mar 2020 11:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DJikYd/A/Hl1+FnsrBoxWu1CezqTwWWqoIzYULPVugA=;
        b=qAnjRz3waWxF1nRk77q0XiHkLyMyDzg2hZcKvCafP/9muEy3qRhSxP1hZDKQvtvfHu
         D5T8VGAkILXBoyQCexEBhQLbwhQKOkuWC27aQOo7xzCRDJlAy0lhR3QfkKpU7+QeuoTx
         ZfPhMTD9wL1NoRNzVsHeitaNM5PwQ1Fz9TdKxP+mrHZxjx6ZYAfOf8++VIphawgtY7xs
         uCj2nkW8BPl8vpMSKBC+dDJCPwNqtOXJnE9AV+lJarHvjjl6yVJ+7lN+u50bRKvtURh/
         blK1PoYx8qQrDEfQ9qkIi140vxe/b1K8fg5l8A0K3lvt80D+gt4l0oJbrO0MbE8LKXsT
         woGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DJikYd/A/Hl1+FnsrBoxWu1CezqTwWWqoIzYULPVugA=;
        b=JUorkBWXnpf4RtlmaqmEvtGfgkqPhrlG/Su16mJAxDLPoTce/4pbo0SYD6NbsXS9sr
         B9TZajexzd8Xu2b6xfvVgZXQ9LuL0+T0xSOTNj5bKJeKC2t+nIVFV0PMr70nkPG7Q6zN
         Z6A/TBIhdyLmGQCMxdCjSPsDLtoeEm2Kn75UXCSIbY2gYxT2ONS4v9fxa8YhbmPrGrWY
         jKDOlayD6EjfHuiLYS3aZAcwyyyrmA32pnc8zZ7GA5Iyy6NmS4On6jvBd5nWscXBGOSJ
         9RCXPk6v+RqWAImj1141gjCRp4m54iGi5KdOX81+zYKfA0JrzKt8CEekewhNU7SWhahM
         K1cQ==
X-Gm-Message-State: ANhLgQ2nXaSLNBalnats2yT03Ov7SBVMgu0L6qvnZUAwt3ZoTkNPM/bj
        RbZfx+emi3+o3sc7GE/nDfgEm4XCSo/CFf0resTV2i5j
X-Google-Smtp-Source: ADFU+vvTRbMz6eVEngUnzpTLvQsixv/66HRyx7TtLySHpp9x2ATOjliDq6xUxTUz0DRl6RXq80UeMaRUowkv4XQs83o=
X-Received: by 2002:aca:4b84:: with SMTP id y126mr162644oia.31.1585334384745;
 Fri, 27 Mar 2020 11:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <9b4bc756764d87c9f34c11e6ec2fc6482f531805.camel@gmail.com> <a3cc46ca-824d-8cab-e333-83f51a7824ca@gmail.com>
In-Reply-To: <a3cc46ca-824d-8cab-e333-83f51a7824ca@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 27 Mar 2020 11:39:33 -0700
Message-ID: <CABPp-BEV0NxMLuM3U8fqECkEB_XHTvLMav1q_TiYveBWrpsr_w@mail.gmail.com>
Subject: Re: git rebase fast-forward fails with abbreviateCommands
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     "Jan Alexander Steffens (heftig)" <jan.steffens@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Fri, Mar 27, 2020 at 8:46 AM Alban Gruin <alban.gruin@gmail.com> wrote:
>
> Hi Jan,
>
> +cc Johannes, Elijah, and Phillip.
>
> Le 27/03/2020 =C3=A0 12:44, Jan Alexander Steffens (heftig) a =C3=A9crit =
:
> > Hi,
> >
> > Since 2.26.0 a simple "git rebase" fails to fast-forward a
> > branch, reporting "error: nothing to do."
> >
> > It started to work again after removing my gitconfig. I've
> > reduced it to the following:
> >
> >     git init foo; cd foo
> >     git commit --allow-empty -m foo
> >     git commit --allow-empty -m bar
> >     git checkout -tb foo
> >     git reset HEAD~
> >     git -c rebase.abbreviateCommands=3Dtrue rebase
> >
>
> Thank you for reporting this bug.
>
> Since git 2.26, the default rebase backend switched from "am" to
> "merge".  So, by default, a todo list is created, even if you can't see i=
t.
>
> In this case, the todo list contains only a `noop', but this command has
> no short form, and is abbreviated with a comment mark.  As there is no
> more commands in the list, the backend will fail with the error "nothing
> to do".
>
> Three approach to fix this:
>
>  1) add an abbreviation to `noop';  this is the simplest fix, and "n" is
> not taken.
>  2) if a command has no short form, do not abbreviate it;  this is
> trivial to do, and should not break anything.

Both sound reasonable to me.

> A third approach would be to change the meaning of an empty buffer, but
> this would break some tests (at least t3404.3) and cause more confusion
> for users than necessary.

Well, "error: nothing to do" probably makes sense if the user
specifies a list of empty commands or sees a list of empty commands
and agrees to pass these to the backend.  But I'm not sure that
message makes sense for implicitly interactive runs as opposed to
explicitly interactive ones.  Perhaps we could change the message to
just be "Already up to date" if the buffer is empty and the run is not
explicitly interactive?


Elijah
