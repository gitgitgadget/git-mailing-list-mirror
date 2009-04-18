From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: [PATCH] Add the diff option --no-defaults
Date: Sat, 18 Apr 2009 13:32:41 -0700 (PDT)
Message-ID: <alpine.GSO.2.00.0904181308440.16775@kiwi.cs.ucla.edu>
References: <alpine.GSO.2.00.0904021647120.16242@kiwi.cs.ucla.edu> <alpine.DEB.1.00.0904091030030.10279@pacific.mpi-cbg.de> <20090409084903.GA18947@coredump.intra.peff.net> <alpine.DEB.1.00.0904091242430.10279@pacific.mpi-cbg.de> <20090410080155.GB32195@coredump.intra.peff.net>
 <alpine.DEB.1.00.0904140036341.10279@pacific.mpi-cbg.de> <20090416083443.GA27399@coredump.intra.peff.net> <alpine.DEB.1.00.0904161124000.10279@pacific.mpi-cbg.de> <20090416094154.GA30479@coredump.intra.peff.net> <7v4owok0bh.fsf@gitster.siamese.dyndns.org>
 <20090417115414.GA29121@coredump.intra.peff.net> <alpine.DEB.1.00.0904171514440.6675@intel-tinevez-2-302> <alpine.GSO.2.00.0904180930390.16775@kiwi.cs.ucla.edu> <alpine.DEB.1.00.0904181937520.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 18 22:34:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvHF4-00089W-93
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 22:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759131AbZDRUcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 16:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758362AbZDRUcv
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 16:32:51 -0400
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:41492 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757453AbZDRUcu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 16:32:50 -0400
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n3IKWfiV019506;
	Sat, 18 Apr 2009 13:32:41 -0700 (PDT)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n3IKWfSL019503;
	Sat, 18 Apr 2009 13:32:41 -0700 (PDT)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <alpine.DEB.1.00.0904181937520.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116865>

Dscho,

On Sat, 18 Apr 2009, Johannes Schindelin wrote:

> On Sat, 18 Apr 2009, Keith Cascio wrote:
> 
> > On Fri, 17 Apr 2009, Johannes Schindelin wrote:
> > 
> > > Besides, you still will have a poison:
> > > 	git config diff.defaultOptions --no-defaults
> > > which is Russel's paradoxon right there.
> > 
> > I can cleanly modify my v3 to handle this case.
> 
> You cannot.  --no-defaults means that diff.defaultOptions should be 
> disregarded.  If the diff.defaultOptions say that they should be disregarded 
> themselves, then --no-defaults should be disregarded.

--no-defaults *could* mean as you say there.  But a much better meaning for 
--no-defaults is: suppress the values in diff.defaultOptions after options 
processing.  We don't have to disregard them, just suppress them after options 
processing.  In that sense, --no-defaults is a meta-option.  It is an option 
about options.  Even users unfamiliar with set theory would assume the 
suppression semantics.

Nevertheless I applaud the Russell reference.  Very intriguing.

> And I still do not like the intrusiveness of your patch.  The last time we did 
> something like that with options (some parseoptifications), we had a lot of 
> fallout as a consequence.

A reasonable worry!  But blind paranoia is paralyzing.  Peff expressed some 
specific concerns which he and I addressed: (1) whether I'd investigated all 
callsites for possible problems (yes I did), (2) whether we'd have to switch 
every callsite to a macro, rather than direct assignment (no we don't).  
Outside of diff.h/diff.c, my v3 deletes no lines and adds only two.  That 
doesn't really seem "intrusive" to me.  By comparison, your patch adds at least 
ten lines outside of diff.h/diff.c.  I'd rather call my patch "innovative".  
Possible?
                               -- Keith
