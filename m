From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: CRLF problems with Git on Win32
Date: Sat, 12 Jan 2008 18:26:15 +0300
Message-ID: <20080112152615.GH2963@dpotapov.dyndns.org>
References: <D36EB89D-11A3-4EAF-BC1C-6100383FCBFC@zib.de> <C3AD6D58.10E02%jefferis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Gregory Jefferis <jefferis@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 16:26:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDiFy-0001Ea-FD
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 16:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758255AbYALP0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 10:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755588AbYALP0S
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 10:26:18 -0500
Received: from smtp03.mtu.ru ([62.5.255.50]:58503 "EHLO smtp03.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758416AbYALP0R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 10:26:17 -0500
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp03.mtu.ru (Postfix) with ESMTP id A6B2118704D7;
	Sat, 12 Jan 2008 18:26:15 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-140-170-195.pppoe.mtu-net.ru [85.140.170.195])
	by smtp03.mtu.ru (Postfix) with ESMTP id 3B1CD18704F2;
	Sat, 12 Jan 2008 18:26:15 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JDiFT-000465-6E; Sat, 12 Jan 2008 18:26:15 +0300
Content-Disposition: inline
In-Reply-To: <C3AD6D58.10E02%jefferis@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70323>

On Fri, Jan 11, 2008 at 07:00:40PM +0000, Gregory Jefferis wrote:
> 
> LF only repositories are model that everyone is tending towards but I feel
> that there are (sane) people out there who would sometimes like to have CRLF
> files in the repository and do cross-platform development (I would
> developing on a Mac for a Windows originated Win/Mac project or if I were
> keeping vendor source code in a tree).  In spite of the plethora of autocrlf
> variants so far there is still none that on unix would give you LF->CRLF on
> check in and CRLF->LF on checkout!  This should be perfectly compatible with
> git's internals

Git internally considers only LF as the EOL marker. I think there are
more three hundreds places in Git where the decision about end-of-line
is made based on that. Though CRLF may appear to work, but it is more
an artifact caused by its LF ending, so what it actually works is LF and
nothing else. IOW, CRLF from the Git's point of view is no better EOL
than let's say SPACE+LF.

> and I think it should be possible to allow this without
> breaking anything for other situations.  One solution, which would have
> other uses, would be to allow checkin conversion to a specified line ending
> and checkout conversion to platform line ending as separately configurable
> options.
> 
> If this seems outrageous then it should be made perfectly clear that the git
> project strongly discourages CRLF text files in cross-platform repositories,

Because LF is the only true EOL marker, and CRLF is not and never will be.
In fact, Git is written in C, and the decision of what is EOL in C is made
many years ago. So, it is the only sane choice to use LF for _internal_
representation. It can be said that *nix users are lucky in that their
OS uses the same symbol, but it is similar to big-endian platforms being
lucky with byte order when it comes to TCP/IP. That is not because TCP/IP
wants to discourage little-endian platforms, but having the single encoding
is the only sane choice if you care about interoperability, and any other
decision will end up being much worse.


Dmitry
