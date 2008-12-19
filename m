From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/4] Notes reloaded
Date: Sat, 20 Dec 2008 00:34:20 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812192347261.30769@pacific.mpi-cbg.de>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com> <20081216085108.GA3031@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Govind Salinas <govind@sophiasuchtig.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 20 00:27:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDol4-00051h-Mx
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 00:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbYLSX0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 18:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbYLSX0U
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 18:26:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:36202 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752048AbYLSX0T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 18:26:19 -0500
Received: (qmail invoked by alias); 19 Dec 2008 23:26:18 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp015) with SMTP; 20 Dec 2008 00:26:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+P9wsnwX2Pr1IOIr0a9X5vyhM+d0tXxRxNmmlF5C
	qQrzlWaO/n5Cr1
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20081216085108.GA3031@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103600>

Hi,

On Tue, 16 Dec 2008, Jeff King wrote:

>   Johannes Schindelin's notes proposal (which is more or less 
>   the current proposal, but I think the on-disk notes index was not 
>   well liked): 
>   http://thread.gmane.org/gmane.comp.version-control.git/52598

I redid the benchmark (this time with a bit beefier machine), just 
comparing no notes with David's/Peff's idea:


-- snip --
$ GIT_NOTES_TIMING_TESTS=1 sh t3302-notes-index-expensive.sh -i -v
Initialized empty Git repository in /home/gitte/git/t/trash directory.t3302-notes-index-expensive/.git/
* expecting success: create_repo 10
Initialized empty Git repository in /home/gitte/git/t/trash directory.t3302-notes-index-expensive/10/.git/
*   ok 1: setup 10

* expecting success: test_notes 10
*   ok 2: notes work

* expecting success: time_notes 100
no-notes
0.08user 0.10system 0:00.18elapsed 95%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+58926minor)pagefaults 0swaps
notes
0.14user 0.07system 0:00.54elapsed 38%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+60319minor)pagefaults 0swaps
*   ok 3: notes timing

* expecting success: create_repo 100
Initialized empty Git repository in /home/gitte/git/t/trash directory.t3302-notes-index-expensive/100/.git/
*   ok 1: setup 100

* expecting success: test_notes 100
*   ok 2: notes work

* expecting success: time_notes 100
no-notes
0.23user 0.21system 0:00.45elapsed 96%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+68043minor)pagefaults 0swaps
notes
0.38user 0.21system 0:00.59elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+78829minor)pagefaults 0swaps
*   ok 3: notes timing

* expecting success: create_repo 1000
Initialized empty Git repository in /home/gitte/git/t/trash directory.t3302-notes-index-expensive/1000/.git/
*   ok 1: setup 1000

* expecting success: test_notes 1000
*   ok 2: notes work

* expecting success: time_notes 100
no-notes
2.06user 0.95system 0:04.26elapsed 70%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+159115minor)pagefaults 0swaps
notes
2.83user 1.54system 0:04.38elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+267416minor)pagefaults 0swaps
*   ok 3: notes timing

* expecting success: create_repo 10000
Initialized empty Git repository in /home/gitte/git/t/trash directory.t3302-notes-index-expensive/10000/.git/
*   ok 1: setup 10000

* expecting success: test_notes 10000
*   ok 2: notes work

* expecting success: time_notes 100
no-notes
20.46user 7.63system 0:28.30elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+1083378minor)pagefaults 0swaps
notes
28.78user 13.74system 0:42.85elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+2240296minor)pagefaults 0swaps
*   ok 3: notes timing

* passed all 0 test(s)
-- snap --


Keep in mind that the tests run "git log" 99 times, and show the 
accumulated time.

So it seems that an increase of roughly 40% in the user time, and roughly 
70% in the system time is the price to have notes associated with every 
single commit.

Note that in that very same repository, a single "git show" goes from

0.00user 0.00system 0:00.00elapsed 0%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (0major+561minor)pagefaults 0swaps

to this:

0.03user 0.02system 0:00.04elapsed 113%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (0major+2294minor)pagefaults 0swaps

(In another run, it only used 90%CPU)

That's not too shabby, given that Git needs to unpack double the number of 
objects in this test when using notes vs. no notes.

For comparison, the numbers back then were something like 10% in user time 
with a penalty of an extraordinary magnitude everytime the notes are 
updated: around 800%.

Note: all these numbers are worst-case numbers, i.e. every commit has one 
note.

To be frank, I do not completely understand why the numbers are that high.  
I would have understood an increase roughly 4 seconds for reading the 
quite large tree 99 times, and then the same ~0.20 seconds back then.  
Maybe I made a huge mistake when implementing the thing.

And BTW, my code does not yet handle the case when 
refs/notes/commits:$commit is a tree instead of a blob.  That is left as 
an exercise to the reader.



Johannes Schindelin (4):
  Introduce commit notes
  Add a script to edit/inspect notes
  Speed up git notes lookup
  Add an expensive test for git-notes

 .gitignore                       |    1 +
 Documentation/config.txt         |   15 ++++
 Documentation/git-notes.txt      |   46 +++++++++++
 Makefile                         |    3 +
 cache.h                          |    3 +
 command-list.txt                 |    1 +
 commit.c                         |    1 +
 config.c                         |    5 +
 environment.c                    |    1 +
 git-notes.sh                     |   65 +++++++++++++++
 notes.c                          |  159 ++++++++++++++++++++++++++++++++++++++
 notes.h                          |    7 ++
 pretty.c                         |    5 +
 t/t3301-notes.sh                 |   65 +++++++++++++++
 t/t3302-notes-index-expensive.sh |   98 +++++++++++++++++++++++
 15 files changed, 475 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-notes.txt
 create mode 100755 git-notes.sh
 create mode 100644 notes.c
 create mode 100644 notes.h
 create mode 100755 t/t3301-notes.sh
 create mode 100755 t/t3302-notes-index-expensive.sh
