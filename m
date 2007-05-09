From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Second parent for reverts
Date: Wed, 9 May 2007 15:16:36 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705091513050.4062@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <7v7irhslx1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 10 00:17:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HluTk-0001G4-H7
	for gcvg-git@gmane.org; Thu, 10 May 2007 00:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706AbXEIWRk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 18:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754890AbXEIWRk
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 18:17:40 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:50497 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754706AbXEIWRj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2007 18:17:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l49MGbsL009166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 9 May 2007 15:16:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l49MGaRk003829;
	Wed, 9 May 2007 15:16:37 -0700
In-Reply-To: <7v7irhslx1.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3.482 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46799>



On Wed, 9 May 2007, Junio C Hamano wrote:
> 
> I would suggest to leave a revert as a revert.  It is not a
> merge.

Yes, please.

People can do fancy things if they want, but quite frankly, if you start 
playing games with the "parent" pointer, it starts losing its meaning, and 
becomes a random "pointer to another related commit". 

Then, you might as well say "oh, this commit is related to that other 
commit", and decide to call the other commit "related" too, and now a 
random commit just looks like a strange merge.

That's simply not what "parenthood" is about. Parenthood is about 
nonlinear development, and parents should not be reachable from each other 
(which such a bogus revert or "related" parent would almost always be: it 
would be reachable from the *real* parent.

If you want a "related to that commit" field, it should be a separate 
field in the commit object. But since it doesn't really have any real 
*semantic* meaning to git itself, it shouldn't be in the header. We 
could, for example, make it be in the free-form section, and teach our 
graphical visualization tools to automatically turn it into a hyperlink.

.. which we already do.

		Linus
