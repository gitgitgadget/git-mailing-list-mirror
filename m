From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-repack made my pack 317x larger...
Date: Fri, 15 Jun 2007 11:53:25 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0706151143590.5651@xanadu.home>
References: <20070615145433.22970.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: linux@horizon.com
X-From: git-owner@vger.kernel.org Fri Jun 15 17:53:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzE79-0005IK-PE
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 17:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbXFOPx2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 11:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753089AbXFOPx2
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 11:53:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30609 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbXFOPx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 11:53:28 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JJO00F6VPH1XBA0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 15 Jun 2007 11:53:25 -0400 (EDT)
In-reply-to: <20070615145433.22970.qmail@science.horizon.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50270>

On Fri, 15 Jun 2007, linux@horizon.com wrote:

> >> Uh... what happened?  It's not a full kernel clone, but it's a lot more
> >> objects than I expected.  Where did all the extra objects come from?
> 
> > Maybe you want to add -l as well to your git-repack invocation.
> 
> Ah.  Thank you.  Indeed, this is another example of git documentation
> disease.  git-repack refers to git-pack-objects, which gives a very
> technical explanation of what it does, but nowhere is it mentioned that
> list of objects suppled to git-pack-object's stdin includes objects
> borrowed from alternates.

At some point it is necessary for people like you who are not so 
intimate with the packing code, and therefore to whom this doesn't look 
obvious, to raise those issues, and ideally provide patches.

> Given that "git-repack -f" is a not uncommon command, could I suggest
> that the default is wrong, and there should be a special flag for
> "suck in alternates, so this repository is no longer dependent
> on any others".

Well, I tend to disagree here.  I don't think using -f _should_ be that 
common.  It is a really expensive operation and you usualy should have a 
good reason to use it.

> Mentally, git-repack is a "reduce space consumption" command, not an
> increase one.  Having to remember that this repository uses alternates
> and add an extra flag to avoid having a space explosion is distinctly
> annoying.

Why don't you use git-gc then?  Its mental model and actual 
implementation is really about reducing space, maybe even more than 
git-repack is, and it does call git-repack with -l.


Nicolas
