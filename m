From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] checkout_entry: only try to create directories when no
 file existed there
Date: Wed, 8 Aug 2007 23:54:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708082345540.21857@racer.site>
References: <Pine.LNX.4.64.0708082200240.14781@racer.site>
 <7v4pj93evc.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0708082239120.21857@racer.site>
 <7vejid1wh2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 00:55:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIuRP-0002aR-Ma
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 00:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761136AbXHHWzi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 18:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761040AbXHHWzh
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 18:55:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:41911 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760994AbXHHWzh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 18:55:37 -0400
Received: (qmail invoked by alias); 08 Aug 2007 22:55:35 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp012) with SMTP; 09 Aug 2007 00:55:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/LnAN4MgzLDHwqHyYBl3jtL26x3ihE+40ma0gYWa
	gawvtpAaqqxK4D
X-X-Sender: gene099@racer.site
In-Reply-To: <7vejid1wh2.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55387>

Hi,

On Wed, 8 Aug 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Now, if we have to remove it, we did a stat() before that.  It succeeded.  
> > So we know that "a/b/c/d/e/f/" exists.  It might contain some symlinks, 
> > but it exists.
> 
> Yes, it is exactly the thing.  It might contain a/b/c as symlink
> but the index does not say a/b/c _IS_ a symlink, and the code
> "fixes" that.  Otherwise, you would get inconsistent result from
> "git checkout" depending on random symlink you happen to have in
> your working tree.

Ah, I see what you're getting to.

If user had a symlink called, say "syml", to, say $HOME, and now switches 
to a branch which has "syml/.bash_profile", then the given code path would 
try to replace the symlink with a directory.

Hmm.

Ciao,
Dscho
