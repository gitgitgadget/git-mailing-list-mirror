From: Sergio <sergio.callegari@gmail.com>
Subject: Re: [RFC] =?utf-8?b?R0lUX1dPUktfVFJFRQ==?=
Date: Sun, 3 Jun 2007 21:34:04 +0000 (UTC)
Message-ID: <loom.20070603T232437-414@post.gmane.org>
References: <20070603144401.GA9518@moooo.ath.cx> <loom.20070603T175743-376@post.gmane.org> <20070603193203.GA24781@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 23:36:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuxkL-0000YI-On
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 23:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbXFCVfb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 17:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbXFCVfa
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 17:35:30 -0400
Received: from main.gmane.org ([80.91.229.2]:54661 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795AbXFCVf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 17:35:29 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Huxij-0003vE-5F
	for git@vger.kernel.org; Sun, 03 Jun 2007 23:34:41 +0200
Received: from adsl-217-127.38-151.net24.it ([151.38.127.217])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Jun 2007 23:34:41 +0200
Received: from sergio.callegari by adsl-217-127.38-151.net24.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Jun 2007 23:34:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 151.38.127.217 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.4) Gecko/20060601 Firefox/2.0.0.4 (Ubuntu-edgy))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49038>

Matthias Lederhofer <matled <at> gmx.net> writes:

> What I haven't thought through is if it could make sense to honor the
> GIT_WORK_TREE/core.worktree setting when such a .git-repo file is used
> or just use the directory containing the file as work tree.

I would do the first... for the following reason...

Suppose that by accident you move the working tree and you cd to some
point in the moved WT...
You issue a git command...
By climbing up the directory hierarchy, git gets to the .git-repo file
so now it knows where the repo is...
But running a command and following the core.worktree config it might
put  output in the wrong output dir...

But actually I also see problems the other way round...

Suppose you have project A containing a dir B that is under its own git
tracking...
Also suppose that both A and B have repos separated from WT.
If for some reason WT of B misses its .git-repo, then there is trouble
on the way: when issuing a command in B, by climbing up git would find
the .git-repo of A, thinking that it is the git-repo of B...
A weird case, though.

Sergio
