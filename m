Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3686AC636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 13:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjBON3W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 08:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjBON3O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 08:29:14 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F852BED7
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 05:28:50 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id hx15so48118059ejc.11
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 05:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3xwznWxgyJaYu6sWIQ8lYhRKBxYQ9PBSj2xVdlJSOM=;
        b=mTYBmG7qaOwRwbiWLkV17znEYFrkrt54hThuEzSWJnECpuh6E9p/l7MYDlPNVYNvvh
         lZmSngFYgoyVYGVZU+qvEJD+5Pi9atuMoBJBJKTtdSy0e2Khiz0iYq/mxoM+cNlUVtNK
         U1I+za5uQQHLUpV2/Sy5x8QZRjygMPL105TdC4kbbUkGQoxeROuEtiRDa0vTd91i9ezB
         hARxwsr4JhOWeXxu+wX+X/NPvW0fHHhAn5ImuyYsYeLOsTQ4a9rxIElVjnFUwCySWx+l
         v9sxRzdGOfe0mroP9yn/bnyTJPtpFrN8jO3EJmvQibHmuLJPoNS0JM/R1HtukpOCs+kU
         SYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3xwznWxgyJaYu6sWIQ8lYhRKBxYQ9PBSj2xVdlJSOM=;
        b=0ArEvIssk+iXp6lf9W4vcOT8hHKaq+iI5cKZDRfmX6NEaVVO9umriTfkgKJjE3ECvK
         x/H51tJtdRLdgTS1szhFXisZBIDe+HTWWPjI81oLDsSQHli5vjgiqg1ilWFbj0+YWZia
         xnPuPOjNmagKGV4Wx6Zsg1EgQZbSaUXmXQjlPr7WRcdHKDFPU6lWpTAlf1rSfu7bAfmU
         tUZz3GIlSkvX4tNvd/Yan/zfe1Yhh5EEoOQDWMGzaV76raD8FCHW5C0pOoFGpCQ9+le5
         YrIz6AgWoBb1zrY4MtjAqsLDdFs55X0s5spFIIsrtVBzbDdVDWaoC1GGDhK+NuFQhqyW
         Veuw==
X-Gm-Message-State: AO0yUKVcS5pK8zvblWvDV0cvhsfDsRVs5ZudurvHdq4nYB70dNtqQE+Y
        nouK5ugCtZEWu5Q17NG/vGaElHGMjGZlwyAxvxz/61Dqnsgop0MT
X-Google-Smtp-Source: AK7set+AIwNVQFP/so0R3dS1Xbqk8GNER7H4m3FuzZz0MZN47kCFCg7lvDxas5CtH4xhcCK5Z1od6YVNxJRH0+NTKX0=
X-Received: by 2002:a17:907:2cd2:b0:895:58be:963 with SMTP id
 hg18-20020a1709072cd200b0089558be0963mr1064763ejc.3.1676467729002; Wed, 15
 Feb 2023 05:28:49 -0800 (PST)
MIME-Version: 1.0
References: <CAAR1xzQwhbHNFFyTJQvkSVLJyJz_Gj5_FQ_udJrjM=ou+3GB3w@mail.gmail.com>
In-Reply-To: <CAAR1xzQwhbHNFFyTJQvkSVLJyJz_Gj5_FQ_udJrjM=ou+3GB3w@mail.gmail.com>
From:   Patakreyp Chandler <patakreyp.chandler@gmail.com>
Date:   Wed, 15 Feb 2023 14:28:38 +0100
Message-ID: <CAAR1xzR9Vu8we4kBkd7rM2NAC63frxZs7Zr4wYNj3beNHtw0Mg@mail.gmail.com>
Subject: Git oddities with case of branch names on Windows
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Here is a scenario for some oddities (bugs?) for case of branch names
(at least with git version 2.37.3.windows.1).

First, we have created an empty git repository on our internal GitHub
server and we clone this repository
    $ git clone git@github.mycompany.com:ID123456/test_branches.git ppppppp
    Cloning into 'ppppppp'...
    warning: You appear to have cloned an empty repository.

Then we create an object in this repository on main branch, we add,
commit and push it:
    $ cd ppppppp/
    $ echo foo > foo
    $ git add foo
     warning: in the working copy of 'foo', LF will be replaced by
CRLF the next time Git touches it
    $ git commit -m 'foo'
     [main (root-commit) 51789b0] foo
     1 file changed, 1 insertion(+)
     create mode 100644 foo
    $ git push
     Enumerating objects: 3, done.
     Counting objects: 100% (3/3), done.
     Writing objects: 100% (3/3), 869 bytes | 869.00 KiB/s, done.
     Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
     To github.mycompany.com:ID123456/test_branches.git
     * [new branch]      main -> main

