From: Paul Mackerras <paulus@samba.org>
Subject: Re: [REPLACEMENT PATCH 2/2] Add "--early-output" log flag for
 interactive GUI use
Date: Sun, 4 Nov 2007 18:10:00 +1100
Message-ID: <18221.28744.805398.598809@cargo.ozlabs.ibm.com>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org>
	<18212.13862.637991.30536@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org>
	<18217.41899.54812.227152@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org>
	<18218.63946.772767.179841@cargo.ozlabs.ibm.com>
	<e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
	<alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711031103340.3342@woody.linux-foundation.org>
	<18221.14113.498416.396006@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0711032234030.15101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 08:10:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoZcv-0001WD-1Z
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 08:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499AbXKDHKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 02:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753479AbXKDHKR
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 02:10:17 -0500
Received: from ozlabs.org ([203.10.76.45]:49879 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753417AbXKDHKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 02:10:16 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 73C16DDE37; Sun,  4 Nov 2007 18:10:14 +1100 (EST)
In-Reply-To: <alpine.LFD.0.999.0711032234030.15101@woody.linux-foundation.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63357>

Linus Torvalds writes:

> > How hard would it be to put the total number of commits on that "Final
> > output" line?  That would be useful for me.
> 
> Not hard. I think we basically have it anyway. The reason I didn't do it 
> is that there's actually multiple numbers: there's the number of primary 
> ("interesting") commits, and then there are the "others", ie the edge 
> things etc. So the number I'd pick would be the number of actual 
> interesting commits, no edges, no nothing. Or what?

Any of those numbers is probably good enough for a progress bar, but
ideally it would be the total number that you are going to output.
So, with --boundary it would include the edge commits, otherwise it
would just be the interesting commits, I think.

> One other thing I was thinking of was also to perhaps allow multiple 
> partial early-output things, in case we get just 5 commits in the first 
> 0.1 seconds, then 50 in the first second, and 200 after 2 seconds.. I can 
> well imagine getting the full list taking a long time over a network 
> filesystem (somebody mentioned samba), and maybe having just a single 
> trigger is too inflexible.

In fact gitk won't mind if you give it multiple occurrences of "Final
output", as long as you start from the beginning again after each
occurrence.  So having multiple triggers is certainly doable as far as
gitk is concerned.  Later on we could optimize that by having git log
match up how many initial commits are the same in both the new list
and the old list, and have it output that rather than the N commits
that were the same as last time.

Paul.
