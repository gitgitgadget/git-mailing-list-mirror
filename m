From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Wed, 9 May 2007 11:16:53 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705091103290.4062@woody.linux-foundation.org>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
 <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org>
 <vpqbqgxak1i.fsf@bauges.imag.fr> <46a038f90705072016x17bd60c3ic779459438ffc19@mail.gmail.com>
 <alpine.LFD.0.98.0705072137450.3974@woody.linux-foundation.org>
 <20070509134151.GT4489@pasky.or.cz> <alpine.LFD.0.98.0705090825090.4062@woody.linux-foundation.org>
 <Pine.LNX.4.64.0705091322180.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed May 09 20:17:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlqit-0002VX-Rj
	for gcvg-git@gmane.org; Wed, 09 May 2007 20:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756256AbXEISRG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 14:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756609AbXEISRF
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 14:17:05 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:59924 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756256AbXEISRE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2007 14:17:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l49IGsxL031071
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 9 May 2007 11:16:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l49IGrBY030163;
	Wed, 9 May 2007 11:16:53 -0700
In-Reply-To: <Pine.LNX.4.64.0705091322180.18541@iabervon.org>
X-Spam-Status: No, hits=-3.482 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46761>



On Wed, 9 May 2007, Daniel Barkalow wrote:
> 
> It only sounds like a complicated sequence because you didn't write a 
> script to do it...

Well, I actually think it sounds like a complicated sequence because I 
tried to explain what I do.

The "script" parts don't really end up being any smaller, and not 
scripting it actually means that I can (and often do) things outside of a 
strict scripting environment.

As mentioned, I not only mix it up with "git cherry-pick", but since I 
just use "git diff", I can - and do - things like pick only a certain set 
of files to diff and edit the patch on. 

So it's an iterative process at several levels (the "outer" level is the 
act of actually committing each change, and iterating to the next one, 
while the "inner" level is often a sequence of "git diff" exploration), 
it's not very fixed. 

For example, when I said that I do a 

	git diff -R target > diff

that's not strictly true. The "git diff -R" is useful for comparing the 
current working tree to another commit, but quite often I actually end up 
doing it differently, and doing it as

	git diff ..target file > diff
	.. edit ..
	git apply diff

or, if I don't need the edit (ie just the fact that I limit it to a single 
file is a sufficient "edit" in itself), I might just do

	git checkout target file

instead, which will fetch the whole file from the "target" branch (and 
also update it in the index, which may or may not actually be what I want, 
but that's a different issue).

So the "process" as far as I'm concerned is actually much more fluid than 
necessarily always working with diffs. Git gives you so many ways to do 
things like this, and I'm pretty comfortable with lots of them.

			Linus
