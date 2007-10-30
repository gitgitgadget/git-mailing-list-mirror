From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/4] Build in some more things
Date: Mon, 29 Oct 2007 21:05:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710292049450.7357@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Oct 30 02:05:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImfYE-0002bs-Uo
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 02:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbXJ3BFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 21:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752100AbXJ3BFh
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 21:05:37 -0400
Received: from iabervon.org ([66.92.72.58]:39152 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752043AbXJ3BFg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 21:05:36 -0400
Received: (qmail 32649 invoked by uid 1000); 30 Oct 2007 01:05:35 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Oct 2007 01:05:35 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62638>

The main effect of this series is removing the fork/exec from pushing via 
the git protocol (aside from the later fork/exec in connect.c of course).

It also heads off some tempting transport-related fetch bugs, which I will 
not introduce in a later patch.

* Miscellaneous const changes and utilities
  Adds two small utility functions, and marks a bunch of stuff as const; 
  the const stuff is to keep builtin-fetch from getting messed up without 
  a warning, because it wants some lists not to change.

* Build-in peek-remote, using transport infrastructure.
* Build-in send-pack, with an API for other programs to call.
* Use built-in send-pack.

 Makefile                               |    4 ++-
 builtin-fetch.c                        |   10 +++---
 peek-remote.c => builtin-peek-remote.c |   55 +++++++++++++---------------
 send-pack.c => builtin-send-pack.c     |   46 ++++++++++++++++--------
 builtin.h                              |    2 +
 cache.h                                |    2 +-
 connect.c                              |   10 +++++-
 git.c                                  |    2 +
 http-push.c                            |    2 +-
 remote.c                               |   32 +++++++++++-----
 remote.h                               |   10 ++++--
 send-pack.h                            |   18 +++++++++
 transport.c                            |   63 +++++++++-----------------------
 transport.h                            |    6 ++--
 14 files changed, 146 insertions(+), 116 deletions(-)

	-Daniel
*This .sig left intentionally blank*
