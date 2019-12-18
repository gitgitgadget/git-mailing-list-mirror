Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCF2C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 21:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A854B218AC
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 21:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brightrockgames-com.20150623.gappssmtp.com header.i=@brightrockgames-com.20150623.gappssmtp.com header.b="TIVH0Gq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfLRVdo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:33:44 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35268 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLRVdo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 16:33:44 -0500
Received: by mail-oi1-f193.google.com with SMTP id k4so1988107oik.2
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 13:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brightrockgames-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/Zvza/HJrIy+bdLx6p9IoIJ5O83y1Nus6tf06XmUr7U=;
        b=TIVH0Gq4DF6V63VmjDuZSW63JRp6Acx8R8tqeFjunOvCk5QD8S/csOCBEfGvCmPETQ
         CVAa35jVIDPw+LRq/FlGW6D2nZJh5suS4hmiflTxAppQfm8wbuoRbnaGs3chzbD7B65s
         nH2LUeZuYyZEgRPK+PtmLeXXXzFCzXNMhhKCJmF5PczdoyGCSeHgn4jnr9dm6ybB7xAG
         KYj6RY2l8OCLoMSlUtNK/y0HpVVadQVSUyVwrjjrIo865u+EXWJLp0fsnh64UJSFRiCd
         6aRKtYCpcMBdhGwVxONLPOXzFZeJsI198lWF7pJHEkQ2F624MiVnmEqDbDRsI4qum4rM
         qz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/Zvza/HJrIy+bdLx6p9IoIJ5O83y1Nus6tf06XmUr7U=;
        b=GhXSBCOL0eiDOkBX7torygYmGHDLVTfZZ7N0XKMfjuk1VQJLHHKwXerRnUG+ODoxUP
         rJ60ajfu5oWkD6sEJ9doWkbfhjsTtxMM7prFn5t/UoMBr21Ip1YNBsiN0Y/m71TXiLdC
         SnQ8yQS/C8mHm6pM/FuTjQbSxvX0sxbaxFm6RjfMG9el8BbfC+ef/0BJTYLHNnYG3IBI
         Q3sRWmVXEmD3+m0w+G30rgKZrwU9A+VtUW7/f2e8yi3FL8vzJ4ZOg/IY+X4PBCvVE2Sw
         bPi/YL0bn63FedA+FUXNSlSULguJL7pDmBsgsXnGqRjren5pEVmeGSdszLr+Pl+zheU6
         mXVQ==
X-Gm-Message-State: APjAAAVb210A6/A0iFrOh2eBbD6Id4omY0Ns2iuHUePsQpmkEChhNwJv
        CGO+GJxGYrWrexSiMDP1nHHgQYmk0/gD8TswKaxYew==
X-Google-Smtp-Source: APXvYqxhty9zHPHFFc+FpQWpqLt1rm++TcmrENQAM6AkRtBBT+WJl6+B7VASzQimR/UGzQy4jO7Dmz74oR1ecoPVwi0=
X-Received: by 2002:aca:c509:: with SMTP id v9mr1431415oif.151.1576704823164;
 Wed, 18 Dec 2019 13:33:43 -0800 (PST)
MIME-Version: 1.0
References: <CAB1T5w2GyfERoaCyFZeKaui_xuXd0r6J+Zvq4pecstBJ9UyRzw@mail.gmail.com>
 <20191218192741.ybi3xpvax7lrrubz@tb-raspi4>
In-Reply-To: <20191218192741.ybi3xpvax7lrrubz@tb-raspi4>
From:   Scott Richmond <scott@brightrockgames.com>
Date:   Wed, 18 Dec 2019 21:33:32 +0000
Message-ID: <CAB1T5w1Ct7_D7kiUypRuoK+zeiocyPJn0SindXfs6M5wUkVavw@mail.gmail.com>
Subject: Re: Ability to ignore EOL changes for certain projects
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Torsten,

Thanks for the reply!

Correct me if am wrong, but those steps don't tell git to "ignore"
line endings. That just causes git to check all text files in and out
with a specific EOL type (Either automatically chosen, or not). If an
app in the dev env changes a files' EOL to something else, git will
notice the change locally.

Regards,

Scott Richmond.
  Director, Producer, Programmer
  Brightrock Games
  T: 07480795661

On Wed, Dec 18, 2019 at 7:27 PM Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
>
> On Wed, Dec 18, 2019 at 11:10:27AM +0000, Scott Richmond wrote:
> > The Problem Domain
> > In certain dev environments (Unity3D projects) there is (AFAIK) an
> > unsolvable problem where some files are often modified with line
> > endings that aren't the native system or not the committed line
> > endings for that file. Secondarily, in this case line endings don't
> > matter - Nothing in the dev environment "cares" which kind of line
> > ending is used.
> >
> > The Problem
> > Git always cares about EOL. Git has options to transparently modify
> > EOLs when files are checked in or out. However it is not possible to
> > tell Git to ignore EOLs in other commands:
> > Git status shows the file modified.
> > Merging/Pulling has to care because it can't merge with a modified
> > working tree. Which means the user has to care - They have to either
> > stash the EOL changes or wipe them out. Sometimes, if the user has a
> > particular app running, it may automatically reload that file and
> > recreate the modified EOL changes, causing an endless loop. This
> > problem is often made unclear to the user how to solve, especially if
> > they aren't domain experts.
> >
> > To be clear, in this particular dev environment, I can say with
> > confidence that this particular issue is a major and common pain point
> > for users. It is made worse as many users in this environment aren't
> > programmers by trade and aren't domain experts in version control. I
> > also believe this environment is becoming a non-trivial portion of the
> > Git userbase and it would be worthwhile looking into resolving.
> >
> > Solution Request
> > It would be fantastic if we could tell Git to stop caring about EOL
> > changes on a per-repo basis, with the effective output being that git
> > status shouldn't show changes for files with differing EOLs.
> >
> > I'm experienced with Git, though I am not expert enough to consider
> > creating such a change myself - It is unclear to me just how
> > complicated a change may be. However maybe I could look into it if it
> > was made clear that this improvement is possible and has no serious
> > side effects.
>
> Hej Scott,
> I think that you problem can be solved.
> For each repository, you can tell Git to ignore the line endings,
> CRLF vs LF.
>
> If you start with a fresh repo,
> you can do something like:
>
> echo "* text=3Dauto" >.gitattributes
> git add .gitattributes
> git commit -m "Add .gitattributes"
>
> For existing repos, we need to take another step:
>
> echo "* text=3Dauto" >.gitattributes
> git add .gitattributes
> git add  --renormlize .
> git commit -m "Add .gitattributes"
>
> More information can be found e.g. here:
> https://git-scm.com/docs/git-add
>
> Once you done that, you can merge branches
> into the master branch with help of the renormalize
>
> git merge -X renormalze branch-name
>
> See even here:
> https://git-scm.com/docs/git-merge
>
>
> This is just a (too) short introduction, I hope that it
> helps and that you find the time to dig somewhat deeper into
> the documentation.
>
> Other developers have that problem as well, you are not alone.
>
> If you have a public repo, I could help with one example.
>
>
> >
> > Regards,
> >
> > Scott Richmond.
> >   Director, Producer, Programmer
> >   Brightrock Games
> >   T: 07480795661
