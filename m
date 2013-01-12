From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH] cvsimport: rewrite to use cvsps 3.x to fix major bugs
Date: Sat, 12 Jan 2013 11:11:05 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130112161105.GB3270@thyrsus.com>
References: <1357875152-19899-1-git-send-email-gitster@pobox.com>
 <50F17DB0.2050802@alum.mit.edu>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Chris Rorvick <chris@rorvick.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Jan 12 17:16:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu3l2-00043C-Kh
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 17:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555Ab3ALQLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 11:11:19 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:46865
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009Ab3ALQLS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 11:11:18 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 9BC694065F; Sat, 12 Jan 2013 11:11:05 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <50F17DB0.2050802@alum.mit.edu>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213292>

Michael Haggerty <mhagger@alum.mit.edu>:
> Otherwise, how do we know that cvsps currently works with git-cvsimport?
> (OK, you claim that it does, but in the next breath you admit that
> there is a new failure in "one pathological tagging case".)  How can we
> understand its strengths/weaknesses?  How can we gain confidence that it
> works on different platforms?  How will we find out if a future versions
> of cvsps stops working (e.g., because of a breakage or a
> non-backwards-compatible change)?

You can't.  But in practice the git crew was going to lose that
capability anyway simply because the new wrapper will support three
engines rather than just one.  It's not practical for the git tests to
handle that many variant external dependencies.

However, there is a solution.

The solution is for git to test that the wrapper is *generating the
expected commands*.  So what the git tree ends up with is conditional
assurance; the wrapper will do the right thing if the engine it calls
is working correctly.  I think that's really all the git-tree tests
can hope for.

Michael, the engines are my problem and yours - it's *our*
responsibility to develop a (hopefully shared) test suite to verify
that they convert repos correctly.  I'm working my end as fast as I can;
I hope to have the test suite factored out of cvsps and ready to check 
multiple engines by around Wednesday.  I still need to convert t9604,
too.

I have parsecvs working since yesterday, so we really are up to three
engines.

I have two minor features I need to merge into parsecvs before 
I can start on splitting out the test suite.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
