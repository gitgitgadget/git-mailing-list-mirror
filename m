From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: encrypted repositories?
Date: Fri, 17 Jul 2009 13:42:36 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907171341040.13838@localhost.localdomain>
References: <op.uw7wmbr41e62zd@balu.cs.uni-paderborn.de>  <alpine.LFD.2.01.0907171226460.13838@localhost.localdomain> <43d8ce650907171322y60aaa0f3na335b7a4a2fe32c1@mail.gmail.com> <alpine.LFD.2.01.0907171337320.13838@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Andree <matthias.andree@gmx.de>, git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 22:43:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRuGn-0004a6-Rk
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 22:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756905AbZGQUnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 16:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756680AbZGQUnA
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 16:43:00 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60784 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756730AbZGQUm7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jul 2009 16:42:59 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6HKga0U002727
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 17 Jul 2009 13:42:37 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6HKgaE8010273;
	Fri, 17 Jul 2009 13:42:36 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907171337320.13838@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.465 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123488>



On Fri, 17 Jul 2009, Linus Torvalds wrote:
> 
> On Fri, 17 Jul 2009, John Tapsell wrote:
> > 
> > Why couldn't you have the actual code encrypted, but have the server
> > still know about the SHAs etc?  You would expose the actual commit
> > structure, but that might be acceptable?
> 
> Even that wouldn't really work, because you'd never be able to generate 
> any deltas.
> 
> So there would be no real advantage. In fact, there would be only 
> disadvantages, because without any delta generation, you'd now have to 
> actually transfer _more_ data.

Oh, if you let the server know all the SHA's at _all_ levels (ie down to 
the blob itself), and then just make the blobs be encrypted, we'd be able 
to do some trivial optimizations, like only sending the actual blobs that 
changed. HOWEVER. That would reveal absolutely tons of data about the 
repository, and about the history. You'd have lost a _lot_ of security.

			Linus
