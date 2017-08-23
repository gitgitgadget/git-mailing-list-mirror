Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1100E20899
	for <e@80x24.org>; Wed, 23 Aug 2017 20:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932621AbdHWUNj (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 16:13:39 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:38301 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932576AbdHWUNi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 16:13:38 -0400
Received: by mail-pg0-f48.google.com with SMTP id m133so4580183pga.5
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 13:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=canonical-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8vuCy6RrJtceP7I3yM49Ujve9mWtkmcA2luvs1McAW8=;
        b=GNfaAmajci3b8GynMdr4yoSODnzomjvl9XkneaMyRPZCZQ1bPjNsV730BRQrZSL4Dc
         BEK6rhQC2Io4NjGOt1H34WpzVHGMha+nhir1IAPJUcUqwJ3cJxx4/KxYmggrYQNXQ5dF
         vt2/GnkjGQvpHWda1SIm7PrlzrNOQnjv/1XDDN5Xcniu8rU/qnb6wOxTSQFdXkgANEMF
         zc6Yi1XrWggACuFS2xyC/40dNAjkQE6ZXD9kUNo8JjSLRsQougBQyJzHMXJ/b874Rj4u
         pE6uLbnnswLMAzLPOzlct3+xBJ+3GLX/khkQXRs6kzwPOIsGJGxz3sxyyFvPOdk4AL7L
         mQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8vuCy6RrJtceP7I3yM49Ujve9mWtkmcA2luvs1McAW8=;
        b=oTkzOkh04bbf0TQqe2wWUcydLJEp1NBXi2g5fZjDxF4TWvPKEiJH5EJ6we0x30gcXr
         jcuh1gKrV6sGGlcDrrhvl4KnNG7mNF76q+sgnGveohYMpZVQXNVS4JnB2uZ1ZS4im4D7
         vadgQwDWzKI3EprkpX7v9f6kQqZIOcCAR54d8QoinQi56KhCa2Xw5A/jxQHXlvEcsQTf
         V8HNSNppiHYkgSaaGWXcW97Qhyq100xU1RB6CSJylnBjKaSpyqIfQj4LBn4zeh/pAyG0
         gSHOjRmx2h6tWOmqlcC+zH6dsNOvMUZj5z+NBAURDXL10ZMjEyK/VoPo4SGXIm9F68/6
         npVg==
X-Gm-Message-State: AHYfb5gf+rzLh45+muSJZgFXHxF61G3m+mdwpCQZ34fgtIlp+8ZWw37u
        K4AeYeTqbQvPWOD9xqrwlg==
X-Received: by 10.99.146.76 with SMTP id s12mr3865558pgn.385.1503519217474;
        Wed, 23 Aug 2017 13:13:37 -0700 (PDT)
Received: from pitfall (174-25-112-249.ptld.qwest.net. [174.25.112.249])
        by smtp.gmail.com with ESMTPSA id h1sm4856789pfg.84.2017.08.23.13.13.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Aug 2017 13:13:37 -0700 (PDT)
Date:   Wed, 23 Aug 2017 13:13:34 -0700
From:   Nish Aravamudan <nish.aravamudan@canonical.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: Undocumented change in `git branch -M` behavior
Message-ID: <20170823201334.bz42s6t5ti4jdaqm@pitfall>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Hopefully, I've got this right -- I noticed a change in behavior in git
with Ubuntu 17.10, which recently got 2.14.1. Specifically, that when in
an orphaned branch, -M ends up moving HEAD to the new branch name,
clobbering the working tree. As far as I know, from the manpages,
orphaned branches are still supported and should work?

I think an example will demonstrate more than words (the following are
done in LXD containers, hence the root user):

# git --version
git version 2.14.1
# mkdir test && cd test && git init .
Initialized empty Git repository in /root/test/.git/
# git checkout -b a
Switched to a new branch 'a'
# touch testfile && git add testfile && git commit -m 'initial commit'
[a (root-commit) 6061193] initial commit
 Committer: root <root@precious-magpie.lxd>
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 testfile
# git checkout --orphan master
Switched to a new branch 'master'
# git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

        new file:   testfile

# git reset --hard && git status
On branch master

No commits yet

nothing to commit (create/copy files and use "git add" to track)
# git branch -M a b
# git status
On branch b
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

        deleted:    testfile

This is very unexpected. I force-renamed a branch I wasn't currently
checked out to and now I'm checked out to it *and* I have staged file
removals (I think what is effectively happening is my current working
directory (empty) is being staged into the new branch, but I'm not
100%).

For comparision, on 17.04:

# git --version
git version 2.11.0
# mkdir test && cd test && git init .
Initialized empty Git repository in /root/test/.git/
# git checkout -b a
Switched to a new branch 'a'
# touch testfile && git add testfile && git commit -m 'initial commit'
[a (root-commit) f8d0d53] initial commit
 Committer: root <root@honest-sturgeon.lxd>
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 testfile
# git checkout --orphan master
Switched to a new branch 'master'
# git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

        new file:   testfile

# git reset --hard && git status
On branch master

No commits yet

nothing to commit (create/copy files and use "git add" to track)
# git branch -M a b
# git status
On branch master

Initial commit

nothing to commit (create/copy files and use "git add" to track)

This is what I expect to see, the branch rename has no effect on HEAD.

I haven't yet bisected this (but I can if necessary). My initial
suspicion is
https://github.com/git/git/commit/70999e9ceca47e03b8900bfb310b2f804125811e#diff-d18f86ea14e2f1e5bff391b2e54438cb
where a comparison between the oldname of the branch and HEAD was
performed before attempting to move HEAD (so that HEAD followed to the
new branch name, I believe). That change was dropped, though and perhaps
the new check in replace_each_worktree_head_symref of

        strcmp(oldref, worktrees[i]->head_ref)

does not work for orphaned branches? I am unfamiliar with all the
details of the git internals, so please correct me if I'm wrong!

Thanks,
Nish

-- 
Nishanth Aravamudan
Ubuntu Server
Canonical Ltd
