X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: [RFC] git-gui: A commit / fetch / push interface
Date: Tue, 7 Nov 2006 03:36:03 -0500
Message-ID: <20061107083603.GB9622@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 7 Nov 2006 08:36:25 +0000 (UTC)
Cc: paulus@samba.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31054>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhMRM-0004l4-05 for gcvg-git@gmane.org; Tue, 07 Nov
 2006 09:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754107AbWKGIgN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 03:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754118AbWKGIgM
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 03:36:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42450 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1754107AbWKGIgL
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 03:36:11 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GhMRC-0006Ms-DK; Tue, 07 Nov 2006 03:36:06 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 535DE20E487; Tue,  7 Nov 2006 03:36:04 -0500 (EST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Paul Mackerras originally started a thread about gitool, a graphical
interface for creating commits:

  http://thread.gmane.org/gmane.comp.version-control.git/26415

I liked it and wanted to start making it available to some folks I
work with who are more comfortable with the mouse than they are with
the keyboard.  At first I tried fixing a few of the outstanding bugs
in gitool but I eventually wound up rewriting the thing from scratch.

The git-gui interface looks pretty similar to the gitool interface
(thanks Paul for laying out a such good idea!).  In the top 1/3
of the window there are two panes listing the modified files; the
middle 1/3 shows the diff against HEAD; the bottom 1/3 is used to
edit the commit message.

Clicking on a file icon in the top 1/3 area will update the index
via an update-index call, thereby scheduling the file for commit.
Right now however you can't undo the update (on the TODO list).  :-)

Clicking on a file name will show the diff against HEAD, or a 3 way
diff against HEAD, index and working directory, or just the file's
contents (depending on state of the file).


Major improvements over Paul's original gitool are:

 * Amend the last commit.

 * Merge commits (no merge resolution assitance however).

 * Automatic loading of MERGE_MSG and SQUASH_MSG buffers.

 * Fetch and push available from with the GUI.

 * Start gitk on the current branch.

 * Some useful keyboard bindings (though probably could use more).

 * Proper menus and menubar.

 * Provides status feedback to the user.

 * Prevents the user from doing parallel operations that might
   also affect the current operation (well at least from within
   git-gui anyway).

 * Default geometry works properly on Windows.

 * Stays running if invoked as git-gui; exits immediately after
   commit if invoked as git-citool.

 * Tested on Cygwin/Windows 2000 and Mac OS X.

 * Never crashes with Tcl/Tk errors.

Ok so that last one might be reaching. :-) While trying to improve
gitool I noticed that gitool kept throwing Tcl/Tk errors at various
times.  I had a hard time tracking down most of them.  (This is
one of the reasons I just rewrote it.)  I have yet to break git-gui.

I have posted a repository with the source on pasky's service:

	http://repo.or.cz/w/git-gui.git


My goal is to have enough operations available through git-gui that
the average user won't need to leave it, unless he/she needs to do a
cherry-pick, am, etc. type of operation.  Or they want to browse the
history, in which case they can just start gitk from within git-gui.
I'm hoping to have most of it done this week.  :-)

Suggestions for improvement (or patches!) are most welcome.
Better naming suggestions are also welcome.  :)

-- 
