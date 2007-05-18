From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: merge summaries
Date: Fri, 18 May 2007 12:13:02 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705181206051.3890@woody.linux-foundation.org>
References: <25A3C618-8D12-42A8-9478-D3A4E7633CE7@zib.de>
 <alpine.LFD.0.98.0705181130580.3890@woody.linux-foundation.org>
 <7vodki55px.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 18 21:14:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp7uX-00006p-BI
	for gcvg-git@gmane.org; Fri, 18 May 2007 21:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754564AbXERTOi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 15:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755701AbXERTOi
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 15:14:38 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34743 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752893AbXERTOh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2007 15:14:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4IJD3BM005508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 18 May 2007 12:13:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4IJD2xg021632;
	Fri, 18 May 2007 12:13:03 -0700
In-Reply-To: <7vodki55px.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.871 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.180 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47633>



On Fri, 18 May 2007, Junio C Hamano wrote:
> 
> This does not necessarily mean that your lieutenants should not
> use merge.summary when they pull from other trees (or inside
> their own repository to merge in the topics).  They need to
> however disable it with --no-summary when they pull from you
> when they choose to merge instead of rebase to adjust to the
> updated infrastructure in your tree.

Yes, the problem is that people *will* get it wrong, so right now I'd 
discourage people from even trying to enable merge summaries unless they 
are the top-level maintainer.

Of course, we could have some heuristics to make it possibly work well 
enough in practice that we could make it useful to more people:

 - take the "merge.summary" field from the "remote" description for any 
   shorthand cases, always defaulting to "off" (regardless of what the 
   "merge.summary" config value is)

   End result: "git pull origin" would never generate a merge summary, 
   unless somebody explicitly sets

	[remote "origin"]
		mergesummary = true

 - use the "merge.summary" flag only for explicitly named remotes (and 
   possibly add "--summary" so that people can choose to never do it by 
   default, but do it explicitly for when they pull from a sublieutenant)

Hmm?

		Linus
