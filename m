From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Funny error with git gc...
Date: Sun, 24 May 2009 19:37:58 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905241937350.26154@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0905152000520.4449@intel-tinevez-2-302> <7vmy9etey8.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0905151128230.3343@localhost.localdomain> <alpine.DEB.1.00.0905152105340.26154@pacific.mpi-cbg.de> <alpine.DEB.1.00.0905152111140.26154@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0905152115220.26154@pacific.mpi-cbg.de> <alpine.LFD.2.01.0905151307390.3343@localhost.localdomain> <alpine.DEB.1.00.0905231050480.9099@intel-tinevez-2-302> <alpine.LFD.2.01.0905230859290.3555@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun May 24 19:37:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Hdk-0002LD-OD
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 19:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757010AbZEXRhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 13:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757375AbZEXRhb
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 13:37:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:56451 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755646AbZEXRhb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 13:37:31 -0400
Received: (qmail invoked by alias); 24 May 2009 17:37:31 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp051) with SMTP; 24 May 2009 19:37:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19LvYVgtp9Lpc0z1YPAcECaJjNroEj1jE4cZbHeIk
	XoEXzUWIlTHNuB
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.01.0905230859290.3555@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119844>

Hi,

On Sat, 23 May 2009, Linus Torvalds wrote:

> On Sat, 23 May 2009, Johannes Schindelin wrote:
> > On Fri, 15 May 2009, Linus Torvalds wrote:
> > 
> > > On Fri, 15 May 2009, Johannes Schindelin wrote:
> > > >  
> > > >  	fd = mkstemp(template);
> > > > +	if (fd < 0) {
> > > > +		release_pack_memory((size_t)-1ll, -1);
> > > > +		fd = mkstemp(template);
> > > 
> > > This is wrong. You can't use "template" twice. You need to re-initialize 
> > > it. The first one will blow away the XXXX pattern.
> > 
> > Turns out that would be awkward, as the xmkstemp() function would have to 
> > copy the template just in case mkstemp() fails due to too many open files, 
> > and of course it would need to release the copy afterwards.
> > 
> > OTOH we cannot just use the initialized filename, because there 
> > might be a race condition with another process, right?
> 
> Correct. You basically need to have the caller re-create the template. We 
> already do that in some other cases: see odb_mkstemp(), or 
> create_tempfile(). Both of them do that template re-creation on failure, 
> and try again.
> 
> You could save off the template into a local temporary array, of course.

I'll let it slip, due to time constraints.

Thanks,
Dscho
