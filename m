Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2BCC2D0EA
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 16:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B6220784
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 16:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IORfy2yZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgDHQVf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:21:35 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:41786 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728473AbgDHQVf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 12:21:35 -0400
Received: by mail-oi1-f176.google.com with SMTP id k9so473992oia.8
        for <git@vger.kernel.org>; Wed, 08 Apr 2020 09:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d6/GSdPFPmht7Cotk4rekTMEYkc3LR4WwyHUa81RMDE=;
        b=IORfy2yZuXbMMlNVXYkX86CG1QpaK9Sohpv0zMq7svLURaRt6KU4YemPCAEpdpgdOo
         okusjC3HadwWePld74tS6QL2l2skd/ddBd/E6bBtwOCZPX0Bw3cYf8tDBYoCLZybXHWf
         ce5iL9EQhejQ2dElpown+Fgla6DyozricafMkKxrbx+sDdsVM5JUcD/M5Grlw7/Nmdkc
         vqhDH2gFxyYcgiRx9hHLgwJMtfxoCe0LBP4hND7be7vAabxM0INezPNetlvq6SqmsrdY
         bANHD9EX2Fxy14kouH1VUDJzfJGVDVMP8K/a07HKzxOEkPB92pu8ZWiZAjvrojvw7OTI
         H/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6/GSdPFPmht7Cotk4rekTMEYkc3LR4WwyHUa81RMDE=;
        b=WHmE0VL88c+yfpKZWxBrki8FV6EzZ4C77pSXudbugFZljKskLyZ2RTaFSg0TIlGV7a
         DVoJinnxsZCl+wHRlHeA7fo3Mf/plwnFsmGwPD8xOdCiSgOLLKUlRg0i2c/UYsDeL4Uq
         sYaiSQ1PQpbM6rFqYPeyGTIiA/D6S+jyS+o0xTC77LsfiJ42IHV+0zspZnNckgsIXwI2
         3sZTmDFcRPc6/nNUTtJIGv3rkPYP+ofJUu+82WeIoERWHqf0Hjg5AV6C8Ifsbk2xiIl9
         P+zQz6btEJvylL3D8oQqFbIcNJU7VhohK3DvCE6nCAlGPhC/pgMVoWdo9/FjrvWcL7Gy
         IvSw==
X-Gm-Message-State: AGi0PuagnCuSq2OPgCAXjf6glvJwSIF6SwfClFjQ/Ks02clSzKn3mM5x
        InjmYhi50lRMKTZFHpmdpxO2im6ty9UbQMSqU1o=
X-Google-Smtp-Source: APiQypK8Pyq4tFxNgjKv/N00bxKleZ72VMhq8WJ4dbtMGAYATZ0nXmDwZxyr737Cv0Rv1I5EmL/3NH2OdKFDZpHVQYA=
X-Received: by 2002:a05:6808:12:: with SMTP id u18mr3160673oic.167.1586362893822;
 Wed, 08 Apr 2020 09:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BEHQUzRjddKrC7Q7j+2W-W9ZjdVnXVjsM6wVWrpDF7cwQ@mail.gmail.com>
 <1540391834.807942587.1586332379241.JavaMail.root@zimbra39-e7>
In-Reply-To: <1540391834.807942587.1586332379241.JavaMail.root@zimbra39-e7>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 8 Apr 2020 09:21:22 -0700
Message-ID: <CABPp-BHFnFx-YV=vcQ0O-s0xKUi9g0n5MWEssWb_B_iTv7LGLQ@mail.gmail.com>
Subject: Re: [BUG] submodule move badly handled by git-rebase
To:     ydirson@free.fr
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Yann,

