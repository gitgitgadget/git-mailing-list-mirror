From: Jim Meyering <jim@meyering.net>
Subject: Re: Problem with case-insensitive file cleanup
Date: Thu, 03 May 2007 15:54:55 +0200
Message-ID: <87odl2dnbk.fsf@rho.meyering.net>
References: <4639DA65.3030401@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bug-gnulib <bug-gnulib@gnu.org>
To: Eric Blake <ebb9@byu.net>
X-From: git-owner@vger.kernel.org Thu May 03 15:55:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjblt-00072z-Je
	for gcvg-git@gmane.org; Thu, 03 May 2007 15:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161928AbXECNy6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 09:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161929AbXECNy6
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 09:54:58 -0400
Received: from mx.meyering.net ([82.230.74.64]:52733 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161928AbXECNy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 09:54:57 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 13DF04DD16; Thu,  3 May 2007 15:54:56 +0200 (CEST)
In-Reply-To: <4639DA65.3030401@byu.net> (Eric Blake's message of "Thu\, 03 May 2007 06\:49\:41 -0600")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46087>

Eric Blake <ebb9@byu.net> wrote:
> Right now, the gnulib repository is mastered in CVS but mirrored by git (I
> am still awaiting the day that Jim decides that his hooks are adequate
> enough that git can be the master and CVS provided by git-cvsserver).

My plan, once we make the switch, is to set things up so that CVS
die-hards can use git-cvsserver for read-only gnulib operations.

BTW, just yesterday there was a bug fix in git relating to git-cvsserver:

    cvsserver: Handle re-added files correctly
    http://git.kernel.org/?p=git/git.git;a=commitdiff;h=a7da9adb1ff

> Earlier this week, I reported a problem when two case-insensitive files
> were created, which is a no-no for checkouts on Mac HFS+ or Windows-based
> platforms [1].  The problem was quickly corrected in CVS (note that
> _Exit.texi now lives in the attic [2]).  But somehow the git repository
> still thinks that _Exit.texi belongs to the current tree [3], which leads
> to this confusing state on a case-insensitive clone:

I've just removed that file manually and pushed the result.
I suppose that happened because something went wrong with the
automated git-cvsimport run.

The current procedure is to rsync the CVS repository,
use that via git-cvsimport into an existing .git repository,
and then to push the result to savannah.

Obviously, before we do the final CVS-to-GIT switch, I'll rerun
git-cvsimport from scratch, rather relying on the incrementally-built-up one.
