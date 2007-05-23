From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] revert/cherry-pick: allow the last parameter to be -h
Date: Wed, 23 May 2007 08:57:50 +0200
Message-ID: <20070523065750.GA25931@diku.dk>
References: <20070522212945.GA8002@diku.dk> <20070522221156.GL30871@steel.home> <7vwsz07b10.fsf@assigned-by-dhcp.cox.net> <20070523053110.GA23971@diku.dk> <7v8xbg5bno.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 23 08:57:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqknH-0002wJ-27
	for gcvg-git@gmane.org; Wed, 23 May 2007 08:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755063AbXEWG5y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 02:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756733AbXEWG5y
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 02:57:54 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:35627 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755063AbXEWG5x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 02:57:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 7F36E9680A7;
	Wed, 23 May 2007 08:57:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oyycBQCbn9xA; Wed, 23 May 2007 08:57:51 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 3FE7496802E;
	Wed, 23 May 2007 08:57:51 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 0F28C6DFB62; Wed, 23 May 2007 08:56:01 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 23DF762A5D; Wed, 23 May 2007 08:57:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v8xbg5bno.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48145>

Junio C Hamano <junkio@cox.net> wrote Tue, May 22, 2007:
> Jonas Fonseca <fonseca@diku.dk> writes:
> 
> > Junio C Hamano <junkio@cox.net> wrote Tue, May 22, 2007:
> >> Alex Riesen <raa.lkml@gmail.com> writes:
> >> ...
> >> > Why should cherry-pick be different?
> >> 
> >> Good question.  FYI
> >> 
> >> 	$ git rev-list --huh?
> >> 
> >> works equally well ;-)
> >
> > Because it is different?
> >
> >    $ git revert --why-must-it-be-so-hard-to-learn-git-sometimes
> >    fatal: Cannot find '--why-must-it-be-so-hard-to-learn-git-sometimes'
> >
> > Because, contrary to git-rev-list, git-revert/cherry-pick is considered
> > part of the porcelain?
> 
> No, I did not notice it until now but you are right.  The
> command line argument parser for these commands is done somewhat
> sloppily, compared to others.
> 
> How about doing something like this instead?

FWIW, I like it. Sorry for my quick and dirty patch.

> -- >8 --
> Fix command line parameter parser of revert/cherry-pick
> 
> The parser was inconsistently done, [...]in that it did not look at
> the last command line parameter to see if it could be an unknown
> option, although it was designed to notice unknown options if
> they were given in positions the command expects to find them
> (i.e. everything except the last parameter, which ought to be
> <commit-ish>).  This prevented a very natural invocation
> 
> 	$ git cherry-pick --help
> 
> from issuing the usage help.

But --help is handled elsewhere, you meant -h ...

-- 
Jonas Fonseca
