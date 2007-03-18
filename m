From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Implement a simple delta_base cache
Date: Sat, 17 Mar 2007 20:31:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703172013340.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703162257560.18328@xanadu.home>
 <Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
 <118833cc0703171814n4e56ab9fwfaaea81c903ae235@mail.gmail.com>
 <Pine.LNX.4.64.0703171822280.4964@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172136440.18328@xanadu.home>
 <Pine.LNX.4.64.0703171854270.6730@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172200060.18328@xanadu.home>
 <Pine.LNX.4.64.0703171911120.6730@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172228220.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Morten Welinder <mwelinder@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Mar 18 04:31:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSm7Z-0007gs-Fa
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 04:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbXCRDbf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 23:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbXCRDbf
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 23:31:35 -0400
Received: from smtp.osdl.org ([65.172.181.24]:54017 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932097AbXCRDbe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 23:31:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2I3VGcD020319
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 17 Mar 2007 20:31:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2I3VCoh014987;
	Sat, 17 Mar 2007 19:31:15 -0800
In-Reply-To: <alpine.LFD.0.83.0703172228220.18328@xanadu.home>
X-Spam-Status: No, hits=-0.981 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42473>



On Sat, 17 Mar 2007, Nicolas Pitre wrote:
> 
> Sure.  But at this point the reference to compare GIT performance 
> against might be GIT itself.  And while 1 second is really nice in this 
> case, there are some repos where it could be (and has already been 
> reported to be) much more.

I'd still like to see the KDE repo, that thing went quiet after it was 
supposed to hit sneaker-net..

If it was 30 seconds before to do a "git log" for some individual file, 
after the recent optimizations it should hopefully be down to 10. And I 
agree that I might be more motivated to try to get it down further if I 
could just find a repository where it's that much. 

Right now I can can do a "git log" on any file in the kernel archive in 
under a second (well, when I say "any file", I started with a script, but 
with 22 thousand files I didn't bother to run it for all that long, so I 
ended up testing a few random files in addition to the first few hundred 
files of "git ls-files", and they are all well under a second).

And that's without the "git diff --quiet" thing that is still in "next", 
and that cut down some of the overhead for other reasons (although I 
suspect the effect of that will be less when combined with my patches 
since the stuff it cut down I probably cut down even more).

I really suspect you'll have a hard time beating "normal" git with the 
patches I sent out. I'm sure it's quite possible - don't get me wrong - I 
just suspect it won't be spectacular, and it will be a lot of work.

		Linus