We create a new branch in this repository and switch to it:
    $ git checkout -b gggg
     Switched to a new branch 'gggg'

We create an object in this repository on the new branch, we add,
commit and push it:
    $ echo bar > bar
    $ git add bar
     warning: in the working copy of 'bar', LF will be replaced by
CRLF the next time Git touches it
    $ git commit -m 'bar'
     [gggg 8f2fdd0] bar
     1 file changed, 1 insertion(+)
     create mode 100644 bar
    $ git push --set-upstream origin gggg
     Enumerating objects: 4, done.
     Counting objects: 100% (4/4), done.
     Delta compression using up to 4 threads
     Compressing objects: 100% (2/2), done.
     Writing objects: 100% (3/3), 929 bytes | 929.00 KiB/s, done.
     Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
     remote:
     remote: Create a pull request for 'gggg' on GitHub by visiting:
     remote:
https://github.mycompany.com/ID123456/test_branches/pull/new/gggg
     remote:
     To github.mycompany.com:ID123456/test_branches.git
     * [new branch]      gggg -> gggg
     branch 'gggg' set up to track 'origin/gggg'.

If we look at the local branches, everything is normal:
    $ git branch -vv
     * gggg 8f2fdd0 [origin/gggg] bar
       main 51789b0 [origin/main] foo

Now we =E2=80=9Cswitch=E2=80=9D to the exact same branch but with a typo (h=
ere, 'GGGG'
instead of 'gggg') in the case of branch name (this does not work with
git on Linux "error: pathspec 'GGGG' did not match any file(s) known
to git."):
    $ git checkout GGGG
     Switched to branch 'GGGG'

We create an object in this repository on the (not really) new branch
(with faulty case name), we add, commit and (try to) push it:
    $ echo foobar > foobar
    $ git add foobar
     warning: in the working copy of 'foobar', LF will be replaced by
CRLF the next time Git touches it
    $ git commit -m 'foobar'
     [GGGG 2ed967b] foobar
     1 file changed, 1 insertion(+)
     create mode 100644 foobar
    $ git push
    fatal: The current branch GGGG has no upstream branch.
    To push the current branch and set the remote as upstream, use
            git push --set-upstream origin GGGG
    To have this happen automatically for branches without a tracking
    upstream, see 'push.autoSetupRemote' in 'git help config'.

Pushing actually fails because git says "The current branch GGGG has
no upstream branch ", and if we check this badly cased branch ("GGGG")
has no upstream tracked branch, but is still the same correctly cased
branch ("gggg"):
    $ git branch -vv
     * GGGG 2ed967b foobar
        main 51789b0 [origin/main] foo
    $ git branch -a
     * GGGG
       main
       remotes/origin/gggg
       remotes/origin/main

Switching back to the correctly cased branch does not seem to put back
everything in order (list of branches is broken), but "git push"
works, at least:
    $ git checkout -
     Switched to branch 'gggg'
       Your branch is ahead of 'origin/gggg' by 1 commit.
       (use "git push" to publish your local commits)
    $ git branch -vv
     GGGG 2ed967b foobar
     main 51789b0 [origin/main] foo
    $ git push
     Enumerating objects: 4, done.
     Counting objects: 100% (4/4), done.
     Delta compression using up to 4 threads
     Compressing objects: 100% (2/2), done.
     Writing objects: 100% (3/3), 962 bytes | 962.00 KiB/s, done.
     Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
     To github.mycompany.com:ID123456/test_branches.git
     8f2fdd0..2ed967b  gggg -> gggg

Even trying to switch to other branches, still does not correct this situat=
ion:
    $ git branch -vv
      GGGG 2ed967b foobar
      main 51789b0 [origin/main] foo
    $ git checkout main
     Switched to branch 'main'
     Your branch is up to date with 'origin/main'.
    $ git branch -vv
       GGGG 2ed967b foobar
     * main 51789b0 [origin/main] foo
    $ git checkout gggg
     Switched to branch 'gggg'
     Your branch is up to date with 'origin/gggg'.
    $ git branch -vv
      GGGG 2ed967b foobar
      main 51789b0 [origin/main] foo
   $ git branch -a
      GGGG
      main
     remotes/origin/gggg
     remotes/origin/main
    $ git checkout Gggg
     Switched to branch 'Gggg'
    $ git branch -a
      GGGG
      main
      remotes/origin/gggg
      remotes/origin/main

 Any idea of what's going on? And how to fix it?
