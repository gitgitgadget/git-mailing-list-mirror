From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Newton-Raphson, was Re: Performance issue of 'git branch'
Date: Fri, 24 Jul 2009 01:24:21 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907240114410.8306@pacific.mpi-cbg.de>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907221959330.21520@localhost.localdomain> <alpine.LFD.2.01.0907222009340.21520@localhost.localdomain> <alpine.LSU.2.00.0907231846190.30197@hermes-2.csi.cam.ac.uk> <alpine.LFD.2.01.0907231153010.21520@localhost.localdomain>
 <alpine.LSU.2.00.0907232310220.22113@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Fri Jul 24 01:24:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MU7eL-0006uK-DC
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 01:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549AbZGWXYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 19:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754201AbZGWXYZ
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 19:24:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:49560 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754037AbZGWXYY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 19:24:24 -0400
Received: (qmail invoked by alias); 23 Jul 2009 23:24:22 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp003) with SMTP; 24 Jul 2009 01:24:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/cD8AYvY/cE2m7e7BgGQBImr/dLcRZ1irgLhB+YS
	bDXVqrATobiZtK
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LSU.2.00.0907232310220.22113@hermes-2.csi.cam.ac.uk>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123896>

Hi,

On Thu, 23 Jul 2009, Tony Finch wrote:

> I think Newton-Raphson is a brilliant but misleading idea. (As Junio 
> said, "egg of Columbus" - it certainly blew my mind!) However, Newton's 
> method works with smooth curves, but a pack index is a straight line 
> plus stochastic deviations. If you try to apply Newton's method then the 
> more you zoom in the more the random variations will send you away from 
> the place you want to be.

No.

Think about it, absent any further information than "it is a hash, i.e. 
distributed pretty equally in _any_ byte", even subsets of a sorted list 
will me more or less linear.  And assuming that they are linear is _still_ 
your best bet.

Assuming that subsets of said sorted list will _still_ minimize the 
average number of steps to take until you find the correct entry.

Unless you have more information about the nature of the hashes, of 
course.

> This should give you O(1) seeks in the index per object lookup.

There is no way to achieve that, best thing you can hope for is _expected_ 
O(1) (e.g. with a hashmap, with exponential worst case).

Ciao,
Dscho
