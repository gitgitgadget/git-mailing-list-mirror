From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: State of CVS-to-git conversion tools (Was: Re: cvsps: bad usage:
 invalid argument --norc)
Date: Tue, 23 Apr 2013 13:50:00 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130423175000.GA25994@thyrsus.com>
References: <323381594.20130414121834@gmail.com>
 <673219382.20130414124800@gmail.com>
 <20130414113351.GA1299@thyrsus.com>
 <1762779000.20130415215818@gmail.com>
 <20130418094326.GB11038@thyrsus.com>
 <214169596.20130420142251@gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 19:50:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUhMJ-00041M-Ji
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 19:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756716Ab3DWRuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 13:50:23 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:41554
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756419Ab3DWRuW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 13:50:22 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 1041140624; Tue, 23 Apr 2013 13:50:00 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <214169596.20130420142251@gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222202>

Apologies for the somewhat belated reply.  I've been even busier than
usual lately and am about to be traveling for a week.

Ilya Basin <basinilya@gmail.com>:
> Hi Eric.
> 
> ESR> cvs-fast-export does not have incremental-import support.
> ESR> Whether git-cvs-import has it depend on which version you have
> ESR> and what backend it it is using. I don't maintain that wrapper.
> Did you mean "git-fast-import"? Or do you know any wrapper that
> already uses cvsps3 --fast-export?

No, I meant git-cvs-import.  I wrote a version of it that supports
cvsps3, but Junio chose to keep the old wrapper.  Apparently he would
rather inflict cvsps2's rather serious known bugs on users than break
backward compatibility even a little.  

> First of all, I think cvsps3 has almost everithing required for
> incremental import: one could just take the date of the last commit
> and invoke cvs ps with the '-d' flag. However, to import new commits
> into existing branches the stream should contain the "from" command in
> oldest commits in each branch (now missing).
> If the branch already exists in the target git repo, it's easy to
> refer it in the stream:
>     from refs/heads/branchname^0

Look at the -i option.  That may do what you need.
 
> But if the branch is new, but it's parent commit is already imported,
> I guess, the only way to refer it is by its SHA-1
> Eric, what parent information can cvsps provide for the first commit
> in a branch, when invoked with the '-d' flag?

At the moment it doesn't provide any at all.  That case wasn't on my
radar when I was fixing the code.  If you can specify a behavior you
think would be useful, I'm listening.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
