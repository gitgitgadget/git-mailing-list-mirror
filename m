From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFD] Strange patch formats (aka tricks with unified diffs)..
Date: Thu, 12 Apr 2007 14:58:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704121436050.4061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 23:58:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc7Jd-0004sa-Np
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 23:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030787AbXDLV6f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 17:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030788AbXDLV6f
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 17:58:35 -0400
Received: from smtp.osdl.org ([65.172.181.24]:33604 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030787AbXDLV6e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 17:58:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3CLwTIs025631
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 12 Apr 2007 14:58:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3CLwSXi017808;
	Thu, 12 Apr 2007 14:58:28 -0700
X-Spam-Status: No, hits=-0.958 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44357>


I'm not sure how many people on this list have worked with unified diffs 
for as long as I have, and are so used to them that they can edit them up 
(and fix up line numbers etc) in their sleep.

So I don't know if people are used to some of the really nice tricks you 
can do with them.

For example, a lot of traditional context diff patch proponents (you're 
wrong, btw) think that unified diffs are hard to read, because you don't 
see the "end result". There's a really trivial trick for this, which is to 
just do

	grep -v '^-'

on the patch, and suddenly you see the patch in a totally different light: 
you see what the end result is (in a much more readable format than a 
traditional context diff).

The reverse operation ("grep -v '^+'") also obviously works, but since it 
just shows the code the way it already is, the only reason to use it tends 
to be an incorrectly reversed patch, or when you just want to see the old 
code side-by-side with the new code (which is why some people prefer 
traditional context diffs, but the reason I hate them is that they break 
up the old/new vertically in random places, so you can't just have two 
windows open and compare them side by side).

I'm normally actually very good at doing that "grep" mentally, and don't 
actually often need to do it explicitly at all, unless the patch is just 
pretty messy. But sometimes the patch is just confusing enough that it 
helps to explicitly filter it.

Now, the reason I mention this is that I was just in "gitk", and while I 
love the gitk graphical revision view, I just noticed (once again) why I 
tend to hate most GUI programs. I can't do the clever tricks! The gitk 
diffs are nice and colorized, but the "show just end result" trick just 
doesn't work.

So I can see two ways to fix this:
 - bug Paul about alternate diff viewing capabilities in gitk. He's cc'd 
   here. A way to make the "diff" pane show just the new one, the old one, 
   or even both side-by-side with some mousy interface?
 - add some actual switch to git diff generation to hide the negative side 
   of a unified diff, and add some way to just make gitk pass that switch 
   in.

I dunno. I realize that it's not just gitk - gitweb, qgit etc don't allow 
the tricks *either*, but gitk was the one I just hit this with. I ended up 
just cutting-and-pasting the SHA1 and doing the thing in a terminal with 
the shell pipeline instead. Am wondering if maybe other people have ideas 
on this.

Maybe I don't need this often enough for it to matter (as mentioned, I'm 
so good at doing this in squishy-ware that I read patches _without_ the 
explicit help most of the time) but I realized that if I do it 
occasionally, perhaps people who haven't worked with unified diffs quite 
as much as I have never even realized..

		Linus
