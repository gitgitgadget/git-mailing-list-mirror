Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA20C35242
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 22:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05E02082F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 22:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2idiJj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgBNWmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:42:47 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:37651 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgBNWmr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 17:42:47 -0500
Received: by mail-wr1-f41.google.com with SMTP id w15so12752798wru.4
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 14:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=UJscC+07pqdCz8Su3LM52V0Zrto4Xnvi2vCwVYfIZuY=;
        b=l2idiJj70jbfGNiDRchEmZXpyWfSJgcsPEmqPOglYlHHtPKnRqSqtkKL1JwqcDDIp9
         uPbO1IFnYeoWuYf0bEKQgKjRcf40/ug22rfChm3zGCNnKBfm16lExsY1KN1dKLh6MBvQ
         EWP0q6M5MA4fFJ0Iid3dvhxouSq5KIiBJL9olc3A0y68dKUm2Ea7X5eZ5hYuaghaOFDJ
         Y2hVyKa5EhyRU9IG3eCA2gaWDoYM0mV1V2nmdiJ00revAspFL8+qK/vDRiervy01rSOY
         ZHnSlIbcAVGAe70NyKQs0fqMFEYr0h4MoFqsKXSYMLFdFItoGL3SLlDs3dTIv3tGnmYZ
         GmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=UJscC+07pqdCz8Su3LM52V0Zrto4Xnvi2vCwVYfIZuY=;
        b=uhRCnp92MYGlb/bP3RXTX3X5YUgusub8XEwjUhdYdyEloFSnHpsAJLV6LUF43Gg/4W
         m9tUZAFio0qQq/lQP/16yGA1FcEtLbRlG7yjImza9GK8sLhVglAnrmDn0KGCZO2FFTBS
         iXLbdCRhN2Pj9zsEvZP5+64SjrPwo51sJ4CI8BUAekLgwYbyyyArPTITld5w2GLyXDUi
         FQi5xwvOBNXWUmv4Lzug0wSzvggzLfrJrNR0X4m4IgDnkz0PwPc+Bj9FYarT+BJISqZK
         HidAG6t/7paeNOJZ7aH7BHeiWjw9KgzG1x5BYbhdp9SUZ4WA0oB6wijEJAD2aN9eEBOh
         iuIQ==
X-Gm-Message-State: APjAAAXa/gRjz5LdUwP/QEKBGYMMTWE4hfzyyimUTUhoL+JC2QQ+nQXw
        3t/z7fuUE/MBsF2eAfQnfSmvYIqj
X-Google-Smtp-Source: APXvYqwd1gnCbJ2K4S52dyVyyP+AWxu6UW7Uohy+EWMya2lQYITYGCeAiLUWR2i1y7aQOOfrDo8uSw==
X-Received: by 2002:a5d:65c5:: with SMTP id e5mr5978196wrw.311.1581720164769;
        Fri, 14 Feb 2020 14:42:44 -0800 (PST)
Received: from doriath (244.193.123.78.rev.sfr.net. [78.123.193.244])
        by smtp.gmail.com with ESMTPSA id p26sm8620640wmc.24.2020.02.14.14.42.43
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 14:42:44 -0800 (PST)
Date:   Fri, 14 Feb 2020 23:42:42 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     git@vger.kernel.org
Subject: Nested submodule checkout
Message-ID: <20200214224242.knmzkwx7ls4sote7@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Fri, 14 Feb 2020 23:29:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git developers,

I stumbled into this situation from which it was a bit painful to recover:

-> test script:

    mkdir ploum
    cd ploum
    git init
    echo 'foo' > foo
    git add foo
    git commit -m foo
    git branch nosubmodules

    mkdir plam
    cd plam
    git init
    echo 'bar' > bar
    git add bar
    git commit -m bar

    mkdir plim
    cd plim
    git init
    echo 'baz' > baz
    git add baz
    git commit -m baz

    cd ..
    git submodule add ./plim
    git commit -am 'Add submodule plim'

    cd ..
    git submodule add ./plam
    git commit -am 'Add submodule plam'

    git checkout nosubmodules
    git checkout --recurse-submodules master

-> The result is as follow:

Initialized empty Git repository in /data/dams/var/tmp/ploum/.git/
[master (root-commit) ec7c09a] foo
 1 file changed, 1 insertion(+)
 create mode 100644 foo
Branch 'nosubmodules' set up to track local branch 'master'.
Initialized empty Git repository in /data/dams/var/tmp/ploum/plam/.git/
[master (root-commit) 35e6696] bar
 1 file changed, 1 insertion(+)
 create mode 100644 bar
Initialized empty Git repository in /data/dams/var/tmp/ploum/plam/plim/.git/
[master (root-commit) b4712c1] baz
 1 file changed, 1 insertion(+)
 create mode 100644 baz
Adding existing repo at 'plim' to the index
[master 989c11d] Add submodule plim
 2 files changed, 4 insertions(+)
 create mode 100644 .gitmodules
 create mode 160000 plim
Adding existing repo at 'plam' to the index
[master 5b34041] Add submodule plam
 2 files changed, 4 insertions(+)
 create mode 100644 .gitmodules
 create mode 160000 plam
Migrating git directory of 'plam' from
'/data/dams/var/tmp/ploum/plam/.git' to
'/data/dams/var/tmp/ploum/.git/modules/plam'
Migrating git directory of 'plam/plim' from
'/data/dams/var/tmp/ploum/plam/plim/.git' to
'/data/dams/var/tmp/ploum/.git/modules/plam/modules/plim'
Switched to branch 'nosubmodules'
Your branch is behind 'master' by 1 commit, and can be fast-forwarded.
  (use "git pull" to update your local branch)
fatal: exec '--super-prefix=plam/plim/': cd to 'plim' failed: No such file or directory
error: Submodule 'plim' could not be updated.
error: Submodule 'plam/plim' cannot checkout new HEAD.
error: Submodule 'plam' could not be updated.
M	plam
Switched to branch 'master'

As you can see, the nested plim submodules could not be recreated since the
folder does not exists yet in the 'nosubmodules' branch. This makes the
'plam' submodule update fails, and in the following state

Unstaged changes after reset:
D	.gitmodules
D	bar
D	plim

-> To recover

In the folder plam, do a `git reset` followed by a `git reset --hard`
(`git reset --hard` directly does not work:
fatal: exec '--super-prefix=plim/': cd to 'plim' failed: No such file or directory)

Indeed the first reset, which puts .gitmodules back in the index, is what
allows to do the `git submodule update` implied by `git reset --hard`.
Since (from what I understand) the path is only read from .gitmodules and
not from the .git/config (where there are only the submodules name which
are distinct from the path), this explain the failures observed.

Note that I wasn't able to reproduce in this small examples, but when
trying to repair I also add some strange errors of the form
'.git is not a git directory' (where .git was a pseudo symlink
gitdir: ../.git/modules/plam).

-> Question

My usage is probably non standard (I have quite a lot of nested
submodules), so I had a hard time to recover from this checkout. Is there a
better way? Would it be possible to make nested submodules checkout of this
form work out of the box?

Thanks!
Damien Robert
