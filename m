From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix segfault in merge-recursive
Date: Sat, 9 May 2009 00:14:15 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905090012410.4601@intel-tinevez-2-302>
References: <alpine.DEB.2.00.0905070102010.30999@narbuckle.genericorp.net> <alpine.DEB.1.00.0905071144370.18521@pacific.mpi-cbg.de> <alpine.DEB.2.00.0905072131470.30999@narbuckle.genericorp.net> <alpine.DEB.1.00.0905082229520.4601@intel-tinevez-2-302>
 <alpine.DEB.2.00.0905081436070.30999@narbuckle.genericorp.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dave O <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 09 00:14:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2YKp-0001gM-8M
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 00:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754242AbZEHWOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 18:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753163AbZEHWOS
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 18:14:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:38057 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752954AbZEHWOR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 18:14:17 -0400
Received: (qmail invoked by alias); 08 May 2009 22:14:17 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp010) with SMTP; 09 May 2009 00:14:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/41A9VrIz4PMVLub2J0Bn4rRmRyyIkam1TY8P65X
	itGu9Irkxx0vND
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.DEB.2.00.0905081436070.30999@narbuckle.genericorp.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118634>

Hi,

On Fri, 8 May 2009, Dave O wrote:

> On Fri, 8 May 2009, Johannes Schindelin wrote:
> 
> > When there is no "common" tree (for whatever reason), we must not 
> > throw a segmentation fault.
> >
> > Noticed by Dave O.
> 
> While this patch does prevent a segfault, it totally fails to recognize 
> any conflicts in the merge.  Reverting 36e3b5e produces an ordinary 
> merge conflict with some rename/delete conflicts, and others including 
> content related conflicts.  I'm not sure I wouldn't rather have the 
> segfault than the grossly incorrect automerge.
> 
> I'll continue debugging the triggering condition to see if I can 
> understand why the index is left dirty, leading to this NULL tree.

One thing I realized while trying to quickly fix the issue for you was 
that the recognized merge base was NULL.  I.e. merge-recursive did _not_ 
find a merge base.

>From your description, it seemed that it should have found a merge base, 
but due to too many renames, maybe it did not.

Probably that is the issue.

(Sorry, too tired to do anything about it.)

Ciao,
Dscho
