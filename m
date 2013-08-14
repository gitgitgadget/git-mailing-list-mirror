From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: re-ignoring a force added file
Date: Wed, 14 Aug 2013 11:22:42 +0200
Message-ID: <87ioz8hbj1.fsf@linux-k42r.v.cablecom.net>
References: <520A7B79.4080306@ebi.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Raza Ali <rali@ebi.ac.uk>
X-From: git-owner@vger.kernel.org Wed Aug 14 11:22:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9XI0-0000LI-Us
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 11:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759358Ab3HNJWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 05:22:45 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:46484 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752182Ab3HNJWo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 05:22:44 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 14 Aug
 2013 11:22:38 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 14 Aug 2013 11:22:41 +0200
In-Reply-To: <520A7B79.4080306@ebi.ac.uk> (Raza Ali's message of "Tue, 13 Aug
	2013 19:31:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232277>

Raza Ali <rali@ebi.ac.uk> writes:

> I have force added a file we usually like to ignore (but keep in the
> repository). That was a change a while ago, and cannot be undone
> without serious pain. I would like to re-ignore the file though, as we
> dont want to track changes to it. Some of the options I came across
> are not useful for me. For example
>
> git rm --cached FILE // removes the file from the remote repository if
> I push, not desirable
> git update-index --assume-unchanged //Will ignore changes to the file
> locally, but someone else clones and the file is tracked for them.
>
> What we would like is to go back to the old state of affairs: the file
> was in the working directory when someone cloned from the remote
> repository, but changes to the file werent tracked or committed.

I highly doubt that this description is accurate:

Either the file was actually in the repository (more specifically, in
the commit that git-clone chose to be checked out).  In this case, it
appears in the worktree after cloning.  But its presence in the HEAD
commit of the resulting repo also means that it is tracked.

Or it was not in the repository.  In which case it will not appear in a
new clone.  And there is no third option here.

So your "old state" in fact did not exist.  And it unfortunately is also
not attainable in more roundabout ways: any given file can only be
either tracked or ignored (or untracked-but-not-ignored, but that's
beside the point).  You cannot use ignore rules to ignore files that are
tracked.

Please check https://gist.github.com/canton7/1423106 for a list of other
ways to achieve what you are trying to do (link from the corresponding
bot quote on #git).  But do note that --assume-unchanged is a rather
more dangerous beast than you may think, and I cannot recommend actually
using it.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
