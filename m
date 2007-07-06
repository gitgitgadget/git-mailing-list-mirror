From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-apply{,mbox,patch} should default to --unidiff-zero
Date: Thu, 5 Jul 2007 21:12:17 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0707052108070.9434@woody.linux-foundation.org>
References: <20070705232210.GR3492@stusta.de> <Pine.LNX.4.64.0707060217460.9789@racer.site>
 <20070706014222.GK3492@stusta.de> <Pine.LNX.4.64.0707060243110.4093@racer.site>
 <20070706022629.GL3492@stusta.de>
 <Pine.LNX.4.64.0707060413190.4093@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Adrian Bunk <bunk@stusta.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 06 06:12:45 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6fBU-000772-EQ
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 06:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190AbXGFEMf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 00:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbXGFEMf
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 00:12:35 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41545 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750814AbXGFEMe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jul 2007 00:12:34 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l664CNLL000700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 5 Jul 2007 21:12:24 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l664CHxS004761;
	Thu, 5 Jul 2007 21:12:18 -0700
In-Reply-To: <Pine.LNX.4.64.0707060413190.4093@racer.site>
X-Spam-Status: No, hits=-2.641 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51721>



On Fri, 6 Jul 2007, Johannes Schindelin wrote:
> 
> With --unidiff-zero, also _adding_ lines will be handled as if there were 
> no problem.
> 
> Yes, in your case it fixes a problem.
> 
> Yet, in other cases it introduces a problem.

Well, we could make the rule be that ew require --unidiff-zero only if 
there really is _no_ old data to verify in a hunk. No deleted lines, and 
no context around it.

Adrian has a point in that if there are lines to be deleted, that in 
itself is context, and then the strict behaviour of "git-apply" is 
arguably unnecessaily strict.

That said, I do absolutely _hate_ how GNU patch will basically apply 
random line noise without complaints. So git-apply is designed to be much 
stricter on _so_ many levels. The thing that I personally always really 
detested about GNU patch was how it would apply part of a patch, then fail 
half-way, and leave the partial patch applied!

git-apply is about a million times better than standard "patch", exactly 
because it tries to make sure that what it does makes sense, and you 
actually need to use explicit flags to make it do things that may be hard 
to undo or slightly questionable.

		Linus
