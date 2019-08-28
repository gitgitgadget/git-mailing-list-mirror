Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C38991F461
	for <e@80x24.org>; Wed, 28 Aug 2019 00:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfH1AWS (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 20:22:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46725 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfH1AWS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 20:22:18 -0400
Received: by mail-pl1-f196.google.com with SMTP id o3so112515plb.13
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 17:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=46YE9IEkP51/gQTPmSIkrBhh9InNneglVpnpxJFC/Ak=;
        b=o018MB6qM3uXn4YbLKhQd5VxM1fWbY4KsJ4AI8jhC5T7S/PAoz/sWMPuDvgSppfzOq
         DoW1MYGxVkTOMfMIj4x5drnsJhoRfmon5LlL6tgeAIzA9K1e289BpI+2x2LVcWfsXzbs
         qXejzcAGSUGO2rpZE8NVfhWrJG4yV5f3H3pgari62LbEDMhoKB43ddiataih4F8ykA7U
         F85+lDsqr21Seh5GNybt06K/C8lNBD2rAkRJZ6hRK00CO5QfyPpCqdPwz7HcBQPnFdZ3
         FQ2mE7YH7P6A0zDLuCiJ9bR5azwytVwq3XcEui12DYr/JEnUyCVl9/etByZx6FNma4Wh
         quhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=46YE9IEkP51/gQTPmSIkrBhh9InNneglVpnpxJFC/Ak=;
        b=JGA7cHFKQd4b31Z/Lxsl+Vi5FKbiULANeAU6p/z9VlWqba/ewJUCT1+NFxCTRcovnx
         y9GpFI+HOCq1lIiaPSV4yiTG+t/qxClNAiamjvpgWZhjbpGHuZC9GocDn2cadkDtiXjD
         0W223S5fOF5EmdWJy2g64k9t2aE3a+nyYHxfvb1U0xc9OeJIuEy5q/NdQIqh7VMVqzuz
         wzv8lXrLw2gnnApLlgbX3aVpQoxQXKu6AytNz9vAn0TFzvMyzHy38hPWDLhbtV5w7ADW
         sr8jBBli63e3Z9Nx6JyNaHxrtq/rTWFS0+pk2urAa9Tt7Ye26oEnQDVbJrmGcFvJJ70K
         tehw==
X-Gm-Message-State: APjAAAXz9Lfg/DTlpZxQexeC0ZqTZbJIVxoXzvFsXG+wMK+OIAAKR9z/
        MdHngqu6R6Ve06B0dCfigcO3Zo5c
X-Google-Smtp-Source: APXvYqwcb8BwtWPWZ61B3doDdmF16bYUvVqg8FEkASGdCD999h7+E8i3TgcZ2WEr8YNJoB0VmgZPEw==
X-Received: by 2002:a17:902:f204:: with SMTP id gn4mr1589464plb.23.1566951737291;
        Tue, 27 Aug 2019 17:22:17 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id h17sm495682pfo.24.2019.08.27.17.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Aug 2019 17:22:16 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 0/4] Warn about git-filter-branch usage and avoid it
Date:   Tue, 27 Aug 2019 17:22:06 -0700
Message-Id: <20190828002210.8862-1-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.38.gfc6987be7e
In-Reply-To: <20190826235226.15386-1-newren@gmail.com>
References: <20190826235226.15386-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a series that shifts the focus slightly to warning about
git-filter-branch usage and avoiding it ourselves.  I have retained
patch 4 but left it marked as RFC for further discussion.  It appears
that folks generally seem to agree the first three patches are good
to include now -- assuming my small fixes correctly address their
requests and suggestions.

Changes since v1 (full range-diff below):
  * I might have had a little fun with a thesaurus (just trying to give
    reviewers something small to smile about...)
  * addressed feedback from Eric and Stolee, as detailed below
  * [Patch 2] factored out some common code
  * [Patch 3] fixed links in asciidoc documentation to make them more
    readable in both manpages and html format
  * [Patch 3] added a warning blurb to git-filter-branch itself

In particular, it'd be helpful if people could take a look at the changes
to git-filter-branch.sh in patch 3 and comment on whether an environment
variable is fine or if we should make it a config setting or something.

