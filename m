From: Theodore Tso <tytso@mit.edu>
Subject: Re: git-pull and tag objects
Date: Sat, 10 Feb 2007 19:25:01 -0500
Message-ID: <20070211002501.GB19656@thunk.org>
References: <1170933407.15431.38.camel@okra.transitives.com> <81b0412b0702090133qa4eb0c0v6a2d309fe9653a3f@mail.gmail.com> <7v4ppurka1.fsf@assigned-by-dhcp.cox.net> <20070210142322.GB25607@thunk.org> <Pine.LNX.4.64.0702100938540.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Alex Riesen <raa.lkml@gmail.com>,
	Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 11 01:25:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HG2Wo-0003eq-6r
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 01:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752236AbXBKAZJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 19:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752235AbXBKAZJ
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 19:25:09 -0500
Received: from THUNK.ORG ([69.25.196.29]:54561 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752236AbXBKAZH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 19:25:07 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HG2bl-0003eI-5G; Sat, 10 Feb 2007 19:30:21 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HG2Wb-0001Ae-7a; Sat, 10 Feb 2007 19:25:01 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702100938540.8424@woody.linux-foundation.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39266>

On Sat, Feb 10, 2007 at 09:56:25AM -0800, Linus Torvalds wrote:
> We could verify tags automatically, of course, but the question is, what 
> would the policy be? 

What I would propose (post-1.5.0!) is that the policy file be local to
the repository, and consist of an ordered list of regular expressions
and and lists of PGP keys associated with each regexp.  So for
example, I might have in my repository a config file which states that
any tag that matches v2.6.[0-9]+ and v2.6.[0-9]+-rc[0-9]+ must be
signed by PGP key 0x76E21CBB (Linus's key).

What I would very much like is for the tags to be automatically
verified whenever I do a git-fetch operation, and for me to get a big,
fat, warning if some tag isn't signed by an authoried key.

So this would help make sure that when I'm pulling from kernel.org,
I'm getting something that originally came from Linus, and someone
hasn't managed to insert trojan into the git tree, but it doesn't help
in between releases.  In order to solve that problem we would have to
have some kind of scheme where branch heads could be optionally
signed, and then transfered over to the public repository.  Then, in
the git config file, we could list an expected set of keys that should
sign any branch head for a particular tracking branch.  

Since all of this is local policy, someone who wanted to have a
different set of trusted peers, they could do so.  And, of course,
someone who wanted to run completely open with no gpg signature
checking at all could do so.  (aka "rms/rms mode" :-)

Does this make sense?

						- Ted
