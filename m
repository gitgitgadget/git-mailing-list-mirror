Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EFC420248
	for <e@80x24.org>; Tue, 26 Feb 2019 17:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfBZR0j convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 26 Feb 2019 12:26:39 -0500
Received: from mout.gmx.net ([212.227.17.22]:38949 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728421AbfBZR0i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 12:26:38 -0500
Received: from legacy ([128.130.40.151]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MHLNn-1glhx01DGd-00E2WB for
 <git@vger.kernel.org>; Tue, 26 Feb 2019 18:26:37 +0100
Date:   Tue, 26 Feb 2019 18:26:36 +0100
From:   Stefan Tauner <stefan.tauner@gmx.at>
To:     git@vger.kernel.org
Subject: Bug: "orphaned" trees indistinguishable in git log --graph output
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-ID: <0Lfolq-1hNWbf1RUI-00pI54@mail.gmx.com>
X-Provags-ID: V03:K1:YPCQWUlD1u22PHHwdrlsFjnc+dF3zTmda7vM1pRtDCF/EaPh8Q7
 wEO3OofSEY18XNzlrSUJLmoxxm4YoJ5OkILlrbvZD0NzfyQmqNe/Y0H27X18M0duwTuxCKR
 9VpLn604DuCy5WKnoyMNJGRiZ1iUno9kCLuu04zd1seHz9XrwToW1Q35qOf6YBDHk4IjbkU
 aR0IMtBNUgavJfby+567A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8Q4LHoSWg4g=:xJ4m+UB/YaZFXPaj9Mgo17
 ijxo9XxcnnA7oBUg/t1P31SC4WBl3tc+Y4Gg8OqhCP6wZHAJuTcHMW1R6N3uEp2T8wWj5YTqo
 VdzcoApG4hy/R8mYtUSkDNNvts14tyUDGbVtm1ZvCUqjYVly/8tAN2p7a9UqgRfrCdxcNH7DT
 NxGNGVBT9VJCjivQEqcpsWHlHwlFYINfB+m74oE2XoXM9H9r9gSZat1CbftaZWpJP7FTJq7PL
 hTbWcbdi6RcoFRQyV0VpLBA3C4syBJ6nCH64pPgZx9JHmmSUfpKjk56sNpNyXQCOMdLjwpD4s
 WKXeuBJJV7t5O81J5y8M7RRuGK6N3fh8T309o5iNckZ/4y7UMsTOF1QF5WDOF7W7adHhQuky6
 +iwYIk1pZrTy8aG3gUfpGqXV08eqUxuOXGXvqiSljAfDU9x/RPbqQ+dZSrihpKZaY6X1E/B9F
 p8+JZELZHcyk1Emvld8BvSk0WuTjsiJLzzeMGclWOqhR6y6lMOoPgz3HrzIli3xbJVfbEeYjj
 TKJIvHNVFxkEyi83UJ32k+UYPzLQJVrOzIhCXvB6jrOP49ugs8UA5e7TZR6wbUV1t3XLVVCHT
 JNVW/GKkgQgy7cKrZjpCQXRAeTl5UQ0sNh6Hf3mJ8LdQqm+PjW0H50+IcgUIIQ9Md31M1Ts6o
 sy1H2zgvEDK89XlwUh4EZWOHNc93Ju+OSv5EIqWDUbShT1GLsjYNhfxvR9l/qF+w8z+9LYpGJ
 79GbGGQFS+9bjmBW9owwzlL4u0ZHMndoQQCt0hDxXnBnUsFFFE6XPbKQGyZAp8Zm2P6nyJVVN
 w/D5fT0e/L7yruVvpMiARyErdYKL9TqWqQNhCj6nPgxfN7yy9ss5MxvBWxn0uHtk1X8wIH57P
 0gj8VDbnOhx74OqRw9pnjX0pV3hu31EYPyrvrWVmZ+aZTDwOSvOM9PMy4X2EyfMUd3u9gbpcP
 ETL7oW5pLcw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I noticed a problem how git log --graph represents orphaned trees, i.e.
how it renders a forest (and not just a single tree). If a repository
is comprised of multiple unconnected trees it can easily happen that
their commits are intertwined in the output of git log --graph so that
the root of one tree seems to be (re)based on a commit of the other
tree and there is no indication that they are indeed separate.

This first example shows the problem in the first indention level:

mkdir git-log-decorate-forest1
cd git-log-decorate-forest1
git init
git commit --allow-empty -m"Tree 1 - branch 1 - commit 1"
git branch tree1_branch1
git checkout --orphan tree2_branch1
git commit --allow-empty -m"Tree 2 - branch 1 - commit 1"
git log --decorate --graph --oneline --all

The log call at the end leads to something like this:

* 73c925a (tree1_branch1, master) Tree 1 - branch 1 - commit 1
* e22a694 (HEAD -> tree2_branch1) Tree 2 - branch 1 - commit 1

Note the asterisks in the beginning that usually indicates that the
commit sits "on top" of the previous one (in contrast to "|" used for
distinct branches). There is no way to tell from the output that the
two commits reside on different trees.

The second example shows that the problem also happens at deeper
indention levels if multiple branches are involved.
NB: the sleep is important due to git log's sorting (I did not try to
understand the details though).

mkdir git-log-decorate-forest2
cd git-log-decorate-forest2
git init
git commit --allow-empty -m"Tree 1 - branch 1 - commit 1"
git commit --allow-empty -m"Tree 1 - branch 1 - commit 2"
git branch tree1_branch1
git checkout --orphan tree2_branch1
git commit --allow-empty -m"Tree 2 - branch 1 - commit 1"
git checkout master
git reset --hard tree1_branch1^
git commit --allow-empty -m"Tree 1 - branch 2 - commit 2"
git branch tree1_branch2
git checkout tree2_branch1 
sleep 1
git commit --amend --no-edit --allow-empty
git checkout master
git commit --allow-empty -m"Tree 1 - branch 2 - commit 3"
git log --decorate --graph --oneline --all

The git log output looks something like this:
* ae86680 (HEAD -> master) Tree 1 - branch 2 - commit 3
* 844c8c3 (tree1_branch2) Tree 1 - branch 2 - commit 2
| * 8e6ed1e (tree2_branch1) Tree 2 - branch 1 - commit 1
| * 3fc176d (tree1_branch1) Tree 1 - branch 1 - commit 2
|/  
* 88b8313 Tree 1 - branch 1 - commit 1

Note how 8e6ed1e looks as if it sits on top of 3fc176d? But it doesn't.
It's an orphaned commit and thus part of a completely separated tree!

In gitk one has to enable the display of all branches but then the two
trees are distinguishable. gitg works fine (for once) as well.
The output of git-cola's DAG viewer is even worse than git log's
output: there (the commit of) the second tree is embedded in the master
branch between tree1_branch2 and the initial commit of tree 1 (88b8313)!

Here are the (outdated) versions of the tools tested:
git version 2.11.0
gitg 3.23.0
cola version 2.10

If the test cases above no longer work I can try to reproduce the
problem with git's HEAD if need be. I really hope I have not overlooked
any related bug reports or even a fix... the issue is a bit hard to
search for ;)

As a fix I guess it would make sense to have additional indention for
the distinct trees... just like how branches are indented but of course
without the |/ split below.

-- 
Kind regards/Mit freundlichen Grüßen, Stefan Tauner
