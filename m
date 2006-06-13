From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 0/13] git-svn: better branch support, SVN:: lib usage, feature additions
Date: Tue, 13 Jun 2006 11:02:02 -0700
Message-ID: <11502217352245-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jun 13 20:02:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqDDZ-0004ny-UQ
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 20:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWFMSCS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 14:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWFMSCS
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 14:02:18 -0400
Received: from hand.yhbt.net ([66.150.188.102]:42949 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751085AbWFMSCR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 14:02:17 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id F40A97DC005;
	Tue, 13 Jun 2006 11:02:15 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 13 Jun 2006 11:02:15 -0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21788>

Most of these patches rely on the last series of patches I posted
        (<11500094252972-git-send-email-normalperson@yhbt.net>).

[PATCH 1/13] git-svn: support -C<num> passing to git-diff-tree
[PATCH 2/13] git-svn: --branch-all-refs / -B support
[PATCH 3/13] git-svn: optimize --branch and --branch-all-ref
[PATCH 4/13] git-svn: support manually placed initial trees from fetch
        These have been around since April or so, but I kept forgetting
        about them since they were on a machine I rarely use.
        All low impact changes.

[PATCH 5/13] git-svn: Move all git-svn-related paths into $GIT_DIR/svn
        Compatibility with 1.0.0 is broken here, in preparation for later
        changes and stuff.

[PATCH 6/13] git-svn: minor cleanups, extra error-checking

[PATCH 7/13] git-svn: add --repack and --repack-flags= options
[PATCH 8/13] git-svn: add --shared and --template= options to pass to init-db
        Simple, low-impact changes.

[PATCH 9/13] git-svn: add some functionality to better support branches in svn
        Three new commands, graft-branches being the most interesting.
        Large patches, but low impact.

[PATCH 10/13] git-svn: add UTF-8 message test
        Low impact change.

[PATCH 11/13] git-svn: add 'log' command, a facsimile of basic `svn log'
        A simple convenience command.  This should help ease communication
        between git-svn and SVN users.  Large patch but low impact.


These last two are very high impact changes.  Some bugs were noticed
and fixed, but more may have been introduced.

[PATCH 12/13] git-svn: add support for Perl SVN::* libraries
        We're faster, much faster in the common case.  Some hacks to get
        around memory leaks, but we're faster, and that matters to
        people.  There's a huge disk space reduction, too, since we
        don't have to keep working copies around.  Of course, this is
        optional, command-line svn will continue to be supported.

[PATCH 13/13] git-svn: make the $GIT_DIR/svn/*/revs directory obsolete
        Now that we're faster, we can import 100k revisions in a finite
        amount of time.  Which means lots of 41-byte files in one
        directory: gross.  Huge disk space reduction for large
        histories.

-- 
Eric Wong
