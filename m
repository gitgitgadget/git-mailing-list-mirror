From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Joining Repositories
Date: Wed, 18 Jan 2006 15:15:06 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601181513030.3240@g5.osdl.org>
References: <200601181325.59832.Mathias.Waack@rantzau.de>
 <20060118125158.GN28365@pasky.or.cz> <20060118140917.GA15438@mythryan2.michonline.com>
 <Pine.LNX.4.64.0601180813170.3240@g5.osdl.org> <7vbqy9xx2r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0601181010410.3240@g5.osdl.org> <7vslrluze6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0601181128060.3240@g5.osdl.org> <Pine.LNX.4.64.0601181414530.3240@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 00:15:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzMWY-00022t-EI
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 00:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161043AbWARXPU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 18:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161051AbWARXPT
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 18:15:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:65480 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161050AbWARXPS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2006 18:15:18 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0INF6DZ002957
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Jan 2006 15:15:07 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0INF6MG005322;
	Wed, 18 Jan 2006 15:15:06 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0601181414530.3240@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.66__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14868>



On Wed, 18 Jan 2006, Linus Torvalds wrote:
> 
> As an example, let's say that you have a git repository that has had a 
> file called "A" some time in the past. That file gets renamed to B, and 
> then gets renamed back again to A. The old "git-rev-list" would show two 
> commits commits: the commit that renames B to A (because it changes A) 
> _and_ as its parent the commit that renames A to B (because it changes A).

Btw, in case somebody doesn't see what's wrong with that (because those 
two commits happen to be the only ones that matter), let's point out that 
the file may have changed while it was called "B". So to do annotation, we 
really need to _stop_ following the filename, start following the previous
one.

Now, the logic to do that could have been in the "annotate" parts, but the 
decision to stop following the chain actually makes sense as part of 
git-rev-list, since it does the tree difference tracking anyway.

		Linus
