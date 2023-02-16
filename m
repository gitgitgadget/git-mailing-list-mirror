Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B5AC636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 07:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjBPHDy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 02:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBPHDx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 02:03:53 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DBF11EBA
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 23:03:51 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id 10so2112871ejc.10
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 23:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fT7DqC+4epNNUcjxq7VUKBUULAdN6xphMc5SV4Y0Tk=;
        b=h3JQvQkk33JpX/SaSaZ/VHHmUc3QuJsJUfs1rvssrDgmLGbjWBLdc9L1vyUM/G5mjr
         1JQcXI8voDzhwn7wclorQQLUi6f9y5quEoNMRCkEUR+9uWcnm0IypTyMDzQkCNj0WVqP
         g++LKD70t03Dau8elcwCd9emEDz46D/WE35nudKUhdz+lf0XxDDy3s2WcNY68jY4fVM5
         pqPAFcH+SUA3qXkJETDvjat4GhF1jXwfQbEWvuzcoGzKcD0jQiIcOUBKX2HP0xLRzGQM
         IbILuo1GOffJl4i7VZ14bBeAZtXIMg4N2uMX+731DYy/PXASoRIPy9J4ZZOhrq8ptAnZ
         mBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fT7DqC+4epNNUcjxq7VUKBUULAdN6xphMc5SV4Y0Tk=;
        b=2Dc3DAkDgu2xBnbDcLRY9IfnhMtbXpdHrMOXD9/CGUdpp+mjV4co33cPIkj6eq4CBL
         EuqjYC1Vw0++ZHkFafd6OAVp8lV0ZGq/mb0zulCDEMgyR0ftmh5XI46321SYj1iyawIJ
         p61EL6aerbgiS9XdFfp7EC1vBjCSOmc5HAghZkysnT0tkxhzY5BPU7NyBcOAW7Jcb5V6
         CdIlhtpRd1jyXPqBzcKGGauoVne7MMeTCwNgCGxUFMVBUzrvuGCkqW715fUJVJMppNYp
         3T4prKwrg/M6h24QugoNEodpEyVEkoJ7Uqek2SFL0VX1gt+ZdLJDkvyfxRW8XXii3e69
         bW6Q==
X-Gm-Message-State: AO0yUKXeg6wKaiQWAu4nbw99M4uWuttYFK2cYPVz1ZjL5saPtXbbsAlk
        vUCY+ocwYjGBeaL+g2HAeDo40+SclNVwQxjLK7u3Ggqr
X-Google-Smtp-Source: AK7set9rA2HeJS6aljpZFGEQxBK2JeBETpAhcPbTeD9XW3atmuR0hfvQP08NHBHJMyHkcVcW3tO/bXg7yoglkgKriuA=
X-Received: by 2002:a17:907:6c14:b0:8ae:cb48:3c80 with SMTP id
 rl20-20020a1709076c1400b008aecb483c80mr874676ejc.7.1676531029959; Wed, 15 Feb
 2023 23:03:49 -0800 (PST)
MIME-Version: 1.0
References: <CAAR1xzQwhbHNFFyTJQvkSVLJyJz_Gj5_FQ_udJrjM=ou+3GB3w@mail.gmail.com>
 <CAAR1xzR9Vu8we4kBkd7rM2NAC63frxZs7Zr4wYNj3beNHtw0Mg@mail.gmail.com> <20230215165337.kq3d6xx6gbiamfsg@tb-raspi4>