On Wed, Apr 8, 2020 at 12:52 AM <ydirson@free.fr> wrote:
>
> Hi Elijah,
>
> > Hi Yann,
> >
> > On Tue, Apr 7, 2020 at 9:36 AM <ydirson@free.fr> wrote:
> > >
> > > Hello all,
> > >
> > > When rebasing commits involving move of a submodule, git-rebase
> > > fails to
> > > record in index the "add" part of the rename.  This leaves the
> > > workdir
> > > dirty and the rebase gets stopped.
> > >
> > > fast-export of a testcase is attached.  To reproduce, just
> > > "git rebase -i", add a "break" before the move commit,
> > > use this to introduce some noise, and watch.
> > >
> > > Best regards,
> > > --
> > > Yann
> > >
> > >
> > > (master)$ git rebase -i HEAD^^
> > > hint: Waiting for your editor to close the file... Waiting for
> > > Emacs...
> > > Stopped at b0e1b00... add submodule
> > >
> > > (master|REBASE 2/3)$ echo >>README
> > >
> > > (master|REBASE 2/3)$ git commit -a -m noise
> > > [detached HEAD d67c886] noise
> > >  1 file changed, 1 insertion(+)
> > >
> > > (master|REBASE 2/3)$ git rebase --continue
> > > Adding as subdir/gitlab-oe~08e230f... move submodule instead
> > > error: could not apply 08e230f... move submodule
> > > Resolve all conflicts manually, mark them as resolved with
> > > "git add/rm <conflicted_files>", then run "git rebase --continue".
> > > You can instead skip this commit: run "git rebase --skip".
> > > To abort and get back to the state before "git rebase", run "git
> > > rebase --abort".
> > > Could not apply 08e230f... move submodule
> > >
> > > (master|REBASE 3/3)$ git st
> > > interactive rebase in progress; onto c21ef8e
> > > Last commands done (3 commands done):
> > >    break
> > >    pick 08e230f move submodule
> > >   (see more in file .git/rebase-merge/done)
> > > No commands remaining.
> > > You are currently rebasing branch 'master' on 'c21ef8e'.
> > >   (fix conflicts and then run "git rebase --continue")
> > >   (use "git rebase --skip" to skip this patch)
> > >   (use "git rebase --abort" to check out the original branch)
> > >
> > > Changes to be committed:
> > >   (use "git restore --staged <file>..." to unstage)
> > >         modified:   .gitmodules
> > >         deleted:    gitlab-oe
> > >
> > > Unmerged paths:
> > >   (use "git restore --staged <file>..." to unstage)
> > >   (use "git add <file>..." to mark resolution)
> > >         added by them:   subdir/gitlab-oe
> > >
> > > (master|REBASE 3/3)$
> >
> > I couldn't figure out how to duplicate.  Maybe I did something wrong,
> > but it was:
> >     # download your fast-export stream
> >     git init temp
> >     cd temp
> >     cat ~/Downloads/submodule-move.fexp | git fast-import --quiet
> >     git checkout master
> >     git rebase -i HEAD^^
> >     # Insert a line with just 'b' between the two pick lines; save
> >     and
> > exit and when it breaks:
> >     echo >>README
> >     git commit -a -m noise
> >     git rebase --continue
> >
> > After the rebase --continue, the rebase completes just fine applying
> > the patch with the submodule move.  git range-diff master@{1}... will
> > show that I inserted a new commit in the middle.  git log --raw looks
> > good, showing all four commits including the moved submodule at the
> > end.
>
> You're right, I missed crucial point: no problem appears unless the submodule
> is initialized.  After checking out the master branch (and possibly issuing
> "git reset --hard" to make sure everything is clean), it is necessary to
> run "git submodule update --init".
>
>
> > What git version did you use?  Do you need special settings (what's
> > in
> > your ~/.gitconfig and your .git/config)?
>
> This is 2.26.0, but like my other report I had it with 2.25.1 already.
> Just tested with an clear config (HOME and GIT_CONFIG_NOSYSTEM set) and
> the problem triggers as well.

Ah, gotcha.  With the "git submodule update --init", I can duplicate
with 2.26.0 and 2.24.1 and I probably could with any other git version
going back to when submodules were introduced.

I decided to also test with the "ort" merge strategy[1] that I haven't
worked on in over a month.  It fixes this testcase.  So this is yet
another example of it having better correctness than merge-recursive.
Thanks for the report.

Elijah

[1] https://github.com/newren/git/tree/git-merge-2020-demo
