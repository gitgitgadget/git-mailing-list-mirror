From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: How to figure out what 'git push' would do?
Date: Sun, 5 Aug 2007 19:33:40 +0200
Message-ID: <20070805173340.GA3159@steel.home>
References: <267CDD46-549B-4BFE-B993-80CD1CFE75D8@zib.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Aug 05 19:35:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHk0K-0001oC-H4
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 19:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbXHEReo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 13:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbXHEReo
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 13:34:44 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:36002 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbXHEReo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 13:34:44 -0400
Received: from tigra.home (Fcb8d.f.strato-dslnet.de [195.4.203.141])
	by post.webmailer.de (klopstock mo18) (RZmta 10.3)
	with ESMTP id 506271j75FXuKc ; Sun, 5 Aug 2007 19:33:41 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id A9E2D277BD;
	Sun,  5 Aug 2007 19:33:41 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 1688ABDCE; Sun,  5 Aug 2007 19:33:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <267CDD46-549B-4BFE-B993-80CD1CFE75D8@zib.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBsHuUg=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55045>

Steffen Prohaska, Sun, Aug 05, 2007 13:37:34 +0200:
> How can I check what a 'git push' would do, without
> actually doing it?
> 
> Is there something like 'git push --dry-run', similar
> to 'rsync --dry-run'?

No. It is often safe to just do git-push, unless you have naive
developers doing pull every time some ref in your shared repo changes
*and* expecting the result to compile (typical for CVS way of work).
git-push will not overwrite anything, it always only forwards history.

For the case you really want to know what the changes on remote repo
will be it is possible to fetch them into the local repo first and
compare with what you will push:

    $ git fetch git://remote/path/REPO master:refs/remotes/REPO/master
    $ gitk local..REPO/master

It gives you all possible information, which may be worth that bit of
work. Or, if you have all the remote configuration ready, it can be
just:

    $ git fetch
    $ gitk local..REPO/master