In-Reply-To: <20230215165337.kq3d6xx6gbiamfsg@tb-raspi4>
From:   Patakreyp Chandler <patakreyp.chandler@gmail.com>
Date:   Thu, 16 Feb 2023 08:03:39 +0100
Message-ID: <CAAR1xzQ3KfPacrF7tNnVtcwYrnF7woCOgnw_bYDCxsVtHYRmcQ@mail.gmail.com>
Subject: Re: Git oddities with case of branch names on Windows
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le mer. 15 f=C3=A9vr. 2023 =C3=A0 17:53, Torsten B=C3=B6gershausen <tboegi@=
web.de> a =C3=A9crit :
>
> On Wed, Feb 15, 2023 at 02:28:38PM +0100, Patakreyp Chandler wrote:
> > Hello,
> >
> > Here is a scenario for some oddities (bugs?) for case of branch names
> > (at least with git version 2.37.3.windows.1).
> >
> > First, we have created an empty git repository on our internal GitHub
> > server and we clone this repository
> >     $ git clone git@github.mycompany.com:ID123456/test_branches.git ppp=
pppp
> >     Cloning into 'ppppppp'...
> >     warning: You appear to have cloned an empty repository.
> >
> > Then we create an object in this repository on main branch, we add,
> > commit and push it:
> >     $ cd ppppppp/
> >     $ echo foo > foo
> >     $ git add foo
> >      warning: in the working copy of 'foo', LF will be replaced by
> > CRLF the next time Git touches it
> >     $ git commit -m 'foo'
> >      [main (root-commit) 51789b0] foo
> >      1 file changed, 1 insertion(+)
> >      create mode 100644 foo
> >     $ git push
> >      Enumerating objects: 3, done.
> >      Counting objects: 100% (3/3), done.
> >      Writing objects: 100% (3/3), 869 bytes | 869.00 KiB/s, done.
> >      Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
> >      To github.mycompany.com:ID123456/test_branches.git
> >      * [new branch]      main -> main
> >
> > We create a new branch in this repository and switch to it:
> >     $ git checkout -b gggg
> >      Switched to a new branch 'gggg'
> >
> > We create an object in this repository on the new branch, we add,
> > commit and push it:
> >     $ echo bar > bar
> >     $ git add bar
> >      warning: in the working copy of 'bar', LF will be replaced by
> > CRLF the next time Git touches it
> >     $ git commit -m 'bar'
> >      [gggg 8f2fdd0] bar
> >      1 file changed, 1 insertion(+)
> >      create mode 100644 bar
> >     $ git push --set-upstream origin gggg
> >      Enumerating objects: 4, done.
> >      Counting objects: 100% (4/4), done.
> >      Delta compression using up to 4 threads
> >      Compressing objects: 100% (2/2), done.
> >      Writing objects: 100% (3/3), 929 bytes | 929.00 KiB/s, done.
> >      Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
> >      remote:
> >      remote: Create a pull request for 'gggg' on GitHub by visiting:
> >      remote:
> > https://github.mycompany.com/ID123456/test_branches/pull/new/gggg
> >      remote:
> >      To github.mycompany.com:ID123456/test_branches.git
> >      * [new branch]      gggg -> gggg
> >      branch 'gggg' set up to track 'origin/gggg'.
> >
> > If we look at the local branches, everything is normal:
> >     $ git branch -vv
> >      * gggg 8f2fdd0 [origin/gggg] bar
> >        main 51789b0 [origin/main] foo
> >
> > Now we =E2=80=9Cswitch=E2=80=9D to the exact same branch but with a typ=
o (here, 'GGGG'
> > instead of 'gggg') in the case of branch name (this does not work with
> > git on Linux "error: pathspec 'GGGG' did not match any file(s) known
> > to git."):
> >     $ git checkout GGGG
> >      Switched to branch 'GGGG'
> >
> > We create an object in this repository on the (not really) new branch
> > (with faulty case name), we add, commit and (try to) push it:
> >     $ echo foobar > foobar
> >     $ git add foobar
> >      warning: in the working copy of 'foobar', LF will be replaced by
> > CRLF the next time Git touches it
> >     $ git commit -m 'foobar'
> >      [GGGG 2ed967b] foobar
> >      1 file changed, 1 insertion(+)
> >      create mode 100644 foobar
> >     $ git push
> >     fatal: The current branch GGGG has no upstream branch.
> >     To push the current branch and set the remote as upstream, use
> >             git push --set-upstream origin GGGG
> >     To have this happen automatically for branches without a tracking
> >     upstream, see 'push.autoSetupRemote' in 'git help config'.
> >
> > Pushing actually fails because git says "The current branch GGGG has
> > no upstream branch ", and if we check this badly cased branch ("GGGG")
> > has no upstream tracked branch, but is still the same correctly cased
> > branch ("gggg"):
> >     $ git branch -vv
> >      * GGGG 2ed967b foobar
> >         main 51789b0 [origin/main] foo
> >     $ git branch -a
> >      * GGGG
> >        main
> >        remotes/origin/gggg
> >        remotes/origin/main
> >
> > Switching back to the correctly cased branch does not seem to put back
> > everything in order (list of branches is broken), but "git push"
> > works, at least:
> >     $ git checkout -
> >      Switched to branch 'gggg'
> >        Your branch is ahead of 'origin/gggg' by 1 commit.
> >        (use "git push" to publish your local commits)
> >     $ git branch -vv
> >      GGGG 2ed967b foobar
> >      main 51789b0 [origin/main] foo
> >     $ git push
> >      Enumerating objects: 4, done.
> >      Counting objects: 100% (4/4), done.
> >      Delta compression using up to 4 threads
> >      Compressing objects: 100% (2/2), done.
> >      Writing objects: 100% (3/3), 962 bytes | 962.00 KiB/s, done.
> >      Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
> >      To github.mycompany.com:ID123456/test_branches.git
> >      8f2fdd0..2ed967b  gggg -> gggg
> >
> > Even trying to switch to other branches, still does not correct this si=
tuation:
> >     $ git branch -vv
> >       GGGG 2ed967b foobar
> >       main 51789b0 [origin/main] foo
> >     $ git checkout main
> >      Switched to branch 'main'
> >      Your branch is up to date with 'origin/main'.
> >     $ git branch -vv
> >        GGGG 2ed967b foobar
> >      * main 51789b0 [origin/main] foo
> >     $ git checkout gggg
> >      Switched to branch 'gggg'
> >      Your branch is up to date with 'origin/gggg'.
> >     $ git branch -vv
> >       GGGG 2ed967b foobar
> >       main 51789b0 [origin/main] foo
> >    $ git branch -a
> >       GGGG
> >       main
> >      remotes/origin/gggg
> >      remotes/origin/main
> >     $ git checkout Gggg
> >      Switched to branch 'Gggg'
> >     $ git branch -a
> >       GGGG
> >       main
> >       remotes/origin/gggg
> >       remotes/origin/main
> >
> >  Any idea of what's going on? And how to fix it?
>
> Thanks for the extensive written report,
> very much appreciated to see a reproducable example.
> For a longer discussion, see below.
>
> If you want to get rid of the GGGG branch, I would suggest something
> in tis style:
>
> git checkout -b tmpbranch
> git branch -d GGGG
> git checkout -b gggg
> git branch -d tmpbranch
>
> Is there a better solution ?
> The problem is that your file system treats GGGG as gggg
>
> Running `git pack-refs` could help. But there may be disadvantages
> for people having many many branches.
> (And then there had been some efforts to write a new backend for refs,
> but I didn't follow that up).
>
> My suggestion is to use lowercase for branch names only.
>
> https://git.vger.kernel.narkive.com/PrwMfgXR/branch-name-case-sensitivity

Thanks for the quick answer and I agree that branch names should be lowerca=
se.

But my biggest concern is that, in my example, the 'GGGG' (or 'Gggg',
'gGgg' or whatever combination) branch does not really behaves as the
original 'gggg' branch.

'GGGG' has no tracked branch, instead of 'rorigin/gggg', causing 'git
push' to fail.

If branch 'gggg' could be written with every letters in any case, it
should behave identically whatever the cases, IMHO.
