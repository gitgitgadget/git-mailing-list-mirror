From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Modify/edit old commit messages
Date: Thu, 1 Feb 2007 08:41:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702010829560.3632@woody.linux-foundation.org>
References: <20070201114909.GV8705@enneenne.com>
 <Pine.LNX.4.63.0702011326130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rodolfo Giometti <giometti@enneenne.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 01 17:42:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCf0S-0008ON-Ch
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 17:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161184AbXBAQlq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 11:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161187AbXBAQlq
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 11:41:46 -0500
Received: from smtp.osdl.org ([65.172.181.24]:48645 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161184AbXBAQlp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 11:41:45 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l11GfY9V027381
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 1 Feb 2007 08:41:34 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l11GfWq8016535;
	Thu, 1 Feb 2007 08:41:33 -0800
In-Reply-To: <Pine.LNX.4.63.0702011326130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.434 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38370>



On Thu, 1 Feb 2007, Johannes Schindelin wrote:
> 
> On Thu, 1 Feb 2007, Rodolfo Giometti wrote:
> > 
> > I'm puzzled... how can I modify or edit old commit messages? :)
> 
> Short answer: you can't.

Side note, just out of historical interest: in BK you could.

And if you're used to it (like I was) it was really quite practical. I 
would apply a patch-bomb from Andrew, notice something was wrong, and just 
edit it before pushing it out.

I could have done the same with git. It would have been easy enough to 
make just the commit message not be part of the name, and still guarantee 
that the history was untouched, and allow the "fix up comments later" 
thing.

But I didn't.

Part of it is purely "internal consistency". Git is simply a _cleaner_ 
system thanks to everything being SHA1-protected, and all objects being 
treated the same, regardless of object type. Yeah, there are four 
different kinds of objects, and they are all really different, and they 
can't be used in the same way, but at the same time, even if their 
encoding might be different on disk, *conceptually* they all work exactly 
the same.

But internal consistency isn't really an excuse for being inflexible, and 
clearly it would be very flexible if we could just fix up mistakes after 
they happen. So that's not a really strong argument.

The *real* reason git doesn't allow you to change the commit message ends 
up being very simple: that way, you can trust the messages. If you allowed 
people to change them afterwards, the messages are inherently not very 
trustworthy.

In BK, for example, if you edited the commit message after already pushing 
it out, it would *work*, but the stuff you pushed out would obviously not 
be changed, so different repositories would literally have different 
commit messages. I did it anyway a few times when some really irritating 
typo just made me say "I can't stand reading that typo over and over 
again, I'll fix it in my tree and screw everybody else".

But it's also very important because nobody *else* can mess with your 
history without it being obvious to everybody who has ever seen the 
pristine one, and nobody can change what you said later. Yeah, there's a 
few embarrassing typo's in the kernel history. We'll never be able to live 
down the fact that spelling and grammar is the dificultest for us. And we 
have some bugs where people have corrupt email addresses etc.

And I'll take guaranteed history over typos any day. 

			Linus