Elijah Newren (4):
  t6006: simplify and optimize empty message test
  t3427: accelerate this test by using fast-export and fast-import
  Recommend git-filter-repo instead of git-filter-branch
  [RFC] Remove git-filter-branch, it is now external to git.git

 .gitignore                          |   1 -
 Documentation/git-fast-export.txt   |   6 +-
 Documentation/git-filter-branch.txt | 481 --------------------
 Documentation/git-gc.txt            |  17 +-
 Documentation/git-rebase.txt        |   2 +-
 Documentation/git-replace.txt       |  10 +-
 Documentation/git-svn.txt           |   4 +-
 Documentation/githooks.txt          |   7 +-
 Makefile                            |   1 -
 command-list.txt                    |   1 -
 contrib/svn-fe/svn-fe.txt           |   4 +-
 git-filter-branch.sh                | 662 ----------------------------
 t/perf/p7000-filter-branch.sh       |  24 -
 t/t3427-rebase-subtree.sh           |  22 +-
 t/t6006-rev-list-format.sh          |   5 +-
 t/t7003-filter-branch.sh            | 505 ---------------------
 t/t7009-filter-branch-null-sha1.sh  |  55 ---
 t/t9902-completion.sh               |  12 +-
 18 files changed, 47 insertions(+), 1772 deletions(-)
 delete mode 100644 Documentation/git-filter-branch.txt
 delete mode 100755 git-filter-branch.sh
 delete mode 100755 t/perf/p7000-filter-branch.sh
 delete mode 100755 t/t7003-filter-branch.sh
 delete mode 100755 t/t7009-filter-branch-null-sha1.sh

Range-diff:
1:  7ddbeea2ca = 1:  7ddbeea2ca t6006: simplify and optimize empty message test
2:  0172ca771e < -:  ---------- t3427: accelerate this test by using fast-export and fast-import
3:  b814cc7b65 < -:  ---------- git-sh-i18n: work with external scripts
-:  ---------- > 2:  f18bd7a609 t3427: accelerate this test by using fast-export and fast-import
4:  dcec36d113 ! 3:  7008c16984 Recommend git-filter-repo instead of git-filter-branch in documentation
    @@ Metadata
     Author: Elijah Newren <newren@gmail.com>
     
      ## Commit message ##
    -    Recommend git-filter-repo instead of git-filter-branch in documentation
    +    Recommend git-filter-repo instead of git-filter-branch
     
    -    filter-branch suffers from a huge number of pitfalls that can result in
    -    incorrectly rewritten history, and many of the problems can easily go
    -    undetected until the new repository is in use.  This can result in
    -    problems ranging from an even messier history than what led folks to
    -    filter-branch in the first place, to data loss or corruption.  These
    -    issues cannot be backward compatibly fixed, so add a warning to the
    -    filter-branch manpage about this and recommand that another tool (such
    -    as filter-repo) be used instead.
    +    filter-branch suffers from a deluge of disguised dangers that disfigure
    +    history rewrites (i.e. deviate from the deliberate changes).  Many of
    +    these problems are unobtrusive and can easily go undiscovered until the
    +    new repository is in use.  This can result in problems ranging from an
    +    even messier history than what led folks to filter-branch in the first
    +    place, to data loss or corruption.  These issues cannot be backward
    +    compatibly fixed, so add a warning to both filter-branch and its manpage
    +    recommending that another tool (such as filter-repo) be used instead.
     
         Also, update other manpages that referenced filter-branch.  Several of
         these needed updates even if we could continue recommending
    @@ Documentation/git-filter-branch.txt: SYNOPSIS
      
     +WARNING
     +-------
    -+'git filter-branch' has a litany of gotchas that can and will cause
    -+history to be rewritten incorrectly (in addition to abysmal
    -+performance).  These issues cannot be backward compatibly fixed and as
    -+such, its use is not recommended.  Please use an alternative history
    -+filtering tool such as 'git filter-repo'.  If you still need to use
    -+'git filter-branch', please carefully read the "Safety" section of
    -+https://public-inbox.org/git/CABPp-BEDOH-row-hxY4u_cP30ptqOpcCvPibwyZ2wBu142qUbA@mail.gmail.com/
    -+and avoid as many of the pitfalls listed there as reasonably possible.
    ++'git filter-branch' has a plethora of pitfalls that can produce non-obvious
    ++manglings of the intended history rewrite (and can leave you with little
    ++time to investigate such problems since it has such abysmal performance).
    ++These safety and performance issues cannot be backward compatibly fixed and
    ++as such, its use is not recommended.  Please use an alternative history
    ++filtering tool such as https://github.com/newren/git-filter-repo/[git
    ++filter-repo].  If you still need to use 'git filter-branch', please
    ++carefully read the "Safety" section of the message on the Git mailing list
    ++https://public-inbox.org/git/CABPp-BEDOH-row-hxY4u_cP30ptqOpcCvPibwyZ2wBu142qUbA@mail.gmail.com/[detailing
    ++the land mines of filter-branch] and vigilantly avoid as many of the
    ++hazards listed there as reasonably possible.
     +
      DESCRIPTION
      -----------
    @@ contrib/svn-fe/svn-fe.txt: The exit status does not reflect whether an error was
     -git-svn(1), svn2git(1), svk(1), git-filter-branch(1), git-fast-import(1),
     +git-svn(1), svn2git(1), svk(1), git-filter-repo(1), git-fast-import(1),
      https://svn.apache.org/repos/asf/subversion/trunk/notes/dump-load-format.txt
    +
    + ## git-filter-branch.sh (mode change 100755 => 100644) ##
    +@@ git-filter-branch.sh: set_ident () {
    + 	finish_ident COMMITTER
    + }
    + 
    ++if [ -z "$FILTER_BRANCH_SQUELCH_WARNING" -a \
    ++     -z "$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS" ]; then
    ++	cat <<EOF
    ++WARNING: git-filter-branch has a glut of gotchas generating mangled history
    ++         rewrites.  Please use an alternative filtering tool such as 'git
    ++         filter-repo' (https://github.com/newren/git-filter-repo/) instead.
    ++         See the filter-branch manual page for more details; to squelch
    ++         this warning and pause, set FILTER_BRANCH_SQUELCH_WARNING=1.
    ++
    ++EOF
    ++	sleep 5
    ++fi
    ++
    + USAGE="[--setup <command>] [--subdirectory-filter <directory>] [--env-filter <command>]
    + 	[--tree-filter <command>] [--index-filter <command>]
    + 	[--parent-filter <command>] [--msg-filter <command>]
