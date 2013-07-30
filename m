From: John Keeping <john@keeping.me.uk>
Subject: ANNOUNCE: git-integration -- Easily manage integration branches
Date: Tue, 30 Jul 2013 16:46:20 +0100
Message-ID: <20130730154620.GN2337@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 30 17:46:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4C86-0004IJ-OL
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 17:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926Ab3G3Pq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 11:46:26 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:54071 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab3G3PqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 11:46:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 31569CDA5E2
	for <git@vger.kernel.org>; Tue, 30 Jul 2013 16:46:25 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FlWigGS4W3tZ for <git@vger.kernel.org>;
	Tue, 30 Jul 2013 16:46:24 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 2325CCDA5A8
	for <git@vger.kernel.org>; Tue, 30 Jul 2013 16:46:22 +0100 (BST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231369>

I wrote this script a few months ago and have been using it pretty much
daily since then, so I figure it's time to see if anyone else finds it
useful...

git-integration [1] is a script to help manage integration branches in
Git.  By defining a base point and a set of branches to be merged to
form the integration branch, git-integration lets you easily rebuild an
integration branch when anything in it changes, as well as showing you
the status of all of the branches in the integration branch.

For example, the instruction sheet for git-integration's "pu" branch
recently looked like this:

	base master

	merge make-clean

	  Add a "clean" target to the makefile.

	merge version

	  Support for "--version" option.

	  N.B. this builds on "make-clean".

	merge skip-option

	  Needs more work to be able to handle "branch not found".

This tells git-integration to base the "pu" branch on "master" and merge
the "make-clean", "version" and "skip-option" branches in.  The comments
following the "merge" instructions are added to the commit message for
the corresponding merge commit.  When I want to rebuild the "pu" branch
I simply do:

	$ git integration --rebuild pu

To change the contents of the branch, I either edit the instruction
sheet manually:

	$ git integration --edit pu

or quickly add a new branch from the command line:

	$ git integration --add my-new-branch pu

In fact, I can combine these to get the benefit of bash-completion on
the branch name and the ability to edit the instruction sheet - when
multiple commands are specified, git-integration performs each of them
in a sensible order, described in the manpage [2].


[1] http://johnkeeping.github.io/git-integration/
[2] http://johnkeeping.github.io/git-integration/git-integration.html
