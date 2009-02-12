From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/3] builtin-remote: teach show to display remote HEAD
Date: Thu, 12 Feb 2009 15:27:13 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0902121519160.19665@iabervon.org>
References: <1234332083-45147-1-git-send-email-jaysoffian@gmail.com>  <1234332083-45147-2-git-send-email-jaysoffian@gmail.com>  <1234332083-45147-3-git-send-email-jaysoffian@gmail.com>  <20090212002612.GC30231@coredump.intra.peff.net>
 <76718490902111748j58f80591ma149f8ec9fb8b352@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 21:28:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXiAw-00039Z-4l
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 21:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758595AbZBLU1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 15:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758177AbZBLU1Q
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 15:27:16 -0500
Received: from iabervon.org ([66.92.72.58]:43348 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756941AbZBLU1P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 15:27:15 -0500
Received: (qmail 29072 invoked by uid 1000); 12 Feb 2009 20:27:13 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Feb 2009 20:27:13 -0000
In-Reply-To: <76718490902111748j58f80591ma149f8ec9fb8b352@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109641>

On Wed, 11 Feb 2009, Jay Soffian wrote:

> On Wed, Feb 11, 2009 at 7:26 PM, Jeff King <peff@peff.net> wrote:
> 
> > Yuck.
> 
> Damn, I knew I wasn't going to slip that one by. :-)
> 
> > I see that the inputs and outputs aren't exactly the same in both cases,
> 
> Which is why I didn't refactor it. The extra code needed to massage
> what builtin-remote.c has to the existing function in builtin-clone.c
> would've been more LOC than the duplicate code (I think...).

Isn't it just:

struct ref *head = locate_head(refs, refs, NULL);
return head ? xstrdup(abbrev_branch(head->name)) : NULL;

?

I'd somehow thought I'd moved locate_head() somewhere common, but it 
really ought to be done. There were periodic discussions of how you find 
out when the remote repo changes its HEAD and you might want to do 
something locally about it, and we never came up with a specific thing 
for git to do, but the facility is probably useful.

I have the vague memory, as well, that there's some way for a transport to 
report that it actually knows that HEAD is a symref to something in 
particular, and so git shouldn't guess.

	-Daniel
*This .sig left intentionally blank*
