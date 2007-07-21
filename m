From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Fri, 20 Jul 2007 17:18:42 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707201712150.27249@woody.linux-foundation.org>
References: <858x9ez1li.fsf@lola.goethe.zz> <7vk5svxt1f.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0707201210550.27249@woody.linux-foundation.org>
 <200707202302.57788.johan@herland.net> <alpine.LFD.0.999.0707201421110.27249@woody.linux-foundation.org>
 <Pine.LNX.4.64.0707202320300.16498@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sat Jul 21 02:19:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC2gY-0005de-SI
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 02:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755201AbXGUAS7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 20:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753482AbXGUAS7
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 20:18:59 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49593 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752672AbXGUAS6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jul 2007 20:18:58 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6L0IlS4011060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Jul 2007 17:18:48 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6L0Igjm023855;
	Fri, 20 Jul 2007 17:18:42 -0700
In-Reply-To: <Pine.LNX.4.64.0707202320300.16498@reaper.quantumfyre.co.uk>
X-Spam-Status: No, hits=-3.213 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53127>



On Fri, 20 Jul 2007, Julian Phillips wrote:

> On Fri, 20 Jul 2007, Linus Torvalds wrote:
> > 
> > So here's my standpoint:
> > 
> > - people who use git natively might as well use the ".gitignore" trick.
> >   It really *does* work, and there really aren't any downsides. Those
> >   directories will stay around forever, until you decide that you don't
> >   want them any more. Problem solved.
> 
> Personally I quite like this approach - I'm going to use it to keep all the
> empty directories from Subversion in my importer.  It seems to address
> everthing quite neatly.

The really sad part about this discussion is that the ".gitignore trick" 
is really technically no different at all from the one that David Kastrup 
has been advocating a few times, except he calls his ".gitignore" just 
".", and seems to think that it's somehow different.

It is true that ".gitignore" and "." _are_ different.

But they are actually different in the sense that the ".gitignore" thing 
is something you can control, while the "." thing is something that is in 
all directories on UNIX, which is exactly why it _must_not_ be used by git 
to mark existence. Exactly because it has thus lost its ability to be 
something you can tune per-directory in the working tree!

That said, I actually like my patch, because the git tree structures 
actually lend themselves very naturally to the "empty tree", and I know 
people have even built up those kinds of trees on purpose, even if the 
index doesn't support that notion.

So in that sense, teaching the index about an empty tree is in some ways 
the "right thing" to do, if only because it means that the index can 
finally express something that the tree objects themselves have always 
been able to validly encode.

			Linus
