From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: cvsps, parsecvs, svn2git and the CVS exporter mess
Date: Sun, 23 Dec 2012 17:45:42 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121223224542.GA16383@thyrsus.com>
References: <20121222173649.04C5B44119@snark.thyrsus.com>
 <20121223202111.GB29354@book-mint>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@free.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Antoine Pelisse <apelisse@gmail.com>,
	Bart Massey <bart@cs.pdx.edu>,
	Keith Packard <keithp@keithp.com>,
	David Mansfield <david@cobite.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Dec 23 23:52:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmuOy-0008G3-Pl
	for gcvg-git-2@plane.gmane.org; Sun, 23 Dec 2012 23:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198Ab2LWWqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2012 17:46:13 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:59667
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125Ab2LWWqL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2012 17:46:11 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id A3EA244119; Sun, 23 Dec 2012 17:45:42 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20121223202111.GB29354@book-mint>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212092>

Heiko Voigt <hvoigt@hvoigt.net>:
> Please share so we can have a look. BTW, where can I find your cvsps
> code?

https://gitorious.org/cvsps

Developments of the last 48 hours:

1. Andreas Schwab sent me a patch that uses commitids wherever the history
   has them - this makes all the time-skew problems go away.  I added code
   to warn if commitids aren't present, so users will get a clear indication
   of when time-skew problems might bite them versus when that is happily
   impossible.

2. I've scrapped a lot of obsolete code and options.  The repo head
   version uses what used to be called cvs-direct mode all the time
   now; it works, and the effect on performance is major.  This also
   means that cvsps doesn't need to use any local CVS commands or even
   have CVS installed where it runs.

> >From my past cvs conversion experiences my personal guess is that
> cvs2svn will win this competition.

That could be.  But right now cvsps has one significant advantage over
cvs2git (which parsecvs might share) - it's *blazingly* fast.  So fast
that I scrapped all the local-caching logic; there seems no point to it at
today's network speeds, and that's one less layer of complications to
go wrong.

I've removed a couple hundred lines of code and the program works
better and faster than it did before.  That's having a good day!
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
