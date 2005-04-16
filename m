From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Re: Re: SHA1 hash safety
Date: Sat, 16 Apr 2005 11:36:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504161114530.29343@cag.csail.mit.edu>
References: <Pine.LNX.4.62.0504160519330.21837@qynat.qvtvafvgr.pbz>
 <20050416123155.GA19908@elte.hu> <Pine.LNX.4.62.0504160542190.21837@qynat.qvtvafvgr.pbz>
 <4261132A.3090907@khandalf.com> <Pine.LNX.4.61.0504161040310.29343@cag.csail.mit.edu>
 <20050416151116.GC19099@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: omb@bluewin.ch, David Lang <david.lang@digitalinsight.com>,
	Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 17:33:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMpIV-0005LR-9J
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 17:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbVDPPhD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 11:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbVDPPhD
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 11:37:03 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:16026 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S262685AbVDPPg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 11:36:58 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DMpLZ-000818-00; Sat, 16 Apr 2005 11:36:37 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050416151116.GC19099@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 16 Apr 2005, Petr Baudis wrote:

>> I know the current state of the art here.  It's going to take more than
>> just hearsay to convince me that full 128-bit MD5 collisions are likely.
>
> http://cryptography.hyperlink.cz/MD5_collisions.html

OK, OK, I spoke too sloppily.  Let me rephrase:
   It's going to take more than just hearsay to convince me that full
   128-bit MD5 collisions *IN ARBITRARILY CHOSEN DOCUMENTS* are likely.

I could add, "WITHOUT SPECIAL EFFORT BY AN ATTACKER".

But you're right, I was too busy thrashing around with the basic 
probability cluestick to carefully distinguish MD5 (in which *collisions* 
can be found fairly easily now by an attacker, although not *preimages*) 
and SHA1 (which is what git is actually using, and still requires 2^69 
hash computations to collide).

And note again that these are not preimage attacks.  Even with MD5, an 
attacker can't arbitrarily change existing code in the Linux kernel by 
creating a malicious file with the same MD5 hash.

But extreme caution is necessary, because both of these hash mechanisms 
have been shown to be weak, and algorithms grow weaker with time, not 
stronger.

I think the only conclusion that can be made is that "one should not rely 
on the hash for security".  And I don't believe that we are.  We should be
careful to continue saying "branch 46f<mumble> *in Linus' tree*" instead 
of just "branch 46f<mumble>" and assuming that that is unique.  The 
security is provided by Linus' control over his repository, not by the 
hash.
   --scott

[The 'MD5 collisions in 15 minutes on a laptop' paper did surprise me.  I 
vaguely remember hearing about this before, but I'd forgotten just how 
broken MD5 is.  It's still a fine *hash* function; just not a terribly 
good *cryptographically secure* hash function.]

Israel PBSUCCESS $400 million in gold bullion President Nader jihad 
RNC LPMEDLEY agent HTKEEPER Cheney SEQUIN SARANAC Clinton biowarfare
                          ( http://cscott.net/ )
