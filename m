From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/6] Builtin remote, v2
Date: Sat, 1 Mar 2008 13:14:39 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803011313020.22527@racer.site>
References: <alpine.LSU.1.00.0802290144130.22527@racer.site> <alpine.LSU.1.00.0802290144410.22527@racer.site> <7vprugfrgw.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802290214150.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 14:15:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVRZG-00073a-92
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 14:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821AbYCANPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 08:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755799AbYCANPW
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 08:15:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:45636 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755735AbYCANPV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 08:15:21 -0500
Received: (qmail invoked by alias); 01 Mar 2008 13:15:18 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp023) with SMTP; 01 Mar 2008 14:15:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX199DoVRfYB9svQesgVqhA66f7VSfO8GA3Bv8lqNun
	T2m/9u2oXVE0Hs
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0802290214150.22527@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75665>


(Yes, I know, it is not v2, but I lost track...)

The only change is that path_list was renamed to string_list.  This is the
first patch, and pretty intrusive (even if the changes are all straight
forward...).

On Fri, 29 Feb 2008, Johannes Schindelin wrote:

> On Thu, 28 Feb 2008, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > This is probably useful to a number of existing non-users of 
> > > path_list.
> > 
> > I suspect most of the non-users will stay non-users, until the thing 
> > is renamed to something more sensible.
> > 
> > The wholesale renaming, if we were to do so, should happen when things 
> > are quiet, and this is probably not a good time for it.
> 
> Right.  Will try to think of a patch when the right time has come.  Just 
> to make sure: "string_list"?

Just in case, I did it.  I have no problems resending it later, too, just 
wanted to let you know that I have the patches ready.

Johannes Schindelin (6):
      Rename path_list to string_list
      string-list: add functions to work with unsorted lists
      parseopt: add flag to stop on first non option
      Test "git remote show" and "git remote prune"
      Make git-remote a builtin
      builtin-remote: prune remotes correctly that were added with --mirror

 Documentation/CodingGuidelines            |    5 +-
 Documentation/technical/api-path-list.txt |    4 +-
 Makefile                                  |    7 +-
 builtin-blame.c                           |    4 +-
 builtin-commit.c                          |   20 +-
 builtin-fast-export.c                     |   14 +-
 builtin-fetch.c                           |   16 +-
 builtin-mailsplit.c                       |   12 +-
 builtin-merge-recursive.c                 |   96 +++---
 builtin-mv.c                              |   39 +-
 builtin-remote.c                          |  558 +++++++++++++++++++++++++++++
 builtin-rerere.c                          |   48 ++--
 builtin-shortlog.c                        |   42 ++--
 builtin-show-ref.c                        |   10 +-
 builtin.h                                 |    1 +
 contrib/examples/git-remote.perl          |  477 ++++++++++++++++++++++++
 diff-lib.c                                |   22 +-
 git-remote.perl                           |  477 ------------------------
 git.c                                     |    1 +
 mailmap.c                                 |   12 +-
 mailmap.h                                 |    4 +-
 parse-options.c                           |    2 +
 parse-options.h                           |    1 +
 path-list.c                               |  104 ------
 path-list.h                               |   22 --
 reflog-walk.c                             |   10 +-
 remote.c                                  |    3 +-
 remote.h                                  |    1 +
 shortlog.h                                |    6 +-
 string-list.c                             |  134 +++++++
 string-list.h                             |   28 ++
 t/t5505-remote.sh                         |   50 +++
 32 files changed, 1442 insertions(+), 788 deletions(-)
 create mode 100644 builtin-remote.c
 create mode 100755 contrib/examples/git-remote.perl
 delete mode 100755 git-remote.perl
 delete mode 100644 path-list.c
 delete mode 100644 path-list.h
 create mode 100644 string-list.c
 create mode 100644 string-list.h

