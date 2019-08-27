Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CBC31F461
	for <e@80x24.org>; Tue, 27 Aug 2019 01:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfH0B3s (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 21:29:48 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40699 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726257AbfH0B3s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 21:29:48 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7R1ThUO028338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 21:29:43 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E6AD042049E; Mon, 26 Aug 2019 21:29:42 -0400 (EDT)
Date:   Mon, 26 Aug 2019 21:29:42 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Missing file in 2.23 (p5302-pack-index.subtests)?
Message-ID: <20190827012942.GD28066@mit.edu>
References: <20190818160317.GA13772@mit.edu>
 <20190826205012.GB27762@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826205012.GB27762@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 04:50:13PM -0400, Jeff King wrote:
> On Sun, Aug 18, 2019 at 12:03:17PM -0400, Theodore Y. Ts'o wrote:
> 
> > I was trying to run "make profile" on the master branch (commit
> > 5fa0f5238b: "Git 2.23") and it died in the
> > 
> > 	$(MAKE) PROFILE=GEN perf
> > 
> > dies with:
> > 
> > 	cannot open test-results/p5302-pack-index.subtests: No such file or directory at ./aggregate.perl line 153.
> > 
> > I presume that's becuase the file t/perf/test-results/p5302-pack-index.subtests is missing?
> 
> That file should be created by running p5302. If you do:
> 
>   cd t/perf
>   rm -rf test-results
>   ./run p5302-pack-index.sh
> 
> is it generated?

No, it wasn't.  See below....

					- Ted

<tytso@lambda> {/usr/projects/git/git-core/t/perf}   (master)
1140% git show
commit 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9 (HEAD -> master, tag: v2.23.0, origin/master, origin/HEAD)
Author: Junio C Hamano <gitster@pobox.com>
Date:   Fri Aug 16 10:28:23 2019 -0700

    Git 2.23
    
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 551e607e73..a1539a7ce6 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 GVF=GIT-VERSION-FILE
-DEF_VER=v2.23.0-rc2
+DEF_VER=v2.23.0
 
 LF='
 '
<tytso@lambda> {/usr/projects/git/git-core/t/perf}   (master)
1141% rm -rf test-results ; ./run p5302-pack-index.sh
=== Running 1 tests in this tree ===
warning: $GIT_PERF_LARGE_REPO is $GIT_BUILD_DIR.
warning: This will work, but may not be a sufficiently large repo
warning: for representative measurements.
not ok 1 - repack
#	
#		git repack -ad &&
#		PACK=$(ls .git/objects/pack/*.pack | head -n1) &&
#		test -f "$PACK" &&
#		export PACK
#	
cannot open test-results/p5302-pack-index.subtests: No such file or directory at ./aggregate.perl line 153.
<tytso@lambda> {/usr/projects/git/git-core/t/perf}   (master)
1142% git status
On branch master
Your branch is up to date with 'origin/master'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	../../MAKELOG
	../../MAKELOG.1
	../../common-cmds.h
	../../git-lost-found
	../../git-peek-remote
	../../git-rebase--am
	../../git-rebase--common
	../../git-rebase--helper
	../../git-rebase--interactive
	../../git-rebase--merge
	../../git-relink
	../../git-remote-testgit
	../../git-repo-config
	../../git-tar-tree
	../../git_remote_helpers/
	../../perl/MYMETA.json
	../../perl/MYMETA.yml
	../../perl/PM.stamp
	../../perl/blib/
	../../perl/perl.mak
	../../perl/pm_to_blib
	../../test-chmtime
	../../test-config
	../../test-credential
	../../test-ctype
	../../test-date
	../../test-delta
	../../test-dump-cache-tree
	../../test-dump-split-index
	../../test-dump-untracked-cache
	../../test-fake-ssh
	../../test-genrandom
	../../test-hashmap
	../../test-index-version
	../../test-line-buffer
	../../test-match-trees
	../../test-mergesort
	../../test-mktemp
	../../test-obj-pool
	../../test-parse-options
	../../test-path-utils
	../../test-prio-queue
	../../test-read-cache
	../../test-regex
	../../test-revision-walking
	../../test-run-command
	../../test-scrap-cache-tree
	../../test-sha1
	../../test-sha1-array
	../../test-sigchain
	../../test-string-list
	../../test-string-pool
	../../test-submodule-config
	../../test-subprocess
	../../test-svn-fe
	../../test-treap
	../../test-urlmatch-normalization
	../../test-wildmatch

nothing added to commit but untracked files present (use "git add" to track)
