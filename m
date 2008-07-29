From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: [ANNOUNCE] GitStats development finished (WRT GSoC)
Date: Wed, 30 Jul 2008 00:11:48 +0200
Message-ID: <bd6139dc0807291511v2d70d549r3682291eb10a745d@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"David Symonds" <dsymonds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Sam Vilain" <sam@vilain.net>
To: "Git Mailinglist" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 00:12:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNxR5-0005XD-Vm
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 00:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540AbYG2WLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 18:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754054AbYG2WLv
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 18:11:51 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:45229 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194AbYG2WLu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 18:11:50 -0400
Received: by py-out-1112.google.com with SMTP id p76so67533pyb.10
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 15:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Vk+uD6CVuXc+7mbk41u/yluVeEEnADRkbFyNRPokv00=;
        b=x7u7UOONKsXbWINmPAK6NvZDnEjiYqeYqPRBZWSjbMyt2BGt50b2CygG/u7tR2ghlA
         S/hOqEOoMGiz1K3OB5VlJOBoEgsWff3tBOulfkoDH/M1Cj5bMZpkx37z6A0y4vLB9nMz
         GteHSKFW/aMTFvTpOTOQB51lgwnYV1HRuGSUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition;
        b=l1wkFou7IhhzPB4WNjnAawQvC3uSUyoiaSKNGY82xSXmT2nn6UJpvI/r/mXbZSMyrb
         Wy+QE3whoQfCOdU61u3gCFGsHNSxq1hRNvsSocU0IEVMw2e/+oWoKSkvLPsX9hzzZ9UV
         RZDEBeBivqgMSw54QFjZcaNM6dmNhqhtLw3Qs=
Received: by 10.142.51.4 with SMTP id y4mr2362316wfy.57.1217369508653;
        Tue, 29 Jul 2008 15:11:48 -0700 (PDT)
Received: by 10.142.104.10 with HTTP; Tue, 29 Jul 2008 15:11:48 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90691>

Heya,

