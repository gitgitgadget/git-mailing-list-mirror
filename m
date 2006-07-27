From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP] Status update on merge-recursive in C
Date: Thu, 27 Jul 2006 11:41:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607271127520.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607081840280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <1152421230.2103.31.camel@dv> <Pine.LNX.4.63.0607091634010.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vu053o2g7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 11:42:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G62Nd-0003yr-8y
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 11:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbWG0JmG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 05:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWG0JmG
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 05:42:06 -0400
Received: from mail.gmx.net ([213.165.64.21]:62443 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932552AbWG0JmF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 05:42:05 -0400
Received: (qmail invoked by alias); 27 Jul 2006 09:42:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 27 Jul 2006 11:42:03 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu053o2g7.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24275>

Hi,

On Thu, 27 Jul 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sun, 9 Jul 2006, Pavel Roskin wrote:
> >
> >> - variable declarations in the middle of the code (allowed by c99 but
> >> not by ANSI C) and incomplete function declarations (no "void").  It's
> >> not C++, let's stick to the C standards.
> >...
> >> I'm attaching a patch that fixes everything except variable
> >> declarations.
> >
> > May I ask you a favour? Can you redo the patch in, say, two weeks? Thank 
> > you!
> 
> Now it's about two weeks so maybe we can apply this on top to
> clean up and prod you to continue ;-)?

*grin*

Actually, we continued a little with it, but I mainly waited what would 
happen to "git-read-tree --rename"...

I will send an updated patch soon. The remaining TODOs after that are:

$ grep TODO merge-recursive.c 
 * TODO: we should not have to copy the SHA1s around, but rather reference
 * TODO: check if we can just reuse the active_cache structure: it is already
 * TODO: this can be streamlined by refactoring builtin-read-tree.c
 * TODO: this can be streamlined by refactoring builtin-read-tree.c
 * TODO: this can be streamlined by refactoring builtin-write-tree.c
/* General TODO: no javaIfiCation: rename updateCache to update_cache */
 * TODO: once we no longer call external programs, we'd probably be better off
/* General TODO: get rid of all the debug messages */
                /* TODO: refactor, so that 1/2 are not needed */

So, the biggest problem I see: refactoring builtin-read-tree. I really 
could use some help there -- I already tried 3 times to come up with a 
nice abstraction for unpack_trees() which could be used as a library 
function.

Ciao,
Dscho
