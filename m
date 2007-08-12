From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Can I have this, pretty please?
Date: Sun, 12 Aug 2007 12:59:48 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708121255230.30176@woody.linux-foundation.org>
References: <85ir7kq42k.fsf@lola.goethe.zz>
 <alpine.LFD.0.999.0708121135050.30176@woody.linux-foundation.org>
 <85abswo9gf.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708121219540.30176@woody.linux-foundation.org>
 <85wsw0mt77.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 22:00:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKJbd-0003Bs-55
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 22:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937639AbXHLUAA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 16:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765472AbXHLUAA
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 16:00:00 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53028 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933211AbXHLT76 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 15:59:58 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7CJxsBE006860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 12 Aug 2007 12:59:55 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7CJxmtQ019427;
	Sun, 12 Aug 2007 12:59:49 -0700
In-Reply-To: <85wsw0mt77.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-2.741 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55714>



On Sun, 12 Aug 2007, David Kastrup wrote:
> >
> > So, use "git log --pretty=oneline" instead, which doesn't have the
> > expense.
> 
> Yes, like managing a manual with grep is all one needs.  git log
> --pretty=oneline provides just the commit headers, but offers no way
> to jump into the commits themselves and back easily.

You misunderstand.

I was suggesting you do a *tool* that bases its listing on 
--pretty=oneline, and then goes from there.

If you don't show the graph anyway, all the complex and expensive things 
that "git-rev-list --topo-order" does is pretty much totally useless. 
You're going to show the commits as a list anyway, and then when you 
*select* one commit for closer inspection, you can then try to do a better 
job at that point of doing the reachability (ie parenthood is trivial, and 
the branch reachability is cheap if it's close to the tip of the tree, 
which it would almost always be).

The real problem with the topological sort is that it requires you to have 
the full history. That not only makes everything pretty big, it also means 
that the startup cost is bad, since you can't do things incrementally.

But if you have a client that is incremental anyway, almost all of that 
goes away.

			Linus
