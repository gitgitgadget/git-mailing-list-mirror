From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git pull and importers
Date: Sat, 07 Apr 2007 14:32:58 -0700
Message-ID: <7vr6qvc1kl.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704062239420.27922@iabervon.org>
	<20070407202409.GA5107@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Apr 07 23:58:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaIX9-0002Hs-W6
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 23:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966354AbXDGVdA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 17:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966350AbXDGVdA
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 17:33:00 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:64558 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966354AbXDGVc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 17:32:59 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070407213257.DRLO28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 7 Apr 2007 17:32:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id kMYy1W0041kojtg0000000; Sat, 07 Apr 2007 17:32:58 -0400
In-Reply-To: <20070407202409.GA5107@muzzle> (Eric Wong's message of "Sat, 7
	Apr 2007 13:24:09 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43986>

Eric Wong <normalperson@yhbt.net> writes:

> When git-fetch is called without any remote arguments, it would look for
> [remote "origin"] as it does now.  However, if no [remote "..."]
> sections are found (as is common with importer-created repos), it would
> try other importers: [svn-remote "svn"], (and hopefully one day
> [cvs-remote "cvs"], [arch-remote "arch"], ...).

I wonder why wouldn't the alternative of noticing the URL scheme
of '[remote "svn"] url' variable is "svn://".  That is...

	[remote "gitrepo"]
        	url = git://example.com/repo.git/
		fetch = refs/heads/*:refs/remotes/gitrepo/*
	[remote "svnrepo"]
        	url = svn://example.com/repo.svn/
                fetch = trunk:refs/remotes/svnrepo/trunk
	[remote "cvsrepo"]
        	url = cvs://example.com/repo.cvs/
                fetch = HEAD:refs/remotes/cvsrepo/

The sections would probably can have importer specific options
besides usual url/fetch.
