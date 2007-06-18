From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: how to move with history?
Date: Mon, 18 Jun 2007 23:07:43 +0200
Message-ID: <20070618210743.GA16397@steel.home>
References: <20070618191607.GK3037@cs-wsok.swansea.ac.uk> <20070618194907.GA12445@steel.home> <20070618202918.GM3037@cs-wsok.swansea.ac.uk>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
X-From: git-owner@vger.kernel.org Mon Jun 18 23:07:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0ORy-0001lt-Tc
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 23:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763914AbXFRVHr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 17:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764083AbXFRVHr
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 17:07:47 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:38410 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761892AbXFRVHq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 17:07:46 -0400
Received: from tigra.home (Fcb3e.f.strato-dslnet.de [195.4.203.62])
	by post.webmailer.de (fruni mo45) (RZmta 7.4)
	with ESMTP id 606b5dj5IJ6GMx ; Mon, 18 Jun 2007 23:07:44 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 164C0277BD;
	Mon, 18 Jun 2007 23:07:44 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id CEA6CC164; Mon, 18 Jun 2007 23:07:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070618202918.GM3037@cs-wsok.swansea.ac.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqByfDQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50410>

Oliver Kullmann, Mon, Jun 18, 2007 22:29:18 +0200:
> > Git does not keep "renaming history". It does not have to, as it keeps
> > how your project looked at each commit (point in history).
> 
> For my purposes, that is a bad thing, since I want to get rid off some parts
> of the history (specifically I want to eliminate some files from history),
> as explained in that last paragraph in my e-mail (with the motivation):
> 
> Is this possible in git?

Yes. You wont be able to change the history after someone copied it
from you (cloned or fetched), because it's "his" now, but you're free
to do anything with your part (or whole) of the history. Happens all
the time. Look at git-cherry-pick, git-format-patch and git-am (and
the new git-filter-branch, but is more for automated mass-rewriting of
big histories).

> And is it possible to add the history of some file to the history
> of another file (in the above application this would be the renamed
> file) ?

Yes, git-format-patch accept pathnames, and its output can be passed
to git-am, which will apply the changes to this file only. git-am also
accepts -pN, so you can move file up a bit. For more complex path
manipulations you'll have to modify the patches (or git-filter-branch
again).

> Altogether, I want to completely change history: It must look as
> if the old files never has been there (from the git-history that is),
> but as it would have had always the new name.

Yep, no problem, just a bit of scripting. Just make sure no one has
that "old" history: it will be hell to merge with them.

> If this is not possible with Git (this "history surgery"),

no, it is not.

> then I hope that at least the future "git-submodule" will not have
> the files in the history which have been filtered out?

depends on how you write the history for that submodule

> So that in this way at least files can be hidden in (sub-)clones (but
> they cannot be renamed) ?

?