I leave to the USA this Friday, and because of US tax laws I would
have to pay an insane amount of tax for just 2 weeks of development. I
have agreed with my mentor a while a go that I would finish up GSoC
before I left, that way avoiding having to pay US taxes. (Over here in
the Netherlands I don't have to pay tax over the $4500 because I
didn't make >6000 euro this year, the joys of being a student.) As a
result it is quite clear what GitStats will look like at the end of my
GSoC. I am going to continue working on it though, I am especially
interested in getting the '--follow' part of 'git log' working in such
a way that it can be incorporated into GitStats. As such, here is a
summary of what GitStat is at the moment. From the documentation:

$ cat gitstats-*
syntax: stats.py author <options>

The purpose of the author module is to gather statistics
about authors, and to aggregate this information to provide
information about all the authors of a repo.

Currently the available metrics in the author module are
the following:
* Determine how many changes an author made (making a
  distinction between lines added and lines deleted), and
  record this per author, for all files in the repository.
  It is possible to get this data for one specific author,
  (although data for all authors will still be gathered,)
  because the result is stored per author.

* Determine how many commits an author made that affected
  a specific file. This metric is less granular, but a lot
  faster. To retreive the more granular result, one could
  simply iterate over the result of the above metric for
  each author, and take only the data for the file one is
  interested in.

* Aggregate the information from the first metric, adding
  up the statistics from each author. This provides a more
  general 'file activity' metric and is a nice example of
  how an existing metric can be modified to do something
  seemingly unrelated.

This module does not define any auxillery functions.

syntax: stats.py branch <options>

The purpose of the branch module is to gather statistics
about branches, or related to branches.

Currently the available metrics in the branch module are
the following:
* Which of the branch head does a commit belong to
  What this metric does is walk down the ancestry of the
  target commit and increase the 'dilution' by one or each
  merge it finds. The exception applies that when following
  the 'primary' parent of the merge (e.g., the branch
  recorded as the one the merge commit was made on), the
  dilution is not increased. As such, if the target commit
  is made on a branch, and then later on it's dilution
  is calculated, it will have 0 dilution for that branch.
  The branch with the lowest dilution is deemed to be the
  branch that the commit belongs to most.
  Note: In git there is no 'main' branch, as such any and
  all branches branches that 'branched off' after the
  target commit will also have dilution 0.

It also defines the following auxillery functions:
* Retreive the name of a commit if it is a the head of a
  branch. This can be seen as the reverse of 'rev-parse'
  for branch heads. This is used internally to provide the
  user with a sensible name when telling them which branch
  a commit belongs to.

* List all the branches that contain a specific commit,
  optionally searching through remote branches as well as
  optionally not filtering at all. This is used internally
  to not search through branches that do not contain the
  target commit.

syntax: stats.py bug <options>

The purpose of the bug module is to gather statistics on
bugfixes within the content, and to aggregate this
information to provide with a report of the last N commits.

Currently the available metrics in the bug module are the
following:
* Determine whether a specific commit is a bugfix based on
  other metrics. When one of the metrics is 'positive',
  that is, it's return value indicates that the examined
  commit is a bugfix, the 'bugfix rating' is increased by
  a pre-configured amount. This amount can be specified per
  metric, and can be set to '0' to ignore it.

* Aggregate the above metric over the past N commits. Also,
  when running the above metric on more than one commit,
  cache the result of calls to the git binary so that the
  execution time is reduced. This means that the execution
  time is not directly proportional to the size of the
  repository. (Instead, there is a fixed 'start up' cost,
  after which there is a 'per commit' cost, which is
  relatively low.)

This module does not define any auxillery functions.

syntax: stats.py commit <options>

The purpose of the commit module is to gather statistics
about commits, or related to commits, with the exception
of things related to diffs (only retrieving the raw diff is
in this module).

Currently the available metrics in the author module are
the following:
* Find all the commits that touched the same paths as the
  specified commit. This is implemented by passing the
  result of the 'paths touched' auxillary function to the
  'commits that touched' auxillary function. See below.

* Retrieve the diff of a commit, either with or without
  context, and optionally ignoring whitespace changes. This
  method also works for the root commit (by making use of
  the '--root' option to 'diff tree'.

* Show only commits of which the commit message, and/or the
  commit diff, match a specific regexp.  This is a simple
  reimplementation of 'git log -S' and 'git log --grep'. It
  is preferable to instead use the options native to
  'git log', than to use this slower version.
  Note: the regexps for the 'commit message' and the
  'commit diff' may be different.

It also defines the following auxillary functions:
* Print a commit in a 'readable' way, this is by default
  'git log -1 --name-only'. By the way of an environmental
  variable ('GIT_STATS_PRETTY_PRINT'), it can be made to
  instead use 'git log -1 --prety=oneline' by setting the
  variable to 'online'.

* Retrieve all the paths that a specific commit touches,
  this is used internally to limit the commits that have
  to be searched when looking for a merge. That is done by
  passing the output of this method to the one described
  below.

* Find all commits that touched a list of files, optionally
  treating the paths as relative to the current working
  directory.

syntax: stats.py diff <options>

The purpose of the diff module is to gather statistics
about diffs, or related to diffs.

Currently the available metrics in the diff module are the
following:
* Determine whether two commit diffs are equal, optionally
  checking whether they are reverts instead. It is also
  possible to just look at what lines were changed (and
  ignore the actual changes).

* Find all commits that are reverted by the specified
  commit by first retrieving the touched files, and then
  examining all the commits that that touch the same files.

It also defines the following auxillery functions:
* Parse a raw commit diff and store it on a hunk-by-hunk
  basis so that later on it can be examined more carefully
  by other tools. Line numbers are optionally included so
  that one can use those. For example, by comparing all the
  added hunks with the deleted hunks of a second commit,
  and vise versa, one can check for (partial) reverts.

syntax: stats.py index <options>

The purpose of the index module is to gather statistics
about the index, or related to the index.

Currently the available metrics in the index module are the
following:
* List all the commits that touch the same files as the
  staged files. This can be useful to find out which commit
  introduced the bug fixed in this commit (by piping the
  output of this method to one that looks at which lines
  were touched for example).

It also defines the following auxillery functions:
* Get all the staged changes (optionally ignoring newly
  added files). This is used internally to find all the
  commits that touched the same files as those that are
  currently staged.

syntax: stats.py matcher <options>

The purpose of the matcher module is to compare hunks
within one diff to one another, and determine whether there
is any code being moved around.

Currently the available metrics in the index module are the
following:
* Try to find a match between the hunks in one diff, so
  that code moves can be detected. This makes use of the
  'diff size calculation' described below.

It also defines the following auxillery functions:
* Calculate the size of a diff, only counting the amount
  of lines added, and the amount of lines deleted. This can
  be used to determine a best 'interdiff' (the shortest one
  is the best one), when searching for two hunks that are
  moved around.

syntax: stats.py <subcommand> <arguments>

Available commands:
  author  Activity for one author, file, or project
  branch  In how far a commit belongs to a branch
  bug     Determine whether a commitis a bugfix
  commit  Basic functionality already present in git
  diff    Compare two diffs and find reverts
  index   Find which commits touched the staged files
  matcher Try to match hunks in a diff to find moves
  test    Run the unittests for GitStats

The stats.py module is the main entry point of GitStats,
it dispatches to the commands listed above. When no
arguments are passed, it automatically runs the command
with '--help' so that a usage message is shown for that
command.

Each of the modules it uses as subcommands defines a
'dispatch' function that is called with the users arguments
(with the exception of the first, which is the name of the
command executed). If anything should be returned to the
system, the dispatch method should return this value.

To run properly it requires the git_stats package to be
a subdirectory of the directory it resides in. That is,
your directory tree should be something like this:
.
|-- git_stats
|   `-- <listing of all installed modules>
|-- scripts
|   `-- <listing of all installed scripts>
|-- t
|   `-- <listing of all installed regression tests>
`-- stats.py

syntax: stats.py tests <options>

The purpose of the tests module is to make available the
unittests for GitStats to external programs. It may be
used to run the unittests for GitStats from for example
a shell script. It's output is made to match the git
regression test suite.

-- 
Cheers,

Sverre Rabbelier