5:  9dec8e06ee ! 4:  ff3e04e558 Remove git-filter-branch, it is now external to git.git
    @@ Metadata
      ## Commit message ##
         Remove git-filter-branch, it is now external to git.git
     
    +    git-filter-branch still exists, still has the same regression tests,
    +    etc., but it is now being tracked in a separate repo that users will
    +    need to download separately.
    +
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
      ## .gitignore ##
    @@ Documentation/git-filter-branch.txt (deleted)
     -
     -WARNING
     --------
    --'git filter-branch' has a litany of gotchas that can and will cause
    --history to be rewritten incorrectly (in addition to abysmal
    --performance).  These issues cannot be backward compatibly fixed and as
    --such, its use is not recommended.  Please use an alternative history
    --filtering tool such as 'git filter-repo'.  If you still need to use
    --'git filter-branch', please carefully read the "Safety" section of
    --https://public-inbox.org/git/CABPp-BEDOH-row-hxY4u_cP30ptqOpcCvPibwyZ2wBu142qUbA@mail.gmail.com/
    --and avoid as many of the pitfalls listed there as reasonably possible.
    +-'git filter-branch' has a plethora of pitfalls that can produce non-obvious
    +-manglings of the intended history rewrite (and can leave you with little
    +-time to investigate such problems since it has such abysmal performance).
    +-These safety and performance issues cannot be backward compatibly fixed and
    +-as such, its use is not recommended.  Please use an alternative history
    +-filtering tool such as https://github.com/newren/git-filter-repo/[git
    +-filter-repo].  If you still need to use 'git filter-branch', please
    +-carefully read the "Safety" section of the message on the Git mailing list
    +-https://public-inbox.org/git/CABPp-BEDOH-row-hxY4u_cP30ptqOpcCvPibwyZ2wBu142qUbA@mail.gmail.com/[detailing
    +-the land mines of filter-branch] and vigilantly avoid as many of the
    +-hazards listed there as reasonably possible.
     -
     -DESCRIPTION
     ------------
    @@ git-filter-branch.sh (deleted)
     -	finish_ident COMMITTER
     -}
     -
    +-if [ -z "$FILTER_BRANCH_SQUELCH_WARNING" -a \
    +-     -z "$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS" ]; then
    +-	cat <<EOF
    +-WARNING: git-filter-branch has a glut of gotchas generating mangled history
    +-         rewrites.  Please use an alternative filtering tool such as 'git
    +-         filter-repo' (https://github.com/newren/git-filter-repo/) instead.
    +-         See the filter-branch manual page for more details; to squelch
    +-         this warning and pause, set FILTER_BRANCH_SQUELCH_WARNING=1.
    +-
    +-EOF
    +-	sleep 5
    +-fi
    +-
     -USAGE="[--setup <command>] [--subdirectory-filter <directory>] [--env-filter <command>]
     -	[--tree-filter <command>] [--index-filter <command>]
     -	[--parent-filter <command>] [--msg-filter <command>]
-- 
2.23.0.3.gcc10030edf.dirty

