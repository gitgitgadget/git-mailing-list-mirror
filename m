From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Packfile can't be mapped
Date: Sun, 27 Aug 2006 21:36:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608272133390.27779@g5.osdl.org>
References: <9e4733910608271804j762960a8ud83654c78ebe009a@mail.gmail.com>
 <20060828024720.GD24204@spearce.org> <Pine.LNX.4.64.0608280014190.3683@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 28 06:36:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHYrh-0003ZJ-0K
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 06:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWH1Egq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 00:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWH1Egq
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 00:36:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16079 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932254AbWH1Egp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Aug 2006 00:36:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7S4aSnW008690
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 27 Aug 2006 21:36:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7S4aRqT016726;
	Sun, 27 Aug 2006 21:36:28 -0700
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0608280014190.3683@localhost.localdomain>
X-Spam-Status: No, hits=-0.439 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.143 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26139>



On Mon, 28 Aug 2006, Nicolas Pitre wrote:
> 
> Good job indeed.  Oh and you probably should not bother trying to 
> deltify commit objects at all since that would be a waste of time.

It might not necessarily always be a waste of time. Especially if you have 
multiple branches tracking a "maintenance" branch, you often end up having 
the same commit message repeated several times in "unrelated" commits 
(they're really the same commit, applied to another branch).

Also, I could imagine that some automated system generates very verbose 
(and possibly very regular) commit messages, so under certain 
circumstances it may well make sense to see if the commits migth delta 
against each other.

But I'll agree that in normal use it's not likely to be a huge saving, 
though. It's probably not worth doing for the fast importer unless it just 
happens to fall out of the code very easily.

		Linus
