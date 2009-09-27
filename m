From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git clone sending unneeded objects
Date: Sat, 26 Sep 2009 22:31:44 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0909262228210.4997@xanadu.home>
References: <alpine.LFD.2.00.0908082246020.440@xanadu.home>
 <m2k51dzb39.fsf@linux-m68k.org> <4ABD0669.7050309@redhat.com>
 <vpqvdj6izt6.fsf@bauges.imag.fr>
 <alpine.LFD.2.00.0909251551290.4997@xanadu.home> <4ABD25FE.2040902@redhat.com>
 <alpine.LFD.2.00.0909251629330.4997@xanadu.home> <4ABD4F7B.4030701@redhat.com>
 <4ABD9C2C.60800@redhat.com> <alpine.LFD.2.00.0909262059520.4997@xanadu.home>
 <20090927020409.GK14660@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jason Merrill <jason@redhat.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Hin-Tak Leung <hintak.leung@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Sep 27 04:33:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mrja5-0003x7-29
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 04:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbZI0Cbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 22:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753170AbZI0Cbl
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 22:31:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55165 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbZI0Cbl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 22:31:41 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KQL00943Z0WKJC0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 26 Sep 2009 22:31:44 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090927020409.GK14660@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129193>

On Sat, 26 Sep 2009, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@fluxnic.net> wrote:
> > And even if the broken clone (before my patch) did pull everything from 
> > gcc.git, in the cloned repository those 410610 extra objects are 
> > considered as garbage because nothing actually reference them.  So even 
> > if you decide to fetch the extra branches that the initial clone didn't 
> > pick up, or if you do reference that repository with "garbage" objects 
> > for another clone to which you want to add those extra branches, git has 
> > no way to know that it already had access to those objects locally and 
> > "ungarbage" them as they aren't referenced.  Result is a useless fetch 
> > of 410610 objects that you already have, but that you weren't supposed 
> > to have in the first place.
> 
> Just to clarify a minor nit:
> 
> Actually, if those refs have not changed, quickfetch should kick in
> and realize that all 410610 objects are reachable locally without
> errors, permitting the client to avoid the object transfer.
> 
> However, if *ANY* of those refs were to change to something you
> don't actually have, quickfetch would fail, and we would need to
> fetch all 410610 objects.

Right.  But since we're talking about a git mirror for the gcc svn repo 
and gcc is a rather active project, the likelyhood of any ref to change 
at any time is rather high.


Nicolas
