From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH] rebase -p: seed first commit in case it's before the
 merge bases.
Date: Sat, 17 Jan 2009 18:11:46 -0600
Organization: Exigence
Message-ID: <20090117181146.906a6bf3.stephen@exigencecorp.com>
References: <496F6AC3.7050704@drmicha.warpmail.net>
	<cover.1232233454.git.stephen@exigencecorp.com>
	<ac1a4533de095f916dd68029793c8ee6eb02d200.1232233454.git.stephen@exigencecorp.com>
	<a524993b13ee586cf0e8fbd3b6459ccd6767c6d8.1232233454.git.stephen@exigencecorp.com>
	<alpine.DEB.1.00.0901180041540.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 01:13:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOLHs-00055G-Ro
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 01:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295AbZARALt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 19:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753571AbZARALt
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 19:11:49 -0500
Received: from smtp162.sat.emailsrvr.com ([66.216.121.162]:42179 "EHLO
	smtp162.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498AbZARALs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 19:11:48 -0500
Received: from relay16.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay16.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 20AAE1BB61C;
	Sat, 17 Jan 2009 19:11:47 -0500 (EST)
Received: by relay16.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTPSA id E9CEE1BB576;
	Sat, 17 Jan 2009 19:11:46 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901180041540.3586@pacific.mpi-cbg.de>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106115>


> > +			# Along with the merge bases, look at the first commit's
> > +			# parent (which may be before the merge base) and mark it
> > +			# as rewritten to ONTO
> > +			FIRST="$(git rev-list --reverse --first-parent $UPSTREAM..$HEAD | head -n 1)"
> > +			for p in $(git rev-list --parents -1 $FIRST | cut -d' ' -f2)
> > +			do
> > +				echo $ONTO > "$REWRITTEN/$p"
> > +			done
> 
> AFAICT this is wrong.  You have no guarantee whatsoever that the output of
> 
> 	$ git rev-list --reverse --first-parent $UPSTREAM..$HEAD | head -n 1
> 
> has any parents at all.  Take for example a coolest-merge-ever, i.e. a 
> merge of an independent project.
> 
> Instead, what you _actually_ are looking for are the boundary objects
> of $UPSTREAM..$HEAD,

Agreed.

> which would be easy to get at.

That would be great, but I'm not seeing it, obviously. Suggestions
would be appreciated.

> However, I have a strong feeling that just piling onto the current
> code will not fix the underlying issues.

Also agreed.

So...not that it really matters, but did my patches go out to the git
list or not? It looks like both Johannes and I got them from the cc
entries.

I tried to use format-patch and the files looked great, cc's including
Michael, Stephan, and Sitaram. Then I ran send-email with the three
files as arguments and it stripped all the cc's but Johannes and
myself. Then I got all three delivered due to my cc entry, but I didn't
see any entries arrive from the list even though the cc-delivered
copies all had "To: git@vger.kernel.org" in them (and that is what I
had pasted into the send-email prompt). I guess I did something wrong
but it's frustrating to not know what it was.

- Stephen
