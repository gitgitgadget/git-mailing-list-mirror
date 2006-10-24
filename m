From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] git-split: Split the history of a git repository by
 subdirectories and ranges
Date: Tue, 24 Oct 2006 08:19:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610240817120.3962@g5.osdl.org>
References: <451A30E4.50801@freedesktop.org> <7vlko5d3bx.fsf@assigned-by-dhcp.cox.net>
 <453C96C9.4010005@freedesktop.org> <Pine.LNX.4.64.0610230846420.3962@g5.osdl.org>
 <453D17B5.6070203@freedesktop.org> <Pine.LNX.4.64.0610231237080.3962@g5.osdl.org>
 <Pine.LNX.4.63.0610241654060.2106@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Josh Triplett <josh@freedesktop.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 17:19:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcO3t-000248-Uw
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 17:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbWJXPT0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 11:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbWJXPT0
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 11:19:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46272 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965039AbWJXPTZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 11:19:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9OFJHaX030017
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 Oct 2006 08:19:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9OFJGUp003606;
	Tue, 24 Oct 2006 08:19:17 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0610241654060.2106@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.978 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29983>



On Tue, 24 Oct 2006, Johannes Schindelin wrote:
> 
> On Mon, 23 Oct 2006, Linus Torvalds wrote:
> 
> > Although I think that somebody (Dscho?) also had a patch to remove 
> > multiple identical parents, which he claimed could happen with 
> > simplification otherwise. I didn't look any closer at it.
> 
> IIRC It only happened when full history was wished for, _and_ path 
> limiting. And Junio said that in that case, culling identical parents 
> would be the wrong thing to do.

Yeah, with full history, you might as well keep the trivially identical 
parents too. In the "nice rewrite", you'd get rid of them, but you'd get 
rid of them not because they are trivially identical, but because they are 
just the trivial case of "one parent totally dominates the other".

Sadly, while it may be the _trivial_ case in --full-history, it's probably 
not even the common case, at least if you have lots of merges (because you 
end up having one parent point to one merge, and the other to another, and 
you need to simplify things in multiple passes).

			Linus
