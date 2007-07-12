From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Better handling of local changes in 'gitk'?
Date: Thu, 12 Jul 2007 12:20:05 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707121214420.20061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Jul 12 21:20:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I94D6-0000aF-Vf
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 21:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754692AbXGLTUP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 15:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753774AbXGLTUP
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 15:20:15 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54914 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753197AbXGLTUN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jul 2007 15:20:13 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6CJKAoC015156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 12 Jul 2007 12:20:11 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6CJK5nF028854;
	Thu, 12 Jul 2007 12:20:05 -0700
X-Spam-Status: No, hits=-2.614 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52330>


I like how gitk shows the local changes as an unnamed commit at the top, 
but what I *don't* like is how it just ignored the difference between 
stuff that has been added to the index, and stuff that hasn't..

It would be very nice to have *two* such commits (either or both of which 
just disappear), where the top-most is the diff to the index, and the 
second is the diff from the index to HEAD.

That would not only be useful in general, it would be a wonderful way to 
visually introduce people to the notion of what the staging area is all 
about.

I think "gitk" was a great way early in git history to show how the git 
commit history works and that it made a lot of people understand a lot 
more how everything tied together (in a way that would have been much 
nastier to visualize with just the SHA1's in "git log"), and I think it 
could do the same thing for the staging area, which still seems to 
occasionally come up as an issue that confuses some people.

But my inability with tcl/tk precludes me from actually changing the logic 
that does

	git diff-index HEAD

into two different things that do the two operations

	git diff-index --cached HEAD
	git diff-files

respectively and ties them together as the two fake commits...

Paul?

			Linus
