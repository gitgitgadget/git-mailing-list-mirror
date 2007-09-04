From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Tue, 4 Sep 2007 11:48:42 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709041145230.28586@racer.site>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com>
 <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com>
 <Pine.LNX.4.64.0709031428080.28586@racer.site> <46DC5ED4.8050202@trolltech.com>
 <46DD0C16.70101@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 12:49:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISVyN-0004k4-Ht
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 12:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbXIDKt1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 06:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbXIDKt0
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 06:49:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:46194 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751565AbXIDKt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 06:49:26 -0400
Received: (qmail invoked by alias); 04 Sep 2007 10:49:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 04 Sep 2007 12:49:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18XPIV4oxQXqPFnDn10P5DNvqEexkrDKm44qJ0c+h
	A3icNdQUIwvC47
X-X-Sender: gene099@racer.site
In-Reply-To: <46DD0C16.70101@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57549>

Hi,

On Tue, 4 Sep 2007, Johannes Sixt wrote:

> Marius Storm-Olsen schrieb:
> > Johannes Schindelin wrote:
> > > To make it easier on others, I just uploaded it into the "teststat"
> > > branch on 4msysgit.git (subject to removal in a few days).
> > 
> > Ok, I've updated the patch in the 4msysgit.git repo, 'teststat' branch.
> > RFC, and please test.
> 
> Thanks a lot! I've pushed it out in mingw.git's master.
> 
> The reason that t4200-rerere.sh fails is that we now store UTC in st_mtime.
> However, for the garbage-collection we compare this entry to a local time
> stamp.

Thanks for the explanation.

> Therefore, I've pushed out a fixup patch at the top of mingw.git's devel 
> branch that converts mtime to local time

On Linux, we compare to UTC to begin with, right?  We should do that here, 
too...  So if time(NULL) does not return UTC on MinGW, we have to wrap 
that function, too.

Ciao,
Dscho
