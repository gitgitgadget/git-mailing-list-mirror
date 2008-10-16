From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Working with remotes; cloning remote references
Date: Thu, 16 Oct 2008 16:29:34 -0400
Message-ID: <48F7A42E.70200@xiplink.com>
References: <48F7852F.109@xiplink.com> <eaa105840810161220k26eebd48q8de606597f2be055@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@peter.is-a-geek.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 22:30:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqZUg-0001Jc-Mc
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 22:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224AbYJPU3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 16:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755134AbYJPU3g
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 16:29:36 -0400
Received: from smtp232.iad.emailsrvr.com ([207.97.245.232]:34857 "EHLO
	smtp232.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754980AbYJPU3f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 16:29:35 -0400
Received: from relay13.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay13.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 3FEE59B19E4;
	Thu, 16 Oct 2008 16:29:34 -0400 (EDT)
Received: by relay13.relay.iad.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTP id 1D4DD9B1485;
	Thu, 16 Oct 2008 16:29:34 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <eaa105840810161220k26eebd48q8de606597f2be055@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98419>

Peter Harris wrote:
> 
> "git clone" doesn't have this option, but you can turn it on
> immediately after with something similar to:
> git config --add remote.origin.fetch +refs/remotes/*:refs/remotes/*
> (which I use for fanning-out my git-svn repos)

Thanks for the pointer (and the quick reply).

That doesn't seem to be what I'm looking for, though -- perhaps I'm 
missing something?  The above puts the remotes in the .git/refs/remotes 
directory, but the .git/config file doesn't have them.

More specifically, if I clone the main repository and run the above and 
then fetch, then AFAICT I'm still not linked to the external mirrors in 
the clone.  In particular, I can't refer to an external project in the 
subtree pull:

	$ git pull -s subtree external2 master
	fatal: 'external2': unable to chdir or not a git archive

(Where 'external2' is the name of the remote in the main repo.)  Also, 
the only remote in the config file is still just the origin.

(As an aside, the above "git config --add" incantation causes problems 
if run inside a clone of a clone:
	$ git clone main clone-of-main
	$ git clone clone-of-main clone-of-clone-of-main
	$ cd clone-of-clone-of-main
	$ git config --add remote.origin.fetch \
		+refs/remotes/*:refs/remotes/*
	$ git pull
	fatal: refs/remotes/origin/master tracks both 
refs/remotes/origin/master and refs/heads/master
)

You did say "something similar" in your reply -- am I not seeing 
something obvious?

		Marc
