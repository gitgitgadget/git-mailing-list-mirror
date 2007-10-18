From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 17:59:27 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710171753020.26902@woody.linux-foundation.org>
References: <1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
 <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu> <3awb7zw6.fsf@blue.sea.net>
 <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
 <1192565900.6430.16.camel@athena> <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
 <20071017015109.303760cc@localhost.localdomain>
 <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org>
 <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>
 <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org>
 <20071018003256.GA5062@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Luke Lu <git@vicaya.com>, Christer Weinigel <christer@weinigel.se>,
	Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 03:00:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiJk6-00034c-E8
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 03:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754422AbXJRA7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 20:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760982AbXJRA7k
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 20:59:40 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43906 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754403AbXJRA7j (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Oct 2007 20:59:39 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9I0xRTK009036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Oct 2007 17:59:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9I0xRm3017094;
	Wed, 17 Oct 2007 17:59:27 -0700
In-Reply-To: <20071018003256.GA5062@coredump.intra.peff.net>
X-Spam-Status: No, hits=-2.717 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61448>



On Wed, 17 Oct 2007, Jeff King wrote:
> 
> In what way does an all-space model cause people to accidentally add
> tabs, but an all-tab model does not cause people to accidentally add
> spaces?

It happens. We do de-spacification in the kernel occasionally when it is 
an annoyance. Usually it shows up in patches, though - exactly because 
code which adds spaces instead of tabs won't line up correctly in the 
diff.

So it doesn't matter *which* one you use (all spaces or all tabs) in that 
sense. But clearly tabs are *way* more common at least in any UNIX 
project, and tabs really do have the advantage of being smaller.

And smaller *is* faster. Do something like this on the kernel:

	GIT_PAGER= time git grep sched_fair

and then do the same thing with the kernel sources blown up by 20% by 
de-tabification. Guess which one is 20% slower?

And whoever said that disk space doesn't matter doesn't know what he is 
talking about. Disk space most *definitely* matters. Do the above test 
with a cold-cache case, and think what 20% more IO does to you (or 20% 
less disk cache).

But no, the size issues are secondary, I'm not claiming anything else. 
Although I do suspect that historically, they have been primary, and have 
been the thing that has resulted in the fact that tabs are so commonly 
used.

			Linus
