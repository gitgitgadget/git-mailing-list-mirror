From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 05:57:08 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121125105707.GA25212@thyrsus.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
 <50B1F684.5020805@alum.mit.edu>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Nov 25 11:58:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcZuj-0005CV-6C
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 11:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061Ab2KYK6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 05:58:00 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:42427
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab2KYK6A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 05:58:00 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 5D9894065F; Sun, 25 Nov 2012 05:57:08 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <50B1F684.5020805@alum.mit.edu>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210354>

Michael Haggerty <mhagger@alum.mit.edu>:
> There is, of course, the awkward issue of how/when to transition to
> Python 3.x, which is *not* backwards compatible with Python 2.x.  I
> expect that when the time comes there will be volunteers (myself
> included) willing to help adapt Python scripts to the new version, but
> the problem shouldn't be minimized.

2to3 actually does a pretty good job.  It doesn't reduce the
transition cost to zero, but I find it does reduce that cost to an
easily manageable level even on quite large codebases.

> It would be insane to rewrite performance-critical C code in any
> scripting language, but there is a huge penumbra of code that is not
> performance critical and that mutates rapidly.

Indeed.  In the git architecture there is a pretty clear dividing line -
to a first approximation, plumbing should remain C but porcelain should
probably not.  (Not that I am advocating forcing such a move - but it would
be good to allow it to happen.)

The 80-20 rule (80% of the execution time is spent in 20% of the code)
helps us here.  The *other* 80% of the code can move to a scripting
language with no significant performance loss.  To find out what needs
to stay in C, run a profiler!
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
