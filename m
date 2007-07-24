From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Tue, 24 Jul 2007 13:42:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241337470.14781@racer.site>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site>
 <Pine.LNX.4.64.0707222205050.23426@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222223460.14781@racer.site>
 <Pine.LNX.4.64.0707222234020.5382@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222255010.14781@racer.site>
 <Pine.LNX.4.64.0707222302170.19212@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707230000020.14781@racer.site> <20070723035644.GC32566@spearce.org>
 <7v1wezohi4.fsf@assigned-by-dhcp.cox.net> <46A5B5F5.6000202@trolltech.com>
 <Pine.LNX.4.64.0707241002410.14781@racer.site> <7vd4yigmla.fsf@assigned-by-dhcp.cox.net>
 <46A5DF1F.2030307@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 14:42:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDJj0-0003QS-2b
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 14:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755885AbXGXMmr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 08:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755810AbXGXMmr
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 08:42:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:55032 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754841AbXGXMmq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 08:42:46 -0400
Received: (qmail invoked by alias); 24 Jul 2007 12:42:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 24 Jul 2007 14:42:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18RYGIoc3ERgLDOGiwZAub+OCWM9+PWdmAX8b/0mw
	rjX7PFnZeg9AOS
X-X-Sender: gene099@racer.site
In-Reply-To: <46A5DF1F.2030307@trolltech.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53581>

Hi,

On Tue, 24 Jul 2007, Marius Storm-Olsen wrote:

> The new-workdir feature doesn't *have* to be about symlinked .git/ 
> metainfo space, but could also be about symref'ed .git/ metainfo. (A 
> discussion was done in 2005s "Getting rid of symlinks in .git?", but the 
> conclusion was that it would slow it down too much? *ponder*)

Right.  I would not do it as symrefs, but as a (potentially ugly, but 
small) change to have the git_dir set to the shared one, and only in case 
of config and HEAD resort to the new_worktree_git_dir.

This would probably be one variable in environment.c, exported in cache.h, 
set in config.c (which would say "new_worktree_git_dir = get_git_dir(); 
setup_new_git_dir(value);"), and the appropriate special handling in
git_path() in path.c.

> I think you're right in that this is probably not the appropriate itch 
> to scratch for a Windows developer to start with, and I have my own list 
> of issues to work on when I get the time. File stat'ing 
> (daemon/service), CRLF issues, de-SH'ifying commands, non-MinGW native 
> build of Git, etc.. Lots to keep my fingers busy :-)

;-)

BTW a friend reported a CRLF issue on Windows, _in spite_ of setting the 
gitattributes appropriately... Did you ever get something like that?

> Though, let me also say that I already love working with Git on Windows. 
> And I thank each and every one who's working on it, for providing such 
> an excellent tool.

Good to hear!

Ciao,
Dscho
